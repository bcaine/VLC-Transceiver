// Transmitter - PRU1 source code. Responsible for pulling encoded, packetized data
// from RAM and pushing this data to the PRU Scratch Pad, which is a low latency
// (1 cycle, regardless of size up to 360B) local register bank between PRUs. Utilized
// in current implementation to push 88 bytes (1 packet) of data to PRU0. PRU1 then
// pulls another packet from RAM and delays until PRU0 has finished modulating the 
// previous packet. Loops until local count of packets sent matches initial length
// of transfer read in from RAM (SEE r3). Currently includes circular buffer
// implementation, and writes its read cursor  


.origin 0
.entrypoint INIT
#define READ_ADDRESS 0x90000000
#define PRU0_DELAY 70365 // delay needed to wait for PRU0
#include "../../include/asm.hp"

// NOTE: Delay assumes 140799 cycles between PRU0 XINs
// and allows for each LBCO/SBCO to take 200 cycles each.
// This should ensure that PRU1 is always done before PRU0,
// which allows XOUT to begin and hang until PRU0 done.
// Note that if PRU1 is done more than 1023 cycles before PRU0,
// we will start to see issues with XOUT timing out.

//  ____________________ 
//  Register  |  Purpose
//
//      r0    |  Counter - Byte offset for reading from RAM
//      r1    |  Const   - Offset limit to prevent over-reading the buffer
//      r2    |  Const   - delays to perform
//      r3    |  Const   - packets to transfer
//      r4    |  Counter - packets sent
//      r5    |  Counter - delay loops performed
//      r6    |  Counter - overflow conditions met
//      r7    |  Const   - Base address of data buffer

INIT:
	// Enable OCP master port -- allows external memory access
    	LBCO      r0, C4, 4, 4
    	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable
    	SBCO      r0, C4, 4, 4

	MOV r7, READ_ADDRESS

	MOV r0, 8 // init offset to ninth byte
	MOV r1, OFFSET_LIM // store end of buffer location
	MOV r2, PRU0_DELAY // store PRU delay value
	LBBO r3, r7, 0, 4 // read number of packets from RAM
	SBBO r0, r7, 4, 4 // write initial read offset to RAM 
	MOV r4, 0 // init number of packets sent to 0
	MOV r5, 0 // init delay counter to 0
	MOV r6, 0 // init overflow counter to 0


START:
	LBBO r8, r7, r0, 88 // load 88 bytes
	ADD r0, r0, 88 // increment read offset
	SBBO r0, r7, 4, 4 // store read cursor

	ADD r4, r4, 1 // increment packet counter

MAIN_LOOP:
	XOUT 10, r8, 88 // write to SP

	// if packet counter reaches total length
	QBEQ STOP, r4, r3 // jump to STOP and halt operation 
	
	// else
	ADD r4, r4, 1 // increment packet count

	// if overflow condition not met
	QBNE LOAD_DATA, r0, r1 // jump to LOAD_DATA
 
	// else
	MOV r0, 8 // reset offset to start of buffer

LOAD_DATA:
	LBBO r8, r7, r0, 88 // load a packet (88B) from RAM

	ADD r0, r0, 88 // increment offset
	SBBO r0, r7, 4, 4 // store current offset to RAM

	MOV r5, 0 // reset delay counter

WAIT:
	ADD r5, r5, 1 // increment delay
	
	// if sufficient delay for PRU0 not reached
	QBNE WAIT, r5, r2 // continue delay

	// else
	JMP MAIN_LOOP // return to main loop

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT+16 // send termination interrupt to ARM
	HALT // shut down


.origin 0
.entrypoint INIT

#define PRU0_DELAY 70196 // delay needed to wait for PRU0
#define INIT_DELAY 70400 // delay needed for initial read-in
#define OFFSET_LIM 16376 // maximum byte offset
#define READ_ADDRESS 0x90000000

#include "../../include/asm.hp"

// NOTE: Delay assuems 140799 cycles between PRU0 XOUTs
// and allows for all LBCO/SBCO to take 200 cycles each.
// This should ensure that PRU1 is always done before PRU0,
// which allows XIN to begin and hang until PRU0 done.
// Note that if PRU1 is done more than 1023 cycles before PRU0,
// we will start to see issues with XIN timing out.


INIT:
	// Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

	// make C31 (CONST_DDR) point to DDR base address
	MOV		  r0, 0x100000
	MOV		  r1, PRU1CTPPR_1
	SBBO	  r0, r1, 0, 4

	MOV r7, READ_ADDRESS

	MOV		  r0, 8 // init write offset to ninth byte
	MOV		  r1, 0 // init delay counter to 0
	MOV		  r2, PRU0_DELAY // store PRU delay value
	LBBO	  r3, r7, 0, 4 // read number of packets from RAM
	SBBO	  r0, r7, 4, 4 // write initial write offset to RAM
	MOV		  r4, 0 // init number of packets received to 0
	MOV		  r5, INIT_DELAY // store initial delay value
	MOV		  r6, OFFSET_LIM // store end of buffer location

START_DELAY: // init special-case delay
	ADD r1, r1, 1
	QBNE START_DELAY, r1, r5

MAIN_LOOP:
	XIN 10, r8, 88 // read from SP

	// if overflow condition not met
	QBNE STORE_DATA, r0, r6 // jump to STORE_DATA

	// else
	MOV r0, 8 // reset offset to start of buffer

STORE_DATA:
	SBBO r8, r7, r0, 88 // push packet to RAM
	ADD r0, r0, 88 // increment offset
	SBBO r0, r7, 4, 4 // store write offset to RAM

	ADD r4, r4, 1 // increment packet count

	// if packet counter reaches total length
	QBEQ STOP, r4, r3 // jump to STOP and halt operation

	// else
	MOV r1, 0 // reset delay counter

WAIT:
	ADD r1, r1, 1 // increment delay

	// if sufficient delay for PRU0 not reached
	QBNE WAIT, r1, r2 // continue delay

	// else
	JMP MAIN_LOOP // return to main loop

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT + 16 // send program complete ineterrupt to host
	HALT // shut down microcontroller

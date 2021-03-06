// Transmitter - PRU1 source code.

// Responsible for pulling outgoing data from main memory and passing
// the data to PRU0 for modulation. On init, PRU1 will load the number of 
// packets to transfer in the current transmission, and will track its packet 
// count thereafter. The operating principle is straightforward: PRU1 will load
// a packet from main RAM, pass it to PRU0, and then delay for the (deterministic)
// amount of time that PRU0 takes to modulate its output. After this period,
// PRU1 will write another packet to PRU0 and load another from main memory,
// continuing this loop until all packets have been transferred in this fashion.
// It is worth noting that the XFR instruction used to transfer data between
// PRUs is a self-synchronizing operation, such that clock drift in this instance
// is effectively a non-issue. 

.origin 0
.entrypoint INIT
#include "../../include/asm.hp"

//  ____________________ 
//  Register  |  Purpose
//
//      r0    |  Counter - Byte offset for reading from RAM
//      r1    |  Const   - Offset limit to prevent over-reading the buffer
//      r2    |  Const   - delays to perform
//      r3    |  Const   - packets to transfer
//      r4    |  Counter - packets sent
//      r5    |  Counter - delay loops performed
//      r6    |  Const   - Base address of data buffer
//    r9-r29  |  Holder  - hold sampled bytes

INIT:

    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4									 // Enable OCP master port 
    SBCO      r0, C4, 4, 4

	MOV 	  r6, DDR_ADDRESS

	MOV 	  r0, 8                 					 // init offset to ninth byte
	MOV 	  r1, OFFSET_LIM        					 // store end of buffer location
	MOV 	  r2, PRU0_DELAY        					 // store PRU delay value
	
	LBBO 	  r3, r6, 0, 4         						 // read number of packets from RAM
	SBBO 	  r0, r6, 4, 4         						 // write initial read offset to RAM 
	
	MOV 	  r4, 0                 					 // init packets sent to 0
	MOV 	  r5, 0                 					 // init delay counter to 0

START:
	LBBO 	  r9, r6, r0, PACK_LEN 						 // load PACK_LEN bytes
	ADD 	  r0, r0, PACK_LEN      					 // increment read offset
	SBBO 	  r0, r6, 4, 4         						 // store read offset

	ADD 	  r4, r4, 1             					 // increment packet counter

MAIN_LOOP:
	XOUT 	  10, r9, PACK_LEN     						 // write to SP

														 // if packet counter reaches total length
	QBEQ 	  STOP, r4, r3         						 // jump to STOP and halt operation 
	
														 // else
	ADD 	  r4, r4, 1             					 // increment packet count

														 // if overflow condition not met
	QBNE 	  LOAD_DATA, r0, r1    						 // jump to LOAD_DATA
 
														 // else
	MOV 	  r0, 8                 					 // reset offset to start of buffer

LOAD_DATA:
	LBBO 	  r9, r6, r0, PACK_LEN 						 // load a packet from RAM

	ADD 	  r0, r0, PACK_LEN      					 // increment offset
	SBBO 	  r0, r6, 4, 4         						 // store current offset to RAM

	MOV 	  r5, 0                 					 // reset delay counter

WAIT:
	ADD 	  r5, r5, 1            						 // increment delay
	
														 // if sufficient delay for PRU0 not reached
	QBNE 	  WAIT, r5, r2        						 // continue delay

														 // else
	JMP 	  MAIN_LOOP            						 // return to main loop

STOP:
	MOV 	  r31.b0, PRU1_ARM_INTERRUPT + 16   		 // send termination interrupt to ARM
	HALT                                				 // shut down



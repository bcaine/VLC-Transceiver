.origin 0
.entrypoint INIT

#define OFFSET_LIM 16777208//16376 // maximum byte offset
#define DDR_ADDRESS 0x90000000
#define READY_CODE 0xaa
#define DONE_CODE 0xff

#define PACKETS_2_RCV 15

#define INIT_OFFSET 8
#define PACK_LEN   88

#include "../../include/asm.hp"

//  _____________________
//  Register  |  Purpose
//		      
//      r0    |  Counter - write offset for RAM stores
//		r1	  |  Holder  - end of buffer offset (wraparound)
//      r2    |  Holder  - address of start of buffer (no offset)
//	   r3.b0  |  Check   - holds zero value to reset packet ready code
//	   r3.b1  |  Check   - holds value at 'packet ready' code location
//     r3.b2  |  Holder  - holds value at done code location
//
//      r4    |  Counter - number of packets received
//
//			  |
//    r8-r29  |  Holder  - hold sampled bytes
//      r30   |  I/O     - holds GPI pin register (.t15)

INIT:
	// Enable OCP master port
	LBCO      r0, C4, 4, 4
	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
	SBCO      r0, C4, 4, 4

	MOV     r0, 0x00000120      // Configure the programmable pointer register for PRU0 by setting c28_pointer[15:0]
	MOV     r1, PRU1CTPPR_0         // field to 0x0120.  This will make C28 point to 0x00012000 (PRU shared RAM).
	SBBO    r0, r1, 0, 4

	MOV r0, INIT_OFFSET // init write offset to ninth byte
	MOV r1, OFFSET_LIM // store end of buffer location
	MOV r2, DDR_ADDRESS
	MOV r3.b0, 0 // holder for resetting packet ready code

	MOV r4, 0
	
	SBBO r0, r2, 4, 4 // write initial offset to RAM
	SBCO r3.b0, CONST_PRUSHAREDRAM, 0, 1 // make sure packet ready on init is not true


POLL_PX: // poll until PRU0 says a packet is ready
	LBCO r3.b1, CONST_PRUSHAREDRAM, 0, 1 
	QBNE POLL_PX, r3.b1, READY_CODE

READ_DATA: // pull in data from PRU0
	XIN 10, r8, PACK_LEN // read from SP
	
	// if overflow condition not met
	QBNE STORE_DATA, r0, r1 // jump to STORE_DATA

	// else
	MOV r0, INIT_OFFSET // reset offset to start of buffer

STORE_DATA:
	SBBO r8, r2, r0, PACK_LEN // push packet to RAM
	ADD r0, r0, PACK_LEN // increment offset
	SBBO r0, r2, 4, 4 // store write offset to RAM

	SBCO r3.b0, CONST_PRUSHAREDRAM, 0, 1 // overwrite the packet ready code
	
	ADD r4, r4, 1
	QBEQ STOP, r4, PACKETS_2_RCV
	
	//LBBO r3.b2, r2, 0, 1 // check the value of the done code
	// if host has written done code
	//QBEQ STOP, r3.b2, DONE_CODE // jump to STOP and halt operation

	// else
	JMP POLL_PX // return to main loop

STOP:

	MOV r31.b0, PRU1_ARM_INTERRUPT + 16 // send program complete interrupt to host
	HALT // shut down microcontroller

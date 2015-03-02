.origin 0
.entrypoint INIT

#include "../../include/asm.hp"

//  _____________________
//  Register  |  Purpose
//		      
//      r0    |  Counter - write offset for RAM stores
//	    r1    |  Holder  - end of buffer offset (wraparound)
//      r2    |  Holder  - address of start of buffer (no offset)
//     r3.b0  |  Check   - holds zero value to reset packet ready code
//     r3.b1  |  Check   - holds value at 'packet ready' code location
//     r3.b2  |  Holder  - holds value at done code location
//
//      r6    |  Counter - number of packets received
//
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
		
	SBBO r0, r2, 4, 4 // write initial offset to RAM
	SBCO r3.b0, CONST_PRUSHAREDRAM, 0, 1 // make sure packet ready on init is not true
	
	MOV r4, 0
	MOV r5, RX_PRU1_TIMEOUT
	// test only:
	MOV r6, 0 // init packet counter to 0
	MOV r7, PACKET_LIMIT

// Initial polling loop has no timeout
POLL_INIT:
	LBCO r3.b1, CONST_PRUSHAREDRAM, 0, 1
	QBNE POLL_PX, r3.b1, READY_CODE
	
	JMP READ

// Once we've received a packet, return if we go too long without getting one
POLL_PX: // poll until PRU0 says a packet is ready
	LBCO r3.b1, CONST_PRUSHAREDRAM, 0, 1 
	QBNE POLL_PX, r3.b1, READY_CODE
	
READ: // pull in data from PRU0
	XIN 10, r9, PACK_LEN // read from SP

	// if overflow condition not met
	QBNE STORE, r0, r1 // jump to STORE_DATA

	// else
	MOV r0, INIT_OFFSET // reset offset to start of buffer

STORE:
	SBBO r9, r2, r0, PACK_LEN // push packet to RAM
	ADD r0, r0, PACK_LEN // increment offset
	SBBO r0, r2, 4, 4 // store write offset to RAM

	SBCO r3.b0, CONST_PRUSHAREDRAM, 0, 1 // overwrite the packet ready code
	
	MOV r4, 0 // reset timeout delay
	
	// test only:
	ADD r6, r6, 1
	QBEQ STOP, r6, r7

	// else
	JMP POLL_PX // return to main loop

STOP:

	MOV r31.b0, PRU1_ARM_INTERRUPT + 16 // send program complete interrupt to host
	HALT // shut down microcontroller


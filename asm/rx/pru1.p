.origin 0
.entrypoint INIT

#define OFFSET_LIM 16777208//16376 // maximum byte offset
#define DDR_ADDRESS 0x90000000
#define READY_CODE 0xaa
#define DONE_CODE 0xff

#define PACKETS_2_RCV 15

#include "../../include/asm.hp"

INIT:
	// Enable OCP master port
    	LBCO      r0, C4, 4, 4
    	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    	SBCO      r0, C4, 4, 4

        MOV     r0, 0x00000120      // Configure the programmable pointer register for PRU0 by setting c28_pointer[15:0]
	MOV     r1, PRU1CTPPR_0         // field to 0x0120.  This will make C28 point to 0x00012000 (PRU shared RAM).
	SBBO    r0, r1, 0, 4

	//MOV		  r4.b1, DONE_CODE	
	//MOV		  r1,    OFFSET_LIM // store end of buffer location

	MOV		  r2,    DDR_ADDRESS	
	MOV		  r0,    8 // init write offset to ninth byte
	MOV		  r4.b0, 0
	MOV 		  r7,    0
	MOV 		  r6,    PACKETS_2_RCV
	SBBO	  	  r0,    r2,     4,     4 // write initial offset to RAM

	SBCO      r4.b0, CONST_PRUSHAREDRAM, 0, 1 // make sure packet ready on init is not true


POLL_PX: // poll until PRU0 says a packet is ready
	LBCO r5.b0, CONST_PRUSHAREDRAM, 0, 1 
	QBNE POLL_PX, r5.b0, READY_CODE

READ_DATA: // pull in data from PRU0
	XIN 10, r8, 88 // read from SP
	
	// if overflow condition not met
	//QBNE STORE_DATA, r0, r1 // jump to STORE_DATA

	// else
	//MOV r0, 8 // reset offset to start of buffer

STORE_DATA:
	SBBO r8, r2, r0, 88 // push packet to RAM
	ADD r0, r0, 88 // increment offset
	SBBO r0, r2, 4, 4 // store write offset to RAM

	SBCO r4.b0, CONST_PRUSHAREDRAM, 0, 1 // overwrite the packet ready code
	ADD r7, r7, 1
	QBEQ STOP, r7, r6
	//LBBO r5.b0, r2, 0, 1 // check the value of the done code

	// if host has written done code
	//QBEQ STOP, r5.b0, r4.b1 // jump to STOP and halt operation

	// else
	JMP POLL_PX // return to main loop

STOP:

	MOV r0, 0
        MOV r1, 0
        MOV r2, 0
        MOV r3, 0
        MOV r4, 0
        MOV r5, 0
        MOV r6, 0
        MOV r7, 0
        MOV r8, 0
        MOV r9, 0
        MOV r10, 0
        MOV r11, 0
        MOV r12, 0
        MOV r13, 0
        MOV r14, 0
        MOV r15, 0
        MOV r16, 0
        MOV r17, 0
        MOV r18, 0
        MOV r19, 0
        MOV r20, 0
        MOV r21, 0
        MOV r22, 0
        MOV r23, 0
        MOV r24, 0
        MOV r25, 0
        MOV r26, 0
        MOV r27, 0
        MOV r28, 0
        MOV r29, 0
	SBBO r0, r7, 0, 120
	SBCO r0, CONST_PRUSHAREDRAM, 0, 120
	MOV r31.b0, PRU1_ARM_INTERRUPT + 16 // send program complete interrupt to host
	HALT // shut down microcontroller

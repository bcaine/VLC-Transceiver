.origin 0
.entrypoint INIT
#include "gpio.hp"

INIT:
    	
	// Enable OCP master port
    	LBCO      r0, CONST_PRUCFG, 4, 4
    	CLR     r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    	SBCO      r0, CONST_PRUCFG, 4, 4

	// make CONST_DDR (C31) point to DDR base address
	MOV r0, 0x00100000
    	MOV r1, CTPPR_1
    	SBBO r0, r1, 0, 4

        MOV r1, 0 // delay loop counter

	MOV r2, 49 // delay loop limit high
	MOV r3, 48 // delay loop limit low

	MOV r4, 0 // counter of 2-bit cycles 
        MOV r5, 100000 // number of 2-bit cycles to modulate

SQ_LOOP:
        SET r30.t15
        MOV r1, 0
	
DELAY_HIGH:
	ADD r1, r1, 1
	QBNE DELAY_HIGH, r1, r2

	CLR r30.t15
	MOV r1, 0

DELAY_LOW:
	ADD r1, r1, 1
	QBNE DELAY_LOW, r1, r3

	ADD r4, r4, 1
        QBNE SQ_LOOP, r4, r5
	
END_SQ_LOOP:
        MOV r31.b0, PRU1_ARM_INTERRUPT+16

	HALT


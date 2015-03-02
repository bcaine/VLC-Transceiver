.origin 0
.entrypoint INIT
#include "../../../include/asm.hp"

#define PREAMBLE 0b00000000

INIT:
	// Enable OCP master port
        LBCO      r0, C4, 4, 4
        CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
        SBCO      r0, C4, 4, 4

	MOV r1.b1, 0
	MOV r3.b0, PREAMBLE
	MOV r3.b2, 0
	MOV r3.b3, 0
	MOV r4, PREAMBLE
	MOV r5, 0x90000000
	LBBO r2.b0, r5, 0, 1
	
	LSL r2.b0, r2.b0, 2
	SET r2.b0.t0
	CLR r2.b0.t0
	SBBO r2.b0, r5, 0, 1
	
PRE:
	XOR r1.b1, r2.b0, r3.b0 // get bitwise differences b/w preamble and current
	SBBO r1.b1, r5, 1, 1
	NOT r1.b1, r1.b1 // NOT - get bitwise similarities
	SBBO r1.b1, r5, 2, 1

        LSR r3.b3, r1.b1, 0 // shift to bit of interest
        AND r3.b3, r3.b3, 1 // isolate that bit
        ADD r3.b2, r3.b2, r3.b3 // add it to the counter

        LSR r3.b3, r1.b1, 1 // repeat for each bit
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

        LSR r3.b3, r1.b1, 2
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 3
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 4
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 5
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 6
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 7
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	SBBO r3.b2, r5, 3, 1

STOP:
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT

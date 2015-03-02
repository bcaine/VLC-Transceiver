.origin 0
.entrypoint INIT
#include "../../../include/asm.hp"

#define TESTPREAMBLE 0b00111100
#define TESTREQ 5
#define HIGH 0b11111111
INIT:
	// Enable OCP master port
        LBCO      r0, C4, 4, 4
        CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
        SBCO      r0, C4, 4, 4

	MOV r1.b0, 0
	MOV r1.b1, TESTPREAMBLE
	MOV r1.b2, 0
	MOV r1.b3, 0
	MOV r3.b2, 0
	MOV r4, TESTPREAMBLE
	MOV r5, 0x90000000

	LBBO r2.b0, r5, 0, 1
	MOV r1.b0, r2.b0
	MOV r2.b1, HIGH
        SBBO r2.b1, r5, 5, 1
	LSL r2.b0, r2.b0, 5
	SBBO r2.b0, r5, 0, 1
	SBBO r2.b1, r5, 6, 1
	
PRE:

    XOR r1.b0, r1.b0, r1.b1 // get bitwise differences b/w preamble and current
    SBBO r1.b0, r5, 1, 1

    NOT r1.b0, r1.b0 // NOT - get bitwise similarities
    SBBO r1.b0, r5, 2, 1

    LSR r1.b0, r1.b0, 0 // shift to bit of interest
    AND r1.b3, r1.b0, 1 // isolate that bit
    ADD r1.b2, r1.b2, r1.b3 // add it to the counter

    LSR r1.b0, r1.b0, 1 // repeat for each bit
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    LSR r1.b0, r1.b0, 1
    AND r1.b3, r1.b0, 1 
    ADD r1.b2, r1.b2, r1.b3

    QBLT WRITE_HIGH, r1.b2, TESTREQ  
    SBBO r1.b2, r5, 3, 1

STOP:
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT

WRITE_HIGH:
	MOV r8, 0xff
	SBBO r8, r5, 3, 1
	JMP STOP

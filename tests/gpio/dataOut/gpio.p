.origin 0
.entrypoint INIT
#include "gpio.hp"

INIT:

	MOV r1, 47
	MOV r2, 45
	MOV r3, 0
	MOV r6, 1000000
	//MOV r5, 0b0101010101010101010101010101010101

        //MOV r5, 0b1100110011001100110011001100110011	
	MOV r5, 0b1010101010101010101010101010101010
	//MOV r5, 0b1111111111111111111111111111111111
	//MOV r5, 0b0000000000000000000000000000000000

MAIN_LOOP:

CLC_B1b1:
	MOV r0, 0
	LSR r4, r5, 31
	AND r4, r4, 1
	QBEQ SET_B1b1, r4, 1

CLR_B1b1:
	CLR r30.t15
	JMP DEL_B1b1

SET_B1b1:
	SET r30.t15
	JMP DEL_B1b1

DEL_B1b1:
	ADD r0, r0, 1
	QBNE DEL_B1b1, r0, r1

CLC_B1b2:
	MOV r0, 0
	LSR r4, r5, 30
	AND r4, r4, 1
	QBEQ SET_B1b2, r4, 1

CLR_B1b2:
	CLR r30.t15
	JMP DEL_B1b2

SET_B1b2:
	SET r30.t15
	JMP DEL_B1b2

DEL_B1b2:
	ADD r0, r0, 1
	QBNE DEL_B1b2, r0, r1

CLC_B1b3:
	MOV r0, 0
	LSR r4, r5, 29
	AND r4, r4, 1
	QBEQ SET_B1b3, r4, 1

CLR_B1b3:
	CLR r30.t15
	JMP DEL_B1b3

SET_B1b3:
	SET r30.t15
	JMP DEL_B1b3

DEL_B1b3:
	ADD r0, r0, 1
	QBNE DEL_B1b3, r0, r1

CLC_B1b4:
        MOV r0, 0
        LSR r4, r5, 28
	AND r4, r4, 1
        QBEQ SET_B1b4, r4, 1

CLR_B1b4:
        CLR r30.t15
        JMP DEL_B1b4

SET_B1b4:
        SET r30.t15
        JMP DEL_B1b4

DEL_B1b4:
        ADD r0, r0, 1
        QBNE DEL_B1b4, r0, r1

CLC_B1b5:
        MOV r0, 0
        LSR r4, r5, 27
        AND r4, r4, 1
        QBEQ SET_B1b5, r4, 1

CLR_B1b5:
        CLR r30.t15
        JMP DEL_B1b5

SET_B1b5:
        SET r30.t15
        JMP DEL_B1b5

DEL_B1b5:
        ADD r0, r0, 1
        QBNE DEL_B1b5, r0, r1

CLC_B1b6:
        MOV r0, 0
        LSR r4, r5, 26
        AND r4, r4, 1
        QBEQ SET_B1b6, r4, 1

CLR_B1b6:
        CLR r30.t15
        JMP DEL_B1b6

SET_B1b6:
        SET r30.t15
        JMP DEL_B1b6

DEL_B1b6:
        ADD r0, r0, 1
        QBNE DEL_B1b6, r0, r1

CLC_B1b7:
        MOV r0, 0
        LSR r4, r5, 25
        AND r4, r4, 1
        QBEQ SET_B1b7, r4, 1

CLR_B1b7:
        CLR r30.t15
        JMP DEL_B1b7

SET_B1b7:
        SET r30.t15
        JMP DEL_B1b7

DEL_B1b7:
        ADD r0, r0, 1
        QBNE DEL_B1b7, r0, r1

CLC_B1b8:
        MOV r0, 0
        LSR r4, r5, 24
        AND r4, r4, 1
        QBEQ SET_B1b8, r4, 1

CLR_B1b8:
        CLR r30.t15
        JMP DEL_B1b8

SET_B1b8:
        SET r30.t15
        JMP DEL_B1b8

BCK_B1b8:
	JMP MAIN_LOOP

DEL_B1b8:
        ADD r0, r0, 1
        QBNE DEL_B1b8, r0, r2

	ADD r3, r3, 1
	QBNE BCK_B1b8, r3, r6

END_LOOP:
        MOV r31.b0, PRU0_ARM_INTERRUPT+16

	HALT


.origin 0
.entrypoint INIT
#include "../../include/asm.hp"

#define READ_ADDRESS 0x90000000

INIT:
	// Enable OCP master port
	LBCO      r0, C4, 4, 4
	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
	SBCO      r0, C4, 4, 4

	MOV r7, READ_ADDRESS
	
	MOV r0.b0, 0 // counter -- register number
	MOV r0.b1, 0 // counter -- preamble verified bits
	
	MOV r1.b0, 0 // counter --delay
	MOV r1.b1, 97 // loop delay --forward
	MOV r1.b2, 92 // loop delay --backward (init not req, here for visibility)
	MOV r1.b3, 96 // loop delay --preamble (init not req, here for visibility)

	MOV r2, 0 // counter --packet length
	LBBO r3, r7, 0, 4 // what's the offset?

	// Free Registers: r5, r6, r7
	// Cycle Count: 140800
	JMP START_PRE

NEW_PACKET:
	XOUT 10, r1.b3, 87

DEL_NEW:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_NEW, r1.b0, r1.b2

	MOV r0.b1, 0 // reset verified
	JMP START_PRE

PRE_P1b1: // restarting preamble - 200c
	MOV r0.b1, 0 // reset verified
START_PRE: // coming from valid data - 199c
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b1, r4, 1

CLR_P1b1:
	CLR r29.t31
	MOV r0.b1, r0.b1
	JMP DEL_P1b1

SET_P1b1:
	SET r29.t31
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b1

DEL_P1b1:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b1, r1.b0, r1.b3

PRE_P1b2: // 200c
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b2, r4, 1

CLR_P1b2:
	CLR r29.t30
	MOV r0.b1, r0.b1
	JMP DEL_P1b2

SET_P1b2:
	SET r29.t30
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b2

DEL_P1b2:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b2, r1.b0, r1.b3

PRE_P1b3: //200c
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b3, r4, 1

CLR_P1b3:
	CLR r29.t29
	MOV r0.b1, r0.b1
	JMP DEL_P1b3

SET_P1b3:
	SET r29.t29
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b3

DEL_P1b3:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b3, r1.b0, r1.b3

PRE_P1b4: // 200c
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b4, r4, 1

CLR_P1b4:
	CLR r29.t28
	MOV r0.b1, r0.b1
	JMP DEL_P1b4

SET_P1b4:
	SET r29.t28
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b4

DEL_P1b4:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b5, r1.b0, r1.b3

PRE_P1b5: // 200c
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b5, r4, 1

CLR_P1b5:
	CLR r29.t27
	MOV r0.b1, r0.b1
	JMP DEL_P1b5

SET_P1b5:
	SET r29.t27
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b5

DEL_P1b5:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b5, r1.b0, r1.b3

PRE_P1b6: // 200c
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b6, r4, 1

CLR_P1b6:
	CLR r29.t26
	MOV r0.b1, r0.b1
	JMP DEL_P1b6

SET_P1b6:
	SET r29.t26
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b6

DEL_P1b6:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b6, r1.b0, r1.b3

PRE_P1b7: // 200c 
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b7, r4, 1

CLR_P1b7:
	CLR r29.t25
	MOV r0.b1, r0.b1
	JMP DEL_P1b7

SET_P1b7:
	SET r29.t25
	ADD r0.b1, r0.b1, 1
	JMP DEL_P1b7

DEL_P1b7:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b7, r1.b0, r1.b3

PRE_P1b8: // 200c (pre) - 201c (data)
	MOV r1.b0, 0
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_P1b8, r4, 1

CLR_P1b8:
	CLR r29.t24
	MOV r0.b1, r0.b1
	MOV r1.b3, 94
	JMP DEL_P1b8 

SET_P1b8:
	SET r29.t24
	ADD r0.b1, r0.b1, 1
	MOV r1.b3, 94
	JMP DEL_P1b8

DEL_P1b8:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_P1b8, r1.b0, r1.b3 

CHK_PRE:
	MOV r1.b0, 0
	MOV r1.b3, 96 // reset preamble delay
	QBLT PRE_P1b1, r0.b1, 7 // repeat preamble - 200c
	JMP SMP_B2b8 // go to data - 201c

DEL_CPY:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_CPY, r1.b0, r1.b2

SMP_B1b1:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b1, r4, 1

CLR_B1b1:
	CLR r29.t31
	JMP DEL_B1b1

SET_B1b1:
	SET r29.t31
	JMP DEL_B1b1

DEL_B1b1:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b1, r1.b0, r1.b1

SMP_B1b2:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b2, r4, 1

CLR_B1b2:
	CLR r29.t30
	JMP DEL_B1b2

SET_B1b2:
	SET r29.t30
	JMP DEL_B1b2

DEL_B1b2:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b2, r1.b0, r1.b1

SMP_B1b3:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b3, r4, 1

CLR_B1b3:
	CLR r29.t29
	JMP DEL_B1b3

SET_B1b3:
	SET r29.t29
	JMP DEL_B1b3

DEL_B1b3:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b3, r1.b0, r1.b1

SMP_B1b4:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b4, r4, 1

CLR_B1b4:
	CLR r29.t28
	JMP DEL_B1b4

SET_B1b4:
	SET r29.t28
	JMP DEL_B1b4

DEL_B1b4:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b4, r1.b0, r1.b1

SMP_B1b5:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b5, r4, 1

CLR_B1b5:
	CLR r29.t27
	JMP DEL_B1b5

SET_B1b5:
	SET r29.t27
	JMP DEL_B1b5

DEL_B1b5:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b5, r1.b0, r1.b1

SMP_B1b6:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b6, r4, 1

CLR_B1b6:
	CLR r29.t26
	JMP DEL_B1b6

SET_B1b6:
	SET r29.t26
	JMP DEL_B1b6

DEL_B1b6:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b6, r1.b0, r1.b1

SMP_B1b7:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b7, r4, 1

CLR_B1b7:
	CLR r29.t25
	JMP DEL_B1b7

SET_B1b7:
	SET r29.t25
	JMP DEL_B1b7

DEL_B1b7:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b7, r1.b0, r1.b1

SMP_B1b8:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B1b8, r4, 1

CLR_B1b8:
	CLR r29.t24
	JMP DEL_B1b8

SET_B1b8:
	SET r29.t24
	JMP DEL_B1b8

BCK_P1b8:
	JMP NEW_PACKET

BCK_B1b8:
	JMP DEL_CPY

DEL_B1b8:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B1b8, r1.b0, r1.b1

SMP_B2b1:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b1, r4, 1

CLR_B2b1:
	CLR r29.t23
	JMP DEL_B2b1

SET_B2b1:
	SET r29.t23
	JMP DEL_B2b1

DEL_B2b1:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b1, r1.b0, r1.b1

SMP_B2b2:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b2, r4, 1

CLR_B2b2:
	CLR r29.t22
	JMP DEL_B2b2

SET_B2b2:
	SET r29.t22
	JMP DEL_B2b2

DEL_B2b2:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b2, r1.b0, r1.b1

SMP_B2b3:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b3, r4, 1

CLR_B2b3:
	CLR r29.t21
	JMP DEL_B2b3

SET_B2b3:
	SET r29.t21
	JMP DEL_B2b3

DEL_B2b3:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b3, r1.b0, r1.b1

SMP_B2b4:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b4, r4, 1

CLR_B2b4:
	CLR r29.t20
	JMP DEL_B2b4

SET_B2b4:
	SET r29.t20
	JMP DEL_B2b4

DEL_B2b4:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b4, r1.b0, r1.b1

SMP_B2b5:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b5, r4, 1

CLR_B2b5:
	CLR r29.t19
	JMP DEL_B2b5

SET_B2b5:
	SET r29.t19
	JMP DEL_B2b5

DEL_B2b5:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b5, r1.b0, r1.b1

SMP_B2b6:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b6, r4, 1

CLR_B2b6:
	CLR r29.t18
	JMP DEL_B2b6

SET_B2b6:
	SET r29.t18
	JMP DEL_B2b6

DEL_B2b6:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b6, r1.b0, r1.b1

SMP_B2b7:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b7, r4, 1

CLR_B2b7:
	CLR r29.t17
	JMP DEL_B2b7

SET_B2b7:
	SET r29.t17
	JMP DEL_B2b7

DEL_B2b7:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b7, r1.b0, r1.b1

SMP_B2b8:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B2b8, r4, 1

CLR_B2b8:
	CLR r29.t16
	JMP DEL_B2b8

SET_B2b8:
	SET r29.t16
	JMP DEL_B2b8

BCK_P2b8:
	JMP BCK_P1b8

BCK_B2b8:
	JMP BCK_B1b8

DEL_B2b8:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B2b8, r1.b0, r1.b1

SMP_B3b1:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b1, r4, 1

CLR_B3b1:
	CLR r29.t15
	JMP DEL_B3b1

SET_B3b1:
	SET r29.t15
	JMP DEL_B3b1

DEL_B3b1:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b1, r1.b0, r1.b1

SMP_B3b2:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b2, r4, 1

CLR_B3b2:
	CLR r29.t14
	JMP DEL_B3b2

SET_B3b2:
	SET r29.t14
	JMP DEL_B3b2

DEL_B3b2:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b2, r1.b0, r1.b1

SMP_B3b3:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b3, r4, 1

CLR_B3b3:
	CLR r29.t13
	JMP DEL_B3b3

SET_B3b3:
	SET r29.t13
	JMP DEL_B3b3

DEL_B3b3:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b3, r1.b0, r1.b1

SMP_B3b4:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b4, r4, 1

CLR_B3b4:
	CLR r29.t12
	JMP DEL_B3b4

SET_B3b4:
	SET r29.t12
	JMP DEL_B3b4

DEL_B3b4:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b4, r1.b0, r1.b1

SMP_B3b5:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b5, r4, 1

CLR_B3b5:
	CLR r29.t11
	JMP DEL_B3b5

SET_B3b5:
	SET r29.t11
	JMP DEL_B3b5

DEL_B3b5:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b5, r1.b0, r1.b1

SMP_B3b6:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b6, r4, 1

CLR_B3b6:
	CLR r29.t10
	JMP DEL_B3b6

SET_B3b6:
	SET r29.t10
	JMP DEL_B3b6

DEL_B3b6:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b6, r1.b0, r1.b1

SMP_B3b7:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b7, r4, 1

CLR_B3b7:
	CLR r29.t9
	JMP DEL_B3b7
		
SET_B3b7:
	SET r29.t9
	JMP DEL_B3b7

DEL_B3b7:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b7, r1.b0, r1.b1

SMP_B3b8:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B3b8, r4, 1

CLR_B3b8:
	CLR r29.t8
	JMP DEL_B3b8

SET_B3b8:
	SET r29.t8
	JMP DEL_B3b8

BCK_P3b8:
	JMP BCK_P2b8

BCK_B3b8:
	JMP BCK_B2b8

DEL_B3b8:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B3b8, r1.b0, r1.b1

SMP_B4b1:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b1, r4, 1

CLR_B4b1:
	CLR r29.t7
	JMP DEL_B4b1

SET_B4b1:
	SET r29.t7
	JMP DEL_B4b1

DEL_B4b1:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b1, r1.b0, r1.b1

SMP_B4b2:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b2, r4, 1

CLR_B4b2:
	CLR r29.t6
	JMP DEL_B4b2

SET_B4b2:
	SET r29.t6
	JMP DEL_B4b2

DEL_B4b2:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b2, r1.b0, r1.b1

SMP_B4b3:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b3, r4, 1

CLR_B4b3:
	CLR r29.t5
	JMP DEL_B4b3

SET_B4b3:
	SET r29.t5
	JMP DEL_B4b3

DEL_B4b3:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b3, r1.b0, r1.b1

SMP_B4b4:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b4, r4, 1

CLR_B4b4:
	CLR r29.t4
	JMP DEL_B4b4

SET_B4b4:
	SET r29.t4
	JMP DEL_B4b4

DEL_B4b4:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b4, r1.b0, r1.b1

SMP_B4b5:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b5, r4, 1

CLR_B4b5:
	CLR r29.t3
	JMP DEL_B4b5

SET_B4b5:
	SET r29.t3
	JMP DEL_B4b5

DEL_B4b5:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b5, r1.b0, r1.b1

SMP_B4b6:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b6, r4, 1

CLR_B4b6:
	CLR r29.t2
	JMP DEL_B4b6

SET_B4b6:
	SET r29.t2
	JMP DEL_B4b6

DEL_B4b6:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b6, r1.b0, r1.b1

SMP_B4b7:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b7, r4, 1

CLR_B4b7:
	CLR r29.t1
	JMP DEL_B4b7

SET_B4b7:
	SET r29.t1
	JMP DEL_B4b7

DEL_B4b7:
	ADD r1.b0, r1.b0, 1
	QBNE DEL_B4b7, r1.b0, r1.b1

SMP_B4b8:
	MOV r1.b0, 0
	LSR r31, r4, 15
	AND r4, r4, 1
	QBEQ SET_B4b8, r4, 1

CLR_B4b8:
	CLR r29.t0
	JMP UPD_R29

SET_B4b8:
	SET r29.t0
	JMP UPD_R29

BCK_P4b8:
	JMP BCK_P3b8

UPD_R29:
	ADD r0.b0, r0.b0, 1
	QBEQ CPY_R8, r0.b0, 1
	QBEQ CPY_R9, r0.b0, 2
	QBEQ CPY_R10, r0.b0, 3
	QBEQ CPY_R11, r0.b0, 4
	QBEQ CPY_R12, r0.b0, 5
	QBEQ CPY_R13, r0.b0, 6
	QBEQ CPY_R14, r0.b0, 7
	QBEQ CPY_R15, r0.b0, 8
	QBEQ CPY_R16, r0.b0, 9
	QBEQ CPY_R17, r0.b0, 10
	QBEQ CPY_R18, r0.b0, 11
	QBEQ CPY_R19, r0.b0, 12
	QBEQ CPY_R20, r0.b0, 13
	QBEQ CPY_R21, r0.b0, 14
	QBEQ CPY_R22, r0.b0, 15
	QBEQ CPY_R23, r0.b0, 16
	QBEQ CPY_R24, r0.b0, 17
	QBEQ CPY_R25, r0.b0, 18
	QBEQ CPY_R26, r0.b0, 19
	QBEQ CPY_R27, r0.b0, 20
	QBEQ CPY_R28, r0.b0, 21
	MOV r0.b0, 0

CHECK_DONE:
	ADD r2, r2, 1
	SUB r1.b3, r1.b3, 3
	QBNE BCK_P4b8, r2, r3
	XOUT 10, r1.b3, 88
	JMP STOP

CPY_R8:
	MOV r1.b3, r29
	MOV r1.b2, 93
	JMP BCK_B3b8
CPY_R9:
	MOV r9, r29
	JMP BCK_B3b8
CPY_R10:
	MOV r10, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R11:
	MOV r11, r29
	JMP BCK_B3b8
CPY_R12:
	MOV r12, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R13:
	MOV r13, r29
	JMP BCK_B3b8
CPY_R14:
	MOV r14, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R15:
	MOV r15, r29
	JMP BCK_B3b8
CPY_R16:
	MOV r16, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R17:
	MOV r17, r29
	JMP BCK_B3b8
CPY_R18:
	MOV r18, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R19:
	MOV r19, r29
	JMP BCK_B3b8
CPY_R20:
	MOV r20, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R21:
	MOV r21, r29
	JMP BCK_B3b8
CPY_R22:
	MOV r22, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R23:
	MOV r23, r29
	JMP BCK_B3b8
CPY_R24:
	MOV r24, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R25:
	MOV r25, r29
	JMP BCK_B3b8
CPY_R26:
	MOV r26, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8
CPY_R27:
	MOV r27, r29
	JMP BCK_B3b8
CPY_R28:
	MOV r28, r29
	SUB r1.b2, r1.b2, 1
	JMP BCK_B3b8

STOP:
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT

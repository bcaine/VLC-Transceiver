.origin 0
.entrypoint INIT
#include "tx.hp"

INIT:
	// Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4
		
	// make C31 (CONST_DDR) point to DDR base address
	MOV r0, 0x100000
	MOV r1, PRU0CTPPR_1
	SBBO r0, r1, 0, 4


	LBCO r3, CONST_DDR, 0, 4 // what's the offset?

	MOV r1, 47 // loop delay forward
	MOV r3, 45 // loop delay backward

// CYCLE COSTS:
// as stands: 200 cycles/bit, 640,000 cycles per loop


CHECK_DONE:
	LBCO r1, CONST_PRUSHAREDRAM, 0, 1 // non-deterministic, ~40-100 cycles
	QBEQ END_LOOP, r1, DONE_CODE

MAIN_LOOP:
	XIN 10, r8, 88 // load 100 bytes in from SP

CLC_B1b1:
        MOV r0, 0
        LSR r4, r8, 31
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
        LSR r4, r8, 30
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
        LSR r4, r8, 29
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
        LSR r4, r8, 28
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
        LSR r4, r8, 27
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
        LSR r4, r8, 26
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
        LSR r4, r8, 25
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
        LSR r4, r8, 24
        AND r4, r4, 1
        QBEQ SET_B1b8, r4, 1

CLR_B1b8:
        CLR r30.t15
        JMP DEL_B1b8

SET_B1b8:
        SET r30.t15
        JMP DEL_B1b8

BCK_B1b8:
		JMP CHECK_DONE

DEL_B1b8:
        ADD r0, r0, 1
        QBNE DEL_B1b8, r0, r1

CLC_B2b1:
        MOV r0, 0
        LSR r4, r8, 23
        AND r4, r4, 1
        QBEQ SET_B2b1, r4, 1

CLR_B2b1:
        CLR r30.t15
        JMP DEL_B2b1

SET_B2b1:
        SET r30.t15
        JMP DEL_B2b1

DEL_B2b1:
        ADD r0, r0, 1
        QBNE DEL_B2b1, r0, r1

CLC_B2b2:
        MOV r0, 0
        LSR r4, r8, 22
        AND r4, r4, 1
        QBEQ SET_B2b2, r4, 1

CLR_B2b2:
        CLR r30.t15
        JMP DEL_B2b2

SET_B2b2:
        SET r30.t15
        JMP DEL_B2b2

DEL_B2b2:
        ADD r0, r0, 1
        QBNE DEL_B2b2, r0, r1

CLC_B2b3:
        MOV r0, 0
        LSR r4, r8, 21
        AND r4, r4, 1
        QBEQ SET_B2b3, r4, 1

CLR_B2b3:
        CLR r30.t15
        JMP DEL_B2b3

SET_B2b3:
        SET r30.t15
        JMP DEL_B2b3

DEL_B2b3:
        ADD r0, r0, 1
        QBNE DEL_B2b3, r0, r1

CLC_B2b4:
        MOV r0, 0
        LSR r4, r8, 20
        AND r4, r4, 1
        QBEQ SET_B2b4, r4, 1

CLR_B2b4:
        CLR r30.t15
        JMP DEL_B2b4

SET_B2b4:
        SET r30.t15
        JMP DEL_B2b4

DEL_B2b4:
        ADD r0, r0, 1
        QBNE DEL_B2b4, r0, r1

CLC_B2b5:
        MOV r0, 0
        LSR r4, r8, 19
        AND r4, r4, 1
        QBEQ SET_B2b5, r4, 1

CLR_B2b5:
        CLR r30.t15
        JMP DEL_B2b5

SET_B2b5:
        SET r30.t15
        JMP DEL_B2b5

DEL_B2b5:
        ADD r0, r0, 1
        QBNE DEL_B2b5, r0, r1

CLC_B2b6:
        MOV r0, 0
        LSR r4, r8, 18
        AND r4, r4, 1
        QBEQ SET_B2b6, r4, 1

CLR_B2b6:
        CLR r30.t15
        JMP DEL_B2b6

SET_B2b6:
        SET r30.t15
        JMP DEL_B2b6

DEL_B2b6:
        ADD r0, r0, 1
        QBNE DEL_B2b6, r0, r1

CLC_B2b7:
        MOV r0, 0
        LSR r4, r8, 17
        AND r4, r4, 1
        QBEQ SET_B2b7, r4, 1

CLR_B2b7:
        CLR r30.t15
        JMP DEL_B2b7

SET_B2b7:
        SET r30.t15
        JMP DEL_B2b7

DEL_B2b7:
        ADD r0, r0, 1
        QBNE DEL_B2b7, r0, r1

CLC_B2b8:
        MOV r0, 0
        LSR r4, r8, 16
        AND r4, r4, 1
        QBEQ SET_B2b8, r4, 1

CLR_B2b8:
        CLR r30.t15
        JMP DEL_B2b8

SET_B2b8:
        SET r30.t15
        JMP DEL_B2b8

BCK_B2b8:
		JMP BCK_B1b8

DEL_B2b8:
        ADD r0, r0, 1
        QBNE DEL_B2b8, r0, r1

CLC_B3b1:
        MOV r0, 0
        LSR r4, r8, 15
        AND r4, r4, 1
        QBEQ SET_B3b1, r4, 1

CLR_B3b1:
        CLR r30.t15
        JMP DEL_B3b1

SET_B3b1:
        SET r30.t15
        JMP DEL_B3b1

DEL_B3b1:
        ADD r0, r0, 1
        QBNE DEL_B3b1, r0, r1

CLC_B3b2:
        MOV r0, 0
        LSR r4, r8, 14
        AND r4, r4, 1
        QBEQ SET_B3b2, r4, 1

CLR_B3b2:
        CLR r30.t15
        JMP DEL_B3b2

SET_B3b2:
        SET r30.t15
        JMP DEL_B3b2

DEL_B3b2:
        ADD r0, r0, 1
        QBNE DEL_B3b2, r0, r1

CLC_B3b3:
        MOV r0, 0
        LSR r4, r8, 13
        AND r4, r4, 1
        QBEQ SET_B3b3, r4, 1

CLR_B3b3:
        CLR r30.t15
        JMP DEL_B3b3

SET_B3b3:
        SET r30.t15
        JMP DEL_B3b3

DEL_B3b3:
        ADD r0, r0, 1
        QBNE DEL_B3b3, r0, r1

CLC_B3b4:
        MOV r0, 0
        LSR r4, r8, 12
        AND r4, r4, 1
        QBEQ SET_B3b4, r4, 1

CLR_B3b4:
        CLR r30.t15
        JMP DEL_B3b4

SET_B3b4:
        SET r30.t15
        JMP DEL_B3b4

DEL_B3b4:
        ADD r0, r0, 1
        QBNE DEL_B3b4, r0, r1

CLC_B3b5:
        MOV r0, 0
        LSR r4, r8, 11
        AND r4, r4, 1
        QBEQ SET_B3b5, r4, 1

CLR_B3b5:
        CLR r30.t15
        JMP DEL_B3b5

SET_B3b5:
        SET r30.t15
        JMP DEL_B3b5

DEL_B3b5:
        ADD r0, r0, 1
        QBNE DEL_B3b5, r0, r1

CLC_B3b6:
        MOV r0, 0
        LSR r4, r8, 10
        AND r4, r4, 1
        QBEQ SET_B3b6, r4, 1

CLR_B3b6:
        CLR r30.t15
        JMP DEL_B3b6

SET_B3b6:
        SET r30.t15
        JMP DEL_B3b6

DEL_B3b6:
        ADD r0, r0, 1
        QBNE DEL_B3b6, r0, r1

CLC_B3b7:
        MOV r0, 0
        LSR r4, r8, 9
        AND r4, r4, 1
        QBEQ SET_B3b7, r4, 1

CLR_B3b7:
        CLR r30.t15
        JMP DEL_B3b7

SET_B3b7:
        SET r30.t15
        JMP DEL_B3b7

DEL_B3b7:
        ADD r0, r0, 1
        QBNE DEL_B3b7, r0, r1

CLC_B3b8:
        MOV r0, 0
        LSR r4, r8, 8
        AND r4, r4, 1
        QBEQ SET_B3b8, r4, 1

CLR_B3b8:
        CLR r30.t15
        JMP DEL_B3b8

SET_B3b8:
        SET r30.t15
        JMP DEL_B3b8

BCK_B3b8:
		JMP BCK_B2b8

DEL_B3b8:
        ADD r0, r0, 1
        QBNE DEL_B3b8, r0, r1

CLC_B4b1:
        MOV r0, 0
        LSR r4, r8, 7
        AND r4, r4, 1
        QBEQ SET_B4b1, r4, 1

CLR_B4b1:
        CLR r30.t15
        JMP DEL_B4b1

SET_B4b1:
        SET r30.t15
        JMP DEL_B4b1

DEL_B4b1:
        ADD r0, r0, 1
        QBNE DEL_B4b1, r0, r1

CLC_B4b2:
        MOV r0, 0
        LSR r4, r8, 6
        AND r4, r4, 1
        QBEQ SET_B4b2, r4, 1

CLR_B4b2:
        CLR r30.t15
        JMP DEL_B4b2

SET_B4b2:
        SET r30.t15
        JMP DEL_B4b2

DEL_B4b2:
        ADD r0, r0, 1
        QBNE DEL_B4b2, r0, r1

CLC_B4b3:
        MOV r0, 0
        LSR r4, r8, 5
        AND r4, r4, 1
        QBEQ SET_B4b3, r4, 1

CLR_B4b3:
        CLR r30.t15
        JMP DEL_B4b3

SET_B4b3:
        SET r30.t15
        JMP DEL_B4b3

DEL_B4b3:
        ADD r0, r0, 1
        QBNE DEL_B4b3, r0, r1

CLC_B4b4:
        MOV r0, 0
        LSR r4, r8, 4
        AND r4, r4, 1
        QBEQ SET_B4b4, r4, 1

CLR_B4b4:
        CLR r30.t15
        JMP DEL_B4b4

SET_B4b4:
        SET r30.t15
        JMP DEL_B4b4

DEL_B4b4:
        ADD r0, r0, 1
        QBNE DEL_B4b4, r0, r1

CLC_B4b5:
        MOV r0, 0
        LSR r4, r8, 3
        AND r4, r4, 1
        QBEQ SET_B4b5, r4, 1

CLR_B4b5:
        CLR r30.t15
        JMP DEL_B4b5

SET_B4b5:
        SET r30.t15
        JMP DEL_B4b5

DEL_B4b5:
        ADD r0, r0, 1
        QBNE DEL_B4b5, r0, r1

CLC_B4b6:
        MOV r0, 0
        LSR r4, r8, 2
        AND r4, r4, 1
        QBEQ SET_B4b6, r4, 1

CLR_B4b6:
        CLR r30.t15
        JMP DEL_B4b6

SET_B4b6:
        SET r30.t15
        JMP DEL_B4b6

DEL_B4b6:
        ADD r0, r0, 1
        QBNE DEL_B4b6, r0, r1

CLC_B4b7:
        MOV r0, 0
        LSR r4, r8, 1
        AND r4, r4, 1
        QBEQ SET_B4b7, r4, 1

CLR_B4b7:
        CLR r30.t15
        JMP DEL_B4b7

SET_B4b7:
        SET r30.t15
        JMP DEL_B4b7

DEL_B4b7:
        ADD r0, r0, 1
        QBNE DEL_B4b7, r0, r1

CLC_B4b8:
        MOV r0, 0
        LSR r4, r8, 0
        AND r4, r4, 1
        QBEQ SET_B4b8, r4, 1

CLR_B4b8:
        CLR r30.t15
        JMP DEL_B4b8

SET_B4b8:
        SET r30.t15
        JMP DEL_B4b8

BCK_B4b8:
		JMP BCK_B3b8

DEL_B4b8:
        ADD r0, r0, 1
        QBNE DEL_B4b8, r0, r1

CLC_B5b1:
        MOV r0, 0
        LSR r4, r9, 31
        AND r4, r4, 1
        QBEQ SET_B5b1, r4, 1

CLR_B5b1:
        CLR r30.t15
        JMP DEL_B5b1

SET_B5b1:
        SET r30.t15
        JMP DEL_B5b1

DEL_B5b1:
        ADD r0, r0, 1
        QBNE DEL_B5b1, r0, r1

CLC_B5b2:
        MOV r0, 0
        LSR r4, r9, 30
        AND r4, r4, 1
        QBEQ SET_B5b2, r4, 1

CLR_B5b2:
        CLR r30.t15
        JMP DEL_B5b2

SET_B5b2:
        SET r30.t15
        JMP DEL_B5b2

DEL_B5b2:
        ADD r0, r0, 1
        QBNE DEL_B5b2, r0, r1

CLC_B5b3:
        MOV r0, 0
        LSR r4, r9, 29
        AND r4, r4, 1
        QBEQ SET_B5b3, r4, 1

CLR_B5b3:
        CLR r30.t15
        JMP DEL_B5b3

SET_B5b3:
        SET r30.t15
        JMP DEL_B5b3

DEL_B5b3:
        ADD r0, r0, 1
        QBNE DEL_B5b3, r0, r1

CLC_B5b4:
        MOV r0, 0
        LSR r4, r9, 28
        AND r4, r4, 1
        QBEQ SET_B5b4, r4, 1

CLR_B5b4:
        CLR r30.t15
        JMP DEL_B5b4

SET_B5b4:
        SET r30.t15
        JMP DEL_B5b4

DEL_B5b4:
        ADD r0, r0, 1
        QBNE DEL_B5b4, r0, r1

CLC_B5b5:
        MOV r0, 0
        LSR r4, r9, 27
        AND r4, r4, 1
        QBEQ SET_B5b5, r4, 1

CLR_B5b5:
        CLR r30.t15
        JMP DEL_B5b5

SET_B5b5:
        SET r30.t15
        JMP DEL_B5b5

DEL_B5b5:
        ADD r0, r0, 1
        QBNE DEL_B5b5, r0, r1

CLC_B5b6:
        MOV r0, 0
        LSR r4, r9, 26
        AND r4, r4, 1
        QBEQ SET_B5b6, r4, 1

CLR_B5b6:
        CLR r30.t15
        JMP DEL_B5b6

SET_B5b6:
        SET r30.t15
        JMP DEL_B5b6

DEL_B5b6:
        ADD r0, r0, 1
        QBNE DEL_B5b6, r0, r1

CLC_B5b7:
        MOV r0, 0
        LSR r4, r9, 25
        AND r4, r4, 1
        QBEQ SET_B5b7, r4, 1

CLR_B5b7:
        CLR r30.t15
        JMP DEL_B5b7

SET_B5b7:
        SET r30.t15
        JMP DEL_B5b7

DEL_B5b7:
        ADD r0, r0, 1
        QBNE DEL_B5b7, r0, r1

CLC_B5b8:
        MOV r0, 0
        LSR r4, r9, 24
        AND r4, r4, 1
        QBEQ SET_B5b8, r4, 1

CLR_B5b8:
        CLR r30.t15
        JMP DEL_B5b8

SET_B5b8:
        SET r30.t15
        JMP DEL_B5b8

BCK_B5b8:
		JMP BCK_B4b8

DEL_B5b8:
        ADD r0, r0, 1
        QBNE DEL_B5b8, r0, r1

CLC_B6b1:
        MOV r0, 0
        LSR r4, r9, 23
        AND r4, r4, 1
        QBEQ SET_B6b1, r4, 1

CLR_B6b1:
        CLR r30.t15
        JMP DEL_B6b1

SET_B6b1:
        SET r30.t15
        JMP DEL_B6b1

DEL_B6b1:
        ADD r0, r0, 1
        QBNE DEL_B6b1, r0, r1

CLC_B6b2:
        MOV r0, 0
        LSR r4, r9, 22
        AND r4, r4, 1
        QBEQ SET_B6b2, r4, 1

CLR_B6b2:
        CLR r30.t15
        JMP DEL_B6b2

SET_B6b2:
        SET r30.t15
        JMP DEL_B6b2

DEL_B6b2:
        ADD r0, r0, 1
        QBNE DEL_B6b2, r0, r1

CLC_B6b3:
        MOV r0, 0
        LSR r4, r9, 21
        AND r4, r4, 1
        QBEQ SET_B6b3, r4, 1

CLR_B6b3:
        CLR r30.t15
        JMP DEL_B6b3

SET_B6b3:
        SET r30.t15
        JMP DEL_B6b3

DEL_B6b3:
        ADD r0, r0, 1
        QBNE DEL_B6b3, r0, r1

CLC_B6b4:
        MOV r0, 0
        LSR r4, r9, 20
        AND r4, r4, 1
        QBEQ SET_B6b4, r4, 1

CLR_B6b4:
        CLR r30.t15
        JMP DEL_B6b4

SET_B6b4:
        SET r30.t15
        JMP DEL_B6b4

DEL_B6b4:
        ADD r0, r0, 1
        QBNE DEL_B6b4, r0, r1

CLC_B6b5:
        MOV r0, 0
        LSR r4, r9, 19
        AND r4, r4, 1
        QBEQ SET_B6b5, r4, 1

CLR_B6b5:
        CLR r30.t15
        JMP DEL_B6b5

SET_B6b5:
        SET r30.t15
        JMP DEL_B6b5

DEL_B6b5:
        ADD r0, r0, 1
        QBNE DEL_B6b5, r0, r1

CLC_B6b6:
        MOV r0, 0
        LSR r4, r9, 18
        AND r4, r4, 1
        QBEQ SET_B6b6, r4, 1

CLR_B6b6:
        CLR r30.t15
        JMP DEL_B6b6

SET_B6b6:
        SET r30.t15
        JMP DEL_B6b6

DEL_B6b6:
        ADD r0, r0, 1
        QBNE DEL_B6b6, r0, r1

CLC_B6b7:
        MOV r0, 0
        LSR r4, r9, 17
        AND r4, r4, 1
        QBEQ SET_B6b7, r4, 1

CLR_B6b7:
        CLR r30.t15
        JMP DEL_B6b7

SET_B6b7:
        SET r30.t15
        JMP DEL_B6b7

DEL_B6b7:
        ADD r0, r0, 1
        QBNE DEL_B6b7, r0, r1

CLC_B6b8:
        MOV r0, 0
        LSR r4, r9, 16
        AND r4, r4, 1
        QBEQ SET_B6b8, r4, 1

CLR_B6b8:
        CLR r30.t15
        JMP DEL_B6b8

SET_B6b8:
        SET r30.t15
        JMP DEL_B6b8

BCK_B6b8:
		JMP BCK_B5b8

DEL_B6b8:
        ADD r0, r0, 1
        QBNE DEL_B6b8, r0, r1

CLC_B7b1:
        MOV r0, 0
        LSR r4, r9, 15
        AND r4, r4, 1
        QBEQ SET_B7b1, r4, 1

CLR_B7b1:
        CLR r30.t15
        JMP DEL_B7b1

SET_B7b1:
        SET r30.t15
        JMP DEL_B7b1

DEL_B7b1:
        ADD r0, r0, 1
        QBNE DEL_B7b1, r0, r1

CLC_B7b2:
        MOV r0, 0
        LSR r4, r9, 14
        AND r4, r4, 1
        QBEQ SET_B7b2, r4, 1

CLR_B7b2:
        CLR r30.t15
        JMP DEL_B7b2

SET_B7b2:
        SET r30.t15
        JMP DEL_B7b2

DEL_B7b2:
        ADD r0, r0, 1
        QBNE DEL_B7b2, r0, r1

CLC_B7b3:
        MOV r0, 0
        LSR r4, r9, 13
        AND r4, r4, 1
        QBEQ SET_B7b3, r4, 1

CLR_B7b3:
        CLR r30.t15
        JMP DEL_B7b3

SET_B7b3:
        SET r30.t15
        JMP DEL_B7b3

DEL_B7b3:
        ADD r0, r0, 1
        QBNE DEL_B7b3, r0, r1

CLC_B7b4:
        MOV r0, 0
        LSR r4, r9, 12
        AND r4, r4, 1
        QBEQ SET_B7b4, r4, 1

CLR_B7b4:
        CLR r30.t15
        JMP DEL_B7b4

SET_B7b4:
        SET r30.t15
        JMP DEL_B7b4

DEL_B7b4:
        ADD r0, r0, 1
        QBNE DEL_B7b4, r0, r1

CLC_B7b5:
        MOV r0, 0
        LSR r4, r9, 11
        AND r4, r4, 1
        QBEQ SET_B7b5, r4, 1

CLR_B7b5:
        CLR r30.t15
        JMP DEL_B7b5

SET_B7b5:
        SET r30.t15
        JMP DEL_B7b5

DEL_B7b5:
        ADD r0, r0, 1
        QBNE DEL_B7b5, r0, r1

CLC_B7b6:
        MOV r0, 0
        LSR r4, r9, 10
        AND r4, r4, 1
        QBEQ SET_B7b6, r4, 1

CLR_B7b6:
        CLR r30.t15
        JMP DEL_B7b6

SET_B7b6:
        SET r30.t15
        JMP DEL_B7b6

DEL_B7b6:
        ADD r0, r0, 1
        QBNE DEL_B7b6, r0, r1

CLC_B7b7:
        MOV r0, 0
        LSR r4, r9, 9
        AND r4, r4, 1
        QBEQ SET_B7b7, r4, 1

CLR_B7b7:
        CLR r30.t15
        JMP DEL_B7b7

SET_B7b7:
        SET r30.t15
        JMP DEL_B7b7

DEL_B7b7:
        ADD r0, r0, 1
        QBNE DEL_B7b7, r0, r1

CLC_B7b8:
        MOV r0, 0
        LSR r4, r9, 8
        AND r4, r4, 1
        QBEQ SET_B7b8, r4, 1

CLR_B7b8:
        CLR r30.t15
        JMP DEL_B7b8

SET_B7b8:
        SET r30.t15
        JMP DEL_B7b8

BCK_B7b8:
		JMP BCK_B6b8

DEL_B7b8:
        ADD r0, r0, 1
        QBNE DEL_B7b8, r0, r1

CLC_B8b1:
        MOV r0, 0
        LSR r4, r9, 7
        AND r4, r4, 1
        QBEQ SET_B8b1, r4, 1

CLR_B8b1:
        CLR r30.t15
        JMP DEL_B8b1

SET_B8b1:
        SET r30.t15
        JMP DEL_B8b1

DEL_B8b1:
        ADD r0, r0, 1
        QBNE DEL_B8b1, r0, r1

CLC_B8b2:
        MOV r0, 0
        LSR r4, r9, 6
        AND r4, r4, 1
        QBEQ SET_B8b2, r4, 1

CLR_B8b2:
        CLR r30.t15
        JMP DEL_B8b2

SET_B8b2:
        SET r30.t15
        JMP DEL_B8b2

DEL_B8b2:
        ADD r0, r0, 1
        QBNE DEL_B8b2, r0, r1

CLC_B8b3:
        MOV r0, 0
        LSR r4, r9, 5
        AND r4, r4, 1
        QBEQ SET_B8b3, r4, 1

CLR_B8b3:
        CLR r30.t15
        JMP DEL_B8b3

SET_B8b3:
        SET r30.t15
        JMP DEL_B8b3

DEL_B8b3:
        ADD r0, r0, 1
        QBNE DEL_B8b3, r0, r1

CLC_B8b4:
        MOV r0, 0
        LSR r4, r9, 4
        AND r4, r4, 1
        QBEQ SET_B8b4, r4, 1

CLR_B8b4:
        CLR r30.t15
        JMP DEL_B8b4

SET_B8b4:
        SET r30.t15
        JMP DEL_B8b4

DEL_B8b4:
        ADD r0, r0, 1
        QBNE DEL_B8b4, r0, r1

CLC_B8b5:
        MOV r0, 0
        LSR r4, r9, 3
        AND r4, r4, 1
        QBEQ SET_B8b5, r4, 1

CLR_B8b5:
        CLR r30.t15
        JMP DEL_B8b5

SET_B8b5:
        SET r30.t15
        JMP DEL_B8b5

DEL_B8b5:
        ADD r0, r0, 1
        QBNE DEL_B8b5, r0, r1

CLC_B8b6:
        MOV r0, 0
        LSR r4, r9, 2
        AND r4, r4, 1
        QBEQ SET_B8b6, r4, 1

CLR_B8b6:
        CLR r30.t15
        JMP DEL_B8b6

SET_B8b6:
        SET r30.t15
        JMP DEL_B8b6

DEL_B8b6:
        ADD r0, r0, 1
        QBNE DEL_B8b6, r0, r1

CLC_B8b7:
        MOV r0, 0
        LSR r4, r9, 1
        AND r4, r4, 1
        QBEQ SET_B8b7, r4, 1

CLR_B8b7:
        CLR r30.t15
        JMP DEL_B8b7

SET_B8b7:
        SET r30.t15
        JMP DEL_B8b7

DEL_B8b7:
        ADD r0, r0, 1
        QBNE DEL_B8b7, r0, r1

CLC_B8b8:
        MOV r0, 0
        LSR r4, r9, 0
        AND r4, r4, 1
        QBEQ SET_B8b8, r4, 1

CLR_B8b8:
        CLR r30.t15
        JMP DEL_B8b8

SET_B8b8:
        SET r30.t15
        JMP DEL_B8b8

BCK_B8b8:
		JMP BCK_B7b8

DEL_B8b8:
        ADD r0, r0, 1
        QBNE DEL_B8b8, r0, r1

CLC_B9b1:
        MOV r0, 0
        LSR r4, r10, 31
        AND r4, r4, 1
        QBEQ SET_B9b1, r4, 1

CLR_B9b1:
        CLR r30.t15
        JMP DEL_B9b1

SET_B9b1:
        SET r30.t15
        JMP DEL_B9b1

DEL_B9b1:
        ADD r0, r0, 1
        QBNE DEL_B9b1, r0, r1

CLC_B9b2:
        MOV r0, 0
        LSR r4, r10, 30
        AND r4, r4, 1
        QBEQ SET_B9b2, r4, 1

CLR_B9b2:
        CLR r30.t15
        JMP DEL_B9b2

SET_B9b2:
        SET r30.t15
        JMP DEL_B9b2

DEL_B9b2:
        ADD r0, r0, 1
        QBNE DEL_B9b2, r0, r1

CLC_B9b3:
        MOV r0, 0
        LSR r4, r10, 29
        AND r4, r4, 1
        QBEQ SET_B9b3, r4, 1

CLR_B9b3:
        CLR r30.t15
        JMP DEL_B9b3

SET_B9b3:
        SET r30.t15
        JMP DEL_B9b3

DEL_B9b3:
        ADD r0, r0, 1
        QBNE DEL_B9b3, r0, r1

CLC_B9b4:
        MOV r0, 0
        LSR r4, r10, 28
        AND r4, r4, 1
        QBEQ SET_B9b4, r4, 1

CLR_B9b4:
        CLR r30.t15
        JMP DEL_B9b4

SET_B9b4:
        SET r30.t15
        JMP DEL_B9b4

DEL_B9b4:
        ADD r0, r0, 1
        QBNE DEL_B9b4, r0, r1

CLC_B9b5:
        MOV r0, 0
        LSR r4, r10, 27
        AND r4, r4, 1
        QBEQ SET_B9b5, r4, 1

CLR_B9b5:
        CLR r30.t15
        JMP DEL_B9b5

SET_B9b5:
        SET r30.t15
        JMP DEL_B9b5

DEL_B9b5:
        ADD r0, r0, 1
        QBNE DEL_B9b5, r0, r1

CLC_B9b6:
        MOV r0, 0
        LSR r4, r10, 26
        AND r4, r4, 1
        QBEQ SET_B9b6, r4, 1

CLR_B9b6:
        CLR r30.t15
        JMP DEL_B9b6

SET_B9b6:
        SET r30.t15
        JMP DEL_B9b6

DEL_B9b6:
        ADD r0, r0, 1
        QBNE DEL_B9b6, r0, r1

CLC_B9b7:
        MOV r0, 0
        LSR r4, r10, 25
        AND r4, r4, 1
        QBEQ SET_B9b7, r4, 1

CLR_B9b7:
        CLR r30.t15
        JMP DEL_B9b7

SET_B9b7:
        SET r30.t15
        JMP DEL_B9b7

DEL_B9b7:
        ADD r0, r0, 1
        QBNE DEL_B9b7, r0, r1

CLC_B9b8:
        MOV r0, 0
        LSR r4, r10, 24
        AND r4, r4, 1
        QBEQ SET_B9b8, r4, 1

CLR_B9b8:
        CLR r30.t15
        JMP DEL_B9b8

SET_B9b8:
        SET r30.t15
        JMP DEL_B9b8

BCK_B9b8:
		JMP BCK_B8b8

DEL_B9b8:
        ADD r0, r0, 1
        QBNE DEL_B9b8, r0, r1

CLC_B10b1:
        MOV r0, 0
        LSR r4, r10, 23
        AND r4, r4, 1
        QBEQ SET_B10b1, r4, 1

CLR_B10b1:
        CLR r30.t15
        JMP DEL_B10b1

SET_B10b1:
        SET r30.t15
        JMP DEL_B10b1

DEL_B10b1:
        ADD r0, r0, 1
        QBNE DEL_B10b1, r0, r1

CLC_B10b2:
        MOV r0, 0
        LSR r4, r10, 22
        AND r4, r4, 1
        QBEQ SET_B10b2, r4, 1

CLR_B10b2:
        CLR r30.t15
        JMP DEL_B10b2

SET_B10b2:
        SET r30.t15
        JMP DEL_B10b2

DEL_B10b2:
        ADD r0, r0, 1
        QBNE DEL_B10b2, r0, r1

CLC_B10b3:
        MOV r0, 0
        LSR r4, r10, 21
        AND r4, r4, 1
        QBEQ SET_B10b3, r4, 1

CLR_B10b3:
        CLR r30.t15
        JMP DEL_B10b3

SET_B10b3:
        SET r30.t15
        JMP DEL_B10b3

DEL_B10b3:
        ADD r0, r0, 1
        QBNE DEL_B10b3, r0, r1

CLC_B10b4:
        MOV r0, 0
        LSR r4, r10, 20
        AND r4, r4, 1
        QBEQ SET_B10b4, r4, 1

CLR_B10b4:
        CLR r30.t15
        JMP DEL_B10b4

SET_B10b4:
        SET r30.t15
        JMP DEL_B10b4

DEL_B10b4:
        ADD r0, r0, 1
        QBNE DEL_B10b4, r0, r1

CLC_B10b5:
        MOV r0, 0
        LSR r4, r10, 19
        AND r4, r4, 1
        QBEQ SET_B10b5, r4, 1

CLR_B10b5:
        CLR r30.t15
        JMP DEL_B10b5

SET_B10b5:
        SET r30.t15
        JMP DEL_B10b5

DEL_B10b5:
        ADD r0, r0, 1
        QBNE DEL_B10b5, r0, r1

CLC_B10b6:
        MOV r0, 0
        LSR r4, r10, 18
        AND r4, r4, 1
        QBEQ SET_B10b6, r4, 1

CLR_B10b6:
        CLR r30.t15
        JMP DEL_B10b6

SET_B10b6:
        SET r30.t15
        JMP DEL_B10b6

DEL_B10b6:
        ADD r0, r0, 1
        QBNE DEL_B10b6, r0, r1

CLC_B10b7:
        MOV r0, 0
        LSR r4, r10, 17
        AND r4, r4, 1
        QBEQ SET_B10b7, r4, 1

CLR_B10b7:
        CLR r30.t15
        JMP DEL_B10b7

SET_B10b7:
        SET r30.t15
        JMP DEL_B10b7

DEL_B10b7:
        ADD r0, r0, 1
        QBNE DEL_B10b7, r0, r1

CLC_B10b8:
        MOV r0, 0
        LSR r4, r10, 16
        AND r4, r4, 1
        QBEQ SET_B10b8, r4, 1

CLR_B10b8:
        CLR r30.t15
        JMP DEL_B10b8

SET_B10b8:
        SET r30.t15
        JMP DEL_B10b8

BCK_B10b8:
		JMP BCK_B9b8

DEL_B10b8:
        ADD r0, r0, 1
        QBNE DEL_B10b8, r0, r1

CLC_B11b1:
        MOV r0, 0
        LSR r4, r10, 15
        AND r4, r4, 1
        QBEQ SET_B11b1, r4, 1

CLR_B11b1:
        CLR r30.t15
        JMP DEL_B11b1

SET_B11b1:
        SET r30.t15
        JMP DEL_B11b1

DEL_B11b1:
        ADD r0, r0, 1
        QBNE DEL_B11b1, r0, r1

CLC_B11b2:
        MOV r0, 0
        LSR r4, r10, 14
        AND r4, r4, 1
        QBEQ SET_B11b2, r4, 1

CLR_B11b2:
        CLR r30.t15
        JMP DEL_B11b2

SET_B11b2:
        SET r30.t15
        JMP DEL_B11b2

DEL_B11b2:
        ADD r0, r0, 1
        QBNE DEL_B11b2, r0, r1

CLC_B11b3:
        MOV r0, 0
        LSR r4, r10, 13
        AND r4, r4, 1
        QBEQ SET_B11b3, r4, 1

CLR_B11b3:
        CLR r30.t15
        JMP DEL_B11b3

SET_B11b3:
        SET r30.t15
        JMP DEL_B11b3

DEL_B11b3:
        ADD r0, r0, 1
        QBNE DEL_B11b3, r0, r1

CLC_B11b4:
        MOV r0, 0
        LSR r4, r10, 12
        AND r4, r4, 1
        QBEQ SET_B11b4, r4, 1

CLR_B11b4:
        CLR r30.t15
        JMP DEL_B11b4

SET_B11b4:
        SET r30.t15
        JMP DEL_B11b4

DEL_B11b4:
        ADD r0, r0, 1
        QBNE DEL_B11b4, r0, r1

CLC_B11b5:
        MOV r0, 0
        LSR r4, r10, 11
        AND r4, r4, 1
        QBEQ SET_B11b5, r4, 1

CLR_B11b5:
        CLR r30.t15
        JMP DEL_B11b5

SET_B11b5:
        SET r30.t15
        JMP DEL_B11b5

DEL_B11b5:
        ADD r0, r0, 1
        QBNE DEL_B11b5, r0, r1

CLC_B11b6:
        MOV r0, 0
        LSR r4, r10, 10
        AND r4, r4, 1
        QBEQ SET_B11b6, r4, 1

CLR_B11b6:
        CLR r30.t15
        JMP DEL_B11b6

SET_B11b6:
        SET r30.t15
        JMP DEL_B11b6

DEL_B11b6:
        ADD r0, r0, 1
        QBNE DEL_B11b6, r0, r1

CLC_B11b7:
        MOV r0, 0
        LSR r4, r10, 9
        AND r4, r4, 1
        QBEQ SET_B11b7, r4, 1

CLR_B11b7:
        CLR r30.t15
        JMP DEL_B11b7

SET_B11b7:
        SET r30.t15
        JMP DEL_B11b7

DEL_B11b7:
        ADD r0, r0, 1
        QBNE DEL_B11b7, r0, r1

CLC_B11b8:
        MOV r0, 0
        LSR r4, r10, 8
        AND r4, r4, 1
        QBEQ SET_B11b8, r4, 1

CLR_B11b8:
        CLR r30.t15
        JMP DEL_B11b8

SET_B11b8:
        SET r30.t15
        JMP DEL_B11b8

BCK_B11b8:
		JMP BCK_B10b8

DEL_B11b8:
        ADD r0, r0, 1
        QBNE DEL_B11b8, r0, r1

CLC_B12b1:
        MOV r0, 0
        LSR r4, r10, 7
        AND r4, r4, 1
        QBEQ SET_B12b1, r4, 1

CLR_B12b1:
        CLR r30.t15
        JMP DEL_B12b1

SET_B12b1:
        SET r30.t15
        JMP DEL_B12b1

DEL_B12b1:
        ADD r0, r0, 1
        QBNE DEL_B12b1, r0, r1

CLC_B12b2:
        MOV r0, 0
        LSR r4, r10, 6
        AND r4, r4, 1
        QBEQ SET_B12b2, r4, 1

CLR_B12b2:
        CLR r30.t15
        JMP DEL_B12b2

SET_B12b2:
        SET r30.t15
        JMP DEL_B12b2

DEL_B12b2:
        ADD r0, r0, 1
        QBNE DEL_B12b2, r0, r1

CLC_B12b3:
        MOV r0, 0
        LSR r4, r10, 5
        AND r4, r4, 1
        QBEQ SET_B12b3, r4, 1

CLR_B12b3:
        CLR r30.t15
        JMP DEL_B12b3

SET_B12b3:
        SET r30.t15
        JMP DEL_B12b3

DEL_B12b3:
        ADD r0, r0, 1
        QBNE DEL_B12b3, r0, r1

CLC_B12b4:
        MOV r0, 0
        LSR r4, r10, 4
        AND r4, r4, 1
        QBEQ SET_B12b4, r4, 1

CLR_B12b4:
        CLR r30.t15
        JMP DEL_B12b4

SET_B12b4:
        SET r30.t15
        JMP DEL_B12b4

DEL_B12b4:
        ADD r0, r0, 1
        QBNE DEL_B12b4, r0, r1

CLC_B12b5:
        MOV r0, 0
        LSR r4, r10, 3
        AND r4, r4, 1
        QBEQ SET_B12b5, r4, 1

CLR_B12b5:
        CLR r30.t15
        JMP DEL_B12b5

SET_B12b5:
        SET r30.t15
        JMP DEL_B12b5

DEL_B12b5:
        ADD r0, r0, 1
        QBNE DEL_B12b5, r0, r1

CLC_B12b6:
        MOV r0, 0
        LSR r4, r10, 2
        AND r4, r4, 1
        QBEQ SET_B12b6, r4, 1

CLR_B12b6:
        CLR r30.t15
        JMP DEL_B12b6

SET_B12b6:
        SET r30.t15
        JMP DEL_B12b6

DEL_B12b6:
        ADD r0, r0, 1
        QBNE DEL_B12b6, r0, r1

CLC_B12b7:
        MOV r0, 0
        LSR r4, r10, 1
        AND r4, r4, 1
        QBEQ SET_B12b7, r4, 1

CLR_B12b7:
        CLR r30.t15
        JMP DEL_B12b7

SET_B12b7:
        SET r30.t15
        JMP DEL_B12b7

DEL_B12b7:
        ADD r0, r0, 1
        QBNE DEL_B12b7, r0, r1

CLC_B12b8:
        MOV r0, 0
        LSR r4, r10, 0
        AND r4, r4, 1
        QBEQ SET_B12b8, r4, 1

CLR_B12b8:
        CLR r30.t15
        JMP DEL_B12b8

SET_B12b8:
        SET r30.t15
        JMP DEL_B12b8

BCK_B12b8:
		JMP BCK_B11b8

DEL_B12b8:
        ADD r0, r0, 1
        QBNE DEL_B12b8, r0, r1

CLC_B13b1:
        MOV r0, 0
        LSR r4, r11, 31
        AND r4, r4, 1
        QBEQ SET_B13b1, r4, 1

CLR_B13b1:
        CLR r30.t15
        JMP DEL_B13b1

SET_B13b1:
        SET r30.t15
        JMP DEL_B13b1

DEL_B13b1:
        ADD r0, r0, 1
        QBNE DEL_B13b1, r0, r1

CLC_B13b2:
        MOV r0, 0
        LSR r4, r11, 30
        AND r4, r4, 1
        QBEQ SET_B13b2, r4, 1

CLR_B13b2:
        CLR r30.t15
        JMP DEL_B13b2

SET_B13b2:
        SET r30.t15
        JMP DEL_B13b2

DEL_B13b2:
        ADD r0, r0, 1
        QBNE DEL_B13b2, r0, r1

CLC_B13b3:
        MOV r0, 0
        LSR r4, r11, 29
        AND r4, r4, 1
        QBEQ SET_B13b3, r4, 1

CLR_B13b3:
        CLR r30.t15
        JMP DEL_B13b3

SET_B13b3:
        SET r30.t15
        JMP DEL_B13b3

DEL_B13b3:
        ADD r0, r0, 1
        QBNE DEL_B13b3, r0, r1

CLC_B13b4:
        MOV r0, 0
        LSR r4, r11, 28
        AND r4, r4, 1
        QBEQ SET_B13b4, r4, 1

CLR_B13b4:
        CLR r30.t15
        JMP DEL_B13b4

SET_B13b4:
        SET r30.t15
        JMP DEL_B13b4

DEL_B13b4:
        ADD r0, r0, 1
        QBNE DEL_B13b4, r0, r1

CLC_B13b5:
        MOV r0, 0
        LSR r4, r11, 27
        AND r4, r4, 1
        QBEQ SET_B13b5, r4, 1

CLR_B13b5:
        CLR r30.t15
        JMP DEL_B13b5

SET_B13b5:
        SET r30.t15
        JMP DEL_B13b5

DEL_B13b5:
        ADD r0, r0, 1
        QBNE DEL_B13b5, r0, r1

CLC_B13b6:
        MOV r0, 0
        LSR r4, r11, 26
        AND r4, r4, 1
        QBEQ SET_B13b6, r4, 1

CLR_B13b6:
        CLR r30.t15
        JMP DEL_B13b6

SET_B13b6:
        SET r30.t15
        JMP DEL_B13b6

DEL_B13b6:
        ADD r0, r0, 1
        QBNE DEL_B13b6, r0, r1

CLC_B13b7:
        MOV r0, 0
        LSR r4, r11, 25
        AND r4, r4, 1
        QBEQ SET_B13b7, r4, 1

CLR_B13b7:
        CLR r30.t15
        JMP DEL_B13b7

SET_B13b7:
        SET r30.t15
        JMP DEL_B13b7

DEL_B13b7:
        ADD r0, r0, 1
        QBNE DEL_B13b7, r0, r1

CLC_B13b8:
        MOV r0, 0
        LSR r4, r11, 24
        AND r4, r4, 1
        QBEQ SET_B13b8, r4, 1

CLR_B13b8:
        CLR r30.t15
        JMP DEL_B13b8

SET_B13b8:
        SET r30.t15
        JMP DEL_B13b8

BCK_B13b8:
		JMP BCK_B12b8

DEL_B13b8:
        ADD r0, r0, 1
        QBNE DEL_B13b8, r0, r1

CLC_B14b1:
        MOV r0, 0
        LSR r4, r11, 23
        AND r4, r4, 1
        QBEQ SET_B14b1, r4, 1

CLR_B14b1:
        CLR r30.t15
        JMP DEL_B14b1

SET_B14b1:
        SET r30.t15
        JMP DEL_B14b1

DEL_B14b1:
        ADD r0, r0, 1
        QBNE DEL_B14b1, r0, r1

CLC_B14b2:
        MOV r0, 0
        LSR r4, r11, 22
        AND r4, r4, 1
        QBEQ SET_B14b2, r4, 1

CLR_B14b2:
        CLR r30.t15
        JMP DEL_B14b2

SET_B14b2:
        SET r30.t15
        JMP DEL_B14b2

DEL_B14b2:
        ADD r0, r0, 1
        QBNE DEL_B14b2, r0, r1

CLC_B14b3:
        MOV r0, 0
        LSR r4, r11, 21
        AND r4, r4, 1
        QBEQ SET_B14b3, r4, 1

CLR_B14b3:
        CLR r30.t15
        JMP DEL_B14b3

SET_B14b3:
        SET r30.t15
        JMP DEL_B14b3

DEL_B14b3:
        ADD r0, r0, 1
        QBNE DEL_B14b3, r0, r1

CLC_B14b4:
        MOV r0, 0
        LSR r4, r11, 20
        AND r4, r4, 1
        QBEQ SET_B14b4, r4, 1

CLR_B14b4:
        CLR r30.t15
        JMP DEL_B14b4

SET_B14b4:
        SET r30.t15
        JMP DEL_B14b4

DEL_B14b4:
        ADD r0, r0, 1
        QBNE DEL_B14b4, r0, r1

CLC_B14b5:
        MOV r0, 0
        LSR r4, r11, 19
        AND r4, r4, 1
        QBEQ SET_B14b5, r4, 1

CLR_B14b5:
        CLR r30.t15
        JMP DEL_B14b5

SET_B14b5:
        SET r30.t15
        JMP DEL_B14b5

DEL_B14b5:
        ADD r0, r0, 1
        QBNE DEL_B14b5, r0, r1

CLC_B14b6:
        MOV r0, 0
        LSR r4, r11, 18
        AND r4, r4, 1
        QBEQ SET_B14b6, r4, 1

CLR_B14b6:
        CLR r30.t15
        JMP DEL_B14b6

SET_B14b6:
        SET r30.t15
        JMP DEL_B14b6

DEL_B14b6:
        ADD r0, r0, 1
        QBNE DEL_B14b6, r0, r1

CLC_B14b7:
        MOV r0, 0
        LSR r4, r11, 17
        AND r4, r4, 1
        QBEQ SET_B14b7, r4, 1

CLR_B14b7:
        CLR r30.t15
        JMP DEL_B14b7

SET_B14b7:
        SET r30.t15
        JMP DEL_B14b7

DEL_B14b7:
        ADD r0, r0, 1
        QBNE DEL_B14b7, r0, r1

CLC_B14b8:
        MOV r0, 0
        LSR r4, r11, 16
        AND r4, r4, 1
        QBEQ SET_B14b8, r4, 1

CLR_B14b8:
        CLR r30.t15
        JMP DEL_B14b8

SET_B14b8:
        SET r30.t15
        JMP DEL_B14b8

BCK_B14b8:
		JMP BCK_B13b8

DEL_B14b8:
        ADD r0, r0, 1
        QBNE DEL_B14b8, r0, r1

CLC_B15b1:
        MOV r0, 0
        LSR r4, r11, 15
        AND r4, r4, 1
        QBEQ SET_B15b1, r4, 1

CLR_B15b1:
        CLR r30.t15
        JMP DEL_B15b1

SET_B15b1:
        SET r30.t15
        JMP DEL_B15b1

DEL_B15b1:
        ADD r0, r0, 1
        QBNE DEL_B15b1, r0, r1

CLC_B15b2:
        MOV r0, 0
        LSR r4, r11, 14
        AND r4, r4, 1
        QBEQ SET_B15b2, r4, 1

CLR_B15b2:
        CLR r30.t15
        JMP DEL_B15b2

SET_B15b2:
        SET r30.t15
        JMP DEL_B15b2

DEL_B15b2:
        ADD r0, r0, 1
        QBNE DEL_B15b2, r0, r1

CLC_B15b3:
        MOV r0, 0
        LSR r4, r11, 13
        AND r4, r4, 1
        QBEQ SET_B15b3, r4, 1

CLR_B15b3:
        CLR r30.t15
        JMP DEL_B15b3

SET_B15b3:
        SET r30.t15
        JMP DEL_B15b3

DEL_B15b3:
        ADD r0, r0, 1
        QBNE DEL_B15b3, r0, r1

CLC_B15b4:
        MOV r0, 0
        LSR r4, r11, 12
        AND r4, r4, 1
        QBEQ SET_B15b4, r4, 1

CLR_B15b4:
        CLR r30.t15
        JMP DEL_B15b4

SET_B15b4:
        SET r30.t15
        JMP DEL_B15b4

DEL_B15b4:
        ADD r0, r0, 1
        QBNE DEL_B15b4, r0, r1

CLC_B15b5:
        MOV r0, 0
        LSR r4, r11, 11
        AND r4, r4, 1
        QBEQ SET_B15b5, r4, 1

CLR_B15b5:
        CLR r30.t15
        JMP DEL_B15b5

SET_B15b5:
        SET r30.t15
        JMP DEL_B15b5

DEL_B15b5:
        ADD r0, r0, 1
        QBNE DEL_B15b5, r0, r1

CLC_B15b6:
        MOV r0, 0
        LSR r4, r11, 10
        AND r4, r4, 1
        QBEQ SET_B15b6, r4, 1

CLR_B15b6:
        CLR r30.t15
        JMP DEL_B15b6

SET_B15b6:
        SET r30.t15
        JMP DEL_B15b6

DEL_B15b6:
        ADD r0, r0, 1
        QBNE DEL_B15b6, r0, r1

CLC_B15b7:
        MOV r0, 0
        LSR r4, r11, 9
        AND r4, r4, 1
        QBEQ SET_B15b7, r4, 1

CLR_B15b7:
        CLR r30.t15
        JMP DEL_B15b7

SET_B15b7:
        SET r30.t15
        JMP DEL_B15b7

DEL_B15b7:
        ADD r0, r0, 1
        QBNE DEL_B15b7, r0, r1

CLC_B15b8:
        MOV r0, 0
        LSR r4, r11, 8
        AND r4, r4, 1
        QBEQ SET_B15b8, r4, 1

CLR_B15b8:
        CLR r30.t15
        JMP DEL_B15b8

SET_B15b8:
        SET r30.t15
        JMP DEL_B15b8

BCK_B15b8:
		JMP BCK_B14b8

DEL_B15b8:
        ADD r0, r0, 1
        QBNE DEL_B15b8, r0, r1

CLC_B16b1:
        MOV r0, 0
        LSR r4, r11, 7
        AND r4, r4, 1
        QBEQ SET_B16b1, r4, 1

CLR_B16b1:
        CLR r30.t15
        JMP DEL_B16b1

SET_B16b1:
        SET r30.t15
        JMP DEL_B16b1

DEL_B16b1:
        ADD r0, r0, 1
        QBNE DEL_B16b1, r0, r1

CLC_B16b2:
        MOV r0, 0
        LSR r4, r11, 6
        AND r4, r4, 1
        QBEQ SET_B16b2, r4, 1

CLR_B16b2:
        CLR r30.t15
        JMP DEL_B16b2

SET_B16b2:
        SET r30.t15
        JMP DEL_B16b2

DEL_B16b2:
        ADD r0, r0, 1
        QBNE DEL_B16b2, r0, r1

CLC_B16b3:
        MOV r0, 0
        LSR r4, r11, 5
        AND r4, r4, 1
        QBEQ SET_B16b3, r4, 1

CLR_B16b3:
        CLR r30.t15
        JMP DEL_B16b3

SET_B16b3:
        SET r30.t15
        JMP DEL_B16b3

DEL_B16b3:
        ADD r0, r0, 1
        QBNE DEL_B16b3, r0, r1

CLC_B16b4:
        MOV r0, 0
        LSR r4, r11, 4
        AND r4, r4, 1
        QBEQ SET_B16b4, r4, 1

CLR_B16b4:
        CLR r30.t15
        JMP DEL_B16b4

SET_B16b4:
        SET r30.t15
        JMP DEL_B16b4

DEL_B16b4:
        ADD r0, r0, 1
        QBNE DEL_B16b4, r0, r1

CLC_B16b5:
        MOV r0, 0
        LSR r4, r11, 3
        AND r4, r4, 1
        QBEQ SET_B16b5, r4, 1

CLR_B16b5:
        CLR r30.t15
        JMP DEL_B16b5

SET_B16b5:
        SET r30.t15
        JMP DEL_B16b5

DEL_B16b5:
        ADD r0, r0, 1
        QBNE DEL_B16b5, r0, r1

CLC_B16b6:
        MOV r0, 0
        LSR r4, r11, 2
        AND r4, r4, 1
        QBEQ SET_B16b6, r4, 1

CLR_B16b6:
        CLR r30.t15
        JMP DEL_B16b6

SET_B16b6:
        SET r30.t15
        JMP DEL_B16b6

DEL_B16b6:
        ADD r0, r0, 1
        QBNE DEL_B16b6, r0, r1

CLC_B16b7:
        MOV r0, 0
        LSR r4, r11, 1
        AND r4, r4, 1
        QBEQ SET_B16b7, r4, 1

CLR_B16b7:
        CLR r30.t15
        JMP DEL_B16b7

SET_B16b7:
        SET r30.t15
        JMP DEL_B16b7

DEL_B16b7:
        ADD r0, r0, 1
        QBNE DEL_B16b7, r0, r1

CLC_B16b8:
        MOV r0, 0
        LSR r4, r11, 0
        AND r4, r4, 1
        QBEQ SET_B16b8, r4, 1

CLR_B16b8:
        CLR r30.t15
        JMP DEL_B16b8

SET_B16b8:
        SET r30.t15
        JMP DEL_B16b8

BCK_B16b8:
		JMP BCK_B15b8

DEL_B16b8:
        ADD r0, r0, 1
        QBNE DEL_B16b8, r0, r1

CLC_B17b1:
        MOV r0, 0
        LSR r4, r12, 31
        AND r4, r4, 1
        QBEQ SET_B17b1, r4, 1

CLR_B17b1:
        CLR r30.t15
        JMP DEL_B17b1

SET_B17b1:
        SET r30.t15
        JMP DEL_B17b1

DEL_B17b1:
        ADD r0, r0, 1
        QBNE DEL_B17b1, r0, r1

CLC_B17b2:
        MOV r0, 0
        LSR r4, r12, 30
        AND r4, r4, 1
        QBEQ SET_B17b2, r4, 1

CLR_B17b2:
        CLR r30.t15
        JMP DEL_B17b2

SET_B17b2:
        SET r30.t15
        JMP DEL_B17b2

DEL_B17b2:
        ADD r0, r0, 1
        QBNE DEL_B17b2, r0, r1

CLC_B17b3:
        MOV r0, 0
        LSR r4, r12, 29
        AND r4, r4, 1
        QBEQ SET_B17b3, r4, 1

CLR_B17b3:
        CLR r30.t15
        JMP DEL_B17b3

SET_B17b3:
        SET r30.t15
        JMP DEL_B17b3

DEL_B17b3:
        ADD r0, r0, 1
        QBNE DEL_B17b3, r0, r1

CLC_B17b4:
        MOV r0, 0
        LSR r4, r12, 28
        AND r4, r4, 1
        QBEQ SET_B17b4, r4, 1

CLR_B17b4:
        CLR r30.t15
        JMP DEL_B17b4

SET_B17b4:
        SET r30.t15
        JMP DEL_B17b4

DEL_B17b4:
        ADD r0, r0, 1
        QBNE DEL_B17b4, r0, r1

CLC_B17b5:
        MOV r0, 0
        LSR r4, r12, 27
        AND r4, r4, 1
        QBEQ SET_B17b5, r4, 1

CLR_B17b5:
        CLR r30.t15
        JMP DEL_B17b5

SET_B17b5:
        SET r30.t15
        JMP DEL_B17b5

DEL_B17b5:
        ADD r0, r0, 1
        QBNE DEL_B17b5, r0, r1

CLC_B17b6:
        MOV r0, 0
        LSR r4, r12, 26
        AND r4, r4, 1
        QBEQ SET_B17b6, r4, 1

CLR_B17b6:
        CLR r30.t15
        JMP DEL_B17b6

SET_B17b6:
        SET r30.t15
        JMP DEL_B17b6

DEL_B17b6:
        ADD r0, r0, 1
        QBNE DEL_B17b6, r0, r1

CLC_B17b7:
        MOV r0, 0
        LSR r4, r12, 25
        AND r4, r4, 1
        QBEQ SET_B17b7, r4, 1

CLR_B17b7:
        CLR r30.t15
        JMP DEL_B17b7

SET_B17b7:
        SET r30.t15
        JMP DEL_B17b7

DEL_B17b7:
        ADD r0, r0, 1
        QBNE DEL_B17b7, r0, r1

CLC_B17b8:
        MOV r0, 0
        LSR r4, r12, 24
        AND r4, r4, 1
        QBEQ SET_B17b8, r4, 1

CLR_B17b8:
        CLR r30.t15
        JMP DEL_B17b8

SET_B17b8:
        SET r30.t15
        JMP DEL_B17b8

BCK_B17b8:
		JMP BCK_B16b8

DEL_B17b8:
        ADD r0, r0, 1
        QBNE DEL_B17b8, r0, r1

CLC_B18b1:
        MOV r0, 0
        LSR r4, r12, 23
        AND r4, r4, 1
        QBEQ SET_B18b1, r4, 1

CLR_B18b1:
        CLR r30.t15
        JMP DEL_B18b1

SET_B18b1:
        SET r30.t15
        JMP DEL_B18b1

DEL_B18b1:
        ADD r0, r0, 1
        QBNE DEL_B18b1, r0, r1

CLC_B18b2:
        MOV r0, 0
        LSR r4, r12, 22
        AND r4, r4, 1
        QBEQ SET_B18b2, r4, 1

CLR_B18b2:
        CLR r30.t15
        JMP DEL_B18b2

SET_B18b2:
        SET r30.t15
        JMP DEL_B18b2

DEL_B18b2:
        ADD r0, r0, 1
        QBNE DEL_B18b2, r0, r1

CLC_B18b3:
        MOV r0, 0
        LSR r4, r12, 21
        AND r4, r4, 1
        QBEQ SET_B18b3, r4, 1

CLR_B18b3:
        CLR r30.t15
        JMP DEL_B18b3

SET_B18b3:
        SET r30.t15
        JMP DEL_B18b3

DEL_B18b3:
        ADD r0, r0, 1
        QBNE DEL_B18b3, r0, r1

CLC_B18b4:
        MOV r0, 0
        LSR r4, r12, 20
        AND r4, r4, 1
        QBEQ SET_B18b4, r4, 1

CLR_B18b4:
        CLR r30.t15
        JMP DEL_B18b4

SET_B18b4:
        SET r30.t15
        JMP DEL_B18b4

DEL_B18b4:
        ADD r0, r0, 1
        QBNE DEL_B18b4, r0, r1

CLC_B18b5:
        MOV r0, 0
        LSR r4, r12, 19
        AND r4, r4, 1
        QBEQ SET_B18b5, r4, 1

CLR_B18b5:
        CLR r30.t15
        JMP DEL_B18b5

SET_B18b5:
        SET r30.t15
        JMP DEL_B18b5

DEL_B18b5:
        ADD r0, r0, 1
        QBNE DEL_B18b5, r0, r1

CLC_B18b6:
        MOV r0, 0
        LSR r4, r12, 18
        AND r4, r4, 1
        QBEQ SET_B18b6, r4, 1

CLR_B18b6:
        CLR r30.t15
        JMP DEL_B18b6

SET_B18b6:
        SET r30.t15
        JMP DEL_B18b6

DEL_B18b6:
        ADD r0, r0, 1
        QBNE DEL_B18b6, r0, r1

CLC_B18b7:
        MOV r0, 0
        LSR r4, r12, 17
        AND r4, r4, 1
        QBEQ SET_B18b7, r4, 1

CLR_B18b7:
        CLR r30.t15
        JMP DEL_B18b7

SET_B18b7:
        SET r30.t15
        JMP DEL_B18b7

DEL_B18b7:
        ADD r0, r0, 1
        QBNE DEL_B18b7, r0, r1

CLC_B18b8:
        MOV r0, 0
        LSR r4, r12, 16
        AND r4, r4, 1
        QBEQ SET_B18b8, r4, 1

CLR_B18b8:
        CLR r30.t15
        JMP DEL_B18b8

SET_B18b8:
        SET r30.t15
        JMP DEL_B18b8

BCK_B18b8:
		JMP BCK_B17b8

DEL_B18b8:
        ADD r0, r0, 1
        QBNE DEL_B18b8, r0, r1

CLC_B19b1:
        MOV r0, 0
        LSR r4, r12, 15
        AND r4, r4, 1
        QBEQ SET_B19b1, r4, 1

CLR_B19b1:
        CLR r30.t15
        JMP DEL_B19b1

SET_B19b1:
        SET r30.t15
        JMP DEL_B19b1

DEL_B19b1:
        ADD r0, r0, 1
        QBNE DEL_B19b1, r0, r1

CLC_B19b2:
        MOV r0, 0
        LSR r4, r12, 14
        AND r4, r4, 1
        QBEQ SET_B19b2, r4, 1

CLR_B19b2:
        CLR r30.t15
        JMP DEL_B19b2

SET_B19b2:
        SET r30.t15
        JMP DEL_B19b2

DEL_B19b2:
        ADD r0, r0, 1
        QBNE DEL_B19b2, r0, r1

CLC_B19b3:
        MOV r0, 0
        LSR r4, r12, 13
        AND r4, r4, 1
        QBEQ SET_B19b3, r4, 1

CLR_B19b3:
        CLR r30.t15
        JMP DEL_B19b3

SET_B19b3:
        SET r30.t15
        JMP DEL_B19b3

DEL_B19b3:
        ADD r0, r0, 1
        QBNE DEL_B19b3, r0, r1

CLC_B19b4:
        MOV r0, 0
        LSR r4, r12, 12
        AND r4, r4, 1
        QBEQ SET_B19b4, r4, 1

CLR_B19b4:
        CLR r30.t15
        JMP DEL_B19b4

SET_B19b4:
        SET r30.t15
        JMP DEL_B19b4

DEL_B19b4:
        ADD r0, r0, 1
        QBNE DEL_B19b4, r0, r1

CLC_B19b5:
        MOV r0, 0
        LSR r4, r12, 11
        AND r4, r4, 1
        QBEQ SET_B19b5, r4, 1

CLR_B19b5:
        CLR r30.t15
        JMP DEL_B19b5

SET_B19b5:
        SET r30.t15
        JMP DEL_B19b5

DEL_B19b5:
        ADD r0, r0, 1
        QBNE DEL_B19b5, r0, r1

CLC_B19b6:
        MOV r0, 0
        LSR r4, r12, 10
        AND r4, r4, 1
        QBEQ SET_B19b6, r4, 1

CLR_B19b6:
        CLR r30.t15
        JMP DEL_B19b6

SET_B19b6:
        SET r30.t15
        JMP DEL_B19b6

DEL_B19b6:
        ADD r0, r0, 1
        QBNE DEL_B19b6, r0, r1

CLC_B19b7:
        MOV r0, 0
        LSR r4, r12, 9
        AND r4, r4, 1
        QBEQ SET_B19b7, r4, 1

CLR_B19b7:
        CLR r30.t15
        JMP DEL_B19b7

SET_B19b7:
        SET r30.t15
        JMP DEL_B19b7

DEL_B19b7:
        ADD r0, r0, 1
        QBNE DEL_B19b7, r0, r1

CLC_B19b8:
        MOV r0, 0
        LSR r4, r12, 8
        AND r4, r4, 1
        QBEQ SET_B19b8, r4, 1

CLR_B19b8:
        CLR r30.t15
        JMP DEL_B19b8

SET_B19b8:
        SET r30.t15
        JMP DEL_B19b8

BCK_B19b8:
		JMP BCK_B18b8

DEL_B19b8:
        ADD r0, r0, 1
        QBNE DEL_B19b8, r0, r1

CLC_B20b1:
        MOV r0, 0
        LSR r4, r12, 7
        AND r4, r4, 1
        QBEQ SET_B20b1, r4, 1

CLR_B20b1:
        CLR r30.t15
        JMP DEL_B20b1

SET_B20b1:
        SET r30.t15
        JMP DEL_B20b1

DEL_B20b1:
        ADD r0, r0, 1
        QBNE DEL_B20b1, r0, r1

CLC_B20b2:
        MOV r0, 0
        LSR r4, r12, 6
        AND r4, r4, 1
        QBEQ SET_B20b2, r4, 1

CLR_B20b2:
        CLR r30.t15
        JMP DEL_B20b2

SET_B20b2:
        SET r30.t15
        JMP DEL_B20b2

DEL_B20b2:
        ADD r0, r0, 1
        QBNE DEL_B20b2, r0, r1

CLC_B20b3:
        MOV r0, 0
        LSR r4, r12, 5
        AND r4, r4, 1
        QBEQ SET_B20b3, r4, 1

CLR_B20b3:
        CLR r30.t15
        JMP DEL_B20b3

SET_B20b3:
        SET r30.t15
        JMP DEL_B20b3

DEL_B20b3:
        ADD r0, r0, 1
        QBNE DEL_B20b3, r0, r1

CLC_B20b4:
        MOV r0, 0
        LSR r4, r12, 4
        AND r4, r4, 1
        QBEQ SET_B20b4, r4, 1

CLR_B20b4:
        CLR r30.t15
        JMP DEL_B20b4

SET_B20b4:
        SET r30.t15
        JMP DEL_B20b4

DEL_B20b4:
        ADD r0, r0, 1
        QBNE DEL_B20b4, r0, r1

CLC_B20b5:
        MOV r0, 0
        LSR r4, r12, 3
        AND r4, r4, 1
        QBEQ SET_B20b5, r4, 1

CLR_B20b5:
        CLR r30.t15
        JMP DEL_B20b5

SET_B20b5:
        SET r30.t15
        JMP DEL_B20b5

DEL_B20b5:
        ADD r0, r0, 1
        QBNE DEL_B20b5, r0, r1

CLC_B20b6:
        MOV r0, 0
        LSR r4, r12, 2
        AND r4, r4, 1
        QBEQ SET_B20b6, r4, 1

CLR_B20b6:
        CLR r30.t15
        JMP DEL_B20b6

SET_B20b6:
        SET r30.t15
        JMP DEL_B20b6

DEL_B20b6:
        ADD r0, r0, 1
        QBNE DEL_B20b6, r0, r1

CLC_B20b7:
        MOV r0, 0
        LSR r4, r12, 1
        AND r4, r4, 1
        QBEQ SET_B20b7, r4, 1

CLR_B20b7:
        CLR r30.t15
        JMP DEL_B20b7

SET_B20b7:
        SET r30.t15
        JMP DEL_B20b7

DEL_B20b7:
        ADD r0, r0, 1
        QBNE DEL_B20b7, r0, r1

CLC_B20b8:
        MOV r0, 0
        LSR r4, r12, 0
        AND r4, r4, 1
        QBEQ SET_B20b8, r4, 1

CLR_B20b8:
        CLR r30.t15
        JMP DEL_B20b8

SET_B20b8:
        SET r30.t15
        JMP DEL_B20b8

BCK_B20b8:
		JMP BCK_B19b8

DEL_B20b8:
        ADD r0, r0, 1
        QBNE DEL_B20b8, r0, r1

CLC_B21b1:
        MOV r0, 0
        LSR r4, r13, 31
        AND r4, r4, 1
        QBEQ SET_B21b1, r4, 1

CLR_B21b1:
        CLR r30.t15
        JMP DEL_B21b1

SET_B21b1:
        SET r30.t15
        JMP DEL_B21b1

DEL_B21b1:
        ADD r0, r0, 1
        QBNE DEL_B21b1, r0, r1

CLC_B21b2:
        MOV r0, 0
        LSR r4, r13, 30
        AND r4, r4, 1
        QBEQ SET_B21b2, r4, 1

CLR_B21b2:
        CLR r30.t15
        JMP DEL_B21b2

SET_B21b2:
        SET r30.t15
        JMP DEL_B21b2

DEL_B21b2:
        ADD r0, r0, 1
        QBNE DEL_B21b2, r0, r1

CLC_B21b3:
        MOV r0, 0
        LSR r4, r13, 29
        AND r4, r4, 1
        QBEQ SET_B21b3, r4, 1

CLR_B21b3:
        CLR r30.t15
        JMP DEL_B21b3

SET_B21b3:
        SET r30.t15
        JMP DEL_B21b3

DEL_B21b3:
        ADD r0, r0, 1
        QBNE DEL_B21b3, r0, r1

CLC_B21b4:
        MOV r0, 0
        LSR r4, r13, 28
        AND r4, r4, 1
        QBEQ SET_B21b4, r4, 1

CLR_B21b4:
        CLR r30.t15
        JMP DEL_B21b4

SET_B21b4:
        SET r30.t15
        JMP DEL_B21b4

DEL_B21b4:
        ADD r0, r0, 1
        QBNE DEL_B21b4, r0, r1

CLC_B21b5:
        MOV r0, 0
        LSR r4, r13, 27
        AND r4, r4, 1
        QBEQ SET_B21b5, r4, 1

CLR_B21b5:
        CLR r30.t15
        JMP DEL_B21b5

SET_B21b5:
        SET r30.t15
        JMP DEL_B21b5

DEL_B21b5:
        ADD r0, r0, 1
        QBNE DEL_B21b5, r0, r1

CLC_B21b6:
        MOV r0, 0
        LSR r4, r13, 26
        AND r4, r4, 1
        QBEQ SET_B21b6, r4, 1

CLR_B21b6:
        CLR r30.t15
        JMP DEL_B21b6

SET_B21b6:
        SET r30.t15
        JMP DEL_B21b6

DEL_B21b6:
        ADD r0, r0, 1
        QBNE DEL_B21b6, r0, r1

CLC_B21b7:
        MOV r0, 0
        LSR r4, r13, 25
        AND r4, r4, 1
        QBEQ SET_B21b7, r4, 1

CLR_B21b7:
        CLR r30.t15
        JMP DEL_B21b7

SET_B21b7:
        SET r30.t15
        JMP DEL_B21b7

DEL_B21b7:
        ADD r0, r0, 1
        QBNE DEL_B21b7, r0, r1

CLC_B21b8:
        MOV r0, 0
        LSR r4, r13, 24
        AND r4, r4, 1
        QBEQ SET_B21b8, r4, 1

CLR_B21b8:
        CLR r30.t15
        JMP DEL_B21b8

SET_B21b8:
        SET r30.t15
        JMP DEL_B21b8

BCK_B21b8:
		JMP BCK_B20b8

DEL_B21b8:
        ADD r0, r0, 1
        QBNE DEL_B21b8, r0, r1

CLC_B22b1:
        MOV r0, 0
        LSR r4, r13, 23
        AND r4, r4, 1
        QBEQ SET_B22b1, r4, 1

CLR_B22b1:
        CLR r30.t15
        JMP DEL_B22b1

SET_B22b1:
        SET r30.t15
        JMP DEL_B22b1

DEL_B22b1:
        ADD r0, r0, 1
        QBNE DEL_B22b1, r0, r1

CLC_B22b2:
        MOV r0, 0
        LSR r4, r13, 22
        AND r4, r4, 1
        QBEQ SET_B22b2, r4, 1

CLR_B22b2:
        CLR r30.t15
        JMP DEL_B22b2

SET_B22b2:
        SET r30.t15
        JMP DEL_B22b2

DEL_B22b2:
        ADD r0, r0, 1
        QBNE DEL_B22b2, r0, r1

CLC_B22b3:
        MOV r0, 0
        LSR r4, r13, 21
        AND r4, r4, 1
        QBEQ SET_B22b3, r4, 1

CLR_B22b3:
        CLR r30.t15
        JMP DEL_B22b3

SET_B22b3:
        SET r30.t15
        JMP DEL_B22b3

DEL_B22b3:
        ADD r0, r0, 1
        QBNE DEL_B22b3, r0, r1

CLC_B22b4:
        MOV r0, 0
        LSR r4, r13, 20
        AND r4, r4, 1
        QBEQ SET_B22b4, r4, 1

CLR_B22b4:
        CLR r30.t15
        JMP DEL_B22b4

SET_B22b4:
        SET r30.t15
        JMP DEL_B22b4

DEL_B22b4:
        ADD r0, r0, 1
        QBNE DEL_B22b4, r0, r1

CLC_B22b5:
        MOV r0, 0
        LSR r4, r13, 19
        AND r4, r4, 1
        QBEQ SET_B22b5, r4, 1

CLR_B22b5:
        CLR r30.t15
        JMP DEL_B22b5

SET_B22b5:
        SET r30.t15
        JMP DEL_B22b5

DEL_B22b5:
        ADD r0, r0, 1
        QBNE DEL_B22b5, r0, r1

CLC_B22b6:
        MOV r0, 0
        LSR r4, r13, 18
        AND r4, r4, 1
        QBEQ SET_B22b6, r4, 1

CLR_B22b6:
        CLR r30.t15
        JMP DEL_B22b6

SET_B22b6:
        SET r30.t15
        JMP DEL_B22b6

DEL_B22b6:
        ADD r0, r0, 1
        QBNE DEL_B22b6, r0, r1

CLC_B22b7:
        MOV r0, 0
        LSR r4, r13, 17
        AND r4, r4, 1
        QBEQ SET_B22b7, r4, 1

CLR_B22b7:
        CLR r30.t15
        JMP DEL_B22b7

SET_B22b7:
        SET r30.t15
        JMP DEL_B22b7

DEL_B22b7:
        ADD r0, r0, 1
        QBNE DEL_B22b7, r0, r1

CLC_B22b8:
        MOV r0, 0
        LSR r4, r13, 16
        AND r4, r4, 1
        QBEQ SET_B22b8, r4, 1

CLR_B22b8:
        CLR r30.t15
        JMP DEL_B22b8

SET_B22b8:
        SET r30.t15
        JMP DEL_B22b8

BCK_B22b8:
		JMP BCK_B21b8

DEL_B22b8:
        ADD r0, r0, 1
        QBNE DEL_B22b8, r0, r1

CLC_B23b1:
        MOV r0, 0
        LSR r4, r13, 15
        AND r4, r4, 1
        QBEQ SET_B23b1, r4, 1

CLR_B23b1:
        CLR r30.t15
        JMP DEL_B23b1

SET_B23b1:
        SET r30.t15
        JMP DEL_B23b1

DEL_B23b1:
        ADD r0, r0, 1
        QBNE DEL_B23b1, r0, r1

CLC_B23b2:
        MOV r0, 0
        LSR r4, r13, 14
        AND r4, r4, 1
        QBEQ SET_B23b2, r4, 1

CLR_B23b2:
        CLR r30.t15
        JMP DEL_B23b2

SET_B23b2:
        SET r30.t15
        JMP DEL_B23b2

DEL_B23b2:
        ADD r0, r0, 1
        QBNE DEL_B23b2, r0, r1

CLC_B23b3:
        MOV r0, 0
        LSR r4, r13, 13
        AND r4, r4, 1
        QBEQ SET_B23b3, r4, 1

CLR_B23b3:
        CLR r30.t15
        JMP DEL_B23b3

SET_B23b3:
        SET r30.t15
        JMP DEL_B23b3

DEL_B23b3:
        ADD r0, r0, 1
        QBNE DEL_B23b3, r0, r1

CLC_B23b4:
        MOV r0, 0
        LSR r4, r13, 12
        AND r4, r4, 1
        QBEQ SET_B23b4, r4, 1

CLR_B23b4:
        CLR r30.t15
        JMP DEL_B23b4

SET_B23b4:
        SET r30.t15
        JMP DEL_B23b4

DEL_B23b4:
        ADD r0, r0, 1
        QBNE DEL_B23b4, r0, r1

CLC_B23b5:
        MOV r0, 0
        LSR r4, r13, 11
        AND r4, r4, 1
        QBEQ SET_B23b5, r4, 1

CLR_B23b5:
        CLR r30.t15
        JMP DEL_B23b5

SET_B23b5:
        SET r30.t15
        JMP DEL_B23b5

DEL_B23b5:
        ADD r0, r0, 1
        QBNE DEL_B23b5, r0, r1

CLC_B23b6:
        MOV r0, 0
        LSR r4, r13, 10
        AND r4, r4, 1
        QBEQ SET_B23b6, r4, 1

CLR_B23b6:
        CLR r30.t15
        JMP DEL_B23b6

SET_B23b6:
        SET r30.t15
        JMP DEL_B23b6

DEL_B23b6:
        ADD r0, r0, 1
        QBNE DEL_B23b6, r0, r1

CLC_B23b7:
        MOV r0, 0
        LSR r4, r13, 9
        AND r4, r4, 1
        QBEQ SET_B23b7, r4, 1

CLR_B23b7:
        CLR r30.t15
        JMP DEL_B23b7

SET_B23b7:
        SET r30.t15
        JMP DEL_B23b7

DEL_B23b7:
        ADD r0, r0, 1
        QBNE DEL_B23b7, r0, r1

CLC_B23b8:
        MOV r0, 0
        LSR r4, r13, 8
        AND r4, r4, 1
        QBEQ SET_B23b8, r4, 1

CLR_B23b8:
        CLR r30.t15
        JMP DEL_B23b8

SET_B23b8:
        SET r30.t15
        JMP DEL_B23b8

BCK_B23b8:
		JMP BCK_B22b8

DEL_B23b8:
        ADD r0, r0, 1
        QBNE DEL_B23b8, r0, r1

CLC_B24b1:
        MOV r0, 0
        LSR r4, r13, 7
        AND r4, r4, 1
        QBEQ SET_B24b1, r4, 1

CLR_B24b1:
        CLR r30.t15
        JMP DEL_B24b1

SET_B24b1:
        SET r30.t15
        JMP DEL_B24b1

DEL_B24b1:
        ADD r0, r0, 1
        QBNE DEL_B24b1, r0, r1

CLC_B24b2:
        MOV r0, 0
        LSR r4, r13, 6
        AND r4, r4, 1
        QBEQ SET_B24b2, r4, 1

CLR_B24b2:
        CLR r30.t15
        JMP DEL_B24b2

SET_B24b2:
        SET r30.t15
        JMP DEL_B24b2

DEL_B24b2:
        ADD r0, r0, 1
        QBNE DEL_B24b2, r0, r1

CLC_B24b3:
        MOV r0, 0
        LSR r4, r13, 5
        AND r4, r4, 1
        QBEQ SET_B24b3, r4, 1

CLR_B24b3:
        CLR r30.t15
        JMP DEL_B24b3

SET_B24b3:
        SET r30.t15
        JMP DEL_B24b3

DEL_B24b3:
        ADD r0, r0, 1
        QBNE DEL_B24b3, r0, r1

CLC_B24b4:
        MOV r0, 0
        LSR r4, r13, 4
        AND r4, r4, 1
        QBEQ SET_B24b4, r4, 1

CLR_B24b4:
        CLR r30.t15
        JMP DEL_B24b4

SET_B24b4:
        SET r30.t15
        JMP DEL_B24b4

DEL_B24b4:
        ADD r0, r0, 1
        QBNE DEL_B24b4, r0, r1

CLC_B24b5:
        MOV r0, 0
        LSR r4, r13, 3
        AND r4, r4, 1
        QBEQ SET_B24b5, r4, 1

CLR_B24b5:
        CLR r30.t15
        JMP DEL_B24b5

SET_B24b5:
        SET r30.t15
        JMP DEL_B24b5

DEL_B24b5:
        ADD r0, r0, 1
        QBNE DEL_B24b5, r0, r1

CLC_B24b6:
        MOV r0, 0
        LSR r4, r13, 2
        AND r4, r4, 1
        QBEQ SET_B24b6, r4, 1

CLR_B24b6:
        CLR r30.t15
        JMP DEL_B24b6

SET_B24b6:
        SET r30.t15
        JMP DEL_B24b6

DEL_B24b6:
        ADD r0, r0, 1
        QBNE DEL_B24b6, r0, r1

CLC_B24b7:
        MOV r0, 0
        LSR r4, r13, 1
        AND r4, r4, 1
        QBEQ SET_B24b7, r4, 1

CLR_B24b7:
        CLR r30.t15
        JMP DEL_B24b7

SET_B24b7:
        SET r30.t15
        JMP DEL_B24b7

DEL_B24b7:
        ADD r0, r0, 1
        QBNE DEL_B24b7, r0, r1

CLC_B24b8:
        MOV r0, 0
        LSR r4, r13, 0
        AND r4, r4, 1
        QBEQ SET_B24b8, r4, 1

CLR_B24b8:
        CLR r30.t15
        JMP DEL_B24b8

SET_B24b8:
        SET r30.t15
        JMP DEL_B24b8

BCK_B24b8:
		JMP BCK_B23b8

DEL_B24b8:
        ADD r0, r0, 1
        QBNE DEL_B24b8, r0, r1

CLC_B25b1:
        MOV r0, 0
        LSR r4, r14, 31
        AND r4, r4, 1
        QBEQ SET_B25b1, r4, 1

CLR_B25b1:
        CLR r30.t15
        JMP DEL_B25b1

SET_B25b1:
        SET r30.t15
        JMP DEL_B25b1

DEL_B25b1:
        ADD r0, r0, 1
        QBNE DEL_B25b1, r0, r1

CLC_B25b2:
        MOV r0, 0
        LSR r4, r14, 30
        AND r4, r4, 1
        QBEQ SET_B25b2, r4, 1

CLR_B25b2:
        CLR r30.t15
        JMP DEL_B25b2

SET_B25b2:
        SET r30.t15
        JMP DEL_B25b2

DEL_B25b2:
        ADD r0, r0, 1
        QBNE DEL_B25b2, r0, r1

CLC_B25b3:
        MOV r0, 0
        LSR r4, r14, 29
        AND r4, r4, 1
        QBEQ SET_B25b3, r4, 1

CLR_B25b3:
        CLR r30.t15
        JMP DEL_B25b3

SET_B25b3:
        SET r30.t15
        JMP DEL_B25b3

DEL_B25b3:
        ADD r0, r0, 1
        QBNE DEL_B25b3, r0, r1

CLC_B25b4:
        MOV r0, 0
        LSR r4, r14, 28
        AND r4, r4, 1
        QBEQ SET_B25b4, r4, 1

CLR_B25b4:
        CLR r30.t15
        JMP DEL_B25b4

SET_B25b4:
        SET r30.t15
        JMP DEL_B25b4

DEL_B25b4:
        ADD r0, r0, 1
        QBNE DEL_B25b4, r0, r1

CLC_B25b5:
        MOV r0, 0
        LSR r4, r14, 27
        AND r4, r4, 1
        QBEQ SET_B25b5, r4, 1

CLR_B25b5:
        CLR r30.t15
        JMP DEL_B25b5

SET_B25b5:
        SET r30.t15
        JMP DEL_B25b5

DEL_B25b5:
        ADD r0, r0, 1
        QBNE DEL_B25b5, r0, r1

CLC_B25b6:
        MOV r0, 0
        LSR r4, r14, 26
        AND r4, r4, 1
        QBEQ SET_B25b6, r4, 1

CLR_B25b6:
        CLR r30.t15
        JMP DEL_B25b6

SET_B25b6:
        SET r30.t15
        JMP DEL_B25b6

DEL_B25b6:
        ADD r0, r0, 1
        QBNE DEL_B25b6, r0, r1

CLC_B25b7:
        MOV r0, 0
        LSR r4, r14, 25
        AND r4, r4, 1
        QBEQ SET_B25b7, r4, 1

CLR_B25b7:
        CLR r30.t15
        JMP DEL_B25b7

SET_B25b7:
        SET r30.t15
        JMP DEL_B25b7

DEL_B25b7:
        ADD r0, r0, 1
        QBNE DEL_B25b7, r0, r1

CLC_B25b8:
        MOV r0, 0
        LSR r4, r14, 24
        AND r4, r4, 1
        QBEQ SET_B25b8, r4, 1

CLR_B25b8:
        CLR r30.t15
        JMP DEL_B25b8

SET_B25b8:
        SET r30.t15
        JMP DEL_B25b8

BCK_B25b8:
		JMP BCK_B24b8

DEL_B25b8:
        ADD r0, r0, 1
        QBNE DEL_B25b8, r0, r1

CLC_B26b1:
        MOV r0, 0
        LSR r4, r14, 23
        AND r4, r4, 1
        QBEQ SET_B26b1, r4, 1

CLR_B26b1:
        CLR r30.t15
        JMP DEL_B26b1

SET_B26b1:
        SET r30.t15
        JMP DEL_B26b1

DEL_B26b1:
        ADD r0, r0, 1
        QBNE DEL_B26b1, r0, r1

CLC_B26b2:
        MOV r0, 0
        LSR r4, r14, 22
        AND r4, r4, 1
        QBEQ SET_B26b2, r4, 1

CLR_B26b2:
        CLR r30.t15
        JMP DEL_B26b2

SET_B26b2:
        SET r30.t15
        JMP DEL_B26b2

DEL_B26b2:
        ADD r0, r0, 1
        QBNE DEL_B26b2, r0, r1

CLC_B26b3:
        MOV r0, 0
        LSR r4, r14, 21
        AND r4, r4, 1
        QBEQ SET_B26b3, r4, 1

CLR_B26b3:
        CLR r30.t15
        JMP DEL_B26b3

SET_B26b3:
        SET r30.t15
        JMP DEL_B26b3

DEL_B26b3:
        ADD r0, r0, 1
        QBNE DEL_B26b3, r0, r1

CLC_B26b4:
        MOV r0, 0
        LSR r4, r14, 20
        AND r4, r4, 1
        QBEQ SET_B26b4, r4, 1

CLR_B26b4:
        CLR r30.t15
        JMP DEL_B26b4

SET_B26b4:
        SET r30.t15
        JMP DEL_B26b4

DEL_B26b4:
        ADD r0, r0, 1
        QBNE DEL_B26b4, r0, r1

CLC_B26b5:
        MOV r0, 0
        LSR r4, r14, 19
        AND r4, r4, 1
        QBEQ SET_B26b5, r4, 1

CLR_B26b5:
        CLR r30.t15
        JMP DEL_B26b5

SET_B26b5:
        SET r30.t15
        JMP DEL_B26b5

DEL_B26b5:
        ADD r0, r0, 1
        QBNE DEL_B26b5, r0, r1

CLC_B26b6:
        MOV r0, 0
        LSR r4, r14, 18
        AND r4, r4, 1
        QBEQ SET_B26b6, r4, 1

CLR_B26b6:
        CLR r30.t15
        JMP DEL_B26b6

SET_B26b6:
        SET r30.t15
        JMP DEL_B26b6

DEL_B26b6:
        ADD r0, r0, 1
        QBNE DEL_B26b6, r0, r1

CLC_B26b7:
        MOV r0, 0
        LSR r4, r14, 17
        AND r4, r4, 1
        QBEQ SET_B26b7, r4, 1

CLR_B26b7:
        CLR r30.t15
        JMP DEL_B26b7

SET_B26b7:
        SET r30.t15
        JMP DEL_B26b7

DEL_B26b7:
        ADD r0, r0, 1
        QBNE DEL_B26b7, r0, r1

CLC_B26b8:
        MOV r0, 0
        LSR r4, r14, 16
        AND r4, r4, 1
        QBEQ SET_B26b8, r4, 1

CLR_B26b8:
        CLR r30.t15
        JMP DEL_B26b8

SET_B26b8:
        SET r30.t15
        JMP DEL_B26b8

BCK_B26b8:
		JMP BCK_B25b8

DEL_B26b8:
        ADD r0, r0, 1
        QBNE DEL_B26b8, r0, r1

CLC_B27b1:
        MOV r0, 0
        LSR r4, r14, 15
        AND r4, r4, 1
        QBEQ SET_B27b1, r4, 1

CLR_B27b1:
        CLR r30.t15
        JMP DEL_B27b1

SET_B27b1:
        SET r30.t15
        JMP DEL_B27b1

DEL_B27b1:
        ADD r0, r0, 1
        QBNE DEL_B27b1, r0, r1

CLC_B27b2:
        MOV r0, 0
        LSR r4, r14, 14
        AND r4, r4, 1
        QBEQ SET_B27b2, r4, 1

CLR_B27b2:
        CLR r30.t15
        JMP DEL_B27b2

SET_B27b2:
        SET r30.t15
        JMP DEL_B27b2

DEL_B27b2:
        ADD r0, r0, 1
        QBNE DEL_B27b2, r0, r1

CLC_B27b3:
        MOV r0, 0
        LSR r4, r14, 13
        AND r4, r4, 1
        QBEQ SET_B27b3, r4, 1

CLR_B27b3:
        CLR r30.t15
        JMP DEL_B27b3

SET_B27b3:
        SET r30.t15
        JMP DEL_B27b3

DEL_B27b3:
        ADD r0, r0, 1
        QBNE DEL_B27b3, r0, r1

CLC_B27b4:
        MOV r0, 0
        LSR r4, r14, 12
        AND r4, r4, 1
        QBEQ SET_B27b4, r4, 1

CLR_B27b4:
        CLR r30.t15
        JMP DEL_B27b4

SET_B27b4:
        SET r30.t15
        JMP DEL_B27b4

DEL_B27b4:
        ADD r0, r0, 1
        QBNE DEL_B27b4, r0, r1

CLC_B27b5:
        MOV r0, 0
        LSR r4, r14, 11
        AND r4, r4, 1
        QBEQ SET_B27b5, r4, 1

CLR_B27b5:
        CLR r30.t15
        JMP DEL_B27b5

SET_B27b5:
        SET r30.t15
        JMP DEL_B27b5

DEL_B27b5:
        ADD r0, r0, 1
        QBNE DEL_B27b5, r0, r1

CLC_B27b6:
        MOV r0, 0
        LSR r4, r14, 10
        AND r4, r4, 1
        QBEQ SET_B27b6, r4, 1

CLR_B27b6:
        CLR r30.t15
        JMP DEL_B27b6

SET_B27b6:
        SET r30.t15
        JMP DEL_B27b6

DEL_B27b6:
        ADD r0, r0, 1
        QBNE DEL_B27b6, r0, r1

CLC_B27b7:
        MOV r0, 0
        LSR r4, r14, 9
        AND r4, r4, 1
        QBEQ SET_B27b7, r4, 1

CLR_B27b7:
        CLR r30.t15
        JMP DEL_B27b7

SET_B27b7:
        SET r30.t15
        JMP DEL_B27b7

DEL_B27b7:
        ADD r0, r0, 1
        QBNE DEL_B27b7, r0, r1

CLC_B27b8:
        MOV r0, 0
        LSR r4, r14, 8
        AND r4, r4, 1
        QBEQ SET_B27b8, r4, 1

CLR_B27b8:
        CLR r30.t15
        JMP DEL_B27b8

SET_B27b8:
        SET r30.t15
        JMP DEL_B27b8

BCK_B27b8:
		JMP BCK_B26b8

DEL_B27b8:
        ADD r0, r0, 1
        QBNE DEL_B27b8, r0, r1

CLC_B28b1:
        MOV r0, 0
        LSR r4, r14, 7
        AND r4, r4, 1
        QBEQ SET_B28b1, r4, 1

CLR_B28b1:
        CLR r30.t15
        JMP DEL_B28b1

SET_B28b1:
        SET r30.t15
        JMP DEL_B28b1

DEL_B28b1:
        ADD r0, r0, 1
        QBNE DEL_B28b1, r0, r1

CLC_B28b2:
        MOV r0, 0
        LSR r4, r14, 6
        AND r4, r4, 1
        QBEQ SET_B28b2, r4, 1

CLR_B28b2:
        CLR r30.t15
        JMP DEL_B28b2

SET_B28b2:
        SET r30.t15
        JMP DEL_B28b2

DEL_B28b2:
        ADD r0, r0, 1
        QBNE DEL_B28b2, r0, r1

CLC_B28b3:
        MOV r0, 0
        LSR r4, r14, 5
        AND r4, r4, 1
        QBEQ SET_B28b3, r4, 1

CLR_B28b3:
        CLR r30.t15
        JMP DEL_B28b3

SET_B28b3:
        SET r30.t15
        JMP DEL_B28b3

DEL_B28b3:
        ADD r0, r0, 1
        QBNE DEL_B28b3, r0, r1

CLC_B28b4:
        MOV r0, 0
        LSR r4, r14, 4
        AND r4, r4, 1
        QBEQ SET_B28b4, r4, 1

CLR_B28b4:
        CLR r30.t15
        JMP DEL_B28b4

SET_B28b4:
        SET r30.t15
        JMP DEL_B28b4

DEL_B28b4:
        ADD r0, r0, 1
        QBNE DEL_B28b4, r0, r1

CLC_B28b5:
        MOV r0, 0
        LSR r4, r14, 3
        AND r4, r4, 1
        QBEQ SET_B28b5, r4, 1

CLR_B28b5:
        CLR r30.t15
        JMP DEL_B28b5

SET_B28b5:
        SET r30.t15
        JMP DEL_B28b5

DEL_B28b5:
        ADD r0, r0, 1
        QBNE DEL_B28b5, r0, r1

CLC_B28b6:
        MOV r0, 0
        LSR r4, r14, 2
        AND r4, r4, 1
        QBEQ SET_B28b6, r4, 1

CLR_B28b6:
        CLR r30.t15
        JMP DEL_B28b6

SET_B28b6:
        SET r30.t15
        JMP DEL_B28b6

DEL_B28b6:
        ADD r0, r0, 1
        QBNE DEL_B28b6, r0, r1

CLC_B28b7:
        MOV r0, 0
        LSR r4, r14, 1
        AND r4, r4, 1
        QBEQ SET_B28b7, r4, 1

CLR_B28b7:
        CLR r30.t15
        JMP DEL_B28b7

SET_B28b7:
        SET r30.t15
        JMP DEL_B28b7

DEL_B28b7:
        ADD r0, r0, 1
        QBNE DEL_B28b7, r0, r1

CLC_B28b8:
        MOV r0, 0
        LSR r4, r14, 0
        AND r4, r4, 1
        QBEQ SET_B28b8, r4, 1

CLR_B28b8:
        CLR r30.t15
        JMP DEL_B28b8

SET_B28b8:
        SET r30.t15
        JMP DEL_B28b8

BCK_B28b8:
		JMP BCK_B27b8

DEL_B28b8:
        ADD r0, r0, 1
        QBNE DEL_B28b8, r0, r1

CLC_B29b1:
        MOV r0, 0
        LSR r4, r15, 31
        AND r4, r4, 1
        QBEQ SET_B29b1, r4, 1

CLR_B29b1:
        CLR r30.t15
        JMP DEL_B29b1

SET_B29b1:
        SET r30.t15
        JMP DEL_B29b1

DEL_B29b1:
        ADD r0, r0, 1
        QBNE DEL_B29b1, r0, r1

CLC_B29b2:
        MOV r0, 0
        LSR r4, r15, 30
        AND r4, r4, 1
        QBEQ SET_B29b2, r4, 1

CLR_B29b2:
        CLR r30.t15
        JMP DEL_B29b2

SET_B29b2:
        SET r30.t15
        JMP DEL_B29b2

DEL_B29b2:
        ADD r0, r0, 1
        QBNE DEL_B29b2, r0, r1

CLC_B29b3:
        MOV r0, 0
        LSR r4, r15, 29
        AND r4, r4, 1
        QBEQ SET_B29b3, r4, 1

CLR_B29b3:
        CLR r30.t15
        JMP DEL_B29b3

SET_B29b3:
        SET r30.t15
        JMP DEL_B29b3

DEL_B29b3:
        ADD r0, r0, 1
        QBNE DEL_B29b3, r0, r1

CLC_B29b4:
        MOV r0, 0
        LSR r4, r15, 28
        AND r4, r4, 1
        QBEQ SET_B29b4, r4, 1

CLR_B29b4:
        CLR r30.t15
        JMP DEL_B29b4

SET_B29b4:
        SET r30.t15
        JMP DEL_B29b4

DEL_B29b4:
        ADD r0, r0, 1
        QBNE DEL_B29b4, r0, r1

CLC_B29b5:
        MOV r0, 0
        LSR r4, r15, 27
        AND r4, r4, 1
        QBEQ SET_B29b5, r4, 1

CLR_B29b5:
        CLR r30.t15
        JMP DEL_B29b5

SET_B29b5:
        SET r30.t15
        JMP DEL_B29b5

DEL_B29b5:
        ADD r0, r0, 1
        QBNE DEL_B29b5, r0, r1

CLC_B29b6:
        MOV r0, 0
        LSR r4, r15, 26
        AND r4, r4, 1
        QBEQ SET_B29b6, r4, 1

CLR_B29b6:
        CLR r30.t15
        JMP DEL_B29b6

SET_B29b6:
        SET r30.t15
        JMP DEL_B29b6

DEL_B29b6:
        ADD r0, r0, 1
        QBNE DEL_B29b6, r0, r1

CLC_B29b7:
        MOV r0, 0
        LSR r4, r15, 25
        AND r4, r4, 1
        QBEQ SET_B29b7, r4, 1

CLR_B29b7:
        CLR r30.t15
        JMP DEL_B29b7

SET_B29b7:
        SET r30.t15
        JMP DEL_B29b7

DEL_B29b7:
        ADD r0, r0, 1
        QBNE DEL_B29b7, r0, r1

CLC_B29b8:
        MOV r0, 0
        LSR r4, r15, 24
        AND r4, r4, 1
        QBEQ SET_B29b8, r4, 1

CLR_B29b8:
        CLR r30.t15
        JMP DEL_B29b8

SET_B29b8:
        SET r30.t15
        JMP DEL_B29b8

BCK_B29b8:
		JMP BCK_B28b8

DEL_B29b8:
        ADD r0, r0, 1
        QBNE DEL_B29b8, r0, r1

CLC_B30b1:
        MOV r0, 0
        LSR r4, r15, 23
        AND r4, r4, 1
        QBEQ SET_B30b1, r4, 1

CLR_B30b1:
        CLR r30.t15
        JMP DEL_B30b1

SET_B30b1:
        SET r30.t15
        JMP DEL_B30b1

DEL_B30b1:
        ADD r0, r0, 1
        QBNE DEL_B30b1, r0, r1

CLC_B30b2:
        MOV r0, 0
        LSR r4, r15, 22
        AND r4, r4, 1
        QBEQ SET_B30b2, r4, 1

CLR_B30b2:
        CLR r30.t15
        JMP DEL_B30b2

SET_B30b2:
        SET r30.t15
        JMP DEL_B30b2

DEL_B30b2:
        ADD r0, r0, 1
        QBNE DEL_B30b2, r0, r1

CLC_B30b3:
        MOV r0, 0
        LSR r4, r15, 21
        AND r4, r4, 1
        QBEQ SET_B30b3, r4, 1

CLR_B30b3:
        CLR r30.t15
        JMP DEL_B30b3

SET_B30b3:
        SET r30.t15
        JMP DEL_B30b3

DEL_B30b3:
        ADD r0, r0, 1
        QBNE DEL_B30b3, r0, r1

CLC_B30b4:
        MOV r0, 0
        LSR r4, r15, 20
        AND r4, r4, 1
        QBEQ SET_B30b4, r4, 1

CLR_B30b4:
        CLR r30.t15
        JMP DEL_B30b4

SET_B30b4:
        SET r30.t15
        JMP DEL_B30b4

DEL_B30b4:
        ADD r0, r0, 1
        QBNE DEL_B30b4, r0, r1

CLC_B30b5:
        MOV r0, 0
        LSR r4, r15, 19
        AND r4, r4, 1
        QBEQ SET_B30b5, r4, 1

CLR_B30b5:
        CLR r30.t15
        JMP DEL_B30b5

SET_B30b5:
        SET r30.t15
        JMP DEL_B30b5

DEL_B30b5:
        ADD r0, r0, 1
        QBNE DEL_B30b5, r0, r1

CLC_B30b6:
        MOV r0, 0
        LSR r4, r15, 18
        AND r4, r4, 1
        QBEQ SET_B30b6, r4, 1

CLR_B30b6:
        CLR r30.t15
        JMP DEL_B30b6

SET_B30b6:
        SET r30.t15
        JMP DEL_B30b6

DEL_B30b6:
        ADD r0, r0, 1
        QBNE DEL_B30b6, r0, r1

CLC_B30b7:
        MOV r0, 0
        LSR r4, r15, 17
        AND r4, r4, 1
        QBEQ SET_B30b7, r4, 1

CLR_B30b7:
        CLR r30.t15
        JMP DEL_B30b7

SET_B30b7:
        SET r30.t15
        JMP DEL_B30b7

DEL_B30b7:
        ADD r0, r0, 1
        QBNE DEL_B30b7, r0, r1

CLC_B30b8:
        MOV r0, 0
        LSR r4, r15, 16
        AND r4, r4, 1
        QBEQ SET_B30b8, r4, 1

CLR_B30b8:
        CLR r30.t15
        JMP DEL_B30b8

SET_B30b8:
        SET r30.t15
        JMP DEL_B30b8

BCK_B30b8:
		JMP BCK_B29b8

DEL_B30b8:
        ADD r0, r0, 1
        QBNE DEL_B30b8, r0, r1

CLC_B31b1:
        MOV r0, 0
        LSR r4, r15, 15
        AND r4, r4, 1
        QBEQ SET_B31b1, r4, 1

CLR_B31b1:
        CLR r30.t15
        JMP DEL_B31b1

SET_B31b1:
        SET r30.t15
        JMP DEL_B31b1

DEL_B31b1:
        ADD r0, r0, 1
        QBNE DEL_B31b1, r0, r1

CLC_B31b2:
        MOV r0, 0
        LSR r4, r15, 14
        AND r4, r4, 1
        QBEQ SET_B31b2, r4, 1

CLR_B31b2:
        CLR r30.t15
        JMP DEL_B31b2

SET_B31b2:
        SET r30.t15
        JMP DEL_B31b2

DEL_B31b2:
        ADD r0, r0, 1
        QBNE DEL_B31b2, r0, r1

CLC_B31b3:
        MOV r0, 0
        LSR r4, r15, 13
        AND r4, r4, 1
        QBEQ SET_B31b3, r4, 1

CLR_B31b3:
        CLR r30.t15
        JMP DEL_B31b3

SET_B31b3:
        SET r30.t15
        JMP DEL_B31b3

DEL_B31b3:
        ADD r0, r0, 1
        QBNE DEL_B31b3, r0, r1

CLC_B31b4:
        MOV r0, 0
        LSR r4, r15, 12
        AND r4, r4, 1
        QBEQ SET_B31b4, r4, 1

CLR_B31b4:
        CLR r30.t15
        JMP DEL_B31b4

SET_B31b4:
        SET r30.t15
        JMP DEL_B31b4

DEL_B31b4:
        ADD r0, r0, 1
        QBNE DEL_B31b4, r0, r1

CLC_B31b5:
        MOV r0, 0
        LSR r4, r15, 11
        AND r4, r4, 1
        QBEQ SET_B31b5, r4, 1

CLR_B31b5:
        CLR r30.t15
        JMP DEL_B31b5

SET_B31b5:
        SET r30.t15
        JMP DEL_B31b5

DEL_B31b5:
        ADD r0, r0, 1
        QBNE DEL_B31b5, r0, r1

CLC_B31b6:
        MOV r0, 0
        LSR r4, r15, 10
        AND r4, r4, 1
        QBEQ SET_B31b6, r4, 1

CLR_B31b6:
        CLR r30.t15
        JMP DEL_B31b6

SET_B31b6:
        SET r30.t15
        JMP DEL_B31b6

DEL_B31b6:
        ADD r0, r0, 1
        QBNE DEL_B31b6, r0, r1

CLC_B31b7:
        MOV r0, 0
        LSR r4, r15, 9
        AND r4, r4, 1
        QBEQ SET_B31b7, r4, 1

CLR_B31b7:
        CLR r30.t15
        JMP DEL_B31b7

SET_B31b7:
        SET r30.t15
        JMP DEL_B31b7

DEL_B31b7:
        ADD r0, r0, 1
        QBNE DEL_B31b7, r0, r1

CLC_B31b8:
        MOV r0, 0
        LSR r4, r15, 8
        AND r4, r4, 1
        QBEQ SET_B31b8, r4, 1

CLR_B31b8:
        CLR r30.t15
        JMP DEL_B31b8

SET_B31b8:
        SET r30.t15
        JMP DEL_B31b8

BCK_B31b8:
		JMP BCK_B30b8

DEL_B31b8:
        ADD r0, r0, 1
        QBNE DEL_B31b8, r0, r1

CLC_B32b1:
        MOV r0, 0
        LSR r4, r15, 7
        AND r4, r4, 1
        QBEQ SET_B32b1, r4, 1

CLR_B32b1:
        CLR r30.t15
        JMP DEL_B32b1

SET_B32b1:
        SET r30.t15
        JMP DEL_B32b1

DEL_B32b1:
        ADD r0, r0, 1
        QBNE DEL_B32b1, r0, r1

CLC_B32b2:
        MOV r0, 0
        LSR r4, r15, 6
        AND r4, r4, 1
        QBEQ SET_B32b2, r4, 1

CLR_B32b2:
        CLR r30.t15
        JMP DEL_B32b2

SET_B32b2:
        SET r30.t15
        JMP DEL_B32b2

DEL_B32b2:
        ADD r0, r0, 1
        QBNE DEL_B32b2, r0, r1

CLC_B32b3:
        MOV r0, 0
        LSR r4, r15, 5
        AND r4, r4, 1
        QBEQ SET_B32b3, r4, 1

CLR_B32b3:
        CLR r30.t15
        JMP DEL_B32b3

SET_B32b3:
        SET r30.t15
        JMP DEL_B32b3

DEL_B32b3:
        ADD r0, r0, 1
        QBNE DEL_B32b3, r0, r1

CLC_B32b4:
        MOV r0, 0
        LSR r4, r15, 4
        AND r4, r4, 1
        QBEQ SET_B32b4, r4, 1

CLR_B32b4:
        CLR r30.t15
        JMP DEL_B32b4

SET_B32b4:
        SET r30.t15
        JMP DEL_B32b4

DEL_B32b4:
        ADD r0, r0, 1
        QBNE DEL_B32b4, r0, r1

CLC_B32b5:
        MOV r0, 0
        LSR r4, r15, 3
        AND r4, r4, 1
        QBEQ SET_B32b5, r4, 1

CLR_B32b5:
        CLR r30.t15
        JMP DEL_B32b5

SET_B32b5:
        SET r30.t15
        JMP DEL_B32b5

DEL_B32b5:
        ADD r0, r0, 1
        QBNE DEL_B32b5, r0, r1

CLC_B32b6:
        MOV r0, 0
        LSR r4, r15, 2
        AND r4, r4, 1
        QBEQ SET_B32b6, r4, 1

CLR_B32b6:
        CLR r30.t15
        JMP DEL_B32b6

SET_B32b6:
        SET r30.t15
        JMP DEL_B32b6

DEL_B32b6:
        ADD r0, r0, 1
        QBNE DEL_B32b6, r0, r1

CLC_B32b7:
        MOV r0, 0
        LSR r4, r15, 1
        AND r4, r4, 1
        QBEQ SET_B32b7, r4, 1

CLR_B32b7:
        CLR r30.t15
        JMP DEL_B32b7

SET_B32b7:
        SET r30.t15
        JMP DEL_B32b7

DEL_B32b7:
        ADD r0, r0, 1
        QBNE DEL_B32b7, r0, r1

CLC_B32b8:
        MOV r0, 0
        LSR r4, r15, 0
        AND r4, r4, 1
        QBEQ SET_B32b8, r4, 1

CLR_B32b8:
        CLR r30.t15
        JMP DEL_B32b8

SET_B32b8:
        SET r30.t15
        JMP DEL_B32b8

BCK_B32b8:
		JMP BCK_B31b8

DEL_B32b8:
        ADD r0, r0, 1
        QBNE DEL_B32b8, r0, r1

CLC_B33b1:
        MOV r0, 0
        LSR r4, r16, 31
        AND r4, r4, 1
        QBEQ SET_B33b1, r4, 1

CLR_B33b1:
        CLR r30.t15
        JMP DEL_B33b1

SET_B33b1:
        SET r30.t15
        JMP DEL_B33b1

DEL_B33b1:
        ADD r0, r0, 1
        QBNE DEL_B33b1, r0, r1

CLC_B33b2:
        MOV r0, 0
        LSR r4, r16, 30
        AND r4, r4, 1
        QBEQ SET_B33b2, r4, 1

CLR_B33b2:
        CLR r30.t15
        JMP DEL_B33b2

SET_B33b2:
        SET r30.t15
        JMP DEL_B33b2

DEL_B33b2:
        ADD r0, r0, 1
        QBNE DEL_B33b2, r0, r1

CLC_B33b3:
        MOV r0, 0
        LSR r4, r16, 29
        AND r4, r4, 1
        QBEQ SET_B33b3, r4, 1

CLR_B33b3:
        CLR r30.t15
        JMP DEL_B33b3

SET_B33b3:
        SET r30.t15
        JMP DEL_B33b3

DEL_B33b3:
        ADD r0, r0, 1
        QBNE DEL_B33b3, r0, r1

CLC_B33b4:
        MOV r0, 0
        LSR r4, r16, 28
        AND r4, r4, 1
        QBEQ SET_B33b4, r4, 1

CLR_B33b4:
        CLR r30.t15
        JMP DEL_B33b4

SET_B33b4:
        SET r30.t15
        JMP DEL_B33b4

DEL_B33b4:
        ADD r0, r0, 1
        QBNE DEL_B33b4, r0, r1

CLC_B33b5:
        MOV r0, 0
        LSR r4, r16, 27
        AND r4, r4, 1
        QBEQ SET_B33b5, r4, 1

CLR_B33b5:
        CLR r30.t15
        JMP DEL_B33b5

SET_B33b5:
        SET r30.t15
        JMP DEL_B33b5

DEL_B33b5:
        ADD r0, r0, 1
        QBNE DEL_B33b5, r0, r1

CLC_B33b6:
        MOV r0, 0
        LSR r4, r16, 26
        AND r4, r4, 1
        QBEQ SET_B33b6, r4, 1

CLR_B33b6:
        CLR r30.t15
        JMP DEL_B33b6

SET_B33b6:
        SET r30.t15
        JMP DEL_B33b6

DEL_B33b6:
        ADD r0, r0, 1
        QBNE DEL_B33b6, r0, r1

CLC_B33b7:
        MOV r0, 0
        LSR r4, r16, 25
        AND r4, r4, 1
        QBEQ SET_B33b7, r4, 1

CLR_B33b7:
        CLR r30.t15
        JMP DEL_B33b7

SET_B33b7:
        SET r30.t15
        JMP DEL_B33b7

DEL_B33b7:
        ADD r0, r0, 1
        QBNE DEL_B33b7, r0, r1

CLC_B33b8:
        MOV r0, 0
        LSR r4, r16, 24
        AND r4, r4, 1
        QBEQ SET_B33b8, r4, 1

CLR_B33b8:
        CLR r30.t15
        JMP DEL_B33b8

SET_B33b8:
        SET r30.t15
        JMP DEL_B33b8

BCK_B33b8:
		JMP CHECK_DONE

DEL_B33b8:
        ADD r0, r0, 1
        QBNE DEL_B33b8, r0, r1

CLC_B34b1:
        MOV r0, 0
        LSR r4, r16, 23
        AND r4, r4, 1
        QBEQ SET_B34b1, r4, 1

CLR_B34b1:
        CLR r30.t15
        JMP DEL_B34b1

SET_B34b1:
        SET r30.t15
        JMP DEL_B34b1

DEL_B34b1:
        ADD r0, r0, 1
        QBNE DEL_B34b1, r0, r1

CLC_B34b2:
        MOV r0, 0
        LSR r4, r16, 22
        AND r4, r4, 1
        QBEQ SET_B34b2, r4, 1

CLR_B34b2:
        CLR r30.t15
        JMP DEL_B34b2

SET_B34b2:
        SET r30.t15
        JMP DEL_B34b2

DEL_B34b2:
        ADD r0, r0, 1
        QBNE DEL_B34b2, r0, r1

CLC_B34b3:
        MOV r0, 0
        LSR r4, r16, 21
        AND r4, r4, 1
        QBEQ SET_B34b3, r4, 1

CLR_B34b3:
        CLR r30.t15
        JMP DEL_B34b3

SET_B34b3:
        SET r30.t15
        JMP DEL_B34b3

DEL_B34b3:
        ADD r0, r0, 1
        QBNE DEL_B34b3, r0, r1

CLC_B34b4:
        MOV r0, 0
        LSR r4, r16, 20
        AND r4, r4, 1
        QBEQ SET_B34b4, r4, 1

CLR_B34b4:
        CLR r30.t15
        JMP DEL_B34b4

SET_B34b4:
        SET r30.t15
        JMP DEL_B34b4

DEL_B34b4:
        ADD r0, r0, 1
        QBNE DEL_B34b4, r0, r1

CLC_B34b5:
        MOV r0, 0
        LSR r4, r16, 19
        AND r4, r4, 1
        QBEQ SET_B34b5, r4, 1

CLR_B34b5:
        CLR r30.t15
        JMP DEL_B34b5

SET_B34b5:
        SET r30.t15
        JMP DEL_B34b5

DEL_B34b5:
        ADD r0, r0, 1
        QBNE DEL_B34b5, r0, r1

CLC_B34b6:
        MOV r0, 0
        LSR r4, r16, 18
        AND r4, r4, 1
        QBEQ SET_B34b6, r4, 1

CLR_B34b6:
        CLR r30.t15
        JMP DEL_B34b6

SET_B34b6:
        SET r30.t15
        JMP DEL_B34b6

DEL_B34b6:
        ADD r0, r0, 1
        QBNE DEL_B34b6, r0, r1

CLC_B34b7:
        MOV r0, 0
        LSR r4, r16, 17
        AND r4, r4, 1
        QBEQ SET_B34b7, r4, 1

CLR_B34b7:
        CLR r30.t15
        JMP DEL_B34b7

SET_B34b7:
        SET r30.t15
        JMP DEL_B34b7

DEL_B34b7:
        ADD r0, r0, 1
        QBNE DEL_B34b7, r0, r1

CLC_B34b8:
        MOV r0, 0
        LSR r4, r16, 16
        AND r4, r4, 1
        QBEQ SET_B34b8, r4, 1

CLR_B34b8:
        CLR r30.t15
        JMP DEL_B34b8

SET_B34b8:
        SET r30.t15
        JMP DEL_B34b8

BCK_B34b8:
		JMP BCK_B33b8

DEL_B34b8:
        ADD r0, r0, 1
        QBNE DEL_B34b8, r0, r1

CLC_B35b1:
        MOV r0, 0
        LSR r4, r16, 15
        AND r4, r4, 1
        QBEQ SET_B35b1, r4, 1

CLR_B35b1:
        CLR r30.t15
        JMP DEL_B35b1

SET_B35b1:
        SET r30.t15
        JMP DEL_B35b1

DEL_B35b1:
        ADD r0, r0, 1
        QBNE DEL_B35b1, r0, r1

CLC_B35b2:
        MOV r0, 0
        LSR r4, r16, 14
        AND r4, r4, 1
        QBEQ SET_B35b2, r4, 1

CLR_B35b2:
        CLR r30.t15
        JMP DEL_B35b2

SET_B35b2:
        SET r30.t15
        JMP DEL_B35b2

DEL_B35b2:
        ADD r0, r0, 1
        QBNE DEL_B35b2, r0, r1

CLC_B35b3:
        MOV r0, 0
        LSR r4, r16, 13
        AND r4, r4, 1
        QBEQ SET_B35b3, r4, 1

CLR_B35b3:
        CLR r30.t15
        JMP DEL_B35b3

SET_B35b3:
        SET r30.t15
        JMP DEL_B35b3

DEL_B35b3:
        ADD r0, r0, 1
        QBNE DEL_B35b3, r0, r1

CLC_B35b4:
        MOV r0, 0
        LSR r4, r16, 12
        AND r4, r4, 1
        QBEQ SET_B35b4, r4, 1

CLR_B35b4:
        CLR r30.t15
        JMP DEL_B35b4

SET_B35b4:
        SET r30.t15
        JMP DEL_B35b4

DEL_B35b4:
        ADD r0, r0, 1
        QBNE DEL_B35b4, r0, r1

CLC_B35b5:
        MOV r0, 0
        LSR r4, r16, 11
        AND r4, r4, 1
        QBEQ SET_B35b5, r4, 1

CLR_B35b5:
        CLR r30.t15
        JMP DEL_B35b5

SET_B35b5:
        SET r30.t15
        JMP DEL_B35b5

DEL_B35b5:
        ADD r0, r0, 1
        QBNE DEL_B35b5, r0, r1

CLC_B35b6:
        MOV r0, 0
        LSR r4, r16, 10
        AND r4, r4, 1
        QBEQ SET_B35b6, r4, 1

CLR_B35b6:
        CLR r30.t15
        JMP DEL_B35b6

SET_B35b6:
        SET r30.t15
        JMP DEL_B35b6

DEL_B35b6:
        ADD r0, r0, 1
        QBNE DEL_B35b6, r0, r1

CLC_B35b7:
        MOV r0, 0
        LSR r4, r16, 9
        AND r4, r4, 1
        QBEQ SET_B35b7, r4, 1

CLR_B35b7:
        CLR r30.t15
        JMP DEL_B35b7

SET_B35b7:
        SET r30.t15
        JMP DEL_B35b7

DEL_B35b7:
        ADD r0, r0, 1
        QBNE DEL_B35b7, r0, r1

CLC_B35b8:
        MOV r0, 0
        LSR r4, r16, 8
        AND r4, r4, 1
        QBEQ SET_B35b8, r4, 1

CLR_B35b8:
        CLR r30.t15
        JMP DEL_B35b8

SET_B35b8:
        SET r30.t15
        JMP DEL_B35b8

BCK_B35b8:
		JMP BCK_B34b8

DEL_B35b8:
        ADD r0, r0, 1
        QBNE DEL_B35b8, r0, r1

CLC_B36b1:
        MOV r0, 0
        LSR r4, r16, 7
        AND r4, r4, 1
        QBEQ SET_B36b1, r4, 1

CLR_B36b1:
        CLR r30.t15
        JMP DEL_B36b1

SET_B36b1:
        SET r30.t15
        JMP DEL_B36b1

DEL_B36b1:
        ADD r0, r0, 1
        QBNE DEL_B36b1, r0, r1

CLC_B36b2:
        MOV r0, 0
        LSR r4, r16, 6
        AND r4, r4, 1
        QBEQ SET_B36b2, r4, 1

CLR_B36b2:
        CLR r30.t15
        JMP DEL_B36b2

SET_B36b2:
        SET r30.t15
        JMP DEL_B36b2

DEL_B36b2:
        ADD r0, r0, 1
        QBNE DEL_B36b2, r0, r1

CLC_B36b3:
        MOV r0, 0
        LSR r4, r16, 5
        AND r4, r4, 1
        QBEQ SET_B36b3, r4, 1

CLR_B36b3:
        CLR r30.t15
        JMP DEL_B36b3

SET_B36b3:
        SET r30.t15
        JMP DEL_B36b3

DEL_B36b3:
        ADD r0, r0, 1
        QBNE DEL_B36b3, r0, r1

CLC_B36b4:
        MOV r0, 0
        LSR r4, r16, 4
        AND r4, r4, 1
        QBEQ SET_B36b4, r4, 1

CLR_B36b4:
        CLR r30.t15
        JMP DEL_B36b4

SET_B36b4:
        SET r30.t15
        JMP DEL_B36b4

DEL_B36b4:
        ADD r0, r0, 1
        QBNE DEL_B36b4, r0, r1

CLC_B36b5:
        MOV r0, 0
        LSR r4, r16, 3
        AND r4, r4, 1
        QBEQ SET_B36b5, r4, 1

CLR_B36b5:
        CLR r30.t15
        JMP DEL_B36b5

SET_B36b5:
        SET r30.t15
        JMP DEL_B36b5

DEL_B36b5:
        ADD r0, r0, 1
        QBNE DEL_B36b5, r0, r1

CLC_B36b6:
        MOV r0, 0
        LSR r4, r16, 2
        AND r4, r4, 1
        QBEQ SET_B36b6, r4, 1

CLR_B36b6:
        CLR r30.t15
        JMP DEL_B36b6

SET_B36b6:
        SET r30.t15
        JMP DEL_B36b6

DEL_B36b6:
        ADD r0, r0, 1
        QBNE DEL_B36b6, r0, r1

CLC_B36b7:
        MOV r0, 0
        LSR r4, r16, 1
        AND r4, r4, 1
        QBEQ SET_B36b7, r4, 1

CLR_B36b7:
        CLR r30.t15
        JMP DEL_B36b7

SET_B36b7:
        SET r30.t15
        JMP DEL_B36b7

DEL_B36b7:
        ADD r0, r0, 1
        QBNE DEL_B36b7, r0, r1

CLC_B36b8:
        MOV r0, 0
        LSR r4, r16, 0
        AND r4, r4, 1
        QBEQ SET_B36b8, r4, 1

CLR_B36b8:
        CLR r30.t15
        JMP DEL_B36b8

SET_B36b8:
        SET r30.t15
        JMP DEL_B36b8

BCK_B36b8:
		JMP BCK_B35b8

DEL_B36b8:
        ADD r0, r0, 1
        QBNE DEL_B36b8, r0, r1

CLC_B37b1:
        MOV r0, 0
        LSR r4, r17, 31
        AND r4, r4, 1
        QBEQ SET_B37b1, r4, 1

CLR_B37b1:
        CLR r30.t15
        JMP DEL_B37b1

SET_B37b1:
        SET r30.t15
        JMP DEL_B37b1

DEL_B37b1:
        ADD r0, r0, 1
        QBNE DEL_B37b1, r0, r1

CLC_B37b2:
        MOV r0, 0
        LSR r4, r17, 30
        AND r4, r4, 1
        QBEQ SET_B37b2, r4, 1

CLR_B37b2:
        CLR r30.t15
        JMP DEL_B37b2

SET_B37b2:
        SET r30.t15
        JMP DEL_B37b2

DEL_B37b2:
        ADD r0, r0, 1
        QBNE DEL_B37b2, r0, r1

CLC_B37b3:
        MOV r0, 0
        LSR r4, r17, 29
        AND r4, r4, 1
        QBEQ SET_B37b3, r4, 1

CLR_B37b3:
        CLR r30.t15
        JMP DEL_B37b3

SET_B37b3:
        SET r30.t15
        JMP DEL_B37b3

DEL_B37b3:
        ADD r0, r0, 1
        QBNE DEL_B37b3, r0, r1

CLC_B37b4:
        MOV r0, 0
        LSR r4, r17, 28
        AND r4, r4, 1
        QBEQ SET_B37b4, r4, 1

CLR_B37b4:
        CLR r30.t15
        JMP DEL_B37b4

SET_B37b4:
        SET r30.t15
        JMP DEL_B37b4

DEL_B37b4:
        ADD r0, r0, 1
        QBNE DEL_B37b4, r0, r1

CLC_B37b5:
        MOV r0, 0
        LSR r4, r17, 27
        AND r4, r4, 1
        QBEQ SET_B37b5, r4, 1

CLR_B37b5:
        CLR r30.t15
        JMP DEL_B37b5

SET_B37b5:
        SET r30.t15
        JMP DEL_B37b5

DEL_B37b5:
        ADD r0, r0, 1
        QBNE DEL_B37b5, r0, r1

CLC_B37b6:
        MOV r0, 0
        LSR r4, r17, 26
        AND r4, r4, 1
        QBEQ SET_B37b6, r4, 1

CLR_B37b6:
        CLR r30.t15
        JMP DEL_B37b6

SET_B37b6:
        SET r30.t15
        JMP DEL_B37b6

DEL_B37b6:
        ADD r0, r0, 1
        QBNE DEL_B37b6, r0, r1

CLC_B37b7:
        MOV r0, 0
        LSR r4, r17, 25
        AND r4, r4, 1
        QBEQ SET_B37b7, r4, 1

CLR_B37b7:
        CLR r30.t15
        JMP DEL_B37b7

SET_B37b7:
        SET r30.t15
        JMP DEL_B37b7

DEL_B37b7:
        ADD r0, r0, 1
        QBNE DEL_B37b7, r0, r1

CLC_B37b8:
        MOV r0, 0
        LSR r4, r17, 24
        AND r4, r4, 1
        QBEQ SET_B37b8, r4, 1

CLR_B37b8:
        CLR r30.t15
        JMP DEL_B37b8

SET_B37b8:
        SET r30.t15
        JMP DEL_B37b8

BCK_B37b8:
		JMP BCK_B36b8

DEL_B37b8:
        ADD r0, r0, 1
        QBNE DEL_B37b8, r0, r1

CLC_B38b1:
        MOV r0, 0
        LSR r4, r17, 23
        AND r4, r4, 1
        QBEQ SET_B38b1, r4, 1

CLR_B38b1:
        CLR r30.t15
        JMP DEL_B38b1

SET_B38b1:
        SET r30.t15
        JMP DEL_B38b1

DEL_B38b1:
        ADD r0, r0, 1
        QBNE DEL_B38b1, r0, r1

CLC_B38b2:
        MOV r0, 0
        LSR r4, r17, 22
        AND r4, r4, 1
        QBEQ SET_B38b2, r4, 1

CLR_B38b2:
        CLR r30.t15
        JMP DEL_B38b2

SET_B38b2:
        SET r30.t15
        JMP DEL_B38b2

DEL_B38b2:
        ADD r0, r0, 1
        QBNE DEL_B38b2, r0, r1

CLC_B38b3:
        MOV r0, 0
        LSR r4, r17, 21
        AND r4, r4, 1
        QBEQ SET_B38b3, r4, 1

CLR_B38b3:
        CLR r30.t15
        JMP DEL_B38b3

SET_B38b3:
        SET r30.t15
        JMP DEL_B38b3

DEL_B38b3:
        ADD r0, r0, 1
        QBNE DEL_B38b3, r0, r1

CLC_B38b4:
        MOV r0, 0
        LSR r4, r17, 20
        AND r4, r4, 1
        QBEQ SET_B38b4, r4, 1

CLR_B38b4:
        CLR r30.t15
        JMP DEL_B38b4

SET_B38b4:
        SET r30.t15
        JMP DEL_B38b4

DEL_B38b4:
        ADD r0, r0, 1
        QBNE DEL_B38b4, r0, r1

CLC_B38b5:
        MOV r0, 0
        LSR r4, r17, 19
        AND r4, r4, 1
        QBEQ SET_B38b5, r4, 1

CLR_B38b5:
        CLR r30.t15
        JMP DEL_B38b5

SET_B38b5:
        SET r30.t15
        JMP DEL_B38b5

DEL_B38b5:
        ADD r0, r0, 1
        QBNE DEL_B38b5, r0, r1

CLC_B38b6:
        MOV r0, 0
        LSR r4, r17, 18
        AND r4, r4, 1
        QBEQ SET_B38b6, r4, 1

CLR_B38b6:
        CLR r30.t15
        JMP DEL_B38b6

SET_B38b6:
        SET r30.t15
        JMP DEL_B38b6

DEL_B38b6:
        ADD r0, r0, 1
        QBNE DEL_B38b6, r0, r1

CLC_B38b7:
        MOV r0, 0
        LSR r4, r17, 17
        AND r4, r4, 1
        QBEQ SET_B38b7, r4, 1

CLR_B38b7:
        CLR r30.t15
        JMP DEL_B38b7

SET_B38b7:
        SET r30.t15
        JMP DEL_B38b7

DEL_B38b7:
        ADD r0, r0, 1
        QBNE DEL_B38b7, r0, r1

CLC_B38b8:
        MOV r0, 0
        LSR r4, r17, 16
        AND r4, r4, 1
        QBEQ SET_B38b8, r4, 1

CLR_B38b8:
        CLR r30.t15
        JMP DEL_B38b8

SET_B38b8:
        SET r30.t15
        JMP DEL_B38b8

BCK_B38b8:
		JMP BCK_B37b8

DEL_B38b8:
        ADD r0, r0, 1
        QBNE DEL_B38b8, r0, r1

CLC_B39b1:
        MOV r0, 0
        LSR r4, r17, 15
        AND r4, r4, 1
        QBEQ SET_B39b1, r4, 1

CLR_B39b1:
        CLR r30.t15
        JMP DEL_B39b1

SET_B39b1:
        SET r30.t15
        JMP DEL_B39b1

DEL_B39b1:
        ADD r0, r0, 1
        QBNE DEL_B39b1, r0, r1

CLC_B39b2:
        MOV r0, 0
        LSR r4, r17, 14
        AND r4, r4, 1
        QBEQ SET_B39b2, r4, 1

CLR_B39b2:
        CLR r30.t15
        JMP DEL_B39b2

SET_B39b2:
        SET r30.t15
        JMP DEL_B39b2

DEL_B39b2:
        ADD r0, r0, 1
        QBNE DEL_B39b2, r0, r1

CLC_B39b3:
        MOV r0, 0
        LSR r4, r17, 13
        AND r4, r4, 1
        QBEQ SET_B39b3, r4, 1

CLR_B39b3:
        CLR r30.t15
        JMP DEL_B39b3

SET_B39b3:
        SET r30.t15
        JMP DEL_B39b3

DEL_B39b3:
        ADD r0, r0, 1
        QBNE DEL_B39b3, r0, r1

CLC_B39b4:
        MOV r0, 0
        LSR r4, r17, 12
        AND r4, r4, 1
        QBEQ SET_B39b4, r4, 1

CLR_B39b4:
        CLR r30.t15
        JMP DEL_B39b4

SET_B39b4:
        SET r30.t15
        JMP DEL_B39b4

DEL_B39b4:
        ADD r0, r0, 1
        QBNE DEL_B39b4, r0, r1

CLC_B39b5:
        MOV r0, 0
        LSR r4, r17, 11
        AND r4, r4, 1
        QBEQ SET_B39b5, r4, 1

CLR_B39b5:
        CLR r30.t15
        JMP DEL_B39b5

SET_B39b5:
        SET r30.t15
        JMP DEL_B39b5

DEL_B39b5:
        ADD r0, r0, 1
        QBNE DEL_B39b5, r0, r1

CLC_B39b6:
        MOV r0, 0
        LSR r4, r17, 10
        AND r4, r4, 1
        QBEQ SET_B39b6, r4, 1

CLR_B39b6:
        CLR r30.t15
        JMP DEL_B39b6

SET_B39b6:
        SET r30.t15
        JMP DEL_B39b6

DEL_B39b6:
        ADD r0, r0, 1
        QBNE DEL_B39b6, r0, r1

CLC_B39b7:
        MOV r0, 0
        LSR r4, r17, 9
        AND r4, r4, 1
        QBEQ SET_B39b7, r4, 1

CLR_B39b7:
        CLR r30.t15
        JMP DEL_B39b7

SET_B39b7:
        SET r30.t15
        JMP DEL_B39b7

DEL_B39b7:
        ADD r0, r0, 1
        QBNE DEL_B39b7, r0, r1

CLC_B39b8:
        MOV r0, 0
        LSR r4, r17, 8
        AND r4, r4, 1
        QBEQ SET_B39b8, r4, 1

CLR_B39b8:
        CLR r30.t15
        JMP DEL_B39b8

SET_B39b8:
        SET r30.t15
        JMP DEL_B39b8

BCK_B39b8:
		JMP BCK_B38b8

DEL_B39b8:
        ADD r0, r0, 1
        QBNE DEL_B39b8, r0, r1

CLC_B40b1:
        MOV r0, 0
        LSR r4, r17, 7
        AND r4, r4, 1
        QBEQ SET_B40b1, r4, 1

CLR_B40b1:
        CLR r30.t15
        JMP DEL_B40b1

SET_B40b1:
        SET r30.t15
        JMP DEL_B40b1

DEL_B40b1:
        ADD r0, r0, 1
        QBNE DEL_B40b1, r0, r1

CLC_B40b2:
        MOV r0, 0
        LSR r4, r17, 6
        AND r4, r4, 1
        QBEQ SET_B40b2, r4, 1

CLR_B40b2:
        CLR r30.t15
        JMP DEL_B40b2

SET_B40b2:
        SET r30.t15
        JMP DEL_B40b2

DEL_B40b2:
        ADD r0, r0, 1
        QBNE DEL_B40b2, r0, r1

CLC_B40b3:
        MOV r0, 0
        LSR r4, r17, 5
        AND r4, r4, 1
        QBEQ SET_B40b3, r4, 1

CLR_B40b3:
        CLR r30.t15
        JMP DEL_B40b3

SET_B40b3:
        SET r30.t15
        JMP DEL_B40b3

DEL_B40b3:
        ADD r0, r0, 1
        QBNE DEL_B40b3, r0, r1

CLC_B40b4:
        MOV r0, 0
        LSR r4, r17, 4
        AND r4, r4, 1
        QBEQ SET_B40b4, r4, 1

CLR_B40b4:
        CLR r30.t15
        JMP DEL_B40b4

SET_B40b4:
        SET r30.t15
        JMP DEL_B40b4

DEL_B40b4:
        ADD r0, r0, 1
        QBNE DEL_B40b4, r0, r1

CLC_B40b5:
        MOV r0, 0
        LSR r4, r17, 3
        AND r4, r4, 1
        QBEQ SET_B40b5, r4, 1

CLR_B40b5:
        CLR r30.t15
        JMP DEL_B40b5

SET_B40b5:
        SET r30.t15
        JMP DEL_B40b5

DEL_B40b5:
        ADD r0, r0, 1
        QBNE DEL_B40b5, r0, r1

CLC_B40b6:
        MOV r0, 0
        LSR r4, r17, 2
        AND r4, r4, 1
        QBEQ SET_B40b6, r4, 1

CLR_B40b6:
        CLR r30.t15
        JMP DEL_B40b6

SET_B40b6:
        SET r30.t15
        JMP DEL_B40b6

DEL_B40b6:
        ADD r0, r0, 1
        QBNE DEL_B40b6, r0, r1

CLC_B40b7:
        MOV r0, 0
        LSR r4, r17, 1
        AND r4, r4, 1
        QBEQ SET_B40b7, r4, 1

CLR_B40b7:
        CLR r30.t15
        JMP DEL_B40b7

SET_B40b7:
        SET r30.t15
        JMP DEL_B40b7

DEL_B40b7:
        ADD r0, r0, 1
        QBNE DEL_B40b7, r0, r1

CLC_B40b8:
        MOV r0, 0
        LSR r4, r17, 0
        AND r4, r4, 1
        QBEQ SET_B40b8, r4, 1

CLR_B40b8:
        CLR r30.t15
        JMP DEL_B40b8

SET_B40b8:
        SET r30.t15
        JMP DEL_B40b8

BCK_B40b8:
		JMP BCK_B39b8

DEL_B40b8:
        ADD r0, r0, 1
        QBNE DEL_B40b8, r0, r1

CLC_B41b1:
        MOV r0, 0
        LSR r4, r18, 31
        AND r4, r4, 1
        QBEQ SET_B41b1, r4, 1

CLR_B41b1:
        CLR r30.t15
        JMP DEL_B41b1

SET_B41b1:
        SET r30.t15
        JMP DEL_B41b1

DEL_B41b1:
        ADD r0, r0, 1
        QBNE DEL_B41b1, r0, r1

CLC_B41b2:
        MOV r0, 0
        LSR r4, r18, 30
        AND r4, r4, 1
        QBEQ SET_B41b2, r4, 1

CLR_B41b2:
        CLR r30.t15
        JMP DEL_B41b2

SET_B41b2:
        SET r30.t15
        JMP DEL_B41b2

DEL_B41b2:
        ADD r0, r0, 1
        QBNE DEL_B41b2, r0, r1

CLC_B41b3:
        MOV r0, 0
        LSR r4, r18, 29
        AND r4, r4, 1
        QBEQ SET_B41b3, r4, 1

CLR_B41b3:
        CLR r30.t15
        JMP DEL_B41b3

SET_B41b3:
        SET r30.t15
        JMP DEL_B41b3

DEL_B41b3:
        ADD r0, r0, 1
        QBNE DEL_B41b3, r0, r1

CLC_B41b4:
        MOV r0, 0
        LSR r4, r18, 28
        AND r4, r4, 1
        QBEQ SET_B41b4, r4, 1

CLR_B41b4:
        CLR r30.t15
        JMP DEL_B41b4

SET_B41b4:
        SET r30.t15
        JMP DEL_B41b4

DEL_B41b4:
        ADD r0, r0, 1
        QBNE DEL_B41b4, r0, r1

CLC_B41b5:
        MOV r0, 0
        LSR r4, r18, 27
        AND r4, r4, 1
        QBEQ SET_B41b5, r4, 1

CLR_B41b5:
        CLR r30.t15
        JMP DEL_B41b5

SET_B41b5:
        SET r30.t15
        JMP DEL_B41b5

DEL_B41b5:
        ADD r0, r0, 1
        QBNE DEL_B41b5, r0, r1

CLC_B41b6:
        MOV r0, 0
        LSR r4, r18, 26
        AND r4, r4, 1
        QBEQ SET_B41b6, r4, 1

CLR_B41b6:
        CLR r30.t15
        JMP DEL_B41b6

SET_B41b6:
        SET r30.t15
        JMP DEL_B41b6

DEL_B41b6:
        ADD r0, r0, 1
        QBNE DEL_B41b6, r0, r1

CLC_B41b7:
        MOV r0, 0
        LSR r4, r18, 25
        AND r4, r4, 1
        QBEQ SET_B41b7, r4, 1

CLR_B41b7:
        CLR r30.t15
        JMP DEL_B41b7

SET_B41b7:
        SET r30.t15
        JMP DEL_B41b7

DEL_B41b7:
        ADD r0, r0, 1
        QBNE DEL_B41b7, r0, r1

CLC_B41b8:
        MOV r0, 0
        LSR r4, r18, 24
        AND r4, r4, 1
        QBEQ SET_B41b8, r4, 1

CLR_B41b8:
        CLR r30.t15
        JMP DEL_B41b8

SET_B41b8:
        SET r30.t15
        JMP DEL_B41b8

BCK_B41b8:
		JMP BCK_B40b8

DEL_B41b8:
        ADD r0, r0, 1
        QBNE DEL_B41b8, r0, r1

CLC_B42b1:
        MOV r0, 0
        LSR r4, r18, 23
        AND r4, r4, 1
        QBEQ SET_B42b1, r4, 1

CLR_B42b1:
        CLR r30.t15
        JMP DEL_B42b1

SET_B42b1:
        SET r30.t15
        JMP DEL_B42b1

DEL_B42b1:
        ADD r0, r0, 1
        QBNE DEL_B42b1, r0, r1

CLC_B42b2:
        MOV r0, 0
        LSR r4, r18, 22
        AND r4, r4, 1
        QBEQ SET_B42b2, r4, 1

CLR_B42b2:
        CLR r30.t15
        JMP DEL_B42b2

SET_B42b2:
        SET r30.t15
        JMP DEL_B42b2

DEL_B42b2:
        ADD r0, r0, 1
        QBNE DEL_B42b2, r0, r1

CLC_B42b3:
        MOV r0, 0
        LSR r4, r18, 21
        AND r4, r4, 1
        QBEQ SET_B42b3, r4, 1

CLR_B42b3:
        CLR r30.t15
        JMP DEL_B42b3

SET_B42b3:
        SET r30.t15
        JMP DEL_B42b3

DEL_B42b3:
        ADD r0, r0, 1
        QBNE DEL_B42b3, r0, r1

CLC_B42b4:
        MOV r0, 0
        LSR r4, r18, 20
        AND r4, r4, 1
        QBEQ SET_B42b4, r4, 1

CLR_B42b4:
        CLR r30.t15
        JMP DEL_B42b4

SET_B42b4:
        SET r30.t15
        JMP DEL_B42b4

DEL_B42b4:
        ADD r0, r0, 1
        QBNE DEL_B42b4, r0, r1

CLC_B42b5:
        MOV r0, 0
        LSR r4, r18, 19
        AND r4, r4, 1
        QBEQ SET_B42b5, r4, 1

CLR_B42b5:
        CLR r30.t15
        JMP DEL_B42b5

SET_B42b5:
        SET r30.t15
        JMP DEL_B42b5

DEL_B42b5:
        ADD r0, r0, 1
        QBNE DEL_B42b5, r0, r1

CLC_B42b6:
        MOV r0, 0
        LSR r4, r18, 18
        AND r4, r4, 1
        QBEQ SET_B42b6, r4, 1

CLR_B42b6:
        CLR r30.t15
        JMP DEL_B42b6

SET_B42b6:
        SET r30.t15
        JMP DEL_B42b6

DEL_B42b6:
        ADD r0, r0, 1
        QBNE DEL_B42b6, r0, r1

CLC_B42b7:
        MOV r0, 0
        LSR r4, r18, 17
        AND r4, r4, 1
        QBEQ SET_B42b7, r4, 1

CLR_B42b7:
        CLR r30.t15
        JMP DEL_B42b7

SET_B42b7:
        SET r30.t15
        JMP DEL_B42b7

DEL_B42b7:
        ADD r0, r0, 1
        QBNE DEL_B42b7, r0, r1

CLC_B42b8:
        MOV r0, 0
        LSR r4, r18, 16
        AND r4, r4, 1
        QBEQ SET_B42b8, r4, 1

CLR_B42b8:
        CLR r30.t15
        JMP DEL_B42b8

SET_B42b8:
        SET r30.t15
        JMP DEL_B42b8

BCK_B42b8:
		JMP BCK_B41b8

DEL_B42b8:
        ADD r0, r0, 1
        QBNE DEL_B42b8, r0, r1

CLC_B43b1:
        MOV r0, 0
        LSR r4, r18, 15
        AND r4, r4, 1
        QBEQ SET_B43b1, r4, 1

CLR_B43b1:
        CLR r30.t15
        JMP DEL_B43b1

SET_B43b1:
        SET r30.t15
        JMP DEL_B43b1

DEL_B43b1:
        ADD r0, r0, 1
        QBNE DEL_B43b1, r0, r1

CLC_B43b2:
        MOV r0, 0
        LSR r4, r18, 14
        AND r4, r4, 1
        QBEQ SET_B43b2, r4, 1

CLR_B43b2:
        CLR r30.t15
        JMP DEL_B43b2

SET_B43b2:
        SET r30.t15
        JMP DEL_B43b2

DEL_B43b2:
        ADD r0, r0, 1
        QBNE DEL_B43b2, r0, r1

CLC_B43b3:
        MOV r0, 0
        LSR r4, r18, 13
        AND r4, r4, 1
        QBEQ SET_B43b3, r4, 1

CLR_B43b3:
        CLR r30.t15
        JMP DEL_B43b3

SET_B43b3:
        SET r30.t15
        JMP DEL_B43b3

DEL_B43b3:
        ADD r0, r0, 1
        QBNE DEL_B43b3, r0, r1

CLC_B43b4:
        MOV r0, 0
        LSR r4, r18, 12
        AND r4, r4, 1
        QBEQ SET_B43b4, r4, 1

CLR_B43b4:
        CLR r30.t15
        JMP DEL_B43b4

SET_B43b4:
        SET r30.t15
        JMP DEL_B43b4

DEL_B43b4:
        ADD r0, r0, 1
        QBNE DEL_B43b4, r0, r1

CLC_B43b5:
        MOV r0, 0
        LSR r4, r18, 11
        AND r4, r4, 1
        QBEQ SET_B43b5, r4, 1

CLR_B43b5:
        CLR r30.t15
        JMP DEL_B43b5

SET_B43b5:
        SET r30.t15
        JMP DEL_B43b5

DEL_B43b5:
        ADD r0, r0, 1
        QBNE DEL_B43b5, r0, r1

CLC_B43b6:
        MOV r0, 0
        LSR r4, r18, 10
        AND r4, r4, 1
        QBEQ SET_B43b6, r4, 1

CLR_B43b6:
        CLR r30.t15
        JMP DEL_B43b6

SET_B43b6:
        SET r30.t15
        JMP DEL_B43b6

DEL_B43b6:
        ADD r0, r0, 1
        QBNE DEL_B43b6, r0, r1

CLC_B43b7:
        MOV r0, 0
        LSR r4, r18, 9
        AND r4, r4, 1
        QBEQ SET_B43b7, r4, 1

CLR_B43b7:
        CLR r30.t15
        JMP DEL_B43b7

SET_B43b7:
        SET r30.t15
        JMP DEL_B43b7

DEL_B43b7:
        ADD r0, r0, 1
        QBNE DEL_B43b7, r0, r1

CLC_B43b8:
        MOV r0, 0
        LSR r4, r18, 8
        AND r4, r4, 1
        QBEQ SET_B43b8, r4, 1

CLR_B43b8:
        CLR r30.t15
        JMP DEL_B43b8

SET_B43b8:
        SET r30.t15
        JMP DEL_B43b8

BCK_B43b8:
		JMP BCK_B42b8

DEL_B43b8:
        ADD r0, r0, 1
        QBNE DEL_B43b8, r0, r1

CLC_B44b1:
        MOV r0, 0
        LSR r4, r18, 7
        AND r4, r4, 1
        QBEQ SET_B44b1, r4, 1

CLR_B44b1:
        CLR r30.t15
        JMP DEL_B44b1

SET_B44b1:
        SET r30.t15
        JMP DEL_B44b1

DEL_B44b1:
        ADD r0, r0, 1
        QBNE DEL_B44b1, r0, r1

CLC_B44b2:
        MOV r0, 0
        LSR r4, r18, 6
        AND r4, r4, 1
        QBEQ SET_B44b2, r4, 1

CLR_B44b2:
        CLR r30.t15
        JMP DEL_B44b2

SET_B44b2:
        SET r30.t15
        JMP DEL_B44b2

DEL_B44b2:
        ADD r0, r0, 1
        QBNE DEL_B44b2, r0, r1

CLC_B44b3:
        MOV r0, 0
        LSR r4, r18, 5
        AND r4, r4, 1
        QBEQ SET_B44b3, r4, 1

CLR_B44b3:
        CLR r30.t15
        JMP DEL_B44b3

SET_B44b3:
        SET r30.t15
        JMP DEL_B44b3

DEL_B44b3:
        ADD r0, r0, 1
        QBNE DEL_B44b3, r0, r1

CLC_B44b4:
        MOV r0, 0
        LSR r4, r18, 4
        AND r4, r4, 1
        QBEQ SET_B44b4, r4, 1

CLR_B44b4:
        CLR r30.t15
        JMP DEL_B44b4

SET_B44b4:
        SET r30.t15
        JMP DEL_B44b4

DEL_B44b4:
        ADD r0, r0, 1
        QBNE DEL_B44b4, r0, r1

CLC_B44b5:
        MOV r0, 0
        LSR r4, r18, 3
        AND r4, r4, 1
        QBEQ SET_B44b5, r4, 1

CLR_B44b5:
        CLR r30.t15
        JMP DEL_B44b5

SET_B44b5:
        SET r30.t15
        JMP DEL_B44b5

DEL_B44b5:
        ADD r0, r0, 1
        QBNE DEL_B44b5, r0, r1

CLC_B44b6:
        MOV r0, 0
        LSR r4, r18, 2
        AND r4, r4, 1
        QBEQ SET_B44b6, r4, 1

CLR_B44b6:
        CLR r30.t15
        JMP DEL_B44b6

SET_B44b6:
        SET r30.t15
        JMP DEL_B44b6

DEL_B44b6:
        ADD r0, r0, 1
        QBNE DEL_B44b6, r0, r1

CLC_B44b7:
        MOV r0, 0
        LSR r4, r18, 1
        AND r4, r4, 1
        QBEQ SET_B44b7, r4, 1

CLR_B44b7:
        CLR r30.t15
        JMP DEL_B44b7

SET_B44b7:
        SET r30.t15
        JMP DEL_B44b7

DEL_B44b7:
        ADD r0, r0, 1
        QBNE DEL_B44b7, r0, r1

CLC_B44b8:
        MOV r0, 0
        LSR r4, r18, 0
        AND r4, r4, 1
        QBEQ SET_B44b8, r4, 1

CLR_B44b8:
        CLR r30.t15
        JMP DEL_B44b8

SET_B44b8:
        SET r30.t15
        JMP DEL_B44b8

BCK_B44b8:
		JMP BCK_B43b8

DEL_B44b8:
        ADD r0, r0, 1
        QBNE DEL_B44b8, r0, r1

CLC_B45b1:
        MOV r0, 0
        LSR r4, r19, 31
        AND r4, r4, 1
        QBEQ SET_B45b1, r4, 1

CLR_B45b1:
        CLR r30.t15
        JMP DEL_B45b1

SET_B45b1:
        SET r30.t15
        JMP DEL_B45b1

DEL_B45b1:
        ADD r0, r0, 1
        QBNE DEL_B45b1, r0, r1

CLC_B45b2:
        MOV r0, 0
        LSR r4, r19, 30
        AND r4, r4, 1
        QBEQ SET_B45b2, r4, 1

CLR_B45b2:
        CLR r30.t15
        JMP DEL_B45b2

SET_B45b2:
        SET r30.t15
        JMP DEL_B45b2

DEL_B45b2:
        ADD r0, r0, 1
        QBNE DEL_B45b2, r0, r1

CLC_B45b3:
        MOV r0, 0
        LSR r4, r19, 29
        AND r4, r4, 1
        QBEQ SET_B45b3, r4, 1

CLR_B45b3:
        CLR r30.t15
        JMP DEL_B45b3

SET_B45b3:
        SET r30.t15
        JMP DEL_B45b3

DEL_B45b3:
        ADD r0, r0, 1
        QBNE DEL_B45b3, r0, r1

CLC_B45b4:
        MOV r0, 0
        LSR r4, r19, 28
        AND r4, r4, 1
        QBEQ SET_B45b4, r4, 1

CLR_B45b4:
        CLR r30.t15
        JMP DEL_B45b4

SET_B45b4:
        SET r30.t15
        JMP DEL_B45b4

DEL_B45b4:
        ADD r0, r0, 1
        QBNE DEL_B45b4, r0, r1

CLC_B45b5:
        MOV r0, 0
        LSR r4, r19, 27
        AND r4, r4, 1
        QBEQ SET_B45b5, r4, 1

CLR_B45b5:
        CLR r30.t15
        JMP DEL_B45b5

SET_B45b5:
        SET r30.t15
        JMP DEL_B45b5

DEL_B45b5:
        ADD r0, r0, 1
        QBNE DEL_B45b5, r0, r1

CLC_B45b6:
        MOV r0, 0
        LSR r4, r19, 26
        AND r4, r4, 1
        QBEQ SET_B45b6, r4, 1

CLR_B45b6:
        CLR r30.t15
        JMP DEL_B45b6

SET_B45b6:
        SET r30.t15
        JMP DEL_B45b6

DEL_B45b6:
        ADD r0, r0, 1
        QBNE DEL_B45b6, r0, r1

CLC_B45b7:
        MOV r0, 0
        LSR r4, r19, 25
        AND r4, r4, 1
        QBEQ SET_B45b7, r4, 1

CLR_B45b7:
        CLR r30.t15
        JMP DEL_B45b7

SET_B45b7:
        SET r30.t15
        JMP DEL_B45b7

DEL_B45b7:
        ADD r0, r0, 1
        QBNE DEL_B45b7, r0, r1

CLC_B45b8:
        MOV r0, 0
        LSR r4, r19, 24
        AND r4, r4, 1
        QBEQ SET_B45b8, r4, 1

CLR_B45b8:
        CLR r30.t15
        JMP DEL_B45b8

SET_B45b8:
        SET r30.t15
        JMP DEL_B45b8

BCK_B45b8:
		JMP BCK_B44b8

DEL_B45b8:
        ADD r0, r0, 1
        QBNE DEL_B45b8, r0, r1

CLC_B46b1:
        MOV r0, 0
        LSR r4, r19, 23
        AND r4, r4, 1
        QBEQ SET_B46b1, r4, 1

CLR_B46b1:
        CLR r30.t15
        JMP DEL_B46b1

SET_B46b1:
        SET r30.t15
        JMP DEL_B46b1

DEL_B46b1:
        ADD r0, r0, 1
        QBNE DEL_B46b1, r0, r1

CLC_B46b2:
        MOV r0, 0
        LSR r4, r19, 22
        AND r4, r4, 1
        QBEQ SET_B46b2, r4, 1

CLR_B46b2:
        CLR r30.t15
        JMP DEL_B46b2

SET_B46b2:
        SET r30.t15
        JMP DEL_B46b2

DEL_B46b2:
        ADD r0, r0, 1
        QBNE DEL_B46b2, r0, r1

CLC_B46b3:
        MOV r0, 0
        LSR r4, r19, 21
        AND r4, r4, 1
        QBEQ SET_B46b3, r4, 1

CLR_B46b3:
        CLR r30.t15
        JMP DEL_B46b3

SET_B46b3:
        SET r30.t15
        JMP DEL_B46b3

DEL_B46b3:
        ADD r0, r0, 1
        QBNE DEL_B46b3, r0, r1

CLC_B46b4:
        MOV r0, 0
        LSR r4, r19, 20
        AND r4, r4, 1
        QBEQ SET_B46b4, r4, 1

CLR_B46b4:
        CLR r30.t15
        JMP DEL_B46b4

SET_B46b4:
        SET r30.t15
        JMP DEL_B46b4

DEL_B46b4:
        ADD r0, r0, 1
        QBNE DEL_B46b4, r0, r1

CLC_B46b5:
        MOV r0, 0
        LSR r4, r19, 19
        AND r4, r4, 1
        QBEQ SET_B46b5, r4, 1

CLR_B46b5:
        CLR r30.t15
        JMP DEL_B46b5

SET_B46b5:
        SET r30.t15
        JMP DEL_B46b5

DEL_B46b5:
        ADD r0, r0, 1
        QBNE DEL_B46b5, r0, r1

CLC_B46b6:
        MOV r0, 0
        LSR r4, r19, 18
        AND r4, r4, 1
        QBEQ SET_B46b6, r4, 1

CLR_B46b6:
        CLR r30.t15
        JMP DEL_B46b6

SET_B46b6:
        SET r30.t15
        JMP DEL_B46b6

DEL_B46b6:
        ADD r0, r0, 1
        QBNE DEL_B46b6, r0, r1

CLC_B46b7:
        MOV r0, 0
        LSR r4, r19, 17
        AND r4, r4, 1
        QBEQ SET_B46b7, r4, 1

CLR_B46b7:
        CLR r30.t15
        JMP DEL_B46b7

SET_B46b7:
        SET r30.t15
        JMP DEL_B46b7

DEL_B46b7:
        ADD r0, r0, 1
        QBNE DEL_B46b7, r0, r1

CLC_B46b8:
        MOV r0, 0
        LSR r4, r19, 16
        AND r4, r4, 1
        QBEQ SET_B46b8, r4, 1

CLR_B46b8:
        CLR r30.t15
        JMP DEL_B46b8

SET_B46b8:
        SET r30.t15
        JMP DEL_B46b8

BCK_B46b8:
		JMP BCK_B45b8

DEL_B46b8:
        ADD r0, r0, 1
        QBNE DEL_B46b8, r0, r1

CLC_B47b1:
        MOV r0, 0
        LSR r4, r19, 15
        AND r4, r4, 1
        QBEQ SET_B47b1, r4, 1

CLR_B47b1:
        CLR r30.t15
        JMP DEL_B47b1

SET_B47b1:
        SET r30.t15
        JMP DEL_B47b1

DEL_B47b1:
        ADD r0, r0, 1
        QBNE DEL_B47b1, r0, r1

CLC_B47b2:
        MOV r0, 0
        LSR r4, r19, 14
        AND r4, r4, 1
        QBEQ SET_B47b2, r4, 1

CLR_B47b2:
        CLR r30.t15
        JMP DEL_B47b2

SET_B47b2:
        SET r30.t15
        JMP DEL_B47b2

DEL_B47b2:
        ADD r0, r0, 1
        QBNE DEL_B47b2, r0, r1

CLC_B47b3:
        MOV r0, 0
        LSR r4, r19, 13
        AND r4, r4, 1
        QBEQ SET_B47b3, r4, 1

CLR_B47b3:
        CLR r30.t15
        JMP DEL_B47b3

SET_B47b3:
        SET r30.t15
        JMP DEL_B47b3

DEL_B47b3:
        ADD r0, r0, 1
        QBNE DEL_B47b3, r0, r1

CLC_B47b4:
        MOV r0, 0
        LSR r4, r19, 12
        AND r4, r4, 1
        QBEQ SET_B47b4, r4, 1

CLR_B47b4:
        CLR r30.t15
        JMP DEL_B47b4

SET_B47b4:
        SET r30.t15
        JMP DEL_B47b4

DEL_B47b4:
        ADD r0, r0, 1
        QBNE DEL_B47b4, r0, r1

CLC_B47b5:
        MOV r0, 0
        LSR r4, r19, 11
        AND r4, r4, 1
        QBEQ SET_B47b5, r4, 1

CLR_B47b5:
        CLR r30.t15
        JMP DEL_B47b5

SET_B47b5:
        SET r30.t15
        JMP DEL_B47b5

DEL_B47b5:
        ADD r0, r0, 1
        QBNE DEL_B47b5, r0, r1

CLC_B47b6:
        MOV r0, 0
        LSR r4, r19, 10
        AND r4, r4, 1
        QBEQ SET_B47b6, r4, 1

CLR_B47b6:
        CLR r30.t15
        JMP DEL_B47b6

SET_B47b6:
        SET r30.t15
        JMP DEL_B47b6

DEL_B47b6:
        ADD r0, r0, 1
        QBNE DEL_B47b6, r0, r1

CLC_B47b7:
        MOV r0, 0
        LSR r4, r19, 9
        AND r4, r4, 1
        QBEQ SET_B47b7, r4, 1

CLR_B47b7:
        CLR r30.t15
        JMP DEL_B47b7

SET_B47b7:
        SET r30.t15
        JMP DEL_B47b7

DEL_B47b7:
        ADD r0, r0, 1
        QBNE DEL_B47b7, r0, r1

CLC_B47b8:
        MOV r0, 0
        LSR r4, r19, 8
        AND r4, r4, 1
        QBEQ SET_B47b8, r4, 1

CLR_B47b8:
        CLR r30.t15
        JMP DEL_B47b8

SET_B47b8:
        SET r30.t15
        JMP DEL_B47b8

BCK_B47b8:
		JMP BCK_B46b8

DEL_B47b8:
        ADD r0, r0, 1
        QBNE DEL_B47b8, r0, r1

CLC_B48b1:
        MOV r0, 0
        LSR r4, r19, 7
        AND r4, r4, 1
        QBEQ SET_B48b1, r4, 1

CLR_B48b1:
        CLR r30.t15
        JMP DEL_B48b1

SET_B48b1:
        SET r30.t15
        JMP DEL_B48b1

DEL_B48b1:
        ADD r0, r0, 1
        QBNE DEL_B48b1, r0, r1

CLC_B48b2:
        MOV r0, 0
        LSR r4, r19, 6
        AND r4, r4, 1
        QBEQ SET_B48b2, r4, 1

CLR_B48b2:
        CLR r30.t15
        JMP DEL_B48b2

SET_B48b2:
        SET r30.t15
        JMP DEL_B48b2

DEL_B48b2:
        ADD r0, r0, 1
        QBNE DEL_B48b2, r0, r1

CLC_B48b3:
        MOV r0, 0
        LSR r4, r19, 5
        AND r4, r4, 1
        QBEQ SET_B48b3, r4, 1

CLR_B48b3:
        CLR r30.t15
        JMP DEL_B48b3

SET_B48b3:
        SET r30.t15
        JMP DEL_B48b3

DEL_B48b3:
        ADD r0, r0, 1
        QBNE DEL_B48b3, r0, r1

CLC_B48b4:
        MOV r0, 0
        LSR r4, r19, 4
        AND r4, r4, 1
        QBEQ SET_B48b4, r4, 1

CLR_B48b4:
        CLR r30.t15
        JMP DEL_B48b4

SET_B48b4:
        SET r30.t15
        JMP DEL_B48b4

DEL_B48b4:
        ADD r0, r0, 1
        QBNE DEL_B48b4, r0, r1

CLC_B48b5:
        MOV r0, 0
        LSR r4, r19, 3
        AND r4, r4, 1
        QBEQ SET_B48b5, r4, 1

CLR_B48b5:
        CLR r30.t15
        JMP DEL_B48b5

SET_B48b5:
        SET r30.t15
        JMP DEL_B48b5

DEL_B48b5:
        ADD r0, r0, 1
        QBNE DEL_B48b5, r0, r1

CLC_B48b6:
        MOV r0, 0
        LSR r4, r19, 2
        AND r4, r4, 1
        QBEQ SET_B48b6, r4, 1

CLR_B48b6:
        CLR r30.t15
        JMP DEL_B48b6

SET_B48b6:
        SET r30.t15
        JMP DEL_B48b6

DEL_B48b6:
        ADD r0, r0, 1
        QBNE DEL_B48b6, r0, r1

CLC_B48b7:
        MOV r0, 0
        LSR r4, r19, 1
        AND r4, r4, 1
        QBEQ SET_B48b7, r4, 1

CLR_B48b7:
        CLR r30.t15
        JMP DEL_B48b7

SET_B48b7:
        SET r30.t15
        JMP DEL_B48b7

DEL_B48b7:
        ADD r0, r0, 1
        QBNE DEL_B48b7, r0, r1

CLC_B48b8:
        MOV r0, 0
        LSR r4, r19, 0
        AND r4, r4, 1
        QBEQ SET_B48b8, r4, 1

CLR_B48b8:
        CLR r30.t15
        JMP DEL_B48b8

SET_B48b8:
        SET r30.t15
        JMP DEL_B48b8

BCK_B48b8:
		JMP BCK_B47b8

DEL_B48b8:
        ADD r0, r0, 1
        QBNE DEL_B48b8, r0, r1

CLC_B49b1:
        MOV r0, 0
        LSR r4, r20, 31
        AND r4, r4, 1
        QBEQ SET_B49b1, r4, 1

CLR_B49b1:
        CLR r30.t15
        JMP DEL_B49b1

SET_B49b1:
        SET r30.t15
        JMP DEL_B49b1

DEL_B49b1:
        ADD r0, r0, 1
        QBNE DEL_B49b1, r0, r1

CLC_B49b2:
        MOV r0, 0
        LSR r4, r20, 30
        AND r4, r4, 1
        QBEQ SET_B49b2, r4, 1

CLR_B49b2:
        CLR r30.t15
        JMP DEL_B49b2

SET_B49b2:
        SET r30.t15
        JMP DEL_B49b2

DEL_B49b2:
        ADD r0, r0, 1
        QBNE DEL_B49b2, r0, r1

CLC_B49b3:
        MOV r0, 0
        LSR r4, r20, 29
        AND r4, r4, 1
        QBEQ SET_B49b3, r4, 1

CLR_B49b3:
        CLR r30.t15
        JMP DEL_B49b3

SET_B49b3:
        SET r30.t15
        JMP DEL_B49b3

DEL_B49b3:
        ADD r0, r0, 1
        QBNE DEL_B49b3, r0, r1

CLC_B49b4:
        MOV r0, 0
        LSR r4, r20, 28
        AND r4, r4, 1
        QBEQ SET_B49b4, r4, 1

CLR_B49b4:
        CLR r30.t15
        JMP DEL_B49b4

SET_B49b4:
        SET r30.t15
        JMP DEL_B49b4

DEL_B49b4:
        ADD r0, r0, 1
        QBNE DEL_B49b4, r0, r1

CLC_B49b5:
        MOV r0, 0
        LSR r4, r20, 27
        AND r4, r4, 1
        QBEQ SET_B49b5, r4, 1

CLR_B49b5:
        CLR r30.t15
        JMP DEL_B49b5

SET_B49b5:
        SET r30.t15
        JMP DEL_B49b5

DEL_B49b5:
        ADD r0, r0, 1
        QBNE DEL_B49b5, r0, r1

CLC_B49b6:
        MOV r0, 0
        LSR r4, r20, 26
        AND r4, r4, 1
        QBEQ SET_B49b6, r4, 1

CLR_B49b6:
        CLR r30.t15
        JMP DEL_B49b6

SET_B49b6:
        SET r30.t15
        JMP DEL_B49b6

DEL_B49b6:
        ADD r0, r0, 1
        QBNE DEL_B49b6, r0, r1

CLC_B49b7:
        MOV r0, 0
        LSR r4, r20, 25
        AND r4, r4, 1
        QBEQ SET_B49b7, r4, 1

CLR_B49b7:
        CLR r30.t15
        JMP DEL_B49b7

SET_B49b7:
        SET r30.t15
        JMP DEL_B49b7

DEL_B49b7:
        ADD r0, r0, 1
        QBNE DEL_B49b7, r0, r1

CLC_B49b8:
        MOV r0, 0
        LSR r4, r20, 24
        AND r4, r4, 1
        QBEQ SET_B49b8, r4, 1

CLR_B49b8:
        CLR r30.t15
        JMP DEL_B49b8

SET_B49b8:
        SET r30.t15
        JMP DEL_B49b8

BCK_B49b8:
		JMP BCK_B48b8

DEL_B49b8:
        ADD r0, r0, 1
        QBNE DEL_B49b8, r0, r1

CLC_B50b1:
        MOV r0, 0
        LSR r4, r20, 23
        AND r4, r4, 1
        QBEQ SET_B50b1, r4, 1

CLR_B50b1:
        CLR r30.t15
        JMP DEL_B50b1

SET_B50b1:
        SET r30.t15
        JMP DEL_B50b1

DEL_B50b1:
        ADD r0, r0, 1
        QBNE DEL_B50b1, r0, r1

CLC_B50b2:
        MOV r0, 0
        LSR r4, r20, 22
        AND r4, r4, 1
        QBEQ SET_B50b2, r4, 1

CLR_B50b2:
        CLR r30.t15
        JMP DEL_B50b2

SET_B50b2:
        SET r30.t15
        JMP DEL_B50b2

DEL_B50b2:
        ADD r0, r0, 1
        QBNE DEL_B50b2, r0, r1

CLC_B50b3:
        MOV r0, 0
        LSR r4, r20, 21
        AND r4, r4, 1
        QBEQ SET_B50b3, r4, 1

CLR_B50b3:
        CLR r30.t15
        JMP DEL_B50b3

SET_B50b3:
        SET r30.t15
        JMP DEL_B50b3

DEL_B50b3:
        ADD r0, r0, 1
        QBNE DEL_B50b3, r0, r1

CLC_B50b4:
        MOV r0, 0
        LSR r4, r20, 20
        AND r4, r4, 1
        QBEQ SET_B50b4, r4, 1

CLR_B50b4:
        CLR r30.t15
        JMP DEL_B50b4

SET_B50b4:
        SET r30.t15
        JMP DEL_B50b4

DEL_B50b4:
        ADD r0, r0, 1
        QBNE DEL_B50b4, r0, r1

CLC_B50b5:
        MOV r0, 0
        LSR r4, r20, 19
        AND r4, r4, 1
        QBEQ SET_B50b5, r4, 1

CLR_B50b5:
        CLR r30.t15
        JMP DEL_B50b5

SET_B50b5:
        SET r30.t15
        JMP DEL_B50b5

DEL_B50b5:
        ADD r0, r0, 1
        QBNE DEL_B50b5, r0, r1

CLC_B50b6:
        MOV r0, 0
        LSR r4, r20, 18
        AND r4, r4, 1
        QBEQ SET_B50b6, r4, 1

CLR_B50b6:
        CLR r30.t15
        JMP DEL_B50b6

SET_B50b6:
        SET r30.t15
        JMP DEL_B50b6

DEL_B50b6:
        ADD r0, r0, 1
        QBNE DEL_B50b6, r0, r1

CLC_B50b7:
        MOV r0, 0
        LSR r4, r20, 17
        AND r4, r4, 1
        QBEQ SET_B50b7, r4, 1

CLR_B50b7:
        CLR r30.t15
        JMP DEL_B50b7

SET_B50b7:
        SET r30.t15
        JMP DEL_B50b7

DEL_B50b7:
        ADD r0, r0, 1
        QBNE DEL_B50b7, r0, r1

CLC_B50b8:
        MOV r0, 0
        LSR r4, r20, 16
        AND r4, r4, 1
        QBEQ SET_B50b8, r4, 1

CLR_B50b8:
        CLR r30.t15
        JMP DEL_B50b8

SET_B50b8:
        SET r30.t15
        JMP DEL_B50b8

BCK_B50b8:
		JMP BCK_B49b8

DEL_B50b8:
        ADD r0, r0, 1
        QBNE DEL_B50b8, r0, r1

CLC_B51b1:
        MOV r0, 0
        LSR r4, r20, 15
        AND r4, r4, 1
        QBEQ SET_B51b1, r4, 1

CLR_B51b1:
        CLR r30.t15
        JMP DEL_B51b1

SET_B51b1:
        SET r30.t15
        JMP DEL_B51b1

DEL_B51b1:
        ADD r0, r0, 1
        QBNE DEL_B51b1, r0, r1

CLC_B51b2:
        MOV r0, 0
        LSR r4, r20, 14
        AND r4, r4, 1
        QBEQ SET_B51b2, r4, 1

CLR_B51b2:
        CLR r30.t15
        JMP DEL_B51b2

SET_B51b2:
        SET r30.t15
        JMP DEL_B51b2

DEL_B51b2:
        ADD r0, r0, 1
        QBNE DEL_B51b2, r0, r1

CLC_B51b3:
        MOV r0, 0
        LSR r4, r20, 13
        AND r4, r4, 1
        QBEQ SET_B51b3, r4, 1

CLR_B51b3:
        CLR r30.t15
        JMP DEL_B51b3

SET_B51b3:
        SET r30.t15
        JMP DEL_B51b3

DEL_B51b3:
        ADD r0, r0, 1
        QBNE DEL_B51b3, r0, r1

CLC_B51b4:
        MOV r0, 0
        LSR r4, r20, 12
        AND r4, r4, 1
        QBEQ SET_B51b4, r4, 1

CLR_B51b4:
        CLR r30.t15
        JMP DEL_B51b4

SET_B51b4:
        SET r30.t15
        JMP DEL_B51b4

DEL_B51b4:
        ADD r0, r0, 1
        QBNE DEL_B51b4, r0, r1

CLC_B51b5:
        MOV r0, 0
        LSR r4, r20, 11
        AND r4, r4, 1
        QBEQ SET_B51b5, r4, 1

CLR_B51b5:
        CLR r30.t15
        JMP DEL_B51b5

SET_B51b5:
        SET r30.t15
        JMP DEL_B51b5

DEL_B51b5:
        ADD r0, r0, 1
        QBNE DEL_B51b5, r0, r1

CLC_B51b6:
        MOV r0, 0
        LSR r4, r20, 10
        AND r4, r4, 1
        QBEQ SET_B51b6, r4, 1

CLR_B51b6:
        CLR r30.t15
        JMP DEL_B51b6

SET_B51b6:
        SET r30.t15
        JMP DEL_B51b6

DEL_B51b6:
        ADD r0, r0, 1
        QBNE DEL_B51b6, r0, r1

CLC_B51b7:
        MOV r0, 0
        LSR r4, r20, 9
        AND r4, r4, 1
        QBEQ SET_B51b7, r4, 1

CLR_B51b7:
        CLR r30.t15
        JMP DEL_B51b7

SET_B51b7:
        SET r30.t15
        JMP DEL_B51b7

DEL_B51b7:
        ADD r0, r0, 1
        QBNE DEL_B51b7, r0, r1

CLC_B51b8:
        MOV r0, 0
        LSR r4, r20, 8
        AND r4, r4, 1
        QBEQ SET_B51b8, r4, 1

CLR_B51b8:
        CLR r30.t15
        JMP DEL_B51b8

SET_B51b8:
        SET r30.t15
        JMP DEL_B51b8

BCK_B51b8:
		JMP BCK_B50b8

DEL_B51b8:
        ADD r0, r0, 1
        QBNE DEL_B51b8, r0, r1

CLC_B52b1:
        MOV r0, 0
        LSR r4, r20, 7
        AND r4, r4, 1
        QBEQ SET_B52b1, r4, 1

CLR_B52b1:
        CLR r30.t15
        JMP DEL_B52b1

SET_B52b1:
        SET r30.t15
        JMP DEL_B52b1

DEL_B52b1:
        ADD r0, r0, 1
        QBNE DEL_B52b1, r0, r1

CLC_B52b2:
        MOV r0, 0
        LSR r4, r20, 6
        AND r4, r4, 1
        QBEQ SET_B52b2, r4, 1

CLR_B52b2:
        CLR r30.t15
        JMP DEL_B52b2

SET_B52b2:
        SET r30.t15
        JMP DEL_B52b2

DEL_B52b2:
        ADD r0, r0, 1
        QBNE DEL_B52b2, r0, r1

CLC_B52b3:
        MOV r0, 0
        LSR r4, r20, 5
        AND r4, r4, 1
        QBEQ SET_B52b3, r4, 1

CLR_B52b3:
        CLR r30.t15
        JMP DEL_B52b3

SET_B52b3:
        SET r30.t15
        JMP DEL_B52b3

DEL_B52b3:
        ADD r0, r0, 1
        QBNE DEL_B52b3, r0, r1

CLC_B52b4:
        MOV r0, 0
        LSR r4, r20, 4
        AND r4, r4, 1
        QBEQ SET_B52b4, r4, 1

CLR_B52b4:
        CLR r30.t15
        JMP DEL_B52b4

SET_B52b4:
        SET r30.t15
        JMP DEL_B52b4

DEL_B52b4:
        ADD r0, r0, 1
        QBNE DEL_B52b4, r0, r1

CLC_B52b5:
        MOV r0, 0
        LSR r4, r20, 3
        AND r4, r4, 1
        QBEQ SET_B52b5, r4, 1

CLR_B52b5:
        CLR r30.t15
        JMP DEL_B52b5

SET_B52b5:
        SET r30.t15
        JMP DEL_B52b5

DEL_B52b5:
        ADD r0, r0, 1
        QBNE DEL_B52b5, r0, r1

CLC_B52b6:
        MOV r0, 0
        LSR r4, r20, 2
        AND r4, r4, 1
        QBEQ SET_B52b6, r4, 1

CLR_B52b6:
        CLR r30.t15
        JMP DEL_B52b6

SET_B52b6:
        SET r30.t15
        JMP DEL_B52b6

DEL_B52b6:
        ADD r0, r0, 1
        QBNE DEL_B52b6, r0, r1

CLC_B52b7:
        MOV r0, 0
        LSR r4, r20, 1
        AND r4, r4, 1
        QBEQ SET_B52b7, r4, 1

CLR_B52b7:
        CLR r30.t15
        JMP DEL_B52b7

SET_B52b7:
        SET r30.t15
        JMP DEL_B52b7

DEL_B52b7:
        ADD r0, r0, 1
        QBNE DEL_B52b7, r0, r1

CLC_B52b8:
        MOV r0, 0
        LSR r4, r20, 0
        AND r4, r4, 1
        QBEQ SET_B52b8, r4, 1

CLR_B52b8:
        CLR r30.t15
        JMP DEL_B52b8

SET_B52b8:
        SET r30.t15
        JMP DEL_B52b8

BCK_B52b8:
		JMP BCK_B51b8

DEL_B52b8:
        ADD r0, r0, 1
        QBNE DEL_B52b8, r0, r1

CLC_B53b1:
        MOV r0, 0
        LSR r4, r21, 31
        AND r4, r4, 1
        QBEQ SET_B53b1, r4, 1

CLR_B53b1:
        CLR r30.t15
        JMP DEL_B53b1

SET_B53b1:
        SET r30.t15
        JMP DEL_B53b1

DEL_B53b1:
        ADD r0, r0, 1
        QBNE DEL_B53b1, r0, r1

CLC_B53b2:
        MOV r0, 0
        LSR r4, r21, 30
        AND r4, r4, 1
        QBEQ SET_B53b2, r4, 1

CLR_B53b2:
        CLR r30.t15
        JMP DEL_B53b2

SET_B53b2:
        SET r30.t15
        JMP DEL_B53b2

DEL_B53b2:
        ADD r0, r0, 1
        QBNE DEL_B53b2, r0, r1

CLC_B53b3:
        MOV r0, 0
        LSR r4, r21, 29
        AND r4, r4, 1
        QBEQ SET_B53b3, r4, 1

CLR_B53b3:
        CLR r30.t15
        JMP DEL_B53b3

SET_B53b3:
        SET r30.t15
        JMP DEL_B53b3

DEL_B53b3:
        ADD r0, r0, 1
        QBNE DEL_B53b3, r0, r1

CLC_B53b4:
        MOV r0, 0
        LSR r4, r21, 28
        AND r4, r4, 1
        QBEQ SET_B53b4, r4, 1

CLR_B53b4:
        CLR r30.t15
        JMP DEL_B53b4

SET_B53b4:
        SET r30.t15
        JMP DEL_B53b4

DEL_B53b4:
        ADD r0, r0, 1
        QBNE DEL_B53b4, r0, r1

CLC_B53b5:
        MOV r0, 0
        LSR r4, r21, 27
        AND r4, r4, 1
        QBEQ SET_B53b5, r4, 1

CLR_B53b5:
        CLR r30.t15
        JMP DEL_B53b5

SET_B53b5:
        SET r30.t15
        JMP DEL_B53b5

DEL_B53b5:
        ADD r0, r0, 1
        QBNE DEL_B53b5, r0, r1

CLC_B53b6:
        MOV r0, 0
        LSR r4, r21, 26
        AND r4, r4, 1
        QBEQ SET_B53b6, r4, 1

CLR_B53b6:
        CLR r30.t15
        JMP DEL_B53b6

SET_B53b6:
        SET r30.t15
        JMP DEL_B53b6

DEL_B53b6:
        ADD r0, r0, 1
        QBNE DEL_B53b6, r0, r1

CLC_B53b7:
        MOV r0, 0
        LSR r4, r21, 25
        AND r4, r4, 1
        QBEQ SET_B53b7, r4, 1

CLR_B53b7:
        CLR r30.t15
        JMP DEL_B53b7

SET_B53b7:
        SET r30.t15
        JMP DEL_B53b7

DEL_B53b7:
        ADD r0, r0, 1
        QBNE DEL_B53b7, r0, r1

CLC_B53b8:
        MOV r0, 0
        LSR r4, r21, 24
        AND r4, r4, 1
        QBEQ SET_B53b8, r4, 1

CLR_B53b8:
        CLR r30.t15
        JMP DEL_B53b8

SET_B53b8:
        SET r30.t15
        JMP DEL_B53b8

BCK_B53b8:
		JMP BCK_B52b8

DEL_B53b8:
        ADD r0, r0, 1
        QBNE DEL_B53b8, r0, r1

CLC_B54b1:
        MOV r0, 0
        LSR r4, r21, 23
        AND r4, r4, 1
        QBEQ SET_B54b1, r4, 1

CLR_B54b1:
        CLR r30.t15
        JMP DEL_B54b1

SET_B54b1:
        SET r30.t15
        JMP DEL_B54b1

DEL_B54b1:
        ADD r0, r0, 1
        QBNE DEL_B54b1, r0, r1

CLC_B54b2:
        MOV r0, 0
        LSR r4, r21, 22
        AND r4, r4, 1
        QBEQ SET_B54b2, r4, 1

CLR_B54b2:
        CLR r30.t15
        JMP DEL_B54b2

SET_B54b2:
        SET r30.t15
        JMP DEL_B54b2

DEL_B54b2:
        ADD r0, r0, 1
        QBNE DEL_B54b2, r0, r1

CLC_B54b3:
        MOV r0, 0
        LSR r4, r21, 21
        AND r4, r4, 1
        QBEQ SET_B54b3, r4, 1

CLR_B54b3:
        CLR r30.t15
        JMP DEL_B54b3

SET_B54b3:
        SET r30.t15
        JMP DEL_B54b3

DEL_B54b3:
        ADD r0, r0, 1
        QBNE DEL_B54b3, r0, r1

CLC_B54b4:
        MOV r0, 0
        LSR r4, r21, 20
        AND r4, r4, 1
        QBEQ SET_B54b4, r4, 1

CLR_B54b4:
        CLR r30.t15
        JMP DEL_B54b4

SET_B54b4:
        SET r30.t15
        JMP DEL_B54b4

DEL_B54b4:
        ADD r0, r0, 1
        QBNE DEL_B54b4, r0, r1

CLC_B54b5:
        MOV r0, 0
        LSR r4, r21, 19
        AND r4, r4, 1
        QBEQ SET_B54b5, r4, 1

CLR_B54b5:
        CLR r30.t15
        JMP DEL_B54b5

SET_B54b5:
        SET r30.t15
        JMP DEL_B54b5

DEL_B54b5:
        ADD r0, r0, 1
        QBNE DEL_B54b5, r0, r1

CLC_B54b6:
        MOV r0, 0
        LSR r4, r21, 18
        AND r4, r4, 1
        QBEQ SET_B54b6, r4, 1

CLR_B54b6:
        CLR r30.t15
        JMP DEL_B54b6

SET_B54b6:
        SET r30.t15
        JMP DEL_B54b6

DEL_B54b6:
        ADD r0, r0, 1
        QBNE DEL_B54b6, r0, r1

CLC_B54b7:
        MOV r0, 0
        LSR r4, r21, 17
        AND r4, r4, 1
        QBEQ SET_B54b7, r4, 1

CLR_B54b7:
        CLR r30.t15
        JMP DEL_B54b7

SET_B54b7:
        SET r30.t15
        JMP DEL_B54b7

DEL_B54b7:
        ADD r0, r0, 1
        QBNE DEL_B54b7, r0, r1

CLC_B54b8:
        MOV r0, 0
        LSR r4, r21, 16
        AND r4, r4, 1
        QBEQ SET_B54b8, r4, 1

CLR_B54b8:
        CLR r30.t15
        JMP DEL_B54b8

SET_B54b8:
        SET r30.t15
        JMP DEL_B54b8

BCK_B54b8:
		JMP BCK_B53b8

DEL_B54b8:
        ADD r0, r0, 1
        QBNE DEL_B54b8, r0, r1

CLC_B55b1:
        MOV r0, 0
        LSR r4, r21, 15
        AND r4, r4, 1
        QBEQ SET_B55b1, r4, 1

CLR_B55b1:
        CLR r30.t15
        JMP DEL_B55b1

SET_B55b1:
        SET r30.t15
        JMP DEL_B55b1

DEL_B55b1:
        ADD r0, r0, 1
        QBNE DEL_B55b1, r0, r1

CLC_B55b2:
        MOV r0, 0
        LSR r4, r21, 14
        AND r4, r4, 1
        QBEQ SET_B55b2, r4, 1

CLR_B55b2:
        CLR r30.t15
        JMP DEL_B55b2

SET_B55b2:
        SET r30.t15
        JMP DEL_B55b2

DEL_B55b2:
        ADD r0, r0, 1
        QBNE DEL_B55b2, r0, r1

CLC_B55b3:
        MOV r0, 0
        LSR r4, r21, 13
        AND r4, r4, 1
        QBEQ SET_B55b3, r4, 1

CLR_B55b3:
        CLR r30.t15
        JMP DEL_B55b3

SET_B55b3:
        SET r30.t15
        JMP DEL_B55b3

DEL_B55b3:
        ADD r0, r0, 1
        QBNE DEL_B55b3, r0, r1

CLC_B55b4:
        MOV r0, 0
        LSR r4, r21, 12
        AND r4, r4, 1
        QBEQ SET_B55b4, r4, 1

CLR_B55b4:
        CLR r30.t15
        JMP DEL_B55b4

SET_B55b4:
        SET r30.t15
        JMP DEL_B55b4

DEL_B55b4:
        ADD r0, r0, 1
        QBNE DEL_B55b4, r0, r1

CLC_B55b5:
        MOV r0, 0
        LSR r4, r21, 11
        AND r4, r4, 1
        QBEQ SET_B55b5, r4, 1

CLR_B55b5:
        CLR r30.t15
        JMP DEL_B55b5

SET_B55b5:
        SET r30.t15
        JMP DEL_B55b5

DEL_B55b5:
        ADD r0, r0, 1
        QBNE DEL_B55b5, r0, r1

CLC_B55b6:
        MOV r0, 0
        LSR r4, r21, 10
        AND r4, r4, 1
        QBEQ SET_B55b6, r4, 1

CLR_B55b6:
        CLR r30.t15
        JMP DEL_B55b6

SET_B55b6:
        SET r30.t15
        JMP DEL_B55b6

DEL_B55b6:
        ADD r0, r0, 1
        QBNE DEL_B55b6, r0, r1

CLC_B55b7:
        MOV r0, 0
        LSR r4, r21, 9
        AND r4, r4, 1
        QBEQ SET_B55b7, r4, 1

CLR_B55b7:
        CLR r30.t15
        JMP DEL_B55b7

SET_B55b7:
        SET r30.t15
        JMP DEL_B55b7

DEL_B55b7:
        ADD r0, r0, 1
        QBNE DEL_B55b7, r0, r1

CLC_B55b8:
        MOV r0, 0
        LSR r4, r21, 8
        AND r4, r4, 1
        QBEQ SET_B55b8, r4, 1

CLR_B55b8:
        CLR r30.t15
        JMP DEL_B55b8

SET_B55b8:
        SET r30.t15
        JMP DEL_B55b8

BCK_B55b8:
		JMP BCK_B54b8

DEL_B55b8:
        ADD r0, r0, 1
        QBNE DEL_B55b8, r0, r1

CLC_B56b1:
        MOV r0, 0
        LSR r4, r21, 7
        AND r4, r4, 1
        QBEQ SET_B56b1, r4, 1

CLR_B56b1:
        CLR r30.t15
        JMP DEL_B56b1

SET_B56b1:
        SET r30.t15
        JMP DEL_B56b1

DEL_B56b1:
        ADD r0, r0, 1
        QBNE DEL_B56b1, r0, r1

CLC_B56b2:
        MOV r0, 0
        LSR r4, r21, 6
        AND r4, r4, 1
        QBEQ SET_B56b2, r4, 1

CLR_B56b2:
        CLR r30.t15
        JMP DEL_B56b2

SET_B56b2:
        SET r30.t15
        JMP DEL_B56b2

DEL_B56b2:
        ADD r0, r0, 1
        QBNE DEL_B56b2, r0, r1

CLC_B56b3:
        MOV r0, 0
        LSR r4, r21, 5
        AND r4, r4, 1
        QBEQ SET_B56b3, r4, 1

CLR_B56b3:
        CLR r30.t15
        JMP DEL_B56b3

SET_B56b3:
        SET r30.t15
        JMP DEL_B56b3

DEL_B56b3:
        ADD r0, r0, 1
        QBNE DEL_B56b3, r0, r1

CLC_B56b4:
        MOV r0, 0
        LSR r4, r21, 4
        AND r4, r4, 1
        QBEQ SET_B56b4, r4, 1

CLR_B56b4:
        CLR r30.t15
        JMP DEL_B56b4

SET_B56b4:
        SET r30.t15
        JMP DEL_B56b4

DEL_B56b4:
        ADD r0, r0, 1
        QBNE DEL_B56b4, r0, r1

CLC_B56b5:
        MOV r0, 0
        LSR r4, r21, 3
        AND r4, r4, 1
        QBEQ SET_B56b5, r4, 1

CLR_B56b5:
        CLR r30.t15
        JMP DEL_B56b5

SET_B56b5:
        SET r30.t15
        JMP DEL_B56b5

DEL_B56b5:
        ADD r0, r0, 1
        QBNE DEL_B56b5, r0, r1

CLC_B56b6:
        MOV r0, 0
        LSR r4, r21, 2
        AND r4, r4, 1
        QBEQ SET_B56b6, r4, 1

CLR_B56b6:
        CLR r30.t15
        JMP DEL_B56b6

SET_B56b6:
        SET r30.t15
        JMP DEL_B56b6

DEL_B56b6:
        ADD r0, r0, 1
        QBNE DEL_B56b6, r0, r1

CLC_B56b7:
        MOV r0, 0
        LSR r4, r21, 1
        AND r4, r4, 1
        QBEQ SET_B56b7, r4, 1

CLR_B56b7:
        CLR r30.t15
        JMP DEL_B56b7

SET_B56b7:
        SET r30.t15
        JMP DEL_B56b7

DEL_B56b7:
        ADD r0, r0, 1
        QBNE DEL_B56b7, r0, r1

CLC_B56b8:
        MOV r0, 0
        LSR r4, r21, 0
        AND r4, r4, 1
        QBEQ SET_B56b8, r4, 1

CLR_B56b8:
        CLR r30.t15
        JMP DEL_B56b8

SET_B56b8:
        SET r30.t15
        JMP DEL_B56b8

BCK_B56b8:
		JMP BCK_B55b8

DEL_B56b8:
        ADD r0, r0, 1
        QBNE DEL_B56b8, r0, r1

CLC_B57b1:
        MOV r0, 0
        LSR r4, r22, 31
        AND r4, r4, 1
        QBEQ SET_B57b1, r4, 1

CLR_B57b1:
        CLR r30.t15
        JMP DEL_B57b1

SET_B57b1:
        SET r30.t15
        JMP DEL_B57b1

DEL_B57b1:
        ADD r0, r0, 1
        QBNE DEL_B57b1, r0, r1

CLC_B57b2:
        MOV r0, 0
        LSR r4, r22, 30
        AND r4, r4, 1
        QBEQ SET_B57b2, r4, 1

CLR_B57b2:
        CLR r30.t15
        JMP DEL_B57b2

SET_B57b2:
        SET r30.t15
        JMP DEL_B57b2

DEL_B57b2:
        ADD r0, r0, 1
        QBNE DEL_B57b2, r0, r1

CLC_B57b3:
        MOV r0, 0
        LSR r4, r22, 29
        AND r4, r4, 1
        QBEQ SET_B57b3, r4, 1

CLR_B57b3:
        CLR r30.t15
        JMP DEL_B57b3

SET_B57b3:
        SET r30.t15
        JMP DEL_B57b3

DEL_B57b3:
        ADD r0, r0, 1
        QBNE DEL_B57b3, r0, r1

CLC_B57b4:
        MOV r0, 0
        LSR r4, r22, 28
        AND r4, r4, 1
        QBEQ SET_B57b4, r4, 1

CLR_B57b4:
        CLR r30.t15
        JMP DEL_B57b4

SET_B57b4:
        SET r30.t15
        JMP DEL_B57b4

DEL_B57b4:
        ADD r0, r0, 1
        QBNE DEL_B57b4, r0, r1

CLC_B57b5:
        MOV r0, 0
        LSR r4, r22, 27
        AND r4, r4, 1
        QBEQ SET_B57b5, r4, 1

CLR_B57b5:
        CLR r30.t15
        JMP DEL_B57b5

SET_B57b5:
        SET r30.t15
        JMP DEL_B57b5

DEL_B57b5:
        ADD r0, r0, 1
        QBNE DEL_B57b5, r0, r1

CLC_B57b6:
        MOV r0, 0
        LSR r4, r22, 26
        AND r4, r4, 1
        QBEQ SET_B57b6, r4, 1

CLR_B57b6:
        CLR r30.t15
        JMP DEL_B57b6

SET_B57b6:
        SET r30.t15
        JMP DEL_B57b6

DEL_B57b6:
        ADD r0, r0, 1
        QBNE DEL_B57b6, r0, r1

CLC_B57b7:
        MOV r0, 0
        LSR r4, r22, 25
        AND r4, r4, 1
        QBEQ SET_B57b7, r4, 1

CLR_B57b7:
        CLR r30.t15
        JMP DEL_B57b7

SET_B57b7:
        SET r30.t15
        JMP DEL_B57b7

DEL_B57b7:
        ADD r0, r0, 1
        QBNE DEL_B57b7, r0, r1

CLC_B57b8:
        MOV r0, 0
        LSR r4, r22, 24
        AND r4, r4, 1
        QBEQ SET_B57b8, r4, 1

CLR_B57b8:
        CLR r30.t15
        JMP DEL_B57b8

SET_B57b8:
        SET r30.t15
        JMP DEL_B57b8

BCK_B57b8:
		JMP BCK_B56b8

DEL_B57b8:
        ADD r0, r0, 1
        QBNE DEL_B57b8, r0, r1

CLC_B58b1:
        MOV r0, 0
        LSR r4, r22, 23
        AND r4, r4, 1
        QBEQ SET_B58b1, r4, 1

CLR_B58b1:
        CLR r30.t15
        JMP DEL_B58b1

SET_B58b1:
        SET r30.t15
        JMP DEL_B58b1

DEL_B58b1:
        ADD r0, r0, 1
        QBNE DEL_B58b1, r0, r1

CLC_B58b2:
        MOV r0, 0
        LSR r4, r22, 22
        AND r4, r4, 1
        QBEQ SET_B58b2, r4, 1

CLR_B58b2:
        CLR r30.t15
        JMP DEL_B58b2

SET_B58b2:
        SET r30.t15
        JMP DEL_B58b2

DEL_B58b2:
        ADD r0, r0, 1
        QBNE DEL_B58b2, r0, r1

CLC_B58b3:
        MOV r0, 0
        LSR r4, r22, 21
        AND r4, r4, 1
        QBEQ SET_B58b3, r4, 1

CLR_B58b3:
        CLR r30.t15
        JMP DEL_B58b3

SET_B58b3:
        SET r30.t15
        JMP DEL_B58b3

DEL_B58b3:
        ADD r0, r0, 1
        QBNE DEL_B58b3, r0, r1

CLC_B58b4:
        MOV r0, 0
        LSR r4, r22, 20
        AND r4, r4, 1
        QBEQ SET_B58b4, r4, 1

CLR_B58b4:
        CLR r30.t15
        JMP DEL_B58b4

SET_B58b4:
        SET r30.t15
        JMP DEL_B58b4

DEL_B58b4:
        ADD r0, r0, 1
        QBNE DEL_B58b4, r0, r1

CLC_B58b5:
        MOV r0, 0
        LSR r4, r22, 19
        AND r4, r4, 1
        QBEQ SET_B58b5, r4, 1

CLR_B58b5:
        CLR r30.t15
        JMP DEL_B58b5

SET_B58b5:
        SET r30.t15
        JMP DEL_B58b5

DEL_B58b5:
        ADD r0, r0, 1
        QBNE DEL_B58b5, r0, r1

CLC_B58b6:
        MOV r0, 0
        LSR r4, r22, 18
        AND r4, r4, 1
        QBEQ SET_B58b6, r4, 1

CLR_B58b6:
        CLR r30.t15
        JMP DEL_B58b6

SET_B58b6:
        SET r30.t15
        JMP DEL_B58b6

DEL_B58b6:
        ADD r0, r0, 1
        QBNE DEL_B58b6, r0, r1

CLC_B58b7:
        MOV r0, 0
        LSR r4, r22, 17
        AND r4, r4, 1
        QBEQ SET_B58b7, r4, 1

CLR_B58b7:
        CLR r30.t15
        JMP DEL_B58b7

SET_B58b7:
        SET r30.t15
        JMP DEL_B58b7

DEL_B58b7:
        ADD r0, r0, 1
        QBNE DEL_B58b7, r0, r1

CLC_B58b8:
        MOV r0, 0
        LSR r4, r22, 16
        AND r4, r4, 1
        QBEQ SET_B58b8, r4, 1

CLR_B58b8:
        CLR r30.t15
        JMP DEL_B58b8

SET_B58b8:
        SET r30.t15
        JMP DEL_B58b8

BCK_B58b8:
		JMP BCK_B57b8

DEL_B58b8:
        ADD r0, r0, 1
        QBNE DEL_B58b8, r0, r1

CLC_B59b1:
        MOV r0, 0
        LSR r4, r22, 15
        AND r4, r4, 1
        QBEQ SET_B59b1, r4, 1

CLR_B59b1:
        CLR r30.t15
        JMP DEL_B59b1

SET_B59b1:
        SET r30.t15
        JMP DEL_B59b1

DEL_B59b1:
        ADD r0, r0, 1
        QBNE DEL_B59b1, r0, r1

CLC_B59b2:
        MOV r0, 0
        LSR r4, r22, 14
        AND r4, r4, 1
        QBEQ SET_B59b2, r4, 1

CLR_B59b2:
        CLR r30.t15
        JMP DEL_B59b2

SET_B59b2:
        SET r30.t15
        JMP DEL_B59b2

DEL_B59b2:
        ADD r0, r0, 1
        QBNE DEL_B59b2, r0, r1

CLC_B59b3:
        MOV r0, 0
        LSR r4, r22, 13
        AND r4, r4, 1
        QBEQ SET_B59b3, r4, 1

CLR_B59b3:
        CLR r30.t15
        JMP DEL_B59b3

SET_B59b3:
        SET r30.t15
        JMP DEL_B59b3

DEL_B59b3:
        ADD r0, r0, 1
        QBNE DEL_B59b3, r0, r1

CLC_B59b4:
        MOV r0, 0
        LSR r4, r22, 12
        AND r4, r4, 1
        QBEQ SET_B59b4, r4, 1

CLR_B59b4:
        CLR r30.t15
        JMP DEL_B59b4

SET_B59b4:
        SET r30.t15
        JMP DEL_B59b4

DEL_B59b4:
        ADD r0, r0, 1
        QBNE DEL_B59b4, r0, r1

CLC_B59b5:
        MOV r0, 0
        LSR r4, r22, 11
        AND r4, r4, 1
        QBEQ SET_B59b5, r4, 1

CLR_B59b5:
        CLR r30.t15
        JMP DEL_B59b5

SET_B59b5:
        SET r30.t15
        JMP DEL_B59b5

DEL_B59b5:
        ADD r0, r0, 1
        QBNE DEL_B59b5, r0, r1

CLC_B59b6:
        MOV r0, 0
        LSR r4, r22, 10
        AND r4, r4, 1
        QBEQ SET_B59b6, r4, 1

CLR_B59b6:
        CLR r30.t15
        JMP DEL_B59b6

SET_B59b6:
        SET r30.t15
        JMP DEL_B59b6

DEL_B59b6:
        ADD r0, r0, 1
        QBNE DEL_B59b6, r0, r1

CLC_B59b7:
        MOV r0, 0
        LSR r4, r22, 9
        AND r4, r4, 1
        QBEQ SET_B59b7, r4, 1

CLR_B59b7:
        CLR r30.t15
        JMP DEL_B59b7

SET_B59b7:
        SET r30.t15
        JMP DEL_B59b7

DEL_B59b7:
        ADD r0, r0, 1
        QBNE DEL_B59b7, r0, r1

CLC_B59b8:
        MOV r0, 0
        LSR r4, r22, 8
        AND r4, r4, 1
        QBEQ SET_B59b8, r4, 1

CLR_B59b8:
        CLR r30.t15
        JMP DEL_B59b8

SET_B59b8:
        SET r30.t15
        JMP DEL_B59b8

BCK_B59b8:
		JMP BCK_B58b8

DEL_B59b8:
        ADD r0, r0, 1
        QBNE DEL_B59b8, r0, r1

CLC_B60b1:
        MOV r0, 0
        LSR r4, r22, 7
        AND r4, r4, 1
        QBEQ SET_B60b1, r4, 1

CLR_B60b1:
        CLR r30.t15
        JMP DEL_B60b1

SET_B60b1:
        SET r30.t15
        JMP DEL_B60b1

DEL_B60b1:
        ADD r0, r0, 1
        QBNE DEL_B60b1, r0, r1

CLC_B60b2:
        MOV r0, 0
        LSR r4, r22, 6
        AND r4, r4, 1
        QBEQ SET_B60b2, r4, 1

CLR_B60b2:
        CLR r30.t15
        JMP DEL_B60b2

SET_B60b2:
        SET r30.t15
        JMP DEL_B60b2

DEL_B60b2:
        ADD r0, r0, 1
        QBNE DEL_B60b2, r0, r1

CLC_B60b3:
        MOV r0, 0
        LSR r4, r22, 5
        AND r4, r4, 1
        QBEQ SET_B60b3, r4, 1

CLR_B60b3:
        CLR r30.t15
        JMP DEL_B60b3

SET_B60b3:
        SET r30.t15
        JMP DEL_B60b3

DEL_B60b3:
        ADD r0, r0, 1
        QBNE DEL_B60b3, r0, r1

CLC_B60b4:
        MOV r0, 0
        LSR r4, r22, 4
        AND r4, r4, 1
        QBEQ SET_B60b4, r4, 1

CLR_B60b4:
        CLR r30.t15
        JMP DEL_B60b4

SET_B60b4:
        SET r30.t15
        JMP DEL_B60b4

DEL_B60b4:
        ADD r0, r0, 1
        QBNE DEL_B60b4, r0, r1

CLC_B60b5:
        MOV r0, 0
        LSR r4, r22, 3
        AND r4, r4, 1
        QBEQ SET_B60b5, r4, 1

CLR_B60b5:
        CLR r30.t15
        JMP DEL_B60b5

SET_B60b5:
        SET r30.t15
        JMP DEL_B60b5

DEL_B60b5:
        ADD r0, r0, 1
        QBNE DEL_B60b5, r0, r1

CLC_B60b6:
        MOV r0, 0
        LSR r4, r22, 2
        AND r4, r4, 1
        QBEQ SET_B60b6, r4, 1

CLR_B60b6:
        CLR r30.t15
        JMP DEL_B60b6

SET_B60b6:
        SET r30.t15
        JMP DEL_B60b6

DEL_B60b6:
        ADD r0, r0, 1
        QBNE DEL_B60b6, r0, r1

CLC_B60b7:
        MOV r0, 0
        LSR r4, r22, 1
        AND r4, r4, 1
        QBEQ SET_B60b7, r4, 1

CLR_B60b7:
        CLR r30.t15
        JMP DEL_B60b7

SET_B60b7:
        SET r30.t15
        JMP DEL_B60b7

DEL_B60b7:
        ADD r0, r0, 1
        QBNE DEL_B60b7, r0, r1

CLC_B60b8:
        MOV r0, 0
        LSR r4, r22, 0
        AND r4, r4, 1
        QBEQ SET_B60b8, r4, 1

CLR_B60b8:
        CLR r30.t15
        JMP DEL_B60b8

SET_B60b8:
        SET r30.t15
        JMP DEL_B60b8

BCK_B60b8:
		JMP BCK_B59b8

DEL_B60b8:
        ADD r0, r0, 1
        QBNE DEL_B60b8, r0, r1

CLC_B61b1:
        MOV r0, 0
        LSR r4, r23, 31
        AND r4, r4, 1
        QBEQ SET_B61b1, r4, 1

CLR_B61b1:
        CLR r30.t15
        JMP DEL_B61b1

SET_B61b1:
        SET r30.t15
        JMP DEL_B61b1

DEL_B61b1:
        ADD r0, r0, 1
        QBNE DEL_B61b1, r0, r1

CLC_B61b2:
        MOV r0, 0
        LSR r4, r23, 30
        AND r4, r4, 1
        QBEQ SET_B61b2, r4, 1

CLR_B61b2:
        CLR r30.t15
        JMP DEL_B61b2

SET_B61b2:
        SET r30.t15
        JMP DEL_B61b2

DEL_B61b2:
        ADD r0, r0, 1
        QBNE DEL_B61b2, r0, r1

CLC_B61b3:
        MOV r0, 0
        LSR r4, r23, 29
        AND r4, r4, 1
        QBEQ SET_B61b3, r4, 1

CLR_B61b3:
        CLR r30.t15
        JMP DEL_B61b3

SET_B61b3:
        SET r30.t15
        JMP DEL_B61b3

DEL_B61b3:
        ADD r0, r0, 1
        QBNE DEL_B61b3, r0, r1

CLC_B61b4:
        MOV r0, 0
        LSR r4, r23, 28
        AND r4, r4, 1
        QBEQ SET_B61b4, r4, 1

CLR_B61b4:
        CLR r30.t15
        JMP DEL_B61b4

SET_B61b4:
        SET r30.t15
        JMP DEL_B61b4

DEL_B61b4:
        ADD r0, r0, 1
        QBNE DEL_B61b4, r0, r1

CLC_B61b5:
        MOV r0, 0
        LSR r4, r23, 27
        AND r4, r4, 1
        QBEQ SET_B61b5, r4, 1

CLR_B61b5:
        CLR r30.t15
        JMP DEL_B61b5

SET_B61b5:
        SET r30.t15
        JMP DEL_B61b5

DEL_B61b5:
        ADD r0, r0, 1
        QBNE DEL_B61b5, r0, r1

CLC_B61b6:
        MOV r0, 0
        LSR r4, r23, 26
        AND r4, r4, 1
        QBEQ SET_B61b6, r4, 1

CLR_B61b6:
        CLR r30.t15
        JMP DEL_B61b6

SET_B61b6:
        SET r30.t15
        JMP DEL_B61b6

DEL_B61b6:
        ADD r0, r0, 1
        QBNE DEL_B61b6, r0, r1

CLC_B61b7:
        MOV r0, 0
        LSR r4, r23, 25
        AND r4, r4, 1
        QBEQ SET_B61b7, r4, 1

CLR_B61b7:
        CLR r30.t15
        JMP DEL_B61b7

SET_B61b7:
        SET r30.t15
        JMP DEL_B61b7

DEL_B61b7:
        ADD r0, r0, 1
        QBNE DEL_B61b7, r0, r1

CLC_B61b8:
        MOV r0, 0
        LSR r4, r23, 24
        AND r4, r4, 1
        QBEQ SET_B61b8, r4, 1

CLR_B61b8:
        CLR r30.t15
        JMP DEL_B61b8

SET_B61b8:
        SET r30.t15
        JMP DEL_B61b8

BCK_B61b8:
		JMP BCK_B28b8

DEL_B61b8:
        ADD r0, r0, 1
        QBNE DEL_B61b8, r0, r1

CLC_B62b1:
        MOV r0, 0
        LSR r4, r23, 23
        AND r4, r4, 1
        QBEQ SET_B62b1, r4, 1

CLR_B62b1:
        CLR r30.t15
        JMP DEL_B62b1

SET_B62b1:
        SET r30.t15
        JMP DEL_B62b1

DEL_B62b1:
        ADD r0, r0, 1
        QBNE DEL_B62b1, r0, r1

CLC_B62b2:
        MOV r0, 0
        LSR r4, r23, 22
        AND r4, r4, 1
        QBEQ SET_B62b2, r4, 1

CLR_B62b2:
        CLR r30.t15
        JMP DEL_B62b2

SET_B62b2:
        SET r30.t15
        JMP DEL_B62b2

DEL_B62b2:
        ADD r0, r0, 1
        QBNE DEL_B62b2, r0, r1

CLC_B62b3:
        MOV r0, 0
        LSR r4, r23, 21
        AND r4, r4, 1
        QBEQ SET_B62b3, r4, 1

CLR_B62b3:
        CLR r30.t15
        JMP DEL_B62b3

SET_B62b3:
        SET r30.t15
        JMP DEL_B62b3

DEL_B62b3:
        ADD r0, r0, 1
        QBNE DEL_B62b3, r0, r1

CLC_B62b4:
        MOV r0, 0
        LSR r4, r23, 20
        AND r4, r4, 1
        QBEQ SET_B62b4, r4, 1

CLR_B62b4:
        CLR r30.t15
        JMP DEL_B62b4

SET_B62b4:
        SET r30.t15
        JMP DEL_B62b4

DEL_B62b4:
        ADD r0, r0, 1
        QBNE DEL_B62b4, r0, r1

CLC_B62b5:
        MOV r0, 0
        LSR r4, r23, 19
        AND r4, r4, 1
        QBEQ SET_B62b5, r4, 1

CLR_B62b5:
        CLR r30.t15
        JMP DEL_B62b5

SET_B62b5:
        SET r30.t15
        JMP DEL_B62b5

DEL_B62b5:
        ADD r0, r0, 1
        QBNE DEL_B62b5, r0, r1

CLC_B62b6:
        MOV r0, 0
        LSR r4, r23, 18
        AND r4, r4, 1
        QBEQ SET_B62b6, r4, 1

CLR_B62b6:
        CLR r30.t15
        JMP DEL_B62b6

SET_B62b6:
        SET r30.t15
        JMP DEL_B62b6

DEL_B62b6:
        ADD r0, r0, 1
        QBNE DEL_B62b6, r0, r1

CLC_B62b7:
        MOV r0, 0
        LSR r4, r23, 17
        AND r4, r4, 1
        QBEQ SET_B62b7, r4, 1

CLR_B62b7:
        CLR r30.t15
        JMP DEL_B62b7

SET_B62b7:
        SET r30.t15
        JMP DEL_B62b7

DEL_B62b7:
        ADD r0, r0, 1
        QBNE DEL_B62b7, r0, r1

CLC_B62b8:
        MOV r0, 0
        LSR r4, r23, 16
        AND r4, r4, 1
        QBEQ SET_B62b8, r4, 1

CLR_B62b8:
        CLR r30.t15
        JMP DEL_B62b8

SET_B62b8:
        SET r30.t15
        JMP DEL_B62b8

BCK_B62b8:
		JMP BCK_B61b8

DEL_B62b8:
        ADD r0, r0, 1
        QBNE DEL_B62b8, r0, r1

CLC_B63b1:
        MOV r0, 0
        LSR r4, r23, 15
        AND r4, r4, 1
        QBEQ SET_B63b1, r4, 1

CLR_B63b1:
        CLR r30.t15
        JMP DEL_B63b1

SET_B63b1:
        SET r30.t15
        JMP DEL_B63b1

DEL_B63b1:
        ADD r0, r0, 1
        QBNE DEL_B63b1, r0, r1

CLC_B63b2:
        MOV r0, 0
        LSR r4, r23, 14
        AND r4, r4, 1
        QBEQ SET_B63b2, r4, 1

CLR_B63b2:
        CLR r30.t15
        JMP DEL_B63b2

SET_B63b2:
        SET r30.t15
        JMP DEL_B63b2

DEL_B63b2:
        ADD r0, r0, 1
        QBNE DEL_B63b2, r0, r1

CLC_B63b3:
        MOV r0, 0
        LSR r4, r23, 13
        AND r4, r4, 1
        QBEQ SET_B63b3, r4, 1

CLR_B63b3:
        CLR r30.t15
        JMP DEL_B63b3

SET_B63b3:
        SET r30.t15
        JMP DEL_B63b3

DEL_B63b3:
        ADD r0, r0, 1
        QBNE DEL_B63b3, r0, r1

CLC_B63b4:
        MOV r0, 0
        LSR r4, r23, 12
        AND r4, r4, 1
        QBEQ SET_B63b4, r4, 1

CLR_B63b4:
        CLR r30.t15
        JMP DEL_B63b4

SET_B63b4:
        SET r30.t15
        JMP DEL_B63b4

DEL_B63b4:
        ADD r0, r0, 1
        QBNE DEL_B63b4, r0, r1

CLC_B63b5:
        MOV r0, 0
        LSR r4, r23, 11
        AND r4, r4, 1
        QBEQ SET_B63b5, r4, 1

CLR_B63b5:
        CLR r30.t15
        JMP DEL_B63b5

SET_B63b5:
        SET r30.t15
        JMP DEL_B63b5

DEL_B63b5:
        ADD r0, r0, 1
        QBNE DEL_B63b5, r0, r1

CLC_B63b6:
        MOV r0, 0
        LSR r4, r23, 10
        AND r4, r4, 1
        QBEQ SET_B63b6, r4, 1

CLR_B63b6:
        CLR r30.t15
        JMP DEL_B63b6

SET_B63b6:
        SET r30.t15
        JMP DEL_B63b6

DEL_B63b6:
        ADD r0, r0, 1
        QBNE DEL_B63b6, r0, r1

CLC_B63b7:
        MOV r0, 0
        LSR r4, r23, 9
        AND r4, r4, 1
        QBEQ SET_B63b7, r4, 1

CLR_B63b7:
        CLR r30.t15
        JMP DEL_B63b7

SET_B63b7:
        SET r30.t15
        JMP DEL_B63b7

DEL_B63b7:
        ADD r0, r0, 1
        QBNE DEL_B63b7, r0, r1

CLC_B63b8:
        MOV r0, 0
        LSR r4, r23, 8
        AND r4, r4, 1
        QBEQ SET_B63b8, r4, 1

CLR_B63b8:
        CLR r30.t15
        JMP DEL_B63b8

SET_B63b8:
        SET r30.t15
        JMP DEL_B63b8

BCK_B63b8:
		JMP BCK_B62b8

DEL_B63b8:
        ADD r0, r0, 1
        QBNE DEL_B63b8, r0, r1

CLC_B64b1:
        MOV r0, 0
        LSR r4, r23, 7
        AND r4, r4, 1
        QBEQ SET_B64b1, r4, 1

CLR_B64b1:
        CLR r30.t15
        JMP DEL_B64b1

SET_B64b1:
        SET r30.t15
        JMP DEL_B64b1

DEL_B64b1:
        ADD r0, r0, 1
        QBNE DEL_B64b1, r0, r1

CLC_B64b2:
        MOV r0, 0
        LSR r4, r23, 6
        AND r4, r4, 1
        QBEQ SET_B64b2, r4, 1

CLR_B64b2:
        CLR r30.t15
        JMP DEL_B64b2

SET_B64b2:
        SET r30.t15
        JMP DEL_B64b2

DEL_B64b2:
        ADD r0, r0, 1
        QBNE DEL_B64b2, r0, r1

CLC_B64b3:
        MOV r0, 0
        LSR r4, r23, 5
        AND r4, r4, 1
        QBEQ SET_B64b3, r4, 1

CLR_B64b3:
        CLR r30.t15
        JMP DEL_B64b3

SET_B64b3:
        SET r30.t15
        JMP DEL_B64b3

DEL_B64b3:
        ADD r0, r0, 1
        QBNE DEL_B64b3, r0, r1

CLC_B64b4:
        MOV r0, 0
        LSR r4, r23, 4
        AND r4, r4, 1
        QBEQ SET_B64b4, r4, 1

CLR_B64b4:
        CLR r30.t15
        JMP DEL_B64b4

SET_B64b4:
        SET r30.t15
        JMP DEL_B64b4

DEL_B64b4:
        ADD r0, r0, 1
        QBNE DEL_B64b4, r0, r1

CLC_B64b5:
        MOV r0, 0
        LSR r4, r23, 3
        AND r4, r4, 1
        QBEQ SET_B64b5, r4, 1

CLR_B64b5:
        CLR r30.t15
        JMP DEL_B64b5

SET_B64b5:
        SET r30.t15
        JMP DEL_B64b5

DEL_B64b5:
        ADD r0, r0, 1
        QBNE DEL_B64b5, r0, r1

CLC_B64b6:
        MOV r0, 0
        LSR r4, r23, 2
        AND r4, r4, 1
        QBEQ SET_B64b6, r4, 1

CLR_B64b6:
        CLR r30.t15
        JMP DEL_B64b6

SET_B64b6:
        SET r30.t15
        JMP DEL_B64b6

DEL_B64b6:
        ADD r0, r0, 1
        QBNE DEL_B64b6, r0, r1

CLC_B64b7:
        MOV r0, 0
        LSR r4, r23, 1
        AND r4, r4, 1
        QBEQ SET_B64b7, r4, 1

CLR_B64b7:
        CLR r30.t15
        JMP DEL_B64b7

SET_B64b7:
        SET r30.t15
        JMP DEL_B64b7

DEL_B64b7:
        ADD r0, r0, 1
        QBNE DEL_B64b7, r0, r1

CLC_B64b8:
        MOV r0, 0
        LSR r4, r23, 0
        AND r4, r4, 1
        QBEQ SET_B64b8, r4, 1

CLR_B64b8:
        CLR r30.t15
        JMP DEL_B64b8

SET_B64b8:
        SET r30.t15
        JMP DEL_B64b8

BCK_B64b8:
		JMP BCK_B63b8

DEL_B64b8:
        ADD r0, r0, 1
        QBNE DEL_B64b8, r0, r1

CLC_B65b1:
        MOV r0, 0
        LSR r4, r24, 31
        AND r4, r4, 1
        QBEQ SET_B65b1, r4, 1

CLR_B65b1:
        CLR r30.t15
        JMP DEL_B65b1

SET_B65b1:
        SET r30.t15
        JMP DEL_B65b1

DEL_B65b1:
        ADD r0, r0, 1
        QBNE DEL_B65b1, r0, r1

CLC_B65b2:
        MOV r0, 0
        LSR r4, r24, 30
        AND r4, r4, 1
        QBEQ SET_B65b2, r4, 1

CLR_B65b2:
        CLR r30.t15
        JMP DEL_B65b2

SET_B65b2:
        SET r30.t15
        JMP DEL_B65b2

DEL_B65b2:
        ADD r0, r0, 1
        QBNE DEL_B65b2, r0, r1

CLC_B65b3:
        MOV r0, 0
        LSR r4, r24, 29
        AND r4, r4, 1
        QBEQ SET_B65b3, r4, 1

CLR_B65b3:
        CLR r30.t15
        JMP DEL_B65b3

SET_B65b3:
        SET r30.t15
        JMP DEL_B65b3

DEL_B65b3:
        ADD r0, r0, 1
        QBNE DEL_B65b3, r0, r1

CLC_B65b4:
        MOV r0, 0
        LSR r4, r24, 28
        AND r4, r4, 1
        QBEQ SET_B65b4, r4, 1

CLR_B65b4:
        CLR r30.t15
        JMP DEL_B65b4

SET_B65b4:
        SET r30.t15
        JMP DEL_B65b4

DEL_B65b4:
        ADD r0, r0, 1
        QBNE DEL_B65b4, r0, r1

CLC_B65b5:
        MOV r0, 0
        LSR r4, r24, 27
        AND r4, r4, 1
        QBEQ SET_B65b5, r4, 1

CLR_B65b5:
        CLR r30.t15
        JMP DEL_B65b5

SET_B65b5:
        SET r30.t15
        JMP DEL_B65b5

DEL_B65b5:
        ADD r0, r0, 1
        QBNE DEL_B65b5, r0, r1

CLC_B65b6:
        MOV r0, 0
        LSR r4, r24, 26
        AND r4, r4, 1
        QBEQ SET_B65b6, r4, 1

CLR_B65b6:
        CLR r30.t15
        JMP DEL_B65b6

SET_B65b6:
        SET r30.t15
        JMP DEL_B65b6

DEL_B65b6:
        ADD r0, r0, 1
        QBNE DEL_B65b6, r0, r1

CLC_B65b7:
        MOV r0, 0
        LSR r4, r24, 25
        AND r4, r4, 1
        QBEQ SET_B65b7, r4, 1

CLR_B65b7:
        CLR r30.t15
        JMP DEL_B65b7

SET_B65b7:
        SET r30.t15
        JMP DEL_B65b7

DEL_B65b7:
        ADD r0, r0, 1
        QBNE DEL_B65b7, r0, r1

CLC_B65b8:
        MOV r0, 0
        LSR r4, r24, 24
        AND r4, r4, 1
        QBEQ SET_B65b8, r4, 1

CLR_B65b8:
        CLR r30.t15
        JMP DEL_B65b8

SET_B65b8:
        SET r30.t15
        JMP DEL_B65b8

BCK_B65b8:
		JMP CHECK_DONE

DEL_B65b8:
        ADD r0, r0, 1
        QBNE DEL_B65b8, r0, r1

CLC_B66b1:
        MOV r0, 0
        LSR r4, r24, 23
        AND r4, r4, 1
        QBEQ SET_B66b1, r4, 1

CLR_B66b1:
        CLR r30.t15
        JMP DEL_B66b1

SET_B66b1:
        SET r30.t15
        JMP DEL_B66b1

DEL_B66b1:
        ADD r0, r0, 1
        QBNE DEL_B66b1, r0, r1

CLC_B66b2:
        MOV r0, 0
        LSR r4, r24, 22
        AND r4, r4, 1
        QBEQ SET_B66b2, r4, 1

CLR_B66b2:
        CLR r30.t15
        JMP DEL_B66b2

SET_B66b2:
        SET r30.t15
        JMP DEL_B66b2

DEL_B66b2:
        ADD r0, r0, 1
        QBNE DEL_B66b2, r0, r1

CLC_B66b3:
        MOV r0, 0
        LSR r4, r24, 21
        AND r4, r4, 1
        QBEQ SET_B66b3, r4, 1

CLR_B66b3:
        CLR r30.t15
        JMP DEL_B66b3

SET_B66b3:
        SET r30.t15
        JMP DEL_B66b3

DEL_B66b3:
        ADD r0, r0, 1
        QBNE DEL_B66b3, r0, r1

CLC_B66b4:
        MOV r0, 0
        LSR r4, r24, 20
        AND r4, r4, 1
        QBEQ SET_B66b4, r4, 1

CLR_B66b4:
        CLR r30.t15
        JMP DEL_B66b4

SET_B66b4:
        SET r30.t15
        JMP DEL_B66b4

DEL_B66b4:
        ADD r0, r0, 1
        QBNE DEL_B66b4, r0, r1

CLC_B66b5:
        MOV r0, 0
        LSR r4, r24, 19
        AND r4, r4, 1
        QBEQ SET_B66b5, r4, 1

CLR_B66b5:
        CLR r30.t15
        JMP DEL_B66b5

SET_B66b5:
        SET r30.t15
        JMP DEL_B66b5

DEL_B66b5:
        ADD r0, r0, 1
        QBNE DEL_B66b5, r0, r1

CLC_B66b6:
        MOV r0, 0
        LSR r4, r24, 18
        AND r4, r4, 1
        QBEQ SET_B66b6, r4, 1

CLR_B66b6:
        CLR r30.t15
        JMP DEL_B66b6

SET_B66b6:
        SET r30.t15
        JMP DEL_B66b6

DEL_B66b6:
        ADD r0, r0, 1
        QBNE DEL_B66b6, r0, r1

CLC_B66b7:
        MOV r0, 0
        LSR r4, r24, 17
        AND r4, r4, 1
        QBEQ SET_B66b7, r4, 1

CLR_B66b7:
        CLR r30.t15
        JMP DEL_B66b7

SET_B66b7:
        SET r30.t15
        JMP DEL_B66b7

DEL_B66b7:
        ADD r0, r0, 1
        QBNE DEL_B66b7, r0, r1

CLC_B66b8:
        MOV r0, 0
        LSR r4, r24, 16
        AND r4, r4, 1
        QBEQ SET_B66b8, r4, 1

CLR_B66b8:
        CLR r30.t15
        JMP DEL_B66b8

SET_B66b8:
        SET r30.t15
        JMP DEL_B66b8

BCK_B66b8:
		JMP BCK_B65b8

DEL_B66b8:
        ADD r0, r0, 1
        QBNE DEL_B66b8, r0, r1

CLC_B67b1:
        MOV r0, 0
        LSR r4, r24, 15
        AND r4, r4, 1
        QBEQ SET_B67b1, r4, 1

CLR_B67b1:
        CLR r30.t15
        JMP DEL_B67b1

SET_B67b1:
        SET r30.t15
        JMP DEL_B67b1

DEL_B67b1:
        ADD r0, r0, 1
        QBNE DEL_B67b1, r0, r1

CLC_B67b2:
        MOV r0, 0
        LSR r4, r24, 14
        AND r4, r4, 1
        QBEQ SET_B67b2, r4, 1

CLR_B67b2:
        CLR r30.t15
        JMP DEL_B67b2

SET_B67b2:
        SET r30.t15
        JMP DEL_B67b2

DEL_B67b2:
        ADD r0, r0, 1
        QBNE DEL_B67b2, r0, r1

CLC_B67b3:
        MOV r0, 0
        LSR r4, r24, 13
        AND r4, r4, 1
        QBEQ SET_B67b3, r4, 1

CLR_B67b3:
        CLR r30.t15
        JMP DEL_B67b3

SET_B67b3:
        SET r30.t15
        JMP DEL_B67b3

DEL_B67b3:
        ADD r0, r0, 1
        QBNE DEL_B67b3, r0, r1

CLC_B67b4:
        MOV r0, 0
        LSR r4, r24, 12
        AND r4, r4, 1
        QBEQ SET_B67b4, r4, 1

CLR_B67b4:
        CLR r30.t15
        JMP DEL_B67b4

SET_B67b4:
        SET r30.t15
        JMP DEL_B67b4

DEL_B67b4:
        ADD r0, r0, 1
        QBNE DEL_B67b4, r0, r1

CLC_B67b5:
        MOV r0, 0
        LSR r4, r24, 11
        AND r4, r4, 1
        QBEQ SET_B67b5, r4, 1

CLR_B67b5:
        CLR r30.t15
        JMP DEL_B67b5

SET_B67b5:
        SET r30.t15
        JMP DEL_B67b5

DEL_B67b5:
        ADD r0, r0, 1
        QBNE DEL_B67b5, r0, r1

CLC_B67b6:
        MOV r0, 0
        LSR r4, r24, 10
        AND r4, r4, 1
        QBEQ SET_B67b6, r4, 1

CLR_B67b6:
        CLR r30.t15
        JMP DEL_B67b6

SET_B67b6:
        SET r30.t15
        JMP DEL_B67b6

DEL_B67b6:
        ADD r0, r0, 1
        QBNE DEL_B67b6, r0, r1

CLC_B67b7:
        MOV r0, 0
        LSR r4, r24, 9
        AND r4, r4, 1
        QBEQ SET_B67b7, r4, 1

CLR_B67b7:
        CLR r30.t15
        JMP DEL_B67b7

SET_B67b7:
        SET r30.t15
        JMP DEL_B67b7

DEL_B67b7:
        ADD r0, r0, 1
        QBNE DEL_B67b7, r0, r1

CLC_B67b8:
        MOV r0, 0
        LSR r4, r24, 8
        AND r4, r4, 1
        QBEQ SET_B67b8, r4, 1

CLR_B67b8:
        CLR r30.t15
        JMP DEL_B67b8

SET_B67b8:
        SET r30.t15
        JMP DEL_B67b8

BCK_B67b8:
		JMP BCK_B66b8

DEL_B67b8:
        ADD r0, r0, 1
        QBNE DEL_B67b8, r0, r1

CLC_B68b1:
        MOV r0, 0
        LSR r4, r24, 7
        AND r4, r4, 1
        QBEQ SET_B68b1, r4, 1

CLR_B68b1:
        CLR r30.t15
        JMP DEL_B68b1

SET_B68b1:
        SET r30.t15
        JMP DEL_B68b1

DEL_B68b1:
        ADD r0, r0, 1
        QBNE DEL_B68b1, r0, r1

CLC_B68b2:
        MOV r0, 0
        LSR r4, r24, 6
        AND r4, r4, 1
        QBEQ SET_B68b2, r4, 1

CLR_B68b2:
        CLR r30.t15
        JMP DEL_B68b2

SET_B68b2:
        SET r30.t15
        JMP DEL_B68b2

DEL_B68b2:
        ADD r0, r0, 1
        QBNE DEL_B68b2, r0, r1

CLC_B68b3:
        MOV r0, 0
        LSR r4, r24, 5
        AND r4, r4, 1
        QBEQ SET_B68b3, r4, 1

CLR_B68b3:
        CLR r30.t15
        JMP DEL_B68b3

SET_B68b3:
        SET r30.t15
        JMP DEL_B68b3

DEL_B68b3:
        ADD r0, r0, 1
        QBNE DEL_B68b3, r0, r1

CLC_B68b4:
        MOV r0, 0
        LSR r4, r24, 4
        AND r4, r4, 1
        QBEQ SET_B68b4, r4, 1

CLR_B68b4:
        CLR r30.t15
        JMP DEL_B68b4

SET_B68b4:
        SET r30.t15
        JMP DEL_B68b4

DEL_B68b4:
        ADD r0, r0, 1
        QBNE DEL_B68b4, r0, r1

CLC_B68b5:
        MOV r0, 0
        LSR r4, r24, 3
        AND r4, r4, 1
        QBEQ SET_B68b5, r4, 1

CLR_B68b5:
        CLR r30.t15
        JMP DEL_B68b5

SET_B68b5:
        SET r30.t15
        JMP DEL_B68b5

DEL_B68b5:
        ADD r0, r0, 1
        QBNE DEL_B68b5, r0, r1

CLC_B68b6:
        MOV r0, 0
        LSR r4, r24, 2
        AND r4, r4, 1
        QBEQ SET_B68b6, r4, 1

CLR_B68b6:
        CLR r30.t15
        JMP DEL_B68b6

SET_B68b6:
        SET r30.t15
        JMP DEL_B68b6

DEL_B68b6:
        ADD r0, r0, 1
        QBNE DEL_B68b6, r0, r1

CLC_B68b7:
        MOV r0, 0
        LSR r4, r24, 1
        AND r4, r4, 1
        QBEQ SET_B68b7, r4, 1

CLR_B68b7:
        CLR r30.t15
        JMP DEL_B68b7

SET_B68b7:
        SET r30.t15
        JMP DEL_B68b7

DEL_B68b7:
        ADD r0, r0, 1
        QBNE DEL_B68b7, r0, r1

CLC_B68b8:
        MOV r0, 0
        LSR r4, r24, 0
        AND r4, r4, 1
        QBEQ SET_B68b8, r4, 1

CLR_B68b8:
        CLR r30.t15
        JMP DEL_B68b8

SET_B68b8:
        SET r30.t15
        JMP DEL_B68b8

BCK_B68b8:
		JMP BCK_B67b8

DEL_B68b8:
        ADD r0, r0, 1
        QBNE DEL_B68b8, r0, r1

CLC_B69b1:
        MOV r0, 0
        LSR r4, r25, 31
        AND r4, r4, 1
        QBEQ SET_B69b1, r4, 1

CLR_B69b1:
        CLR r30.t15
        JMP DEL_B69b1

SET_B69b1:
        SET r30.t15
        JMP DEL_B69b1

DEL_B69b1:
        ADD r0, r0, 1
        QBNE DEL_B69b1, r0, r1

CLC_B69b2:
        MOV r0, 0
        LSR r4, r25, 30
        AND r4, r4, 1
        QBEQ SET_B69b2, r4, 1

CLR_B69b2:
        CLR r30.t15
        JMP DEL_B69b2

SET_B69b2:
        SET r30.t15
        JMP DEL_B69b2

DEL_B69b2:
        ADD r0, r0, 1
        QBNE DEL_B69b2, r0, r1

CLC_B69b3:
        MOV r0, 0
        LSR r4, r25, 29
        AND r4, r4, 1
        QBEQ SET_B69b3, r4, 1

CLR_B69b3:
        CLR r30.t15
        JMP DEL_B69b3

SET_B69b3:
        SET r30.t15
        JMP DEL_B69b3

DEL_B69b3:
        ADD r0, r0, 1
        QBNE DEL_B69b3, r0, r1

CLC_B69b4:
        MOV r0, 0
        LSR r4, r25, 28
        AND r4, r4, 1
        QBEQ SET_B69b4, r4, 1

CLR_B69b4:
        CLR r30.t15
        JMP DEL_B69b4

SET_B69b4:
        SET r30.t15
        JMP DEL_B69b4

DEL_B69b4:
        ADD r0, r0, 1
        QBNE DEL_B69b4, r0, r1

CLC_B69b5:
        MOV r0, 0
        LSR r4, r25, 27
        AND r4, r4, 1
        QBEQ SET_B69b5, r4, 1

CLR_B69b5:
        CLR r30.t15
        JMP DEL_B69b5

SET_B69b5:
        SET r30.t15
        JMP DEL_B69b5

DEL_B69b5:
        ADD r0, r0, 1
        QBNE DEL_B69b5, r0, r1

CLC_B69b6:
        MOV r0, 0
        LSR r4, r25, 26
        AND r4, r4, 1
        QBEQ SET_B69b6, r4, 1

CLR_B69b6:
        CLR r30.t15
        JMP DEL_B69b6

SET_B69b6:
        SET r30.t15
        JMP DEL_B69b6

DEL_B69b6:
        ADD r0, r0, 1
        QBNE DEL_B69b6, r0, r1

CLC_B69b7:
        MOV r0, 0
        LSR r4, r25, 25
        AND r4, r4, 1
        QBEQ SET_B69b7, r4, 1

CLR_B69b7:
        CLR r30.t15
        JMP DEL_B69b7

SET_B69b7:
        SET r30.t15
        JMP DEL_B69b7

DEL_B69b7:
        ADD r0, r0, 1
        QBNE DEL_B69b7, r0, r1

CLC_B69b8:
        MOV r0, 0
        LSR r4, r25, 24
        AND r4, r4, 1
        QBEQ SET_B69b8, r4, 1

CLR_B69b8:
        CLR r30.t15
        JMP DEL_B69b8

SET_B69b8:
        SET r30.t15
        JMP DEL_B69b8

BCK_B69b8:
		JMP BCK_B68b8

DEL_B69b8:
        ADD r0, r0, 1
        QBNE DEL_B69b8, r0, r1

CLC_B70b1:
        MOV r0, 0
        LSR r4, r25, 23
        AND r4, r4, 1
        QBEQ SET_B70b1, r4, 1

CLR_B70b1:
        CLR r30.t15
        JMP DEL_B70b1

SET_B70b1:
        SET r30.t15
        JMP DEL_B70b1

DEL_B70b1:
        ADD r0, r0, 1
        QBNE DEL_B70b1, r0, r1

CLC_B70b2:
        MOV r0, 0
        LSR r4, r25, 22
        AND r4, r4, 1
        QBEQ SET_B70b2, r4, 1

CLR_B70b2:
        CLR r30.t15
        JMP DEL_B70b2

SET_B70b2:
        SET r30.t15
        JMP DEL_B70b2

DEL_B70b2:
        ADD r0, r0, 1
        QBNE DEL_B70b2, r0, r1

CLC_B70b3:
        MOV r0, 0
        LSR r4, r25, 21
        AND r4, r4, 1
        QBEQ SET_B70b3, r4, 1

CLR_B70b3:
        CLR r30.t15
        JMP DEL_B70b3

SET_B70b3:
        SET r30.t15
        JMP DEL_B70b3

DEL_B70b3:
        ADD r0, r0, 1
        QBNE DEL_B70b3, r0, r1

CLC_B70b4:
        MOV r0, 0
        LSR r4, r25, 20
        AND r4, r4, 1
        QBEQ SET_B70b4, r4, 1

CLR_B70b4:
        CLR r30.t15
        JMP DEL_B70b4

SET_B70b4:
        SET r30.t15
        JMP DEL_B70b4

DEL_B70b4:
        ADD r0, r0, 1
        QBNE DEL_B70b4, r0, r1

CLC_B70b5:
        MOV r0, 0
        LSR r4, r25, 19
        AND r4, r4, 1
        QBEQ SET_B70b5, r4, 1

CLR_B70b5:
        CLR r30.t15
        JMP DEL_B70b5

SET_B70b5:
        SET r30.t15
        JMP DEL_B70b5

DEL_B70b5:
        ADD r0, r0, 1
        QBNE DEL_B70b5, r0, r1

CLC_B70b6:
        MOV r0, 0
        LSR r4, r25, 18
        AND r4, r4, 1
        QBEQ SET_B70b6, r4, 1

CLR_B70b6:
        CLR r30.t15
        JMP DEL_B70b6

SET_B70b6:
        SET r30.t15
        JMP DEL_B70b6

DEL_B70b6:
        ADD r0, r0, 1
        QBNE DEL_B70b6, r0, r1

CLC_B70b7:
        MOV r0, 0
        LSR r4, r25, 17
        AND r4, r4, 1
        QBEQ SET_B70b7, r4, 1

CLR_B70b7:
        CLR r30.t15
        JMP DEL_B70b7

SET_B70b7:
        SET r30.t15
        JMP DEL_B70b7

DEL_B70b7:
        ADD r0, r0, 1
        QBNE DEL_B70b7, r0, r1

CLC_B70b8:
        MOV r0, 0
        LSR r4, r25, 16
        AND r4, r4, 1
        QBEQ SET_B70b8, r4, 1

CLR_B70b8:
        CLR r30.t15
        JMP DEL_B70b8

SET_B70b8:
        SET r30.t15
        JMP DEL_B70b8

BCK_B70b8:
		JMP BCK_B69b8

DEL_B70b8:
        ADD r0, r0, 1
        QBNE DEL_B70b8, r0, r1

CLC_B71b1:
        MOV r0, 0
        LSR r4, r25, 15
        AND r4, r4, 1
        QBEQ SET_B71b1, r4, 1

CLR_B71b1:
        CLR r30.t15
        JMP DEL_B71b1

SET_B71b1:
        SET r30.t15
        JMP DEL_B71b1

DEL_B71b1:
        ADD r0, r0, 1
        QBNE DEL_B71b1, r0, r1

CLC_B71b2:
        MOV r0, 0
        LSR r4, r25, 14
        AND r4, r4, 1
        QBEQ SET_B71b2, r4, 1

CLR_B71b2:
        CLR r30.t15
        JMP DEL_B71b2

SET_B71b2:
        SET r30.t15
        JMP DEL_B71b2

DEL_B71b2:
        ADD r0, r0, 1
        QBNE DEL_B71b2, r0, r1

CLC_B71b3:
        MOV r0, 0
        LSR r4, r25, 13
        AND r4, r4, 1
        QBEQ SET_B71b3, r4, 1

CLR_B71b3:
        CLR r30.t15
        JMP DEL_B71b3

SET_B71b3:
        SET r30.t15
        JMP DEL_B71b3

DEL_B71b3:
        ADD r0, r0, 1
        QBNE DEL_B71b3, r0, r1

CLC_B71b4:
        MOV r0, 0
        LSR r4, r25, 12
        AND r4, r4, 1
        QBEQ SET_B71b4, r4, 1

CLR_B71b4:
        CLR r30.t15
        JMP DEL_B71b4

SET_B71b4:
        SET r30.t15
        JMP DEL_B71b4

DEL_B71b4:
        ADD r0, r0, 1
        QBNE DEL_B71b4, r0, r1

CLC_B71b5:
        MOV r0, 0
        LSR r4, r25, 11
        AND r4, r4, 1
        QBEQ SET_B71b5, r4, 1

CLR_B71b5:
        CLR r30.t15
        JMP DEL_B71b5

SET_B71b5:
        SET r30.t15
        JMP DEL_B71b5

DEL_B71b5:
        ADD r0, r0, 1
        QBNE DEL_B71b5, r0, r1

CLC_B71b6:
        MOV r0, 0
        LSR r4, r25, 10
        AND r4, r4, 1
        QBEQ SET_B71b6, r4, 1

CLR_B71b6:
        CLR r30.t15
        JMP DEL_B71b6

SET_B71b6:
        SET r30.t15
        JMP DEL_B71b6

DEL_B71b6:
        ADD r0, r0, 1
        QBNE DEL_B71b6, r0, r1

CLC_B71b7:
        MOV r0, 0
        LSR r4, r25, 9
        AND r4, r4, 1
        QBEQ SET_B71b7, r4, 1

CLR_B71b7:
        CLR r30.t15
        JMP DEL_B71b7

SET_B71b7:
        SET r30.t15
        JMP DEL_B71b7

DEL_B71b7:
        ADD r0, r0, 1
        QBNE DEL_B71b7, r0, r1

CLC_B71b8:
        MOV r0, 0
        LSR r4, r25, 8
        AND r4, r4, 1
        QBEQ SET_B71b8, r4, 1

CLR_B71b8:
        CLR r30.t15
        JMP DEL_B71b8

SET_B71b8:
        SET r30.t15
        JMP DEL_B71b8

BCK_B71b8:
		JMP BCK_B70b8

DEL_B71b8:
        ADD r0, r0, 1
        QBNE DEL_B71b8, r0, r1

CLC_B72b1:
        MOV r0, 0
        LSR r4, r25, 7
        AND r4, r4, 1
        QBEQ SET_B72b1, r4, 1

CLR_B72b1:
        CLR r30.t15
        JMP DEL_B72b1

SET_B72b1:
        SET r30.t15
        JMP DEL_B72b1

DEL_B72b1:
        ADD r0, r0, 1
        QBNE DEL_B72b1, r0, r1

CLC_B72b2:
        MOV r0, 0
        LSR r4, r25, 6
        AND r4, r4, 1
        QBEQ SET_B72b2, r4, 1

CLR_B72b2:
        CLR r30.t15
        JMP DEL_B72b2

SET_B72b2:
        SET r30.t15
        JMP DEL_B72b2

DEL_B72b2:
        ADD r0, r0, 1
        QBNE DEL_B72b2, r0, r1

CLC_B72b3:
        MOV r0, 0
        LSR r4, r25, 5
        AND r4, r4, 1
        QBEQ SET_B72b3, r4, 1

CLR_B72b3:
        CLR r30.t15
        JMP DEL_B72b3

SET_B72b3:
        SET r30.t15
        JMP DEL_B72b3

DEL_B72b3:
        ADD r0, r0, 1
        QBNE DEL_B72b3, r0, r1

CLC_B72b4:
        MOV r0, 0
        LSR r4, r25, 4
        AND r4, r4, 1
        QBEQ SET_B72b4, r4, 1

CLR_B72b4:
        CLR r30.t15
        JMP DEL_B72b4

SET_B72b4:
        SET r30.t15
        JMP DEL_B72b4

DEL_B72b4:
        ADD r0, r0, 1
        QBNE DEL_B72b4, r0, r1

CLC_B72b5:
        MOV r0, 0
        LSR r4, r25, 3
        AND r4, r4, 1
        QBEQ SET_B72b5, r4, 1

CLR_B72b5:
        CLR r30.t15
        JMP DEL_B72b5

SET_B72b5:
        SET r30.t15
        JMP DEL_B72b5

DEL_B72b5:
        ADD r0, r0, 1
        QBNE DEL_B72b5, r0, r1

CLC_B72b6:
        MOV r0, 0
        LSR r4, r25, 2
        AND r4, r4, 1
        QBEQ SET_B72b6, r4, 1

CLR_B72b6:
        CLR r30.t15
        JMP DEL_B72b6

SET_B72b6:
        SET r30.t15
        JMP DEL_B72b6

DEL_B72b6:
        ADD r0, r0, 1
        QBNE DEL_B72b6, r0, r1

CLC_B72b7:
        MOV r0, 0
        LSR r4, r25, 1
        AND r4, r4, 1
        QBEQ SET_B72b7, r4, 1

CLR_B72b7:
        CLR r30.t15
        JMP DEL_B72b7

SET_B72b7:
        SET r30.t15
        JMP DEL_B72b7

DEL_B72b7:
        ADD r0, r0, 1
        QBNE DEL_B72b7, r0, r1

CLC_B72b8:
        MOV r0, 0
        LSR r4, r25, 0
        AND r4, r4, 1
        QBEQ SET_B72b8, r4, 1

CLR_B72b8:
        CLR r30.t15
        JMP DEL_B72b8

SET_B72b8:
        SET r30.t15
        JMP DEL_B72b8

BCK_B72b8:
		JMP BCK_B71b8

DEL_B72b8:
        ADD r0, r0, 1
        QBNE DEL_B72b8, r0, r1

CLC_B73b1:
        MOV r0, 0
        LSR r4, r26, 31
        AND r4, r4, 1
        QBEQ SET_B73b1, r4, 1

CLR_B73b1:
        CLR r30.t15
        JMP DEL_B73b1

SET_B73b1:
        SET r30.t15
        JMP DEL_B73b1

DEL_B73b1:
        ADD r0, r0, 1
        QBNE DEL_B73b1, r0, r1

CLC_B73b2:
        MOV r0, 0
        LSR r4, r26, 30
        AND r4, r4, 1
        QBEQ SET_B73b2, r4, 1

CLR_B73b2:
        CLR r30.t15
        JMP DEL_B73b2

SET_B73b2:
        SET r30.t15
        JMP DEL_B73b2

DEL_B73b2:
        ADD r0, r0, 1
        QBNE DEL_B73b2, r0, r1

CLC_B73b3:
        MOV r0, 0
        LSR r4, r26, 29
        AND r4, r4, 1
        QBEQ SET_B73b3, r4, 1

CLR_B73b3:
        CLR r30.t15
        JMP DEL_B73b3

SET_B73b3:
        SET r30.t15
        JMP DEL_B73b3

DEL_B73b3:
        ADD r0, r0, 1
        QBNE DEL_B73b3, r0, r1

CLC_B73b4:
        MOV r0, 0
        LSR r4, r26, 28
        AND r4, r4, 1
        QBEQ SET_B73b4, r4, 1

CLR_B73b4:
        CLR r30.t15
        JMP DEL_B73b4

SET_B73b4:
        SET r30.t15
        JMP DEL_B73b4

DEL_B73b4:
        ADD r0, r0, 1
        QBNE DEL_B73b4, r0, r1

CLC_B73b5:
        MOV r0, 0
        LSR r4, r26, 27
        AND r4, r4, 1
        QBEQ SET_B73b5, r4, 1

CLR_B73b5:
        CLR r30.t15
        JMP DEL_B73b5

SET_B73b5:
        SET r30.t15
        JMP DEL_B73b5

DEL_B73b5:
        ADD r0, r0, 1
        QBNE DEL_B73b5, r0, r1

CLC_B73b6:
        MOV r0, 0
        LSR r4, r26, 26
        AND r4, r4, 1
        QBEQ SET_B73b6, r4, 1

CLR_B73b6:
        CLR r30.t15
        JMP DEL_B73b6

SET_B73b6:
        SET r30.t15
        JMP DEL_B73b6

DEL_B73b6:
        ADD r0, r0, 1
        QBNE DEL_B73b6, r0, r1

CLC_B73b7:
        MOV r0, 0
        LSR r4, r26, 25
        AND r4, r4, 1
        QBEQ SET_B73b7, r4, 1

CLR_B73b7:
        CLR r30.t15
        JMP DEL_B73b7

SET_B73b7:
        SET r30.t15
        JMP DEL_B73b7

DEL_B73b7:
        ADD r0, r0, 1
        QBNE DEL_B73b7, r0, r1

CLC_B73b8:
        MOV r0, 0
        LSR r4, r26, 24
        AND r4, r4, 1
        QBEQ SET_B73b8, r4, 1

CLR_B73b8:
        CLR r30.t15
        JMP DEL_B73b8

SET_B73b8:
        SET r30.t15
        JMP DEL_B73b8

BCK_B73b8:
		JMP BCK_B72b8

DEL_B73b8:
        ADD r0, r0, 1
        QBNE DEL_B73b8, r0, r1

CLC_B74b1:
        MOV r0, 0
        LSR r4, r26, 23
        AND r4, r4, 1
        QBEQ SET_B74b1, r4, 1

CLR_B74b1:
        CLR r30.t15
        JMP DEL_B74b1

SET_B74b1:
        SET r30.t15
        JMP DEL_B74b1

DEL_B74b1:
        ADD r0, r0, 1
        QBNE DEL_B74b1, r0, r1

CLC_B74b2:
        MOV r0, 0
        LSR r4, r26, 22
        AND r4, r4, 1
        QBEQ SET_B74b2, r4, 1

CLR_B74b2:
        CLR r30.t15
        JMP DEL_B74b2

SET_B74b2:
        SET r30.t15
        JMP DEL_B74b2

DEL_B74b2:
        ADD r0, r0, 1
        QBNE DEL_B74b2, r0, r1

CLC_B74b3:
        MOV r0, 0
        LSR r4, r26, 21
        AND r4, r4, 1
        QBEQ SET_B74b3, r4, 1

CLR_B74b3:
        CLR r30.t15
        JMP DEL_B74b3

SET_B74b3:
        SET r30.t15
        JMP DEL_B74b3

DEL_B74b3:
        ADD r0, r0, 1
        QBNE DEL_B74b3, r0, r1

CLC_B74b4:
        MOV r0, 0
        LSR r4, r26, 20
        AND r4, r4, 1
        QBEQ SET_B74b4, r4, 1

CLR_B74b4:
        CLR r30.t15
        JMP DEL_B74b4

SET_B74b4:
        SET r30.t15
        JMP DEL_B74b4

DEL_B74b4:
        ADD r0, r0, 1
        QBNE DEL_B74b4, r0, r1

CLC_B74b5:
        MOV r0, 0
        LSR r4, r26, 19
        AND r4, r4, 1
        QBEQ SET_B74b5, r4, 1

CLR_B74b5:
        CLR r30.t15
        JMP DEL_B74b5

SET_B74b5:
        SET r30.t15
        JMP DEL_B74b5

DEL_B74b5:
        ADD r0, r0, 1
        QBNE DEL_B74b5, r0, r1

CLC_B74b6:
        MOV r0, 0
        LSR r4, r26, 18
        AND r4, r4, 1
        QBEQ SET_B74b6, r4, 1

CLR_B74b6:
        CLR r30.t15
        JMP DEL_B74b6

SET_B74b6:
        SET r30.t15
        JMP DEL_B74b6

DEL_B74b6:
        ADD r0, r0, 1
        QBNE DEL_B74b6, r0, r1

CLC_B74b7:
        MOV r0, 0
        LSR r4, r26, 17
        AND r4, r4, 1
        QBEQ SET_B74b7, r4, 1

CLR_B74b7:
        CLR r30.t15
        JMP DEL_B74b7

SET_B74b7:
        SET r30.t15
        JMP DEL_B74b7

DEL_B74b7:
        ADD r0, r0, 1
        QBNE DEL_B74b7, r0, r1

CLC_B74b8:
        MOV r0, 0
        LSR r4, r26, 16
        AND r4, r4, 1
        QBEQ SET_B74b8, r4, 1

CLR_B74b8:
        CLR r30.t15
        JMP DEL_B74b8

SET_B74b8:
        SET r30.t15
        JMP DEL_B74b8

BCK_B74b8:
		JMP BCK_B73b8

DEL_B74b8:
        ADD r0, r0, 1
        QBNE DEL_B74b8, r0, r1

CLC_B75b1:
        MOV r0, 0
        LSR r4, r26, 15
        AND r4, r4, 1
        QBEQ SET_B75b1, r4, 1

CLR_B75b1:
        CLR r30.t15
        JMP DEL_B75b1

SET_B75b1:
        SET r30.t15
        JMP DEL_B75b1

DEL_B75b1:
        ADD r0, r0, 1
        QBNE DEL_B75b1, r0, r1

CLC_B75b2:
        MOV r0, 0
        LSR r4, r26, 14
        AND r4, r4, 1
        QBEQ SET_B75b2, r4, 1

CLR_B75b2:
        CLR r30.t15
        JMP DEL_B75b2

SET_B75b2:
        SET r30.t15
        JMP DEL_B75b2

DEL_B75b2:
        ADD r0, r0, 1
        QBNE DEL_B75b2, r0, r1

CLC_B75b3:
        MOV r0, 0
        LSR r4, r26, 13
        AND r4, r4, 1
        QBEQ SET_B75b3, r4, 1

CLR_B75b3:
        CLR r30.t15
        JMP DEL_B75b3

SET_B75b3:
        SET r30.t15
        JMP DEL_B75b3

DEL_B75b3:
        ADD r0, r0, 1
        QBNE DEL_B75b3, r0, r1

CLC_B75b4:
        MOV r0, 0
        LSR r4, r26, 12
        AND r4, r4, 1
        QBEQ SET_B75b4, r4, 1

CLR_B75b4:
        CLR r30.t15
        JMP DEL_B75b4

SET_B75b4:
        SET r30.t15
        JMP DEL_B75b4

DEL_B75b4:
        ADD r0, r0, 1
        QBNE DEL_B75b4, r0, r1

CLC_B75b5:
        MOV r0, 0
        LSR r4, r26, 11
        AND r4, r4, 1
        QBEQ SET_B75b5, r4, 1

CLR_B75b5:
        CLR r30.t15
        JMP DEL_B75b5

SET_B75b5:
        SET r30.t15
        JMP DEL_B75b5

DEL_B75b5:
        ADD r0, r0, 1
        QBNE DEL_B75b5, r0, r1

CLC_B75b6:
        MOV r0, 0
        LSR r4, r26, 10
        AND r4, r4, 1
        QBEQ SET_B75b6, r4, 1

CLR_B75b6:
        CLR r30.t15
        JMP DEL_B75b6

SET_B75b6:
        SET r30.t15
        JMP DEL_B75b6

DEL_B75b6:
        ADD r0, r0, 1
        QBNE DEL_B75b6, r0, r1

CLC_B75b7:
        MOV r0, 0
        LSR r4, r26, 9
        AND r4, r4, 1
        QBEQ SET_B75b7, r4, 1

CLR_B75b7:
        CLR r30.t15
        JMP DEL_B75b7

SET_B75b7:
        SET r30.t15
        JMP DEL_B75b7

DEL_B75b7:
        ADD r0, r0, 1
        QBNE DEL_B75b7, r0, r1

CLC_B75b8:
        MOV r0, 0
        LSR r4, r26, 8
        AND r4, r4, 1
        QBEQ SET_B75b8, r4, 1

CLR_B75b8:
        CLR r30.t15
        JMP DEL_B75b8

SET_B75b8:
        SET r30.t15
        JMP DEL_B75b8

BCK_B75b8:
		JMP BCK_B74b8

DEL_B75b8:
        ADD r0, r0, 1
        QBNE DEL_B75b8, r0, r1

CLC_B76b1:
        MOV r0, 0
        LSR r4, r26, 7
        AND r4, r4, 1
        QBEQ SET_B76b1, r4, 1

CLR_B76b1:
        CLR r30.t15
        JMP DEL_B76b1

SET_B76b1:
        SET r30.t15
        JMP DEL_B76b1

DEL_B76b1:
        ADD r0, r0, 1
        QBNE DEL_B76b1, r0, r1

CLC_B76b2:
        MOV r0, 0
        LSR r4, r26, 6
        AND r4, r4, 1
        QBEQ SET_B76b2, r4, 1

CLR_B76b2:
        CLR r30.t15
        JMP DEL_B76b2

SET_B76b2:
        SET r30.t15
        JMP DEL_B76b2

DEL_B76b2:
        ADD r0, r0, 1
        QBNE DEL_B76b2, r0, r1

CLC_B76b3:
        MOV r0, 0
        LSR r4, r26, 5
        AND r4, r4, 1
        QBEQ SET_B76b3, r4, 1

CLR_B76b3:
        CLR r30.t15
        JMP DEL_B76b3

SET_B76b3:
        SET r30.t15
        JMP DEL_B76b3

DEL_B76b3:
        ADD r0, r0, 1
        QBNE DEL_B76b3, r0, r1

CLC_B76b4:
        MOV r0, 0
        LSR r4, r26, 4
        AND r4, r4, 1
        QBEQ SET_B76b4, r4, 1

CLR_B76b4:
        CLR r30.t15
        JMP DEL_B76b4

SET_B76b4:
        SET r30.t15
        JMP DEL_B76b4

DEL_B76b4:
        ADD r0, r0, 1
        QBNE DEL_B76b4, r0, r1

CLC_B76b5:
        MOV r0, 0
        LSR r4, r26, 3
        AND r4, r4, 1
        QBEQ SET_B76b5, r4, 1

CLR_B76b5:
        CLR r30.t15
        JMP DEL_B76b5

SET_B76b5:
        SET r30.t15
        JMP DEL_B76b5

DEL_B76b5:
        ADD r0, r0, 1
        QBNE DEL_B76b5, r0, r1

CLC_B76b6:
        MOV r0, 0
        LSR r4, r26, 2
        AND r4, r4, 1
        QBEQ SET_B76b6, r4, 1

CLR_B76b6:
        CLR r30.t15
        JMP DEL_B76b6

SET_B76b6:
        SET r30.t15
        JMP DEL_B76b6

DEL_B76b6:
        ADD r0, r0, 1
        QBNE DEL_B76b6, r0, r1

CLC_B76b7:
        MOV r0, 0
        LSR r4, r26, 1
        AND r4, r4, 1
        QBEQ SET_B76b7, r4, 1

CLR_B76b7:
        CLR r30.t15
        JMP DEL_B76b7

SET_B76b7:
        SET r30.t15
        JMP DEL_B76b7

DEL_B76b7:
        ADD r0, r0, 1
        QBNE DEL_B76b7, r0, r1

CLC_B76b8:
        MOV r0, 0
        LSR r4, r26, 0
        AND r4, r4, 1
        QBEQ SET_B76b8, r4, 1

CLR_B76b8:
        CLR r30.t15
        JMP DEL_B76b8

SET_B76b8:
        SET r30.t15
        JMP DEL_B76b8

BCK_B76b8:
		JMP BCK_B75b8

DEL_B76b8:
        ADD r0, r0, 1
        QBNE DEL_B76b8, r0, r1

CLC_B77b1:
        MOV r0, 0
        LSR r4, r27, 31
        AND r4, r4, 1
        QBEQ SET_B77b1, r4, 1

CLR_B77b1:
        CLR r30.t15
        JMP DEL_B77b1

SET_B77b1:
        SET r30.t15
        JMP DEL_B77b1

DEL_B77b1:
        ADD r0, r0, 1
        QBNE DEL_B77b1, r0, r1

CLC_B77b2:
        MOV r0, 0
        LSR r4, r27, 30
        AND r4, r4, 1
        QBEQ SET_B77b2, r4, 1

CLR_B77b2:
        CLR r30.t15
        JMP DEL_B77b2

SET_B77b2:
        SET r30.t15
        JMP DEL_B77b2

DEL_B77b2:
        ADD r0, r0, 1
        QBNE DEL_B77b2, r0, r1

CLC_B77b3:
        MOV r0, 0
        LSR r4, r27, 29
        AND r4, r4, 1
        QBEQ SET_B77b3, r4, 1

CLR_B77b3:
        CLR r30.t15
        JMP DEL_B77b3

SET_B77b3:
        SET r30.t15
        JMP DEL_B77b3

DEL_B77b3:
        ADD r0, r0, 1
        QBNE DEL_B77b3, r0, r1

CLC_B77b4:
        MOV r0, 0
        LSR r4, r27, 28
        AND r4, r4, 1
        QBEQ SET_B77b4, r4, 1

CLR_B77b4:
        CLR r30.t15
        JMP DEL_B77b4

SET_B77b4:
        SET r30.t15
        JMP DEL_B77b4

DEL_B77b4:
        ADD r0, r0, 1
        QBNE DEL_B77b4, r0, r1

CLC_B77b5:
        MOV r0, 0
        LSR r4, r27, 27
        AND r4, r4, 1
        QBEQ SET_B77b5, r4, 1

CLR_B77b5:
        CLR r30.t15
        JMP DEL_B77b5

SET_B77b5:
        SET r30.t15
        JMP DEL_B77b5

DEL_B77b5:
        ADD r0, r0, 1
        QBNE DEL_B77b5, r0, r1

CLC_B77b6:
        MOV r0, 0
        LSR r4, r27, 26
        AND r4, r4, 1
        QBEQ SET_B77b6, r4, 1

CLR_B77b6:
        CLR r30.t15
        JMP DEL_B77b6

SET_B77b6:
        SET r30.t15
        JMP DEL_B77b6

DEL_B77b6:
        ADD r0, r0, 1
        QBNE DEL_B77b6, r0, r1

CLC_B77b7:
        MOV r0, 0
        LSR r4, r27, 25
        AND r4, r4, 1
        QBEQ SET_B77b7, r4, 1

CLR_B77b7:
        CLR r30.t15
        JMP DEL_B77b7

SET_B77b7:
        SET r30.t15
        JMP DEL_B77b7

DEL_B77b7:
        ADD r0, r0, 1
        QBNE DEL_B77b7, r0, r1

CLC_B77b8:
        MOV r0, 0
        LSR r4, r27, 24
        AND r4, r4, 1
        QBEQ SET_B77b8, r4, 1

CLR_B77b8:
        CLR r30.t15
        JMP DEL_B77b8

SET_B77b8:
        SET r30.t15
        JMP DEL_B77b8

BCK_B77b8:
		JMP BCK_B76b8

DEL_B77b8:
        ADD r0, r0, 1
        QBNE DEL_B77b8, r0, r1

CLC_B78b1:
        MOV r0, 0
        LSR r4, r27, 23
        AND r4, r4, 1
        QBEQ SET_B78b1, r4, 1

CLR_B78b1:
        CLR r30.t15
        JMP DEL_B78b1

SET_B78b1:
        SET r30.t15
        JMP DEL_B78b1

DEL_B78b1:
        ADD r0, r0, 1
        QBNE DEL_B78b1, r0, r1

CLC_B78b2:
        MOV r0, 0
        LSR r4, r27, 22
        AND r4, r4, 1
        QBEQ SET_B78b2, r4, 1

CLR_B78b2:
        CLR r30.t15
        JMP DEL_B78b2

SET_B78b2:
        SET r30.t15
        JMP DEL_B78b2

DEL_B78b2:
        ADD r0, r0, 1
        QBNE DEL_B78b2, r0, r1

CLC_B78b3:
        MOV r0, 0
        LSR r4, r27, 21
        AND r4, r4, 1
        QBEQ SET_B78b3, r4, 1

CLR_B78b3:
        CLR r30.t15
        JMP DEL_B78b3

SET_B78b3:
        SET r30.t15
        JMP DEL_B78b3

DEL_B78b3:
        ADD r0, r0, 1
        QBNE DEL_B78b3, r0, r1

CLC_B78b4:
        MOV r0, 0
        LSR r4, r27, 20
        AND r4, r4, 1
        QBEQ SET_B78b4, r4, 1

CLR_B78b4:
        CLR r30.t15
        JMP DEL_B78b4

SET_B78b4:
        SET r30.t15
        JMP DEL_B78b4

DEL_B78b4:
        ADD r0, r0, 1
        QBNE DEL_B78b4, r0, r1

CLC_B78b5:
        MOV r0, 0
        LSR r4, r27, 19
        AND r4, r4, 1
        QBEQ SET_B78b5, r4, 1

CLR_B78b5:
        CLR r30.t15
        JMP DEL_B78b5

SET_B78b5:
        SET r30.t15
        JMP DEL_B78b5

DEL_B78b5:
        ADD r0, r0, 1
        QBNE DEL_B78b5, r0, r1

CLC_B78b6:
        MOV r0, 0
        LSR r4, r27, 18
        AND r4, r4, 1
        QBEQ SET_B78b6, r4, 1

CLR_B78b6:
        CLR r30.t15
        JMP DEL_B78b6

SET_B78b6:
        SET r30.t15
        JMP DEL_B78b6

DEL_B78b6:
        ADD r0, r0, 1
        QBNE DEL_B78b6, r0, r1

CLC_B78b7:
        MOV r0, 0
        LSR r4, r27, 17
        AND r4, r4, 1
        QBEQ SET_B78b7, r4, 1

CLR_B78b7:
        CLR r30.t15
        JMP DEL_B78b7

SET_B78b7:
        SET r30.t15
        JMP DEL_B78b7

DEL_B78b7:
        ADD r0, r0, 1
        QBNE DEL_B78b7, r0, r1

CLC_B78b8:
        MOV r0, 0
        LSR r4, r27, 16
        AND r4, r4, 1
        QBEQ SET_B78b8, r4, 1

CLR_B78b8:
        CLR r30.t15
        JMP DEL_B78b8

SET_B78b8:
        SET r30.t15
        JMP DEL_B78b8

BCK_B78b8:
		JMP BCK_B77b8

DEL_B78b8:
        ADD r0, r0, 1
        QBNE DEL_B78b8, r0, r1

CLC_B79b1:
        MOV r0, 0
        LSR r4, r27, 15
        AND r4, r4, 1
        QBEQ SET_B79b1, r4, 1

CLR_B79b1:
        CLR r30.t15
        JMP DEL_B79b1

SET_B79b1:
        SET r30.t15
        JMP DEL_B79b1

DEL_B79b1:
        ADD r0, r0, 1
        QBNE DEL_B79b1, r0, r1

CLC_B79b2:
        MOV r0, 0
        LSR r4, r27, 14
        AND r4, r4, 1
        QBEQ SET_B79b2, r4, 1

CLR_B79b2:
        CLR r30.t15
        JMP DEL_B79b2

SET_B79b2:
        SET r30.t15
        JMP DEL_B79b2

DEL_B79b2:
        ADD r0, r0, 1
        QBNE DEL_B79b2, r0, r1

CLC_B79b3:
        MOV r0, 0
        LSR r4, r27, 13
        AND r4, r4, 1
        QBEQ SET_B79b3, r4, 1

CLR_B79b3:
        CLR r30.t15
        JMP DEL_B79b3

SET_B79b3:
        SET r30.t15
        JMP DEL_B79b3

DEL_B79b3:
        ADD r0, r0, 1
        QBNE DEL_B79b3, r0, r1

CLC_B79b4:
        MOV r0, 0
        LSR r4, r27, 12
        AND r4, r4, 1
        QBEQ SET_B79b4, r4, 1

CLR_B79b4:
        CLR r30.t15
        JMP DEL_B79b4

SET_B79b4:
        SET r30.t15
        JMP DEL_B79b4

DEL_B79b4:
        ADD r0, r0, 1
        QBNE DEL_B79b4, r0, r1

CLC_B79b5:
        MOV r0, 0
        LSR r4, r27, 11
        AND r4, r4, 1
        QBEQ SET_B79b5, r4, 1

CLR_B79b5:
        CLR r30.t15
        JMP DEL_B79b5

SET_B79b5:
        SET r30.t15
        JMP DEL_B79b5

DEL_B79b5:
        ADD r0, r0, 1
        QBNE DEL_B79b5, r0, r1

CLC_B79b6:
        MOV r0, 0
        LSR r4, r27, 10
        AND r4, r4, 1
        QBEQ SET_B79b6, r4, 1

CLR_B79b6:
        CLR r30.t15
        JMP DEL_B79b6

SET_B79b6:
        SET r30.t15
        JMP DEL_B79b6

DEL_B79b6:
        ADD r0, r0, 1
        QBNE DEL_B79b6, r0, r1

CLC_B79b7:
        MOV r0, 0
        LSR r4, r27, 9
        AND r4, r4, 1
        QBEQ SET_B79b7, r4, 1

CLR_B79b7:
        CLR r30.t15
        JMP DEL_B79b7

SET_B79b7:
        SET r30.t15
        JMP DEL_B79b7

DEL_B79b7:
        ADD r0, r0, 1
        QBNE DEL_B79b7, r0, r1

CLC_B79b8:
        MOV r0, 0
        LSR r4, r27, 8
        AND r4, r4, 1
        QBEQ SET_B79b8, r4, 1

CLR_B79b8:
        CLR r30.t15
        JMP DEL_B79b8

SET_B79b8:
        SET r30.t15
        JMP DEL_B79b8

BCK_B79b8:
		JMP BCK_B78b8

DEL_B79b8:
        ADD r0, r0, 1
        QBNE DEL_B79b8, r0, r1

CLC_B80b1:
        MOV r0, 0
        LSR r4, r27, 7
        AND r4, r4, 1
        QBEQ SET_B80b1, r4, 1

CLR_B80b1:
        CLR r30.t15
        JMP DEL_B80b1

SET_B80b1:
        SET r30.t15
        JMP DEL_B80b1

DEL_B80b1:
        ADD r0, r0, 1
        QBNE DEL_B80b1, r0, r1

CLC_B80b2:
        MOV r0, 0
        LSR r4, r27, 6
        AND r4, r4, 1
        QBEQ SET_B80b2, r4, 1

CLR_B80b2:
        CLR r30.t15
        JMP DEL_B80b2

SET_B80b2:
        SET r30.t15
        JMP DEL_B80b2

DEL_B80b2:
        ADD r0, r0, 1
        QBNE DEL_B80b2, r0, r1

CLC_B80b3:
        MOV r0, 0
        LSR r4, r27, 5
        AND r4, r4, 1
        QBEQ SET_B80b3, r4, 1

CLR_B80b3:
        CLR r30.t15
        JMP DEL_B80b3

SET_B80b3:
        SET r30.t15
        JMP DEL_B80b3

DEL_B80b3:
        ADD r0, r0, 1
        QBNE DEL_B80b3, r0, r1

CLC_B80b4:
        MOV r0, 0
        LSR r4, r27, 4
        AND r4, r4, 1
        QBEQ SET_B80b4, r4, 1

CLR_B80b4:
        CLR r30.t15
        JMP DEL_B80b4

SET_B80b4:
        SET r30.t15
        JMP DEL_B80b4

DEL_B80b4:
        ADD r0, r0, 1
        QBNE DEL_B80b4, r0, r1

CLC_B80b5:
        MOV r0, 0
        LSR r4, r27, 3
        AND r4, r4, 1
        QBEQ SET_B80b5, r4, 1

CLR_B80b5:
        CLR r30.t15
        JMP DEL_B80b5

SET_B80b5:
        SET r30.t15
        JMP DEL_B80b5

DEL_B80b5:
        ADD r0, r0, 1
        QBNE DEL_B80b5, r0, r1

CLC_B80b6:
        MOV r0, 0
        LSR r4, r27, 2
        AND r4, r4, 1
        QBEQ SET_B80b6, r4, 1

CLR_B80b6:
        CLR r30.t15
        JMP DEL_B80b6

SET_B80b6:
        SET r30.t15
        JMP DEL_B80b6

DEL_B80b6:
        ADD r0, r0, 1
        QBNE DEL_B80b6, r0, r1

CLC_B80b7:
        MOV r0, 0
        LSR r4, r27, 1
        AND r4, r4, 1
        QBEQ SET_B80b7, r4, 1

CLR_B80b7:
        CLR r30.t15
        JMP DEL_B80b7

SET_B80b7:
        SET r30.t15
        JMP DEL_B80b7

DEL_B80b7:
        ADD r0, r0, 1
        QBNE DEL_B80b7, r0, r1

CLC_B80b8:
        MOV r0, 0
        LSR r4, r27, 0
        AND r4, r4, 1
        QBEQ SET_B80b8, r4, 1

CLR_B80b8:
        CLR r30.t15
        JMP DEL_B80b8

SET_B80b8:
        SET r30.t15
        JMP DEL_B80b8

BCK_B80b8:
		JMP BCK_B79b8

DEL_B80b8:
        ADD r0, r0, 1
        QBNE DEL_B80b8, r0, r1

CLC_B81b1:
        MOV r0, 0
        LSR r4, r28, 31
        AND r4, r4, 1
        QBEQ SET_B81b1, r4, 1

CLR_B81b1:
        CLR r30.t15
        JMP DEL_B81b1

SET_B81b1:
        SET r30.t15
        JMP DEL_B81b1

DEL_B81b1:
        ADD r0, r0, 1
        QBNE DEL_B81b1, r0, r1

CLC_B81b2:
        MOV r0, 0
        LSR r4, r28, 30
        AND r4, r4, 1
        QBEQ SET_B81b2, r4, 1

CLR_B81b2:
        CLR r30.t15
        JMP DEL_B81b2

SET_B81b2:
        SET r30.t15
        JMP DEL_B81b2

DEL_B81b2:
        ADD r0, r0, 1
        QBNE DEL_B81b2, r0, r1

CLC_B81b3:
        MOV r0, 0
        LSR r4, r28, 29
        AND r4, r4, 1
        QBEQ SET_B81b3, r4, 1

CLR_B81b3:
        CLR r30.t15
        JMP DEL_B81b3

SET_B81b3:
        SET r30.t15
        JMP DEL_B81b3

DEL_B81b3:
        ADD r0, r0, 1
        QBNE DEL_B81b3, r0, r1

CLC_B81b4:
        MOV r0, 0
        LSR r4, r28, 28
        AND r4, r4, 1
        QBEQ SET_B81b4, r4, 1

CLR_B81b4:
        CLR r30.t15
        JMP DEL_B81b4

SET_B81b4:
        SET r30.t15
        JMP DEL_B81b4

DEL_B81b4:
        ADD r0, r0, 1
        QBNE DEL_B81b4, r0, r1

CLC_B81b5:
        MOV r0, 0
        LSR r4, r28, 27
        AND r4, r4, 1
        QBEQ SET_B81b5, r4, 1

CLR_B81b5:
        CLR r30.t15
        JMP DEL_B81b5

SET_B81b5:
        SET r30.t15
        JMP DEL_B81b5

DEL_B81b5:
        ADD r0, r0, 1
        QBNE DEL_B81b5, r0, r1

CLC_B81b6:
        MOV r0, 0
        LSR r4, r28, 26
        AND r4, r4, 1
        QBEQ SET_B81b6, r4, 1

CLR_B81b6:
        CLR r30.t15
        JMP DEL_B81b6

SET_B81b6:
        SET r30.t15
        JMP DEL_B81b6

DEL_B81b6:
        ADD r0, r0, 1
        QBNE DEL_B81b6, r0, r1

CLC_B81b7:
        MOV r0, 0
        LSR r4, r28, 25
        AND r4, r4, 1
        QBEQ SET_B81b7, r4, 1

CLR_B81b7:
        CLR r30.t15
        JMP DEL_B81b7

SET_B81b7:
        SET r30.t15
        JMP DEL_B81b7

DEL_B81b7:
        ADD r0, r0, 1
        QBNE DEL_B81b7, r0, r1

CLC_B81b8:
        MOV r0, 0
        LSR r4, r28, 24
        AND r4, r4, 1
        QBEQ SET_B81b8, r4, 1

CLR_B81b8:
        CLR r30.t15
        JMP DEL_B81b8

SET_B81b8:
        SET r30.t15
        JMP DEL_B81b8

BCK_B81b8:
		JMP BCK_B80b8

DEL_B81b8:
        ADD r0, r0, 1
        QBNE DEL_B81b8, r0, r1

CLC_B82b1:
        MOV r0, 0
        LSR r4, r28, 23
        AND r4, r4, 1
        QBEQ SET_B82b1, r4, 1

CLR_B82b1:
        CLR r30.t15
        JMP DEL_B82b1

SET_B82b1:
        SET r30.t15
        JMP DEL_B82b1

DEL_B82b1:
        ADD r0, r0, 1
        QBNE DEL_B82b1, r0, r1

CLC_B82b2:
        MOV r0, 0
        LSR r4, r28, 22
        AND r4, r4, 1
        QBEQ SET_B82b2, r4, 1

CLR_B82b2:
        CLR r30.t15
        JMP DEL_B82b2

SET_B82b2:
        SET r30.t15
        JMP DEL_B82b2

DEL_B82b2:
        ADD r0, r0, 1
        QBNE DEL_B82b2, r0, r1

CLC_B82b3:
        MOV r0, 0
        LSR r4, r28, 21
        AND r4, r4, 1
        QBEQ SET_B82b3, r4, 1

CLR_B82b3:
        CLR r30.t15
        JMP DEL_B82b3

SET_B82b3:
        SET r30.t15
        JMP DEL_B82b3

DEL_B82b3:
        ADD r0, r0, 1
        QBNE DEL_B82b3, r0, r1

CLC_B82b4:
        MOV r0, 0
        LSR r4, r28, 20
        AND r4, r4, 1
        QBEQ SET_B82b4, r4, 1

CLR_B82b4:
        CLR r30.t15
        JMP DEL_B82b4

SET_B82b4:
        SET r30.t15
        JMP DEL_B82b4

DEL_B82b4:
        ADD r0, r0, 1
        QBNE DEL_B82b4, r0, r1

CLC_B82b5:
        MOV r0, 0
        LSR r4, r28, 19
        AND r4, r4, 1
        QBEQ SET_B82b5, r4, 1

CLR_B82b5:
        CLR r30.t15
        JMP DEL_B82b5

SET_B82b5:
        SET r30.t15
        JMP DEL_B82b5

DEL_B82b5:
        ADD r0, r0, 1
        QBNE DEL_B82b5, r0, r1

CLC_B82b6:
        MOV r0, 0
        LSR r4, r28, 18
        AND r4, r4, 1
        QBEQ SET_B82b6, r4, 1

CLR_B82b6:
        CLR r30.t15
        JMP DEL_B82b6

SET_B82b6:
        SET r30.t15
        JMP DEL_B82b6

DEL_B82b6:
        ADD r0, r0, 1
        QBNE DEL_B82b6, r0, r1

CLC_B82b7:
        MOV r0, 0
        LSR r4, r28, 17
        AND r4, r4, 1
        QBEQ SET_B82b7, r4, 1

CLR_B82b7:
        CLR r30.t15
        JMP DEL_B82b7

SET_B82b7:
        SET r30.t15
        JMP DEL_B82b7

DEL_B82b7:
        ADD r0, r0, 1
        QBNE DEL_B82b7, r0, r1

CLC_B82b8:
        MOV r0, 0
        LSR r4, r28, 16
        AND r4, r4, 1
        QBEQ SET_B82b8, r4, 1

CLR_B82b8:
        CLR r30.t15
        JMP DEL_B82b8

SET_B82b8:
        SET r30.t15
        JMP DEL_B82b8

BCK_B82b8:
		JMP BCK_B81b8

DEL_B82b8:
        ADD r0, r0, 1
        QBNE DEL_B82b8, r0, r1

CLC_B83b1:
        MOV r0, 0
        LSR r4, r28, 15
        AND r4, r4, 1
        QBEQ SET_B83b1, r4, 1

CLR_B83b1:
        CLR r30.t15
        JMP DEL_B83b1

SET_B83b1:
        SET r30.t15
        JMP DEL_B83b1

DEL_B83b1:
        ADD r0, r0, 1
        QBNE DEL_B83b1, r0, r1

CLC_B83b2:
        MOV r0, 0
        LSR r4, r28, 14
        AND r4, r4, 1
        QBEQ SET_B83b2, r4, 1

CLR_B83b2:
        CLR r30.t15
        JMP DEL_B83b2

SET_B83b2:
        SET r30.t15
        JMP DEL_B83b2

DEL_B83b2:
        ADD r0, r0, 1
        QBNE DEL_B83b2, r0, r1

CLC_B83b3:
        MOV r0, 0
        LSR r4, r28, 13
        AND r4, r4, 1
        QBEQ SET_B83b3, r4, 1

CLR_B83b3:
        CLR r30.t15
        JMP DEL_B83b3

SET_B83b3:
        SET r30.t15
        JMP DEL_B83b3

DEL_B83b3:
        ADD r0, r0, 1
        QBNE DEL_B83b3, r0, r1

CLC_B83b4:
        MOV r0, 0
        LSR r4, r28, 12
        AND r4, r4, 1
        QBEQ SET_B83b4, r4, 1

CLR_B83b4:
        CLR r30.t15
        JMP DEL_B83b4

SET_B83b4:
        SET r30.t15
        JMP DEL_B83b4

DEL_B83b4:
        ADD r0, r0, 1
        QBNE DEL_B83b4, r0, r1

CLC_B83b5:
        MOV r0, 0
        LSR r4, r28, 11
        AND r4, r4, 1
        QBEQ SET_B83b5, r4, 1

CLR_B83b5:
        CLR r30.t15
        JMP DEL_B83b5

SET_B83b5:
        SET r30.t15
        JMP DEL_B83b5

DEL_B83b5:
        ADD r0, r0, 1
        QBNE DEL_B83b5, r0, r1

CLC_B83b6:
        MOV r0, 0
        LSR r4, r28, 10
        AND r4, r4, 1
        QBEQ SET_B83b6, r4, 1

CLR_B83b6:
        CLR r30.t15
        JMP DEL_B83b6

SET_B83b6:
        SET r30.t15
        JMP DEL_B83b6

DEL_B83b6:
        ADD r0, r0, 1
        QBNE DEL_B83b6, r0, r1

CLC_B83b7:
        MOV r0, 0
        LSR r4, r28, 9
        AND r4, r4, 1
        QBEQ SET_B83b7, r4, 1

CLR_B83b7:
        CLR r30.t15
        JMP DEL_B83b7

SET_B83b7:
        SET r30.t15
        JMP DEL_B83b7

DEL_B83b7:
        ADD r0, r0, 1
        QBNE DEL_B83b7, r0, r1

CLC_B83b8:
        MOV r0, 0
        LSR r4, r28, 8
        AND r4, r4, 1
        QBEQ SET_B83b8, r4, 1

CLR_B83b8:
        CLR r30.t15
        JMP DEL_B83b8

SET_B83b8:
        SET r30.t15
        JMP DEL_B83b8

BCK_B83b8:
		JMP BCK_B82b8

DEL_B83b8:
        ADD r0, r0, 1
        QBNE DEL_B83b8, r0, r1

CLC_B84b1:
        MOV r0, 0
        LSR r4, r28, 7
        AND r4, r4, 1
        QBEQ SET_B84b1, r4, 1

CLR_B84b1:
        CLR r30.t15
        JMP DEL_B84b1

SET_B84b1:
        SET r30.t15
        JMP DEL_B84b1

DEL_B84b1:
        ADD r0, r0, 1
        QBNE DEL_B84b1, r0, r1

CLC_B84b2:
        MOV r0, 0
        LSR r4, r28, 6
        AND r4, r4, 1
        QBEQ SET_B84b2, r4, 1

CLR_B84b2:
        CLR r30.t15
        JMP DEL_B84b2

SET_B84b2:
        SET r30.t15
        JMP DEL_B84b2

DEL_B84b2:
        ADD r0, r0, 1
        QBNE DEL_B84b2, r0, r1

CLC_B84b3:
        MOV r0, 0
        LSR r4, r28, 5
        AND r4, r4, 1
        QBEQ SET_B84b3, r4, 1

CLR_B84b3:
        CLR r30.t15
        JMP DEL_B84b3

SET_B84b3:
        SET r30.t15
        JMP DEL_B84b3

DEL_B84b3:
        ADD r0, r0, 1
        QBNE DEL_B84b3, r0, r1

CLC_B84b4:
        MOV r0, 0
        LSR r4, r28, 4
        AND r4, r4, 1
        QBEQ SET_B84b4, r4, 1

CLR_B84b4:
        CLR r30.t15
        JMP DEL_B84b4

SET_B84b4:
        SET r30.t15
        JMP DEL_B84b4

DEL_B84b4:
        ADD r0, r0, 1
        QBNE DEL_B84b4, r0, r1

CLC_B84b5:
        MOV r0, 0
        LSR r4, r28, 3
        AND r4, r4, 1
        QBEQ SET_B84b5, r4, 1

CLR_B84b5:
        CLR r30.t15
        JMP DEL_B84b5

SET_B84b5:
        SET r30.t15
        JMP DEL_B84b5

DEL_B84b5:
        ADD r0, r0, 1
        QBNE DEL_B84b5, r0, r1

CLC_B84b6:
        MOV r0, 0
        LSR r4, r28, 2
        AND r4, r4, 1
        QBEQ SET_B84b6, r4, 1

CLR_B84b6:
        CLR r30.t15
        JMP DEL_B84b6

SET_B84b6:
        SET r30.t15
        JMP DEL_B84b6

DEL_B84b6:
        ADD r0, r0, 1
        QBNE DEL_B84b6, r0, r1

CLC_B84b7:
        MOV r0, 0
        LSR r4, r28, 1
        AND r4, r4, 1
        QBEQ SET_B84b7, r4, 1

CLR_B84b7:
        CLR r30.t15
        JMP DEL_B84b7

SET_B84b7:
        SET r30.t15
        JMP DEL_B84b7

DEL_B84b7:
        ADD r0, r0, 1
        QBNE DEL_B84b7, r0, r1

CLC_B84b8:
        MOV r0, 0
        LSR r4, r28, 0
        AND r4, r4, 1
        QBEQ SET_B84b8, r4, 1

CLR_B84b8:
        CLR r30.t15
        JMP DEL_B84b8

SET_B84b8:
        SET r30.t15
        JMP DEL_B84b8

BCK_B84b8:
		JMP BCK_B83b8

DEL_B84b8:
        ADD r0, r0, 1
        QBNE DEL_B84b8, r0, r1

CLC_B85b1:
        MOV r0, 0
        LSR r4, r29, 31
        AND r4, r4, 1
        QBEQ SET_B85b1, r4, 1

CLR_B85b1:
        CLR r30.t15
        JMP DEL_B85b1

SET_B85b1:
        SET r30.t15
        JMP DEL_B85b1

DEL_B85b1:
        ADD r0, r0, 1
        QBNE DEL_B85b1, r0, r1

CLC_B85b2:
        MOV r0, 0
        LSR r4, r29, 30
        AND r4, r4, 1
        QBEQ SET_B85b2, r4, 1

CLR_B85b2:
        CLR r30.t15
        JMP DEL_B85b2

SET_B85b2:
        SET r30.t15
        JMP DEL_B85b2

DEL_B85b2:
        ADD r0, r0, 1
        QBNE DEL_B85b2, r0, r1

CLC_B85b3:
        MOV r0, 0
        LSR r4, r29, 29
        AND r4, r4, 1
        QBEQ SET_B85b3, r4, 1

CLR_B85b3:
        CLR r30.t15
        JMP DEL_B85b3

SET_B85b3:
        SET r30.t15
        JMP DEL_B85b3

DEL_B85b3:
        ADD r0, r0, 1
        QBNE DEL_B85b3, r0, r1

CLC_B85b4:
        MOV r0, 0
        LSR r4, r29, 28
        AND r4, r4, 1
        QBEQ SET_B85b4, r4, 1

CLR_B85b4:
        CLR r30.t15
        JMP DEL_B85b4

SET_B85b4:
        SET r30.t15
        JMP DEL_B85b4

DEL_B85b4:
        ADD r0, r0, 1
        QBNE DEL_B85b4, r0, r1

CLC_B85b5:
        MOV r0, 0
        LSR r4, r29, 27
        AND r4, r4, 1
        QBEQ SET_B85b5, r4, 1

CLR_B85b5:
        CLR r30.t15
        JMP DEL_B85b5

SET_B85b5:
        SET r30.t15
        JMP DEL_B85b5

DEL_B85b5:
        ADD r0, r0, 1
        QBNE DEL_B85b5, r0, r1

CLC_B85b6:
        MOV r0, 0
        LSR r4, r29, 26
        AND r4, r4, 1
        QBEQ SET_B85b6, r4, 1

CLR_B85b6:
        CLR r30.t15
        JMP DEL_B85b6

SET_B85b6:
        SET r30.t15
        JMP DEL_B85b6

DEL_B85b6:
        ADD r0, r0, 1
        QBNE DEL_B85b6, r0, r1

CLC_B85b7:
        MOV r0, 0
        LSR r4, r29, 25
        AND r4, r4, 1
        QBEQ SET_B85b7, r4, 1

CLR_B85b7:
        CLR r30.t15
        JMP DEL_B85b7

SET_B85b7:
        SET r30.t15
        JMP DEL_B85b7

DEL_B85b7:
        ADD r0, r0, 1
        QBNE DEL_B85b7, r0, r1

CLC_B85b8:
        MOV r0, 0
        LSR r4, r29, 24
        AND r4, r4, 1
        QBEQ SET_B85b8, r4, 1

CLR_B85b8:
        CLR r30.t15
        JMP DEL_B85b8

SET_B85b8:
        SET r30.t15
        JMP DEL_B85b8

BCK_B85b8:
		JMP BCK_B84b8

DEL_B85b8:
        ADD r0, r0, 1
        QBNE DEL_B85b8, r0, r1

CLC_B86b1:
        MOV r0, 0
        LSR r4, r29, 23
        AND r4, r4, 1
        QBEQ SET_B86b1, r4, 1

CLR_B86b1:
        CLR r30.t15
        JMP DEL_B86b1

SET_B86b1:
        SET r30.t15
        JMP DEL_B86b1

DEL_B86b1:
        ADD r0, r0, 1
        QBNE DEL_B86b1, r0, r1

CLC_B86b2:
        MOV r0, 0
        LSR r4, r29, 22
        AND r4, r4, 1
        QBEQ SET_B86b2, r4, 1

CLR_B86b2:
        CLR r30.t15
        JMP DEL_B86b2

SET_B86b2:
        SET r30.t15
        JMP DEL_B86b2

DEL_B86b2:
        ADD r0, r0, 1
        QBNE DEL_B86b2, r0, r1

CLC_B86b3:
        MOV r0, 0
        LSR r4, r29, 21
        AND r4, r4, 1
        QBEQ SET_B86b3, r4, 1

CLR_B86b3:
        CLR r30.t15
        JMP DEL_B86b3

SET_B86b3:
        SET r30.t15
        JMP DEL_B86b3

DEL_B86b3:
        ADD r0, r0, 1
        QBNE DEL_B86b3, r0, r1

CLC_B86b4:
        MOV r0, 0
        LSR r4, r29, 20
        AND r4, r4, 1
        QBEQ SET_B86b4, r4, 1

CLR_B86b4:
        CLR r30.t15
        JMP DEL_B86b4

SET_B86b4:
        SET r30.t15
        JMP DEL_B86b4

DEL_B86b4:
        ADD r0, r0, 1
        QBNE DEL_B86b4, r0, r1

CLC_B86b5:
        MOV r0, 0
        LSR r4, r29, 19
        AND r4, r4, 1
        QBEQ SET_B86b5, r4, 1

CLR_B86b5:
        CLR r30.t15
        JMP DEL_B86b5

SET_B86b5:
        SET r30.t15
        JMP DEL_B86b5

DEL_B86b5:
        ADD r0, r0, 1
        QBNE DEL_B86b5, r0, r1

CLC_B86b6:
        MOV r0, 0
        LSR r4, r29, 18
        AND r4, r4, 1
        QBEQ SET_B86b6, r4, 1

CLR_B86b6:
        CLR r30.t15
        JMP DEL_B86b6

SET_B86b6:
        SET r30.t15
        JMP DEL_B86b6

DEL_B86b6:
        ADD r0, r0, 1
        QBNE DEL_B86b6, r0, r1

CLC_B86b7:
        MOV r0, 0
        LSR r4, r29, 17
        AND r4, r4, 1
        QBEQ SET_B86b7, r4, 1

CLR_B86b7:
        CLR r30.t15
        JMP DEL_B86b7

SET_B86b7:
        SET r30.t15
        JMP DEL_B86b7

DEL_B86b7:
        ADD r0, r0, 1
        QBNE DEL_B86b7, r0, r1

CLC_B86b8:
        MOV r0, 0
        LSR r4, r29, 16
        AND r4, r4, 1
        QBEQ SET_B86b8, r4, 1

CLR_B86b8:
        CLR r30.t15
        JMP DEL_B86b8

SET_B86b8:
        SET r30.t15
        JMP DEL_B86b8

BCK_B86b8:
		JMP BCK_B85b8

DEL_B86b8:
        ADD r0, r0, 1
        QBNE DEL_B86b8, r0, r1

CLC_B87b1:
        MOV r0, 0
        LSR r4, r29, 15
        AND r4, r4, 1
        QBEQ SET_B87b1, r4, 1

CLR_B87b1:
        CLR r30.t15
        JMP DEL_B87b1

SET_B87b1:
        SET r30.t15
        JMP DEL_B87b1

DEL_B87b1:
        ADD r0, r0, 1
        QBNE DEL_B87b1, r0, r1

CLC_B87b2:
        MOV r0, 0
        LSR r4, r29, 14
        AND r4, r4, 1
        QBEQ SET_B87b2, r4, 1

CLR_B87b2:
        CLR r30.t15
        JMP DEL_B87b2

SET_B87b2:
        SET r30.t15
        JMP DEL_B87b2

DEL_B87b2:
        ADD r0, r0, 1
        QBNE DEL_B87b2, r0, r1

CLC_B87b3:
        MOV r0, 0
        LSR r4, r29, 13
        AND r4, r4, 1
        QBEQ SET_B87b3, r4, 1

CLR_B87b3:
        CLR r30.t15
        JMP DEL_B87b3

SET_B87b3:
        SET r30.t15
        JMP DEL_B87b3

DEL_B87b3:
        ADD r0, r0, 1
        QBNE DEL_B87b3, r0, r1

CLC_B87b4:
        MOV r0, 0
        LSR r4, r29, 12
        AND r4, r4, 1
        QBEQ SET_B87b4, r4, 1

CLR_B87b4:
        CLR r30.t15
        JMP DEL_B87b4

SET_B87b4:
        SET r30.t15
        JMP DEL_B87b4

DEL_B87b4:
        ADD r0, r0, 1
        QBNE DEL_B87b4, r0, r1

CLC_B87b5:
        MOV r0, 0
        LSR r4, r29, 11
        AND r4, r4, 1
        QBEQ SET_B87b5, r4, 1

CLR_B87b5:
        CLR r30.t15
        JMP DEL_B87b5

SET_B87b5:
        SET r30.t15
        JMP DEL_B87b5

DEL_B87b5:
        ADD r0, r0, 1
        QBNE DEL_B87b5, r0, r1

CLC_B87b6:
        MOV r0, 0
        LSR r4, r29, 10
        AND r4, r4, 1
        QBEQ SET_B87b6, r4, 1

CLR_B87b6:
        CLR r30.t15
        JMP DEL_B87b6

SET_B87b6:
        SET r30.t15
        JMP DEL_B87b6

DEL_B87b6:
        ADD r0, r0, 1
        QBNE DEL_B87b6, r0, r1

CLC_B87b7:
        MOV r0, 0
        LSR r4, r29, 9
        AND r4, r4, 1
        QBEQ SET_B87b7, r4, 1

CLR_B87b7:
        CLR r30.t15
        JMP DEL_B87b7

SET_B87b7:
        SET r30.t15
        JMP DEL_B87b7

DEL_B87b7:
        ADD r0, r0, 1
        QBNE DEL_B87b7, r0, r1

CLC_B87b8:
        MOV r0, 0
        LSR r4, r29, 8
        AND r4, r4, 1
        QBEQ SET_B87b8, r4, 1

CLR_B87b8:
        CLR r30.t15
        JMP DEL_B87b8

SET_B87b8:
        SET r30.t15
        JMP DEL_B87b8

BCK_B87b8:
		JMP BCK_B86b8

DEL_B87b8:
        ADD r0, r0, 1
        QBNE DEL_B87b8, r0, r1

CLC_B88b1:
        MOV r0, 0
        LSR r4, r29, 7
        AND r4, r4, 1
        QBEQ SET_B88b1, r4, 1

CLR_B88b1:
        CLR r30.t15
        JMP DEL_B88b1

SET_B88b1:
        SET r30.t15
        JMP DEL_B88b1

DEL_B88b1:
        ADD r0, r0, 1
        QBNE DEL_B88b1, r0, r1

CLC_B88b2:
        MOV r0, 0
        LSR r4, r29, 6
        AND r4, r4, 1
        QBEQ SET_B88b2, r4, 1

CLR_B88b2:
        CLR r30.t15
        JMP DEL_B88b2

SET_B88b2:
        SET r30.t15
        JMP DEL_B88b2

DEL_B88b2:
        ADD r0, r0, 1
        QBNE DEL_B88b2, r0, r1

CLC_B88b3:
        MOV r0, 0
        LSR r4, r29, 5
        AND r4, r4, 1
        QBEQ SET_B88b3, r4, 1

CLR_B88b3:
        CLR r30.t15
        JMP DEL_B88b3

SET_B88b3:
        SET r30.t15
        JMP DEL_B88b3

DEL_B88b3:
        ADD r0, r0, 1
        QBNE DEL_B88b3, r0, r1

CLC_B88b4:
        MOV r0, 0
        LSR r4, r29, 4
        AND r4, r4, 1
        QBEQ SET_B88b4, r4, 1

CLR_B88b4:
        CLR r30.t15
        JMP DEL_B88b4

SET_B88b4:
        SET r30.t15
        JMP DEL_B88b4

DEL_B88b4:
        ADD r0, r0, 1
        QBNE DEL_B88b4, r0, r1

CLC_B88b5:
        MOV r0, 0
        LSR r4, r29, 3
        AND r4, r4, 1
        QBEQ SET_B88b5, r4, 1

CLR_B88b5:
        CLR r30.t15
        JMP DEL_B88b5

SET_B88b5:
        SET r30.t15
        JMP DEL_B88b5

DEL_B88b5:
        ADD r0, r0, 1
        QBNE DEL_B88b5, r0, r1

CLC_B88b6:
        MOV r0, 0
        LSR r4, r29, 2
        AND r4, r4, 1
        QBEQ SET_B88b6, r4, 1

CLR_B88b6:
        CLR r30.t15
        JMP DEL_B88b6

SET_B88b6:
        SET r30.t15
        JMP DEL_B88b6

DEL_B88b6:
        ADD r0, r0, 1
        QBNE DEL_B88b6, r0, r1

CLC_B88b7:
        MOV r0, 0
        LSR r4, r29, 1
        AND r4, r4, 1
        QBEQ SET_B88b7, r4, 1

CLR_B88b7:
        CLR r30.t15
        JMP DEL_B88b7

SET_B88b7:
        SET r30.t15
        JMP DEL_B88b7

DEL_B88b7:
        ADD r0, r0, 1
        QBNE DEL_B88b7, r0, r1

CLC_B88b8:
        MOV r0, 0
        LSR r4, r29, 0
        AND r4, r4, 1
        QBEQ SET_B88b8, r4, 1

CLR_B88b8:
        CLR r30.t15
        JMP DEL_B88b8

SET_B88b8:
        SET r30.t15
        JMP DEL_B88b8

DEL_B88b8:
        ADD r0, r0, 1
        QBNE DEL_B88b8, r0, r1

JMP BCK_B87b8

STOP:
	SET r30.t15
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT
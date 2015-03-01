.origin 0
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

	// make C31 (CONST_DDR) point to DDR base address
 	MOV r0, 0x100000
 	MOV r1, PRU1CTPPR_1
 	SBBO r0, r1, 0, 4

    MOV r0, 0
    MOV r1, 100000000
    MOV r2, 0
    MOV r3, 49

BEGIN_TEST:
    ADD r0, r0, 1

DEL_HIGH:
    ADD r2, r2, 1
    QBNE DEL_HIGH, r2, r3

    MOV r2, 0
   // SBCO r9, CONST_DDR, 12, 4
//    XIN 88, r5, 4

DEL_LOW:
    ADD r2, r2, 1
    QBNE DEL_LOW, r2, r3

    MOV r2, 0
    QBNE BEGIN_TEST, r0, r1

END_TEST:
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16

    HALT



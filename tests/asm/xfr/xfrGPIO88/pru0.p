.origin 0
.entrypoint INIT
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    // make C31 (CONST_DDR) point to DDR base address
 	MOV r0, 0x100000
 	MOV r1, PRU0CTPPR_1
 	SBBO r0, r1, 0, 4

    MOV r0, 0
    MOV r1, 100000000
    MOV r3, 0
    MOV r4, 48
    MOV r5, 49

 // LBCO size 88 results in required 64 cycle delay.

BEGIN_TEST:
    ADD r0, r0, 1

    SET r30.t15
    MOV r3, 0
DEL_HIGH:
    ADD r3, r3, 1
    QBNE DEL_HIGH, r3, r4

    MOV r3, 0
    SBCO r8, CONST_DDR, 4, 4
//    XOUT 88, r6, 4

    CLR r30.t15
DEL_LOW:
    ADD r3, r3, 1
    QBNE DEL_LOW, r3, r5

    QBNE BEGIN_TEST, r0, r1

END_TEST:

    // Send notification to Host for program completion
    MOV       r31.b0, PRU0_ARM_INTERRUPT+16

    // Halt the processor
    HALT

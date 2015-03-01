.origin 0
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    // make CONST_DDR (C31) point to DDR base address
    MOV r0, 0x100000
    MOV r1, PRU0CTPPR_1
    SBBO r0, r1, 0, 4
    
    MOV r1, 0xdcba
    MOV r2, 0b10101010101010101010101010101010
BEGIN_TEST:
    XIN 10, r5, 4

    QBNE END_LOOP, r5, r2

    SBCO r1, CONST_DDR, 0, 4

END_LOOP:
    MOV       r31.b0, PRU0_ARM_INTERRUPT+16

    HALT



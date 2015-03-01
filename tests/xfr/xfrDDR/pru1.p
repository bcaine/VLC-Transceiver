.origin 0
.entrypoint INIT
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    // make CONST_DDR (C31) point to DDR base address
   // MOV r0, 0x100000
   // MOV r1, PRU1CTPPR_1
   // SBBO r0, r1, 0, 4


    MOV r5, 0b10101010101010101010101010101010

BEGIN_TEST:
    XOUT 10, r5, 4

    // Send notification to Host for program completion
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16

    // Halt the processor
    HALT

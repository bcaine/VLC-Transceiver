.origin 0
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

BEGIN_TEST:
    XIN 10, r5, 4

END_TEST:
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16

    HALT



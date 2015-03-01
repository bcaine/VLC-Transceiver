.origin 0
.entrypoint INIT
#include "xfr.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

BEGIN_TEST:

    SET r30.t15
    XOUT 10, r5, 88
    CLR r30.t15

END_TEST:

    // Send notification to Host for program completion
    MOV       r31.b0, PRU0_ARM_INTERRUPT+16

    // Halt the processor
    HALT

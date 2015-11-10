.origin 0
.entrypoint BEGIN_TEST

#include "prutest.hp"
LDI r5, 255
BEGIN_TEST:
    XOUT 10, r5, 4
    // Send notification to Host for program completion
    MOV       r31.b0, PRU0_ARM_INTERRUPT+16

    // Halt the processor
    HALT

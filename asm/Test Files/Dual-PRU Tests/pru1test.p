.origin 0
#include "prutest.hp"
//LDI r3, 10000
BEGIN_TEST:
    XIN 10, r5, 4
    // Send notification to Host for program completion
    QBNE BEGIN_TEST, r5, 253
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16

    // Halt the processor
    HALT



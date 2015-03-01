.origin 0
.entrypoint INIT
#include "../../..interface/asm.hp"
#define WRITE_CODE 0b10101010101010101010101010101010

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    MOV r5, WRITE_CODE // load code to transfer to PRU0

BEGIN_TEST:
    XOUT 10, r5, 4 // initiate 4-byte transfer to PRU0

    // Send notification to Host for program completion
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16
    // Halt the processor
    HALT

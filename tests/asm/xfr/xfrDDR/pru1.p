// This test should use PRU1 to perform a 4-byte data transfer to PRU0 via the Scratch Pad.
// PRU0 will receive this data and compare it to its expected value. If the received
// matches the expected, PRU0 will write a success code to main RAM. If not, it will
// write a failure code.

#define WRITE_CODE 0b10101010101010101010101010101010

.origin 0
.entrypoint INIT
#include "../../../../include/asm.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    MOV r5, WRITE_CODE // load code to transfer to PRU0

BEGIN_TEST:

    XOUT 10, r5, 4 // initiate 4-byte transfer to PRU0

END_TEST:

    MOV       r31.b0, PRU1_ARM_INTERRUPT+16 // send program complete interrupt
  
    HALT // halt the microcontroller

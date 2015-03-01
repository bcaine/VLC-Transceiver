// This test serves to test the timing of the XFR instructions. PRU0 will set its GPO
// line high for 100 cycles, then try to send 4 bytes of data to PRU1 via the scratch pad
// (XOUT). Immediately upon completion of this XFR, PRU0 will set its GPIO line low.
// This should allow examination with the scope to determine if XFR is taking more than
// the specified 1 cycle per data transfer.	

.origin 0
#include "../../../interface/asm.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    MOV r0, 0 // loop iteration counter
    MOV r1, 1000000 // iterations to perform
    MOV r2, 0 // delay counter
    MOV r3, 49 // delay loop length

BEGIN_TEST:
    ADD r0, r0, 1 // increment iteration counter

DEL_HIGH: // delay s.t. there are 200 cycles between XINs
    ADD r2, r2, 1
    QBNE DEL_HIGH, r2, r3

    MOV r2, 0 // reset delay counter
    XIN 10, r5, 4 // receive XFR from PRU0

DEL_LOW: // delay s.t. there are 200 cycles between XINs
    ADD r2, r2, 1
    QBNE DEL_LOW, r2, r3

    MOV r2, 0 // reset delay counter

    // if there are more iterations to perform
    QBNE BEGIN_TEST, r0, r1 // jump to start of loop

    // else, end test
END_TEST:
    
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16 // send program completion interrupt

    HALT // halt microcontroller



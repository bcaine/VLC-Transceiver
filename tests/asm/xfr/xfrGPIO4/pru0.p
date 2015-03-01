// This test serves to test the timing of the XFR instructions. PRU0 will set its GPO
// line high for 100 cycles, then try to send 4 bytes of data to PRU1 via the scratch pad
// (XOUT). Immediately upon completion of this XFR, PRU0 will set its GPIO line low. 
// This should allow examination with the scope to determine if XFR is taking more than
// the specified 1 cycle per data transfer.

.origin 0
.entrypoint INIT
#include "../../../interface/asm.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    MOV r0, 0 // counter for loop iterations
    MOV r1, 1000000 // number of iterations to loop
    MOV r3, 0 // delay counter
    MOV r4, 48 // number of delay loops after setting high
    MOV r5, 49 // number of delay loops after setting low

BEGIN_TEST:
    ADD r0, r0, 1 // increment loop counter

    SET r30.t15 // set GPO high
    MOV r3, 0 // reset delay counter

DEL_HIGH: // delay s.t. GPO high for 100 cycles
    ADD r3, r3, 1
    QBNE DEL_HIGH, r3, r4

    MOV r3, 0 // reset delay counter
    XOUT 10, r5, 4 // transfer r5 to PRU1 via scratchpad

    CLR r30.t15 // set GPO low

DEL_LOW: // delay s.t. GPO low for 100 cycles
    ADD r3, r3, 1
    QBNE DEL_LOW, r3, r5

    // if more loop iterations to perform
    QBNE BEGIN_TEST, r0, r1 // jump back to start of loop

    // else, terminate test
END_TEST:

    MOV       r31.b0, PRU0_ARM_INTERRUPT+16 // send program completion interrupt

    HALT // halt the microcontroller

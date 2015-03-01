// This test should use PRU1 to perform a 4-byte data transfer to PRU0 via the Scratch Pad.
// PRU0 will receive this data and compare it to its expected value. If the received 
// matches the expected, PRU0 will write a success code to main RAM. If not, it will 
// write a failure code. 

#define READ_CODE 0b10101010101010101010101010101010
#define PASS_CODE 0xaaaa
#define FAIL_CODE 0xffff

.origin 0
#include "../../../../include/asm.hp"

INIT:

    // Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

    // make CONST_DDR (C31) point to DDR base address
    MOV r0, 0x100000
    MOV r1, PRU0CTPPR_1
    SBBO r0, r1, 0, 4
    
    MOV r2, READ_CODE // load expected value for comparison


BEGIN_TEST:

    XIN 10, r5, 4 // pull 4 bytes from PRU1 transfer

    // if received != expected
    QBNE TEST_FAIL, r5, r2 // jump to failure

    // else, test passed
TEST_PASS: 

    MOV r1, PASS_CODE // load success code for memory store
    JMP END_TEST // jump over the failure block

TEST_FAIL:

    MOV r1, FAIL_CODE // load failure code for memory store

END_TEST:
    
    SBCO r1, CONST_DDR, 0, 4 // write the result of the test to RAM

    MOV  r31.b0, PRU0_ARM_INTERRUPT+16 // send program completion interrupt

    HALT // halt the microcontroller



// This test should use PRU1 to store a 4-byte code (see pru1.p WRITE_CODE) into local
// PRU RAM. PRU0 should then read in this 4-byte code, and compare it to the expected
// value (see pru0.p READ_CODE). If it matches, PRU0 will write a success code
// (see pru0.p PASS_CODE)  to main RAM. If not, PRU0 will then write a test failed 
// code (see pru0.p FAIL_CODE)  to main RAM. The result of PRU0's memory store
// will be examined and determine final test pass/fail.

#define WRITE_CODE 0xdcba
.origin 0
.entrypoint INIT

#include "../../../../../include/asm.hp"

INIT:

    // Enable OCP master port
    LBCO r0, C4, 4, 4
    CLR r0, r0, 4
    SBCO r0, C4, 4, 4

    // make CONST_PRUSHAREDRAM (C28) point to PRU shared RAM base address
    MOV r0, 0x00000120
    MOV r1, PRU0CTPPR_0
    SBBO r0, r1, 0, 4 

WRITE_TEST:
    MOV r5, WRITE_CODE // load store code for writing to PRU RAM
    SBCO r5, CONST_PRUSHAREDRAM, 0, 4 // write 4 byte code to PRU RAM

    MOV r31.b0, PRU1_ARM_INTERRUPT+16

    HALT


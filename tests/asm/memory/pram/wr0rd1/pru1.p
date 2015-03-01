// This test should use PRU0 to store a 4-byte code (see pru0.p WRITE_CODE) into local
// PRU RAM. PRU1 will delay (see the value of r2) enough to allow this memory access 
// to happen, but should then read in this 4-byte code, and compare it to the expected
// value (see pru1.p READ_CODE). If it matches, PRU1 will write a success code
// (see pru1.p PASS_CODE)  to main RAM. If not, PRU1 will then write a test failed
// code (see pru1.p FAIL_CODE)  to main RAM. The result of PRU1's memory store
// will be examined and determine final test pass/fail.


#define READ_CODE 0xdcba
#define PASS_CODE 0xaaaa
#define FAIL_CODE 0xffff
.origin 0
.entrypoint INIT

#include "../../../../interface/asm.hp"

INIT:
    
    // Enable OCP master port
    LBCO r0, C4, 4, 4
    CLR r0, r0, 4
    SBCO r0, C4, 4, 4

    // make CONST_PRUSHAREDRAM (C28) point to PRU shared RAM base address
    MOV r0, 0x120
    MOV r1, PRU1CTPPR_0
    SBBO r0, r1, 0, 4 
   
    // make CONST_DDR (C31) point to DDR memory base address
    MOV r0, 0x100000
    MOV r1, PRU1CTPPR_1
    SBBO r0, r1, 0, 4

    MOV r1, 0 // loop counter
    MOV r2, 100000 // number of loops

DELAY:
    ADD r1, r1, 1
    QBNE DELAY, r1, r2

READ_TEST:
    MOV r4, READ_CODE // load expected value for comparison
    LBCO r5, CONST_PRUSHAREDRAM, 0, 4 // read 4 byte code from PRAM
    QBEQ TEST_PASSED, r5, r4 // if equal, test passed

TEST_FAILED: // if not equal, test failed
    MOV r6, FAIL_CODE // load failure code for store instr
    SBCO r6, CONST_DDR, 0, 4 // write failure code to RAM
    JMP END_TEST

TEST_PASSED:
    MOV r6, PASS_CODE // load pass code for store instr
    SBCO r6, CONST_DDR, 0, 4 // write success code to RAM

END_TEST:
    MOV r31.b0, PRU1_ARM_INTERRUPT+16
    HALT


#define READ_CODE 0xdcba
#define PASS_CODE 0xaaaa
#define FAIL_CODE 0xffff
.origin 0
.entrypoint INIT

#include "pramtest.hp"

INIT:
    
    // Enable OCP master port
    LBCO r0, CONST_PRUCFG, 4, 4
    CLR r0, r0, 4
    SBCO r0, CONST_PRUCFG, 4, 4

    // make CONST_PRUSHAREDRAM (C28) point to PRU shared RAM base address
    MOV r0, 0x00000120
    MOV r1, CTPPR_0
    SBBO r0, r1, 0, 4 
   
    // make CONST_DDR (C31) point to DDR memory base address
    MOV r0, 0x00100000
    MOV r1, CTPPR_1
    SBBO r0, r1, 0, 4

    MOV r1, 0
    MOV r2, 100000

DELAY:

    ADD r1, r1, 1
    QBNE DELAY, r1, r2

READ_TEST:
    MOV r4, READ_CODE
    LBCO r5, CONST_PRUSHAREDRAM, 0, 4 // read 4 byte code from PRAM
    QBEQ TEST_PASSED, r5, r4

TEST_FAILED:

    MOV r6, FAIL_CODE
    SBCO r6, CONST_DDR, 0, 4 // write failure code to DDR
    JMP END_TEST

TEST_PASSED:
    MOV r6, PASS_CODE
    SBCO r6, CONST_DDR, 0, 4 // write success code to DDR

END_TEST:
    MOV r31.b0, PRU0_ARM_INTERRUPT+16

    HALT


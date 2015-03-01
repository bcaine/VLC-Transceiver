#define WRITE_CODE 0xdcba
.origin 0
.entrypoint INIT

#include "pramtest.hp"

INIT:

    // Enable OCP master port
    LBCO r0, C4, 4, 4
    CLR r0, r0, 4
    SBCO r0, C4, 4, 4

    // make CONST_PRUSHAREDRAM (C28) point to PRU shared RAM base address
    MOV r0, 0x120
    MOV r1, PRU1CTPPR_0
    SBBO r0, r1, 0, 4 

WRITE_TEST:
    MOV r5, WRITE_CODE
    SBCO r5, CONST_PRUSHAREDRAM, 0, 4 // write 4 byte code to PRAM

    MOV r31.b0, PRU1_ARM_INTERRUPT+16

    HALT


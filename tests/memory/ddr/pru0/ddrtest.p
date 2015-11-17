#define WRITE_CODE 0xdcba
#define READ_CODE 0xabcd
.origin 0
.entrypoint READ_TEST

#include "ddrtest.hp"

READ_TEST:

    // Enable OCP master port
    LBCO      r0, CONST_PRUCFG, 4, 4
    CLR     r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, CONST_PRUCFG, 4, 4

    // make CONST_DDR (C31) point to DDR base address
    MOV r0, 0x00100000
    MOV r1, CTPPR_1
    SBBO r0, r1, 0, 4


    LDI r5, READ_CODE
    
    LBCO r4, CONST_DDR, 0, 4 // load 4 byte code from DDR
    QBNE READ_TEST, r4, r5

WRITE_TEST:
    
    MOV r4, WRITE_CODE
    SBCO r4, CONST_DDR, 0, 4 // write 4 byte code to DDR

    MOV r31.b0, PRU0_ARM_INTERRUPT+16

    HALT


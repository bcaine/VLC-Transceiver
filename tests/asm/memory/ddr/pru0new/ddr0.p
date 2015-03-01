// This test, to be run on PRU 0, will attempt to read in a code from the 
// first 4 bytes of RAM. It will continually read this value until it sees 
// the value it expects (READ_CODE). It will then attempt to write its own 
// code (WRITE_CODE) back into these same 4 bytes of RAM, to be verified by ddr0.c

#define READ_ADDRESS 0x90000000
#define WRITE_CODE 0xdcba
#define READ_CODE 0xabcd
.origin 0
.entrypoint READ_TEST

#include "../../../../interface/ddrtest.hp"

READ_TEST:

    // Enable OCP master port
    LBCO      r0, CONST_PRUCFG, 4, 4
    CLR     r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, CONST_PRUCFG, 4, 4

    // make CONST_DDR (C31) point to DDR base address
   // MOV r0, 0x00100000
   // MOV r1, CTPPR_1
   // SBBO r0, r1, 0, 4

    MOV r7, READ_ADDRESS
    MOV r5, READ_CODE // load the expected value for comparison
    
    LBBO r4, r7, 0, 4 // load 4 byte code from DDR
    QBNE READ_TEST, r4, r5 // if not the expected val, re-load

WRITE_TEST:
    
    MOV r4, WRITE_CODE // load the write code value
    SBBO r4, r7, 0, 4 // write 4 byte code to DDR

    MOV r31.b0, PRU0_ARM_INTERRUPT+16

    HALT


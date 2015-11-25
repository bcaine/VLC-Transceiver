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
    
    LBCO r5, CONST_DDR, 8, 88 // load 88 bytes from DDR
    //QBNE READ_TEST, r4, r5
WRITE_TEST:
    MOV r5, 0b10101010101010101010101010101010
    MOV r6, 0b10101010101010101010101010101010
    MOV r7, 0b10101010101010101010101010101010
    MOV r8, 0b10101010101010101010101010101010
    MOV r9, 0b10101010101010101010101010101010
    MOV r10, 0b10101010101010101010101010101010
    MOV r11, 0b10101010101010101010101010101010
    MOV r12, 0b10101010101010101010101010101010
    MOV r13, 0b10101010101010101010101010101010
    MOV r14, 0b10101010101010101010101010101010
    MOV r15, 0b10101010101010101010101010101010
    MOV r16, 0b10101010101010101010101010101010
    MOV r17, 0b10101010101010101010101010101010
    MOV r18, 0b10101010101010101010101010101010
    MOV r19, 0b10101010101010101010101010101010
    MOV r20, 0b10101010101010101010101010101010
    MOV r21, 0b10101010101010101010101010101010
    MOV r22, 0b10101010101010101010101010101010
    MOV r23, 0b10101010101010101010101010101010
    MOV r24, 0b10101010101010101010101010101010
    MOV r25, 0b10101010101010101010101010101010
    MOV r26, 0b10101010101010101010101010101010
    MOV r27, 0b10101010101010101010101010101010
    
    JMP STOP

WRITEBACK_TEST:
    
    ADD r5.b0, r5.b0, 1
    ADD r5.b1, r5.b1, 1
    ADD r5.b2, r5.b2, 1
    ADD r5.b3, r5.b3, 1

    ADD r6.b0, r6.b0, 2
    ADD r6.b1, r6.b1, 2
    ADD r6.b2, r6.b2, 2
    ADD r6.b3, r6.b3, 2

    ADD r7.b0, r7.b0, 3
    ADD r7.b1, r7.b1, 3
    ADD r7.b2, r7.b2, 3
    ADD r7.b3, r7.b3, 3

    ADD r8.b0, r8.b0, 4
    ADD r8.b1, r8.b1, 4
    ADD r8.b2, r8.b2, 4
    ADD r8.b3, r8.b3, 4

    ADD r9.b0, r5.b0, 1
    ADD r9.b1, r5.b1, 1
    ADD r9.b2, r5.b2, 1
    ADD r9.b3, r5.b3, 1

    ADD r10.b0, r6.b0, 2
    ADD r10.b1, r6.b1, 2
    ADD r10.b2, r6.b2, 2
    ADD r10.b3, r6.b3, 2

    ADD r11.b0, r7.b0, 3
    ADD r11.b1, r7.b1, 3
    ADD r11.b2, r7.b2, 3
    ADD r11.b3, r7.b3, 3

    ADD r12.b0, r8.b0, 4
    ADD r12.b1, r8.b1, 4
    ADD r12.b2, r8.b2, 4
    ADD r12.b3, r8.b3, 4

    ADD r13.b0, r13.b0, 1
    ADD r13.b1, r13.b1, 1
    ADD r13.b2, r13.b2, 1
    ADD r13.b3, r13.b3, 1

    ADD r14.b0, r14.b0, 2
    ADD r14.b1, r14.b1, 2
    ADD r14.b2, r14.b2, 2
    ADD r14.b3, r14.b3, 2

    ADD r15.b0, r15.b0, 3
    ADD r15.b1, r15.b1, 3
    ADD r15.b2, r15.b2, 3
    ADD r15.b3, r15.b3, 3

    ADD r16.b0, r16.b0, 4
    ADD r16.b1, r16.b1, 4
    ADD r16.b2, r16.b2, 4
    ADD r16.b3, r16.b3, 4

    ADD r17.b0, r17.b0, 1
    ADD r17.b1, r17.b1, 1
    ADD r17.b2, r17.b2, 1
    ADD r17.b3, r17.b3, 1

    ADD r18.b0, r18.b0, 2
    ADD r18.b1, r18.b1, 2
    ADD r18.b2, r18.b2, 2
    ADD r18.b3, r18.b3, 2

    ADD r19.b0, r19.b0, 3
    ADD r19.b1, r19.b1, 3
    ADD r19.b2, r19.b2, 3
    ADD r19.b3, r19.b3, 3

    ADD r20.b0, r20.b0, 4
    ADD r20.b1, r20.b1, 4
    ADD r20.b2, r20.b2, 4
    ADD r20.b3, r20.b3, 4

    ADD r21.b0, r21.b0, 1
    ADD r21.b1, r21.b1, 1
    ADD r21.b2, r21.b2, 1
    ADD r21.b3, r21.b3, 1

    ADD r22.b0, r22.b0, 2
    ADD r22.b1, r22.b1, 2
    ADD r22.b2, r22.b2, 2
    ADD r22.b3, r22.b3, 2

    ADD r23.b0, r23.b0, 3
    ADD r23.b1, r23.b1, 3
    ADD r23.b2, r23.b2, 3
    ADD r23.b3, r23.b3, 3

    ADD r24.b0, r24.b0, 4
    ADD r24.b1, r24.b1, 4
    ADD r24.b2, r24.b2, 4
    ADD r24.b3, r24.b3, 4

    ADD r25.b0, r25.b0, 1
    ADD r25.b1, r25.b1, 1
    ADD r25.b2, r25.b2, 1
    ADD r25.b3, r25.b3, 1

    ADD r26.b0, r26.b0, 2
    ADD r26.b1, r26.b1, 2
    ADD r26.b2, r26.b2, 2
    ADD r26.b3, r26.b3, 2

    ADD r27.b0, r27.b0, 3
    ADD r27.b1, r27.b1, 3
    ADD r27.b2, r27.b2, 3
    ADD r27.b3, r27.b3, 3


    SBCO r5, CONST_DDR, 8, 88 // write 4 byte code to DDR

STOP:
    MOV r29, 0

DEL:
    ADD r29, r29, 1
    QBNE DEL, r29, 100
    
    SBCO r5, CONST_DDR, 8, 88

    MOV r29, 0

DEL2:
    ADD r29, r29, 1
    QBNE DEL2, r29, 100

    MOV r31.b0, PRU0_ARM_INTERRUPT+16

    HALT


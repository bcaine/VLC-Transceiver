// This test should generate a 1MHz wave on Pin 11 of header P8 on the
// Beaglebone Black, using the contents of r5. Note that this requires a device
// tree overlay enabling direct PRU control already be in place 
// (see /etc/rc.local for echo command).
//
// Square wave output will be modulated using the entire contents of r5,
// this process will loop according to the value stored in r3.  

.origin 0
.entrypoint INIT
#include "../../../interface/asm.hp"

#define ALL_HIGH 0b11111111111111111111111111111111
#define ALL_LOW  0b00000000000000000000000000000000
#define ALT_1bH  0b10101010101010101010101010101010
#define ALT_1bL	 0b01010101010101010101010101010101
#define ALT_2bH  0b11001100110011001100110011001100
#define ALT_2bL	 0b00110011001100110011001100110011
#define ALT_4bH	 0b11110000111100001111000011110000
#define ALT_4bL	 0b00001111000011110000111100001111

INIT:

	MOV r1.b0, 0 // loop counter --delay
	MOV r1.b1, 97 // delay length --forward
	MOV r1.b2, 91 // delay length --backward

	MOV r2, 0 // loop counter
	MOV r3, 1000 // number of loop repetitions (32-bit modulation per)

	MOV r5, ALT_2bH // data to modulate out
	JMP END_TEST

MAIN_LOOP:

CLC_B1b1:
    MOV r1.b0, 0
    LSR r4, r8, 31
    AND r4, r4, 1
    QBEQ SET_B1b1, r4, 1

CLR_B1b1:
    CLR r30.t15
    JMP DEL_B1b1

SET_B1b1:
    SET r30.t15
    JMP DEL_B1b1

DEL_B1b1:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b1, r1.b0, r1.b1

CLC_B1b2:
    MOV r1.b0, 0
    LSR r4, r8, 30
    AND r4, r4, 1
    QBEQ SET_B1b2, r4, 1

CLR_B1b2:
    CLR r30.t15
    JMP DEL_B1b2

SET_B1b2:
    SET r30.t15
    JMP DEL_B1b2

DEL_B1b2:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b2, r1.b0, r1.b1

CLC_B1b3:
    MOV r1.b0, 0
    LSR r4, r8, 29
    AND r4, r4, 1
    QBEQ SET_B1b3, r4, 1

CLR_B1b3:
    CLR r30.t15
    JMP DEL_B1b3

SET_B1b3:
    SET r30.t15
    JMP DEL_B1b3

DEL_B1b3:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b3, r1.b0, r1.b1

CLC_B1b4:
    MOV r1.b0, 0
    LSR r4, r8, 28
    AND r4, r4, 1
    QBEQ SET_B1b4, r4, 1

CLR_B1b4:
    CLR r30.t15
    JMP DEL_B1b4

SET_B1b4:
    SET r30.t15
    JMP DEL_B1b4

DEL_B1b4:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b4, r1.b0, r1.b1

CLC_B1b5:
    MOV r1.b0, 0
    LSR r4, r8, 27
    AND r4, r4, 1
    QBEQ SET_B1b5, r4, 1

CLR_B1b5:
    CLR r30.t15
    JMP DEL_B1b5

SET_B1b5:
    SET r30.t15
    JMP DEL_B1b5

DEL_B1b5:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b5, r1.b0, r1.b1

CLC_B1b6:
    MOV r1.b0, 0
    LSR r4, r8, 26
    AND r4, r4, 1
    QBEQ SET_B1b6, r4, 1

CLR_B1b6:
    CLR r30.t15
    JMP DEL_B1b6

SET_B1b6:
    SET r30.t15
    JMP DEL_B1b6

DEL_B1b6:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b6, r1.b0, r1.b1

CLC_B1b7:
    MOV r1.b0, 0
    LSR r4, r8, 25
    AND r4, r4, 1
    QBEQ SET_B1b7, r4, 1

CLR_B1b7:
    CLR r30.t15
    JMP DEL_B1b7

SET_B1b7:
    SET r30.t15
    JMP DEL_B1b7

DEL_B1b7:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b7, r1.b0, r1.b1

CLC_B1b8:
    MOV r1.b0, 0
    LSR r4, r8, 24
    AND r4, r4, 1
    QBEQ SET_B1b8, r4, 1

CLR_B1b8:
    CLR r30.t15
    JMP DEL_B1b8

SET_B1b8:
    SET r30.t15
    JMP DEL_B1b8

BCK_B1b8:
    JMP CLC_B1b8

DEL_B1b8:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b8, r1.b0, r1.b1

CLC_B2b1:
    MOV r1.b0, 0
    LSR r4, r8, 23
    AND r4, r4, 1
    QBEQ SET_B2b1, r4, 1

CLR_B2b1:
    CLR r30.t15
    JMP DEL_B2b1

SET_B2b1:
    SET r30.t15
    JMP DEL_B2b1

DEL_B2b1:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b1, r1.b0, r1.b1

CLC_B2b2:
    MOV r1.b0, 0
    LSR r4, r8, 22
    AND r4, r4, 1
    QBEQ SET_B2b2, r4, 1

CLR_B2b2:
    CLR r30.t15
    JMP DEL_B2b2

SET_B2b2:
    SET r30.t15
    JMP DEL_B2b2

DEL_B2b2:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b2, r1.b0, r1.b1

CLC_B2b3:
    MOV r1.b0, 0
    LSR r4, r8, 21
    AND r4, r4, 1
    QBEQ SET_B2b3, r4, 1

CLR_B2b3:
    CLR r30.t15
    JMP DEL_B2b3

SET_B2b3:
    SET r30.t15
    JMP DEL_B2b3

DEL_B2b3:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b3, r1.b0, r1.b1

CLC_B2b4:
    MOV r1.b0, 0
    LSR r4, r8, 20
    AND r4, r4, 1
    QBEQ SET_B2b4, r4, 1

CLR_B2b4:
    CLR r30.t15
    JMP DEL_B2b4

SET_B2b4:
    SET r30.t15
    JMP DEL_B2b4

DEL_B2b4:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b4, r1.b0, r1.b1

CLC_B2b5:
    MOV r1.b0, 0
    LSR r4, r8, 19
    AND r4, r4, 1
    QBEQ SET_B2b5, r4, 1

CLR_B2b5:
    CLR r30.t15
    JMP DEL_B2b5

SET_B2b5:
    SET r30.t15
    JMP DEL_B2b5

DEL_B2b5:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b5, r1.b0, r1.b1

CLC_B2b6:
    MOV r1.b0, 0
    LSR r4, r8, 18
    AND r4, r4, 1
    QBEQ SET_B2b6, r4, 1

CLR_B2b6:
    CLR r30.t15
    JMP DEL_B2b6

SET_B2b6:
    SET r30.t15
    JMP DEL_B2b6

DEL_B2b6:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b6, r1.b0, r1.b1

CLC_B2b7:
    MOV r1.b0, 0
    LSR r4, r8, 17
    AND r4, r4, 1
    QBEQ SET_B2b7, r4, 1

CLR_B2b7:
    CLR r30.t15
    JMP DEL_B2b7

SET_B2b7:
    SET r30.t15
    JMP DEL_B2b7

DEL_B2b7:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b7, r1.b0, r1.b1

CLC_B2b8:
    MOV r1.b0, 0
    LSR r4, r8, 16
    AND r4, r4, 1
    QBEQ SET_B2b8, r4, 1

CLR_B2b8:
    CLR r30.t15
    JMP DEL_B2b8

SET_B2b8:
    SET r30.t15
    JMP DEL_B2b8

BCK_B2b8:
JMP BCK_B1b8

DEL_B2b8:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B2b8, r1.b0, r1.b1

CLC_B3b1:
    MOV r1.b0, 0
    LSR r4, r8, 15
    AND r4, r4, 1
    QBEQ SET_B3b1, r4, 1

CLR_B3b1:
    CLR r30.t15
    JMP DEL_B3b1

SET_B3b1:
    SET r30.t15
    JMP DEL_B3b1

DEL_B3b1:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b1, r1.b0, r1.b1

CLC_B3b2:
    MOV r1.b0, 0
    LSR r4, r8, 14
    AND r4, r4, 1
    QBEQ SET_B3b2, r4, 1

CLR_B3b2:
    CLR r30.t15
    JMP DEL_B3b2

SET_B3b2:
    SET r30.t15
    JMP DEL_B3b2

DEL_B3b2:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b2, r1.b0, r1.b1

CLC_B3b3:
    MOV r1.b0, 0
    LSR r4, r8, 13
    AND r4, r4, 1
    QBEQ SET_B3b3, r4, 1

CLR_B3b3:
    CLR r30.t15
    JMP DEL_B3b3

SET_B3b3:
    SET r30.t15
    JMP DEL_B3b3

DEL_B3b3:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b3, r1.b0, r1.b1

CLC_B3b4:
    MOV r1.b0, 0
    LSR r4, r8, 12
    AND r4, r4, 1
    QBEQ SET_B3b4, r4, 1

CLR_B3b4:
    CLR r30.t15
    JMP DEL_B3b4

SET_B3b4:
    SET r30.t15
    JMP DEL_B3b4

DEL_B3b4:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b4, r1.b0, r1.b1

CLC_B3b5:
    MOV r1.b0, 0
    LSR r4, r8, 11
    AND r4, r4, 1
    QBEQ SET_B3b5, r4, 1

CLR_B3b5:
    CLR r30.t15
    JMP DEL_B3b5

SET_B3b5:
    SET r30.t15
    JMP DEL_B3b5

DEL_B3b5:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b5, r1.b0, r1.b1

CLC_B3b6:
    MOV r1.b0, 0
    LSR r4, r8, 10
    AND r4, r4, 1
    QBEQ SET_B3b6, r4, 1

CLR_B3b6:
    CLR r30.t15
    JMP DEL_B3b6

SET_B3b6:
    SET r30.t15
    JMP DEL_B3b6

DEL_B3b6:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b6, r1.b0, r1.b1

CLC_B3b7:
    MOV r1.b0, 0
    LSR r4, r8, 9
    AND r4, r4, 1
    QBEQ SET_B3b7, r4, 1

CLR_B3b7:
    CLR r30.t15
    JMP DEL_B3b7

SET_B3b7:
    SET r30.t15
    JMP DEL_B3b7

DEL_B3b7:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b7, r1.b0, r1.b1

CLC_B3b8:
    MOV r1.b0, 0
    LSR r4, r8, 8
    AND r4, r4, 1
    QBEQ SET_B3b8, r4, 1

CLR_B3b8:
    CLR r30.t15
    JMP DEL_B3b8

SET_B3b8:
    SET r30.t15
    JMP DEL_B3b8

BCK_B3b8:
	JMP BCK_B2b8

DEL_B3b8:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B3b8, r1.b0, r1.b1

CLC_B4b1:
    MOV r1.b0, 0
    LSR r4, r8, 7
    AND r4, r4, 1
    QBEQ SET_B4b1, r4, 1

CLR_B4b1:
    CLR r30.t15
    JMP DEL_B4b1

SET_B4b1:
    SET r30.t15
    JMP DEL_B4b1

DEL_B4b1:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b1, r1.b0, r1.b1

CLC_B4b2:
    MOV r1.b0, 0
    LSR r4, r8, 6
    AND r4, r4, 1
    QBEQ SET_B4b2, r4, 1

CLR_B4b2:
    CLR r30.t15
    JMP DEL_B4b2

SET_B4b2:
    SET r30.t15
    JMP DEL_B4b2

DEL_B4b2:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b2, r1.b0, r1.b1

CLC_B4b3:
    MOV r1.b0, 0
    LSR r4, r8, 5
    AND r4, r4, 1
    QBEQ SET_B4b3, r4, 1

CLR_B4b3:
    CLR r30.t15
    JMP DEL_B4b3

SET_B4b3:
    SET r30.t15
    JMP DEL_B4b3

DEL_B4b3:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b3, r1.b0, r1.b1

CLC_B4b4:
    MOV r1.b0, 0
    LSR r4, r8, 4
    AND r4, r4, 1
    QBEQ SET_B4b4, r4, 1

CLR_B4b4:
    CLR r30.t15
    JMP DEL_B4b4

SET_B4b4:
    SET r30.t15
    JMP DEL_B4b4

DEL_B4b4:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b4, r1.b0, r1.b1

CLC_B4b5:
    MOV r1.b0, 0
    LSR r4, r8, 3
    AND r4, r4, 1
    QBEQ SET_B4b5, r4, 1

CLR_B4b5:
    CLR r30.t15
    JMP DEL_B4b5

SET_B4b5:
    SET r30.t15
    JMP DEL_B4b5

DEL_B4b5:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b5, r1.b0, r1.b1

CLC_B4b6:
    MOV r1.b0, 0
    LSR r4, r8, 2
    AND r4, r4, 1
    QBEQ SET_B4b6, r4, 1

CLR_B4b6:
    CLR r30.t15
    JMP DEL_B4b6

SET_B4b6:
    SET r30.t15
    JMP DEL_B4b6

DEL_B4b6:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b6, r1.b0, r1.b1

CLC_B4b7:
    MOV r1.b0, 0
    LSR r4, r8, 1
    AND r4, r4, 1
    QBEQ SET_B4b7, r4, 1

CLR_B4b7:
    CLR r30.t15
    JMP DEL_B4b7

SET_B4b7:
    SET r30.t15
    JMP DEL_B4b7

DEL_B4b7:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b7, r1.b0, r1.b1

CLC_B4b8:
    MOV r1.b0, 0
    LSR r4, r8, 0
    AND r4, r4, 1
    QBEQ SET_B4b8, r4, 1

CLR_B4b8:
    CLR r30.t15
    JMP DEL_B4b8

SET_B4b8:
    SET r30.t15
    JMP DEL_B4b8

DEL_B4b8:
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B4b8, r1.b0, r1.b2

    ADD r2, r2, 1
    QBNE CLC_B1b1, r2, r3

END_TEST:

    MOV r31.b0, PRU0_ARM_INTERRUPT+16
    HALT


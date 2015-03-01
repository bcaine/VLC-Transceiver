// Receiver - PRU0 source code. Responsible for sampling incoming data from
// its input GPIO pin (Header 8, Pin 15 on Beaglebone Black) and passing it
// to PRU1 for later memory dump. This code implements a preamble for clock
// sync purposes: on init, and after the end of each packet, PRU0 will sample
// a byte of data from its input pin and check if this byte matches the start
// of a new packet (preamble byte). Aside from this special case, PRU0 will
// sample its input pin at a rate of 1MHz, matching the transmission rate.
// Current implementation stores 4 bytes of input data at a time in r29, then
// copies r29 to the first register 'in the queue', allowing repetition of the loop.

.origin 0
.entrypoint INIT
#include "../../include/asm.hp"

#define PACKETCOUNT 2000
#define PREAMBLE 0b00111100
#define REQBITS 6

//  _____________________
//  Register  |  Purpose
//		      
//    r0.b0   |  Counter - delay loops performed
//    r0.b1   |  Const   - delays to perform (normal op)
//    r0.b2   |  Const   - delays to perform (after reg copy)
//    r0.b3   |  Const   - delays to perform (preamble loop)
//    r1.b0   |  Counter - registers filled
//    r1.b1   |  Holder  - XOR result (preamble)
//      r2    |  Holder  - recent input bits (preamble)
//    r3.b0   |  Holder  - hold preamble for comparison
//    r3.b1   |  Holder  - hold desired number of bitmatches for preamble comparison
//    r3.b2   |  Counter - number of input stream bits matching the preamble
//    r3.b3   |  Holder  - hold LSR/AND result (preamble)
//      r4    |  Holder  - bit sampled
//    r8-r29  |  Holder  - hold sampled bytes
//      r30   |  I/O     - holds GPI pin register (.t15)
//
//    r5, r6  | - Free registers
//      r7    |

INIT:
        // Enable OCP master port
        LBCO      r0, C4, 4, 4
        CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
        SBCO      r0, C4, 4, 4

        MOV r0.b0, 0 // init delay counter to 0
        MOV r0.b1, 97 // store forward delay value for comparison
        MOV r0.b2, 92 // store backward delay value for comparison
        MOV r0.b3, 82 // store preamble delay value for comparison

	MOV r1.b0, 0 // init reg number to 0
	MOV r1.b1, 0 // hold XOR result

        MOV r2, 0 // recent bits holder
        
	MOV r3.b0, PREAMBLE // hold actual preamble for comparison
        MOV r3.b1, REQBITS // hold desired bit matches for comparison
	MOV r3.b2, 0 // init bit matches counter to 0
	MOV r3.b3, 0 // hold LSR/AND result

        MOV r6, PACKETCOUNT
	MOV r7, 0

        JMP PRE_LP

NEW_PACKET:
        XOUT 10, r8, 88

DEL_NEW:
        ADD r0.b0, r0.b0, 1
        QBNE DEL_NEW, r0.b0, r0.b2

        MOV r2, 0 // reset bit holder
        MOV r3.b2, 0 // reset matching bits counter

PRE_LP:
        MOV r0.b0, 0 // reset delay
        LSL r2, r2, 1 // shift preamble holder to prepare for new bit
        LSR r4, r31, 15 // sample GPI reg, shift sample value to 0th index
        AND r4, r4, 1 // and to zero out all other bits
        QBEQ PRE_SET, r4, 1 // if bit set, jump to set

PRE_CLR:
        CLR r2.t0 // clear new bit
        MOV r3.b2, 0 // NOP
        JMP PRE_DEL

PRE_SET:
        SET r2.t0 // set new bit
        MOV r3.b2, 0 // NOP
        JMP PRE_DEL

PRE_DEL: 
        ADD r0.b0, r0.b0, 1
        QBNE PRE_DEL, r0.b0, r0.b3

PRE_CHK:
        XOR r1.b1, r2.b0, r3.b0 // get bitwise differences b/w preamble and current
        NOT r1.b1, r1.b1 // NOT - get bitwise similarities

        LSR r3.b3, r1.b1, 0 // shift to bit of interest
        AND r3.b3, r3.b3, 1 // isolate that bit
        ADD r3.b2, r3.b2, r3.b3 // add it to the counter

        LSR r3.b3, r1.b1, 1 // repeat for each bit
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

        LSR r3.b3, r1.b1, 2
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 3
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 4
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 5
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 6
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

	LSR r3.b3, r1.b1, 7
        AND r3.b3, r3.b3, 1
        ADD r3.b2, r3.b2, r3.b3

        QBGT CPY_P1b1, r3.b1, r3.b2 // if enough bits match, jump out of preamble
        JMP PRE_LP

CPY_P1b1:
        MOV r29.b3, r2.b0 // store preamble
        JMP SMP_B2b1

DEL_CPY:
        ADD r0.b0, r0.b0, 1
        QBNE DEL_CPY, r0.b0, r0.b2

SMP_B1b1:
        MOV r0.b0, 0
        LSR r4, r31, 15
        AND r4, r4, 1
        QBEQ SET_B1b1, r4, 1


CLR_B1b1:
	CLR r29.t31
	JMP DEL_B1b1

SET_B1b1:
	SET r29.t31
	JMP DEL_B1b1

DEL_B1b1:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b1, r0.b0, r0.b1

SMP_B1b2:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b2, r4, 1

CLR_B1b2:
	CLR r29.t30
	JMP DEL_B1b2

SET_B1b2:
	SET r29.t30
	JMP DEL_B1b2

DEL_B1b2:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b2, r0.b0, r0.b1

SMP_B1b3:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b3, r4, 1

CLR_B1b3:
	CLR r29.t29
	JMP DEL_B1b3

SET_B1b3:
	SET r29.t29
	JMP DEL_B1b3

DEL_B1b3:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b3, r0.b0, r0.b1

SMP_B1b4:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b4, r4, 1

CLR_B1b4:
	CLR r29.t28
	JMP DEL_B1b4

SET_B1b4:
	SET r29.t28
	JMP DEL_B1b4

DEL_B1b4:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b4, r0.b0, r0.b1

SMP_B1b5:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b5, r4, 1

CLR_B1b5:
	CLR r29.t27
	JMP DEL_B1b5

SET_B1b5:
	SET r29.t27
	JMP DEL_B1b5

DEL_B1b5:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b5, r0.b0, r0.b1

SMP_B1b6:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b6, r4, 1

CLR_B1b6:
	CLR r29.t26
	JMP DEL_B1b6

SET_B1b6:
	SET r29.t26
	JMP DEL_B1b6

DEL_B1b6:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b6, r0.b0, r0.b1

SMP_B1b7:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b7, r4, 1

CLR_B1b7:
	CLR r29.t25
	JMP DEL_B1b7

SET_B1b7:
	SET r29.t25
	JMP DEL_B1b7

DEL_B1b7:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b7, r0.b0, r0.b1

SMP_B1b8:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B1b8, r4, 1

CLR_B1b8:
	CLR r29.t24
	JMP DEL_B1b8

SET_B1b8:
	SET r29.t24
	JMP DEL_B1b8

BCK_P1b8:
	JMP NEW_PACKET

BCK_B1b8:

	JMP DEL_CPY

DEL_B1b8:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B1b8, r0.b0, r0.b1

SMP_B2b1:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b1, r4, 1

CLR_B2b1:
	CLR r29.t23
	JMP DEL_B2b1

SET_B2b1:
	SET r29.t23
	JMP DEL_B2b1

DEL_B2b1:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b1, r0.b0, r0.b1

SMP_B2b2:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b2, r4, 1

CLR_B2b2:
	CLR r29.t22
	JMP DEL_B2b2

SET_B2b2:
	SET r29.t22
	JMP DEL_B2b2

DEL_B2b2:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b2, r0.b0, r0.b1

SMP_B2b3:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b3, r4, 1

CLR_B2b3:
	CLR r29.t21
	JMP DEL_B2b3

SET_B2b3:
	SET r29.t21
	JMP DEL_B2b3

DEL_B2b3:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b3, r0.b0, r0.b1

SMP_B2b4:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b4, r4, 1

CLR_B2b4:
	CLR r29.t20
	JMP DEL_B2b4

SET_B2b4:
	SET r29.t20
	JMP DEL_B2b4

DEL_B2b4:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b4, r0.b0, r0.b1

SMP_B2b5:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b5, r4, 1

CLR_B2b5:
	CLR r29.t19
	JMP DEL_B2b5

SET_B2b5:
	SET r29.t19
	JMP DEL_B2b5

DEL_B2b5:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b5, r0.b0, r0.b1

SMP_B2b6:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b6, r4, 1

CLR_B2b6:
	CLR r29.t18
	JMP DEL_B2b6

SET_B2b6:
	SET r29.t18
	JMP DEL_B2b6

DEL_B2b6:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b6, r0.b0, r0.b1

SMP_B2b7:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b7, r4, 1

CLR_B2b7:
	CLR r29.t17
	JMP DEL_B2b7

SET_B2b7:
	SET r29.t17
	JMP DEL_B2b7

DEL_B2b7:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b7, r0.b0, r0.b1

SMP_B2b8:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B2b8, r4, 1

CLR_B2b8:
	CLR r29.t16
	JMP DEL_B2b8

SET_B2b8:
	SET r29.t16
	JMP DEL_B2b8

BCK_P2b8:
	JMP BCK_P1b8

BCK_B2b8:
	JMP BCK_B1b8

DEL_B2b8:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B2b8, r0.b0, r0.b1

SMP_B3b1:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b1, r4, 1

CLR_B3b1:
	CLR r29.t15
	JMP DEL_B3b1

SET_B3b1:
	SET r29.t15
	JMP DEL_B3b1

DEL_B3b1:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b1, r0.b0, r0.b1

SMP_B3b2:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b2, r4, 1

CLR_B3b2:
	CLR r29.t14
	JMP DEL_B3b2

SET_B3b2:
	SET r29.t14
	JMP DEL_B3b2

DEL_B3b2:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b2, r0.b0, r0.b1

SMP_B3b3:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b3, r4, 1

CLR_B3b3:
	CLR r29.t13
	JMP DEL_B3b3

SET_B3b3:
	SET r29.t13
	JMP DEL_B3b3

DEL_B3b3:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b3, r0.b0, r0.b1

SMP_B3b4:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b4, r4, 1

CLR_B3b4:
	CLR r29.t12
	JMP DEL_B3b4

SET_B3b4:
	SET r29.t12
	JMP DEL_B3b4

DEL_B3b4:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b4, r0.b0, r0.b1

SMP_B3b5:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b5, r4, 1

CLR_B3b5:
	CLR r29.t11
	JMP DEL_B3b5

SET_B3b5:
	SET r29.t11
	JMP DEL_B3b5

DEL_B3b5:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b5, r0.b0, r0.b1

SMP_B3b6:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b6, r4, 1

CLR_B3b6:
	CLR r29.t10
	JMP DEL_B3b6

SET_B3b6:
	SET r29.t10
	JMP DEL_B3b6

DEL_B3b6:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b6, r0.b0, r0.b1

SMP_B3b7:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b7, r4, 1

CLR_B3b7:
	CLR r29.t9
	JMP DEL_B3b7
		
SET_B3b7:
	SET r29.t9
	JMP DEL_B3b7

DEL_B3b7:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b7, r0.b0, r0.b1

SMP_B3b8:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B3b8, r4, 1

CLR_B3b8:
	CLR r29.t8
	JMP DEL_B3b8

SET_B3b8:
	SET r29.t8
	JMP DEL_B3b8

BCK_P3b8:
	JMP BCK_P2b8

BCK_B3b8:
	JMP BCK_B2b8

DEL_B3b8:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B3b8, r0.b0, r0.b1

SMP_B4b1:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b1, r4, 1

CLR_B4b1:
	CLR r29.t7
	JMP DEL_B4b1

SET_B4b1:
	SET r29.t7
	JMP DEL_B4b1

DEL_B4b1:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b1, r0.b0, r0.b1

SMP_B4b2:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b2, r4, 1

CLR_B4b2:
	CLR r29.t6
	JMP DEL_B4b2

SET_B4b2:
	SET r29.t6
	JMP DEL_B4b2

DEL_B4b2:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b2, r0.b0, r0.b1

SMP_B4b3:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b3, r4, 1

CLR_B4b3:
	CLR r29.t5
	JMP DEL_B4b3

SET_B4b3:
	SET r29.t5
	JMP DEL_B4b3

DEL_B4b3:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b3, r0.b0, r0.b1

SMP_B4b4:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b4, r4, 1

CLR_B4b4:
	CLR r29.t4
	JMP DEL_B4b4

SET_B4b4:
	SET r29.t4
	JMP DEL_B4b4

DEL_B4b4:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b4, r0.b0, r0.b1

SMP_B4b5:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b5, r4, 1

CLR_B4b5:
	CLR r29.t3
	JMP DEL_B4b5

SET_B4b5:
	SET r29.t3
	JMP DEL_B4b5

DEL_B4b5:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b5, r0.b0, r0.b1

SMP_B4b6:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b6, r4, 1

CLR_B4b6:
	CLR r29.t2
	JMP DEL_B4b6

SET_B4b6:
	SET r29.t2
	JMP DEL_B4b6

DEL_B4b6:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b6, r0.b0, r0.b1

SMP_B4b7:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b7, r4, 1

CLR_B4b7:
	CLR r29.t1
	JMP DEL_B4b7

SET_B4b7:
	SET r29.t1
	JMP DEL_B4b7

DEL_B4b7:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_B4b7, r0.b0, r0.b1

SMP_B4b8:
	MOV r0.b0, 0
	LSR r4, r31, 15
	AND r4, r4, 1
	QBEQ SET_B4b8, r4, 1

CLR_B4b8:
	CLR r29.t0
	JMP UPD_R29

SET_B4b8:
	SET r29.t0
	JMP UPD_R29

BCK_P4b8:
	JMP BCK_P3b8

UPD_R29:
	ADD r1.b0, r1.b0, 1
	QBEQ CPY_R8, r1.b0, 1
	QBEQ CPY_R9, r1.b0, 2
	QBEQ CPY_R10, r1.b0, 3
	QBEQ CPY_R11, r1.b0, 4
	QBEQ CPY_R12, r1.b0, 5
	QBEQ CPY_R13, r1.b0, 6
	QBEQ CPY_R14, r1.b0, 7
	QBEQ CPY_R15, r1.b0, 8
	QBEQ CPY_R16, r1.b0, 9
	QBEQ CPY_R17, r1.b0, 10
	QBEQ CPY_R18, r1.b0, 11
	QBEQ CPY_R19, r1.b0, 12
	QBEQ CPY_R20, r1.b0, 13
	QBEQ CPY_R21, r1.b0, 14
	QBEQ CPY_R22, r1.b0, 15
	QBEQ CPY_R23, r1.b0, 16
	QBEQ CPY_R24, r1.b0, 17
	QBEQ CPY_R25, r1.b0, 18
	QBEQ CPY_R26, r1.b0, 19
	QBEQ CPY_R27, r1.b0, 20
	QBEQ CPY_R28, r1.b0, 21
	MOV r1.b0, 0

CHECK_DONE:
	ADD r7, r7, 1
	SUB r0.b2, r0.b2, 3
	QBNE BCK_P4b8, r6, r7
	XOUT 10, r8, 88
	JMP STOP

CPY_R8:
	MOV r8, r29
	MOV r0.b2, 93
	JMP BCK_B3b8
CPY_R9:
	MOV r9, r29
	JMP BCK_B3b8
CPY_R10:
	MOV r10, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R11:
	MOV r11, r29
	JMP BCK_B3b8
CPY_R12:
	MOV r12, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R13:
	MOV r13, r29
	JMP BCK_B3b8
CPY_R14:
	MOV r14, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R15:
	MOV r15, r29
	JMP BCK_B3b8
CPY_R16:
	MOV r16, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R17:
	MOV r17, r29
	JMP BCK_B3b8
CPY_R18:
	MOV r18, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R19:
	MOV r19, r29
	JMP BCK_B3b8
CPY_R20:
	MOV r20, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R21:
	MOV r21, r29
	JMP BCK_B3b8
CPY_R22:
	MOV r22, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R23:
	MOV r23, r29
	JMP BCK_B3b8
CPY_R24:
	MOV r24, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R25:
	MOV r25, r29
	JMP BCK_B3b8
CPY_R26:
	MOV r26, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8
CPY_R27:
	MOV r27, r29
	JMP BCK_B3b8
CPY_R28:
	MOV r28, r29
	SUB r0.b2, r0.b2, 1
	JMP BCK_B3b8

STOP:
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT


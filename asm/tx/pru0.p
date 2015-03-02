.origin 0
.entrypoint INIT
#include "../../include/asm.hp"

//  _____________________
//  Register  |  Purpose
//
//    r0.b0   |  Counter - delay loops performed
//    r0.b1   |  Const   - delays to perform (normal op)
//    r0.b2   |  Holder  - delays to perform (after reg copy)   
//    r0.b3   |  Counter - registers modulated
//    r2.w0   |  Counter - packets modulated
//    r2.w2   |  Const   - packets to transfer
//      r3    |  Const   - base address of data buffer
//      r4    |  Holder  - bit to modulate
//
//    r5-r7   |  Free
//
//    r9-r29  |  Holder  - hold packet bytes
//      r30   |  I/O     - holds GPO pin register (.t15)

#define DELAY_FWD 97
#define DELAY_BWD 92
#define DELAY_NEW 92

INIT:
    
    // Enable OCP master port -- allows external memory access
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4
		
    MOV r3, DDR_ADDRESS
	
    MOV  r0.b0, 0 // init delay counter to 0
    MOV  r0.b1, DELAY_FWD // store forward delay value
    MOV  r0.b2, DELAY_BWD // store backward delay value
    MOV  r0.b3, 0 // init register counter to 0
	
    MOV  r2.w0, 0 // init packet counter to 0
    LBBO r2.w2, r3, 0, 2 // load transfer length from RAM

    XIN 10, r9, PACK_LEN // pull a packet from the scratchpad
    JMP CLC_B1b1 // jump to modulation (start loop)

MAIN_LOOP:
    XIN 10, r9, PACK_LEN // load PACK_LEN bytes in from SP
    MOV r0.b2, DELAY_NEW // set delay lower when pulling new packet (takes longer) 

DEL_R8: // new packet delay
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R8, r0.b0, r0.b2

CLC_B1b1:
    MOV r0.b0, 0 // reset delay counter to 0
    GET_BIT r9, 31, r4
    QBEQ SET_B1b1, r4, 1 // if this bit is high, jump to set

CLR_B1b1: // if bit low
    CLR r30.t15 // set GPIO low
    JMP DEL_B1b1 // jump to delay

SET_B1b1: // if bit high
    SET r30.t15 // set GPIO high
    JMP DEL_B1b1 // jump to delay

DEL_B1b1: // Byte 1, bit 1 delay
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b1, r0.b0, r0.b1

// This same process repeats for each bit of the data register

CLC_B1b2:
    MOV r0.b0, 0
    GET_BIT r9, 30, r4
    QBEQ SET_B1b2, r4, 1

CLR_B1b2:
    CLR r30.t15
    JMP DEL_B1b2

SET_B1b2:
    SET r30.t15
    JMP DEL_B1b2

DEL_B1b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b2, r0.b0, r0.b1

CLC_B1b3:
    MOV r0.b0, 0
    GET_BIT r9, 29, r4
    QBEQ SET_B1b3, r4, 1

CLR_B1b3:
    CLR r30.t15
    JMP DEL_B1b3

SET_B1b3:
    SET r30.t15
    JMP DEL_B1b3

DEL_B1b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b3, r0.b0, r0.b1

CLC_B1b4:
    MOV r0.b0, 0
    GET_BIT r9, 28, r4
    QBEQ SET_B1b4, r4, 1

CLR_B1b4:
    CLR r30.t15
    JMP DEL_B1b4

SET_B1b4:
    SET r30.t15
    JMP DEL_B1b4

DEL_B1b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b4, r0.b0, r0.b1

CLC_B1b5:
    MOV r0.b0, 0
    GET_BIT r9, 27, r4
    QBEQ SET_B1b5, r4, 1

CLR_B1b5:
    CLR r30.t15
    JMP DEL_B1b5

SET_B1b5:
    SET r30.t15
    JMP DEL_B1b5

DEL_B1b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b5, r0.b0, r0.b1

CLC_B1b6:
    MOV r0.b0, 0
    GET_BIT r9, 26, r4
    QBEQ SET_B1b6, r4, 1

CLR_B1b6:
    CLR r30.t15
    JMP DEL_B1b6

SET_B1b6:
    SET r30.t15
    JMP DEL_B1b6

DEL_B1b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b6, r0.b0, r0.b1

CLC_B1b7:
    MOV r0.b0, 0
    GET_BIT r9, 25, r4
    QBEQ SET_B1b7, r4, 1

CLR_B1b7:
    CLR r30.t15
    JMP DEL_B1b7

SET_B1b7:
    SET r30.t15
    JMP DEL_B1b7

DEL_B1b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b7, r0.b0, r0.b1

CLC_B1b8:
    MOV r0.b0, 0
    GET_BIT r9, 24, r4
    QBEQ SET_B1b8, r4, 1

CLR_B1b8:
    CLR r30.t15
    JMP DEL_B1b8

SET_B1b8:
    SET r30.t15
    JMP DEL_B1b8

BCK_B1b8: // backup to loop start
    QBEQ MAIN_LOOP, r0.b3, 0 // if we've modulated all reg, pull a new packet
    JMP DEL_R8 // else, modulate next data reg

DEL_B1b8:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B1b8, r0.b0, r0.b1

CLC_B2b1:
    MOV r0.b0, 0
    GET_BIT r9, 23, r4
    QBEQ SET_B2b1, r4, 1

CLR_B2b1:
    CLR r30.t15
    JMP DEL_B2b1

SET_B2b1:
    SET r30.t15
    JMP DEL_B2b1

DEL_B2b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b1, r0.b0, r0.b1

CLC_B2b2:
    MOV r0.b0, 0
    GET_BIT r9, 22, r4
    QBEQ SET_B2b2, r4, 1

CLR_B2b2:
    CLR r30.t15
    JMP DEL_B2b2

SET_B2b2:
    SET r30.t15
    JMP DEL_B2b2

DEL_B2b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b2, r0.b0, r0.b1

CLC_B2b3:
    MOV r0.b0, 0
    GET_BIT r9, 21, r4
    QBEQ SET_B2b3, r4, 1

CLR_B2b3:
    CLR r30.t15
    JMP DEL_B2b3

SET_B2b3:
    SET r30.t15
    JMP DEL_B2b3

DEL_B2b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b3, r0.b0, r0.b1

CLC_B2b4:
    MOV r0.b0, 0
    GET_BIT r9, 20, r4
    QBEQ SET_B2b4, r4, 1

CLR_B2b4:
    CLR r30.t15
    JMP DEL_B2b4

SET_B2b4:
    SET r30.t15
    JMP DEL_B2b4

DEL_B2b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b4, r0.b0, r0.b1

CLC_B2b5:
    MOV r0.b0, 0
    GET_BIT r9, 19, r4
    QBEQ SET_B2b5, r4, 1

CLR_B2b5:
    CLR r30.t15
    JMP DEL_B2b5

SET_B2b5:
    SET r30.t15
    JMP DEL_B2b5

DEL_B2b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b5, r0.b0, r0.b1

CLC_B2b6:
    MOV r0.b0, 0
    GET_BIT r9, 18, r4
    QBEQ SET_B2b6, r4, 1

CLR_B2b6:
    CLR r30.t15
    JMP DEL_B2b6

SET_B2b6:
    SET r30.t15
    JMP DEL_B2b6

DEL_B2b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b6, r0.b0, r0.b1

CLC_B2b7:
    MOV r0.b0, 0
    GET_BIT r9, 17, r4
    QBEQ SET_B2b7, r4, 1

CLR_B2b7:
    CLR r30.t15
    JMP DEL_B2b7

SET_B2b7:
    SET r30.t15
    JMP DEL_B2b7

DEL_B2b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b7, r0.b0, r0.b1

CLC_B2b8:
    MOV r0.b0, 0
    GET_BIT r9, 16, r4
    QBEQ SET_B2b8, r4, 1

CLR_B2b8:
    CLR r30.t15
    JMP DEL_B2b8

SET_B2b8:
    SET r30.t15
    JMP DEL_B2b8

BCK_B2b8: // backup to loop start
    JMP BCK_B1b8

DEL_B2b8:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B2b8, r0.b0, r0.b1

CLC_B3b1:
    MOV r0.b0, 0
    GET_BIT r9, 15, r4
    QBEQ SET_B3b1, r4, 1

CLR_B3b1:
    CLR r30.t15
    JMP DEL_B3b1

SET_B3b1:
    SET r30.t15
    JMP DEL_B3b1

DEL_B3b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b1, r0.b0, r0.b1

CLC_B3b2:
    MOV r0.b0, 0
    GET_BIT r9, 14, r4
    QBEQ SET_B3b2, r4, 1

CLR_B3b2:
    CLR r30.t15
    JMP DEL_B3b2

SET_B3b2:
    SET r30.t15
    JMP DEL_B3b2

DEL_B3b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b2, r0.b0, r0.b1

CLC_B3b3:
    MOV r0.b0, 0
    GET_BIT r9, 13, r4
    QBEQ SET_B3b3, r4, 1

CLR_B3b3:
    CLR r30.t15
    JMP DEL_B3b3

SET_B3b3:
    SET r30.t15
    JMP DEL_B3b3

DEL_B3b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b3, r0.b0, r0.b1

CLC_B3b4:
    MOV r0.b0, 0
    GET_BIT r9, 12, r4
    QBEQ SET_B3b4, r4, 1

CLR_B3b4:
    CLR r30.t15
    JMP DEL_B3b4

SET_B3b4:
    SET r30.t15
    JMP DEL_B3b4

DEL_B3b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b4, r0.b0, r0.b1

CLC_B3b5:
    MOV r0.b0, 0
    GET_BIT r9, 11, r4
    QBEQ SET_B3b5, r4, 1

CLR_B3b5:
    CLR r30.t15
    JMP DEL_B3b5

SET_B3b5:
    SET r30.t15
    JMP DEL_B3b5

DEL_B3b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b5, r0.b0, r0.b1

CLC_B3b6:
    MOV r0.b0, 0
    GET_BIT r9, 10, r4
    QBEQ SET_B3b6, r4, 1

CLR_B3b6:
    CLR r30.t15
    JMP DEL_B3b6

SET_B3b6:
    SET r30.t15
    JMP DEL_B3b6

DEL_B3b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b6, r0.b0, r0.b1

CLC_B3b7:
    MOV r0.b0, 0
    GET_BIT r9, 9, r4
    QBEQ SET_B3b7, r4, 1

CLR_B3b7:
    CLR r30.t15
    JMP DEL_B3b7

SET_B3b7:
    SET r30.t15
    JMP DEL_B3b7

DEL_B3b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b7, r0.b0, r0.b1

CLC_B3b8:
    MOV r0.b0, 0
    GET_BIT r9, 8, r4
    QBEQ SET_B3b8, r4, 1

CLR_B3b8:
    CLR r30.t15
    JMP DEL_B3b8

SET_B3b8:
    SET r30.t15
    JMP DEL_B3b8

BCK_B3b8: // backup to loop start
	JMP BCK_B2b8

DEL_B3b8:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B3b8, r0.b0, r0.b1

CLC_B4b1:
    MOV r0.b0, 0
    GET_BIT r9, 7, r4
    QBEQ SET_B4b1, r4, 1

CLR_B4b1:
    CLR r30.t15
    JMP DEL_B4b1

SET_B4b1:
    SET r30.t15
    JMP DEL_B4b1

DEL_B4b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b1, r0.b0, r0.b1

CLC_B4b2:
    MOV r0.b0, 0
    GET_BIT r9, 6, r4
    QBEQ SET_B4b2, r4, 1

CLR_B4b2:
    CLR r30.t15
    JMP DEL_B4b2

SET_B4b2:
    SET r30.t15
    JMP DEL_B4b2

DEL_B4b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b2, r0.b0, r0.b1

CLC_B4b3:
    MOV r0.b0, 0
    GET_BIT r9, 5, r4
    QBEQ SET_B4b3, r4, 1

CLR_B4b3:
    CLR r30.t15
    JMP DEL_B4b3

SET_B4b3:
    SET r30.t15
    JMP DEL_B4b3

DEL_B4b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b3, r0.b0, r0.b1

CLC_B4b4:
    MOV r0.b0, 0
    GET_BIT r9, 4, r4
    QBEQ SET_B4b4, r4, 1

CLR_B4b4:
    CLR r30.t15
    JMP DEL_B4b4

SET_B4b4:
    SET r30.t15
    JMP DEL_B4b4

DEL_B4b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b4, r0.b0, r0.b1

CLC_B4b5:
    MOV r0.b0, 0
    GET_BIT r9, 3, r4
    QBEQ SET_B4b5, r4, 1

CLR_B4b5:
    CLR r30.t15
    JMP DEL_B4b5

SET_B4b5:
    SET r30.t15
    JMP DEL_B4b5

DEL_B4b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b5, r0.b0, r0.b1

CLC_B4b6:
    MOV r0.b0, 0
    GET_BIT r9, 2, r4
    QBEQ SET_B4b6, r4, 1

CLR_B4b6:
    CLR r30.t15
    JMP DEL_B4b6

SET_B4b6:
    SET r30.t15
    JMP DEL_B4b6

DEL_B4b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b6, r0.b0, r0.b1

CLC_B4b7:
    MOV r0.b0, 0
    GET_BIT r9, 1, r4
    QBEQ SET_B4b7, r4, 1

CLR_B4b7:
    CLR r30.t15
    JMP DEL_B4b7

SET_B4b7:
    SET r30.t15
    JMP DEL_B4b7

DEL_B4b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_B4b7, r0.b0, r0.b1

CLC_B4b8:
    MOV r0.b0, 0
    GET_BIT r9, 0, r4
    QBEQ SET_B4b8, r4, 1

CLR_B4b8:
    CLR r30.t15
    JMP UPD_R8

SET_B4b8:
    SET r30.t15
    JMP UPD_R8

BCK_B4b8: // backup to loop start
	JMP BCK_B3b8

UPD_R8: // once the whole reg modulated
	ADD r0.b3, r0.b3, 1 // increment register counter
	
	// Copy the next register to modulate into r9,
	// dependent on the value of the register counter
	QBEQ CPY_R10, r0.b3, 1
	QBEQ CPY_R11, r0.b3, 2
	QBEQ CPY_R12, r0.b3, 3
	QBEQ CPY_R13, r0.b3, 4
	QBEQ CPY_R14, r0.b3, 5
	QBEQ CPY_R15, r0.b3, 6
	QBEQ CPY_R16, r0.b3, 7
	QBEQ CPY_R17, r0.b3, 8
	QBEQ CPY_R18, r0.b3, 9
	QBEQ CPY_R19, r0.b3, 10
	QBEQ CPY_R20, r0.b3, 11
	QBEQ CPY_R21, r0.b3, 12
	QBEQ CPY_R22, r0.b3, 13
	QBEQ CPY_R23, r0.b3, 14
	QBEQ CPY_R24, r0.b3, 15
	QBEQ CPY_R25, r0.b3, 16
	QBEQ CPY_R26, r0.b3, 17
	QBEQ CPY_R27, r0.b3, 18
	QBEQ CPY_R28, r0.b3, 19
	QBEQ MOD_R29, r0.b3, 20

// If all registers modulated

CHECK_DONE: 
	MOV r0.b3, 0 // reset register counter
    ADD r2.w0, r2.w0, 1 // increment packet counter

    // if more packets, jump back to loop start.
    // Note that due to instruction limitations,
    // jump is segmented across multiple addresses
    // in instruction memory to allow stunted jump
    // back to the top of the loop.
    QBNE BCK_B4b8, r2.w0, r2.w2

    JMP STOP // if done, jump to stop

CPY_R10:
	MOV r9, r10 	// copy contents of r9 into r9 (modulation reg)
	MOV r0.b2, DELAY_BWD // reset delay
	JMP BCK_B4b8 // jump back to loop start
CPY_R11:
	MOV r9, r11
	JMP BCK_B4b8 
CPY_R12:
	MOV r9, r12 
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8 
CPY_R13:
	MOV r9, r13 
	JMP BCK_B4b8
CPY_R14:
	MOV r9, r14
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R15:
	MOV r9, r15
	JMP BCK_B4b8
CPY_R16:
	MOV r9, r16
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R17:
	MOV r9, r17
	JMP BCK_B4b8
CPY_R18:
	MOV r9, r18
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R19:
	MOV r9, r19
	JMP BCK_B4b8
CPY_R20:
	MOV r9, r20
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R21:
	MOV r9, r21
	JMP BCK_B4b8
CPY_R22:
	MOV r9, r22
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R23:
	MOV r9, r23
	JMP BCK_B4b8
CPY_R24:
	MOV r9, r24
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R25:
	MOV r9, r25
	JMP BCK_B4b8
CPY_R26:
	MOV r9, r26
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8
CPY_R27:
	MOV r9, r27
	JMP BCK_B4b8
CPY_R28:
	MOV r9, r28
	SUB r0.b2, r0.b2, 1
	JMP BCK_B4b8					
	
MOD_R29:
	MOV r9, r29
	MOV r0.b0, 0
	ADD r0.b2, r0.b2, 2 // = 85
	
DEL_R29:
	ADD r0.b0, r0.b0, 1
	QBNE DEL_R29, r0.b0, r0.b2
	
CLC_R29_B2b1:
    MOV r0.b0, 0
    GET_BIT r9, 23, r4
    QBEQ SET_R29_B2b1, r4, 1

CLR_R29_B2b1:
    CLR r30.t15
    JMP DEL_R29_B2b1

SET_R29_B2b1:
    SET r30.t15
    JMP DEL_R29_B2b1

DEL_R29_B2b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b1, r0.b0, r0.b1

CLC_R29_B2b2:
    MOV r0.b0, 0
    GET_BIT r9, 22, r4
    QBEQ SET_R29_B2b2, r4, 1

CLR_R29_B2b2:
    CLR r30.t15
    JMP DEL_R29_B2b2

SET_R29_B2b2:
    SET r30.t15
    JMP DEL_R29_B2b2

DEL_R29_B2b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b2, r0.b0, r0.b1

CLC_R29_B2b3:
    MOV r0.b0, 0
    GET_BIT r9, 21, r4
    QBEQ SET_R29_B2b3, r4, 1

CLR_R29_B2b3:
    CLR r30.t15
    JMP DEL_R29_B2b3

SET_R29_B2b3:
    SET r30.t15
    JMP DEL_R29_B2b3

DEL_R29_B2b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b3, r0.b0, r0.b1

CLC_R29_B2b4:
    MOV r0.b0, 0
    GET_BIT r9, 20, r4
    QBEQ SET_R29_B2b4, r4, 1

CLR_R29_B2b4:
    CLR r30.t15
    JMP DEL_R29_B2b4

SET_R29_B2b4:
    SET r30.t15
    JMP DEL_R29_B2b4

DEL_R29_B2b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b4, r0.b0, r0.b1

CLC_R29_B2b5:
    MOV r0.b0, 0
    GET_BIT r9, 19, r4
    QBEQ SET_R29_B2b5, r4, 1

CLR_R29_B2b5:
    CLR r30.t15
    JMP DEL_R29_B2b5

SET_R29_B2b5:
    SET r30.t15
    JMP DEL_R29_B2b5

DEL_R29_B2b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b5, r0.b0, r0.b1

CLC_R29_B2b6:
    MOV r0.b0, 0
    GET_BIT r9, 18, r4
    QBEQ SET_R29_B2b6, r4, 1

CLR_R29_B2b6:
    CLR r30.t15
    JMP DEL_R29_B2b6

SET_R29_B2b6:
    SET r30.t15
    JMP DEL_R29_B2b6

DEL_R29_B2b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b6, r0.b0, r0.b1

CLC_R29_B2b7:
    MOV r0.b0, 0
    GET_BIT r9, 17, r4
    QBEQ SET_R29_B2b7, r4, 1

CLR_R29_B2b7:
    CLR r30.t15
    JMP DEL_R29_B2b7

SET_R29_B2b7:
    SET r30.t15
    JMP DEL_R29_B2b7

DEL_R29_B2b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b7, r0.b0, r0.b1

CLC_R29_B2b8:
    MOV r0.b0, 0
    GET_BIT r9, 16, r4
    QBEQ SET_R29_B2b8, r4, 1

CLR_R29_B2b8:
    CLR r30.t15
    JMP DEL_R29_B2b8

SET_R29_B2b8:
    SET r30.t15
    JMP DEL_R29_B2b8

DEL_R29_B2b8:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B2b8, r0.b0, r0.b1

CLC_R29_B3b1:
    MOV r0.b0, 0
    GET_BIT r9, 15, r4
    QBEQ SET_R29_B3b1, r4, 1

CLR_R29_B3b1:
    CLR r30.t15
    JMP DEL_R29_B3b1

SET_R29_B3b1:
    SET r30.t15
    JMP DEL_R29_B3b1

DEL_R29_B3b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b1, r0.b0, r0.b1

CLC_R29_B3b2:
    MOV r0.b0, 0
    GET_BIT r9, 14, r4
    QBEQ SET_R29_B3b2, r4, 1

CLR_R29_B3b2:
    CLR r30.t15
    JMP DEL_R29_B3b2

SET_R29_B3b2:
    SET r30.t15
    JMP DEL_R29_B3b2

DEL_R29_B3b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b2, r0.b0, r0.b1

CLC_R29_B3b3:
    MOV r0.b0, 0
    GET_BIT r9, 13, r4
    QBEQ SET_R29_B3b3, r4, 1

CLR_R29_B3b3:
    CLR r30.t15
    JMP DEL_R29_B3b3

SET_R29_B3b3:
    SET r30.t15
    JMP DEL_R29_B3b3

DEL_R29_B3b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b3, r0.b0, r0.b1

CLC_R29_B3b4:
    MOV r0.b0, 0
    GET_BIT r9, 12, r4
    QBEQ SET_R29_B3b4, r4, 1

CLR_R29_B3b4:
    CLR r30.t15
    JMP DEL_R29_B3b4

SET_R29_B3b4:
    SET r30.t15
    JMP DEL_R29_B3b4

DEL_R29_B3b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b4, r0.b0, r0.b1

CLC_R29_B3b5:
    MOV r0.b0, 0
    GET_BIT r9, 11, r4
    QBEQ SET_R29_B3b5, r4, 1

CLR_R29_B3b5:
    CLR r30.t15
    JMP DEL_R29_B3b5

SET_R29_B3b5:
    SET r30.t15
    JMP DEL_R29_B3b5

DEL_R29_B3b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b5, r0.b0, r0.b1

CLC_R29_B3b6:
    MOV r0.b0, 0
    GET_BIT r9, 10, r4
    QBEQ SET_R29_B3b6, r4, 1

CLR_R29_B3b6:
    CLR r30.t15
    JMP DEL_R29_B3b6

SET_R29_B3b6:
    SET r30.t15
    JMP DEL_R29_B3b6

DEL_R29_B3b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b6, r0.b0, r0.b1

CLC_R29_B3b7:
    MOV r0.b0, 0
    GET_BIT r9, 9, r4
    QBEQ SET_R29_B3b7, r4, 1

CLR_R29_B3b7:
    CLR r30.t15
    JMP DEL_R29_B3b7

SET_R29_B3b7:
    SET r30.t15
    JMP DEL_R29_B3b7

DEL_R29_B3b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b7, r0.b0, r0.b1

CLC_R29_B3b8:
    MOV r0.b0, 0
    GET_BIT r9, 8, r4
    QBEQ SET_R29_B3b8, r4, 1

CLR_R29_B3b8:
    CLR r30.t15
    JMP DEL_R29_B3b8

SET_R29_B3b8:
    SET r30.t15
    JMP DEL_R29_B3b8

DEL_R29_B3b8:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B3b8, r0.b0, r0.b1

CLC_R29_B4b1:
    MOV r0.b0, 0
    GET_BIT r9, 7, r4
    QBEQ SET_R29_B4b1, r4, 1

CLR_R29_B4b1:
    CLR r30.t15
    JMP DEL_R29_B4b1

SET_R29_B4b1:
    SET r30.t15
    JMP DEL_R29_B4b1

DEL_R29_B4b1:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b1, r0.b0, r0.b1

CLC_R29_B4b2:
    MOV r0.b0, 0
    GET_BIT r9, 6, r4
    QBEQ SET_R29_B4b2, r4, 1

CLR_R29_B4b2:
    CLR r30.t15
    JMP DEL_R29_B4b2

SET_R29_B4b2:
    SET r30.t15
    JMP DEL_R29_B4b2

DEL_R29_B4b2:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b2, r0.b0, r0.b1

CLC_R29_B4b3:
    MOV r0.b0, 0
    GET_BIT r9, 5, r4
    QBEQ SET_R29_B4b3, r4, 1

CLR_R29_B4b3:
    CLR r30.t15
    JMP DEL_R29_B4b3

SET_R29_B4b3:
    SET r30.t15
    JMP DEL_R29_B4b3

DEL_R29_B4b3:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b3, r0.b0, r0.b1

CLC_R29_B4b4:
    MOV r0.b0, 0
    GET_BIT r9, 4, r4
    QBEQ SET_R29_B4b4, r4, 1

CLR_R29_B4b4:
    CLR r30.t15
    JMP DEL_R29_B4b4

SET_R29_B4b4:
    SET r30.t15
    JMP DEL_R29_B4b4

DEL_R29_B4b4:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b4, r0.b0, r0.b1

CLC_R29_B4b5:
    MOV r0.b0, 0
    GET_BIT r9, 3, r4
    QBEQ SET_R29_B4b5, r4, 1

CLR_R29_B4b5:
    CLR r30.t15
    JMP DEL_R29_B4b5

SET_R29_B4b5:
    SET r30.t15
    JMP DEL_R29_B4b5

DEL_R29_B4b5:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b5, r0.b0, r0.b1

CLC_R29_B4b6:
    MOV r0.b0, 0
    GET_BIT r9, 2, r4
    QBEQ SET_R29_B4b6, r4, 1

CLR_R29_B4b6:
    CLR r30.t15
    JMP DEL_R29_B4b6

SET_R29_B4b6:
    SET r30.t15
    JMP DEL_R29_B4b6

DEL_R29_B4b6:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b6, r0.b0, r0.b1

CLC_R29_B4b7:
    MOV r0.b0, 0
    GET_BIT r9, 1, r4
    QBEQ SET_R29_B4b7, r4, 1

CLR_R29_B4b7:
    CLR r30.t15
    JMP DEL_R29_B4b7

SET_R29_B4b7:
    SET r30.t15
    JMP DEL_R29_B4b7

DEL_R29_B4b7:
    ADD r0.b0, r0.b0, 1
    QBNE DEL_R29_B4b7, r0.b0, r0.b1

CLC_R29_B4b8:
    MOV r0.b0, 0
    GET_BIT r9, 0, r4
    QBEQ SET_R29_B4b8, r4, 1

CLR_R29_B4b8:
    CLR r30.t15
    JMP UPD_R8

SET_R29_B4b8:
    SET r30.t15
    JMP UPD_R8

BCK_R29_B4b8: // backup to loop start
	JMP CHECK_DONE

STOP:
	SET r30.t15 // leave GPIO line high
	MOV r31.b0, PRU0_ARM_INTERRUPT+16 // send termination interrupt to ARM
	HALT // shutdown



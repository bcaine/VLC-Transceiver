// Transmitter - PRU0 source code. Responsible for pulling encoded, packetized data
// from the PRU Scratch Pad and modulating it on the output GPIO pin (Header 8, 
// Pin 11 on Beaglebone Black). Pulls one packet (88B) at a time and modulates the data
// out at a constant rate of 1MHz, corresponding to a full-loop operation time of 140800
// cycles, or 0.7 ms per packet. Loops until local count of packets sent matches
// initial length of transfer read in from RAM (SEE r3). Current implementation
// loops modulating all bits of the register r8, then copying the first register
// 'in the queue' into r8, allowing repetition of the loop.


.origin 0
.entrypoint INIT
#include "../../include/asm.hp"

#define READ_ADDRESS 0x90000000

//  _____________________
//  Register  |  Purpose
//
//    r1.b0   |  Counter - delay loops performed
//    r1.b1   |  Const   - delays to perform (normal op)
//    r1.b2   |  Holder  - delays to perform (after reg copy)   
//    r1.b3   |  Counter - registers modulated
//      r2    |  Counter - packets modulated
//      r3    |  Const   - packets to transfer
//      r4    |  Holder  - bit to modulate
//      r5    |  Const   - base address of data buffer
//    r8-r29  |  Holder  - hold packet bytes
//      r30   |  I/O     - holds GPO pin register (.t15)


// Not used: r0, r5, r6, r7

INIT:
    
    // Enable OCP master port -- allows external memory access
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4
		
    MOV r5, READ_ADDRESS
    MOV r1.b0, 0 // init delay counter to 0
    MOV r1.b1, 97 // store forward delay value
    MOV r1.b2, 91 // store backward delay value
    MOV r1.b3, 0 // init register counter to 0
    MOV r2, 0 // init packet counter to 0
    LBBO r3, r5, 0, 4 // load transfer length from RAM

    XIN 10, r8, 88 // pull a packet from the scratchpad
    JMP CLC_B1b1 // jump to modulation (start loop)

MAIN_LOOP:
    XIN 10, r8, 88 // load 88 bytes in from SP
    MOV r1.b2, 81 // set delay lower when pulling new packet (takes longer) 


DEL_R8: // new packet delay
    ADD r1.b0, r1.b0, 1
    QBNE DEL_R8, r1.b0, r1.b2

CLC_B1b1:
    MOV r1.b0, 0 // reset delay counter to 0
    LSR r4, r8, 31 // shift MSB of data reg to LSB
    AND r4, r4, 1 // AND with 1 to remove all other bits
    QBEQ SET_B1b1, r4, 1 // if this bit is high, jump to set

CLR_B1b1: // if bit low
    CLR r30.t15 // set GPIO low
    JMP DEL_B1b1 // jump to delay

SET_B1b1: // if bit high
    SET r30.t15 // set GPIO high
    JMP DEL_B1b1 // jump to delay

DEL_B1b1: // Byte 1, bit 1 delay
    ADD r1.b0, r1.b0, 1
    QBNE DEL_B1b1, r1.b0, r1.b1

// This same process repeats for each bit of the data register

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

BCK_B1b8: // backup to loop start
    QBEQ MAIN_LOOP, r1.b3, 0 // if we've modulated all reg, pull a new packet
    JMP DEL_R8 // else, modulate next data reg

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

BCK_B2b8: // backup to loop start
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

BCK_B3b8: // backup to loop start
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
    JMP UPD_R8

SET_B4b8:
    SET r30.t15
    JMP UPD_R8

BCK_B4b8: // backup to loop start
	JMP BCK_B3b8

UPD_R8: // once the whole reg modulated
	ADD r1.b3, r1.b3, 1 // increment register counter
	
	// Copy the next register to modulate into r8,
	// dependent on the value of the register counter
	QBEQ CPY_R9, r1.b3, 1
	QBEQ CPY_R10, r1.b3, 2
	QBEQ CPY_R11, r1.b3, 3
	QBEQ CPY_R12, r1.b3, 4
	QBEQ CPY_R13, r1.b3, 5
	QBEQ CPY_R14, r1.b3, 6
	QBEQ CPY_R15, r1.b3, 7
	QBEQ CPY_R16, r1.b3, 8
	QBEQ CPY_R17, r1.b3, 9
	QBEQ CPY_R18, r1.b3, 10
	QBEQ CPY_R19, r1.b3, 11
	QBEQ CPY_R20, r1.b3, 12
	QBEQ CPY_R21, r1.b3, 13
	QBEQ CPY_R22, r1.b3, 14
	QBEQ CPY_R23, r1.b3, 15
	QBEQ CPY_R24, r1.b3, 16
	QBEQ CPY_R25, r1.b3, 17
	QBEQ CPY_R26, r1.b3, 18
	QBEQ CPY_R27, r1.b3, 19
	QBEQ CPY_R28, r1.b3, 20
	QBEQ CPY_R29, r1.b3, 21

// If all registers modulated

	MOV r1.b3, 0 // reset register counter

CHECK_DONE: 
    ADD r2, r2, 1 // increment packet counter

    // if more packets, jump back to loop start.
    // Note that due to instruction limitations,
    // jump is segmented across multiple addresses
    // in instruction memory to allow stunted jump
    // back to the top of the loop.
    QBNE BCK_B4b8, r2, r3

    JMP STOP // if done, jump to stop

CPY_R9:
	MOV r8, r9 // copy contents of r9 into r8 (modulation reg)
	MOV r1.b2, 91 // set required delay for constant 1mhz
	MOV r1.b2, 91 // NOP to make delay even (allow loop)
	JMP BCK_B4b8 // jump back to loop start
CPY_R10:
	MOV r8, r10 // copy r10 into r8
	MOV r1.b2, 91 // NOP to make delay even
	JMP BCK_B4b8 // jump back to loop start
CPY_R11:
	MOV r8, r11 // copy r11 into r8
	JMP BCK_B4b8 // jump back to loop start
CPY_R12:
	MOV r8, r12

	// as the register check block above takes more cycles
	// for higher registers, subtract from the delay limit
	// to maintain a constant 1mhz out with changing cycle
	// costs per register.
	SUB r1.b2, r1.b2, 1 
	JMP BCK_B4b8
CPY_R13:
	MOV r8, r13
	JMP BCK_B4b8
CPY_R14:
	MOV r8, r14
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R15:
	MOV r8, r15
	JMP BCK_B4b8
CPY_R16:
	MOV r8, r16
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R17:
	MOV r8, r17
	JMP BCK_B4b8
CPY_R18:
	MOV r8, r18
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R19:
	MOV r8, r19
	JMP BCK_B4b8
CPY_R20:
	MOV r8, r20
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R21:
	MOV r8, r21
	JMP BCK_B4b8
CPY_R22:
	MOV r8, r22
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R23:
	MOV r8, r23
	JMP BCK_B4b8
CPY_R24:
	MOV r8, r24
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R25:
	MOV r8, r25
	JMP BCK_B4b8
CPY_R26:
	MOV r8, r26
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R27:
	MOV r8, r27
	JMP BCK_B4b8
CPY_R28:
	MOV r8, r28
	SUB r1.b2, r1.b2, 1
	JMP BCK_B4b8
CPY_R29:
	MOV r8, r29
	JMP BCK_B4b8

STOP:
	SET r30.t15 // leave GPIO line high
	MOV r31.b0, PRU0_ARM_INTERRUPT+16 // send termination interrupt to ARM
	HALT // shutdown


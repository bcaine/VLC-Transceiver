.origin 0
.entrypoint INIT

#define PRU0_DELAY 70347 // delay needed to wait for PRU0
#include "tx.hp"

INIT:
	// Enable OCP master port
    	LBCO      r0, C4, 4, 4
    	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    	SBCO      r0, C4, 4, 4

	// make C31 (CONST_DDR) point to DDR base address
	MOV r0, 0x100000
	MOV r1, PRU1CTPPR_1
	SBBO r0, r1, 0, 4

	MOV r0, 5 // offset
	MOV r1, 0 // delay counter
	MOV r2, PRU0_DELAY // delay value
	MOV r4, 0 // packet counter
	LBCO r5, CONST_DDR, 0, 4 // what's the offset?

START:
	LBCO r8, CONST_DDR, r0, 88 // load 88 bytes into r8-r29 from DDR
	ADD r0, r0, 100 // increment read offset
	ADD r4, r4, 1 // increment packet counter

MAIN_LOOP:
	XOUT 10, r8, 100 // write to SP
	QBEQ STOP, r4, r5 // if done, branch to stop

	ADD r4, r4, 1 // if not done, increment packet length and keep going

	LBCO r8, CONST_DDR, r0, 100 // pull another 100 bytes from DDR
	ADD r0, r0, 100 // increment read offset
	SBCO r4, CONST_DDR, 0, 8 // store packet count to DDR

	LDI r1, 0 // reset delay counter

WAIT:
	ADD r1, r1, 1 // increment delay
	QBLT WAIT, r1, r2
	JMP MAIN_LOOP // if sufficient delay, return to main loop

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT+16
	HALT

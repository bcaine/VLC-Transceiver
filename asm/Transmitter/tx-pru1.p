.origin 0
.entrypoint INIT

#define PRU0_DELAY // number of cycles' delay needed to wait for PRU0
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

	LDI r0, 5 // load initial offset into r0
	LDI r1, 0 // load PRU1 delay counter
	LDI r4, 0 // load packet length counter
	LBCO r5, CONST_DDR, 0, 1 // 1 byte or 4? what's the offset?

// NOTE: Need to determine the cycle cost of this MAIN_LOOP, find the difference

// initial data pull from DDR
START:
	LBCO r8, CONST_DDR, r0, 100 // load 88 bytes into r8-r29 from DDR
	ADD r0, r0, 100 // increment read offset

MAIN_LOOP:
	XOUT 10, r8, 100 // write to SP
	LBCO r2, CONST_DDR, 0, 1 // load the done code from DDR
	QBEQ STOP, r4, r5 // if done, branch to stop

	ADD r4, r4, 1 // if not done, increment packet length and keep going

	LBCO r8, CONST_DDR, r0, 100 // pull another 100 bytes from DDR
	ADD r0, r0, 100 // increment read offset
	SBCO r0, CONST_DDR, 1, 4 // store read offset to DDR

	LDI r1, 0 // reset delay counter

WAIT:
	ADD r1, r1, 1 // increment delay
	QBLT WAIT, r1, PRU0_DELAY // wait for PRU1 to modulate, deterministic
	JMP MAIN_LOOP // if sufficient delay, return to main loop

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT+16
	HALT
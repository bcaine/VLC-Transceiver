.origin 0
.entrypoint INIT

#define PRU0_DELAY 70197 // delay needed to wait for PRU0
#include "tx.hp"

// NOTE: Delay assumes 140799 cycles between PRU0 XINs
// and allows for each LBCO/SBCO to take 200 cycles each
// This should ensure that PRU1 is always done before PRU0,
// which allows XOUT to begin and hang until PRU0 done.
// Note that if PRU1 is done more than 1023 cycles before PRU0,
// we will start to see issues with XOUT timing out.

INIT:
	// Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

	// make C31 (CONST_DDR) point to DDR base address
	MOV r0, 0x100000
	MOV r1, PRU1CTPPR_1
	SBBO r0, r1, 0, 4

	MOV r0, 5 // initial offset
	MOV r1, 0 // delay counter
	MOV r2, PRU0_DELAY // packet length counter
	MOV r4, 0 // packet counter

	LBCO r3, CONST_DDR, 0, 4 // what's the offset?

START:
	LBCO r8, CONST_DDR, r0, 88 // load 88 bytes
	ADD r0, r0, 88 // increment read offset
	ADD r4, r4, 1 // increment packet counter

MAIN_LOOP:
	XOUT 10, r8, 88 // write to SP
	QBEQ STOP, r4, r3 // if done, branch to stop

	ADD r4, r4, 1 // if not done, increment packet length and keep going

	LBCO r8, CONST_DDR, r0, 88 // pull another 88 bytes
	ADD r0, r0, 88 // increment read offset
	SBCO r4, CONST_DDR, 4, 4 // store packet count

	LDI r1, 0 // reset delay counter

WAIT:
	ADD r1, r1, 1 // increment delay
	QBLT WAIT, r1, r2 
	JMP MAIN_LOOP // if sufficient delay, return to main loop

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT+16
	HALT
.origin 0
.entrypoint INIT

#define PRU0_DELAY 70196 // delay needed to wait for PRU0
#define INIT_DELAY 70400 // delay needed for initial read-in
#define OFFSET_LIM 16376 // maximum byte offset
#include "rx.hp"

// NOTE: Delay assuems 140799 cycles between PRU0 XOUTs
// and allows for all LBCO/SBCO to take 200 cycles each.
// This should ensure that PRU1 is always done before PRU0,
// which allows XIN to begin and hang until PRU0 done.
// Note that if PRU1 is done more than 1023 cycles before PRU0,
// we will start to see issues with XIN timing out.


INIT:
	// Enable OCP master port
    LBCO      r0, C4, 4, 4
    CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, C4, 4, 4

	// make C31 (CONST_DDR) point to DDR base address
	MOV		  r0, 0x100000
	MOV		  r1, PRU1CTPPR_1
	SBBO	  r0, r1, 0, 4

	MOV		  r0, 8 // counter --offset
	MOV		  r1, 0 // counter --delay
	MOV		  r2, PRU0_DELAY // loop delay --forward
	LBCO	  r3, CONST_DDR, 0, 4 // limit --num packets
	MOV		  r4, 0 // counter --packets
	MOV		  r5, INIT_DELAY // loop delay --init
	MOV		  r6, OFFSET_LIM // limit --read offset

START_DELAY:
	ADD r1, r1, 1
	QBNE START_DELAY, r1, r5

MAIN_LOOP:
	XIN 10, r8, 88 // read from SP
	QBNE STORE_DATA, r0, r6
	MOV r0, 8

STORE_DATA:
	SBCO r8, CONST_DDR, r0, 88 // store to RAM
	ADD r0, r0, 88 // increment offset

	ADD r4, r4, 1 // increment packet count
	SBCO r4, CONST_DDR, 4, 4 // store to RAM

	QBEQ STOP, r4, r3

	MOV r1, 0

WAIT:
	ADD r1, r1, 1
	QBNE WAIT, r1, r2 

	JMP MAIN_LOOP

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT + 16
	HALT
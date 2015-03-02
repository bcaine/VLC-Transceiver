// This test should sample the level of Pin 15 of header P8 on the Beaglebone Black.
// Note that this requires a device tree overlay enabling direct PRU control already 
// be in place (see /etc/rc.local for echo command).
//
// This test will sample the input pin at 1MHz, looping for the number of samples
// specified by levelIn.c, which is loaded into r2. For each sample, if the value
// does not match the expected value (see r3), a mismatch counter is incremented.
// At the end of the test, the mismatch value is written to RAM for processing by 
// the Linux side.

.origin 0
.entrypoint INIT
#include "../../../../../include/asm.hp"

#define HIGH  1
#define LOW   0

INIT:

        // Enable OCP master port
        LBCO r0, CONST_PRUCFG, 4, 4
        CLR r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
        SBCO r0, CONST_PRUCFG, 4, 4

        // make CONST_DDR (C31) point to DDR base address
        MOV r0, 0x00100000
        MOV r1, PRU0CTPPR_1
        SBBO r0, r1, 0, 4

        MOV r0, 0 // delay loop counter
        MOV r1, 96 // delay loops
	LBCO r2, CONST_DDR, 0, 4 // load number of samples to take
	MOV r5, 0 // number of samples taken
	MOV r6, 0 // hold number of samples that do not match expected
	CLR r30.t15
	MOV r3, LOW // hold expected value for comparisonn
	
SAMPLE:
	MOV r0, 0 // reset delay counter
	MOV r0, 0 // NOP (delay)
	MOV r1, 96 // reset delay length
	SET r30.t15
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	MOV r0, r0
	LSR r4, r31, 15 // sample input register
	CLR r30.t15
	AND r4, r4, 1 // isolate input pin
	QBEQ DELAY, r4, r3 // if value matches expected, go to delay
	ADD r6, r6, 1 // if not, increment mismatch counter
	SUB r1, r1, 1 // subtract 1 from delay for consistency

DELAY:
	ADD r0, r0, 1
	QBNE DELAY, r0, r1
	
	ADD r5, r5, 1 // increment sample counter
	// if samples taken not equal to the total number to take
	QBNE SAMPLE, r5, r2 // restart loop

	// else, terminate
STOP:
	SBCO r6, CONST_DDR, 4, 4

        MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT

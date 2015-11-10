// NOTE: Can we test with a simple breadboard LED circuit? Or DVM... LED is nicer
#define PIN_NUMBER ?? // GPO pin used for test

SET_HIGH:
	LDI r4, 0
	AND r30, r30, PIN_NUMBER // set specified GPO high
WAIT_HIGH:
	ADD r4, r4, 1
	QBNE WAIT_HIGH r4, 50000000 // wait for half a second
SET_LOW:
	AND r30, r30, 0 // set all GPO low
WAIT_LOW:
	SUB r4, r4, 1
	QBNE WAIT_LOW r4, 0 // wait for half a second
	JMP SET_HIGH // restart loop


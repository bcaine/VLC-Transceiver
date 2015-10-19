#define PRAM_ADDR // the address of local PRU RAM
#define DONE_CODE // code assigned when all data has been read
#define PIN_BITMASK // bitmask for the desired pin of the GPO

START:
	LDI r1, PRAM_ADDR // load the PRAM address for read operations

// CYCLE COSTS:
// as stands: TX - 2 cycles/bit
// entire loop will take 1601 cycles
// plus 4 cycle break for JMP/CHECK_DONE

// NOTE: still need to decide on GPO pin number, and hard code the LSL/LSR
// instructions to shift to that bit appropriately.

CHECK_DONE:
	LBBO r2, r1, 0, 1 // load the done code from PRAM
	QBEQ STOP, r2, DONE_CODE
MAIN_LOOP:
	XIN 10, r5, 100 // load 100 bytes in from SP
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 1
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 2
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 3
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 4
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 5
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 6
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 7
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 8
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 1
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 2
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 3
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 4
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 5
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 6
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 7
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 8
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 1
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 2
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 3
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 4
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 5
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 6
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 7
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 8
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 1
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 2
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 3
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 4
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 5
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 6
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 7
	LSL r4, r5, pinNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 8

	// continue for all of the registers

	JMP CHECK_DONE

STOP:
	SLP 0 // deactivate PRU (requires restart)
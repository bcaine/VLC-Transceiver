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

// (IMPLEMENT THIS) NOTE: shiftNumber should be hardcoded to avoid cycle cost.
// at each point, shiftNumber should be =  pinSet - currentBit, where pinSet
// is the number bit of the GPO register we are trying to set, and pinSet is the
// number bit of the register we are currently trying to write.
// FURTHER NOTE: LSL will need to change to LSR once (pinSet - currentBit) < 0

// NOTEY NOTE NOTE: below implementation should work completely fine, as long as
// writing directly to R30 will set the PRU GPIO bit. Note that this also requires
// that that pin be mux'd to be a PRU GPIO, which in turn requires DTO. Test this first.

CHECK_DONE:
	LBBO r2, r1, 0, 1 // load the done code from PRAM
	QBEQ STOP, r2, DONE_CODE
MAIN_LOOP:
	XIN 10, r5, 100 // load 100 bytes in from SP
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 1
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 2
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 3
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 4
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 5
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 6
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 7
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 1 bit 8
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 1
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 2
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 3
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 4
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 5
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 6
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 7
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 2 bit 8
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 1
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 2
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 3
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 4
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 5
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 6
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 7
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 3 bit 8
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 1
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 2
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 3
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 4
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 5
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 6
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 7
	LSL r4, r5, shiftNumber
	AND r30, r4, PIN_BITMASK // set byte 4 bit 8

	// continue for all of the registers

	JMP CHECK_DONE

STOP:
	SLP 0 // deactivate PRU (requires restart)
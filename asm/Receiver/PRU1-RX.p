#define DONE_CODE // code to indicate enough valid data has been written
#define READBITMASK // bitmask cancelling out all but the relevant GPI bit
#define PRAM_ADDR // address of local PRAM for read operations

START:
	// what goes here? -- clock sync operation?
	LDI r1, PRAM_ADDR // load read address for check-done operations

CHECK_DONE:
	LBBO r2, r1, 0, 1
	QBEQ STOP, r2, DONE_CODE

// CYCLE COSTS:
// as stands: RX - 2 cycles/bit
// entire loop will take 1601 cycles
// + 4 cycle break for JUMP/CHECK_DONE


// NOTE: still need to determine which GPI we will be using, set r31.t?? appropriately.
// Also need to confirm that LSL will accept r31.t?? as input, not entirely clear

MAIN_LOOP:
	// byte 1:
	LSL r3, r31.t1, 0 // shift over (not necessary for first bit, but need to maintain cycle cost/bit)
	OR r5, r5, r3 // OR the given bit into the storage register
	LSL r3, r31.t1, 1 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 2 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 3 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 4 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 5 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 6 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 7 // shift over
	OR r5, r5, r3 // OR into storage

	// byte 2:
	LSL r3, r31.t1, 8 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 9 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 10 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 11 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 12 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 13 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 14 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 15 // shift over
	OR r5, r5, r3 // OR into storage

	// byte 3:
	LSL r3, r31.t1, 16 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 17 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 18 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 19 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 20 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 21 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 22 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 23 // shift over
	OR r5, r5, r3 // OR into storage

	// byte 4:
	LSL r3, r31.t1, 24 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 25 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 26 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 27 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 28 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 29 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 30 // shift over
	OR r5, r5, r3 // OR into storage
	LSL r3, r31.t1, 31 // shift over
	OR r5, r5, r3 // OR into storage

	// repeat this, masking, shifting, and ORing, for all available registers
	// (minimize required off-time)

DATA_PUSH:
	XOUT 10, r5, 100
	JMP CHECK_DONE

STOP:
	SLP 0
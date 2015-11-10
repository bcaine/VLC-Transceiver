#define DDR_ADDR // address of main DDR memory
#define PRAM_ADDR // address of local PRU RAM
#define MAX_WR_OFFSET // maximum valid write offset (limited by DDR size)
#define PRU1_DELAY // number of cycles' delay needed to allow PRU1 to pull sufficient data
#define DONE_CODE // code signifying 'all valid data received to DDR'

START:
	LDI r1, DDR_ADDR // load the address of main DDR into r1 for store instr
	LDI r2, 8 // load the initial offset into r2 for load instr. gives us 2 bytes of empty mem
	LDI r3, 0 // load delay value for waiting for PRU1 to modulate

// NOTE: Need to determine the cycle cost of this MAIN_LOOP, find the difference
// between time required for this and time required for PRU1 to receive input.
// This difference will be the value of PRU1_DELAY, allowing this PRU to idle.

WAIT_LOOP:
	ADD r3, r3, 1 // increment delay
	QBLT WAIT_LOOP, r3, PRU1_DELAY // wait for PRU1 to receive, deterministic

MAIN_LOOP:
	LBCO r4, r1, 0, 4 // load in the dataDone code
	QBEQ STOP, r4, DONE_CODE // check if data is done, if so jump to stop
	XIN 10, r5, 100 // pull 100 bytes from the scratchpad 
	SBCO r5, r1, r2, 100 // store the 100 bytes to DDR
	SBCO r2, r1, 4, 4 // store the current write offset for BBB
	ADD r2, r2, 100 // increment the offset
	LDI r3, 0 // reset delay counter to 0
	QBLT WAIT_LOOP, r2, MAX_WR_OFFSET // check that offset still within bounds
	LDI r2, 8 // if not, reset the offset
STOP:
	LDI r1, PRAM_ADDR // load the PRU RAM address into reg for write operation
	LDI r2, DONE_CODE // load the done code into reg for write operation
	SBBO r2, r1, 0, 1 // store the done code in PRU local RAM
	SLP 0 // PRU turns off (reset required to start again)
#define DDR_ADDR // address of main DDR memory, used for data loads
#define PRAM_ADDR // address of local PRU RAM, used for writing 'DONE'
#define MAX_RD_OFFSET // maximum valid read offset (limited by available DDR size)
#define PRU1_DELAY // number of cycles' delay needed to allow PRU1 to modulate its given data
#define DONE_CODE // code signifying 'all data pulled from DDR'

START:
	LDI r1, DDR_ADDR // load the address of main DDR into r1 for load instr
	LDI r2, 8 // load the initial offset into r2 for load instr. gives us 2 bytes of empty mem
	LDI r3, 0 // load delay counter for waiting for PRU1 to modulate

// NOTE: Need to determine the cycle cost of this MAIN_LOOP, find the difference
// between time required for this and time required for PRU1 to modulate output.
// This difference will be the value of PRU1_DELAY, allowing this PRU to idle.

// initial data pull from DDR
INIT:
	LBCO r5, r1, r2, 100 // load 100 bytes (number of available registers *4) into r5-r29 from DDR
	ADD r2, r2, 100 // increment read offset

MAIN_LOOP:
	XOUT 10, r5, 100 // write the 100 bytes to the scratchpad (should take 1 cycle)
	LBCO r4, r1, 0, 4 // load in the dataDone code
	QBEQ STOP, r4, DONE_CODE // check if data is done, if so jump to stop
	LBCO r5, r1, r2, 100 // pull another 100 bytes from DDR
	ADD r2, r2, 100 // increment read offset
	SBCO r2, r1, 4, 4 // store the current read offset for BBB to analyze
	LDI r3, 0 // reset delay counter to 0
	QBLT WAIT, r2, MAX_RD_OFFSET // check that offset still within bounds
	LDI r2, 8 // if not, reset the offset
WAIT:
	ADD r3, r3, 1 // increment delay
	QBLT WAIT, r3, PRU1_DELAY // wait for PRU1 to modulate, deterministic
	JMP MAIN_LOOP // if sufficient delay, return to main loop
STOP:
	LDI r1, PRAM_ADDR // load the PRU RAM address into reg for write operation
	LDI r2, DONE_CODE // load the done code into reg for write operation
	SBBO r2, r1, 0, 1 // store the done code in PRU local RAM
	SLP 0 // PRU turns off (reset required to start again)
#define READTESTLOC ?? // location in DDR that we are trying to read from
#define WRITETESTLOC ?? // location in DDR that we are trying to write to
#define READTESTBYTE ?? // byte we expect to read from DDR
#define PIN_NUMBER ?? // GPO pin we want to write to for test pass/fail

LDI r1, READTESTLOC
LDI r2, WRITETESTLOC

LBCO r3, r1, 0, 1 // read in the value from DDR
QBEQ TEST_PASS, r3, READTESTBYTE // if as expected, test passed

TEST_FAIL: 
	AND r30, r30, 0 // set GPIO low
	JMP WRITE_TEST

TEST_PASS:
	AND r30, r30, PIN_NUMBER // set GPIO high

WRITE_TEST:
	SBCO r3, r2, 0, 1 // write the read-in value to DDR
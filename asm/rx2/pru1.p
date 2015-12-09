.origin 0
.entrypoint INIT

#include "../../include/asm.hp"

//  _____________________
//  Register  |  Purpose
//		      
//      r0    |  Counter - write offset for RAM stores
//	    r1    |  Holder  - end of buffer offset (wraparound)
//      r2    |  Holder  - address of start of buffer (no offset)
//     r3.b0  |  Check   - holds zero value to reset packet ready code
//     r3.b1  |  Check   - holds value at 'packet ready' code location
//      r4    |  Counter - number of packets received
//      r5    |  Holder  - maximum number of packets to receive
//      r6    |  Counter - delay loops performed
//      r7    |  Holder  - delay loop timeout (shutdown if reached)
//    r9-r29  |  Holder  - hold sampled bytes

INIT:
	// Enable OCP master port
	LBCO      r0, C4, 4, 4
	CLR       r0, r0, 4     
	SBCO      r0, C4, 4, 4

	// Enable PRU RAM access
	MOV     r0, 0x00000120      
	MOV     r1, PRU1CTPPR_0     
	SBBO    r0, r1, 0, 4

	MOV r0, INIT_OFFSET                      // init write offset to ninth byte
	MOV r1, OFFSET_LIM                       // store end of buffer location
	MOV r2, DDR_ADDRESS	                     // store buffer address
	
	SBBO r0, r2, 4, 4                        // write initial offset to RAM
	SBCO r3.b0, CONST_PRUSHAREDRAM, 0, 1     // force packet ready false on init
	
	MOV r4, 0                                // init packet counter to 0
	MOV r5, PACKET_LIMIT                     // store max packet limit for comparison
	MOV r6, 0                                // init delay counter to 0
	MOV r7, RX_PRU1_TIMEOUT                  // store delay timeout for comparison

POLL_INIT:
	LBCO r3.b1, CONST_PRUSHAREDRAM, 0, 1     // load value of packet-ready code
	QBNE POLL_INIT, r3.b1, READY_CODE        // if low, keep checking it
	JMP READ                                 // if high, jump to pull data

POLL_PX:
	ADD r6, r6, 1                            // increment delay counter
	LBCO r3.b1, CONST_PRUSHAREDRAM, 0, 1     // load value of packet-ready code
	QBEQ STOP, r6, r7                        // if delay over timeout value, jump to shutdown
	QBNE POLL_PX, r3.b1, READY_CODE          // if low, keep checking the code

READ: 
	XIN 10, r9, PACK_LEN                     // once packet-ready code high, pull from PRU0

	QBNE STORE, r0, r1                       // if not an overflow condition, jump to store data

	MOV r0, INIT_OFFSET                      // else, reset offset to start of buffer

STORE:
	SBBO r9, r2, r0, PACK_LEN                // push packet to RAM
	ADD r0, r0, PACK_LEN                     // increment offset
	SBBO r0, r2, 4, 4                        // store offset to RAM

	MOV r9.b0, 0                             // store 0 value
	SBCO r9.b0, CONST_PRUSHAREDRAM, 0, 1     // overwrite the packet ready code with this value
	
	ADD r4, r4, 1                            // increment packet counter 
	QBEQ STOP, r4, r5                        // if at packet limit, jump to stop

	MOV r6, 0                                // if not, reset delay value

	JMP POLL_PX                              // and wait for another packet

STOP:
	MOV r31.b0, PRU1_ARM_INTERRUPT + 16      // send program complete interrupt to host
	HALT                                     // shut down microcontroller


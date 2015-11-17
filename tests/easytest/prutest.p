.origin 0
.entrypoint MEMACCESS_DDR_PRUSHAREDRAM

#include "prutest.hp"

MEMACCESS_DDR_PRUSHAREDRAM:

    // Enable OCP master port
    LBCO      r0, CONST_PRUCFG, 4, 4
    CLR     r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable OCP master port
    SBCO      r0, CONST_PRUCFG, 4, 4

    // Configure the programmable pointer register for PRU0 by setting c28_pointer[15:0] 
    // field to 0x0120.  This will make C28 point to 0x00012000 (PRU shared RAM).
    MOV     r0, 0x00000120
    MOV       r1, CTPPR_0
    ST32      r0, r1

    // Configure the programmable pointer register for PRU0 by setting c31_pointer[15:0] 
    // field to 0x0010.  This will make C31 point to 0x80001000 (DDR memory).
    MOV     r0, 0x00100000
    MOV       r1, CTPPR_1
    ST32      r0, r1
	
    //Load values from external DDR Memory into Registers R0/R1/R2
    LBCO      r0, CONST_DDR, 0, 12

    MOV r4, 0xabcd

    SBCO      r4, CONST_DDR, 0, 4
    //Store values from read from the DDR memory into PRU shared RAM
    SBCO      r0, CONST_PRUSHAREDRAM, 0, 12

    // Send notification to Host for program completion
    MOV       r31.b0, PRU1_ARM_INTERRUPT+16

    // Halt the processor
    HALT



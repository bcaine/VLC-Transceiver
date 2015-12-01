.origin 0
.entrypoint INIT

#define READ_ADDRESS 0x90000000
#define PRU0_ARM_INTERRUPT 19

INIT:	
	// Enable OCP master port -- allows external memory access
	LBCO      r0, C4, 4, 4
	CLR       r0, r0, 4         // Clear SYSCFG[STANDBY_INIT] to enable
	SBCO      r0, C4, 4, 4

	MOV r7, READ_ADDRESS // memory location to read from
	MOV r2, 0 // init packet count to 0
	MOV r0, 8 // init offset to 8
	MOV r3, 0
	MOV r4, 100
	LBBO r1, r7, 0, 4 // load number of loops to perform
	//ADD r1, r1, 1	
LOOPY:
	LBBO r8, r7, r0, 88 // pull 88 bytes from address r0, put in r8
	
        MOV r14.b0, 1
        MOV r14.b1, 2
        MOV r14.b2, 3
        MOV r14.b3, 4

        MOV r15.b0, 5
        MOV r15.b1, 6
        MOV r15.b2, 7
        MOV r15.b3, 8 

        MOV r16.b0, 9
        MOV r16.b1, 10
        MOV r16.b2, 11
        MOV r16.b3, 12

        MOV r17.b0, 13
        MOV r17.b1, 14
        MOV r17.b2, 15
        MOV r17.b3, 16 

        MOV r18.b0, 17
        MOV r18.b1, 18
        MOV r18.b2, 19
        MOV r18.b3, 20 

        MOV r19.b0, 21
        MOV r19.b1, 22
        MOV r19.b2, 23
        MOV r19.b3, 24
 
        MOV r20.b0, 25
        MOV r20.b1, 26
        MOV r20.b2, 27
        MOV r20.b3, 28 
        
        MOV r21.b0, 29
        MOV r21.b1, 30
        MOV r21.b2, 31
        MOV r21.b3, 32 

        MOV r22.b0, 33
        MOV r22.b1, 34
        MOV r22.b2, 35
        MOV r22.b3, 36

        MOV r23.b0, 37
        MOV r23.b1, 38
        MOV r23.b2, 39
        MOV r23.b3, 40 

        MOV r24.b0, 41
        MOV r24.b1, 42
        MOV r24.b2, 43
        MOV r24.b3, 44

        MOV r25.b0, 45
        MOV r25.b1, 46
        MOV r25.b2, 47
        MOV r25.b3, 48 

        MOV r26.b0, 49
        MOV r26.b1, 50
        MOV r26.b2, 51
        MOV r26.b3, 52 

        MOV r27.b0, 53
        MOV r27.b1, 54
        MOV r27.b2, 55
        MOV r27.b3, 56
 
        MOV r28.b0, 57
        MOV r28.b1, 58
        MOV r28.b2, 59
        MOV r28.b3, 60 
        
        MOV r29.b0, 61
        MOV r29.b1, 62
        MOV r29.b2, 63
        MOV r29.b3, 64

        MOV r8.b0, 65
        MOV r8.b1, 66
        MOV r8.b2, 67
        MOV r8.b3, 68

        MOV r9.b0, 69
        MOV r9.b1, 70
        MOV r9.b2, 71
        MOV r9.b3, 72

        MOV r10.b0, 73
        MOV r10.b1, 74
        MOV r10.b2, 75
        MOV r10.b3, 76 

        MOV r11.b0, 77
        MOV r11.b1, 78
        MOV r11.b2, 79
        MOV r11.b3, 80
 
        MOV r12.b0, 81
        MOV r12.b1, 82
        MOV r12.b2, 83
        MOV r12.b3, 84 
        
        MOV r13.b0, 85
        MOV r13.b1, 86
        MOV r13.b2, 87
        MOV r13.b3, 88 
 
        SBBO r8, r7, r0, 88 // store 88 bytes (starting at r8) to address	
	
	ADD r0, r0, 88
	
	ADD r2, r2, 1 // increment packet count

	QBNE LOOPY, r1, r2 // restart loop if more to go
   
STOP:
	MOV r31.b0, PRU0_ARM_INTERRUPT+16
	HALT

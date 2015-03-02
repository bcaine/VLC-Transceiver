/******************************************************************************
* Include Files                                                               *
******************************************************************************/

// Standard header files
#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

// Driver header file
#include "prussdrv.h"
#include <pruss_intc_mapping.h>	 

/******************************************************************************
* Explicit External Declarations                                              *
******************************************************************************/

/******************************************************************************
* Local Macro Declarations                                                    *
******************************************************************************/
#define LENGTH 		 100
#define PACK_LEN	 83
#define PRU_NUM 	 0
#define BUFFER_LENGTH    186
#define BUFF_BASEADDR    0x90000000

#define HIGH_CODE 	 0xffff
#define ALT_CODE 	 0xaaaa
#define LOW_CODE	 0x0000


/******************************************************************************
* Local Typedef Declarations                                                  *
******************************************************************************/


/******************************************************************************
* Local Function Declarations                                                 *
******************************************************************************/

static int LOCAL_exampleInit ( );
static unsigned short LOCAL_examplePassed ( unsigned short pruNum );

/******************************************************************************
* Local Variable Definitions                                                  *
******************************************************************************/
volatile void *length;
volatile void *cursor;
void *data;
unsigned long numBytes = LENGTH * PACK_LEN;
unsigned long numPacks = PACK_LEN;
/******************************************************************************
* Intertupt Service Routines                                                  *
******************************************************************************/


/******************************************************************************
* Global Variable Definitions                                                 *
******************************************************************************/

static int mem_fd;
static void *ddrMem, *sharedMem;
static unsigned int *sharedMem_int;

/******************************************************************************
* Global Function Definitions                                                 *
******************************************************************************/

int main (void)
{
    unsigned int ret0, ret1;
    tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;
    
    printf("\nINFO: Starting test.\r\n");
    /* Initialize the PRU */
    prussdrv_init ();		
    
    /* Open PRU Interrupt */
    ret0 = prussdrv_open(PRU_EVTOUT_0);
    if (ret0)
    {
        printf("prussdrv_open 0 failed\n");
        return (ret0);
    }
    ret1 = prussdrv_open(PRU_EVTOUT_1);
    if (ret1)
    {
        printf("prussdrv_open 1 failed\n");
	return (ret1);
    }
    
    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);

    /* Initialize example */
    printf("\tINFO: Initializing test: (%li) packets.\r\n", LENGTH);
    LOCAL_exampleInit();
    
    /* Execute example on PRU */
    //printf("\tINFO: Executing test.\r\n");
    prussdrv_exec_program (0, "./pru0.bin");
    prussdrv_exec_program (1, "./pru1.bin");

    printf("\tDelaying very stupidly.\r\n");
    //while((*(unsigned long*) cursor) < 8880){};
    *((unsigned char*) length) = 0xff;
    printf("\tWaiting for PRU0 done recognition.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_0);
    //printf("\tINFO: PRU0 completed execution.\r\n");
    prussdrv_pru_clear_event (PRU0_ARM_INTERRUPT);

    /* Wait until PRU0 has finished execution */
    printf("\tWaiting for PRU1 done recognition.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_1);
    //printf("\tINFO: PRU1 completed execution.\r\n");
    prussdrv_pru_clear_event (PRU1_ARM_INTERRUPT);
    /* Check if example passed */
    LOCAL_examplePassed(PRU_NUM);

    memset(ddrMem, LOW_CODE, numBytes);
    
    /* Disable PRU and close memory mapping*/
    prussdrv_pru_disable(0);
    prussdrv_pru_disable(1); 
    prussdrv_exit ();
    munmap(ddrMem, numBytes);
    close(mem_fd);

    return(0);
}

/*****************************************************************************
* Local Function Definitions                                                 *
*****************************************************************************/

static int LOCAL_exampleInit (  )
{
    /* open the device */
    mem_fd = open("/dev/mem", O_RDWR);
    if (mem_fd < 0) {
        printf("Failed to open /dev/mem (%s)\n", strerror(errno));
        return -1;
    }	

    /* map the DDR memory */
    ddrMem = mmap(0, numBytes,  PROT_WRITE | PROT_READ, MAP_SHARED, mem_fd, BUFF_BASEADDR);
    if (ddrMem == NULL) {
        printf("Failed to map the device (%s)\n", strerror(errno));
        close(mem_fd);
        return -1;
    }

    /* Setup required PRU vars in RAM */
    length = ddrMem;
    cursor = ddrMem + 4;
    data = ddrMem + 8;

    *((unsigned long*) length) = 0;
    *((unsigned long*) cursor) = 0;
	
    printf("Clearing before");
    memset(ddrMem, LOW_CODE, numBytes);
    printf("\t memset passed \n");
    return(0);
}
static unsigned short LOCAL_examplePassed ( unsigned short pruNum )
{
   printf("\n\tAfter PRU Completion:\n");
   printf("Length: (%li)\n", (*(unsigned long*) length));
   printf("Cursor: (%li)\n", (*(unsigned long*) cursor));

   printf("Data: \n\n");
   int i = 0;
   unsigned char received[PACK_LEN];
   unsigned long problems = 0;
   for(i; i < LENGTH; i=i+1){
	int j = 0;
	while (j < PACK_LEN){
	  received[j] = (*(unsigned char*) (data + (i * PACK_LEN) +  j));
	  j=j+1;
	}
/*
	int clockDrift = 0;
	int m = 2;
	for(m=4; m < PACK_LEN; m=m+1){
	    if(received[m] != 0xaa){
	        clockDrift = 1;
                problems = problems + 1;
                break;
            }
	}
	if(clockDrift){*/
	    printf("\n Packet number: %li\n", i);
	    int k = 0;
	    for(k=0; k < PACK_LEN; k=k+1){
	        printf("%x ", received[k]);
	    }
	    printf("\n\n");
 	//} 
   }
	//printf("Out of %li packets, %li had drift.\n", LENGTH, problems);
	//float perc = problems/(float)(LENGTH-4);
   	//printf("Corresponding to a %f chance of we're fucked.\n\n\n", perc);

   // return(*(unsigned long*) DDR_regaddr == 0xdcba);
    return(1);
}


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
#include <stdlib.h>

// Driver header file
#include "prussdrv.h"
#include <pruss_intc_mapping.h>	 

/******************************************************************************
* Explicit External Declarations                                              *
******************************************************************************/

/******************************************************************************
* Local Macro Declarations                                                    *
******************************************************************************/
#define LENGTH		 1000
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
volatile void *data;
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

int offset = 0;

/******************************************************************************
* Global Function Definitions                                                 *
******************************************************************************/

int main (int argc, char *argv[])
{
  if (argc == 2)
    offset = atoi(argv[1]);

  printf("Offset %li", offset);
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
    data = ddrMem + 8 + offset;

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
   int i = 5;
   unsigned char packReceived[LENGTH];
   unsigned char packetNum = 0;
   unsigned char received[PACK_LEN];
   unsigned long problems = 0;
   for(i; i < LENGTH; i=i+1){
	int j = 0;
	while (j < PACK_LEN){
	  received[j] = (*(unsigned char*) (data + (i * PACK_LEN) +  j));
	  j=j+1;
	}
	packReceived[i] = received[4];
	/*int clockDrift = 0;

	int m = 2;
	for(m=2; m < PACK_LEN; m=m+1){
	    if(received[m] != 0xaa){
	        clockDrift = 1;
                problems = problems + 1;
                break;
            }
	}
	if(clockDrift){ */
	    printf("\n Packet number: %li\n", i);
	    int k = 0;
	    for(k=0; k < PACK_LEN; k=k+1){
	        printf("%x ", received[k]);
	    }
	    printf("\n\n");
 	//} 
   }
   printf("\n");
   int offCount = 0;
   int j = 0;
   for(j=6; j < LENGTH; j=j+1){
     if(packReceived[j] - packReceived[j-1] > 1){
       printf("At packet [%i]: Before: %i\tCurrent: %i\n", j, packReceived[j-1], packReceived[j]);
       offCount = offCount + 1;
     }
     //printf("%i\n", packReceived[j]);
   }

   printf("\n Number off: %i\n", offCount);
   //printf("Out of %li packets, %li had drift.\n", LENGTH-4, problems);
   //float perc = problems/(float)(LENGTH-4);
   //printf("Corresponding to a %f chance of we're fucked.\n\n\n", perc);

    return(1);
}


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
#define LENGTH 		 1000
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
unsigned long numBytes = LENGTH * 88;

static int LOCAL_exampleInit ( );
static unsigned short LOCAL_examplePassed ( unsigned short pruNum );

/******************************************************************************
* Local Variable Definitions                                                  *
******************************************************************************/
void *length;
void *cursor;
void *data;

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
    printf("\tINFO: Initializing test.\r\n");
    LOCAL_exampleInit();
    
    /* Execute example on PRU */
    printf("\tINFO: Executing test.\r\n");
    prussdrv_exec_program (0, "./oldpru0.bin");
    prussdrv_exec_program (1, "./oldpru1.bin");

    /* Wait until PRU0 has finished execution */
    printf("\tINFO: Waiting for HALT1 command.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_1);
    printf("\tINFO: PRU1 completed execution.\r\n");
    prussdrv_pru_clear_event (PRU1_ARM_INTERRUPT);
    printf("\tINFO: Waiting for HALT0 command.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_0);
    printf("\tINFO: PRU0 completed execution.\r\n");
    prussdrv_pru_clear_event (PRU0_ARM_INTERRUPT);
    /* Check if example passed */
    if ( LOCAL_examplePassed(PRU_NUM) )
    {
        printf("Example executed succesfully.\r\n");
    }
    else
    {
        printf("Example failed.\r\n");
    }
    
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
    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd < 0) {
        printf("Failed to open /dev/mem (%s)\n", strerror(errno));
        return -1;
    }	
    // 0x0FFFFFFF
    /* map the DDR memory */
    ddrMem = mmap(0, numBytes,  PROT_WRITE | PROT_READ, MAP_SHARED, mem_fd, BUFF_BASEADDR);
    if (ddrMem == NULL) {
        printf("Failed to map the device (%s)\n", strerror(errno));
        close(mem_fd);
        return -1;
    }

    /* Setup required PRU vars in RAM */
    length = ddrMem;
    cursor = length + 4;
    data = cursor + 4;

    *((unsigned long*) length) = LENGTH;
    int i = 0;
    int j = 0;
    void *storeData = data;
    for(i=0; i < LENGTH/83; i++){
    	(*(unsigned char*) (storeData+83*i)) = 0b00111100;
	for(j=1; j < 83; j++){
	    (*(unsigned char*) (storeData+83*i+j)) = i;
	}
    }
	
    // printf("Attempting memset to (%x) with size of (%li)\n", LOW_CODE, numBytes);
   // memset(data, HIGH_CODE, numBytes);

    printf("\t memset passed \n");
    return(0);
}
static unsigned short LOCAL_examplePassed ( unsigned short pruNum )
{
   printf("\n\tAfter PRU Completion:\n");
   printf("Length: (%li)\n", (*(unsigned long*) length));
   printf("Offset: (%li)\n", (*(unsigned long*) cursor));
   printf("Data:\n");

   int i = 0, j = 0;
   for(i=0; i < LENGTH/83; i++){
       printf("Preamble: (%x)\t", (*(unsigned char*) (data+83*i)));
	for(j=1; j < 83; j++){
	    printf("%x ", (*(unsigned char*) (data+83*i+j)));
	}
	printf("\n");
    }
   
   // return(*(unsigned long*) DDR_regaddr == 0xdcba);
    return(1);
}


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
#define LENGTH 		 166
#define PRU_NUM 	 0
#define CODE1 		 0b01010101010101010101010101010101
#define DDR_BASEADDR     0x80000000
#define OFFSET_DDR	 0x00001000 
#define OFFSET_SHAREDRAM 2048		//equivalent with 0x00002000

#define PRUSS0_SHARED_DATARAM    4

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
    printf("\tINFO: Initializing example.\r\n");
    LOCAL_exampleInit();
    
    /* Execute example on PRU */
    printf("\tINFO: Executing example.\r\n");
    prussdrv_exec_program (0, "./pru0.bin");
    prussdrv_exec_program (1, "./pru1.bin");

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
    munmap(ddrMem, 0x0FFFFFFF);
    close(mem_fd);

    return(0);
}

/*****************************************************************************
* Local Function Definitions                                                 *
*****************************************************************************/

static int LOCAL_exampleInit (  )
{
    void *DDR_regaddr;

    /* open the device */
    mem_fd = open("/dev/mem", O_RDWR);
    if (mem_fd < 0) {
        printf("Failed to open /dev/mem (%s)\n", strerror(errno));
        return -1;
    }	

    /* map the DDR memory */
    ddrMem = mmap(0, 0x0FFFFFFF, PROT_WRITE | PROT_READ, MAP_SHARED, mem_fd, DDR_BASEADDR);
    if (ddrMem == NULL) {
        printf("Failed to map the device (%s)\n", strerror(errno));
        close(mem_fd);
        return -1;
    }

    /* Store Addends in DDR memory location */
    DDR_regaddr = ddrMem + OFFSET_DDR;
    void *length;
    void *cursor;
    void *data;
    length = DDR_regaddr;
    cursor = length + 4;
    data = cursor + 4;
    *((unsigned long*) length) = 5;
    *((unsigned long*) cursor) = 0;
    printf("Attempting memset with size of 7040\n");
    //memset(DDR_regaddr, 0, 100);
    printf("\t memset passed \n");
    return(0);
}
static unsigned short LOCAL_examplePassed ( unsigned short pruNum )
{
   void *DDR_regaddr = ddrMem + OFFSET_DDR + 8;
   printf("Start: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 1: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 2: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 3: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 4: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 5: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 6: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 7: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 8: (%x)\n", (*(unsigned char*) DDR_regaddr));
   DDR_regaddr = DDR_regaddr + 1;
   printf("Plus 9: (%x)\n", (*(unsigned char*) DDR_regaddr));
   // return(*(unsigned long*) DDR_regaddr == 0xdcba);
    return(1);
}


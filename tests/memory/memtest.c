/*****************************************************************************
* Include Files                                                              *
*****************************************************************************/

#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

// Driver header file
#include <prussdrv.h>
#include <pruss_intc_mapping.h>

/*****************************************************************************
* Explicit External Declarations                                             *
*****************************************************************************/


/*****************************************************************************
* Local Macro Declarations                                                   *
*****************************************************************************/

#define PRU_NUM         0
#define CODE0      0xdbca
#define DDR_BASEADDR 0x80000000
#define OFFSET_DDR 0x00001000
#define OFFSET_SHAREDRAM 2048
#define AM33X
/*****************************************************************************
* Local Typedef Declarations                                                 *
*****************************************************************************/


/*****************************************************************************
* Local Function Declarations                                                *
*****************************************************************************/

static int LOCAL_exampleInit ( unsigned short pruNum );
static unsigned short LOCAL_examplePassed ( );

/*****************************************************************************
* Local Variable Definitions                                                 *
*****************************************************************************/


/*****************************************************************************
* Intertupt Service Routines                                                 *
*****************************************************************************/


/*****************************************************************************
* Global Variable Definitions                                                *
*****************************************************************************/

static int mem_fd;
static void *ddrMem, *sharedMem;
static unsigned int *sharedMem_int;
static void *pruDataMem;
static unsigned int *pruDataMem_int;

/*****************************************************************************
* Global Function Definitions                                                *
*****************************************************************************/

int main (void)
{
    unsigned int ret;
    tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;

    printf("\nINFO: Starting test.\r\n");
    /* Initialize the PRU */
    prussdrv_init ();

    /* Open PRU Interrupt */
    ret = prussdrv_open(PRU_EVTOUT_0);
    if (ret)
    {
        printf("prussdrv_open open failed\n");
        return (ret);
    }

    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);

    /* Initialize example */
 printf("\tINFO: Initializing example.\r\n");
    LOCAL_exampleInit(PRU_NUM);

    /* Execute example on PRU */
    printf("\tINFO: Executing example.\r\n");
    prussdrv_exec_program (PRU_NUM, "./prunewtest.bin");


    /* Wait until PRU0 has finished execution */
    printf("\tINFO: Waiting for HALT command.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_0);
    printf("\tINFO: PRU completed transfer.\r\n");
    prussdrv_pru_clear_event (PRU_EVTOUT_0);

    /* Check if example passed */
    if ( LOCAL_examplePassed() )
    {
        printf("INFO: Example executed succesfully.\r\n");
    }
    else
    {
        printf("INFO: Example failed.\r\n");
    }

    /* Disable PRU and close memory mapping*/
    prussdrv_pru_disable (0);
    prussdrv_pru_disable (1);
    prussdrv_exit ();
    munmap(ddrMem, 0x0FFFFFFF);
    close(mem_fd);

    return(0);

}

/*****************************************************************************
* Local Function Definitions                                                 *
*****************************************************************************/

static int LOCAL_exampleInit (unsigned short pruNum) {
    void *DDR_regaddr1;
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
    DDR_regaddr1 = ddrMem + OFFSET_DDR;
    *(unsigned long*) DDR_regaddr1 = CODE0;

     //Initialize pointer to PRU data memory
    if (pruNum == 0)
    {
      prussdrv_map_prumem (PRUSS0_PRU0_DATARAM, &pruDataMem);
    }
    else if (pruNum == 1)
    {
      prussdrv_map_prumem (PRUSS0_PRU1_DATARAM, &pruDataMem);
    }

    pruDataMem_int = (unsigned int*) pruDataMem;

    // Flush the values in the PRU data memory location
    pruDataMem_int[1] = 0x00;

    return(0);
}

static unsigned short LOCAL_examplePassed ( ) {
    unsigned int result_0;
     /* Allocate Shared PRU memory. */
    prussdrv_map_prumem(PRUSS0_SHARED_DATARAM, &sharedMem);
    sharedMem_int = (unsigned int*) sharedMem;
    result_0 = sharedMem_int[OFFSET_SHAREDRAM];

    return (result_0 == CODE0 & pruDataMem_int[1] ==  0xabcd);
}



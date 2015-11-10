******************************************************************************
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

/******************************************************************************
* Local Typedef Declarations                                                  *
******************************************************************************/


/******************************************************************************
* Local Function Declarations                                                 *
******************************************************************************/


/******************************************************************************
* Local Variable Definitions                                                  *
******************************************************************************/


/******************************************************************************
* Intertupt Service Routines                                                  *
******************************************************************************/


/******************************************************************************
* Global Variable Definitions                                                 *
******************************************************************************/


/******************************************************************************
* Global Function Definitions                                                 *
******************************************************************************/

int main (void)
{
    unsigned int ret0;
    unsigned int ret1;
    tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;

    printf("\nINFO: Starting %s example.\r\n", "PRU0-1TEST");
    /* Initialize the PRU */
    prussdrv_init ();

    /* Open PRU Interrupt */
    ret0 = prussdrv_open(PRU_EVTOUT_0);
    if (ret0)
    {
        printf("prussdrv_open open failed\n");
		        return (ret0);
    }
    ret1 = prussdrv_open(PRU_EVTOUT_1);
    if (ret1)
    {
        printf("prussdrv_open open failed\n");
        return (ret1);
    }
    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);

    /* Execute example on PRU */
    printf("\tINFO: Executing example.\r\n");
    prussdrv_exec_program (0, "./pru0test.bin");
    prussdrv_exec_program (1, "./pru1test.bin");
    /* Wait until PRU0 has finished execution */
    printf("\tINFO: Waiting for HALT0 command.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_0);
    printf("\tINFO: PRU0 completed test.\r\n");
    prussdrv_pru_clear_event (PRU_EVTOUT_0);

    printf("\tINFO: Waiting for HALT1 command.\r\n");
    prussdrv_pru_wait_event (PRU_EVTOUT_1);
    printf("\tINFO: PRU1 completed test.\r\n");
    prussdrv_pru_clear_event (PRU_EVTOUT_1);

   /* Disable PRUs and close memory mapping*/
    prussdrv_pru_disable(0);
    prussdrv_pru_disable(1);
    prussdrv_exit ();

    return(0);
}










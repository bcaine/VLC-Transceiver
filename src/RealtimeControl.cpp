/* Implementations of RealtimeControl.hpp
   This should control initialization/data sharing with the PRU

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "RealtimeControl.hpp"


void RealtimeControl::InitPRU() {

  unsigned int ret0, ret1;
  tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;
    
  printf("\nINFO: Starting %s example.\r\n", "Waves are for squares");
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
}

void RealtimeControl::Run() {
  prussdrv_exec_program (0, "./tx-pru0.bin");
  prussdrv_exec_program (1, "./tx-pru1.bin");

  // Blocks until done
  Done();
}


void RealtimeControl::Done() {

  /* Wait until PRU0 has finished execution */
  printf("\tINFO: Waiting for HALT1 command.\r\n");
  prussdrv_pru_wait_event (PRU_EVTOUT_1);
  printf("\tINFO: PRU1 completed execution.\r\n");
  prussdrv_pru_clear_event (PRU1_ARM_INTERRUPT);
  printf("\tINFO: Waiting for HALT0 command.\r\n");
  prussdrv_pru_wait_event (PRU_EVTOUT_0);
  printf("\tINFO: PRU0 completed execution.\r\n");
  prussdrv_pru_clear_event (PRU0_ARM_INTERRUPT);
}

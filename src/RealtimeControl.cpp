/* Implementations of RealtimeControl.hpp
   This should control initialization/data sharing with the PRU

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "RealtimeControl.hpp"
#include <iostream>
using namespace std;

bool RealtimeControl::InitPRU() {

  // Initialize the PRU //
  unsigned int ret0, ret1;
  tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;

  printf("Initializing the PRU");
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

  // If we made it this far, return true
  return true;
}


void RealtimeControl::Transmit() {
  printf("Executing the TX code on the PRUs\n");
  //prussdrv_exec_program (0, "./asm/Transmitter/tx-pru0.bin");
  // prussdrv_exec_program (1, "./asm/Transmitter/tx-pru1.bin");
  prussdrv_exec_program (0, "./prutest.bin");

  // Blocks until done
  DisablePRU();
}


void RealtimeControl::DisablePRU() {

  /* Wait until PRU0 has finished execution */
  /*
  printf("\tINFO: Waiting for HALT1 command.\r\n");
  prussdrv_pru_wait_event (PRU_EVTOUT_1);
  printf("\tINFO: PRU1 completed execution.\r\n");
  prussdrv_pru_clear_event (PRU1_ARM_INTERRUPT);
  */
  printf("\tINFO: Waiting for HALT0 command.\r\n");
  prussdrv_pru_wait_event (PRU_EVTOUT_0);
  printf("\tINFO: PRU0 completed execution.\r\n");
  prussdrv_pru_clear_event (PRU0_ARM_INTERRUPT);

  prussdrv_pru_disable(0);
  // prussdrv_pru_disable(1);
  prussdrv_exit();
}


bool RealtimeControl::OpenMem() {
  // Start up Memory
  mem_fd = open("/dev/mem", O_RDWR);

  if (mem_fd < 0) {
    printf("Failed to open /dev/mem (%s)\n", strerror(errno));
    return false;
  }
  
  /* map the DDR memory */
  ddrMem = mmap(0, 0x0FFFFFFF, PROT_WRITE | PROT_READ, MAP_SHARED, 
		mem_fd, DDR_BASEADDR);

  if (ddrMem == NULL) {
    printf("Failed to map the device (%s)\n", strerror(errno));
    close(mem_fd);
    return false;
  }

  data = ddrMem + OFFSET_DDR;

  return true;
}


void RealtimeControl::CloseMem() {
  close(mem_fd);
  munmap(ddrMem, 0x0FFFFFFF);
}

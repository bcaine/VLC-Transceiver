/* Module to control PRU (Programmable Realtime Unit) for the Beaglebone Black.

   This should handle initializing the PRUs two units to do data transfer
   and modulation. 
   
   Author: Ben Caine
   Date: October 17, 2015
*/
#ifndef REALTIME_HPP
#define REALTIME_HPP

#include "prussdrv.h"
#include <pruss_intc_mapping.h>	 

#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <cstdlib>
#include <cstring>
#include <sys/mman.h>
#include "Util.hpp"

#define DDR_BASEADDR     0x80000000
#define OFFSET_DDR	 0x00001000

class RealtimeControl {

public:

  bool InitPRU();
  void DisablePRU();
  void Transmit();
  bool OpenMem();
  void CloseMem();

  int mem_fd;
  void *ddrMem;

  void *data;
};

#endif // REALTIME_HPP

/* Module to control PRU (Programmable Realtime Unit) for the Beaglebone Black.

   This should handle initializing the PRUs two units to do data transfer
   and modulation. Additionally, it should manage the buffer we point
   the PRU to for access to our encoded/decoded data.
   
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

#define DDR_BASEADDR     0x80000000
#define OFFSET_DDR	 0x00001000

class RealtimeControl {

public:
  void Done();
  void InitPRU();
  void Run();
};

#endif // REALTIME_HPP

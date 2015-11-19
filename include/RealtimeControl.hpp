/* Module to control PRU (Programmable Realtime Unit) for the Beaglebone Black.

   This should handle initializing the PRUs two units to do data transfer
   and modulation. Additionally, it should manage the buffer we point
   the PRU to for access to our encoded/decoded data.
   
   Author: Ben Caine
   Date: October 17, 2015
*/
#ifndef REALTIME_HPP
#define REALTIME_HPP


class RealtimeControl {

public:
  // TODO: This will need location info, 
  RealtimeControl();
  ~RealtimeControl();

  bool Done();

private:
  bool InitPRU();
};

#endif // REALTIME_HPP

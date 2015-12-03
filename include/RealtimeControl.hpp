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
#include <stdint.h>
#include <iostream>

#define DDR_BASEADDR     0x90000000

// Encoded Packet = Preamble + Encoded Packet Data
const int ENCODED_PACKET_SIZE = 83;
const int PREAMBLE_LEN = 2;
// Data length without preamble we push or pull from memory
const int ENCODED_DATA_SIZE = ENCODED_PACKET_SIZE - PREAMBLE_LEN;
// Packet size before/after encoding
const int DECODED_PACKET_SIZE = 42;
// Decoded data len = packet size - 2 bytes for length
const int DECODED_DATA_SIZE = DECODED_PACKET_SIZE - 2;



using namespace std;

class RealtimeControl {

public:

  bool InitPru();
  void MarkPruDone();
  void DisablePru();
  void Transmit();
  void Receive();
  void Test();
  
  
  /* Memory Related Functionality */
  bool OpenMem();
  void CloseMem();
  void pop(uint8_t bytes[]);
  void push(uint8_t bytes[]);

  void setLength(int n) { *(_length) = n; }
  uint32_t getLength() { return *_length; }

  // Returns pointer to current location of queue
  uint8_t* peek() { return (uint8_t*)_data + _internal_cursor; }

  uint8_t* data() { return (uint8_t*)_data; }
  void setCursor(uint32_t val) { _internal_cursor = val; }
  
  uint32_t pruCursor() { return *_pru_cursor - 8; }
  uint32_t internalCursor() { return _internal_cursor; }

  uint32_t max_bytes;
  uint32_t max_packets;

private:
  int mem_fd;
  void *ddrMem;

  // four bytes for length
  uint32_t* _length;
  // Four bytes for PRU cursor
  // VALUE IN BYTES
  uint32_t* _pru_cursor;
  // Rest is data
  void* _data;


  // Internal cursor controls knowing where we are writing
  // or reading data coming from encoding or going towards
  // decoding.
  // VALUE IN BYTES
  uint32_t _internal_cursor;

};

#endif // REALTIME_HPP

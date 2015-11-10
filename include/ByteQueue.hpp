/*
  ByteQueue is a non-standard queue that stores a fixed number of
  bytes (unsigned chars). When it reaches the end, it loops back up
  to the top and starts overwriting old data.

  Our system will pull 100 bytes at a time (one packet).

  We assume we have a shared pointer to an int value for 
  the cursor from the Realtime unit.
*/
#ifndef BYTEQUEUE_HPP
#define BYTEQUEUE_HPP

#include <stdint.h>
#include <cstring>
#include <assert.h>

class ByteQueue {

public:

  ByteQueue(uint32_t* pru_cursor, int max_bytes);

  // Returns pointer to current location of queue and moves cursor
  // Assumes you want 100 bytes at a time
  // NOTE: Pop is receiver specific
  unsigned char* pop();
  // Adds data to the queue
  // NOTE: Push is transmitter specific
  void push(unsigned char* bytes, int len);

  // Returns pointer to current location of queue
  unsigned char* peak() { return _data + (*_internal_cursor * 8); }
  
private:
  int _max_bytes;
  
  // NOTE: Cursors measure location in bytes.
  //       They should always be divisible by 100
  
  // Internal cursor controls knowing where we are writing
  // or reading data coming from encoding or going towards
  // decoding.
  uint32_t* _internal_cursor;
  // PRU cursor tells us where the PRU is reading from.
  uint32_t* _pru_cursor;

  unsigned char* _data;

};

#endif // BYTEQUEUE_HPP

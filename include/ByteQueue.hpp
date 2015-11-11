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
#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>


class ByteQueue {

public:

  ByteQueue(int max_bytes);

  // Returns pointer to current location of queue and moves cursor
  // Assumes you want 100 bytes at a time
  // NOTE: Pop is receiver specific
  void* pop();
  // Adds data to the queue
  // NOTE: Push is transmitter specific
  void push(unsigned char* bytes, int len);
  void* dataLocation() { return _data; }

  // Returns pointer to current location of queue
  void* peak() { return _data + (_internal_cursor * 8); }
  
private:
  int _max_bytes;
  
  // Internal cursor controls knowing where we are writing
  // or reading data coming from encoding or going towards
  // decoding.
  int _internal_cursor;
  // One byte for done
  void* _done;
  // Four bytes for PRU location
  void* _pru_location;
  // The rest is data
  void* _data;
  int _mem_fd;

};

#endif // BYTEQUEUE_HPP

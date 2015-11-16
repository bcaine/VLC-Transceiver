#include "ByteQueue.hpp"
#include <iostream>

using namespace std;

ByteQueue::ByteQueue(uint32_t max_bytes) {
    assert(max_bytes % 88 == 0);
    // Size params
    _max_bytes = max_bytes;

    // Set up cursors
    // TODO: PRU Cursor is just first 4 bytes of buffer
    // Make functions to access
    
    // Initialize cursor values
    _internal_cursor = 5;

    _mem_fd = open("/dev/mem", O_RDWR);
    if (_mem_fd < 0) {
        printf("Failed to open /dev/mem (%s)\n", strerror(errno));
        return;
    }	
    // Create data block
    _done = mmap(0, max_bytes + 5, PROT_WRITE | PROT_READ,
		 MAP_SHARED, _mem_fd, 0);

    _pru_cursor = (uint8_t*)_done + 1;
    _data = (uint8_t*)_pru_cursor + 4;

    *((unsigned char*)_done) = 0;
    *((uint32_t*)_pru_cursor) = 0;

    // Set all values in this memory to 0
    memset(_data, 0, max_bytes);
    

}

// Pops 1 encoded packet at a time
// We pop 87 bytes, which is actually 86.25 bytes
// AKA 690 bits.
void ByteQueue::pop(uint8_t* packet) {
  // Expect packet array length to be 92

  uint8_t* addr = peek();
  // Remove preamble 
  memcpy(packet, (addr + 1), 87);

  // TODO: We need the PRU to keep track of where BBB is reading
  _internal_cursor += 88;
  _internal_cursor %= _max_bytes;
}

// Always expect 87 Bytes (86.25 actual in packet)
void ByteQueue::push(uint8_t* packet) {

  *peek() = 0xFF;
  memcpy((peek() + 1), packet, 87);

  
  // TODO: Check where the PRU is before writing
  _internal_cursor += 88;
  _internal_cursor %= _max_bytes;
  cout << "Push done" << endl;
}

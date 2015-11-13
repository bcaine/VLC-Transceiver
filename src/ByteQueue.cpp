#include "ByteQueue.hpp"
#include <iostream>

ByteQueue::ByteQueue(int max_bytes) {
    assert(max_bytes % 100 == 0);
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
}

// Pops 100 bytes at a time
void* ByteQueue::pop() {
  // Get addr of current queue before incrementing
  void *addr = peek();

  // TODO: We need the PRU to keep track of where BBB is reading
  _internal_cursor += 100;
  _internal_cursor %= _max_bytes;

  return addr;
}

void ByteQueue::push(unsigned char* bytes, int len) {
  // Get the current loc with peak, and save data to it
  std::memcpy(peek(), bytes, len);

  // TODO: Check where the PRU is before writing
  _internal_cursor += 100;
  _internal_cursor %= _max_bytes;
}

unsigned char* packetize(unsigned char* bytes, int len) {
  /* We want the packet to be 100 bytes long:
     Preamble: 12 bits
     Length: 6 bits
     Data: 782 bits
  */
  
  unsigned char* packets = new unsigned char[100];

  return packets;
}

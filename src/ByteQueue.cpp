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
    _pru_location = _done + 1;
    _data = _pru_location + 4;
}

// Pops 100 bytes at a time
void* ByteQueue::pop() {
  // Get addr of current queue before incrementing
  void *addr = peak();

  // TODO: We need the PRU to keep track of where BBB is reading
  _internal_cursor += 100;
  _internal_cursor %= _max_bytes;

  return addr;
}

void ByteQueue::push(unsigned char* bytes, int len) {
  // Get the current loc with peak, and save data to it
  std::memcpy(peak(), bytes, len);

  // TODO: Check where the PRU is before writing
  _internal_cursor += 100;
  _internal_cursor %= _max_bytes;
}

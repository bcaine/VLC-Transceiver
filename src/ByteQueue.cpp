#include "ByteQueue.hpp"


ByteQueue::ByteQueue(uint32_t* pru_cursor, int max_bytes) {
    assert(max_bytes % 100 == 0);
    // Size params
    _max_bytes = max_bytes;

    // Set up cursors
    _internal_cursor = new uint32_t;
    _pru_cursor = pru_cursor;

    // Initialize cursor values
    *_internal_cursor = 0;
    *_pru_cursor = 0;

    // Create data block
    _data = new unsigned char[max_bytes];
}

// Pops 100 bytes at a time
unsigned char* ByteQueue::pop() {
  // Get addr of current queue before incrementing
  unsigned char *addr = peak();

  // TODO: We need the PRU to keep track of where BBB is reading
  *_internal_cursor += 100;
  *_internal_cursor %= _max_bytes;

  return addr;
}

void ByteQueue::push(unsigned char* bytes, int len) {
  // Get the current loc with peak, and save data to it
  std::memcpy(peak(), bytes, len);

  // TODO: Check where the PRU is before writing
  *_internal_cursor += 100;
  *_internal_cursor %= _max_bytes;
}

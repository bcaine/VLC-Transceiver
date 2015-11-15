#include "ByteQueue.hpp"
#include <iostream>

using namespace std;

ByteQueue::ByteQueue(uint32_t max_bytes) {
    assert(max_bytes % 95 == 0);
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

// Pops 1 packet at a time
uint16_t ByteQueue::pop(uint8_t* packet) {
  // Expect packet array length to be 92

  uint8_t* addr = peek();
  uint16_t bitlen = *(uint16_t*)(addr + 1);
  memcpy(packet, (addr + 3), 92);

  // TODO: We need the PRU to keep track of where BBB is reading
  _internal_cursor += 95;
  _internal_cursor %= _max_bytes;

  return bitlen;
}

void ByteQueue::push(uint8_t* bytes, uint16_t bitlen) {
    /* We want the packet to be 100 bytes long:
     Preamble: 8 bits
     Length: 16 bits
     Data: 736 bits
  */
  uint8_t* packet = new uint8_t[100];

  int num_packets = (bitlen / 736) + 1;

  for(int n = 0; n < num_packets; n++) {
    // Set preamble
    packet[0] = 0xFF;

    *(uint16_t*)(packet + 1) = bitlen;

    for(int i = 0; i < 736; i++)
      setBit(packet, 24 + i, getBit(bytes, i + ((n-1) * 736)));

      // Get the current loc with peak, and save data to it
    memcpy(peek(), packet, 95);
  
    // TODO: Check where the PRU is before writing
    _internal_cursor += 95;
    _internal_cursor %= _max_bytes;
  }
  cout << "Push done" << endl;

  delete[] packet;
}

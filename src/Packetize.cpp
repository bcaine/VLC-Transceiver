#include "Packetize.hpp"
#include <iostream>

const int MAX_BYTES = 40;
const int MAX_BITS = 8 * MAX_BYTES;

// Should pass in 40 Bytes and we will return 42 bytes
void packetize(uint8_t* data_in, uint8_t* packet, uint16_t bitlen)
{
  assert(bitlen <= MAX_BITS);
  // If length is max, set it to all 1s
  if (bitlen == MAX_BITS)
    *(uint16_t*)(packet) = 0xFFFF;
  else
    // Set length to be first two bytes
    *(uint16_t*)(packet) = bitlen;

  // Fill in packet with data + padding
  // For each bit less than 40 * 8, pack it with 1s
  for (int i = bitlen + 16; i < MAX_BITS; i++)
    setBit(packet, i, 1);

  std::memcpy((packet + 2), data_in, MAX_BYTES);
}

// Pass in 42 bytes and we will return the size and 40 bytes
uint16_t depacketize(uint8_t* packet, uint8_t* data_out)
{
  uint16_t bitlen = *(uint16_t*)(packet);

  // If bitlen > MAX_BITS, its probably an
  // uncorrectable error farther up the pipeline...
  // Unfortunately, the only thing we can do
  // is set the length to the max bits and hope
  // that it was a full packet.

  bitlen = bitlen > MAX_BITS ? MAX_BITS : bitlen;
  
  std::memcpy(data_out, (packet + 2), MAX_BYTES);

  return bitlen;
}

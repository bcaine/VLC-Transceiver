#include "Packetize.hpp"

const int MAX_BYTES = 43;
const int MAX_BITS = 8 * MAX_BYTES;

// Should pass in 43 Bytes and we will return 45 bytes
void packetize(uint8_t* data_in, uint8_t* packet, uint16_t bitlen)
{
  assert(bitlen <= MAX_BITS);
  // Set length to be first two bytes
  *(uint16_t*)(packet) = bitlen;

  // Fill in packet with data + padding
  // For each bit less than 43 * 8, pack it with 1s
  for (int i = bitlen + 16; i < MAX_BITS; i++)
    setBit(packet, i, 1);

  std::memcpy((packet + 2), data_in, MAX_BYTES);
}

// Pass in 45 bytes and we will return the size and 43 bytes
uint16_t depacketize(uint8_t* packet, uint8_t* data_out)
{
  uint16_t bitlen = *(uint16_t*)(packet);
  assert(bitlen <= MAX_BITS);
  std::memcpy(data_out, (packet + 2), MAX_BYTES);

  return bitlen;
}

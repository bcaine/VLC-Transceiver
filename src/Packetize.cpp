#include "Packetize.hpp"

// Should pass in 43 Bytes and we will return 45 bytes
void packetize(uint8_t* data_in, uint8_t* packet, uint16_t bitlen)
{
  assert(bitlen <= (8 * 43));
  // Set length to be first two bytes
  *(uint16_t*)(packet) = bitlen;

  // Fill in packet with data + padding
  // For each bit less than 43 * 8, pack it with 1s
  for (int i = bitlen; i < 43 * 8; i++)
    setBit(packet, i, 1);
  
  std::memcpy((packet + 2), data_in, 43);
}

// Pass in 45 bytes and we will return the size and 43 bytes
uint16_t depacketize(uint8_t* packet, uint8_t* data_out)
{
  uint16_t bitlen = *(uint16_t*)(packet);
  assert(bitlen <= (8 * 43));
  std::memcpy(data_out, (packet + 2), 43);

  return bitlen;
}

#include "Packetize.hpp"

// Should pass in 43 Bytes and we will return 45 bytes
void packetize(uint8_t* data_in, uint8_t* packet, uint16_t bitlen)
{
  assert(bitlen <= (8 * 43));
  // Set length to be first two bytes
  *(uint16_t*)(packet) = bitlen;
  // Copy memory
  int copy_len = bitlen / 8;
  // If its not cleanly divisible, add an extra byte
  copy_len += (bitlen % 8 == 0) ? 0 : 1;
  
  std::memcpy((packet + 2), data_in, copy_len);
}

// Pass in 45 bytes and we will return the size and 43 bytes
uint16_t depacketize(uint8_t* packet, uint8_t* data_out)
{
  uint16_t bitlen = *(uint16_t*)(packet);

  assert(bitlen <= (8 * 43));

  int copy_len = bitlen / 8;
  // If its not cleanly divisible, add an extra byte
  copy_len += (bitlen % 8 == 0) ? 0 : 1;
  
  std::memcpy(data_out, (packet + 2), copy_len);

  return bitlen;
}

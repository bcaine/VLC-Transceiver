#ifndef PACKETIZE_HPP
#define PACKETIZE_HPP

#include <stdint.h>
#include <assert.h>
#include <cstring>

void packetize(uint8_t* data_in, uint8_t* data_out,
	       uint16_t bitlen);
uint16_t depacketize(uint8_t* data_in, uint8_t* data_out);

#endif // PACKETIZE_HPP

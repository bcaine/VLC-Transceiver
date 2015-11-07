/* Implementations of ForwardErrorCorrection.hpp
   This should do decoding/encoding of data.

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "ForwardErrorCorrection.hpp"
#include <iostream>
#include <exception>

using namespace std;

// data: bytes of binary data we are encoding; data_length: number of bytes
unsigned char* ForwardErrorCorrection::Encode(unsigned char *data, int len) {
  
  // Make sure data size is correct
  int num_bits = len * 8;
  assert(num_bits % 12 == 0);
  
  // Then we know we have blocks 
  int blockcount = num_bits / 12;

  // Our output is the number of blocks * 2
  // Because we take in 12 bits and output 24 bit
  // blocks
  unsigned char encoded[blockcount * 2];

  bool first = true;
  int idx;
  // Go 12 bits at a time (each input length)
  for (int i = 0; i < num_bits; i+= 12) {
    // We need to use 12 and 24 bits.
    // So we need to access every 12 bits, which
    // corresponds with byte i / 12...
    // Output is simply every 3 bytes,
    // So that is 12 / 4
    golayEncode(data[i / 12], encoded[i / 4], first);
    first = !first;
  }

  return encoded;
}


// encoded: bytes of binary data we are encoding; data_length: number of bytes
unsigned char* ForwardErrorCorrection::Decode(unsigned char *encoded, int len) {
  // Make sure data size is correct
  int num_bits = len * 8;
  int num_bits_out = num_bits / 2;
  assert(num_bits % 24 == 0);
  
  // Then we know we have blocks 
  int blockcount = num_bits / 24;

  // Our output is the number of blocks / 2
  // Because we take in 24 bits and output 12
  unsigned char data[blockcount / 2];

  bool first = true;
  int idx;
  // Send in 24 bits each time, get back 12
  for (int i = 0; i < num_bits_out; i+= 12) {
    golayDecode(encoded[i/4], data[i / 12], first);
    first = !first;
  }

  return data;
}

/* Implementations of ForwardErrorCorrection.hpp
   This should do decoding/encoding of data.

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "ForwardErrorCorrection.hpp"
#include <iostream>
#include <exception>

using namespace std;

/*
INPUTS:
data: bytes of binary data we are encoding
len: number of bytes of data we are encoding
OUTPUT: 
encoded: bytes of encoded data
*/
void ForwardErrorCorrection::Encode(unsigned char *data, unsigned char *encoded, int len) {
  // TODO: Make sure len(encoded) == blockcount * 2

  // Make sure data size is correct
  int num_bits = len * 8;
  assert(num_bits % 12 == 0);
  
  bool first = true;
  // Go 12 bits at a time (each input length)
  for (int i = 0; i < num_bits; i+= 12) {
    // We need to use 12 and 24 bits.
    // So we need to access every 12 bits, which
    // corresponds with byte i / 12...
    // Output is simply every 3 bytes,
    // So that is 12 / 4
    golayEncode(&data[i / 12], &encoded[i / 4], first);
    first = !first;
  }
}


/*
INPUTS:
encoded: bytes of binary data we are encoding
len: Number of bytes of encoded
OUTPUTS:
data: bytes of our decoded data
*/
void ForwardErrorCorrection::Decode(unsigned char *encoded, unsigned char* data, int len) {
  // TODO: Make sure len(data) == block_count / 2
  
  // Make sure data size is correct
  int num_bits = len * 8;
  int num_bits_out = num_bits / 2;
  assert(num_bits % 24 == 0);
  
  bool first = true;
  // Send in 24 bits each time, get back 12
  for (int i = 0; i < num_bits_out; i+= 12) {
    golayDecode(&encoded[i/4], &data[i / 12], first);
    first = !first;
  }
}

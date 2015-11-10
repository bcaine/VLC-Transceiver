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
  
  // Go 12 bits at a time (each input length)
  int i = 0, j = 0;
  while (i < num_bits) {
    golayEncode(data, encoded, i, j);
    i += 12;
    j += 23;
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
  // assert(num_bits % 23 == 0);

  int i = 0, j = 0;
  while (i < num_bits) {
    golayDecode(encoded, data, i, j);
    i += 23;
    j += 12;
  }
}

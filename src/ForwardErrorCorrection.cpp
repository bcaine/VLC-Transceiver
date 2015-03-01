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
void ForwardErrorCorrection::Encode(unsigned char *data,
				    unsigned char *encoded,
				    int len)
{
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
void ForwardErrorCorrection::Decode(unsigned char *encoded,
				    unsigned char *data,
				    int len)
{
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

void ForwardErrorCorrection::ManchesterEncode(
		      unsigned char *data_in,
		      unsigned char *data_out,
		      int in_len,
		      int out_len)
{
  assert((in_len * 2) == out_len);
  int num_bits = in_len * 8;

  int out = 0;
  for(int in = 0; in < num_bits; in++) {
    if (getBit(data_in, in) == 0) {
      setBit(data_out, out, 0);
      setBit(data_out, out + 1, 1);
    } else {
      setBit(data_out, out, 1);
      setBit(data_out, out + 1, 0);
    }
    out += 2;
  }
}

void ForwardErrorCorrection::ManchesterDecode(
		      unsigned char *data_in,
		      unsigned char *data_out,
		      int in_len,
		      int out_len)
{
  assert((in_len / 2) == out_len);
  int num_bits = out_len * 8;

  int in = 0;
  for(int out = 0; out < num_bits; out++) {
    if ((getBit(data_in, in) == 0) &&
	(getBit(data_in, in+1) == 1))
    {
      setBit(data_out, out, 0);
    } else {
      setBit(data_out, out, 1);
    }
    in += 2;
  }
}

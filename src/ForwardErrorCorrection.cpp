/* Implementations of ForwardErrorCorrection.hpp
   This should do decoding/encoding of data.

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "ForwardErrorCorrection.hpp"
#include <iostream>
#include <exception>

using namespace std;

// This code was created using the following as a reference:
// https://github.com/catid/longhair/README.md
unsigned char* ForwardErrorCorrection::Encode(unsigned char *data, int data_length) {
  // Check that the length of our data is the same as we expect
  // with _k * _bytes length
  cout<<"Data Length: " << data_length << endl;
  
  assert(data_length == _k * _bytes);

  unsigned char *recovery_blocks = new unsigned char[_m * _bytes];
  const unsigned char *data_ptrs[_k];

  // Get a pointer to the start of each block
  for (int i = 0; i < _k; ++i) {
    data_ptrs[i] = data + i * _bytes;
  }

  if (cauchy_256_encode(_k, _m, data_ptrs, recovery_blocks, _bytes)) {
    throw runtime_error("Encoding Error");
  }

  return recovery_blocks;
}

unsigned char* ForwardErrorCorrection::Decode(unsigned char *data) {
  Block *block_info = new Block[_k];

  if (cauchy_256_decode(_k, _m, block_info, _bytes)) {
      assert(_k + _m <= 256);
      assert(block_info != 0);
      assert(_bytes % 8 == 0);
      throw runtime_error("Decoding Error");
  }

  unsigned char *decoded_data = new unsigned char[_k * _bytes];

  // TODO: Currently causing seg fault. So fix that.
  // Also, can I use memcpy here instead?
  for (int ki = 0; ki < _k; ++ki) {
    for (int bi = 0; bi < _bytes; ++bi) {
      decoded_data[ki * bi] = block_info[ki].data[bi];
    }
  }

  return decoded_data;
}

bool ForwardErrorCorrection::RLLEncode(char *data) {
  return true;
}

bool ForwardErrorCorrection::RLLDecode(char *data) {
  return true;
}
  

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
  int data_size = _k * _bytes;
  int redundancy_size = _m * _bytes;
  
  assert(data_length == data_size);

  unsigned char *recovery_blocks = new unsigned char[redundancy_size];
  const unsigned char *data_ptrs[_k];

  // Get a pointer to the start of each block
  for (int i = 0; i < _k; ++i) {
    data_ptrs[i] = data + i * _bytes;
  }

  if (cauchy_256_encode(_k, _m, data_ptrs, recovery_blocks, _bytes)) {
    throw runtime_error("Encoding Error");
  }

  // Combine the data with the redundancy
  unsigned char* encoded_data = new unsigned char[data_size + redundancy_size];
  copy(data, data + data_size, encoded_data);
  copy(recovery_blocks, recovery_blocks + redundancy_size, encoded_data + data_size);

  // Recovery blocks no longer needed
  delete []recovery_blocks;

  return encoded_data;
}

unsigned char* ForwardErrorCorrection::Decode(unsigned char *data) {
  Block *block_info = new Block[_k + _m];

  for (int i = 0; i < _k + _m; ++i) {
    block_info[i].data = (unsigned char*) data + i * _bytes;
    block_info[i].row = (unsigned char)i;
  }

  if (cauchy_256_decode(_k, _m, block_info, _bytes)) {
      assert(_k + _m <= 256);
      assert(block_info != 0);
      assert(_bytes % 8 == 0);
      throw runtime_error("Decoding Error");
  }

  unsigned char *decoded_data = new unsigned char[_k * _bytes];

  for (int ki = 0; ki < _k; ++ki) {
    cout << ki << endl;
    cout << block_info[ki].data << endl;
    cout << "--------------" << endl;
  }

  return decoded_data;
}

bool ForwardErrorCorrection::RLLEncode(char *data) {
  return true;
}

bool ForwardErrorCorrection::RLLDecode(char *data) {
  return true;
}
  

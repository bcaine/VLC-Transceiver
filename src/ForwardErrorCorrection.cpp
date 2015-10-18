/* Implementations of ForwardErrorCorrection.hpp
   This should do decoding/encoding of data.

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "ForwardErrorCorrection.hpp"
#include <iostream>

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
    cout << "Encoding Failure" << endl;
    return false;
  }

  return recovery_blocks;
}

unsigned char* ForwardErrorCorrection::Decode(unsigned char *data, int data_length) {
  unsigned char* foo = new unsigned char[10];
  return foo;
}

bool ForwardErrorCorrection::RLLEncode(char *data) {
  return true;
}

bool ForwardErrorCorrection::RLLDecode(char *data) {
  return true;
}
  

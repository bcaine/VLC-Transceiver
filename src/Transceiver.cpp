/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"


// This code was created using: https://github.com/catid/longhair/README.md
// as a reference.
bool ForwardErrorCorrection::Encode(u8 *data) {

  // Check that the length of our data is the same as we expect
  // with _k * _bytes length
  int data_length = sizeof(data)/sizeof(data[0]);
  assert(data_length == _k * _bytes);

  char *recovery_blocks = new u8[_m * _bytes];
  char *data_ptrs[_k];

  // Get a pointer to the start of each block
  for (int i = 0; i < _k; ++i) {
    data_ptrs[i] = data + i * _bytes;
  }

  if (cauchy_256_encode(_k, _m, data_ptrs, recovery_blocks, _bytes)) {
    // Then decoding failed
    // Log a failure
    return false;
  }

  for (int i = 0; i < _m; ++i) {
    char *block = recovery_blocks + i * _bytes;
    unsigned char row = _k + i;
    // TODO: Store block data somewhere we can access it.
    // Either write to file, to a mem location the PRU has access to, etc.

    // TODO: Remove once working
    std::cout << "Block data: " << *block << std::endl;
    std::cout << "Row: " << row << std::endl;
  }

  delete []recovery_blocks;
}

bool ForwardErrorCorrection::Decode() {

}

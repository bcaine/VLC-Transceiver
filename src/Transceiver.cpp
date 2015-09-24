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
  int block_count = 2;
  int recovery_block_count = 1;

  // Data is of len = bytes * block_count
  // For example, with block_count = 2 and bytes = 1024, we are passed
  // u8 data[1024 * 2]
  
  u8 *recovery_blocks = new u8[recovery_block_count * _bytes];

  // TODO: What size do we actually need?
  const u8 *data_ptrs[block_count];

  for (int i = 0; i < block_count; ++i) {
    // Block or block bytes?
    data_ptrs[i] = data + i * _bytes;
  }

  // DO MORE STUFF

}

bool ForwardErrorCorrection::Decode() {

}

/* Encoding Library for Reed-Solomon based on Longhair implementation

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef FEC_HPP
#define FEC_HPP

#include "cauchy_256.h"

class ForwardErrorCorrection {
  int _k, _m;
  int _bytes;

public:
  ForwardErrorCorrection(int k, int m, int bytes) {
    // Check that the values are usable
    assert(bytes % 8 == 0);

    _k = k;
    _m = m;
    _bytes = bytes;
    
    if (cauchy_init()) {
      exit(1);
    }
  }

  ~ForwardErrorCorrection() {
    // Free up garbage/memory here
  }


  bool Encode(u8 *data);
  bool Decode(u8 *data);
};

/* Encoding Library for Reed-Solomon based on Longhair implementation

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef FEC_HPP
#define FEC_HPP

typedef unsigned u8;

#include "cauchy_256.h"
#include <assert.h>


class ForwardErrorCorrection {

public:
  ForwardErrorCorrection(int k, int m, int bytes) {
    // Check that the values are usable
    assert(bytes % 8 == 0);

    _k = k;
    _m = m;
    _bytes = bytes;
    
    if (cauchy_256_init()) {
      exit(1);
    }
  }

  ~ForwardErrorCorrection() {
    // Free up garbage/memory here
  }


  bool Encode(u8 *data);
  bool Decode(u8 *data);

private:
  int _k, _m;
  int _bytes;

  bool RLLEncode(u8 *data);
  bool RLLDecode(u8 *data);

};

#endif // FEC_HPP

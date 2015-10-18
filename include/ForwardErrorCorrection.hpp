/* Encoding Library for Reed-Solomon based on Longhair implementation

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef FEC_HPP
#define FEC_HPP

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


  unsigned char* Encode(unsigned char *data, int data_length);
  unsigned char* Decode(unsigned char *data, int data_length);

private:
  int _k, _m;
  int _bytes;

  bool RLLEncode(char *data);
  bool RLLDecode(char *data);

};

#endif // FEC_HPP

/* Encoding Library for Reed-Solomon based on Longhair implementation

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef FEC_HPP
#define FEC_HPP

#include <assert.h>
#include "golay.h"

class ForwardErrorCorrection {

public:
  unsigned char* Encode(unsigned char *data, int data_length);
  unsigned char* Decode(unsigned char *data, int data_length);

private:
  unsigned char* ManchesterEncode(unsigned char *data);
  unsigned char* ManchesterDecode(unsigned char *data);
};

#endif // FEC_HPP

/* Encoding Library for Reed-Solomon based on Golay(12, 24) Coding

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef FEC_HPP
#define FEC_HPP

#include <assert.h>
#include "Golay.hpp"

class ForwardErrorCorrection {

public:
  void Encode(unsigned char *data, unsigned char* encoded, int len);
  void Decode(unsigned char *encoded, unsigned char* data, int len);

private:
  unsigned char* ManchesterEncode(unsigned char *data);
  unsigned char* ManchesterDecode(unsigned char *data);
};

#endif // FEC_HPP

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

  void ManchesterEncode(unsigned char *data_in,
			unsigned char *data_out,
			int num_bits_in);
  void ManchesterDecode(unsigned char *data_in,
			unsigned char *data_out,
			int num_bits_out);
};

#endif // FEC_HPP

/* Encoding Library for Reed-Solomon based on Longhair implementation

   Author: Ben Caine
   Date: September 24, 2015
*/

#ifndef FEC_HPP
#define FEC_HPP

class ForwardErrorCorrection {
  int _k, _m;
  int _bytes;

public:
  ForwardErrorCorrection(int k, int m, int bytes) {
    _k = k;
    _m = m;
    _bytes = bytes;
  }

  ~ForwardErrorCorrection() {
    // Free up garbage/memory here
  }


  bool Encode();
  bool Decode();
};

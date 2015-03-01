#include "Golay.hpp"


// 12 bits in, 23 out
void golayEncode(unsigned char* in, unsigned char* out,
		 int start_in, int start_out)
{
  int i, idx;
  unsigned int w, q;

  w = 0;
  q = 0xC750;
  for (i=start_out+22; i >= start_out+11; i--)  {
    idx = i - start_out;
    if (getBit(in, start_in + idx - 11) == 1)
      w = w ^ q;
    if (w >= 0x8000)
      setBit(out, i, 1);
    else
      setBit(out, i, 0);
    w = (w << 1) & 0xFFFF;
  }
  
  for (i=start_out + 10; i>=start_out + 0; i--)  {
    if (w >= 0x8000)
      setBit(out, i, 1);
    else
      setBit(out, i, 0);
    w = (w << 1) & 0xFFFF;
  }

}

// 23 bits in, 12 out
int golayDecode(unsigned char* in, unsigned char* out,
		int start_in, int start_out)
{
  int i;
  unsigned int a, w, q, r;
  int error_count = 0;

  w = 0;
  q = 0xC750;
  for (i=start_in + 10; i>=start_in; i--) {
    w = w + w + getBit(in, i);
  }

  int idx;
  for (i=start_in + 22; i>=start_in + 11; i--) {
    idx = i - start_in;
    if (getBit(in, i) == 1) {
      w = w ^ pc[22-idx];
    }
  }
  
  a = ep[w];
  error_count = a & 0x000f;
  r = 0;
  
  for (i=start_in + 22; i>=start_in + 7; i--) {
    r = r + r + getBit(in, i);
  }
  
  r = r ^ a;

  for (i=start_out + 11; i>= start_out; i--)  {
    if (r >= 0x8000)  {
      r = r ^ q;
      setBit(out, i, 1);
    } else {
      setBit(out, i, 0);
    }
    r = r + r;
  }

  return error_count;
}

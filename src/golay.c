#include "golaytable.h"

typedef int bool;
#define true 1
#define false 0

int getBit(unsigned char* bytes, int location) {
  int loc = location % 8;
  int idx = location / 8;
  return (bytes[idx] & ( 1 << (7 - loc) )) >> (7 - loc);
}

void setBit(unsigned char* bytes, int location, int val) {
  int loc = location % 8;
  int idx = location / 8;
  bytes[idx] ^= (-val^ bytes[idx]) & (1 << (7 - loc));
}

// 2 bytes in (0-11 or 3-15), 3 bytes out. 
void golayEncode(unsigned char* in, unsigned char* out, bool first)
{
  int i, idx;
  unsigned int w, q;

  w = 0;
  q = 0xC750;
  for (i=22; i>=11; i--)  {
    // We want to start at bit 11 and work backwards
    // if we are doing 0-11 (indicated by first being
    // set). If first is not set, we start at 15 and
    // work towards 4
    idx = first ? i - 11 : i - 7;

    if (getBit(in, idx) == 1)
      w = w ^ q;
    if (w >= 0x8000)
      setBit(out, i, 1);
    else
      setBit(out, i, 0);
    w = (w << 1) & 0xFFFF;
  }
  
  for (i=10; i>=0; i--)  {
    if (w >= 0x8000)
      setBit(out, i, 1);
    else
      setBit(out, i, 0);
    w = (w << 1) & 0xFFFF;
  }
  
  int sum = 0;
  for (i = 0; i < 23; ++i) {
    sum += getBit(out, i);
  }
  
  // Add a checksum as last bit
  // Don't currently check this decoding.. But it may be
  // useful if we need it for some reason.
  // Mostly its just here to fill out the last bit in our 3 bytes
  setBit(out, 23, sum % 2);
}

// 24 bits (3 bytes in), 12 bits (1.5 bytes) out
int golayDecode(unsigned char* in, unsigned char* out, bool first)
{
  int i;
  unsigned int a, w, q, r;
  int error_count = 0;

  w = 0;
  q = 0xC750;
  for (i=10; i>=0; i--) {
    w = w + w + getBit(in, i);
  }
  
  for (i=22; i>=11; i--) {
    if (getBit(in, i) == 1)
      w = w ^ pc[22-i];
  }
  
  a = ep[w];
  error_count = a & 0x000f;
  r = 0;
  
  for (i=22; i>=7; i--) {
    r = r + r + getBit(in, i);
  }
  
  r = r ^ a;

  // If first == true, we save in bits 0-11,
  // otherwise we save in bits 4-15
  int idx = first ? 11 : 15;
  
  for (i=idx; i>= idx-11; i--)  {
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

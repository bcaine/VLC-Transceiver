#ifndef GOLAY_HPP
#define GOLAY_HPP

#include "golaytable.hpp"

int getBit(unsigned char* bytes, int location);
void setBit(unsigned char* bytes, int location, int val);

void golayEncode(unsigned char* in, unsigned char* out, bool first);
int golayDecode(unsigned char* in, unsigned char* out, bool first);

#endif // GOLAY_HPP

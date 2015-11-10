#ifndef GOLAY_HPP
#define GOLAY_HPP

#include "GolayTable.hpp"

int getBit(unsigned char* bytes, int location);
void setBit(unsigned char* bytes, int location, int val);

void golayEncode(unsigned char* in, unsigned char* out,
		 int start_in, int start_out);
int golayDecode(unsigned char* in, unsigned char* out,
		int start_in, int start_out);

#endif // GOLAY_HPP

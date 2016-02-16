#ifndef GOLAY_HPP
#define GOLAY_HPP

#include "GolayTable.hpp"
#include "Util.hpp"

void golayEncode(unsigned char* in, unsigned char* out,
                 int start_in, int start_out);
int golayDecode(unsigned char* in, unsigned char* out,
                int start_in, int start_out);

#endif // GOLAY_HPP

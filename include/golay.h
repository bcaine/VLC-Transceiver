#ifndef GOLAY_H
#define GOLAY_H

int getBit(unsigned char* bytes, int location);
int setBit(unsigned char* bytes, int location, int val);

void golayEncode(unsigned char* in, unsigned char* out, int first);
int golayDecode(unsigned char* in, unsigned char* out, int first);

#endif // GOLAY_H

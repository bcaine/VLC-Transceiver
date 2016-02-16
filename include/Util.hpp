#ifndef UTIL_HPP
#define UTIL_HPP

inline int getBit(unsigned char* bytes, int location) {
    int loc = location % 8;
    int idx = location / 8;
    return (bytes[idx] & ( 1 << (7 - loc) )) >> (7 - loc);
}

inline void setBit(unsigned char* bytes, int location, int val) {
    int loc = location % 8;
    int idx = location / 8;
    bytes[idx] ^= (-val^ bytes[idx]) & (1 << (7 - loc));
}

#endif // UTIL_HPP

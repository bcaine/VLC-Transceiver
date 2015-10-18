#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include<iostream>

using namespace std;

unsigned char* GenerateData(int k, int bytes) {
  unsigned char *data = new unsigned char[k * bytes];

  // Generate Alphabet over and over
  for (int i = 0; i < k * bytes; i++) {
    data[i] = char((i % 26) + 97);
  }
  
  return data;
}


void TestFEC() {
  int k = 64;
  int m = 32;
  int bytes = 1000;
  unsigned char *data = GenerateData(k, bytes);
  // k = 64, m = 32, bytes = 1000
  ForwardErrorCorrection fec(k, m, bytes);
  unsigned char* recovery_blocks = fec.Encode(data, k * bytes);

  for (int i = 0; i < m; ++i) {
    unsigned char *block = recovery_blocks + i * bytes;
    unsigned char row = k + i;
    // TODO: Store block data somewhere we can access it.
    // Either write to file, to a mem location the PRU has access to, etc.

    cout << "Block data: " << block << std::endl;
    cout << "Row: " << row << endl;
  }
  // Verify length?

  
  delete []recovery_blocks;
}


int main() {

  cout << "Forward Error Correction Test Running..." << endl;
  TestFEC();
  
  return 0;
};

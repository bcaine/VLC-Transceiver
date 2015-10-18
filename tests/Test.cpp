#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include<iostream>
#include<exception>

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
  
  try {
    unsigned char* recovery_blocks = fec.Encode(data, k * bytes);
    unsigned char* recovered_data = fec.Decode(recovery_blocks);
    cout<< recovered_data << endl;
    delete []recovery_blocks;
    delete []recovered_data;
  } catch (const exception& e) {
    cout << "Exception occurred: " << e.what() << endl;
  }
  
}


int main() {

  cout << "Forward Error Correction Test Running..." << endl;
  TestFEC();
  
  return 0;
};

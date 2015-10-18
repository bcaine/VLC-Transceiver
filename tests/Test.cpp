#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include<iostream>

using namespace std;

char* GenerateData(int k, int bytes) {
  char *data = new char[k * bytes];

  // Generate Alphabet over and over
  for (int i = 0; i < k * bytes; i++) {
    data[i] = char((i % 26) + 97);
  }
  
  return data;
}


bool TestFEC() {
  char *data = GenerateData(64, 1000);
  // k = 64, m = 32, bytes = 1000
  ForwardErrorCorrection fec(64, 32, 1000);
  fec.Encode(data);
  
  // Put in code to test ForwardErrorCorrection
  return true;
}


int main() {

  cout << "Forward Error Correction Test: " << (TestFEC() == true ? "Passed" : "Failed" )<< endl;
  
  return 0;
};

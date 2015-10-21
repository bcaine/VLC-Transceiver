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

void CorruptData(unsigned char* data, int n_corruptions, int data_length) {
  for (int i = 0; i < n_corruptions; ++i) {
    int position = rand()%(data_length + 1);
    int val = rand()%(255 + 1);
    data[position] = val;
  }
}

void TestFEC() {
  int k = 16;
  int m = 8;
  int bytes = 8;
  unsigned char *data = GenerateData(k, bytes);
  // k = 64, m = 32, bytes = 1000
  ForwardErrorCorrection fec(k, m, bytes);
  
  try {
    cout << data << endl;
    cout << "--------------------------------" << endl;
    // Return Data + Recovery Blocks (appended)
    unsigned char* encoded_data = fec.Encode(data, k * bytes);

    int length = (k + m) * bytes;
    // Corrupt the data a bit
    CorruptData(encoded_data, 12, length);
    
    cout << encoded_data << endl;
    cout << "--------------------------------" << endl;

    // Take that, and decode to get recovered data
    unsigned char* recovered_data = fec.Decode(encoded_data);

    cout << recovered_data << endl;
    
    
    delete []encoded_data;
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

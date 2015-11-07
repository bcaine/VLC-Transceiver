#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include "Golay.hpp"
#include<iostream>
#include<exception>
#include<ctime>
#include<cstdlib>

using namespace std;

unsigned char* GenerateData(int data_length) {
  unsigned char *data = new unsigned char[data_length / 8];

  // Generate Alphabet over and over
  for (int i = 0; i < data_length; i++) {
    data[i] = char((i % 26) + 97);
  }
  
  return data;
}

void CorruptData(unsigned char* data,
		 int n_corruptions,
		 int data_length) {

  for (int i = 0; i < n_corruptions; ++i) {
    // Corrupt a single bit
    int position = rand() % data_length;
    setBit(data, position, getBit(data, position) ^ 1);
  }
}

unsigned int HammingDistance(unsigned char* a,
			     unsigned char* b,
			     unsigned int n) {

  unsigned int num_mismatches = 0;
  while (n) {
    if (*a != *b) {
      for (int i = 0; i < 8; ++i)
	num_mismatches += (getBit(a, i) == getBit(b, i));
    }
    
    --n;
    ++a;
    ++b;
  }
  
  return num_mismatches;
}

void TestFEC() {
  int data_length = 96;
  int num_errors = 20;
  unsigned char *data = GenerateData(data_length);
  unsigned char *encoded = new unsigned char[data_length * 2];
  unsigned char *decoded = new unsigned char[data_length];
  
  ForwardErrorCorrection fec;

  cout << "Data of length: " << data_length << endl;
  cout << "Introducing " << num_errors << " Errors" << endl;
  cout << endl;
  
  cout << data << endl;
  cout << "--------------------------------" << endl;

  fec.Encode(data, encoded, data_length);

  // Corrupt the data a bit
  CorruptData(encoded, num_errors, data_length * 2);

  // Take that, and decode to get recovered data
  fec.Decode(encoded, decoded, data_length);
  
  cout << decoded << endl;

  cout << "Hamming Distance between input and output: ";
  cout << HammingDistance(data, decoded, data_length / 8);
  cout << endl;
}


int main() {

  cout << "Forward Error Correction Test Running..." << endl;
  TestFEC();
  
  return 0;
};

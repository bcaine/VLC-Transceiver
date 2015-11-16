#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include "Golay.hpp"
#include "ByteQueue.hpp"
#include "Util.hpp"
#include<iostream>
#include<exception>
#include<ctime>
#include<cstdlib>

using namespace std;

unsigned char* GenerateData(int bytes) {
  unsigned char *data = new unsigned char[bytes];

  // Generate Alphabet over and over
  for (int i = 0; i < bytes; i++) {
    data[i] = char((i % 26) + 97);
  }
  
  return data;
}

void CorruptData(unsigned char* data,
		 int n_corruptions,
		 int bytes) {

  for (int i = 0; i < n_corruptions; ++i) {
    // Corrupt a single bit
    int position = rand() % (bytes * 8);
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
  int num_errors = 35;

  cout << "Testing FEC with " << num_errors << " errors" << endl;

  assert(data_length % 3 == 0);

  unsigned char* data = GenerateData(data_length);
  unsigned char* encoded = new unsigned char[data_length * 2];
  unsigned char* decoded = new unsigned char[data_length];

  cout << data << endl;
  cout << "-------------------------" << endl;

  ForwardErrorCorrection fec;
  
  fec.Encode(data, encoded, data_length);

  CorruptData(encoded, num_errors, data_length);

  fec.Decode(encoded, decoded, data_length * 2);

  cout << decoded << endl;

  cout << "Hamming Distance between input and output: ";
  cout << HammingDistance(data, decoded, data_length) << endl;

}

void TestByteQueue() {
  uint32_t* pru_cursor = new uint32_t;
  *pru_cursor = 0;

  ByteQueue queue(88 * 2);
  cout << "Queue Created" << endl;

  queue.push(GenerateData(87));

  uint8_t* data = new uint8_t[87];
  queue.pop(data);
  cout << data << endl;

  queue.pop(data);
  cout << data << endl;
}

void TestManchester() {
  int data_length = 2;
  unsigned char* data = GenerateData(data_length);
  unsigned char* encoded = new unsigned char[data_length * 2];
  unsigned char* decoded = new unsigned char[data_length];

  ForwardErrorCorrection fec;
  
  cout << data << endl;
  cout << "---------------------" << endl;
  fec.ManchesterEncode(data, encoded,
		       data_length, data_length * 2);

  cout << encoded << endl;
  cout << "---------------------" << endl;
  fec.ManchesterDecode(encoded, decoded,
		       data_length * 2, data_length);

  cout << decoded << endl;
}

void TestDataPipeline() {
  // Generate Data

  int data_length = 1000;
  int num_errors = 100;
  uint8_t* data = GenerateData(data_length);
  uint8_t* encoded = new uint8_t[2000];

  // Encode
  ForwardErrorCorrection fec;
  fec.Encode(data, encoded, data_length);

  // Errors
  CorruptData(encoded, num_errors, data_length * 2);

  int encoded_bit_length = (data_length * 8 * 12) / 23;
  encoded_bit_length += (data_length * 8 * 12) % 23;
  
  // Save
  ByteQueue queue(2000);
  cout << "Queue Created" << endl;

  /*
  int j = 0;
  for (int i = encoded_bit_length; i > 0; i -= (92 * 8)) {
    queue.push(&encoded[j * 92], 92 * 8);
    j++;
  }
  // Pop

  uint8_t* data_pop = new uint8_t[92];
  int len;
  for(int i = j; i > 0; i--) {
    
    len = queue.pop(data_pop);
    cout << "Length: " << len << endl;
    cout << data_pop << endl;
  }
  
  // Decode
  //  fec.Decode(encoded, decoded, data_length * 2);



  // Data

  */
}


int main() {

  cout << "Forward Error Correction Test Running...\n" << endl;
  TestFEC();

  cout << "----------------------------------------";
  cout << "----------------------------------------" << endl;

  cout << "ByteQueue Test Running...\n" << endl;
  TestByteQueue();

  cout << "----------------------------------------";
  cout << "----------------------------------------" << endl;

  cout << "Manchester Encoding Test Running...\n" << endl;
  TestManchester();
  
  // TestDataPipeline();

  return 0;
};

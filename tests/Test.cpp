#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include "Golay.hpp"
#include "ByteQueue.hpp"
#include "Util.hpp"
#include "Packetize.hpp"
#include <iostream>
#include <exception>
#include <ctime>
#include <cstdlib>
#include <cstring>

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
  
  assert(HammingDistance(data, decoded, data_length) == 0);
}

void TestByteQueue() {
  uint32_t* pru_cursor = new uint32_t;
  *pru_cursor = 0;

  ByteQueue queue(88 * 2);
  cout << "Queue Created" << endl;

  uint8_t* in = GenerateData(87);
  queue.push(in);

  uint8_t* out = new uint8_t[87];
  queue.pop(out);
  cout << out << endl;

  queue.pop(out);
  cout << out << endl;

  assert(HammingDistance(in, out, 88) == 0);

  delete [] in;
  delete [] out;
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

  assert(HammingDistance(data, decoded, 2) == 0);

  delete [] data;
  delete [] encoded;
  delete [] decoded;
}

void TestBasicPacketization() {

  // Basic test of a normal packet size
  uint8_t *data = GenerateData(43);
  uint8_t *packet = new uint8_t[45];
  uint8_t *out = new uint8_t[43];

  packetize(data, packet, 43 * 8);

  uint16_t bitlen = depacketize(packet, out);

  cout << "IN:  " << data << endl;
  cout << "OUT: " << out << endl;
  
  assert(HammingDistance(data, out, 43) == 0);
  assert(bitlen = 43 * 8);

  delete [] data;
  delete [] packet;
  delete [] out;
}

void TestAdvPacketization() {

  // Test truncated packetization with padding
  uint8_t *data = GenerateData(30);
  uint8_t *packet = new uint8_t[45];
  uint8_t *out = new uint8_t[43];

  packetize(data, packet, 30 * 8);

  uint16_t bitlen = depacketize(packet, out);

  cout << "Bitlen: " << bitlen << endl;

  cout << "IN:  " << data << endl;
  cout << "OUT: " << out << endl;

  assert(HammingDistance(data, out, 30) == 0);
  assert(bitlen = 30 * 8);

  delete [] data;
  delete [] packet;
  delete [] out;
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

  cout << "----------------------------------------";
  cout << "----------------------------------------" << endl;

  cout << "Basic Packetization Test Running...\n" << endl;
  TestBasicPacketization();

  cout << "----------------------------------------";
  cout << "----------------------------------------" << endl;

  cout << "Advanced Packetization Test Running...\n" << endl;
  TestAdvPacketization();

  // TestDataPipeline();

  return 0;
};

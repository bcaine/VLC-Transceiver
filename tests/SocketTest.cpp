#include "SocketConnection.hpp"
#include <iostream>
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

void BasicReceiveSocket() {

  // This corresponds with a simple python client
  // That sends 1000 bytes of data.
  int len;
  
  SocketConnection sock(9000);
  uint8_t *buf = new uint8_t[1000];

  for (int i = 0; i < 1000; i+= 43) {
    len = sock.Receive(buf + i, 43);
    cout << len << endl;
  }

  cout << buf << endl;
}

int main() {
  cout << "Testing receive socket" << endl;
  BasicReceiveSocket();

}

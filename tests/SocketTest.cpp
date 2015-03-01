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

void BasicReceiveSocket()
{

  // This corresponds with a simple python client
  // That sends 1000 bytes of data.
  int len;
  
  SocketConnection sock(9000);
  uint8_t *buf = new uint8_t[1000];

  int i = 0;
  while(i < 1000) {
    len = sock.Receive(buf + i, 43);
    cout << "i: " << i << " len: " << len << endl;
    i += len;
  }

  cout << buf << endl;
  sock.Close();
}

void BasicSendSocket()
{

  int data_len = 1000;
  SocketConnection sock(9000);
  uint8_t *buf = GenerateData(data_len);

  sock.Send(buf, data_len);
  sock.Close();
}

int main(int argc, char *argv[])
{
  if( argc == 2 ) {
    printf("The argument supplied is %s\n", argv[1]);
  }

  if (strcmp(argv[1], "receive") == 0) {
    cout << "Testing receive socket" << endl;
    BasicReceiveSocket();
  } else if (strcmp(argv[1], "send") == 0) {
    cout << "Testing send socket" << endl;
    BasicSendSocket();
  }

}

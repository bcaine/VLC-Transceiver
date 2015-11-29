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
  int totallen;

  SocketConnection sock(9000);
  uint8_t *buf = new uint8_t[1000];
  len = sock.Receive(buf, 4);
  totallen = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);

  int packet_num = totallen / 43;
  if (totallen % 43 != 0)
    packet_num += 1;

  sock.Ack();

  int i = 0;
  while(i < totallen) {
    len = sock.Receive(buf, 1000);
    cout << "Length: " << len << endl;
    i += len;
  }

  cout << buf << endl;
  sock.Close();
}

void BasicSendSocket()
{

  int data_len = 100;
  SocketConnection sock(9000);
  uint8_t *buf = GenerateData(data_len);

  int flushsize = 10;
  int sent = 0;

  cout << "Waiting for client to connect" << endl;
  sock.WaitForClient();

  // In Transmit function, we timeout when the PRU stops giving us data
  while(sent < data_len) {
    sock.Send(buf + sent, flushsize);
    sent += flushsize;
  }

  cout << "Finished. Shutting down" << endl;
  sock.SendDone();
  sock.Close();
}

int main(int argc, char *argv[])
{
  if (argc == 1) {
    cout << "Please provide either 'send' or 'receive' as an argument" << endl;
    return 0;
  }

  if (strcmp(argv[1], "receive") == 0) {
    cout << "Testing receive socket" << endl;
    BasicReceiveSocket();
  } else if (strcmp(argv[1], "send") == 0) {
    cout << "Testing send socket" << endl;
    BasicSendSocket();
  } else {
    cout << "Please provide either 'send' or 'receive' as an argument" << endl;
  }

  return 0;
}

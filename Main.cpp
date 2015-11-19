#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include "ByteQueue.hpp"
#include <iostream>

using namespace std;

void Transmit() {


}

void Receive() {


}

int main(int argc, char *argv[]) {

  if ( argc == 1)
    cout << "Please provide either 'transmit' or 'receive'" << endl;

  if (strcmp(argv[1], "transmit") == 0)
    Transmit();
  else if (strcmp(argv[1], "receive") == 0)
    Receive();
  else
    cout << "Please provide either 'transmit' or 'receive'" << endl;

  return 0;
}

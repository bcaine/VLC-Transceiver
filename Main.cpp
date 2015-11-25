#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include <iostream>

using namespace std;

void Transceive(bool transmit) {
  SocketConnection sockconn(9000);
  ForwardErrorCorrection fec;
  RealtimeControl pru;

  Transceiver transceiver(sockconn, fec, pru);

  cout << "Starting Transceiver in ";
  cout << (transmit ? "transmit mode." : "receive mode.") << endl;
  
  if (transmit)
    transceiver.Transmit();
  else
    transceiver.Receive();

  cout << "Shutting down..." << endl;
}

int main(int argc, char *argv[]) {

  if ( argc == 1)
    cout << "Please provide either 'transmit' or 'receive'" << endl;

  if (strcmp(argv[1], "transmit") == 0)
    Transceive(true);
  else if (strcmp(argv[1], "receive") == 0)
    Transceive(false);
  else
    cout << "Please provide either 'transmit' or 'receive'" << endl;

  return 0;
}

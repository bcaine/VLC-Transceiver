#include "Transceiver.hpp"
#include "ForwardErrorCorrection.hpp"
#include "RealtimeControl.hpp"
#include "SocketConnection.hpp"
#include "ByteQueue.hpp"
#include <iostream>

using namespace std;

void Transceive(bool transmit) {
  SocketConnection sockconn(9000);
  ForwardErrorCorrection fec;
  RealtimeControl pru;

  // TODO: Uncomment this when we are on Beaglebone
  // x86 Linux Kernel doesn't let you access > 1MB of /dev/mem
  // with mmap unless I recompile the kernel with a flag disabled.
  // Testing with a smaller queue, but not ideal.
  // Create queue that is ~16 MB large
  // ByteQueue queue(16777200);

  // Close to 512 kb. For testing. We want more.
  ByteQueue queue(524216);

  Transceiver transceiver(sockconn, fec, pru, queue);

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

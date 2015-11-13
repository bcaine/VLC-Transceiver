/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"


Transceiver::Transceiver(const SocketConnection &sockconn,
			 const ForwardErrorCorrection &fec,
			 const RealtimeControl &pru):
  _sockconn(sockconn), _fec(fec), _pru(pru) {

}

Transceiver::~Transceiver() {
  // Possibly delete the three objects? Or call destructors?
  // This may get run automatically. Figure this out.
  /*
  _sockconn();
  ~_fec();
  ~_pru()
  */
}

void Transceiver::Transmit()
{
  /*
    unsigned char* buf = unsigned char[100]
    unsigned char* encoded = unsigned char[100]
    while(true):
      length, buf = recv(1000)
      encode(buf, encoded, length)
      // Queue should packetize
      queue.push(encoded)
      
      
    


  */
  // Loop through, take in data from socket, encode, write to memory
}

void Transceiver::Receive() {
  // Loop through, take data from memory, decode, send through socket
}

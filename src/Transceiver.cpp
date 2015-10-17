/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"


Transceiver::Transceiver(SocketConnection sockconn,
			 ForwardErrorCorrection fec,
			 RealtimeControl pru) {
  _sockconn = sockconn;
  _fec = fec;
  _pru = pru;
}

Transciever::~Transceiver() {
  ~sockconn();
  ~fec();
  ~pru();
}

void Transceiver::Transmit() {
  // Loop through, take in data from socket, encode, write to memory
  return
}

void Trasceiver::Receive() {
  // Loop through, take data from memory, decode, send through socket
  return
}

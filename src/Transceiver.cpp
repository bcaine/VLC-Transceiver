/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"


Transceiver::Transceiver(SocketConnection &sockconn,
			 ForwardErrorCorrection &fec,
			 RealtimeControl &pru,
			 ByteQueue &queue):
  _sock(sockconn), _fec(fec), _pru(pru), _queue(queue) {}


void Transceiver::Transmit()
{
  cout << "Starting Transmit" << endl;
  
  uint8_t* buf = new uint8_t[43];
  uint8_t* packet = new uint8_t[45];
  uint8_t* encoded = new uint8_t[87];
  int recvlen;

  while(1) {
    recvlen = _sock.Receive(buf, 43);

    if (recvlen == 0) {
      cout << "Receive Length 0. Assume Transfer is done." << endl;
      break;
    }

    packetize(buf, packet, recvlen * 8);
    _fec.Encode(encoded, packet, 87);
    _queue.push(encoded);
  }
}

void Transceiver::Receive() {

  uint8_t* encoded = new uint8_t[87];
  uint8_t* packet = new uint8_t[45];
  uint8_t* buf = new uint8_t[43];
  int packetlen;

  while(!_pru.Done()) {

    // TODO: If we are waiting on the PRU, delay...
    // This is super important
    
    _queue.pop(encoded);
    _fec.Decode(encoded, packet, 87);
    
    packetlen = depacketize(packet, buf);

    // May want to send all data at once? Not sure yet.
    _sock.Send(buf, packetlen);
  }
}

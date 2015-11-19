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
  uint32_t totallen;

  // Get totallen by receiving it first
  recvlen = _sock.Receive(buf, 43);
  totallen = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
  _queue.setLength(totallen);
  cout << "Incoming data length: " << totallen << endl;

  // Send an Ack to let them know we are ready for data
  _sock.Ack();


  uint32_t received = 0;
  while(1) {
    recvlen = _sock.Receive(buf, 43);
    received += recvlen;

    if (recvlen == 0 && (received == totallen)) {
      cout << "Assume Transfer is done." << endl;
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

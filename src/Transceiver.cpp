/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"
#include "Util.hpp"


Transceiver::Transceiver(SocketConnection &sockconn,
			 ForwardErrorCorrection &fec,
			 RealtimeControl &pru):
  _sock(sockconn), _fec(fec), _pru(pru) {}


void Transceiver::Transmit()
{

  // Initializing pru memory
  _pru.OpenMem();
  
  cout << "Starting Transmit" << endl;
  uint8_t* buf = new uint8_t[43];
  uint8_t* packet = new uint8_t[45];
  uint8_t* encoded = new uint8_t[87];
  int recvlen;
  uint32_t totallen;

  // Get totallen by receiving it first
  recvlen = _sock.Receive(buf, 4);
  totallen = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
  // Length is number of packets...
  int packet_num = totallen / 43;
  if (totallen % 43 != 0)
    packet_num += 1;

  _pru.setLength(packet_num);
  cout << "Incoming data length: " << totallen << endl;
  cout << "Packet count: " << packet_num << endl;

  // Send an Ack to let them know we are ready for data
  _sock.Ack();

  /*
  cout << "Memsetting data to 0" << endl;
  memset(_pru.data(), 0, totallen);
  cout << "Just Memset data to 0" << endl;
  */

  /*
  for (int i = 0; i < totallen; i++) {
    cout << getBit(_pru.data(), i);
   }
  */

  uint32_t received = 0;
  int num = 0;
  while(1) {
    recvlen = _sock.Receive(buf, 43);
    received += recvlen;

    cout << "Packet: " << num << endl;
    num ++;

    if (recvlen == 0 && (received == totallen)) {
      cout << "Assume Transfer is done." << endl;
      break;
    }


    packetize(buf + 43, packet, recvlen * 8);
    
    _fec.Encode(packet, encoded, 45);
      
    int pos = 0;
    for (int i = 0; i < 87 * 8; i++) {
      if (pos < 4)
	setBit(encoded, i, 0);
      else
	setBit(encoded, i, 1);
      
      pos += 1;
      pos %= 8;
    }
    
    _pru.push(encoded);
  }
  cout << endl;

  cout << "Initializing the PRU" << endl;
  _pru.InitPRU();
  cout << "Starting Transmit" << endl;
  _pru.Transmit();

  /*
  for (int i = 0; i < totallen; i++) {
    cout << getBit(_pru.data(), i);
   }
  */

  cout << "PRU Cursor: " << *_pru.pruCursor() << endl;
  _pru.CloseMem();
  cout << "Closed Memory" << endl;

}

void Transceiver::Receive() {

  uint8_t* encoded = new uint8_t[87];
  uint8_t* packet = new uint8_t[45];
  uint8_t* buf = new uint8_t[43];
  int packetlen;

  /*
  while(!_pru.Done()) {

    // TODO: If we are waiting on the PRU, delay...
    // This is super important
    
    _pru.pop(encoded);
    _fec.Decode(encoded, packet, 87);
    
    packetlen = depacketize(packet, buf);

    // May want to send all data at once? Not sure yet.
    _sock.Send(buf, packetlen);
    }*/
}

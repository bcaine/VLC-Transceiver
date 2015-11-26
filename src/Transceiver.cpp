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
  uint8_t* buf = new uint8_t[1032];
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


  uint32_t received = 0;
  int n = 0;
  int i = 0, j = 0;
  int packetlen;

  // Read in all data from socket and write to mem or backlog
  while(1) {
    recvlen = _sock.Receive(buf, 1032);
    received += recvlen;

    for (i = 0; i < recvlen; i+= 43) {
      packetlen = ((recvlen - i) >= 43) ? 43 : recvlen - i;
      
      packetize(buf + i, packet, packetlen * 8);
      _fec.Encode(packet, encoded, 45);
      
      // If its our first n packets, write to mem
      if (n < _pru.max_packets)
	_pru.push(encoded);
      else
	for(j = 0; j < 87; j++)
	  _backlog.push(encoded[j]);
      n++;
    }

    if (received == totallen) {
      cout << "Socket Transfer is done." << endl;
      break;
    }
  }

  cout << "Initializing the PRU and starting transmit" << endl;
  _pru.InitPRU();
  _pru.Transmit();

  // Work our way through backlog pushing data into mem when we can
  while(!_backlog.empty()) {
    /*
    cout << "Queue has a size of: " << _backlog.size() << endl;
    cout << "PRU Cursor: " << _pru.pruCursor() << endl;
    cout << "Internal: " << _pru.internalCursor() << endl;
    */

    // If we cant fit the next packet
    if (_pru.pruCursor() <= _pru.internalCursor() + 88)
      continue;
    
    for(i = 0; i < 87; i++) {
      encoded[i] = _backlog.front();
      _backlog.pop();
    }

    _pru.push(encoded);
  }

  _pru.DisablePRU();
  _pru.CloseMem();
  cout << "Transmit Finished" << endl;
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

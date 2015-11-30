/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical
   and Computer Engineering Department.

   Author: Ben Caine
   Date: September 24, 2015
*/

#include "Transceiver.hpp"


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
  unsigned int n = 0;
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


      // If its our first n packets, write to mem. 
      // Otherwise to the backlog
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
  _pru.InitPru();
  _pru.Transmit();

  // Work our way through backlog pushing data into mem when we can
  while(!_backlog.empty()) {

    // If we cant fit the next packet
    if (_pru.pruCursor() <= _pru.internalCursor() + 88)
      usleep(SLEEP_US);
      continue;
    
    for(i = 0; i < 87; i++) {
      encoded[i] = _backlog.front();
      _backlog.pop();
    }

    _pru.push(encoded);
  }

  _pru.DisablePru();
  _pru.CloseMem();
  _sock.Close();

  // Clean up
  delete[] buf;
  delete[] packet;
  delete[] encoded;

  cout << "Transmit Finished" << endl;
}

void Transceiver::Receive() {

  uint8_t* encoded = new uint8_t[87];
  uint8_t* packet = new uint8_t[45];
  uint8_t* data = new uint8_t[43];
  // Only should use 1032
  uint8_t* buf = new uint8_t[1100];

  // We flush (send via sockets) every 1032 bytes
  const int flushsize = 1032;
  
  int packetlen_bits = 0;
  int packetlen = 0;
  int sendsize = 0;
  
  _pru.OpenMem();

  cout << "Waiting for client to connect..." << endl;
  _sock.WaitForClient();

  cout << "Setting up the PRUs to receive..."<< endl;
  _pru.InitPru();
  _pru.Receive();

  time_t last_send = time(NULL);
  bool first_packet = true;
  
  while(true) {
    // If timeout, and not the first packet (which may take
    // an indeterminate amount of time), we exit
    if ((!first_packet) && (time(NULL) > last_send + TIMEOUT))
	break;

    // Loop while we wait for cursor to increment
    if (_pru.internalCursor() + 88 <= _pru.pruCursor()) {
      cout << "Pru Cursor: " << _pru.pruCursor() << endl;
      cout << "Internal Cursor: " << _pru.internalCursor() << endl;
      usleep(SLEEP_US);
      continue;
    }

    _pru.pop(encoded);
    _fec.Decode(encoded, packet, 87);

    // This gives us number of bits in packet that are real data
    packetlen_bits = depacketize(packet, data);
    packetlen = packetlen_bits / 8;

    // If we have data, this isn't the first packet anymore
    if (packetlen > 0)
      first_packet = false;

    // If not a multiple of 8, just return an extra byte
    if (packetlen_bits % 8 != 0)
      packetlen += 1;

    // Copy data into buffer
    memcpy(buf + sendsize, data, packetlen);

    sendsize += packetlen;

    // If the packetlen isnt a multiple of 8
    // its the last packet so we can break
    if (packetlen_bits % 8 != 0)
      break;

    if (sendsize >= flushsize) {
      _sock.Send(buf, sendsize);
      sendsize = 0;
      last_send = time(NULL);
    }
  }

  // Send the rest via sockets.
  if (sendsize > 0)
    _sock.Send(buf, sendsize);

  // Mark the PRU done and send Done via sockets
  _pru.MarkPruDone();
  _sock.SendDone();

  // Then wait for the PRU to exit
  _pru.DisablePru();
  // Close the memory and socket fds
  _pru.CloseMem();
  _sock.Close();

  // Clean up
  delete[] encoded;
  delete[] packet;
  delete[] data;
  delete[] buf;

  cout << "Receive Finished" << endl;
}

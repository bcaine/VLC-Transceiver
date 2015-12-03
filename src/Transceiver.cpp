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
  uint8_t buf[FLUSH_SIZE];
  uint8_t packet[DECODED_PACKET_SIZE];
  uint8_t encoded[ENCODED_DATA_SIZE];
  int recvlen;
  uint32_t totallen;

  // Get totallen by receiving it first
  recvlen = _sock.Receive(buf, 4);
  totallen = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
  // Length is number of packets...
  int packet_num = totallen / DECODED_DATA_SIZE;
  if (totallen % DECODED_DATA_SIZE != 0)
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
    recvlen = _sock.Receive(buf, FLUSH_SIZE);
    received += recvlen;

    for (i = 0; i < recvlen; i+= DECODED_DATA_SIZE) {
      
      if ((recvlen - i) >= DECODED_DATA_SIZE)
	packetlen = DECODED_DATA_SIZE;
      else
	packetlen = recvlen - i;

      packetize(buf + i, packet, packetlen * 8);
      _fec.Encode(packet, encoded, DECODED_PACKET_SIZE);

      /*
      for(int i = 0; i < 81; i++) {
	encoded[i] = n;
	}*/

      // Increase packet number
      n++;

      // If its our first n packets, write to mem. 
      // Otherwise to the backlog
      if (n < _pru.max_packets)
	_pru.push(encoded);
      else
	for(j = 0; j < ENCODED_DATA_SIZE; j++)
	  _backlog.push(encoded[j]);
    }

    if (received >= totallen) {
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
    if (_pru.pruCursor() <= _pru.internalCursor() + ENCODED_PACKET_SIZE)
      usleep(SLEEP_US);
      continue;
    
    for(i = 0; i < ENCODED_DATA_SIZE; i++) {
      encoded[i] = _backlog.front();
      _backlog.pop();
    }

    _pru.push(encoded);
  }

  _pru.DisablePru();
  _pru.CloseMem();
  _sock.Close();

  cout << "Transmit Finished" << endl;
}

void Transceiver::Receive() {

  uint8_t encoded[ENCODED_DATA_SIZE];
  uint8_t packet[DECODED_PACKET_SIZE];
  uint8_t data[DECODED_DATA_SIZE];
  uint8_t buf[FLUSH_SIZE + 100];

  int packetlen_bits = 0;
  int packetlen = 0;
  int sendsize = 0;
  
  _pru.OpenMem();

  cout << "Waiting for client to connect..." << endl;
  _sock.WaitForClient();

  cout << "Setting up the PRUs to receive..."<< endl;
  _pru.InitPru();
  _pru.Receive();
  // Wait for it to finish
  _pru.DisablePru();

  int num_packets = 15;

  for (int i = 0; i < 4; i++)
    _pru.pop(encoded);
  
  for (int n = 4; n < num_packets + 4; n++) {
    _pru.pop(encoded);

    cout << encoded << endl;

    /*
    _fec.Decode(encoded, packet, ENCODED_DATA_SIZE);

    // This gives us number of bits in packet that are real data
    packetlen_bits = depacketize(packet, data);
    packetlen = packetlen_bits / 8;

    // If not a multiple of 8, just return an extra byte
    if (packetlen_bits % 8 != 0)
      packetlen += 1;
    */
    // Copy data into buffer
    memcpy(buf + sendsize, encoded, 87);
    //memcpy(buf + sendsize, data, packetlen);

    //sendsize += packetlen;
    sendsize += 87;
    /*
    if (packetlen_bits % 8 != 0)
      break;
    */

    if (sendsize >= FLUSH_SIZE) {
      cout << "Sending: " << sendsize << " Bytes"<< endl;
      _sock.Send(buf, sendsize);
      sendsize = 0;
    }
  }

  // Send the rest via sockets.
  if (sendsize > 0) {
    cout << "Sent " << sendsize << " bytes" << endl;
    _sock.Send(buf, sendsize);
  }
  
  // Mark the PRU done and send Done via sockets
  _pru.MarkPruDone();
  _sock.SendDone();

  // Then wait for the PRU to exit
  //_pru.DisablePru();
  // Close the memory and socket fds
  _pru.CloseMem();
  _sock.Close();

  cout << "Receive Finished" << endl;
}

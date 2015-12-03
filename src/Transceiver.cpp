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
  int i = 0;
  int packetlen;

  // Read in all data from socket and write to mem or backlog
  while(1) {
    recvlen = _sock.Receive(buf, FLUSH_SIZE);
    received += recvlen;

    // Really bad hack. First 2-3 packets on RX side are corrupted
    // with old data. Sending first 5 packets twice...
    // Assuming all first 5 packets are full...
    for (i = 0; i < DECODED_DATA_SIZE * 5; i+= DECODED_DATA_SIZE) {
      packetlen = DECODED_DATA_SIZE;
      
      packetize(buf + i, packet, packetlen * 8);
      _fec.Encode(packet, encoded, DECODED_PACKET_SIZE);
      _pru.push(encoded);
      n++;

    }

    for (i = 0; i < recvlen; i+= DECODED_DATA_SIZE) {
      
      if ((recvlen - i) >= DECODED_DATA_SIZE)
	packetlen = DECODED_DATA_SIZE;
      else
	packetlen = recvlen - i;

      packetize(buf + i, packet, packetlen * 8);
      _fec.Encode(packet, encoded, DECODED_PACKET_SIZE);

      for(int i = 0; i < ENCODED_DATA_SIZE; i++) {
	encoded[i] = n;
      }

      // Increase packet number
      n++;

      // If its our first n packets, write to mem. 
      // Otherwise to the backlog
      if (n < _pru.max_packets)
	_pru.push(encoded);
    }

    if (received >= totallen) {
      cout << "Socket Transfer is done." << endl;
      break;
    }
  }

  cout << "Transmitted " << n << " Packets" << endl;

  cout << "Initializing the PRU and starting transmit" << endl;
  _pru.InitPru();
  _pru.Transmit();
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

  // Toss out first 5
  for (int i = 0; i < 5; i++)
    _pru.pop(encoded);
  
  int zeros = 0;

  while(1) {
    _pru.pop(encoded);
    cout << encoded << endl;
    
    for(int j = 0; j < ENCODED_DATA_SIZE; j++)
      zeros += encoded[j];

    if (zeros >= ENCODED_DATA_SIZE)
      break;
    


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
    memcpy(buf + sendsize, encoded, ENCODED_DATA_SIZE);
    //memcpy(buf + sendsize, data, packetlen);

    //sendsize += packetlen;
    sendsize += ENCODED_DATA_SIZE;

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
  _sock.SendDone();

  // Close the memory and socket fds
  _pru.CloseMem();
  _sock.Close();

  cout << "Receive Finished" << endl;
}

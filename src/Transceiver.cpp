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

const unsigned PACKET_COUNT = 6000;

void Transceiver::Transmit()
{

  // Initializing pru memory
  _pru.OpenMem();

  cout << "Starting Transmit" << endl;
  uint8_t buf[FLUSH_SIZE];
  uint8_t packet[HALF_PACKET_SIZE];
  uint8_t encoded[PACKET_SIZE];
  int recvlen;
  uint32_t totallen;

  // Get totallen by receiving it first
  recvlen = _sock.Receive(buf, 4);
  totallen = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
  // Length is number of packets...
  int packet_num = totallen / DATA_SIZE;
  if (totallen % DATA_SIZE != 0)
    packet_num += 1;

  _pru.setLength(PACKET_COUNT);
  cout << "Incoming data length: " << totallen << endl;
  cout << "Packet count: " << packet_num << endl;

  // Send an Ack to let them know we are ready for data
  _sock.Ack();


  uint32_t received = 0;
  unsigned int n = 0;
  int i = 0;
  int packetlen;

  bool first = true;

  // Read in all data from socket and write to mem or backlog
  while(1) {
    recvlen = _sock.Receive(buf, FLUSH_SIZE);
    received += recvlen;

    for (i = 0; i < recvlen; i+= HALF_DATA_SIZE) {
      
      if ((recvlen - i) >= HALF_DATA_SIZE)
	packetlen = HALF_DATA_SIZE;
      else
	packetlen = recvlen - i;

      packetize(buf + i, packet, packetlen * 8);
      
      _fec.ManchesterEncode(packet, encoded, (2 + packetlen) * 8);
      // Since we only save 40-> Encoded packets, set last one to 0
      encoded[PACKET_SIZE - 1] = 0;

      // Increase packet number
      n++;
      _pru.push(encoded);

      if (first) {
	for(int u = 0; u < PACKET_SIZE * 8; u++)
	  cout << getBit(encoded, u);
	cout << endl;
	first = false;
      }
    }

    if (received >= totallen) {
      cout << "Socket Transfer is done." << endl;
      break;
    }
  }

  // Set all high for the rest of packets
  memset(encoded, 0xFF, PACKET_SIZE);

  for (i = n; i < PACKET_COUNT + 50; i++) {
    _pru.push(encoded);
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

  uint8_t encoded[PACKET_SIZE];
  uint8_t packet[HALF_PACKET_SIZE];
  uint8_t data[HALF_DATA_SIZE];
  uint8_t buf[FLUSH_SIZE];

  int packetlen_bits = 0;
  int packetlen = 0;
  int sendsize = 0;

  int n = 0;
  
  _pru.OpenMem();

  cout << "Waiting for client to connect..." << endl;
  _sock.WaitForClient();

  cout << "Setting up the PRUs to receive..."<< endl;
  _pru.InitPru();
  _pru.Receive();
  // Wait for it to finish
  _pru.DisablePru();

  // Toss out first 2 that are always 0xff
  for (int i = 0; i < 2; i++) {
    _pru.pop(packet);
    for(int j = 0; j < PACKET_SIZE; j++)
      printf("%02x", packet[j]);
    cout << endl;
  }

  
  int num_packets = (_pru.pruCursor() - 8) / TOTAL_SIZE;

  int high = 0;
  bool last_packet_high = false;

  for (int i = 0; i < num_packets; i++) {
    _pru.pop(encoded);

    for (int j = 0; j < PACKET_SIZE; j++)
      high += packet[j] == 0xFF;
    
    if (high > (PACKET_SIZE - 10)) {
      if (last_packet_high)
	break;
      else
	last_packet_high = true;
    } else {
      last_packet_high = false;
    }

    high = 0;
    
    _fec.ManchesterDecode(encoded, packet, HALF_PACKET_SIZE * 8);

    packetlen_bits = depacketize(packet, data);
    packetlen = packetlen_bits / 8;

    // If not a multiple of 8, just return an extra byte
    if (packetlen_bits % 8 != 0)
      packetlen += 1;

    // Copy data into buffer
    memcpy(buf + sendsize, data, packetlen);

    sendsize += packetlen;

    if (packetlen_bits % 8 != 0) {
      cout << "Packetlength bits not % by 8. Breaking." << endl;
      break;
    }

    if (sendsize >= FLUSH_SIZE) {
      cout << "Sending: " << sendsize << " Bytes"<< endl;
      _sock.Send(buf, sendsize);
      sendsize = 0;
    }
    n++;
  }
  
  cout << "Received: " << n << " Packets" << endl;

  // Send the rest via sockets.
  if (sendsize > 0) {
    cout << "Sent " << sendsize << " bytes" << endl;
    if (last_packet_high)
      _sock.Send(buf, sendsize - PACKET_SIZE * 2);
    else
      _sock.Send(buf, sendsize);
  }

  // Mark the PRU done and send Done via sockets
  _sock.SendDone();

  // Close the memory and socket fds
  _pru.CloseMem();
  _sock.Close();

  cout << "Receive Finished" << endl;
}

/* Tranceiver code for a Visible Light Communication System.
   Part of a Senior Capstone Project at Northeastern University's Electrical 
   and Computer Engineering Department.

   This module wraps the Transmitter and Receiver module into one for
   easy use.

   Author: Ben Caine
   Date: September 24, 2015
*/
#ifndef TRANSCEIVER_HPP
#define TRANSCEIVER_HPP

#include "ForwardErrorCorrection.hpp"
#include "SocketConnection.hpp"
#include "RealtimeControl.hpp"
#include "Packetize.hpp"
#include <iostream>
#include <queue>
#include <time.h>
#include <unistd.h>

using namespace std;

const int TIMEOUT = 5000;
const int SLEEP_US = 100;

class Transceiver {

public:
  Transceiver(SocketConnection &sockconn,
	      ForwardErrorCorrection &fec,
	      RealtimeControl &pru);
  
  void Transmit();
  void Receive();

private:
  SocketConnection _sock;
  ForwardErrorCorrection _fec;
  RealtimeControl _pru;

  queue<uint8_t> _backlog;
};

#endif // TRANSCEIVER_HPP

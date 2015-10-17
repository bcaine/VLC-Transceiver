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


class Transceiver {

public:
  Transceiver(const SocketConnection &sockconn,
	      const ForwardErrorCorrection &fec,
	      const RealtimeControl &pru);
  
  ~Transceiver();

  void Transmit();
  void Receive();

private:
  SocketConnection _sockconn;
  ForwardErrorCorrection _fec;
  RealtimeControl _pru;
};

#endif // TRANSCEIVER_HPP

/* Implementations of SocketConnection.hpp
   This should manage our socket information, relating to
   transfering data between the host computer and this application

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "SocketConnection.hpp"

SocketConnection::SocketConnection(int port, bool is_server) {
  _is_server = is_server;
  
  // TODO:
  // - Init Socket
  // - Do things differently if server/client
}

SocketConnection::~SocketConnection() {
  // TODO:
  // - Close Socket
}

bool SocketConnection::Receive(char *buf) {
  // TODO:
  // - Behave differently if server/client
  // - Transfer this data into the buffer that is
  //   shared with encoding
  return true;
}

bool SocketConnection::Send(char *buf) {
  // TODO:
  // - Behave differently if server/client
  // - Take data from buffer and push to
  return true;
}

/* Implementations of SocketConnection.hpp
   This should manage our socket information, relating to
   transfering data between the host computer and this application

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "SocketConnection.hpp"

SocketConnection::SocketConnection(int port) {

  _sock = socket(AF_INET, SOCK_STREAM, 0);

  memset(&_servaddr, '0', sizeof(_servaddr));
  memset(&_cliaddr, '0', sizeof(_cliaddr));

  _servaddr.sin_family = AF_INET;
  _servaddr.sin_addr.s_addr = INADDR_ANY;
  _servaddr.sin_port = htons(port);
  
  if (bind(_sock, (struct sockaddr*)&_servaddr, sizeof(_servaddr)) == -1) {
    std::cout << "Could not bind to socket." << std::endl;
    fprintf(stderr, "socket failed: %s\n", strerror(errno));
  }

  if (listen(_sock, 500) == -1) {
    std::cout << "Could not listen to socket." << std::endl;
    fprintf(stderr, "socket failed: %s\n", strerror(errno));
  }

  // Set to 0 so we can make sure Accept is called before send/receive
  _connfd = 0;

  // Set it so we can reuse an addr
  int yes = 1;
  setsockopt(_sock, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int));
  
}

SocketConnection::~SocketConnection() {
  close(_sock);
}

bool SocketConnection::Accept() {
  int sock_size = sizeof(_cliaddr);
  _connfd = accept(_sock, (struct sockaddr*)&_cliaddr,
		   (socklen_t*)&sock_size);
  return _connfd != -1;
}

bool SocketConnection::Close() {
  return close(_connfd) != -1;
}

int SocketConnection::Receive(uint8_t *buf, int len) {
  if (_connfd == 0)
    if (!Accept())
      std::cout << "Accept failed... Receive won't work" << std::endl;
  return recv(_connfd, buf, len, 0);
}

int SocketConnection::Send(uint8_t *buf, int len) {

  if (_connfd == 0)
    if (!Accept())
      std::cout << "Accept failed... Receive won't work" << std::endl;

  return send(_connfd, buf, len, 0);
}

void SocketConnection::Ack() {
  uint8_t* ack = new uint8_t[1];
  ack[0] = 0xF;
  Send(ack, 1);
}

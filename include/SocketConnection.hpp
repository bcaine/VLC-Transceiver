/* Socket Connection class for receiving data from our host computer

   Author: Ben Caine
   Date: October 17, 2015
*/
#ifndef SOCKET_HPP
#define SOCKET_HPP


// TODO: Figure out which of these I can get rid of...
// Going off C Socket Programming example from Wireless Networks class
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>


class SocketConnection {

public:
  SocketConnection(int port, bool is_server);
  ~SocketConnection();

  bool Receive(char *buf);
  bool Send(char *buf);
  
private:
  int _sock_m, _recv_result;
  // We care about cliaddr if we want to explicitly
  // send a message to the client.
  struct sockaddr_in _servaddr, _cliaddr;
  // Decide whether this is the server or client.
  // NOTE: This seems like a pretty poor idea. Introduces code smell
  // Refactor this into an abstract class
  bool _is_server;

};

#endif // SOCKET_HPP

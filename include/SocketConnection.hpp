/* Socket Connection class for receiving data from our host computer

   Author: Ben Caine
   Date: October 17, 2015
*/
#ifndef SOCKET_HPP
#define SOCKET_HPP

#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdint.h>
#include <iostream>
#include <cstring>
#include <stdio.h>
#include <errno.h>


class SocketConnection {

  public:
    SocketConnection(int port);
    ~SocketConnection();

    bool Accept();
    bool Close();
    int Receive(uint8_t *buf, int bytes);
    int Send(uint8_t *buf, int bytes);
    void Ack();
    void WaitForClient();
    void SendDone();

  private:
    int _sock, _recv_result;
    int _connfd;
    // We care about cliaddr if we want to explicitly
    // send a message to the client.
    struct sockaddr_in _servaddr, _cliaddr;
};

#endif // SOCKET_HPP

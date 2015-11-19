#!/usr/bin/python

import socket
import sys


def send_data(port):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = ('localhost', port)
    print >>sys.stderr, 'connecting to %s port %s' % server_address
    sock.connect(server_address)
    message = 'HelloWorld' * 100
    print >>sys.stderr, 'sending "%s"' % message
    sock.sendall(message)

def receive_data(port):
    pass

if __name__=="__main__":
    if 'send' in sys.argv:
        send_data(port=9000)
    elif 'receive' in sys.argv:
        receive_data(port=9000)

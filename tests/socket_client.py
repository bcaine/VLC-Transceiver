#!/usr/bin/python

import socket
import sys

def get_socket(port):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = ('localhost', port)
    print >>sys.stderr, 'connecting to %s port %s' % server_address
    sock.connect(server_address)
    return sock

def send_data(port):
    sock = get_socket(port)
    message = 'HelloWorld' * 100
    print >>sys.stderr, 'sending "%s"' % message
    sock.sendall(message)

def receive_data(port):
    print "Creating socket"
    sock = get_socket(port)
    data = ''
    data += sock.recv(1000)
    print "Received data of length: {}".format(len(data))
    print data

if __name__=="__main__":
    if 'send' in sys.argv:
        send_data(port=9000)
    elif 'receive' in sys.argv:
        receive_data(port=9000)

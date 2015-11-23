#!/usr/bin/python

import socket
import sys
import struct

HOST="192.168.2.2"

def get_socket(port):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (HOST, port)
    print >>sys.stderr, 'connecting to %s port %s' % server_address
    sock.connect(server_address)
    return sock

def send_data(port):
    sock = get_socket(port)
    message = 'HelloWorld' * 800
    # print >>sys.stderr, 'sending "%s"' % message
    len_in_bytes = struct.pack("I", 8000)
    print "Sending Length"
    sock.sendall(len_in_bytes)

    # Wait for ack
    ack = sock.recv(1)

    print "Sending Message"
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

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

def send_data(port, n):
    sock = get_socket(port)
    # 5 Bytes * whatever
    # message = 'Hello' * n
    message = 'a' * n
    # print >>sys.stderr, 'sending "%s"' % message
    len_in_bytes = struct.pack("I", len(message))
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


def convert(n):
    num = int(n[:-1])
    if n[-1:] == 'k':
        return num * 10**3
    elif n[-1:] == 'm':
        return num * 10**6
    else:
        return num

if __name__=="__main__":
    if len(sys.argv) == 3:
        num = convert(sys.argv[2])
    if 'send' in sys.argv:
        send_data(9000, num)
    elif 'receive' in sys.argv:
        receive_data(9000)

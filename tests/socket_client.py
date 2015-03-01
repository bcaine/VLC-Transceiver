#!/usr/bin/python

import socket
import sys
import struct

HOST="192.168.7.2"

def get_socket(port):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (HOST, port)
    print >>sys.stderr, 'connecting to %s port %s' % server_address
    sock.connect(server_address)
    return sock

def send_data(port, n):
    sock = get_socket(port)
    message = 'hello' * (n / 5)
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
    # Send 1 byte of junk so it has the client addr
    sock.sendall('a')

    while(True):
        received = sock.recv(100)

        if (len(received) == 4) and received == "DONE":
            break
        
        data += received
    
    print "Received data of length: {}".format(len(data))
    print data


def convert(n):

    if n[-1:] == 'k':
        return int(n[:-1]) * 10**3
    elif n[-1:] == 'm':
        return int(n[:-1]) * 10**6
    else:
        return int(n)

if __name__=="__main__":
    if len(sys.argv) == 3:
        num = convert(sys.argv[2])
    if 'send' in sys.argv:
        send_data(9000, num)
    elif 'receive' in sys.argv:
        receive_data(9000)

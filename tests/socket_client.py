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

if __name__=="__main__":
    send_data(9000)

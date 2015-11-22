# We want to add compiler settings for our different platforms
CCPP = g++
CC = gcc
CFLAGS = -Wall -I ./include 
CPFLAGS = $(CFLAGS)
LIBS =

packet_o = Packetize.o
queue_o = ByteQueue.o
golay_o = Golay.o
fec_o = ForwardErrorCorrection.o $(golay_o)
realtime_o = RealtimeControl.o
socket_o = SocketConnection.o
transceiver_o = Transceiver.o $(fec_o) $(realtime_o) $(socket_o) $(queue_o) $(packet_o)
test_o = Test.o $(transceiver_o)
main_o = Main.o $(transceiver_o)
sockettest_o = SocketTest.o $(transceiver_o)

# -------------------------------
# Add release and debug modes with different flags


# -------------------------------

Transceiver.o: src/Transceiver.cpp
	$(CCPP) $(CFLAGS) -c src/Transceiver.cpp

ForwardErrorCorrection.o: src/ForwardErrorCorrection.cpp
	$(CCPP) $(CFLAGS) -c src/ForwardErrorCorrection.cpp

RealtimeControl.o: src/RealtimeControl.cpp
	$(CCPP) $(CFLAGS) -c src/RealtimeControl.cpp

SocketConnection.o: src/SocketConnection.cpp
	$(CCPP) $(CFLAGS) -c src/SocketConnection.cpp

Test.o: tests/Test.cpp
	$(CCPP) $(CFLAGS) -c tests/Test.cpp

SocketTest.o: tests/SocketTest.cpp
	$(CCPP) $(CFLAGS) -c tests/SocketTest.cpp

Golay.o: src/Golay.cpp
	$(CC) $(CFLAGS) -c src/Golay.cpp

ByteQueue.o: src/ByteQueue.cpp
	$(CC) $(CFLAGS) -c src/ByteQueue.cpp

Packetize.o: src/Packetize.cpp
	$(CC) $(CFLAGS) -c src/Packetize.cpp

Main.o: Main.cpp
	$(CC) $(CFLAGS) -c Main.cpp

test: clean $(test_o)
	$(CCPP) $(LIBS) -o test $(test_o)

sockettest: clean $(sockettest_o)
	$(CCPP) $(LIBS) -o sockettest $(sockettest_o)

main: clean $(main_o)
	$(CCPP) $(LIBS) -o main $(main_o)

all: test sockettest main

clean:
	-rm *.o test sockettest main

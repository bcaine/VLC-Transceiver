# We want to add compiler settings for our different platforms
CCPP = clang++
CC = clang
CFLAGS = -Wall -I ./include 
CPFLAGS = $(CFLAGS)
LIBS =

golay_o = golay.o
fec_o = ForwardErrorCorrection.o $(golay_o)
realtime_o = RealtimeControl.o
socket_o = SocketConnection.o
transceiver_o = Transceiver.o $(fec_o) $(realtime_o) $(socket_o)
test_o = Test.o $(transceiver_o)

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

golay.o: src/golay.c
	$(CC) $(CFLAGS) -c src/golay.c

test: clean $(test_o)
	$(CCPP) $(LIBS) -o test $(test_o)

all: test

clean:
	git submodule update --init --recursive
	-rm *.o test

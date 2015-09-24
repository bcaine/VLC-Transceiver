# We want to add compiler settings for our different platforms
CCPP = clang++
CC = clang
CFLAGS = -Wall -I ./longhair/include -I
CPFLAGS = $(CFLAGS)
LIBS =

longhair_o = cauchy_256.o
transceiver_o = transceiver.o $(longhair_o)
test_o = test.o $(transceiver_o)

# -------------------------------
# Add release and debug modes with different flags


# -------------------------------

cauchy_256.o : longhair/src/cauchy_256.cpp
	$(CCPP) $(CFLAGS) -c longhair/src/cauchy_256.cpp


transceiver_o: src/Transceiver.cpp
	$(CCPP) $(CFLAGS) -c src/Transceiver.cpp

test_o: test/test.cpp
	$(CCPP) $(CFLAGS) -c tests/Test.cpp

test: clean $(test_o)
	$(CCPP) $(LIBS) -o test $(test_o)

all: test

clean:
	git submodule update --init --recursive
	-rm *.o

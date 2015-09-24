# We want to add compiler settings for our different platforms
CCPP = clang++
CC = clang
CFLAGS = -Wall -I ./longhair/include -I
CPFLAGS = $(CFLAGS)
LIBS =

longhair_o = cauchy_256.o
tranceiver_o = tranceiver.o $(longhair_o)
test_o = test.o $(tranceiver_o)

# -------------------------------
# Add release and debug modes with different flags


# -------------------------------

cauchy_256.o : longhair/src/cauchy_256.cpp
	$(CCPP) $(CFLAGS) -c longhair/src/cauchy_256.cpp


tranceiver_o: src/Tranceiver.cpp
	$(CCPP) $(CFLAGS) -c src/Tranceiver.cpp

test_o: test/test.cpp
	$(CCPP) $(CFLAGS) -c test/test.cpp

test: clean $(test_o)
	$(CCPP) $(LIBS) -o test $(test_o)

all: test

clean:
	git submodule update --init --recursive
	-rm *.o

# Visible Light Communication Transceiver
This software package is intended to perform the transmitting and receiving functionality needed to transmit data via Visible Light Communication using a [Beaglebone Black](http://beagleboard.org/black). This project is for our Senior Capstone at Northeastern University in Boston.


## Table of Contents
- [Basic Overview](#overview)
- [Structure](#structure)
- [Limitations](#limitations-and-issues) 
- [Use](#use)
- [Testing](#testing)

## Overview

The majority of the code is (messy) C++ and [PRU Assembly](http://processors.wiki.ti.com/index.php/PRU_Assembly_Instructions).

Barring hardware restrictions, this code should transmit data at 1MHz with about a 1/2 coding rate (12/23), giving us a transfer rate of about 520 kbit/s (or about 65 kB/s).

This code should be used in conjunction with a LED circuit capable of cleanly modulating LEDs using [On-off Keying](https://en.wikipedia.org/wiki/On-off_keying), and a photodiode based receiver circuit with appropriate optical and electrical filtering, amplification etc.
This project provides two distinct sets of functionality; transmitting and receiving. Both modes require both the C++ and Assembly code to work in unison.

The Linux portion of the Beaglebone (the C++ code) does data encoding and decoding, packetization, and memory management. We then use the two [Programmable Realtime Units](http://beagleboard.org/pru) on the Beaglebone, which are two 200MHz 32-bit processors that have access to the pins and the ability to do direct memory access to the Beaglebone's RAM. The transmitter and receiver PRU code is all written in assembly.

Data is passed from and to the host computer over USB using sockets. The Beaglebone sets itself up as a networked device when attached to a computer, and allows standard network internet protocols.

#### Basics

Data is sent in 88 byte packets, with the first byte being a preamble (currently 11111111) followed by 87 bytes of encoded data.

The receiver has to continuously search for the preamble when not reading in data. The preamble helps prevent clock drift, align our sampling, and prevent us from trying to receive data that's not really data.

Each bit should have a width of 1μs.

#### Transmitter

(Excluding descriptions of what the PRUs are doing)

1. Initialize the memory (mmap "/dev/mem"... which is less than ideal)
2. Get the size of the incoming data from the Host via USB (Sockets)
3. Receive Data from Host via USB (Sockets)
4. Packetize data (45 byte packets: 2 byte length, 43 bytes data)
5. Encode data using the [perfect binary Golay Code](https://en.wikipedia.org/wiki/Binary_Golay_code) which transforms 12 bits into 23 encoded bits. This allows us to fix 3 bit errors per 23 bit block when decoding.
6. Add encoded data to memory up until the limit (16kb), and then put the rest in a queue.
7. Start the PRUs
8. Watch the PRU, and backfill data from the queue behind it to make sure it churns through all the data and doesn't just spit out random data from RAM.
9. Clean up: Shut down PRU, Close Memory, Close Socket etc.


#### Receiver

(Excluding descriptions of what the PRUs are doing)

1. Initialize the memory (mmap "/dev/mem" again...)
2. Initialize the PRUs
3. Watch their cursor, when new packets are available, put decode them, depacketize them, and put them in a buffer.
4. When this buffer reaches a certain size, send this via USB to the Host computer (via Sockets).
5. Clean up: Shut down PRU, Close Memory, Close Socket ect.


## Structure

The main sections of our codebase are as follows: 

	Main.cpp   - Main file to run to initialize Transmitting or Receiving.
	asm        - Directory containing all our Transmitter or Receiver assembly for the PRU
	assembler  - A slightly modified nonstandard assembler enabling some crucial functionality
	include    - Header files for our C++ code
	src        - Source code for our C++ code
	tests      - Tests for both assembly and C++
	
	
## Limitations and Issues

1. We are unable to mmap more than 16kb of /dev/mem for use communicating between the PRU and Linux Partition. MMapping /dev/mem in general seems non-ideal and dangerous, but this seems to be the standard doing this in the Beaglebone community. We are unsure of another way to do DMA without doing this. This limit makes transmitting more data require special care, like our overflow queue. 

## Use

#### Compiling
The C++ code can be built using the Makefile
	
	$ make all

You then still need to build the Assembly using pasm (the PRU assembler). You will need to install the assembler in the assembler/ directory (see documentation for that). Assembling the Transmitter and Receiver Assembly code should be done from the appropriate directory (asm/tx/ or asm/rx/). We should encorporate this into the Makefile, but for now it has to be done manually.

	$ cd asm/tx/
	$ pasm -b pru0.p
	$ pasm -b pru1.p

	$ cd ../rx/
	$ pasm -b pru0.p
	$ pasm -b pru1.p

Usage is straightforward, with two options.
	
	
    $ ./main 
	Options:
		transmit    - Transmit data (receive from socket, send as light).
		receive     - Receive data (read from photodiode circuit, send via socket).
		
	$ ./main transmit
	Starting Transceiver in transmit mode.
	Starting Transmit

For a quick demo, you can use the hacked together python script in tests/socket_client.py to test the functionality of either unit. Edit this file to point towards the correct IP address and port. To test the Transmitter, you can start up the transmitter on the beaglebone (see above) and then run the python script:

	python tests/socket_client.py send 10k
	
This will send 'a' 10,000 times, giving us 10kb of data. The Transmitter should load this data into memory and modulate the GPIO. If hooked up to an oscilloscope, you should see the data as a waveform. If hooked up to an LED, expect it to dim for a short period of time. 

## Testing

Other than the above functional test using the python script, there are a handful of tests for both the C++ and Assembly side.

#### C++ Tests

* Test.cpp ("test" when compiled) - Should test basic functionality like data encoding and decoding, packetization, data queue and memory usage, etc.
* SocketTest.cpp ("sockettest" when compiled) - Tests Socket Library. Currently not functional with current communication scheme. 
* PruTest.cpp ("prutest" when compiled) - Tests writing data to Memory, and having the PRU write back different data (all 'a's). May need to compile Assembly file tests/interface/prutest.p from its directory using pasm -b prutest.p

#### Assembly Tests

* GPIO/sqWave ("testSqWave" when compiled) - Tests PRU GPO by modulating a 1MHz square wave.
* GPIO/dataOut ("testDataOut" when compiled) - Tests PRU GPO by modulating a given bit pattern at 1MHz.
* Memory/ddr ("testDDR_PRU0" and "testDDR_PRU1" when compiled) - Test PRU external memory access, read and write.
* Memory/pram ("testPRAM_Write0_Read1" and "testPRAM_Write1_Read0" when compiled) - Test PRU shared memory access, the former writing from PRU0 and reading with PRU1 and the latter testing the opposite.
* XFR/xfrDDR ("testxfrDDR" when compiled) - Test XFR data transfer between PRUs, checking the bytes received vs. the bytes sent.
* XFR/xfrGPIO4 ("testxfrGPIO4" when compiled) - Test timing of XFR data transfer with size of 4 bytes. Requires GPO examination with scope to determine cycle cost of XFR.
* XFR/xfrGPIO88 ("testxfrGPIO88" when compiled) - Test timing of XFR data transfer with full size of 88 bytes (1 packet). Requires GPO examination with scope to determine cycle cost of XFR.





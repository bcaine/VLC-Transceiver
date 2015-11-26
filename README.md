# Visible Light Communication Transceiver
This software package is intended to perform the transmitting and receiving functionality needed to transmit data via Visible Light Communication using a [Beaglebone Black](http://beagleboard.org/black). This project is for our Senior Capstone at Northeastern University in Boston.


* [Basic Overview](#Overview)
	* [Transmitter](#Transmitter)
	* [Receiver](#Receiver)
* [Structure](#Structure)
* [Limitations](#Limitations-and-Issues) 
* [Use](#Use)
* [Testing](#Testing)

## Overview

The majority of the code is (messy) C++ and [PRU Assembly](http://processors.wiki.ti.com/index.php/PRU_Assembly_Instructions#Quick_Branch_if_Not_Equal_.28QBNE.29).

Barring hardware restrictions, this code should transmit data at 1MHz with about a 1/2 coding rate (12/23), giving us a transfer rate of about 520 kbit/s (or about 65 kb/s).

This code should be used in conjunction with a LED circuit capable of cleanly modulating LEDs using [On-off Keying](https://en.wikipedia.org/wiki/On-off_keying), and a photodiode based receiver circuit with appropriate optical and electrical filtering, amplification etc.
This project provides two distinct sets of functionality; transmitting and receiving. Both modes require both the C++ and Assembly code to work in unison.

The Linux portion of the Beaglebone (the C++ code) does data encoding and decoding, packetization, and memory management. We then use the two [Programmable Realtime Units](http://beagleboard.org/pru) on the Beaglebone, which are two 200MHz 32 bit processors that have access to the pins and the ability to do direct memory access to the Beaglebone's RAM. The transmitter and receiver PRU code is all written in assembly.

Data is passed from and to the host computer over USB using sockets. The Beaglebone sets itself up as a networked device when attached to a computer, and allows standard network internet protocols.

#### Transmitter

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


## Testing



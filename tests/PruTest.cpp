#include "RealtimeControl.hpp"
#include "ByteQueue.hpp"
#include "Util.hpp"
#include <cstdlib>
#include <iostream>
#include <cstring>
#include <iomanip>
#include <sys/mman.h>
#include <stdio.h>
// For handler
#include <execinfo.h>
#include <signal.h>
#include <stdlib.h>

// Driver header file
#include "prussdrv.h"
#include <pruss_intc_mapping.h>	 

#define DDR_BASEADDR     0x80000000
#define OFFSET_DDR	 0x00001000 

using namespace std;

static int mem_fd;
static void *ddrMem;

void handler(int sig) {
  void *array[10];
  size_t size;

  // get void*'s for all entries on the stack
  size = backtrace(array, 10);

  // print out all the frames to stderr
  fprintf(stderr, "Error: signal %d:\n", sig);
  backtrace_symbols_fd(array, size, 2);
  exit(1);
}

void StupidTest() {
  ByteQueue queue(4);


  cout << "Data is: " << queue._data << endl;
  *(unsigned long*)queue._data = 0xabcd;

  RealtimeControl pru;

  pru.InitPRU();
  pru.Transmit();


  cout << "Out: " << hex << (*(unsigned long*)queue._data);
  cout << endl;
}

void PacketTest() {
  ByteQueue queue(200);
  
  // Generate all 'a's
  uint8_t *data = new uint8_t[200];
  uint8_t *out = new uint8_t[200];

  for (int i = 0; i < 200; i++) {
    data[i] = 'a';
  }

  queue.push(data);

  queue.pop(out);
  cout << "Data in queue: " << out << endl;

  RealtimeControl pru;

  pru.InitPRU();
  pru.Transmit();

  queue.pop(out);
  cout << "Output after PRU is: " << out << endl;
}

void MemTest() {
  signal(SIGSEGV, handler);   // install our handler

  RealtimeControl pru;

  if (!pru.OpenMem()) {
    cout << "Failed to open Memory" << endl;
  }

  uint8_t *data = new uint8_t[87];
  uint8_t *out = new uint8_t[87];

  for (int i = 0; i < 87; i++) {
    data[i] = 'a';
  }

  memcpy(data, pru.data, 87);

  /*
  for (int i = 0; i < 22; i++) {
    *((unsigned long*) pru.data + i) = 0xff;
    }*/

  pru.InitPRU();
  pru.Transmit();
  
  
  cout << "About to try to print out data" << endl;
  cout << pru.data << endl;

  for(int i =0; i < 22; i++) {
    printf("C-side wrote: %x\n", *((unsigned long*) pru.data + i));
  }

  /*

  memcpy(pru.data, out, 87);
  for(int i =0; i < 87; i++) {
    printf("C-side wrote: %x\n", out[i]);
  }
  */

  cout << out << endl;

  pru.CloseMem();
}

int main() {
  MemTest();
  // PacketTest();
  return 0;
}

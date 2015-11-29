#include "RealtimeControl.hpp"
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


using namespace std;

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

void MemTest() {
  signal(SIGSEGV, handler);   // install our handler

  RealtimeControl pru;

  if (!pru.OpenMem()) {
    cout << "Failed to open Memory" << endl;
  }

  uint8_t *data = new uint8_t[87];
  uint8_t *out = new uint8_t[87];

  for (int i = 0; i < 87; i++) {
    data[i] = '\xbb';
  }

  memcpy(pru.data(), data, 87);

  cout << "Initing the PRU" << endl;
  pru.InitPRU();
  pru.Test();
  
  cout << "About to try to print out data" << endl;
  cout << pru.data() << endl;

  /*
  for(int i =0; i < 22; i++) {
    printf("C-side wrote: %x\n", *((unsigned long*) pru.data + i));
  }
  */


  memcpy(out, pru.data(), 87);

  for(int i =0; i < 87; i++) {
    printf("C-side wrote: %x\n", out[i]);
  }

  pru.CloseMem();
  delete[] data;
  delete[] out;
}

void QueueTest() {
  signal(SIGSEGV, handler);   // install our handler

  RealtimeControl pru;

  cout << "Opening Mem" << endl;

  if (!pru.OpenMem()) {
    cout << "Failed to open Memory" << endl;
  }

  uint8_t *data = new uint8_t[87];
  uint8_t *out = new uint8_t[87];

  for (int i = 0; i < 87; i++) {
    data[i] = 'b';
  }
  
  pru.push(data);

  pru.InitPRU();
  pru.Test();
  
  cout << "About to try to print out data" << endl;
  cout << pru.data() << endl;
  
  pru.setCursor(0);

  pru.pop(out);

  for(int i =0; i < 87; i++) {
    printf("C-side wrote: %x\n", out[i]);
  }

  pru.CloseMem();
  delete[] data;
  delete[] out;
}

int main() {
  // MemTest();
  QueueTest();
  return 0;
}

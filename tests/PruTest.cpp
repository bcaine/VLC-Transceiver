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
#include <assert.h>

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
    pru.InitPru();
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

    pru.InitPru();
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

void WritebackTest() {
    signal(SIGSEGV, handler);   // install our handler

    RealtimeControl pru;

    cout << "Opening Mem" << endl;

    if (!pru.OpenMem()) {
        cout << "Failed to open Memory" << endl;
    }


    uint32_t packet_num = 500;
    uint32_t packetlen = 87;

    uint8_t *data = new uint8_t[packetlen * packet_num];
    uint8_t *out = new uint8_t[packetlen];

    pru.setLength(packet_num);

    for (uint32_t n = 0; n < packet_num; n++) {
        for (int i = 0; i < packetlen; i++) {
            data[i + (n * packetlen)] = n;
        }
        pru.push(data + (n * packetlen));
    }

    pru.InitPru();
    pru.Test();

    // Set cursor back to 0, and check every packet
    // to see if every value is .inverted
    pru.setCursor(0);

    bool flag = true;
    uint8_t header;
    // Check that each value is the opposite it should be
    for (uint32_t n = 0; n < packet_num; n++) {
        header = *pru.peek();
        pru.pop(out);
        for (int i = 0; i < packetlen * 8; i++) {
            flag = getBit(data + (n * packetlen), i) != getBit(out, i);


            if (!flag) {
                cout << "Packet Number: " << n << endl;
                cout << "Bit num: " << i << endl;
                cout << "In bit: " << getBit(data + (n * packetlen), i) << endl;
                cout << "Out bit: " << getBit(out, i) << endl;

                cout << "Binary of Data: " << endl;
                for(int g = 0; g < 8; g++)
                    cout << getBit(&header, g);
                for (int blah = 0; blah < packetlen * 8; blah ++) {
                    cout << getBit(data, blah);
                }

                cout << endl;

                cout << "Binary of Out: " << endl;
                for(int g = 0; g < 8; g++)
                    cout << getBit(&header, g);
                for (int blarg = 0; blarg < packetlen * 8; blarg ++) {
                    cout << getBit(out, blarg);
                }
            }

            assert(flag);
        }
        memset(out, 0, packetlen);
    }

    pru.CloseMem();
    delete[] data;
    delete[] out;
}

int main() {
    // MemTest();
    // QueueTest();
    WritebackTest();
    return 0;
}
?

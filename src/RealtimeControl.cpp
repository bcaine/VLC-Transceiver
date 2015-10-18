/* Implementations of RealtimeControl.hpp
   This should control initialization/data sharing with the PRU

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "RealtimeControl.hpp"

RealtimeControl::RealtimeControl(int buffer_size) {
  _buffer_size = buffer_size;
  // TODO:
  // - Init PRU information, call InitPRU?
  // - Init buffer
}

RealtimeControl::~RealtimeControl() {
  // Delete Buffer
}

void RealtimeControl::Write(char *data) {
  // TODO
}

void RealtimeControl::Read(char *data) {
  // TODO
}

bool RealtimeControl::InitPRU() {
  // TODO
  return true;
}

/* Implementations of RealtimeControl.hpp
   This should control initialization/data sharing with the PRU

   Author: Ben Caine
   Date: October 17, 2015
*/

#include "RealtimeControl.hpp"

RealtimeControl::RealtimeControl() {
  // TODO:
  // - Init PRU information, call InitPRU?
  // - Init buffer
}

RealtimeControl::~RealtimeControl() {
  // Delete Buffer
}

bool RealtimeControl::InitPRU() {
  // TODO
  return true;
}

bool RealtimeControl::Done() {
  // TODO CHANGE THIS TO ACTUALLY DO SOMETHING
  return false;
}

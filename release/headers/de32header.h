// Будущий сишный хедер к DEmbro
// Пока что только windows

#pragma once

#include <windows.h>
#include <stdint.h>

typedef void*    dePointer;
typedef uint32_t u32;
typedef int32_t  i32;

const u32  DE_FALSE                      = 0;
const u32  DE_TRUE                       = (u32)-1;

const u32  DE_OK                         = 0;
const u32  DE_ERR_UNKNOWN_SOURCE_TYPE    = (u32)-1;

const u32  DE_SOURCE_PCHAR               = 1;
const u32  DE_SOURCE_FUNC                = 2;
const u32  DE_SOURCE_FILE                = 3;

typedef void            (__stdcall *TdeVersion)(u32&, u32&);
typedef dePointer       (__stdcall *TdeCreateMachine)();
typedef void            (__stdcall *TdeFreeMachine)(dePointer);
typedef i32             (__stdcall *TdeInterpret)(dePointer, i32, const char*);
typedef void            (__stdcall *TdeAddCommand)(dePointer, const char*, dePointer, dePointer, u32);

TdeVersion deVersion;
TdeCreateMachine deCreateMachine;
TdeFreeMachine deFreeMachine;
TdeInterpret deInterpret;
TdeAddCommand deAddCommand;

HMODULE lib = 0;

bool deLibReady() {
  return lib != 0;
}

bool deLibLoad(const char* filename) {
#define LOADFUNC(name) \
  name = (T##name)GetProcAddress(lib, #name); \
  if (&name == NULL) \
    return false;

  lib = LoadLibrary(filename);
  LOADFUNC(deVersion);
  LOADFUNC(deCreateMachine);
  LOADFUNC(deFreeMachine);
  LOADFUNC(deInterpret);
  LOADFUNC(deAddCommand);
  return true;
#undef LOADFUNC
}

void deLibFree() {
  if (lib != 0) {
    FreeLibrary(lib);
    lib = 0;
  }
}

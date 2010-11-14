#include "..\dec.h"

const char* NAME = "deArhimag";

EXPORT void  decInfo(void** name, int* type, int* version)
{
  //printf("decInfo\n");
  //*name         = (void*)NAME;
  //*type         = 1;
  //*version      = 0;
}

EXPORT void  decSetParam(int id, int type, void* val, int size)
{
}

EXPORT void  decCompile()
{
}

EXPORT int   decError(int* id, int* pos)
{
  return 0;
}

EXPORT char* decErrorString(int id)
{
  return 0;
}

EXPORT void  decParse(const char* format, ...)
{
}

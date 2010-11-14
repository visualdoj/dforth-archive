#include "..\dec.h"

const char* NAME = "deArhimag";

EXPORT void  decInfo(const char** name, int* type, int* version)
{
  //printf("decInfo\n");
  *name         = NAME;
  *type         = 1;
  *version      = 0;
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

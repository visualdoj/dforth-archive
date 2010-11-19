#include <stdio.h>
#include "..\dec.h"
#include "examples.cpp"

const char* NAME = "deArhimag";

int apptype; // DEC_ID_OUTPUT
char output[1024*16]; // DEC_ID_OUTPUT
commands_t commands; // DEC_ID_CODE
int commandscount;
code_t* code; // DEC_ID_CODE

typedef struct error_s {
  int id;
  int pos;
} error_t; 

error_t errors[1024];
int errorlast = 0;
int errorfirst = 0;

char* errorstr[] = {
                     "no errors",
                     "not supported this apptype"
                   };

void DumpBytes(FILE* f, int len, unsigned char* bytes)
{
  for(int i = 0; i < 2*len; ++i)
    fprintf(f, "%x", bytes[i]);
}

void DumpUint(FILE* f, int len, unsigned char* bytes)
{
  for(int i = 2*len - 1; i >= 0; --i)
    fprintf(f, "%2.2x", bytes[i]);
}

void DumpCode()
{
  unsigned int pos = 0;
  FILE* f;
  f = fopen("temp~", "wt");
  for (int i = 0; i < code->count; ++i) {
    DumpUint(f, 2, (unsigned char*)&pos);
    if (IsChunkData(code->chunks[i]))
      fprintf(f, ": %d", code->chunks[i].len);
    else
      fprintf(f, ": %s ", commands[code->chunks[i].opcode].name);
    DumpBytes(f, code->chunks[i].len, code->chunks[i].data);
    fprintf(f, "\n");
    pos += GetChunkSize(code->chunks[i]);
  }
  fclose(f);
}

void AddError(int id, int pos)
{
  errors[errorlast].id = id;
  errors[errorlast].pos = pos;
  ++errorlast;
}

EXPORT void  decInfo(const char** name, int* type, int* version)
{
  //printf("decInfo\n");
  *name         = NAME;
  *type         = 1;
  *version      = 0;
}

EXPORT void  decSetParam(int id, int type, void* val, int size)
{
  if (type == TYPE_INT) {
  } else if (type == TYPE_STR)
    switch (id) {
      case ID_OUTPUT: /* копирование из val в output */ ; break;
    }
  else if (type == TYPE_DATA)
    switch (id) {
      case ID_CODE: code = (code_t*)val; break;
      case ID_COMMANDS: commands = (commands_t)val;
                        commandscount = size; break;
    }
}

EXPORT void  decCompile()
{
  DumpCode();
  if (apptype != APPTYPE_CONSOLE && apptype != APPTYPE_GUI) {
    AddError(1, 0);
    return;
  }
}

EXPORT int   decError(int* id, int* pos)
{
  int flag = errorlast - errorfirst > 0;
  if (flag) {
    *id = errors[errorfirst].id;
    *pos = errors[errorfirst].pos;
    ++errorfirst;
  }
  return flag;
}

EXPORT char* decErrorString(int id)
{
  return errorstr[id];
}

EXPORT void  decParse(const char* format, ...)
{
}


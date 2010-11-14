#ifndef _H_DEC_
#define _H_DEC_

// params' type
const int TYPE_INT              = 1;
const int TYPE_STR              = 2;
const int TYPE_DATA             = 3;

// params' id
const int ID_APPTYPE            = 1;
const int ID_OUTPUT             = 2;
const int ID_COMMANDS           = 3;
const int ID_CODE               = 4;

// ID_APPTYPE
const int APPTYPE_CONSOLE       = 1;
const int APPTYPE_GUI           = 2;

// ID_COMMANDS
typedef struct command_s {
  char* name; // ��� �������
  int flags; // �����; bit0 �������� �� ������� immediate
             // bit1 �������� �� ������� ����������, ��� ��� �������� ��������
             // � ������ ������ ��� ����� ������������ ��������, �� ������
             // �� ������ � ����� code
  int code; // ����� ����� � embro, ������� � �������� ��� ��������
  int data; // ����� ����� � embro, ������� � �������� ��������� ������ ��� ������
} command_t;
typedef command_t* commands_t;

// ID_CODE
typedef struct code_s {
  void* embro;
  int* opcodes;
  int* refs;
} code_t;

#define EXPORT extern "C" __declspec(dllexport) __attribute__((stdcall))

EXPORT void  decSetParam(int id, int type, void* val, int size);
EXPORT void  decCompile();
EXPORT int   decError(int* id, int* pos);
EXPORT char* decErrorString(int id);
EXPORT void  decParse(const char* format, ...);
#endif

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
  // Имя команды
  char*                 name; 
  // флаги; bit0 является ли команда immediate
  // bit1 является ли команда встроенной, или она является функцией
  // в первом случае код будет сгенерирован плагином, во втором
  // он указан в полне code
  // См. cf* defines
  int flags; 
  // номер байта в embro, начиная с которого идёт описание
  unsigned int          code; 
  // номер байта в embro, начиная с которого находятся данные для команд
  unsigned int          data; 
} command_t;
typedef command_t* commands_t;

// command flags
#define cfI(x) (((x).flags & 1) > 0)
#define cfB(x) (((x).flags & 2) > 0)

// ID_CODE
const unsigned int EMBRO_DATA           = 0;
const unsigned int EMBRO_CODE           = 1;

typedef struct chunk_s {
  unsigned int          opcode;
  unsigned int          len; // bytes in data
  unsigned char*        data;
  // если (opcode == 0 && len == 0), то это вызов nop 
  //     (команда, которая ничего не делает)
  // если (opcode == 0 && len != 0), то это чанк с данными
  // если (opcode != 0), то это чанк вызова команды
  //     data является указателем на параметры команды, len их размер в байтах
  // см. examples.cpp

  // Косвенные указатели на шитый код
  // Каждый указатель имеет тип unsigned int
  // refs[i] является отступом в data до указателя
  // Фактически, указатель получается по формуле 
  //                                       *((unsigned int*)(&data[refs[i]]))
  unsigned int          rcount; // кол-во
  unsigned int*         refs; // отступы в data
} chunk_t;

typedef struct code_s {
  // Чанки
  unsigned int          count; // кол-во
  chunk_t*              chunks; // массив
} code_t;

#define EXPORT extern "C" __declspec(dllexport) __attribute__((cdecl))

// в type должно быть возвращено 1
// в version два младших разряда — minor часть, остальное — major-часть
// Например version==1234 означает версию 12.34
EXPORT void  decInfo(const char** name, int* type, int* version);
EXPORT void  decSetParam(int id, int type, void* val, int size);
EXPORT void  decCompile();
EXPORT int   decError(int* id, int* pos);
EXPORT char* decErrorString(int id);

extern "C" __declspec(dllexport) __attribute__((cdecl)) 
       void  decParse(const char* format, ...);
#endif

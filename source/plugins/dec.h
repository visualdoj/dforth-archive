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
  int flags; 
  // номер байта в embro, начиная с которого идёт описание
  unsigned int          code; 
  // номер байта в embro, начиная с которого находятся данные для команд
  unsigned int          data; 
} command_t;
typedef command_t* commands_t;

// ID_CODE
const unsigned int EMBRO_DATA           = 0;
const unsigned int EMBRO_CODE           = 1;

// Чаники типа DATA являются недилимыми, их нужно оставить в таком виде,
// в каком они и были
// Чаники типа CODE можно разрезать там, где начинается какой-то опкод
// При этом нужно не забывать, что важно сохранить порядок выполняемых
// действий и менять ссылки, расположение которых указано в массиве refs
typedef struct chunk_s {
  unsigned int          pos;
  unsigned int          type; // см. EMBRO_* константы
  unsigned int          size;
  // Только при type==EMBRO_CODE
  // Массив номеров байтов, начиная с которых находятся 
  // опкоды вызова команд данного чанка
  // Все опкоды являются 32-битными числами.
  // Опкод — номер команды в таблице ID_COMMANDS.
  // Их нужно менять при изменении в таблицы команд
  //
  // Пример получения нулевого опкода: 
  // unsigned int op = *(&embro[opcodes[0]])
  unsigned int*         opcodes; 
  unsigned int          ocount;
} chunk_t;

typedef struct code_s {
  // указатель на шитый код
  unsigned char*        embro;
  // Чанки
  chunk_t*              chunks;
  unsigned int          ccount;
  // массив указателей на места, где находятся embro-указатели
  // все embro-указатели являются 32-битными числами 
  // embro-указатель — номер байта в embro, на который ссылаются
  // 
  // Пример получения нулевого embroptr: 
  // unsigned int embropts = *(&embro[refs[0]])
  unsigned int*         refs;
  unsigned int          rcount;
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

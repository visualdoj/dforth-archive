#ifndef _H_DEC_
#define _H_DEC_

#include<stdint.h>

//{{{ consts
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
//}}}
//{{{ types
typedef unsigned int uint;

// ID_COMMANDS
typedef struct command_s {
  // Имя команды
  char*                 name; 
  // флаги; bit0 является ли команда immediate
  // bit1 является ли команда встроенной, или она является функцией
  // bit2 является ли команда noname
  // в первом случае код будет сгенерирован плагином, во втором
  // он указан в полне code
  // См. cf* defines
  int flags; 
  // номер байта в embro, начиная с которого идёт описание
  unsigned int          code; 
  // номер байта в embro, начиная с которого находятся данные для команд
  unsigned int          data; 
  // определяющее слово, которым создана данная команда
  unsigned int          parent;
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
  int                   flags;
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
  unsigned int*         r; // отступы в data

  unsigned int          xcount;
  unsigned int*         x;

  unsigned int          ocount;
  unsigned int*         o;

  unsigned int          pcount;
  unsigned int*         p;
} chunk_t;

typedef struct code_s {
  // Чанки
  unsigned int          count; // кол-во
  chunk_t*              chunks; // массив
} code_t;
//}}}
//{{{ dev kit
// Является ли чанк данными
bool IsChunkData(const chunk_t& chunk) 
{ 
  return (chunk.opcode == 0 && chunk.len != 0);
}

// Есть ли у чанка поля rcount, r, xcount и т.д.
bool IsChunkInteresting(const chunk_t& chunk) 
{ 
  return (chunk.flags & 1) > 0;
}

// Вычисление размера, занимаемого чанком в шитом коде
//   В случае, если это чанк вызова команды, нужно ещё учесть место,
//   занимаемое опкодом команды
uint GetChunkSize(chunk_t& chunk) 
{ 
  return chunk.len + (IsChunkData(chunk)?0:sizeof(unsigned int)); 
}

// Вычисление номера байта (embroptr) начала чанка с номером index
// Вернёт -1, если index не является индексом никакого чанка
// Работает за O(index)
int GetChunkPos(const code_t& code, int index)
{
  int pos = 0;
  if (0 > index || index >= code.count)
    return -1;
  for (int i = 0; i < index-1; ++i)
    pos += GetChunkSize(code.chunks[i]);
  return pos;
}

// Вычисление номера байта (embroptr) начала чанка с номером index
// Вернёт -1, если index не является индексом никакого чанка
// Работает только в случае, если данные в памяти лежат последовательно, 
// в противном случае результат неопределён
// Работает за O(1)
int GetChunkPosFlat(const code_t& code, int index)
{
  if (code.count == 0)
    return -1;
  else
    return (uint)code.chunks[index].data - (uint)code.chunks[0].data;
}
//}}}

// Неоднородные данные
// Если embro[i].type == ET_DATA, то участок памяти начиная
// с &embro[i+1] размером embro[i].size байт хранит данные, 
// которые нужно сохранить в первозданном виде
// Следующий значимый embroitem находится в 
//   embro[i + embro[i].size/sizeof(embroitem_t) + 1 + 
//                      embro[i].size%sizeof(embroitem_t)==0?0:1]
// Если последовательно идут два ET_DATA блока, то после преобразования
// шитого кода они должны остаться последовательными
const uint8_t ET_DATA               = 0;
// Опкод команды на выполнение
// В val хранится опкод команды
// При преобразованиях таблицы команд следует обновлять все опкоды
const uint8_t ET_OPCODE             = 1;
// Опкод команды в качестве параметра другой команды
// В val хранится опкод
// При преобразованиях таблицы команд следует обновлять все опкоды
const uint8_t ET_PARAM_OPCODE       = 2;
// Указатель на место в коде
// Если embro[i].type == ET_EMBRO_PTR, то 
// указатель ссылается на embro[embro[i].val]
// При преобразованиях кода следует обновлять ембро-указатели
const uint8_t ET_EMBRO_PTR          = 3;
// Указатель на XT-команду, хранится в val
const uint8_t ET_XT                 = 4;
// Указатель на какую-то область данных
const uint8_t ET_PTR                = 5;
// Параметр команды -- умещается в 1 ячейку и не требует своего изменения
// при всяких преобразованиях. Например, (literal) использует параметр такого
// типа
const uint8_t ET_PARAM              = 6;

typedef struct embroitem_s {
  // 1 cell (32 bits) -- header
  uint8_t       type; // ET_* constants 
  uint16_t      size; // for ET_DATA
  uint8_t       res;  // reserved
  // 1 cell (32 bits) -- value
  int           val;
} embroitem_t;

typedef struct code_s {
  int count;
  embroitem_t* items;
} code_t;

#define EXPORT extern "C" __declspec(dllexport) __attribute__((cdecl))
//{{{ exports
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
//}}}
#endif

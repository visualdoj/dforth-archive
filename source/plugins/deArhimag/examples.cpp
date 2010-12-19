// Примеры подпрограмм

#include <stdlib.h>
#include "..\dec.h"

// Размер кода (сумма размеров всех чанков)
unsigned int GetCodeSize(code_t* code)
{
  unsigned int size = 0;
  for (int i = 0; i < code->count; ++i)
    size += GetChunkSize(code->chunks[i]);
  return size;
}
// Возвращает указатель в шитый код исходя из индексов
unsigned int GetEmbroPtr(code_t* code, int command, int refindex)
{
  return *((unsigned int*)&(code->chunks[command]
                          .data[code->chunks[command].r[refindex]]));
}

// Меняет указателя в шитом код исходя из индексов
void SetEmbroPtr(code_t* code, int command, int refindex, unsigned int val)
{
  *((unsigned int*)&(code->chunks[command]
                     .data[code->chunks[command].r[refindex]])) = val;
}

// Вычисление чанка, в который ссылается данный embroptr
//     code [in]
//       шитый код, в котором ищется чанк
//     ref [in]
//       шитый указатель (embroptr)
//     index [out]
//       номер чанка, на который указывает ref
//     offset [out]
//       смещение внутри чанка
//     возвращаемые значения
//       -1 - ссылка выходит за границы шитого кода
//       0  - ссылка на чанк с командой
//       1  - ссылка внутрь команды
//       2  - ссылка на данные
//       3  - ссылка во внутрь данных
int FindChunk(const code_t& code, unsigned int ref, int* index, int* offset)
{
  unsigned int pos = 0;
  unsigned int size;
  *offset = 0;
  for (*index = 0; *index < code.count; ++*index) {
    if (pos == ref)
      return IsChunkData(code.chunks[*index])?2:0;
    size = GetChunkSize(code.chunks[*index]);
    *offset = pos+size - ref;
    if (*offset > 0)
      return IsChunkData(code.chunks[*index])?3:1;
    pos += size;
  } 
  return -1;
}

// Скопировать код в собственную память
// Изначальный код трогать запрещенно
// Поэтому, если в него необходимо внести изменения, его нужно скопировать
//   embro
//     возвращает сырой шитый код
code_t* CopyCode(code_t* code, unsigned char** embro)
{
  *embro = (unsigned char*)malloc(GetCodeSize(code));
  code_t* other = (code_t*)malloc(sizeof(code_t));
  other->count = code->count;
  other->chunks = (chunk_t*)malloc(sizeof(chunk_t) * other->count);
  int pos = 0;
  for (int i = 0; i < other->count; ++i) {
    other->chunks[i].opcode = code->chunks[i].opcode;
    other->chunks[i].len = code->chunks[i].len;
    other->chunks[i].data = &((*embro)[pos]);
    other->chunks[i].rcount = code->chunks[i].rcount;
    other->chunks[i].r = (unsigned int*)malloc(sizeof(unsigned int)*
                                               other->chunks[i].rcount);
    for (int j = 0; j < other->chunks[i].rcount; ++j)
      other->chunks[i].r[j] = code->chunks[i].r[j];
    pos += GetChunkSize(code->chunks[i]);
  }
  return other;
}

// Удаление шитого кода из памяти
void FreeCode(code_t* code, unsigned char* embro)
{
  for (int i = 0; i < code->count; ++i)
    free(code->chunks[i].r);
  free(code->chunks);
  free(code);
  free(embro);
}

// Копирование таблицы команд
commands_t CopyCommands(int count, commands_t commands)
{
  commands_t res = (commands_t)malloc(sizeof(command_t) * count);
  for (int i = 0; i < count; ++i) {
    res[i].name = commands[i].name; // TODO: нужно понять нужно ли тут копировать?
                                    // если предполагается менять содержимое name,
                                    // то да, это нужно. Иначе не нужно
                                    // Главное -- помнить синхронизировать
                                    // это с освобождением в FreeCommands
    res[i].flags = commands[i].flags; 
    res[i].code = commands[i].code; 
    res[i].data = commands[i].data;
  }
  return res;
}

// Удаление таблицы команд
void FreeCommands(int count, commands_t commands)
{
  free(commands);
}

// Обновить косвенный указатель при перемещении какого-то участка шитого кода
//   ref - косвенный указатель
//   pos - начало переносимого участка кода
//   len - размер переносимого участка кода
//   newpos - новое положение участка кода
unsigned int GetUpdatedRef(unsigned int ref, unsigned int pos, unsigned int len,
                           unsigned int newpos)
{
  if (pos <= ref && ref < pos+len)
    return ref - pos + newpos;
}

void UpdateRef(unsigned int &ref, unsigned int pos, unsigned int len,
               unsigned int newpos)
{
  if (pos <= ref && ref < pos+len)
    ref = ref - pos + newpos;
}

// Предположим, что полуинтервал шитого кода [pos, pos+len) нужно перенести в
// [other, other+len)
// Нужно исправить все ссылки и таблицу команд
void UpdateEmbroRefsOnMove(code_t* code, int pos, int len, int other)
{
  for (int i = 0; i < code->count; ++i)
    for (int j = 0; j < code->chunks[i].rcount; ++j) {
      int ref = GetEmbroPtr(code, i, j);
      if (pos <= ref && ref < pos + len)
        SetEmbroPtr(code, i, j, ref - pos + other);
    }
}

// Исправление таблицы команд (в которой хранятся поля, ссылающиеся на
// шитый код)
void UpdateCommandsOnMove(int count, commands_t commands, unsigned int pos,
                          unsigned int len, unsigned int newpos)
{
  for (int i = 0; i < count; ++i)
    if (!cfB(commands[i])) {
      UpdateRef(commands[i].code, pos, len, newpos);
      UpdateRef(commands[i].data, pos, len, newpos);
    }
}

// Примеры подпрограмм

#include "..\dec.h"

// Является ли чанк данными
int IsChunkData(const chunk_t& chunk)
{
  return (chunk.opcode == 0 && chunk.len != 0);
}

// Вычисление размера, занимаемого чанком в шитом коде
//   В случае, если это чанк вызова команды, нужно ещё учесть место,
//   занимаемое опкодом команды
unsigned int GetChunkSize(const chunk_t& chunk)
{
  return chunk.len + (IsChunkData(chunk)?0:sizeof(unsigned int));
}

// Вычисление номера байта (embroptr) начала чанка с номером index
// Вернёт -1, если index не является индексом никакого чанка
int GetChunkPos(const code_t& code, int index)
{
  int pos = 0;
  if (0 > index || index >= code.count)
    return -1;
  for (int i = 0; i < index-1; ++i)
    pos += GetChunkSize(code.chunks[i]);
  return pos;
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

// ������� �����������

#include "..\dec.h"

// �������� �� ���� �������
int IsChunkData(const chunk_t& chunk)
{
  return (chunk.opcode == 0 && chunk.len != 0);
}

// ���������� �������, ����������� ������ � ����� ����
//   � ������, ���� ��� ���� ������ �������, ����� ��� ������ �����,
//   ���������� ������� �������
unsigned int GetChunkSize(const chunk_t& chunk)
{
  return chunk.len + (IsChunkData(chunk)?0:sizeof(unsigned int));
}

// ���������� ������ ����� (embroptr) ������ ����� � ������� index
// ����� -1, ���� index �� �������� �������� �������� �����
int GetChunkPos(const code_t& code, int index)
{
  int pos = 0;
  if (0 > index || index >= code.count)
    return -1;
  for (int i = 0; i < index-1; ++i)
    pos += GetChunkSize(code.chunks[i]);
  return pos;
}

// ���������� �����, � ������� ��������� ������ embroptr
//     code [in]
//       ����� ���, � ������� ������ ����
//     ref [in]
//       ����� ��������� (embroptr)
//     index [out]
//       ����� �����, �� ������� ��������� ref
//     offset [out]
//       �������� ������ �����
//     ������������ ��������
//       -1 - ������ ������� �� ������� ������ ����
//       0  - ������ �� ���� � ��������
//       1  - ������ ������ �������
//       2  - ������ �� ������
//       3  - ������ �� ������ ������
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

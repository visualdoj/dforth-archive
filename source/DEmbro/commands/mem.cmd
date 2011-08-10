DECLARE(malloc)
  var 
    P: Pointer;
  body(
    GetMem(P, WOI);
    WUP(P);)
SUMMARY ( size -- ptr) �������� ���������� ����� ����, ���������� ���������

DECLARE(free)
  body(FreeMem(WOP))
SUMMARY ( ptr) ����������� ���������� ����� ������� ������

DECLARE(realloc)
  var P: Pointer;
  body(
    Dec(WP, SizeOf(Pointer));
    Pointer(WVar(-SizeOf(Pointer))) := 
        ReAllocMem(Pointer(WP^), Integer(WVar(-SizeOf(Pointer))));)
SUMMARY ( ptr1 newsize -- ptr2) ������������ ������, �������� ������

DECLARE(move)
SUMMARY ( src dst size --) ��������� size ���� �� src � dst

DECLARE(fill)
SUMMARY ( dst size value --) ��������� size ���� �� ������ dst ��������� value 

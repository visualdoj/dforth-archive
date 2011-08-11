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
  body()
SUMMARY ( src dst size --) ��������� size ���� �� src � dst

DECLARE(fill0)
  body(
    Dec(WP, 2*SizeOf(Pointer));
    FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), 0);)
SUMMARY ( dst size --) ��������� size ���� �� ������ dst ������

DECLARE(fill)
body(
  Dec(WP, 3*SizeOf(Pointer));
  FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), Integer(WVar(2*SizeOf(Pointer))));
)
SUMMARY ( dst size value --) ��������� size ���� �� ������ dst ���������� Value

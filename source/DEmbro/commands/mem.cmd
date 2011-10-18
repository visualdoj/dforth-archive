DECLARE(malloc)
  var 
    P: Pointer;
  body(
    GetMem(P, WOI);
    WUP(P);)
RUS SUMMARY ( size -- ptr) �������� ���������� ����� ����, ���������� ��������� _SUMMARY

DECLARE(free)
  body(FreeMem(WOP))
RUS SUMMARY ( ptr) ����������� ���������� ����� ������� ������ _SUMMARY

DECLARE(realloc)
  var P: Pointer;
  body(
    Dec(WP, SizeOf(Pointer));
    Pointer(WVar(-SizeOf(Pointer))) := 
        ReAllocMem(Pointer(WP^), Integer(WVar(-SizeOf(Pointer))));)
RUS SUMMARY ( ptr1 newsize -- ptr2) ������������ ������, �������� ������ _SUMMARY

DECLARE(move)
  body( Dec(WP, SizeOf(Pointer)*3); Move(Pointer(WVar(0))^, Pointer(WVar(SizeOf(Pointer)))^, TUint(WVar(2*SizeOf(Pointer)))); )
RUS SUMMARY ( src dst size --) ��������� size ���� �� src � dst _SUMMARY

DECLARE(fill0)
  body(
    Dec(WP, 2*SizeOf(Pointer));
    FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), 0);)
RUS SUMMARY ( dst size --) ��������� size ���� �� ������ dst ������ _SUMMARY

DECLARE(fill)
body(
  Dec(WP, 3*SizeOf(Pointer));
  FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), Integer(WVar(2*SizeOf(Pointer))));
)
RUS SUMMARY ( dst size value --) ��������� size ���� �� ������ dst ���������� Value _SUMMARY

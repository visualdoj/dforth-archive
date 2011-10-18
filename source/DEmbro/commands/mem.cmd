DECLARE(malloc)
  var 
    P: Pointer;
  body(
    GetMem(P, WOI);
    WUP(P);)
RUS SUMMARY ( size -- ptr) выделяет переданное число байт, возвращает указатель _SUMMARY

DECLARE(free)
  body(FreeMem(WOP))
RUS SUMMARY ( ptr) освобождает выделенный ранее участок памяти _SUMMARY

DECLARE(realloc)
  var P: Pointer;
  body(
    Dec(WP, SizeOf(Pointer));
    Pointer(WVar(-SizeOf(Pointer))) := 
        ReAllocMem(Pointer(WP^), Integer(WVar(-SizeOf(Pointer))));)
RUS SUMMARY ( ptr1 newsize -- ptr2) перевыделяет память, сохраняя данные _SUMMARY

DECLARE(move)
  body( Dec(WP, SizeOf(Pointer)*3); Move(Pointer(WVar(0))^, Pointer(WVar(SizeOf(Pointer)))^, TUint(WVar(2*SizeOf(Pointer)))); )
RUS SUMMARY ( src dst size --) переносит size байт из src в dst _SUMMARY

DECLARE(fill0)
  body(
    Dec(WP, 2*SizeOf(Pointer));
    FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), 0);)
RUS SUMMARY ( dst size --) заполняет size байт по адресу dst нулями _SUMMARY

DECLARE(fill)
body(
  Dec(WP, 3*SizeOf(Pointer));
  FillChar(Pointer(WVar(0))^, Integer(WVar(SizeOf(Pointer))), Integer(WVar(2*SizeOf(Pointer))));
)
RUS SUMMARY ( dst size value --) заполняет size байт по адресу dst значениями Value _SUMMARY

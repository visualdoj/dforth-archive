DECLARE(malloc)
  var 
    P: Pointer;
  body(
    GetMem(P, WOI);
    WUP(P);)
SUMMARY ( size -- ptr) выделяет переданное число байт, возвращает указатель

DECLARE(free)
  body(FreeMem(WOP))
SUMMARY ( ptr) освобождает выделенный ранее участок памяти

DECLARE(realloc)
  var P: Pointer;
  body(
    Dec(WP, SizeOf(Pointer));
    Pointer(WVar(-SizeOf(Pointer))) := 
        ReAllocMem(Pointer(WP^), Integer(WVar(-SizeOf(Pointer))));)
SUMMARY ( ptr1 newsize -- ptr2) перевыделяет память, сохраняя данные

DECLARE(move)
SUMMARY ( src dst size --) переносит size байт из src в dst

DECLARE(fill)
SUMMARY ( dst size value --) заполняет size байт по адресу dst значением value 

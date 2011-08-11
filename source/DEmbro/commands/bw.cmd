    define(`cmdhdr', `(Machine: TForthMachine; Command: PForthCommand)')
    define(`WVar', `(Pointer(TUInt(Machine.WP) + ($1))^)')
    define(`LVar', `(Pointer(TUInt(LB) + ($1))^)')
    define(`WInc', `Inc(WP, $1)')
    define(`WDec', `Dec(TUInt(WP), $1)')
    define(`PSize', `(SizeOf(Pointer))')
    define(`CELL', `(SizeOf(Pointer))')
    define(`BInc', `Inc(BWP, CELL)')
    define(`BDec', `Dec(TUInt(BWP), CELL)')
    define(`BVar', `TBlock(Pointer(TUInt(Machine.BWP) + ($1)*CELL)^)')
    define(`bAddRef', ` if $1 <> nil then begin
                       if PInteger($1)^ <> -1 then Inc(PInteger($1)^); 
                     end')
    define(`bDelRef', ` if $1 <> nil then begin
                       if PInteger($1)^ > 1 then Dec(PInteger($1)^)
                       else if PInteger($1)^ = 1 then FreeMem(Pointer($1)); 
                     end')
    define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
    define(`body', `begin with Machine^ do begin $1 end; end;')

DECLARE(b@, bdog)
  body(
    WDec(CELL); 
    BVar(0) := TBlock(Pointer(WP^)^); 
    bAddRef(BVar(0));
    BInc;)

DECLARE(B!, bexclamation)
  body(
    WDec(CELL); 
    BDec; 
    bDelRef(TBlock(Pointer(WP^)^));
    TBlock(Pointer(WP^)^) := BVar(0);)

DECLARE(binc)
  body(
    WDec(CELL); 
    bAddRef(TBlock(Pointer(WP^)));)

DECLARE(bdec)
  body(
    WDec(CELL);
    bDelRef(TBlock(Pointer(WP^)));)

DECLARE(bdrop)
  body(
    BDec;
    bDelRef(BVar(0)); )

DECLARE(bdup)
  body(
    BVar(0) := BVar(-1);
    bAddRef(BVar(0));
    BInc; )

DECLARE(bnip)
  body(
    BDec;
    bDelRef(BVar(-1));
    BVar(-1) := BVar(0); )

DECLARE(bswap)
  body(
    BVar(0) := BVar(-1);
    BVar(-1) := BVar(-2);
    BVar(-2) := BVar(0); )

DECLARE(bover)
  body(
    BVar(0) := BVar(-2);
    bAddRef(BVar(0));
    BInc; )

DECLARE(btuck)
  body(
    BVar(0) := BVar(-1);
    BVar(-1) := BVar(-2);
    BVar(-2) := BVar(0);
    BInc;
    bAddRef(BVar(0)))

DECLARE(blrot)
  body( 
    BVar(0) := BVar(-3);  BVar(-3) := BVar(-2); 
    BVar(-2) := BVar(-1); BVar(-1) := BVar(0);
  )

DECLARE(brrot)
  body( 
    BVar(0) := BVar(-1);  BVar(-1) := BVar(-2); 
    BVar(-2) := BVar(-3); BVar(-3) := BVar(0);
  )

DECLARE(b>w, BtoW)
  begin
    Machine.WUP(Machine.BWO);
  end;

DECLARE(w>b, WtoB)
  begin
    Machine.BWU(Machine.WOP);
  end;

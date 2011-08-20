DECLARE(current-directory, current_directory)
  body(Machine.WUS(GetCurrentDirectory);)
RUS SUMMARY ( -- B: s) кладёт путь до текущей деректории без завершающего слеша

DECLARE(nop)
  body()
RUS SUMMARY ничего не делает

DECLARE(timer)
  body( WUI(GetTimer); )
RUS SUMMARY ( -- i) кладёт счётчик, увеличивающийся на 1 каждую миллисекунду

DECLARE(@wp, DogwpTemp)
  body(
    Pointer(WP^) := @WP;
    Inc(WP, SizeOf(Pointer)); )

DECLARE(wp) 
  body( Pointer(WP^) := WP; 
  Inc(WP, SizeOf(Pointer)); )

DECLARE(rp)
  body(
    Pointer(WP^) := RP;
    Inc(WP, SizeOf(Pointer)); )

DECLARE(lp)
  body(
    Pointer(WP^) := LP;
    Inc(WP, SizeOf(Pointer)); )

DECLARE(lb)
  body( Pointer(WP^) := LB; Inc(WP, SizeOf(Pointer)); )

DECLARE(r@, r_dog)
  body(
    Pointer(WP^) := Pointer(Pointer(Cardinal(RP) - SizeOf(Pointer))^);
    Inc(WP, SizeOf(Pointer)); )

DECLARE(r>, r_gt)
  body(
    Dec(RP, SizeOf(Pointer));
    Pointer(WP^) := Pointer(RP^);
    Inc(WP, SizeOf(Pointer)); )

DECLARE(>r, gt_r)
  body(
    Dec(WP, SizeOf(Pointer));
    Pointer(RP^) := Pointer(WP^);
    Inc(RP, SizeOf(Pointer)); )

DECLARE(l@, l_dog)
  body(
    Pointer(WVar(-SizeOf(Pointer))) := Pointer(LVar(Integer(WVar(-SizeOf(Pointer))))); )

DECLARE(l!, l_ex)
  body(
    Pointer(LVar(Integer(WVar(-SizeOf(Pointer))))) := Pointer(WVar(-2*SizeOf(Pointer))); Dec(WP, 2*SizeOf(Pointer)); )

DECLARE(l+, l_plus)
  body(
    Dec(WP, SizeOf(TInt));
    Inc(LP, TInt(WP^)) )

DECLARE(sys-version, version)
  body(
    TInt(WP^) := DFORTHMACHINE_VERSION;
    Inc(WP, SizeOf(TInt)); )

DECLARE(state)
  body(
    Pointer(WP^) := @State;
    Inc(WP, SizeOf(Pointer)); )

DECLARE(time)
  body(
    Integer(WP^) := GetTimer;
    Inc(WP, SizeOf(TInt)); )

DECLARE(local)
  body(
    RunCommand(PForthCommand((@E[Integer(Command^.Data)])^)); )

DECLARE(source-cut, source_cut)
  var
    _S: TStr;
    _L: TString;
  body( 
    _S := str_pop(Machine); 
    _L := StrToString(_S);
    WUS(Source^.SourceCut(_L));
    DelRef(_S))

DECLARE(source-next-char, source_next_char)
  body( WUI(Integer(NextChar)) )

DECLARE(source-next-name, source_next_name) 
  body( str_push(Machine, NextName) )
  procedure interpret_source_next_name_passive cmdhdr; body( str_push(Machine, NextNamePassive) )
  procedure compile_source_next_name_passive cmdhdr; body( BuiltinEWO('(str)' + Char(34)); EWStr(NextNamePassive); )

DECLARE(source-next-name-passive, source_next_name_passive)
  body( interpret_source_next_name_passive(Machine, Command) )

DECLARE(source-next-line, source_next_line)
  body( str_push(Machine, Machine.Source^.NextLine) )

DECLARE(source-next-line-passive, source_next_line_passive)
  body( str_push(Machine, Machine.Source^.NextLinePassive) )

DECLARE(run_source_next_name_passive)
  body( str_push(Machine, @E[EC]); )

DECLARE(source-read-to-char, source_read_to_char)
  body(  
    Dec(WP, 1);
    while not Source^.EOS do
      if Source^.NextChar = TChar(WP^) then
        break; )

DECLARE(ptr-nil, ptr_nil)
  body( WUP(nil); )

DECLARE(compile@, compile_start)
  body( State := FS_COMPILE )

DECLARE(interpret@, interpret_start)
  body( State := FS_INTERPRET )

DECLARE(run@, run_start)
  body( State := FS_INTERPRET )

DECLARE(opcode->command, opcode_to_command)
  body( Pointer(WVar(-SizeOf(Integer))) := GetCommandByOpcode(Integer(WVar(-SizeOf(Integer)))) )

DECLARE(literal)
  body( BuiltinEWO('(literal)'); EWI(WOI); )

dnl ищи в DForthMachine.pas4
dnl DECLARE([""], sq_ap_sq)
dnl   body(
dnl     WUP(FindCommand(NextName));
dnl     literal(Machine, Command); )

dnl DECLARE(interpret@[""], interpret_sq_ap_sq)
dnl   body( WUP(FindCommand(NextName)) )

dnl DECLARE(compile@[""], compile_sq_ap_sq)
dnl   body( 
dnl     BuiltinEWO('run@['']');
dnl     EWO(NextName); )

dnl DECLARE(run@[""], run_sq_ap_sq)
dnl   body( WUP(C[ERO]); )

dnl DECLARE("", tick)
dnl   body( Pointer(WP^) := FindCommand(NextName);
dnl   Inc(WP, SizeOf(Pointer)); )

DECLARE(execute)
  var
    P: PForthCommand;
  body( 
    P := WOP;
    P.Code(Machine, P) )

DECLARE(does>, does_gt, True)
  body(
    BuiltinEWO('(does>)');
    BuiltinEWO('exit'); )
  procedure _CallDoesGt cmdhdr;
  body(
    Call(Machine, Command);
    Pointer(WP^) := Pointer(Command.Param);
    Inc(WP, SizeOf(Pointer)); )

DECLARE((does>), _sq_does_gt_sq)
  body(
    Integer(C[FLastMnemonic].Param) := Integer(C[FLastMnemonic].Data);
    Integer(C[FLastMnemonic].Data) := EC + 4;
    C[FLastMnemonic].Code := CallDoesGt; )

DECLARE(cells)
  body(TInt(WVar(-SizeOf(TInt))) := TInt(WVar(-SizeOf(TInt)))*SizeOf(Integer);)

DECLARE(cell+, cell_plus)
  body( TInt(WVar(-SizeOf(TInt))) := TInt(WVar(-SizeOf(TInt))) + SizeOf(TInt); )

DECLARE(last)
  body(
    Pointer(WP^) := C[FLastMnemonic];
    {Writeln(Integer(WP^));}
    Inc(WP, SizeOf(Pointer)); )

DECLARE(randomize)
  body(Randomize;)

DECLARE(random)
  body(Machine.WUI(Random(Machine.WOI));)
      
DECLARE(align)
  var
    I: Integer;
  body(
    I := WOI;
    if I mod 4 = 0 then
      WUI(I)
    else
      WUI(I + 4 - (I mod 4)))

DECLARE(palign)
  body(_align(Machine, Command);)

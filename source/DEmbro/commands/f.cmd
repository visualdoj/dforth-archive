DECLARE(finit)
  idle(asm{$IFDEF I386}
    finit
  {$ENDIF}end;)

DECLARE(fdrop)
  idle(asm{$IFDEF I386}
    fstp ST(0)
  {$ENDIF}end;)

DECLARE(fnip)
  idle(asm{$IFDEF I386}
    fxch ST(1)
    fstp ST(0)
  {$ENDIF}end;)

DECLARE(fdup)
  idle(asm{$IFDEF I386}
    fld ST(0)
  {$ENDIF}end;)

DECLARE(fover)
  idle(asm{$IFDEF I386}
    fld ST(1)
  {$ENDIF}end;)

DECLARE(ftuck)
  idle(asm{$IFDEF I386}
    fxch ST(1)
    fld  ST(1)
  {$ENDIF}end;)

DECLARE(fswap)
  idle(asm{$IFDEF I386}
    fxch ST(1)
  {$ENDIF}end;)

DECLARE(flrot)
  idle(asm{$IFDEF I386}
    fxch ST(1)
    fxch ST(2)
  {$ENDIF}end;)

DECLARE(frrot)
  idle(asm{$IFDEF I386}
    fxch ST(2)
    fxch ST(1)
  {$ENDIF}end;)

DECLARE(f0)
  idle(asm{$IFDEF I386}
    fldz
  {$ENDIF}end;)

DECLARE(f1)
  idle(asm{$IFDEF I386}
    fld1
  {$ENDIF}end;)

DECLARE(fpi)
  idle(asm{$IFDEF I386}
    fldpi
  {$ENDIF}end;)

DECLARE(flog10)
  idle(asm{$IFDEF I386}
    fldl2t
  {$ENDIF}end;)

DECLARE(floge)
  idle(asm{$IFDEF I386}
    fldl2e
  {$ENDIF}end;)

DECLARE(f10log2)
  idle(asm{$IFDEF I386}
    fldlg2
  {$ENDIF}end;)

DECLARE(fln2)
  idle(asm{$IFDEF I386}
    fldln2
  {$ENDIF}end;)

DECLARE(w>f, w2f)
  idle(asm{$IFDEF I386}
    mov ecx, [eax]
    sub [eax], 4
    fild DWORD [ecx-4]
  {$ENDIF}end;)

DECLARE(f>w, f2w)
  idle(asm{$IFDEF I386}
    mov ecx, [eax]
    fistp DWORD [ecx]
    add [eax], 4
    fwait
  {$ENDIF}end;)

DECLARE(float-w>f, float_w2f)
  idle(asm{$IFDEF I386}
    sub [eax], 4
    mov ecx, [eax]
    fld Single [ecx]
  {$ENDIF}end;)

DECLARE(double-w>f, double_w2f)
  idle(asm{$IFDEF I386}
    sub [eax], 8
    mov ecx, [eax]
    fld Double [ecx]
  {$ENDIF}end;)

DECLARE(extended-w>f, extended_w2f)
  idle(asm{$IFDEF I386}
    sub [eax], SizeOf(Extended)
    mov ecx, [eax]
    fld Extended [ecx]
  {$ENDIF}end;)

DECLARE(float-f>w, float_f2w)
  idle(asm{$IFDEF I386}
    mov ecx, [eax]
    fstp Single [ecx]
    add [eax], 4
    fwait
  {$ENDIF}end;)

DECLARE(double-f>w, double_f2w)
  idle(asm{$IFDEF I386}
    mov ecx, [eax]
    fstp Double [ecx]
    add [eax], 8
    fwait
  {$ENDIF}end;)

DECLARE(extended-f>w, extended_f2w)
  idle(asm{$IFDEF I386}
    mov ecx, [eax]
    fstp Extended [ecx]
    add [eax], 10
    fwait
  {$ENDIF}end;)

DECLARE(frandom)
  var
    E: Extended;
  begin
    E := Random;
    idle(asm{$IFDEF I386} fld E {$ENDIF}end;)
  end;

DECLARE(f+, fadd)
  idle(asm{$IFDEF I386}
    fadd
  {$ENDIF}end;)

DECLARE(f-, fsub)
  idle(asm{$IFDEF I386}
    fsub
  {$ENDIF}end;)

DECLARE(fswap-, fswapsub)
  idle(asm{$IFDEF I386}
    fsubr
  {$ENDIF}end;)

DECLARE(f*, fmul)
  idle(asm{$IFDEF I386}
    fmul
  {$ENDIF}end;)

DECLARE(f/, fdiv)
  idle(asm{$IFDEF I386}
    fdiv
  {$ENDIF}end;)

DECLARE(fswap/, fswapdiv)
  idle(asm{$IFDEF I386}
    fdivr
  {$ENDIF}end;)

DECLARE(fabs)
  idle(asm{$IFDEF I386}
    fabs
  {$ENDIF}end;)

DECLARE(fneg)
  idle(asm{$IFDEF I386}
    fchs
  {$ENDIF}end;)

DECLARE(fsqrt)
  idle(asm{$IFDEF I386}
    fsqrt
  {$ENDIF}end;)

DECLARE(fscale)
  idle(asm{$IFDEF I386}
    fscale
  {$ENDIF}end;)

DECLARE(fround)
  idle(asm{$IFDEF I386}
    frndint
  {$ENDIF}end;)

DECLARE(fptan)
  idle(asm{$IFDEF I386}
    fptan
  {$ENDIF}end;)

DECLARE(fpatan)
  idle(asm{$IFDEF I386}
    fpatan
  {$ENDIF}end;)

DECLARE(flog*, flogmul)
  idle(asm{$IFDEF I386}
    fyl2x
  {$ENDIF}end;)

DECLARE(flog1+mul, flog1plus_mul)
  idle(asm{$IFDEF I386}
    fyl2xp1
  {$ENDIF}end;)

DECLARE(f2pwr1-, f2pwr_1minus)
  idle(asm{$IFDEF I386}
    f2xm1
  {$ENDIF}end;)

DECLARE(fcos)
  idle(asm{$IFDEF I386}
    fcos
  {$ENDIF}end;)

DECLARE(fsin)
  idle(asm{$IFDEF I386}
    fsin
  {$ENDIF}end;)

DECLARE(fsincos)
  idle(asm{$IFDEF I386}
    fsincos
  {$ENDIF}end;)

DECLARE(float-fliteral, _float_fliteral, True)
  var
    F: Single;
  begin
    idle(asm{$IFDEF I386}
      fstp F
    {$ENDIF}end;)
    Machine.BuiltinEWO('float-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(double-fliteral, _double_fliteral, True)
  var
    F: Double;
  begin
    idle(asm{$IFDEF I386}
      fstp F
    {$ENDIF}end;)
    Machine.BuiltinEWO('double-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(extended-fliteral, _extended_fliteral, True)
  var
    F: Double;
  begin
    idle(asm{$IFDEF I386}
      fstp F
    {$ENDIF}end;)
    Machine.BuiltinEWO('extended-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(float-(fliteral), _float_run_fliteral)
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm{$IFDEF I386}
      fld single [P]
    {$ENDIF}end;)
    Inc(Machine.EC, SizeOf(Single));
  end;

DECLARE(double-(fliteral), _double_run_fliteral)    
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm{$IFDEF I386}
      fld double [P]
    {$ENDIF}end;)
    Inc(Machine.EC, SizeOf(Double));
  end;

DECLARE(extended-(fliteral), _extended_run_fliteral)    
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm{$IFDEF I386}
      fld extended [P]
    {$ENDIF}end;)
    Inc(Machine.EC, SizeOf(Extended));
  end;

DECLARE(float->str, _float_to_str)
  var
    F: Single;
    S: String;
  begin
    //idle(asm{$IFDEF I386}
    //  fstp f
    //{$ENDIF}end;)
    Machine.WOV(@F, SizeOf(F));
    str(F, S);
    Machine.WUS(S);
  end;

DECLARE(double->str, _double_to_str)
  var
    F: Double;
    S: String;
  begin
    //idle(asm{$IFDEF I386}
    //  fstp f
    //{$ENDIF}end;)
    Machine.WOV(@F, SizeOf(F));
    str(F, S);
    Machine.WUS(S);
  end;

DECLARE(extended->str, _extended_to_str)
  var
    F: Extended;
    S: String;
  begin
    //idle(asm{$IFDEF I386}
    //  fstp f
    //{$ENDIF}end;)
    Machine.WOV(@F, SizeOf(F));
    str(F, S);
    Machine.WUS(S);
  end;

DECLARE(str->float?, _str_to_float_ask)
  var
    Code: Word;
    S: TString;
    V: Single;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      // idle(asm{$IFDEF I386} fld V {$ENDIF}end;)
      Machine.WUV(@V, SizeOf(V));
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(str->double?, _str_to_double_ask)
  var
    Code: Word;
    S: TString;
    V: Double;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      // idle(asm{$IFDEF I386} fld V end;)
      Machine.WUV(@V, SizeOf(V));
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(str->extended?, _str_to_extended_ask)
  var
    Code: Word;
    S: TString;
    V: Extended;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      // idle(asm{$IFDEF I386} fld V end;)
      Machine.WUV(@V, SizeOf(V));
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(str->float!?, _str_to_float_excl_ask)
  var
    Code: Word;
    S: TString;
    V: Single;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      Single(Machine.WOP^) := V;
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(str->double!?, _str_to_double_excl_ask)
  var
    Code: Word;
    S: TString;
    V: Double;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      Double(Machine.WOP^) := V;
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(str->extended!?, _str_to_extended_excl_ask)
  var
    Code: Word;
    S: TString;
    V: Extended;
  begin
    S := Machine.WOS;
    val(S, V, Code);
    if Code = 0 then begin
      Extended(Machine.WOP^) := V;
      Machine.WUI(BOOL_TRUE);
    end else
      Machine.WUI(BOOL_FALSE);
  end;

DECLARE(finit)
  idle(asm
    finit
  end;)

DECLARE(fdrop)
  idle(asm
    fstp ST(0)
  end;)

DECLARE(fnip)
  idle(asm
    fxch ST(1)
    fstp ST(0)
  end;)

DECLARE(fdup)
  idle(asm
    fld ST(0)
  end;)

DECLARE(fover)
  idle(asm
    fld ST(1)
  end;)

DECLARE(ftuck)
  idle(asm
    fxch ST(1)
    fld  ST(1)
  end;)

DECLARE(fswap)
  idle(asm
    fxch ST(1)
  end;)

DECLARE(flrot)
  idle(asm
    fxch ST(1)
    fxch ST(2)
  end;)

DECLARE(frrot)
  idle(asm
    fxch ST(2)
    fxch ST(1)
  end;)

DECLARE(f0)
  idle(asm
    fldz
  end;)

DECLARE(f1)
  idle(asm
    fld1
  end;)

DECLARE(fpi)
  idle(asm
    fldpi
  end;)

DECLARE(flog10)
  idle(asm
    fldl2t
  end;)

DECLARE(floge)
  idle(asm
    fldl2e
  end;)

DECLARE(f10log2)
  idle(asm
    fldlg2
  end;)

DECLARE(fln2)
  idle(asm
    fldln2
  end;)

DECLARE(w>f, w2f)
  idle(asm
    mov ecx, [eax]
    sub [eax], 4
    fild DWORD [ecx-4]
  end;)

DECLARE(f>w, f2w)
  idle(asm
    mov ecx, [eax]
    fistp DWORD [ecx]
    add [eax], 4
    fwait
  end;)

DECLARE(float-w>f, float_w2f)
  idle(asm
    sub [eax], 4
    mov ecx, [eax]
    fld Single [ecx]
  end;)

DECLARE(double-w>f, double_w2f)
  idle(asm
    sub [eax], 8
    mov ecx, [eax]
    fld Double [ecx]
  end;)

DECLARE(extended-w>f, extended_w2f)
  idle(asm
    sub [eax], SizeOf(Extended)
    mov ecx, [eax]
    fld Extended [ecx]
  end;)

DECLARE(float-f>w, float_f2w)
  idle(asm
    mov ecx, [eax]
    fstp Single [ecx]
    add [eax], 4
    fwait
  end;)

DECLARE(double-f>w, double_f2w)
  idle(asm
    mov ecx, [eax]
    fstp Double [ecx]
    add [eax], 8
    fwait
  end;)

DECLARE(extended-f>w, extended_f2w)
  idle(asm
    mov ecx, [eax]
    fstp Extended [ecx]
    add [eax], 10
    fwait
  end;)

DECLARE(frandom)
  var
    E: Extended;
  begin
    E := Random;
    idle(asm fld E end;)
  end;

DECLARE(f+, fadd)
  idle(asm
    fadd
  end;)

DECLARE(f-, fsub)
  idle(asm
    fsub
  end;)

DECLARE(fswap-, fswapsub)
  idle(asm
    fsubr
  end;)

DECLARE(f*, fmul)
  idle(asm
    fmul
  end;)

DECLARE(f/, fdiv)
  idle(asm
    fdiv
  end;)

DECLARE(fswap/, fswapdiv)
  idle(asm
    fdivr
  end;)

DECLARE(fabs)
  idle(asm
    fabs
  end;)

DECLARE(fneg)
  idle(asm
    fchs
  end;)

DECLARE(fsqrt)
  idle(asm
    fsqrt
  end;)

DECLARE(fscale)
  idle(asm
    fscale
  end;)

DECLARE(fround)
  idle(asm
    frndint
  end;)

DECLARE(fptan)
  idle(asm
    fptan
  end;)

DECLARE(fpatan)
  idle(asm
    fpatan
  end;)

DECLARE(flog*, flogmul)
  idle(asm
    fyl2x
  end;)

DECLARE(flog1+mul, flog1plus_mul)
  idle(asm
    fyl2xp1
  end;)

DECLARE(f2pwr1-, f2pwr_1minus)
  idle(asm
    f2xm1
  end;)

DECLARE(fcos)
  idle(asm
    fcos
  end;)

DECLARE(fsin)
  idle(asm
    fsin
  end;)

DECLARE(fsincos)
  idle(asm
    fsincos
  end;)

DECLARE(float-fliteral, _float_fliteral, True)
  var
    F: Single;
  begin
    idle(asm
      fstp F
    end;)
    Machine.BuiltinEWO('float-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(double-fliteral, _double_fliteral, True)
  var
    F: Double;
  begin
    idle(asm
      fstp F
    end;)
    Machine.BuiltinEWO('double-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(extended-fliteral, _extended_fliteral, True)
  var
    F: Double;
  begin
    idle(asm
      fstp F
    end;)
    Machine.BuiltinEWO('extended-(fliteral)');
    Machine.EWV(@F, SizeOf(F));
  end;

DECLARE(float-(fliteral), _float_run_fliteral)
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm
      fld single [P]
    end;)
    Inc(Machine.EC, SizeOf(Single));
  end;

DECLARE(double-(fliteral), _double_run_fliteral)    
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm
      fld double [P]
    end;)
    Inc(Machine.EC, SizeOf(Double));
  end;

DECLARE(extended-(fliteral), _extended_run_fliteral)    
  var
    P: Pointer;
  begin
    P := @Machine.E[Machine.EC];
    idle(asm
      fld extended [P]
    end;)
    Inc(Machine.EC, SizeOf(Extended));
  end;

DECLARE(float->str, _float_to_str)
  var
    F: Single;
    S: String;
  begin
    {idle(asm
      fstp f
    end;)}
    Machine.WOV(@F, SizeOf(F));
    str(F, S);
    Machine.WUS(S);
  end;

DECLARE(double->str, _double_to_str)
  var
    F: Double;
    S: String;
  begin
    {idle(asm
      fstp f
    end;)}
    Machine.WOV(@F, SizeOf(F));
    str(F, S);
    Machine.WUS(S);
  end;

DECLARE(extended->str, _extended_to_str)
  var
    F: Extended;
    S: String;
  begin
    {idle(asm
      fstp f
    end;)}
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
      // idle(asm fld V end;)
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
      // idle(asm fld V end;)
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
      // idle(asm fld V end;)
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

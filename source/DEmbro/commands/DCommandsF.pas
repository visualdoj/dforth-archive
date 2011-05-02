unit DCommandsF;

interface




uses
  {$I units.inc},
  DForthMachine;

      procedure finit (Machine: TForthMachine; Command: PForthCommand);
      procedure fdrop (Machine: TForthMachine; Command: PForthCommand);
      procedure fnip (Machine: TForthMachine; Command: PForthCommand);
      procedure fdup (Machine: TForthMachine; Command: PForthCommand);
      procedure fover (Machine: TForthMachine; Command: PForthCommand);
      procedure ftuck (Machine: TForthMachine; Command: PForthCommand);
      procedure fswap (Machine: TForthMachine; Command: PForthCommand);
      procedure flrot (Machine: TForthMachine; Command: PForthCommand);
      procedure frrot (Machine: TForthMachine; Command: PForthCommand);
      procedure f0 (Machine: TForthMachine; Command: PForthCommand);
      procedure f1 (Machine: TForthMachine; Command: PForthCommand);
      procedure fpi (Machine: TForthMachine; Command: PForthCommand);
      procedure flog10 (Machine: TForthMachine; Command: PForthCommand);
      procedure floge (Machine: TForthMachine; Command: PForthCommand);
      procedure f10log2 (Machine: TForthMachine; Command: PForthCommand);
      procedure fln2 (Machine: TForthMachine; Command: PForthCommand);
      procedure w2f (Machine: TForthMachine; Command: PForthCommand);
      procedure f2w (Machine: TForthMachine; Command: PForthCommand);
      procedure float_w2f (Machine: TForthMachine; Command: PForthCommand);
      procedure double_w2f (Machine: TForthMachine; Command: PForthCommand);
      procedure extended_w2f (Machine: TForthMachine; Command: PForthCommand);
      procedure float_f2w (Machine: TForthMachine; Command: PForthCommand);
      procedure double_f2w (Machine: TForthMachine; Command: PForthCommand);
      procedure extended_f2w (Machine: TForthMachine; Command: PForthCommand);
      procedure frandom (Machine: TForthMachine; Command: PForthCommand);

      procedure fadd (Machine: TForthMachine; Command: PForthCommand);
      procedure fsub (Machine: TForthMachine; Command: PForthCommand);
      procedure fswapsub (Machine: TForthMachine; Command: PForthCommand);
      procedure fmul (Machine: TForthMachine; Command: PForthCommand);
      procedure fdiv (Machine: TForthMachine; Command: PForthCommand);
      procedure fswapdiv (Machine: TForthMachine; Command: PForthCommand);

      procedure fabs (Machine: TForthMachine; Command: PForthCommand);
      procedure fneg (Machine: TForthMachine; Command: PForthCommand);
      procedure fsqrt (Machine: TForthMachine; Command: PForthCommand);
      procedure fscale (Machine: TForthMachine; Command: PForthCommand);
      procedure fround (Machine: TForthMachine; Command: PForthCommand);

      procedure fptan   (Machine: TForthMachine; Command: PForthCommand);
      procedure fpatan  (Machine: TForthMachine; Command: PForthCommand);
      procedure flogmul (Machine: TForthMachine; Command: PForthCommand);
      procedure flog1plus_mul  (Machine: TForthMachine; Command: PForthCommand);
      procedure f2pwr   (Machine: TForthMachine; Command: PForthCommand);
      procedure fcos    (Machine: TForthMachine; Command: PForthCommand);
      procedure fsin    (Machine: TForthMachine; Command: PForthCommand);
      procedure fsincos (Machine: TForthMachine; Command: PForthCommand);

      procedure _float_fliteral (Machine: TForthMachine; Command: PForthCommand);
      procedure _double_fliteral (Machine: TForthMachine; Command: PForthCommand);
      procedure _extended_fliteral (Machine: TForthMachine; Command: PForthCommand);
      procedure _float_run_fliteral (Machine: TForthMachine; Command: PForthCommand);
      procedure _double_run_fliteral (Machine: TForthMachine; Command: PForthCommand);    
      procedure _extended_run_fliteral (Machine: TForthMachine; Command: PForthCommand);    
      procedure _float_to_str (Machine: TForthMachine; Command: PForthCommand);
      procedure _double_to_str (Machine: TForthMachine; Command: PForthCommand);
      procedure _extended_to_str (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_float_ask (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_double_ask (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_extended_ask (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_float_excl_ask (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_double_excl_ask (Machine: TForthMachine; Command: PForthCommand);
      procedure _str_to_extended_excl_ask (Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

      procedure finit (Machine: TForthMachine; Command: PForthCommand);
      asm
        finit
      end;
      procedure fdrop (Machine: TForthMachine; Command: PForthCommand);
      asm
        fstp ST(0)
      end;
      procedure fnip (Machine: TForthMachine; Command: PForthCommand);
      asm
        fxch ST(1)
        fstp ST(0)
      end;
      procedure fdup (Machine: TForthMachine; Command: PForthCommand);
      asm
        fld ST(0)
      end;
      procedure fover (Machine: TForthMachine; Command: PForthCommand);
      asm
        fld ST(1)
      end;
      procedure ftuck (Machine: TForthMachine; Command: PForthCommand);
      asm
        fxch ST(1)
        fld  ST(1)
      end;
      procedure fswap (Machine: TForthMachine; Command: PForthCommand);
      asm
        fxch ST(1)
      end;
      procedure flrot (Machine: TForthMachine; Command: PForthCommand);
      asm
        fxch ST(1)
        fxch ST(2)
      end;
      procedure frrot (Machine: TForthMachine; Command: PForthCommand);
      asm
        fxch ST(2)
        fxch ST(1)
      end;
      procedure f0 (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldz
      end;
      procedure f1 (Machine: TForthMachine; Command: PForthCommand);
      asm
        fld1
      end;
      procedure fpi (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldpi
      end;
      procedure flog10 (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldl2t
      end;
      procedure floge (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldl2e
      end;
      procedure f10log2 (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldlg2
      end;
      procedure fln2 (Machine: TForthMachine; Command: PForthCommand);
      asm
        fldln2
      end;
      procedure w2f (Machine: TForthMachine; Command: PForthCommand);
      asm
        mov ecx,[eax]
        sub [eax],4
        fild DWORD [ecx-4]
      end;
      procedure f2w (Machine: TForthMachine; Command: PForthCommand);
      asm
        mov ecx,[eax]
        fistp DWORD [ecx]
        add [eax],4
        fwait
      end;
      procedure float_w2f (Machine: TForthMachine; Command: PForthCommand);
      asm
        sub [eax],4
        mov ecx,[eax]
        fld Single [ecx]
      end;
      procedure double_w2f (Machine: TForthMachine; Command: PForthCommand);
      asm
        sub [eax],8
        mov ecx,[eax]
        fld Double [ecx]
      end;
      procedure extended_w2f (Machine: TForthMachine; Command: PForthCommand);
      asm
        sub [eax],SizeOf(Extended)
        mov ecx,[eax]
        fld Extended [ecx]
      end;
      procedure float_f2w (Machine: TForthMachine; Command: PForthCommand);
      asm
        mov ecx,[eax]
        fstp Single [ecx]
        add [eax],4
        fwait
      end;
      procedure double_f2w (Machine: TForthMachine; Command: PForthCommand);
      asm
        mov ecx,[eax]
        fstp Double [ecx]
        add [eax],8
        fwait
      end;
      procedure extended_f2w (Machine: TForthMachine; Command: PForthCommand);
      asm
        mov ecx,[eax]
        fstp Extended [ecx]
        add [eax],10
        fwait
      end;
      procedure frandom (Machine: TForthMachine; Command: PForthCommand);
      var
        E: Extended;
      begin
        E := Random;
        asm fld E end;
      end;
      procedure fadd (Machine: TForthMachine; Command: PForthCommand);
      asm
        fadd
      end;
      procedure fsub (Machine: TForthMachine; Command: PForthCommand);
      asm
        fsub
      end;
      procedure fswapsub (Machine: TForthMachine; Command: PForthCommand);
      asm
        fsubr
      end;
      procedure fmul (Machine: TForthMachine; Command: PForthCommand);
      asm
        fmul
      end;
      procedure fdiv (Machine: TForthMachine; Command: PForthCommand);
      asm
        fdiv
      end;
      procedure fswapdiv (Machine: TForthMachine; Command: PForthCommand);
      asm
        fdivr
      end;
      procedure fabs (Machine: TForthMachine; Command: PForthCommand);
      asm
        fabs
      end;
      procedure fneg (Machine: TForthMachine; Command: PForthCommand);
      asm
        fchs
      end;
      procedure fsqrt (Machine: TForthMachine; Command: PForthCommand);
      asm
        fsqrt
      end;
      procedure fscale (Machine: TForthMachine; Command: PForthCommand);
      asm
        fscale
      end;
      procedure fround (Machine: TForthMachine; Command: PForthCommand);
      asm
        frndint
      end;
      procedure fptan   (Machine: TForthMachine; Command: PForthCommand);
      asm
        fptan
      end;
      procedure fpatan  (Machine: TForthMachine; Command: PForthCommand);
      asm
        fpatan
      end;
      procedure flogmul (Machine: TForthMachine; Command: PForthCommand);
      asm
        fyl2x
      end;
      procedure flog1plus_mul (Machine: TForthMachine; Command: PForthCommand);
      asm
        fyl2xp1
      end;
      procedure f2pwr   (Machine: TForthMachine; Command: PForthCommand);
      asm
        f2xm1
      end;
      procedure fcos    (Machine: TForthMachine; Command: PForthCommand);
      asm
        fcos
      end;
      procedure fsin    (Machine: TForthMachine; Command: PForthCommand);
      asm
        fsin
      end;
      procedure fsincos (Machine: TForthMachine; Command: PForthCommand);
      asm
        fsincos
      end;
      procedure _float_fliteral (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Single;
      begin
        asm
          fstp F
        end;
        Machine.BuiltinEWO('float-(fliteral)');
        Machine.EWV(@F, SizeOf(F));
      end;
      procedure _double_fliteral (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Double;
      begin
        asm
          fstp F
        end;
        Machine.BuiltinEWO('double-(fliteral)');
        Machine.EWV(@F, SizeOf(F));
      end;
      procedure _extended_fliteral (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Double;
      begin
        asm
          fstp F
        end;
        Machine.BuiltinEWO('extended-(fliteral)');
        Machine.EWV(@F, SizeOf(F));
      end;
      procedure _float_run_fliteral (Machine: TForthMachine; Command: PForthCommand);
      var
        P: Pointer;
      begin
        P := @Machine.E[Machine.EC];
        asm
          fld single [P]
        end;
        Inc(Machine.EC, SizeOf(Single));
      end;
      procedure _double_run_fliteral (Machine: TForthMachine; Command: PForthCommand);    
      var
        P: Pointer;
      begin
        P := @Machine.E[Machine.EC];
        asm
          fld double [P]
        end;
        Inc(Machine.EC, SizeOf(Double));
      end;
      procedure _extended_run_fliteral (Machine: TForthMachine; Command: PForthCommand);    
      var
        P: Pointer;
      begin
        P := @Machine.E[Machine.EC];
        asm
          fld extended [P]
        end;
        Inc(Machine.EC, SizeOf(Extended));
      end;
      procedure _float_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Single;
        S: String;
      begin
        {asm
          fstp f
        end;}
        Machine.WOV(@F, SizeOf(F));
        str(F, S);
        Machine.WUS(S);
      end;
      procedure _double_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Double;
        S: String;
      begin
        {asm
          fstp f
        end;}
        Machine.WOV(@F, SizeOf(F));
        str(F, S);
        Machine.WUS(S);
      end;
      procedure _extended_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        F: Extended;
        S: String;
      begin
        {asm
          fstp f
        end;}
        Machine.WOV(@F, SizeOf(F));
        str(F, S);
        Machine.WUS(S);
      end;
      procedure _str_to_float_ask (Machine: TForthMachine; Command: PForthCommand);
      var
        Code: Word;
        S: TString;
        V: Single;
      begin
        S := Machine.WOS;
        val(S, V, Code);
        if Code = 0 then begin
          // asm fld V end;
          Machine.WUV(@V, SizeOf(V));
          Machine.WUI(BOOL_TRUE);
        end else
          Machine.WUI(BOOL_FALSE);
      end;
      procedure _str_to_double_ask (Machine: TForthMachine; Command: PForthCommand);
      var
        Code: Word;
        S: TString;
        V: Double;
      begin
        S := Machine.WOS;
        val(S, V, Code);
        if Code = 0 then begin
          // asm fld V end;
          Machine.WUV(@V, SizeOf(V));
          Machine.WUI(BOOL_TRUE);
        end else
          Machine.WUI(BOOL_FALSE);
      end;
      procedure _str_to_extended_ask (Machine: TForthMachine; Command: PForthCommand);
      var
        Code: Word;
        S: TString;
        V: Extended;
      begin
        S := Machine.WOS;
        val(S, V, Code);
        if Code = 0 then begin
          // asm fld V end;
          Machine.WUV(@V, SizeOf(V));
          Machine.WUI(BOOL_TRUE);
        end else
          Machine.WUI(BOOL_FALSE);
      end;
      procedure _str_to_float_excl_ask (Machine: TForthMachine; Command: PForthCommand);
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
      procedure _str_to_double_excl_ask (Machine: TForthMachine; Command: PForthCommand);
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
      procedure _str_to_extended_excl_ask (Machine: TForthMachine; Command: PForthCommand);
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

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('finit',   finit);
  Machine.AddCommand('fdrop',   fdrop);
  Machine.AddCommand('fnip',    fnip);
  Machine.AddCommand('fdup',    fdup);
  Machine.AddCommand('fover',   fover);
  Machine.AddCommand('ftuck',   ftuck);
  Machine.AddCommand('fswap',   fswap);
  Machine.AddCommand('flrot',   flrot);
  Machine.AddCommand('frrot',   frrot);

  Machine.AddCommand('f0',      f0);
  Machine.AddCommand('f1',      f1);
  Machine.AddCommand('fpi',     fpi);
  Machine.AddCommand('flog10',  flog10);
  Machine.AddCommand('floge',   floge);
  Machine.AddCommand('f10log2', f10log2);
  Machine.AddCommand('fln2',    fln2);    
  Machine.AddCommand('frandom', frandom);    

  Machine.AddCommand('w>f',     w2f);    
  Machine.AddCommand('f>w',     f2w);    
  Machine.AddCommand('float-w>f',    float_w2f);    
  Machine.AddCommand('double-w>f',   double_w2f);    
  Machine.AddCommand('extended-w>f', extended_w2f);    
  Machine.AddCommand('float-f>w',    float_f2w);    
  Machine.AddCommand('double-f>w',   double_f2w);    
  Machine.AddCommand('extended-f>w', extended_f2w);    

  Machine.AddCommand('f+',     fadd);    
  Machine.AddCommand('f-',     fsub);    
  Machine.AddCommand('fswap-', fswapsub);    
  Machine.AddCommand('f*',     fmul);    
  Machine.AddCommand('f/',     fdiv);    
  Machine.AddCommand('fswap/', fswapdiv);    

  Machine.AddCommand('fabs', fabs);    
  Machine.AddCommand('fneg', fneg);    
  Machine.AddCommand('fsqrt', fsqrt);    
  Machine.AddCommand('fscale', fscale);    
  Machine.AddCommand('fround', fround);    

  Machine.AddCommand('fptan',    fptan);    
  Machine.AddCommand('fpatan',   fpatan);    
  Machine.AddCommand('flog*',     flogmul);    
  Machine.AddCommand('flog1+mul',   flog1plus_mul);    
  Machine.AddCommand('f2pwr1-',  f2pwr);    
  Machine.AddCommand('fcos',     fcos);    
  Machine.AddCommand('fsin',     fsin);    
  Machine.AddCommand('fsincos',  fsincos);    

  Machine.AddCommand('float-fliteral',  _float_fliteral, True);    
  Machine.AddCommand('double-fliteral',  _double_fliteral, True);    
  Machine.AddCommand('extended-fliteral',  _extended_fliteral, True);    
  Machine.AddCommand('float-(fliteral)',  _float_run_fliteral);    
  Machine.AddCommand('double-(fliteral)',  _double_run_fliteral);    
  Machine.AddCommand('extended-(fliteral)',  _extended_run_fliteral);    
  Machine.AddCommand('float->str',  _float_to_str);    
  Machine.AddCommand('double->str',  _double_to_str);    
  Machine.AddCommand('extended->str',  _extended_to_str);    
  Machine.AddCommand('str->float?',  _str_to_float_ask);    
  Machine.AddCommand('str->double?',  _str_to_double_ask);    
  Machine.AddCommand('str->extended?',  _str_to_extended_ask);    
  Machine.AddCommand('str->float!?',  _str_to_float_excl_ask);    
  Machine.AddCommand('str->double!?',  _str_to_double_excl_ask);    
  Machine.AddCommand('str->extended!?',  _str_to_extended_excl_ask);      
end;

end.

dnl DCommandsArithmetic.pas4
define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
define(`arithmetic_commands', `
      DECLARE($1+, $1_plus) body( $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) + $2(WVar(-SizeOf($2))); 
                                                   Dec(WP, SizeOf($2)); )
      DECLARE($1_minus) body( $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) - $2(WVar(-SizeOf($2))); 
                                                   Dec(WP, SizeOf($2)); )
      DECLARE($1_star) body( $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) * $2(WVar(-SizeOf($2))); 
                                                   Dec(WP, SizeOf($2)); )
      DECLARE($1_equel) body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) = $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_nequel) body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) <> $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_lt)    body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) < $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_gt)    body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) > $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_lte)   body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) <= $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_gte)   body( TInt(WVar(-2*SizeOf($2))) := BOOL_TRUE*Ord($2(WVar(-2*SizeOf($2))) >= $2(WVar(-SizeOf($2)))); 
                                                   Dec(WP, 2*SizeOf($2) - SizeOf(TInt)); )
      DECLARE($1_0_equel) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) = 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_0_nequel) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) <> 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_0_lt) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) < 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_0_gt) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) > 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_0_lte) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) <= 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_0_gte) body( TInt(WVar(-1*SizeOf($2))) := BOOL_TRUE*Ord(($2(WVar(-1*SizeOf($2)))) >= 0); Dec(WP, SizeOf($2) - SizeOf(TInt)) )
      DECLARE($1_ask_dup) body( if ($2(WVar(-1*SizeOf($2)))) <> 0 then begin $2(WP^) := $2(WVar(-1*SizeOf($2))); Inc(WP, SizeOf($2)); end; )
      DECLARE($1_0_exit) body( if $2(WVar(-SizeOf($2))) = 0 then begin Dec(WP, SizeOf($2)); _exit(Machine, Command); end )
      DECLARE($1_if_exit) body( if $2(WVar(-SizeOf($2))) <> 0 then begin Dec(WP, SizeOf($2)); _exit(Machine, Command); end )
      DECLARE($1_max)
      body(
        if $2(WVar(-2*SizeOf($2))) < $2(WVar(-1*SizeOf($2))) then
          Move(WVar(-1*SizeOf($2)), WVar(-2*SizeOf($2)), SizeOf($2));
        Dec(WP, SizeOf($2));
      )
      DECLARE($1_min)
      body(
        if $2(WVar(-2*SizeOf($2))) > $2(WVar(-1*SizeOf($2))) then
          Move(WVar(-1*SizeOf($2)), WVar(-2*SizeOf($2)), SizeOf($2));
        Dec(WP, SizeOf($2));
      )
      DECLARE($1_minmax)
      body(
        if $2(WVar(-2*SizeOf($2))) > $2(WVar(-1*SizeOf($2))) then begin
          Move(WVar(-2*SizeOf($2)), WVar(-0*SizeOf($2)), SizeOf($2));
          Move(WVar(-1*SizeOf($2)), WVar(-2*SizeOf($2)), SizeOf($2));
          Move(WVar(-0*SizeOf($2)), WVar(-1*SizeOf($2)), SizeOf($2));
        end;
      )
      DECLARE($1_dot)    body( Dec(WP, SizeOf($2)); Write($2(WP^), " "); )
      DECLARE($1_dollar) var Temp: $2; body( Read(Temp); Move(Temp, WP^, SizeOf($2)); Inc(WP, SizeOf($2)); )
      DECLARE($1_ptr_plus_exclamation) body( $2(Pointer(WVar(-SizeOf(Pointer)))^) := $2(Pointer(WVar(-SizeOf(Pointer)))^) + $2(WVar(-SizeOf(Pointer)-SizeOf($2))); Dec(WP, SizeOf(Pointer) + SizeOf($2)); )
      DECLARE($1_conv_to_str)
      var
        B: TString;
      body(
        Str($2(WVar(-SizeOf($2))), B);
        Dec(WP, SizeOf($2));
        str_push(Machine, B);
      )
      DECLARE($1_conv_from_str)
      var
        B: TStr;
      body(
        B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), $2(WP^));
        Inc(WP, SizeOf($2));
        DelRef(B);
      )
')

arithmetic_commands(`', TInt)
arithmetic_commands(int, TInt)
arithmetic_commands(int8, TInt8)
arithmetic_commands(int16, TInt16)
arithmetic_commands(int32, TInt32)
arithmetic_commands(int64, TInt64)
arithmetic_commands(uint, TUInt)
arithmetic_commands(uint8, TUInt8)
arithmetic_commands(uint16, TUInt16)
arithmetic_commands(uint32, TUInt32)
arithmetic_commands(uint64, TUInt64)
arithmetic_commands(float, Single)
arithmetic_commands(double, Double)
arithmetic_commands(extended, Extended)

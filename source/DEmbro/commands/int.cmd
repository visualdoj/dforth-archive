dnl DCommandsNumberArithmetic.pas4
define(`number_arithmetic_commands', `
     DECLARE($1_push ) body( if State = FS_COMPILE then $1_compile_push(Machine, Command) else $1_interpret_push(Machine, Command) )
     DECLARE($1_interpret_push ) body( $2(WP^) := $2(StrToInt(NextName)); Inc(WP, SizeOf($2)); )
     DECLARE($1_compile_push ) body( BuiltinEWO("run@$1-push"); EW_$1(StrToInt(NextName)); )
     DECLARE($1_run_push ) body( $2(WP^) := ER_$1; Inc(WP, SizeOf($2)); )
     DECLARE($1_1_plus)  body( Inc($2(WVar(-SizeOf($2)))) )
     DECLARE($1_1_minus) body( Dec($2(WVar(-SizeOf($2)))) )
     DECLARE($1_div) body( $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) div $2(WVar(-SizeOf($2))); 
                                                   Dec(WP, SizeOf($2)); )
     DECLARE($1_mod) body( $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) mod $2(WVar(-SizeOf($2))); 
                                                   Dec(WP, SizeOf($2)); )
     DECLARE($1_divmod) body( $2(WVar(0)) := $2(WVar(-2*SizeOf($2))) mod $2(WVar(-SizeOf($2))); 
                                                     $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) div $2(WVar(-SizeOf($2)));
                                                     $2(WVar(-  SizeOf($2))) := $2(WVar(0)); 
                                               )
     DECLARE($1_shl) body( Dec(WP, SizeOf($2));
                    $2(WVar(-SizeOf($2))) := $2(WVar(-SizeOf($2))) shl $2(WVar(0)) )
     DECLARE($1_shr) body( Dec(WP, SizeOf($2));
                    $2(WVar(-SizeOf($2))) := $2(WVar(-SizeOf($2))) shr $2(WVar(0)) )
     DECLARE($1_power) 
     idle(var 
       Power, Base, Value: Cardinal;) 
     body(
       Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
     )
     DECLARE($1_ptr_inc)
     body(
       $2(Pointer(WVar(-SizeOf(Pointer)))^) := 
                         $2(Pointer(WVar(-SizeOf(Pointer)))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     )
     DECLARE($1_ptr_dec)
     body(
       $2(Pointer(WVar(-SizeOf(Pointer)))^) := 
                         $2(Pointer(WVar(-SizeOf(Pointer)))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     )
     DECLARE($1_from_str)
     var
       S: TStr;
     body(
       S := str_pop(Machine);
       ConvertStrTo$1(StrToString(S), $2(WVar(0)));
       Inc(WP, SizeOf($2));
       DelRef(S);
')

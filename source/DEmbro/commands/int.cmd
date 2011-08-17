dnl DCommandsNumberArithmetic.pas4
define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
define(`number_arithmetic_commands', `
     DECLARE($1-push, $1_push)
         body( if State = FS_COMPILE then $1_compile_push(Machine, Command) else $1_interpret_push(Machine, Command) )

     DECLARE(genname($1, interpret@push), $1_interpret_push )
         body( $2(WP^) := $2(StrToInt(NextName)); Inc(WP, SizeOf($2)); )

     DECLARE(genname($1, compile@push), $1_compile_push )
         body( BuiltinEWO("run@$1-push"); EW_$1(StrToInt(NextName)); )

     DECLARE(genname($1, run@push), $1_run_push)
         body( $2(WP^) := ER_$1; Inc(WP, SizeOf($2)); )

     DECLARE(genname($1,1+), $1_one_plus)
         body( Inc($2(WVar(-SizeOf($2)))) )

     DECLARE(genname($1,1-), $1_one_minus)
         body( Dec($2(WVar(-SizeOf($2)))) )

     DECLARE(genname($1,div), $1_div)
         body(
           $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) div $2(WVar(-SizeOf($2))); 
           Dec(WP, SizeOf($2)); )

     DECLARE(genname($1,mod), $1_mod)
         body(
           $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) mod $2(WVar(-SizeOf($2))); 
           Dec(WP, SizeOf($2)); )

     DECLARE(genname($1,divmod), $1_divmod)
         body(
           $2(WVar(0)) := $2(WVar(-2*SizeOf($2))) mod $2(WVar(-SizeOf($2))); 
           $2(WVar(-2*SizeOf($2))) := $2(WVar(-2*SizeOf($2))) div $2(WVar(-SizeOf($2)));
           $2(WVar(-  SizeOf($2))) := $2(WVar(0)); )

     DECLARE(genname($1,shl), $1_shl)
         body(
           Dec(WP, SizeOf($2));
           $2(WVar(-SizeOf($2))) := $2(WVar(-SizeOf($2))) shl $2(WVar(0)) )

     DECLARE(genname($1,shr), $1_shr)
         body(
           Dec(WP, SizeOf($2));
           $2(WVar(-SizeOf($2))) := $2(WVar(-SizeOf($2))) shr $2(WVar(0)) )

     DECLARE($1**, $1_power) 
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
           WUI(Value);)

     DECLARE(genname($1,inc!), $1_ptr_inc)
         body(
           $2(Pointer(WVar(-SizeOf(Pointer)))^) := 
                             $2(Pointer(WVar(-SizeOf(Pointer)))^) + 1; 
           Dec(WP, SizeOf(Pointer));)

     DECLARE(genname($1,dec!), $1_ptr_dec)
         body(
           $2(Pointer(WVar(-SizeOf(Pointer)))^) := 
                             $2(Pointer(WVar(-SizeOf(Pointer)))^) - 1; 
           Dec(WP, SizeOf(Pointer));)
     ifelse($1,`',`',
         DECLARE(str->$1, $1_from_str)
             var
               S: TStr;
             body(
               S := str_pop(Machine);
               ConvertStrTo$1(StrToString(S), $2(WVar(0)));
               Inc(WP, SizeOf($2));
               DelRef(S);))
')

number_arithmetic_commands(`', TInt)
number_arithmetic_commands(int, TInt)
number_arithmetic_commands(int8, TInt8)
number_arithmetic_commands(int16, TInt16)
number_arithmetic_commands(int32, TInt32)
number_arithmetic_commands(int64, TInt64)
number_arithmetic_commands(uint, TUInt)
number_arithmetic_commands(uint8, TUInt8)
number_arithmetic_commands(uint16, TUInt16)
number_arithmetic_commands(uint32, TUInt32)
number_arithmetic_commands(uint64, TUInt64)

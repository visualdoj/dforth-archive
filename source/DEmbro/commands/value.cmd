dnl DCommandInt.pas4
define(`genname', `ifelse($1, `', $2, len($1), `1', $2, $1-$2)')
define(`NO_X86')
define(`NO_IA32')
define(`typed_commands',`
     ifdef(`_IA32',
       `
         DECLARE(genname($1,drop), drop_$1)
           idle(asm
             sub [eax], 4
           end;)

         {DECLARE(genname($1,dup), dup_$1)
           idle(asm
             mov ecx, [eax]
             mov edx, [ecx-4]
             mov [ecx], edx
             add [eax], 4
           end;)}

         DECLARE(genname($1,dup), dup_$1) body(Move(WVar(-$2), WVar(0), $2); WInc($2); )

         DECLARE(genname($1,nip), nip_$1)
           idle(asm
             mov ecx, [eax]
             lea ecx, [ecx-4]
             mov edx, [ecx]
             mov [ecx-4], edx
             mov [eax], ecx
           end;)

         DECLARE(genname($1,swap), swap_$1)
           idle(asm
             mov ecx, [eax]
             mov edx, [ecx-4]
             xchg [ecx-8], edx
             mov [ecx-4], edx
           end;)

         DECLARE(genname($1,over), over_$1)
           idle(asm
             mov ecx, [eax]
             mov edx, [ecx-8]
             mov [ecx], edx
             add [eax], 4
           end;)

         DECLARE(genname($1,tuck), tuck_$1)
           idle(asm // ab-bab  @wp=eax 
             mov ecx, [eax]       // ecx := wp 
             add [eax], 4         // @wp++
             mov edx, [ecx-4]     // edx := b
             mov [ecx], edx       // top := b
             mov eax, [ecx-8]     // eax := a
             mov [ecx-4], eax     // top[1] := a
             mov [ecx-8], edx     // top[2] := b
           end;)
       ',

         DECLARE(genname($1,drop), drop_$1)
           body(Dec(WP, $2))

         DECLARE(genname($1,dup), dup_$1)
           body(Move(WVar(-$2), WVar(0), $2); WInc($2))

         DECLARE(genname($1,nip), nip_$1)
           body(Move(WVar(-1*$2), WVar(-2*$2), $2); Dec(WP, $2))

         DECLARE(genname($1,swap), swap_$1)
           body(Move(WVar(-$2), WP^, $2); Move(WVar(-2*$2), WVar(-$2), $2); Move(WP^, WVar(-2*$2), $2);)

         DECLARE(genname($1,over), over_$1)
           body(Move(WVar(-2*$2), WVar(0), $2); Inc(WP, $2))

         DECLARE(genname($1,tuck), tuck_$1)
           body(Move(WVar(-2*$2), WVar(-1*$2), 2*$2); Move(WVar(0), WVar(-2*$2), $2); WInc($2);body)
     )

     DECLARE(genname($1,lrot), lrot_$1) 
       body(
         Move(WVar(-1*$2), WP^, $2);
         Move(WVar(-3*$2), WVar(-1*$2), $2);
         Move(WVar(-2*$2), WVar(-3*$2), $2);
         Move(WP^, WVar(-2*$2), $2);)

     DECLARE(genname($1,rrot), rrot_$1)
       body( 
         Move(WVar(-1*$2), WP^, $2);
         Move(WVar(-2*$2), WVar(-1*$2), $2);
         Move(WVar(-3*$2), WVar(-2*$2), $2);
         Move(WP^, WVar(-3*$2), $2);)

     DECLARE(genname($1,lrotn), lrotn_$1) 
       var
         N: Integer;
       body( 
         Dec(WP, SizeOf(TInt));
         N := TInt(WP^);
         Move(WVar(-$2*N), WVar(0), $2);
         while N > 0 do begin
           Move(WVar(-$2*(N-1)), WVar(-$2*N), $2);
           Dec(N);
         end;
         //Move(WVar(0), WVar(-$2), $2);
         )

     DECLARE(genname($1,rrotn), rrotn_$1)
       var
         I: Integer;
         N: Integer;
       body(
         Dec(WP, SizeOf(TInt));
         N := TInt(WP^);
         //Move(WVar(-$2), WVar(0), $2);
         for I := 0 to N - 1 do
           Move(WVar(-$2*(I+1)), WVar(-$2*I), $2);
         Move(WVar(0), WVar(-N*$2), $2);)

     DECLARE(genname($1,pick), pick_$1) 
       body( 
         Move(WVar(-SizeOf(TInt) -$2*TInt(WVar(-SizeOf(TInt)))), 
              WVar(-SizeOf(TInt)),
              $2);
         WInc($2 - SizeOf(TInt));)

     DECLARE(idle($1,),comma_$1)
       body(
         Dec(WP, $2);
         ifelse(`',$1,
           EWI(Integer(WP^));,
           EWV(WP, $2); ) )

     DECLARE($1@, _dog_$1)
       body(
         Move(Pointer(WVar(-PSize))^, WVar(-PSize), $2);
         Inc(WP, $2 - PSize))

     DECLARE(`$1!',_exclamation_$1)
       body(
         Move(WVar(-PSize-$2), Pointer(WVar(-PSize))^, $2);
         Dec(WP, PSize + $2) )

     DECLARE(ptr+$1, ptr_plus_$1)
       body( PtrInt(WVar(-SizeOf(Pointer))) := PtrInt(WVar(-SizeOf(Pointer))) + $2; )

     DECLARE(genname($1,[to]), compile_to_$1, True)
       body( BuiltinEWO("run@genname($1, `to')"); EWO(NextName); )

     DECLARE(run@genname($1, to), run_to_$1)
       var O: TOpcode;
       body(
         O := ERO;
         Move(WVar(-$2),
         C[O].Data^, $2);
         Dec(WP, $2); )

     DECLARE(interpret@genname($1, to), interpret_to_$1, True)
       var
         N: TString;
         Comm: PForthCommand;
       body( N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError("unkown name after genname($1, `to'): " + N); FSession := False; Exit; end; 
               Move(WVar(-$2), Comm.Data^, $2); Dec(WP, $2);)

     DECLARE(genname($1,to), _to_$1, True)
       body(
         if State <> FS_INTERPRET then _compile_to_$1(Machine, Command) else _interpret_to_$1(Machine, Command); )

     procedure RunValue_$1 cmdhdr;
       body( Move(Command.Data^, WP^, $2); Inc(WP, $2); )

     DECLARE(genname($1,value), _value_$1)
       body( with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_$1; Move(WVar(-$2), Here^, $2); Dec(WP, $2); EA($2); Flags := Flags and not 1; end; )

     DECLARE(genname($1, constant), _constant_$1)
       body( with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_$1; Move(WVar(-$2), Here^, $2); Dec(WP, $2); EA($2); Flags := Flags and not 1; end; )

     DECLARE(genname($1, variable), _variable_$1)
       body( with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, $2); Move(WP^, Here^, $2);} EA($2); end; )

    DECLARE(genname($1, literal), literal_$1, True)
      body( BuiltinEWO("genname($1, (literal))"); Dec(WP, $2); 
                                       ifelse(`',$1,
                                              EWI(Integer(WP^)), 
                                              EWV(WP, $2);) )

    DECLARE(genname($1, (literal)), run_literal_$1)
      body( ERV(WP, $2); Inc(WP, $2); )
')

typed_commands(`', 4)
typed_commands(ptr, 4)
typed_commands(int, 4)
typed_commands(int8, 1)
typed_commands(int16, 2)
typed_commands(int32, 4)
typed_commands(int64, 8)
typed_commands(uint, 4)
typed_commands(uint8, 1)
typed_commands(uint16, 2)
typed_commands(uint32, 4)
typed_commands(uint64, 8)
typed_commands(embro, 4)
typed_commands(float, 4)
typed_commands(double, 8)
typed_commands(extended, 10)

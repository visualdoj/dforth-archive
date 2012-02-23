



















unit DCommandsNumberArithmetic;

interface

uses
  {$I units.inc},

  DCommandsStrings,
  DForthMachine;




{$IFNDEF FLAG_FPC}{$REGION 'number_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

  
  procedure _push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure _div (Machine: TForthMachine; Command: PForthCommand);
  procedure _mod (Machine: TForthMachine; Command: PForthCommand);
  procedure _divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure _shl (Machine: TForthMachine; Command: PForthCommand);
  procedure _shr (Machine: TForthMachine; Command: PForthCommand);
  procedure _power (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;

procedure LoadCommands(Machine: TForthMachine);

implementation

 
    
     procedure _push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then _compile_push(Machine, Command) else _interpret_push(Machine, Command)  end; end;
     procedure _interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt));  end; end;
     procedure _compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@-push'); EW_(StrToInt(NextName));  end; end;
     procedure _run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := ER_; Inc(WP, SizeOf(TInt));  end; end;
     procedure _1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure _1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure _div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure _mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure _divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (0))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure _shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shl TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure _shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shr TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure _power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure _ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure _ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure _from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTo(StrToString(S), TInt((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt));
       DelRef(S);
      end; end;
    
   
    
     procedure int_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int_compile_push(Machine, Command) else int_interpret_push(Machine, Command)  end; end;
     procedure int_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt));  end; end;
     procedure int_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int-push'); EW_int(StrToInt(NextName));  end; end;
     procedure int_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := ER_int; Inc(WP, SizeOf(TInt));  end; end;
     procedure int_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure int_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure int_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure int_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure int_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (0))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shl TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shr TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrToint(StrToString(S), TInt((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt));
       DelRef(S);
      end; end;
    
   
    
     procedure int8_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int8_compile_push(Machine, Command) else int8_interpret_push(Machine, Command)  end; end;
     procedure int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(WP^) := TInt8(StrToInt(NextName)); Inc(WP, SizeOf(TInt8));  end; end;
     procedure int8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int8-push'); EW_int8(StrToInt(NextName));  end; end;
     procedure int8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(WP^) := ER_int8; Inc(WP, SizeOf(TInt8));  end; end;
     procedure int8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)))  end; end;
     procedure int8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)))  end; end;
     procedure int8_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
     procedure int8_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
     procedure int8_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (0))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                     TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^));
                                                     TInt8((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int8_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt8));
                    TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) shl TInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int8_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt8));
                    TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) shr TInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int8_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int8_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrToint8(StrToString(S), TInt8((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt8));
       DelRef(S);
      end; end;
    
   
    
     procedure int16_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int16_compile_push(Machine, Command) else int16_interpret_push(Machine, Command)  end; end;
     procedure int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(WP^) := TInt16(StrToInt(NextName)); Inc(WP, SizeOf(TInt16));  end; end;
     procedure int16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int16-push'); EW_int16(StrToInt(NextName));  end; end;
     procedure int16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(WP^) := ER_int16; Inc(WP, SizeOf(TInt16));  end; end;
     procedure int16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)))  end; end;
     procedure int16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)))  end; end;
     procedure int16_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
     procedure int16_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
     procedure int16_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (0))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                     TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^));
                                                     TInt16((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int16_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt16));
                    TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) shl TInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int16_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt16));
                    TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) shr TInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int16_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int16_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrToint16(StrToString(S), TInt16((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt16));
       DelRef(S);
      end; end;
    
   
    
     procedure int32_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int32_compile_push(Machine, Command) else int32_interpret_push(Machine, Command)  end; end;
     procedure int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(WP^) := TInt32(StrToInt(NextName)); Inc(WP, SizeOf(TInt32));  end; end;
     procedure int32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int32-push'); EW_int32(StrToInt(NextName));  end; end;
     procedure int32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(WP^) := ER_int32; Inc(WP, SizeOf(TInt32));  end; end;
     procedure int32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)))  end; end;
     procedure int32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)))  end; end;
     procedure int32_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
     procedure int32_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
     procedure int32_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (0))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                     TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^));
                                                     TInt32((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int32_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt32));
                    TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) shl TInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int32_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt32));
                    TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) shr TInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int32_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int32_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrToint32(StrToString(S), TInt32((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt32));
       DelRef(S);
      end; end;
    
   
    
     procedure int64_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int64_compile_push(Machine, Command) else int64_interpret_push(Machine, Command)  end; end;
     procedure int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(WP^) := TInt64(StrToInt(NextName)); Inc(WP, SizeOf(TInt64));  end; end;
     procedure int64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int64-push'); EW_int64(StrToInt(NextName));  end; end;
     procedure int64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(WP^) := ER_int64; Inc(WP, SizeOf(TInt64));  end; end;
     procedure int64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)))  end; end;
     procedure int64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)))  end; end;
     procedure int64_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
     procedure int64_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
     procedure int64_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (0))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                     TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^));
                                                     TInt64((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int64_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt64));
                    TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) shl TInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int64_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt64));
                    TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) shr TInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int64_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int64_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrToint64(StrToString(S), TInt64((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TInt64));
       DelRef(S);
      end; end;
    
   
    
     procedure uint_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint_compile_push(Machine, Command) else uint_interpret_push(Machine, Command)  end; end;
     procedure uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(WP^) := TUInt(StrToInt(NextName)); Inc(WP, SizeOf(TUInt));  end; end;
     procedure uint_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint-push'); EW_uint(StrToInt(NextName));  end; end;
     procedure uint_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(WP^) := ER_uint; Inc(WP, SizeOf(TUInt));  end; end;
     procedure uint_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)))  end; end;
     procedure uint_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)))  end; end;
     procedure uint_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
     procedure uint_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
     procedure uint_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                     TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^));
                                                     TUInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt));
                    TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) shl TUInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt));
                    TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) shr TUInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTouint(StrToString(S), TUInt((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TUInt));
       DelRef(S);
      end; end;
    
   
    
     procedure uint8_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint8_compile_push(Machine, Command) else uint8_interpret_push(Machine, Command)  end; end;
     procedure uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(WP^) := TUInt8(StrToInt(NextName)); Inc(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint8-push'); EW_uint8(StrToInt(NextName));  end; end;
     procedure uint8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(WP^) := ER_uint8; Inc(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)))  end; end;
     procedure uint8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)))  end; end;
     procedure uint8_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                     TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^));
                                                     TUInt8((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint8_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt8));
                    TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) shl TUInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint8_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt8));
                    TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) shr TUInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint8_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint8_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTouint8(StrToString(S), TUInt8((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TUInt8));
       DelRef(S);
      end; end;
    
   
    
     procedure uint16_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint16_compile_push(Machine, Command) else uint16_interpret_push(Machine, Command)  end; end;
     procedure uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(WP^) := TUInt16(StrToInt(NextName)); Inc(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint16-push'); EW_uint16(StrToInt(NextName));  end; end;
     procedure uint16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(WP^) := ER_uint16; Inc(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)))  end; end;
     procedure uint16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)))  end; end;
     procedure uint16_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                     TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^));
                                                     TUInt16((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint16_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt16));
                    TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) shl TUInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint16_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt16));
                    TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) shr TUInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint16_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint16_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTouint16(StrToString(S), TUInt16((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TUInt16));
       DelRef(S);
      end; end;
    
   
    
     procedure uint32_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint32_compile_push(Machine, Command) else uint32_interpret_push(Machine, Command)  end; end;
     procedure uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(WP^) := TUInt32(StrToInt(NextName)); Inc(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint32-push'); EW_uint32(StrToInt(NextName));  end; end;
     procedure uint32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(WP^) := ER_uint32; Inc(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)))  end; end;
     procedure uint32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)))  end; end;
     procedure uint32_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                     TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^));
                                                     TUInt32((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint32_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt32));
                    TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) shl TUInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint32_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt32));
                    TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) shr TUInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint32_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint32_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTouint32(StrToString(S), TUInt32((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TUInt32));
       DelRef(S);
      end; end;
    
   
    
     procedure uint64_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint64_compile_push(Machine, Command) else uint64_interpret_push(Machine, Command)  end; end;
     procedure uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(WP^) := TUInt64(StrToInt(NextName)); Inc(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint64-push'); EW_uint64(StrToInt(NextName));  end; end;
     procedure uint64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(WP^) := ER_uint64; Inc(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)))  end; end;
     procedure uint64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)))  end; end;
     procedure uint64_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                     TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^));
                                                     TUInt64((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint64_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt64));
                    TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) shl TUInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint64_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt64));
                    TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) shr TUInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint64_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint64_from_str (Machine: TForthMachine; Command: PForthCommand);
     var
       S: TStr;
     begin with Machine^ do begin S := str_pop(Machine);
       ConvertStrTouint64(StrToString(S), TUInt64((Pointer(TUInt(Machine.WP) + (0))^)));
       Inc(WP, SizeOf(TUInt64));
       DelRef(S);
      end; end;
    
  

procedure LoadCommands(Machine: TForthMachine);
begin
  
    
     Machine.AddCommand('-push', _push, True);
     Machine.AddCommand('run@-push', _run_push);
     Machine.AddCommand('inc', _1_plus);
     Machine.AddCommand('dec', _1_minus);
     Machine.AddCommand('1+', _1_plus);
     Machine.AddCommand('1-', _1_minus);
     Machine.AddCommand('inc!', _ptr_inc);
     Machine.AddCommand('dec!', _ptr_dec);
     Machine.AddCommand('1+!', _ptr_inc);
     Machine.AddCommand('1-!', _ptr_dec);
     Machine.AddCommand('div', _div);
     Machine.AddCommand('mod', _mod);
     Machine.AddCommand('divmod', _divmod);
     Machine.AddCommand('shl', _shl);
     Machine.AddCommand('shr', _shr);
     Machine.AddCommand('**', _power);
     Machine.AddCommand('str->', _from_str);
    
    
     Machine.AddCommand('int-push', int_push, True);
     Machine.AddCommand('run@int-push', int_run_push);
     Machine.AddCommand('int-inc', int_1_plus);
     Machine.AddCommand('int-dec', int_1_minus);
     
     
     Machine.AddCommand('int-inc!', int_ptr_inc);
     Machine.AddCommand('int-dec!', int_ptr_dec);
     
     
     Machine.AddCommand('int-div', int_div);
     Machine.AddCommand('int-mod', int_mod);
     Machine.AddCommand('int-divmod', int_divmod);
     Machine.AddCommand('int-shl', int_shl);
     Machine.AddCommand('int-shr', int_shr);
     Machine.AddCommand('int-**', int_power);
     Machine.AddCommand('str->int', int_from_str);
    
    
     Machine.AddCommand('int8-push', int8_push, True);
     Machine.AddCommand('run@int8-push', int8_run_push);
     Machine.AddCommand('int8-inc', int8_1_plus);
     Machine.AddCommand('int8-dec', int8_1_minus);
     
     
     Machine.AddCommand('int8-inc!', int8_ptr_inc);
     Machine.AddCommand('int8-dec!', int8_ptr_dec);
     
     
     Machine.AddCommand('int8-div', int8_div);
     Machine.AddCommand('int8-mod', int8_mod);
     Machine.AddCommand('int8-divmod', int8_divmod);
     Machine.AddCommand('int8-shl', int8_shl);
     Machine.AddCommand('int8-shr', int8_shr);
     Machine.AddCommand('int8-**', int8_power);
     Machine.AddCommand('str->int8', int8_from_str);
    
    
     Machine.AddCommand('int16-push', int16_push, True);
     Machine.AddCommand('run@int16-push', int16_run_push);
     Machine.AddCommand('int16-inc', int16_1_plus);
     Machine.AddCommand('int16-dec', int16_1_minus);
     
     
     Machine.AddCommand('int16-inc!', int16_ptr_inc);
     Machine.AddCommand('int16-dec!', int16_ptr_dec);
     
     
     Machine.AddCommand('int16-div', int16_div);
     Machine.AddCommand('int16-mod', int16_mod);
     Machine.AddCommand('int16-divmod', int16_divmod);
     Machine.AddCommand('int16-shl', int16_shl);
     Machine.AddCommand('int16-shr', int16_shr);
     Machine.AddCommand('int16-**', int16_power);
     Machine.AddCommand('str->int16', int16_from_str);
    
    
     Machine.AddCommand('int32-push', int32_push, True);
     Machine.AddCommand('run@int32-push', int32_run_push);
     Machine.AddCommand('int32-inc', int32_1_plus);
     Machine.AddCommand('int32-dec', int32_1_minus);
     
     
     Machine.AddCommand('int32-inc!', int32_ptr_inc);
     Machine.AddCommand('int32-dec!', int32_ptr_dec);
     
     
     Machine.AddCommand('int32-div', int32_div);
     Machine.AddCommand('int32-mod', int32_mod);
     Machine.AddCommand('int32-divmod', int32_divmod);
     Machine.AddCommand('int32-shl', int32_shl);
     Machine.AddCommand('int32-shr', int32_shr);
     Machine.AddCommand('int32-**', int32_power);
     Machine.AddCommand('str->int32', int32_from_str);
    
    
     Machine.AddCommand('int64-push', int64_push, True);
     Machine.AddCommand('run@int64-push', int64_run_push);
     Machine.AddCommand('int64-inc', int64_1_plus);
     Machine.AddCommand('int64-dec', int64_1_minus);
     
     
     Machine.AddCommand('int64-inc!', int64_ptr_inc);
     Machine.AddCommand('int64-dec!', int64_ptr_dec);
     
     
     Machine.AddCommand('int64-div', int64_div);
     Machine.AddCommand('int64-mod', int64_mod);
     Machine.AddCommand('int64-divmod', int64_divmod);
     Machine.AddCommand('int64-shl', int64_shl);
     Machine.AddCommand('int64-shr', int64_shr);
     Machine.AddCommand('int64-**', int64_power);
     Machine.AddCommand('str->int64', int64_from_str);
    
    
     Machine.AddCommand('uint-push', uint_push, True);
     Machine.AddCommand('run@uint-push', uint_run_push);
     Machine.AddCommand('uint-inc', uint_1_plus);
     Machine.AddCommand('uint-dec', uint_1_minus);
     
     
     Machine.AddCommand('uint-inc!', uint_ptr_inc);
     Machine.AddCommand('uint-dec!', uint_ptr_dec);
     
     
     Machine.AddCommand('uint-div', uint_div);
     Machine.AddCommand('uint-mod', uint_mod);
     Machine.AddCommand('uint-divmod', uint_divmod);
     Machine.AddCommand('uint-shl', uint_shl);
     Machine.AddCommand('uint-shr', uint_shr);
     Machine.AddCommand('uint-**', uint_power);
     Machine.AddCommand('str->uint', uint_from_str);
    
    
     Machine.AddCommand('uint8-push', uint8_push, True);
     Machine.AddCommand('run@uint8-push', uint8_run_push);
     Machine.AddCommand('uint8-inc', uint8_1_plus);
     Machine.AddCommand('uint8-dec', uint8_1_minus);
     
     
     Machine.AddCommand('uint8-inc!', uint8_ptr_inc);
     Machine.AddCommand('uint8-dec!', uint8_ptr_dec);
     
     
     Machine.AddCommand('uint8-div', uint8_div);
     Machine.AddCommand('uint8-mod', uint8_mod);
     Machine.AddCommand('uint8-divmod', uint8_divmod);
     Machine.AddCommand('uint8-shl', uint8_shl);
     Machine.AddCommand('uint8-shr', uint8_shr);
     Machine.AddCommand('uint8-**', uint8_power);
     Machine.AddCommand('str->uint8', uint8_from_str);
    
    
     Machine.AddCommand('uint16-push', uint16_push, True);
     Machine.AddCommand('run@uint16-push', uint16_run_push);
     Machine.AddCommand('uint16-inc', uint16_1_plus);
     Machine.AddCommand('uint16-dec', uint16_1_minus);
     
     
     Machine.AddCommand('uint16-inc!', uint16_ptr_inc);
     Machine.AddCommand('uint16-dec!', uint16_ptr_dec);
     
     
     Machine.AddCommand('uint16-div', uint16_div);
     Machine.AddCommand('uint16-mod', uint16_mod);
     Machine.AddCommand('uint16-divmod', uint16_divmod);
     Machine.AddCommand('uint16-shl', uint16_shl);
     Machine.AddCommand('uint16-shr', uint16_shr);
     Machine.AddCommand('uint16-**', uint16_power);
     Machine.AddCommand('str->uint16', uint16_from_str);
    
    
     Machine.AddCommand('uint32-push', uint32_push, True);
     Machine.AddCommand('run@uint32-push', uint32_run_push);
     Machine.AddCommand('uint32-inc', uint32_1_plus);
     Machine.AddCommand('uint32-dec', uint32_1_minus);
     
     
     Machine.AddCommand('uint32-inc!', uint32_ptr_inc);
     Machine.AddCommand('uint32-dec!', uint32_ptr_dec);
     
     
     Machine.AddCommand('uint32-div', uint32_div);
     Machine.AddCommand('uint32-mod', uint32_mod);
     Machine.AddCommand('uint32-divmod', uint32_divmod);
     Machine.AddCommand('uint32-shl', uint32_shl);
     Machine.AddCommand('uint32-shr', uint32_shr);
     Machine.AddCommand('uint32-**', uint32_power);
     Machine.AddCommand('str->uint32', uint32_from_str);
    
    
     Machine.AddCommand('uint64-push', uint64_push, True);
     Machine.AddCommand('run@uint64-push', uint64_run_push);
     Machine.AddCommand('uint64-inc', uint64_1_plus);
     Machine.AddCommand('uint64-dec', uint64_1_minus);
     
     
     Machine.AddCommand('uint64-inc!', uint64_ptr_inc);
     Machine.AddCommand('uint64-dec!', uint64_ptr_dec);
     
     
     Machine.AddCommand('uint64-div', uint64_div);
     Machine.AddCommand('uint64-mod', uint64_mod);
     Machine.AddCommand('uint64-divmod', uint64_divmod);
     Machine.AddCommand('uint64-shl', uint64_shl);
     Machine.AddCommand('uint64-shr', uint64_shr);
     Machine.AddCommand('uint64-**', uint64_power);
     Machine.AddCommand('str->uint64', uint64_from_str);
    ;
end;

end.

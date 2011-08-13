


















unit DCommandsConvertNumber;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DCommandsStrings,
  DForthMachine;




{$IFNDEF FLAG_FPC}{$REGION 'convert_number_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

  
  procedure int_convert_to_int8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;

procedure LoadCommands(Machine: TForthMachine);

implementation

 
    
     procedure int_convert_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt8));  end; end;
    
   
    
     procedure int_convert_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt16));  end; end;
    
   
    
     procedure int_convert_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt32));  end; end;
    
   
    
     procedure int_convert_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt64));  end; end;
    
   
    
     procedure int8_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                            Dec(WP, SizeOf(TInt8) - SizeOf(TInt));  end; end;
    
   
    
     procedure int16_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                            Dec(WP, SizeOf(TInt16) - SizeOf(TInt));  end; end;
    
   
    
     procedure int32_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                            Dec(WP, SizeOf(TInt32) - SizeOf(TInt));  end; end;
    
   
    
     procedure int64_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                            Dec(WP, SizeOf(TInt64) - SizeOf(TInt));  end; end;
    
   
    
     procedure uint_convert_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt8));  end; end;
    
   
    
     procedure uint_convert_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt16));  end; end;
    
   
    
     procedure uint_convert_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt32));  end; end;
    
   
    
     procedure uint_convert_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt64));  end; end;
    
   
    
     procedure uint8_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                            Dec(WP, SizeOf(TUInt8) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint16_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                            Dec(WP, SizeOf(TUInt16) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint32_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                            Dec(WP, SizeOf(TUInt32) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint64_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                            Dec(WP, SizeOf(TUInt64) - SizeOf(TUInt));  end; end;
    
   
    
     procedure float_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Double));  end; end;
    
   
    
     procedure double_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Single));  end; end;
    
   
    
     procedure float_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Extended));  end; end;
    
   
    
     procedure double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Extended));  end; end;
    
   
    
     procedure extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Double));  end; end;
    
   
    
     procedure extended_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Single));  end; end;
    
   
    
     procedure int_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Single));  end; end;
    
   
    
     procedure int_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Double));  end; end;
    
   
    
     procedure int_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Extended));  end; end;
    
  

procedure LoadCommands(Machine: TForthMachine);
begin
  
    Machine.AddCommand('int->int8', int_convert_to_int8);
    
    Machine.AddCommand('int->int16', int_convert_to_int16);
    
    Machine.AddCommand('int->int32', int_convert_to_int32);
    
    Machine.AddCommand('int->int64', int_convert_to_int64);
    
    Machine.AddCommand('int8->int', int8_convert_to_int);
    
    Machine.AddCommand('int16->int', int16_convert_to_int);
    
    Machine.AddCommand('int32->int', int32_convert_to_int);
    
    Machine.AddCommand('int64->int', int64_convert_to_int);
    
    Machine.AddCommand('uint->uint8', uint_convert_to_uint8);
    
    Machine.AddCommand('uint->uint16', uint_convert_to_uint16);
    
    Machine.AddCommand('uint->uint32', uint_convert_to_uint32);
    
    Machine.AddCommand('uint->uint64', uint_convert_to_uint64);
    
    Machine.AddCommand('uint8->uint', uint8_convert_to_uint);
    
    Machine.AddCommand('uint16->uint', uint16_convert_to_uint);
    
    Machine.AddCommand('uint32->uint', uint32_convert_to_uint);
    
    Machine.AddCommand('uint64->uint', uint64_convert_to_uint);
    
    Machine.AddCommand('float->double', float_convert_to_double);
    
    Machine.AddCommand('double->float', double_convert_to_float);
    
    Machine.AddCommand('float->extended', float_convert_to_extended);
    
    Machine.AddCommand('double->extended', double_convert_to_extended);
    
    Machine.AddCommand('extended->double', extended_convert_to_double);
    
    Machine.AddCommand('extended->float', extended_convert_to_float);
    
    Machine.AddCommand('int->float', int_convert_to_float);
    
    Machine.AddCommand('int->double', int_convert_to_double);
    
    Machine.AddCommand('int->extended', int_convert_to_extended);
    ;
end;

end.

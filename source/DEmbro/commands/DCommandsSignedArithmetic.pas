


















unit DCommandsSignedArithmetic;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DCommandsStrings,
  DForthMachine;




{$IFNDEF FLAG_FPC}{$REGION 'signed_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

  
  procedure _abs (Machine: TForthMachine; Command: PForthCommand);
  procedure _neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure float_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure double_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;

procedure LoadCommands(Machine: TForthMachine);

implementation

 
    procedure _abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)));  end; end;
     procedure _neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));  end; end;
    
   
    procedure int_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)));  end; end;
     procedure int_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));  end; end;
    
   
    procedure int8_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := Abs(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)));  end; end;
     procedure int8_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := - TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^));  end; end;
    
   
    procedure int16_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := Abs(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)));  end; end;
     procedure int16_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := - TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^));  end; end;
    
   
    procedure int32_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := Abs(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)));  end; end;
     procedure int32_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := - TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^));  end; end;
    
   
    procedure int64_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := Abs(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)));  end; end;
     procedure int64_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := - TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^));  end; end;
    
   
    procedure float_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Abs(Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)));  end; end;
     procedure float_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := - Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^));  end; end;
    
   
    procedure double_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Abs(Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)));  end; end;
     procedure double_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := - Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^));  end; end;
    
  

procedure LoadCommands(Machine: TForthMachine);
begin
  
    Machine.AddCommand('abs', _abs);
     Machine.AddCommand('neg', _neg);
    
    Machine.AddCommand('int-abs', int_abs);
     Machine.AddCommand('int-neg', int_neg);
    
    Machine.AddCommand('int8-abs', int8_abs);
     Machine.AddCommand('int8-neg', int8_neg);
    
    Machine.AddCommand('int16-abs', int16_abs);
     Machine.AddCommand('int16-neg', int16_neg);
    
    Machine.AddCommand('int32-abs', int32_abs);
     Machine.AddCommand('int32-neg', int32_neg);
    
    Machine.AddCommand('int64-abs', int64_abs);
     Machine.AddCommand('int64-neg', int64_neg);
    
    Machine.AddCommand('float-abs', float_abs);
     Machine.AddCommand('float-neg', float_neg);
    
    Machine.AddCommand('double-abs', double_abs);
     Machine.AddCommand('double-neg', double_neg);
    ;
end;

end.

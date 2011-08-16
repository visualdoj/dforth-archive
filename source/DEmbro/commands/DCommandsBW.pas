


















unit DCommandsBW;

interface
















uses
  {$I units.inc},

  DForthMachine;

    procedure bdog (Machine: TForthMachine; Command: PForthCommand);
    procedure bexclamation (Machine: TForthMachine; Command: PForthCommand);
    procedure _binc (Machine: TForthMachine; Command: PForthCommand);
    procedure _bdec (Machine: TForthMachine; Command: PForthCommand);
    procedure bdrop (Machine: TForthMachine; Command: PForthCommand);
    procedure bdup (Machine: TForthMachine; Command: PForthCommand);
    procedure bnip (Machine: TForthMachine; Command: PForthCommand);
    procedure bswap (Machine: TForthMachine; Command: PForthCommand);
    procedure bover (Machine: TForthMachine; Command: PForthCommand);
    procedure btuck (Machine: TForthMachine; Command: PForthCommand);
    procedure blrot (Machine: TForthMachine; Command: PForthCommand);
    procedure brrot (Machine: TForthMachine; Command: PForthCommand);

    procedure _BtoW(Machine: TForthMachine; Command: PForthCommand);
    procedure _WtoB(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

     procedure bdog (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(WP), (SizeOf(Pointer))); TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(WP^)^); 
                                   if TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ <> -1 then Inc(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^); 
                 end; Inc(BWP, (SizeOf(Pointer)));  end; end;
     procedure bexclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(WP), (SizeOf(Pointer))); Dec(TUInt(BWP), (SizeOf(Pointer)));  if TBlock(Pointer(WP^)^) <> nil then begin
                   if PInteger(TBlock(Pointer(WP^)^))^ > 1 then Dec(PInteger(TBlock(Pointer(WP^)^))^)
                   else if PInteger(TBlock(Pointer(WP^)^))^ = 1 then FreeMem(Pointer(TBlock(Pointer(WP^)^))); 
                 end;
                                          TBlock(Pointer(WP^)^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^); end; end;
     procedure _binc (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(WP), (SizeOf(Pointer)));  if TBlock(Pointer(WP^)) <> nil then begin
                   if PInteger(TBlock(Pointer(WP^)))^ <> -1 then Inc(PInteger(TBlock(Pointer(WP^)))^); 
                 end;  end; end;
     procedure _bdec (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(WP), (SizeOf(Pointer)));  if TBlock(Pointer(WP^)) <> nil then begin
                   if PInteger(TBlock(Pointer(WP^)))^ > 1 then Dec(PInteger(TBlock(Pointer(WP^)))^)
                   else if PInteger(TBlock(Pointer(WP^)))^ = 1 then FreeMem(Pointer(TBlock(Pointer(WP^)))); 
                 end;  end; end;
     procedure bdrop (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(BWP), (SizeOf(Pointer)));  if TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ > 1 then Dec(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^)
                   else if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ = 1 then FreeMem(Pointer(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))); 
                 end;  end; end;
     procedure bdup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^);  if TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ <> -1 then Inc(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^); 
                 end; Inc(BWP, (SizeOf(Pointer)));  end; end;
     procedure bnip (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt(BWP), (SizeOf(Pointer)));  if TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^))^ > 1 then Dec(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^))^)
                   else if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^))^ = 1 then FreeMem(Pointer(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^))); 
                 end; TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^);  end; end;
     procedure bswap (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^); TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^);
                                   TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^);  end; end;
     procedure bover (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^);  if TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ <> -1 then Inc(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^); 
                 end; Inc(BWP, (SizeOf(Pointer)));  end; end;
     procedure btuck (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^); TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^);
                                   TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^); Inc(BWP, (SizeOf(Pointer)));  if TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) <> nil then begin
                   if PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^ <> -1 then Inc(PInteger(TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^))^); 
                 end end; end;
     procedure blrot (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-3)*(SizeOf(Pointer)))^);  TBlock(Pointer(TUInt(Machine.BWP) + (-3)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^); 
       TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^); TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^);
      end; end;
     procedure brrot (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^);  TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^); 
       TBlock(Pointer(TUInt(Machine.BWP) + (-2)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (-3)*(SizeOf(Pointer)))^); TBlock(Pointer(TUInt(Machine.BWP) + (-3)*(SizeOf(Pointer)))^) := TBlock(Pointer(TUInt(Machine.BWP) + (0)*(SizeOf(Pointer)))^);
      end; end;

    procedure _BtoW(Machine: TForthMachine; Command: PForthCommand);
    begin
      Machine.WUP(Machine.BWO);
    end;

    procedure _WtoB(Machine: TForthMachine; Command: PForthCommand);
    begin
      Machine.BWU(Machine.WOP);
    end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('b@',           bdog);
  Machine.AddCommand('b!',           bexclamation);
  Machine.AddCommand('b' + 'inc',         _binc);
  Machine.AddCommand('b' + 'dec',         _bdec);
  Machine.AddCommand('bdup',         bdup);
  Machine.AddCommand('bdrop',        bdrop);
  Machine.AddCommand('bdup',         bdup);
  Machine.AddCommand('bnip',         bnip);
  Machine.AddCommand('bswap',        bswap);
  Machine.AddCommand('bover',        bover);
  Machine.AddCommand('btuck',        btuck);
  Machine.AddCommand('blrot',        blrot);
  Machine.AddCommand('brrot',        brrot);
  
  Machine.AddCommand('w>b', _WtoB);
  Machine.AddCommand('b>w', _BtoW);
end;

end.

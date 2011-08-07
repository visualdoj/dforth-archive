


















unit DCommandsMem;

interface

uses
  {$I units.inc},
  DForthMachine;

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _malloc (Machine: TForthMachine; Command: PForthCommand); 
var 
  P: Pointer; 
begin with Machine^ do begin P := Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^));
  GetMem(P, Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^))); 
  Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)) := P;
 end; end;

procedure _free (Machine: TForthMachine; Command: PForthCommand); 
var 
  P: Pointer; 
begin with Machine^ do begin Dec(WP, SizeOf(Pointer));
  P := Pointer(WP^);
  FreeMem(P);
 end; end;

procedure _realloc (Machine: TForthMachine; Command: PForthCommand);
var 
  P: Pointer;
begin with Machine^ do begin Dec(WP, SizeOf(Pointer));
  Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := 
      ReAllocMem(Pointer(WP^), Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)));
 end; end;

procedure _move (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(Pointer)*3); Move(Pointer((Pointer(TUInt(Machine.WP) + (0))^))^, Pointer((Pointer(TUInt(Machine.WP) + (SizeOf(Pointer)))^))^, TUint((Pointer(TUInt(Machine.WP) + (2*SizeOf(Pointer)))^))); {Writeln(TUInt((Pointer(TUInt(Machine.WP) + (0))^)), TUInt((Pointer(TUInt(Machine.WP) + (SizeOf(Pointer)))^)), TUint((Pointer(TUInt(Machine.WP) + (2*SizeOf(Pointer)))^)));}  end; end;

procedure _fill0 (Machine: TForthMachine; Command: PForthCommand);
begin with Machine^ do begin Dec(WP, 2*SizeOf(Pointer));
  FillChar(Pointer((Pointer(TUInt(Machine.WP) + (0))^))^, Integer((Pointer(TUInt(Machine.WP) + (SizeOf(Pointer)))^)), 0);
 end; end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('malloc', _malloc);
  Machine.AddCommand('free', _free);
  Machine.AddCommand('realloc', _realloc);
  Machine.AddCommand('move', _move);
  Machine.AddCommand('fill0', _fill0);
end;

end.

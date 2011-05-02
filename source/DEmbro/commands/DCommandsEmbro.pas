unit DCommandsEmbro;

interface

uses
  DForthMachine;

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _here(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Pointer(WP^) := @E[EL];
    Inc(WP, SizeOf(Pointer));
  end;
end;

procedure allot(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin
  with Machine^ do begin
    I := Machine.WOI;
    Machine.IncHere(I);
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('here', _here);
  Machine.AddCommand('allot', allot);  
end;

end.

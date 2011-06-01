


















unit DCommandsBool;

interface

uses
  DEmbroCore,
  DForthMachine;

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _false(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.WUI(BOOL_FALSE);
  end;
end;

procedure _true(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.WUI(BOOL_TRUE);
  end;
end;

procedure _not(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.WUI(not Machine.WOI);
  end;
end;

procedure _or(Machine: TForthMachine; Command: PForthCommand);
var
  a, b: TInt;
begin
  with Machine^ do begin
    Machine.WUI(Machine.WOI or Machine.WOI);
  end;
end;

procedure _and(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.WUI(Machine.WOI and Machine.WOI);
  end;
end;

procedure _xor(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.WUI(Machine.WOI xor Machine.WOI);
  end;
end;

procedure _bool_dot(Machine: TForthMachine; Command: PForthCommand);
var
  a: TInt;
begin
  with Machine^ do begin
    a := Machine.WOI;
    if a = 0 then
      Write('FALSE ')
    else
      Write('TRUE ')
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('bool-false', _false);
  Machine.AddCommand('bool-true', _true);
  Machine.AddCommand('bool-not', _not);
  Machine.AddCommand('bool-or', _or);
  Machine.AddCommand('bool-and', _and);
  Machine.AddCommand('bool-xor', _xor);
  Machine.AddCommand('bool.', _bool_dot);
  Machine.AddCommand('false', _false);
  Machine.AddCommand('true', _true);
  Machine.AddCommand('not', _not);
  Machine.AddCommand('or', _or);
  Machine.AddCommand('and', _and);
  Machine.AddCommand('xor', _xor);  
end;

end.
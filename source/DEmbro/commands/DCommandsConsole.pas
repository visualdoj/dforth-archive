unit DCommandsConsole;

interface

uses
  DEmbroCore,
  DForthMachine;

procedure cr(Machine: TForthMachine; Command: PForthCommand);
procedure emit(Machine: TForthMachine; Command: PForthCommand);
procedure space(Machine: TForthMachine; Command: PForthCommand);
procedure spaces(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure cr;
begin
  with Machine^ do begin
    Writeln;
  end;
end;

procedure emit;
var
  I: Integer;
begin
  with Machine^ do begin
    //Machine.Stack.Pop(@I, SizeOf(I));
    Write(Char(WOI));
  end;
end;

procedure space;
begin
  with Machine^ do begin
    Write(' ');
  end;
end;

procedure spaces;
var
  I: TInt;
begin
  with Machine^ do begin
    I := Machine.WOI;
    while I > 0 do begin
      SPACE(Machine, Command);
      Dec(I);
    end;
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('cr', cr);
  Machine.AddCommand('emit', emit);
  Machine.AddCommand('space', space);
  Machine.AddCommand('spaces', spaces);
end;

end.

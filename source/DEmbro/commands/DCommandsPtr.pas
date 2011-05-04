


















unit DCommandsPtr;

interface

uses
  DForthMachine;

  procedure _nil(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _nil(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    P := nil;
    Machine.WUP(nil);
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('nil', _nil);
end;

end.

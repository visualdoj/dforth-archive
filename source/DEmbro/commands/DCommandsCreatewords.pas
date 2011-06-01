


















unit DCommandsCreatewords;

interface

uses
  {$I units.inc},

  strings,

  DEmbroCore,
  DCommandsBW,
  DForthMachine;

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure _create(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    Name := Machine.NextName;
    NewCommand := Machine.ReserveName(Name);
    NewCommand^.Code := putdataptr;
    NewCommand^.Data := Machine.Here;
    Machine.OnUpdateCommand(NewCommand);
  end;
end;

procedure _created(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    Name := Machine.WOS;
    NewCommand := Machine.ReserveName(Name);
    NewCommand^.Code := putdataptr;
    NewCommand^.Data := Machine.Here;
    Machine.OnUpdateCommand(NewCommand);
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('create', _create);
  Machine.AddCommand('created', _created);
end;

end.
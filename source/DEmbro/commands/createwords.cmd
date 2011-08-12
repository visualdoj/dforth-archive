DECLARE(create)
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

DECLARE(created)
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

DECLARE(create-noname, create_noname)
  var
    Name: TString;
    NewCommand: PForthCommand;
  begin
    with Machine^ do begin
      NewCommand := Machine.ReserveName('');
      NewCommand^.Code := putdataptr;
      NewCommand^.Data := Machine.Here;
      Machine.OnUpdateCommand(NewCommand);
    end;
  end;

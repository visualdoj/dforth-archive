unit DCommandsControl;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DCommandsStrings,
  DForthMachine;

procedure compile_def(Machine: TForthMachine; Command: PForthCommand);
procedure compile_noname(Machine: TForthMachine; Command: PForthCommand);
procedure compile_enddef(Machine: TForthMachine; Command: PForthCommand);
procedure compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
procedure compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand);
procedure scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
procedure branch(Machine: TForthMachine; Command: PForthCommand);
procedure _ask_branch(Machine: TForthMachine; Command: PForthCommand);
procedure _gt_mark(Machine: TForthMachine; Command: PForthCommand);
procedure _gt_resolve(Machine: TForthMachine; Command: PForthCommand);
procedure _lt_mark(Machine: TForthMachine; Command: PForthCommand);
procedure _lt_resolve(Machine: TForthMachine; Command: PForthCommand);
procedure recurse(Machine: TForthMachine; Command: PForthCommand);
procedure immediate(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure compile_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
  PName: PChar;
begin
  with Machine^ do begin
    Name := Machine.NextName;
    PName := CopyStrToPChar(Name);
    NewCommand := Machine.ReserveName('');
    NewCommand^.Code := call;
    SetImmediate(NewCommand, False);
    Integer(NewCommand^.Data) := Machine.EL;
    Machine.State := FS_COMPILE;
    Machine.LUI(Machine.FLastMnemonic);
    Machine.LUP(PName);
    Machine.LUI(101);
  end;
end;

procedure compile_noname(Machine: TForthMachine; Command: PForthCommand);
var
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    NewCommand := Machine.ReserveName('');
    NewCommand^.Code := call;
    SetImmediate(NewCommand, False);
    Integer(NewCommand^.Data) := Machine.EL;
    Machine.State := FS_COMPILE;
    Machine.WUP(NewCommand);
    Machine.LUI(Machine.FLastMnemonic);
    Machine.LUP(Pointer(PChar('')));
    Machine.LUI(101);
  end;
end;

procedure compile_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  B: TString;
  Index: TInt;
  P: PChar;
  ID: Integer;
begin
  with Machine^ do begin
    //B := str_pop(Machine);
    //Machine.C[Machine.WOI]^.Name := PChar(TString(PChar(@TStrRec(B^).Sym[0])));
    //DelRef(B);
    ID := Machine.LOI;
    if ID = 201 then begin
      _gt_resolve(Machine, nil);
    end;
    P := Machine.LOP;
    Index := Machine.LOI;
    Machine.C[Index]^.Name := P;
    Machine.BuiltinEWO('exit');
    Machine.State := FS_INTERPRET;
    Machine.C[Index]^.Flags := Machine.C[Index]^.Flags and not 1;
    Machine.OnUpdateCommand(Index);
    Machine.FLastMnemonic := Index;
    //Writeln('LAST COMMAND ', High(Machine.C), ' ' + Machine.C[High(Machine.C)].Name);
  end;
end;

procedure compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  C: PForthCommand;
begin
 // with Machine^ do begin
    Machine.State := FS_COMPILE;
    Name := Machine.NextName;
    C := Machine.FindCommand(Name);
    if C = nil then begin
      Machine.LogError('Command not found: ' + Name);
      Exit;
    end;
    Machine.WUU(Cardinal((@Machine.E[Cardinal(C^.Param)])^));
    Cardinal((@Machine.E[Cardinal(C^.Param)])^) := Machine.EL;
    Machine.WUP(C);
 // end;
end;

procedure compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  P: Cardinal;
begin
 // with Machine^ do begin
    C := Machine.WOP;
    P := Cardinal(C^.Param);
    Machine.BuiltinEWO('branch');
    Cardinal(C^.Param) := Machine.EL;
    Machine.EWU(Machine.WOU);
    Machine.State := FS_INTERPRET;
 // end;
end;

procedure scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
begin
  with Machine^ do begin
    Machine.BuiltinEWO('branch');
    Cardinal(Machine.C[Machine.FLastMnemonic]^.Param) := Machine.EL;
    Machine.EWU(Machine.EL + SizeOf(TUInt));
  end;
end;

procedure branch(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.EC := Machine.ERU;
  end;
end;

procedure _ask_branch(Machine: TForthMachine; Command: PForthCommand);
var
  B: TInt;
  Temp: Cardinal;
begin
  with Machine^ do begin
    B := Machine.WOI;
    Temp := Machine.ERU;
    if B = BOOL_FALSE then
      Machine.EC := Temp;
  end;
end;

procedure _gt_mark(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.EL;
    Machine.WUU(Temp);
    Machine.EWU(Temp);
  end;
end;

procedure _gt_resolve(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.WOU;
    PC := Machine.EL;
    Move(PC, Pointer(@Machine.E[Temp])^, SizeOf(PC));
  end;
end;

procedure _lt_mark(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.EL;
    Machine.WUU(Temp);
  end;
end;

procedure _lt_resolve(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.WOU;
    Machine.EWU(Temp);
  end;
end;

procedure recurse(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.EWO(Machine.FLastMnemonic);
  end;
end;

procedure immediate(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    SetImmediate(Machine.C[Machine.FLastMnemonic], True);
  end;
end;

procedure LoadCommands(Machine: TForthMachine);
begin
{$IFNDEF FLAG_FPC}{$REGION 'control commands'}{$ENDIF}
  Machine.AddCommand(':', compile_def);
  Machine.AddCommand(':noname', compile_noname);
  Machine.AddCommand(';', compile_enddef, True);
  Machine.AddCommand('skip-to;', compile_enddef, True);
  Machine.AddCommand('...', scattered_dots, True);
  Machine.AddCommand('..:', compile_scattered_def);
  Machine.AddCommand(';..', compile_scattered_enddef, True);
  Machine.AddCommand('branch', branch);
  Machine.AddCommand('?branch', _ask_branch);
  Machine.AddCommand('>mark', _gt_mark);
  Machine.AddCommand('>resolve', _gt_resolve);
  Machine.AddCommand('<mark', _lt_mark);
  Machine.AddCommand('<resolve', _lt_resolve);
  Machine.AddCommand('recurse', recurse, True);
  Machine.AddCommand('immediate', immediate);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}  
end;

end.

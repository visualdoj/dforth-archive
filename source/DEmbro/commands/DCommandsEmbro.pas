


















unit DCommandsEmbro;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DCommandsStrings,
  DForthMachine;

{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
procedure compile(Machine: TForthMachine; Command: PForthCommand);
procedure q_compile_q(Machine: TForthMachine; Command: PForthCommand);
procedure _call(Machine: TForthMachine; Command: PForthCommand);
procedure postpone(Machine: TForthMachine; Command: PForthCommand);
procedure _compiled(Machine: TForthMachine; Command: PForthCommand);
procedure _postponed(Machine: TForthMachine; Command: PForthCommand);
procedure _called(Machine: TForthMachine; Command: PForthCommand);
procedure _execute(Machine: TForthMachine; Command: PForthCommand);
procedure Evaluate(Machine: TForthMachine; Command: PForthCommand);
procedure EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

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

procedure compile(Machine: TForthMachine; Command: PForthCommand);
var
  U: TUInt;
begin
  with Machine^ do begin
    //if Machine.State = FS_COMPILE then begin
      Machine.BuiltinEWO('(compile)');
      Machine.EWO(Machine.NextName);
    //end else begin
    //  Machine.EWO(Machine.C[Machine.ERU].Name);
    //end;
  end;
end;

procedure q_compile_q(Machine: TForthMachine; Command: PForthCommand);
var
  O: TOpcode;
begin
  with Machine^ do begin
    O := Machine.ERU;
    Machine.EWO(Machine.C[O].Name);
  end;
end;

procedure _call(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.EWO(Machine.NextName);
end;

procedure postpone(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  Opcode: TOpcode;
begin
  C := Machine.FindCommand(Machine.NextName, @Opcode);
  // Writeln(C^.Name);
  if not IsImmediate(C) then
    Machine.BuiltinEWO('(compile)');
  Machine.EWO(Opcode)
end;

procedure _compiled(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    //if Machine.State = FS_COMPILE then begin
      Machine.BuiltinEWO('(compile)');
      Machine.EWO(Machine.WOS);
    //end else begin
    //  Machine.EWO(Machine.C[Machine.ERU].Name);
    //end;
  end;
end;

procedure _postponed(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  Opcode: TOpcode;
begin
  C := Machine.FindCommand(Machine.WOS, @Opcode);
  // Writeln(C^.Name);
  if not IsImmediate(C) then
    Machine.BuiltinEWO('(compile)');
  Machine.EWO(Opcode)
end;

procedure _called(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.EWO(Machine.WOS);
end;

procedure _execute(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.InterpretName(PChar(Machine.NextName));
  end;
end;

procedure Evaluate(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  S := str_pop(Machine);
  Machine.Interpret(PChar(@(PStrRec(S)^.Sym[0])));
  DelRef(S);
end;

procedure EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
var
  F: TextFile;
  S: TStr;
  B: TString;
  T: TString;
  FullPath: TString;
  ShortPath: TString;
begin
  S := str_pop(Machine);
  ShortPath := TString(PChar(@(PStrRec(S)^.Sym[0])));
  FullPath := '';
  while True do begin
    if Length(Machine.Directories) > 0 then begin
      FullPath := Machine.Directories[High(Machine.Directories)] + ShortPath;
      if FileExists(FullPath) then 
        Break;
    end;
    FullPath := PChar(GetCurrentDirectory) + '\' + ShortPath;
    if FileExists(FullPath) then 
      Break;
    FullPath := PChar(GetExeDirectory) + '\' + ShortPath;
    if FileExists(FullPath) then 
      Break;
    Exit;
  end;
  SetLength(Machine.Directories, Length(Machine.Directories) + 1);
  Machine.Directories[High(Machine.Directories)] := GetDirectory(FullPath);
  DelRef(S);
  Machine.InterpretFile(FullPath);
  SetLength(Machine.Directories, Length(Machine.Directories) - 1);
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('here', _here);
  Machine.AddCommand('allot', allot);  

  Machine.AddCommand('compile', compile, True);
  Machine.AddCommand('(compile)', q_compile_q, True);
  Machine.AddCommand('call', _call, True);
  Machine.AddCommand('postpone', postpone, True);
  Machine.AddCommand('compiled', _compiled, False);
  Machine.AddCommand('postponed', _postponed, False);
  Machine.AddCommand('called', _called, False);
  Machine.AddCommand('evaluate', Evaluate);
  Machine.AddCommand('evaluate-file', EvaluateFile);
end;

end.
DECLARE(here)
  begin
    with Machine^ do begin
      Pointer(WP^) := @E[EL];
      Inc(WP, SizeOf(Pointer));
    end;
  end;

DECLARE(allot)
  var
    I: Integer;
  begin
    with Machine^ do begin
      I := Machine.WOI;
      Machine.IncHere(I);
    end;
  end;

DECLARE(compile)
  begin
    with Machine^ do begin
        Machine.BuiltinEWO('(compile)');
        Machine.EWO(Machine.NextName);
    end;
  end;

DECLARE((compile), q_compile_q)
  var
    O: TOpcode;
  begin
    with Machine^ do begin
      O := Machine.ERU;
      Machine.EWO(Machine.C[O].Name);
    end;
  end;

DECLARE(call)
  begin
    Machine.EWO(Machine.NextName);
  end;

DECLARE(postpone)
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

DECLARE(compiled)
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

DECLARE(postponed)
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

DECLARE(called)
  begin
    Machine.EWO(Machine.WOS);
  end;

DECLARE(execute)
  begin
    with Machine^ do begin
      Machine.InterpretName(PChar(Machine.NextName));
    end;
  end;

DECLARE(evaluate)
  var
    S: TStr;
  begin
    S := str_pop(Machine);
    Machine.Interpret(PChar(@(PStrRec(S)^.Sym[0])));
    DelRef(S);
  end;

DECLARE(evaluate-file, evaluate_file)
  var
    S: TStr;
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

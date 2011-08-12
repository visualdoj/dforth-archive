DECLARE(:, compile_def)
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

DECLARE(:noname, compile_noname)
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

DECLARE(;, compile_enddef, True)
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

DECLARE(..:, compile_scattered_def)
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

DECLARE(;.., compile_scattered_enddef, True)
  var
    C: PForthCommand;
    //P: Cardinal;
  begin
   // with Machine^ do begin
      C := Machine.WOP;
      //P := Cardinal(C^.Param);
      Machine.BuiltinEWO('branch');
      Cardinal(C^.Param) := Machine.EL;
      Machine.EWU(Machine.WOU);
      Machine.State := FS_INTERPRET;
   // end;
  end;

DECLARE(..., scattered_dots, True)
  begin
    with Machine^ do begin
      Machine.BuiltinEWO('branch');
      Cardinal(Machine.C[Machine.FLastMnemonic]^.Param) := Machine.EL;
      Machine.EWU(Machine.EL + SizeOf(TUInt));
    end;
  end;

DECLARE(branch)
  begin
    with Machine^ do begin
      Machine.EC := Machine.ERU;
    end;
  end;

DECLARE(?branch, _ask_branch)
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

DECLARE(>mark, _gt_mark)
  var
    Temp: Cardinal;
  begin
    with Machine^ do begin
      Temp := Machine.EL;
      Machine.WUU(Temp);
      Machine.EWU(Temp);
    end;
  end;

DECLARE(>resolve, _gt_resolve)
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

DECLARE(<mark, _lt_mark)
  var
    Temp: Cardinal;
  begin
    with Machine^ do begin
      Temp := Machine.EL;
      Machine.WUU(Temp);
    end;
  end;

DECLARE(<resolve, _lt_resolve)
  var
    Temp: Cardinal;
  begin
    with Machine^ do begin
      Temp := Machine.WOU;
      Machine.EWU(Temp);
    end;
  end;

DECLARE(recurse,, True)
  begin
    with Machine^ do begin
      Machine.EWO(Machine.FLastMnemonic);
    end;
  end;

DECLARE(immediate)
  begin
    with Machine^ do begin
      SetImmediate(Machine.C[Machine.FLastMnemonic], True);
    end;
  end;

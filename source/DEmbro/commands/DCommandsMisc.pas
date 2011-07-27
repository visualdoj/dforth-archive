


















unit DCommandsMisc;

interface







uses
  {$I units.inc},

  DCommandsStrings,

  DForthMachine;

  procedure _timer (Machine: TForthMachine; Command: PForthCommand);
  procedure _DogwpTemp (Machine: TForthMachine; Command: PForthCommand);
  procedure _wp (Machine: TForthMachine; Command: PForthCommand);
  procedure _rp (Machine: TForthMachine; Command: PForthCommand);
  procedure _lp (Machine: TForthMachine; Command: PForthCommand);
  procedure _lb (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_dog (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _lt_r (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_dog (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure version (Machine: TForthMachine; Command: PForthCommand);
  procedure _state (Machine: TForthMachine; Command: PForthCommand);
  procedure _time (Machine: TForthMachine; Command: PForthCommand);
  procedure _local (Machine: TForthMachine; Command: PForthCommand);
  procedure source_cut (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_char (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_name (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_line (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_line_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure run_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure source_read_to_char (Machine: TForthMachine; Command: PForthCommand);
  procedure ptr_nil (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_start (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_start (Machine: TForthMachine; Command: PForthCommand);
  procedure run_start (Machine: TForthMachine; Command: PForthCommand);
  //procedure allot (Machine: TForthMachine; Command: PForthCommand)
  procedure opcode_to_command (Machine: TForthMachine; Command: PForthCommand);
  procedure literal (Machine: TForthMachine; Command: PForthCommand);
  procedure sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure run_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure _tick (Machine: TForthMachine; Command: PForthCommand);
  procedure execute (Machine: TForthMachine; Command: PForthCommand);
  procedure _does_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _sq_does_gt_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure CallDoesGt (Machine: TForthMachine; Command: PForthCommand);
  procedure Cells (Machine: TForthMachine; Command: PForthCommand);
  procedure Cell_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _malloc (Machine: TForthMachine; Command: PForthCommand);
  procedure _free (Machine: TForthMachine; Command: PForthCommand);
  procedure _last (Machine: TForthMachine; Command: PForthCommand);
  procedure _xt_dot_n (Machine: TForthMachine; Command: PForthCommand);
  procedure _xt_dot_d (Machine: TForthMachine; Command: PForthCommand);
  procedure _move (Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

      procedure _nop (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin  end; end;
      procedure _timer (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(GetTimer);  end; end;
      procedure _DogwpTemp (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := @WP; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _wp (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := WP; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _rp (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := RP; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _lp (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := LP; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _lb (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := LB; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _r_dog (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := Pointer(Pointer(Cardinal(RP) - SizeOf(Pointer))^); Inc(WP, SizeOf(Pointer));  end; end;
      procedure _r_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(RP, SizeOf(Pointer)); Pointer(WP^) := Pointer(RP^); Inc(WP, SizeOf(Pointer));  end; end;
      procedure _lt_r (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(Pointer)); Pointer(RP^) := Pointer(WP^); Inc(RP, SizeOf(Pointer));  end; end;
      procedure _l_dog (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := Pointer((Pointer(TUInt(LB) + (Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))))^));  end; end;
      procedure _l_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer((Pointer(TUInt(LB) + (Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))))^)) := Pointer((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Pointer)))^)); Dec(WP, 2*SizeOf(Pointer));  end; end;
      procedure _l_plus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt)); Inc(LP, TInt(WP^))  end; end;
      procedure version (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := DFORTHMACHINE_VERSION; Inc(WP, SizeOf(TInt));  end; end;
      procedure _state (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := @State; Inc(WP, SizeOf(Pointer));  end; end;
      procedure _time (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Integer(WP^) := GetTimer; Inc(WP, SizeOf(TInt));  end; end;
      procedure _local (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin RunCommand(PForthCommand((@E[Integer(Command^.Data)])^));  end; end;
      procedure source_cut (Machine: TForthMachine; Command: PForthCommand);
        var _S: TStr; _L: TString;
        begin with Machine^ do begin _S := str_pop(Machine); 
          _L := StrToString(_S);
          WUS(Source^.SourceCut(_L));
          DelRef(_S) end; end;
      procedure source_next_char (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(Integer(NextChar))  end; end;
      procedure source_next_name (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin str_push(Machine, NextName)  end; end;
      procedure source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin // if State <> FS_INTERPRET then compile_source_next_name_passive(Machine, Command) else 
                                                                                                   interpret_source_next_name_passive(Machine, Command)  end; end;
      procedure source_next_line (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin str_push(Machine, Machine.Source^.NextLine)  end; end;
      procedure source_next_line_passive (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin str_push(Machine, Machine.Source^.NextLinePassive)  end; end;
      procedure interpret_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin str_push(Machine, NextNamePassive)  end; end;
      procedure compile_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('(str)' + Char(34)); EWStr(NextNamePassive);  end; end;
      procedure run_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin str_push(Machine, @E[EC]);  end; end;
      procedure source_read_to_char (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 1);
        while not Source^.EOS do
          if Source^.NextChar = TChar(WP^) then
             break;  end; end;
      procedure ptr_nil (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(nil);  end; end;
      procedure compile_start (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin State := FS_COMPILE  end; end;
      procedure interpret_start (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin State := FS_INTERPRET  end; end;
      procedure run_start (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin State := FS_INTERPRET  end; end;
      procedure opcode_to_command (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)) := GetCommandByOpcode(Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)))  end; end;
      procedure literal (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('(literal)'); EWI(WOI);  end; end;
      //procedure sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin {if State <> FS_INTERPRET then compile_sq_ap_sq(Machine, Command) else interpret_sq_ap_sq(Machine, Command)}
      //          WUI(GetOpcodeByName(NextName)); Literal(Machine, Command);
      //          BuiltinEWO('opcode->command');  end; end; 
      procedure sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(FindCommand(NextName)); literal(Machine, Command);  end; end;
      procedure interpret_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(FindCommand(NextName))  end; end;
      procedure compile_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@['']'); EWO(NextName);  end; end;
      procedure run_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(C[ERO]);  end; end;
      procedure _tick (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := FindCommand(NextName); Inc(WP, SizeOf(Pointer));  end; end;
      procedure execute (Machine: TForthMachine; Command: PForthCommand); var P: PForthCommand; begin with Machine^ do begin P := WOP;
                                             P.Code(Machine, P)  end; end;
      procedure _does_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('(does>)'); BuiltinEWO('exit');  end; end;
      procedure _sq_does_gt_sq (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Integer(C[FLastMnemonic].Param) := Integer(C[FLastMnemonic].Data); Integer(C[FLastMnemonic].Data) := EC + 4; C[FLastMnemonic].Code := CallDoesGt;  end; end;
      procedure CallDoesGt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Call(Machine, Command); Pointer(WP^) := Pointer(Command.Param); Inc(WP, SizeOf(Pointer));  end; end;
      procedure Cells (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))*SizeOf(Integer);  end; end;
      procedure Cell_plus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) + SizeOf(TInt);  end; end;
      procedure _malloc (Machine: TForthMachine; Command: PForthCommand); var P: Pointer; begin with Machine^ do begin P := Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)); GetMem(P, Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^))); Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)) := P;  end; end;
      procedure _free (Machine: TForthMachine; Command: PForthCommand); var P: Pointer; begin with Machine^ do begin Dec(WP, SizeOf(Pointer)); P := Pointer(WP^); FreeMem(P);  end; end;
      procedure _last (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer(WP^) := C[FLastMnemonic]; {Writeln(Integer(WP^));} Inc(WP, SizeOf(Pointer));  end; end;
      procedure _xt_dot_n (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := @(PForthCommand((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)).Name[0]);  end; end;
      procedure _xt_dot_d (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PForthCommand((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)).Data  end; end;
      procedure _move (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(Pointer)*3); Move(Pointer((Pointer(TUInt(Machine.WP) + (0))^))^, Pointer((Pointer(TUInt(Machine.WP) + (SizeOf(Pointer)))^))^, TUint((Pointer(TUInt(Machine.WP) + (2*SizeOf(Pointer)))^))); {Writeln(TUInt((Pointer(TUInt(Machine.WP) + (0))^)), TUInt((Pointer(TUInt(Machine.WP) + (SizeOf(Pointer)))^)), TUint((Pointer(TUInt(Machine.WP) + (2*SizeOf(Pointer)))^)));}  end; end;


procedure _randomize (Machine: TForthMachine; Command: PForthCommand);
begin
  Randomize;
end;

procedure _random (Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(Random(Machine.WOI));
end;
      
procedure _align(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin with Machine^ do begin I := WOI;
  if I mod 4 = 0 then
    WUI(I)
  else
    WUI(I + 4 - (I mod 4))
 end; end;

procedure _palign(Machine: TForthMachine; Command: PForthCommand);
begin
  _align(Machine, Command);
end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('nop', _nop);
  Machine.AddCommand('timer', _timer);
  Machine.AddCommand('wp', _wp);
  Machine.AddCommand('@wp', _DogwpTemp);
  Machine.AddCommand('rp', _rp);
  Machine.AddCommand('lp', _lp);
  Machine.AddCommand('lb', _lb);
  Machine.AddCommand('r@', _r_dog);
  Machine.AddCommand('r>', _r_gt);
  Machine.AddCommand('>r', _lt_r);
  Machine.AddCommand('l@', _l_dog);
  Machine.AddCommand('l!', _l_exclamation);
  Machine.AddCommand('l+', _l_plus);
  Machine.AddCommand('sys-version', version);
  Machine.AddCommand('state', _state);
  Machine.AddCommand('time', _time);
  Machine.AddCommand('local', _local);
  Machine.AddCommand('source-cut', source_cut);
  Machine.AddCommand('source-next-char', source_next_char);
  Machine.AddCommand('source-next-name', source_next_name);
  Machine.AddCommand('source-next-name-passive', source_next_name_passive);
  Machine.AddCommand('source-next-line', source_next_line);
  Machine.AddCommand('source-next-line-passive', source_next_line_passive);
  Machine.AddCommand('interpret@source-next-name-passive', source_next_name_passive);
  Machine.AddCommand('compile@source-next-name-passive', source_next_name_passive);
  Machine.AddCommand('run@source-next-name-passive', source_next_name_passive);
  Machine.AddCommand('source-read-to-char', source_read_to_char);
  Machine.AddCommand('ptr-nil', ptr_nil);
  Machine.AddCommand('interpret@', interpret_start);
  Machine.AddCommand('compile@', compile_start);
  Machine.AddCommand('run@', run_start);
  //Machine.AddCommand('allot', allot);
  //Machine.AddCommand('literal', literal, True);
  Machine.AddCommand('['']', sq_ap_sq, True);
  Machine.AddCommand('opcode->command', opcode_to_command);
  Machine.AddCommand('run@['']', run_sq_ap_sq);
  //Machine.AddCommand('compile@['']', compile_sq_ap_sq);
  //Machine.AddCommand('interpret@['']', interpret_sq_ap_sq);
  Machine.AddCommand('''', _tick);
  Machine.AddCommand('execute', execute);
  Machine.AddCommand('does>', _does_gt, True);
  Machine.AddCommand('(does>)', _sq_does_gt_sq);
  Machine.AddCommand('cells', Cells);
  Machine.AddCommand('cell+', Cell_plus);
  Machine.AddCommand('malloc', _malloc);
  Machine.AddCommand('free', _free);
  Machine.AddCommand('last', _last);
  Machine.AddCommand('xt.n@', _xt_dot_n);
  Machine.AddCommand('xt.d@', _xt_dot_d);
  Machine.AddCommand('move', _move);

  Machine.AddCommand('randomize', _randomize);
  Machine.AddCommand('random', _random);

  Machine.AddCommand('align', _align);
  Machine.AddCommand('palign', _palign);
end;

end.

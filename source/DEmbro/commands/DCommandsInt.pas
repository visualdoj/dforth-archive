unit DCommandsInt;

interface

uses
  {$I units.inc},

  DEmbroCore,
  DForthMachine;
















    procedure drop_ (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_ (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_ (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_ (Machine: TForthMachine; Command: PForthCommand);
    procedure over_ (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_ (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_ (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_ (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_ (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_ (Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

     procedure drop_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, CELL_SIZE) end; end;
       procedure dup_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (0))^), CELL_SIZE); Inc(WP, CELL_SIZE) end; end;
       procedure nip_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), CELL_SIZE); Dec(WP, CELL_SIZE) end; end;
       procedure swap_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), WP^, CELL_SIZE); Move((Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), CELL_SIZE); Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), CELL_SIZE); end; end;
       procedure over_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (0))^), CELL_SIZE); Inc(WP, CELL_SIZE) end; end;
       procedure tuck_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), 2*CELL_SIZE); Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), CELL_SIZE); Inc(WP, CELL_SIZE);begin with Machine^ do begin  end; end; end; end;
     
     procedure lrot_ (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), WP^, CELL_SIZE);
       Move((Pointer(TUInt(Machine.WP) + (-3*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), CELL_SIZE);
       Move((Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-3*CELL_SIZE))^), CELL_SIZE);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), CELL_SIZE);
      end; end;
     procedure rrot_ (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), WP^, CELL_SIZE);
       Move((Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-1*CELL_SIZE))^), CELL_SIZE);
       Move((Pointer(TUInt(Machine.WP) + (-3*CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (-2*CELL_SIZE))^), CELL_SIZE);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*CELL_SIZE))^), CELL_SIZE);
      end; end;
     procedure lrotn_ (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE*N))^), (Pointer(TUInt(Machine.WP) + (0))^), CELL_SIZE);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-CELL_SIZE*N))^), CELL_SIZE);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), CELL_SIZE);
      end; end;
     procedure rrotn_ (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), (Pointer(TUInt(Machine.WP) + (0))^), CELL_SIZE);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-CELL_SIZE*I))^), CELL_SIZE);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*CELL_SIZE))^), CELL_SIZE);
      end; end;
     procedure pick_ (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -CELL_SIZE*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            CELL_SIZE);
       Inc(WP, CELL_SIZE - SizeOf(TInt));
      end; end;
     procedure _comma_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, CELL_SIZE); EWV(WP, CELL_SIZE);   end; end;
     procedure _dog_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), CELL_SIZE); Inc(WP, CELL_SIZE - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-CELL_SIZE))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, CELL_SIZE); Dec(WP, (SizeOf(Pointer)) + CELL_SIZE)  end; end;
     procedure ptr_plus_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + CELL_SIZE;  end; end;
     procedure _to_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_(Machine, Command) else _interpret_to_(Machine, Command);  end; end;
     procedure _compile_to_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@~to|'); EWO(NextName);  end; end;
     procedure _run_to_ (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), C[O].Data^, CELL_SIZE); Dec(WP, CELL_SIZE);  end; end;
     procedure _interpret_to_ (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after ~to|: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), Comm.Data^, CELL_SIZE); Dec(WP, CELL_SIZE);
              end; end;
     procedure _value_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_; Move((Pointer(TUInt(Machine.WP) + (-CELL_SIZE))^), Here^, CELL_SIZE); Dec(WP, CELL_SIZE); EA(CELL_SIZE); Flags := Flags and not 1; end;  end; end;
     procedure _variable_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, CELL_SIZE); Move(WP^, Here^, CELL_SIZE);} EA(CELL_SIZE); end;  end; end;
     procedure RunValue_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, CELL_SIZE); Inc(WP, CELL_SIZE);  end; end;
    procedure literal_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('(literal)'); Dec(WP, CELL_SIZE); 
                                       EWV(WP, CELL_SIZE);  end; end;
    procedure run_literal_ (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, CELL_SIZE); Inc(WP, CELL_SIZE);  end; end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('drop', drop_);
  Machine.AddCommand('dup', dup_);
  Machine.AddCommand('nip', nip_);
  Machine.AddCommand('swap', swap_);
  Machine.AddCommand('over', over_);
  Machine.AddCommand('tuck', tuck_);
  Machine.AddCommand('lrot', lrot_);
  Machine.AddCommand('rrot', rrot_);
  Machine.AddCommand('lrotn', lrotn_);
  Machine.AddCommand('rrotn', rrotn_);
  Machine.AddCommand('pick', pick_);
  Machine.AddCommand(',', _comma_);
  Machine.AddCommand('@', _dog_);
  Machine.AddCommand('!', _exclamation_);
  Machine.AddCommand('ptr+', ptr_plus_);
  Machine.AddCommand('to', _to_, True);
  Machine.AddCommand('compile@to', _compile_to_);
  Machine.AddCommand('run@to', _run_to_);
  Machine.AddCommand('interpret@to', _interpret_to_);
  Machine.AddCommand('value', _value_);
  Machine.AddCommand('constant', _value_);
  Machine.AddCommand('variable', _variable_);
  Machine.AddCommand('literal', literal_, True);
  Machine.AddCommand('(literal)', run_literal_);
end;

end.

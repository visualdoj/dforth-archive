uses
  {$IFDEF FLAG_FPC}
    DMath in 'FPC\DMath.pas',
  {$ELSE}
    DMath in '..\DEngine\DELPHI\DMath.pas',
  {$ENDIF}

  DEncoding,

  DEvents,
  DClasses,
  DWinApi in '..\DEngine\WINDOWS\DWinApi.pas',
  DLib in '..\DEngine\WINDOWS\DLib.pas',

  DUtils,
  DDebug,
  DParser,

  DMachineCode in '..\DMachineCode\DMachineCode.pas',
  Dx86 in '..\DMachineCode\Dx86.pas',

  DEmbroCore,
  DEmbroChunk,
  DEmbroManager,
  DMemMeta,
  DEmbroSource,
  console,
  stream,
  sh,

  DCommandsAlien in 'commands\DCommandsAlien',
  DCommandsConsole in 'commands\DCommandsConsole',
  DCommandsControl in 'commands\DCommandsControl.pas',
  DCommandsMisc in 'commands\DCommandsMisc.pas',
  DCommandsNumberArithmetic in 'commands\DCommandsNumberArithmetic.pas',
  DCommandsStrings in 'commands\DCommandsStrings',
  DCommandsVoc in 'commands\DCommandsVoc',

  DAlien,
  DForthMachine,
  DVocabulary,
  DExecutable,
  DCommandLine,
  DPlugin,
  DCompiler;

var
  Machine: TForthMachine;
  Compiler: TCompiler;
  Done: Boolean = False;
  S: String;
  I: Integer;

function GetCurrentDirectory: String;
begin
  Result := '.';
end;

procedure quit(Machine: TForthMachine; Command: PForthCommand);
begin
  Done := True;
end;

procedure embro_dump(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin
  for I := 0 to Machine.GetEmbroDumpLines - 1 do
    Writeln(IntToHex(I, 3), '   ', Machine.GetEmbroDumpLine(I));
end;

function GetExeName(S: String): String;
var
  I: Integer;
begin
  I := Length(S);
  while I > 0 do
    if S[I] = '.' then
      Break
    else
      Dec(I); 
  if I = 0 then
    Result := S + '.exe'
  else
    Result := Copy(S, 1, I - 1) + '.exe';
end;

procedure RunSystem;
begin
  if CommandLine.System = '' then
    Exit;
  // 1. command line
  // 2. current dir
  if FileExist(GetCurrentDirectory + '/' + CommandLine.System) then begin
    Machine.InterpretFile(GetCurrentDirectory + '/' + CommandLine.System);
    Exit;
  end;
  // 3. exe
  if FileExist(GetExeDirectory + '/' + CommandLine.System) then begin
    Machine.InterpretFile(GetExeDirectory + '/' + CommandLine.System);
    Exit;
  end;
  // 3. exe/units
  if FileExist(GetExeDirectory + '/units/' + CommandLine.System) then begin
    Machine.InterpretFile(GetExeDirectory + '/units/' + CommandLine.System);
    Exit;
  end;
end;

type
  TProc = procedure (A, B, C, D: Integer); stdcall;
  
var
  //Buffer: array[0..64*1024] of Byte;
  //F: File of Byte;
  Stack: array[0..64*1024] of Byte;
  WP: Pointer = nil;

procedure __Test(Machine: Pointer; Command: Pointer); stdcall;
begin
  Writeln('Machine = ', TUInt(Machine), ' Command = ', TUInt(Command));
  Writeln('Param1 = ', Integer(Pointer(@Stack[0])^));
  Writeln('Param2 = ', Integer(Pointer(@Stack[4])^));
  Writeln('Param3 = ', Integer(Pointer(@Stack[8])^));
  Writeln('Param4 = ', Integer(Pointer(@Stack[12])^));
  Writeln('Param5 = ', Integer(Pointer(@Stack[16])^));
  Writeln('Param6 = ', Integer(Pointer(@Stack[20])^));
  Writeln('Param7 = ', Integer(Pointer(@Stack[24])^));
  Writeln('Param8 = ', Integer(Pointer(@Stack[28])^));
  Writeln('@Stack = ', Integer(Pointer(@Stack[0])));
  Writeln('WP     = ', Integer(WP));
end;

begin
  //with TAlien.Create do begin
  //  WP := @Stack[0];
  //  GenerateCallback(@Buffer[0], 64*1024, [4, 4, 4, 4], 4,
  //                   @WP, 998877, 112233, @__Test);
  //  (* __Test(998877, 112233); *)
  //  (* TProc(@Buffer[0])(12,13,14,15); *)
  //  (* TProc(@Buffer[0])(16,17,18,19); *)
  //  Assign(F, 'call.bin');
  //  Rewrite(F);
  //  BlockWrite(F, (@Buffer[0])^, MachineCode.Size);
  //  Close(F);
  //  Free;
  //  //Exit;
  //end;
  ParseCommandLine;
  if CommandLine.Debug then
    Writeln('Start: ', GetTimer);
  if CommandLine.Error then
    Halt(-1);
  if CommandLine.Help then
    Halt;

  New(Machine, Create);
  RunSystem;
  Compiler := TCompiler.Create(Machine);
  Machine.AddCommand('quit', quit);
  Machine.AddCommand('embro-dump', embro_dump);

  with CommandLine do begin
    {if Mode = CMD_EXE then begin
      Compile;
    end else} 
    for I := 0 to High(FileNames) do
      Machine.Interpret(PChar('str" ' + FileNames[I] + '" evaluate-file'));
    if CommandLine.Debug then
      Writeln('Initialized: ', GetTimer);
    if Repl then begin
      Writeln('DEmbro v' + IntToStr(DFORTHMACHINE_VERSION div 100) + '.' + 
                           IntToStr(DFORTHMACHINE_VERSION mod 100) + ' built ' +
              DFORTHMACHINE_DATE +
              ' (commands available: ', Length(Machine.C), ')');
      Writeln('Type "quit" to exit');
      while not Done do begin
        Write('dembro> ');
        Readln(S);
        SetLength(S, Length(S) + 1);
        S[Length(S)] := #0;
        //try
          Machine.Interpret(@S[1]);
        //except
        //  Writeln('Error');
        //  continue;
        //end;
        Writeln(' ok');
      end;
    end else begin
    end;
  end;
  // Writeln('Destroying machine');
  Machine^.Destroy;
  // Writeln('Compiler.Free');
  Compiler.Free;
  // Writeln('Dispose Machine');
  Dispose(Machine, Destroy);
  // Writeln('dembro32 out');
end.

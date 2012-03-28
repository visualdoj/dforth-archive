uses
  {$IFDEF FLAG_FPC}
    DMath in '..\DEngine\FPC\DMath.pas',
  {$ELSE}
    DMath in '..\DEngine\DELPHI\DMath.pas',
  {$ENDIF}
  DLib in '..\DEngine\WINDOWS\DLib.pas',

  DWinApi in '..\DEngine\WINDOWS\DWinApi.pas',
  DUtils,
  DDebug,
  DParser,

  DCommandLine,
  de32header;

var
  Machine: Pointer;
  Done: Boolean = False;
  S: String;
  I: Integer;

function GetCurrentDirectory: String;
begin
  Result := '.';
end;

procedure quit(Machine: Pointer; Command: Pointer);
begin
  Done := True;
end;

procedure RunSystem;
begin
  if CommandLine.System = '' then
    Exit;
  // 1. command line
  // 2. current dir
  if FileExist(GetCurrentDirectory + '/' + CommandLine.System) then begin
    deInterpret(Machine, DE_SOURCE_FILE, PAnsiChar(GetCurrentDirectory + '/' + CommandLine.System));
    Exit;
  end;
  // 3. exe
  if FileExist(GetExeDirectory + '/' + CommandLine.System) then begin
    deInterpret(Machine, DE_SOURCE_FILE, PAnsiChar(GetExeDirectory + '/' + CommandLine.System));
    Exit;
  end;
  // 3. exe/units
  if FileExist(GetExeDirectory + '/units/' + CommandLine.System) then begin
    deInterpret(Machine, DE_SOURCE_FILE, PAnsiChar(GetExeDirectory + '/units/' + CommandLine.System));
    Exit;
  end;
end;

procedure PrintVersion;
var
  Version: Cardinal;
  Date: PAnsiChar;
begin
  deVersion(Version, Date);
  Writeln('DEmbro v' + IntToStr(Version div 100) + '.' + 
                       IntToStr(Version mod 100) + ' built ',
                       Date);
  //        ' (commands available: ', Length(Machine.C), ')');
end;

begin
  ParseCommandLine;
  if CommandLine.Debug then
    Writeln('Start: ', GetTimer);
  if CommandLine.Error then
    Halt(Cardinal(-1));
  if CommandLine.Help then
    Halt;
  if not deLibLoad(CommandLine.LibNameReal) then begin
    Write('Cannot load library: ', CommandLine.LibNameReal);
    if not CommandLine.LibNameDefined then
        Write(', try to specify it directly throw --lib parameter');
    Writeln;
    Exit;
  end;

  Machine := deCreateMachine();
  RunSystem;
  deAddCommand(Machine, 'quit', @quit, nil, True);

  with CommandLine do begin
    {if Mode = CMD_EXE then begin
      Compile;
    end else} 
    for I := 0 to High(FileNames) do
      deInterpret(Machine, DE_SOURCE_PCHAR, PChar('str" ' + FileNames[I] + '" evaluate-file'));
    if CommandLine.Debug then
      Writeln('Initialized: ', GetTimer);
    if (Repl and ReplDefined) or (ReplDefault and not ReplDefined) then begin
      PrintVersion;
      Writeln('Type "quit" to exit');
      while not Done do begin
        Write('dembro> ');
        Readln(S);
        SetLength(S, Length(S) + 1);
        S[Length(S)] := #0;
        //try
          deInterpret(Machine, DE_SOURCE_PCHAR, @S[1]);
        //except
        //  Writeln('Error');
        //  continue;
        //end;
        Writeln(' ok');
      end;
    end else begin
    end;
  end;
  deFreeMachine(Machine);
  deLibFree;
end.

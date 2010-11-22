uses
  {$IFDEF FLAG_FPC}
    DMath in '..\DEngine\FPC\DMath.pas',
  {$ELSE}
    DMath in '..\DEngine\DELPHI\DMath.pas',
  {$ENDIF}

  DEncoding in '..\DLocal\DEncoding.pas',
  DTranslater in '..\DLocal\DTranslater.pas',

  DXML in '..\DParser\DXML.pas',
  DXMLExecutor in '..\DParser\DXMLExecutor.pas',
  DIni in '..\DParser\DIni.pas',
  DTreeExpr in '..\DParser\DTreeExpr.pas',

  {$IFNDEF FLAG_DEBUG}
    winsock in '..\DEngine\WINSOCK\winsock.pas',
  {$ENDIF}

  DEvents in '..\DEngine\DEvents.pas',
  DClasses in '..\DEngine\DClasses.pas',
  DWinApi in '..\DEngine\WINDOWS\DWinApi.pas',
  DNet in '..\DEngine\WINSOCK\DNet.pas',
  DLib in '..\DEngine\WINDOWS\DLib.pas',

  DUtils in '..\DEngine\DUtils.pas',
  DDebug in '..\DEngine\DDebug.pas',
  DParser in '..\DEngine\DParser.pas',

  DForthStack,
  DForthMachine,
  DExecutable,
  DCommandLine,
  DPlugin,
  DCompiler;

type
TRepl = class
 public
  procedure quit(Machine: TForthMachine; Command: PForthCommand);
  procedure embro_dump(Machine: TForthMachine; Command: PForthCommand);
end;

var
  Machine: TForthMachine;
  Compiler: TCompiler;
  Repl: TRepl;
  Done: Boolean = False;
  S: String;

procedure TRepl.quit;
begin
  Done := True;
end;

procedure TRepl.embro_dump(Machine: TForthMachine; Command: PForthCommand);
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
  // 1. command line
  // 2. current dir
  if FileExist(GetCurrentDirectory + '\system.de') then begin
    Machine.InterpretFile(GetCurrentDirectory + '\system.de');
    Exit;
  end;
  // 3. exe
  if FileExist(GetExeDirectory + '\system.de') then begin
    Machine.InterpretFile(GetExeDirectory + '\system.de');
    Exit;
  end;
  // 3. exe\units
  if FileExist(GetExeDirectory + '\units\system.de') then begin
    Machine.InterpretFile(GetExeDirectory + '\units\system.de');
    Exit;
  end;
end;

procedure Compile;
var
  Builder: TExeBuilder;
begin
  with CommandLine do begin
    if Dest = '' then
      Dest := GetExeName(Source);
    Builder := TExeBuilder.Create;
    Builder.AppType := AT_CONSOLE;
    Builder.BuildHeader;
    Builder.Save(Dest);
    Builder.Free;
  end;
end;

begin
  ParseCommandLine;
  with CommandLine do
    if Mode = CMD_EXE then begin
      Compile;
    end else if (Mode = CMD_REPL) and (Source = '-') then begin
      Machine := TForthMachine.Create;
      RunSystem;
      Compiler := TCompiler.Create(Machine);
      Repl := TRepl.Create;
      Machine.AddCommand('quit', Repl.quit);
      Machine.AddCommand('embro-dump', Repl.embro_dump);
      Writeln('DEmbro v' + IntToStr(DFORTHMACHINE_VERSION div 100) + '.' + 
                           IntToStr(DFORTHMACHINE_VERSION mod 100) + 
              ' (commands available: ', Length(Machine.C), ')');
      Writeln('Type "quit" to exit');
      while not Done do begin
        Write('dforth> ');
        Readln(S);
        SetLength(S, Length(S) + 1);
        S[Length(S)] := #0;
        Machine.Interpret(@S[1]);
        Writeln('ok');
      end;
      Compiler.Free;
      Machine.Free;
    end else begin
      Machine := TForthMachine.Create;
      RunSystem;
      Compiler := TCompiler.Create(Machine);
      Repl := TRepl.Create;
      Machine.AddCommand('quit', Repl.quit);
      Machine.AddCommand('embro-dump', Repl.embro_dump);
      Machine.Interpret(PChar('str" ' + Source + '" evaluate-file'));
      Repl.Free;
      Compiler.Free;
      Machine.Free;
    end;
end.

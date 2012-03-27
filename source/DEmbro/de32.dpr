library de32;

uses
  {$IFDEF FLAG_FPC}
    DMath in '..\DEngine\FPC\DMath.pas',
  {$ELSE}
    DMath in '..\DEngine\DELPHI\DMath.pas',
  {$ENDIF}

  {$IFNDEF FLAG_DEBUG}
    {$IFDEF WIN32}winsock in '..\DEngine\WINSOCK\winsock.pas',{$ENDIF}
  {$ENDIF}

  DEvents in '..\DEngine\DEvents.pas',
  DClasses in '..\DEngine\DClasses.pas',
  DWinApi in '..\DEngine\WINDOWS\DWinApi.pas',
  // DNet in '..\DEngine\WINSOCK\DNet.pas',
  DLib in '..\DEngine\WINDOWS\DLib.pas',

  DUtils in '..\DEngine\DUtils.pas',
  DDebug in '..\DEngine\DDebug.pas',
  DParser in '..\DEngine\DParser.pas',

  DMachineCode in '..\DMachineCode\DMachineCode.pas',
  
  DForthMachine;

function deCreateMachine: Pointer; stdcall;
var
  M: TForthMachine;
begin
  New(M, Create);
  deCreateMachine := M;
  Writeln('Created DEmbro machine');
end;

procedure deFreeMachine(machine: Pointer); stdcall;
begin
  Dispose(TForthMachine(machine), Destroy);
end;

const
  DE_OK                         = 0;
  DE_ERR_UNKNOWN_SOURCE_TYPE    = -1;

  DE_SOURCE_PCHAR               = 1; // исполняемый код находится в строке с завершающим нулём
  DE_SOURCE_FUNC                = 2; // исходный код нужно получать из функции до тех пор, пока она не вернёт nil
  DE_SOURCE_FILE                = 3; // исходный код находится в файле

function deInterpret(machine: Pointer; typ: Integer; source: Pointer): Integer; stdcall;
var
  S: PChar;
begin
  deInterpret := DE_OK;
  if typ = DE_SOURCE_PCHAR then begin
    // GetMem(S, SizeOf(Char) * (Length(PChar(source)) + 1));
    // Move(source^, S^, SizeOf(Char) * (Length(PChar(source)) + 1));
    TForthMachine(machine).Interpret(source);
    // FreeMem(S);
  end else if typ = DE_SOURCE_FILE then begin
    TForthMachine(machine).InterpretFile(TString(PAnsiChar(source)));
  end else if typ = DE_SOURCE_FUNC then begin
    // underconstruction
  end else
    deInterpret := DE_ERR_UNKNOWN_SOURCE_TYPE;
end;

procedure deAddCommand(machine: Pointer; 
                      name: PChar; 
                      CallBack: Pointer;
                      Data: Pointer;
                      Immediate: Boolean
                     ); stdcall;
begin
  TForthMachine(machine).AddCommand(name, Callback, Immediate, False);
end;

exports
  deCreateMachine,
  deFreeMachine,
  deInterpret,
  deAddCommand;

end.

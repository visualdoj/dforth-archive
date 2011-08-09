library dembro32lib;

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
  DForthMachine;

const
  DE_OK                         = 0; // всё прошло без ошибок
  DE_ERR_UNKNOWN_VALTYPE        = 1; // некорректное значение параметра valtype
  DE_ERR_UNKNOWN_ACTION         = 2; // некорректное значение параметра action
  DE_ERR_UNKNOWN_SOURCE_TYPE    = 3; // некорректное значение параметра typ

  DE_IGNORE                     = 0; // игнорировать

  DE_USERDATA                   = 1; // пользовательская переменная
  DE_W                          = 2; // стек W (основной)
  DE_R                          = 3; // стек R (возвратов)
  DE_L                          = 4; // стек L (локальных переменных)
  
  DE_READ                       = 1;
  DE_WRITE                      = 2;
  DE_PUSH                       = 3;
  DE_POP                        = 4;

  DE_SOURCE_PCHAR               = 1; // исполняемый код находится в строке с завершающим нулём
  DE_SOURCE_FUNC                = 2; // исходный код нужно получать из функции до тех пор, пока она не вернёт nil

function deCreateMachine: Pointer; stdcall;
begin
  Result := TForthMachine.Create;
end;

procedure deFreeMachine(machine: Pointer); stdcall;
begin
  TForthMachine(machine).Free;
end;

function deInterpret(machine: Pointer; typ: Integer; source: Pointer): Integer; stdcall;
var
  S: PChar;
begin
  Result := DE_OK;
  if typ = DE_SOURCE_PCHAR then begin
    GetMem(S, SizeOf(Char) * (Length(PChar(source)) + 1));
    Move(source^, S^, SizeOf(Char) * (Length(PChar(source)) + 1));
    TForthMachine(machine).Interpret(S);
    FreeMem(S);
  end else if typ = DE_SOURCE_FUNC then begin
    // underconstruction
  end else
    Result := DE_ERR_UNKNOWN_SOURCE_TYPE;
end;

procedure deAddCommand(machine: Pointer; 
                      name: PChar; 
                      CallBack: Pointer;
                      Data: Pointer;
                      Immediate: Boolean
                     ); stdcall;
begin
  //TForthMachine(machine).AddCommand(name, TCallback(Callback));
end;

function deVar(machine: Pointer; 
               valtype: Integer; 
               action: Integer; 
               ptr: Pointer;
               size: Integer; 
               pos: Integer): Integer; stdcall;
begin
  Result := DE_OK;
  if machine = nil then
    Exit;
  with TForthMachine(machine) do
    if action = DE_WRITE then
      case valtype of
        DE_IGNORE: ;
        DE_USERDATA: Userdata := Pointer(ptr^);
        DE_W: Move(ptr^, Pointer(Cardinal(WP) + Pos)^, Size);
        DE_R: Move(ptr^, Pointer(Cardinal(RP) + Pos)^, Size);
        DE_L: Move(ptr^, Pointer(Cardinal(LP) + Pos)^, Size);
      else
        Result := DE_ERR_UNKNOWN_VALTYPE;
      end
    else if action = DE_READ then
      case valtype of
        DE_IGNORE: ;
        DE_USERDATA: Pointer(ptr^) := Userdata;
        DE_W: Move(Pointer(Cardinal(WP) + Pos)^, ptr^, Size);
        DE_R: Move(Pointer(Cardinal(RP) + Pos)^, ptr^, Size);
        DE_L: Move(Pointer(Cardinal(LP) + Pos)^, ptr^, Size);
      else
        Result := DE_ERR_UNKNOWN_VALTYPE;
      end
    else if action = DE_PUSH then
      case valtype of
        DE_IGNORE: ;
        DE_W: WUV(ptr, size);
        DE_R: RUV(ptr, size);
        DE_L: LUV(ptr, size);
      else
        Result := DE_ERR_UNKNOWN_VALTYPE;
      end
    else if action = DE_POP then
      case valtype of
        DE_IGNORE: ;
        DE_W: WOV(ptr, size);
        DE_R: ROV(ptr, size);
        DE_L: LOV(ptr, size);
      else
        Result := DE_ERR_UNKNOWN_VALTYPE;
      end
    else if action = DE_IGNORE then
    else
      Result := DE_ERR_UNKNOWN_ACTION;
end;

exports
  deCreateMachine,
  deFreeMachine,
  deInterpret,
  deAddCommand,
  deVar;

end.

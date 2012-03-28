

unit de32header;

interface

uses
  DDebug,
  DLib;

const
  DE_OK                         = 0;
  DE_ERR_UNKNOWN_SOURCE_TYPE    = -1;

  DE_SOURCE_PCHAR               = 1; // исполняемый код находится в строке с завершающим нулём
  DE_SOURCE_FUNC                = 2; // исходный код нужно получать из функции до тех пор, пока она не вернёт nil
  DE_SOURCE_FILE                = 3; // исходный код находится в файле

var
deCreateMachine: function: Pointer; stdcall;
deFreeMachine: procedure (machine: Pointer); stdcall;
deInterpret: function (machine: Pointer; typ: Integer; source: Pointer): Integer; stdcall;
deAddCommand: procedure(machine: Pointer; 
                      name: PChar; 
                      CallBack: Pointer;
                      Data: Pointer;
                      Immediate: Boolean
                     ); stdcall;

function LoadLib(FileName: String): Boolean;

implementation

var
  Lib: TLib;

function LoadLib(FileName: String): Boolean;
begin
  Lib := TLib.Create(PChar(FileName));
  if not Lib.Ready then begin
    Result := False;
    Exit;
  end;
  
  deCreateMachine := Lib.GetProcAddress('deCreateMachine'); if (@deCreateMachine = nil) then begin Result := False; Exit; end;
  deFreeMachine := Lib.GetProcAddress('deFreeMachine'); if (@deFreeMachine = nil) then begin Result := False; Exit; end;
  deAddCommand := Lib.GetProcAddress('deAddCommand'); if (@deAddCommand = nil) then begin Result := False; Exit; end;
  deInterpret := Lib.GetProcAddress('deInterpret'); if (@deInterpret = nil) then begin Result := False; Exit; end;
  
  Result := True;
end;

end.

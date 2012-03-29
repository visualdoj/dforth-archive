

unit de32header;

interface

uses
  DynLibs;

const
  DE_OK                         = 0;
  DE_ERR_UNKNOWN_SOURCE_TYPE    = -1;

  DE_SOURCE_PCHAR               = 1; // исполняемый код находится в строке с завершающим нулём
  DE_SOURCE_FUNC                = 2; // исходный код нужно получать из функции до тех пор, пока она не вернёт nil
  DE_SOURCE_FILE                = 3; // исходный код находится в файле

var
deVersion: procedure (var Version: Cardinal; var Date: PAnsiChar); stdcall;
deCreateMachine: function: Pointer; stdcall;
deFreeMachine: procedure (machine: Pointer); stdcall;
deInterpret: function (machine: Pointer; typ: Integer; source: Pointer): Integer; stdcall;
deAddCommand: procedure(machine: Pointer; 
                      name: PChar; 
                      CallBack: Pointer;
                      Data: Pointer;
                      Immediate: Boolean
                     ); stdcall;

function deLibReady: Boolean;
function deLibLoad(const FileName: String): Boolean;
procedure deLibFree;

implementation

var
  Lib: TLibHandle = NilHandle;

function deLibReady: Boolean;
begin
  Result := Lib <> NilHandle;
end;

function deLibLoad(const FileName: String): Boolean;
begin
  Lib := LoadLibrary(FileName);
  if Lib = NilHandle then begin
    Result := False;
    Exit;
  end;
  
  deVersion := GetProcAddress(Lib, 'deVersion'); if (@deVersion = nil) then begin deLibFree; Result := False; Exit; end;
  deCreateMachine := GetProcAddress(Lib, 'deCreateMachine'); if (@deCreateMachine = nil) then begin deLibFree; Result := False; Exit; end;
  deFreeMachine := GetProcAddress(Lib, 'deFreeMachine'); if (@deFreeMachine = nil) then begin deLibFree; Result := False; Exit; end;
  deAddCommand := GetProcAddress(Lib, 'deAddCommand'); if (@deAddCommand = nil) then begin deLibFree; Result := False; Exit; end;
  deInterpret := GetProcAddress(Lib, 'deInterpret'); if (@deInterpret = nil) then begin deLibFree; Result := False; Exit; end;
   //'
  Result := True;
end;

procedure deLibFree;
begin
  if Lib <> NilHandle then begin
    FreeLibrary(Lib);
    Lib := NilHandle;
  end;
end;

end.

unit DPlugin;

interface

uses
  DWinApi,
  DParser,
  DUtils,
  DLib;

const
  ERROR_ICORRECT_LIB = 1;
  ERROR_ICORRECT_TYPE = 2;
  ERROR_EXCEPTION_WHILE_INFO = 3;
  ERROR_EXCEPTION_WHILE_SETPATAM = 4;
  ERROR_EXCEPTION_WHILE_COMPILE = 5;
  ERROR_EXCEPTION_WHILE_ERROR = 6;
  ERROR_EXCEPTION_WHILE_ERROR_STRING = 7;
  ERROR_EXCEPTION_WHILE_PARSE = 8;

type
  TdecInfo = procedure (Name: Pointer; _Type: PInteger; Version: PInteger); stdcall;
  TdecSetParam = procedure (Id: Integer; _Type: Integer; Val: Pointer; Size: Integer); stdcall;
  TdecCompile = procedure; cdecl;
  TdecError = function (Id: PInteger; Pos: PInteger): Integer; stdcall;
  TdecErrorString = function (Id: Integer): PChar; stdcall;
  TdecParse = procedure (Format: PChar; Args: array of Const); cdecl;

type
TPlugin = class
private
  FLib: TLib;
  FSetParam: TdecSetParam;
  FCompile: TdecCompile;
  FError: TdecError;
  FErrorString: TdecErrorString;
  FParse: TdecParse;
  FName: PChar;
  FType: Integer;
  FVersion: Integer;
  FReady: Integer;
public
  constructor Create(FileName: TString);
  destructor Destroy; override;
  procedure SetParam(Id, _Type: Integer; Val: Pointer; Size: Integer = 0);
  procedure Compile;
  function Error(var Id: Integer; var Pos: Integer): Integer;
  function ErrorString(Id: Integer): PChar;
  //procedure Parse(Format: PChar; Args: array of Const);
  property Name: PChar read FName;
  property _Type: Integer read FType;
  property Version: Integer read FVersion;
  property Ready: Integer read FReady;
  property Parse: TdecParse read FParse;
end;

var
  Plugins: array of TPlugin;

procedure LoadPlugins;

implementation

constructor TPlugin.Create;
var
  N: PChar;
  T: Integer;
  V: Integer;
begin
  FLib := TLib.Create(PChar(FileName));
  FReady := Ord(not FLib.Ready);
  if FReady = 0 then
    try
      Writeln('Called decInfo');
      //TdecInfo(FLib.GetProcAddress('decInfo'))(@N, @T, @V);
      TdecCompile(FLib.GetProcAddress('decCompile'))();
      Writeln('Done decInfo');
      FName := N;
      FType := T;
      FVersion := V;
      FType := 1;
      if FType <> 1 then
        FReady := ERROR_ICORRECT_TYPE
      else begin
        FSetParam := FLib.GetProcAddress('decSetParam');
        FCompile := FLib.GetProcAddress('decCompile');
        FError := FLib.GetProcAddress('decError');
        FErrorString := FLib.GetProcAddress('decErrorString');
        FParse := FLib.GetProcAddress('decParse');
      end;
    except
      FReady := ERROR_EXCEPTION_WHILE_INFO;
    end;
end;

destructor TPlugin.Destroy;
begin
  FLib.Free;
end;

procedure TPlugin.SetParam(Id, _Type: Integer; Val: Pointer; Size: Integer = 0);
begin
  try
    FSetParam(Id, _Type, Val, Size);
  except
    FReady := ERROR_EXCEPTION_WHILE_SETPATAM;
  end;
end;

procedure TPlugin.Compile;
begin
  try
    FCompile;
  except
    FReady := ERROR_EXCEPTION_WHILE_COMPILE;
  end;
end;

function TPlugin.Error(var Id: Integer; var Pos: Integer): Integer;
begin
  try
    FError(@Id, @Pos);
  except
    FReady := ERROR_EXCEPTION_WHILE_ERROR;
  end;
end;

function TPlugin.ErrorString(Id: Integer): PChar;
begin
  try
    Result := FErrorString(Id);
  except
    FReady := ERROR_EXCEPTION_WHILE_ERROR_STRING;
    Result := '';
  end;
end;

{procedure TPlugin.Parse(Format: PChar; Args: array of Const);
var
  V: array of TVarRec;
  I: Integer;
begin
  SetLength(V, Length(Args));
  for I := 0 to High(Args) do
    V[I] := Args[I];
  try
    FParse(Format, V);
  except
    FReady := False;
  end;
end;}

procedure LoadPlugins;
var
  I: Integer;
  P: TPlugin;
  Files: TArrayOfString;
begin
  GetFileList('plugins\', Files);
  SetLength(Plugins, 0);
  for I := 0 to High(Files) do begin
    P := TPlugin.Create('plugins\' + Files[I]);
    Writeln(Files[I], ' ', P.Ready);
    if P.Ready = 0 then begin
      SetLength(Plugins, Length(Plugins) + 1);
      Plugins[High(Plugins)] := P;
    end else
      P.Free;
  end;
end;

end.

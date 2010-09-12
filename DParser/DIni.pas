unit DIni;

interface

uses
  DUtils,
  DParser;

type
TIniValue = record
  Name: TString;
  Value: TString; 
end;

TIniGroup = record
  Name: TString;
  Values: array Of TIniValue;
end;

TIni = class
private
  FGroups: array of TIniGroup;
  function FindGroup(Name: TString): Integer;
  function FindValue(Group: Integer; Name: TString): Integer;
  function AddGroup(Name: TString): Integer;
  function AddValue(Group: Integer; Name: TString): Integer;
  function GetValue(Group, Name: TString): TString;
  procedure SetValue(Group, Name, Value: TString);
public
  constructor Create; overload;
  constructor Create(const FileName: TString); overload;
  destructor Destroy; override;
  procedure Load(const FileName: TString);
  procedure Save(const FileName: TString);
  function Exists(Group, Name: TString): Boolean;
  property Values[Group, Name: TString]: TString read GetValue write SetValue; default;
end;

implementation

function TIni.FindGroup(Name: TString): Integer;
begin
  Result := High(FGroups);
  while Result >= 0 do
    if FGroups[Result].Name = Name then
      Exit
    else
      Dec(Result);
end;

function TIni.FindValue(Group: Integer; Name: TString): Integer;
begin
  Result := High(FGroups[Group].Values);
  while Result >= 0 do
    if FGroups[Group].Values[Result].Name = Name then
      Exit
    else
      Dec(Result);
end;

function TIni.AddGroup(Name: TString): Integer;
begin
  SetLength(FGroups, Length(FGroups) + 1);
  Result := High(FGroups);
  FGroups[Result].Name := Name;
  SetLength(FGroups[Result].Values, 0);
end;

function TIni.AddValue(Group: Integer; Name: TString): Integer;
begin
  SetLength(FGroups[Group].Values, Length(FGroups[Group].Values) + 1);
  Result := High(FGroups[Group].Values);
  FGroups[Group].Values[Result].Name := Name;
  FGroups[Group].Values[Result].Value := '';
end;

function TIni.GetValue(Group, Name: TString): TString;
  var
    G, V: Integer;
begin
  G := FindGroup(Group);
  if G = -1 then
    Result := ''
  else begin
    V := FindValue(G, Name);
    if V = -1 then
      Result := ''
    else
      Result := FGroups[G].Values[V].Value;
  end;
end;

procedure TIni.SetValue(Group, Name, Value: TString);
  var
    G, V: Integer;
begin
  G := FindGroup(Group);
  if G = -1 then
    G := AddGroup(Group);
  V := FindValue(G, Name);
  if V = -1 then
    V := AddValue(G, Name);
  FGroups[G].Values[V].Value := Value;
end;

constructor TIni.Create;
begin
  SetLength(FGroups, 0);
end;

constructor TIni.Create(const FileName: TString);
begin
  Create;
  Load(FileName);
end;

destructor TIni.Destroy; 
begin
end;

procedure TIni.Load(const FileName: TString);
  var
    F: TextFile;
    S: TString;
    Group, Name, Value: TString;
begin
  SetLength(FGroups, 0);
  Assign(F, FileName);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  Group := '';
  while not Eof(F) do begin
    Readln(F, S);
    S := DeleteLeftSpaces(DeleteRightSpaces(S));
    if Pos('[', S) <> 0 then begin
      S := TStringDeletePre(S, Pos('[', S));
      S := TStringDeletePost(S, Pos(']', S));
      S := DeleteLeftSpaces(DeleteRightSpaces(S));
      Group := S;
    end else if Pos('=', S) <> 0 then begin
      ParseBinary(S, '=', Name, Value);
      Name := DeleteLeftSpaces(DeleteRightSpaces(Name));
      Value := DeleteLeftSpaces(DeleteRightSpaces(Value));
      SetValue(Group, Name, Value)
    end;
  end;
  Close(F);
end;

procedure TIni.Save(const FileName: TString);
  var
    F: TextFile;
    G, V: Integer;
begin
  Assign(F, FileName);
  {$I-}
  Rewrite(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  for G := 0 to High(FGroups) do
    with FGroups[G] do begin
      Writeln(F, '[', Name, ']');
      for V := 0 to High(Values) do
        with Values[V] do 
          Writeln(F, Name, ' = ', Value);
    end;
  Close(F);
end;

function TIni.Exists(Group, Name: TString): Boolean;
  var
    G: Integer;
begin
  G := FindGroup(Group);
  if G = -1 then
    Result := False
  else
    Result := FindValue(G, Name) <> -1;
end;

end.

unit DMachineCode;

interface

type
PMachineCodeError = ^TMachineCodeError;
TMachineCodeError = record
  Id: Integer; // ид-ошибки
  Pos: Integer; // номер байта, в месте записи которого возникла ошибка
  Description: String; // описание ошибки
end;

TMachineCodeMarker = record
  Pos: Integer;
  Name: String;
end;

TMachineCode = class
protected
  FData: array of Byte;
  FSize: Integer;
  FPtr: Pointer;
  FMaxSize: Integer;
  FErrors: array of TMachineCodeError;
  FMarkers: array of TMachineCodeMarker;
  procedure Resize(NewSize: Integer);
  procedure IncSize(Val: Integer);
  procedure Write(V: Pointer; S: Integer);
  procedure WriteB(B: Byte);
  procedure WriteW(W: Word);
  procedure WriteI(I: LongInt);
  procedure WriteD(D: LongInt);
  procedure WriteU(U: Cardinal);
  procedure AddError(Id, Pos: Integer; const Description: String);
  procedure AddMarker(const Name: String; Pos: Integer);
  function FindMarker(const Name: String; var Index: Integer): Boolean;
public
  constructor Create(BaseSize: Integer = 64*1024);
  procedure SetData(Ptr: Pointer; MaxSize: Integer);
  function IsError: Boolean;
  function GetError(Error: PMachineCodeError): Boolean;
  function SetLabel(const Name: String): Integer;
  property _SetLabel[Name: String]: Integer read SetLabel;
  property Size: Integer read FSize;
end;

implementation

procedure TMachineCode.Resize(NewSize: Integer);
begin
  if NewSize > Length(FData) then
    SetLength(FData, Length(FData)*2);
end;

procedure TMachineCode.IncSize(Val: Integer);
begin
  FSize := FSize + Val;
end;

procedure TMachineCode.Write(V: Pointer; S: Integer);
begin
  if FPtr = nil then begin
    Resize(FSize + S);
    Move(V^, FData[FSize], S);
  end else begin
    if S + FSize > FMaxSize then begin
      AddError($F0000001, FSize, 'not enougth buffer space')
    end else begin
      Move(V^, FPtr^, S);
      Inc(FSize, S);
      Inc(FPtr, S);
    end;
  end;
end;

procedure TMachineCode.WriteB(B: Byte);
begin
  Write(@B, SizeOf(Byte));
end;

procedure TMachineCode.WriteW(W: Word);
begin
  Write(@W, SizeOf(Word));
end;

procedure TMachineCode.WriteI(I: LongInt);
begin
  Write(@I, SizeOf(LongInt));
end;

procedure TMachineCode.WriteD(D: LongInt);
begin
  Write(@D, SizeOf(LongInt));
end;

procedure TMachineCode.WriteU(U: Cardinal);
begin
  Write(@U, SizeOF(U));
end;

procedure TMachineCode.AddError(Id, Pos: Integer; const Description: String);
begin
  SetLength(FErrors, Length(FErrors) + 1);
  FErrors[High(FErrors)].Id := Id;
  FErrors[High(FErrors)].Pos := Pos;
  FErrors[High(FErrors)].Description := Description;
end;

procedure TMachineCode.AddMarker(const Name: String; Pos: Integer);
begin
  SetLength(FMarkers, Length(FMarkers) + 1);
  FMarkers[High(FMarkers)].Name := Name;
  FMarkers[High(FMarkers)].Pos := Pos;
end;

function TMachineCode.FindMarker(const Name: String; var Index: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(FMarkers) do
    if FMarkers[I].Name = Name then begin
      Result := True;
      Index := I;
      Exit;
    end;
  Result := False;
end;

constructor TMachineCode.Create(BaseSize: Integer = 64*1024);
begin
  SetLength(FData, BaseSize);
  FSize := 0;
  FPtr := nil;
end;

procedure TMachineCode.SetData(Ptr: Pointer; MaxSize: Integer);
begin
  FPtr := Ptr;
  FMaxSize := MaxSize;
  FSize := 0;
end;

function TMachineCode.IsError: Boolean;
begin
  Result := Length(FErrors) > 0;
end;

function TMachineCode.GetError(Error: PMachineCodeError): Boolean;
begin
  Result := Length(FErrors) > 0;
  if Result and (Error <> nil) then begin
    Error^ := FErrors[High(FErrors)];
    SetLength(FErrors, High(FErrors));
  end;
end;

function TMachineCode.SetLabel(const Name: String): Integer;
begin
  AddMarker(Name, FSize);
  Result := FSize;
end;

end.

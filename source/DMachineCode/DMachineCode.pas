unit DMachineCode;

interface

type
TMachineCode = class
protected
  FData: array of Byte;
  FSize: Integer;
  procedure Resize(NewSize: Integer);
  procedure IncSize(Val: Integer);
  procedure Write(V: Pointer; S: Integer);
  procedure WriteB(B: Byte);
  procedure WriteW(W: Word);
  procedure WriteI(I: LongInt);
  procedure WriteD(D: LongInt);
public
  constructor Create(BaseSize: Integer = 64*1024);
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
  Resize(FSize + S);
  Move(V^, FData[FSize], S);
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

constructor TMachineCode.Create(BaseSize: Integer = 64*1024);
begin
  SetLength(FData, BaseSize);
  FSize := 0;
end;

end.

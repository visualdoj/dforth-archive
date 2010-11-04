unit DMachineCode;

interface

uses
  DUtils,
  DDebug;

type
TMachineCode = class
protected
  FData: array of Byte;
  FSize: Integer;
  procedure Resize(NewSize: Integer);
  procedure IncSize(Val: Integer);
  procedure Write(V: Pointer; S: Integer);
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

constructor TMachineCode.Create(BaseSize: Integer = 64*1024);
begin
  SetLength(FData, BaseSize);
  FSize := 0;
end;

end.

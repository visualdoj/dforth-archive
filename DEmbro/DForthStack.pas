unit DForthStack;

interface

uses
  {$I units.inc};
  
type
TForthStack = class
 private
  FData: array of Byte;
 public
  procedure push(P: Pointer; Size: Integer);
  procedure drop(Size: Integer);
  procedure pop(P: Pointer; Size: Integer);
  procedure dup(Size: Integer);
  procedure swap(Size: Integer);
  procedure over(Size: Integer);
  procedure PUSHN(P: Pointer; Size: Integer);
  procedure DROPN(Size: Integer);
  procedure POPN(P: Pointer; Size: Integer);
  procedure DUPN(Size: Integer);
  procedure SWAPN(Size: Integer);
  procedure OVERN(Size: Integer);
  procedure LROT(Size: Integer);
  procedure RROT(Size: Integer);
  procedure LROTN(Size: Integer);
  procedure RROTN(Size: Integer);
  function GetSize: Integer;
  function GetPtr: Pointer;

  {procedure PUSH(Value: Integer);
  procedure DROP;
  function POP: Integer;}
end;

implementation

procedure TForthStack.push(P: Pointer; Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(P^, FData[Length(FData) - Size], Size);
end;

procedure TForthStack.drop(Size: Integer);
begin
  SetLength(FData, Length(FData) - Size);
end;

procedure TForthStack.pop(P: Pointer; Size: Integer);
begin
  Move(FData[Length(FData) - Size], P^, Size);
  SetLength(FData, Length(FData) - Size);
end;

procedure TForthStack.dup(Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(FData[Length(FData) - 2*Size], FData[Length(FData) - Size], Size);
end;

procedure TForthStack.swap(Size: Integer);
var
  Temp: array of Byte;
begin
  SetLength(Temp, Size);
  Move(FData[Length(FData) -   Size], Temp[0], Size);
  Move(FData[Length(FData) - 2*Size], FData[Length(FData) - Size], Size);
  Move(Temp[0], FData[Length(FData) -   2*Size], Size);
end;

procedure TForthStack.over(Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(FData[Length(FData) - 3*Size], FData[Length(FData) - Size], Size);
end;

procedure TForthStack.PUSHN(P: Pointer; Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(P^, FData[Length(FData) - Size], Size);
end;

procedure TForthStack.DROPN(Size: Integer);
begin
  SetLength(FData, Length(FData) - Size);
end;

procedure TForthStack.POPN(P: Pointer; Size: Integer);
begin
  Move(FData[Length(FData) - Size], P^, Size);
  SetLength(FData, Length(FData) - Size);
end;

procedure TForthStack.DUPN(Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(FData[Length(FData) - 2*Size], FData[Length(FData) - Size], Size);
end;

procedure TForthStack.SWAPN(Size: Integer);
begin
  Swap(Size);
end;

procedure TForthStack.OVERN(Size: Integer);
begin
  SetLength(FData, Length(FData) + Size);
  Move(FData[Length(FData) - 3*Size], FData[Length(FData) - Size], Size);
end;

procedure TForthStack.LROT(Size: Integer);
var
  Temp: array of Byte;
begin
  SetLength(Temp, Size);
  Move(FData[Length(FData) -   Size], Temp[0], Size);
  Move(FData[Length(FData) - 3*Size], FData[Length(FData) -   Size], Size);
  Move(FData[Length(FData) - 2*Size], FData[Length(FData) - 3*Size], Size);
  Move(Temp[0], FData[Length(FData) -   3*Size], Size);
end;

procedure TForthStack.RROT(Size: Integer);
var
  Temp: array of Byte;
begin
  SetLength(Temp, Size);
  Move(FData[Length(FData) -   Size], Temp[0], Size);
  Move(FData[Length(FData) - 2*Size], FData[Length(FData) -   Size], Size);
  Move(FData[Length(FData) - 3*Size], FData[Length(FData) - 2*Size], Size);
  Move(Temp[0], FData[Length(FData) -   3*Size], Size);
end;

procedure TForthStack.LROTN(Size: Integer);
var
  N: TInt;
  Temp: array of Byte;
  I: Integer;
begin
  pop(@N, SizeOf(N));
  SetLength(Temp, Size);
  Move(FData[Length(FData) - N*Size], Temp[0], Size);
  for I := N downto 2 do    
    Move(FData[Length(FData) - (I-1)*Size], FData[Length(FData) - I*Size], Size);
  Move(Temp[0], FData[Length(FData) - Size], Size);
end;

procedure TForthStack.RROTN(Size: Integer);
var
  N: TInt;
  Temp: array of Byte;
  I: Integer;
begin
  pop(@N, SizeOf(N));
  SetLength(Temp, Size);
  Move(FData[Length(FData) - Size], Temp[0], Size);
  for I := 1 to N-1 do    
    Move(FData[Length(FData) - (I+1)*Size], FData[Length(FData) - I*Size], Size);
  Move(Temp[0], FData[Length(FData) - N*Size], Size);
end;

function TForthStack.GetSize: Integer;
begin
  Result := Length(FData);
end;

function TForthStack.GetPtr: Pointer;
begin
  Result := @FData[Length(FData)];
end;

{procedure TForthStack.PUSH(Value: Integer);
begin
  PUSHN(@Value, SizeOf(Value));
  //Write(Value, ' ');
end;

procedure TForthStack.DROP;
begin
  DROPN(SizeOf(Integer));
end;

function TForthStack.POP: Integer;
begin
  POPN(@Result, SizeOf(Integer));
end;}

end.

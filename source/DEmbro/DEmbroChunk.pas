
unit DEmbroChunk;

interface

uses
  DEmbroCore;

type
// Непрерывный кусок шитого кода, свободное место которого достаточно для
// хранения одной команды
PEmbroChunk = ^TEmbroChunk;
TEmbroChunk = packed record
  Next: PEmbroChunk; 
  Size: Integer;
  Data: array[0..1] of Byte;
end;

// создаёт и добавляет новый кусок в список, возвращает указатель на него
function CreateChunk(Size: Integer; Next: PEmbroChunk): PEmbroChunk;
// освобождает кусок, возвращает его Next
function FreeChunk(Chunk: PEmbroChunk): PEmbroChunk;
// проверяет на принадлежность указателя куску
function IsInChunk(Chunk: PEmbroChunk; P: Pointer): Boolean;

type
TEmbroSpace = object
 private
  // число предполагаемых команд
  FCommandsCapacity: Integer;
  // число байт, требующееся на команду
  FBytesPerBlock: Integer;
  // текущий кусок
  FChunk: PEmbroChunk;
  // позиция в текущем куске
  FPos: PByte;
  // число оставшихся байт в текущем куске
  FRest: Integer;
  // Создать новый кусок
  procedure StartNewChunk;
 public
  // Проинициализировать пространство. 
  // BytesPerBlock -- максимальное число байт, которое может занимать блок
  // CommandsCapacity -- на сколько команд делать запас
  constructor Init(CommandsCapacity, BytesPerBlock: Integer);
  // Получить текущее положение
  function Here: Pointer;
  // При старте описания новой команды
  procedure StartBlock;
  // Выделить несколько байт
  procedure Allot(Bytes: Integer);
  // Очистить всю память до какой-то позиции в прошлом
  procedure ClearTo(Pos: Pointer);
  // Проверить принадлежит ли указатель пространству
  function IsInSpace(Pos: Pointer): Boolean;
end;

implementation

function CreateChunk(Size: Integer; Next: PEmbroChunk): PEmbroChunk;
begin
  GetMem(Result, SizeOf(Next) + SizeOf(Size) + Size);
  Result^.Size := Size;
  Result^.Next := Next;
end;

function FreeChunk(Chunk: PEmbroChunk): PEmbroChunk;
begin
  Result := Chunk^.Next;
  FreeMem(Chunk);
end;

function IsInChunk(Chunk: PEmbroChunk; P: Pointer): Boolean;
begin
  Result := (Cardinal(@Chunk^.Data[0]) <= Cardinal(P)) and
            (Cardinal(P) < Cardinal(@Chunk^.Data[0]) + Chunk^.Size)
end;

procedure TEmbroSpace.StartNewChunk;
begin
  FChunk := CreateChunk(FCommandsCapacity * FBytesPerBlock, FChunk);
  FPos := @FChunk^.Data[0];
  FRest := FCommandsCapacity * FBytesPerBlock;
end;

constructor TEmbroSpace.Init(CommandsCapacity, BytesPerBlock: Integer);
begin
  FCommandsCapacity := CommandsCapacity;
  FBytesPerBlock := BytesPerBlock;
  FChunk := nil;
  StartNewChunk;
end;

function TEmbroSpace.Here: Pointer;
begin
  Result := FPos;
end;

procedure TEmbroSpace.StartBlock;
begin
  if FRest < FBytesPerBlock then
    StartNewChunk;
end;

procedure TEmbroSpace.Allot(Bytes: Integer);
begin
  if Bytes > FRest then begin
    Exit;
  end;
  Inc(FPos, Bytes);
  Dec(FRest, Bytes);
end;

procedure TEmbroSpace.ClearTo(Pos: Pointer);
begin
  while FChunk <> nil do
    if IsInChunk(FChunk, Pos) then begin
      FPos := Pos;
      FRest := FChunk^.Size - (Cardinal(Pos) - Cardinal(@FChunk^.Data[0]));
      Exit;
    end else
      FChunk := FreeChunk(FChunk);
  StartNewChunk;
end;

function TEmbroSpace.IsInSpace(Pos: Pointer): Boolean;
var
  I: PEmbroChunk;
begin
  I := FChunk;
  while I <> nil do
    if IsInChunk(I, Pos) then
      begin Result := True; Exit; end
    else
      I := I^.Next;
  Result := False;
end;

end.

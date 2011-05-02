unit DEmbroSpace;

interface

uses
  DEmbroCore;



const
  DEFAULT_CAPACITY = 64 * 1024;

type
PEmbroChunk = ^TEmbroChunk;
TEmbroChunk = object
  Prev: PEmbroChunk;
  Ptr: Pointer;
  Size: Integer;
end;
 
PEmbroSpace = ^TEmbroSpace;
TEmbroSpace = object
 private
  FCapacity: Integer;
  FBytesPerBlock: Integer;
  FChunk: PEmbroChunk;
  FPos: Cardinal;
  procedure AllocNewChunk;
  procedure ClearChunk;
 public
  constructor Init(BytesPerBlock: Integer; Capacity: Integer = 0);
  procedure SetBytesPerBlock(Bytes: Integer);
  procedure StartBlock;
  function Allot(Bytes: Integer): TError;
  function Here: Pointer;
  function Clear(Bytes: Integer): TError;
end;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TEmbroSpace'}{$ENDIF}
procedure TEmbroSpace.AllocNewChunk;
var
  C: PEmbroChunk;
begin
  New(C);
  C^.Prev := FChunk;
  GetMem(C^.Ptr, FCapacity);
  C^.Size := FCapacity;
  FChunk := C;
end;

procedure TEmbroSpace.ClearChunk;
var
  C: PEmbroChunk;
begin
  C := FChunk^.Prev;
  FreeMem(FChunk^.Ptr);
  Dispose(FChunk);
  FChunk := C;
end;

constructor TEmbroSpace.Init(BytesPerBlock: Integer; Capacity: Integer = 0);
begin
  FBytesPerBlock := Align(BytesPerBlock);
  if FCapacity = 0 then begin
    FCapacity := DEFAULT_CAPACITY;
  end else if FBytesPerBlock > FCapacity then begin
    FCapacity := FBytesPerBlock;
  end else
    FCapacity := Capacity;
  FCapacity := Align(FCapacity);
  FChunk := nil;
end;

procedure TEmbroSpace.SetBytesPerBlock(Bytes: Integer);
begin
  FBytesPerBlock := Align(Bytes);
end;

procedure TEmbroSpace.StartBlock;
begin
  if FChunk = nil then
    AllocNewChunk
  else if FBytesPerBlock > FChunk^.Size - FPos then 
    AllocNewChunk;
end;

function TEmbroSpace.Allot(Bytes: Integer): TError;
begin
  if Bytes > FChunk^.Size - FPos then
    begin Result := ERROR_EMBRO_TOO_BIG_ALLOT; Exit; end;
  if Bytes mod 4 <> 0 then
    begin Result := ERROR_EMBRO_NOT_ALIGNED_ALLOT; Exit; end;
  Inc(FPos, Bytes);
  begin Result := OK; Exit; end;
end;

function TEmbroSpace.Here: Pointer;
begin
  Result := Pointer(Cardinal(FChunk^.Ptr) + FPos);
end;

function TEmbroSpace.Clear(Bytes: Integer): TError;
begin
  if Bytes mod 4 <> 0 then
    begin Result := ERROR_EMBRO_NOT_ALIGNED_CLEAR; Exit; end;
  while (Bytes > 0) and (FChunk <> nil) do begin
    if Bytes > FPos then begin
      Dec(FPos, Bytes);
      begin Result := OK; Exit; end;
    end;
    Dec(Bytes, FPos);
    ClearChunk;
    if FChunk <> nil then
      FPos := FChunk^.Size;
  end;
  begin Result := ERROR_EMBRO_TOO_BIG_CLEAR; Exit; end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

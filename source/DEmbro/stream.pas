unit stream;

interface

uses
  {$I units.inc},
  strings;

type
PInStream = ^TInStream;
POutStream = ^TOutStream;

TInStream = object
 protected
  FReady: Boolean;
 public
  function Read(P: Pointer; Size: Integer): Integer; virtual; abstract; 
  property Ready: Boolean read FReady;
end;

TOutStream = object
 protected
  FReady: Boolean;
 public
  function Write(P: Pointer; Size: Integer): Integer; virtual; abstract;
  property Ready: Boolean read FReady;
end;

TInFile = object(TInStream)
 private
  F: File;
 public
  constructor Create(FName: PAnsiChar); overload;
  constructor Create(var _F: File); overload;
  destructor Destroy; virtual;
  function Read(P: Pointer; Size: Integer): Integer; virtual;
end;

TOutFile = object(TOutStream)
 private
  F: File;
 public
  constructor Create(FName: PAnsiChar); overload;
  constructor Create(var _F: File); overload;
  destructor Destroy; virtual;
  function Write(P: Pointer; Size: Integer): Integer; virtual;
end;

TInMemory = object(TInStream)
 private
  FPosition: PByte;
  FEnd: Pointer;
 public
  constructor Create(Memory: Pointer; Size: Integer); overload;
  constructor Create(S: PAnsiChar); overload;
  function Read(P: Pointer; Size: Integer): Integer; virtual;
end;

TOutMemory = object(TOutStream)
 private
  FPosition: PByte;
  FEnd: Pointer;
 public
  constructor Create(Memory: Pointer; Size: Integer); overload;
  constructor Create(S: PAnsiChar); overload;
  function Write(P: Pointer; Size: Integer): Integer; virtual;
end;

implementation

constructor TInFile.Create(FName: PAnsiChar);
begin
  Assign(F, FName);
  {$I-}
  Reset(F);
  {$I+}
  FReady := IOResult = 0;
end;

constructor TInFile.Create(var _F: File);
begin
  F := _F;
  FReady := True;
end;

destructor TInFile.Destroy;
begin
  Close(F);
end;

function TInFile.Read(P: Pointer; Size: Integer): Integer;
begin
  BlockRead(F, P^, Size, Result);
end;

constructor TOutFile.Create(FName: PAnsiChar);
begin
  Assign(F, FName);
  {$I-}
  Rewrite(F);
  {$I+}
  FReady := IOResult = 0;
end;

constructor TOutFile.Create(var _F: File);
begin
  F := _F;
  FReady := True;
end;

destructor TOutFile.Destroy;
begin
  Close(F);
end;

function TOutFile.Write(P: Pointer; Size: Integer): Integer;
begin
  BlockWrite(F, P^, Size, Result);
end;

constructor TInMemory.Create(Memory: Pointer; Size: Integer);
begin
  FEnd := Pointer(PtrUInt(Memory) + Size);
  FPosition := Memory;
  FReady := True;
end;

constructor TInMemory.Create(S: PAnsiChar);
begin
  FPosition := Pointer(S);
  FEnd := Pointer(PtrUInt(S) + StrLen(S));
  FReady := True;
end;

function TInMemory.Read(P: Pointer; Size: Integer): Integer;
begin
  Result := PtrUInt(FEnd) - PtrUInt(FPosition);
  if Result > Size then
    Result := Size;
  Move(FPosition^, P^, Result);
  Inc(FPosition, Result);
end;

constructor TOutMemory.Create(Memory: Pointer; Size: Integer);
begin
  FEnd := Pointer(PtrUInt(Memory) + Size);
  FPosition := Memory;
  FReady := True;
end;

constructor TOutMemory.Create(S: PAnsiChar);
begin
  FPosition := Pointer(S);
  FEnd := Pointer(PtrUInt(S) + StrLen(S));
  FReady := True;
end;

function TOutMemory.Write(P: Pointer; Size: Integer): Integer;
begin
  Result := PtrUInt(FEnd) - PtrUInt(FPosition);
  if Result > Size then
    Result := Size;
  Move(P^, FPosition^, Result);
  Inc(FPosition, Result);
end;

end.

unit pool;

interface

type
TPool = object
  constructor Init(Capacity: Integer);
  procedure Clear;
  function Append(Memory: Pointer; Size: Integer): Pointer; overload;
  function Append(S: PAnsiChar): PAnsiChar; overload;
end;

implementation

constructor TPool.Init(Capacity: Integer);
begin
end;

procedure TPool.Clear;
begin
end;

function TPool.Append(Memory: Pointer; Size: Integer): Pointer;
begin
end;

function TPool.Append(S: PAnsiChar): PAnsiChar;
begin
end;

end.

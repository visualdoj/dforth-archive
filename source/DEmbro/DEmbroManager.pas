unit DEmbroManager;

interface

uses
  DEmbroCore,
  DEmbroSpace;

type
TEmbro = object
 private
  FSpaces: array of PEmbroSpace;
 public
  function CreateSpace(BytesPerBlock: Integer; Capacity: Integer = 0): PEmbroSpace;
end;

implementation

function TEmbro.CreateSpace;
begin
  SetLength(FSpaces, Length(FSpaces) + 1);
  New(Result, Init(BytesPerBlock, Capacity));
  FSpaces[High(FSpaces)] := Result;
end;

end.

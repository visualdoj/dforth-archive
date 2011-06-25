unit DCommandsTable;

interface

uses
  DEmbroCore;

type
PCommandsTable = ^TCommandsTable;
TCommandsTable = object
  function IsXT(P: Pointer): Boolean;
  function AddXT: TXt;
  procedure DelXT(Xt: TXt);
end;

implementation

function TCommandsTable.IsXT(P: Pointer): Boolean;
begin
  Result := True;
end;

function TCommandsTable.AddXT: PForthCommand;
begin
  New(Result);
end;

procedure TCommandsTable.DelXT(Xt: TXt);
begin
  if IsXT(Xt) then
    Dispose(Xt);
end;

end.

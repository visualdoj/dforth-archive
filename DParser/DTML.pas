unit DTML;

interface

uses
  DUtils,
  DParser;

type
TDTMLItem = record
  Command: Boolean;
  Text: TString;
end;
TDTML = array Of TDTMLItem;

procedure ParseDTML(const Text: TString; var DTML: TDTML);

implementation

procedure ParseDTML(const Text: TString; var DTML: TDTML);
  var
    C: array of Integer; // положение в Text с одиночными |
    I, J, Last: Integer;
    Commands: TArrayOfString;
  function SingleVert(ID: Integer): Boolean;
  begin
    Result := Text[ID] = '|';
    if ID > 1 then
      Result := Result and (Text[ID - 1] <> '|');
    if ID < Length(Text) then
      Result := Result and (Text[ID + 1] <> '|');
  end;
begin
  SetLength(C, 0);
  for I := 1 to Length(Text) do
    if SingleVert(I) then begin
      SetLength(C, Length(C) + 1);
      C[High(C)] := I;
    end;
  Last := 0;
  SetLength(DTML, 0);
  SetLength(C, Length(C) + 1);
  C[High(C)] := Length(Text) + 1;
  for I := 0 to Length(C) do begin
    if C[I] - Last - 1 = 0 then begin
      Last := C[I];
      Continue;
    end;
    if I mod 2 = 0 then begin
      SetLength(DTML, Length(DTML) + 1);
      DTML[High(DTML)].Command := False;
      DTML[High(DTML)].Text := Copy(Text, Last + 1, C[I] - Last - 1);
      while Pos('||', DTML[High(DTML)].Text) <> 0 do
        Delete(DTML[High(DTML)].Text, Pos('||', DTML[High(DTML)].Text), 1);
    end else begin
      ParseList(Copy(Text, Last + 1, C[I] - Last - 1), '|', Commands);
      for J := 0 to High(Commands) do
        if Commands[J] <> '' then begin
          SetLength(DTML, Length(DTML) + 1);
          DTML[High(DTML)].Command := True;
          DTML[High(DTML)].Text := Commands[J];
        end;
    end;
    Last := C[I];
  end;
end;

end.

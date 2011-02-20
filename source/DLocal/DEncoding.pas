unit DEncoding;

interface

uses
  DDebug,
  DUtils,
  DParser;

// Функция считывания utf-8 символа из потока, 
// автоматически переводит его в юникод
function ReadUTF8Char(var P: Pointer): Integer; overload;
function ReadUTF8Char(var P: Pointer; var U: Integer): Boolean; overload;

implementation

function ReadUTF8Char(var P: Pointer): Integer; overload;
begin
  if not ReadUTF8Char(P, Result) then
    Result := 0;
end;

function ReadUTF8Char(var P: Pointer; var U: Integer): Boolean;
  var
    B: Byte;
  function ReadByte: Byte;
  begin
    Result := Byte(P^);
    Inc(P);
  end;
begin
  Result := True;
  U := 0;
  B := ReadByte;
  if (B and (1 shl 7)) = 0 then begin
    U := B
  end else if (B and (1 shl 6)) = 0 then begin
    Result := False;
  end else if (B and (1 shl 5)) = 0 then begin
    U := (B and $1F) shl 6 + (ReadByte and $3F);
  end else if (B and (1 shl 4)) = 0 then begin
    U := (B and $0F) shl 12 + (ReadByte and $3F) shl 6 + (ReadByte and $3F);
  end else if (B and (1 shl 3)) = 0 then begin
    U := (B and $07) shl 18       + (ReadByte and $3F) shl 12 +
         (ReadByte and $3F) shl 6 + (ReadByte and $3F);
  end else
    Result := False;
end;

end.

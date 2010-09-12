unit DEncoding;

interface

uses
  DDebug,
  DUtils,
  DParser;

type
// ����� ��� �������� ������� ���������
TEncoding = class
 protected
  FMaps: array of record
                    D, E: TUnicodeChar;
                  end;
  FReady: Boolean;
 public
  // ����������� ������ �� ������� ��������� �� ����������
  function Decode(C: TUnicodeChar): TUnicodeChar; overload;
  // �������� ��������
  function Encode(C: TUnicodeChar): TUnicodeChar; overload;
  // ����������� ������ �� ������� ��������� �� ����������
  // widestring-��������� �����������
  function Decode(const S: TUnicode): TUnicode; overload;
  // �������� ��������������
  function Encode(const S: TUnicode): TUnicode; overload;
  // ������ �������������� S �� ���������� ���������
  // ����� ���� ��������� ������ ���� ���� � ������� �������
  function Decode(const S: TUnicode): TString; overload;
  // ��������� S �� ���������� ������, ����� ���� ��������
  // �������������� �� ����������� ������� �� �������
  function Encode(const S: TString): TUnicode; overload;

  property Ready: Boolean read FReady;
end;

// ����� ��� �������� ����� ���������, ���������������� ���������� Creumap
TCreumapEncoding = class(TEncoding)
 public
  constructor Create(const FileName: TString);
end;

// ������� ���������� utf-8 ������� �� ������, 
// ������������� ��������� ��� � ������
function ReadUTF8Char(Data: TData): TUnicodeChar; overload;
function ReadUTF8Char(Data: TData; var U: TUnicodeChar): Boolean; overload;

// ������������� ���������� ��������� � ���������.
// � ���������, ��� ������������� ��������� �������������� ���������
// 
// �������� ������ ��� ������� ���� - � ����� ����� ����� ����������������
// ��������� ��������
//
// var
//   U: TUnicodeString;
//   S: TString;
//
// U := S; // ������ �������� � ������ U := Encoding.Encode(S)
// S := U; // ���������� � S := Encoding.Decode(U)
//
// ����� SetGlobalEncoding � Encoding= nil �������� � ����������� 
// ������� �������������� �� ���������
procedure SetGlobalEncoding(Encoding: TEncoding);

// ��������� TCruemapEncoding
procedure Test(const FileName: TString);

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TEncoding'}{$ENDIF}
function TEncoding.Decode(C: TUnicodeChar): TUnicodeChar;
  var
    I: Integer;
begin
  Result := #0;
  for I := 0 to High(FMaps) do
    if FMaps[I].E = C then begin
      Result := FMaps[I].D;
      Exit;
    end;
end;

function TEncoding.Encode(C: TUnicodeChar): TUnicodeChar;
  var
    I: Integer;
begin
  Result := #0;
  for I := 0 to High(FMaps) do
    if FMaps[I].D = C then begin
      Result := FMaps[I].E;
      Exit;
    end;
end;

function TEncoding.Decode(const S: TUnicode): TUnicode;
  var
    I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I] := Decode(S[I]);
end;

function TEncoding.Encode(const S: TUnicode): TUnicode;
  var
    I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I] := Encode(S[I]);
end;

function TEncoding.Decode(const S: TUnicode): TString;
  var
    I: Integer;
begin
  //Decoded := Decode(S);
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I] := TChar(Decode(S[I]));
end;

function TEncoding.Encode(const S: TString): TUnicode;
  var
    U: TUnicodeChar;
    I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do begin
    FillChar(U, SizeOf(U), #0);
    Move(S[I], U, SizeOf(TChar));
    Result[I] := Encode(U);
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TCreumapEncoding'}{$ENDIF}
constructor TCreumapEncoding.Create(const FileName: TString);
  var
    Line: TString;
    E, D: TString;
    F: TextFile;
begin
  FReady := False;
  Assign(F, FileName);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  while not Eof(F) do begin
    Readln(F, Line);
    if Length(Line) = 0 then
      Continue;
    if Line[1] <> '0' then
      Continue;
    E := Copy(Line, 3, Pos(#9, Line) - 3);
    Delete(Line, 1, Pos(#9, Line));
    D := Copy(Line, 3, Pos(#9, Line) - 3);
    SetLength(FMaps, Length(FMaps) + 1);
    FMaps[High(FMaps)].D := TUnicodeChar(HexToInt(D));
    FMaps[High(FMaps)].E := TUnicodeChar(HexToInt(E));
  end;
  Close(F);
  FReady := True;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

function ReadUTF8Char(Data: TData): TUnicodeChar;
begin
  if not ReadUTF8Char(Data, Result) then
    Result := #0;
end;

function ReadUTF8Char(Data: TData; var U: TUnicodeChar): Boolean;
  var
    B: Byte;
begin
  Result := True;
  U := #0;
  B := Data.ReadByte;
  if (B and (1 shl 7)) = 0 then begin
    U := TUnicodeChar(B)
  end else if (B and (1 shl 6)) = 0 then begin
    Result := False;
  end else if (B and (1 shl 5)) = 0 then begin
    U := TUnicodeChar((B and $1F) shl 6 + 
                      (Data.ReadByte and $3F));
  end else if (B and (1 shl 4)) = 0 then begin
    U := TUnicodeChar((B and $0F) shl 12 + 
                      (Data.ReadByte and $3F) shl 6 +
                      (Data.ReadByte and $3F));
  end else if (B and (1 shl 3)) = 0 then begin
    U := TUnicodeChar((B and $07) shl 18 + 
                      (Data.ReadByte and $3F) shl 12 +
                      (Data.ReadByte and $3F) shl 6 +
                      (Data.ReadByte and $3F));
  end else
    Result := False;
end;

var
  {$IFDEF FLAG_FPC}
    DefaultWideStringManager: TWideStringManager;
  {$ELSE}
    // TODO: delphi
  {$ENDIF}
threadvar
  CurrentEncoding: TEncoding;

procedure SetGlobalEncoding(Encoding: TEncoding);
  {$IFDEF FLAG_FPC}
    var
      Manager: TWideStringManager;
  {$ELSE}
    // TODO: delphi
  {$ENDIF}
begin
  CurrentEncoding := Encoding;
  {$IFDEF FLAG_FPC}
  if CurrentEncoding = nil then begin
    SetWideStringManager(DefaultWideStringManager);
  end else begin
    // TODO: ���������� ���������
    // Manager.Wide2AnsiMoveProc := ...
    // Manager.Ansi2WideMoveProc := ...
    // � �.�.
    FillChar(Manager, SizeOf(Manager), #0);
    SetWideStringManager(Manager);
  end;
  {$ELSE}
    // TODO: delphi
  {$ENDIF}
end;

procedure Test;
  var
    E: TEncoding;
    I: Integer;
begin
  E := TCreumapEncoding.Create(FileName);
  if not E.Ready then begin
    Error('[DEncoding.Test]: cannot open file "' + FileName + '"');
    Exit;
  end;
  for I := 0 to High(E.FMaps) do
    Log('encoding: ' + IntToHex(Ord(E.FMaps[I].D)) + ' ' + 
                       IntToHex(Ord(E.FMaps[I].E)));
  E.Free;
end;

initialization
  GetWideStringManager(DefaultWideStringManager);

end.

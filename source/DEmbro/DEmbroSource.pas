
unit DEmbroSource;

interface

uses
  {$I units.inc},
  DEmbroCore;

type
PSource = ^TSource;
PSpaceSkipper = ^TSpaceSkipper;
PNameReader = ^TNameReader;
PLineReader = ^TLineReader;
{$IFNDEF FLAG_FPC}{$REGION 'Source'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourceDecorator'}{$ENDIF}
TSourceDecorator = object
 protected
  FSource: PSource;
 public
  constructor Create(Source: PSource);
  // вызывается после того, как в конец добавлены новые данные
  procedure OnBufferUpdate(AddedBytes: Integer); virtual;
  // вызывается перед тем, как сдвинуть буфер в начало
  procedure OnBufferMove(Delta: Integer); virtual;
  // вызывается после того, как позиция в буфере сдвинулась
  procedure OnIncPos(Delta: Integer); virtual;
  property Source: PSource read FSource;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSource'}{$ENDIF}
TSource = object
 private
  FNameReader: PNameReader;
  FSpaceSkipper: PSpaceSkipper;
  FLineReader: PLineReader;
  FBuffer: record
    Start: PArrayOfByte;
    Pos: PArrayOfByte;
    Finish: PArrayOfByte;
    Size: Integer;
  end;
 protected
  // сдвинуть позицию в буфере
  procedure IncPos(Count: Integer);
  // обновить буфер, вернёт False, если исходник достиг конца
  function UpdateBuffer: Boolean;
 public
  procedure OnBufferUpdate(AddedBytes: Integer); virtual;
  procedure OnBufferMove(Delta: Integer); virtual;
  procedure OnIncPos(Delta: Integer); virtual;

  property NameReader: PNameReader read FNameReader;
  property SpaceSkipper: PSpaceSkipper read FSpaceSkipper;
  property LineReader: PLineReader read FLineReader;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
PSourcePChar = ^TSourcePChar;
TSourcePChar = object(TSource)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourceFile'}{$ENDIF}
TSourceFile = object(TSource)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourceFunc'}{$ENDIF}
TSourceFunc = object(TSource)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'SpaceSkipper'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSpaceSkipper'}{$ENDIF}
TSpaceSkipper = object(TSourceDecorator)
 public
  procedure SkipSpaces; virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleSpaceSkipper'}{$ENDIF}
TSimpleSpaceSkipper = object(TSpaceSkipper)
 public
  procedure SkipSpaces; virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'NameReader'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TNameReader'}{$ENDIF}
TNameReader = object(TSourceDecorator)
 protected
  FInBuffer: Boolean;
  FLast: TString;
  FPos: PChar;
  FLen: Integer;
  property InBuffer: Boolean read FInBuffer;
 public
  function ReadName: Boolean; virtual;
  function ReadNamePassive: Boolean; virtual;
  procedure GetLastName(out Pos: PChar; out Len: Integer); overload;
  function GetLastName: TString; overload;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TCommonNameReader'}{$ENDIF}
TCommonNameReader = object(TNameReader)
 public
  function ReadName: Boolean; virtual;
  function ReadNamePassive: Boolean; virtual;
  procedure OnBufferUpdate(AddedBytes: Integer); virtual;
  procedure OnBufferMove(Delta: Integer); virtual;
  procedure OnIncPos(Delta: Integer); virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'LineReader'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLineReader'}{$ENDIF}
TLineReader = object(TSourceDecorator)
 protected
  function ReadLineFromBuffer(
        Buffer: PChar; 
        BufferSize: Integer;
        out P: PChar; 
        out Size: Integer): Boolean; virtual;
 public
  constructor Create;
  // Используя метод Source.Buffer функция должна выделить в исходном коде
  // строку, вернуть P -- её начало, и Size -- её конец.
  // Допустимо возвращать значения внутри данных, которые вернул последний
  // вызов Buffer.
  // Возвращаемое число -- число прочитанных символов
  function ReadLine(Source: PSource; out P: PChar; out Size: Integer): Integer;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleLineReader'}{$ENDIF}
TSimpleLineReader = object(TLineReader)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TWindowsLineReader'}{$ENDIF}
PWindowsLineReader = ^TWindowsLineReader;
TWindowsLineReader = object(TSimpleLineReader)
 protected
  function ReadLineFromBuffer(
        Buffer: PChar; 
        BufferSize: Integer;
        out P: PChar; 
        out Size: Integer): Boolean; virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLinuxLineReader'}{$ENDIF}
TLinuxLineReader = object(TSimpleLineReader)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TMacLineReader'}{$ENDIF}
TMacLineReader = object(TSimpleLineReader)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TSourceDecorator'}{$ENDIF}
constructor TSourceDecorator.Create(Source: PSource);
begin
  FSource := Source;
end;

procedure TSourceDecorator.OnBufferUpdate(AddedBytes: Integer);
begin
end;

procedure TSourceDecorator.OnBufferMove(Delta: Integer);
begin
end;

procedure TSourceDecorator.OnIncPos(Delta: Integer);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSource'}{$ENDIF}
procedure TSource.IncPos(Count: Integer);
begin
  if PtrInt(FBuffer.Finish) - PtrInt(FBuffer.Pos) <= Count then
    FBuffer.Pos := FBuffer.Finish
  else
    Inc(FBuffer.Pos, Count);
end;

function TSource.UpdateBuffer: Boolean;
begin
  Result := False;
end;

procedure TSource.OnBufferUpdate(AddedBytes: Integer);
begin
  FLineReader.OnBufferUpdate(AddedBytes);
  FNameReader.OnBufferUpdate(AddedBytes);
  FSpaceSkipper.OnBufferUpdate(AddedBytes);
end;

procedure TSource.OnBufferMove(Delta: Integer);
begin
  FLineReader.OnBufferMove(Delta);
  FNameReader.OnBufferMove(Delta);
  FSpaceSkipper.OnBufferMove(Delta);
end;

procedure TSource.OnIncPos(Delta: Integer);
begin
  FLineReader.OnIncPos(Delta);
  FNameReader.OnIncPos(Delta);
  FSpaceSkipper.OnIncPos(Delta);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSpaceSkipper'}{$ENDIF}
procedure TSpaceSkipper.SkipSpaces;
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleSpaceSkipper'}{$ENDIF}
procedure TSimpleSpaceSkipper.SkipSpaces;
begin
  with Source^.FBuffer do
    while Pos[0] in [0..32] do begin
      while Pos <> Finish do
        if Pos[0] in [0..32] then
          Inc(Pos)
        else
          Exit;
      if not Source.UpdateBuffer then
        Exit;
    end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TNameReader'}{$ENDIF}
function TNameReader.ReadName: Boolean;
begin
  Result := False;
end;

function TNameReader.ReadNamePassive: Boolean;
begin
  Result := False;
end;

procedure TNameReader.GetLastName(out Pos: PChar; out Len: Integer);
begin
  if InBuffer then begin
    Pos := FPos;
    Len := FLen;
  end else begin
    Pos := @FLast[1];
    Len := Length(FLast);
  end;
end;

function TNameReader.GetLastName: TString;
begin
  if InBuffer then begin
    SetLength(Result, FLen);
    Move(FPos[0], Result[1], FLen);
  end else
    Result := FLast;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TCommonNameReader'}{$ENDIF}
function TCommonNameReader.ReadName: Boolean;
begin
  FInBuffer := False;
  FLast := '';
  with Source^.FBuffer do
    while not (Pos[0] in [0..32]) do begin
      while Pos <> Finish do
        if Pos[0] in [0..32] then
          begin Result := Length(FLast) <> 0; Exit; end
        else begin
          FLast := FLast + Char(Pos[0]);
          Inc(Pos);
        end;
      if not Source^.UpdateBuffer then
        begin Result := Length(FLast) <> 0; Exit; end;
    end;
  begin Result := Length(FLast) <> 0; Exit; end;
end;

function TCommonNameReader.ReadNamePassive: Boolean;
begin
  FInBuffer := False;
  Result := True;
end;

procedure TCommonNameReader.OnBufferUpdate(AddedBytes: Integer);
begin
end;

procedure TCommonNameReader.OnBufferMove(Delta: Integer);
begin
  if FInBuffer then begin
    SetLength(FLast, FLen);
    Move(FPos[0], FLast[1], FLen);
    FInBuffer := False;
  end;
end;

procedure TCommonNameReader.OnIncPos(Delta: Integer);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLineReader'}{$ENDIF}
function TLineReader.ReadLineFromBuffer;
begin
  P := Buffer;
  Size := BufferSize;
  Result := True;
end;

constructor TLineReader.Create;
begin
end;

function TLineReader.ReadLine;
var
  I: Integer;
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleLineReader'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TWindowsLineReader'}{$ENDIF}
function TWindowsLineReader.ReadLineFromBuffer(
      Buffer: PChar; 
      BufferSize: Integer;
      out P: PChar; 
      out Size: Integer): Boolean;
begin
  P := Buffer;
  Size := 1;
  while Size < BufferSize do begin
    Inc(Size);
    if (P[Size - 2] = #13) and (P[Size - 1] = #10) then
      begin Result := True; Exit; end;
  end;
  Result := False;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

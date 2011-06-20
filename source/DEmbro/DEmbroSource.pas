
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
  constructor Create;
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
  FEOS: Boolean;
 protected
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
  constructor Create(NameReader: PNameReader; 
                     SpaceSkipper: PSpaceSkipper;
                     LineReader: PLineReader);
  procedure OnBufferUpdate(AddedBytes: Integer); virtual;
  procedure OnBufferMove(Delta: Integer); virtual;
  procedure OnIncPos(Delta: Integer); virtual;

  procedure SkipSpaces;
  function SourceCut(const S: TString): TString;
  function NextName: TString;
  function NextNamePassive: TString;
  function NextChar: TChar;

  property NameReader: PNameReader read FNameReader;
  property SpaceSkipper: PSpaceSkipper read FSpaceSkipper;
  property LineReader: PLineReader read FLineReader;
  property EOS: Boolean read FEOS;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
PSourcePChar = ^TSourcePChar;
TSourcePChar = object(TSource)
 private
  FP: PAnsiChar;
 public
  constructor Create(NameReader: PNameReader; 
                     SpaceSkipper: PSpaceSkipper;
                     LineReader: PLineReader;
                     P: PChar);
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
PSimpleSpaceSkipper = ^TSimpleSpaceSkipper;
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
PCommonNameReader = ^TCommonNameReader;
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
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleLineReader'}{$ENDIF}
TSimpleLineReader = object(TLineReader)
 private
  FCurrentLine: TString;
  FCurrentLineBefore: TString;
  FCurrentLineAfter: TString;
 public
  procedure OnBufferUpdate(AddedBytes: Integer); virtual;
  procedure OnBufferMove(Delta: Integer); virtual;
  procedure OnIncPos(Delta: Integer); virtual;
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

function GetEmptySource: PSourcePChar;
function CreateSourcePChar(P: PChar): PSourcePChar;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TSourceDecorator'}{$ENDIF}
constructor TSourceDecorator.Create;
begin
  FSource := Nil;
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
constructor TSource.Create(NameReader: PNameReader; 
                   SpaceSkipper: PSpaceSkipper;
                   LineReader: PLineReader);
begin
  FNameReader := NameReader;
  FSpaceSkipper := SpaceSkipper;
  FLineReader := LineReader;
  FNameReader^.FSource := @Self;
  FSpaceSkipper^.FSource := @Self;
  FLineReader^.FSource := @Self;
  FEOS := True;
  FBuffer.Start := nil;
  FBuffer.Pos := nil;
  FBuffer.Size := 0;
  FBuffer.Finish := nil;
end;

procedure TSource.IncPos(Count: Integer);
begin
  if PtrInt(FBuffer.Finish) - PtrInt(FBuffer.Pos) <= Count then
    FBuffer.Pos := FBuffer.Finish
  else
    Inc(PByte(FBuffer.Pos),Count);
end;

function TSource.UpdateBuffer: Boolean;
begin
  Result := False;
  FEOS := FBuffer.Pos = FBuffer.Finish;
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
  if FBuffer.Pos = FBuffer.Finish then
    FEOS := not UpdateBuffer;
end;

procedure TSource.SkipSpaces;
begin
  FSpaceSkipper.SkipSpaces;
end;

function TSource.SourceCut(const S: TString): TString;
type
  PtrInt = Cardinal;
var
  L: Integer;
  P: PArrayOfByte;
begin
  Result := '';
  with FBuffer do
    while not EOS do begin
      P := Pos;
      while PtrInt(Finish) - PtrInt(P) >= Length(S) do
        if CompareByte(S[1], P[0], Length(S)) = 0 then begin
          L := Length(Result);
          //Writeln('L, P-Pos: ', L, ' ', PtrInt(P) - PtrInt(Pos));
          SetLength(Result, Length(Result) + PtrInt(P) - PtrInt(Pos));
          Move(Pos[0], Result[1+L], PtrInt(P) - PtrInt(Pos));
          IncPos(PtrInt(P) - PtrInt(Pos) + Length(S));
          //Writeln('SourceCut: ', Length(Result));
          Exit;
        end else
          Inc(PByte(P),1);
      //Writeln('WAR: UpdateBuffer underdeveloped');
      UpdateBuffer;
    end;
end;

function TSource.NextName: TString;
begin
  FSpaceSkipper.SkipSpaces;
  if EOS then begin
    Result := '';
  end else begin
    if FNameReader.ReadName then
      Result := FNameReader.GetLastName
    else
      Result := '';
  end;
end;

function TSource.NextNamePassive: TString;
begin
  FSpaceSkipper.SkipSpaces;
  if EOS then begin
    Result := '';
  end else begin
    if FNameReader.ReadNamePassive then
      Result := FNameReader.GetLastName
    else
      Result := '';
  end;
end;

function TSource.NextChar: TChar;
begin
  with FBuffer do
    if EOS then
      Result := #0
    else begin 
      if Pos = Finish then
        if not UpdateBuffer then
          begin Result := #0; Exit; end;
      Result := Char(Pos[0]);
      Inc(PByte(Pos));
      OnIncPos(1);
    end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
constructor TSourcePChar.Create;
begin
  inherited Create(NameReader, SpaceSkipper, LineReader);
  FP := P;
  FEOS := False;
  FBuffer.Start := @FP[0];
  FBuffer.Size := StrLen(FP);
  FBuffer.Pos := FBuffer.Start;
  FBuffer.Finish := @FBuffer.Start[FBuffer.Size];
end;
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
          Inc(PByte(Pos))
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
//label
//  DONE_;
begin
  {FInBuffer := False;
  FLast := '';
  with Source^.FBuffer do
    while not (Pos[0] in [0..32]) do begin
      while Pos <> Finish do
        if Pos[0] in [0..32] then
          goto DONE_
        else begin
          FLast := FLast + Char(Pos[0]);
          Inc(PByte(Pos));
        end;
      if not Source^.UpdateBuffer then
        goto DONE_
    end;
DONE_:
  Result := Length(FLast) <> 0;
  if Result then
    Source^.OnIncPos(Length(FLast));}
  Result := ReadNamePassive;   
  if Result then begin
    Source^.IncPos({Source^.FBuffer.Pos,} Length(FLast));
    Source^.OnIncPos(Length(FLast));
  end;
end;

function TCommonNameReader.ReadNamePassive: Boolean;
label
  DONE_;
var
  PassivePos: PArrayOfByte;
begin
  FInBuffer := False;
  FLast := '';
  PassivePos := Source^.FBuffer.Pos;
  with Source^.FBuffer do
    while not (PassivePos[0] in [0..32]) do begin
      while PassivePos <> Finish do
        if PassivePos[0] in [0..32] then
          goto DONE_
        else begin
          FLast := FLast + Char(PassivePos[0]);
          Inc(PByte(PassivePos));
        end;
      if not Source^.UpdateBuffer then
        goto DONE_
    end;
DONE_:
  Result := Length(FLast) <> 0;
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
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSimpleLineReader'}{$ENDIF}
procedure TSimpleLineReader.OnBufferUpdate(AddedBytes: Integer);
begin
end;

procedure TSimpleLineReader.OnBufferMove(Delta: Integer);
begin
end;

procedure TSimpleLineReader.OnIncPos(Delta: Integer);
begin
end;
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

var
  EmptySource: PSourcePChar;

function GetEmptySource: PSourcePChar;
begin
  Result := EmptySource;
end;

function CreateSourcePChar(P: PChar): PSourcePChar;
begin
  Result := New(PSourcePChar, 
        Create(
                New(PCommonNameReader, Create),
                New(PSimpleSpaceSkipper, Create),
                New(PWindowsLineReader, Create),
                P
              ));
end;

initialization
  EmptySource := CreateSourcePChar('');
finalization
  Dispose(EmptySource);
end.

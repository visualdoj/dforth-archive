unit DEmbroSource;

interface

uses
  {$I units.inc},
  DEmbroCore;

type
PSource = ^TSource;
PLineReader = ^TLineReader;
{$IFNDEF FLAG_FPC}{$REGION 'Source'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSource'}{$ENDIF}
TSource = object
 private
  FLineReader: PLineReader;
  FName: TString;
  FLast: record
    Line: Integer;
    Col: Integer;
  end;
  FLine: record
    Index: Integer;
    Col: Integer;
    Start: PChar;
    Size: Integer;
  end;
  FBuffer: record
    P: PChar;
    Size: Integer;
  end;
 protected
  // считывает в некий внутренний буфер данные оптимального размера
  //   P -- указатель на начало буфера
  //   Size -- размер буфера
  //   Возвращает True, если данные ещё не закончились. 
  //   
  //   При повторном вызове Buffer, данные должны "нараститься": 
  //   начало буфера должно остаться таким же, но должен увеличиться его размер.
  //function Buffer(out P: Pointer; out Size: Integer): Boolean; virtual;
  // закончились ли данные буфера
  function EndOfStreamData: Boolean; virtual;
  // определяет границы строки исходника
  procedure ReadLine;
  // буфер
  function Buffer: Pointer;
  function BufferSize: Integer;
  function UpdateBuffer: Boolean; virtual;
  procedure SkipBuffer(Bytes: Integer); virtual;
 public
  constructor Create(const Name: TString; LineReader: PLineReader);
  // закончился ли исходный код
  function EOS: Boolean;
  // прочесть символ
  function ReadChar: Byte;
  // прочесть имя
  function ReadName: TString;
  // содержимое текущей строки
  procedure GetCurrentLine(out Start: PChar; out Size: Integer);
  // текущий номер строки исходника
  function Line: Integer;
  // текущий символ в строке исходника
  function Col: Integer;
  // номер строки последнего прочитанного слова
  function NameLine: Integer;
  // номер символа, с которого начинается последнее прочитанное слово
  function NameCol: Integer;
  // название исходника
  property Name: TString read FName;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
PSourcePChar = ^TSourcePChar;
TSourcePChar = object(TSource)
 private
  FStart: PChar;
  FEnd: PChar;
  FPos: PChar;
 protected
  function UpdateBuffer: Boolean; virtual;
  function EndOfStreamData: Boolean; virtual;
 public
  constructor Create(const Name: TString; 
                     LineReader: PLineReader;
                     Start: PChar;
                     Size: Integer = -1);
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
{$IFNDEF FLAG_FPC}{$REGION 'LineReader'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLineReader'}{$ENDIF}
TLineReader = object
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

{$IFNDEF FLAG_FPC}{$REGION 'TSource'}{$ENDIF}
constructor TSource.Create(const Name: TString; LineReader: PLineReader);
begin
  FLineReader := LineReader;
  FName := Name;
  FBuffer.P := nil;
  FBuffer.Size := 0;
  FLast.Line := 0;
  FLast.Col := 0;
  FLine.Index := 0;
  FLine.Col := 0;
  FLine.Start := nil;
  FLine.Size := 0;
end;

function TSource.EndOfStreamData: Boolean;
begin
  Result := True;
end;

procedure TSource.ReadLine;
var
  I: Integer;
begin
  FLineReader.ReadLine(@Self, FLine.Start, FLine.Size);
  Inc(FLine.Index);
  FLine.Col := 0;

  Write('Line(',FLine.Index,'): ');
  for I := 0 to FLine.Size - 1 do
    Write(FLine.Start[I]);
  Writeln;
  Write('Press enter...'); Readln;
end;

function TSource.Buffer: Pointer;
begin
  Result := FBuffer.P;
end;

function TSource.BufferSize: Integer;
begin
  Result := FBuffer.Size;
end;

function TSource.UpdateBuffer;
begin
  Result := False;
end;

procedure TSource.SkipBuffer(Bytes: Integer);
begin
  FBuffer.P := @FBuffer.P[Bytes];
  Dec(FBuffer.Size, Bytes);
  if FBuffer.Size < 0 then
    FBuffer.Size := 0;
end;

function TSource.EOS: Boolean;
begin
  Result := (FLine.Col = FLine.Size) and EndOfStreamData;
end;

function TSource.ReadChar: Byte;
begin
  if EOS then begin
    Result := 0;
    Exit;
  end;
  if FLine.Col = FLine.Size then
    ReadLine;
  Result := Ord(FLine.Start[FLine.Col]);
  Inc(FLine.Col);
end;

function TSource.ReadName: TString;
begin
  Result := '';
  while Result = '' do begin
    while FLine.Col < FLine.Size do
      if FLine.Start[FLine.Col] in [#0..#32] then
        Inc(FLine.Col)
      else
        Break;
    if FLine.Col = FLine.Size then begin
      ReadLine;
      Continue;
    end;
    FLast.Line := FLine.Index;
    FLast.Col := FLine.Col;
    while FLine.Col < FLine.Size do 
      if FLine.Start[FLine.Col] in [#0..#32] then
        Break
      else
        Inc(FLine.Col);      
    SetLength(Result, FLine.Col - FLast.Col);
    Move(FLine.Start[FLast.Col], Result[1], FLine.Col - FLast.Col);
  end;
end;

procedure TSource.GetCurrentLine(out Start: PChar; out Size: Integer);
begin
  Start := FLine.Start;
  Size := FLine.Size;
end;

function TSource.Line: Integer;
begin
  Result := FLine.Index;
end;

function TSource.Col: Integer;
begin
  Result := FLine.Col;
end;

function TSource.NameLine: Integer;
begin
  Result := FLast.Line;
end;

function TSource.NameCol: Integer;
begin
  Result := FLast.Col;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TSourcePChar'}{$ENDIF}
constructor TSourcePChar.Create;
begin
  Inherited Create(Name, LineReader);
  FStart := Start;
  FEnd := Start;
  if Size <> -1 then
    FEnd := PChar(Cardinal(FStart) + Size)
  else
    while FEnd^ <> #0 do
      Inc(FEnd);
  FPos := FStart;
  FBuffer.P := FStart;
  FBuffer.Size := Cardinal(FEnd) - Cardinal(FStart);
end;

function TSourcePChar.UpdateBuffer;
begin
end;

function TSourcePChar.EndOfStreamData: Boolean;
begin
  Result := FPos = FEnd;
end;

(* function TSourcePChar.Buffer(out P: Pointer; out Size: Integer): Boolean; *)
(* begin *)
(*   P := FPos; *)
(*   Size := Cardinal(FEnd) - Cardinal(FPos); *)
(*   Result := Size <> 0; *)
(* end; *)
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
  repeat
    if ReadLineFromBuffer(Source.Buffer, Source.BufferSize, P, Size) then begin
      Result := Size;
      Exit;
    end;
  until not Source.UpdateBuffer;
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
  Result := True;
  Size := 1;
  while Size < BufferSize do begin
    Inc(Size);
    if (P[Size - 2] = #13) and (P[Size - 1] = #10) then
      Exit;
  end;
  Result := False;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

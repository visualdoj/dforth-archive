//{$MACRO on}
unit DUtils;

interface

{$IFNDEF FLAG_FPC}
uses
  Windows;
{$ENDIF}

Type
Float = Single;

TInt  = Integer;
TInt8  = ShortInt;
TInt16 = SmallInt;
TInt32 = LongInt;
TInt64 = Int64;
TUint  = Cardinal;
TUint8  = Byte;
TUint16 = Word;
TUint32 = Cardinal;
TUint64 = QWord;

TString = AnsiString;
TChar = AnsiChar;

TUnicode = WideString;
TUnicodeChar = WideChar;

TSetOfChar = set of TChar;
TData = class;
PArrayOfByte = ^TArrayOfByte;
TArrayOfByte = array[0..1] of Byte;
PArrayOfSingle = ^TArrayOfSingle;
TArrayOfSingle = array[0..1] of Single;
PArrayOfWord = ^TArrayOfWord;
TArrayOfWord = array[0..1] of Word;
PArrayOfCardinal = ^TArrayOfCardinal;
TArrayOfCardinal = array[0..1] of Cardinal;

PCrossChar = {$IFDEF FLAG_FPC}PAnsiChar{$ELSE}PWideChar{$ENDIF};

TProcOfObj = procedure of object;

TUtils = class
  class function GetTimer: Integer;
end;

TData = class
 private
  // массив данных
  FBytes: array of Byte;
  // минимум физической памяти, которую будет выделять класс
  FReserved: Integer;
  // фактическое кол-во данных
  FSize: Integer;
  // положение курсора
  FPos: Integer;

  FReady: Boolean;

  procedure SetReserved(Reserve: Integer);
 public
  constructor Create(Reserved: Integer = 0); overload;
  constructor Create(const FileName: TString); overload;
  constructor Create(P: Pointer; Size: Integer); overload;
  procedure Clear;
  procedure ReadFromFile(const FileName: TString);
  procedure WriteToFile(const FileName: TString);
  // функции чтения/записи
  procedure WriteVar(P: Pointer; Size: Integer);
  procedure ReadVar(P: Pointer; Size: Integer);
  // устанавливает курсор в 0
  procedure Rewind;
  // пропускает сколько-то байт
  procedure Seek(Delta: Integer);
  // устанавливает кусор
  procedure SeekAbs(NewPos: Integer);

  // для удобства
  procedure WriteInt(I: Integer);
  procedure WriteByte(B: Byte);
  procedure WriteWord(W: Word);
  procedure WriteFloat(F: Float);
  procedure WriteStr(S: TString);
  function ReadInt: Integer;
  function ReadUint: Cardinal;
  function ReadByte: Byte;
  function ReadWord: Word;
  function ReadFloat: Single;
  function ReadStr: TString;
  function ReadPChar: TString;
  // указатель курсора
  function GetPtr: Pointer;
  // указатель на начало данных
  function GetData: Pointer;
  // фактический размер
  function GetSize: Integer;
  // минимальный размер
  function GetMaxSize: Integer;
  // дошел ли курсор до конца
  function IsEmpty: Boolean;
  property Pos: Integer read FPos;
  property Size: Integer read FSize write FSize;
  property Reserved: Integer read FReserved write SetReserved;
  property Ready: Boolean read FReady;
end;

Function IntToStr(Value: integer): TString;
Function StrToInt(const Value: TString): integer;
Function StrToIntDef(const Value: TString; Def: integer): integer;
Function StrToFloat(const S: TString): Single;
Function FloatToStr(F: Single): TString; overload;
Function FloatToStr(F: Single; Digitals: Integer): TString; overload;
function CharArrToStr(const C: Array of Char): TString;
Function HexToInt(S: TString): Integer;
Function IntToHex(Value: Integer; Digits: Integer = 0): TString;
Function FileExist(const Filename: TString): boolean;
Function FileExists(const Filename: TString): boolean;
Procedure CreateFile(const FileName: TString);
Procedure DeleteFile(const Filename: TString);
Function GetTimer: integer;
// Из верхнего регистра в нижний
Function AnsiLowerCase(const S: TString): TString;
function Space(b: Byte): TString;
function IsPrintable(C: TChar): Boolean;

function ToStr(V: Array Of Const): TString;

type
TCriticalSection = class
private
  FCS: TRTLCriticalSection;
  FLocked: Boolean;
public
  constructor Create;
  destructor Destroy; override;
  procedure Enter; inline;
  procedure Leave; inline;
  property Locked: Boolean read FLocked;
end;

function GetRaz(I: Integer): TString;

implementation

uses
  DDebug, DWinApi;

class function TUtils.GetTimer: Integer;
begin
  Result := DWinApi.GetTimer;
end;

//{{{ TData
procedure TData.SetReserved(Reserve: Integer);
begin
  FReserved := Ord(Reserve > 4)*Reserve + Ord(Reserve <= 4)*4;
  if Length(FBytes) < FReserved then
    SetLength(FBytes, FReserved);
end;

constructor TData.Create(Reserved: Integer = 0);
begin
  Clear;
  Rewind;
  FReserved := Ord(Reserved>4)*Reserved + Ord(Reserved<=4)*4;
  FSize := 0;
  if FReserved > 0 then
    SetLength(FBytes, FReserved);
  FReady := True;
end;

constructor TData.Create(const FileName: TString);
begin
  Create;
  ReadFromFile(FileName);
end;

constructor TData.Create(P: Pointer; Size: Integer); 
begin
  Create(Size);
  WriteVar(P, Size);
end;

procedure TData.Clear;
begin
  SetLength(FBytes, FReserved);
  FSize := 0;
end;

procedure TData.ReadFromFile(const FileName: TString);
  var
    F: file of Byte;
begin
  FReady := False;
  Assign(F, FileName);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  if FSize + FileSize(F) > Length(FBytes) then
    SetLength(FBytes, FSize + FileSize(F));
  FSize := FSize + FileSize(F);
  BlockRead(F, FBytes[FSize - FileSize(F)], FileSize(F));
  Close(F);
  FReady := True;
end;

procedure TData.WriteToFile(const FileName: TString);
  var
    F: file of Byte;
begin
  Assign(F, FileName);
  {$I-}
  Rewrite(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  BlockWrite(F, FBytes[0], FSize);
  Close(F);
end;

procedure TData.WriteVar(P: Pointer; Size: Integer);
  var
    Temp: array of Byte;
begin
  if Size <= 0 then
    Exit;
  if P = nil then begin
    SetLength(Temp, Size);
    WriteVar(@Temp[0], Size);
    Exit;
  end;
  if FSize + Size > Length(FBytes) then
    SetLength(FBytes, FSize + Size);
  Move(P^, FBytes[FSize], Size);
  Inc(FSize, Size);
end;

procedure TData.WriteInt(I: Integer);
begin
  WriteVar(@I, SizeOf(Integer));
end;

procedure TData.WriteByte(B: Byte);
begin
  WriteVar(@B, SizeOf(Byte));
end;

procedure TData.WriteWord(W: Word);
begin
  WriteVar(@W, SizeOf(W));
end;

procedure TData.WriteFloat(F: Float);
begin
  WriteVar(@F, SizeOf(Float));
end;

procedure TData.WriteStr(S: TString);
begin
  WriteByte(Length(S));
  WriteVar(@(S[1]), Length(S));
end;

procedure TData.Rewind;
begin
  FPos := 0;
end;

procedure TData.Seek(Delta: Integer);
begin
  FPos := FPos + Delta;
end;

procedure TData.SeekAbs(NewPos: Integer);
begin
  FPos := NewPos;
end;

procedure TData.ReadVar(P: Pointer; Size: Integer);
begin
  if FPos + Size <= FSize then begin
    if P <> nil then
      Move(FBytes[FPos], P^, Size);
    FPos := FPos + Size;
  end;
end;

function TData.ReadInt: Integer;
begin
  ReadVar(@Result, SizeOf(Integer));
end;

function TData.ReadUint: Cardinal;
begin
  ReadVar(@Result, SizeOf(Cardinal));
end;

function TData.ReadByte: Byte;
begin
  ReadVar(@Result, SizeOf(Byte))
end;

function TData.ReadWord: Word;
begin
  ReadVar(@Result, SizeOf(Word));
end;

function TData.ReadFloat: Single;
begin
  ReadVar(@Result, SizeOf(Single));
end;

function TData.ReadStr: TString;
  var
    Len: Byte;
begin
  Len := ReadByte;
  SetLength(Result, Len);
  if Len > 0 then
    ReadVar(@Result[1], Len);
end;

function TData.ReadPChar: TString;
  var
    C: TChar;
begin
  SetLength(Result, 0);
  C := TChar(ReadByte);
  while C <> #0 do begin
    Result := Result + C;
    C := TChar(ReadByte);
  end;
end;

function TData.GetPtr: Pointer;
begin
  Result := @FBytes[FPos];
end;

function TData.GetData: Pointer;
begin
  Result := @FBytes[0];
end;

function TData.GetSize: Integer;
begin
  {if FMaxSize = 0 then
    Result := Length(FBytes)
  else}
    Result := FSize;
end;

function TData.GetMaxSize: Integer;
begin
  {if FMaxSize = 0 then
    Result := Length(FBytes)
  else
    Result := FMaxSize;}
  Result := 0;
end;

function TData.IsEmpty: Boolean;
begin
  Result := FPos >= FSize;
end;
//}}}

Function InttoStr;//{{{
begin
  Str(Value, Result);
end;
//}}}
Function StrtoInt;//{{{
  Var
    Code: integer;
    //S: TString;
begin
  //S := StrToAnsi(Value);
  Val(Value, Result, Code);
end;
//}}}
Function StrToIntDef(const Value: TString; Def: integer): integer;//{{{
  Var
    Code: integer;
begin
  Val(Value, Result, Code);
    If Code <> 0 then
      Result := Def;
end;
//}}}
Function StrToFloat(const S: TString): Single;//{{{
  Var
    Code: Integer;
begin
    If Pos('.', S) <> 0 then begin
      //Insert(',', S, Pos('.', S));
      //Delete(S, Pos('.', S), 1);
    end;
  Val(S, Result, Code);
end;
//}}}
Function FloatToStr(F: Single): TString;//{{{
begin
  Str(F, Result);
    If Pos(',', Result) <> 0 then begin
      Insert('.', Result, Pos(',', Result));
      Delete(Result, Pos(',', Result), 1);
    end;
end;
//}}}
Function FloatToStr(F: Single; Digitals: Integer): TString;//{{{
begin
  Str(F:0:Digitals, Result);
    If Pos(',', Result) <> 0 then begin
      Insert('.', Result, Pos(',', Result));
      Delete(Result, Pos(',', Result), 1);
    end;
end;
//}}}
Function HexDigitToInt(C: TChar): Byte;//{{{
begin
  if C in ['A'..'F'] then
    Result := Ord(C) - Ord('A') + 10
  else if C in ['a'..'f'] then
    Result := Ord(C) - Ord('a') + 10
  else if C in ['0'..'9'] then
    Result := Ord(C) - Ord('0')
  else
    Result := 0;
end;
//}}}
Function HexToInt(S: TString): Integer;//{{{
begin
  Result := 0;
  while Length(S) > 0 do begin
    Result := Result*16 + HexDigitToInt(S[1]);
    Delete(S, 1, 1);
  end;
end;
//}}}
const
   HexDigits: array[0..15] of TChar = '0123456789ABCDEF';

function IntToHex;//{{{
  var 
    i: integer;
begin
 SetLength(result, digits);
 for i := 0 to digits - 1 do
  begin
   result[digits - i] := HexDigits[value and 15];
   value := value shr 4;
  end ;
 while value <> 0 do begin
   result := HexDigits[value and 15] + result;
   value := value shr 4;
 end;
end;

//}}}
function CharArrToStr(const C : Array of Char) : TString;//{{{
var I : Integer;
begin
  // convert the array of characters to a TString
  I :=0;
  result :='';
  while C[i] <> #0 do
  begin
    result := result + C[I];
    Inc(I);
  end;
end;
//}}}
Function FileExist;//{{{
  Var
    F: File;
begin
  FileMode := 64;
  AssignFile(F, Filename);
  {$I-}
  Reset(F);
  {$I+}
  Result := IOResult = 0;
    If Result then
      CloseFile(F);
end;
//}}}
Function FileExists;//{{{
  Var
    F: File;
begin
  FileMode := 64;
  AssignFile(F, Filename);
  {$I-}
  Reset(F);
  {$I+}
  Result := IOResult = 0;
    If Result then
      CloseFile(F);
end;
//}}}
Procedure CreateFile;//{{{
  Var
    F: File;
begin
    If FileExist(FileName) then
      Exit;
  Assign(F, FileName);
  {$I-}
  Rewrite(F);
  {$I+}
    If IOResult = 0 then
      Close(F);
end;
//}}}
Procedure DeleteFile;//{{{
begin
    If not FileExist(Filename) then
      Exit;
  //Windows.DeleteFile(PCrossChar(Filename));
end;
//}}}
Function GetTimer;//{{{
begin
  Result := DWinApi.GetTimer;
end;
//}}}
Function AnsiLowerCase(Const S: TString): TString;//{{{
  Var
    Len: Integer;
begin
  Len := Length(S);
  SetString(Result, PChar(S), Len);
  //   If Len > 0 then
  //    CharLowerBuff(Pointer(Result), Len);
end;
//}}}
function Space(b: Byte): TString;
begin
  SetLength(Result, B);
  FillChar(Result[1], B, Ord(' '));
end;

function IsPrintable(C: TChar): Boolean;
begin
  Result := Char(C) in ['a'..'z', 'A'..'Z', 
                        'А'..'Я', 'а'..'я', 
                        '0'..'9', ' ', '#',
                        '.', ',', '?', '!',
                        '_', '-', '/', '\',
                        '[', ']', '{', '}',
                        '(', ')', '<', '>',
                        '$', '%', '&', '@',
                        ':', ';', '"', '''',
                        '+', '*', '=', '|',
                        '^'];
end;

Function ToStr(V: Array Of Const): TString;//{{{
  Var
    I: Integer;
begin
  Result := '';
  for I := 0 to High(V) do
    case V[I].vType of
      vtInteger: Result := Result + IntToStr(V[I].vInteger);
      vtExtended: Result := Result + FloatToStr(V[I].vExtended^);
      vtBoolean: Result := Result + IntToStr(Ord(V[I].vBoolean));
      vtChar: Result := Result + V[I].vChar;
      vtString: Result := Result + V[I].vString^;
      vtPointer: Result := Result + '@' + IntToStr(LongInt(V[I].vPointer));
     { TODO : не пашет } vtPChar: Result := Result + V[I].vPChar;
      vtObject:
        begin
          Result := Result + '<' + V[I].vObject.ClassName + '>';
        end;
      vtClass: Result := Result + '<' + V[I].vClass.ClassName + '>';
      { TODO : не пашет }vtAnsiString: Result := Result + AnsiString(V[I].vAnsiString);
    else
      Result := Result + '?';
    end;
end;

//
// TCriticalSection
//
constructor TCriticalSection.Create;
begin
  InitCriticalSection(FCS);
  FLocked := False;
end;

destructor TCriticalSection.Destroy;
begin
  DoneCriticalSection(FCS);
end;

procedure TCriticalSection.Enter;
begin
  EnterCriticalSection(FCS);
  FLocked := True;
end;

procedure TCriticalSection.Leave;
begin
  FLocked := False;
  LeaveCriticalSection(FCS);
end;

function GetRaz(I: Integer): TString;
begin
  if (I div 10 <> 1) and ((I mod 10) in [2, 3, 4]) then
    Result := 'раза'
  else
    Result := 'раз';
end;

end.

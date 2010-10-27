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
TArrayOfByte = array[-High(Word)..+High(Word)] of Byte;
PArrayOfSingle = ^TArrayOfSingle;
TArrayOfSingle = array[0..1] of Single;

PCrossChar = {$IFDEF FLAG_FPC}PAnsiChar{$ELSE}PWideChar{$ENDIF};

TStreamable = class;
CStreamable = class of TStreamable;

TProcOfObj = procedure of object;

TUtils = class
  class function GetTimer: Integer;
end;

// {{{ TStreamable
// Класс, предназначенный для сохранения и загрузки в файл
//
// 1.   У потомка нужно унаследовать метод Stream, который без параметров.
//      в нем нужно написать код, в котором перечисляются все поля для
//      стриминга, например
//      
//      Stream(FName);
//      Stream(FID);
//      Stream(@FPos, SizeOf(FPos));
//      Stream(TStreamable(FWeapon));
//    Вуаля, наш потомок автоматически умеет сохраняться/загружаться ;)
//
// 2.   Каждый класс, который будет загружаться, должен быть зарегистрирован
//      в Factory. Делается это так:
//
//      Factory.Regist(TWeapon);
//
//      В противном случае в лог выведется строка
//
//      !!! [TStreamableFactory.CreateStreamable] Class not found: TWeapon
//
//      Программа скорее всего свалится, но разработчик сможет внести
//      нужное изменение. :)
TStreamable = class(TObject)
private
  FLoading: Boolean;
  FData: TData;
protected
  procedure Stream(P: Pointer; Size: Integer); overload;
  procedure Stream(var I: Integer); overload;
  procedure Stream(var F: Float); overload;
  procedure Stream(var S: TString); overload;
  procedure Stream(var Obj: TStreamable); overload;
  procedure Stream(var Obj: CStreamable); overload;
  procedure Stream; overload; virtual;
  property Loading: Boolean read FLoading;
  property Data: TData read FData;
public
  constructor CreateFromStream(Data: TData);
  procedure Save(Data: TData); overload;
  procedure Load(Data: TData); overload;
  procedure Save(FileName: TString); overload;
  procedure Load(FileName: TString); overload;
  procedure Stream(Loading: Boolean; Data: TData); overload;
end;
//}}}

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

{$IFDEF FLAG_FPC}generic{$ENDIF} TList<TItem> = class(TObject)
 var private
  FItems: Array Of TItem;
{$IFDEF FLAG_FPC}
//type private
//  T = TItem;
{$ENDIF}
//private
  //function Compare{$IFNDEF FLAG_FPC}<T>{$ENDIF}(A, B: T): Boolean;
 public
  constructor Create;
  //function DefaultCompare(const A, B: TItem): Integer;
  procedure SetCount(NewCount: Integer); inline;
  function Last: Integer; inline;
  function GetCount: Integer; inline;
  procedure Add(Item: TItem);
  //procedure Del(Item: TItem; All: Boolean = True);
  function Find(Item: TItem): Integer;
  procedure ClearList;
  function GetItem(Index: Integer): TItem; inline;
  procedure SetItem(Index: Integer; Item: TItem); inline;
  property Items[Index: Integer]: TItem read GetItem write SetItem; default;
  property Count: Integer read GetCount write SetCount;
end;
TListOfInteger = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<Integer>;
TListOfTString = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TString>;
TListOfObject = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TObject>;

TListOfCStreamable = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<CStreamable>;
TStreamableFactory = class
private
  FClasses: TListOfCStreamable;
public
  constructor Create;
  destructor Destroy; override;
  procedure Regist(Streamable: CStreamable); inline;
  function GetClass(Name: TString): CStreamable;
  function CreateStreamable(Name: TString; Data: TData): TStreamable;
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

var
  Factory: TStreamableFactory;

function GetRaz(I: Integer): TString;

implementation

uses
  DDebug, DWinApi;

class function TUtils.GetTimer: Integer;
begin
  Result := DWinApi.GetTimer;
end;

//{{{ TStreamable
procedure TStreamable.Stream(P: Pointer; Size: Integer);//{{{
begin
  if FLoading then
    FData.ReadVar(P, Size)
  else
    FData.WriteVar(P, Size);
end;

//}}}
procedure TStreamable.Stream(var I: Integer);//{{{
begin
  Stream(@I, SizeOf(I));
end;

//}}}
procedure TStreamable.Stream(var F: Float);//{{{
begin
  Stream(@F, SizeOf(F));
end;

//}}}
procedure TStreamable.Stream(var S: TString);//{{{
begin
  if FLoading then
    S := FData.ReadStr
  else
    FData.WriteStr(S);
end; 

//}}}
procedure TStreamable.Stream(var Obj: TStreamable);//{{{
begin
  if FLoading then
    Obj := Factory.CreateStreamable(FData.ReadStr, FData)
  else begin
    FData.WriteStr(Obj.ClassName);
    Obj.Stream(FLoading, FData);
  end;
end;

//}}}
procedure TStreamable.Stream(var Obj: CStreamable);//{{{
begin
  if FLoading then
    Obj := Factory.GetClass(FData.ReadStr)
  else begin
    FData.WriteStr(Obj.ClassName);
  end;
end;
//}}}
procedure TStreamable.Stream;//{{{
begin
end;

//}}}
constructor TStreamable.CreateFromStream(Data: TData);//{{{
begin
  inherited;
  Load(Data);
end;

//}}}
procedure TStreamable.Save(Data: TData); //{{{
begin
  Stream(False, Data);
end;

//}}}
procedure TStreamable.Load(Data: TData);//{{{
begin
  Stream(True, Data);
end;

//}}}
procedure TStreamable.Save(FileName: TString);//{{{
  var
    Data: TData;
begin
  Data := TData.Create;
  Save(Data);
  Data.WriteToFile(FileName);
  Data.Free;
end;
//}}}
procedure TStreamable.Load(FileName: TString);//{{{
  var
    Data: TData;
begin
  Data := TData.Create(FileName);
  Load(Data);
  Data.Free;
end;
//}}}
procedure TStreamable.Stream(Loading: Boolean; Data: TData); //{{{
begin
  FLoading := Loading;
  FData := Data;
  Stream;
end;

//}}}

//}}}

//  generic TList//{{{
//
//function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Compare{$IFNDEF FLAG_FPC}<T>{$ENDIF}(A, B: T): Boolean;
//begin
//  Result := A = B;
//end;

constructor TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Create;
begin
  {  if @Compare = nil then
    FCompare := DefaultCompare
  else
    FCompare := Compare;}
end;

(*function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.DefaultCompare(const A, B: TItem): Integer;
  var
    I: Integer;
begin
  Result := 1;
  for I := 0 to SizeOf(TItem) - 1 do
    if PArrayOfByte(@A)^[I] <> PArrayOfByte(@B)^[I] then
      Exit;
  Result := 0;
end;*)

procedure TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.SetCount;
begin
  SetLength(FItems, NewCount);
end;

function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Last: Integer;
begin
  Result := High(FItems);
end;

function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.GetCount: Integer;
begin
  Result := Length(FItems);
end;

//{$DEFINE Length:=L}
//{$DEFINE High:=H}
//{$DEFINE SetLength:=S}
procedure TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Add(Item: TItem);
begin
  Count := Count + 1;
  FItems[Last] := Item;
end;

(*procedure TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Del(Item: TItem; All: Boolean = True);
  var
    I: Integer;
begin
  I := 0;
  Count := SizeOf(TItem);
  while I < Count do
    if FCompare(FItems[I], Item) = 0 then begin
      FItems[I] := FItems[Last];
      Count := Count - 1;
      if not All then
        Exit;
    end else
      Inc(I);
end;*)

function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.Find(Item: TItem): Integer;
  var
    I: Integer;
begin
  for I := 0 to Last do
    //if FItems[I] = Item then begin
      Result := I;
      Exit;
    //end;
  Result := -1;
end;

procedure TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.ClearList;
begin
  Count := 0;
end;

function TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.GetItem(Index: Integer): TItem;
begin
  Result := FItems[Index];
end;

procedure TList{$IFNDEF FLAG_FPC}<TItem>{$ENDIF}.SetItem(Index: Integer; Item: TItem);
begin
  FItems[Index] := Item;
end;

//{$UNDEF Length}
//{$UNDEF High}
//{$UNDEF SetLength}
//}}}
// TStreamableFactory//{{{
constructor TStreamableFactory.Create;
begin
  FClasses := TListOfCStreamable.Create;
end;

destructor TStreamableFactory.Destroy;
begin
  FClasses.Free;
end;

procedure TStreamableFactory.Regist; 
begin
  FClasses.Add(Streamable);
end;

function TStreamableFactory.GetClass;
  var
    I: Integer;
begin
  for I := 0 to FClasses.Last do
    if FClasses[I].ClassName = Name then begin
      Result := FClasses[I];
      Exit;
    end;
  SDebug.Log('!!! [TStreamableFactory.GetClass] Class not found: ' + Name);
  Result := nil;
end;

function TStreamableFactory.CreateStreamable;
  var
    I: Integer;
begin
  for I := 0 to FClasses.Last do
    if FClasses[I].ClassName = Name then begin
      Result := FClasses[I].CreateFromStream(Data);
      Exit;
    end;
  SDebug.Log('!!! [TStreamableFactory.CreateStreamable] Class not found: ' + Name);
  Result := nil;
end;

//}}}
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

initialization
  Factory := TStreamableFactory.Create;
finalization
  Factory.Free;
end.

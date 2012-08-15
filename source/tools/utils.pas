{$IFDEF LINUX} {$DEFINE LINUX_or_BSD} {$ENDIF}
{$IFDEF BSD} {$DEFINE LINUX_or_BSD} {$ENDIF}
unit utils;

interface

uses
  SysUtils;

Type
  TString = String;
  TArrayOfString = Array Of TString;

Function DeleteLeftSpaces(S: TString): TString;
Function DeleteRightSpaces(S: TString): TString;
Function TStringDeletePre(S: TString; Count: Integer): TString;
Function TStringDeletePost(S: TString; Start: Integer): TString;
function Trim(const S: TString): TString;

// S = List[0] B List[1] B ... B List[n-1]
Procedure ParseList(S: TString; B: TString; Var List: TArrayOfString);
// S = LBR
Function ParseBinary(S, B: TString; Var L, R: TString): Boolean;
// заменяет первое вхождение T на W
function ParseFormat(const S, T, W: TString): TString;

// Проверяет удволетворяет ли строка S паттерну P
// Допустимые спецсимволы в P:
//   * любая последовательность символов
//   ? любой одиночный символ
//   ~ строка не должна удволетворять тому, что дальше.
//     Может стоять только первым символом строки или сразу после |
//   & для перечичления нескольких обязательных паттернов
//   | для перечисления нескольких паттернов
//   \ экранирует последующий символ
//
//  Примеры:
//  MatchPattern('My Sector is the best!', '*Sector*') = True
//  MatchPattern('This is one symbol: 5 isn''t it?', '*symbol: ? isn''t it\?') = True
//  MatchPattern('Hard string', 'Hard string|Simple string') = True
//  MatchPattern('Simple string', 'Hard string|Simple string') = True
function MatchPattern(const S, P{attern}: String): Boolean;
function IsTrivialPattern(P{attern}: String): Boolean;

function RemoveExtension(const FileName: String): String;
function ChangeExtension(const FileName, Ext: String): String;
function ExtractExtension(const FileName: String): String;

function ChangeSub(const S, Sub, NewSub: String): String;

type
  TOnFile = procedure (const Folder: String; const Search: TSearchRec);

procedure ProcessFiles(Folder: String; 
                       Recursive: Boolean; 
                       OnFile: TOnFile);

function memncmp(P1, P2: PChar; N: Integer): Integer;
function memnfill(P: PChar; N: Integer; B: Byte): Integer;

implementation

uses
  {$IFDEF WIN32}windows{$ENDIF} {$IFDEF UNIX}unix, BaseUnix{$ENDIF};

Function DeleteLeftSpaces(S: TString): TString;
begin
  Result := S;
    While (Length(Result) > 0) And (Result[1] in [#0..#32]) do
      Delete(Result, 1, 1);
end;

Function DeleteRightSpaces(S: TString): TString;
begin
  Result := S;
    While (Length(Result) > 0) And (Result[Length(Result)] in [#0..#32]) do
      Delete(Result, Length(Result), 1);
end;

Function TStringDeletePre(S: TString; Count: Integer): TString;
begin
  Result := S;
    If Count = 0 then
      Exit;
  Delete(Result, 1, Count);
end;

Function TStringDeletePost(S: TString; Start: Integer): TString;
begin
  Result := S;
    If Start = 0 then
      Exit;
  Delete(Result, Start, Length(Result) - Start + 1);
end;

function Trim(const S: TString): TString;
begin
  Result := DeleteLeftSpaces(DeleteRightSpaces(S));
end;

Procedure ParseList(S: TString; B: TString; Var List: TArrayOfString);
begin
  SetLength(List, 1);
    While Pos(B, S) <> 0 do begin
      //List[High(List)] := TStringDeletePost(S, Pos(B, S));
      //S := TStringDeletePre(S, Pos(B, S) + Length(B) - 1);
      //SetLength(List, Length(List) + 1);
      ParseBinary(S, B, List[High(List)], S);
      SetLength(List, Length(List) + 1);
    end;
  List[High(List)] := S;
end;

Function ParseBinary;
begin
  Result := Pos(B, S) <> 0;
  L := TStringDeletePost(S, Pos(B, S));
  R := TStringDeletePre(S, Pos(B, S) + Length(B) - 1);
end;

function ParseFormat(const S, T, W: TString): TString;
  var
    P, RightPart: Integer;
begin
  Result := S;
  P := Pos(T, S);
  if P = 0 then
    Exit;
  RightPart := P + Length(T);
  Result := Copy(S, 1, P - 1) + W + 
            Copy(S, RightPart, Length(S) - RightPart + 1);
end;

function MatchPattern;
    // Обрабатывает паттерны, содержащие *, ? и \
    function MatchStarPattern(const S, P{attern}: String): Boolean;
      var
        I, J: Integer;
        // DOJ: функцию MatchPart можно было бы сделать рекурсивной,
        // но тогда при нескольких * есть риск того, что будет считаться куча
        // лишней инфы, и функция будет работать долго. При динамической
        // реализации получаем время O(Length(S) * Length(P)) всегда
        Table: array of array of Boolean;
          // Удволитворяет ли Copy(S, SIndex, Length(SIndex) - SIndex + 1)
          // паттерну Copy(P, PIndex, Length(PIndex) - PIndex + 1)
          function MatchPart(SIndex, PIndex: Integer): Boolean;
          begin
            // рассматриваем тривиальные варианты
            if (Length(P) < PIndex) and (Length(S) < SIndex) then
              Result := True
            else if (Length(P) = PIndex) and (P[PIndex] = '*') then
              Result := True
            else if (Length(S) < SIndex)  and (Length(P) >= PIndex) then
              Result := False
            else if (Length(S) >= SIndex) and (Length(P) < PIndex) then
              Result := False
            // ? может задавать любой символ
            else if P[PIndex] = '?' then
              Result := Table[SIndex + 1][PIndex + 1]
            // * может задавать любую последовательность символов
            else if P[PIndex] = '*' then begin
              Result := Table[SIndex][PIndex + 1];
              if not Result then
                Result := Table[SIndex + 1][PIndex];
            // экранируем символ
            {end else if P[PIndex] = '\' then begin
              if PIndex + 1 > Length(P) then
                Result := False
              else
                Result := (S[SIndex] = P[PIndex + 1]) and Table[SIndex + 1][PIndex + 2]}
            // иначе сравниваем побуквенно
            end else
              Result := (S[SIndex] = P[PIndex]) and Table[SIndex + 1][PIndex + 1];
          end;
    begin
      SetLength(Table, Length(S) + 2, Length(P) + 2);
      for I := High(Table) downto 1 do
        for J := High(Table[I]) downto 1 do
          Table[I][J] := MatchPart(I, J);
      Result := Table[1][1];
    end;
  var
    I, J: Integer;
    AndChunks, OrChunks: TArrayOfString;
    OrResult: Boolean;
begin
  // при помощи & можно задавать несколько вариантов
  ParseList(P, '&', AndChunks);
  for I := 0 to High(AndChunks) do begin
    ParseList(AndChunks[I], '|', OrChunks);
    for J := 0 to High(OrChunks) do begin
      //if MatchStarPattern(OrChunks[J], '~*') then
      //  OrResult := not MatchStarPattern(S, Copy(OrChunks[J], 2, Length(OrChunks[J]) - 1))
      //else
        OrResult := MatchStarPattern(S, OrChunks[J]);
      if OrResult then
        Break;
    end;
    Result := OrResult;
    if not Result then
      Exit;
  end;
  Result := True;
end;

function IsTrivialPattern(P{attern}: String): Boolean;
begin
  Result := (Pos('&', P) = 0) and
            (Pos('*', P) = 0) and
            (Pos('|', P) = 0) and
            (Pos('?', P) = 0);
end;

procedure SplitExtension(const FileName: String; out Without, Ext: String);
var
  I: Integer;
begin
  Without := FileName;
  Ext := '';
  I := Length(Without);
  while I > 0 do
    if Without[I] in ['\', '/'] then
      Exit
    else if Without[I] = '.' then begin
      Ext := Copy(Without, I+1, Length(Without) - 1);
      Delete(Without, I, Length(Without) - I + 1);
      Exit;
    end else
      Dec(I);
end;

function RemoveExtension(const FileName: String): String;
var
  Temp: String;
begin
  SplitExtension(FileName, Result, Temp);
end;

function ChangeExtension(const FileName, Ext: String): String;
begin
  Result := RemoveExtension(FileName) + Ext;
end;

function ExtractExtension(const FileName: String): String;
var
  Temp: String;
begin
  SplitExtension(FileName, Temp, Result);
end;

function ChangeSub(const S, Sub, NewSub: String): String;
var
  P: Integer;
begin
  Result := S;
  P := Pos(Sub, S);
  while P <> 0 do begin
    Result := Copy(Result, 1, P - 1) + NewSub + 
              Copy(Result, P + 2, Length(Result) - P - 1);
    P := Pos(Sub, Result);
  end;
end;

{procedure ProcessFiles;
var
  Search: TSearchRec;
begin
  //if Folder[Length(Folder)] <> '\' then
  //  Folder := Folder + '\';
  Folder := ExtractFilePath(Folder);
  Writeln('Folder = ', Folder);
  if FindFirst(Folder, faAnyFile, Search) <> 0 then
    Exit;
  //FindFirst(Folder, faAnyFile and faDirectory, Search);
  Writeln('FoundFirst ', Folder);
  repeat
    if (Search.Name = '.\') or (Search.Name = '..\') then begin
    end else if (Search.Attr and faDirectory) = faDirectory then begin
      if Recursive then
        ProcessFiles(Folder + Search.Name, True, OnFile);
    end else //if (Search.Attr and faAnyFile) = faAnyFile then
      OnFile(Search);
  until FindNext(Search) <> 0;
  FindClose(Search);
end;}

{$IFDEF WIN32}
procedure ProcessFiles;
var
  Search: TSearchRec;
  fd: TWin32FindData;
  fh: THandle;
begin
  fh := FindFirstFile(PAnsiChar(Folder + '*'), @fd);
  if fh = INVALID_HANDLE_VALUE then
    Exit;
  repeat
    if fd.cFileName[0] <> '.' then
      if fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0 then begin
        if Recursive then
          ProcessFiles(Folder + fd.cFileName + '\', True, OnFile);
      end else begin
        Search.Name := fd.cFileName;
        OnFile(Folder, Search);
      end;
  until not FindNextFile(fh, @fd);
  FindClose(fh);
end;
{$ENDIF}
{$IFDEF LINUX_or_BSD}
procedure ProcessFiles;
var
  Search: TSearchRec;
  Dir: PDir;
  Entry: PDirEnt;
begin
  Dir := FpOpenDir(Folder);
  repeat 
    Entry := FpReadDir(Dir^);
    if (Entry <> nil) then begin
            // Writeln('Entry: "', PChar(@Entry^.d_name[0]), '" ', Entry^.d_type);
            Search.Name := PChar(@Entry^.d_name[0]);
            OnFile(Folder, Search);
    end;
  until Entry = nil;
end;
{$ENDIF}

function memncmp(P1, P2: PChar; N: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to N - 1 do
    if P1[I] < P2[I] then begin
      Result := -1;
      Exit;
    end else if P1[I] > P2[I] then begin
      Result := 1;
      Exit;
    end;
  Result := 0;
end;

function memnfill(P: PChar; N: Integer; B: Byte): Integer;
var
  I: Integer;
begin
  for I := 0 to N - 1 do
    P[I] := Char(B);
end;

end.

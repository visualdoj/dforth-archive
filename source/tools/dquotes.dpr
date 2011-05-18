uses
  SysUtils,
  utils;

const
  APO = $27; // symbol ' APOstrophe
  QUO = $22; // symbol " QUOte
  ITA = $60; // symbol ` ITAlic
             // symbol & AMPersand

var
  Table: array[Byte] of Byte;
  Recursively: Boolean;
  Folder: String;
  Src, Dst: record
    Name: String;
    Defined: Boolean;
  end;

procedure InitDefault;
var
  I: Byte;
begin
  for I := Low(Table) to High(Table) do
    Table[I] := I;
  Table[QUO] := APO;
  Recursively := False;
  Src.Name := '';
  Src.Defined := False;
  Dst.Name := '';
  Dst.Defined := False;
  Folder := '.\';
end;

procedure PrintAbout;
begin
  Writeln('Char converter (c) 2011 Doj');
end;

procedure PrintHelp;
begin
  Writeln('Usage: dquotes [options] [src] [options] [dst] [options]');
  Writeln('  src: source filename (default: stdin)');
  Writeln('  dst: destination filename (default: stdout)');
  Writeln('  options:');
  Writeln('    -h, --help');
  Writeln('           show this help and exit');
  Writeln('    -hc, --help-common');
  Writeln('           show options for common conversions');
  Writeln('    -u, --usage');
  Writeln('           show usage and exit');
  Writeln('    -i, --ignore');
  Writeln('           this option ignores');
  Writeln('    -r, --recursively  folder');
  Writeln('           recursively process files in folder');
  Writeln('    -2, --convert  XX YY');
  Writeln('           convert char with hex code XX to char with hex code YY');
end;

procedure PrintCommonConversions;
begin
  Writeln('  some simple options for common conversions:');
  Writeln('    -qq              " -> "  ');
  Writeln('    -aq              '' -> "  (default)');
  Writeln('    -qa              " -> ''');
  Writeln('    -iq              ` -> "');
  Writeln('    -qi              " -> `');
  Writeln('    -ai              '' -> `');
  Writeln('    -ia              ` -> ''');
end;

procedure PrintUsage;
begin
  Writeln('dquotes');
  Writeln('  print help');
  Writeln('dquotes -i');
  Writeln('  convert all " to '' in stdin and write result to stdout');
  Writeln('dquotes file.in file.out');
  Writeln('  convert all " in file.in and write result to file.out');
  Writeln('dquotes -qq -ai');
  Writeln('  convert all '' to ` in stdin and write result to stdout');
  Writeln('dquotes -qq -2 26 5e');
  Writeln('  convert all & to ^ in stdin and write result to stdout');
  Writeln('dquotes -r .');
  Writeln('  recursively convert all');
end;

function Opt(var Index: Integer; 
             const Short, Full: String): Boolean;
begin
  Result := ((ParamStr(Index) = Short) and (Short <> '')) or
            ((ParamStr(Index) = Full)  and (Full  <> ''));
  Inc(Index, Ord(Result));
end;

function Opt1(var Index: Integer; 
              const Short, Full: String; 
              var Param: String): Boolean;
begin
  if Index = ParamCount then
    Result := False
  else begin
    Result := Opt(Index, Short, Full);
    if Result then begin
      Param := ParamStr(Index);
      Inc(Index);
    end;
  end;
end;

function Opt2(var Index: Integer; 
              const Short, Full: String; 
              var Param1, Param2: String): Boolean;
begin
  if Index >= ParamCount - 1 then
    Result := False
  else
    if Opt1(Index, Short, Full, Param1) then begin
      Result := True;
      Param2 := ParamStr(Index);
      Inc(Index);
    end else
      Result := False;
end;

type TProc = procedure;
function Action(var Index: Integer; 
                Short, Full: String; 
                Proc: TProc): Boolean;
begin
  Result := Opt(Index, Short, Full);
  if Result then
    Proc;
end;

function MagicTable(var Index: Integer; const Magic: String; X, Y: Byte): Boolean;
begin
  Result := Opt(Index, Magic, '');
  if Result then
    Table[X] := Y;
end;

function IsHexDigit(C: Char; out Digit: Byte): Boolean;
begin
  Result := True;
  if C in ['0'..'9'] then begin
    Digit := Ord(C) - Ord('0');
  end else if C in ['a'..'f'] then begin
    Digit := 10 + Ord(C) - Ord('a');
  end else if C in ['A'..'F'] then begin
    Digit := 10 + Ord(C) - Ord('A');
  end else
    Result := False;
end;

function IsHexByte(X: String; out H: Byte): Boolean;
var
  D1, D2: Byte;
begin
  if Length(X) <> 2 then
    Result := False
  else
    if IsHexDigit(X[1], D1) and IsHexDigit(X[2], D2) then begin
      H := (D1 shl 4) + D2;
      Result := True;
    end else
      Result := False;
end;

function ReadParameters: Boolean;
var
  I: Integer;
  Param1, Param2: String;
  X, Y: Byte;
begin
  Result := False;
  if ParamCount = 0 then begin
    PrintAbout;
    PrintHelp;
    Exit;
  end;
  I := 1;
  while I <= ParamCount do begin
    if Action(I, '-h', '--help', PrintHelp) then Exit;
    if Action(I, '-u', '--usage', PrintUsage) then Exit;
    if Action(I, '-hc', '--help-common', PrintCommonConversions) then Exit;
    if Opt(I, '-i', '--ignore') then continue;
    if Opt1(I, '-r', '--recursively', Folder) then begin 
      Recursively := True;
      continue;
    end;
    if MagicTable(I, '-qa', QUO, APO) then continue;
    if MagicTable(I, '-aq', APO, QUO) then continue;
    if MagicTable(I, '-qi', QUO, ITA) then continue;
    if MagicTable(I, '-iq', ITA, QUO) then continue;
    if MagicTable(I, '-ai', APO, ITA) then continue;
    if MagicTable(I, '-ia', ITA, APO) then continue;
    if Opt2(I, '-2', '--convert', Param1, Param2) then begin
      if IsHexByte(Param1, X) and IsHexByte(Param2, Y) then begin
        Writeln(Char(X), ' -> ', Char(Y));
        Table[X] := Y;
        continue;
      end else begin
        Writeln('error: incorrect parameters, both must be hex integers with ' +
                'two digits');
        Exit;
      end;
    end;
    if Pos('-', ParamStr(I)) = 1 then begin
      Writeln('error: unknown parameter "', ParamStr(I), '"');
      Exit;
    end;
    if not Src.Defined then begin
      Src.Name := ParamStr(I);
      Src.Defined := True;
      Inc(I);
      continue;
    end;
    if not Dst.Defined then begin
      Dst.Name := ParamStr(I);
      Dst.Defined := True;
      Inc(I);
      continue;
    end;
    Writeln('error: unknown parameter "', ParamStr(I), '"');
    Exit;
  end;
  Result := True;
end;

procedure ConvertFile(const Src, Dst: String);
var
  SrcFile, DstFile: File of Byte;
  Buffer: array of Byte;
  I: Integer;
begin
  Assign(SrcFile, Src);
  {$I-} Reset(SrcFile); {$I+}
  if IOResult <> 0 then begin
    Writeln('Cant open src file "', Src, '"');
    Exit;
  end;

  SetLength(Buffer, filesize(SrcFile));
  BlockRead(SrcFile, Buffer[0], Length(Buffer));
  for I := 0 to High(Buffer) do
    Buffer[I] := Table[Buffer[I]];

  Close(SrcFile);

  Assign(DstFile, Dst);
  {$I-} Rewrite(DstFile); {$I+}
  if IOResult <> 0 then begin
    Writeln('Cant open dst file "', Dst, '"');
    Exit;
  end;

  BlockWrite(DstFile, Buffer[0], Length(Buffer));

  Close(DstFile);
end;

procedure OnFile(const Folder: String; const Search: TSearchRec);
var
  FileName: String;
begin
  if MatchPattern(Search.Name, Src.Name) then begin
    FileName := Folder + Search.Name;
    if Dst.Defined then begin
      if Dst.Name[1] = '*' then
        ConvertFile(FileName, ChangeExtension(FileName, 
                                  Copy(Dst.Name, 2, Length(Dst.Name)-1)))
      else
        ConvertFile(FileName, Dst.Name);
    end else
      ConvertFile(FileName, '');
    //Writeln(Search.Name);
  end;
end;

begin
  InitDefault;
  if ReadParameters then
    if Recursively then begin
      ProcessFiles(Folder, True, OnFile);
    end else if IsTrivialPattern(Src.Name) then begin
      ConvertFile(Src.Name, Dst.Name);
    end else begin
      ProcessFiles(Folder, False, OnFile);
    end;
end.

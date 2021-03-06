


















unit DCommandsStrings;

interface





uses
  {$I units.inc},

  strings,

  DForthMachine;

  procedure pchar_alloc(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_free(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_len(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_concat(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_equel(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure run_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure run_pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_dot(Machine: TForthMachine; Command: PForthCommand);

  procedure _char(Machine: TForthMachine; Command: PForthCommand);
  procedure _compile_char(Machine: TForthMachine; Command: PForthCommand);

  // �������� ������� ��� �������� ����������
  procedure str_push(Machine: TForthMachine; const B: TString); overload;
  procedure str_push(Machine: TForthMachine; B: TStr); overload;
  function str_pop(Machine: TForthMachine): TStr;
  function str_top(Machine: TForthMachine): TStr; overload;
  function str_top(Machine: TForthMachine; Index: Integer): TStr; overload;

  procedure str_drop(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dup(Machine: TForthMachine; Command: PForthCommand);
  procedure str_over(Machine: TForthMachine; Command: PForthCommand);

  procedure str_nil(Machine: TForthMachine; Command: PForthCommand);
  procedure str_len(Machine: TForthMachine; Command: PForthCommand);
  procedure str_width(Machine: TForthMachine; Command: PForthCommand);
  procedure str_concat(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dog(Machine: TForthMachine; Command: PForthCommand);
  procedure str_exclamation(Machine: TForthMachine; Command: PForthCommand);
  procedure str_symbol_dog(Machine: TForthMachine; Command: PForthCommand);
  procedure str_symbol_exclamation(Machine: TForthMachine; Command: PForthCommand);
  procedure str_new(Machine: TForthMachine; Command: PForthCommand);
  procedure str_equel(Machine: TForthMachine; Command: PForthCommand);
  procedure str_pos(Machine: TForthMachine; Command: PForthCommand);
  procedure str_pos_ask(Machine: TForthMachine; Command: PForthCommand);
  procedure str_minus(Machine: TForthMachine; Command: PForthCommand);
  procedure str_replace(Machine: TForthMachine; Command: PForthCommand);
  procedure str_ins(Machine: TForthMachine; Command: PForthCommand);
  procedure str_del(Machine: TForthMachine; Command: PForthCommand);
  procedure str_cut(Machine: TForthMachine; Command: PForthCommand);
  procedure str_split(Machine: TForthMachine; Command: PForthCommand);
  procedure str_sub(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure run_str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure _str_literal(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dollar(Machine: TForthMachine; Command: PForthCommand);
  // procedure str_new(Machine: TForthMachine; Command: PForthCommand);
  procedure str_index_dog(Machine: TForthMachine; Command: PForthCommand);
  procedure str_index_exclamation(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_to_str(Machine: TForthMachine; Command: PForthCommand);
  procedure Format(Machine: TForthMachine; Command: PForthCommand);

  // ������� ������ � �����
  procedure AddRef(B: TStr);
  procedure DelRef(B: TStr);

  function CreateStr(Width, Len: Integer): TStr; overload;
  function CreateStr(const S: TString): TStr; overload;
  function StrSymbol(S: TStr; Index: Integer): Cardinal;
  function char4to1(C: Cardinal): Byte;
  function char4to2(C: Cardinal): Byte;
  function char2to1(C: Word): Byte;
  procedure MoveChars(Dst, Src: Pointer; Len, DSize, SSize: Integer);
  procedure SetStrSymbol(S: TStr; Index: Integer; C: Cardinal);
  function StrToString(S: TStr): TString;

  function CreatePChar(const S: TString): PAnsiChar; overload;
  function CreatePChar(const P: PAnsiChar): PAnsiChar; overload;

  procedure _poststr (Machine: TForthMachine; Command: PForthCommand);
  procedure _postname (Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

procedure pchar_alloc(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
  Size: Integer;
begin
  with Machine^ do begin
    Size := Machine.WOI;
    GetMem(P, Size + 1);
    Machine.WUP(P);
  end;
end;

procedure pchar_free(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    P := Machine.WOP;
    FreeMem(P);
  end;
end;

procedure pchar_len(Machine: TForthMachine; Command: PForthCommand);
var
  P: PByte;
  L: Integer;
begin
  //with Machine^ do begin
    P := Machine.WOP;
    L := strlen(PChar(P));
    Machine.WUI(L);
 // end;
end;

procedure pchar_concat(Machine: TForthMachine; Command: PForthCommand);
var
  S1, S2, D: PChar;
begin
  with Machine^ do begin
    S2 := Machine.WOP;
    S1 := Machine.WOP;
    D := StrAlloc(StrLen(S1) + StrLen(S2) + 1);
    Move(S1^, D^, StrLen(S1));
    Move(S2^, (@(PArrayOfByte(D)^[StrLen(S1)]))^, StrLen(S2));
    D[StrLen(S1) + StrLen(S2)] := #0;
    Machine.WUP(D);
  end;
end;

procedure pchar_equel(Machine: TForthMachine; Command: PForthCommand);
var
  S1, S2: PChar;
begin
  with Machine^ do begin
    S1 := Machine.WOP;
    S2 := Machine.WOP;
    if StrComp(S1, S2) = 0 then
      Machine.WUI(BOOL_TRUE)
    else
      Machine.WUI(BOOL_FALSE)
  end;
end;

procedure pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
begin
 // with Machine^ do begin
    if Machine.State = FS_COMPILE then begin
      compile_pchar_dq(Machine, Command);
    end else begin
      SetLength(Machine.FPChars, Length(Machine.FPChars) + 1);
      SetLength(Machine.FPChars[High(Machine.FPChars)], 0); 
      C := Machine.NextChar;
      while C <> Char(34) do begin
        SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + 1); 
        Machine.FPChars[High(Machine.FPChars)][High(Machine.FPChars[High(Machine.FPChars)])] := C; 
        C := Machine.NextChar;
      end; 
      SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + 1); 
      Machine.FPChars[High(Machine.FPChars)][High(Machine.FPChars[High(Machine.FPChars)])] := #0; 
      Machine.WUP(Machine.FPChars[High(Machine.FPChars)]);
    end;
 // end;
end;

procedure compile_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
begin
 // with Machine^ do begin
    Machine.BuiltinEWO('(pchar)' + Char(34));
    C := Machine.NextChar;
    while C <> Char(34) do begin
      Machine.EWC(C);
      C := Machine.NextChar;
    end;
    C := #0;
    Machine.EWC(C);
 // end;
end;

procedure run_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
 // with Machine^ do begin
    P := @Machine.E[Machine.EC];
    Machine.WUP(P);
    while Machine.E[Machine.EC] <> 0 do
      Inc(Machine.EC);
    Inc(Machine.EC);
 // end;
end;

procedure pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: WideChar;
begin
    (* if Machine.State = FS_COMPILE then begin *)
    (*   compile_pwidechar_dq(Machine, Command); *)
    (* end else begin *)
      SetLength(Machine.FPChars, Length(Machine.FPChars) + 1);
      SetLength(Machine.FPChars[High(Machine.FPChars)], 0); 
      C := WideChar(Machine.NextChar);
      while C <> Char(34) do begin
        SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + SizeOf(C)); 
        Move(C, Machine.FPChars[High(Machine.FPChars)][Length(Machine.FPChars[High(Machine.FPChars)]) - SizeOf(C)], SizeOf(C)); 
        C := WideChar(Machine.NextChar);
      end; 
      SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + SizeOf(C)); 
      C := #0;
      Move(C, Machine.FPChars[High(Machine.FPChars)][Length(Machine.FPChars[High(Machine.FPChars)]) - SizeOf(C)], SizeOf(C)); 
      Machine.WUP(Machine.FPChars[High(Machine.FPChars)]);
    //end;
end;

procedure compile_pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: WideChar;
begin
 // with Machine^ do begin
    Machine.BuiltinEWO('(pwidechar)' + Char(34));
    C := WideChar(Machine.NextChar);
    while C <> Char(34) do begin
      Machine.EWV(@C, SizeOf(C));
      C := WideChar(Machine.NextChar);
    end;
    C := #0;
    Machine.EWV(@C, SizeOf(C));
end;

procedure run_pwidechar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
    P := @Machine.E[Machine.EC];
    Machine.WUP(P);
    while WideChar((@Machine.E[Machine.EC])^) <> #0 do
      Inc(Machine.EC, SizeOf(WideChar));
    Inc(Machine.EC, SizeOf(WideChar));
end;

procedure pchar_dot(Machine: TForthMachine; Command: PForthCommand);
var
  B: PChar;
begin
  B := Machine.WOP;
  Write(B);
end;

function CreateStr(Width, Len: Integer): TStr; overload;
begin
  //Writeln('CREATEING STRING ', Len);
  GetMem(Result, SizeOf(Integer)*3 + Len*Width + 1);
  PStrRec(Result)^.Ref := 0;
  PStrRec(Result)^.Len := Len;
  PStrRec(Result)^.Width := Width;
  PStrRec(Result)^.Sym[Len*Width] := 0;
end;

function CreateStr(const S: TString): TStr; overload;
begin
  Result := CreateStr(1, Length(S));
  Move(S[1], PStrRec(Result)^.Sym[0], Length(S));
end;

function CreateStr(const S: TStr): TStr; overload;
begin
  Result := CreateStr(S^.Width, S^.Len);
  Move(S^.Sym[0], PStrRec(Result)^.Sym[0], S^.Width * S^.Len);
end;

function StrSymbol(S: TStr; Index: Integer): Cardinal;
begin
  case S^.Width of
    0: Result := 0;
    1: Result := S^.Sym[Index];
    2: Result := Word(Pointer(@S^.Sym[2*Index])^);
    4: Result := PArrayOfCardinal(@S^.Sym[0])^[Index];
  else
    Result := 0;
  end;
end;

function char4to1(C: Cardinal): Byte;
begin
  if C > 255 then
    Result := Ord('?')
  else
    Result := C;
end;

function char4to2(C: Cardinal): Byte;
begin
  if C > 256*256 - 1 then
    Result := Ord('?')
  else
    Result := C;
end;

function char2to1(C: Word): Byte;
begin
  if C > 256 - 1 then
    Result := Ord('?')
  else
    Result := C;
end;

procedure MoveChars(Dst, Src: Pointer; Len, DSize, SSize: Integer);
var
  I: Integer;
begin
  // Writeln(Char(Byte(Src^)));
  // Writeln(Char(TArrayOfByte(Src^)[0]));
  // Writeln(Char(PArrayOfByte(Src)^[0]));
  if SSize = DSize then
    Move(Src^, Dst^, Len*SSize)
  else if DSize = 4 then begin
    //FillChar(Dst^, Len*4, 0);
    if SSize = 1 then begin
      for I := 0 to Len - 1 do begin
        // Write(Char(PArrayOfByte(Src)^[I]));
        PArrayOfCardinal(Dst)^[I] := PArrayOfByte(Src)^[I];
      end;
      // Writeln;
    end else begin
      for I := 0 to Len - 1 do
        PArrayOfCardinal(Dst)^[I] := PArrayOfWord(Src)^[I];
    end;
  end else if DSize = 1 then begin
    if SSize = 4 then begin
      for I := 0 to Len - 1 do
        PArrayOfByte(Dst)^[I] := char4to1(PArrayOfCardinal(Src)^[I]);
    end else begin
      for I := 0 to Len - 1 do
        PArrayOfByte(Dst)^[I] := char2to1(PArrayOfWord(Src)^[I]);
    end;
  end else begin {DSize = 2}
    if SSize = 4 then begin
      for I := 0 to Len - 1 do
        PArrayOfWord(Dst)^[I] := char4to2(PArrayOfCardinal(Src)^[I]);
    end else begin
      //FillChar(Dst^, Len*2, 0);
      for I := 0 to Len - 1 do
        PArrayOfWord(Dst)^[I] := PArrayOfByte(Src)^[I];
    end;
  end;
end;

procedure SetStrSymbol(S: TStr; Index: Integer; C: Cardinal);
begin
  case S^.Width of
    1: S^.Sym[Index] := char4to1(C);
    2: Word(Pointer(@S^.Sym[2*Index])^) := char4to2(C);
    4: Cardinal(Pointer(@S^.Sym[4*Index])^) := C;
  end;
end;

function StrToString(S: TStr): TString;
var
  I: Integer;
begin
  if S = nil then begin
    Result := '';
    Exit;
  end;
  // Writeln('StrToString: ref=', S^.Ref, ' len=', S^.Len);
  SetLength(Result, S^.Len);
  case S^.Width of
    1: Move(S^.Sym[0], Result[1], S^.Len);
    2: for I := 0 to S^.Len do 
         Result[I] := Char(char2to1(Word(Pointer(@S^.Sym[I*2])^)));
    4: for I := 0 to S^.Len do 
         Result[I] := Char(char4to1(Word(Pointer(@S^.Sym[I*4])^)));
  end;
end;

function CreatePChar(const S: TString): PAnsiChar;
begin
  Result := StrAlloc(Length(S)+1);
  StrLCopy(Result, @S[1], Length(S));
end;

function CreatePChar(const P: PAnsiChar): PAnsiChar;
begin
  Result := StrAlloc(StrLen(P)+1);
  StrCopy(Result, P);
end;

procedure AddRef(B: TStr);
begin
  if B = nil then 
    Exit;
  Inc(PStrRec(B)^.Ref);
  //Machine.FMemoryDebug.Log(ToStr([' + str' ', PChar(@B^.Sym[0]), '' ', B^.Ref]));
end;

procedure DelRef(B: TStr);
begin
  if B = nil then 
    Exit;
  //Dec(PStrRec(B)^.Ref);
  if PStrRec(B)^.Ref < 1 then begin
    // Writeln('Free string '', PChar(@(PStrRec(B)^.Sym[0])), ''');
    FreeMem(B);
    //Machine.FMemoryDebug.Log(ToStr([' - str' ', PChar(@B^.Sym[0]), '' (free)']));
  end;// else
    //Machine.FMemoryDebug.Log(ToStr([' - str' ', PChar(@B^.Sym[0]), '' ', B^.Ref]));
end;

procedure _char(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(Ord(Machine.SNC));
end;

procedure _compile_char(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.BuiltinEWO('(literal)');
  Machine.EWI(Ord(Machine.SNC));
end;

procedure str_push(Machine: TForthMachine; const B: TString);
var
  FS: TStr;
begin
  FS := CreateStr(1, Length(B));
  Move(B[1], FS.Sym[0], Length(B));
  str_push(Machine, FS);
end;

procedure str_push(Machine: TForthMachine; B: TStr);
begin
  AddRef(B);
  Machine.BWU(B);
end;

function str_pop(Machine: TForthMachine): TStr;
begin
  Result := Machine.BWO;
end;

function str_top(Machine: TForthMachine): TStr;
begin
  Result := TStr(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^));
end;

function str_top(Machine: TForthMachine; Index: Integer): TStr;
begin
  Result := TStr(TBlock(Pointer(TUInt(Machine.BWP) + (-Index)*(SizeOf(Pointer)))^));
end;

procedure str_drop(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    DelRef(str_pop(Machine));
  end;
end;

procedure str_dup(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
  with Machine^ do begin
    B := str_pop(Machine);
    str_push(Machine, B);
    str_push(Machine, B);
    DelRef(B);
  end;
end;

procedure str_over(Machine: TForthMachine; Command: PForthCommand);
var
  A, B: TStr;
begin
  with Machine^ do begin
    B := str_pop(Machine);
    A := str_pop(Machine);
    str_push(Machine, A);
    str_push(Machine, B);
    str_push(Machine, A);
    DelRef(A);
    DelRef(B);
  end;
end;


procedure str_len(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
  with Machine^ do begin
    B := str_top(Machine);
    Machine.WUI(PStrRec(B)^.Len);
  end;
end;

procedure str_width(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(str_top(Machine)^.Width);
end;

procedure str_pos(Machine: TForthMachine; Command: PForthCommand);
label
  _continue;
var
  X, S: TStr;
  I, J: Integer;
begin
  X := str_top(Machine, 2);
  S := str_top(Machine, 1);
  for I := 0 to X^.Len - 1 do begin
    for J := 0 to S^.Len - 1 do
      if StrSymbol(X, I+J) <> StrSymbol(S, J) then
        goto _continue;
    Machine.WUI(I);
    Exit;
  _continue:
  end;
  Machine.WUI(-1);
end;

procedure str_pos_ask(Machine: TForthMachine; Command: PForthCommand);
begin
  str_pos(Machine, Command);
  if Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Integer)))^)) = -1 then
    Machine.WUI(BOOL_FALSE)
  else
    Machine.WUI(BOOL_TRUE);
end;

procedure str_minus(Machine: TForthMachine; Command: PForthCommand);
label
  _Break;
var
  X, S, Y: TStr;
  I, J, Len: Integer;
begin
  S := str_pop(Machine);
  X := str_top(Machine);
  if X^.Ref = 1 then begin
    Y := X;
    X^.Ref := 2;
  end else begin
    str_pop(Machine);
    Y := CreateStr(X^.Width, X^.Len);
    str_push(Machine, Y);
  end;
  Len := 0;
  I := 0;
  while I < X^.Len do begin
    for J := 0 to S^.Len - 1 do
      if StrSymbol(X, I+J) <> StrSymbol(S, J) then
        goto _Break;
    Inc(I, S^.Len);
    continue;
  _Break:
    Move(X^.Sym[I*X^.Width], Y^.Sym[Len*X^.Width], X^.Width);  
    Inc(Len);
    Inc(I);
  end;
  Y^.Len := Len;
  DelRef(X);
  DelRef(S);
end;

procedure str_replace(Machine: TForthMachine; Command: PForthCommand);
label
  _Break;
var
  X, S, N, Y: TStr;
  I, J, Len: Integer;
  Buffer: array of Byte;
begin
  N := str_pop(Machine);
  S := str_pop(Machine);
  X := str_top(Machine);
  // ��������� -- ������ ���� ����� ����� ����������� �����
  SetLength(Buffer, (X^.Len + 5*N^.Len)*X^.Width);
  Len := 0;
  I := 0;
  while I < X^.Len do begin
    for J := 0 to S^.Len - 1 do
      if StrSymbol(X, I+J) <> StrSymbol(S, J) then
        goto _Break;
    Inc(I, S^.Len);
    if Len + N^.Len > Length(Buffer) div X^.Width then
      SetLength(Buffer, 2*Length(Buffer)); 
    // Move(N^.Sym[0], Buffer[Len*X^.Width], N^.Len * N^.Width);
    MoveChars(@Buffer[Len*X^.Width], @N^.Sym[0], N^.Len, X^.Width, N^.Width);
    Inc(Len, N^.Len);
    continue;
  _Break:
    if Len > Length(Buffer) div X^.Width then
      SetLength(Buffer, 2*Length(Buffer)); 
    Move(X^.Sym[I*X^.Width], Buffer[Len*X^.Width], X^.Width);  
    Inc(Len);
    Inc(I);
  end;
  if (X^.Ref = 1) and (Len <= X^.Len) then begin
    Move(Buffer[0], X^.Sym[0], Len*X^.Width);
    X^.Len := Len;
  end else begin
    str_pop(Machine);
    Y := CreateStr(X^.Width, Len);
    Move(Buffer[0], Y^.Sym[0], X^.Width * Len);
    str_push(Machine, Y);
    DelRef(X);
  end;
  DelRef(S);
  DelRef(N);
end;

procedure str_ins(Machine: TForthMachine; Command: PForthCommand);
var
  X, Y, S: TStr;
  P, Width: Integer;
begin
  S := str_pop(Machine);
  X := str_pop(Machine);
  P := Machine.WOI;
  Width := Max(X^.Width, S^.Width);
  Y := CreateStr(Width, X^.Len + S^.Len);
  MoveChars(@Y^.Sym[0],                @X^.Sym[0],          P,                   Width, X^.Width);
  MoveChars(@Y^.Sym[P*Width],          @S^.Sym[0],          S^.Len,              Width, S^.Width);
  MoveChars(@Y^.Sym[(P+S^.Len)*Width], @X^.Sym[P*X^.Width], X^.Len - P - S^.Len, Width, X^.Width);
  DelRef(S);
  DelRef(X);
  str_push(Machine, Y);
end;

procedure str_del(Machine: TForthMachine; Command: PForthCommand);
var
  X, Y: TStr;
  P, S: Integer;
begin
  X := str_top(Machine);
  S := Machine.WOI;
  P := Machine.WOI;
  if X^.Ref = 1 then begin
    Move(X^.Sym[(P+S)*X^.Width], X^.Sym[P*X^.Width], (X^.Len - (P+S)) * X^.Width); 
    X^.Len := X^.Len - S;
    Exit;
  end;
  Y := CreateStr(X^.Width, X^.Len - S);
  Move(X^.Sym[0], Y^.Sym[0], P * X^.Width); 
  Move(X^.Sym[(P+S)*X^.Width], Y^.Sym[P*X^.Width], (X^.Len - (P+S)) * X^.Width); 
  str_drop(Machine, nil);
  str_push(Machine, Y);
end;

procedure str_cut(Machine: TForthMachine; Command: PForthCommand);
var
  X, Y: TStr;
  P, S: Integer;
begin
  X := str_top(Machine);
  S := Machine.WOI;
  P := Machine.WOI;
  if X^.Ref = 1 then begin
    Move(X^.Sym[P*X^.Width], X^.Sym[0], S * X^.Width); 
    X^.Len := S;
    Exit;
  end;
  Y := CreateStr(X^.Width, S);
  Move(X^.Sym[P*X^.Width], Y^.Sym[0], S * X^.Width); 
  str_drop(Machine, nil);
  DelRef(X);
  str_push(Machine, Y);
end;

procedure str_split(Machine: TForthMachine; Command: PForthCommand);
var
  S, X, Y: TStr;
  P: Integer;
begin
  S := str_top(Machine);
  P := Machine.WOI;
  Y := CreateStr(S^.Width, S^.Len - P);
  Move(S^.Sym[P*S^.Width], Y^.Sym[0], (S^.Len - P)*S^.Width);
  if S^.Ref = 1 then begin
    S^.Len := P;
    str_push(Machine, Y);
    Exit;
  end;
  X := CreateStr(S^.Width, S^.Len);
  Move(S^.Sym[0], X^.Sym[0], P*S^.Width);
  str_drop(Machine, Command);
  str_push(Machine, X);
  str_push(Machine, Y);
end;

procedure str_sub(Machine: TForthMachine; Command: PForthCommand);
begin
end;

procedure str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
  Temp: array of Char;
  B: TStr;
  I: Integer;
begin
 // with Machine^ do begin
    //if Machine.State = FS_COMPILE then begin
    //  compile_str_dq(Machine, Command);
    //end else begin
      SetLength(Temp, 0); 
      C := Machine.NextChar;
      while C <> Char(34) do begin
        SetLength(Temp, Length(Temp) + 1); 
        if C = '^' then begin
          C := Machine.NextChar;
          case C of
            'n': 
              begin
                SetLength(Temp, Length(Temp) + Length(CR_windows) - 1);
                for I := 0 to High(CR_windows) do
                  Temp[High(Temp) - I] := Char(CR_windows[High(CR_windows) - I]);
              end;
            Char(34): Temp[High(Temp)] := Char(34);
          else
            Temp[High(Temp)] := C; 
          end
        end else begin
          Temp[High(Temp)] := C; 
        end;
        C := Machine.NextChar;
      end; 
      GetMem(B, 3*SizeOf(TInt) + Length(Temp) + 1);
      PStrRec(B)^.Len := Length(Temp);
      PStrRec(B)^.Ref := 0;
      PStrRec(B)^.Width := 1;
      Move(Temp[0], PStrRec(B)^.Sym[0], Length(Temp));
      PStrRec(B)^.Sym[Length(Temp)*PStrRec(B)^.Width] := 0;
      str_push(Machine, B);
      Machine.ConvStr^.Code(Machine, Machine.ConvStr);
    //end;
 // end;
end;

procedure compile_str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
  E: Cardinal;
  L: Integer;
  S: PStrRec;
begin
 // with Machine^ do begin
    if Machine.ConvStr = Machine.nop then begin
      Machine.BuiltinEWO('(str)' + Char(34));
      Machine.EWI(1);
      E := Machine.EL;
      Machine.EWI(0);
      Machine.EWI(1);
      C := Machine.NextChar;
      L := 0;
      while C <> Char(34) do begin
        if C = '^' then begin
          C := Machine.NextChar;
          case C of
            'n': Machine.EWC(#13);
          else
            Machine.EWC(C);
          end
        end else begin
          Machine.EWC(C);
        end;
        C := Machine.NextChar;
        Inc(L);
      end;
      Machine.EWC(#0);
      Move(L, Machine.E[E], SizeOf(TInt));
    end else begin
      str_dq(Machine, Command);
      S := PStrRec(TBlock(Pointer(TUInt(Machine.BWP) + (-1)*(SizeOf(Pointer)))^));
      Machine.BuiltinEWO('(str)' + Char(34));
      E := Machine.EL;
      Machine.EWV(S, SizeOf(Integer)*3 + S^.Len*S^.Width + 1);
      Integer(Pointer(@Machine.E[E])^) := 1;
    end;
 // end;
end;

procedure run_str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
 // with Machine^ do begin
    B := @Machine.E[Machine.EC];
    str_push(Machine, B);
    Inc(Machine.EC, 3*SizeOf(TInt) + PStrRec(B)^.Len*B^.Width + 1);
 // end;
end;

procedure _str_literal(Machine: TForthMachine; Command: PForthCommand);
const
  One: Integer = 1;
var
  B: TStr;
  E: Integer;
begin
  Machine.BuiltinEWO('(str-literal)');
  B := str_pop(Machine);
  E := Machine.EL;
  Machine.EWV(B, 3*SizeOf(TInt) + B^.Len*B^.Width + 1);
  Move(One, Machine.E[E], SizeOf(Integer));
  DelRef(B);
end;

procedure str_equel(Machine: TForthMachine; Command: PForthCommand);
label
  _Exit;
var
  A, B: TStr;
  I: Integer;
begin
 // with Machine^ do begin
    B := str_pop(Machine);
    A := str_pop(Machine);
    if PStrRec(A)^.Len <> PStrRec(B)^.Len then
      Machine.WUI(BOOL_FALSE)
    else begin
      (* for I := 0 to PStrRec(A)^.Len - 1 do *)
      (*   if PStrRec(A)^.Sym[I] <> PStrRec(B)^.Sym[I] then begin *)
      (*     Machine.WUI(BOOL_FALSE); *)
      (*     DelRef(A); *)
      (*     DelRef(B); *)
      (*     Exit; *)
      (*   end; *)
      (* Machine.WUI(BOOL_TRUE); *)
      for I := 0 to A^.Len - 1 do
        if StrSymbol(A, I) <> StrSymbol(B, I) then begin
          Machine.WUI(BOOL_FALSE);
          goto _Exit;
        end;
      Machine.WUI(BOOL_TRUE);
      (* if StrComp(@PStrRec(A)^.Sym[0], @PStrRec(B)^.Sym[0]) = 0 then *)
      (*   Machine.WUI(BOOL_TRUE) *)
      (* else *)
      (*   Machine.WUI(BOOL_FALSE); *)
    end;
  _Exit:
    DelRef(A);
    DelRef(B);
 // end;
end;

procedure str_concat(Machine: TForthMachine; Command: PForthCommand);
var
  Width: Integer;
  A, B, C: TStr;
begin
 // with Machine^ do begin
    B := str_pop(Machine);
    A := str_pop(Machine);
    Width := Max(A^.Width, B^.Width);
    C := CreateStr(Width, A^.Len + B^.Len);
    MoveChars(@C^.Sym[0],            @A^.Sym[0], A^.Len, Width, A^.Width);
    MoveChars(@C^.Sym[A^.Len*Width], @B^.Sym[0], B^.Len, Width, B^.Width);
    DelRef(A);
    DelRef(B);
    str_push(Machine, C);
 // end;
end;

procedure str_nil(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    str_push(Machine, FStrNil);
  end;
end;

procedure str_dollar(Machine: TForthMachine; Command: PForthCommand);
var
  P: TStr;
  B: TString;
begin
  with Machine^ do begin
    Readln(B); 
    GetMem(P, 3*SizeOf(Integer) + Length(B) + 1);
    PStrRec(P)^.Ref := 0;
    PStrRec(P)^.Len := Length(B);
    PStrRec(P)^.Width := 1;
    Move(B[1], PStrRec(P)^.Sym[0], Length(B));
    PStrRec(P)^.Sym[Length(B)] := 0;
    str_push(Machine, P);
  end;
end;

procedure str_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    with Machine^ do begin
      Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := Pointer(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^);
      AddRef(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)));
    end;
  end;
end;

procedure str_exclamation(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    with Machine^ do begin
      DelRef(Pointer(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^));
      Pointer(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Pointer((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Pointer)))^));
      Dec(WP, 2*SizeOf(Pointer));
      AddRef(Pointer(WP^));
    end;
  end;
end;

procedure str_symbol_dog(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
  with Machine^ do begin
    Cardinal((Pointer(TUInt(Machine.WP) + (-SizeOf(Cardinal)))^)) := StrSymbol(str_top(Machine), Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Cardinal)))^)));
  end;
end;

procedure str_symbol_exclamation(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
  with Machine^ do begin
    B := str_top(Machine);
    if B^.Ref <> 1 then begin
      B := CreateStr(B);
      DelRef(str_pop(Machine));
      str_push(Machine, B);
    end;
    SetStrSymbol(B, Integer((Pointer(TUInt(Machine.WP) + (-SizeOf(Cardinal)))^)), Cardinal((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Cardinal)))^)));
    Dec(Machine.WP, 2*SizeOf(Integer));
  end;
end;

procedure str_new(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
begin
  B := str_pop(Machine);
  str_push(Machine, CreateStr(B));
  DelRef(B);
end;

{ procedure str_new(Machine: TForthMachine; Command: PForthCommand);
var
  B: TStr;
  Len, C, Width, I: Integer;
begin
  Width := Machine.WOI;
  C := Machine.WOI;
  Len := Machine.WOI;
  B := CreateStr(Width, Len);
  for I := 0 to Len - 1 do
    B^.Sym[I*Width] := C;
  str_push(Machine, B);
end;}

procedure str_index_dog(Machine: TForthMachine; Command: PForthCommand);
begin
 // B := str_pop(Machine);
 // WUI(StrSymbol(B, Machine.WOI));
end;

procedure str_index_exclamation(Machine: TForthMachine; Command: PForthCommand);
begin
end;

procedure pchar_to_str(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Dec(Machine.WP, SizeOf(Pointer));
    //P := PAnsiChar(Machine.WP^);
    Machine.WUS(TString(PAnsiChar(Machine.WP^)));
  end;
end;

procedure Format(Machine: TForthMachine; Command: PForthCommand);
var
  I, J: Integer;
  Sub: array of string;
  STemp: TStr;
begin
  SetLength(Sub, 0);
  with Machine^ do begin
    STemp := str_pop(Machine);
    I := STemp^.Len;
    while I > 0 do begin
      Dec(I);
      SetLength(Sub, Length(Sub) + 1);
      if TChar(STemp^.Sym[I]) = '%' then begin
        if TChar(STemp^.Sym[I+1]) = '%' then begin
          Sub[High(Sub)] := '%';
        end else if TChar(STemp^.Sym[I+1]) = 's' then begin
          STemp := str_pop(Machine);
          DelRef(STemp);
        end;
      end else begin
        J := I;
        while (J >= 0) and (TChar(STemp^.Sym[I+1]) <> '%') do
          Dec(J);
        SetLength(Sub[High(Sub)], I - J);
        I := J;
      end;
    end;
    DelRef(STemp);
  end;
end;


procedure _raw_2_unicode (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(4, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 4, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

procedure _utf8_2_unicode (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
  Len, U: Integer;
  P: Pointer;
begin
  B := str_pop(Machine);
  C := CreateStr(4, B^.Len);
  Len := 0;
  P := @B^.Sym[0];
  while TUInt(P) < TUInt(@B^.Sym[B^.Len]) do
    if not ReadUTF8Char(P, U) then
      Break
    else begin
      PArrayOfCardinal(@C^.Sym[0])^[Len] := U;
      Inc(Len);
      // Write(Char(U));
    end;
  // Writeln;
  C^.Len := Len;
  DelRef(B);
  str_push(Machine, C);
end;

procedure _utf8_2_raw (Machine: TForthMachine; Command: PForthCommand);
begin with Machine^ do begin  end; end;

procedure _unicode_2_utf8 (Machine: TForthMachine; Command: PForthCommand);
begin with Machine^ do begin  end; end;

procedure _unicode_2_raw (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(1, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 1, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

procedure _poststr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(@ConvStr) end; end;
procedure _postname (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(@ConvName) end; end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('pchar' + Char(34), pchar_dq, True);
  Machine.AddCommand('(pchar)' + Char(34), run_pchar_dq);
  Machine.AddCommand('pwidechar' + Char(34), pwidechar_dq, True);
  Machine.AddCommand('[pwidechar]' + Char(34), compile_pwidechar_dq, True);
  Machine.AddCommand('(pwidechar)' + Char(34), run_pwidechar_dq);
  Machine.AddCommand('pchar.', pchar_dot);
  Machine.AddCommand('pchar-alloc', pchar_alloc);
  Machine.AddCommand('pchar-free', pchar_free);
  Machine.AddCommand('pchar-len', pchar_len);
  Machine.AddCommand('pchar-concat', pchar_concat);
  Machine.AddCommand('pchar=', pchar_equel);

  Machine.AddCommand('char', _char);
  Machine.AddCommand('[char]', _compile_char, True);

  Machine.AddCommand('str0', str_nil);
  Machine.AddCommand('str#', str_len);
  Machine.AddCommand('str-width', str_width);
  Machine.AddCommand('str+', str_concat);
  Machine.AddCommand('str@', str_dog);
  Machine.AddCommand('str!', str_exclamation);
  Machine.AddCommand('str[]@', str_symbol_dog);
  Machine.AddCommand('str[]!', str_symbol_exclamation);
  Machine.AddCommand('str-new', str_new);
  Machine.AddCommand('str=', str_equel);
  Machine.AddCommand('str^', str_pos);
  Machine.AddCommand('str^?', str_pos_ask);
  Machine.AddCommand('str-', str_minus);
  Machine.AddCommand('str\', str_replace);
  Machine.AddCommand('str-ins', str_ins);
  Machine.AddCommand('str-del', str_del);
  Machine.AddCommand('str-cut', str_cut);
  Machine.AddCommand('str-split', str_split);
  Machine.AddCommand('str-sub', str_sub);
  Machine.AddCommand('str' + Char(34), str_dq);
  Machine.AddCommand('[str]' + Char(34), compile_str_dq, True);
  Machine.AddCommand('(str)' + Char(34), run_str_dq);
  Machine.AddCommand('(str-literal)', run_str_dq);
  Machine.AddCommand('str-literal', _str_literal, True);
  Machine.AddCommand('str$', str_dollar);
  Machine.AddCommand('pchar->str', pchar_to_str);  

  Machine.AddCommand('utf8->unicode', _utf8_2_unicode);
  Machine.AddCommand('utf8->raw', _utf8_2_raw);
  Machine.AddCommand('raw->unicode', _raw_2_unicode);
  Machine.AddCommand('unicode->utf8', _unicode_2_utf8);
  Machine.AddCommand('unicode->raw', _unicode_2_raw);

  Machine.AddCommand('*poststr', _poststr);
  Machine.AddCommand('*postname', _postname);
end;

end.

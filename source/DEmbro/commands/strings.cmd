DECLARE(pachar-alloc, pchar_alloc)
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

DECLARE(pchar-free, pchar_free)
var
  P: Pointer;
begin
  with Machine^ do begin
    P := Machine.WOP;
    FreeMem(P);
  end;
end;

DECLARE(pchar-len, pchar_len)
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

DECLARE(pchar-concat, pchar_concat)
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

DECLARE(pchar=, pchar_equel)
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

dnl see blablabla
dnl DECLARE(pchar_dq)
dnl var
dnl   C: TChar;
dnl begin
dnl  // with Machine^ do begin
dnl     if Machine.State = FS_COMPILE then begin
dnl       compile_pchar_dq(Machine, Command);
dnl     end else begin
dnl       SetLength(Machine.FPChars, Length(Machine.FPChars) + 1);
dnl       SetLength(Machine.FPChars[High(Machine.FPChars)], 0); 
dnl       C := Machine.NextChar;
dnl       while C <> Char(34) do begin
dnl         SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + 1); 
dnl         Machine.FPChars[High(Machine.FPChars)][High(Machine.FPChars[High(Machine.FPChars)])] := C; 
dnl         C := Machine.NextChar;
dnl       end; 
dnl       SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + 1); 
dnl       Machine.FPChars[High(Machine.FPChars)][High(Machine.FPChars[High(Machine.FPChars)])] := #0; 
dnl       Machine.WUP(Machine.FPChars[High(Machine.FPChars)]);
dnl     end;
dnl  // end;
dnl end;

dnl see blablabla
dnl DECLARE(compile_pchar_dq)
dnl var
dnl   C: TChar;
dnl begin
dnl  // with Machine^ do begin
dnl     Machine.BuiltinEWO('(pchar)' + Char(34));
dnl     C := Machine.NextChar;
dnl     while C <> Char(34) do begin
dnl       Machine.EWC(C);
dnl       C := Machine.NextChar;
dnl     end;
dnl     C := #0;
dnl     Machine.EWC(C);
dnl  // end;
dnl end;

dnl see blablabla
dnl DECLARE(run_pchar_dq)
dnl var
dnl   P: Pointer;
dnl begin
dnl  // with Machine^ do begin
dnl     P := @Machine.E[Machine.EC];
dnl     Machine.WUP(P);
dnl     while Machine.E[Machine.EC] <> 0 do
dnl       Inc(Machine.EC);
dnl     Inc(Machine.EC);
dnl  // end;
dnl end;

dnl see blablabla
dnl DECLARE(pwidechar_dq)
dnl var
dnl   C: WideChar;
dnl begin
dnl     (* if Machine.State = FS_COMPILE then begin *)
dnl     (*   compile_pwidechar_dq(Machine, Command); *)
dnl     (* end else begin *)
dnl       SetLength(Machine.FPChars, Length(Machine.FPChars) + 1);
dnl       SetLength(Machine.FPChars[High(Machine.FPChars)], 0); 
dnl       C := WideChar(Machine.NextChar);
dnl       while C <> Char(34) do begin
dnl         SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + SizeOf(C)); 
dnl         Move(C, Machine.FPChars[High(Machine.FPChars)][Length(Machine.FPChars[High(Machine.FPChars)]) - SizeOf(C)], SizeOf(C)); 
dnl         C := WideChar(Machine.NextChar);
dnl       end; 
dnl       SetLength(Machine.FPChars[High(Machine.FPChars)], Length(Machine.FPChars[High(Machine.FPChars)]) + SizeOf(C)); 
dnl       C := #0;
dnl       Move(C, Machine.FPChars[High(Machine.FPChars)][Length(Machine.FPChars[High(Machine.FPChars)]) - SizeOf(C)], SizeOf(C)); 
dnl       Machine.WUP(Machine.FPChars[High(Machine.FPChars)]);
dnl     //end;
dnl end;

dnl DECLARE(compile_pwidechar_dq)
dnl var
dnl   C: WideChar;
dnl begin
dnl  // with Machine^ do begin
dnl     Machine.BuiltinEWO('(pwidechar)' + Char(34));
dnl     C := WideChar(Machine.NextChar);
dnl     while C <> Char(34) do begin
dnl       Machine.EWV(@C, SizeOf(C));
dnl       C := WideChar(Machine.NextChar);
dnl     end;
dnl     C := #0;
dnl     Machine.EWV(@C, SizeOf(C));
dnl end;

dnl DECLARE(run_pwidechar_dq)
dnl var
dnl   P: Pointer;
dnl begin
dnl     P := @Machine.E[Machine.EC];
dnl     Machine.WUP(P);
dnl     while WideChar((@Machine.E[Machine.EC])^) <> #0 do
dnl       Inc(Machine.EC, SizeOf(WideChar));
dnl     Inc(Machine.EC, SizeOf(WideChar));
dnl end;

DECLARE(pchar., pchar_dot)
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

function CreatePChar(const S: TString): PAnsiChar; overload;
begin
  Result := StrAlloc(Length(S)+1);
  StrLCopy(Result, @S[1], Length(S));
end;

function CreatePChar(const P: PAnsiChar): PAnsiChar; overload;
begin
  Result := StrAlloc(StrLen(P)+1);
  StrCopy(Result, P);
end;

procedure AddRef(B: TStr);
begin
  if B = nil then 
    Exit;
  Inc(PStrRec(B)^.Ref);
  //Machine.FMemoryDebug.Log(ToStr([' + str" ', PChar(@B^.Sym[0]), '" ', B^.Ref]));
end;

procedure DelRef(B: TStr);
begin
  if B = nil then 
    Exit;
  //Dec(PStrRec(B)^.Ref);
  if PStrRec(B)^.Ref < 1 then begin
    // Writeln('Free string "', PChar(@(PStrRec(B)^.Sym[0])), '"');
    FreeMem(B);
    //Machine.FMemoryDebug.Log(ToStr([' - str" ', PChar(@B^.Sym[0]), '" (free)']));
  end;// else
    //Machine.FMemoryDebug.Log(ToStr([' - str" ', PChar(@B^.Sym[0]), '" ', B^.Ref]));
end;

DECLARE(char)
begin
  Machine.WUI(Ord(Machine.SNC));
end;

DECLARE([char], sq_char_sq, True)
begin
  Machine.BuiltinEWO('(literal)');
  Machine.EWI(Ord(Machine.SNC));
end;

procedure str_push(Machine: TForthMachine; const B: TString); overload;
var
  FS: TStr;
begin
  FS := CreateStr(1, Length(B));
  Move(B[1], FS.Sym[0], Length(B));
  str_push(Machine, FS);
end;

procedure str_push(Machine: TForthMachine; B: TStr); overload;
begin
  AddRef(B);
  Machine.BWU(B);
end;

function str_pop(Machine: TForthMachine): TStr;
begin
  Result := Machine.BWO;
end;

function str_top(Machine: TForthMachine): TStr; overload;
begin
  Result := TStr(BVar(-1));
end;

function str_top(Machine: TForthMachine; Index: Integer): TStr; overload;
begin
  Result := TStr(BVar(-Index));
end;

DECLARE(str-drop, str_drop)
begin
  with Machine^ do begin
    DelRef(str_pop(Machine));
  end;
end;

DECLARE(str-dup, str_dup)
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

DECLARE(str-over, str_over)
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


DECLARE(str-len, str_len)
var
  B: TStr;
begin
  with Machine^ do begin
    B := str_top(Machine);
    Machine.WUI(PStrRec(B)^.Len);
  end;
end;

DECLARE(str-width, str_width)
begin
  Machine.WUI(str_top(Machine)^.Width);
end;

DECLARE(str^, str_pos)
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

DECLARE(str^?, str_pos_ask)
begin
  str_pos(Machine, Command);
  if Integer(WVar(-SizeOf(Integer))) = -1 then
    Machine.WUI(BOOL_FALSE)
  else
    Machine.WUI(BOOL_TRUE);
end;

DECLARE(str-, str_minus)
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

DECLARE(str-replace, str_replace)
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
  // эвристика -- больше пяти замен будет происходить редко
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

DECLARE(str-ins, str_ins)
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

DECLARE(str-del, str_del)
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

DECLARE(str-cut, str_cut)
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

DECLARE(str-split, str_split)
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

DECLARE(str-sub, str_sub)
begin
end;

dnl DECLARE(str_dq)
dnl var
dnl   C: TChar;
dnl   Temp: array of Char;
dnl   B: TStr;
dnl   I: Integer;
dnl begin
dnl  // with Machine^ do begin
dnl     //if Machine.State = FS_COMPILE then begin
dnl     //  compile_str_dq(Machine, Command);
dnl     //end else begin
dnl       SetLength(Temp, 0); 
dnl       C := Machine.NextChar;
dnl       while C <> Char(34) do begin
dnl         SetLength(Temp, Length(Temp) + 1); 
dnl         if C = '^' then begin
dnl           C := Machine.NextChar;
dnl           case C of
dnl             'n': 
dnl               begin
dnl                 SetLength(Temp, Length(Temp) + Length(CR_windows) - 1);
dnl                 for I := 0 to High(CR_windows) do
dnl                   Temp[High(Temp) - I] := Char(CR_windows[High(CR_windows) - I]);
dnl               end;
dnl             Char(34): Temp[High(Temp)] := Char(34);
dnl           else
dnl             Temp[High(Temp)] := C; 
dnl           end
dnl         end else begin
dnl           Temp[High(Temp)] := C; 
dnl         end;
dnl         C := Machine.NextChar;
dnl       end; 
dnl       GetMem(B, 3*SizeOf(TInt) + Length(Temp) + 1);
dnl       PStrRec(B)^.Len := Length(Temp);
dnl       PStrRec(B)^.Ref := 0;
dnl       PStrRec(B)^.Width := 1;
dnl       Move(Temp[0], PStrRec(B)^.Sym[0], Length(Temp));
dnl       PStrRec(B)^.Sym[Length(Temp)*PStrRec(B)^.Width] := 0;
dnl       str_push(Machine, B);
dnl       Machine.ConvStr^.Code(Machine, Machine.ConvStr);
dnl     //end;
dnl  // end;
dnl end;

dnl DECLARE(compile_str_dq)
dnl var
dnl   C: TChar;
dnl   E: Cardinal;
dnl   L: Integer;
dnl   S: PStrRec;
dnl begin
dnl  // with Machine^ do begin
dnl     if Machine.ConvStr = Machine.nop then begin
dnl       Machine.BuiltinEWO('(str)' + Char(34));
dnl       Machine.EWI(1);
dnl       E := Machine.EL;
dnl       Machine.EWI(0);
dnl       Machine.EWI(1);
dnl       C := Machine.NextChar;
dnl       L := 0;
dnl       while C <> Char(34) do begin
dnl         if C = '^' then begin
dnl           C := Machine.NextChar;
dnl           case C of
dnl             'n': Machine.EWC(#13);
dnl           else
dnl             Machine.EWC(C);
dnl           end
dnl         end else begin
dnl           Machine.EWC(C);
dnl         end;
dnl         C := Machine.NextChar;
dnl         Inc(L);
dnl       end;
dnl       Machine.EWC(#0);
dnl       Move(L, Machine.E[E], SizeOf(TInt));
dnl     end else begin
dnl       str_dq(Machine, Command);
dnl       S := PStrRec(BVar(-1));
dnl       Machine.BuiltinEWO('(str)' + Char(34));
dnl       E := Machine.EL;
dnl       Machine.EWV(S, SizeOf(Integer)*3 + S^.Len*S^.Width + 1);
dnl       Integer(Pointer(@Machine.E[E])^) := 1;
dnl     end;
dnl  // end;
dnl end;

dnl DECLARE(run_str_dq)
dnl var
dnl   B: TStr;
dnl begin
dnl  // with Machine^ do begin
dnl     B := @Machine.E[Machine.EC];
dnl     str_push(Machine, B);
dnl     Inc(Machine.EC, 3*SizeOf(TInt) + PStrRec(B)^.Len*B^.Width + 1);
dnl  // end;
dnl end;

DECLARE(str-literal, str_literal, True)
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

DECLARE(str=, str_equel)
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

DECLARE(str+, str_concat)
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

DECLARE(str0, str_nil)
begin
  with Machine^ do begin
    str_push(Machine, FStrNil);
  end;
end;

DECLARE(str., str_dot)
var
  I: Integer;
  B: TStr;
begin
  with Machine^ do begin
    B := str_pop(Machine);
    I := 0;
    while I < PStrRec(B)^.Len do begin
      if StrSymbol(B, I) = 13{'\'} then begin
        //if PStrRec(B)^.Sym[I+1] = 'n' then begin
          Writeln;
        //  Inc(I);
        //end;
      end else
        Write(Char(char4to1(StrSymbol(B, I))));
      Inc(I);
    end;
    DelRef(B);
  end;
end;

DECLARE(str$, str_dollar)
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

DECLARE(str@, str_dog)
begin
  with Machine^ do begin
    with Machine^ do begin
      Pointer(WVar(-SizeOf(Pointer))) := Pointer(Pointer(WVar(-SizeOf(Pointer)))^);
      AddRef(Pointer(WVar(-SizeOf(Pointer))));
    end;
  end;
end;

DECLARE(str!, str_exclamation)
begin
  with Machine^ do begin
    with Machine^ do begin
      DelRef(Pointer(Pointer(WVar(-SizeOf(Pointer)))^));
      Pointer(Pointer(WVar(-SizeOf(Pointer)))^) := Pointer(WVar(-2*SizeOf(Pointer)));
      Dec(WP, 2*SizeOf(Pointer));
      AddRef(Pointer(WP^));
    end;
  end;
end;

DECLARE(str[]@, str_symbol_dog)
var
  B: TStr;
begin
  with Machine^ do begin
    Cardinal(WVar(-SizeOf(Cardinal))) := StrSymbol(str_top(Machine), Integer(WVar(-SizeOf(Cardinal))));
  end;
end;

DECLARE(str[]!, str_symbol_exclamation)
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
    SetStrSymbol(B, Integer(WVar(-SizeOf(Cardinal))), Cardinal(WVar(-2*SizeOf(Cardinal))));
    Dec(Machine.WP, 2*SizeOf(Integer));
  end;
end;

DECLARE(str-copy, str_copy)
var
  B: TStr;
begin
  B := str_pop(Machine);
  str_push(Machine, CreateStr(B));
  DelRef(B);
end;
RUS SUMMARY(( B: x -- B: y) создаёт новую строку, содержащую копию x)

DECLARE(str-new, str_new)
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
end;
RUS SUMMARY(( lcw -- B: s) создаёт строку длинной l шириной w, каждый символ которой c)

DECLARE(pchar->str, pchar_to_str)
begin
  with Machine^ do begin
    Dec(Machine.WP, SizeOf(Pointer));
    //P := PAnsiChar(Machine.WP^);
    Machine.WUS(TString(PAnsiChar(Machine.WP^)));
  end;
end;

DECLARE(format)
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


DECLARE(raw->unicode, raw_2_unicode)
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(4, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 4, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

DECLARE(utf8->unicode, utf8_2_unicode)
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

DECLARE(utf8->raw, utf8_2_raw)
body(
)

DECLARE(unicode->utf8, unicode_2_utf8)
body(
)

DECLARE(unicode->raw, unicode_2_raw)
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(1, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 1, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

DECLARE(*poststr, poststr) body(WUP(@ConvStr))
DECLARE(*postname, postname) body(WUP(@ConvName))

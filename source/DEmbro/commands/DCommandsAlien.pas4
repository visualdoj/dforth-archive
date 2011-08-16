unit DCommandsAlien;

interface

uses
  {$I units.inc},
  strings,
  DForthMachine;

  procedure lib_load(Machine: TForthMachine; Command: PForthCommand);
  procedure lib_unload(Machine: TForthMachine; Command: PForthCommand);
  procedure lib_fun(Machine: TForthMachine; Command: PForthCommand);
  procedure alien_fun(Machine: TForthMachine; Command: PForthCommand);
  procedure alien_endfun(Machine: TForthMachine; Command: PForthCommand);
  procedure callback_fun(Machine: TForthMachine; Command: PForthCommand);
  procedure callback_endfun(Machine: TForthMachine; Command: PForthCommand);
  procedure invoke_stdcall(Machine: TForthMachine; Command: PForthCommand);
  procedure invoke_cdecl(Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_stdcall(Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_cdecl(Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TAlienCommands'}{$ENDIF}
procedure lib_load(Machine: TForthMachine; Command: PForthCommand);
var
  B: TString;
  L: TLib;
  I: TInt;
begin
  //with Machine^ do begin
    //Machine.FPtrStackCommands.Pop(@P);
    B := Machine.WOS;
    L := TLib.Create(PChar(B));   
    Machine.WUP(L);
    I := BOOL_TRUE * Ord(L.Ready) + BOOL_FALSE * Ord(not L.Ready);
    Machine.WUI(I);
  //end;
end;

procedure lib_unload(Machine: TForthMachine; Command: PForthCommand);
var
  L: TLib;
begin
  //with Machine^ do begin
    L := Machine.WOP;
    L.Free;
  //end;
end;

procedure lib_fun(Machine: TForthMachine; Command: PForthCommand);
var
  L: TLib;
  B: TString;
  P: Pointer;
begin
 // with Machine^ do begin
    B := Machine.WOS;
    L := Machine.WOP;
    P := L.GetProcAddress(PChar(B));
    // Machine.WUI(L);
    Machine.WUP(P);
 // end;
end;

procedure alien_fun(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  C: PForthCommand;
  T: PType;
begin
 // with Machine^ do begin
    if Machine.State = FS_COMPILE then begin
      Machine.LogError(Command^.Name + ' command cannot work in compile mode');
      Exit;
    end;
    Name := Machine.NextName;
    New(C);
    C^.Name := StrAlloc(Length(Name) + 1);
    StrCopy(C^.Name, PChar(Name));
    //Log('Pushed command ' + C^.Name);
    Machine.WUP(C);
    T := @Machine.FTypes[0];
    Machine.WUP(T);
 // end;
end;

procedure Test1(A, B: Integer); stdcall;
begin
  Log('Test1 ' + IntToStr(A - B));
end;

function Test2(A, B: Integer): Integer; stdcall;
begin
  Log('Test2 ' + IntToStr(A - B));
  Result := A - B;
end;

function Test3(A, B: TInt64): TInt64; stdcall;
begin
  Log('Test3 ' + IntToStr(A - B));
  Result := A - B;
end;

procedure alien_endfun(Machine: TForthMachine; Command: PForthCommand);
var
  Conv: Integer;
  ReturnType: PType;
  T: PType;
  Types: array of PType;
  C, C2: PForthCommand;
  P: Pointer; 
  B: Byte;
  I: Integer;
  Small: TInt8;
begin
  //with Machine^ do begin
    if Machine.State = FS_COMPILE then begin
      Machine.LogError(Command^.Name + ' command cannot work in compile mode');
      Exit;
    end;
    Conv := Machine.WOI;
    ReturnType := Machine.WOP;
    T := Machine.WOP;
    SetLength(Types, 0);
    while T <> @Machine.FTypes[0] do begin
      //Log(IntToStr(Length(Types)) + ': ' + T^.Name);
      SetLength(Types, Length(Types) + 1);
      Types[High(Types)] := T;
      T := Machine.WOP;
    end;
    C2 := Machine.WOP;
    //Log('Poped command ' + C2^.Name);
    C := Machine.ReserveName(TString(C2^.Name));
    StrDispose(C2^.Name);
    Dispose(C2);
    if Conv = CONV_STDCALL then 
          begin
            C^.Code := invoke_stdcall;
            C^.Data := Machine.Here;
            if C^.Name = 'test1' then
              P := @Test1
            else if C^.Name = 'test2' then
              P := @Test2;
            Move(P, Machine.Here^, SizeOf(P));
            Machine.IncHere(SizeOf(P));
            B := ReturnType^.Size;
            if B <= 8 then begin
              Small := B;
              if Small > 4 then
                Small := 4;
              //Writeln('Return-size(1): ', Small);
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
              B := B - Small;
              Small := B;
              if Small > 4 then
                Small := 4;
              //Writeln('Return-size(2): ', Small);
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
              Small := 0;
              //Writeln('Return-size(3): ', Small);
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
            end else begin
              Small := 0;
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
              Small := 0;
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
              Small := B;
              Move(Small, Machine.Here^, SizeOf(Small));
              Machine.IncHere(SizeOf(Small));
            end;
            for I := 0 to High(Types) do begin
              B := Types[I]^.Size;
              while B > 0 do begin
                Small := B mod 4;
                if Small = 0 then
                  Small := 4;
                B := B - Small;
                Small := -Small;
                Move(Small, Machine.Here^, SizeOf(Small));
                Machine.IncHere(SizeOf(Small));
              end;
            end;
            B := 0;
            Move(B, Machine.Here^, SizeOf(B));
            Machine.IncHere(SizeOf(B));
          end
    else if Conv = CONV_CDECL then 
          begin
            C^.Code := invoke_cdecl;
            C^.Data := Machine.Here;
            P := nil;
            Move(P, Machine.Here^, SizeOf(P));
          end
    else begin
      Machine.LogError(C^.Name + ' unknown code convension');
      Exit;
    end;
    //Log('Created command ' + C^.Name);
 // end;
end;

procedure __Callback(Machine: TForthMachine; Command: PForthCommand; DogWP: Pointer); stdcall;
begin
  Machine.CallCommand(Command);
end;

procedure callback_fun;
var
  Name: TString;
  C: PForthCommand;
begin
 // with Machine^ do begin
    Name := Machine.NextName;
    New(C);
    C^.Name := StrAlloc(Length(Name) + 1);
    StrCopy(C^.Name, PChar(Name));
    Machine.WUP(C);
    Machine.WUP(@Machine.FTypes[0]);
 // end;
end;

procedure callback_endfun;
var
  Conv: Integer;
  ReturnType: PType;
  T: PType;
  Types: array of PType;
  NewC, C2: PForthCommand;
  XT: PForthCommand;
  Sizes: array of Integer;
  I: Integer;
  F: File;
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then begin
      Machine.LogError(Command^.Name + ' command cannot work in compile mode');
      Exit;
    end;
    Conv := Machine.WOI;
    ReturnType := Machine.WOP;
    T := Machine.WOP;
    SetLength(Types, 0);
    while T <> @Machine.FTypes[0] do begin
      //Log(IntToStr(Length(Types)) + ': ' + T^.Name);
      SetLength(Types, Length(Types) + 1);
      Types[High(Types)] := T;
      T := Machine.WOP;
    end;
    C2 := Machine.WOP;
    //Log('Poped command ' + C2^.Name);
    NewC := Machine.ReserveName(TString(C2^.Name));
    StrDispose(C2^.Name);
    Dispose(C2);
    XT := WOP;
    NewC^.Code := PutDataPtr;
    SetLength(Sizes, Length(Types));
    for I := 0 to High(Types) do
      Sizes[I] := Types[I]^.Size;
    while (Integer(Machine.Here) mod 16) <> 6 do begin
      Byte(Machine.Here^) := 0;
      Machine.IncHere(1);
    end;
    // Machine.IncHere(22 - (Integer(Machine.Here) mod 16));
    // Writeln('AFTER INC HERE ', Integer(Machine.Here));
    NewC^.Data := Machine.Here;
    FAlien.GenerateCallback(Machine.Here, ES - EC, Sizes, ReturnType^.Size,
                            @Machine.WP, Machine, XT, @__Callback);
    // Writeln('@WP = ', TUInt(@Machine.WP), ' ', FAlien.MachineCode.GetError(nil), ' Machine=', Cardinal(Machine));
    Assign(F, 'generated.bin');
    Rewrite(F);
    BlockWrite(F, Machine.Here^, FAlien.MachineCode.Size);
    Close(F);
    Machine.IncHere(FAlien.MachineCode.Size);
    for I := 0 to 256 - 1 do begin
      Byte(Machine.Here^) := 0;
      Machine.IncHere(1);
    end;
  end;
end;

procedure invoke_stdcall(Machine: TForthMachine; Command: PForthCommand);
var
  Fun: Pointer;
  Stack: Pointer;
  Data: Pointer;
begin
  with Machine^ do begin
    Data := Command^.Data;
    Fun := Pointer(Command^.Data^);
    Stack := Machine.WP;
    asm
      mov ebx, Stack
      mov ecx, Data
      add ecx, 7 // пропускаем Fun и return-size
      jmp @startcycle
      @cycle:
        add ebx, eax
        push DWORD [ebx] // переносим очередной параметр на стек
        inc ecx
      @startcycle:
        movsx eax, BYTE [ecx] // получаем знаковое значение текущего байта
        cmp eax, 0
        jnz @cycle // если 0, то выходим из цикла
      @endcycle:
        mov Stack, ebx
        call [Fun] // вызываем функцию
        mov ebx,Stack
      @readeax:
        mov ecx,Data
        movsx ecx, BYTE [ecx+4] // нужно ли читать ecx
        cmp ecx, 0
        jz @readedx
        mov [ebx], eax
        add ebx, 4
      @readedx:
        mov ecx,Data
        movsx ecx, BYTE [ecx+5] // нужно ли читать edx
        cmp ecx, 0
        jz @readstack
        mov [ebx], edx
        add ebx, 4
      @readstack:
        mov ecx,Data
        movsx ecx, BYTE [ecx+6] // что читаем со стека
        cmp ecx, 0
        jz @endofcall
      @readstackloop:
        pop eax
        mov [ebx], eax
        add ebx, 4
        sub ecx, 4
        jnz @readstackloop
      @endofcall:
        mov Stack, ebx // запоминаем положение стека
    end;
    //Log('SUB: ' + IntToStr(TUInt(Machine.WP) - TUInt(Stack)));
    Machine.WP := Stack;
  end;
end;

procedure invoke_cdecl(Machine: TForthMachine; Command: PForthCommand);
begin
end;

procedure _conv_stdcall(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(CONV_STDCALL);
end;

procedure _conv_cdecl(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(CONV_CDECL);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

procedure LoadCommands(Machine: TForthMachine);
begin
{$IFNDEF FLAG_FPC}{$REGION 'alien commands'}{$ENDIF}
  Machine.AddCommand('lib-load', lib_load);
  Machine.AddCommand('lib-unload', lib_unload);
  Machine.AddCommand('lib-fun', lib_fun);
  Machine.AddCommand(':a', alien_fun);
  Machine.AddCommand('a;', alien_endfun);
  Machine.AddCommand(':c', callback_fun);
  Machine.AddCommand('c;', callback_endfun);
  Machine.AddCommand('stdcall', _conv_stdcall);
  Machine.AddCommand('cdecl', _conv_cdecl);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}  
end;

end.

uses
  DUtils in '..\..\source\DEngine\DUtils.pas',
  DDebug in '..\..\source\DEngine\DDebug.pas', 
  DParser in '..\..\source\DEngine\DParser.pas', 
  DMath in '..\..\source\DEngine\FPC\DMath.pas', 
  DEvents in '..\..\source\DEngine\DEvents.pas', 
  DClasses in '..\..\source\DEngine\DClasses.pas', 
  DWinApi in '..\..\source\DEngine\WINDOWS\DWinApi.pas', 
  DLib in '..\..\source\DEngine\WINDOWS\DLib.pas', 
  DMachineCode in '..\..\source\DMachineCode\DMachineCode.pas',
  Dx86 in '..\..\source\DMachineCode\Dx86.pas',
  DAlien in '..\..\source\DEmbro\DAlien.pas';

type
  TProc0 = procedure; stdcall;
  TProc1 = procedure (A: Integer); stdcall;
  TProc2 = procedure (A, B: Integer); stdcall;
  TProc3 = procedure (A, B, C: Integer); stdcall;
  TProc4 = procedure (A, B, C, D: Integer); stdcall;
  TFunc0 = function: Integer; stdcall;
  TFunc1 = function (A: Integer): Integer; stdcall;
  TFunc2 = function (A, B: Integer): Integer; stdcall;
  TFunc3 = function (A, B, C: Integer): Integer; stdcall;
  TFunc4 = function (A, B, C, D: Integer): Integer; stdcall;

var
  Alien: TAlien;
  Buffer: array[0..1024*1024*4] of Byte;
  BufferStart: Integer;
  Stack: array[0..1024*1024] of Integer;
  PStack: PInteger;
  PPStack: Pointer;
  F: File;
  Lib: TLib;
  Loop: procedure (Callback: TFunc4; A, B, C, D: Integer); stdcall;

procedure __Test(Machine: Pointer; Command: Pointer); stdcall;
var
  I: Integer;
begin
  Writeln('__Test(', Integer(Machine), ',', Integer(Command), ')');
  Write('  Stack:');
  for I := 0 to 14 do
    Write(' ', Stack[I]);
  Writeln;
  Writeln('  PStack: ', Integer(PStack));
  PStack^ := 1001001;
  Inc(PStack);
end;

function Fen(const A, Proc: Pointer; C, D: Integer): Integer; stdcall; assembler;
asm
  mov eax, PPStack
  mov ecx, DWORD [eax]
  mov edx, ecx

  mov eax, DWORD [ebp + 8]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 12]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 16]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 20]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, PPStack
  mov DWORD [eax], ecx

  push DWORD 11223344 // Command
  push DWORD 55667788 // Machine
  mov eax, DWORD [ebp + 12] // Proc
  call eax
  mov eax, DWORD [ebp + 8] // PPStack
  mov ecx, DWORD [eax]
  sub ecx, 4
  mov DWORD [eax], ecx
  mov eax, DWORD [ecx]
end;

function Fen2(const PPStack, Proc: Pointer; C, D: Integer): Integer; stdcall; assembler;
const
  S = 'FEN2';
asm
  mov eax, DWORD $EEEEEEEE
  mov ecx, DWORD [eax]
  mov edx, ecx

  mov eax, DWORD [ebp + 8]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 12]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 16]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD [ebp + 20]
  mov DWORD [ecx], eax
  add ecx, 4

  mov eax, DWORD $EEEEEEEE
  mov DWORD [eax], ecx

  push DWORD $55667788
  push DWORD $99AABBCC
  mov eax, DWORD $DDEEFF00
  call eax
  mov eax, DWORD $EEEEEEEE
  mov ecx, DWORD [eax]
  sub ecx, 4
  mov DWORD [eax], ecx
  mov eax, DWORD [ecx]
end;

function RealFen(PPSize, Proc, C, D: Integer): Integer; stdcall;
begin
end;

begin
  Alien := TAlien.Create;
  PStack := @Stack[0];
  PPStack := @PStack;
  BufferStart := 233;
  Alien.GenerateCallback(@Buffer[BufferStart], 64*1024, [4, 4, 4, 4], 4,
                         @PStack, Pointer($99AABBCC), Pointer($55667788), @__Test);  
  Assign(F, 'call_my.bin');
  Rewrite(F);
  BlockWrite(F, (@Buffer[BufferStart])^, Alien.MachineCode.Size);
  Close(F);
  Assign(F, 'call_fpc.bin');
  Rewrite(F);
  BlockWrite(F, (@Fen2)^, Alien.MachineCode.Size);
  Close(F);
  Lib := TLib.Create('Callback.dll');
  Loop := Lib.GetProcAddress('Loop2');
  Loop(@Fen, Integer(@PStack), Integer(@__Test), 1009009, 2009009);
  Loop(@Buffer[BufferStart], Integer(@PStack), Integer(@__Test), 1009009, 2009009);
  Lib.Free;
  Writeln('PStack: ', Integer(PStack));
  TFunc4(@Buffer[BufferStart])(12,13,14,15);
  TFunc4(@Buffer[BufferStart])(16,17,18,19);
  Writeln(TFunc4(@Fen)(Integer(@PStack), Integer(@__Test), 10, 20));
  Writeln(TFunc4(@Fen)(Integer(@PStack), Integer(@__Test), 1009009, 2009009));
  Writeln('PStack: ', Integer(PStack));
  Alien.Free;
end.

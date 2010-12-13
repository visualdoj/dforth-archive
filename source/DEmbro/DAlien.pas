unit DAlien;

interface

uses
  DUtils,
  DDebug,
  DMachineCode,
  Dx86;

type
TAlien = class
 private
  Fx86: Tx86;
  FMachineCode: TMachineCode;
 public
  constructor Create;
  destructor Destroy; override;
  function GenerateCallback(Ptr: Pointer; 
                             MaxSize: Integer;
                             const Sizes: array of Integer;
                             ReturnSize: Integer;
                             DogWP: Pointer;
                             Machine: Pointer;
                             Command: Pointer;
                             Code: Pointer): Boolean;
  property MachineCode: TMachineCode read FMachineCode;
end;

implementation

constructor TAlien.Create;
begin
  Fx86 := Tx86.Create(0);
  FMachineCode := Fx86;
end;

destructor TAlien.Destroy;
begin
  Fx86.Free;
end;

function TAlien.GenerateCallback;
var
  I, FullSize: Integer;
begin
  // Writeln('MaxSize: ', MaxSize);
  Fx86.SetData(Ptr, MaxSize);
  // push EBP
  // mov EBP, ESP
  Fx86.PUSH(EBP);
  Fx86.MOV(EBP, ESP);
  // mov ECX, [@WP]
  Fx86.MOV(ECX, Tx86d(DogWP));
  (* // mov eax, @WP *)
  (* // mov ecx, [eax] *)
  (* Fx86.MOV(EAX, DogWP); *)
  (* Fx86.MOV(ECX, [EAX]); *)

  FullSize := 0;
  for I := 0 to High(Sizes) do begin
    if Sizes[I] = 4 then begin
      // mov eax, [esp + 2*SizeOf(TInt) + FullSize]
      // mov [ecx], eax
      // add ecx, 4
      Fx86.MOV(EAX, [EBP], 8 + FullSize);
      Fx86.MOV([ECX], EAX);
      Fx86.ADD(ECX, 4);
    end else begin
      Result := False;
      Error('[TAlien.GenerateCallback]: underconstruction param size ' 
                    + IntToStr(Sizes[I]));
      Exit;
    end;
    Inc(FullSize, Sizes[I]);
  end;
  
  // mov [@WP], ecx ; update WP
  Fx86.MOV([DogWP], ECX);

  // ; invoking command
  Fx86.PUSH(Tx86d(Command)); // push Command
  Fx86.PUSH(Tx86d(Machine)); // push Machine
  // Fx86.CALL(Code); // call Code
  Fx86.MOV(EAX, LongInt(Code));
  Fx86.CALL(EAX);
    // // ; if cdecl
    // // pop eax
    // // pop eax
    // Fx86.POP(EAX);
    // Fx86.POP(EAX);
  // ; stdcall -- do nothing
  
  if ReturnSize = 4 then begin
    // mov ECX, [@WP]
    Fx86.MOV(ECX, LongInt(DogWP));
    Fx86.SUB(ECX, 4);
    Fx86.MOV(EAX, [ECX]);
    Fx86.MOV(DogWP, ECX);
  end else if ReturnSize = 0 then begin
    // ; nothing
    Fx86.MOV(EAX, LongInt(-1));
    Fx86.MOV(EDX, LongInt(-1));
  end else begin
    Result := False;
    Error('[TAlien.GenerateCallback]: underconstruction return size ' 
                  + IntToStr(ReturnSize));
    Exit;
  end;
  // leave
  Fx86.LEAVE;
  // ret FullSize
  Fx86.RETnear(FullSize);
  
  Result := not Fx86.IsError;
end;

end.

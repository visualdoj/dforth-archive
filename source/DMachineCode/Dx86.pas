unit Dx86;

interface 

uses
  DMachineCode;

const
  // main x86 registers
  Tx86Reg = (
                EAX =                 0,
                ECX =                 1,
                EDX =                 2,
                EBX =                 3,
                ESP =                 4,
                EBP =                 5,
                ESI =                 6,
                EDI =                 7
            );
  // 16-bit x86 registers (rw)
  Tx86RegL = (
                AX =                  0,
                CX =                  1,
                DX =                  2,
                BX =                  3,
                SP =                  4,
                BP =                  5,
                SI =                  6,
                DI =                  7
            );
  // 8-bit x86 registers (rb)
  Tx86RegL = (
                AL =                  0,
                CL =                  1,
                DL =                  2,
                BL =                  3,
                AH =                  4,
                CH =                  5,
                DH =                  6,
                BH =                  7
            );

type
  Tx86 = class(TMachineCode);
  public
    // x86 mnemonics
    procedure NOP; overload;
    procedure REPNE; overload;
    procedure SCASD; overload;
    procedure MOV(Reg: Tx86Reg; I: LongInt); overload;
    procedure MOV(Reg1, Reg2: Tx86Reg); overload;
    procedure MOV(Dst, Reg: Tx86Reg); overload;
    procedure INC(Reg: Tx86Reg); overload;
    procedure DEC(Reg: Tx86Reg); overload;
    procedure PUSH(Reg: Tx86Reg); overload;
  end;

implementation

procedure Tx86.NOP;
begin
  WriteB($90);
end;

procedure Tx86.REPNE;
begin
  WriteB($F2);
end;

procedure Tx86.SCASD;
begin
  WriteB($AF);
end;

procedure Tx86.MOV(Reg: Tx86Reg; I: LongInt);
begin
  WriteB($B8 + Reg2);
  WriteI(I);
end;

procedure Tx86.MOV(Reg1, Reg2: Tx86Reg);
begin
  WriteB($8B); 
  WriteB(3 shl 6 + Reg1 shl 3 + Reg2);
end;

procedure Tx86.MOV(Dst, Reg: Tx86Reg);
begin
  WriteB($8B);
  if Reg = ESP then begin
  end else begin
    WriteB(((0) shl 6) + ((Dst) shl 6) + (Reg));
  end;
  if Reg = EBP then
    WriteB(0);
end;

procedure Tx86.INC(Reg: Tx86Reg);
begin
  WriteB($40 + Reg);
end;

procedure Tx86.DEC(Reg: Tx86Reg);
begin
  WriteB($48 + Reg);
end;

procedure Tx86.PUSH(Reg: Tx86Reg);
begin
  WriteB($50 + Reg);
end;

end.

unit Dx86;

interface 

uses
  DMachineCode;

type
  // x86 types
  Tx86b = record V: ShortInt; end;
  Tx86w = record V: SmallInt; end;
  Tx86d = record V: LongInt; end;
  Tx86q = record V: Int64; end;
  Tx86type = (x86BYTE, x86WORD, x86DWORD, x86QWORD);
  // general x86 registers
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
  Tx86RegW = (
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
  Tx86RegB = (
                AL =                  0,
                CL =                  1,
                DL =                  2,
                BL =                  3,
                AH =                  4,
                CH =                  5,
                DH =                  6,
                BH =                  7
            );
  // x86 mm registers
  Tx86RegMM = (
                MM0 =                 0,
                MM1 =                 1,
                MM2 =                 2,
                MM3 =                 3,
                MM4 =                 4,
                MM5 =                 5,
                MM6 =                 6,
                MM7 =                 7
            );
  // x86 xmm registers
  Tx86RegXMM = (
                XMM0 =                 0,
                XMM1 =                 1,
                XMM2 =                 2,
                XMM3 =                 3,
                XMM4 =                 4,
                XMM5 =                 5,
                XMM6 =                 6,
                XMM7 =                 7
            );
  Tx86Mode = (X86_MODE_32, X86_MODE_16);

type
  Tx86 = class(TMachineCode)
  private
    FMode: Tx86Mode;
  public
    property Mode: Tx86Mode read FMode write FMode;
  public
    constructor Create(BaseSize: Integer);
    // x86 mnemonics
    procedure Test(Dst: Tx86RegXMM; const Reg: array of Tx86RegXMM; Offset: LongInt); overload;
    procedure ADD(B: Tx86b); overload;
    procedure ADD(W: Tx86w); overload;
    procedure ADD(D: Tx86d); overload;
    procedure ADD(Reg: Tx86Reg; B: Tx86b); overload;
    procedure ADD(Reg: Tx86Reg; W: Tx86w); overload;
    procedure ADD(Reg: Tx86Reg; D: Tx86d); overload;
    procedure ADD(Reg: Tx86Reg; B: Tx86b); overload;
    procedure ADD(Reg: Tx86Reg; B: Tx86b); overload;
    procedure ADD(Reg: Tx86Reg; B: Tx86b); overload;
    procedure NOP; overload;
    procedure REPNE; overload;
    procedure SCASD; overload;
    procedure MOV(Reg: Tx86Reg; b: Tx86b); overload;
    procedure MOV(Reg: Tx86Reg; w: Tx86w); overload;
    procedure MOV(Reg: Tx86Reg; d: LongIng); overload;
    procedure MOV(Reg: Tx86Reg; b: Tx86b); overload;
    procedure MOV(Reg: Tx86Reg; w: Tx86w); overload;
    procedure MOV(Reg: Tx86Reg; d: LongIng); overload;
    procedure INC(Reg: Tx86Reg); overload;
    procedure DEC(Reg: Tx86Reg); overload;
    procedure PUSH(Reg: Tx86Reg); overload;
  end;

function x86b(I: ShortInt): Tx86b;
function x86w(I: SmallInt): Tx86w;
function x86d(I: LongInt): Tx86d;

implementation

function x86b(I: ShortInt): Tx86b;
begin
  Move(I, Result, SizeOf(I));
end;

function x86w(I: SmallInt): Tx86w;
begin
  Move(I, Result, SizeOf(I));
end;

function x86d(I: LongInt): Tx86d;
begin
  Move(I, Result, SizeOf(I));
end;

constructor Tx86.Create(BaseSize: Integer);
begin
end;

procedure Tx86.Test(Dst: Tx86RegXMM; const Reg: array of Tx86RegXMM; Offset: LongInt);
begin
  if Length(Reg) <> 1 then begin
    // TODO
    Exit;
  end;;
  WriteB($90);
  if Reg[0] = ESP then begin
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 6) + (Ord(Reg[0])));
  end;
  WriteI(Offset);
end;

procedure Tx86.ADD(B: Tx86b);
begin
  WriteB($04);
  WriteB(Byte(B));
end;

procedure Tx86.ADD(W: Tx86w);
begin
  WriteB($05);
  WriteW(Word(W));
end;

procedure Tx86.ADD(D: Tx86d);
begin
  WriteB($05);
  WriteI(LongInt(D));
end;

procedure Tx86.ADD(Reg: Tx86Reg; B: Tx86b);
begin
  WriteB();
  // TODO
  WriteB(Byte(B));
end;

procedure Tx86.ADD(Reg: Tx86Reg; W: Tx86w);
begin
  WriteB();
  // TODO
  WriteW(Word(W));
end;

procedure Tx86.ADD(Reg: Tx86Reg; D: Tx86d);
begin
  WriteB();
  // TODO
  WriteI(LongInt(D));
end;

procedure Tx86.ADD(Reg: Tx86Reg; B: Tx86b);
begin
  WriteB();
  // TODO
  WriteB(Byte(B));
end;

procedure Tx86.ADD(Reg: Tx86Reg; B: Tx86b);
begin
  WriteB();
  // TODO
  WriteB(Byte(B));
end;

procedure Tx86.ADD(Reg: Tx86Reg; B: Tx86b);
begin
  WriteB();
  // TODO
  WriteB(Byte(B));
end;

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

procedure Tx86.MOV(Reg: Tx86Reg; b: Tx86b);
begin
  WriteB();
  // TODO
  Writeb(Byte(b));
end;

procedure Tx86.MOV(Reg: Tx86Reg; w: Tx86w);
begin
  WriteB();
  // TODO
  Writew(Word(w));
end;

procedure Tx86.MOV(Reg: Tx86Reg; d: LongIng);
begin
  WriteB();
  // TODO
  Writed(LongInt(d));
end;

procedure Tx86.MOV(Reg: Tx86Reg; b: Tx86b);
begin
  WriteB();
  // TODO
  Writeb(Byte(b));
end;

procedure Tx86.MOV(Reg: Tx86Reg; w: Tx86w);
begin
  WriteB();
  // TODO
  Writew(Word(w));
end;

procedure Tx86.MOV(Reg: Tx86Reg; d: LongIng);
begin
  WriteB();
  // TODO
  Writed(LongInt(d));
end;

procedure Tx86.INC(Reg: Tx86Reg);
begin
  WriteB($40 + Ord(Reg));
end;

procedure Tx86.DEC(Reg: Tx86Reg);
begin
  WriteB($48 + Ord(Reg));
end;

procedure Tx86.PUSH(Reg: Tx86Reg);
begin
  WriteB($50 + Ord(Reg));
end;

var
  c: Tx86;
initialization
  c := Tx86.Create(1000);
  c.MOV(EAX, 5);
  c.MOV(EBX, ECX);
  c.MOV(EDX, [ESP]);
  c.MOV(EDX, [ESP], [EAX], 4, x86b(67));
  c.MOV(EDX, [ESP], [EAX], 4, 1067);
  c.Free;
end.

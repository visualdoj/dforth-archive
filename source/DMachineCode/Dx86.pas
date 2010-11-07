unit Dx86;

interface 

uses
  DMachineCode;

type
  // x86 types
  Tx86b = packed record V: ShortInt; end;
  Tx86w = packed record V: SmallInt; end;
  Tx86d = packed record V: LongInt;  end;
  Tx86q = packed record V: Int64;    end;
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
  // x86 Sreg register
  Tx86RegSreg = ( 
                ES =                    0,
                CS =                    1,
                SS =                    2,
                DS =                    3,
                FS =                    4,
                GS =                    5
                );
  // x86 modes
  Tx86Mode = (X86_MODE_32, X86_MODE_16);
  // coeff in [register1 + register2*mul + offset]
  Tx86Mul = (m1 = 0, m2 = 1, m4 = 2, m8 = 3);

type
  Tx86 = class(TMachineCode)
  private
    FMode: Tx86Mode;
  public
    property Mode: Tx86Mode read FMode write FMode;
  public
    constructor Create(BaseSize: Integer);
    // x86 mnemonics
    procedure ADD(B: Tx86b); overload;
    procedure ADD(W: Tx86w); overload;
    procedure ADD(D: Tx86d); overload;
    procedure ADD(D: LongInt); overload;
    procedure ADD(Reg: Tx86RegB; B: Tx86b); overload;
    procedure ADD(Reg: Tx86RegW; W: Tx86w); overload;
    procedure ADD(Reg: Tx86Reg; D: LongInt); overload;
    procedure ADD(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure ADD(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure ADD(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure NOP; overload;
    procedure REPNE; overload;
    procedure SCASD; overload;
    procedure _OR(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure _OR(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure _OR(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure _OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure ADC(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure ADC(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure ADC(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure SBB(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure SBB(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure SBB(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _AND(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure _AND(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure _AND(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure _AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure SUB(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure SUB(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure SUB(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure _XOR(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure _XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure _XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure CMP(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure CMP(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure CMP(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure XCHNG(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure MOV(Dst, Src: Tx86RegB); overload;
    procedure MOV(Dst, Src: Tx86RegW); overload;
    procedure MOV(Dst, Src: Tx86Reg); overload;
    procedure MOV(Reg: Tx86RegB; B: Tx86b); overload;
    procedure MOV(Reg: Tx86RegW; W: Tx86w); overload;
    procedure MOV(Reg: Tx86Reg; D: LongInt); overload;
    procedure MOV(Reg: Tx86RegW; S: Tx86RegSreg); overload;
    procedure MOV(S: Tx86RegSreg; Reg: Tx86RegW); overload;
    procedure MOV(M: Tx86w; S: Tx86RegSreg); overload;
    procedure MOV(S: Tx86RegSreg; M: Tx86w); overload;
    procedure MOV(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure MOV(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure MOV(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure INC(Reg: Tx86Reg); overload;
    procedure DEC(Reg: Tx86Reg); overload;
    procedure PUSH(Reg: Tx86Reg); overload;
    procedure POP(Reg: Tx86Reg); overload;
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
  inherited Create(BaseSize);
  FMode := X86_MODE_32;
end;

procedure Tx86.ADD(B: Tx86b);
begin
  WriteB($04);
  WriteB(Byte(B));
end;

procedure Tx86.ADD(W: Tx86w);
begin
  if FMode = X86_MODE_16 then
    WriteB($66); 
  WriteB($05);
  WriteW(Word(W));
end;

procedure Tx86.ADD(D: Tx86d);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($05);
  WriteI(LongInt(D));
end;

procedure Tx86.ADD(D: LongInt);
begin
  if (D >= -128) and (D <= 127) then
    ADD(x86b(ShortInt(D)))
  else if (D >= -32768) and (D <= 32767) then
    ADD(x86w(SmallInt(D)))
  else
    ADD(x86d(D));
end;

procedure Tx86.ADD(Reg: Tx86RegB; B: Tx86b);
begin
  WriteB($80 + Ord(Reg));
  WriteB(Byte(B));
end;

procedure Tx86.ADD(Reg: Tx86RegW; W: Tx86w);
begin
  WriteB($81 + Ord(Reg));
  WriteW(Word(W));
end;

procedure Tx86.ADD(Reg: Tx86Reg; D: LongInt);
begin
  WriteB($81 + Ord(Reg));
  WriteI(LongInt(D));
end;

procedure Tx86.ADD(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($03);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($03);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($03);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($03);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($03);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($03);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADD(Dst, Src, x86b(Offset))
  else
    ADD(Dst, Src, x86d(Offset))
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    ADD(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    ADD(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($03);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
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

procedure Tx86._OR(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($0B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($0B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($0B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($0B);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($0B);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($0B);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _OR(Dst, Src, x86b(Offset))
  else
    _OR(Dst, Src, x86d(Offset))
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    _OR(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    _OR(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($0B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($13);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($13);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($13);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($13);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($13);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($13);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADC(Dst, Src, x86b(Offset))
  else
    ADC(Dst, Src, x86d(Offset))
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    ADC(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    ADC(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($13);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($1B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($1B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($1B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($1B);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($1B);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($1B);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SBB(Dst, Src, x86b(Offset))
  else
    SBB(Dst, Src, x86d(Offset))
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    SBB(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    SBB(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($1B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _AND(Dst, Src, x86b(Offset))
  else
    _AND(Dst, Src, x86d(Offset))
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    _AND(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    _AND(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SUB(Dst, Src, x86b(Offset))
  else
    SUB(Dst, Src, x86d(Offset))
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    SUB(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    SUB(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _XOR(Dst, Src, x86b(Offset))
  else
    _XOR(Dst, Src, x86d(Offset))
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    _XOR(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    _XOR(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($23);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _XOR(Dst, Src, x86b(Offset))
  else
    _XOR(Dst, Src, x86d(Offset))
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    _XOR(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    _XOR(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($3B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($3B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($3B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($3B);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($3B);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($3B);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    CMP(Dst, Src, x86b(Offset))
  else
    CMP(Dst, Src, x86d(Offset))
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    CMP(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    CMP(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($3B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($87);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($87);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($87);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    XCHNG(Dst, Src, x86b(Offset))
  else
    XCHNG(Dst, Src, x86d(Offset))
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    XCHNG(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    XCHNG(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($87);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($89);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($89);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($89);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    XCHNG(Dst, Src, x86b(Offset))
  else
    XCHNG(Dst, Src, x86d(Offset))
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    XCHNG(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    XCHNG(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHNG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHNG(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($89);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst, Src: Tx86RegB);
begin
  WriteB($88); 
  WriteB(((3) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src)));
end;

procedure Tx86.MOV(Dst, Src: Tx86RegW);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);; 
  WriteB($89);
  WriteB(((3) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src)));
end;

procedure Tx86.MOV(Dst, Src: Tx86Reg);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);;
  WriteB($89); 
  WriteB(((3) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src)));
end;

procedure Tx86.MOV(Reg: Tx86RegB; B: Tx86b);
begin
  WriteB($B0 + Ord(Reg));
  WriteB(Byte(B));
end;

procedure Tx86.MOV(Reg: Tx86RegW; W: Tx86w);
begin
  WriteB($B8 + Ord(Reg));
  WriteW(Word(W));
end;

procedure Tx86.MOV(Reg: Tx86Reg; D: LongInt);
begin
  WriteB($B8 + Ord(Reg));
  WriteI(LongInt(D));
end;

procedure Tx86.MOV(Reg: Tx86RegW; S: Tx86RegSreg);
begin
  WriteB($8C); // TODO
end;

procedure Tx86.MOV(S: Tx86RegSreg; Reg: Tx86RegW);
begin
  WriteB($8E); // TODO
end;

procedure Tx86.MOV(M: Tx86w; S: Tx86RegSreg);
begin
  WriteB($8C); // TODO
end;

procedure Tx86.MOV(S: Tx86RegSreg; M: Tx86w);
begin
  WriteB($8E); // TODO
end;

procedure Tx86.MOV(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($8B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($8B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($8B);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($8B);
  if Src[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Src[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($8B);
  if Src[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end;
  WriteB($8B);
  if Src[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Dst)) shl 3) + (Ord(Src[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    MOV(Dst, Src, x86b(Offset))
  else
    MOV(Dst, Src, x86d(Offset))
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    // TODO
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(SmallInt) <= Offset) and (Offset <= High(SmallInt)) then
    MOV(Dst, Src1, Src2, Mul, dx86b(Offset))
  else
    MOV(Dst, Src1, Src2, Mul, dx86d(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    // TODO
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    // TODO ТАК ДЕЛАТЬ НЕЛЬЗЯ!
    Exit;
  end;
  WriteB($8B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
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

procedure Tx86.POP(Reg: Tx86Reg);
begin
  WriteB($58 + Ord(Reg));
end;

var
  c: Tx86;
initialization
  c := Tx86.Create(1000);
  c.MOV(EAX, 5);
  c.MOV(EBX, ECX);
  //c.MOV(EDX, [ESP]);
  //c.MOV(EDX, [ESP], [EAX], 4, x86b(67));
  //c.MOV(EDX, [ESP], [EAX], 4, 1067);
  c.Free;
end.

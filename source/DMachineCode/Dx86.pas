unit Dx86;

interface 

uses
  DMachineCode;

const
  // errors
  X86_ERROR_ESP                                 = 1;
  X86_ERROR_K_PARAM_ONE                         = 2;

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
  // x86 segment register
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
    procedure ADD(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure ADD(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure ADD(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure _OR(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure _OR(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure _OR(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure ADC(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure ADC(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure ADC(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure SBB(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure SBB(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure SBB(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure _AND(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure _AND(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure _AND(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure SUB(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure SUB(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure SUB(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure _XOR(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure _XOR(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure _XOR(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure _XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure _XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
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
    procedure CMP(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure CMP(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure CMP(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure TEST(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure TEST(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure TEST(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure XCHG(Dst: Tx86Reg; Ptr: Tx86d); overload;
    procedure XCHG(Dst: Tx86Reg; Ptr: Pointer); overload;
    procedure XCHG(Dst: Tx86Reg; Ptr: Cardinal); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt); overload;
    procedure XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
    procedure XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b); overload;
    procedure XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d); overload;
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
    procedure MOV(Ptr: Tx86d; Src: Tx86Reg); overload;
    procedure MOV(Ptr: Pointer; Src: Tx86Reg); overload;
    procedure MOV(Ptr: Cardinal; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg); overload;
    procedure MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg); overload;
    procedure MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg); overload;
    procedure INC(Reg: Tx86Reg); overload;
    procedure DEC(Reg: Tx86Reg); overload;
    procedure PUSH(Reg: Tx86Reg); overload;
    procedure POP(Reg: Tx86Reg); overload;
    procedure JA(Rel: Tx86b); overload;
    procedure JAE(Rel: Tx86b); overload;
    procedure JB(Rel: Tx86b); overload;
    procedure JBE(Rel: Tx86b); overload;
    procedure JC(Rel: Tx86b); overload;
    procedure JCXZ(Rel: Tx86b); overload;
    procedure JECXZ(Rel: Tx86b); overload;
    procedure JRCXZ(Rel: Tx86b); overload;
    procedure JE(Rel: Tx86b); overload;
    procedure JG(Rel: Tx86b); overload;
    procedure JGE(Rel: Tx86b); overload;
    procedure JL(Rel: Tx86b); overload;
    procedure JLE(Rel: Tx86b); overload;
    procedure JNA(Rel: Tx86b); overload;
    procedure JNAE(Rel: Tx86b); overload;
    procedure JNB(Rel: Tx86b); overload;
    procedure JNBE(Rel: Tx86b); overload;
    procedure JNE(Rel: Tx86b); overload;
    procedure JNG(Rel: Tx86b); overload;
    procedure JNGE(Rel: Tx86b); overload;
    procedure JNL(Rel: Tx86b); overload;
    procedure JNLE(Rel: Tx86b); overload;
    procedure JNO(Rel: Tx86b); overload;
    procedure JNP(Rel: Tx86b); overload;
    procedure JNS(Rel: Tx86b); overload;
    procedure JNZ(Rel: Tx86b); overload;
    procedure JO(Rel: Tx86b); overload;
    procedure JP(Rel: Tx86b); overload;
    procedure JPE(Rel: Tx86b); overload;
    procedure JPO(Rel: Tx86b); overload;
    procedure JS(Rel: Tx86b); overload;
    procedure JZ(Rel: Tx86b); overload;
    procedure JA(Rel: Tx86d); overload;
    procedure JAE(Rel: Tx86d); overload;
    procedure JB(Rel: Tx86d); overload;
    procedure JBE(Rel: Tx86d); overload;
    procedure JC(Rel: Tx86d); overload;
    procedure JZ(Rel: Tx86d); overload;
    procedure JG(Rel: Tx86d); overload;
    procedure JGE(Rel: Tx86d); overload;
    procedure JL(Rel: Tx86d); overload;
    procedure JLE(Rel: Tx86d); overload;
    procedure JNA(Rel: Tx86d); overload;
    procedure JNAE(Rel: Tx86d); overload;
    procedure JNB(Rel: Tx86d); overload;
    procedure JNBE(Rel: Tx86d); overload;
    procedure JNC(Rel: Tx86d); overload;
    procedure JNE(Rel: Tx86d); overload;
    procedure JNG(Rel: Tx86d); overload;
    procedure JNGE(Rel: Tx86d); overload;
    procedure JNL(Rel: Tx86d); overload;
    procedure JNLE(Rel: Tx86d); overload;
    procedure JNO(Rel: Tx86d); overload;
    procedure JNP(Rel: Tx86d); overload;
    procedure JNS(Rel: Tx86d); overload;
    procedure JNZ(Rel: Tx86d); overload;
    procedure JO(Rel: Tx86d); overload;
    procedure JP(Rel: Tx86d); overload;
    procedure JPE(Rel: Tx86d); overload;
    procedure JPO(Rel: Tx86d); overload;
    procedure JS(Rel: Tx86d); overload;
    procedure JA(Rel: Tx86w); overload;
    procedure JAE(Rel: Tx86w); overload;
    procedure JB(Rel: Tx86w); overload;
    procedure JBE(Rel: Tx86w); overload;
    procedure JC(Rel: Tx86w); overload;
    procedure JZ(Rel: Tx86w); overload;
    procedure JG(Rel: Tx86w); overload;
    procedure JGE(Rel: Tx86w); overload;
    procedure JL(Rel: Tx86w); overload;
    procedure JLE(Rel: Tx86w); overload;
    procedure JNA(Rel: Tx86w); overload;
    procedure JNAE(Rel: Tx86w); overload;
    procedure JNB(Rel: Tx86w); overload;
    procedure JNBE(Rel: Tx86w); overload;
    procedure JNC(Rel: Tx86w); overload;
    procedure JNE(Rel: Tx86w); overload;
    procedure JNG(Rel: Tx86w); overload;
    procedure JNGE(Rel: Tx86w); overload;
    procedure JNL(Rel: Tx86w); overload;
    procedure JNLE(Rel: Tx86w); overload;
    procedure JNO(Rel: Tx86w); overload;
    procedure JNP(Rel: Tx86w); overload;
    procedure JNS(Rel: Tx86w); overload;
    procedure JNZ(Rel: Tx86w); overload;
    procedure JO(Rel: Tx86w); overload;
    procedure JP(Rel: Tx86w); overload;
    procedure JPE(Rel: Tx86w); overload;
    procedure JPO(Rel: Tx86w); overload;
    procedure JS(Rel: Tx86w); overload;
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

procedure Tx86.ADD(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($01);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($01);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($01);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($01);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($01);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($01);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADD(Dst, x86b(Offset), Src)
  else
    ADD(Dst, x86d(Offset), Src)
end;

procedure Tx86.ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADD(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    ADD(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($01);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($03);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADD(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    ADD(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($03);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADD(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADD(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($0B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _OR(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    _OR(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($0B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._OR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($0B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($09);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($09);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($09);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($09);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($09);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($09);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _OR(Dst, x86b(Offset), Src)
  else
    _OR(Dst, x86d(Offset), Src)
end;

procedure Tx86._OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _OR(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    _OR(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._OR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _OR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($09);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($13);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADC(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    ADC(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($13);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADC(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($13);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($11);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($11);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($11);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($11);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($11);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($11);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADC(Dst, x86b(Offset), Src)
  else
    ADC(Dst, x86d(Offset), Src)
end;

procedure Tx86.ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    ADC(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    ADC(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.ADC(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      ADC(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($11);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($1B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SBB(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    SBB(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($1B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SBB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($1B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($10);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($10);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($10);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($10);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($10);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($10);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SBB(Dst, x86b(Offset), Src)
  else
    SBB(Dst, x86d(Offset), Src)
end;

procedure Tx86.SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SBB(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    SBB(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SBB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SBB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($10);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _AND(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    _AND(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._AND(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _AND(Dst, x86b(Offset), Src)
  else
    _AND(Dst, x86d(Offset), Src)
end;

procedure Tx86._AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _AND(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    _AND(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._AND(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _AND(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SUB(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    SUB(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SUB(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SUB(Dst, x86b(Offset), Src)
  else
    SUB(Dst, x86d(Offset), Src)
end;

procedure Tx86.SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    SUB(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    SUB(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.SUB(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      SUB(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _XOR(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    _XOR(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($23);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($21);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _XOR(Dst, x86b(Offset), Src)
  else
    _XOR(Dst, x86d(Offset), Src)
end;

procedure Tx86._XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    _XOR(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    _XOR(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86._XOR(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      _XOR(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($21);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($3B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    CMP(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    CMP(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($3B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.CMP(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($3B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($39);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($39);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($39);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($39);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($39);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($39);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    CMP(Dst, x86b(Offset), Src)
  else
    CMP(Dst, x86d(Offset), Src)
end;

procedure Tx86.CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    CMP(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    CMP(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.CMP(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      CMP(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($39);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($85);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.TEST(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($85);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.TEST(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($85);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($85);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($85);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($85);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    TEST(Dst, x86b(Offset), Src)
  else
    TEST(Dst, x86d(Offset), Src)
end;

procedure Tx86.TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      TEST(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    TEST(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    TEST(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      TEST(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      TEST(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.TEST(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      TEST(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($85);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; Ptr: Tx86d);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; Ptr: Pointer);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; Ptr: Cardinal);
begin
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(Dst)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    XCHG(Dst, Src, x86b(Offset))
  else
    XCHG(Dst, Src, x86d(Offset))
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
  if Src1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      XCHG(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    XCHG(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    XCHG(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHG(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHG(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.XCHG(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      XCHG(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($87);
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src1 must have only one element');
    Exit;
  end; 
  if Length(Src2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src2 must have only one element');
    Exit;
  end;
  if Src2[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src2, Src1, Mul, Offset);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($8B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Src2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src1: array of Tx86Reg; const Src2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    MOV(Dst, Src1, Src2, Mul, x86b(Offset))
  else
    MOV(Dst, Src1, Src2, Mul, x86d(Offset));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($8B);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.MOV(Dst: Tx86Reg; const Src: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b);
begin
  if Length(Src) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
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
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Src must have only one element');
    Exit;
  end; 
  if Src[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($8B);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Dst)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(Ptr: Tx86d; Src: Tx86Reg);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(Ptr: Pointer; Src: Tx86Reg);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(Ptr: Cardinal; Src: Tx86Reg);
begin
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
  Write(@Ptr, SizeOf(Ptr));
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($89);
  if Dst[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(EBP)));
    WriteB(0);
  end else if Dst[0] = ESP then begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((0) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($89);
  if Dst[0] = ESP then begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(ESP)));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((1) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end;
  WriteB($89);
  if Dst[0] = ESP then begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(0)));
  end else begin
    WriteB(((2) shl 6) + ((Ord(Src)) shl 3) + (Ord(Dst[0])));
  end;
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    MOV(Dst, x86b(Offset), Src)
  else
    MOV(Dst, x86d(Offset), Src)
end;

procedure Tx86.MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  if Dst1[0] = EBP then begin
    WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  end else
    WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst1) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst1 must have only one element');
    Exit;
  end; 
  if Length(Dst2) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst2 must have only one element');
    Exit;
  end;
  if Dst2[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst1, Dst2, Mul, Offset, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(Dst2[0])) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(const Dst1: array of Tx86Reg; const Dst2: array of Tx86Reg; Mul: Tx86Mul; Offset: LongInt; Src: Tx86Reg);
begin
  if (Low(ShortInt) <= Offset) and (Offset <= High(ShortInt)) then
    MOV(Dst1, Dst2, Mul, x86b(Offset), Src)
  else
    MOV(Dst1, Dst2, Mul, x86d(Offset), Src);
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  WriteB(((0) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86b; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  WriteB(((1) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
  WriteB(((Ord(Mul)) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Ord(Mul))));
  Write(@Offset, SizeOf(Offset));
end;

procedure Tx86.MOV(const Dst: array of Tx86Reg; Mul: Tx86Mul; Offset: Tx86d; Src: Tx86Reg);
begin
  if Length(Dst) <> 1 then begin
    AddError(X86_ERROR_K_PARAM_ONE, FSize, 'Parameter Dst must have only one element');
    Exit;
  end; 
  if Dst[0] = ESP then begin
    if Mul = m1 then begin
      MOV(Dst, Src);
      Exit;
    end;
    AddError(X86_ERROR_ESP, FSize, 'It''s impossible to use ESP register as second register');
    Exit;
  end;
  WriteB($89);
  WriteB(((2) shl 6) + ((Ord(ESP)) shl 3) + (Ord(Src)));
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

procedure Tx86.JA(Rel: Tx86b);
begin
  
  WriteB($77);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JAE(Rel: Tx86b);
begin
  
  WriteB($73);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JB(Rel: Tx86b);
begin
  
  WriteB($72);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JBE(Rel: Tx86b);
begin
  
  WriteB($76);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JC(Rel: Tx86b);
begin
  
  WriteB($72);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JCXZ(Rel: Tx86b);
begin
  
  WriteB($E3);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JECXZ(Rel: Tx86b);
begin
  
  WriteB($E3);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JRCXZ(Rel: Tx86b);
begin
  
  WriteB($E3);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JE(Rel: Tx86b);
begin
  
  WriteB($74);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JG(Rel: Tx86b);
begin
  
  WriteB($7F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JGE(Rel: Tx86b);
begin
  
  WriteB($7D);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JL(Rel: Tx86b);
begin
  
  WriteB($7C);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JLE(Rel: Tx86b);
begin
  
  WriteB($7E);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNA(Rel: Tx86b);
begin
  
  WriteB($76);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNAE(Rel: Tx86b);
begin
  
  WriteB($72);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNB(Rel: Tx86b);
begin
  
  WriteB($73);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNBE(Rel: Tx86b);
begin
  
  WriteB($77);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNE(Rel: Tx86b);
begin
  
  WriteB($75);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNG(Rel: Tx86b);
begin
  
  WriteB($7E);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNGE(Rel: Tx86b);
begin
  
  WriteB($7C);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNL(Rel: Tx86b);
begin
  
  WriteB($7D);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNLE(Rel: Tx86b);
begin
  
  WriteB($7F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNO(Rel: Tx86b);
begin
  
  WriteB($71);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNP(Rel: Tx86b);
begin
  
  WriteB($7B);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNS(Rel: Tx86b);
begin
  
  WriteB($79);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNZ(Rel: Tx86b);
begin
  
  WriteB($75);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JO(Rel: Tx86b);
begin
  
  WriteB($70);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JP(Rel: Tx86b);
begin
  
  WriteB($7A);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPE(Rel: Tx86b);
begin
  
  WriteB($7A);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPO(Rel: Tx86b);
begin
  
  WriteB($7B);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JS(Rel: Tx86b);
begin
  
  WriteB($78);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JZ(Rel: Tx86b);
begin
  
  WriteB($74);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JA(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JAE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JB(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JBE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JC(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JZ(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JG(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JGE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JL(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JLE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNA(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNAE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNB(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNBE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNC(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNG(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNGE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNL(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNLE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNO(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNP(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNS(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNZ(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JO(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JP(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPE(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPO(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JS(Rel: Tx86d);
begin
  if FMode = X86_MODE_16 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JA(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JAE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JB(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JBE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JC(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JZ(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JG(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JGE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JL(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JLE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNA(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNAE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNB(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNBE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNC(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNG(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNGE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNL(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNLE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNO(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNP(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNS(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JNZ(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JO(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JP(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPE(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JPO(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
end;

procedure Tx86.JS(Rel: Tx86w);
begin
  if FMode = X86_MODE_32 then
    WriteB($66);
  WriteB($0F);  
  Write(@Rel, SizeOf(Rel));
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

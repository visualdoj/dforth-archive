unit DArm;

interface

uses
  DMachineCode;


type
  TArmReg =     (
                        r0      = 0,
                        r1      = 1,
                        r2      = 2,
                        r3      = 3,
                        r4      = 4,
                        r5      = 5,
                        r6      = 6,
                        r7      = 7,
                        r8      = 8,
                        r9      = 9,
                        r10     = 10,
                        r11     = 11,
                        r12     = 12,
                        r13     = 13,
                        r14     = 14,
                        r15     = 15
                );
  TArmPSR  =       (
                        CPSR    = 0,
                        SPSR    = 1
                );
  TArmPSRf  =       (
                        CPSR_flg        = 0,
                        SPSR_flg        = 1
                );
  TArmSign =
                (
                        ARM_MINUS       = 0,
                        ARM_PLUS        = 1
                );
  TArmWriteBack =
                (
                        ARM_DONOTWRITE  = 0,
                        ARM_WRITE       = 1
                );

const
  // alternative registers' names
  sp = r13;
  lr = r14;
  pc = r15;
  CPSR_all = CPSR;
  SPSR_all = SPSR;

type
  TArm = class(TMachineCode)
  private
  public
  public
    constructor Create(BaseSize: Integer);
    // arm mnemonics
  
  // data processing (arithmetic & logic)
    procedure WriteDataTrans(C, I, O, S, N, D: Byte; R: Cardinal); overload;
    procedure WriteDataTransR(C, O, S: Byte; N, D, R: TArmReg; F: Byte); overload;
    procedure WriteDataTransI(C, O, S: Byte; N, D: TArmReg; I, R: Byte); overload;
  // branch menmonics
    procedure B(Offset: Cardinal); overload;
    procedure BEQ(Offset: Cardinal); overload;
    procedure BNE(Offset: Cardinal); overload;
    procedure BHS(Offset: Cardinal); overload;
    procedure BCS(Offset: Cardinal); overload;
    procedure BLO(Offset: Cardinal); overload;
    procedure BCC(Offset: Cardinal); overload;
    procedure BMI(Offset: Cardinal); overload;
    procedure BPL(Offset: Cardinal); overload;
    procedure BVS(Offset: Cardinal); overload;
    procedure BVC(Offset: Cardinal); overload;
    procedure BHI(Offset: Cardinal); overload;
    procedure BLS(Offset: Cardinal); overload;
    procedure BGE(Offset: Cardinal); overload;
    procedure BLT(Offset: Cardinal); overload;
    procedure BGT(Offset: Cardinal); overload;
    procedure BLE(Offset: Cardinal); overload;
    procedure BAL(Offset: Cardinal); overload;
    procedure BNV(Offset: Cardinal); overload;
    procedure BL(Offset: Cardinal); overload;
    procedure BLEQ(Offset: Cardinal); overload;
    procedure BLNE(Offset: Cardinal); overload;
    procedure BLHS(Offset: Cardinal); overload;
    procedure BLCS(Offset: Cardinal); overload;
    procedure BLLO(Offset: Cardinal); overload;
    procedure BLCC(Offset: Cardinal); overload;
    procedure BLMI(Offset: Cardinal); overload;
    procedure BLPL(Offset: Cardinal); overload;
    procedure BLVS(Offset: Cardinal); overload;
    procedure BLVC(Offset: Cardinal); overload;
    procedure BLHI(Offset: Cardinal); overload;
    procedure BLLS(Offset: Cardinal); overload;
    procedure BLGE(Offset: Cardinal); overload;
    procedure BLLT(Offset: Cardinal); overload;
    procedure BLGT(Offset: Cardinal); overload;
    procedure BLLE(Offset: Cardinal); overload;
    procedure BLAL(Offset: Cardinal); overload;
    procedure BLNV(Offset: Cardinal); overload;
    procedure _AND(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure _ANDS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure _AND(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure _ANDS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ANDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ANDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ANDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EOR(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EOR(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EOREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EOREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EOREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EOREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure EORNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure EORNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure EORNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUB(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUB(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SUBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SUBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SUBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSB(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSB(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADD(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADD(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ADCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ADCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ADCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure SBCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure SBCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure SBCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure RSCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure RSCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure RSCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TST(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TST(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TSTNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TSTNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TSTNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure TEQNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure TEQNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure TEQNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMP(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMP(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMPNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMPNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMPNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMN(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMN(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure CMNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure CMNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure CMNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORR(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORR(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure ORRNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure ORRNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure ORRNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MOVNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MOVNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MOVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BIC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BIC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure BICNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure BICNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure BICNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVN(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVN(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0); overload;
    procedure MVNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0); overload;
    procedure MVNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload;
    procedure MVNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0); overload; 
  // PSR transfer (for CPSR and SPSR registers)
    procedure MRS(r: TArmReg; p: TArmPSR); overload;
    procedure MSR(p: TArmPSR; r: TArmReg); overload;
    procedure MSR(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSR(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSEQ(r: TArmReg; p: TArmPSR); overload;
    procedure MSREQ(p: TArmPSR; r: TArmReg); overload;
    procedure MSREQ(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSREQ(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSNE(r: TArmReg; p: TArmPSR); overload;
    procedure MSRNE(p: TArmPSR; r: TArmReg); overload;
    procedure MSRNE(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRNE(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSHS(r: TArmReg; p: TArmPSR); overload;
    procedure MSRHS(p: TArmPSR; r: TArmReg); overload;
    procedure MSRHS(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRHS(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSCS(r: TArmReg; p: TArmPSR); overload;
    procedure MSRCS(p: TArmPSR; r: TArmReg); overload;
    procedure MSRCS(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRCS(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSLO(r: TArmReg; p: TArmPSR); overload;
    procedure MSRLO(p: TArmPSR; r: TArmReg); overload;
    procedure MSRLO(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRLO(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSCC(r: TArmReg; p: TArmPSR); overload;
    procedure MSRCC(p: TArmPSR; r: TArmReg); overload;
    procedure MSRCC(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRCC(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSMI(r: TArmReg; p: TArmPSR); overload;
    procedure MSRMI(p: TArmPSR; r: TArmReg); overload;
    procedure MSRMI(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRMI(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSPL(r: TArmReg; p: TArmPSR); overload;
    procedure MSRPL(p: TArmPSR; r: TArmReg); overload;
    procedure MSRPL(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRPL(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSVS(r: TArmReg; p: TArmPSR); overload;
    procedure MSRVS(p: TArmPSR; r: TArmReg); overload;
    procedure MSRVS(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRVS(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSVC(r: TArmReg; p: TArmPSR); overload;
    procedure MSRVC(p: TArmPSR; r: TArmReg); overload;
    procedure MSRVC(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRVC(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSHI(r: TArmReg; p: TArmPSR); overload;
    procedure MSRHI(p: TArmPSR; r: TArmReg); overload;
    procedure MSRHI(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRHI(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSLS(r: TArmReg; p: TArmPSR); overload;
    procedure MSRLS(p: TArmPSR; r: TArmReg); overload;
    procedure MSRLS(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRLS(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSGE(r: TArmReg; p: TArmPSR); overload;
    procedure MSRGE(p: TArmPSR; r: TArmReg); overload;
    procedure MSRGE(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRGE(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSLT(r: TArmReg; p: TArmPSR); overload;
    procedure MSRLT(p: TArmPSR; r: TArmReg); overload;
    procedure MSRLT(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRLT(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSGT(r: TArmReg; p: TArmPSR); overload;
    procedure MSRGT(p: TArmPSR; r: TArmReg); overload;
    procedure MSRGT(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRGT(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSLE(r: TArmReg; p: TArmPSR); overload;
    procedure MSRLE(p: TArmPSR; r: TArmReg); overload;
    procedure MSRLE(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRLE(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSAL(r: TArmReg; p: TArmPSR); overload;
    procedure MSRAL(p: TArmPSR; r: TArmReg); overload;
    procedure MSRAL(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRAL(p: TArmPSRf; r: TArmReg); overload;
    procedure MRSNV(r: TArmReg; p: TArmPSR); overload;
    procedure MSRNV(p: TArmPSR; r: TArmReg); overload;
    procedure MSRNV(p: TArmPSRf; Rotate, Imm: Byte); overload;
    procedure MSRNV(p: TArmPSRf; r: TArmReg); overload; 
  // multiplication
    procedure Multiplication(C, S: Byte; Rd, Rm, Rs: TArmReg); overload;
    procedure MultiplicationA(C, S: Byte; Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MUL(Rd, Rm, Rs: TArmReg); overload;
    procedure MLA(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULEQ(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAEQ(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULEQS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAEQS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULNE(Rd, Rm, Rs: TArmReg); overload;
    procedure MLANE(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULNES(Rd, Rm, Rs: TArmReg); overload;
    procedure MLANES(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULHS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAHS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULHSS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAHSS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULCS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLACS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULCSS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLACSS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLO(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALO(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLOS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALOS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULCC(Rd, Rm, Rs: TArmReg); overload;
    procedure MLACC(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULCCS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLACCS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULMI(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAMI(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULMIS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAMIS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULPL(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAPL(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULPLS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAPLS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULVS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAVS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULVSS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAVSS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULVC(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAVC(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULVCS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAVCS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULHI(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAHI(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULHIS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAHIS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLSS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALSS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULGE(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAGE(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULGES(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAGES(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLT(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALT(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLTS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALTS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULGT(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAGT(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULGTS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAGTS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLE(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALE(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULLES(Rd, Rm, Rs: TArmReg); overload;
    procedure MLALES(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULAL(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAAL(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULALS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLAALS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULNV(Rd, Rm, Rs: TArmReg); overload;
    procedure MLANV(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure MULNVS(Rd, Rm, Rs: TArmReg); overload;
    procedure MLANVS(Rd, Rm, Rs, Rn: TArmReg); overload;
    procedure LongMultiplication(C, U, A, S: Byte; RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLEQ(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALEQ(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLEQS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALEQS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLEQ(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALEQ(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLEQS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALEQS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLNE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALNE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLNES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALNES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLNE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALNE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLNES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALNES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLHS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALHS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLHSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALHSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLHS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALHS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLHSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALHSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLCSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALCSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLCSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALCSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLO(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLO(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLOS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLOS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLO(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLO(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLOS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLOS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLCC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALCC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLCCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALCCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLCC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALCC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLCCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALCCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLMI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALMI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLMIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALMIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLMI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALMI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLMIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALMIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLPL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALPL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLPLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALPLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLPL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALPL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLPLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALPLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLVSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALVSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLVSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALVSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLVC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALVC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLVCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALVCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLVC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALVC(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLVCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALVCS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLHI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALHI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLHIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALHIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLHI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALHI(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLHIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALHIS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLSS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLGE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALGE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLGES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALGES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLGE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALGE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLGES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALGES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLGT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALGT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLGTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALGTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLGT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALGT(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLGTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALGTS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLLES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALLES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLE(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLLES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALLES(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALAL(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALALS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLNV(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALNV(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMULLNVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure SMLALNVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLNV(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALNV(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMULLNVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure UMLALNVS(RdLo, RdHi, Rm, Rs: TArmReg); overload;
    procedure DataTransferI(C, P, U, B, W, L: Byte; Rn, Rd: TArmReg; O: Word); overload;
    procedure DataTransfer(C, P, U, B, W, L: Byte; Shift: Byte; Rm: TArmReg); overload;
    procedure LDR(Rd: TArmReg; O: Word); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRB(Rd: TArmReg; O: Word); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRT(Rd: TArmReg; O: Word); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRBT(Rd: TArmReg; O: Word); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STR(Rd: TArmReg; O: Word); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRB(Rd: TArmReg; O: Word); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRT(Rd: TArmReg; O: Word); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRBT(Rd: TArmReg; O: Word); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQ(Rd: TArmReg; O: Word); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQB(Rd: TArmReg; O: Word); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQT(Rd: TArmReg; O: Word); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQBT(Rd: TArmReg; O: Word); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQ(Rd: TArmReg; O: Word); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQB(Rd: TArmReg; O: Word); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQT(Rd: TArmReg; O: Word); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQBT(Rd: TArmReg; O: Word); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNE(Rd: TArmReg; O: Word); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNEB(Rd: TArmReg; O: Word); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNET(Rd: TArmReg; O: Word); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNEBT(Rd: TArmReg; O: Word); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNE(Rd: TArmReg; O: Word); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNEB(Rd: TArmReg; O: Word); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNET(Rd: TArmReg; O: Word); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNEBT(Rd: TArmReg; O: Word); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHS(Rd: TArmReg; O: Word); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHSB(Rd: TArmReg; O: Word); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHST(Rd: TArmReg; O: Word); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHSBT(Rd: TArmReg; O: Word); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHS(Rd: TArmReg; O: Word); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHSB(Rd: TArmReg; O: Word); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHST(Rd: TArmReg; O: Word); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHSBT(Rd: TArmReg; O: Word); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCS(Rd: TArmReg; O: Word); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCSB(Rd: TArmReg; O: Word); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCST(Rd: TArmReg; O: Word); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCSBT(Rd: TArmReg; O: Word); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCS(Rd: TArmReg; O: Word); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCSB(Rd: TArmReg; O: Word); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCST(Rd: TArmReg; O: Word); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCSBT(Rd: TArmReg; O: Word); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLO(Rd: TArmReg; O: Word); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOB(Rd: TArmReg; O: Word); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOT(Rd: TArmReg; O: Word); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOBT(Rd: TArmReg; O: Word); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLO(Rd: TArmReg; O: Word); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOB(Rd: TArmReg; O: Word); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOT(Rd: TArmReg; O: Word); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOBT(Rd: TArmReg; O: Word); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCC(Rd: TArmReg; O: Word); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCB(Rd: TArmReg; O: Word); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCT(Rd: TArmReg; O: Word); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCBT(Rd: TArmReg; O: Word); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCC(Rd: TArmReg; O: Word); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCB(Rd: TArmReg; O: Word); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCT(Rd: TArmReg; O: Word); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCBT(Rd: TArmReg; O: Word); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMI(Rd: TArmReg; O: Word); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIB(Rd: TArmReg; O: Word); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIT(Rd: TArmReg; O: Word); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIBT(Rd: TArmReg; O: Word); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMI(Rd: TArmReg; O: Word); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIB(Rd: TArmReg; O: Word); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIT(Rd: TArmReg; O: Word); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIBT(Rd: TArmReg; O: Word); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPL(Rd: TArmReg; O: Word); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLB(Rd: TArmReg; O: Word); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLT(Rd: TArmReg; O: Word); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLBT(Rd: TArmReg; O: Word); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPL(Rd: TArmReg; O: Word); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLB(Rd: TArmReg; O: Word); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLT(Rd: TArmReg; O: Word); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLBT(Rd: TArmReg; O: Word); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVS(Rd: TArmReg; O: Word); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVSB(Rd: TArmReg; O: Word); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVST(Rd: TArmReg; O: Word); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVSBT(Rd: TArmReg; O: Word); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVS(Rd: TArmReg; O: Word); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVSB(Rd: TArmReg; O: Word); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVST(Rd: TArmReg; O: Word); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVSBT(Rd: TArmReg; O: Word); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVC(Rd: TArmReg; O: Word); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCB(Rd: TArmReg; O: Word); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCT(Rd: TArmReg; O: Word); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCBT(Rd: TArmReg; O: Word); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVC(Rd: TArmReg; O: Word); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCB(Rd: TArmReg; O: Word); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCT(Rd: TArmReg; O: Word); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCBT(Rd: TArmReg; O: Word); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHI(Rd: TArmReg; O: Word); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIB(Rd: TArmReg; O: Word); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIT(Rd: TArmReg; O: Word); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIBT(Rd: TArmReg; O: Word); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHI(Rd: TArmReg; O: Word); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIB(Rd: TArmReg; O: Word); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIT(Rd: TArmReg; O: Word); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIBT(Rd: TArmReg; O: Word); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLS(Rd: TArmReg; O: Word); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLSB(Rd: TArmReg; O: Word); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLST(Rd: TArmReg; O: Word); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLSBT(Rd: TArmReg; O: Word); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLS(Rd: TArmReg; O: Word); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLSB(Rd: TArmReg; O: Word); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLST(Rd: TArmReg; O: Word); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLSBT(Rd: TArmReg; O: Word); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGE(Rd: TArmReg; O: Word); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGEB(Rd: TArmReg; O: Word); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGET(Rd: TArmReg; O: Word); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGEBT(Rd: TArmReg; O: Word); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGE(Rd: TArmReg; O: Word); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGEB(Rd: TArmReg; O: Word); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGET(Rd: TArmReg; O: Word); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGEBT(Rd: TArmReg; O: Word); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLT(Rd: TArmReg; O: Word); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTB(Rd: TArmReg; O: Word); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTT(Rd: TArmReg; O: Word); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTBT(Rd: TArmReg; O: Word); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLT(Rd: TArmReg; O: Word); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTB(Rd: TArmReg; O: Word); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTT(Rd: TArmReg; O: Word); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTBT(Rd: TArmReg; O: Word); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGT(Rd: TArmReg; O: Word); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTB(Rd: TArmReg; O: Word); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTT(Rd: TArmReg; O: Word); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTBT(Rd: TArmReg; O: Word); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGT(Rd: TArmReg; O: Word); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTB(Rd: TArmReg; O: Word); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTT(Rd: TArmReg; O: Word); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTBT(Rd: TArmReg; O: Word); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLE(Rd: TArmReg; O: Word); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLEB(Rd: TArmReg; O: Word); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLET(Rd: TArmReg; O: Word); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLEBT(Rd: TArmReg; O: Word); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLE(Rd: TArmReg; O: Word); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLEB(Rd: TArmReg; O: Word); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLET(Rd: TArmReg; O: Word); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLEBT(Rd: TArmReg; O: Word); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRAL(Rd: TArmReg; O: Word); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALB(Rd: TArmReg; O: Word); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALT(Rd: TArmReg; O: Word); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALBT(Rd: TArmReg; O: Word); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRAL(Rd: TArmReg; O: Word); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALB(Rd: TArmReg; O: Word); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALT(Rd: TArmReg; O: Word); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALBT(Rd: TArmReg; O: Word); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNV(Rd: TArmReg; O: Word); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVB(Rd: TArmReg; O: Word); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVT(Rd: TArmReg; O: Word); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVBT(Rd: TArmReg; O: Word); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNV(Rd: TArmReg; O: Word); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVB(Rd: TArmReg; O: Word); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVT(Rd: TArmReg; O: Word); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVBT(Rd: TArmReg; O: Word); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0); overload;
    procedure SwapInstruction(C, B: Byte; Rd, Rm, Rn: TArmReg); overload;
    procedure SWP(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPEQ(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPEQB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPNE(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPNEB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPHS(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPHSB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPCS(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPCSB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLO(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLOB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPCC(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPCCB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPMI(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPMIB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPPL(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPPLB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPVS(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPVSB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPVC(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPVCB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPHI(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPHIB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLS(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLSB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPGE(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPGEB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLT(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLTB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPGT(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPGTB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLE(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPLEB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPAL(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPALB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPNV(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
    procedure SWPNVB(Rd, Rm: TArmReg; const Rn: array of TArmReg); overload;
  end;

implementation

constructor TArm.Create(BaseSize: Integer);
begin
end;

procedure TArm.WriteDataTrans(C, I, O, S, N, D: Byte; R: Cardinal);
begin
  WriteU(((Ord(C)) shl 28) or ((Ord(I)) shl 25) or (O shl 22) or ((Ord(S)) shl 20) or (N shl 16) or (D shl 12) or R);
end;

procedure TArm.WriteDataTransR(C, O, S: Byte; N, D, R: TArmReg; F: Byte);
begin
  WriteDataTrans(C, 0, O, S, Ord(N), Ord(D), (F shl 4) or Ord(R));
end;

procedure TArm.WriteDataTransI(C, O, S: Byte; N, D: TArmReg; I, R: Byte);
begin
  WriteDataTrans(1, 0, O, S, Ord(N), Ord(D), ((R and $F) shl 8) or I);
end;

procedure TArm.B(Offset: Cardinal);
begin
  WriteU(((Ord($E)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BEQ(Offset: Cardinal);
begin
  WriteU(((Ord($0)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BNE(Offset: Cardinal);
begin
  WriteU(((Ord($1)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BHS(Offset: Cardinal);
begin
  WriteU(((Ord($2)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BCS(Offset: Cardinal);
begin
  WriteU(((Ord($2)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BLO(Offset: Cardinal);
begin
  WriteU(((Ord($3)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BCC(Offset: Cardinal);
begin
  WriteU(((Ord($3)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BMI(Offset: Cardinal);
begin
  WriteU(((Ord($4)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BPL(Offset: Cardinal);
begin
  WriteU(((Ord($5)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BVS(Offset: Cardinal);
begin
  WriteU(((Ord($6)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BVC(Offset: Cardinal);
begin
  WriteU(((Ord($7)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BHI(Offset: Cardinal);
begin
  WriteU(((Ord($8)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BLS(Offset: Cardinal);
begin
  WriteU(((Ord($9)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BGE(Offset: Cardinal);
begin
  WriteU(((Ord($A)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BLT(Offset: Cardinal);
begin
  WriteU(((Ord($B)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BGT(Offset: Cardinal);
begin
  WriteU(((Ord($C)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BLE(Offset: Cardinal);
begin
  WriteU(((Ord($D)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BAL(Offset: Cardinal);
begin
  WriteU(((Ord($E)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BNV(Offset: Cardinal);
begin
  WriteU(((Ord($F)) shl 28) or (10 shl 24) or Offset);
end;

procedure TArm.BL(Offset: Cardinal);
begin
  WriteU(((Ord($E)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLEQ(Offset: Cardinal);
begin
  WriteU(((Ord($0)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLNE(Offset: Cardinal);
begin
  WriteU(((Ord($1)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLHS(Offset: Cardinal);
begin
  WriteU(((Ord($2)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLCS(Offset: Cardinal);
begin
  WriteU(((Ord($2)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLLO(Offset: Cardinal);
begin
  WriteU(((Ord($3)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLCC(Offset: Cardinal);
begin
  WriteU(((Ord($3)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLMI(Offset: Cardinal);
begin
  WriteU(((Ord($4)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLPL(Offset: Cardinal);
begin
  WriteU(((Ord($5)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLVS(Offset: Cardinal);
begin
  WriteU(((Ord($6)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLVC(Offset: Cardinal);
begin
  WriteU(((Ord($7)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLHI(Offset: Cardinal);
begin
  WriteU(((Ord($8)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLLS(Offset: Cardinal);
begin
  WriteU(((Ord($9)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLGE(Offset: Cardinal);
begin
  WriteU(((Ord($A)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLLT(Offset: Cardinal);
begin
  WriteU(((Ord($B)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLGT(Offset: Cardinal);
begin
  WriteU(((Ord($C)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLLE(Offset: Cardinal);
begin
  WriteU(((Ord($D)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLAL(Offset: Cardinal);
begin
  WriteU(((Ord($E)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm.BLNV(Offset: Cardinal);
begin
  WriteU(((Ord($F)) shl 28) or (11 shl 24) or Offset);
end;

procedure TArm._AND(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm._ANDS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm._AND(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm._ANDS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $0, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ANDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $0, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ANDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $0, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ANDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $0, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EOR(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EOR(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EOREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EOREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EOREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EOREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $1, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.EORNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $1, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.EORNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $1, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.EORNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $1, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUB(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUB(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $2, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SUBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $2, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SUBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $2, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SUBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $2, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSB(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSB(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $3, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $3, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $3, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $3, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADD(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADD(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $4, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $4, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $4, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $4, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $5, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ADCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $5, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ADCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $5, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ADCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $5, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $6, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.SBCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $6, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.SBCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $6, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.SBCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $6, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $7, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.RSCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $7, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.RSCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $7, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.RSCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $7, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TST(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TST(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $8, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TSTNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $8, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TSTNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $8, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TSTNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $8, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $9, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.TEQNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $9, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.TEQNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $9, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.TEQNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $9, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMP(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMP(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $A, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMPNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $A, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMPNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $A, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMPNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $A, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMN(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMN(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $B, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.CMNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $B, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.CMNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $B, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.CMNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $B, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORR(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORR(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $C, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.ORRNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $C, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.ORRNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $C, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.ORRNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $C, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $D, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MOVNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $D, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MOVNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $D, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MOVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $D, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BIC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BIC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $E, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.BICNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $E, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.BICNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $E, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.BICNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $E, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVN(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVN(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $F, 0, Src1, Dst, Src2, Shift);
end;

procedure TArm.MVNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $F, 1, Src1, Dst, Src2, Shift); 
end;

procedure TArm.MVNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $F, 0, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MVNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $F, 1, Src, Dst, Imm, Rotate); 
end;

procedure TArm.MRS(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($E)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSR(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($E)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSR(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($E)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSR(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($E)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSEQ(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($0)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSREQ(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($0)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSREQ(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($0)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSREQ(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($0)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSNE(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($1)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRNE(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($1)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRNE(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($1)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRNE(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($1)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSHS(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($2)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRHS(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($2)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRHS(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($2)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRHS(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($2)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSCS(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($2)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRCS(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($2)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRCS(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($2)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRCS(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($2)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSLO(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($3)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRLO(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($3)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRLO(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($3)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRLO(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($3)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSCC(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($3)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRCC(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($3)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRCC(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($3)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRCC(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($3)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSMI(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($4)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRMI(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($4)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRMI(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($4)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRMI(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($4)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSPL(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($5)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRPL(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($5)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRPL(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($5)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRPL(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($5)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSVS(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($6)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRVS(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($6)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRVS(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($6)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRVS(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($6)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSVC(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($7)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRVC(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($7)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRVC(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($7)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRVC(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($7)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSHI(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($8)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRHI(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($8)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRHI(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($8)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRHI(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($8)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSLS(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($9)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRLS(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($9)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRLS(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($9)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRLS(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($9)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSGE(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($A)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRGE(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($A)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRGE(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($A)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRGE(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($A)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSLT(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($B)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRLT(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($B)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRLT(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($B)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRLT(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($B)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSGT(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($C)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRGT(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($C)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRGT(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($C)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRGT(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($C)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSLE(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($D)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRLE(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($D)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRLE(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($D)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRLE(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($D)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSAL(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($E)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRAL(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($E)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRAL(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($E)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRAL(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($E)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MRSNV(r: TArmReg; p: TArmPSR);
begin
  WriteU(((Ord($F)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($F shl 16) or (Ord(r) shl 12));
end;

procedure TArm.MSRNV(p: TArmPSR; r: TArmReg);
begin
  WriteU(((Ord($F)) shl 28) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($9 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.MSRNV(p: TArmPSRf; Rotate, Imm: Byte);
begin
  WriteU(((Ord($F)) shl 28) or (1 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or ((Rotate and $F) shl 8) or Imm);
end;

procedure TArm.MSRNV(p: TArmPSRf; r: TArmReg);
begin
  WriteU(((Ord($F)) shl 28) or (0 shl 25) or (2 shl 23) or (Ord(p) shl 22) or ($2 shl 20) or ($8 shl 16) or ($F shl 12) or Ord(r));
end;

procedure TArm.Multiplication(C, S: Byte; Rd, Rm, Rs: TArmReg);
begin
  WriteU(((Ord(C)) shl 28) or (S shl 20) or (Ord(Rd) shl 16) or (Ord(Rs) shl 8) or (Ord(9) shl 4) or Ord(Rm));
end;

procedure TArm.MultiplicationA(C, S: Byte; Rd, Rm, Rs, Rn: TArmReg);
begin
  WriteU(((Ord($E)) shl 28) or ($1 shl 21) or (S shl 20) or (Ord(Rd) shl 16) or (Ord(Rn) shl 12) or (Ord(Rs) shl 8) or (Ord(9) shl 4) or Ord(Rm));
end;

procedure TArm.MUL(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($E, $0, Rd, Rm, Rs);
end;

procedure TArm.MLA(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($E, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($E, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($E, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULEQ(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($0, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAEQ(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($0, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULEQS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($0, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAEQS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($0, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULNE(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($1, $0, Rd, Rm, Rs);
end;

procedure TArm.MLANE(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($1, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULNES(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($1, $1, Rd, Rm, Rs);
end;

procedure TArm.MLANES(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($1, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULHS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($2, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAHS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($2, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULHSS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($2, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAHSS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($2, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULCS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($2, $0, Rd, Rm, Rs);
end;

procedure TArm.MLACS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($2, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULCSS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($2, $1, Rd, Rm, Rs);
end;

procedure TArm.MLACSS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($2, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLO(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($3, $0, Rd, Rm, Rs);
end;

procedure TArm.MLALO(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($3, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLOS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($3, $1, Rd, Rm, Rs);
end;

procedure TArm.MLALOS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($3, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULCC(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($3, $0, Rd, Rm, Rs);
end;

procedure TArm.MLACC(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($3, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULCCS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($3, $1, Rd, Rm, Rs);
end;

procedure TArm.MLACCS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($3, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULMI(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($4, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAMI(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($4, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULMIS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($4, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAMIS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($4, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULPL(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($5, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAPL(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($5, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULPLS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($5, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAPLS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($5, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULVS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($6, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAVS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($6, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULVSS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($6, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAVSS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($6, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULVC(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($7, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAVC(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($7, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULVCS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($7, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAVCS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($7, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULHI(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($8, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAHI(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($8, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULHIS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($8, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAHIS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($8, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($9, $0, Rd, Rm, Rs);
end;

procedure TArm.MLALS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($9, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLSS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($9, $1, Rd, Rm, Rs);
end;

procedure TArm.MLALSS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($9, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULGE(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($A, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAGE(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($A, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULGES(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($A, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAGES(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($A, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLT(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($B, $0, Rd, Rm, Rs);
end;

procedure TArm.MLALT(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($B, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLTS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($B, $1, Rd, Rm, Rs);
end;

procedure TArm.MLALTS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($B, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULGT(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($C, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAGT(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($C, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULGTS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($C, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAGTS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($C, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLE(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($D, $0, Rd, Rm, Rs);
end;

procedure TArm.MLALE(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($D, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULLES(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($D, $1, Rd, Rm, Rs);
end;

procedure TArm.MLALES(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($D, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULAL(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($E, $0, Rd, Rm, Rs);
end;

procedure TArm.MLAAL(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($E, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULALS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($E, $1, Rd, Rm, Rs);
end;

procedure TArm.MLAALS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($E, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULNV(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($F, $0, Rd, Rm, Rs);
end;

procedure TArm.MLANV(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($F, $0, Rd, Rm, Rs, Rn);
end;

procedure TArm.MULNVS(Rd, Rm, Rs: TArmReg);
begin
  Multiplication($F, $1, Rd, Rm, Rs);
end;

procedure TArm.MLANVS(Rd, Rm, Rs, Rn: TArmReg);
begin
  MultiplicationA($F, $1, Rd, Rm, Rs, Rn);
end;

procedure TArm.LongMultiplication(C, U, A, S: Byte; RdLo, RdHi, Rm, Rs: TArmReg);
begin
  WriteU(((Ord(C)) shl 28) or (1 shl 23) or (U shl 22) or (A shl 21) or (S shl 20) or (Ord(RdHi) shl 16) or (Ord(RdLo) shl 12) or (Ord(Rs) shl 8) or (9 shl 4) or Ord(Rm));
end;

procedure TArm.SMULL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLEQ(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALEQ(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLEQS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALEQS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLEQ(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALEQ(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLEQS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALEQS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($0, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLNE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALNE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLNES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALNES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLNE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALNE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLNES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALNES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($1, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLHS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALHS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLHSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALHSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLHS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALHS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLHSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALHSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLCSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALCSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLCSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALCSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($2, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLO(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLO(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLOS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLOS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLO(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLO(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLOS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLOS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLCC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALCC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLCCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALCCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLCC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALCC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLCCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALCCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($3, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLMI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALMI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLMIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALMIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLMI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALMI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLMIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALMIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($4, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLPL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALPL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLPLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALPLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLPL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALPL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLPLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALPLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($5, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLVSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALVSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLVSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALVSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($6, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLVC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALVC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLVCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALVCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLVC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALVC(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLVCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALVCS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($7, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLHI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALHI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLHIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALHIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLHI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALHI(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLHIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALHIS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($8, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLSS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($9, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLGE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALGE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLGES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALGES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLGE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALGE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLGES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALGES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($A, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($B, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLGT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALGT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLGTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALGTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLGT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALGT(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLGTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALGTS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($C, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLLES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALLES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLE(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLLES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALLES(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($D, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALAL(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALALS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($E, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLNV(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 0, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALNV(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 0, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMULLNVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 0, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.SMLALNVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 0, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLNV(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 1, 0, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALNV(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 1, 1, $0, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMULLNVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 1, 0, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.UMLALNVS(RdLo, RdHi, Rm, Rs: TArmReg);
begin
  LongMultiplication($F, 1, 1, $1, RdLo, RdHi, Rm, Rs);
end;

procedure TArm.DataTransferI(C, P, U, B, W, L: Byte; Rn, Rd: TArmReg; O: Word);
begin
  WriteU(((Ord(C)) shl 28) or (1 shl 26) or (1 shl 25) or (P shl 24) or (U shl 23) or (B shl 22) or (W shl 21) or (L shl 20) or (Ord(Rn) shl 16) or (Ord(Rd) shl 12) or O);
end;

procedure TArm.DataTransfer(C, P, U, B, W, L: Byte; Shift: Byte; Rm: TArmReg);
begin
  WriteU(((Ord(C)) shl 28) or (1 shl 26) or (0 shl 25) or (P shl 24) or (U shl 23) or (B shl 22) or (W shl 21) or (L shl 20) or (Ord(Rn) shl 16) or (Ord(Rd) shl 12) or (Shift shl 4) or Ord(Rm));
end;

procedure TArm.LDR(Rd: TArmReg; O: Word);
begin
  LDR(Rd, [pc], [O]);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDR(Rd, [pc], [0], W);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDR(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDR(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRB(Rd: TArmReg; O: Word);
begin
  LDRB(Rd, [pc], [O]);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRB(Rd, [pc], [0], W);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRT(Rd: TArmReg; O: Word);
begin
  LDRT(Rd, [pc], [O]);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRT(Rd, [pc], [0], W);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRBT(Rd: TArmReg; O: Word);
begin
  LDRBT(Rd, [pc], [O]);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STR(Rd: TArmReg; O: Word);
begin
  STR(Rd, [pc], [O]);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STR(Rd, [pc], [0], W);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STR(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STR(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STR(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRB(Rd: TArmReg; O: Word);
begin
  STRB(Rd, [pc], [O]);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRB(Rd, [pc], [0], W);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRT(Rd: TArmReg; O: Word);
begin
  STRT(Rd, [pc], [O]);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRT(Rd, [pc], [0], W);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRBT(Rd: TArmReg; O: Word);
begin
  STRBT(Rd, [pc], [O]);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRBT(Rd, [pc], [0], W);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDREQ(Rd: TArmReg; O: Word);
begin
  LDREQ(Rd, [pc], [O]);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQ(Rd, [pc], [0], W);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQ(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDREQ(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDREQB(Rd: TArmReg; O: Word);
begin
  LDREQB(Rd, [pc], [O]);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQB(Rd, [pc], [0], W);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDREQB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDREQT(Rd: TArmReg; O: Word);
begin
  LDREQT(Rd, [pc], [O]);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQT(Rd, [pc], [0], W);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDREQT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDREQBT(Rd: TArmReg; O: Word);
begin
  LDREQBT(Rd, [pc], [O]);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQBT(Rd, [pc], [0], W);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDREQBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDREQBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STREQ(Rd: TArmReg; O: Word);
begin
  STREQ(Rd, [pc], [O]);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQ(Rd, [pc], [0], W);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQ(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STREQ(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STREQ(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STREQB(Rd: TArmReg; O: Word);
begin
  STREQB(Rd, [pc], [O]);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQB(Rd, [pc], [0], W);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STREQB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STREQB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STREQT(Rd: TArmReg; O: Word);
begin
  STREQT(Rd, [pc], [O]);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQT(Rd, [pc], [0], W);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STREQT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STREQT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STREQBT(Rd: TArmReg; O: Word);
begin
  STREQBT(Rd, [pc], [O]);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQBT(Rd, [pc], [0], W);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($0, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STREQBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($0, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($0, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STREQBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STREQBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($0, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNE(Rd: TArmReg; O: Word);
begin
  LDRNE(Rd, [pc], [O]);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNE(Rd, [pc], [0], W);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNEB(Rd: TArmReg; O: Word);
begin
  LDRNEB(Rd, [pc], [O]);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNEB(Rd, [pc], [0], W);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNET(Rd: TArmReg; O: Word);
begin
  LDRNET(Rd, [pc], [O]);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNET(Rd, [pc], [0], W);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; O: Word);
begin
  LDRNEBT(Rd, [pc], [O]);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNEBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNE(Rd: TArmReg; O: Word);
begin
  STRNE(Rd, [pc], [O]);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNE(Rd, [pc], [0], W);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNEB(Rd: TArmReg; O: Word);
begin
  STRNEB(Rd, [pc], [O]);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNEB(Rd, [pc], [0], W);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNET(Rd: TArmReg; O: Word);
begin
  STRNET(Rd, [pc], [O]);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNET(Rd, [pc], [0], W);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNEBT(Rd: TArmReg; O: Word);
begin
  STRNEBT(Rd, [pc], [O]);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNEBT(Rd, [pc], [0], W);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($1, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($1, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($1, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($1, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHS(Rd: TArmReg; O: Word);
begin
  LDRHS(Rd, [pc], [O]);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHS(Rd, [pc], [0], W);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHSB(Rd: TArmReg; O: Word);
begin
  LDRHSB(Rd, [pc], [O]);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHSB(Rd, [pc], [0], W);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHST(Rd: TArmReg; O: Word);
begin
  LDRHST(Rd, [pc], [O]);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHST(Rd, [pc], [0], W);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; O: Word);
begin
  LDRHSBT(Rd, [pc], [O]);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHSBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHS(Rd: TArmReg; O: Word);
begin
  STRHS(Rd, [pc], [O]);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHS(Rd, [pc], [0], W);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHSB(Rd: TArmReg; O: Word);
begin
  STRHSB(Rd, [pc], [O]);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHSB(Rd, [pc], [0], W);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHST(Rd: TArmReg; O: Word);
begin
  STRHST(Rd, [pc], [O]);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHST(Rd, [pc], [0], W);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHSBT(Rd: TArmReg; O: Word);
begin
  STRHSBT(Rd, [pc], [O]);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHSBT(Rd, [pc], [0], W);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCS(Rd: TArmReg; O: Word);
begin
  LDRCS(Rd, [pc], [O]);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCS(Rd, [pc], [0], W);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCSB(Rd: TArmReg; O: Word);
begin
  LDRCSB(Rd, [pc], [O]);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCSB(Rd, [pc], [0], W);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCST(Rd: TArmReg; O: Word);
begin
  LDRCST(Rd, [pc], [O]);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCST(Rd, [pc], [0], W);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; O: Word);
begin
  LDRCSBT(Rd, [pc], [O]);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCSBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCS(Rd: TArmReg; O: Word);
begin
  STRCS(Rd, [pc], [O]);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCS(Rd, [pc], [0], W);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCSB(Rd: TArmReg; O: Word);
begin
  STRCSB(Rd, [pc], [O]);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCSB(Rd, [pc], [0], W);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCST(Rd: TArmReg; O: Word);
begin
  STRCST(Rd, [pc], [O]);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCST(Rd, [pc], [0], W);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCSBT(Rd: TArmReg; O: Word);
begin
  STRCSBT(Rd, [pc], [O]);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCSBT(Rd, [pc], [0], W);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($2, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($2, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($2, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($2, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLO(Rd: TArmReg; O: Word);
begin
  LDRLO(Rd, [pc], [O]);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLO(Rd, [pc], [0], W);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLO(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLO(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLOB(Rd: TArmReg; O: Word);
begin
  LDRLOB(Rd, [pc], [O]);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOB(Rd, [pc], [0], W);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLOB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLOT(Rd: TArmReg; O: Word);
begin
  LDRLOT(Rd, [pc], [O]);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLOT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; O: Word);
begin
  LDRLOBT(Rd, [pc], [O]);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLOBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLOBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLO(Rd: TArmReg; O: Word);
begin
  STRLO(Rd, [pc], [O]);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLO(Rd, [pc], [0], W);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLO(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLO(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLO(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLOB(Rd: TArmReg; O: Word);
begin
  STRLOB(Rd, [pc], [O]);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOB(Rd, [pc], [0], W);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLOB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLOB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLOT(Rd: TArmReg; O: Word);
begin
  STRLOT(Rd, [pc], [O]);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOT(Rd, [pc], [0], W);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLOT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLOT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLOBT(Rd: TArmReg; O: Word);
begin
  STRLOBT(Rd, [pc], [O]);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOBT(Rd, [pc], [0], W);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLOBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLOBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLOBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCC(Rd: TArmReg; O: Word);
begin
  LDRCC(Rd, [pc], [O]);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCC(Rd, [pc], [0], W);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCC(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCC(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCCB(Rd: TArmReg; O: Word);
begin
  LDRCCB(Rd, [pc], [O]);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCB(Rd, [pc], [0], W);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCCB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCCT(Rd: TArmReg; O: Word);
begin
  LDRCCT(Rd, [pc], [O]);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCT(Rd, [pc], [0], W);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCCT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; O: Word);
begin
  LDRCCBT(Rd, [pc], [O]);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRCCBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRCCBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCC(Rd: TArmReg; O: Word);
begin
  STRCC(Rd, [pc], [O]);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCC(Rd, [pc], [0], W);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCC(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCC(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCCB(Rd: TArmReg; O: Word);
begin
  STRCCB(Rd, [pc], [O]);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCB(Rd, [pc], [0], W);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCCB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCCT(Rd: TArmReg; O: Word);
begin
  STRCCT(Rd, [pc], [O]);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCT(Rd, [pc], [0], W);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCCT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRCCBT(Rd: TArmReg; O: Word);
begin
  STRCCBT(Rd, [pc], [O]);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCBT(Rd, [pc], [0], W);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($3, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRCCBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($3, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($3, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRCCBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRCCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($3, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRMI(Rd: TArmReg; O: Word);
begin
  LDRMI(Rd, [pc], [O]);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMI(Rd, [pc], [0], W);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMI(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRMI(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRMIB(Rd: TArmReg; O: Word);
begin
  LDRMIB(Rd, [pc], [O]);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIB(Rd, [pc], [0], W);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRMIB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRMIT(Rd: TArmReg; O: Word);
begin
  LDRMIT(Rd, [pc], [O]);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIT(Rd, [pc], [0], W);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRMIT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; O: Word);
begin
  LDRMIBT(Rd, [pc], [O]);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRMIBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRMIBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRMI(Rd: TArmReg; O: Word);
begin
  STRMI(Rd, [pc], [O]);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMI(Rd, [pc], [0], W);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMI(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRMI(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRMI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRMIB(Rd: TArmReg; O: Word);
begin
  STRMIB(Rd, [pc], [O]);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIB(Rd, [pc], [0], W);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRMIB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRMIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRMIT(Rd: TArmReg; O: Word);
begin
  STRMIT(Rd, [pc], [O]);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIT(Rd, [pc], [0], W);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRMIT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRMIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRMIBT(Rd: TArmReg; O: Word);
begin
  STRMIBT(Rd, [pc], [O]);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIBT(Rd, [pc], [0], W);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($4, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRMIBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($4, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($4, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRMIBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRMIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($4, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRPL(Rd: TArmReg; O: Word);
begin
  LDRPL(Rd, [pc], [O]);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPL(Rd, [pc], [0], W);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPL(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRPL(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRPLB(Rd: TArmReg; O: Word);
begin
  LDRPLB(Rd, [pc], [O]);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLB(Rd, [pc], [0], W);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRPLB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRPLT(Rd: TArmReg; O: Word);
begin
  LDRPLT(Rd, [pc], [O]);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLT(Rd, [pc], [0], W);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRPLT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; O: Word);
begin
  LDRPLBT(Rd, [pc], [O]);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRPLBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRPLBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRPL(Rd: TArmReg; O: Word);
begin
  STRPL(Rd, [pc], [O]);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPL(Rd, [pc], [0], W);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPL(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRPL(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRPL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRPLB(Rd: TArmReg; O: Word);
begin
  STRPLB(Rd, [pc], [O]);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLB(Rd, [pc], [0], W);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRPLB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRPLB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRPLT(Rd: TArmReg; O: Word);
begin
  STRPLT(Rd, [pc], [O]);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLT(Rd, [pc], [0], W);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRPLT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRPLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRPLBT(Rd: TArmReg; O: Word);
begin
  STRPLBT(Rd, [pc], [O]);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLBT(Rd, [pc], [0], W);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($5, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRPLBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($5, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($5, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRPLBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRPLBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($5, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVS(Rd: TArmReg; O: Word);
begin
  LDRVS(Rd, [pc], [O]);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVS(Rd, [pc], [0], W);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVSB(Rd: TArmReg; O: Word);
begin
  LDRVSB(Rd, [pc], [O]);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVSB(Rd, [pc], [0], W);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVST(Rd: TArmReg; O: Word);
begin
  LDRVST(Rd, [pc], [O]);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVST(Rd, [pc], [0], W);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; O: Word);
begin
  LDRVSBT(Rd, [pc], [O]);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVSBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVS(Rd: TArmReg; O: Word);
begin
  STRVS(Rd, [pc], [O]);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVS(Rd, [pc], [0], W);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVSB(Rd: TArmReg; O: Word);
begin
  STRVSB(Rd, [pc], [O]);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVSB(Rd, [pc], [0], W);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVST(Rd: TArmReg; O: Word);
begin
  STRVST(Rd, [pc], [O]);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVST(Rd, [pc], [0], W);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVSBT(Rd: TArmReg; O: Word);
begin
  STRVSBT(Rd, [pc], [O]);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVSBT(Rd, [pc], [0], W);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($6, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($6, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($6, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($6, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVC(Rd: TArmReg; O: Word);
begin
  LDRVC(Rd, [pc], [O]);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVC(Rd, [pc], [0], W);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVC(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVC(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVCB(Rd: TArmReg; O: Word);
begin
  LDRVCB(Rd, [pc], [O]);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCB(Rd, [pc], [0], W);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVCB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVCT(Rd: TArmReg; O: Word);
begin
  LDRVCT(Rd, [pc], [O]);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCT(Rd, [pc], [0], W);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVCT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; O: Word);
begin
  LDRVCBT(Rd, [pc], [O]);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRVCBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRVCBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVC(Rd: TArmReg; O: Word);
begin
  STRVC(Rd, [pc], [O]);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVC(Rd, [pc], [0], W);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVC(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVC(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVC(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVCB(Rd: TArmReg; O: Word);
begin
  STRVCB(Rd, [pc], [O]);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCB(Rd, [pc], [0], W);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVCB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVCB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVCT(Rd: TArmReg; O: Word);
begin
  STRVCT(Rd, [pc], [O]);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCT(Rd, [pc], [0], W);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVCT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVCT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRVCBT(Rd: TArmReg; O: Word);
begin
  STRVCBT(Rd, [pc], [O]);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCBT(Rd, [pc], [0], W);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($7, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRVCBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($7, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($7, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRVCBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRVCBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($7, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHI(Rd: TArmReg; O: Word);
begin
  LDRHI(Rd, [pc], [O]);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHI(Rd, [pc], [0], W);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHI(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHI(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHIB(Rd: TArmReg; O: Word);
begin
  LDRHIB(Rd, [pc], [O]);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIB(Rd, [pc], [0], W);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHIB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHIT(Rd: TArmReg; O: Word);
begin
  LDRHIT(Rd, [pc], [O]);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIT(Rd, [pc], [0], W);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHIT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; O: Word);
begin
  LDRHIBT(Rd, [pc], [O]);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRHIBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRHIBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHI(Rd: TArmReg; O: Word);
begin
  STRHI(Rd, [pc], [O]);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHI(Rd, [pc], [0], W);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHI(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHI(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHI(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHIB(Rd: TArmReg; O: Word);
begin
  STRHIB(Rd, [pc], [O]);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIB(Rd, [pc], [0], W);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHIB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHIB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHIT(Rd: TArmReg; O: Word);
begin
  STRHIT(Rd, [pc], [O]);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIT(Rd, [pc], [0], W);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHIT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHIT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRHIBT(Rd: TArmReg; O: Word);
begin
  STRHIBT(Rd, [pc], [O]);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIBT(Rd, [pc], [0], W);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($8, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRHIBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($8, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($8, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRHIBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRHIBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($8, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLS(Rd: TArmReg; O: Word);
begin
  LDRLS(Rd, [pc], [O]);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLS(Rd, [pc], [0], W);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLSB(Rd: TArmReg; O: Word);
begin
  LDRLSB(Rd, [pc], [O]);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLSB(Rd, [pc], [0], W);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLST(Rd: TArmReg; O: Word);
begin
  LDRLST(Rd, [pc], [O]);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLST(Rd, [pc], [0], W);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; O: Word);
begin
  LDRLSBT(Rd, [pc], [O]);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLSBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLS(Rd: TArmReg; O: Word);
begin
  STRLS(Rd, [pc], [O]);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLS(Rd, [pc], [0], W);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLS(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLS(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLS(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLSB(Rd: TArmReg; O: Word);
begin
  STRLSB(Rd, [pc], [O]);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLSB(Rd, [pc], [0], W);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLSB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLSB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLSB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLST(Rd: TArmReg; O: Word);
begin
  STRLST(Rd, [pc], [O]);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLST(Rd, [pc], [0], W);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLST(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLST(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLST(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLSBT(Rd: TArmReg; O: Word);
begin
  STRLSBT(Rd, [pc], [O]);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLSBT(Rd, [pc], [0], W);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($9, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLSBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($9, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($9, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLSBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLSBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($9, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGE(Rd: TArmReg; O: Word);
begin
  LDRGE(Rd, [pc], [O]);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGE(Rd, [pc], [0], W);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGEB(Rd: TArmReg; O: Word);
begin
  LDRGEB(Rd, [pc], [O]);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGEB(Rd, [pc], [0], W);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGET(Rd: TArmReg; O: Word);
begin
  LDRGET(Rd, [pc], [O]);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGET(Rd, [pc], [0], W);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; O: Word);
begin
  LDRGEBT(Rd, [pc], [O]);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGEBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGE(Rd: TArmReg; O: Word);
begin
  STRGE(Rd, [pc], [O]);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGE(Rd, [pc], [0], W);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGEB(Rd: TArmReg; O: Word);
begin
  STRGEB(Rd, [pc], [O]);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGEB(Rd, [pc], [0], W);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGET(Rd: TArmReg; O: Word);
begin
  STRGET(Rd, [pc], [O]);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGET(Rd, [pc], [0], W);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGEBT(Rd: TArmReg; O: Word);
begin
  STRGEBT(Rd, [pc], [O]);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGEBT(Rd, [pc], [0], W);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($A, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($A, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($A, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($A, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLT(Rd: TArmReg; O: Word);
begin
  LDRLT(Rd, [pc], [O]);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLTB(Rd: TArmReg; O: Word);
begin
  LDRLTB(Rd, [pc], [O]);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTB(Rd, [pc], [0], W);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLTB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLTT(Rd: TArmReg; O: Word);
begin
  LDRLTT(Rd, [pc], [O]);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLTT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; O: Word);
begin
  LDRLTBT(Rd, [pc], [O]);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLTBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLTBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLT(Rd: TArmReg; O: Word);
begin
  STRLT(Rd, [pc], [O]);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLT(Rd, [pc], [0], W);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLTB(Rd: TArmReg; O: Word);
begin
  STRLTB(Rd, [pc], [O]);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTB(Rd, [pc], [0], W);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLTB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLTT(Rd: TArmReg; O: Word);
begin
  STRLTT(Rd, [pc], [O]);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTT(Rd, [pc], [0], W);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLTT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLTBT(Rd: TArmReg; O: Word);
begin
  STRLTBT(Rd, [pc], [O]);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTBT(Rd, [pc], [0], W);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($B, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLTBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($B, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($B, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLTBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($B, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGT(Rd: TArmReg; O: Word);
begin
  LDRGT(Rd, [pc], [O]);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGT(Rd, [pc], [0], W);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGTB(Rd: TArmReg; O: Word);
begin
  LDRGTB(Rd, [pc], [O]);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTB(Rd, [pc], [0], W);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGTB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGTT(Rd: TArmReg; O: Word);
begin
  LDRGTT(Rd, [pc], [O]);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTT(Rd, [pc], [0], W);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGTT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; O: Word);
begin
  LDRGTBT(Rd, [pc], [O]);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRGTBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRGTBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGT(Rd: TArmReg; O: Word);
begin
  STRGT(Rd, [pc], [O]);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGT(Rd, [pc], [0], W);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGTB(Rd: TArmReg; O: Word);
begin
  STRGTB(Rd, [pc], [O]);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTB(Rd, [pc], [0], W);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGTB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGTB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGTT(Rd: TArmReg; O: Word);
begin
  STRGTT(Rd, [pc], [O]);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTT(Rd, [pc], [0], W);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGTT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGTT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRGTBT(Rd: TArmReg; O: Word);
begin
  STRGTBT(Rd, [pc], [O]);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTBT(Rd, [pc], [0], W);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($C, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRGTBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($C, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($C, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRGTBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRGTBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($C, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLE(Rd: TArmReg; O: Word);
begin
  LDRLE(Rd, [pc], [O]);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLE(Rd, [pc], [0], W);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLEB(Rd: TArmReg; O: Word);
begin
  LDRLEB(Rd, [pc], [O]);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLEB(Rd, [pc], [0], W);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLET(Rd: TArmReg; O: Word);
begin
  LDRLET(Rd, [pc], [O]);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLET(Rd, [pc], [0], W);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; O: Word);
begin
  LDRLEBT(Rd, [pc], [O]);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLEBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRLEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRLEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLE(Rd: TArmReg; O: Word);
begin
  STRLE(Rd, [pc], [O]);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLE(Rd, [pc], [0], W);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLE(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLE(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLE(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLEB(Rd: TArmReg; O: Word);
begin
  STRLEB(Rd, [pc], [O]);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLEB(Rd, [pc], [0], W);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLEB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLEB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLEB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLET(Rd: TArmReg; O: Word);
begin
  STRLET(Rd, [pc], [O]);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLET(Rd, [pc], [0], W);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLET(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLET(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLET(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRLEBT(Rd: TArmReg; O: Word);
begin
  STRLEBT(Rd, [pc], [O]);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLEBT(Rd, [pc], [0], W);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($D, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRLEBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($D, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($D, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRLEBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRLEBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($D, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRAL(Rd: TArmReg; O: Word);
begin
  LDRAL(Rd, [pc], [O]);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRAL(Rd, [pc], [0], W);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRAL(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRAL(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRALB(Rd: TArmReg; O: Word);
begin
  LDRALB(Rd, [pc], [O]);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALB(Rd, [pc], [0], W);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRALB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRALT(Rd: TArmReg; O: Word);
begin
  LDRALT(Rd, [pc], [O]);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALT(Rd, [pc], [0], W);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRALT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRALBT(Rd: TArmReg; O: Word);
begin
  LDRALBT(Rd, [pc], [O]);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRALBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRALBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRAL(Rd: TArmReg; O: Word);
begin
  STRAL(Rd, [pc], [O]);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRAL(Rd, [pc], [0], W);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRAL(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRAL(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRAL(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRALB(Rd: TArmReg; O: Word);
begin
  STRALB(Rd, [pc], [O]);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALB(Rd, [pc], [0], W);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRALB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRALB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRALT(Rd: TArmReg; O: Word);
begin
  STRALT(Rd, [pc], [O]);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALT(Rd, [pc], [0], W);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRALT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRALT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRALBT(Rd: TArmReg; O: Word);
begin
  STRALBT(Rd, [pc], [O]);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALBT(Rd, [pc], [0], W);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($E, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRALBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($E, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($E, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRALBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRALBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($E, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNV(Rd: TArmReg; O: Word);
begin
  LDRNV(Rd, [pc], [O]);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNV(Rd, [pc], [0], W);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNV(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNV(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNVB(Rd: TArmReg; O: Word);
begin
  LDRNVB(Rd, [pc], [O]);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVB(Rd, [pc], [0], W);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNVB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNVT(Rd: TArmReg; O: Word);
begin
  LDRNVT(Rd, [pc], [O]);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVT(Rd, [pc], [0], W);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 0, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 0, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 0, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNVT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 0, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; O: Word);
begin
  LDRNVBT(Rd, [pc], [O]);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVBT(Rd, [pc], [0], W);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 1, Ord(W), 1, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  LDRNVBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 1, Ord(W), 1, Rn[0], Shift, Rm[0]);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 1, 1, 1, Rn[0], Rd, O and $FFF);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  LDRNVBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.LDRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 1, 1, 1, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNV(Rd: TArmReg; O: Word);
begin
  STRNV(Rd, [pc], [O]);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNV(Rd, [pc], [0], W);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNV(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNV(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNV(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNVB(Rd: TArmReg; O: Word);
begin
  STRNVB(Rd, [pc], [O]);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVB(Rd, [pc], [0], W);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVB(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNVB(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNVB(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNVT(Rd: TArmReg; O: Word);
begin
  STRNVT(Rd, [pc], [O]);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVT(Rd, [pc], [0], W);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 0, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 0, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 0, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNVT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNVT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 0, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.STRNVBT(Rd: TArmReg; O: Word);
begin
  STRNVBT(Rd, [pc], [O]);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVBT(Rd, [pc], [0], W);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const O: array of SmallInt; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransferI($F, 1, Ord(O[0] >= 0), 1, Ord(W), 0, Rn[0], Rd, O[0] and $FFF);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  STRNVBT(Rd, Rn, ARM_PLUS, Rm, Shift, W);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; const Rm: array of TArmReg; Shift: Byte = 0; W: TArmWriteBack = ARM_DONOTWRITE);
begin
  DataTransfer($F, 1, Ord(Sign), 1, Ord(W), 0, Rn[0], Shift, Rm[0]);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; O: SmallInt);
begin
  DataTransferI($F, 0, Ord(O >= 0), 1, 1, 0, Rn[0], Rd, O and $FFF);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Rm: TArmReg; Shift: Byte = 0);
begin
  STRNVBT(Rd, Rn, ARM_PLUS, Rm, Shift);
end;

procedure TArm.STRNVBT(Rd: TArmReg; const Rn: array of TArmReg; Sign: TArmSign; Rm: TArmReg; Shift: Byte = 0);
begin
  DataTransfer($F, 0, Ord(Sign), 1, 1, 0, Rn[0], Rd, Shift, Rm);
end;

procedure TArm.SwapInstruction(C, B: Byte; Rd, Rm, Rn: TArmReg);
begin
  WriteU(((Ord(C)) shl 28) or (2 shl 23) or (B shl 22) or (Ord(Rn) shl 16) or (Ord(Rd) shl 12) or (9 shl 4) or Ord(Rm));
end;

procedure TArm.SWP(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($E, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($E, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPEQ(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($0, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPEQB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($0, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPNE(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($1, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPNEB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($1, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPHS(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($2, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPHSB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($2, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPCS(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($2, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPCSB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($2, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLO(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($3, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLOB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($3, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPCC(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($3, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPCCB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($3, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPMI(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($4, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPMIB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($4, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPPL(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($5, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPPLB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($5, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPVS(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($6, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPVSB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($6, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPVC(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($7, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPVCB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($7, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPHI(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($8, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPHIB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($8, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLS(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($9, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLSB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($9, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPGE(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($A, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPGEB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($A, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLT(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($B, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLTB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($B, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPGT(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($C, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPGTB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($C, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLE(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($D, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPLEB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($D, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPAL(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($E, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPALB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($E, 1, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPNV(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($F, 0, Rd, Rm, Rn[0]);
end;

procedure TArm.SWPNVB(Rd, Rm: TArmReg; const Rn: array of TArmReg);
begin
  SwapInstruction($F, 1, Rd, Rm, Rn[0]);
end;

end.

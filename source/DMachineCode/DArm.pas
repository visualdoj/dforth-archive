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
                        r13     = 13, sp = 13,
                        r14     = 14, lr = 14,
                        r15     = 15, pc = 15
                );

type
  TArm = class(TMachineCode)
  private
  public
  public
    constructor Create(BaseSize: Integer);
    // arm mnemonics
  
    procedure WriteDataTrans(C, I, O, S, N, D: Byte; R: Cardinal); overload;
    procedure WriteDataTransR(C, O, S, N, D: Byte; R, F: Byte); overload;
    procedure WriteDataTransI(C, O, S, N, D: Byte; I, R: Byte); overload;
  // branch menmonics
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
  end;

implementation

constructor TArm.Create(BaseSize: Integer);
begin
end;

procedure TArm.WriteDataTrans(C, I, O, S, N, D: Byte; R: Cardinal);
begin
  WriteU(((Ord(C)) shl 28) or ((Ord(I)) shl 25) or (O shl 22) or ((Ord(S)) shl 20) or (N shl 16) or (D shl 12) or R);
end;

procedure TArm.WriteDataTransR(C, O, S, N, D: Byte; R, F: Byte);
begin
  WriteDataTrans(C, 0, O, S, N, D, (F shl 4) or R);
end;

procedure TArm.WriteDataTransI(C, O, S, N, D: Byte; I, R: Byte);
begin
  WriteDataTrans(1, 0, O, S, N, D, ((R and $F) shl 8) or I);
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

procedure TArm.ANDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $0, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ANDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $0, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ANDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $0, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ANDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $0, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EOREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EOREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EOREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EOREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $1, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.EORNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $1, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.EORNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $1, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.EORNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $1, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $2, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SUBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $2, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SUBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $2, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SUBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $2, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $3, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSBNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $3, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSBNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $3, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSBNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $3, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $4, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADDNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $4, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADDNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $4, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADDNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $4, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $5, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ADCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $5, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ADCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $5, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ADCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $5, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $6, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.SBCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $6, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.SBCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $6, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.SBCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $6, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $7, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.RSCNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $7, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.RSCNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $7, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.RSCNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $7, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $8, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TSTNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $8, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TSTNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $8, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TSTNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $8, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $9, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.TEQNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $9, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.TEQNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $9, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.TEQNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $9, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $A, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMPNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $A, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMPNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $A, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMPNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $A, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $B, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.CMNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $B, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.CMNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $B, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.CMNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $B, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORREQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORREQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORREQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORREQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $C, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.ORRNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $C, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.ORRNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $C, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.ORRNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $C, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $D, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MOVNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $D, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MOVNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $D, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MOVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $D, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $E, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.BICNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $E, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.BICNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $E, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.BICNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $E, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNEQ(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($0, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNEQS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($0, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNEQ(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNEQS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($0, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNNE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($1, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNNES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($1, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNNE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNNES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($1, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNHS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNHSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNHS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNHSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNCS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($2, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNCSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($2, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNCSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($2, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLO(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNLOS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNLO(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLOS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNCC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($3, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNCCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($3, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNCC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNCCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($3, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNMI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($4, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNMIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($4, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNMI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNMIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($4, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNPL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($5, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNPLS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($5, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNPL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNPLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($5, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNVS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($6, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNVSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($6, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNVSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($6, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNVC(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($7, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNVCS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($7, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNVC(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNVCS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($7, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNHI(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($8, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNHIS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($8, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNHI(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNHIS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($8, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLS(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($9, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNLSS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($9, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNLS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLSS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($9, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNGE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($A, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNGES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($A, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNGE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNGES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($A, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($B, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNLTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($B, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNLT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($B, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNGT(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($C, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNGTS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($C, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNGT(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNGTS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($C, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLE(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($D, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNLES(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($D, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNLE(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNLES(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($D, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNAL(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($E, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNALS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($E, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNAL(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNALS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($E, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNNV(Dst, Src1, Src2: TArmReg; Shift: Word = 0);
begin
  WriteDataTransR($F, $F, 0, Ord(Src1), Ord(Dst), Ord(Src2), Shift);
end;

procedure TArm.MVNNVS(Dst, Src1, Src2: TArmReg; Shift: Byte = 0);
begin
  WriteDataTransR($F, $F, 1, Ord(Src1), Ord(Dst), Ord(Src2), Shift); 
end;

procedure TArm.MVNNV(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $F, 0, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

procedure TArm.MVNNVS(Dst, Src: TArmReg; Imm: Byte; Rotate: Byte = 0);
begin
  WriteDataTransI($F, $F, 1, Ord(Src), Ord(Dst), Imm, Rotate); 
end;

end.

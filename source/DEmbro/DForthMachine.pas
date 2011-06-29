
unit DForthMachine;

interface

{$DEFINE FLAG_X86}
{$DEFINE FLAG_IA32}








uses
  {$I units.inc},Math,strings,DAlien,DVocabulary,DEmbroCore,DEmbroSource,DCommandsTable,DForthStack;

const
  DFORTHMACHINE_VERSION = 11;
  DFORTHMACHINE_DATE: TString = '\Fri Jul 29 19:54 2011\';



















{$IFNDEF FLAG_FPC}{$REGION 'data_commands'}{$ENDIF}


{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'sysar_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'system_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'stack utils'}{$ENDIF}


{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

const
  CONV_STDCALL: Integer = 100;
  CONV_CDECL: Integer   = 101;

  MACHINE_MODE_READY            = $00;
  MACHINE_MODE_BREAKPOINT       = $01;
  MACHINE_MODE_WAITSOURCE       = $02;
  MACHINE_MODE_WORK             = $03;

  FS_INTERPRET                  = $00;
  FS_COMPILE                    = not $00;
  // FS_RUN                        = $02;

  DF_FILE_R                     = $A0;
  DF_FILE_W                     = $A1;

  EOL: String                   = #13;

type
  TForthMachine = ^OForthMachine;

  PForthCommand = ^TForthCommand;
  TCode = procedure (Machine: TForthMachine; Command: PForthCommand); register;
  TForthCommand = record 
          Code: TCode;
          Data: Pointer;
          Flags: Byte;
          Name: PAnsiChar; 
          Param: Pointer;
        end;
  TXt = PForthCommand;

  // Machine размещается в EAX
  // Command размещается в EDX

  TCallback = procedure (machine: Pointer); stdcall;
  TForthRuntimeProc = procedure (machine: TForthMachine; Command: PForthCommand) 
                                                                      of object;
  TForthCommandProc = procedure (machine: TForthMachine) of object;

  TMnemonic = TInt;
  TOpcode = TInt;
  TPtr = Pointer;
  TEmbroPtr = TInt;

  TRecBlock = packed record
    Ref: TInt;
  end;
  TBlock = ^TRecBlock;

  TStrRec = packed record
    Ref: TInt;
    Len: TInt;
    Width: TInt;
    Sym: array[0..1] of Byte;
  end;
  PStrRec = ^TStrRec;
  TStr = PStrRec;

  PLong = ^TLong;
  TLong = record
    Ref: Integer; // -1 если не нужно высвобождать из памяти,иначе --- число ссылок
    Flags: Integer; // Flags and 1 > 0 если число отрицательно
    Len: Integer; // Такое число,что V[I] = 0 для всех I >= Len
    Max: Integer; // Число элементов в массиве V
    V: array[0..1] of Integer;
  end;

  TType = record
    Name: PChar;
    Size: Integer;
  end;
  PType = ^TType;

  TEmbroItemInfo = packed record
    Typ: TUInt8;
    Size: TUInt16;
    Reserver: TUInt8;
  end;
{$IFNDEF FLAG_FPC}{$REGION 'OForthMachine'}{$ENDIF}
OForthMachine = object
{$IFNDEF FLAG_FPC}{$REGION 'machine datas'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'W'}{$ENDIF}
  WP: Pointer; // Work stack Pointer
  W: array of Byte; // Work stack
  WB: Pointer; // Work stack Base (@W[0])
  WS: Integer; // Work stack Size
  BW: array of Pointer; // Counter Work stack
  BWB: Pointer;
  BWP: Pointer;
  BWS: Integer;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'E'}{$ENDIF}
  E: array of Byte; // Embro
  EB: Pointer; // Embro Base (@E[0])
  EC: Integer; // Embro Counter (E[EC])
  EL: Integer; // Embro Last compiled
  ES: Integer; // Embro Size (Length(E))
  Embro: array of Cardinal;
  EmbroB: Pointer;
  EmbroP: Integer;
  EmbroL: Integer;
  EmbroS: Integer;
  EmbroI: array of TEmbroItemInfo;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'R'}{$ENDIF}
  R: array of Byte; // Return stack
  RB: Pointer; // Return stack Base
  RP: Pointer; // Return stack Pointer
  RS: Integer; // Return stack Size
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'C'}{$ENDIF}
  C: array of PForthCommand; // Commands
  CB: Pointer; // Commands Base (@C[0])
  CC: Integer; // Commands Counter (C[CC] - last added command)
  CS: Integer; // Commands Size (Length(C))
  // Command REserve
  // Command FInd
  // Command EXecute
  // Command COmpile
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'LOCALS'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'D'}{$ENDIF}
 {D: array of Byte; // Data
  DB: Pointer; // Data Base
  DP: Pointer; // Data Pointer (traditionaly called HERE in forth)
  DS: Integer; // Data Size
  procedure DA(Size: Integer); // Data Allot}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'S'}{$ENDIF}
  // doesn't work in run state
  // S: PChar; // Source
  // SC: Integer; // Source Counter
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
  L: array of Byte; // Local stack
  LB: Pointer; // Local stack Base (@W[0])
  LP: Pointer; // Local stack Pointer
  LS: Integer; // Local stack Size
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'V'}{$ENDIF}
  Context: array of PVoc;
  Target: array of PVoc;
  vGLOBAL: PVoc;
  vLOCAL: PVoc;
  vBUILTIN: PVoc;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'plugin datas'}{$ENDIF}
  Code: packed record
    Count: Cardinal;
    Chunks: Pointer;
  end;
  Chunks: array of packed record
                            Opcode: Cardinal;
                            Len: Cardinal;
                            Data: Pointer;
                            Count: Cardinal;
                            Refs: Pointer;
                          end;
  Refs: array of array of Cardinal;
  Commands: array of packed record
                       Name: PChar;
                       Flags: Integer;
                       Code: Integer;
                       Data: Integer;
                     end;
  FOutput: TString;
  FAppType: Integer;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'Strings'}{$ENDIF}
  // когда они создаются при интерпритации,нужно где-то хранить
  FPChars: array of array of TChar;

  TempS: TStr;
  FStrNil: TStr;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'exceptions'}{$ENDIF}
  Exceptions: array of Byte;
  ExceptionsB: Pointer;
  ExceptionsP: Pointer;
  ExceptionsS: Integer;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'system options'}{$ENDIF}
  nop: PForthCommand;
  ConvStr: PForthCommand;
  ConvName: PForthCommand;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  UserData: Pointer;
  //C: array of TForthCommand;
  FData: array of Byte;
  //FHere: Integer;
  FCompilation: Boolean;
  FRunning: Boolean;
  FSource: PSource;
  FCurrentChar: Integer;
  //FPC: Cardinal;
  FCurrentName: TString;
  // FS_*
  State: Integer;
  FSession: Boolean;
  FLastMnemonic: Integer;
  FEmbroDump: array of TString;
  FEmbro: array of Byte;
  FTypes: array of TType;
  //FMemoryDebug: TDebug;
  FAlien: TAlien;
  FCurrentFileName: TString;
  FCurrentLine: Integer;
  FCurrentPos: Integer;
  Directories: array of TString;
  procedure CompileSource(Source: PChar);
  function CompileName(W: PChar): Boolean; overload;
  function NextMnemonic: Cardinal;
  procedure Run(Index: Integer);
  procedure RunMnemonic(M: Cardinal);
  procedure RunCommand(Command: PForthCommand);
  procedure RunError(const Message: TString);
  procedure RunWarring(const Message: TString);
  procedure IncHere(Count: Integer);
  procedure AddType(const Name: TString; Size: Integer);
  
  procedure EW_ (V: TInt);
  function ER_: TInt
  
  
;
  
  procedure EW_int (V: TInt);
  function ER_int: TInt
  
  
;
  
  procedure EW_int8 (V: TInt8);
  function ER_int8: TInt8
  
  
;
  
  procedure EW_int16 (V: TInt16);
  function ER_int16: TInt16
  
  
;
  
  procedure EW_int32 (V: TInt32);
  function ER_int32: TInt32
  
  
;
  
  procedure EW_int64 (V: TInt64);
  function ER_int64: TInt64
  
  
;
  
  procedure EW_uint (V: TUInt);
  function ER_uint: TUInt
  
  
;
  
  procedure EW_uint8 (V: TUInt8);
  function ER_uint8: TUInt8
  
  
;
  
  procedure EW_uint16 (V: TUInt16);
  function ER_uint16: TUInt16
  
  
;
  
  procedure EW_uint32 (V: TUInt32);
  function ER_uint32: TUInt32
  
  
;
  
  procedure EW_uint64 (V: TUInt64);
  function ER_uint64: TUInt64
  
  
;
  
  procedure EW_float (V: Single);
  function ER_float: Single
  
  
;
  
  procedure EW_double (V: Double);
  function ER_double: Double
  
  
;
  
  procedure EW_extended (V: Extended);
  function ER_extended: Extended
  
  
;
  
  function ConvertStrTo(const B: TString; var X: TInt): Integer
  
;
  
  function ConvertStrToint(const B: TString; var X: TInt): Integer
  
;
  
  function ConvertStrToint8(const B: TString; var X: TInt8): Integer
  
;
  
  function ConvertStrToint16(const B: TString; var X: TInt16): Integer
  
;
  
  function ConvertStrToint32(const B: TString; var X: TInt32): Integer
  
;
  
  function ConvertStrToint64(const B: TString; var X: TInt64): Integer
  
;
  
  function ConvertStrTouint(const B: TString; var X: TUInt): Integer
  
;
  
  function ConvertStrTouint8(const B: TString; var X: TUInt8): Integer
  
;
  
  function ConvertStrTouint16(const B: TString; var X: TUInt16): Integer
  
;
  
  function ConvertStrTouint32(const B: TString; var X: TUInt32): Integer
  
;
  
  function ConvertStrTouint64(const B: TString; var X: TUInt64): Integer
  
;
{$IFNDEF FLAG_FPC}{$REGION 'machine datas'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'E'}{$ENDIF}
  procedure EA(Size: Integer); // Embro Alloc
  function Here: Pointer; overload;
  procedure EWV(V: Pointer; Size: Integer); // Embro Write Var
  procedure EWI(V: Integer); // Embro Write Integer
  procedure EWE(V: TEmbroPtr);
  procedure EWO(V: TOpcode); overload;
  procedure EWO(V: TString); overload;
  procedure BuiltinEWO(V: TString); 
  procedure EWR(V: TOpcode); overload;
  procedure EWI8(V: TInt8);
  procedure EWI16(V: TInt16);
  procedure EWI32(V: TInt32);
  procedure EWI64(V: TInt64);
  procedure EWU(V: TUInt);
  procedure EWU8(V: TUInt8);
  procedure EWU16(V: TUInt16);
  procedure EWU32(V: TUInt32);
  procedure EWU64(V: TUInt64);
  procedure EWC(V: Char);
  procedure EWS(V: Single);
  procedure EWD(const V: Double);
  procedure EWExtended(const V: Extended);
  procedure EWPChar(V: PChar);
  procedure EWStr(V: TString);
  procedure ERV(V: Pointer; Size: Integer); // Embro Read Var
  function ERI: Integer; // Embro Read Integer
  function ERE: TEmbroPtr;
  function ERO: TOpcode;
  function ERI8: TInt8;
  function ERI16: TInt16;
  function ERI32: TInt32;
  function ERI64: TInt64;
  function ERU: TUInt;
  function ERU8: TUInt8;
  function ERU16: TUInt16;
  function ERU32: TUInt32;
  function ERU64: TUInt64;
  function ERC: Char;
  function ERS: Single;
  function ERD: Double;
  function ERExtended: Extended;
  function ERPChar: PChar;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'R'}{$ENDIF}
  procedure RUV(const P: Pointer; Size: Integer);
  procedure ROV(const P: Pointer; Size: Integer);
  function ROP: Pointer 
  ; // Return stack pOp Pointer
  procedure RUI(const V: TInt); overload 
  ; // Return stack pUsh Integer
  procedure RUI8(const V: TInt8); overload 
  ; 
  procedure RUI16(const V: TInt16); overload 
  ;
  procedure RUI32(const V: TInt32); overload 
  ;
  procedure RUI64(const V: TInt64); overload 
  ;
  procedure RUU(const V: TUInt); overload 
  ;
  procedure RUU8(const V: TUInt8); overload 
  ; 
  procedure RUU16(const V: TUInt16); overload 
  ;
  procedure RUU32(const V: TUInt32); overload 
  ;
  procedure RUU64(const V: TUInt64); overload 
  ;
  procedure RUP(const V: Pointer); overload 
  ; // Return stack pUsh Pointer
  function ROI: TInt 
  ; // Return stack pOp Integer
  function ROI8: TInt8 
  ; 
  function ROI16: TInt16 
  ;
  function ROI32: TInt32 
  ;
  function ROI64: TInt64 
  ;
  function ROU: TUInt 
  ;
  function ROU8: TUInt8 
  ; 
  function ROU16: TUInt16 
  ;
  function ROU32: TUInt32 
  ;
  function ROU64: TUInt64 
  ;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'W'}{$ENDIF}
  procedure WUI(const V: TInt); overload 
  ; // Work stack pUsh Integer
  procedure WUP(const V: Pointer); overload 
  ; // Work stack pUsh Pointer
  function WOI: TInt 
  ; // Work stack pOp Integer
  function WOP: Pointer 
  ; // Work stack pOp Pointer
  procedure WUI8(const V: TInt8); overload 
  ; 
  procedure WUI16(const V: TInt16); overload 
  ;
  procedure WUI32(const V: TInt32); overload 
  ;
  procedure WUI64(const V: TInt64); overload 
  ;
  procedure WUU(const V: TUInt); overload 
  ;
  procedure WUU8(const V: TUInt8); overload 
  ; 
  procedure WUU16(const V: TUInt16); overload 
  ;
  procedure WUU32(const V: TUInt32); overload 
  ;
  procedure WUU64(const V: TUInt64); overload 
  ;
  function WOI8: TInt8 
  ; 
  function WOI16: TInt16 
  ;
  function WOI32: TInt32 
  ;
  function WOI64: TInt64 
  ;
  function WOU: TUInt 
  ;
  function WOU8: TUInt8 
  ; 
  function WOU16: TUInt16 
  ;
  function WOU32: TUInt32 
  ;
  function WOU64: TUInt64 
  ;
  procedure WUV(const P: Pointer; Size: Integer);
  procedure WOV(const P: Pointer; Size: Integer);
  procedure WUS(const S: TString);
  function WOS: TString;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'B'}{$ENDIF}
  procedure BWU(C: Pointer); // Block Work pUsh
  function BWO: Pointer; // Block Work pOp
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'C'}{$ENDIF}
  // Command REserve
  // Command FInd
  // Command EXecute
  // Command COmpile
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'LOCALS'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'S'}{$ENDIF}
  // doesn't work in run state
  function SE: Boolean; // Source End
  function SNC: TChar; // Source Next Char
  function SNN: TString; // Source Next Name
  procedure SSS; // Source Skip Spaces
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
  procedure LUV(const P: Pointer; Size: Integer);
  procedure LOV(const P: Pointer; Size: Integer);
  procedure LUI(const V: TInt); overload 
  ; // Work stack pUsh Integer
  procedure LUP(const V: Pointer); overload 
  ; // Work stack pUsh Pointer
  function LOI: TInt 
  ; // Work stack pOp Integer
  function LOP: Pointer 
  ; // Work stack pOp Pointer
  procedure LUI8(const V: TInt8); overload 
  ; 
  procedure LUI16(const V: TInt16); overload 
  ;
  procedure LUI32(const V: TInt32); overload 
  ;
  procedure LUI64(const V: TInt64); overload 
  ;
  procedure LUU(const V: TUInt); overload 
  ;
  procedure LUU8(const V: TUInt8); overload 
  ; 
  procedure LUU16(const V: TUInt16); overload 
  ;
  procedure LUU32(const V: TUInt32); overload 
  ;
  procedure LUU64(const V: TUInt64); overload 
  ;
  function LOI8: TInt8 
  ; 
  function LOI16: TInt16 
  ;
  function LOI32: TInt32 
  ;
  function LOI64: TInt64 
  ;
  function LOU: TUInt 
  ;
  function LOU8: TUInt8 
  ; 
  function LOU16: TUInt16 
  ;
  function LOU32: TUInt32 
  ;
  function LOU64: TUInt64 
  ;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'V'}{$ENDIF}
  function HighTarget: PVoc;
  procedure ContextPush(V: PVoc);
  function ContextPop: PVoc;
  procedure TargetPush(V: PVoc);
  function TargetPop: PVoc;
  procedure UseVoc(V: PVoc);
  procedure UnuseVoc;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  constructor Create;
  destructor Destroy;
  procedure AddCommand(Name: PChar; Code: TCode; Immediate: Boolean = False;
                       Builtin: Boolean = True);
  procedure OnUpdateCommand(Opcode: Integer); overload;
  procedure OnUpdateCommand(Command: PForthCommand); overload;
  procedure AddToContext(Index: Integer);
  procedure UpdateContext;

  procedure InterpretName(W: PChar); overload;
  procedure Interpret(const Line: PChar); overload;
  procedure InterpretFile(const FileName: TString);
  procedure CallCommand(Command: PForthCommand);
  procedure MainLoop;
  procedure Step;
  procedure InterpretStep;
  procedure CompileStep;
  procedure RunStep;
  
  // команды времени компиляции
  procedure CompileError(const Message: TString);
  procedure CompileWarring(const Message: TString);
  procedure LogError(const Message: TString);
  function NextChar: TChar;
  function NextName: TString; overload;
  function NextName(S: PChar; var I: Integer): TString; overload;
  function NextNamePassive: TString;
  function EOS: Boolean; // end of source
  procedure WriteEmbro(P: Pointer; Size: Integer);
  procedure WriteEmbroInt(I: Integer); overload;
  procedure WriteEmbroUInt(U: Cardinal); overload;
  procedure WriteEmbroChar(C: Char); overload;
  procedure WriteEmbroByte(B: Byte); overload;
  procedure PopEmbro(P: Pointer; Size: Integer);
  procedure WriteMnemonic(M: Cardinal);
  procedure WriteMnemonicByName(const Name: TString);
  function GetOpcodeByName(const Name: TString): TMnemonic;
  function GetCommandByOpcode(Opcode: Integer): PForthCommand;
  procedure CancelMnemonic;
  function ReserveName(const Name: TString): PForthCommand;
  
  procedure ReadEmbro(P: Pointer; Size: Integer);
  function ReadMnemonic: TMnemonic;

  function GetEmbroDumpLines: Integer;
  function GetEmbroDumpLine(Index: Integer): TString;
  function FindCommand(Voc: PVoc; const Name: TString; Index: PInteger = nil): PForthCommand; overload;
  function FindCommand(const Name: TString; Index: PInteger = nil): PForthCommand; overload;
  function ExtendedFindCommand(const Name: TString; Index: PInteger = nil): PForthCommand; overload;
  property Source: PSource read FSource;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'all commands'}{$ENDIF}
  
  procedure _sys_exceptions_execute (Machine: TForthMachine; Command: PForthCommand);
  procedure _sys_exceptions_pop (Machine: TForthMachine; Command: PForthCommand);
  procedure _throw (Machine: TForthMachine; Command: PForthCommand);
  
  
  

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'misc commands'}{$ENDIF}
  procedure _nop(Machine: TForthMachine; Command: PForthCommand);
  procedure _builtedin(Machine: TForthMachine; Command: PForthCommand);
  procedure _builtin(Machine: TForthMachine; Command: PForthCommand);
  procedure CompileComment(Machine: TForthMachine; Command: PForthCommand);
  procedure CompileLineComment(Machine: TForthMachine; Command: PForthCommand);
  procedure _here(Machine: TForthMachine; Command: PForthCommand); overload;
  procedure _FIND_(Machine: TForthMachine; Command: PForthCommand);
  procedure _NOTFOUND_(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TControlCommands'}{$ENDIF}
procedure call(Machine: TForthMachine; Command: PForthCommand);
procedure _exit(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}

  procedure putdataptr(Machine: TForthMachine; Command: PForthCommand);
  procedure here(Machine: TForthMachine; Command: PForthCommand);
  procedure allot(Machine: TForthMachine; Command: PForthCommand);

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TTypeCommands'}{$ENDIF}
  procedure typeof(Machine: TForthMachine; Command: PForthCommand);
  procedure type_size(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_type(Machine: TForthMachine; Name: PChar);
  procedure interpete_type(Machine: TForthMachine; Name: PChar);
  procedure run_type(Machine: TForthMachine; Command: PForthCommand);
  procedure _void(Machine: TForthMachine; Command: PForthCommand);
  procedure _int(Machine: TForthMachine; Command: PForthCommand);
  procedure _int8(Machine: TForthMachine; Command: PForthCommand);
  procedure _int16(Machine: TForthMachine; Command: PForthCommand);
  procedure _int32(Machine: TForthMachine; Command: PForthCommand);
  procedure _int64(Machine: TForthMachine; Command: PForthCommand);
  procedure _uint(Machine: TForthMachine; Command: PForthCommand);
  procedure _uint8(Machine: TForthMachine; Command: PForthCommand);
  procedure _uint16(Machine: TForthMachine; Command: PForthCommand);
  procedure _uint32(Machine: TForthMachine; Command: PForthCommand);
  procedure _uint64(Machine: TForthMachine; Command: PForthCommand);
  procedure _bool(Machine: TForthMachine; Command: PForthCommand);
  procedure _str(Machine: TForthMachine; Command: PForthCommand);
  procedure _pchar(Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr(Machine: TForthMachine; Command: PForthCommand);
  procedure _type(Machine: TForthMachine; Command: PForthCommand);
  procedure _float(Machine: TForthMachine; Command: PForthCommand);
  procedure _double(Machine: TForthMachine; Command: PForthCommand);
  procedure _extended(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

function GetFileName(FullPath: TString): TString;
function GetDirectory(const FullPath: TString): TString;

function IsImmediate(Command: PForthCommand): Boolean;
procedure SetImmediate(Command: PForthCommand; I: Boolean);
function IsBuiltin(Command: PForthCommand): Boolean;
procedure SetBuiltin(Command: PForthCommand; I: Boolean);
function CopyStrToPChar(const B: TString): PChar;

implementation

uses
  DCommandsBool,DCommandsMisc,DCommandsArithmetic,DCommandsSignedArithmetic,DCommandsNumberArithmetic,DCommandsConvertNumber,DCommandsConsole,DCommandsStrings,DCommandsAlien,DCommandsF,DCommandsBW,DCommandsCompile,DCommandsCreatewords,DCommandsFiles,DCommandsInt,DCommandsMem,DCommandsOS,DCommandsPtr,DCommandsR,DCommandsSource,DCommandsVM,DCommandsVoc,DCommandsExtInt,DCommandsEmbro,DCommandsControl;

function GetFileName(FullPath: TString): TString;
var
  I: Integer;
begin
  I := Length(FullPath);
  while I > 0 do
    if FullPath[I] = '\' then begin
      Delete(FullPath, 1, I);
      break;
    end else
      Dec(I);
  Result := FullPath;
end;

function GetDirectory(const FullPath: TString): TString;
var
  I: Integer;
begin
  Result := FullPath;
  I := Length(FullPath);
  while I > 0 do
    if Result[I] = '\' then begin
      Result := Copy(Result, 1, I);
      Exit
    end else
      Dec(I);
end;

function InternalFileName(const FullPath: TString): TString;
begin
  Result := GetFileName(FullPath);
  if Length(Result) > 2 then
    if Pos('.de', Result) = Length(Result) - 2 then
      Delete(Result, Length(Result) - 2, 3);
end;

function IsImmediate(Command: PForthCommand): Boolean;
begin
  Result := (Command^.Flags and 1) > 0;
end;

procedure SetImmediate(Command: PForthCommand; I: Boolean);
begin
  with Command^ do
    if I then
      Flags := Flags or 1
    else
      Flags := Flags and not 1
end;

function IsBuiltin(Command: PForthCommand): Boolean;
begin
  Result := (Command^.Flags and 2) > 0;
end;

procedure SetBuiltin(Command: PForthCommand; I: Boolean);
begin
  Command^.Flags := Command^.Flags or (Ord(I) shl 1);
  with Command^ do
    if I then
      Flags := Flags or 2
    else
      Flags := Flags and not 2
end;

function CopyStrToPChar(const B: TString): PChar;
begin
  Result := StrAlloc(Length(B) + 1);
  StrCopy(Result, PChar(B));
end;

{$IFNDEF FLAG_FPC}{$REGION 'TControlCommands'}{$ENDIF}

procedure _exit;
begin
  with Machine^ do begin
    // Log('EXIT');
    if TUInt(Machine.RB) < TUInt(Machine.RP) then begin
      Machine.EC := Machine.ROI;
    end else if TUInt(Machine.RB) = TUInt(Machine.RP) then begin
      //Machine.EC := Length(Machine.FEmbro)
      Machine.RB := Machine.ROP;
      // Machine.State := Machine.ROI;
      Machine.FRunning := False;
    end else begin
      Machine.LogError('[exit] R stack error (' +
                         IntToStr(TUInt(Machine.RP) - TUInt(Machine.RB)) + ')');
      Machine.FSession := False;
    end;
    Machine.LP := Machine.LB;
    Machine.LB := Machine.ROP;
  end;
end;

procedure call(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    // Writeln('INSIDE CALL "' + Command^.Name + '"');
    //Writeln('called function ' + Command^.Name);
    Machine.RUP(Machine.LB);
    Machine.LB := Machine.LP;
    if Machine.FRunning then
      Machine.RUI(Machine.EC)
    else begin
      // Machine.RUI(Machine.State);
      Machine.RUP(Machine.RB);
      Machine.RB := Machine.RP;
    end;
    Machine.EC := Integer(Command^.Data);
    Machine.FRunning := True;
    // Writeln('WP = ', Cardinal(Machine.WP));
  end;
end;

procedure compile_skip_to_end(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Integer(Machine.LP^) <> 101 then begin
      Machine.LogError('Нельзя использовать skip-to; внутри конструкций (на вершине стека не colon-id)');
      Exit;
    end;
    _gt_mark(Machine, nil);
    Machine.LUI(201);
  end;
end;

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}
procedure putdataptr(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    P := Command^.Data;
    Machine.WUP(P);
  end;
end;

procedure here(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    // FIXME: P не постоянен
    P := Machine.Here;
    Machine.WUP(P);
  end;
end;

procedure allot(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin
  with Machine^ do begin
    I := Machine.WOI;
    Machine.IncHere(I);
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TTypeCommands'}{$ENDIF}
procedure typeof(machine: tforthmachine; command: pforthcommand);
var
  Name: TString;
  I: Integer;
  P: PType;
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, PChar(Machine.NextName))
    else begin
      Name := Machine.NextName;
      for I := 0 to High(Machine.FTypes) do
        if TString(Machine.FTypes[I].Name) = Name then begin
          P := @Machine.FTypes[I];
          Machine.WUP(P);
          Exit;
        end;
      Machine.LogError('cannot find type "' + Name + '"');
    end;
  end;
end;

procedure type_size(Machine: TForthMachine; Command: PForthCommand);
var
  P: PType;
begin
  with Machine^ do begin
    P := Machine.WOP;
    Machine.WUI(P^.Size);
  end;
end;

procedure compile_type(Machine: TForthMachine; Name: PChar);
var
  I: Integer;
begin
  with Machine^ do begin
    for I := 0 to High(Machine.FTypes) do
      if TString(Machine.FTypes[I].Name) = TString(Name) then begin
        Machine.BuiltinEWO('(typeof)');
        Machine.EWI(I);
        Exit;
      end;
    Machine.LogError('cannot find type "' + Name + '"');
  end;
end;

procedure interpete_type(Machine: TForthMachine; Name: PChar);
var
  I: Integer;
begin
  with Machine^ do begin
    for I := 0 to High(Machine.FTypes) do
      if TString(Machine.FTypes[I].Name) = TString(Name) then begin
        Machine.WUP(@Machine.FTypes[I]);
        Exit;
      end;
    Machine.LogError('cannot find type "' + Name + '"');
  end;
end;

procedure run_type;
var
  I: TInt;
  P: PType;
begin
  with Machine^ do begin
    I := Machine.ERI;
    P := @Machine.FTypes[I];
    Machine.WUP(P);
  end;
end;

procedure _void(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'void')
    else
      interpete_type(Machine, 'void');
  end;
end;

procedure _int(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'int')
    else
      interpete_type(Machine, 'int');
  end;
end;

procedure _int8(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'int8')
    else
      interpete_type(Machine, 'int8');
  end;
end;

procedure _int16(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'int16')
    else
      interpete_type(Machine, 'int16');
  end;
end;

procedure _int32(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'int32')
    else
      interpete_type(Machine, 'int32');
  end;
end;

procedure _int64(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'int64')
    else
      interpete_type(Machine, 'int64');
  end;
end;

procedure _uint(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'uint')
    else
      interpete_type(Machine, 'uint');
  end;
end;

procedure _uint8(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'uint8')
    else
      interpete_type(Machine, 'uint8');
  end;
end;

procedure _uint16(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'uint16')
    else
      interpete_type(Machine, 'uint16');
  end;
end;

procedure _uint32(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'uint32')
    else
      interpete_type(Machine, 'uint32');
  end;
end;

procedure _uint64(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'uint64')
    else
      interpete_type(Machine, 'uint64');
  end;
end;

procedure _bool(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'bool')
    else
      interpete_type(Machine, 'bool');
  end;
end;

procedure _str(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'str')
    else
      interpete_type(Machine, 'str');
  end;
end;

procedure _pchar(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'pchar')
    else
      interpete_type(Machine, 'pchar');
  end;
end;

procedure _ptr(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'ptr')
    else
      interpete_type(Machine, 'ptr');
  end;
end;

procedure _type(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'type')
    else
      interpete_type(Machine, 'type');
  end;
end;

procedure _float(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'float')
    else
      interpete_type(Machine, 'float');
  end;
end;

procedure _double(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'double')
    else
      interpete_type(Machine, 'double');
  end;
end;

procedure _extended(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_type(Machine, 'extended')
    else
      interpete_type(Machine, 'extended');
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TForthMachine'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'folded'}{$ENDIF}
procedure OForthMachine.AddCommand(Name: PChar; Code: TCode; Immediate: Boolean = False; Builtin: Boolean = True);
begin
  SetLength(C, Length(C) + 1);
  New(C[High(C)]);
  C[High(C)].Name := StrAlloc(StrLen(Name)+1);
  StrCopy(C[High(C)].Name, Name);
  C[High(C)].Code := Code;
  SetImmediate(C[High(C)], Immediate);
  SetBuiltin(C[High(C)], Builtin);
  OnUpdateCommand(High(C));
  FLastMnemonic := High(C);
end;

procedure OForthMachine.OnUpdateCommand(Opcode: Integer);
begin
  VocAdd(HighTarget, Opcode);
  // Writeln('Add command ', C[Opcode]^.Name);
  if TString(C[Opcode]^.Name) = '_FIND_' then
    HighTarget.sFIND := Opcode
  else if TString(C[Opcode]^.Name) = '_NOTFOUND_' then
    HighTarget.sNOTFOUND := Opcode;
  FLastMnemonic := Opcode;
end;

procedure OForthMachine.OnUpdateCommand(Command: PForthCommand);
var
  I: Integer;
begin
  for I := High(C) downto 0 do
    if C[I] = Command then begin
      OnUpdateCommand(I);
      Exit;
    end;
end;

procedure OForthMachine.AddToContext(Index: Integer);
begin
  if Context[High(Context)] = nil then begin
    LogError('[OForthMachine.AddToContext] Incorrect context stack');
    Exit;
  end;
  VocAdd(Context[High(Context)], Index);
end;

procedure OForthMachine.UpdateContext;
var
  I: PVocItem;
begin
  if Context[High(Context)] = nil then begin
    LogError('[OForthMachine.UpdateContext] Incorrect context stack');
    Exit;
  end;
  I := Context[High(Context)].Item;
  while I <> nil do
    if TString(C[I^.Index].Name) = '_NOTFOUND_' then begin
      Context[High(Context)].sNOTFOUND := I^.Index;
      Break;
    end else
      I := I^.Next;
  while I <> nil do
    if TString(C[I^.Index].Name) = '_FIND_' then begin
      Context[High(Context)].sFIND := I^.Index;
      Break;
    end else
      I := I^.Next;
end;

procedure OForthMachine.CompileSource(Source: PChar);
begin
  FCompilation := True;
  State := FS_COMPILE;
  FCurrentChar := 0;
  while (not EOS) and FCompilation do begin
    FCurrentName := NextName;
    if FCurrentName = '' then
      Break;
    EWO(FCurrentName);
    CompileName(@FCurrentName[1]);
  end;
  //for I := 0 to High(FEmbro) do
  //  Write(IntToHex(FEmbro[I], 2), ' ');
  //Writeln;
  FCompilation := False;
end;

procedure _nop(Machine: TForthMachine; Command: PForthCommand);
begin
end;

procedure _builtedin(Machine: TForthMachine; Command: PForthCommand);
var
  S: TString;
  NewName: PAnsiChar;
  V: PVocItem;
begin
  NewName := PAnsiChar(Machine.WOS);
  S := TString(Machine.WOS);
  V := Machine.vBUILTIN.Item;
  while V <> nil do begin
    if TString(Machine.C[V^.Index].Name) = S then begin
      with Machine^ do
        AddCommand(NewName, C[V^.Index].Code, IsImmediate(C[V^.Index]));
      Exit;
    end;
    V := V^.Next;
  end;
  Machine.LogError('not found command "' + S + '"');
end;

procedure _builtin(Machine: TForthMachine; Command: PForthCommand);
begin
  source_next_name(Machine, Command);
  source_next_name(Machine, Command);
  _builtedin(Machine, Command);
end;

procedure CompileComment(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    {( это для m4}
    while Machine.NextChar <> ')' do
      if Machine.EOS then begin
        {( это для m4 }CompileError('need ")", but end of source found');
        Break;
      end;
  end;
end;

procedure CompileLineComment(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    while Machine.NextChar <> #13 do
      if Machine.EOS then
        Break;
  end;
end;

function OForthMachine.NextMnemonic: Cardinal;
begin
  Result := Cardinal((@FEmbro[EC])^);
  Inc(EC, SizeOf(Cardinal));
end;

procedure OForthMachine.Run(Index: Integer);
begin
  // Writeln('Deprecated code');
  LogError('Deprecated code');
  // Halt(-1);
end;

procedure OForthMachine.RunMnemonic(M: Cardinal);
begin
  //Writeln('RUN MNEMONIC "' + C[M].Name + '" ' + IntToStr(M) + ' EC:' + IntToStr(EC));
  // Writeln('RUN STEP "', C[M].Name, '"');
  if M = Cardinal(-1) then begin
    LogError('trying to run command with opcode -1');
    Exit;
  end;
  // Writeln(C[M].Name);
  C[M].Code(@Self, C[M]);
end;

procedure OForthMachine.RunCommand(Command: PForthCommand);
begin
  Command^.Code(@Self, Command);
end;

procedure OForthMachine.RunError(const Message: TString);
begin
  Error('Runtime(' + InternalFileName(FCurrentFileName) + ', ' +
                     IntToStr(FCurrentLine) + ', ' +
                     IntToStr(FCurrentPos) + '): ' + Message);
  // FRunning := False;
end;

procedure OForthMachine.RunWarring(const Message: TString);
begin
  Warrning('Runtime warring: ' + Message);
end;

procedure OForthMachine.IncHere(Count: Integer);
begin
  //Inc(Here, Count);
  EA(Count);
  //if Length(FData) - FHere < 1024 then
  //  SetLength(FData, Length(FData) + 1024);
end;

procedure OForthMachine.AddType(const Name: TString; Size: Integer);
var
  Command: PForthCommand;
begin
  SetLength(FTypes, Length(FTypes) + 1);
  FTypes[High(FTypes)].Name := PChar(Name);
  FTypes[High(FTypes)].Size := Size;

  Command := ReserveName(Name);
  SetImmediate(Command, True);
  SetBuiltin(Command, True);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'E'}{$ENDIF}
procedure OForthMachine.EA(Size: Integer); // Embro Alloc
begin
  Inc(EL, Size);
end;

function OForthMachine.Here: Pointer;
begin
  Result := @E[EL];
end;

procedure _here(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Pointer(WP^) := @E[EL];
    Inc(WP, SizeOf(Pointer));
  end;
end;

procedure OForthMachine.EWV(V: Pointer; Size: Integer); // Embro Write Data
begin
  Move(V^, (@E[EL])^, Size);
  Inc(EL, Size);

  Inc(Chunks[High(Chunks)].Len, Size);
end;

procedure OForthMachine.EWI(V: Integer);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' ' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWE(V: TEmbroPtr);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' embro:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWO(V: TOpcode);
begin
  Move(V, (@E[EL])^, SizeOf(V));
  Inc(EL, SizeOf(V));

  SetLength(FEmbroDump, Length(FEmbroDump) + 1);
  FEmbroDump[High(FEmbroDump)] := C[V].Name + ' ';

  SetLength(Chunks, Length(Chunks) + 1);
  Chunks[High(Chunks)].Opcode := V;
  Chunks[High(Chunks)].Data := @E[EL];
  Chunks[High(Chunks)].Len := 0;
  Chunks[High(Chunks)].Count := 0;
  Chunks[High(Chunks)].Refs := nil;
  SetLength(Refs, Length(Refs) + 1);
  //Writeln('WRITE OPCODE: ' + IntToStr(V));
end;

procedure OForthMachine.EWO(V: TString);
var
  I: TOpcode;
begin
  (* for I := High(C) downto 0 do *)
  (*   if TString(C[I].Name) = V then begin *)
  (*     EWO(I); *)
  (*     Exit; *)
  (*   end; *)
  if FindCommand(V, @I) <> nil then begin
    EWO(I);
    Exit;
  end;
  FSession := False;
  LogError('command "' + V + '" not found');
end;

procedure OForthMachine.BuiltinEWO(V: TString); 
var
  I: TOpcode;
begin
  if FindCommand(vBUILTIN, V, @I) <> nil then begin
    EWO(I);
    Exit;
  end;
  FSession := False;
  LogError('builtin command "' + V + '" not found');
end;

procedure OForthMachine.EWR(V: TOpcode);
begin
  // TODO
end;

procedure OForthMachine.EWI8(V: TInt8);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int8:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWI16(V: TInt16);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int16:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWI32(V: TInt32);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int32:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWI64(V: TInt64);
begin
  EWV(@V, SizeOf(V));
  
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int64:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWU(V: TUInt);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' u' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWU8(V: TUInt8);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint8:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWU16(V: TUInt16);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint16:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWU32(V: TUInt32);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint32:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWU64(V: TUInt64);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint64:' + IntToStr(V) + ' ';
end;

procedure OForthMachine.EWC(V: Char);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + V;
end;

procedure OForthMachine.EWS(V: Single);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' s' + FloatToStr(V) + ' ';
end;

procedure OForthMachine.EWD(const V: Double);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' d' + FloatToStr(V) + ' ';
end;

procedure OForthMachine.EWExtended(const V: Extended);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' e' + FloatToStr(V) + ' ';
end;

procedure OForthMachine.EWPChar(V: PChar);
begin
  // TODO
end;

procedure OForthMachine.EWStr(V: TString);
var
  B: TStr;
begin
  B := CreateStr(V);
  PStrRec(B)^.Ref := 1;
  EWV(B, SizeOf(Integer)*3 + PStrRec(B)^.Len + 1);

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' "' + V + '" ';
end;

procedure OForthMachine.ERV(V: Pointer; Size: Integer);
begin
  Move((@E[EC])^, V^, Size);
  Inc(EC, Size);
end;

function OForthMachine.ERI: Integer;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERE: TEmbroPtr;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERO: TOpcode;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERI8: TInt8;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERI16: TInt16;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERI32: TInt32;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERI64: TInt64;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERU: TUInt;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERU8: TUInt8;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERU16: TUInt16;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERU32: TUInt32;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERU64: TUInt64;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERC: Char;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERS: Single;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERD: Double;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERExtended: Extended;
begin
  ERV(@Result, SizeOf(Result));
end;

function OForthMachine.ERPChar: PChar;
begin
  // TODO
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'D'}{$ENDIF}
{procedure OForthMachine.DA(Size: Integer);
begin
  Inc(Here, Size);
end;}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'S'}{$ENDIF}
function OForthMachine.SE: Boolean;
begin
  Result := FSource^.EOS;
  //Result := S[SC] = #0;
end;

function OForthMachine.SNC: TChar;
begin
  Result := FSource^.NextChar;
  {Result := S[SC];
  if not SE then begin
    Inc(SC);
    if Result = EOL then begin
      Inc(FCurrentLine);
      FCurrentPos := 1
    end else
      Inc(FCurrentPos);
  end;}
end;

function OForthMachine.SNN: TString;
var
  Ch: TChar;
begin
  Result := '';
  repeat
    Ch := SNC;
  until (not (Ch in [#0..#32])) or SE;
  repeat
    Result := Result + Ch;
    if SE then
      Exit;
    Ch := SNC;
  until (Ch in [#0..#32]) or SE;
  if not (Ch in [#0..#32]) then
    Result := Result + Ch;
end;

procedure OForthMachine.SSS;
begin
  FSource^.SkipSpaces;
  //while (not SE) and (S[SC] in [#1..#32]) do
  //  SNC;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'R'}{$ENDIF}
procedure OForthMachine.RUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, RP^, Size);
  Inc(RP, Size);
end;

procedure OForthMachine.ROV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(RP^, P^, Size);
  Dec(RP, Size);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'W'}{$ENDIF}
procedure OForthMachine.BWU;
begin
  Pointer(BWP^) := C;
  Inc(BWP, SizeOf(Pointer));
end;

function OForthMachine.BWO;
begin
  Dec(BWP, SizeOf(Pointer));
  Result := Pointer(BWP^);
end;

procedure OForthMachine.WUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, WP^, Size);
  Inc(WP, Size);
end;

procedure OForthMachine.WOV(const P: Pointer; Size: Integer);
begin
  Dec(WP, Size);
  if P <> nil then
    Move(WP^, P^, Size);
end;

procedure OForthMachine.WUS(const S: TString);
begin
  str_push(@Self, S);
end;

function OForthMachine.WOS: TString;
var
  S_: PStrRec;
begin
  S_ := str_pop(@Self);
  Result := StrToString(S_);
  DelRef(S_);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
procedure OForthMachine.LUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, LP^, Size);
  Inc(LP, Size);
end;

procedure OForthMachine.LOV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(LP^, P^, Size);
  Dec(LP, Size);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'V'}{$ENDIF}
function OForthMachine.HighTarget: PVoc;
var
  I: Integer;
begin
  I := High(Target);
  while (I > 0) and (Target[I] = nil) do
    Dec(I);
  Result := Target[I];
end;

procedure OForthMachine.ContextPush(V: PVoc);
begin
  SetLength(Context, Length(Context) + 1);
  Context[High(Context)] := V;
end;

function OForthMachine.ContextPop: PVoc;
begin
  if Length(Context) = 0 then
    Exit;
  Result := Context[High(Context)];
  if Length(Context) = 1 then begin
    LogError('trying to pop root context vocabulary');
    Exit;
  end;
  SetLength(Context, Length(Context) - 1);
end;

procedure OForthMachine.TargetPush(V: PVoc);
begin
  SetLength(Target, Length(Target) + 1);
  Target[High(Target)] := V;
end;

function OForthMachine.TargetPop: PVoc;
begin
  if Length(Target) = 0 then
    Exit;
  Result := Target[High(Target)];
  if Length(Target) = 1 then begin
    LogError('trying to pop root target vocabulary');
    Exit;
  end;
  SetLength(Target, Length(Target) - 1);
end;

procedure OForthMachine.UseVoc(V: PVoc);
begin
  TargetPush(V);
  ContextPush(V);
end;

procedure OForthMachine.UnuseVoc;
begin
  TargetPop;
  ContextPop;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

constructor OForthMachine.Create;
begin
  GetMem(FStrNil, 3*SizeOf(TInt) + 1);
  PStrRec(FStrNil)^.Ref := 1;
  PStrRec(FStrNil)^.Len := 0;
  PStrRec(FStrNil)^.Width := 1;
  PStrRec(FStrNil)^.Sym[0] := 0;

  SetLength(E, 1024 * 1024);
  EB := @E[0];
  EC := 0;
  EL := 0;
  ES := Length(E);
  SetLength(R,   16 * 1024);
  RB := @R[0];
  RP := RB;
  RS := Length(R);
  SetLength(W,   16 * 1024);
  WB := @W[0];
  WP := WB;
  WS := Length(W);
  SetLength(BW,  4 * 1024);
  BWB := @BW[0];
  BWP := BWB;
  BWS := Length(BW);
  SetLength(C,   0);
  CB := @C[0];
  CC := 0;
  CS := Length(C);
  {SetLength(D, 1024 * 1024);
  DB := @D[0];
  Here := DB;
  DS := Length(D);}
  SetLength(L, 1024 * 1024);
  LB := @L[0];
  LP := LB;
  LS := Length(L);
  //S  := nil;
  //SC := 0;
  FSource := GetEmptySource;
  UserData := nil;
  State := FS_INTERPRET;
  SetLength(FData, 2048);
  //FHere := 0;
  //FMemoryDebug := TDebug.Create('memory.tmp');
  //FMemoryDebug.Console := False;

  FAlien := TAlien.Create;

  new(vGLOBAL);
  new(vLOCAL);
  new(vBUILTIN);
  vGLOBAL^.Item := nil;
  vLOCAL^.Item := nil;
  vBUILTIN^.Item := nil;
  vGLOBAL^.sFIND := -1;
  vGLOBAL^.sNOTFOUND := -1;
  vLOCAL^.sFIND := -1;
  vLOCAL^.sNOTFOUND := -1;
  vBUILTIN^.sFIND := -1;
  vBUILTIN^.sNOTFOUND := -1;
  UseVoc(vGLOBAL);
  ContextPush(vLOCAL);
  // it must have zero opcode
  AddCommand('exit', _exit);
  AddCommand('_FIND_', _FIND_);
  AddCommand('(', CompileComment, True); {) для m4}
  AddCommand('//', CompileLineComment, True);
  AddCommand('builtin', _builtin);
  AddCommand('builtedin', _builtedin);

  UseVoc(vBUILTIN);
  AddCommand('nop', _nop);
  nop := C[High(C)];

  ConvStr := nop;
  ConvName := nop;

  AddCommand('exit', _exit);
  AddCommand('_FIND_', _FIND_);
  AddCommand('(', CompileComment, True); {) для m4}
  AddCommand('//', CompileLineComment, True);
  AddCommand('builtin', _builtin);
  AddCommand('builtedin', _builtedin);
  AddCommand('_NOTFOUND_', _NOTFOUND_);

  SetLength(FTypes, 0);
  
    ExceptionsS := 1024;
    SetLength(Exceptions, ExceptionsS);
    ExceptionsB := @Exceptions[0];
    ExceptionsP := @Exceptions[0]
  ;
  AddType('', 0);
  AddType('void', 0);
  AddType('int', SizeOf(TInt));
  AddType('int8', SizeOf(TInt8));
  AddType('int16', SizeOf(TInt16));
  AddType('int32', SizeOf(TInt32));
  AddType('int64', SizeOf(TInt64));
  AddType('uint', SizeOf(TUInt));
  AddType('uint8', SizeOf(TUInt8));
  AddType('uint16', SizeOf(TUInt16));
  AddType('uint32', SizeOf(TUInt32));
  AddType('uint64', SizeOf(TUInt64));
  AddType('bool', SizeOf(TInt));
  AddType('ptr', SizeOf(Pointer));
  AddType('pchar', SizeOf(PChar));
  AddType('str', SizeOf(TStr));
  AddType('type', SizeOf(PType));
  AddType('float', SizeOf(PType));
  AddType('double', SizeOf(PType));
  AddType('extended', SizeOf(PType));

  AddCommand('exit', _exit);
  DCommandsEmbro.LoadCommands(@Self);
  DCommandsBool.LoadCommands(@Self);
{$IFNDEF FLAG_FPC}{$REGION 'type commands'}{$ENDIF}
  AddCommand('typeof', typeof, True);
  AddCommand('(typeof)', run_type);
  AddCommand('type-size', type_size);
  AddCommand('t_void', _void, True);
  AddCommand('t_int', _int, True);
  AddCommand('t_int8', _int8, True);
  AddCommand('t_int16', _int16, True);
  AddCommand('t_int32', _int32, True);
  AddCommand('t_int64', _int64, True);
  AddCommand('t_uint', _uint, True);
  AddCommand('t_uint8', _uint8, True);
  AddCommand('t_uint16', _uint16, True);
  AddCommand('t_uint32', _uint32, True);
  AddCommand('t_uint64', _uint64, True);
  AddCommand('t_bool', _bool, True);
  AddCommand('t_str', _str, True);
  AddCommand('t_pchar', _pchar, True);
  AddCommand('t_ptr', _ptr, True);
  AddCommand('t_type', _type, True);
  AddCommand('t_float', _float, True);
  AddCommand('t_single', _float, True);
  AddCommand('t_double', _double, True);
  AddCommand('t_extended', _extended, True);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  DCommandsAlien.LoadCommands(@Self);
  DCommandsStrings.LoadCommands(@Self);
  DCommandsConsole.LoadCommands(@Self);
  DCommandsF.LoadCommands(@Self);
  DCommandsBW.LoadCommands(@Self);
  DCommandsCompile.LoadCommands(@Self);
  DCommandsCreatewords.LoadCommands(@Self);
  DCommandsFiles.LoadCommands(@Self);
  DCommandsInt.LoadCommands(@Self);
  DCommandsMem.LoadCommands(@Self);
  DCommandsOS.LoadCommands(@Self);
  DCommandsPtr.LoadCommands(@Self);
  DCommandsR.LoadCommands(@Self);
  DCommandsSource.LoadCommands(@Self);
  DCommandsVM.LoadCommands(@Self);
  DCommandsVoc.LoadCommands(@Self);
  DCommandsExtInt.LoadCommands(@Self);
  DCommandsMisc.LoadCommands(@Self);
  DCommandsArithmetic.LoadCommands(@Self);
  DCommandsSignedArithmetic.LoadCommands(@Self);
  DCommandsNumberArithmetic.LoadCommands(@Self);
  DCommandsConvertNumber.LoadCommands(@Self);
  DCommandsControl.LoadCommands(@Self);
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      AddCommand('sys-exceptions-execute', _sys_exceptions_execute);
      AddCommand('sys-exceptions-pop', _sys_exceptions_pop);
      AddCommand('throw', _throw);
    ;
  UnuseVoc;
end;

destructor OForthMachine.Destroy; 
begin
  ;
  FAlien.Free;
end;

procedure OForthMachine.InterpretName(W: PChar);
var
  I: Integer;
  Command: PForthCommand;
  S_: TString;
  //Time: Integer;
begin
  //Writeln('INTERPRET ', W);
  (* for I := High(C) downto 0 do *)
  (*   if StrComp(C[I].Name, W) = 0 then begin *)
  (*     //Writeln('START ' + W); *)
  (*     C[I].Code(@Self, C[I]); *)
  (*     // Writeln('DONE ' + W); *)
  (*     Exit; *)
  (*   end; *)
  S_ := W;
  Command := FindCommand(S_);
  // Writeln('FOUND COMMAND: ', Integer(Command));
  if Command <> nil then begin
    // Writeln('INTERPRET COMMAND ', Command^.Name);
    Command.Code(@Self, Command);
    Exit;
  end;
  //Time := GetTimer;
  for I := High(Context) downto 0 do begin
    if Context[I] = nil then
      continue;
    if Context[I]^.sNOTFOUND = -1 then
      continue;
    WUS(S_);
    CallCommand(C[Context[I]^.sNOTFOUND]);
    if WOI <> 0 then
      Exit;
  end;
  LogError('unknown command "' + S_ + '"');
end;

function OForthMachine.CompileName(W: PChar): Boolean;
var
  I: Integer;
  Command: PForthCommand;
  S_: TString;
begin
  S_ := W;
  Command := FindCommand(S_, @I);
  if Command <> nil then begin
    if IsImmediate(C[I]) then
      C[I].Code(@Self, C[I])
    else
      EWO(I);
    Exit;
  end;
  for I := High(Context) downto 0 do begin
    if Context[I] = nil then
      continue;
    if Context[I]^.sNOTFOUND = -1 then
      continue;
    WUS(S_);
    CallCommand(C[Context[I]^.sNOTFOUND]);
    if WOI <> 0 then
      Exit;
  end;
  LogError('Unknown command: ' + W)
end;

procedure OForthMachine.Interpret(const Line: PChar);
begin
  //Writeln('Interpret ', Line);
  if Line = nil then
    Exit;
  (* Writeln('RB=', Cardinal(RB), *)
  (*         ' RP=', Cardinal(RP),  *)
  (*         ' SC=', SC,  *)
  (*         ' EC=', EC, *)
  (*         ' Line=', Line); *)
  RUI(State);
  RUI(Ord(FSession) * BOOL_TRUE);
  RUI(Ord(FRunning) * BOOL_TRUE);
  RUI(EC);
    RUP(Self.FSource);
    //RUP(Self.S);
    //RUI(SC);
  RUP(RB);
    FSource := CreateSourcePChar(Line);
    //Self.S := Line;
    //Self.SB := Line;
    //Self.SC := 0;
  State := FS_INTERPRET;
  FSession := True;
  FRunning := False;
  RUI(FCurrentLine);
  RUI(FCurrentPos);
  FCurrentLine := 1;
  FCurrentPos := 1;
  MainLoop;
  FCurrentPos := ROI;
  FCurrentLine := ROI;
  RB := ROP; 
    Self.FSource := ROP;
    //SC := ROI;
    //Self.S  := ROP;
  EC := ROI;
  FRunning := ROI <> BOOL_FALSE;
  FSession := ROI <> BOOL_FALSE;
  // Writeln('RB=', Cardinal(RB), ' SC=', SC, ' Line=', Integer(Line), ' EC=', EC);
  State := ROI;
end;

procedure OForthMachine.InterpretFile(const FileName: TString);
var
  F: TextFile;
  S_: TString;
  B: TString;
  T: TString;
begin
  S_ := FileName;
  Assign(F, S_);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then begin
    LogError('cannot open file "' + S_ + '"');
    Exit;
  end;
  B := '';
  while not EOF(F) do begin
    Readln(F, T);
    B := B + T + EOL;
  end;
  Close(F);
  WUS(FCurrentFileName);
  LUI(FCurrentLine);
  LUI(FCurrentPos);
  FCurrentFileName := FileName;
  FCurrentLine := 1;
  FCurrentPos := 1;
  Interpret(PChar(B));
  FCurrentPos := LOI;
  FCurrentLine := LOI;
  FCurrentFileName := WOS;
end;

procedure OForthMachine.CallCommand(Command: PForthCommand);
begin
  if Command = nil then
    Exit;
  // Writeln('Call command ', Command^.Name);
  RUI(Ord(FSession) * BOOL_TRUE);
  RUI(Ord(FRunning) * BOOL_TRUE);
  RUI(EC);
    RUP(Self.FSource);
    // RUP(S);
    // RUI(SC);
  RUP(RB);
  RUP(RP);
    FSource := GetEmptySource;
    // S := '';
    // SC := 0;
  RB := RP;
  FSession := True;
  FRunning := False;
  Command^.Code(@Self, Command);
  if FRunning then begin
    // Writeln('MAINLOOP');
    MainLoop;
  end;
  RP := ROP;
  RB := ROP; 
    FSource := ROP;
    //SC := ROI;
    //S := ROP;
  EC := ROI;
  FRunning := ROI <> BOOL_FALSE;
  FSession := ROI <> BOOL_FALSE;
  // Writeln('Command done');
end;

procedure OForthMachine.MainLoop;
begin
  while FSession do begin
    //Writeln('MainLoop');
    if FRunning then
      RunStep
    else
      case State of
        FS_INTERPRET: InterpretStep;
        FS_COMPILE:   CompileStep;
      else
        LogError('Illegal State');
        FSession := False;
      end;
    // Writeln('Main Loop State="', State, '" FRunning="', FRunning, '"');
  end;
end;

procedure OForthMachine.Step;
var
  Running: Boolean;
begin
  if not FSession then
    Exit;
  Writeln('Step');
  Running := FRunning;
  FRunning := False;
  case State of
    FS_INTERPRET: InterpretStep;
    FS_COMPILE:   CompileStep;
  else
    LogError('Illegal State');
    FSession := False;
  end;
  FRunning := Running;
end;

procedure OForthMachine.InterpretStep;
begin
  // Writeln('INTERPRET STEP');
  SSS;
  if SE then begin
    FSession := False;
  end else
    InterpretName(PChar(SNN));
end;

procedure OForthMachine.CompileStep;
begin
  // Writeln('COMPILE STEP');
  SSS;
  if SE then
    FSession := False
  else
    CompileName(PChar(SNN));
end;

procedure OForthMachine.RunStep;
begin
  RunMnemonic(ERO);
end;

procedure OForthMachine.CompileError(const Message: TString);
begin
  Error('Compile(' + InternalFileName(FCurrentFileName) + ', ' +
                     IntToStr(FCurrentLine) + ', ' +
                     IntToStr(FCurrentPos) + '): ' + Message);
  FCompilation := False;
end;

procedure OForthMachine.CompileWarring(const Message: TString);
begin
  Warrning(' Compilation: "' + Message + '"');
end;

procedure OForthMachine.LogError(const Message: TString);
begin
  if State = FS_COMPILE then
    CompileError(Message)
  else
    RunError(Message);
end;

function OForthMachine.NextChar: TChar;
begin
  Result := SNC;
end;

function OForthMachine.NextName: TString;
begin
  Result := SNN;
end;

function OForthMachine.NextName(S: PChar; var I: Integer): TString;
var
  Ch: TChar;
begin
  Result := '';
  repeat
    Ch := S[I];
    if Ch <> #0 then
      Inc(I);
  until (not (Ch in [#0..#32])) or (Ch = #0);
  repeat
    Result := Result + Ch;
    if S[I] = #0 then
      Exit;
    Ch := S[I];
    if Ch <> #0 then
      Inc(I);
  until (Ch in [#0..#32]) or (Ch = #0);
  if not (Ch in [#0..#32]) then
    Result := Result + Ch;
end;

function OForthMachine.NextNamePassive: TString;
begin
  Result := FSource^.NextNamePassive;
end;

function OForthMachine.EOS: Boolean; // end of source
begin
  Result := SE;
end;

procedure OForthMachine.WriteEmbro(P: Pointer; Size: Integer);
begin
  SetLength(FEmbro, Length(FEmbro) + Size);
  Move(P^, FEmbro[Length(FEmbro) - Size], Size);
end;

procedure OForthMachine.WriteEmbroInt(I: Integer);
begin
  WriteEmbro(@I, SizeOf(I));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' ' + IntToStr(I) + ' ';
end;

procedure OForthMachine.WriteEmbroUInt(U: Cardinal);
begin
  WriteEmbro(@U, SizeOf(U));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' u' + IntToStr(U) + ' ';
end;

procedure OForthMachine.WriteEmbroChar(C: Char);
begin
  WriteEmbro(@C, SizeOf(C));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + '''' + IntToHex(Ord(C), 2);
end;

procedure OForthMachine.WriteEmbroByte(B: Byte);
begin
  WriteEmbro(@B, SizeOf(B));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + 'b' + IntToHex(Ord(B), 2);
end;

procedure OForthMachine.PopEmbro(P: Pointer; Size: Integer);
begin
  Move(FEmbro[Length(FEmbro) - Size], P^, Size);
  SetLength(FEmbro, Length(FEmbro) - Size);
end;

procedure OForthMachine.WriteMnemonic(M: Cardinal);
begin
  WriteEmbro(@M, SizeOf(M));
  SetLength(FEmbroDump, Length(FEmbroDump) + 1);
  FEmbroDump[High(FEmbroDump)] := C[M].Name + ' ';
end;

procedure OForthMachine.WriteMnemonicByName(const Name: TString);
var
  I: Integer;
begin
  //Writeln('Write mnemonic by name ' + Name);
  for I := High(C) downto 0 do
    if TString(C[I].Name) = Name then begin
      WriteMnemonic(I);
      Exit;
    end;
  (* I := StrToIntDef(Name, -3535); *)
  (* if I = -3535 then *)
  (*   CompileError('Unknown name "' + Name + '"') *)
  (* else begin *)
  (*   WriteMnemonicByName('int-push'); *)
  (*   WriteEmbroInt(I); *)
  (* end; *)
  if ConvertStrToInt(Name, I) <> 0 then
    LogError('Unknown command: ' + Name)
  else begin
    BuiltinEWO('(literal)');
    EWI(I);
  end;
end;

function OForthMachine.GetOpcodeByName(const Name: TString): TMnemonic;
var
  I: Integer;
begin
  for I := High(C) downto 0 do
    if TString(C[I].Name) = Name then begin
      //Writeln(I);
      Result := I;
      Exit;
    end;
  Result := 0;
end;

function OForthMachine.GetCommandByOpcode(Opcode: Integer): PForthCommand;
begin
  //Writeln(Opcode);
  Result := C[Opcode];
end;

procedure OForthMachine.CancelMnemonic;
begin
  SetLength(FEmbro, Length(FEmbro) - SizeOf(Cardinal));
end;

function OForthMachine.ReserveName(const Name: TString): PForthCommand;
begin
  FLastMnemonic := -1;
  if FLastMnemonic = -1 then begin
    SetLength(C, Length(C) + 1);
    New(C[High(C)]);
    C[High(C)].Name := StrAlloc(Length(Name)+1);
    StrCopy(C[High(C)].Name, PChar(Name));
  end;
  SetImmediate(C[High(C)], False);
  C[High(C)].Code := call;
  FLastMnemonic := High(C);
  Result := C[High(C)];
  if Name <> '' then begin
    OnUpdateCommand(High(C));
    FLastMnemonic := High(C);
  end;
end;

procedure OForthMachine.ReadEmbro(P: Pointer; Size: Integer);
begin
  Move(FEmbro[EC], P^, Size);
  Inc(EC, Size);
end;

function OForthMachine.ReadMnemonic: TMnemonic;
begin
  ReadEmbro(@Result, SizeOf(TMnemonic));
end;

function OForthMachine.GetEmbroDumpLines: Integer;
begin
  Result := Length(FEmbroDump);
end;

function OForthMachine.GetEmbroDumpLine;
begin
  Result := FEmbroDump[Index];
end;

procedure _FIND_(Machine: TForthMachine; Command: PForthCommand);
var
  B: TString;
  I: Integer;
  Item: PVocItem;
begin
  with Machine^ do begin
    B := WOS;
    with Machine^ do begin
      for I := High(Context) downto 0 do begin
        if Context[I] = nil then
          continue;
        Item := Context[I].Item;
        while Item <> nil do begin
          if TString(C[Item^.Index]^.Name) = B then begin
            //Writeln('FOUND ', Item^.Index, ' ', C[Item^.Index]^.Name);
            WUI(Item^.Index);
            WUI(0);
            Exit;
          end;
          Item := Item^.Next;
        end;
      end;
      // Writeln('_FIND_(', B, ')');
      //for I := High(C) downto 0 do
      //  if TString(C[I].Name) = B then begin
      //    WUI(I);
      //    WUI(0);
      //    // Writeln('_FIND_(', B, ') done');
      //    Exit;
      //  end;
      WUI(-1);
      // Writeln('_FIND_(', B, ') failed');
    end;
  end;
end;

procedure _NOTFOUND_(Machine: TForthMachine; Command: PForthCommand);
var
  B: TString;
  I: Integer;
begin
  with Machine^ do begin
    B := Machine.WOS;
    // Writeln('_NOTFOUND_(', B, ')');
    if ConvertStrToInt(B, I) = 0 then begin
      if Machine^.State = FS_INTERPRET then
        Machine^.WUI(I)
      else begin
        Machine^.BuiltinEWO('(literal)');
        MAchine^.EWI(I);
      end;
      WUI(BOOL_TRUE);
      Exit;
    end;
    WUI(BOOL_FALSE);
  end;
end;


function OForthMachine.FindCommand(Voc: PVoc; const Name: TString; Index: PInteger = nil): PForthCommand;
begin
  if Voc <> nil then begin
    if Voc.sFIND <> -1 then begin
      WUS(Name);
      CallCommand(C[Voc.sFIND]);
      if WOI = 0 then begin
        if Index <> nil then begin
          Index^ := WOI;
          Result := C[Index^];
        end else
          Result := C[WOI];
      end else begin
        Result := nil;
      end;
    end else
      Result := nil;
  end else
    Result := nil;
end;

function OForthMachine.FindCommand(const Name: TString; Index: PInteger = nil): PForthCommand;
var
  I: Integer;
begin
  I := High(Context);
  Result := nil;
  for I := High(Context) downto 0 do begin
    Result := FindCommand(Context[I], Name, Index);
    if Result <> nil then
      Exit;
  end;
end;

function OForthMachine.ExtendedFindCommand(const Name: TString; Index: PInteger = nil): PForthCommand;
begin
  Result := FindCommand(Name, Index);
  if Result = nil then
    Result := FindCommand(vBUILTIN, Name, Index);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

// ( Вся соль :)
 
    
      procedure OForthMachine.EW_; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_int; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_int; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_int8; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_int8; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_int16; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_int16; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_int32; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_int32; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_int64; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_int64; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_uint; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_uint; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_uint8; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_uint8; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_uint16; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_uint16; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_uint32; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_uint32; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_uint64; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_uint64; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_float; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_float; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_double; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_double; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure OForthMachine.EW_extended; begin EWV(@V, SizeOf(V)) end;
      function OForthMachine.ER_extended; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
       function OForthMachine.ConvertStrTo(const B: TString; var X: TInt): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrToint(const B: TString; var X: TInt): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrToint8(const B: TString; var X: TInt8): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrToint16(const B: TString; var X: TInt16): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrToint32(const B: TString; var X: TInt32): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrToint64(const B: TString; var X: TInt64): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrTouint(const B: TString; var X: TUInt): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrTouint8(const B: TString; var X: TUInt8): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrTouint16(const B: TString; var X: TUInt16): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrTouint32(const B: TString; var X: TUInt32): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    
       function OForthMachine.ConvertStrTouint64(const B: TString; var X: TUInt64): Integer;
       var
         D: Byte;
             function GetDigit(C: TChar; var D: Byte): Boolean;
             begin
               Result := True;
               case C of
                 '0'..'9': D := Ord(C) - Ord('0');
                 'a'..'f': D := Ord(C) - Ord('a') + 10;
                 'A'..'F': D := Ord(C) - Ord('F') + 10;
               else
                 Result := False;
               end;
             end;
       begin
         X := 0;
         Result := Ord(Length(B) <> 0);
         if Result = 0 then
           Exit; 
         if B[1] = 'h' then begin
           Inc(Result);
           while Result <= Length(B) do begin
             if not GetDigit(B[Result], D) then
               Exit;
             X := (X shl 4) or D;
             Inc(Result);
           end;
           Result := 0;
         end else
           Val(B, X, Result);
       end;
    
   
    function OForthMachine.ROP: Pointer; begin Dec(RP, SizeOf(Result)); Result := Pointer(RP^); end;
     
     procedure OForthMachine.RUI(const V: TInt); begin TInt(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUI8(const V: TInt8); begin TInt8(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUI16(const V: TInt16); begin TInt16(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUI32(const V: TInt32); begin TInt32(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUI64(const V: TInt64); begin TInt64(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUU(const V: TUInt); begin TUInt(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUU8(const V: TUInt8); begin TUInt8(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUU16(const V: TUInt16); begin TUInt16(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUU32(const V: TUInt32); begin TUInt32(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUU64(const V: TUInt64); begin TUInt64(RP^) := V; Inc(RP, SizeOf(V)) end;
   
     procedure OForthMachine.RUP(const V: Pointer); begin Pointer(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    function OForthMachine.ROI: TInt; begin Dec(RP, SizeOf(Result)); Result := TInt(RP^); end;
     
    function OForthMachine.ROI8: TInt8; begin Dec(RP, SizeOf(Result)); Result := TInt8(RP^); end;
     
    function OForthMachine.ROI16: TInt16; begin Dec(RP, SizeOf(Result)); Result := TInt16(RP^); end;
     
    function OForthMachine.ROI32: TInt32; begin Dec(RP, SizeOf(Result)); Result := TInt32(RP^); end;
     
    function OForthMachine.ROI64: TInt64; begin Dec(RP, SizeOf(Result)); Result := TInt64(RP^); end;
     
    function OForthMachine.ROU: TUInt; begin Dec(RP, SizeOf(Result)); Result := TUInt(RP^); end;
     
    function OForthMachine.ROU8: TUInt8; begin Dec(RP, SizeOf(Result)); Result := TUInt8(RP^); end;
     
    function OForthMachine.ROU16: TUInt16; begin Dec(RP, SizeOf(Result)); Result := TUInt16(RP^); end;
     
    function OForthMachine.ROU32: TUInt32; begin Dec(RP, SizeOf(Result)); Result := TUInt32(RP^); end;
     
    function OForthMachine.ROU64: TUInt64; begin Dec(RP, SizeOf(Result)); Result := TUInt64(RP^); end;
     
     procedure OForthMachine.WUI(const V: TInt); begin TInt(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUP(const V: Pointer); begin Pointer(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    function OForthMachine.WOI: TInt; begin Dec(WP, SizeOf(Result)); Result := TInt(WP^); end;
     
    function OForthMachine.WOP: Pointer; begin Dec(WP, SizeOf(Result)); Result := Pointer(WP^); end;
     
     procedure OForthMachine.WUI8(const V: TInt8); begin TInt8(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUI16(const V: TInt16); begin TInt16(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUI32(const V: TInt32); begin TInt32(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUI64(const V: TInt64); begin TInt64(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUU(const V: TUInt); begin TUInt(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUU8(const V: TUInt8); begin TUInt8(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUU16(const V: TUInt16); begin TUInt16(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUU32(const V: TUInt32); begin TUInt32(WP^) := V; Inc(WP, SizeOf(V)) end;
   
     procedure OForthMachine.WUU64(const V: TUInt64); begin TUInt64(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    function OForthMachine.WOI8: TInt8; begin Dec(WP, SizeOf(Result)); Result := TInt8(WP^); end;
     
    function OForthMachine.WOI16: TInt16; begin Dec(WP, SizeOf(Result)); Result := TInt16(WP^); end;
     
    function OForthMachine.WOI32: TInt32; begin Dec(WP, SizeOf(Result)); Result := TInt32(WP^); end;
     
    function OForthMachine.WOI64: TInt64; begin Dec(WP, SizeOf(Result)); Result := TInt64(WP^); end;
     
    function OForthMachine.WOU: TUInt; begin Dec(WP, SizeOf(Result)); Result := TUInt(WP^); end;
     
    function OForthMachine.WOU8: TUInt8; begin Dec(WP, SizeOf(Result)); Result := TUInt8(WP^); end;
     
    function OForthMachine.WOU16: TUInt16; begin Dec(WP, SizeOf(Result)); Result := TUInt16(WP^); end;
     
    function OForthMachine.WOU32: TUInt32; begin Dec(WP, SizeOf(Result)); Result := TUInt32(WP^); end;
     
    function OForthMachine.WOU64: TUInt64; begin Dec(WP, SizeOf(Result)); Result := TUInt64(WP^); end;
     
     procedure OForthMachine.LUI(const V: TInt); begin TInt(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUP(const V: Pointer); begin Pointer(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    function OForthMachine.LOI: TInt; begin Dec(LP, SizeOf(Result)); Result := TInt(LP^); end;
     
    function OForthMachine.LOP: Pointer; begin Dec(LP, SizeOf(Result)); Result := Pointer(LP^); end;
     
     procedure OForthMachine.LUI8(const V: TInt8); begin TInt8(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUI16(const V: TInt16); begin TInt16(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUI32(const V: TInt32); begin TInt32(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUI64(const V: TInt64); begin TInt64(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUU(const V: TUInt); begin TUInt(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUU8(const V: TUInt8); begin TUInt8(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUU16(const V: TUInt16); begin TUInt16(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUU32(const V: TUInt32); begin TUInt32(LP^) := V; Inc(LP, SizeOf(V)) end;
   
     procedure OForthMachine.LUU64(const V: TUInt64); begin TUInt64(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    function OForthMachine.LOI8: TInt8; begin Dec(LP, SizeOf(Result)); Result := TInt8(LP^); end;
     
    function OForthMachine.LOI16: TInt16; begin Dec(LP, SizeOf(Result)); Result := TInt16(LP^); end;
     
    function OForthMachine.LOI32: TInt32; begin Dec(LP, SizeOf(Result)); Result := TInt32(LP^); end;
     
    function OForthMachine.LOI64: TInt64; begin Dec(LP, SizeOf(Result)); Result := TInt64(LP^); end;
     
    function OForthMachine.LOU: TUInt; begin Dec(LP, SizeOf(Result)); Result := TUInt(LP^); end;
     
    function OForthMachine.LOU8: TUInt8; begin Dec(LP, SizeOf(Result)); Result := TUInt8(LP^); end;
     
    function OForthMachine.LOU16: TUInt16; begin Dec(LP, SizeOf(Result)); Result := TUInt16(LP^); end;
     
    function OForthMachine.LOU32: TUInt32; begin Dec(LP, SizeOf(Result)); Result := TUInt32(LP^); end;
     
    function OForthMachine.LOU64: TUInt64; begin Dec(LP, SizeOf(Result)); Result := TUInt64(LP^); end;
     
    
     procedure _sys_exceptions_execute (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Integer(ExceptionsP^) := 0;
       Inc(ExceptionsP, SizeOf(Integer));
       Integer(ExceptionsP^) := EC;
       Inc(ExceptionsP, SizeOf(Integer));
       Pointer(ExceptionsP^) := WP;
       Inc(ExceptionsP, SizeOf(Pointer));
       Pointer(ExceptionsP^) := RP;
       Inc(ExceptionsP, SizeOf(Pointer));
       execute(Machine, Command);
      end; end;
     procedure _sys_exceptions_pop (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Dec(ExceptionsP, 2*SizeOf(Integer) + 2*SizeOf(Pointer));
       WUI(Integer(ExceptionsP^));
      end; end;
     procedure _throw (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Integer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)-2*SizeOf(Integer)])^) := WOI;
       EC := Integer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)-SizeOf(Integer)])^);
       RP := Pointer((@PArrayOfByte(ExceptionsP)^[-1*SizeOf(Pointer)])^);
       WP := Pointer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)])^);
      end; end;
    
  

end.

{
var
  testptr,param:pointer;
  mm:TMemoryStream;
  i,paramsize:integer;
begin
  testptr:=@test;
  mm:=TMemoryStream.Create;
// в обратном порядке кидаю параметры в память
  i:=20;
  mm.Write(i,sizeof(i));
  i:=10;
  mm.Write(i,sizeof(i));
// здесь надо кидать по 4 байта - или указатель, или значение.
  mm.Position:=0;
  paramsize:=mm.Size;
  param:=mm.Memory;
  asm
    mov eax,0
    mov ecx,0
    lab:
    mov ebx,[Param+ecx]
    // получаю значение под указателем
    // если этого не сделать, то положим указатель на память вместо значения.
    mov ebx,[ebx]
    // в стек
    push ebx
    add ecx,4
    cmp ecx,ParamSize
    jne lab
    // сам вызов
    call [testptr]
  end;
    mov eax, work
    mov ecx, param
    cycle:
      mov ebx, BYTE [ecx] // получаем значение текущего байта
      jz endcycle // если 0, то выходим из цикла
      push [eax] // переносим очередной параметр на стек
      sub eax, ebx // сдвигаем указатели
      inc ecx
      jmp cycle // повторяем операцию
    endcycle:
      inc ecx
      call [ecx] // вызываем функцию
      add ecx, 4
      pop [eax] // переносим результат на рабочий стек форта
      add eax, BYTE [ecx]
      mov work, eax // сменяем положение стека
end;




Чистить стек можно с помощью любого регистра pop-ами, а можно сделать проще - просто сохранить esp где ни будь и восстановить. Вобще то любую переменную больше 4 байт обычно передают по адресу, так как она уже является массивом и считывать ее придется уже побайтово, тоесть инкрементируя адрес. Но я правда не уверен насчет языков высокого уровня, что там из себя представляют переменные. Я бы делал для надежности так :
int a;
LEA eax,a
mov ebx,[eax]
ну это конечно утрировано, но зато надежно.

mov ebx,[Param+ecx]
mov ebx,[ebx]

Вот в эту шаманскую песенку я не вкурил. [Param+ecx] это уже ваша переменная со смещением, двойное слово. Или там в param список адресов? 





В param - адрес на память, где находятся параметры.
param:=mm.Memory;

сначала ecx=0, с каждым проходом цикла он увеличивается на 4
add ecx,4

и так пока ecx не станет равным ParamSize - общей сумме размеров параметров.

а что такое
LEA eax,a
mov ebx,[eax]
? для типа extended не работает - он передается как 2 dword и один word.
Например, для (-5.5):
push $0000c001
push $b0000000
push $00
из CPU-debug. 

}
)))))))))))))))))))))))))))))))))))))))))))))))



unit DForthMachine;

interface

{$DEFINE FLAG_X86}
{$DEFINE FLAG_IA32}






uses
  {$I units.inc},Math,strings,DAlien,DVocabulary,DForthStack;

const
  DFORTHMACHINE_VERSION = 11;



















{$IFNDEF FLAG_FPC}{$REGION 'typed_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'data_commands'}{$ENDIF}


{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'signed_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'number_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'convert_number_arithmetic_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'sysar_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'system_commands'}{$ENDIF}

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'stack utils'}{$ENDIF}


{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

const
  BOOL_FALSE: Integer   = 0;
  BOOL_TRUE: Integer    = -1;

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

  // Machine размещается в EAX
  // Command размещается в EDX
  TCode = procedure (Machine: TForthMachine; Command: PForthCommand); register;

  TForthCommand = record 
          Code: TCode;
          Data: Pointer;
          Flags: Byte;
          Name: PAnsiChar; 
          Param: Pointer;
        end;

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
  S: PChar; // Source
  SC: Integer; // Source Counter
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
  FSource: PChar;
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
  procedure RunError(const S: TString);
  procedure RunWarring(const S: TString);
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
  procedure CompileError(const S: TString);
  procedure CompileWarring(const S: TString);
  procedure LogError(const S: TString);
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
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'all commands'}{$ENDIF}
  
    procedure drop_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure over_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_ptr (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_ptr (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int8 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int16 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int32 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_int64 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_int64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint8 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint16 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint32 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure over_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_uint64 (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_uint64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure over_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_embro (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_embro (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_float (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_float (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_float (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_float (Machine: TForthMachine; Command: PForthCommand);
    procedure over_float (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_float (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_float (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_float (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_float (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_float (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_float (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_float (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_float (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_float (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_float (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_double (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_double (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_double (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_double (Machine: TForthMachine; Command: PForthCommand);
    procedure over_double (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_double (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_double (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_double (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_double (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_double (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_double (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_double (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_double (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_double (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_double (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
    procedure drop_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure over_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_extended (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure _plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _minus (Machine: TForthMachine; Command: PForthCommand);
  procedure _star (Machine: TForthMachine; Command: PForthCommand);
  procedure _equel (Machine: TForthMachine; Command: PForthCommand);
  procedure _nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure _lt (Machine: TForthMachine; Command: PForthCommand);
  procedure _gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _lte (Machine: TForthMachine; Command: PForthCommand);
  procedure _gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure _0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure _ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure _0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure _if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure _max (Machine: TForthMachine; Command: PForthCommand);
  procedure _min (Machine: TForthMachine; Command: PForthCommand);
  procedure _minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure _dot (Machine: TForthMachine; Command: PForthCommand);
  procedure _dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int8_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int16_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int32_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_star (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure int64_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_max (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_min (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint8_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint16_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint32_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_star (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure uint64_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure float_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure float_star (Machine: TForthMachine; Command: PForthCommand);
  procedure float_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure float_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure float_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure float_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure float_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure float_max (Machine: TForthMachine; Command: PForthCommand);
  procedure float_min (Machine: TForthMachine; Command: PForthCommand);
  procedure float_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure float_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure float_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure float_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure float_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure float_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure double_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure double_star (Machine: TForthMachine; Command: PForthCommand);
  procedure double_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure double_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure double_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure double_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure double_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure double_max (Machine: TForthMachine; Command: PForthCommand);
  procedure double_min (Machine: TForthMachine; Command: PForthCommand);
  procedure double_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure double_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure double_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure double_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure double_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure double_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_star (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure extended_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_if_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_max (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_min (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure extended_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure _abs (Machine: TForthMachine; Command: PForthCommand);
  procedure _neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure float_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure double_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure _push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure _div (Machine: TForthMachine; Command: PForthCommand);
  procedure _mod (Machine: TForthMachine; Command: PForthCommand);
  procedure _divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure _shl (Machine: TForthMachine; Command: PForthCommand);
  procedure _shr (Machine: TForthMachine; Command: PForthCommand);
  procedure _power (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_power (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_shl (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_shr (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_power (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_int64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int8_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int16_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int32_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int64_convert_to_int (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint8 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint16 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint32 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint_convert_to_uint64 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint8_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint16_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint32_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure uint64_convert_to_uint (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure float_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_float (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure int_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
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
  procedure _BtoW(Machine: TForthMachine; Command: PForthCommand);
  procedure _WtoB(Machine: TForthMachine; Command: PForthCommand);
  procedure Evaluate(Machine: TForthMachine; Command: PForthCommand);
  procedure EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
  procedure _FIND_(Machine: TForthMachine; Command: PForthCommand);
  procedure _NOTFOUND_(Machine: TForthMachine; Command: PForthCommand);
  procedure _align(Machine: TForthMachine; Command: PForthCommand);
  procedure _palign(Machine: TForthMachine; Command: PForthCommand);
  procedure _poststr (Machine: TForthMachine; Command: PForthCommand);
  procedure _postname (Machine: TForthMachine; Command: PForthCommand);
  procedure _raw_2_unicode (Machine: TForthMachine; Command: PForthCommand);
  procedure _utf8_2_unicode (Machine: TForthMachine; Command: PForthCommand);
  procedure _utf8_2_raw (Machine: TForthMachine; Command: PForthCommand);
  procedure _unicode_2_utf8 (Machine: TForthMachine; Command: PForthCommand);
  procedure _unicode_2_raw (Machine: TForthMachine; Command: PForthCommand);
  procedure _randomize (Machine: TForthMachine; Command: PForthCommand);
  procedure _random (Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TControlCommands'}{$ENDIF}
procedure branch(Machine: TForthMachine; Command: PForthCommand);
procedure _ask_branch(Machine: TForthMachine; Command: PForthCommand);
procedure _gt_mark(Machine: TForthMachine; Command: PForthCommand);
procedure _gt_resolve(Machine: TForthMachine; Command: PForthCommand);
procedure _lt_mark(Machine: TForthMachine; Command: PForthCommand);
procedure _lt_resolve(Machine: TForthMachine; Command: PForthCommand);
procedure _exit(Machine: TForthMachine; Command: PForthCommand);
procedure recurse(Machine: TForthMachine; Command: PForthCommand);
procedure call(Machine: TForthMachine; Command: PForthCommand);
procedure compile_def(Machine: TForthMachine; Command: PForthCommand);
procedure compile_noname(Machine: TForthMachine; Command: PForthCommand);
procedure compile_skip_to_end(Machine: TForthMachine; Command: PForthCommand);
procedure compile_enddef(Machine: TForthMachine; Command: PForthCommand);
procedure compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
procedure compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand); 
procedure scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
procedure immediate(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
procedure compile(Machine: TForthMachine; Command: PForthCommand);
procedure q_compile_q(Machine: TForthMachine; Command: PForthCommand);
procedure _call(Machine: TForthMachine; Command: PForthCommand);
procedure postpone(Machine: TForthMachine; Command: PForthCommand);
procedure _compiled(Machine: TForthMachine; Command: PForthCommand);
procedure _postponed(Machine: TForthMachine; Command: PForthCommand);
procedure _called(Machine: TForthMachine; Command: PForthCommand);
procedure _execute(Machine: TForthMachine; Command: PForthCommand);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}
  procedure _nil(Machine: TForthMachine; Command: PForthCommand);
  procedure ptr_comma(Machine: TForthMachine; Command: PForthCommand);

  procedure _create(Machine: TForthMachine; Command: PForthCommand);
  procedure _created(Machine: TForthMachine; Command: PForthCommand);
  procedure putdataptr(Machine: TForthMachine; Command: PForthCommand);
  procedure here(Machine: TForthMachine; Command: PForthCommand);
  procedure allot(Machine: TForthMachine; Command: PForthCommand);

  procedure compile_to(Machine: TForthMachine; const Name: TString; Size: Integer);
  procedure interpete_to(Machine: TForthMachine; const Name: TString; Size: Integer);

  procedure to_int(Machine: TForthMachine; Command: PForthCommand);
  procedure to_int8(Machine: TForthMachine; Command: PForthCommand);
  procedure to_int16(Machine: TForthMachine; Command: PForthCommand);
  procedure to_int32(Machine: TForthMachine; Command: PForthCommand);
  procedure to_int64(Machine: TForthMachine; Command: PForthCommand);
  procedure to_uint(Machine: TForthMachine; Command: PForthCommand);
  procedure to_uint8(Machine: TForthMachine; Command: PForthCommand);
  procedure to_uint16(Machine: TForthMachine; Command: PForthCommand);
  procedure to_uint32(Machine: TForthMachine; Command: PForthCommand);
  procedure to_uint64(Machine: TForthMachine; Command: PForthCommand);
  procedure to_ptr(Machine: TForthMachine; Command: PForthCommand);
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

function IsImmediate(Command: PForthCommand): Boolean;
procedure SetImmediate(Command: PForthCommand; I: Boolean);
function IsBuiltin(Command: PForthCommand): Boolean;
procedure SetBuiltin(Command: PForthCommand; I: Boolean);
function CopyStrToPChar(const B: TString): PChar;

implementation

uses
  DCommandsBool,DCommandsMisc,DCommandsConsole,DCommandsStrings,DCommandsAlien,DCommandsF,DCommandsBW,DCommandsCompile,DCommandsCreatewords,DCommandsFiles,DCommandsInt,DCommandsMem,DCommandsOS,DCommandsPtr,DCommandsR,DCommandsSource,DCommandsVM,DCommandsVoc,DCommandsExtInt,DCommandsEmbro;

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
procedure branch;
begin
  with Machine^ do begin
    Machine.EC := Machine.ERU;
  end;
end;

procedure _ask_branch;
var
  B: TInt;
  Temp: Cardinal;
begin
  with Machine^ do begin
    B := Machine.WOI;
    Temp := Machine.ERU;
    if B = BOOL_FALSE then
      Machine.EC := Temp;
  end;
end;

procedure _gt_mark;
var
  Temp: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.EL;
    Machine.WUU(Temp);
    Machine.EWU(Temp);
  end;
end;

procedure _gt_resolve;
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.WOU;
    PC := Machine.EL;
    Move(PC, Pointer(@Machine.E[Temp])^, SizeOf(PC));
  end;
end;

procedure _lt_mark;
var
  Temp: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.EL;
    Machine.WUU(Temp);
  end;
end;

procedure _lt_resolve;
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  with Machine^ do begin
    Temp := Machine.WOU;
    Machine.EWU(Temp);
  end;
end;

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

procedure recurse(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.EWO(Machine.FLastMnemonic);
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

procedure compile_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
  PName: PChar;
begin
  with Machine^ do begin
    Name := Machine.NextName;
    PName := CopyStrToPChar(Name);
    NewCommand := Machine.ReserveName('');
    NewCommand^.Code := call;
    SetImmediate(NewCommand, False);
    Integer(NewCommand^.Data) := Machine.EL;
    Machine.State := FS_COMPILE;
    Machine.LUI(Machine.FLastMnemonic);
    Machine.LUP(PName);
    Machine.LUI(101);
  end;
end;

procedure compile_noname(Machine: TForthMachine; Command: PForthCommand);
var
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    NewCommand := Machine.ReserveName('');
    NewCommand^.Code := call;
    SetImmediate(NewCommand, False);
    Integer(NewCommand^.Data) := Machine.EL;
    Machine.State := FS_COMPILE;
    Machine.WUP(NewCommand);
    Machine.LUI(Machine.FLastMnemonic);
    Machine.LUP(Pointer(PChar('')));
    Machine.LUI(101);
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

procedure compile_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  B: TString;
  Index: TInt;
  P: PChar;
  ID: Integer;
begin
  with Machine^ do begin
    //B := str_pop(Machine);
    //Machine.C[Machine.WOI]^.Name := PChar(TString(PChar(@TStrRec(B^).Sym[0])));
    //DelRef(B);
    ID := Machine.LOI;
    if ID = 201 then begin
      _gt_resolve(Machine, nil);
    end;
    P := Machine.LOP;
    Index := Machine.LOI;
    Machine.C[Index]^.Name := P;
    Machine.BuiltinEWO('exit');
    Machine.State := FS_INTERPRET;
    Machine.C[Index]^.Flags := Machine.C[Index]^.Flags and not 1;
    Machine.OnUpdateCommand(Index);
    Machine.FLastMnemonic := Index;
    //Writeln('LAST COMMAND ', High(Machine.C), ' ' + Machine.C[High(Machine.C)].Name);
  end;
end;

procedure compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  C: PForthCommand;
begin
 // with Machine^ do begin
    Machine.State := FS_COMPILE;
    Name := Machine.NextName;
    C := Machine.FindCommand(Name);
    if C = nil then begin
      Machine.LogError('Command not found: ' + Name);
      Exit;
    end;
    Machine.WUU(Cardinal((@Machine.E[Cardinal(C^.Param)])^));
    Cardinal((@Machine.E[Cardinal(C^.Param)])^) := Machine.EL;
    Machine.WUP(C);
 // end;
end;

procedure compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  P: Cardinal;
begin
 // with Machine^ do begin
    C := Machine.WOP;
    P := Cardinal(C^.Param);
    Machine.BuiltinEWO('branch');
    Cardinal(C^.Param) := Machine.EL;
    Machine.EWU(Machine.WOU);
    Machine.State := FS_INTERPRET;
 // end;
end;

procedure scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
begin
  with Machine^ do begin
    Machine.BuiltinEWO('branch');
    Cardinal(Machine.C[Machine.FLastMnemonic]^.Param) := Machine.EL;
    Machine.EWU(Machine.EL + SizeOf(TUInt));
  end;
end;

procedure immediate(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    SetImmediate(Machine.C[Machine.FLastMnemonic], True);
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
procedure compile(Machine: TForthMachine; Command: PForthCommand);
var
  U: TUInt;
begin
  with Machine^ do begin
    //if Machine.State = FS_COMPILE then begin
      Machine.BuiltinEWO('(compile)');
      Machine.EWO(Machine.NextName);
    //end else begin
    //  Machine.EWO(Machine.C[Machine.ERU].Name);
    //end;
  end;
end;

procedure q_compile_q(Machine: TForthMachine; Command: PForthCommand);
var
  O: TOpcode;
begin
  with Machine^ do begin
    O := Machine.ERU;
    Machine.EWO(Machine.C[O].Name);
  end;
end;

procedure _call(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.EWO(Machine.NextName);
end;

procedure postpone(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  Opcode: TOpcode;
begin
  C := Machine.FindCommand(Machine.NextName, @Opcode);
  // Writeln(C^.Name);
  if not IsImmediate(C) then
    Machine.BuiltinEWO('(compile)');
  Machine.EWO(Opcode)
end;

procedure _compiled(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    //if Machine.State = FS_COMPILE then begin
      Machine.BuiltinEWO('(compile)');
      Machine.EWO(Machine.WOS);
    //end else begin
    //  Machine.EWO(Machine.C[Machine.ERU].Name);
    //end;
  end;
end;

procedure _postponed(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  Opcode: TOpcode;
begin
  C := Machine.FindCommand(Machine.WOS, @Opcode);
  // Writeln(C^.Name);
  if not IsImmediate(C) then
    Machine.BuiltinEWO('(compile)');
  Machine.EWO(Opcode)
end;

procedure _called(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.EWO(Machine.WOS);
end;

procedure _execute(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    Machine.InterpretName(PChar(Machine.NextName));
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}
procedure _create(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    Name := Machine.NextName;
    NewCommand := Machine.ReserveName(Name);
    NewCommand^.Code := putdataptr;
    NewCommand^.Data := Machine.Here;
    Machine.OnUpdateCommand(NewCommand);
  end;
end;

procedure _created(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  with Machine^ do begin
    Name := Machine.WOS;
    NewCommand := Machine.ReserveName(Name);
    NewCommand^.Code := putdataptr;
    NewCommand^.Data := Machine.Here;
    Machine.OnUpdateCommand(NewCommand);
  end;
end;

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

procedure to_int(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TInt))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TInt));
  end;
end;

procedure to_int8(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TInt8))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TInt8));
  end;
end;

procedure to_int16(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TInt16))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TInt16));
  end;
end;

procedure to_int32(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TInt32))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TInt32));
  end;
end;

procedure to_int64(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TInt64))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TInt64));
  end;
end;

procedure to_uint(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TUInt))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TUInt));
  end;
end;

procedure to_uint8(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TUInt8))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TUInt8));
  end;
end;

procedure to_uint16(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TUInt16))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TUInt16));
  end;
end;

procedure to_uint32(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TUInt32))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TUInt32));
  end;
end;

procedure to_uint64(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(TUint64))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(TUint64));
  end;
end;

procedure to_ptr(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine^ do begin
    if Machine.State = FS_COMPILE then
      compile_to(Machine, Machine.NextName, SizeOf(Pointer))
    else
      interpete_to(Machine, Machine.NextName, SizeOf(Pointer));
  end;
end;

procedure compile_to;
begin
  with Machine^ do begin
    case Size of
      1: Machine.WriteMnemonicByName(' 8to');
      2: Machine.WriteMnemonicByName(' 16to');
      4: Machine.WriteMnemonicByName(' 32to');
      8: Machine.WriteMnemonicByName(' 64to');
    else
      Machine.WriteMnemonicByName(' to');
      Machine.WriteEmbroByte(Size);
    end;
    Machine.WriteMnemonicByName(Name);
  end;
end;

procedure interpete_to;
var
  C: PForthCommand;
  Temp: array of Byte;
begin
 // with Machine^ do begin
    C := Machine.FindCommand(Name);
    if C = nil then begin
      Machine.LogError('cannot find command ' + Name);
      Exit;
    end;
    SetLength(Temp, Size);
    // FIXME
    //Machine.(@Temp[0], Size);
    Move(Temp[0], C^.Data^, Size);
 // end;
end;

procedure _nil(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    P := nil;
    Machine.WUP(nil);
  end;
end;

procedure ptr_comma(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  with Machine^ do begin
    P := Machine.WOP;
    Move(P, Machine.Here^, SizeOf(Pointer));
    Machine.IncHere(SizeOf(Pointer)); 
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
  P: PType;
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
  P: PType;
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
var
  I: Integer;
begin
  FSource := Source;
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
var
  M: Cardinal;
  SavedState: Integer;
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

procedure OForthMachine.RunError(const S: TString);
begin
  Error('Runtime(' + InternalFileName(FCurrentFileName) + ', ' +
                     IntToStr(FCurrentLine) + ', ' +
                     IntToStr(FCurrentPos) + '): ' + S);
  // FRunning := False;
end;

procedure OForthMachine.RunWarring(const S: TString);
begin
  Warrning('Runtime warring: ' + S);
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
  Result := S[SC] = #0;
end;

function OForthMachine.SNC: TChar;
begin
  Result := S[SC];
  if not SE then begin
    Inc(SC);
    if Result = EOL then begin
      Inc(FCurrentLine);
      FCurrentPos := 1
    end else
      Inc(FCurrentPos);
  end;
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
  while (not SE) and (S[SC] in [#1..#32]) do
    SNC;
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

procedure _BtoW(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUP(Machine.BWO);
end;

procedure _WtoB(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.BWU(Machine.WOP);
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
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
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
  S  := nil;
  SC := 0;
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
  AddCommand('align', _align);
  AddCommand('palign', _palign);
  AddCommand('*poststr', _poststr);
  AddCommand('*postname', _postname);
  AddCommand('utf8->unicode', _utf8_2_unicode);
  AddCommand('utf8->raw', _utf8_2_raw);
  AddCommand('raw->unicode', _raw_2_unicode);
  AddCommand('unicode->utf8', _unicode_2_utf8);
  AddCommand('unicode->raw', _unicode_2_raw);
  AddCommand('randomize', _randomize);
  AddCommand('random', _random);
  
  AddCommand('w>b', _WtoB);
  AddCommand('b>w', _BtoW);

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
{$IFNDEF FLAG_FPC}{$REGION 'control commands'}{$ENDIF}
  AddCommand(':', compile_def);
  AddCommand(':noname', compile_noname);
  AddCommand(';', compile_enddef, True);
  AddCommand('skip-to;', compile_enddef, True);
  AddCommand('...', scattered_dots, True);
  AddCommand('..:', compile_scattered_def);
  AddCommand(';..', compile_scattered_enddef, True);
  AddCommand('branch', branch);
  AddCommand('?branch', _ask_branch);
  AddCommand('>mark', _gt_mark);
  AddCommand('>resolve', _gt_resolve);
  AddCommand('<mark', _lt_mark);
  AddCommand('<resolve', _lt_resolve);
  AddCommand('recurse', recurse, True);
  AddCommand('immediate', immediate);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'embro commands'}{$ENDIF}
  AddCommand('compile', compile, True);
  AddCommand('(compile)', q_compile_q, True);
  AddCommand('call', _call, True);
  AddCommand('postpone', postpone, True);
  AddCommand('compiled', _compiled, False);
  AddCommand('postponed', _postponed, False);
  AddCommand('called', _called, False);
  AddCommand('evaluate', Evaluate);
  AddCommand('evaluate-file', EvaluateFile);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'data commands'}{$ENDIF}
  AddCommand('nil', _nil);
  AddCommand('ptr,', ptr_comma);

  AddCommand('create', _create);
  AddCommand('created', _created);
  DCommandsEmbro.LoadCommands(@Self);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'bool'}{$ENDIF}
  DCommandsBool.LoadCommands(@Self);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
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
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     AddCommand('ptr-drop', drop_ptr);
     AddCommand('ptr-dup', dup_ptr);
     AddCommand('ptr-nip', nip_ptr);
     AddCommand('ptr-swap', swap_ptr);
     AddCommand('ptr-over', over_ptr);
     AddCommand('ptr-tuck', tuck_ptr);
     AddCommand('ptr-lrot', lrot_ptr);
     AddCommand('ptr-rrot', rrot_ptr);
     AddCommand('ptr-lrotn', lrotn_ptr);
     AddCommand('ptr-rrotn', rrotn_ptr);
     AddCommand('ptr-pick', pick_ptr);
     AddCommand('ptr,', _comma_ptr);
     AddCommand('ptr@', _dog_ptr);
     AddCommand('ptr!', _exclamation_ptr);
     AddCommand('ptr+ptr', ptr_plus_ptr);
     AddCommand('ptr-to', _to_ptr, True);
     AddCommand('compile@ptr-to', _compile_to_ptr);
     AddCommand('run@ptr-to', _run_to_ptr);
     AddCommand('interpret@ptr-to', _interpret_to_ptr);
     AddCommand('ptr-value', _value_ptr);
     AddCommand('ptr-constant', _value_ptr);
     AddCommand('ptr-variable', _variable_ptr);
     AddCommand('ptr-literal', literal_ptr, True);
     AddCommand('ptr-(literal)', run_literal_ptr);
    
    
     AddCommand('int-drop', drop_int);
     AddCommand('int-dup', dup_int);
     AddCommand('int-nip', nip_int);
     AddCommand('int-swap', swap_int);
     AddCommand('int-over', over_int);
     AddCommand('int-tuck', tuck_int);
     AddCommand('int-lrot', lrot_int);
     AddCommand('int-rrot', rrot_int);
     AddCommand('int-lrotn', lrotn_int);
     AddCommand('int-rrotn', rrotn_int);
     AddCommand('int-pick', pick_int);
     AddCommand('int,', _comma_int);
     AddCommand('int@', _dog_int);
     AddCommand('int!', _exclamation_int);
     AddCommand('ptr+int', ptr_plus_int);
     AddCommand('int-to', _to_int, True);
     AddCommand('compile@int-to', _compile_to_int);
     AddCommand('run@int-to', _run_to_int);
     AddCommand('interpret@int-to', _interpret_to_int);
     AddCommand('int-value', _value_int);
     AddCommand('int-constant', _value_int);
     AddCommand('int-variable', _variable_int);
     AddCommand('int-literal', literal_int, True);
     AddCommand('int-(literal)', run_literal_int);
    
    
     AddCommand('int8-drop', drop_int8);
     AddCommand('int8-dup', dup_int8);
     AddCommand('int8-nip', nip_int8);
     AddCommand('int8-swap', swap_int8);
     AddCommand('int8-over', over_int8);
     AddCommand('int8-tuck', tuck_int8);
     AddCommand('int8-lrot', lrot_int8);
     AddCommand('int8-rrot', rrot_int8);
     AddCommand('int8-lrotn', lrotn_int8);
     AddCommand('int8-rrotn', rrotn_int8);
     AddCommand('int8-pick', pick_int8);
     AddCommand('int8,', _comma_int8);
     AddCommand('int8@', _dog_int8);
     AddCommand('int8!', _exclamation_int8);
     AddCommand('ptr+int8', ptr_plus_int8);
     AddCommand('int8-to', _to_int8, True);
     AddCommand('compile@int8-to', _compile_to_int8);
     AddCommand('run@int8-to', _run_to_int8);
     AddCommand('interpret@int8-to', _interpret_to_int8);
     AddCommand('int8-value', _value_int8);
     AddCommand('int8-constant', _value_int8);
     AddCommand('int8-variable', _variable_int8);
     AddCommand('int8-literal', literal_int8, True);
     AddCommand('int8-(literal)', run_literal_int8);
    
    
     AddCommand('int16-drop', drop_int16);
     AddCommand('int16-dup', dup_int16);
     AddCommand('int16-nip', nip_int16);
     AddCommand('int16-swap', swap_int16);
     AddCommand('int16-over', over_int16);
     AddCommand('int16-tuck', tuck_int16);
     AddCommand('int16-lrot', lrot_int16);
     AddCommand('int16-rrot', rrot_int16);
     AddCommand('int16-lrotn', lrotn_int16);
     AddCommand('int16-rrotn', rrotn_int16);
     AddCommand('int16-pick', pick_int16);
     AddCommand('int16,', _comma_int16);
     AddCommand('int16@', _dog_int16);
     AddCommand('int16!', _exclamation_int16);
     AddCommand('ptr+int16', ptr_plus_int16);
     AddCommand('int16-to', _to_int16, True);
     AddCommand('compile@int16-to', _compile_to_int16);
     AddCommand('run@int16-to', _run_to_int16);
     AddCommand('interpret@int16-to', _interpret_to_int16);
     AddCommand('int16-value', _value_int16);
     AddCommand('int16-constant', _value_int16);
     AddCommand('int16-variable', _variable_int16);
     AddCommand('int16-literal', literal_int16, True);
     AddCommand('int16-(literal)', run_literal_int16);
    
    
     AddCommand('int32-drop', drop_int32);
     AddCommand('int32-dup', dup_int32);
     AddCommand('int32-nip', nip_int32);
     AddCommand('int32-swap', swap_int32);
     AddCommand('int32-over', over_int32);
     AddCommand('int32-tuck', tuck_int32);
     AddCommand('int32-lrot', lrot_int32);
     AddCommand('int32-rrot', rrot_int32);
     AddCommand('int32-lrotn', lrotn_int32);
     AddCommand('int32-rrotn', rrotn_int32);
     AddCommand('int32-pick', pick_int32);
     AddCommand('int32,', _comma_int32);
     AddCommand('int32@', _dog_int32);
     AddCommand('int32!', _exclamation_int32);
     AddCommand('ptr+int32', ptr_plus_int32);
     AddCommand('int32-to', _to_int32, True);
     AddCommand('compile@int32-to', _compile_to_int32);
     AddCommand('run@int32-to', _run_to_int32);
     AddCommand('interpret@int32-to', _interpret_to_int32);
     AddCommand('int32-value', _value_int32);
     AddCommand('int32-constant', _value_int32);
     AddCommand('int32-variable', _variable_int32);
     AddCommand('int32-literal', literal_int32, True);
     AddCommand('int32-(literal)', run_literal_int32);
    
    
     AddCommand('int64-drop', drop_int64);
     AddCommand('int64-dup', dup_int64);
     AddCommand('int64-nip', nip_int64);
     AddCommand('int64-swap', swap_int64);
     AddCommand('int64-over', over_int64);
     AddCommand('int64-tuck', tuck_int64);
     AddCommand('int64-lrot', lrot_int64);
     AddCommand('int64-rrot', rrot_int64);
     AddCommand('int64-lrotn', lrotn_int64);
     AddCommand('int64-rrotn', rrotn_int64);
     AddCommand('int64-pick', pick_int64);
     AddCommand('int64,', _comma_int64);
     AddCommand('int64@', _dog_int64);
     AddCommand('int64!', _exclamation_int64);
     AddCommand('ptr+int64', ptr_plus_int64);
     AddCommand('int64-to', _to_int64, True);
     AddCommand('compile@int64-to', _compile_to_int64);
     AddCommand('run@int64-to', _run_to_int64);
     AddCommand('interpret@int64-to', _interpret_to_int64);
     AddCommand('int64-value', _value_int64);
     AddCommand('int64-constant', _value_int64);
     AddCommand('int64-variable', _variable_int64);
     AddCommand('int64-literal', literal_int64, True);
     AddCommand('int64-(literal)', run_literal_int64);
    
    
     AddCommand('uint-drop', drop_uint);
     AddCommand('uint-dup', dup_uint);
     AddCommand('uint-nip', nip_uint);
     AddCommand('uint-swap', swap_uint);
     AddCommand('uint-over', over_uint);
     AddCommand('uint-tuck', tuck_uint);
     AddCommand('uint-lrot', lrot_uint);
     AddCommand('uint-rrot', rrot_uint);
     AddCommand('uint-lrotn', lrotn_uint);
     AddCommand('uint-rrotn', rrotn_uint);
     AddCommand('uint-pick', pick_uint);
     AddCommand('uint,', _comma_uint);
     AddCommand('uint@', _dog_uint);
     AddCommand('uint!', _exclamation_uint);
     AddCommand('ptr+uint', ptr_plus_uint);
     AddCommand('uint-to', _to_uint, True);
     AddCommand('compile@uint-to', _compile_to_uint);
     AddCommand('run@uint-to', _run_to_uint);
     AddCommand('interpret@uint-to', _interpret_to_uint);
     AddCommand('uint-value', _value_uint);
     AddCommand('uint-constant', _value_uint);
     AddCommand('uint-variable', _variable_uint);
     AddCommand('uint-literal', literal_uint, True);
     AddCommand('uint-(literal)', run_literal_uint);
    
    
     AddCommand('uint8-drop', drop_uint8);
     AddCommand('uint8-dup', dup_uint8);
     AddCommand('uint8-nip', nip_uint8);
     AddCommand('uint8-swap', swap_uint8);
     AddCommand('uint8-over', over_uint8);
     AddCommand('uint8-tuck', tuck_uint8);
     AddCommand('uint8-lrot', lrot_uint8);
     AddCommand('uint8-rrot', rrot_uint8);
     AddCommand('uint8-lrotn', lrotn_uint8);
     AddCommand('uint8-rrotn', rrotn_uint8);
     AddCommand('uint8-pick', pick_uint8);
     AddCommand('uint8,', _comma_uint8);
     AddCommand('uint8@', _dog_uint8);
     AddCommand('uint8!', _exclamation_uint8);
     AddCommand('ptr+uint8', ptr_plus_uint8);
     AddCommand('uint8-to', _to_uint8, True);
     AddCommand('compile@uint8-to', _compile_to_uint8);
     AddCommand('run@uint8-to', _run_to_uint8);
     AddCommand('interpret@uint8-to', _interpret_to_uint8);
     AddCommand('uint8-value', _value_uint8);
     AddCommand('uint8-constant', _value_uint8);
     AddCommand('uint8-variable', _variable_uint8);
     AddCommand('uint8-literal', literal_uint8, True);
     AddCommand('uint8-(literal)', run_literal_uint8);
    
    
     AddCommand('uint16-drop', drop_uint16);
     AddCommand('uint16-dup', dup_uint16);
     AddCommand('uint16-nip', nip_uint16);
     AddCommand('uint16-swap', swap_uint16);
     AddCommand('uint16-over', over_uint16);
     AddCommand('uint16-tuck', tuck_uint16);
     AddCommand('uint16-lrot', lrot_uint16);
     AddCommand('uint16-rrot', rrot_uint16);
     AddCommand('uint16-lrotn', lrotn_uint16);
     AddCommand('uint16-rrotn', rrotn_uint16);
     AddCommand('uint16-pick', pick_uint16);
     AddCommand('uint16,', _comma_uint16);
     AddCommand('uint16@', _dog_uint16);
     AddCommand('uint16!', _exclamation_uint16);
     AddCommand('ptr+uint16', ptr_plus_uint16);
     AddCommand('uint16-to', _to_uint16, True);
     AddCommand('compile@uint16-to', _compile_to_uint16);
     AddCommand('run@uint16-to', _run_to_uint16);
     AddCommand('interpret@uint16-to', _interpret_to_uint16);
     AddCommand('uint16-value', _value_uint16);
     AddCommand('uint16-constant', _value_uint16);
     AddCommand('uint16-variable', _variable_uint16);
     AddCommand('uint16-literal', literal_uint16, True);
     AddCommand('uint16-(literal)', run_literal_uint16);
    
    
     AddCommand('uint32-drop', drop_uint32);
     AddCommand('uint32-dup', dup_uint32);
     AddCommand('uint32-nip', nip_uint32);
     AddCommand('uint32-swap', swap_uint32);
     AddCommand('uint32-over', over_uint32);
     AddCommand('uint32-tuck', tuck_uint32);
     AddCommand('uint32-lrot', lrot_uint32);
     AddCommand('uint32-rrot', rrot_uint32);
     AddCommand('uint32-lrotn', lrotn_uint32);
     AddCommand('uint32-rrotn', rrotn_uint32);
     AddCommand('uint32-pick', pick_uint32);
     AddCommand('uint32,', _comma_uint32);
     AddCommand('uint32@', _dog_uint32);
     AddCommand('uint32!', _exclamation_uint32);
     AddCommand('ptr+uint32', ptr_plus_uint32);
     AddCommand('uint32-to', _to_uint32, True);
     AddCommand('compile@uint32-to', _compile_to_uint32);
     AddCommand('run@uint32-to', _run_to_uint32);
     AddCommand('interpret@uint32-to', _interpret_to_uint32);
     AddCommand('uint32-value', _value_uint32);
     AddCommand('uint32-constant', _value_uint32);
     AddCommand('uint32-variable', _variable_uint32);
     AddCommand('uint32-literal', literal_uint32, True);
     AddCommand('uint32-(literal)', run_literal_uint32);
    
    
     AddCommand('uint64-drop', drop_uint64);
     AddCommand('uint64-dup', dup_uint64);
     AddCommand('uint64-nip', nip_uint64);
     AddCommand('uint64-swap', swap_uint64);
     AddCommand('uint64-over', over_uint64);
     AddCommand('uint64-tuck', tuck_uint64);
     AddCommand('uint64-lrot', lrot_uint64);
     AddCommand('uint64-rrot', rrot_uint64);
     AddCommand('uint64-lrotn', lrotn_uint64);
     AddCommand('uint64-rrotn', rrotn_uint64);
     AddCommand('uint64-pick', pick_uint64);
     AddCommand('uint64,', _comma_uint64);
     AddCommand('uint64@', _dog_uint64);
     AddCommand('uint64!', _exclamation_uint64);
     AddCommand('ptr+uint64', ptr_plus_uint64);
     AddCommand('uint64-to', _to_uint64, True);
     AddCommand('compile@uint64-to', _compile_to_uint64);
     AddCommand('run@uint64-to', _run_to_uint64);
     AddCommand('interpret@uint64-to', _interpret_to_uint64);
     AddCommand('uint64-value', _value_uint64);
     AddCommand('uint64-constant', _value_uint64);
     AddCommand('uint64-variable', _variable_uint64);
     AddCommand('uint64-literal', literal_uint64, True);
     AddCommand('uint64-(literal)', run_literal_uint64);
    
    
     AddCommand('embro-drop', drop_embro);
     AddCommand('embro-dup', dup_embro);
     AddCommand('embro-nip', nip_embro);
     AddCommand('embro-swap', swap_embro);
     AddCommand('embro-over', over_embro);
     AddCommand('embro-tuck', tuck_embro);
     AddCommand('embro-lrot', lrot_embro);
     AddCommand('embro-rrot', rrot_embro);
     AddCommand('embro-lrotn', lrotn_embro);
     AddCommand('embro-rrotn', rrotn_embro);
     AddCommand('embro-pick', pick_embro);
     AddCommand('embro,', _comma_embro);
     AddCommand('embro@', _dog_embro);
     AddCommand('embro!', _exclamation_embro);
     AddCommand('ptr+embro', ptr_plus_embro);
     AddCommand('embro-to', _to_embro, True);
     AddCommand('compile@embro-to', _compile_to_embro);
     AddCommand('run@embro-to', _run_to_embro);
     AddCommand('interpret@embro-to', _interpret_to_embro);
     AddCommand('embro-value', _value_embro);
     AddCommand('embro-constant', _value_embro);
     AddCommand('embro-variable', _variable_embro);
     AddCommand('embro-literal', literal_embro, True);
     AddCommand('embro-(literal)', run_literal_embro);
    
    
     AddCommand('float-drop', drop_float);
     AddCommand('float-dup', dup_float);
     AddCommand('float-nip', nip_float);
     AddCommand('float-swap', swap_float);
     AddCommand('float-over', over_float);
     AddCommand('float-tuck', tuck_float);
     AddCommand('float-lrot', lrot_float);
     AddCommand('float-rrot', rrot_float);
     AddCommand('float-lrotn', lrotn_float);
     AddCommand('float-rrotn', rrotn_float);
     AddCommand('float-pick', pick_float);
     AddCommand('float,', _comma_float);
     AddCommand('float@', _dog_float);
     AddCommand('float!', _exclamation_float);
     AddCommand('ptr+float', ptr_plus_float);
     AddCommand('float-to', _to_float, True);
     AddCommand('compile@float-to', _compile_to_float);
     AddCommand('run@float-to', _run_to_float);
     AddCommand('interpret@float-to', _interpret_to_float);
     AddCommand('float-value', _value_float);
     AddCommand('float-constant', _value_float);
     AddCommand('float-variable', _variable_float);
     AddCommand('float-literal', literal_float, True);
     AddCommand('float-(literal)', run_literal_float);
    
    
     AddCommand('double-drop', drop_double);
     AddCommand('double-dup', dup_double);
     AddCommand('double-nip', nip_double);
     AddCommand('double-swap', swap_double);
     AddCommand('double-over', over_double);
     AddCommand('double-tuck', tuck_double);
     AddCommand('double-lrot', lrot_double);
     AddCommand('double-rrot', rrot_double);
     AddCommand('double-lrotn', lrotn_double);
     AddCommand('double-rrotn', rrotn_double);
     AddCommand('double-pick', pick_double);
     AddCommand('double,', _comma_double);
     AddCommand('double@', _dog_double);
     AddCommand('double!', _exclamation_double);
     AddCommand('ptr+double', ptr_plus_double);
     AddCommand('double-to', _to_double, True);
     AddCommand('compile@double-to', _compile_to_double);
     AddCommand('run@double-to', _run_to_double);
     AddCommand('interpret@double-to', _interpret_to_double);
     AddCommand('double-value', _value_double);
     AddCommand('double-constant', _value_double);
     AddCommand('double-variable', _variable_double);
     AddCommand('double-literal', literal_double, True);
     AddCommand('double-(literal)', run_literal_double);
    
    
     AddCommand('extended-drop', drop_extended);
     AddCommand('extended-dup', dup_extended);
     AddCommand('extended-nip', nip_extended);
     AddCommand('extended-swap', swap_extended);
     AddCommand('extended-over', over_extended);
     AddCommand('extended-tuck', tuck_extended);
     AddCommand('extended-lrot', lrot_extended);
     AddCommand('extended-rrot', rrot_extended);
     AddCommand('extended-lrotn', lrotn_extended);
     AddCommand('extended-rrotn', rrotn_extended);
     AddCommand('extended-pick', pick_extended);
     AddCommand('extended,', _comma_extended);
     AddCommand('extended@', _dog_extended);
     AddCommand('extended!', _exclamation_extended);
     AddCommand('ptr+extended', ptr_plus_extended);
     AddCommand('extended-to', _to_extended, True);
     AddCommand('compile@extended-to', _compile_to_extended);
     AddCommand('run@extended-to', _run_to_extended);
     AddCommand('interpret@extended-to', _interpret_to_extended);
     AddCommand('extended-value', _value_extended);
     AddCommand('extended-constant', _value_extended);
     AddCommand('extended-variable', _variable_extended);
     AddCommand('extended-literal', literal_extended, True);
     AddCommand('extended-(literal)', run_literal_extended);
    
    
     AddCommand('+', _plus);
     AddCommand('-', _minus);
     AddCommand('*', _star);
     AddCommand('=', _equel);
     AddCommand('<>', _nequel);
     AddCommand('<', _lt);
     AddCommand('>', _gt);
     AddCommand('<=', _lte);
     AddCommand('>=', _gte);
     AddCommand('0=', _0_equel);
     AddCommand('0<>', _0_nequel);
     AddCommand('0<', _0_lt);
     AddCommand('0>', _0_gt);
     AddCommand('0<=', _0_lte);
     AddCommand('0>=', _0_gte);
     AddCommand('?dup', _ask_dup);
     addcommand('0;', _0_exit);
     addcommand('if;', _if_exit);
     AddCommand('min', _min);
     AddCommand('max', _max);
     AddCommand('minmax', _minmax);
     AddCommand('.', _dot);
     AddCommand('$', _dollar);
     AddCommand('+!', _ptr_plus_exclamation);
     AddCommand('->str', _conv_to_str);
     AddCommand('str->', _conv_from_str);
    
    
     AddCommand('int+', int_plus);
     AddCommand('int-', int_minus);
     AddCommand('int*', int_star);
     AddCommand('int=', int_equel);
     AddCommand('int<>', int_nequel);
     AddCommand('int<', int_lt);
     AddCommand('int>', int_gt);
     AddCommand('int<=', int_lte);
     AddCommand('int>=', int_gte);
     AddCommand('int-0=', int_0_equel);
     AddCommand('int-0<>', int_0_nequel);
     AddCommand('int-0<', int_0_lt);
     AddCommand('int-0>', int_0_gt);
     AddCommand('int-0<=', int_0_lte);
     AddCommand('int-0>=', int_0_gte);
     AddCommand('int-?dup', int_ask_dup);
     addcommand('int-0;', int_0_exit);
     addcommand('int-if;', int_if_exit);
     AddCommand('int-min', int_min);
     AddCommand('int-max', int_max);
     AddCommand('int-minmax', int_minmax);
     AddCommand('int.', int_dot);
     AddCommand('int$', int_dollar);
     AddCommand('int+!', int_ptr_plus_exclamation);
     AddCommand('int->str', int_conv_to_str);
     AddCommand('str->int', int_conv_from_str);
    
    
     AddCommand('int8+', int8_plus);
     AddCommand('int8-', int8_minus);
     AddCommand('int8*', int8_star);
     AddCommand('int8=', int8_equel);
     AddCommand('int8<>', int8_nequel);
     AddCommand('int8<', int8_lt);
     AddCommand('int8>', int8_gt);
     AddCommand('int8<=', int8_lte);
     AddCommand('int8>=', int8_gte);
     AddCommand('int8-0=', int8_0_equel);
     AddCommand('int8-0<>', int8_0_nequel);
     AddCommand('int8-0<', int8_0_lt);
     AddCommand('int8-0>', int8_0_gt);
     AddCommand('int8-0<=', int8_0_lte);
     AddCommand('int8-0>=', int8_0_gte);
     AddCommand('int8-?dup', int8_ask_dup);
     addcommand('int8-0;', int8_0_exit);
     addcommand('int8-if;', int8_if_exit);
     AddCommand('int8-min', int8_min);
     AddCommand('int8-max', int8_max);
     AddCommand('int8-minmax', int8_minmax);
     AddCommand('int8.', int8_dot);
     AddCommand('int8$', int8_dollar);
     AddCommand('int8+!', int8_ptr_plus_exclamation);
     AddCommand('int8->str', int8_conv_to_str);
     AddCommand('str->int8', int8_conv_from_str);
    
    
     AddCommand('int16+', int16_plus);
     AddCommand('int16-', int16_minus);
     AddCommand('int16*', int16_star);
     AddCommand('int16=', int16_equel);
     AddCommand('int16<>', int16_nequel);
     AddCommand('int16<', int16_lt);
     AddCommand('int16>', int16_gt);
     AddCommand('int16<=', int16_lte);
     AddCommand('int16>=', int16_gte);
     AddCommand('int16-0=', int16_0_equel);
     AddCommand('int16-0<>', int16_0_nequel);
     AddCommand('int16-0<', int16_0_lt);
     AddCommand('int16-0>', int16_0_gt);
     AddCommand('int16-0<=', int16_0_lte);
     AddCommand('int16-0>=', int16_0_gte);
     AddCommand('int16-?dup', int16_ask_dup);
     addcommand('int16-0;', int16_0_exit);
     addcommand('int16-if;', int16_if_exit);
     AddCommand('int16-min', int16_min);
     AddCommand('int16-max', int16_max);
     AddCommand('int16-minmax', int16_minmax);
     AddCommand('int16.', int16_dot);
     AddCommand('int16$', int16_dollar);
     AddCommand('int16+!', int16_ptr_plus_exclamation);
     AddCommand('int16->str', int16_conv_to_str);
     AddCommand('str->int16', int16_conv_from_str);
    
    
     AddCommand('int32+', int32_plus);
     AddCommand('int32-', int32_minus);
     AddCommand('int32*', int32_star);
     AddCommand('int32=', int32_equel);
     AddCommand('int32<>', int32_nequel);
     AddCommand('int32<', int32_lt);
     AddCommand('int32>', int32_gt);
     AddCommand('int32<=', int32_lte);
     AddCommand('int32>=', int32_gte);
     AddCommand('int32-0=', int32_0_equel);
     AddCommand('int32-0<>', int32_0_nequel);
     AddCommand('int32-0<', int32_0_lt);
     AddCommand('int32-0>', int32_0_gt);
     AddCommand('int32-0<=', int32_0_lte);
     AddCommand('int32-0>=', int32_0_gte);
     AddCommand('int32-?dup', int32_ask_dup);
     addcommand('int32-0;', int32_0_exit);
     addcommand('int32-if;', int32_if_exit);
     AddCommand('int32-min', int32_min);
     AddCommand('int32-max', int32_max);
     AddCommand('int32-minmax', int32_minmax);
     AddCommand('int32.', int32_dot);
     AddCommand('int32$', int32_dollar);
     AddCommand('int32+!', int32_ptr_plus_exclamation);
     AddCommand('int32->str', int32_conv_to_str);
     AddCommand('str->int32', int32_conv_from_str);
    
    
     AddCommand('int64+', int64_plus);
     AddCommand('int64-', int64_minus);
     AddCommand('int64*', int64_star);
     AddCommand('int64=', int64_equel);
     AddCommand('int64<>', int64_nequel);
     AddCommand('int64<', int64_lt);
     AddCommand('int64>', int64_gt);
     AddCommand('int64<=', int64_lte);
     AddCommand('int64>=', int64_gte);
     AddCommand('int64-0=', int64_0_equel);
     AddCommand('int64-0<>', int64_0_nequel);
     AddCommand('int64-0<', int64_0_lt);
     AddCommand('int64-0>', int64_0_gt);
     AddCommand('int64-0<=', int64_0_lte);
     AddCommand('int64-0>=', int64_0_gte);
     AddCommand('int64-?dup', int64_ask_dup);
     addcommand('int64-0;', int64_0_exit);
     addcommand('int64-if;', int64_if_exit);
     AddCommand('int64-min', int64_min);
     AddCommand('int64-max', int64_max);
     AddCommand('int64-minmax', int64_minmax);
     AddCommand('int64.', int64_dot);
     AddCommand('int64$', int64_dollar);
     AddCommand('int64+!', int64_ptr_plus_exclamation);
     AddCommand('int64->str', int64_conv_to_str);
     AddCommand('str->int64', int64_conv_from_str);
    
    
     AddCommand('uint+', uint_plus);
     AddCommand('uint-', uint_minus);
     AddCommand('uint*', uint_star);
     AddCommand('uint=', uint_equel);
     AddCommand('uint<>', uint_nequel);
     AddCommand('uint<', uint_lt);
     AddCommand('uint>', uint_gt);
     AddCommand('uint<=', uint_lte);
     AddCommand('uint>=', uint_gte);
     AddCommand('uint-0=', uint_0_equel);
     AddCommand('uint-0<>', uint_0_nequel);
     AddCommand('uint-0<', uint_0_lt);
     AddCommand('uint-0>', uint_0_gt);
     AddCommand('uint-0<=', uint_0_lte);
     AddCommand('uint-0>=', uint_0_gte);
     AddCommand('uint-?dup', uint_ask_dup);
     addcommand('uint-0;', uint_0_exit);
     addcommand('uint-if;', uint_if_exit);
     AddCommand('uint-min', uint_min);
     AddCommand('uint-max', uint_max);
     AddCommand('uint-minmax', uint_minmax);
     AddCommand('uint.', uint_dot);
     AddCommand('uint$', uint_dollar);
     AddCommand('uint+!', uint_ptr_plus_exclamation);
     AddCommand('uint->str', uint_conv_to_str);
     AddCommand('str->uint', uint_conv_from_str);
    
    
     AddCommand('uint8+', uint8_plus);
     AddCommand('uint8-', uint8_minus);
     AddCommand('uint8*', uint8_star);
     AddCommand('uint8=', uint8_equel);
     AddCommand('uint8<>', uint8_nequel);
     AddCommand('uint8<', uint8_lt);
     AddCommand('uint8>', uint8_gt);
     AddCommand('uint8<=', uint8_lte);
     AddCommand('uint8>=', uint8_gte);
     AddCommand('uint8-0=', uint8_0_equel);
     AddCommand('uint8-0<>', uint8_0_nequel);
     AddCommand('uint8-0<', uint8_0_lt);
     AddCommand('uint8-0>', uint8_0_gt);
     AddCommand('uint8-0<=', uint8_0_lte);
     AddCommand('uint8-0>=', uint8_0_gte);
     AddCommand('uint8-?dup', uint8_ask_dup);
     addcommand('uint8-0;', uint8_0_exit);
     addcommand('uint8-if;', uint8_if_exit);
     AddCommand('uint8-min', uint8_min);
     AddCommand('uint8-max', uint8_max);
     AddCommand('uint8-minmax', uint8_minmax);
     AddCommand('uint8.', uint8_dot);
     AddCommand('uint8$', uint8_dollar);
     AddCommand('uint8+!', uint8_ptr_plus_exclamation);
     AddCommand('uint8->str', uint8_conv_to_str);
     AddCommand('str->uint8', uint8_conv_from_str);
    
    
     AddCommand('uint16+', uint16_plus);
     AddCommand('uint16-', uint16_minus);
     AddCommand('uint16*', uint16_star);
     AddCommand('uint16=', uint16_equel);
     AddCommand('uint16<>', uint16_nequel);
     AddCommand('uint16<', uint16_lt);
     AddCommand('uint16>', uint16_gt);
     AddCommand('uint16<=', uint16_lte);
     AddCommand('uint16>=', uint16_gte);
     AddCommand('uint16-0=', uint16_0_equel);
     AddCommand('uint16-0<>', uint16_0_nequel);
     AddCommand('uint16-0<', uint16_0_lt);
     AddCommand('uint16-0>', uint16_0_gt);
     AddCommand('uint16-0<=', uint16_0_lte);
     AddCommand('uint16-0>=', uint16_0_gte);
     AddCommand('uint16-?dup', uint16_ask_dup);
     addcommand('uint16-0;', uint16_0_exit);
     addcommand('uint16-if;', uint16_if_exit);
     AddCommand('uint16-min', uint16_min);
     AddCommand('uint16-max', uint16_max);
     AddCommand('uint16-minmax', uint16_minmax);
     AddCommand('uint16.', uint16_dot);
     AddCommand('uint16$', uint16_dollar);
     AddCommand('uint16+!', uint16_ptr_plus_exclamation);
     AddCommand('uint16->str', uint16_conv_to_str);
     AddCommand('str->uint16', uint16_conv_from_str);
    
    
     AddCommand('uint32+', uint32_plus);
     AddCommand('uint32-', uint32_minus);
     AddCommand('uint32*', uint32_star);
     AddCommand('uint32=', uint32_equel);
     AddCommand('uint32<>', uint32_nequel);
     AddCommand('uint32<', uint32_lt);
     AddCommand('uint32>', uint32_gt);
     AddCommand('uint32<=', uint32_lte);
     AddCommand('uint32>=', uint32_gte);
     AddCommand('uint32-0=', uint32_0_equel);
     AddCommand('uint32-0<>', uint32_0_nequel);
     AddCommand('uint32-0<', uint32_0_lt);
     AddCommand('uint32-0>', uint32_0_gt);
     AddCommand('uint32-0<=', uint32_0_lte);
     AddCommand('uint32-0>=', uint32_0_gte);
     AddCommand('uint32-?dup', uint32_ask_dup);
     addcommand('uint32-0;', uint32_0_exit);
     addcommand('uint32-if;', uint32_if_exit);
     AddCommand('uint32-min', uint32_min);
     AddCommand('uint32-max', uint32_max);
     AddCommand('uint32-minmax', uint32_minmax);
     AddCommand('uint32.', uint32_dot);
     AddCommand('uint32$', uint32_dollar);
     AddCommand('uint32+!', uint32_ptr_plus_exclamation);
     AddCommand('uint32->str', uint32_conv_to_str);
     AddCommand('str->uint32', uint32_conv_from_str);
    
    
     AddCommand('uint64+', uint64_plus);
     AddCommand('uint64-', uint64_minus);
     AddCommand('uint64*', uint64_star);
     AddCommand('uint64=', uint64_equel);
     AddCommand('uint64<>', uint64_nequel);
     AddCommand('uint64<', uint64_lt);
     AddCommand('uint64>', uint64_gt);
     AddCommand('uint64<=', uint64_lte);
     AddCommand('uint64>=', uint64_gte);
     AddCommand('uint64-0=', uint64_0_equel);
     AddCommand('uint64-0<>', uint64_0_nequel);
     AddCommand('uint64-0<', uint64_0_lt);
     AddCommand('uint64-0>', uint64_0_gt);
     AddCommand('uint64-0<=', uint64_0_lte);
     AddCommand('uint64-0>=', uint64_0_gte);
     AddCommand('uint64-?dup', uint64_ask_dup);
     addcommand('uint64-0;', uint64_0_exit);
     addcommand('uint64-if;', uint64_if_exit);
     AddCommand('uint64-min', uint64_min);
     AddCommand('uint64-max', uint64_max);
     AddCommand('uint64-minmax', uint64_minmax);
     AddCommand('uint64.', uint64_dot);
     AddCommand('uint64$', uint64_dollar);
     AddCommand('uint64+!', uint64_ptr_plus_exclamation);
     AddCommand('uint64->str', uint64_conv_to_str);
     AddCommand('str->uint64', uint64_conv_from_str);
    
    
     AddCommand('float+', float_plus);
     AddCommand('float-', float_minus);
     AddCommand('float*', float_star);
     AddCommand('float=', float_equel);
     AddCommand('float<>', float_nequel);
     AddCommand('float<', float_lt);
     AddCommand('float>', float_gt);
     AddCommand('float<=', float_lte);
     AddCommand('float>=', float_gte);
     AddCommand('float-0=', float_0_equel);
     AddCommand('float-0<>', float_0_nequel);
     AddCommand('float-0<', float_0_lt);
     AddCommand('float-0>', float_0_gt);
     AddCommand('float-0<=', float_0_lte);
     AddCommand('float-0>=', float_0_gte);
     AddCommand('float-?dup', float_ask_dup);
     addcommand('float-0;', float_0_exit);
     addcommand('float-if;', float_if_exit);
     AddCommand('float-min', float_min);
     AddCommand('float-max', float_max);
     AddCommand('float-minmax', float_minmax);
     AddCommand('float.', float_dot);
     AddCommand('float$', float_dollar);
     AddCommand('float+!', float_ptr_plus_exclamation);
     AddCommand('float->str', float_conv_to_str);
     AddCommand('str->float', float_conv_from_str);
    
    
     AddCommand('double+', double_plus);
     AddCommand('double-', double_minus);
     AddCommand('double*', double_star);
     AddCommand('double=', double_equel);
     AddCommand('double<>', double_nequel);
     AddCommand('double<', double_lt);
     AddCommand('double>', double_gt);
     AddCommand('double<=', double_lte);
     AddCommand('double>=', double_gte);
     AddCommand('double-0=', double_0_equel);
     AddCommand('double-0<>', double_0_nequel);
     AddCommand('double-0<', double_0_lt);
     AddCommand('double-0>', double_0_gt);
     AddCommand('double-0<=', double_0_lte);
     AddCommand('double-0>=', double_0_gte);
     AddCommand('double-?dup', double_ask_dup);
     addcommand('double-0;', double_0_exit);
     addcommand('double-if;', double_if_exit);
     AddCommand('double-min', double_min);
     AddCommand('double-max', double_max);
     AddCommand('double-minmax', double_minmax);
     AddCommand('double.', double_dot);
     AddCommand('double$', double_dollar);
     AddCommand('double+!', double_ptr_plus_exclamation);
     AddCommand('double->str', double_conv_to_str);
     AddCommand('str->double', double_conv_from_str);
    
    
     AddCommand('extended+', extended_plus);
     AddCommand('extended-', extended_minus);
     AddCommand('extended*', extended_star);
     AddCommand('extended=', extended_equel);
     AddCommand('extended<>', extended_nequel);
     AddCommand('extended<', extended_lt);
     AddCommand('extended>', extended_gt);
     AddCommand('extended<=', extended_lte);
     AddCommand('extended>=', extended_gte);
     AddCommand('extended-0=', extended_0_equel);
     AddCommand('extended-0<>', extended_0_nequel);
     AddCommand('extended-0<', extended_0_lt);
     AddCommand('extended-0>', extended_0_gt);
     AddCommand('extended-0<=', extended_0_lte);
     AddCommand('extended-0>=', extended_0_gte);
     AddCommand('extended-?dup', extended_ask_dup);
     addcommand('extended-0;', extended_0_exit);
     addcommand('extended-if;', extended_if_exit);
     AddCommand('extended-min', extended_min);
     AddCommand('extended-max', extended_max);
     AddCommand('extended-minmax', extended_minmax);
     AddCommand('extended.', extended_dot);
     AddCommand('extended$', extended_dollar);
     AddCommand('extended+!', extended_ptr_plus_exclamation);
     AddCommand('extended->str', extended_conv_to_str);
     AddCommand('str->extended', extended_conv_from_str);
    
    AddCommand('abs', _abs);
     AddCommand('neg', _neg);
    
    AddCommand('int-abs', int_abs);
     AddCommand('int-neg', int_neg);
    
    AddCommand('int8-abs', int8_abs);
     AddCommand('int8-neg', int8_neg);
    
    AddCommand('int16-abs', int16_abs);
     AddCommand('int16-neg', int16_neg);
    
    AddCommand('int32-abs', int32_abs);
     AddCommand('int32-neg', int32_neg);
    
    AddCommand('int64-abs', int64_abs);
     AddCommand('int64-neg', int64_neg);
    
    AddCommand('float-abs', float_abs);
     AddCommand('float-neg', float_neg);
    
    AddCommand('double-abs', double_abs);
     AddCommand('double-neg', double_neg);
    
    
     AddCommand('-push', _push, True);
     AddCommand('run@-push', _run_push);
     AddCommand('inc', _1_plus);
     AddCommand('dec', _1_minus);
     AddCommand('1+', _1_plus);
     AddCommand('1-', _1_minus);
     AddCommand('inc!', _ptr_inc);
     AddCommand('dec!', _ptr_dec);
     AddCommand('1+!', _ptr_inc);
     AddCommand('1-!', _ptr_dec);
     AddCommand('div', _div);
     AddCommand('mod', _mod);
     AddCommand('divmod', _divmod);
     AddCommand('shl', _shl);
     AddCommand('shr', _shr);
     AddCommand('**', _power);
    
    
     AddCommand('int-push', int_push, True);
     AddCommand('run@int-push', int_run_push);
     AddCommand('int-inc', int_1_plus);
     AddCommand('int-dec', int_1_minus);
     
     
     AddCommand('int-inc!', int_ptr_inc);
     AddCommand('int-dec!', int_ptr_dec);
     
     
     AddCommand('int-div', int_div);
     AddCommand('int-mod', int_mod);
     AddCommand('int-divmod', int_divmod);
     AddCommand('int-shl', int_shl);
     AddCommand('int-shr', int_shr);
     AddCommand('int-**', int_power);
    
    
     AddCommand('int8-push', int8_push, True);
     AddCommand('run@int8-push', int8_run_push);
     AddCommand('int8-inc', int8_1_plus);
     AddCommand('int8-dec', int8_1_minus);
     
     
     AddCommand('int8-inc!', int8_ptr_inc);
     AddCommand('int8-dec!', int8_ptr_dec);
     
     
     AddCommand('int8-div', int8_div);
     AddCommand('int8-mod', int8_mod);
     AddCommand('int8-divmod', int8_divmod);
     AddCommand('int8-shl', int8_shl);
     AddCommand('int8-shr', int8_shr);
     AddCommand('int8-**', int8_power);
    
    
     AddCommand('int16-push', int16_push, True);
     AddCommand('run@int16-push', int16_run_push);
     AddCommand('int16-inc', int16_1_plus);
     AddCommand('int16-dec', int16_1_minus);
     
     
     AddCommand('int16-inc!', int16_ptr_inc);
     AddCommand('int16-dec!', int16_ptr_dec);
     
     
     AddCommand('int16-div', int16_div);
     AddCommand('int16-mod', int16_mod);
     AddCommand('int16-divmod', int16_divmod);
     AddCommand('int16-shl', int16_shl);
     AddCommand('int16-shr', int16_shr);
     AddCommand('int16-**', int16_power);
    
    
     AddCommand('int32-push', int32_push, True);
     AddCommand('run@int32-push', int32_run_push);
     AddCommand('int32-inc', int32_1_plus);
     AddCommand('int32-dec', int32_1_minus);
     
     
     AddCommand('int32-inc!', int32_ptr_inc);
     AddCommand('int32-dec!', int32_ptr_dec);
     
     
     AddCommand('int32-div', int32_div);
     AddCommand('int32-mod', int32_mod);
     AddCommand('int32-divmod', int32_divmod);
     AddCommand('int32-shl', int32_shl);
     AddCommand('int32-shr', int32_shr);
     AddCommand('int32-**', int32_power);
    
    
     AddCommand('int64-push', int64_push, True);
     AddCommand('run@int64-push', int64_run_push);
     AddCommand('int64-inc', int64_1_plus);
     AddCommand('int64-dec', int64_1_minus);
     
     
     AddCommand('int64-inc!', int64_ptr_inc);
     AddCommand('int64-dec!', int64_ptr_dec);
     
     
     AddCommand('int64-div', int64_div);
     AddCommand('int64-mod', int64_mod);
     AddCommand('int64-divmod', int64_divmod);
     AddCommand('int64-shl', int64_shl);
     AddCommand('int64-shr', int64_shr);
     AddCommand('int64-**', int64_power);
    
    
     AddCommand('uint-push', uint_push, True);
     AddCommand('run@uint-push', uint_run_push);
     AddCommand('uint-inc', uint_1_plus);
     AddCommand('uint-dec', uint_1_minus);
     
     
     AddCommand('uint-inc!', uint_ptr_inc);
     AddCommand('uint-dec!', uint_ptr_dec);
     
     
     AddCommand('uint-div', uint_div);
     AddCommand('uint-mod', uint_mod);
     AddCommand('uint-divmod', uint_divmod);
     AddCommand('uint-shl', uint_shl);
     AddCommand('uint-shr', uint_shr);
     AddCommand('uint-**', uint_power);
    
    
     AddCommand('uint8-push', uint8_push, True);
     AddCommand('run@uint8-push', uint8_run_push);
     AddCommand('uint8-inc', uint8_1_plus);
     AddCommand('uint8-dec', uint8_1_minus);
     
     
     AddCommand('uint8-inc!', uint8_ptr_inc);
     AddCommand('uint8-dec!', uint8_ptr_dec);
     
     
     AddCommand('uint8-div', uint8_div);
     AddCommand('uint8-mod', uint8_mod);
     AddCommand('uint8-divmod', uint8_divmod);
     AddCommand('uint8-shl', uint8_shl);
     AddCommand('uint8-shr', uint8_shr);
     AddCommand('uint8-**', uint8_power);
    
    
     AddCommand('uint16-push', uint16_push, True);
     AddCommand('run@uint16-push', uint16_run_push);
     AddCommand('uint16-inc', uint16_1_plus);
     AddCommand('uint16-dec', uint16_1_minus);
     
     
     AddCommand('uint16-inc!', uint16_ptr_inc);
     AddCommand('uint16-dec!', uint16_ptr_dec);
     
     
     AddCommand('uint16-div', uint16_div);
     AddCommand('uint16-mod', uint16_mod);
     AddCommand('uint16-divmod', uint16_divmod);
     AddCommand('uint16-shl', uint16_shl);
     AddCommand('uint16-shr', uint16_shr);
     AddCommand('uint16-**', uint16_power);
    
    
     AddCommand('uint32-push', uint32_push, True);
     AddCommand('run@uint32-push', uint32_run_push);
     AddCommand('uint32-inc', uint32_1_plus);
     AddCommand('uint32-dec', uint32_1_minus);
     
     
     AddCommand('uint32-inc!', uint32_ptr_inc);
     AddCommand('uint32-dec!', uint32_ptr_dec);
     
     
     AddCommand('uint32-div', uint32_div);
     AddCommand('uint32-mod', uint32_mod);
     AddCommand('uint32-divmod', uint32_divmod);
     AddCommand('uint32-shl', uint32_shl);
     AddCommand('uint32-shr', uint32_shr);
     AddCommand('uint32-**', uint32_power);
    
    
     AddCommand('uint64-push', uint64_push, True);
     AddCommand('run@uint64-push', uint64_run_push);
     AddCommand('uint64-inc', uint64_1_plus);
     AddCommand('uint64-dec', uint64_1_minus);
     
     
     AddCommand('uint64-inc!', uint64_ptr_inc);
     AddCommand('uint64-dec!', uint64_ptr_dec);
     
     
     AddCommand('uint64-div', uint64_div);
     AddCommand('uint64-mod', uint64_mod);
     AddCommand('uint64-divmod', uint64_divmod);
     AddCommand('uint64-shl', uint64_shl);
     AddCommand('uint64-shr', uint64_shr);
     AddCommand('uint64-**', uint64_power);
    
    AddCommand('int->int8', int_convert_to_int8);
    
    AddCommand('int->int16', int_convert_to_int16);
    
    AddCommand('int->int32', int_convert_to_int32);
    
    AddCommand('int->int64', int_convert_to_int64);
    
    AddCommand('int8->int', int8_convert_to_int);
    
    AddCommand('int16->int', int16_convert_to_int);
    
    AddCommand('int32->int', int32_convert_to_int);
    
    AddCommand('int64->int', int64_convert_to_int);
    
    AddCommand('uint->uint8', uint_convert_to_uint8);
    
    AddCommand('uint->uint16', uint_convert_to_uint16);
    
    AddCommand('uint->uint32', uint_convert_to_uint32);
    
    AddCommand('uint->uint64', uint_convert_to_uint64);
    
    AddCommand('uint8->uint', uint8_convert_to_uint);
    
    AddCommand('uint16->uint', uint16_convert_to_uint);
    
    AddCommand('uint32->uint', uint32_convert_to_uint);
    
    AddCommand('uint64->uint', uint64_convert_to_uint);
    
    AddCommand('float->double', float_convert_to_double);
    
    AddCommand('double->float', double_convert_to_float);
    
    AddCommand('float->extended', float_convert_to_extended);
    
    AddCommand('double->extended', double_convert_to_extended);
    
    AddCommand('extended->double', extended_convert_to_double);
    
    AddCommand('extended->float', extended_convert_to_float);
    
    AddCommand('int->float', int_convert_to_float);
    
    AddCommand('int->double', int_convert_to_double);
    
    AddCommand('int->extended', int_convert_to_extended);
    
    
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
  //FMemoryDebug.Free;
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
  RUP(Self.S);
  RUI(SC);
  RUP(RB);
  Self.S := Line;
  //Self.SB := Line;
  Self.SC := 0;
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
  SC := ROI;
  Self.S  := ROP;
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

procedure Evaluate(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  S := str_pop(Machine);
  Machine.Interpret(PChar(@(PStrRec(S)^.Sym[0])));
  DelRef(S);
end;

procedure EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
var
  //F: File of Byte;
  F: TextFile;
  S: TStr;
  //B: array of Byte;
  B: TString;
  T: TString;
  FullPath: TString;
  ShortPath: TString;
begin
  S := str_pop(Machine);
  ShortPath := TString(PChar(@(PStrRec(S)^.Sym[0])));
  FullPath := '';
  while True do begin
    if Length(Machine.Directories) > 0 then begin
      FullPath := Machine.Directories[High(Machine.Directories)] + ShortPath;
      if FileExists(FullPath) then 
        Break;
    end;
    FullPath := PChar(GetCurrentDirectory) + '\' + ShortPath;
    if FileExists(FullPath) then 
      Break;
    FullPath := PChar(GetExeDirectory) + '\' + ShortPath;
    if FileExists(FullPath) then 
      Break;
    Exit;
  end;
  SetLength(Machine.Directories, Length(Machine.Directories) + 1);
  Machine.Directories[High(Machine.Directories)] := GetDirectory(FullPath);
  DelRef(S);
  Machine.InterpretFile(FullPath);
  SetLength(Machine.Directories, Length(Machine.Directories) - 1);
  (* // Writeln('Evaluate file "', PChar(@(PStrRec(S)^.Sym[0])), '"'); *)
  (* if Length(Machine.Directories) > 0 then begin *)
  (*   FullPath := Machine.Directories[High(Machine.Directories)] + ShortPath;  *)
  (*   Assign(F, FullPath); *)
  (*   {$I-} *)
  (*   Reset(F); *)
  (*   {$I+} *)
  (* end; *)
  (* if (Length(Machine.Directories) = 0) or (IOResult <> 0) then begin *)
  (*   FullPath := PChar(GetCurrentDirectory) + '\\' + ShortPath; *)
  (*   Assign(F, FullPath); *)
  (*   {$I-} *)
  (*   Reset(F); *)
  (*   {$I+} *)
  (*   if IOResult <> 0 then begin *)
  (*     FullPath := PChar(GetExeDirectory) + '\\' + ShortPath; *)
  (*     Assign(F, FullPath); *)
  (*     {$I-} *)
  (*     Reset(F); *)
  (*     {$I+} *)
  (*     if IOResult <> 0 then begin *)
  (*       Machine.LogError('cannot open file "' + ShortPath + '"'); *)
  (*       Exit; *)
  (*     end; *)
  (*   end; *)
  (* end; *)
  (* B := TString(PChar(@(PStrRec(S)^.Sym[0]))); *)
  (* while (Length(B) > 0) and (B[Length(B)] <> '\\') do begin *)
  (*   SetLength(B, Length(B) - 1); *)
  (* end; *)
  (* SetLength(Machine.Directories, Length(Machine.Directories) + 1); *)
  (* Machine.Directories[High(Machine.Directories)] := B; *)
  (* B := ''; *)
  (* while not EOF(F) do begin *)
  (*   Readln(F, T); *)
  (*   B := B + T + EOL; *)
  (* end; *)
  (* Close(F); *)
  (* Machine.Interpret(PChar(B)); *)
  (* DelRef(S); *)
  (* SetLength(Machine.Directories, Length(Machine.Directories) - 1); *)
  // Writeln('End of evaluate file "', PChar(@S^.Sym[0]), '"');
end;

procedure OForthMachine.CallCommand(Command: PForthCommand);
begin
  if Command = nil then
    Exit;
  // Writeln('Call command ', Command^.Name);
  RUI(Ord(FSession) * BOOL_TRUE);
  RUI(Ord(FRunning) * BOOL_TRUE);
  RUI(EC);
  RUP(S);
  RUI(SC);
  RUP(RB);
  RUP(RP);
  S := '';
  SC := 0;
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
  SC := ROI;
  S := ROP;
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

procedure OForthMachine.CompileError(const S: TString);
begin
  Error('Compile(' + InternalFileName(FCurrentFileName) + ', ' +
                     IntToStr(FCurrentLine) + ', ' +
                     IntToStr(FCurrentPos) + '): ' + S);
  FCompilation := False;
end;

procedure OForthMachine.CompileWarring(const S: TString);
begin
  Warrning(' Compilation: "' + S + '"');
end;

procedure OForthMachine.LogError(const S: TString);
begin
  if State = FS_COMPILE then
    CompileError(S)
  else
    RunError(S);
end;

function OForthMachine.NextChar: TChar;
begin
  Result := SNC;
  {if EOS then
    Result := #0
  else begin
    Result := FSource[FCurrentChar];
    Inc(FCurrentChar);
  end;}
end;

function OForthMachine.NextName: TString;
begin
  Result := SNN;
  {Result := '';
  repeat
    C := NextChar;
  until (not (C in [#0..#32])) or EOS;
  repeat
    Result := Result + C;
    if EOS then
      Exit;
    C := NextChar;
  until (C in [#0..#32]) or EOS;
  if not (C in [#0..#32]) then
    Result := Result + C;}
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
var
  Temp: Integer;
begin
  Temp := SC;
  Result := NextName(S, Temp);
end;

function OForthMachine.EOS: Boolean; // end of source
begin
  Result := SE;
  //Result := FSource[FCurrentChar] = #0;
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
var
  I: Integer;
begin
  FLastMnemonic := -1;
  {{for I := 0 to High(C) do
    if TString(C[I].Name) = Name then begin
      Result := C[I];
      FLastMnemonic := I;
      Break;
    end;}
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

procedure _align(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin with Machine^ do begin I := WOI;
  if I mod 4 = 0 then
    WUI(I)
  else
    WUI(I + 4 - (I mod 4))
 end; end;

procedure _palign(Machine: TForthMachine; Command: PForthCommand);
begin
  _align(Machine, Command);
end;

procedure _poststr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(@ConvStr) end; end;
procedure _postname (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(@ConvName) end; end;

procedure _raw_2_unicode (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(4, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 4, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

procedure _utf8_2_unicode (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
  Len, U: Integer;
  P: Pointer;
begin
  B := str_pop(Machine);
  C := CreateStr(4, B^.Len);
  Len := 0;
  P := @B^.Sym[0];
  while TUInt(P) < TUInt(@B^.Sym[B^.Len]) do
    if not ReadUTF8Char(P, U) then
      Break
    else begin
      PArrayOfCardinal(@C^.Sym[0])^[Len] := U;
      Inc(Len);
      // Write(Char(U));
    end;
  // Writeln;
  C^.Len := Len;
  DelRef(B);
  str_push(Machine, C);
end;

procedure _utf8_2_raw (Machine: TForthMachine; Command: PForthCommand);
begin with Machine^ do begin  end; end;

procedure _unicode_2_utf8 (Machine: TForthMachine; Command: PForthCommand);
begin with Machine^ do begin  end; end;

procedure _unicode_2_raw (Machine: TForthMachine; Command: PForthCommand);
var
  B, C: TStr;
begin
  B := str_pop(Machine);
  C := CreateStr(1, B^.Len);
  MoveChars(@C^.Sym[0], @B^.Sym[0], B^.Len, 1, B^.Width);
  DelRef(B);
  str_push(Machine, C);
end;

procedure _randomize (Machine: TForthMachine; Command: PForthCommand);
begin
  Randomize;
end;

procedure _random (Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(Random(Machine.WOI));
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
  (* I := High(Context); *)
  (* while I >= 0 do *)
  (*   if Context[I] <> nil then begin *)
  (*     if Context[I].sFIND = -1 then *)
  (*       Dec(I) *)
  (*     else *)
  (*       Break; *)
  (*   end else *)
  (*     Dec(I); *)
  (* // Writeln('I = ', I); *)
  (* if I <> -1 then begin *)
  (*   WUS(Name); *)
  (*   CallCommand(C[Context[I].sFIND]); *)
  (*   if WOI = 0 then begin *)
  (*     if Index <> nil then begin *)
  (*       Index^ := WOI; *)
  (*       Result := C[Index^]; *)
  (*     end else *)
  (*       Result := C[WOI]; *)
  (*   end else begin *)
  (*     Result := nil; *)
  (*   end; *)
  (* end else *)
  (*   Result := nil; *)
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
     
    
     
         procedure drop_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_ptr (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_ptr (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_ptr (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_ptr(Machine, Command) else _interpret_to_ptr(Machine, Command);  end; end;
     procedure _compile_to_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@ptr-to'); EWO(NextName);  end; end;
     procedure _run_to_ptr (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_ptr (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after ptr-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_ptr; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('ptr-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_int (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_int (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_int (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_int (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int(Machine, Command) else _interpret_to_int(Machine, Command);  end; end;
     procedure _compile_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int-to'); EWO(NextName);  end; end;
     procedure _run_to_int (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_int (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1); Inc(WP, 1);  end; end;
         procedure nip_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int8 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
      end; end;
     procedure rrot_int8 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
      end; end;
     procedure lrotn_int8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-1*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-1*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-1))^), 1);
      end; end;
     procedure rrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-1*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*1))^), 1);
      end; end;
     procedure pick_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
      end; end;
     procedure _comma_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 1); EWV(WP, 1);   end; end;
     procedure _dog_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1)  end; end;
     procedure ptr_plus_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 1;  end; end;
     procedure _to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int8(Machine, Command) else _interpret_to_int8(Machine, Command);  end; end;
     procedure _compile_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int8-to'); EWO(NextName);  end; end;
     procedure _run_to_int8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1);  end; end;
     procedure _interpret_to_int8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-1))^), Comm.Data^, 1); Dec(WP, 1);
              end; end;
     procedure _value_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int8; Move((Pointer(TUInt(Machine.WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end;  end; end;
     procedure RunValue_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 1); Inc(WP, 1);  end; end;
    procedure literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int8-(literal)'); Dec(WP, 1); 
                                       EWV(WP, 1);  end; end;
    procedure run_literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 1); Inc(WP, 1);  end; end;
    
   
    
     
         procedure drop_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2); Inc(WP, 2);  end; end;
         procedure nip_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int16 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
      end; end;
     procedure rrot_int16 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
      end; end;
     procedure lrotn_int16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-2*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-2*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-2))^), 2);
      end; end;
     procedure rrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-2*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*2))^), 2);
      end; end;
     procedure pick_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
      end; end;
     procedure _comma_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 2); EWV(WP, 2);   end; end;
     procedure _dog_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2)  end; end;
     procedure ptr_plus_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 2;  end; end;
     procedure _to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int16(Machine, Command) else _interpret_to_int16(Machine, Command);  end; end;
     procedure _compile_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int16-to'); EWO(NextName);  end; end;
     procedure _run_to_int16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2);  end; end;
     procedure _interpret_to_int16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-2))^), Comm.Data^, 2); Dec(WP, 2);
              end; end;
     procedure _value_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int16; Move((Pointer(TUInt(Machine.WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end;  end; end;
     procedure RunValue_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 2); Inc(WP, 2);  end; end;
    procedure literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int16-(literal)'); Dec(WP, 2); 
                                       EWV(WP, 2);  end; end;
    procedure run_literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 2); Inc(WP, 2);  end; end;
    
   
    
     
         procedure drop_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int32 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_int32 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_int32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int32(Machine, Command) else _interpret_to_int32(Machine, Command);  end; end;
     procedure _compile_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int32-to'); EWO(NextName);  end; end;
     procedure _run_to_int32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_int32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int32; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int32-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_int64 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_int64 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_int64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_int64(Machine, Command) else _interpret_to_int64(Machine, Command);  end; end;
     procedure _compile_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int64-to'); EWO(NextName);  end; end;
     procedure _run_to_int64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_int64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after int64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int64; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('int64-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_uint (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_uint (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_uint (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint(Machine, Command) else _interpret_to_uint(Machine, Command);  end; end;
     procedure _compile_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint-to'); EWO(NextName);  end; end;
     procedure _run_to_uint (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_uint (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1); Inc(WP, 1);  end; end;
         procedure nip_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint8 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
      end; end;
     procedure rrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(Machine.WP) + (-2*1))^), (Pointer(TUInt(Machine.WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (-3*1))^), (Pointer(TUInt(Machine.WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*1))^), 1);
      end; end;
     procedure lrotn_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-1*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-1*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-1))^), 1);
      end; end;
     procedure rrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-1))^), (Pointer(TUInt(Machine.WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-1*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*1))^), 1);
      end; end;
     procedure pick_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
      end; end;
     procedure _comma_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 1); EWV(WP, 1);   end; end;
     procedure _dog_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1)  end; end;
     procedure ptr_plus_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 1;  end; end;
     procedure _to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint8(Machine, Command) else _interpret_to_uint8(Machine, Command);  end; end;
     procedure _compile_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint8-to'); EWO(NextName);  end; end;
     procedure _run_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1);  end; end;
     procedure _interpret_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-1))^), Comm.Data^, 1); Dec(WP, 1);
              end; end;
     procedure _value_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint8; Move((Pointer(TUInt(Machine.WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end;  end; end;
     procedure RunValue_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 1); Inc(WP, 1);  end; end;
    procedure literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint8-(literal)'); Dec(WP, 1); 
                                       EWV(WP, 1);  end; end;
    procedure run_literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 1); Inc(WP, 1);  end; end;
    
   
    
     
         procedure drop_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2); Inc(WP, 2);  end; end;
         procedure nip_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint16 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
      end; end;
     procedure rrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(Machine.WP) + (-2*2))^), (Pointer(TUInt(Machine.WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (-3*2))^), (Pointer(TUInt(Machine.WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*2))^), 2);
      end; end;
     procedure lrotn_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-2*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-2*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-2))^), 2);
      end; end;
     procedure rrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-2))^), (Pointer(TUInt(Machine.WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-2*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*2))^), 2);
      end; end;
     procedure pick_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
      end; end;
     procedure _comma_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 2); EWV(WP, 2);   end; end;
     procedure _dog_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2)  end; end;
     procedure ptr_plus_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 2;  end; end;
     procedure _to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint16(Machine, Command) else _interpret_to_uint16(Machine, Command);  end; end;
     procedure _compile_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint16-to'); EWO(NextName);  end; end;
     procedure _run_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2);  end; end;
     procedure _interpret_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-2))^), Comm.Data^, 2); Dec(WP, 2);
              end; end;
     procedure _value_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint16; Move((Pointer(TUInt(Machine.WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end;  end; end;
     procedure RunValue_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 2); Inc(WP, 2);  end; end;
    procedure literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint16-(literal)'); Dec(WP, 2); 
                                       EWV(WP, 2);  end; end;
    procedure run_literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 2); Inc(WP, 2);  end; end;
    
   
    
     
         procedure drop_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint32 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint32(Machine, Command) else _interpret_to_uint32(Machine, Command);  end; end;
     procedure _compile_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint32-to'); EWO(NextName);  end; end;
     procedure _run_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint32; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint32-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_uint64 (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_uint64(Machine, Command) else _interpret_to_uint64(Machine, Command);  end; end;
     procedure _compile_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint64-to'); EWO(NextName);  end; end;
     procedure _run_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after uint64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint64; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('uint64-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_embro (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_embro (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_embro (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_embro (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_embro (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_embro(Machine, Command) else _interpret_to_embro(Machine, Command);  end; end;
     procedure _compile_to_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@embro-to'); EWO(NextName);  end; end;
     procedure _run_to_embro (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_embro (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after embro-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_embro; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('embro-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_embro (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4); Inc(WP, 4);  end; end;
         procedure nip_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_float (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_float (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_float (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
      end; end;
     procedure rrot_float (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(Machine.WP) + (-2*4))^), (Pointer(TUInt(Machine.WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (-3*4))^), (Pointer(TUInt(Machine.WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*4))^), 4);
      end; end;
     procedure lrotn_float (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-4*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-4*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-4))^), 4);
      end; end;
     procedure rrotn_float (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-4))^), (Pointer(TUInt(Machine.WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-4*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*4))^), 4);
      end; end;
     procedure pick_float (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
      end; end;
     procedure _comma_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 4); EWV(WP, 4);   end; end;
     procedure _dog_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4)  end; end;
     procedure ptr_plus_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 4;  end; end;
     procedure _to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_float(Machine, Command) else _interpret_to_float(Machine, Command);  end; end;
     procedure _compile_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@float-to'); EWO(NextName);  end; end;
     procedure _run_to_float (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4);  end; end;
     procedure _interpret_to_float (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after float-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-4))^), Comm.Data^, 4); Dec(WP, 4);
              end; end;
     procedure _value_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_float; Move((Pointer(TUInt(Machine.WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end;  end; end;
     procedure _variable_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end;  end; end;
     procedure RunValue_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 4); Inc(WP, 4);  end; end;
    procedure literal_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('float-(literal)'); Dec(WP, 4); 
                                       EWV(WP, 4);  end; end;
    procedure run_literal_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 4); Inc(WP, 4);  end; end;
    
   
    
     
         procedure drop_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8); Inc(WP, 8);  end; end;
         procedure nip_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_double (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_double (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_double (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
      end; end;
     procedure rrot_double (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(Machine.WP) + (-2*8))^), (Pointer(TUInt(Machine.WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (-3*8))^), (Pointer(TUInt(Machine.WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*8))^), 8);
      end; end;
     procedure lrotn_double (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-8*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-8*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-8))^), 8);
      end; end;
     procedure rrotn_double (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-8))^), (Pointer(TUInt(Machine.WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-8*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*8))^), 8);
      end; end;
     procedure pick_double (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
      end; end;
     procedure _comma_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 8); EWV(WP, 8);   end; end;
     procedure _dog_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8)  end; end;
     procedure ptr_plus_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 8;  end; end;
     procedure _to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_double(Machine, Command) else _interpret_to_double(Machine, Command);  end; end;
     procedure _compile_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@double-to'); EWO(NextName);  end; end;
     procedure _run_to_double (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8);  end; end;
     procedure _interpret_to_double (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after double-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-8))^), Comm.Data^, 8); Dec(WP, 8);
              end; end;
     procedure _value_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_double; Move((Pointer(TUInt(Machine.WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end;  end; end;
     procedure _variable_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end;  end; end;
     procedure RunValue_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 8); Inc(WP, 8);  end; end;
    procedure literal_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('double-(literal)'); Dec(WP, 8); 
                                       EWV(WP, 8);  end; end;
    procedure run_literal_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 8); Inc(WP, 8);  end; end;
    
   
    
     
         procedure drop_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           sub [eax],4
         end;
         {procedure dup_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           mov [ecx],edx
           add [eax],4
         end;}
         procedure dup_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-10))^), (Pointer(TUInt(Machine.WP) + (0))^), 10); Inc(WP, 10);  end; end;
         procedure nip_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           lea ecx,[ecx-4]
           mov edx,[ecx]
           mov [ecx-4],edx
           mov [eax],ecx
         end;
         procedure swap_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-4]
           xchg [ecx-8],edx
           mov [ecx-4],edx
         end;
         procedure over_extended (Machine: TForthMachine; Command: PForthCommand);
         asm
           mov ecx,[eax]
           mov edx,[ecx-8]
           mov [ecx],edx
           add [eax],4
         end;
         procedure tuck_extended (Machine: TForthMachine; Command: PForthCommand);
         asm // ab-bab  @wp=eax 
           mov ecx,[eax]       // ecx := wp 
           add [eax],4         // @wp++
           mov edx,[ecx-4]     // edx := b
           mov [ecx],edx       // top := b
           mov eax,[ecx-8]     // eax := a
           mov [ecx-4],eax     // top[1] := a
           mov [ecx-8],edx     // top[2] := b
         end;
       
     procedure lrot_extended (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*10))^), WP^, 10);
       Move((Pointer(TUInt(Machine.WP) + (-3*10))^), (Pointer(TUInt(Machine.WP) + (-1*10))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (-2*10))^), (Pointer(TUInt(Machine.WP) + (-3*10))^), 10);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-2*10))^), 10);
      end; end;
     procedure rrot_extended (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-1*10))^), WP^, 10);
       Move((Pointer(TUInt(Machine.WP) + (-2*10))^), (Pointer(TUInt(Machine.WP) + (-1*10))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (-3*10))^), (Pointer(TUInt(Machine.WP) + (-2*10))^), 10);
       Move(WP^, (Pointer(TUInt(Machine.WP) + (-3*10))^), 10);
      end; end;
     procedure lrotn_extended (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(Machine.WP) + (-10*N))^), (Pointer(TUInt(Machine.WP) + (0))^), 10);
       while N > 0 do begin
         Move((Pointer(TUInt(Machine.WP) + (-10*(N-1)))^), (Pointer(TUInt(Machine.WP) + (-10*N))^), 10);
         Dec(N);
       end;
       //Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-10))^), 10);
      end; end;
     procedure rrotn_extended (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin with Machine^ do begin Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(Machine.WP) + (-10))^), (Pointer(TUInt(Machine.WP) + (0))^), 10);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(Machine.WP) + (-10*(I+1)))^), (Pointer(TUInt(Machine.WP) + (-10*I))^), 10);
       Move((Pointer(TUInt(Machine.WP) + (0))^), (Pointer(TUInt(Machine.WP) + (-N*10))^), 10);
      end; end;
     procedure pick_extended (Machine: TForthMachine; Command: PForthCommand); 
     begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt) -10*TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^),
            10);
       Inc(WP, 10 - SizeOf(TInt));
      end; end;
     procedure _comma_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, 10); EWV(WP, 10);   end; end;
     procedure _dog_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^), 10); Inc(WP, 10 - (SizeOf(Pointer)))  end; end;
     procedure _exclamation_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))-10))^), Pointer((Pointer(TUInt(Machine.WP) + (-(SizeOf(Pointer))))^))^, 10); Dec(WP, (SizeOf(Pointer)) + 10)  end; end;
     procedure ptr_plus_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^)) + 10;  end; end;
     procedure _to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State <> FS_INTERPRET then _compile_to_extended(Machine, Command) else _interpret_to_extended(Machine, Command);  end; end;
     procedure _compile_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@extended-to'); EWO(NextName);  end; end;
     procedure _run_to_extended (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin with Machine^ do begin O := ERO; Move((Pointer(TUInt(Machine.WP) + (-10))^), C[O].Data^, 10); Dec(WP, 10);  end; end;
     procedure _interpret_to_extended (Machine: TForthMachine; Command: PForthCommand); var N: TString; Comm: PForthCommand; begin with Machine^ do begin N := NextName; Comm := FindCommand(N);
               if Comm = nil then begin LogError('unkown name after extended-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(Machine.WP) + (-10))^), Comm.Data^, 10); Dec(WP, 10);
              end; end;
     procedure _value_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_extended; Move((Pointer(TUInt(Machine.WP) + (-10))^), Here^, 10); Dec(WP, 10); EA(10); Flags := Flags and not 1; end;  end; end;
     procedure _variable_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin with ReserveName(SNN)^ do begin Data := Here; Code := PutDataPtr; {Dec(WP, 10); Move(WP^, Here^, 10);} EA(10); end;  end; end;
     procedure RunValue_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Move(Command.Data^, WP^, 10); Inc(WP, 10);  end; end;
    procedure literal_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('extended-(literal)'); Dec(WP, 10); 
                                       EWV(WP, 10);  end; end;
    procedure run_literal_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin ERV(WP, 10); Inc(WP, 10);  end; end;
    
   
    
      procedure _plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure _equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure _0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure _ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end;  end; end;
      procedure _0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure _if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) <> 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure _max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure _min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure _minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
       end; end;
      procedure _dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' ');  end; end;
      procedure _dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt));  end; end;
      procedure _ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt));  end; end;
      procedure _conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)), B);
        Dec(WP, SizeOf(TInt));
        str_push(Machine, B);
       end; end;
      procedure _conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt(WP^), Res);
        Inc(WP, SizeOf(TInt));
        DelRef(B);
       end; end;
    
   
    
      procedure int_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
      procedure int_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt));  end; end;
      procedure int_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt))  end; end;
      procedure int_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end;  end; end;
      procedure int_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure int_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) <> 0 then begin Dec(WP, SizeOf(TInt)); _exit(Machine, Command); end  end; end;
      procedure int_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure int_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
       end; end;
      procedure int_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
       end; end;
      procedure int_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' ');  end; end;
      procedure int_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt));  end; end;
      procedure int_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt));  end; end;
      procedure int_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)), B);
        Dec(WP, SizeOf(TInt));
        str_push(Machine, B);
       end; end;
      procedure int_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt(WP^), Res);
        Inc(WP, SizeOf(TInt));
        DelRef(B);
       end; end;
    
   
    
      procedure int8_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) + TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) - TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) * TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
      procedure int8_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) = TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) <> TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) <= TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) >= TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt));  end; end;
      procedure int8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) = 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <> 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) < 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) > 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) >= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt))  end; end;
      procedure int8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^))) <> 0 then begin TInt8(WP^) := TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)); Inc(WP, SizeOf(TInt8)); end;  end; end;
      procedure int8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) = 0 then begin Dec(WP, SizeOf(TInt8)); _exit(Machine, Command); end  end; end;
      procedure int8_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) <> 0 then begin Dec(WP, SizeOf(TInt8)); _exit(Machine, Command); end  end; end;
      procedure int8_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
       end; end;
      procedure int8_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
       end; end;
      procedure int8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt8)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt8)))^), SizeOf(TInt8));
        end;
       end; end;
      procedure int8_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt8)); Write(TInt8(WP^), ' ');  end; end;
      procedure int8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt8; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt8)); Inc(WP, SizeOf(TInt8));  end; end;
      procedure int8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt8));  end; end;
      procedure int8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)), B);
        Dec(WP, SizeOf(TInt8));
        str_push(Machine, B);
       end; end;
      procedure int8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt8(WP^), Res);
        Inc(WP, SizeOf(TInt8));
        DelRef(B);
       end; end;
    
   
    
      procedure int16_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) + TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) - TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) * TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
      procedure int16_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) = TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) <> TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) <= TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) >= TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt));  end; end;
      procedure int16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) = 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <> 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) < 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) > 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) >= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt))  end; end;
      procedure int16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^))) <> 0 then begin TInt16(WP^) := TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)); Inc(WP, SizeOf(TInt16)); end;  end; end;
      procedure int16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) = 0 then begin Dec(WP, SizeOf(TInt16)); _exit(Machine, Command); end  end; end;
      procedure int16_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) <> 0 then begin Dec(WP, SizeOf(TInt16)); _exit(Machine, Command); end  end; end;
      procedure int16_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
       end; end;
      procedure int16_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
       end; end;
      procedure int16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt16)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt16)))^), SizeOf(TInt16));
        end;
       end; end;
      procedure int16_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt16)); Write(TInt16(WP^), ' ');  end; end;
      procedure int16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt16; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt16)); Inc(WP, SizeOf(TInt16));  end; end;
      procedure int16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt16));  end; end;
      procedure int16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)), B);
        Dec(WP, SizeOf(TInt16));
        str_push(Machine, B);
       end; end;
      procedure int16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt16(WP^), Res);
        Inc(WP, SizeOf(TInt16));
        DelRef(B);
       end; end;
    
   
    
      procedure int32_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) + TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) - TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) * TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
      procedure int32_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) = TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) <> TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) <= TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) >= TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt));  end; end;
      procedure int32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) = 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <> 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) < 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) > 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) >= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt))  end; end;
      procedure int32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^))) <> 0 then begin TInt32(WP^) := TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)); Inc(WP, SizeOf(TInt32)); end;  end; end;
      procedure int32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) = 0 then begin Dec(WP, SizeOf(TInt32)); _exit(Machine, Command); end  end; end;
      procedure int32_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) <> 0 then begin Dec(WP, SizeOf(TInt32)); _exit(Machine, Command); end  end; end;
      procedure int32_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
       end; end;
      procedure int32_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
       end; end;
      procedure int32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt32)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt32)))^), SizeOf(TInt32));
        end;
       end; end;
      procedure int32_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt32)); Write(TInt32(WP^), ' ');  end; end;
      procedure int32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt32; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt32)); Inc(WP, SizeOf(TInt32));  end; end;
      procedure int32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt32));  end; end;
      procedure int32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)), B);
        Dec(WP, SizeOf(TInt32));
        str_push(Machine, B);
       end; end;
      procedure int32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt32(WP^), Res);
        Inc(WP, SizeOf(TInt32));
        DelRef(B);
       end; end;
    
   
    
      procedure int64_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) + TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) - TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) * TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
      procedure int64_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) = TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) <> TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) <= TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) >= TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt));  end; end;
      procedure int64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) = 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <> 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) < 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) > 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) >= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt))  end; end;
      procedure int64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^))) <> 0 then begin TInt64(WP^) := TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)); Inc(WP, SizeOf(TInt64)); end;  end; end;
      procedure int64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) = 0 then begin Dec(WP, SizeOf(TInt64)); _exit(Machine, Command); end  end; end;
      procedure int64_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) <> 0 then begin Dec(WP, SizeOf(TInt64)); _exit(Machine, Command); end  end; end;
      procedure int64_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
       end; end;
      procedure int64_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
       end; end;
      procedure int64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TInt64)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TInt64)))^), SizeOf(TInt64));
        end;
       end; end;
      procedure int64_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TInt64)); Write(TInt64(WP^), ' ');  end; end;
      procedure int64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt64; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TInt64)); Inc(WP, SizeOf(TInt64));  end; end;
      procedure int64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt64));  end; end;
      procedure int64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)), B);
        Dec(WP, SizeOf(TInt64));
        str_push(Machine, B);
       end; end;
      procedure int64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TInt64(WP^), Res);
        Inc(WP, SizeOf(TInt64));
        DelRef(B);
       end; end;
    
   
    
      procedure uint_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) + TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) - TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) * TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
      procedure uint_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) = TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) <> TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) <= TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) >= TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt));  end; end;
      procedure uint_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) = 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <> 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) < 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) > 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) >= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt))  end; end;
      procedure uint_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^))) <> 0 then begin TUInt(WP^) := TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)); Inc(WP, SizeOf(TUInt)); end;  end; end;
      procedure uint_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) = 0 then begin Dec(WP, SizeOf(TUInt)); _exit(Machine, Command); end  end; end;
      procedure uint_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt)); _exit(Machine, Command); end  end; end;
      procedure uint_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
       end; end;
      procedure uint_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
       end; end;
      procedure uint_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt)))^), SizeOf(TUInt));
        end;
       end; end;
      procedure uint_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt)); Write(TUInt(WP^), ' ');  end; end;
      procedure uint_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt)); Inc(WP, SizeOf(TUInt));  end; end;
      procedure uint_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt));  end; end;
      procedure uint_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)), B);
        Dec(WP, SizeOf(TUInt));
        str_push(Machine, B);
       end; end;
      procedure uint_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt(WP^), Res);
        Inc(WP, SizeOf(TUInt));
        DelRef(B);
       end; end;
    
   
    
      procedure uint8_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) + TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) - TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) * TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) = TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) <> TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) <= TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) >= TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt));  end; end;
      procedure uint8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) = 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <> 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) < 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) > 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) >= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt))  end; end;
      procedure uint8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^))) <> 0 then begin TUInt8(WP^) := TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)); Inc(WP, SizeOf(TUInt8)); end;  end; end;
      procedure uint8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) = 0 then begin Dec(WP, SizeOf(TUInt8)); _exit(Machine, Command); end  end; end;
      procedure uint8_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt8)); _exit(Machine, Command); end  end; end;
      procedure uint8_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
       end; end;
      procedure uint8_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
       end; end;
      procedure uint8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt8)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        end;
       end; end;
      procedure uint8_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt8)); Write(TUInt8(WP^), ' ');  end; end;
      procedure uint8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt8; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt8)); Inc(WP, SizeOf(TUInt8));  end; end;
      procedure uint8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt8));  end; end;
      procedure uint8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)), B);
        Dec(WP, SizeOf(TUInt8));
        str_push(Machine, B);
       end; end;
      procedure uint8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt8(WP^), Res);
        Inc(WP, SizeOf(TUInt8));
        DelRef(B);
       end; end;
    
   
    
      procedure uint16_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) + TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) - TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) * TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) = TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) <> TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) <= TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) >= TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt));  end; end;
      procedure uint16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) = 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <> 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) < 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) > 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) >= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt))  end; end;
      procedure uint16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^))) <> 0 then begin TUInt16(WP^) := TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)); Inc(WP, SizeOf(TUInt16)); end;  end; end;
      procedure uint16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) = 0 then begin Dec(WP, SizeOf(TUInt16)); _exit(Machine, Command); end  end; end;
      procedure uint16_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt16)); _exit(Machine, Command); end  end; end;
      procedure uint16_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
       end; end;
      procedure uint16_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
       end; end;
      procedure uint16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt16)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        end;
       end; end;
      procedure uint16_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt16)); Write(TUInt16(WP^), ' ');  end; end;
      procedure uint16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt16; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt16)); Inc(WP, SizeOf(TUInt16));  end; end;
      procedure uint16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt16));  end; end;
      procedure uint16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)), B);
        Dec(WP, SizeOf(TUInt16));
        str_push(Machine, B);
       end; end;
      procedure uint16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt16(WP^), Res);
        Inc(WP, SizeOf(TUInt16));
        DelRef(B);
       end; end;
    
   
    
      procedure uint32_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) + TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) - TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) * TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) = TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) <> TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) <= TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) >= TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt));  end; end;
      procedure uint32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) = 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <> 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) < 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) > 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) >= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt))  end; end;
      procedure uint32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^))) <> 0 then begin TUInt32(WP^) := TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)); Inc(WP, SizeOf(TUInt32)); end;  end; end;
      procedure uint32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) = 0 then begin Dec(WP, SizeOf(TUInt32)); _exit(Machine, Command); end  end; end;
      procedure uint32_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt32)); _exit(Machine, Command); end  end; end;
      procedure uint32_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
       end; end;
      procedure uint32_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
       end; end;
      procedure uint32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt32)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        end;
       end; end;
      procedure uint32_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt32)); Write(TUInt32(WP^), ' ');  end; end;
      procedure uint32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt32; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt32)); Inc(WP, SizeOf(TUInt32));  end; end;
      procedure uint32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt32));  end; end;
      procedure uint32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)), B);
        Dec(WP, SizeOf(TUInt32));
        str_push(Machine, B);
       end; end;
      procedure uint32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt32(WP^), Res);
        Inc(WP, SizeOf(TUInt32));
        DelRef(B);
       end; end;
    
   
    
      procedure uint64_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) + TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) - TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) * TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) = TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) <> TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) <= TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) >= TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt));  end; end;
      procedure uint64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) = 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <> 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) < 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) > 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) >= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt))  end; end;
      procedure uint64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^))) <> 0 then begin TUInt64(WP^) := TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)); Inc(WP, SizeOf(TUInt64)); end;  end; end;
      procedure uint64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) = 0 then begin Dec(WP, SizeOf(TUInt64)); _exit(Machine, Command); end  end; end;
      procedure uint64_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) <> 0 then begin Dec(WP, SizeOf(TUInt64)); _exit(Machine, Command); end  end; end;
      procedure uint64_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
       end; end;
      procedure uint64_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
       end; end;
      procedure uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(TUInt64)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        end;
       end; end;
      procedure uint64_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(TUInt64)); Write(TUInt64(WP^), ' ');  end; end;
      procedure uint64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt64; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt64)); Inc(WP, SizeOf(TUInt64));  end; end;
      procedure uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(TUInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt64));  end; end;
      procedure uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)), B);
        Dec(WP, SizeOf(TUInt64));
        str_push(Machine, B);
       end; end;
      procedure uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), TUInt64(WP^), Res);
        Inc(WP, SizeOf(TUInt64));
        DelRef(B);
       end; end;
    
   
    
      procedure float_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) + Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) - Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) * Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single));  end; end;
      procedure float_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) = Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) <> Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) <= Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) >= Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt));  end; end;
      procedure float_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) = 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <> 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) < 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) > 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) >= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt))  end; end;
      procedure float_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^))) <> 0 then begin Single(WP^) := Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)); Inc(WP, SizeOf(Single)); end;  end; end;
      procedure float_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) = 0 then begin Dec(WP, SizeOf(Single)); _exit(Machine, Command); end  end; end;
      procedure float_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) <> 0 then begin Dec(WP, SizeOf(Single)); _exit(Machine, Command); end  end; end;
      procedure float_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
       end; end;
      procedure float_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
       end; end;
      procedure float_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Single((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Single)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Single)))^), SizeOf(Single));
        end;
       end; end;
      procedure float_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Single)); Write(Single(WP^), ' ');  end; end;
      procedure float_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Single; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Single)); Inc(WP, SizeOf(Single));  end; end;
      procedure float_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Single(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Single)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Single));  end; end;
      procedure float_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)), B);
        Dec(WP, SizeOf(Single));
        str_push(Machine, B);
       end; end;
      procedure float_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Single(WP^), Res);
        Inc(WP, SizeOf(Single));
        DelRef(B);
       end; end;
    
   
    
      procedure double_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) + Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) - Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) * Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double));  end; end;
      procedure double_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) = Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) <> Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) <= Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) >= Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt));  end; end;
      procedure double_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) = 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <> 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) < 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) > 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) >= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt))  end; end;
      procedure double_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^))) <> 0 then begin Double(WP^) := Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)); Inc(WP, SizeOf(Double)); end;  end; end;
      procedure double_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) = 0 then begin Dec(WP, SizeOf(Double)); _exit(Machine, Command); end  end; end;
      procedure double_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) <> 0 then begin Dec(WP, SizeOf(Double)); _exit(Machine, Command); end  end; end;
      procedure double_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
       end; end;
      procedure double_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
       end; end;
      procedure double_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Double((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Double)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Double)))^), SizeOf(Double));
        end;
       end; end;
      procedure double_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Double)); Write(Double(WP^), ' ');  end; end;
      procedure double_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Double; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Double)); Inc(WP, SizeOf(Double));  end; end;
      procedure double_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Double(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Double)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Double));  end; end;
      procedure double_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)), B);
        Dec(WP, SizeOf(Double));
        str_push(Machine, B);
       end; end;
      procedure double_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Double(WP^), Res);
        Inc(WP, SizeOf(Double));
        DelRef(B);
       end; end;
    
   
    
      procedure extended_plus  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) + Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) - Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_star  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) * Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended));  end; end;
      procedure extended_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) = Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) <> Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_lt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_gt (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_lte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) <= Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_gte (Machine: TForthMachine; Command: PForthCommand);   begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) >= Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt));  end; end;
      procedure extended_0_equel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) = 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <> 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_lt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) < 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_gt (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) > 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_lte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_0_gte (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) >= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt))  end; end;
      procedure extended_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if (Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^))) <> 0 then begin Extended(WP^) := Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)); Inc(WP, SizeOf(Extended)); end;  end; end;
      procedure extended_0_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) = 0 then begin Dec(WP, SizeOf(Extended)); _exit(Machine, Command); end  end; end;
      procedure extended_if_exit (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) <> 0 then begin Dec(WP, SizeOf(Extended)); _exit(Machine, Command); end  end; end;
      procedure extended_max (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
       end; end;
      procedure extended_min (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
       end; end;
      procedure extended_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin with Machine^ do begin if Extended((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^)) then begin
          Move((Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-0*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(Machine.WP) + (-0*SizeOf(Extended)))^), (Pointer(TUInt(Machine.WP) + (-1*SizeOf(Extended)))^), SizeOf(Extended));
        end;
       end; end;
      procedure extended_dot (Machine: TForthMachine; Command: PForthCommand);    begin with Machine^ do begin Dec(WP, SizeOf(Extended)); Write(Extended(WP^), ' ');  end; end;
      procedure extended_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Extended; begin with Machine^ do begin Read(Temp); Move(Temp, WP^, SizeOf(Extended)); Inc(WP, SizeOf(Extended));  end; end;
      procedure extended_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := Extended(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)-SizeOf(Extended)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Extended));  end; end;
      procedure extended_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TString;
      begin with Machine^ do begin Str(Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)), B);
        Dec(WP, SizeOf(Extended));
        str_push(Machine, B);
       end; end;
      procedure extended_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        B: TStr;
        Res: Word;
      begin with Machine^ do begin B := str_pop(Machine);
        Val(PChar(@(TStrRec(B^).Sym[0])), Extended(WP^), Res);
        Inc(WP, SizeOf(Extended));
        DelRef(B);
       end; end;
    
   
    procedure _abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)));  end; end;
     procedure _neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));  end; end;
    
   
    procedure int_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)));  end; end;
     procedure int_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));  end; end;
    
   
    procedure int8_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := Abs(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)));  end; end;
     procedure int8_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := - TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^));  end; end;
    
   
    procedure int16_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := Abs(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)));  end; end;
     procedure int16_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := - TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^));  end; end;
    
   
    procedure int32_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := Abs(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)));  end; end;
     procedure int32_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := - TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^));  end; end;
    
   
    procedure int64_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := Abs(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)));  end; end;
     procedure int64_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := - TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^));  end; end;
    
   
    procedure float_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Abs(Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)));  end; end;
     procedure float_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := - Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^));  end; end;
    
   
    procedure double_abs (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Abs(Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)));  end; end;
     procedure double_neg (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := - Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^));  end; end;
    
   
    
     procedure _push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then _compile_push(Machine, Command) else _interpret_push(Machine, Command)  end; end;
     procedure _interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt));  end; end;
     procedure _compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@-push'); EW_(StrToInt(NextName));  end; end;
     procedure _run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := ER_; Inc(WP, SizeOf(TInt));  end; end;
     procedure _1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure _1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure _div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure _mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure _divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (0))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure _shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shl TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure _shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shr TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure _power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure _ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure _ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int_compile_push(Machine, Command) else int_interpret_push(Machine, Command)  end; end;
     procedure int_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt));  end; end;
     procedure int_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int-push'); EW_int(StrToInt(NextName));  end; end;
     procedure int_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt(WP^) := ER_int; Inc(WP, SizeOf(TInt));  end; end;
     procedure int_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure int_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)))  end; end;
     procedure int_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure int_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt));  end; end;
     procedure int_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (0))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shl TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt));
                    TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) shr TInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int8_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int8_compile_push(Machine, Command) else int8_interpret_push(Machine, Command)  end; end;
     procedure int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(WP^) := TInt8(StrToInt(NextName)); Inc(WP, SizeOf(TInt8));  end; end;
     procedure int8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int8-push'); EW_int8(StrToInt(NextName));  end; end;
     procedure int8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8(WP^) := ER_int8; Inc(WP, SizeOf(TInt8));  end; end;
     procedure int8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)))  end; end;
     procedure int8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)))  end; end;
     procedure int8_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
     procedure int8_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8));  end; end;
     procedure int8_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (0))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                     TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^));
                                                     TInt8((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int8_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt8));
                    TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) shl TInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int8_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt8));
                    TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) shr TInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int8_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int16_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int16_compile_push(Machine, Command) else int16_interpret_push(Machine, Command)  end; end;
     procedure int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(WP^) := TInt16(StrToInt(NextName)); Inc(WP, SizeOf(TInt16));  end; end;
     procedure int16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int16-push'); EW_int16(StrToInt(NextName));  end; end;
     procedure int16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16(WP^) := ER_int16; Inc(WP, SizeOf(TInt16));  end; end;
     procedure int16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)))  end; end;
     procedure int16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)))  end; end;
     procedure int16_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
     procedure int16_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16));  end; end;
     procedure int16_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (0))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                     TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^));
                                                     TInt16((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int16_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt16));
                    TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) shl TInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int16_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt16));
                    TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) shr TInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int16_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int32_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int32_compile_push(Machine, Command) else int32_interpret_push(Machine, Command)  end; end;
     procedure int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(WP^) := TInt32(StrToInt(NextName)); Inc(WP, SizeOf(TInt32));  end; end;
     procedure int32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int32-push'); EW_int32(StrToInt(NextName));  end; end;
     procedure int32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32(WP^) := ER_int32; Inc(WP, SizeOf(TInt32));  end; end;
     procedure int32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)))  end; end;
     procedure int32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)))  end; end;
     procedure int32_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
     procedure int32_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32));  end; end;
     procedure int32_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (0))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                     TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^));
                                                     TInt32((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int32_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt32));
                    TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) shl TInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int32_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt32));
                    TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) shr TInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int32_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int64_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then int64_compile_push(Machine, Command) else int64_interpret_push(Machine, Command)  end; end;
     procedure int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(WP^) := TInt64(StrToInt(NextName)); Inc(WP, SizeOf(TInt64));  end; end;
     procedure int64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@int64-push'); EW_int64(StrToInt(NextName));  end; end;
     procedure int64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64(WP^) := ER_int64; Inc(WP, SizeOf(TInt64));  end; end;
     procedure int64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)))  end; end;
     procedure int64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)))  end; end;
     procedure int64_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
     procedure int64_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64));  end; end;
     procedure int64_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (0))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                     TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^));
                                                     TInt64((Pointer(TUInt(Machine.WP) + (-  SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure int64_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt64));
                    TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) shl TInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int64_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TInt64));
                    TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) shr TInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure int64_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure uint_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint_compile_push(Machine, Command) else uint_interpret_push(Machine, Command)  end; end;
     procedure uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(WP^) := TUInt(StrToInt(NextName)); Inc(WP, SizeOf(TUInt));  end; end;
     procedure uint_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint-push'); EW_uint(StrToInt(NextName));  end; end;
     procedure uint_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt(WP^) := ER_uint; Inc(WP, SizeOf(TUInt));  end; end;
     procedure uint_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)))  end; end;
     procedure uint_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)))  end; end;
     procedure uint_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
     procedure uint_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt));  end; end;
     procedure uint_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                     TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^));
                                                     TUInt((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt));
                    TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) shl TUInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt));
                    TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) shr TUInt((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure uint8_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint8_compile_push(Machine, Command) else uint8_interpret_push(Machine, Command)  end; end;
     procedure uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(WP^) := TUInt8(StrToInt(NextName)); Inc(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint8-push'); EW_uint8(StrToInt(NextName));  end; end;
     procedure uint8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8(WP^) := ER_uint8; Inc(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)))  end; end;
     procedure uint8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)))  end; end;
     procedure uint8_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8));  end; end;
     procedure uint8_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                     TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^));
                                                     TUInt8((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint8_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt8));
                    TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) shl TUInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint8_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt8));
                    TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) shr TUInt8((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint8_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure uint16_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint16_compile_push(Machine, Command) else uint16_interpret_push(Machine, Command)  end; end;
     procedure uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(WP^) := TUInt16(StrToInt(NextName)); Inc(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint16-push'); EW_uint16(StrToInt(NextName));  end; end;
     procedure uint16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16(WP^) := ER_uint16; Inc(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)))  end; end;
     procedure uint16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)))  end; end;
     procedure uint16_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16));  end; end;
     procedure uint16_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                     TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^));
                                                     TUInt16((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint16_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt16));
                    TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) shl TUInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint16_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt16));
                    TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) shr TUInt16((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint16_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure uint32_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint32_compile_push(Machine, Command) else uint32_interpret_push(Machine, Command)  end; end;
     procedure uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(WP^) := TUInt32(StrToInt(NextName)); Inc(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint32-push'); EW_uint32(StrToInt(NextName));  end; end;
     procedure uint32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32(WP^) := ER_uint32; Inc(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)))  end; end;
     procedure uint32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)))  end; end;
     procedure uint32_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32));  end; end;
     procedure uint32_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                     TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^));
                                                     TUInt32((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint32_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt32));
                    TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) shl TUInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint32_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt32));
                    TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) shr TUInt32((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint32_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure uint64_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin if State = FS_COMPILE then uint64_compile_push(Machine, Command) else uint64_interpret_push(Machine, Command)  end; end;
     procedure uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(WP^) := TUInt64(StrToInt(NextName)); Inc(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin BuiltinEWO('run@uint64-push'); EW_uint64(StrToInt(NextName));  end; end;
     procedure uint64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64(WP^) := ER_uint64; Inc(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin with Machine^ do begin Inc(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)))  end; end;
     procedure uint64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)))  end; end;
     procedure uint64_div (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_mod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64));  end; end;
     procedure uint64_divmod (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (0))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                     TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^));
                                                     TUInt64((Pointer(TUInt(Machine.WP) + (-  SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (0))^)); 
                                                end; end;
     procedure uint64_shl (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt64));
                    TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) shl TUInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint64_shr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Dec(WP, SizeOf(TUInt64));
                    TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) shr TUInt64((Pointer(TUInt(Machine.WP) + (0))^))  end; end;
     procedure uint64_power (Machine: TForthMachine; Command: PForthCommand); 
     var 
       Power,Base,Value: Cardinal; 
     begin with Machine^ do begin Power := WOI;
       Base := WOI;
       Value := 1;
       while Power > 0 do begin
         if (Power mod 2) > 0 then
           Value := Value * Base;
         Base := Base * Base;
         Power := Power div 2;
       end;
       WUI(Value);
      end; end;
     procedure uint64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
     procedure uint64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin with Machine^ do begin TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(Machine.WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
      end; end;
    
   
    
     procedure int_convert_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt8));  end; end;
    
   
    
     procedure int_convert_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt16));  end; end;
    
   
    
     procedure int_convert_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt32));  end; end;
    
   
    
     procedure int_convert_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt64));  end; end;
    
   
    
     procedure int8_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt8)))^)); 
                                                            Dec(WP, SizeOf(TInt8) - SizeOf(TInt));  end; end;
    
   
    
     procedure int16_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt16)))^)); 
                                                            Dec(WP, SizeOf(TInt16) - SizeOf(TInt));  end; end;
    
   
    
     procedure int32_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt32)))^)); 
                                                            Dec(WP, SizeOf(TInt32) - SizeOf(TInt));  end; end;
    
   
    
     procedure int64_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt64)))^)); 
                                                            Dec(WP, SizeOf(TInt64) - SizeOf(TInt));  end; end;
    
   
    
     procedure uint_convert_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt8));  end; end;
    
   
    
     procedure uint_convert_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt16));  end; end;
    
   
    
     procedure uint_convert_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt32));  end; end;
    
   
    
     procedure uint_convert_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt64));  end; end;
    
   
    
     procedure uint8_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt8)))^)); 
                                                            Dec(WP, SizeOf(TUInt8) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint16_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt16)))^)); 
                                                            Dec(WP, SizeOf(TUInt16) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint32_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt32)))^)); 
                                                            Dec(WP, SizeOf(TUInt32) - SizeOf(TUInt));  end; end;
    
   
    
     procedure uint64_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin TUInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(Machine.WP) + (-SizeOf(TUInt64)))^)); 
                                                            Dec(WP, SizeOf(TUInt64) - SizeOf(TUInt));  end; end;
    
   
    
     procedure float_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Double));  end; end;
    
   
    
     procedure double_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Single));  end; end;
    
   
    
     procedure float_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Extended));  end; end;
    
   
    
     procedure double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Extended));  end; end;
    
   
    
     procedure extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Double));  end; end;
    
   
    
     procedure extended_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Single));  end; end;
    
   
    
     procedure int_convert_to_float (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Single((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Single));  end; end;
    
   
    
     procedure int_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Double((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Double));  end; end;
    
   
    
     procedure int_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin Extended((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(Machine.WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(Extended));  end; end;
    
   
    
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


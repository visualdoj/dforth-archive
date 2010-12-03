unit DForthMachine;

interface

uses
  {$I units.inc},Math,strings,DForthStack;

const
  DFORTHMACHINE_VERSION = 11;


















{$IFNDEF FLAG_FPC}{$REGION 'long commands'}{$ENDIF}

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
  FS_COMPILE                    = $01;
  FS_RUN                        = $02;

  DF_FILE_R                     = $A0;
  DF_FILE_W                     = $A1;

  EOL: String                   = #13;

type
  TForthMachine = class;

  PForthCommand = ^TForthCommand;
  TCode = procedure (Machine: TForthMachine; Command: PForthCommand) of object;
  TForthCommand = record 
          Code: TCode;
          Data: Pointer;
          Flags: Byte;
          Name: PChar; 
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

  TStrRec = record
    Ref: TInt;
    Len: TInt;
    Sym: array[0..1] of TChar;
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

  TWordSpace = record
    C: array of PForthCommand;
    L: Integer;
    S: Integer;
  end;
{$IFNDEF FLAG_FPC}{$REGION 'TReturnStack'}{$ENDIF}
TReturnStack = class(TForthStack)
 public
  procedure ptrpush(P: Pointer);
  function ptrpop: Pointer;
  function ptrgettop: Pointer;
  procedure embropush(P: Cardinal);
  function embropop: Cardinal;
  function embrogettop: Cardinal;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TStackCommands'}{$ENDIF}
TStackCommands = class
 private
  FMachine: TForthMachine;
  FSize: Integer;
  Temp: array of Byte;
 public
  constructor Create(Machine: TForthMachine; Size: Integer);
  procedure push(P: Pointer);
  procedure _push(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_push(Machine: TForthMachine);
  procedure pop(P: Pointer);
  procedure dup(Machine: TForthMachine; Command: PForthCommand);
  procedure drop(Machine: TForthMachine; Command: PForthCommand);
  procedure swap(Machine: TForthMachine; Command: PForthCommand);
  procedure over(Machine: TForthMachine; Command: PForthCommand);
  procedure lrot(Machine: TForthMachine; Command: PForthCommand);
  procedure rrot(Machine: TForthMachine; Command: PForthCommand);
  procedure lrotn(Machine: TForthMachine; Command: PForthCommand);
  procedure rrotn(Machine: TForthMachine; Command: PForthCommand);

  procedure _dog(Machine: TForthMachine; Command: PForthCommand);
  procedure _exclamation(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TBoolCommands'}{$ENDIF}
TBoolCommands = class
 private
  FMachine: TForthMachine;
 public
  constructor Create(Machine: TForthMachine);
  procedure push(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_push(Machine: TForthMachine);
  procedure _false(Machine: TForthMachine; Command: PForthCommand);
  procedure _true(Machine: TForthMachine; Command: PForthCommand);
  procedure _not(Machine: TForthMachine; Command: PForthCommand);
  procedure _or(Machine: TForthMachine; Command: PForthCommand);
  procedure _and(Machine: TForthMachine; Command: PForthCommand);
  procedure _xor(Machine: TForthMachine; Command: PForthCommand);
  procedure _dot(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TConsoleCommands'}{$ENDIF}
TConsoleCommands = class
 private
  FMachine: TForthMachine;
 public
  constructor Create(Machine: TForthMachine);
  procedure cr(Machine: TForthMachine; Command: PForthCommand);
  procedure emit(Machine: TForthMachine; Command: PForthCommand);
  procedure space(Machine: TForthMachine; Command: PForthCommand);
  procedure spaces(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TControlCommands'}{$ENDIF}
TControlCommands = class
 private
  FMachine: TForthMachine;
 public
  constructor Create(Machine: TForthMachine);
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
  procedure compile_skip_to_end(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_enddef(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand); 
  procedure scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
  procedure immediate(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
TEmbroCommands = class
 public
  procedure compile(Machine: TForthMachine; Command: PForthCommand);
  procedure execute(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}
TDataCommands = class
 public
  procedure _nil(Machine: TForthMachine; Command: PForthCommand);
  procedure ptr_comma(Machine: TForthMachine; Command: PForthCommand);

  procedure _create(Machine: TForthMachine; Command: PForthCommand);
  procedure putdataptr(Machine: TForthMachine; Command: PForthCommand);
  procedure here(Machine: TForthMachine; Command: PForthCommand);
  procedure allot(Machine: TForthMachine; Command: PForthCommand);

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
  procedure compile_to(Machine: TForthMachine; const Name: TString; Size: Integer);
  procedure run_to(Machine: TForthMachine; Command: PForthCommand);
  procedure run_8to(Machine: TForthMachine; Command: PForthCommand);
  procedure run_16to(Machine: TForthMachine; Command: PForthCommand);
  procedure run_32to(Machine: TForthMachine; Command: PForthCommand);
  procedure run_64to(Machine: TForthMachine; Command: PForthCommand);
  procedure interpete_to(Machine: TForthMachine; const Name: TString; Size: Integer);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TTypeCommands'}{$ENDIF}
TTypeCommands = class
 public
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
  procedure _single(Machine: TForthMachine; Command: PForthCommand);
  procedure _double(Machine: TForthMachine; Command: PForthCommand);
  procedure _extended(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TAlienCommands'}{$ENDIF}
TAlienCommands = class
 private
  FLibs: array of TInt;
 public
  procedure lib_load(Machine: TForthMachine; Command: PForthCommand);
  procedure lib_unload(Machine: TForthMachine; Command: PForthCommand);
  procedure lib_fun(Machine: TForthMachine; Command: PForthCommand);
  procedure alien_fun(Machine: TForthMachine; Command: PForthCommand);
  procedure alien_endfun(Machine: TForthMachine; Command: PForthCommand);
  procedure invoke_stdcall(Machine: TForthMachine; Command: PForthCommand);
  procedure invoke_cdecl(Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_stdcall(Machine: TForthMachine; Command: PForthCommand);
  procedure _conv_cdecl(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TStringCommands'}{$ENDIF}
TStringCommands = class
 private
  FMachine: TForthMachine;
  // когда они создаются при интерпритации,нужно где-то хранить
  FPChars: array of array of TChar;

  S: TStr;
  FStrNil: TStr;
 public
  constructor Create(Machine: TForthMachine);
  procedure pchar_alloc(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_free(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_len(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_concat(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_equel(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure run_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_dot(Machine: TForthMachine; Command: PForthCommand);

  // подсчёт ссылок у строк
  procedure AddRef(S: TStr);
  procedure DelRef(S: TStr);

  // стековые команды над строками отличаются
  procedure str_push(Machine: TForthMachine; Command: PForthCommand; S: TString); overload;
  procedure str_push(Machine: TForthMachine; Command: PForthCommand; S: TStr); overload;
  function str_pop(Machine: TForthMachine; Command: PForthCommand): TStr;
  procedure str_drop(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dup(Machine: TForthMachine; Command: PForthCommand);
  procedure str_over(Machine: TForthMachine; Command: PForthCommand);

  procedure str_len(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure compile_str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure run_str_dq(Machine: TForthMachine; Command: PForthCommand);
  procedure str_equel(Machine: TForthMachine; Command: PForthCommand);
  procedure str_concat(Machine: TForthMachine; Command: PForthCommand);
  procedure str_nil(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dot(Machine: TForthMachine; Command: PForthCommand);
  procedure str_dollar(Machine: TForthMachine; Command: PForthCommand);
  procedure pchar_to_str(Machine: TForthMachine; Command: PForthCommand);
  procedure Format(Machine: TForthMachine; Command: PForthCommand);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TForthMachine'}{$ENDIF}
TForthMachine = class
 private
  FUserData: Pointer;
  FStack: TForthStack;
  FReturnStack: TReturnStack;
{$IFNDEF FLAG_FPC}{$REGION 'commands'}{$ENDIF}
  FControlCommands: TControlCommands;
  FEmbroCommands: TEmbroCommands;
  FDataCommands: TDataCommands;
  FAlienCommands: TAlienCommands;
  FStackCommands: TStackCommands;
  FStackCommands8: TStackCommands;
  FStackCommands16: TStackCommands;
  FStackCommands32: TStackCommands;
  FStackCommands64: TStackCommands;
  FPtrStackCommands: TStackCommands;
  FStringCommands: TStringCommands;
  FTypeCommands: TTypeCommands;
  FIntArithmetic: TObject;
  FInt8Arithmetic: TObject;
  FInt16Arithmetic: TObject;
  FInt32Arithmetic: TObject;
  FInt64Arithmetic: TObject;
  FUIntArithmetic: TObject;
  FUInt8Arithmetic: TObject;
  FUInt16Arithmetic: TObject;
  FUInt32Arithmetic: TObject;
  FUInt64Arithmetic: TObject;
  FBoolCommands: TBoolCommands;
  FConsoleCommands: TConsoleCommands;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
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
  FState: Integer;
  FSession: Boolean;
  FLastMnemonic: Integer;
  FEmbroDump: array of TString;
  FEmbro: array of Byte;
  FTypes: array of TType;
{$IFNDEF FLAG_FPC}{$REGION 'misc commands'}{$ENDIF}
  procedure CompileComment(Machine: TForthMachine; Command: PForthCommand);
  procedure CompileLineComment(Machine: TForthMachine; Command: PForthCommand);
  procedure CompileSource(Source: PChar);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  function CompileName(W: PChar): Boolean; overload;
  function NextMnemonic: Cardinal;
  procedure Run(Index: Integer);
  procedure RunMnemonic(M: Cardinal);
  procedure RunCommand(Command: PForthCommand);
  procedure RunError(const S: TString);
  procedure RunWarring(const S: TString);
  procedure IncHere(Count: Integer);
  procedure AddType(const Name: TString; Size: Integer);
 public
{$IFNDEF FLAG_FPC}{$REGION 'machine datas'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'E'}{$ENDIF}
 public
  E: array of Byte; // Embro
  EB: Pointer; // Embro Base (@E[0])
  EC: Integer; // Embro Counter (E[EC])
  EL: Integer; // Embro Last compiled
  ES: Integer; // Embro Size (Length(E))
  procedure EA(Size: Integer); // Embro Alloc
  function Here: Pointer; overload;
  procedure _here(Machine: TForthMachine; Command: PForthCommand); overload;
  procedure EWV(V: Pointer; Size: Integer); // Embro Write Var
  procedure EWI(V: Integer); // Embro Write Integer
  procedure EWE(V: TEmbroPtr);
  procedure EWO(V: TOpcode); overload;
  procedure EWO(V: TString); overload;
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
 public
  R: array of Byte; // Return stack
  RB: Pointer; // Return stack Base
  RP: Pointer; // Return stack Pointer
  RS: Integer; // Return stack Size
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
 public
  W: array of Byte; // Work stack
  WB: Pointer; // Work stack Base (@W[0])
  WP: Pointer; // Work stack Pointer
  WS: Integer; // Work stack Size
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
{$IFNDEF FLAG_FPC}{$REGION 'C'}{$ENDIF}
 public
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
 public
   Local: TWordSpace;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'D'}{$ENDIF}
 public
 {D: array of Byte; // Data
  DB: Pointer; // Data Base
  DP: Pointer; // Data Pointer (traditionaly called HERE in forth)
  DS: Integer; // Data Size
  procedure DA(Size: Integer); // Data Allot}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'S'}{$ENDIF}
 public
  // doesn't work in run state
  S: PChar; // Source
  SC: Integer; // Source Counter
  function SE: Boolean; // Source End
  function SNC: TChar; // Source Next Char
  function SNN: TString; // Source Next Name
  procedure SSS; // Source Skip Spaces
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
 public
  L: array of Byte; // Local stack
  LB: Pointer; // Local stack Base (@W[0])
  LP: Pointer; // Local stack Pointer
  LS: Integer; // Local stack Size
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
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'plugin datas'}{$ENDIF}
 public
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
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'all commands'}{$ENDIF}
          
    procedure drop_ (Machine: TForthMachine; Command: PForthCommand);
    procedure dup_ (Machine: TForthMachine; Command: PForthCommand);
    procedure nip_ (Machine: TForthMachine; Command: PForthCommand);
    procedure swap_ (Machine: TForthMachine; Command: PForthCommand);
    procedure over_ (Machine: TForthMachine; Command: PForthCommand);
    procedure tuck_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrot_ (Machine: TForthMachine; Command: PForthCommand);
    procedure lrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure rrotn_ (Machine: TForthMachine; Command: PForthCommand);
    procedure pick_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _comma_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _dog_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _exclamation_ (Machine: TForthMachine; Command: PForthCommand);
    procedure ptr_plus_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _compile_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _run_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _interpret_to_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _value_ (Machine: TForthMachine; Command: PForthCommand);
    procedure _variable_ (Machine: TForthMachine; Command: PForthCommand);
    procedure RunValue_ (Machine: TForthMachine; Command: PForthCommand);
    procedure literal_ (Machine: TForthMachine; Command: PForthCommand);
    procedure run_literal_ (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
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
  procedure uint64_max (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_min (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure single_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure single_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure single_star (Machine: TForthMachine; Command: PForthCommand);
  procedure single_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure single_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure single_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure single_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure single_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure single_gte (Machine: TForthMachine; Command: PForthCommand);  
  procedure single_0_equel (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_nequel (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_lt (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_lte (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_gte (Machine: TForthMachine; Command: PForthCommand);
  procedure single_ask_dup (Machine: TForthMachine; Command: PForthCommand);
  procedure single_0_exit (Machine: TForthMachine; Command: PForthCommand);
  procedure single_max (Machine: TForthMachine; Command: PForthCommand);
  procedure single_min (Machine: TForthMachine; Command: PForthCommand);
  procedure single_minmax (Machine: TForthMachine; Command: PForthCommand);
  procedure single_dot (Machine: TForthMachine; Command: PForthCommand);
  procedure single_dollar (Machine: TForthMachine; Command: PForthCommand);
  procedure single_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure single_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
  procedure single_conv_from_str (Machine: TForthMachine; Command: PForthCommand)
  
  
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
  
  procedure single_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure single_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_abs (Machine: TForthMachine; Command: PForthCommand);
  procedure double_neg (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTo(const S: TString; var X: TInt): Integer;
  procedure _push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure _div (Machine: TForthMachine; Command: PForthCommand);
  procedure _mod (Machine: TForthMachine; Command: PForthCommand);
  procedure _divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure _ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrToint(const S: TString; var X: TInt): Integer;
  procedure int_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrToint8(const S: TString; var X: TInt8): Integer;
  procedure int8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrToint16(const S: TString; var X: TInt16): Integer;
  procedure int16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrToint32(const S: TString; var X: TInt32): Integer;
  procedure int32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrToint64(const S: TString; var X: TInt64): Integer;
  procedure int64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTouint(const S: TString; var X: TUInt): Integer;
  procedure uint_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTouint8(const S: TString; var X: TUInt8): Integer;
  procedure uint8_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTouint16(const S: TString; var X: TUInt16): Integer;
  procedure uint16_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTouint32(const S: TString; var X: TUInt32): Integer;
  procedure uint32_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_divmod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
  procedure uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  function ConvertStrTouint64(const S: TString; var X: TUInt64): Integer;
  procedure uint64_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_run_push  (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_1_minus (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_div (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_mod (Machine: TForthMachine; Command: PForthCommand);
  procedure uint64_divmod (Machine: TForthMachine; Command: PForthCommand);
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
  
  procedure single_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_single (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure single_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
  procedure extended_convert_to_single (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
   procedure single_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure single_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure single_compile_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure single_run_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure single_slash (Machine: TForthMachine; Command: PForthCommand);
   procedure single_cos (Machine: TForthMachine; Command: PForthCommand);
   procedure single_sin (Machine: TForthMachine; Command: PForthCommand);
   procedure single_tan (Machine: TForthMachine; Command: PForthCommand);
   procedure single_atan (Machine: TForthMachine; Command: PForthCommand);
   procedure single_atan2 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
   procedure double_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure double_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure double_compile_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure double_run_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure double_slash (Machine: TForthMachine; Command: PForthCommand);
   procedure double_cos (Machine: TForthMachine; Command: PForthCommand);
   procedure double_sin (Machine: TForthMachine; Command: PForthCommand);
   procedure double_tan (Machine: TForthMachine; Command: PForthCommand);
   procedure double_atan (Machine: TForthMachine; Command: PForthCommand);
   procedure double_atan2 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
   procedure extended_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_interpret_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_compile_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_run_push  (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_slash (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_cos (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_sin (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_tan (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_atan (Machine: TForthMachine; Command: PForthCommand);
   procedure extended_atan2 (Machine: TForthMachine; Command: PForthCommand)
  
  
;
  
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
  
  procedure EW_single (V: Single);
  function ER_single: Single
  
  
;
  
  procedure EW_double (V: Double);
  function ER_double: Double
  
  
;
  
  procedure EW_extended (V: Extended);
  function ER_extended: Extended
  
  
;
  
  procedure _wp (Machine: TForthMachine; Command: PForthCommand);
  procedure _rp (Machine: TForthMachine; Command: PForthCommand);
  procedure _lp (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_dog (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _lt_r (Machine: TForthMachine; Command: PForthCommand);
  procedure version (Machine: TForthMachine; Command: PForthCommand);
  procedure _state (Machine: TForthMachine; Command: PForthCommand);
  procedure _time (Machine: TForthMachine; Command: PForthCommand);
  procedure _local (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_char (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_name (Machine: TForthMachine; Command: PForthCommand);
  procedure source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure run_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand);
  procedure source_read_to_char (Machine: TForthMachine; Command: PForthCommand);
  procedure ptr_nil (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_start (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_start (Machine: TForthMachine; Command: PForthCommand);
  procedure run_start (Machine: TForthMachine; Command: PForthCommand);
  //procedure allot (Machine: TForthMachine; Command: PForthCommand)
  procedure opcode_to_command (Machine: TForthMachine; Command: PForthCommand);
  procedure literal (Machine: TForthMachine; Command: PForthCommand);
  procedure sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure interpret_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure compile_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure run_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure _tick (Machine: TForthMachine; Command: PForthCommand);
  procedure execute (Machine: TForthMachine; Command: PForthCommand);
  procedure _does_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _sq_does_gt_sq (Machine: TForthMachine; Command: PForthCommand);
  procedure CallDoesGt (Machine: TForthMachine; Command: PForthCommand);
  procedure Cells (Machine: TForthMachine; Command: PForthCommand);
  procedure Cell_plus (Machine: TForthMachine; Command: PForthCommand);
  procedure _malloc (Machine: TForthMachine; Command: PForthCommand);
  procedure _free (Machine: TForthMachine; Command: PForthCommand);
  procedure _last (Machine: TForthMachine; Command: PForthCommand);
  procedure _xt_dot_n (Machine: TForthMachine; Command: PForthCommand);
  procedure _xt_dot_d (Machine: TForthMachine; Command: PForthCommand);
  
  

  
 public
  Exceptions: array of Byte;
  ExceptionsB: Pointer;
  ExceptionsP: Pointer;
  ExceptionsS: Integer;
  procedure _sys_exceptions_execute (Machine: TForthMachine; Command: PForthCommand);
  procedure _sys_exceptions_pop (Machine: TForthMachine; Command: PForthCommand);
  procedure _throw (Machine: TForthMachine; Command: PForthCommand);
  
  )))))))))))))))))))))))))))))))


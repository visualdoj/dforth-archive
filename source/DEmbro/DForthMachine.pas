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

  TStrRec = packed record
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
  procedure compile_noname(Machine: TForthMachine; Command: PForthCommand);
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
  procedure _created(Machine: TForthMachine; Command: PForthCommand);
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
  procedure str_dog(Machine: TForthMachine; Command: PForthCommand);
  procedure str_exclamation(Machine: TForthMachine; Command: PForthCommand);
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
  FMemoryDebug: TDebug;
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
  procedure _lb (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_dog (Machine: TForthMachine; Command: PForthCommand);
  procedure _r_gt (Machine: TForthMachine; Command: PForthCommand);
  procedure _lt_r (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_dog (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_exclamation (Machine: TForthMachine; Command: PForthCommand);
  procedure _l_plus (Machine: TForthMachine; Command: PForthCommand);
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
  procedure _move (Machine: TForthMachine; Command: PForthCommand);
  
  

  
 public
  Exceptions: array of Byte;
  ExceptionsB: Pointer;
  ExceptionsP: Pointer;
  ExceptionsS: Integer;
  procedure _sys_exceptions_execute (Machine: TForthMachine; Command: PForthCommand);
  procedure _sys_exceptions_pop (Machine: TForthMachine; Command: PForthCommand);
  procedure _throw (Machine: TForthMachine; Command: PForthCommand);
  
  
  

  
  procedure file_open (Machine: TForthMachine; Command: PForthCommand);
  procedure file_close (Machine: TForthMachine; Command: PForthCommand);
  procedure file_w (Machine: TForthMachine; Command: PForthCommand);
  procedure file_r (Machine: TForthMachine; Command: PForthCommand);
  procedure file_write (Machine: TForthMachine; Command: PForthCommand);
  procedure file_read (Machine: TForthMachine; Command: PForthCommand);
  procedure file_write_from_w (Machine: TForthMachine; Command: PForthCommand);
  procedure file_read_to_w (Machine: TForthMachine; Command: PForthCommand);
  procedure file_size (Machine: TForthMachine; Command: PForthCommand);
  
  

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  constructor Create;
  destructor Destroy; override;
  procedure AddCommand(Name: PChar; Code: TCode; Immediate: Boolean = False;
                       Builtin: Boolean = True);

  procedure InterpretName(W: PChar); overload;
  procedure Interpret(const S: PChar); overload;
  procedure InterpretFile(const FileName: TString);
  procedure Evaluate(Machine: TForthMachine; Command: PForthCommand);
  procedure EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
  procedure MainLoop;
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

  procedure Push(P: Pointer; Size: Integer); overload;
  procedure Push(I: TInt); overload;
  procedure PushMnemonic(M: TMnemonic); overload;
  procedure PushPtr(P: Pointer); overload;
  procedure PushEmbroPtr(EmbroPtr: TInt); overload;
  procedure Pop(P: Pointer; Size: Integer); overload;
  function Pop: Integer; overload;
  function PopMnemonic: TMnemonic;
  function PopPtr: TPtr;
  function PopEmbroPtr: TEmbroPtr;

  function GetEmbroDumpLines: Integer;
  function GetEmbroDumpLine(Index: Integer): TString;
  function FindCommand(const Name: TString): PForthCommand;

  property UserData: Pointer read FUserData write FUserData;
  property Stack: TForthStack read FStack;
  property Current: Integer;
  property State: Integer read FState write FState;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'GIntArithmetic<T>'}{$ENDIF}
type
{$IFDEF FLAG_FPC}generic{$ENDIF} GIntArithmetic<T> = class
 protected
  FMachine: TForthMachine;
 public
  constructor Create(Machine: TForthMachine);
  procedure _plus(Machine: TForthMachine; Command: PForthCommand);
  procedure _minus(Machine: TForthMachine; Command: PForthCommand);
  procedure _star(Machine: TForthMachine; Command: PForthCommand);
  procedure _equel(Machine: TForthMachine; Command: PForthCommand);
  procedure _lt(Machine: TForthMachine; Command: PForthCommand);
  procedure _gt(Machine: TForthMachine; Command: PForthCommand);
  procedure _div(Machine: TForthMachine; Command: PForthCommand);
  procedure _mod(Machine: TForthMachine; Command: PForthCommand);
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); virtual;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); virtual;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); virtual;
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); virtual;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'specialized arithmetic'}{$ENDIF}
SIntArithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TInt>;
SInt8Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TInt8>;
SInt16Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TInt16>;
SInt32Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TInt32>;
SInt64Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TInt64>;
SUIntArithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TUInt>;
SUInt8Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TUInt8>;
SUInt16Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TUInt16>;
SUInt32Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TUInt32>;
SUInt64Arithmetic = {$IFDEF FLAG_FPC}specialize{$ENDIF} GIntArithmetic<TUInt64>;

TIntArithmetic = class(SIntArithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); override;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TInt8Arithmetic = class(SInt8Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); override;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TInt16Arithmetic = class(SInt16Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); override;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TInt32Arithmetic = class(SInt32Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); override;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TInt64Arithmetic = class(SInt64Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure _abs(Machine: TForthMachine; Command: PForthCommand); override;
  procedure neg(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TUIntArithmetic = class(SUIntArithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TUInt8Arithmetic = class(SUInt8Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TUInt16Arithmetic = class(SUInt16Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TUInt32Arithmetic = class(SUInt32Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;

TUInt64Arithmetic = class(SUInt64Arithmetic)
 public
  procedure _dot(Machine: TForthMachine; Command: PForthCommand); override;
  procedure ToInt(Machine: TForthMachine; Command: PForthCommand);
  procedure FromInt(Machine: TForthMachine; Command: PForthCommand);
  procedure _comma(Machine: TForthMachine; Command: PForthCommand); override;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

function IsImmediate(Command: PForthCommand): Boolean;
procedure SetImmediate(Command: PForthCommand; I: Boolean);
function IsBuiltin(Command: PForthCommand): Boolean;
procedure SetBuiltin(Command: PForthCommand; I: Boolean);
function CopyStrToPChar(const S: TString): PChar;

procedure WordListClear(var WL: TWordSpace);
function WordListInsert(var WL: TWordSpace; Command: PForthCommand): Integer;
function WordListFind(var WL: TWordSpace; S: TString; var Opcode: TOpcode): Boolean;

implementation

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

function CopyStrToPChar(const S: TString): PChar;
begin
  Result := StrAlloc(Length(S) + 1);
  StrCopy(Result, PChar(S));
end;

procedure WordListClear(var WL: TWordSpace);
begin
  SetLength(WL.C, 0);
  WL.L := 0;
  WL.S := 0;
end;

function WordListInsert(var WL: TWordSpace; Command: PForthCommand): Integer;
begin
  SetLength(WL.C, Length(WL.C) + 1);
  WL.C[High(WL.C)] := Command;
  WL.L := Length(WL.C);
  Result := High(WL.C);
end;

function WordListFind(var WL: TWordSpace; S: TString; var Opcode: TOpcode): Boolean;
var
  I: Integer;
begin
  for I := WL.L - 1 downto 0 do
    if TString(WL.C[I]) = S then begin
      Result := True;
      Opcode := I;
      Exit;
    end;
  Result := False;
end;

{$IFNDEF FLAG_FPC}{$REGION 'TReturnStack'}{$ENDIF}
procedure TReturnStack.ptrpush(P: Pointer);
begin
  Push(@P, SizeOf(P));
end;

function TReturnStack.ptrpop: Pointer;
begin
  Pop(@Result, SizeOf(Result));
end;

function TReturnStack.ptrgettop: Pointer;
begin
  Dup(SizeOf(Pointer));
  Result := ptrpop;
end;

procedure TReturnStack.embropush(P: Cardinal);
begin
  Push(@P, SizeOf(P));
end;

function TReturnStack.embropop: Cardinal;
begin
  Pop(@Result, SizeOf(Result));
end;

function TReturnStack.embrogettop: Cardinal;
begin
  Dup(SizeOf(Cardinal));
  Result := embropop;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TStackCommands'}{$ENDIF}
constructor TStackCommands.Create(Machine: TForthMachine; Size: Integer);
begin
  FMachine := Machine;
  FSize := Size;
  SetLength(Temp, FSize);
end;

procedure TStackCommands.push(P: Pointer);
begin
  FMachine.Push(P, FSize);
end;

procedure TStackCommands._push;
var
  Temp: array of Byte;
begin
  //SetLength(Temp, FSize);
  //FMachine.ReadEmbro(@Temp[0], FSize);
  //FMachine.Stack.pushn(@Temp[0], FSize);
end;

procedure TStackCommands.compile_push;
(* var *)
(*   Name: TString; *)
(*   I: Integer; *)
begin
  (* Name := FMachine.NextName; *)
  (* I := StrToIntDef(Name, -3535); *)
  (* if I = -3535 then *)
  (*   FMachine.CompileError('need number, but ' + Name + ' found') *)
  (* else *)
  (*   FMachine.WriteEmbroInt(I); *)
end;

procedure TStackCommands.pop(P: Pointer);
begin
  //FMachine.Stack.pop(P, FSize);
end;

procedure TStackCommands.dup;
begin
  //FMachine.Stack.dupn(FSize);
end;

procedure TStackCommands.drop;
begin
  //FMachine.Stack.dropn(FSize);
end;

procedure TStackCommands.swap;
begin
  //FMachine.Stack.swap(FSize);
end;

procedure TStackCommands.over;
begin
  //FMachine.Stack.overn(FSize);
end;

procedure TStackCommands.lrot;
begin
  //FMachine.Stack.lrot(FSize);
end;

procedure TStackCommands.rrot;
begin
  //FMachine.Stack.rrot(FSize);
end;

procedure TStackCommands.lrotn;
begin
  //FMachine.Stack.lrotn(FSize);
end;

procedure TStackCommands.rrotn;
begin
  //FMachine.Stack.rrotn(FSize);
end;

procedure TStackCommands._dog(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  FMachine.FPtrStackCommands.Pop(@P);
  Push(P);
end;

procedure TStackCommands._exclamation(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  FMachine.FPtrStackCommands.Pop(@P);
  Pop(@Temp[0]);
  Move(Temp[0], P^, FSize);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TBoolCommands'}{$ENDIF}
constructor TBoolCommands.Create(Machine: TForthMachine);
begin
  FMachine := Machine;
end;

procedure TBoolCommands.push;
var
  B: TInt;
begin
  FMachine.ReadEmbro(@B, SizeOf(B));
  FMachine.WUI(B);
end;

procedure TBoolCommands.compile_push;
var
  Name: TString;
begin
  Name := Machine.NextName;
  if Name = 'true' then
    Machine.WriteEmbroInt(BOOL_TRUE)
  else if Name = 'false' then
    Machine.WriteEmbroInt(BOOL_FALSE)
  else
    Machine.CompileError('need bool constant, but "' + Name + '" found');
end;

procedure TBoolCommands._false;
begin
  FMachine.WUI(BOOL_FALSE);
end;

procedure TBoolCommands._true;
begin
  FMachine.WUI(BOOL_TRUE);
end;

procedure TBoolCommands._not;
//var
//  a: TInt;
begin
  {FMachine.WUI(a);
  if a = BOOL_FALSE then
    a := BOOL_TRUE
  else
    a := BOOL_FALSE;
  FMachine.WUI(a);}
  FMachine.WUI(not FMachine.WOI);
end;

procedure TBoolCommands._or;
var
  a,b: TInt;
begin
  {FMachine.WUI(a);
  FMachine.WUI(b);
  if (a = BOOL_FALSE) and (b = BOOL_FALSE) then
    a := BOOL_FALSE
  else
    a := BOOL_TRUE;
  FMachine.WUI(a);}
  FMachine.WUI(FMachine.WOI or FMachine.WOI);
end;

procedure TBoolCommands._and;
//var
//  a,b: TInt;
begin
  {a := FMachine.WOI;
  b := FMachine.WOI;
  if (a = BOOL_FALSE) or (b = BOOL_FALSE) then
    a := BOOL_FALSE
  else
    a := BOOL_TRUE;
  FMachine.WUI(a);}
  FMachine.WUI(FMachine.WOI and FMachine.WOI);
end;

procedure TBoolCommands._xor;
//var
//  a,b: TInt;
begin
  {a := FMachine.WOI;
  b := FMachine.WOI;
  if (a = BOOL_FALSE) xor (b = BOOL_FALSE) then
    a := BOOL_TRUE
  else
    a := BOOL_FALSE;
  FMachine.WUI(a);}
  FMachine.WUI(FMachine.WOI xor FMachine.WOI);
end;

procedure TBoolCommands._dot;
var
  a: TInt;
begin
  a := FMachine.WOI;
  if a = 0 then
    Write('FALSE ')
  else
    Write('TRUE ')
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TConsoleCommands'}{$ENDIF}
constructor TConsoleCommands.Create(Machine: TForthMachine);
begin
  FMachine := Machine;
end;

procedure TConsoleCommands.cr;
begin
  Writeln;
end;

procedure TConsoleCommands.emit;
var
  I: Integer;
begin
  //FMachine.Stack.Pop(@I, SizeOf(I));
  Write(TChar(I));
end;

procedure TConsoleCommands.space;
begin
  Write(' ');
end;

procedure TConsoleCommands.spaces;
var
  I: TInt;
begin
  I := FMachine.WOI;
  while I > 0 do begin
    SPACE(Machine, Command);
    Dec(I);
  end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TControlCommands'}{$ENDIF}
constructor TControlCommands.Create(Machine: TForthMachine);
begin
  FMachine := Machine;
end;

procedure TControlCommands.branch;
begin
  FMachine.EC := FMachine.ERU;
end;

procedure TControlCommands._ask_branch;
var
  B: TInt;
  Temp: Cardinal;
begin
  B := FMachine.WOI;
  Temp := FMachine.ERU;
  if B = BOOL_FALSE then
    FMachine.EC := Temp;
end;

procedure TControlCommands._gt_mark;
var
  Temp: Cardinal;
begin
  Temp := Machine.EL;
  FMachine.WUU(Temp);
  FMachine.EWU(Temp);
end;

procedure TControlCommands._gt_resolve;
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  Temp := FMachine.WOU;
  PC := Machine.EL;
  Move(PC, Pointer(@Machine.E[Temp])^, SizeOf(PC));
end;

procedure TControlCommands._lt_mark;
var
  Temp: Cardinal;
begin
  Temp := Machine.EL;
  FMachine.WUU(Temp);
end;

procedure TControlCommands._lt_resolve;
var
  Temp: Cardinal;
  PC: Cardinal;
begin
  Temp := FMachine.WOU;
  FMachine.EWU(Temp);
end;

procedure TControlCommands._exit;
begin
  //Log('EXIT');
  if TUInt(FMachine.RB) >= TUInt(FMachine.RP) then begin
    //FMachine.EC := Length(FMachine.FEmbro)
    Machine.RB := Machine.ROP;
    Machine.FState := Machine.ROI;
  end else
    FMachine.EC := FMachine.ROI;
  FMachine.LP := FMachine.LB;
  FMAchine.LB := FMachine.ROP;
end;

procedure TControlCommands.recurse(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.EWO(Machine.FLastMnemonic);
end;

procedure TControlCommands.call(Machine: TForthMachine; Command: PForthCommand);
begin
  // Writeln('INSIDE CALL "' + Command^.Name + '"');
  //Writeln('called function ' + Command^.Name);
  Machine.RUP(Machine.LB);
  Machine.LB := Machine.LP;
  if Machine.FState = FS_RUN then
    Machine.RUI(Machine.EC)
  else begin
    Machine.RUI(Machine.FState);
    Machine.RUP(Machine.RB);
    Machine.RB := Machine.RP;
  end;
  Machine.EC := Integer(Command^.Data);
  Machine.FState := FS_RUN;
end;

procedure TControlCommands.compile_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
  PName: PChar;
begin
  Name := Machine.NextName;
  PName := CopyStrToPChar(Name);
  NewCommand := Machine.ReserveName('');
  NewCommand^.Code := call;
  SetImmediate(NewCommand, False);
  Integer(NewCommand^.Data) := FMachine.EL;
  Machine.FState := FS_COMPILE;
  Machine.LUI(Machine.FLastMnemonic);
  Machine.LUP(PName);
  Machine.LUI(101);
end;

procedure TControlCommands.compile_noname(Machine: TForthMachine; Command: PForthCommand);
var
  NewCommand: PForthCommand;
begin
  NewCommand := Machine.ReserveName('');
  NewCommand^.Code := call;
  SetImmediate(NewCommand, False);
  Integer(NewCommand^.Data) := FMachine.EL;
  Machine.FState := FS_COMPILE;
  Machine.WUP(NewCommand);
  Machine.LUI(Machine.FLastMnemonic);
  Machine.LUP(Pointer(PChar('')));
  Machine.LUI(101);
end;

procedure TControlCommands.compile_skip_to_end(Machine: TForthMachine; Command: PForthCommand);
begin
  if Integer(Machine.LP^) <> 101 then begin
    Machine.LogError('Нельзя использовать skip-to; внутри конструкций (на вершине стека не colon-id)');
    Exit;
  end;
  Machine.FControlCommands._gt_mark(Machine, nil);
  Machine.LUI(201);
end;

procedure TControlCommands.compile_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  S: TString;
  Index: TInt;
  P: PChar;
  ID: Integer;
begin
  //S := Machine.FStringCommands.str_pop(Machine, Command);
  //Machine.C[Machine.WOI]^.Name := PChar(TString(PChar(@TStrRec(S^).Sym[0])));
  //Machine.FStringCommands.DelRef(S);
  ID := Machine.LOI;
  if ID = 201 then begin
    Machine.FControlCommands._gt_resolve(Machine, nil);
  end;
  P := Machine.LOP;
  Index := Machine.LOI;
  Machine.C[Index]^.Name := P;
  Machine.EWO('exit');
  Machine.FState := FS_INTERPRET;
  Machine.C[Index]^.Flags := Machine.C[Index]^.Flags and not 1;
  //Writeln('LAST COMMAND ', High(Machine.C), ' ' + Machine.C[High(Machine.C)].Name);
end;

procedure TControlCommands.compile_scattered_def(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  C: PForthCommand;
begin
  Machine.FState := FS_COMPILE;
  Name := Machine.NextName;
  C := Machine.FindCommand(Name);
  if C = nil then begin
    Machine.LogError('Command not found: ' + Name);
    Exit;
  end;
  Machine.WUU(Cardinal((@Machine.E[Cardinal(C^.Param)])^));
  Cardinal((@Machine.E[Cardinal(C^.Param)])^) := FMachine.EL;
  Machine.WUP(C);
end;

procedure TControlCommands.compile_scattered_enddef(Machine: TForthMachine; Command: PForthCommand);
var
  C: PForthCommand;
  P: Cardinal;
begin
  C := Machine.WOP;
  P := Cardinal(C^.Param);
  Machine.EWO('branch');
  Cardinal(C^.Param) := Machine.EL;
  Machine.EWU(Machine.WOU);
  Machine.FState := FS_INTERPRET;
end;

procedure TControlCommands.scattered_dots(Machine: TForthMachine; Command: PForthCommand); 
begin
  Machine.EWO('branch');
  Cardinal(Machine.C[Machine.FLastMnemonic]^.Param) := Machine.EL;
  Machine.EWU(Machine.EL + SizeOf(TUInt));
end;

procedure TControlCommands.immediate(Machine: TForthMachine; Command: PForthCommand);
begin
  SetImmediate(Machine.C[Machine.FLastMnemonic], True);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TEmbroCommands'}{$ENDIF}
procedure TEmbroCommands.compile(Machine: TForthMachine; Command: PForthCommand);
var
  U: TUInt;
begin
  if Machine.State = FS_COMPILE then begin
    Machine.EWO('compile');
    Machine.EWO(Machine.NextName);
  end else begin
    Machine.EWO(Machine.C[Machine.ERU].Name);
  end;
end;

procedure TEmbroCommands.execute(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.InterpretName(PChar(Machine.NextName));
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TDataCommands'}{$ENDIF}
procedure TDataCommands._create(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  Name := Machine.NextName;
  NewCommand := Machine.ReserveName(Name);
  NewCommand^.Code := putdataptr;
  NewCommand^.Data := Machine.Here;
end;

procedure TDataCommands._created(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  NewCommand: PForthCommand;
begin
  Name := Machine.WOS;
  NewCommand := Machine.ReserveName(Name);
  NewCommand^.Code := putdataptr;
  NewCommand^.Data := Machine.Here;
end;

procedure TDataCommands.putdataptr(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  P := Command^.Data;
  Machine.WUP(P);
end;

procedure TDataCommands.here(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  // FIXME: P не постоянен
  P := Machine.Here;
  Machine.FPtrStackCommands.Push(@P);
end;

procedure TDataCommands.allot(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin
  I := Machine.WOI;
  Machine.IncHere(I);
end;

procedure TDataCommands.to_int(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TInt))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TInt));
end;

procedure TDataCommands.to_int8(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TInt8))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TInt8));
end;

procedure TDataCommands.to_int16(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TInt16))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TInt16));
end;

procedure TDataCommands.to_int32(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TInt32))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TInt32));
end;

procedure TDataCommands.to_int64(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TInt64))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TInt64));
end;

procedure TDataCommands.to_uint(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TUInt))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TUInt));
end;

procedure TDataCommands.to_uint8(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TUInt8))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TUInt8));
end;

procedure TDataCommands.to_uint16(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TUInt16))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TUInt16));
end;

procedure TDataCommands.to_uint32(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TUInt32))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TUInt32));
end;

procedure TDataCommands.to_uint64(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(TUint64))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(TUint64));
end;

procedure TDataCommands.to_ptr(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.State = FS_COMPILE then
    compile_to(Machine, Machine.NextName, SizeOf(Pointer))
  else
    interpete_to(Machine, Machine.NextName, SizeOf(Pointer));
end;

procedure TDataCommands.compile_to;
begin
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

procedure TDataCommands.run_to(Machine: TForthMachine; Command: PForthCommand);
var
  Size: Byte;
  M: TMnemonic;
  Temp: array[0..255] of Byte;
begin
  Machine.ReadEmbro(@Size, SizeOf(Size));
  M := Machine.ReadMnemonic;
  Machine.Pop(@Temp[0], Size);
  Move(Temp[0], Machine.C[M].Data^, Size);
end;

procedure TDataCommands.run_8to(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: TUint8;
begin
  Machine.Pop(@Temp, SizeOf(Temp));
  Move(Temp, Machine.C[Machine.ReadMnemonic].Data^, SizeOf(Temp));
end;

procedure TDataCommands.run_16to(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: TUint16;
begin
  Machine.Pop(@Temp, SizeOf(Temp));
  Move(Temp, Machine.C[Machine.ReadMnemonic].Data^, SizeOf(Temp));
end;

procedure TDataCommands.run_32to(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: TUint32;
begin
  Machine.Pop(@Temp, SizeOf(Temp));
  Move(Temp, Machine.C[Machine.ReadMnemonic].Data^, SizeOf(Temp));
end;

procedure TDataCommands.run_64to(Machine: TForthMachine; Command: PForthCommand);
var
  Temp: TUint64;
begin
  Machine.Pop(@Temp, SizeOf(Temp));
  Move(Temp, Machine.C[Machine.ReadMnemonic].Data^, SizeOf(Temp));
end;

procedure TDataCommands.interpete_to;
var
  C: PForthCommand;
  Temp: array of Byte;
begin
  C := Machine.FindCommand(Name);
  if C = nil then begin
    Machine.LogError('cannot find command ' + Name);
    Exit;
  end;
  SetLength(Temp, Size);
  // FIXME
  //Machine.(@Temp[0], Size);
  Move(Temp[0], C^.Data^, Size);
end;

procedure TDataCommands._nil(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  P := nil;
  Machine.WUP(nil);
end;

procedure TDataCommands.ptr_comma(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  Machine.FPtrStackCommands.Pop(@P);
  Move(P, Machine.Here^, SizeOf(Pointer));
  Machine.IncHere(SizeOf(Pointer)); 
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TTypeCommands'}{$ENDIF}
procedure TTypeCommands.typeof(machine: tforthmachine; command: pforthcommand);
var
  Name: TString;
  I: Integer;
  P: PType;
begin
  if Machine.State = FS_COMPILE then
    compile_type(Machine, PChar(Machine.NextName))
  else begin
    Name := Machine.NextName;
    for I := 0 to High(Machine.FTypes) do
      if TString(Machine.FTypes[I].Name) = Name then begin
        P := @Machine.FTypes[I];
        Machine.FPtrStackCommands.Push(@P);
        Exit;
      end;
    Machine.LogError('cannot find type "' + Name + '"');
  end;
end;

procedure TTypeCommands.type_size(Machine: TForthMachine; Command: PForthCommand);
var
  P: PType;
begin
  P := Machine.WOP;
  Machine.WUI(P^.Size);
end;

procedure TTypeCommands.compile_type(Machine: TForthMachine; Name: PChar);
var
  I: Integer;
  P: PType;
begin
  for I := 0 to High(Machine.FTypes) do
    if TString(Machine.FTypes[I].Name) = TString(Name) then begin
      Machine.EWO(' typeof');
      Machine.EWI(I);
      Exit;
    end;
  Machine.LogError('cannot find type "' + Name + '"');
end;

procedure TTypeCommands.interpete_type(Machine: TForthMachine; Name: PChar);
var
  I: Integer;
  P: PType;
begin
  for I := 0 to High(Machine.FTypes) do
    if TString(Machine.FTypes[I].Name) = TString(Name) then begin
      Machine.WUP(@Machine.FTypes[I]);
      Exit;
    end;
  Machine.LogError('cannot find type "' + Name + '"');
end;

procedure TTypeCommands.run_type;
var
  I: TInt;
  P: PType;
begin
  I := Machine.ERI;
  P := @Machine.FTypes[I];
  Machine.WUP(P);
end;

procedure TTypeCommands._void(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'void')
  else
    interpete_type(Machine, 'void');
end;

procedure TTypeCommands._int(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'int')
  else
    interpete_type(Machine, 'int');
end;

procedure TTypeCommands._int8(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'int8')
  else
    interpete_type(Machine, 'int8');
end;

procedure TTypeCommands._int16(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'int16')
  else
    interpete_type(Machine, 'int16');
end;

procedure TTypeCommands._int32(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'int32')
  else
    interpete_type(Machine, 'int32');
end;

procedure TTypeCommands._int64(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'int64')
  else
    interpete_type(Machine, 'int64');
end;

procedure TTypeCommands._uint(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'uint')
  else
    interpete_type(Machine, 'uint');
end;

procedure TTypeCommands._uint8(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'uint8')
  else
    interpete_type(Machine, 'uint8');
end;

procedure TTypeCommands._uint16(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'uint16')
  else
    interpete_type(Machine, 'uint16');
end;

procedure TTypeCommands._uint32(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'uint32')
  else
    interpete_type(Machine, 'uint32');
end;

procedure TTypeCommands._uint64(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'uint64')
  else
    interpete_type(Machine, 'uint64');
end;

procedure TTypeCommands._bool(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'bool')
  else
    interpete_type(Machine, 'bool');
end;

procedure TTypeCommands._str(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'str')
  else
    interpete_type(Machine, 'str');
end;

procedure TTypeCommands._pchar(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'pchar')
  else
    interpete_type(Machine, 'pchar');
end;

procedure TTypeCommands._ptr(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'ptr')
  else
    interpete_type(Machine, 'ptr');
end;

procedure TTypeCommands._type(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'type')
  else
    interpete_type(Machine, 'type');
end;

procedure TTypeCommands._single(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'single')
  else
    interpete_type(Machine, 'single');
end;

procedure TTypeCommands._double(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'double')
  else
    interpete_type(Machine, 'double');
end;

procedure TTypeCommands._extended(Machine: TForthMachine; Command: PForthCommand);
begin
  if Machine.FState = FS_COMPILE then
    compile_type(Machine, 'extended')
  else
    interpete_type(Machine, 'extended');
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TAlienCommands'}{$ENDIF}
procedure TAlienCommands.lib_load(Machine: TForthMachine; Command: PForthCommand);
var
  S: TString;
  L: TLib;
  B: TInt;
begin
  //Machine.FPtrStackCommands.Pop(@P);
  S := Machine.WOS;
  L := TLib.Create(PChar(S));   
  Machine.WUP(L);
  B := BOOL_TRUE * Ord(L.Ready) + BOOL_FALSE * Ord(not L.Ready);
  Machine.WUI(B);
end;

procedure TAlienCommands.lib_unload(Machine: TForthMachine; Command: PForthCommand);
var
  L: TLib;
begin
  L := Machine.WOP;
  L.Free;
end;

procedure TAlienCommands.lib_fun(Machine: TForthMachine; Command: PForthCommand);
var
  L: TLib;
  S: TString;
  P: Pointer;
begin
  S := Machine.WOS;
  L := Machine.WOP;
  P := L.GetProcAddress(PChar(S));
  // Machine.WUI(L);
  Machine.WUP(P);
end;

procedure TAlienCommands.alien_fun(Machine: TForthMachine; Command: PForthCommand);
var
  Name: TString;
  C: PForthCommand;
  T: PType;
begin
  if Machine.State = FS_COMPILE then begin
    Machine.LogError(Command^.Name + ' command cannot work in compile mode');
    Exit;
  end;
  Name := Machine.NextName;
  New(C);
  C^.Name := StrAlloc(Length(Name) + 1);
  StrCopy(C^.Name, PChar(Name));
  //Log('Pushed command ' + C^.Name);
  Machine.WUP(C);
  T := @Machine.FTypes[0];
  Machine.WUP(T);
end;

procedure Test1(A, B: Integer); stdcall;
begin
  Log('Test1 ' + IntToStr(A - B));
end;

function Test2(A, B: Integer): Integer; stdcall;
begin
  Log('Test2 ' + IntToStr(A - B));
  Result := A - B;
end;

function Test3(A, B: TInt64): TInt64; stdcall;
begin
  Log('Test3 ' + IntToStr(A - B));
  Result := A - B;
end;

procedure TAlienCommands.alien_endfun(Machine: TForthMachine; Command: PForthCommand);
var
  Conv: Integer;
  ReturnType: PType;
  T: PType;
  Types: array of PType;
  C,C2: PForthCommand;
  P: Pointer;
  B: Byte;
  I: Integer;
  S: TInt8;
begin
  if Machine.State = FS_COMPILE then begin
    Machine.LogError(Command^.Name + ' command cannot work in compile mode');
    Exit;
  end;
  Conv := Machine.WOI;
  ReturnType := Machine.WOP;
  T := Machine.WOP;
  SetLength(Types, 0);
  while T <> @Machine.FTypes[0] do begin
    //Log(IntToStr(Length(Types)) + ': ' + T^.Name);
    SetLength(Types, Length(Types) + 1);
    Types[High(Types)] := T;
    T := Machine.WOP;
  end;
  C2 := Machine.WOP;
  //Log('Poped command ' + C2^.Name);
  C := Machine.ReserveName(TString(C2^.Name));
  StrDispose(C2^.Name);
  Dispose(C2);
  if Conv = CONV_STDCALL then 
        begin
          C^.Code := invoke_stdcall;
          C^.Data := Machine.Here;
          if C^.Name = 'test1' then
            P := @Test1
          else if C^.Name = 'test2' then
            P := @Test2;
          Move(P, Machine.Here^, SizeOf(P));
          Machine.IncHere(SizeOf(P));
          B := ReturnType^.Size;
          if B <= 8 then begin
            S := B;
            if S > 4 then
              S := 4;
            //Writeln('Return-size(1): ', S);
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
            B := B - S;
            S := B;
            if S > 4 then
              S := 4;
            //Writeln('Return-size(2): ', S);
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
            S := 0;
            //Writeln('Return-size(3): ', S);
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
          end else begin
            S := 0;
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
            S := 0;
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
            S := B;
            Move(S, Machine.Here^, SizeOf(S));
            Machine.IncHere(SizeOf(S));
          end;
          for I := 0 to High(Types) do begin
            B := Types[I]^.Size;
            while B > 0 do begin
              S := B mod 4;
              if S = 0 then
                S := 4;
              B := B - S;
              S := -S;
              Move(S, Machine.Here^, SizeOf(S));
              Machine.IncHere(SizeOf(S));
            end;
          end;
          B := 0;
          Move(B, Machine.Here^, SizeOf(B));
          Machine.IncHere(SizeOf(B));
        end
  else if Conv = CONV_CDECL then 
        begin
          C^.Code := invoke_cdecl;
          C^.Data := Machine.Here;
          P := nil;
          Move(P, Machine.Here^, SizeOf(P));
        end
  else begin
    Machine.LogError(C^.Name + ' unknown code convension');
    Exit;
  end;
  //Log('Created command ' + C^.Name);
end;

procedure TAlienCommands.invoke_stdcall(Machine: TForthMachine; Command: PForthCommand);
var
  Fun: Pointer;
  Stack: Pointer;
  Data: Pointer;
begin
  Data := Command^.Data;
  Fun := Pointer(Command^.Data^);
  Stack := Machine.WP;
  asm
    mov ebx,Stack
    mov ecx,Data
    add ecx,7 // пропускаем Fun и return-size
    jmp @startcycle
    @cycle:
      add ebx,eax
      push DWORD [ebx] // переносим очередной параметр на стек
      inc ecx
    @startcycle:
      movsx eax,BYTE [ecx] // получаем знаковое значение текущего байта
      cmp eax,0
      jnz @cycle // если 0,то выходим из цикла
    @endcycle:
      mov Stack,ebx
      call [Fun] // вызываем функцию
      mov ebx,Stack
    @readeax:
      mov ecx,Data
      movsx ecx,BYTE [ecx+4] // нужно ли читать ecx
      cmp ecx,0
      jz @readedx
      mov [ebx],eax
      add ebx,4
    @readedx:
      mov ecx,Data
      movsx ecx,BYTE [ecx+5] // нужно ли читать edx
      cmp ecx,0
      jz @readstack
      mov [ebx],edx
      add ebx,4
    @readstack:
      mov ecx,Data
      movsx ecx,BYTE [ecx+6] // что читаем со стека
      cmp ecx,0
      jz @endofcall
    @readstackloop:
      pop eax
      mov [ebx],eax
      add ebx,4
      sub ecx,4
      jnz @readstackloop
    @endofcall:
      mov Stack,ebx // запоминаем положение стека
  end;
  //Log('SUB: ' + IntToStr(TUInt(Machine.WP) - TUInt(Stack)));
  Machine.WP := Stack;
end;

procedure TAlienCommands.invoke_cdecl(Machine: TForthMachine; Command: PForthCommand);
begin
end;

procedure TAlienCommands._conv_stdcall(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(CONV_STDCALL);
end;

procedure TAlienCommands._conv_cdecl(Machine: TForthMachine; Command: PForthCommand);
begin
  Machine.WUI(CONV_CDECL);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TStringCommands'}{$ENDIF}
constructor TStringCommands.Create(Machine: TForthMachine);
begin
  FMachine := Machine;
  GetMem(FStrNil, 2*SizeOf(TInt) + 1);
  PStrRec(FStrNil)^.Ref := 1;
  PStrRec(FStrNil)^.Len := 0;
  PStrRec(FStrNil)^.Sym := #0;
end;

procedure TStringCommands.pchar_alloc(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
  Size: Integer;
begin
  Size := Machine.WOI;
  GetMem(P, Size + 1);
  Machine.WUP(P);
end;

procedure TStringCommands.pchar_free(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  P := Machine.WOP;
  FreeMem(P);
end;

procedure TStringCommands.pchar_len(Machine: TForthMachine; Command: PForthCommand);
var
  P: PByte;
  L: Integer;
begin
  P := Machine.WOP;
  L := strlen(PChar(P));
  Machine.WUI(L);
end;

procedure TStringCommands.pchar_concat(Machine: TForthMachine; Command: PForthCommand);
var
  S1,S2,D: PChar;
begin
  S2 := Machine.WOP;
  S1 := Machine.WOP;
  D := StrAlloc(StrLen(S1) + StrLen(S2) + 1);
  Move(S1^, D^, StrLen(S1));
  Move(S2^, (@(PArrayOfByte(D)^[StrLen(S1)]))^, StrLen(S2));
  D[StrLen(S1) + StrLen(S2)] := #0;
  Machine.WUP(D);
end;

procedure TStringCommands.pchar_equel(Machine: TForthMachine; Command: PForthCommand);
var
  S1,S2: PChar;
begin
  S1 := Machine.WOP;
  S2 := Machine.WOP;
  if StrComp(S1, S2) = 0 then
    Machine.WUI(BOOL_TRUE)
  else
    Machine.WUI(BOOL_FALSE)
end;

procedure TStringCommands.pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
  C: TChar;
begin
  if Machine.FState = FS_COMPILE then begin
    compile_pchar_dq(Machine, Command);
  end else begin
    SetLength(FPChars, Length(FPChars) + 1);
    SetLength(FPChars[High(FPChars)], 0); 
    C := Machine.NextChar;
    while C <> '"' do begin
      SetLength(FPChars[High(FPChars)], Length(FPChars[High(FPChars)]) + 1); 
      FPChars[High(FPChars)][High(FPChars[High(FPChars)])] := C; 
      C := Machine.NextChar;
    end; 
    SetLength(FPChars[High(FPChars)], Length(FPChars[High(FPChars)]) + 1); 
    FPChars[High(FPChars)][High(FPChars[High(FPChars)])] := #0; 
    Machine.WUP(FPChars[High(FPChars)]);
  end;
end;

procedure TStringCommands.compile_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
begin
  Machine.EWO(' pchar"');
  C := Machine.NextChar;
  while C <> '"' do begin
    Machine.EWC(C);
    C := Machine.NextChar;
  end;
  C := #0;
  Machine.EWC(C);
end;

procedure TStringCommands.run_pchar_dq(Machine: TForthMachine; Command: PForthCommand);
var
  P: Pointer;
begin
  P := @Machine.E[Machine.EC];
  Machine.WUP(P);
  while Machine.E[Machine.EC] <> 0 do
    Inc(Machine.EC);
  Inc(Machine.EC);
end;

procedure TStringCommands.pchar_dot(Machine: TForthMachine; Command: PForthCommand);
var
  S: PChar;
begin
  S := Machine.WOP;
  Write(S);
end;

procedure TStringCommands.AddRef(S: TStr);
begin
  if S = nil then 
    Exit;
  Inc(PStrRec(S)^.Ref);
  FMachine.FMemoryDebug.Log(ToStr([' + str" ', PChar(@S^.Sym[0]), '" ', S^.Ref]));
end;

procedure TStringCommands.DelRef(S: TStr);
begin
  if S = nil then 
    Exit;
  //Dec(PStrRec(S)^.Ref);
  if PStrRec(S)^.Ref < 1 then begin
    // Writeln('Free string "', PChar(@(PStrRec(S)^.Sym[0])), '"');
    FreeMem(S);
    FMachine.FMemoryDebug.Log(ToStr([' - str" ', PChar(@S^.Sym[0]), '" (free)']));
  end else
    FMachine.FMemoryDebug.Log(ToStr([' - str" ', PChar(@S^.Sym[0]), '" ', S^.Ref]));
end;

procedure TStringCommands.str_push(Machine: TForthMachine; Command: PForthCommand; S: TString);
var
  FS: TStr;
begin
  GetMem(FS, SizeOf(Integer)*2 + Length(S) + 1);
  PStrRec(FS)^.Len := Length(S);
  PStrRec(FS)^.Ref := 0;
  Move(S[1], PStrRec(FS)^.Sym[0], Length(S));
  PStrRec(FS)^.Sym[Length(S)] := #0;
  str_push(Machine, Command, FS);
end;

procedure TStringCommands.str_push(Machine: TForthMachine; Command: PForthCommand; S: TStr);
begin
  AddRef(S);
  Machine.WUP(S);
end;

function TStringCommands.str_pop(Machine: TForthMachine; Command: PForthCommand): TStr;
begin
  Result := Machine.WOP;
end;

procedure TStringCommands.str_drop(Machine: TForthMachine; Command: PForthCommand);
begin
  DelRef(str_pop(Machine, Command));
end;

procedure TStringCommands.str_dup(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  //S := str_pop(Machine, Command);
  //str_push(Machine, Command, S);
  //str_push(Machine, Command, S);
  //DelRef(S);
  with MAchine do begin
    Pointer(Machine.WP^) := Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^));
    AddRef(TStr(WP^));
    Inc(WP, SizeOf(Pointer));
  end;
end;

procedure TStringCommands.str_over(Machine: TForthMachine; Command: PForthCommand);
var
  A,B: TStr;
begin
  B := str_pop(Machine, Command);
  A := str_pop(Machine, Command);
  str_push(Machine, Command, A);
  str_push(Machine, Command, B);
  str_push(Machine, Command, A);
  DelRef(A);
  DelRef(B);
end;


procedure TStringCommands.str_len(Machine: TForthMachine; Command: PForthCommand);
begin
  S := Machine.WOP;
  Machine.WUI(PStrRec(S)^.Len);
  DelRef(S);
end;

procedure TStringCommands.str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
  Temp: array of Char;
begin
  //if Machine.FState = FS_COMPILE then begin
  //  compile_str_dq(Machine, Command);
  //end else begin
    SetLength(Temp, 0); 
    C := Machine.NextChar;
    while C <> '"' do begin
      SetLength(Temp, Length(Temp) + 1); 
      Temp[High(Temp)] := C; 
      C := Machine.NextChar;
    end; 
    GetMem(S, 2*SizeOf(TInt) + Length(Temp) + 1);
    PStrRec(S)^.Len := Length(Temp);
    PStrRec(S)^.Ref := 0;
    Move(Temp[0], PStrRec(S)^.Sym[0], Length(Temp));
    PStrRec(S)^.Sym[Length(Temp)] := #0;
    str_push(Machine, Command, S);
  //end;
end;

procedure TStringCommands.compile_str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  C: TChar;
  E: Cardinal;
  L: Integer;
begin
  Machine.EWO('(str)"');
  Machine.EWI(1);
  E := Machine.EL;
  Machine.EWI(0);
  C := Machine.NextChar;
  L := 0;
  while C <> '"' do begin
    Machine.EWC(C);
    C := Machine.NextChar;
    Inc(L);
  end;
  Machine.EWC(#0);
  Move(L, Machine.E[E], SizeOf(TInt));
end;

procedure TStringCommands.run_str_dq(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  S := @Machine.E[Machine.EC];
  str_push(Machine, Command, S);
  Inc(Machine.EC, 2*SizeOf(TInt) + PStrRec(S)^.Len + 1);
end;

procedure TStringCommands.str_equel(Machine: TForthMachine; Command: PForthCommand);
var
  A, B: TStr;
  I: Integer;
begin
  B := str_pop(Machine, Command);
  A := str_pop(Machine, Command);
  if PStrRec(A)^.Len <> PStrRec(B)^.Len then
    Machine.WUI(BOOL_FALSE)
  else begin
    (* for I := 0 to PStrRec(A)^.Len - 1 do *)
    (*   if PStrRec(A)^.Sym[I] <> PStrRec(B)^.Sym[I] then begin *)
    (*     Machine.WUI(BOOL_FALSE); *)
    (*     DelRef(A); *)
    (*     DelRef(B); *)
    (*     Exit; *)
    (*   end; *)
    (* Machine.WUI(BOOL_TRUE); *)
    if StrComp(@PStrRec(A)^.Sym[0], @PStrRec(B)^.Sym[0]) = 0 then
      Machine.WUI(BOOL_TRUE)
    else
      Machine.WUI(BOOL_FALSE);
  end;
  DelRef(A);
  DelRef(B);
end;

procedure TStringCommands.str_concat(Machine: TForthMachine; Command: PForthCommand);
var
  A, B: TStr;
begin
  B := str_pop(Machine, Command);
  A := str_pop(Machine, Command);
  GetMem(S, 2*SizeOf(TInt) + PStrRec(A)^.Len + PStrRec(B)^.Len + 1);
  PStrRec(S)^.Ref := 0;
  PStrRec(S)^.Len := PStrRec(A)^.Len + PStrRec(B)^.Len;
  Move(PStrRec(A)^.Sym[0], PStrRec(S)^.Sym[0], PStrRec(A)^.Len);
  Move(PStrRec(B)^.Sym[0], PStrRec(S)^.Sym[PStrRec(A)^.Len], PStrRec(B)^.Len);
  PStrRec(S)^.Sym[PStrRec(S)^.Len] := #0;
  DelRef(A);
  DelRef(B);
  str_push(Machine, Command, S);
end;

procedure TStringCommands.str_nil(Machine: TForthMachine; Command: PForthCommand);
begin
  str_push(Machine, Command, @FStrNil);
end;

procedure TStringCommands.str_dot(Machine: TForthMachine; Command: PForthCommand);
var
  I: Integer;
begin
  S := str_pop(Machine, Command);
  I := 0;
  while I < PStrRec(S)^.Len do begin
    if PStrRec(S)^.Sym[I] = #13{'\'} then begin
      //if PStrRec(S)^.Sym[I+1] = 'n' then begin
        Writeln;
      //  Inc(I);
      //end;
    end else
      Write(PStrRec(S)^.Sym[I]);
    Inc(I);
  end;
  DelRef(S);
end;

procedure TStringCommands.str_dollar(Machine: TForthMachine; Command: PForthCommand);
var
  P: TStr;
  S: TString;
begin
  Read(S); 
  GetMem(P, 2*SizeOf(Integer) + Length(S) + 1);
  PStrRec(P)^.Ref := 0;
  PStrRec(P)^.Len := Length(S);
  Move(S[1], PStrRec(P)^.Sym[0], Length(S));
  PStrRec(P)^.Sym[Length(S)] := #0;
  str_push(Machine, Command, P);
end;

procedure TStringCommands.str_dog(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine do begin
    Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := Pointer(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^);
    AddRef(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)));
  end;
end;

procedure TStringCommands.str_exclamation(Machine: TForthMachine; Command: PForthCommand);
begin
  with Machine do begin
    DelRef(Pointer(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^));
    Pointer(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := Pointer((Pointer(TUInt(WP) + (-2*SizeOf(Pointer)))^));
    Dec(WP, 2*SizeOf(Pointer));
    AddRef(Pointer(WP^));
  end;
end;

procedure TStringCommands.pchar_to_str(Machine: TForthMachine; Command: PForthCommand);
begin
  Dec(Machine.WP, SizeOf(Pointer));
  Machine.WUS(TString(PChar(Machine.WP^)));
end;

procedure TStringCommands.Format(Machine: TForthMachine; Command: PForthCommand);
var
  P: PChar;
  I, J: Integer;
  Sub: array of string;
  STemp: TStr;
begin
  S := str_pop(Machine, Command);
  I := S^.Len;
  while I > 0 do begin
    Dec(I);
    SetLength(Sub, Length(Sub) + 1);
    if TChar(S^.Sym[I]) = '%' then begin
      if TChar(S^.Sym[I+1]) = '%' then begin
        Sub[High(Sub)] := '%';
      end else if TChar(S^.Sym[I+1]) = 's' then begin
        STemp := str_pop(Machine, Command);
        DelRef(STemp);
      end;
    end else begin
      J := I;
      while (J >= 0) and (TChar(S^.Sym[I+1]) <> '%') do
        Dec(J);
      SetLength(Sub[High(Sub)], I - J);
      I := J;
    end;
  end;
  DelRef(S);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TForthMachine'}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'folded'}{$ENDIF}
procedure TForthMachine.AddCommand(Name: PChar; Code: TCode; Immediate: Boolean = False; Builtin: Boolean = True);
begin
  SetLength(C, Length(C) + 1);
  New(C[High(C)]);
  C[High(C)].Name := StrAlloc(StrLen(Name)+1);
  StrCopy(C[High(C)].Name, Name);
  C[High(C)].Code := Code;
  SetImmediate(C[High(C)], Immediate);
  SetBuiltin(C[High(C)], Builtin);
end;

procedure TForthMachine.CompileSource(Source: PChar);
var
  I: Integer;
begin
  FSource := Source;
  FCompilation := True;
  FState := FS_COMPILE;
  FCurrentChar := 0;
  while (not EOS) and FCompilation do begin
    FCurrentName := NextName;
    if FCurrentName = '' then
      Break;
    WriteMnemonicByName(FCurrentName);
    CompileName(@FCurrentName[1]);
  end;
  //for I := 0 to High(FEmbro) do
  //  Write(IntToHex(FEmbro[I], 2), ' ');
  //Writeln;
  FCompilation := False;
end;

procedure TForthMachine.CompileComment(Machine: TForthMachine; Command: PForthCommand);
begin
  {( это для m4}
  while Machine.NextChar <> ')' do
    if Machine.EOS then begin
      {( это для m4 }CompileError('need ")", but end of source found');
      Break;
    end;
end;

procedure TForthMachine.CompileLineComment(Machine: TForthMachine; Command: PForthCommand);
begin
  while Machine.NextChar <> #13 do
    if Machine.EOS then
      Break;
end;

function TForthMachine.NextMnemonic: Cardinal;
begin
  Result := Cardinal((@FEmbro[EC])^);
  Inc(EC, SizeOf(Cardinal));
end;

procedure TForthMachine.Run(Index: Integer);
var
  M: Cardinal;
  SavedState: Integer;
begin
  {FRunning := True;
  //FState := False;
  EC := Index;
  while FRunning and (EC < Length(FEmbro)) do begin
    M := NextMnemonic;
    if (M > High(C)) then begin
      RunError('unknown mnemonic ' + IntToStr(M));
      Break;
    end;
    if FState then  
      CompileName(C[M].Name)
    else
      RunMnemonic(M);
  end;
  FRunning := False;}
  SavedState := FState;
  FState := FS_RUN;
  while FReturnStack.GetSize > 0 do begin
    M := NextMnemonic;
    if M > High(C) then begin
      RunError('unknown mnemonic ' + IntToStr(M));
      Break;
    end;
    RunMnemonic(M);
  end;
  FState := SavedState;
end;

procedure TForthMachine.RunMnemonic(M: Cardinal);
begin
  //Writeln('RUN MNEMONIC "' + C[M].Name + '" ' + IntToStr(M) + ' EC:' + IntToStr(EC));
  C[M].Code(Self, C[M]);
end;

procedure TForthMachine.RunCommand(Command: PForthCommand);
begin
  Command^.Code(Self, Command);
end;

procedure TForthMachine.RunError(const S: TString);
begin
  Error(' Runtime: ' + S);
  FRunning := False;
end;

procedure TForthMachine.RunWarring(const S: TString);
begin
  Warrning('Runtime warring: ' + S);
end;

procedure TForthMachine.IncHere(Count: Integer);
begin
  //Inc(Here, Count);
  EA(Count);
  //if Length(FData) - FHere < 1024 then
  //  SetLength(FData, Length(FData) + 1024);
end;

procedure TForthMachine.AddType(const Name: TString; Size: Integer);
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
procedure TForthMachine.EA(Size: Integer); // Embro Alloc
begin
  Inc(EL, Size);
end;

function TForthMachine.Here: Pointer;
begin
  Result := @E[EL];
end;

procedure TForthMachine._here(Machine: TForthMachine; Command: PForthCommand);
begin
  Pointer(WP^) := @E[EL];
  Inc(WP, SizeOf(Pointer));
end;

procedure TForthMachine.EWV(V: Pointer; Size: Integer); // Embro Write Data
begin
  Move(V^, (@E[EL])^, Size);
  Inc(EL, Size);

  Inc(Chunks[High(Chunks)].Len, Size);
end;

procedure TForthMachine.EWI(V: Integer);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' ' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWE(V: TEmbroPtr);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' embro:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWO(V: TOpcode);
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

procedure TForthMachine.EWO(V: TString);
var
  I: TOpcode;
begin
  for I := High(C) downto 0 do
    if TString(C[I].Name) = V then begin
      EWO(I);
      Exit;
    end;
  FSession := False;
  LogError('command "' + V + '" not found');
end;

procedure TForthMachine.EWR(V: TOpcode);
begin
  // TODO
end;

procedure TForthMachine.EWI8(V: TInt8);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int8:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWI16(V: TInt16);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int16:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWI32(V: TInt32);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int32:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWI64(V: TInt64);
begin
  EWV(@V, SizeOf(V));
  
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' int64:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWU(V: TUInt);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' u' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWU8(V: TUInt8);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint8:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWU16(V: TUInt16);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint16:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWU32(V: TUInt32);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint32:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWU64(V: TUInt64);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' uint64:' + IntToStr(V) + ' ';
end;

procedure TForthMachine.EWC(V: Char);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + V;
end;

procedure TForthMachine.EWS(V: Single);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' s' + FloatToStr(V) + ' ';
end;

procedure TForthMachine.EWD(const V: Double);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' d' + FloatToStr(V) + ' ';
end;

procedure TForthMachine.EWExtended(const V: Extended);
begin
  EWV(@V, SizeOf(V));

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' e' + FloatToStr(V) + ' ';
end;

procedure TForthMachine.EWPChar(V: PChar);
begin
  // TODO
end;

function CreateStr(const S: TString): TStr;
begin
  GetMem(Result, SizeOf(Integer)*2 + Length(S) + 1);
  PStrRec(Result)^.Ref := 0;
  PStrRec(Result)^.Len := Length(S);
  Move(S[1], PStrRec(Result)^.Sym[0], Length(S));
  PStrRec(Result)^.Sym[LengtH(S)] := #0;
end;

procedure TForthMachine.EWStr(V: TString);
var
  S: TStr;
begin
  S := CreateStr(V);
  PStrRec(S)^.Ref := 1;
  EWV(S, SizeOf(Integer)*2 + PStrRec(S)^.Len + 1);

  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' "' + V + '" ';
end;

procedure TForthMachine.ERV(V: Pointer; Size: Integer);
begin
  Move((@E[EC])^, V^, Size);
  Inc(EC, Size);
end;

function TForthMachine.ERI: Integer;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERE: TEmbroPtr;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERO: TOpcode;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERI8: TInt8;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERI16: TInt16;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERI32: TInt32;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERI64: TInt64;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERU: TUInt;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERU8: TUInt8;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERU16: TUInt16;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERU32: TUInt32;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERU64: TUInt64;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERC: Char;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERS: Single;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERD: Double;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERExtended: Extended;
begin
  ERV(@Result, SizeOf(Result));
end;

function TForthMachine.ERPChar: PChar;
begin
  // TODO
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'D'}{$ENDIF}
{procedure TForthMachine.DA(Size: Integer);
begin
  Inc(Here, Size);
end;}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'S'}{$ENDIF}
function TForthMachine.SE: Boolean;
begin
  Result := S[SC] = #0;
end;

function TForthMachine.SNC: TChar;
begin
  Result := S[SC];
  if not SE then
    Inc(SC);
end;

function TForthMachine.SNN: TString;
var
  C: TChar;
begin
  Result := '';
  repeat
    C := SNC;
  until (not (C in [#0..#32])) or SE;
  repeat
    Result := Result + C;
    if SE then
      Exit;
    C := SNC;
  until (C in [#0..#32]) or SE;
  if not (C in [#0..#32]) then
    Result := Result + C;
end;

procedure TForthMachine.SSS;
begin
  while (not SE) and (S[SC] in [#1..#32]) do
    SNC;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'R'}{$ENDIF}
procedure TForthMachine.RUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, RP^, Size);
  Inc(RP, Size);
end;

procedure TForthMachine.ROV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(RP^, P^, Size);
  Dec(RP, Size);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'W'}{$ENDIF}
procedure TForthMachine.WUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, WP^, Size);
  Inc(WP, Size);
end;

procedure TForthMachine.WOV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(WP^, P^, Size);
  Dec(WP, Size);
end;

procedure TForthMachine.WUS(const S: TString);
begin
  FStringCommands.str_push(Self, nil, S);
end;

function TForthMachine.WOS: TString;
var
  S: PStrRec;
begin
  S := FStringCommands.str_pop(Self, nil);
  Result := TString(PChar(@S^.Sym[0]));
  FStringCommands.DelRef(S);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'L'}{$ENDIF}
procedure TForthMachine.LUV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(P^, LP^, Size);
  Inc(LP, Size);
end;

procedure TForthMachine.LOV(const P: Pointer; Size: Integer);
begin
  if P <> nil then
    Move(LP^, P^, Size);
  Dec(LP, Size);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

constructor TForthMachine.Create;
var
{$IFNDEF FLAG_FPC}{$REGION 'blocks of commands'}{$ENDIF}
  IntArithmetic:    TIntArithmetic;
  Int8Arithmetic:   TInt8Arithmetic;
  Int16Arithmetic:  TInt16Arithmetic;
  Int32Arithmetic:  TInt32Arithmetic;
  Int64Arithmetic:  TInt64Arithmetic;
  UIntArithmetic:   TUIntArithmetic;
  UInt8Arithmetic:  TUInt8Arithmetic;
  UInt16Arithmetic: TUInt16Arithmetic;
  UInt32Arithmetic: TUInt32Arithmetic;
  UInt64Arithmetic: TUInt64Arithmetic;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
begin
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
  SetLength(C,   0);
  CB := @C[0];
  CC := 0;
  CS := Length(C);
  WordListClear(Local);
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
  FUserData := nil;
  FState := FS_INTERPRET;
  FStack := TForthStack.Create;
  FReturnStack := TReturnStack.Create;
  SetLength(FData, 2048);
  //FHere := 0;
  FMemoryDebug := TDebug.Create('memory.tmp');
  FMemoryDebug.Console := False;

  // it must have zero opcode
  AddCommand('exit', FControlCommands._exit);

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
  AddType('single', SizeOf(PType));
  AddType('double', SizeOf(PType));
  AddType('extended', SizeOf(PType));

  FControlCommands := TControlCommands.Create(Self);
  FEmbroCommands := TEmbroCommands.Create;
  FDataCommands := TDataCommands.Create;
  FAlienCommands := TAlienCommands.Create;
  FStackCommands   := TStackCommands.Create(Self, SizeOf(TInt));
  FStackCommands8  := TStackCommands.Create(Self, 1);
  FStackCommands16 := TStackCommands.Create(Self, 2);
  FStackCommands32 := TStackCommands.Create(Self, 4);
  FStackCommands64 := TStackCommands.Create(Self, 8);
  FPtrStackCommands := FStackCommands32;
  IntArithmetic := TIntArithmetic.Create(Self);
  Int8Arithmetic := TInt8Arithmetic.Create(Self);
  Int16Arithmetic := TInt16Arithmetic.Create(Self);
  Int32Arithmetic := TInt32Arithmetic.Create(Self);
  Int64Arithmetic := TInt64Arithmetic.Create(Self);
  UIntArithmetic := TUIntArithmetic.Create(Self);
  UInt8Arithmetic := TUInt8Arithmetic.Create(Self);
  UInt16Arithmetic := TUInt16Arithmetic.Create(Self);
  UInt32Arithmetic := TUInt32Arithmetic.Create(Self);
  UInt64Arithmetic := TUInt64Arithmetic.Create(Self);
  FStringCommands := TStringCommands.Create(Self);

  AddCommand('exit', FControlCommands._exit);
  AddCommand('(', CompileComment, True); {) для m4}
  AddCommand('//', CompileLineComment, True);
(*
{$IFNDEF FLAG_FPC}{$REGION 'stack commands'}{$ENDIF}
  AddCommand('int-push', FStackCommands._push, True);
  AddCommand('int-drop', FStackCommands.drop);
  AddCommand('int-dup',  FStackCommands.dup);
  AddCommand('int-swap', FStackCommands.swap);
  AddCommand('int-over', FStackCommands.over);
  AddCommand('int-rot',  FStackCommands.lrot);
  AddCommand('int-lrot', FStackCommands.lrot);
  AddCommand('int-rrot', FStackCommands.rrot);
  AddCommand('int-lrotn', FStackCommands.lrotn);
  AddCommand('int-rrotn', FStackCommands.rrotn);
  AddCommand('uint-drop', FStackCommands.drop);
  AddCommand('uint-dup',  FStackCommands.dup);
  AddCommand('uint-swap', FStackCommands.swap);
  AddCommand('uint-over', FStackCommands.over);
  AddCommand('uint-rot',  FStackCommands.lrot);
  AddCommand('uint-lrot', FStackCommands.lrot);
  AddCommand('uint-rrot', FStackCommands.rrot);
  AddCommand('uint-lrotn', FStackCommands.lrotn);
  AddCommand('uint-rrotn', FStackCommands.rrotn);
  AddCommand('bool-drop', FStackCommands.drop);
  AddCommand('bool-dup',  FStackCommands.dup);
  AddCommand('bool-swap', FStackCommands.swap);
  AddCommand('bool-over', FStackCommands.over);
  AddCommand('bool-rot',  FStackCommands.lrot);
  AddCommand('bool-lrot', FStackCommands.lrot);
  AddCommand('bool-rrot', FStackCommands.rrot);
  ommands.lrotn);
  AddCommand('bool-rrotn', FStackCommands.rrotn);
  AddCommand('drop', FStackCommands.drop);
  AddCommand('dup',  FStackCommands.dup);
  AddCommand('swap', FStackCommands.swap);
  AddCommand('over', FStackCommands.over);
  AddCommand('rot',  FStackCommands.lrot);
  AddCommand('lrot', FStackCommands.lrot);
  AddCommand('rrot', FStackCommands.rrot);
  AddCommand('lrotn', FStackCommands.lrotn);
  AddCommand('rrotn', FStackCommands.rrotn);
  AddCommand('int8-drop', FStackCommands8.drop);
  AddCommand('int8-dup',  FStackCommands8.dup);
  AddCommand('int8-swap', FStackCommands8.swap);
  AddCommand('int8-over', FStackCommands8.over);
  AddCommand('int8-rot',  FStackCommands8.lrot);
  AddCommand('int8-lrot', FStackCommands8.lrot);
  AddCommand('int8-lrotn', FStackCommands8.lrotn);
  AddCommand('int8-rrotn', FStackCommands8.rrotn);
  AddCommand('int16-drop', FStackCommands16.drop);
  AddCommand('int16-dup',  FStackCommands16.dup);
  AddCommand('int16-swap', FStackCommands16.swap);
  AddCommand('int16-over', FStackCommands16.over);
  AddCommand('int16-rot',  FStackCommands16.lrot);
  AddCommand('int16-lrot', FStackCommands16.lrot);
  AddCommand('int16-lrotn', FStackCommands16.lrotn);
  AddCommand('int16-rrotn', FStackCommands16.rrotn);
  AddCommand('int32-drop', FStackCommands32.drop);
  AddCommand('int32-dup',  FStackCommands32.dup);
  AddCommand('int32-swap', FStackCommands32.swap);
  AddCommand('int32-over', FStackCommands32.over);
  AddCommand('int32-rot',  FStackCommands32.lrot);
  AddCommand('int32-lrot', FStackCommands32.lrot);
  AddCommand('int32-lrotn', FStackCommands32.lrotn);
  AddCommand('int32-rrotn', FStackCommands32.rrotn);
  AddCommand('int64-drop', FStackCommands64.drop);
  AddCommand('int64-dup',  FStackCommands64.dup);
  AddCommand('int64-swap', FStackCommands64.swap);
  AddCommand('int64-over', FStackCommands64.over);
  AddCommand('int64-rot',  FStackCommands64.lrot);
  AddCommand('int64-lrot', FStackCommands64.lrot);
  AddCommand('int64-lrotn', FStackCommands64.lrotn);
  AddCommand('int64-rrotn', FStackCommands64.rrotn);
  AddCommand('uint8-drop', FStackCommands8.drop);
  AddCommand('uint8-dup',  FStackCommands8.dup);
  AddCommand('uint8-swap', FStackCommands8.swap);
  AddCommand('uint8-over', FStackCommands8.over);
  AddCommand('uint8-rot',  FStackCommands8.lrot);
  AddCommand('uint8-lrot', FStackCommands8.lrot);
  AddCommand('int8-lrotn', FStackCommands8.lrotn);
  AddCommand('int8-rrotn', FStackCommands8.rrotn);
  AddCommand('uint16-drop', FStackCommands16.drop);
  AddCommand('uint16-dup',  FStackCommands16.dup);
  AddCommand('uint16-swap', FStackCommands16.swap);
  AddCommand('uint16-over', FStackCommands16.over);
  AddCommand('uint16-rot',  FStackCommands16.lrot);
  AddCommand('uint16-lrot', FStackCommands16.lrot);
  AddCommand('int16-lrotn', FStackCommands16.lrotn);
  AddCommand('int16-rrotn', FStackCommands16.rrotn);
  AddCommand('uint32-drop', FStackCommands32.drop);
  AddCommand('uint32-dup',  FStackCommands32.dup);
  AddCommand('uint32-swap', FStackCommands32.swap);
  AddCommand('uint32-over', FStackCommands32.over);
  AddCommand('uint32-rot',  FStackCommands32.lrot);
  AddCommand('uint32-lrot', FStackCommands32.lrot);
  AddCommand('int32-lrotn', FStackCommands32.lrotn);
  AddCommand('int32-rrotn', FStackCommands32.rrotn);
  AddCommand('uint64-drop', FStackCommands64.drop);
  AddCommand('uint64-dup',  FStackCommands64.dup);
  AddCommand('uint64-swap', FStackCommands64.swap);
  AddCommand('uint64-over', FStackCommands64.over);
  AddCommand('uint64-rot',  FStackCommands64.lrot);
  AddCommand('uint64-lrot', FStackCommands64.lrot);
  AddCommand('int64-lrotn', FStackCommands64.lrotn);
  AddCommand('int64-rrotn', FStackCommands64.rrotn);
  AddCommand('ptr-drop', FPtrStackCommands.drop);
  AddCommand('ptr-dup',  FPtrStackCommands.dup);
  AddCommand('ptr-swap', FPtrStackCommands.swap);
  AddCommand('ptr-over', FPtrStackCommands.over);
  AddCommand('ptr-rot',  FPtrStackCommands.lrot);
  AddCommand('ptr-lrot', FPtrStackCommands.lrot);
  AddCommand('ptr-rrot', FPtrStackCommands.rrot);
  AddCommand('ptr-lrotn', FPtrStackCommands.lrotn);
  AddCommand('ptr-rrotn', FPtrStackCommands.rrotn);
  AddCommand('pchar-drop', FPtrStackCommands.drop);
  AddCommand('pchar-dup',  FPtrStackCommands.dup);
  AddCommand('pchar-swap', FPtrStackCommands.swap);
  AddCommand('pchar-over', FPtrStackCommands.over);
  AddCommand('pchar-rot',  FPtrStackCommands.lrot);
  AddCommand('pchar-lrot', FPtrStackCommands.lrot);
  AddCommand('pchar-rrot', FPtrStackCommands.rrot);
  AddCommand('pchar-lrotn', FPtrStackCommands.lrotn);
  AddCommand('pchar-rrotn', FPtrStackCommands.rrotn);
  AddCommand('type-drop', FPtrStackCommands.drop);
  AddCommand('type-dup',  FPtrStackCommands.dup);
  AddCommand('type-swap', FPtrStackCommands.swap);
  AddCommand('type-over', FPtrStackCommands.over);
  AddCommand('type-rot',  FPtrStackCommands.lrot);
  AddCommand('type-lrot', FPtrStackCommands.lrot);
  AddCommand('type-rrot', FPtrStackCommands.rrot);
  AddCommand('type-lrotn', FPtrStackCommands.lrotn);
  AddCommand('type-rrotn', FPtrStackCommands.rrotn);
  AddCommand('embro-drop', FStackCommands.drop);
  AddCommand('embro-dup',  FStackCommands.dup);
  AddCommand('embro-swap', FStackCommands.swap);
  AddCommand('embro-over', FStackCommands.over);
  AddCommand('embro-rot',  FStackCommands.lrot);
  AddCommand('embro-lrot', FStackCommands.lrot);
  AddCommand('embro-rrot', FStackCommands.rrot);
  AddCommand('embro-lrotn', FStackCommands.lrotn);
  AddCommand('embro-rrotn', FStackCommands.rrotn);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
*)
{$IFNDEF FLAG_FPC}{$REGION 'control commands'}{$ENDIF}
  AddCommand(':', FControlCommands.compile_def);
  AddCommand(':noname', FControlCommands.compile_noname);
  AddCommand(';', FControlCommands.compile_enddef, True);
  AddCommand('skip-to;', FControlCommands.compile_enddef, True);
  AddCommand('...', FControlCommands.scattered_dots, True);
  AddCommand('..:', FControlCommands.compile_scattered_def);
  AddCommand(';..', FControlCommands.compile_scattered_enddef, True);
  AddCommand('branch', FControlCommands.branch);
  AddCommand('?branch', FControlCommands._ask_branch);
  AddCommand('>mark', FControlCommands._gt_mark);
  AddCommand('>resolve', FControlCommands._gt_resolve);
  AddCommand('<mark', FControlCommands._lt_mark);
  AddCommand('<resolve', FControlCommands._lt_resolve);
  AddCommand('recurse', FControlCommands.recurse, True);
  AddCommand('immediate', FControlCommands.immediate);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'embro commands'}{$ENDIF}
  AddCommand('compile', FEmbroCommands.compile, True);
  //AddCommand('execute', FEmbroCommands.execute, True);
  AddCommand('evaluate', Evaluate);
  AddCommand('evaluate-file', EvaluateFile);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'data commands'}{$ENDIF}
  AddCommand('nil', FDataCommands._nil);
  AddCommand('ptr,', FDataCommands.ptr_comma);

  {AddCommand('bool@', FStackCommands._dog);
  AddCommand('int@', FStackCommands._dog);
  AddCommand('int8@', FStackCommands8._dog);
  AddCommand('int16@', FStackCommands16._dog);
  AddCommand('int32@', FStackCommands32._dog);
  AddCommand('int64@', FStackCommands64._dog);
  AddCommand('uint@', FStackCommands._dog);
  AddCommand('uint8@', FStackCommands8._dog);
  AddCommand('uint16@', FStackCommands16._dog);
  AddCommand('uint32@', FStackCommands32._dog);
  AddCommand('uint64@', FStackCommands64._dog);
  AddCommand('ptr@', FPtrStackCommands._dog);
  AddCommand('bool!', FStackCommands._exclamation);
  AddCommand('int!', FStackCommands._exclamation);
  AddCommand('int8!', FStackCommands8._exclamation);
  AddCommand('int16!', FStackCommands16._exclamation);
  AddCommand('int32!', FStackCommands32._exclamation);
  AddCommand('int64!', FStackCommands64._exclamation);
  AddCommand('uint!', FStackCommands._exclamation);
  AddCommand('uint8!', FStackCommands8._exclamation);
  AddCommand('uint16!', FStackCommands16._exclamation);
  AddCommand('uint32!', FStackCommands32._exclamation);
  AddCommand('uint64!', FStackCommands64._exclamation);
  AddCommand('ptr!', FPtrStackCommands._exclamation);

  AddCommand('int-to', FDataCommands.to_int, True);
  AddCommand('int8-to', FDataCommands.to_int8, True);
  AddCommand('int16-to', FDataCommands.to_int16, True);
  AddCommand('int32-to', FDataCommands.to_int32, True);
  AddCommand('int64-to', FDataCommands.to_int64, True);
  AddCommand('uint-to', FDataCommands.to_uint, True);
  AddCommand('uint8-to', FDataCommands.to_uint8, True);
  AddCommand('uint16-to', FDataCommands.to_uint16, True);
  AddCommand('uint32-to', FDataCommands.to_uint32, True);
  AddCommand('uint64-to', FDataCommands.to_uint64, True);
  AddCommand('ptr-to', FDataCommands.to_ptr, True);
  AddCommand('pchar-to', FDataCommands.to_ptr, True);
  AddCommand(' to', FDataCommands.run_to);
  AddCommand(' 8to', FDataCommands.run_8to);
  AddCommand(' 16to', FDataCommands.run_16to);
  AddCommand(' 32to', FDataCommands.run_32to);
  AddCommand(' 64to', FDataCommands.run_64to);}

  AddCommand('create', FDataCommands._create);
  AddCommand('created', FDataCommands._created);
  AddCommand('here', _here);
  AddCommand('allot', FDataCommands.allot);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
(*
{$IFNDEF FLAG_FPC}{$REGION 'arithmetic'}{$ENDIF}
  AddCommand('int+', IntArithmetic._plus);
  AddCommand('int-', IntArithmetic._minus);
  AddCommand('int*', IntArithmetic._star);
  AddCommand('int=', IntArithmetic._equel);
  AddCommand('int<', IntArithmetic._lt);
  AddCommand('int>', IntArithmetic._gt);
  AddCommand('int-div', IntArithmetic._div);
  AddCommand('int-mod', IntArithmetic._mod);
  AddCommand('int.', IntArithmetic._dot);
  AddCommand('int-abs', IntArithmetic._abs);
  AddCommand('int-neg', IntArithmetic.neg);
  AddCommand('int,', IntArithmetic._comma);
  AddCommand('+', IntArithmetic._plus);
  AddCommand('-', IntArithmetic._minus);
  AddCommand('*', IntArithmetic._star);
  AddCommand('=', IntArithmetic._equel);
  AddCommand('<', IntArithmetic._lt);
  AddCommand('>', IntArithmetic._gt);
  AddCommand('div', IntArithmetic._div);
  AddCommand('mod', IntArithmetic._mod);
  AddCommand('.', IntArithmetic._dot);
  AddCommand('abs', IntArithmetic._abs);
  AddCommand('neg', IntArithmetic.neg);
  AddCommand(',', IntArithmetic._comma);
  AddCommand('int8+', Int8Arithmetic._plus);
  AddCommand('int8-', Int8Arithmetic._minus);
  AddCommand('int8*', Int8Arithmetic._star);
  AddCommand('int8=', Int8Arithmetic._equel);
  AddCommand('int8<', Int8Arithmetic._lt);
  AddCommand('int8>', Int8Arithmetic._gt);
  AddCommand('int8-div', Int8Arithmetic._div);
  AddCommand('int8-mod', Int8Arithmetic._mod);
  AddCommand('int8.', Int8Arithmetic._dot);
  AddCommand('int8-abs', Int8Arithmetic._abs);
  AddCommand('int8-neg', Int8Arithmetic.neg);
  AddCommand('int8,', Int8Arithmetic._comma);
  AddCommand('int16+', Int16Arithmetic._plus);
  AddCommand('int16-', Int16Arithmetic._minus);
  AddCommand('int16*', Int16Arithmetic._star);
  AddCommand('int16=', Int16Arithmetic._equel);
  AddCommand('int16<', Int16Arithmetic._lt);
  AddCommand('int16>', Int16Arithmetic._gt);
  AddCommand('int16-div', Int16Arithmetic._div);
  AddCommand('int16-mod', Int16Arithmetic._mod);
  AddCommand('int16.', Int16Arithmetic._dot);
  AddCommand('int16-abs', Int16Arithmetic._abs);
  AddCommand('int16-neg', Int16Arithmetic.neg);
  AddCommand('int16,', Int16Arithmetic._comma);
  AddCommand('int32+', Int32Arithmetic._plus);
  AddCommand('int32-', Int32Arithmetic._minus);
  AddCommand('int32*', Int32Arithmetic._star);
  AddCommand('int32=', Int32Arithmetic._equel);
  AddCommand('int32<', Int32Arithmetic._lt);
  AddCommand('int32>', Int32Arithmetic._gt);
  AddCommand('int32-div', Int32Arithmetic._div);
  AddCommand('int32-mod', Int32Arithmetic._mod);
  AddCommand('int32.', Int32Arithmetic._dot);
  AddCommand('int32-abs', Int32Arithmetic._abs);
  AddCommand('int32-neg', Int32Arithmetic.neg);
  AddCommand('int32,', Int32Arithmetic._comma);
  AddCommand('int64+', Int64Arithmetic._plus);
  AddCommand('int64-', Int64Arithmetic._minus);
  AddCommand('int64*', Int64Arithmetic._star);
  AddCommand('int64=', Int64Arithmetic._equel);
  AddCommand('int64<', Int64Arithmetic._lt);
  AddCommand('int64>', Int64Arithmetic._gt);
  AddCommand('int64-div', Int64Arithmetic._div);
  AddCommand('int64-mod', Int64Arithmetic._mod);
  AddCommand('int64.', Int64Arithmetic._dot);
  AddCommand('int64-abs', Int64Arithmetic._abs);
  AddCommand('int64-neg', Int64Arithmetic.neg);
  AddCommand('int64,', Int64Arithmetic._comma);
  AddCommand('uint+', UintArithmetic._plus);
  AddCommand('uint-', UintArithmetic._minus);
  AddCommand('uint*', UintArithmetic._star);
  AddCommand('uint-div', UintArithmetic._div);
  AddCommand('uint-mod', UintArithmetic._mod);
  AddCommand('uint.', UIntArithmetic._dot);
  AddCommand('uint,', UIntArithmetic._comma);
  AddCommand('uint8+', Uint8Arithmetic._plus);
  AddCommand('uint8-', Uint8Arithmetic._minus);
  AddCommand('uint8*', Uint8Arithmetic._star);
  AddCommand('uint8=', UInt8Arithmetic._equel);
  AddCommand('uint8<', UInt8Arithmetic._lt);
  AddCommand('uint8>', UInt8Arithmetic._gt);
  AddCommand('uint8-div', Uint8Arithmetic._div);
  AddCommand('uint8-mod', Uint8Arithmetic._mod);
  AddCommand('uint8.', UInt8Arithmetic._dot);
  AddCommand('uint8,', UInt8Arithmetic._comma);
  AddCommand('uint16+', Uint16Arithmetic._plus);
  AddCommand('uint16-', Uint16Arithmetic._minus);
  AddCommand('uint16*', Uint16Arithmetic._star);
  AddCommand('uint16=', UInt16Arithmetic._equel);
  AddCommand('uint16<', UInt16Arithmetic._lt);
  AddCommand('uint16>', UInt16Arithmetic._gt);
  AddCommand('uint16-div', Uint16Arithmetic._div);
  AddCommand('uint16-mod', Uint16Arithmetic._mod);
  AddCommand('uint16.', UInt16Arithmetic._dot);
  AddCommand('uint16,', UInt16Arithmetic._comma);
  AddCommand('uint32+', Uint32Arithmetic._plus);
  AddCommand('uint32-', Uint32Arithmetic._minus);
  AddCommand('uint32*', Uint32Arithmetic._star);
  AddCommand('uint32=', UInt32Arithmetic._equel);
  AddCommand('uint32<', UInt32Arithmetic._lt);
  AddCommand('uint32>', UInt32Arithmetic._gt);
  AddCommand('uint32.', UInt32Arithmetic._dot);
  AddCommand('uint32-div', Uint32Arithmetic._div);
  AddCommand('uint32-mod', Uint32Arithmetic._mod);
  AddCommand('uint32,', UInt32Arithmetic._comma);
  AddCommand('uint64+', Uint64Arithmetic._plus);
  AddCommand('uint64-', Uint64Arithmetic._minus);
  AddCommand('uint64*', Uint64Arithmetic._star);
  AddCommand('uint64=', UInt64Arithmetic._equel);
  AddCommand('uint64<', UInt64Arithmetic._lt);
  AddCommand('uint64>', UInt64Arithmetic._gt);
  AddCommand('uint64-div', Uint64Arithmetic._div);
  AddCommand('uint64-mod', Uint64Arithmetic._mod);
  AddCommand('uint64.', UInt64Arithmetic._dot);
  AddCommand('uint64,', UInt64Arithmetic._comma);

  AddCommand('int8->int', Int8Arithmetic.ToInt);
  AddCommand('int->int8', Int8Arithmetic.FromInt);
  AddCommand('int16->int', Int16Arithmetic.ToInt);
  AddCommand('int->int16', Int16Arithmetic.FromInt);
  AddCommand('int32->int', Int32Arithmetic.ToInt);
  AddCommand('int->int32', Int32Arithmetic.FromInt);
  AddCommand('int64->int', Int64Arithmetic.ToInt);
  AddCommand('int->int64', Int64Arithmetic.FromInt);
  AddCommand('uint8->uint', UInt8Arithmetic.ToInt);
  AddCommand('uint->uint8', UInt8Arithmetic.FromInt);
  AddCommand('uint16->uint', UInt16Arithmetic.ToInt);
  AddCommand('uint->uint16', UInt16Arithmetic.FromInt);
  AddCommand('uint32->uint', UInt32Arithmetic.ToInt);
  AddCommand('uint->uint32', UInt32Arithmetic.FromInt);
  AddCommand('uint64->uint', UInt64Arithmetic.ToInt);
  AddCommand('uint->uint64', UInt64Arithmetic.FromInt);

  FIntArithmetic := IntArithmetic;
  FInt8Arithmetic := Int8Arithmetic;
  FInt16Arithmetic := Int16Arithmetic;
  FInt32Arithmetic := Int32Arithmetic;
  FInt64Arithmetic := Int64Arithmetic;
  FUIntArithmetic := UIntArithmetic;
  FUInt8Arithmetic := UInt8Arithmetic;
  FUInt16Arithmetic := UInt16Arithmetic;
  FUInt32Arithmetic := UInt32Arithmetic;
  FUInt64Arithmetic := UInt64Arithmetic;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
*)
{$IFNDEF FLAG_FPC}{$REGION 'bool'}{$ENDIF}
  FBoolCommands := TBoolCommands.Create(Self);
  AddCommand('bool-push', FBoolCommands.push, True);
  AddCommand('bool-false', FBoolCommands._false);
  AddCommand('bool-true', FBoolCommands._true);
  AddCommand('bool-not', FBoolCommands._not);
  AddCommand('bool-or', FBoolCommands._or);
  AddCommand('bool-and', FBoolCommands._and);
  AddCommand('bool-xor', FBoolCommands._xor);
  AddCommand('bool.', FBoolCommands._dot);
  AddCommand('false', FBoolCommands._false);
  AddCommand('true', FBoolCommands._true);
  AddCommand('not', FBoolCommands._not);
  AddCommand('or', FBoolCommands._or);
  AddCommand('and', FBoolCommands._and);
  AddCommand('xor', FBoolCommands._xor);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'type commands'}{$ENDIF}
  AddCommand('typeof', FTypeCommands.typeof, True);
  AddCommand(' typeof', FTypeCommands.run_type);
  AddCommand('type-size', FTypeCommands.type_size);
  AddCommand('t_void', FTypeCommands._void, True);
  AddCommand('t_int', FTypeCommands._int, True);
  AddCommand('t_int8', FTypeCommands._int8, True);
  AddCommand('t_int16', FTypeCommands._int16, True);
  AddCommand('t_int32', FTypeCommands._int32, True);
  AddCommand('t_int64', FTypeCommands._int64, True);
  AddCommand('t_uint', FTypeCommands._uint, True);
  AddCommand('t_uint8', FTypeCommands._uint8, True);
  AddCommand('t_uint16', FTypeCommands._uint16, True);
  AddCommand('t_uint32', FTypeCommands._uint32, True);
  AddCommand('t_uint64', FTypeCommands._uint64, True);
  AddCommand('t_bool', FTypeCommands._bool, True);
  AddCommand('t_str', FTypeCommands._str, True);
  AddCommand('t_pchar', FTypeCommands._pchar, True);
  AddCommand('t_ptr', FTypeCommands._ptr, True);
  AddCommand('t_type', FTypeCommands._type, True);
  AddCommand('t_single', FTypeCommands._single, True);
  AddCommand('t_double', FTypeCommands._double, True);
  AddCommand('t_extended', FTypeCommands._extended, True);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'alien commands'}{$ENDIF}
  AddCommand('lib-load', FAlienCommands.lib_load);
  AddCommand('lib-unload', FAlienCommands.lib_unload);
  AddCommand('lib-fun', FAlienCommands.lib_fun);
  AddCommand(':a', FAlienCommands.alien_fun);
  AddCommand('a;', FAlienCommands.alien_endfun);
  AddCommand('stdcall', FAlienCommands._conv_stdcall);
  AddCommand('cdecl', FAlienCommands._conv_cdecl);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'string commands'}{$ENDIF}
  AddCommand('pchar"', FStringCommands.pchar_dq, True);
  AddCommand(' pchar"', FStringCommands.run_pchar_dq);
  AddCommand('pchar.', FStringCommands.pchar_dot);
  AddCommand('pchar-alloc', FStringCommands.pchar_alloc);
  AddCommand('pchar-free', FStringCommands.pchar_free);
  AddCommand('pchar-len', FStringCommands.pchar_len);
  AddCommand('pchar-concat', FStringCommands.pchar_concat);
  AddCommand('pchar=', FStringCommands.pchar_equel);

  AddCommand('str"', FStringCommands.str_dq);
  AddCommand('[str]"', FStringCommands.compile_str_dq, True);
  AddCommand('(str)"', FStringCommands.run_str_dq);
  AddCommand('str.', FStringCommands.str_dot);
  AddCommand('str$', FStringCommands.str_dollar);
  AddCommand('str@', FStringCommands.str_dog);
  AddCommand('str!', FStringCommands.str_exclamation);
  AddCommand('str-len', FStringCommands.str_len);
  AddCommand('str=', FStringCommands.str_equel);
  AddCommand('str-nil', FStringCommands.str_nil);
  AddCommand('str-concat', FStringCommands.str_concat);
  AddCommand('str-drop', FStringCommands.str_drop);
  AddCommand('str-dup', FStringCommands.str_dup);
  AddCommand('str-swap', FPtrStackCommands.swap);
  AddCommand('str-over', FStringCommands.str_over);
  AddCommand('str-rot', FPtrStackCommands.lrot);
  AddCommand('str-lrot', FPtrStackCommands.lrot);
  AddCommand('str-rrot', FPtrStackCommands.rrot);
  AddCommand('str-lrotn', FPtrStackCommands.lrotn);
  AddCommand('str-rrotn', FPtrStackCommands.rrotn);
  AddCommand('pchar->str', FStringCommands.pchar_to_str);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'console commands'}{$ENDIF}
  FConsoleCommands := TConsoleCommands.Create(Self);
  AddCommand('cr', FConsoleCommands.cr);
  AddCommand('emit', FConsoleCommands.emit);
  AddCommand('space', FConsoleCommands.space);
  AddCommand('spaces', FConsoleCommands.spaces);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  
    
     AddCommand('drop', drop_);
     AddCommand('dup', dup_);
     AddCommand('nip', nip_);
     AddCommand('swap', swap_);
     AddCommand('over', over_);
     AddCommand('tuck', tuck_);
     AddCommand('lrot', lrot_);
     AddCommand('rrot', rrot_);
     AddCommand('lrotn', lrotn_);
     AddCommand('rrotn', rrotn_);
     AddCommand('pick', pick_);
     AddCommand(',', _comma_);
     AddCommand('@', _dog_);
     AddCommand('!', _exclamation_);
     AddCommand('ptr+', ptr_plus_);
     AddCommand('to', _to_, True);
     AddCommand('compile@to', _compile_to_);
     AddCommand('run@to', _run_to_);
     AddCommand('interpret@to', _interpret_to_);
     AddCommand('value', _value_);
     AddCommand('constant', _value_);
     AddCommand('variable', _variable_);
     AddCommand('literal', literal_, True);
     AddCommand('(literal)', run_literal_);
    
    
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
     AddCommand('0;', _0_exit);
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
     AddCommand('int-0;', int_0_exit);
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
     AddCommand('int8-0;', int8_0_exit);
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
     AddCommand('int16-0;', int16_0_exit);
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
     AddCommand('int32-0;', int32_0_exit);
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
     AddCommand('int64-0;', int64_0_exit);
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
     AddCommand('uint-0;', uint_0_exit);
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
     AddCommand('uint8-0;', uint8_0_exit);
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
     AddCommand('uint16-0;', uint16_0_exit);
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
     AddCommand('uint32-0;', uint32_0_exit);
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
     AddCommand('uint64-0;', uint64_0_exit);
     AddCommand('uint64-min', uint64_min);
     AddCommand('uint64-max', uint64_max);
     AddCommand('uint64-minmax', uint64_minmax);
     AddCommand('uint64.', uint64_dot);
     AddCommand('uint64$', uint64_dollar);
     AddCommand('uint64+!', uint64_ptr_plus_exclamation);
     AddCommand('uint64->str', uint64_conv_to_str);
     AddCommand('str->uint64', uint64_conv_from_str);
    
    
     AddCommand('single+', single_plus);
     AddCommand('single-', single_minus);
     AddCommand('single*', single_star);
     AddCommand('single=', single_equel);
     AddCommand('single<>', single_nequel);
     AddCommand('single<', single_lt);
     AddCommand('single>', single_gt);
     AddCommand('single<=', single_lte);
     AddCommand('single>=', single_gte);
     AddCommand('single-0=', single_0_equel);
     AddCommand('single-0<>', single_0_nequel);
     AddCommand('single-0<', single_0_lt);
     AddCommand('single-0>', single_0_gt);
     AddCommand('single-0<=', single_0_lte);
     AddCommand('single-0>=', single_0_gte);
     AddCommand('single-?dup', single_ask_dup);
     AddCommand('single-0;', single_0_exit);
     AddCommand('single-min', single_min);
     AddCommand('single-max', single_max);
     AddCommand('single-minmax', single_minmax);
     AddCommand('single.', single_dot);
     AddCommand('single$', single_dollar);
     AddCommand('single+!', single_ptr_plus_exclamation);
     AddCommand('single->str', single_conv_to_str);
     AddCommand('str->single', single_conv_from_str);
    
    
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
     AddCommand('double-0;', double_0_exit);
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
     AddCommand('extended-0;', extended_0_exit);
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
    
    AddCommand('single-abs', single_abs);
     AddCommand('single-neg', single_neg);
    
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
    
    
     AddCommand('int-push', int_push, True);
     AddCommand('run@int-push', int_run_push);
     AddCommand('int-inc', int_1_plus);
     AddCommand('int-dec', int_1_minus);
     
     
     AddCommand('int-inc!', int_ptr_inc);
     AddCommand('int-dec!', int_ptr_dec);
     
     
     AddCommand('int-div', int_div);
     AddCommand('int-mod', int_mod);
     AddCommand('int-divmod', int_divmod);
    
    
     AddCommand('int8-push', int8_push, True);
     AddCommand('run@int8-push', int8_run_push);
     AddCommand('int8-inc', int8_1_plus);
     AddCommand('int8-dec', int8_1_minus);
     
     
     AddCommand('int8-inc!', int8_ptr_inc);
     AddCommand('int8-dec!', int8_ptr_dec);
     
     
     AddCommand('int8-div', int8_div);
     AddCommand('int8-mod', int8_mod);
     AddCommand('int8-divmod', int8_divmod);
    
    
     AddCommand('int16-push', int16_push, True);
     AddCommand('run@int16-push', int16_run_push);
     AddCommand('int16-inc', int16_1_plus);
     AddCommand('int16-dec', int16_1_minus);
     
     
     AddCommand('int16-inc!', int16_ptr_inc);
     AddCommand('int16-dec!', int16_ptr_dec);
     
     
     AddCommand('int16-div', int16_div);
     AddCommand('int16-mod', int16_mod);
     AddCommand('int16-divmod', int16_divmod);
    
    
     AddCommand('int32-push', int32_push, True);
     AddCommand('run@int32-push', int32_run_push);
     AddCommand('int32-inc', int32_1_plus);
     AddCommand('int32-dec', int32_1_minus);
     
     
     AddCommand('int32-inc!', int32_ptr_inc);
     AddCommand('int32-dec!', int32_ptr_dec);
     
     
     AddCommand('int32-div', int32_div);
     AddCommand('int32-mod', int32_mod);
     AddCommand('int32-divmod', int32_divmod);
    
    
     AddCommand('int64-push', int64_push, True);
     AddCommand('run@int64-push', int64_run_push);
     AddCommand('int64-inc', int64_1_plus);
     AddCommand('int64-dec', int64_1_minus);
     
     
     AddCommand('int64-inc!', int64_ptr_inc);
     AddCommand('int64-dec!', int64_ptr_dec);
     
     
     AddCommand('int64-div', int64_div);
     AddCommand('int64-mod', int64_mod);
     AddCommand('int64-divmod', int64_divmod);
    
    
     AddCommand('uint-push', uint_push, True);
     AddCommand('run@uint-push', uint_run_push);
     AddCommand('uint-inc', uint_1_plus);
     AddCommand('uint-dec', uint_1_minus);
     
     
     AddCommand('uint-inc!', uint_ptr_inc);
     AddCommand('uint-dec!', uint_ptr_dec);
     
     
     AddCommand('uint-div', uint_div);
     AddCommand('uint-mod', uint_mod);
     AddCommand('uint-divmod', uint_divmod);
    
    
     AddCommand('uint8-push', uint8_push, True);
     AddCommand('run@uint8-push', uint8_run_push);
     AddCommand('uint8-inc', uint8_1_plus);
     AddCommand('uint8-dec', uint8_1_minus);
     
     
     AddCommand('uint8-inc!', uint8_ptr_inc);
     AddCommand('uint8-dec!', uint8_ptr_dec);
     
     
     AddCommand('uint8-div', uint8_div);
     AddCommand('uint8-mod', uint8_mod);
     AddCommand('uint8-divmod', uint8_divmod);
    
    
     AddCommand('uint16-push', uint16_push, True);
     AddCommand('run@uint16-push', uint16_run_push);
     AddCommand('uint16-inc', uint16_1_plus);
     AddCommand('uint16-dec', uint16_1_minus);
     
     
     AddCommand('uint16-inc!', uint16_ptr_inc);
     AddCommand('uint16-dec!', uint16_ptr_dec);
     
     
     AddCommand('uint16-div', uint16_div);
     AddCommand('uint16-mod', uint16_mod);
     AddCommand('uint16-divmod', uint16_divmod);
    
    
     AddCommand('uint32-push', uint32_push, True);
     AddCommand('run@uint32-push', uint32_run_push);
     AddCommand('uint32-inc', uint32_1_plus);
     AddCommand('uint32-dec', uint32_1_minus);
     
     
     AddCommand('uint32-inc!', uint32_ptr_inc);
     AddCommand('uint32-dec!', uint32_ptr_dec);
     
     
     AddCommand('uint32-div', uint32_div);
     AddCommand('uint32-mod', uint32_mod);
     AddCommand('uint32-divmod', uint32_divmod);
    
    
     AddCommand('uint64-push', uint64_push, True);
     AddCommand('run@uint64-push', uint64_run_push);
     AddCommand('uint64-inc', uint64_1_plus);
     AddCommand('uint64-dec', uint64_1_minus);
     
     
     AddCommand('uint64-inc!', uint64_ptr_inc);
     AddCommand('uint64-dec!', uint64_ptr_dec);
     
     
     AddCommand('uint64-div', uint64_div);
     AddCommand('uint64-mod', uint64_mod);
     AddCommand('uint64-divmod', uint64_divmod);
    
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
    
    AddCommand('single->double', single_convert_to_double);
    
    AddCommand('double->single', double_convert_to_single);
    
    AddCommand('single->extended', single_convert_to_extended);
    
    AddCommand('double->extended', double_convert_to_extended);
    
    AddCommand('extended->double', extended_convert_to_double);
    
    AddCommand('extended->single', extended_convert_to_single);
    
    
     AddCommand('single-push', single_push, True);
     AddCommand('run@single-push', single_run_push);
     AddCommand('single/', single_slash);
     AddCommand('single-cos', single_cos);
     AddCommand('single-sin', single_sin);
     AddCommand('single-tan', single_tan);
     AddCommand('single-atan', single_atan);
     AddCommand('single-atan2', single_atan2);
    
    
     AddCommand('double-push', double_push, True);
     AddCommand('run@double-push', double_run_push);
     AddCommand('double/', double_slash);
     AddCommand('double-cos', double_cos);
     AddCommand('double-sin', double_sin);
     AddCommand('double-tan', double_tan);
     AddCommand('double-atan', double_atan);
     AddCommand('double-atan2', double_atan2);
    
    
     AddCommand('extended-push', extended_push, True);
     AddCommand('run@extended-push', extended_run_push);
     AddCommand('extended/', extended_slash);
     AddCommand('extended-cos', extended_cos);
     AddCommand('extended-sin', extended_sin);
     AddCommand('extended-tan', extended_tan);
     AddCommand('extended-atan', extended_atan);
     AddCommand('extended-atan2', extended_atan2);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     AddCommand('wp', _wp);
     AddCommand('rp', _rp);
     AddCommand('lp', _lp);
     AddCommand('lb', _lb);
     AddCommand('r@', _r_dog);
     AddCommand('r>', _r_gt);
     AddCommand('>r', _lt_r);
     AddCommand('l@', _l_dog);
     AddCommand('l!', _l_exclamation);
     AddCommand('l+', _l_plus);
     AddCommand('sys-version', version);
     AddCommand('state', _state);
     AddCommand('time', _time);
     AddCommand('local', _local);
     AddCommand('source-next-char', source_next_char);
     AddCommand('source-next-name', source_next_name);
     AddCommand('source-next-name-passive', source_next_name_passive);
     AddCommand('interpret@source-next-name-passive', source_next_name_passive);
     AddCommand('compile@source-next-name-passive', source_next_name_passive);
     AddCommand('run@source-next-name-passive', source_next_name_passive);
     AddCommand('source-read-to-char', source_read_to_char);
     AddCommand('ptr-nil', ptr_nil);
     AddCommand('interpret@', interpret_start);
     AddCommand('compile@', compile_start);
     AddCommand('run@', run_start);
     //AddCommand('allot', allot);
     //AddCommand('literal', literal, True);
     AddCommand('['']', sq_ap_sq, True);
     AddCommand('opcode->command', opcode_to_command);
     //AddCommand('run@['']', run_sq_ap_sq);
     //AddCommand('compile@['']', compile_sq_ap_sq);
     //AddCommand('interpret@['']', interpret_sq_ap_sq);
     AddCommand('''', _tick);
     AddCommand('execute', execute);
     AddCommand('does>', _does_gt, True);
     AddCommand('(does>)', _sq_does_gt_sq);
     AddCommand('cells', Cells);
     AddCommand('cell+', Cell_plus);
     AddCommand('malloc', _malloc);
     AddCommand('free', _free);
     AddCommand('last', _last);
     AddCommand('xt.n@', _xt_dot_n);
     AddCommand('xt.d@', _xt_dot_d);
     AddCommand('move', _move);
    
    
      AddCommand('sys-exceptions-execute', _sys_exceptions_execute);
      AddCommand('sys-exceptions-pop', _sys_exceptions_pop);
      AddCommand('throw', _throw);
    
    
     AddCommand('file-open', file_open);
     AddCommand('file-close', file_close);
     AddCommand('file-w', file_w);
     AddCommand('file-r', file_r);
     AddCommand('file-write', file_write);
     AddCommand('file-read', file_read);
     AddCommand('file-size', file_size);
    ;
  //Writeln('Commands count: ', Length(C));
end;

destructor TForthMachine.Destroy; 
begin
  ;
  FAlienCommands.Free;
  FStringCommands.Free;
  FDataCommands.Free;
  FEmbroCommands.Free;
  FControlCommands.Free;
  FStackCommands.Free;
  FStackCommands8.Free;
  FStackCommands16.Free;
  FStackCommands32.Free;
  FStackCommands64.Free;
  FIntArithmetic.Free;
  FInt8Arithmetic.Free;
  FInt16Arithmetic.Free;
  FInt32Arithmetic.Free;
  FInt64Arithmetic.Free;
  FUIntArithmetic.Free;
  FUInt8Arithmetic.Free;
  FUInt16Arithmetic.Free;
  FUInt32Arithmetic.Free;
  FUInt64Arithmetic.Free;
  FBoolCommands.Free;
  FReturnStack.Free;
  FStack.Free;
  FMemoryDebug.Free;
end;

procedure TForthMachine.InterpretName(W: PChar);
var
  I: Integer;
begin
  for I := High(C) downto 0 do
    if StrComp(C[I].Name, W) = 0 then begin
      //Writeln('START ' + W);
      C[I].Code(Self, C[I]);
      // Writeln('DONE ' + W);
      Exit;
    end;
  (* I := StrToIntDef(W, -3535); *)
  (* if I = -3535 then *)
  (*   Error(' Unknown command: ' + W) *)
  (* else *)
  (*   WUI(I); *)
  if ConvertStrToInt(W, I) <> 0 then
    Error(' Unknown command: ' + W)
  else
    WUI(I);
end;

function TForthMachine.CompileName(W: PChar): Boolean;
var
  I: Integer;
begin
  for I := High(C) downto 0 do
    if StrComp(C[I].Name, W) = 0 then begin
      if IsImmediate(C[I]) then
        C[I].Code(Self, C[I])
      else
        EWO(I);
      Exit;
    end;
  (* I := StrToIntDef(W, -3535); *)
  (* if I = -3535 then *)
  (*   Error('Unknown command: ' + W) *)
  (* else begin *)
  (*   EWO('(literal)'); *)
  (*   EWI(I); *)
  (* end; *)
  if ConvertStrToInt(W, I) <> 0 then
    Error(' Unknown command: ' + W)
  else begin
    EWO('(literal)');
    EWI(I);
  end;
end;

procedure TForthMachine.Interpret(const S: PChar);
begin
  {FSource := S;
  FCurrentChar := 0;
  while not EOS do begin
    FCurrentName := NextName;
    if FState = FS_COMPILE then
      CompileName(PChar(FCurrentName))
    else
      InterpretName(PChar(FCurrentName));
  end;}
  RUI(FState);
  RUI(Ord(FSession) * BOOL_TRUE);
  RUI(EC);
  RUP(Self.S);
  RUI(SC);
  RUP(RB);
  if S = nil then
    Exit;
  Self.S := S;
  //Self.SB := S;
  Self.SC := 0;
  FState := FS_INTERPRET;
  FSession := True;
  MainLoop;
  RB := ROP;
  SC := ROI;
  Self.S  := ROP;
  EC := ROI;
  FSession := ROI <> BOOL_FALSE;
  FState := ROI;
end;

procedure TForthMachine.InterpretFile(const FileName: TString);
var
  F: TextFile;
  S: TString;
  B: TString;
  T: TString;
begin
  S := FileName;
  Assign(F, S);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then begin
    LogError('cannot open file "' + S + '"');
    Exit;
  end;
  B := '';
  while not EOF(F) do begin
    Readln(F, T);
    B := B + T + EOL;
  end;
  Close(F);
  Interpret(PChar(B));
end;

procedure TForthMachine.Evaluate(Machine: TForthMachine; Command: PForthCommand);
var
  S: TStr;
begin
  S := Machine.FStringCommands.str_pop(Machine, Command);
  Interpret(PChar(@(PStrRec(S)^.Sym[0])));
  Machine.FStringCommands.DelRef(S);
end;

procedure TForthMachine.EvaluateFile(Machine: TForthMachine; Command: PForthCommand);
var
  //F: File of Byte;
  F: TextFile;
  S: TStr;
  //B: array of Byte;
  B: TString;
  T: TString;
begin
  S := MAchine.FStringCommands.str_pop(Machine, Command);
  Assign(F, PChar(GetCurrentDirectory) + '\' + PChar(@(PStrRec(S)^.Sym[0])));
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 then begin
    Assign(F, PChar(GetExeDirectory) + '\' + PChar(@(PStrRec(S)^.Sym[0])));
    {$I-}
    Reset(F);
    {$I+}
    if IOResult <> 0 then begin
      LogError('cannot open file "' + PChar(@(PStrRec(S)^.Sym[0])) + '"');
      Exit;
    end;
  end;
  B := '';
  while not EOF(F) do begin
    Readln(F, T);
    B := B + T + EOL;
  end;
  Close(F);
  Machine.Interpret(PChar(B));
  Machine.FStringCommands.DelRef(S);
end;

procedure TForthMachine.MainLoop;
begin
  while FSession do
    case FState of
      FS_INTERPRET: InterpretStep;
      FS_COMPILE:   CompileStep;
      FS_RUN:       RunStep;
    end;
end;

procedure TForthMachine.InterpretStep;
begin
  SSS;
  if SE then
    FSession := False
  else
    InterpretName(PChar(SNN));
end;

procedure TForthMachine.CompileStep;
begin
  SSS;
  if SE then
    FSession := False
  else
    CompileName(PChar(SNN));
end;

procedure TForthMachine.RunStep;
begin
  //Writeln('RUN STEP');
  RunMnemonic(ERO);
end;

procedure TForthMachine.CompileError(const S: TString);
begin
  Error(' Compilation: "' + S + '"');
  FCompilation := False;
end;

procedure TForthMachine.CompileWarring(const S: TString);
begin
  Warrning(' Compilation: "' + S + '"');
end;

procedure TForthMachine.LogError(const S: TString);
begin
  if FState = FS_COMPILE then
    CompileError(S)
  else
    RunError(S);
end;

function TForthMachine.NextChar: TChar;
begin
  Result := SNC;
  {if EOS then
    Result := #0
  else begin
    Result := FSource[FCurrentChar];
    Inc(FCurrentChar);
  end;}
end;

function TForthMachine.NextName: TString;
var
  C: TChar;
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

function TForthMachine.NextName(S: PChar; var I: Integer): TString;
var
  C: TChar;
begin
  Result := '';
  repeat
    C := S[I];
    if C <> #0 then
      Inc(I);
  until (not (C in [#0..#32])) or (C = #0);
  repeat
    Result := Result + C;
    if S[I] = #0 then
      Exit;
    C := S[I];
    if C <> #0 then
      Inc(I);
  until (C in [#0..#32]) or (C = #0);
  if not (C in [#0..#32]) then
    Result := Result + C;
end;

function TForthMachine.NextNamePassive: TString;
var
  Temp: Integer;
begin
  Temp := SC;
  Result := NextName(S, Temp);
end;

function TForthMachine.EOS: Boolean; // end of source
begin
  Result := SE;
  //Result := FSource[FCurrentChar] = #0;
end;

procedure TForthMachine.WriteEmbro(P: Pointer; Size: Integer);
begin
  SetLength(FEmbro, Length(FEmbro) + Size);
  Move(P^, FEmbro[Length(FEmbro) - Size], Size);
end;

procedure TForthMachine.WriteEmbroInt(I: Integer);
begin
  WriteEmbro(@I, SizeOf(I));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' ' + IntToStr(I) + ' ';
end;

procedure TForthMachine.WriteEmbroUInt(U: Cardinal);
begin
  WriteEmbro(@U, SizeOf(U));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + ' u' + IntToStr(U) + ' ';
end;

procedure TForthMachine.WriteEmbroChar(C: Char);
begin
  WriteEmbro(@C, SizeOf(C));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + '''' + IntToHex(Ord(C), 2);
end;

procedure TForthMachine.WriteEmbroByte(B: Byte);
begin
  WriteEmbro(@B, SizeOf(B));
  FEmbroDump[High(FEmbroDump)] := FEmbroDump[High(FEmbroDump)] + 'b' + IntToHex(Ord(B), 2);
end;

procedure TForthMachine.PopEmbro(P: Pointer; Size: Integer);
begin
  Move(FEmbro[Length(FEmbro) - Size], P^, Size);
  SetLength(FEmbro, Length(FEmbro) - Size);
end;

procedure TForthMachine.WriteMnemonic(M: Cardinal);
begin
  WriteEmbro(@M, SizeOf(M));
  SetLength(FEmbroDump, Length(FEmbroDump) + 1);
  FEmbroDump[High(FEmbroDump)] := C[M].Name + ' ';
end;

procedure TForthMachine.WriteMnemonicByName(const Name: TString);
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
    Error(' Unknown command: ' + Name)
  else begin
    EWO('(literal)');
    EWI(I);
  end;
end;

function TForthMachine.GetOpcodeByName(const Name: TString): TMnemonic;
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

function TForthMachine.GetCommandByOpcode(Opcode: Integer): PForthCommand;
begin
  //Writeln(Opcode);
  Result := C[Opcode];
end;

procedure TForthMachine.CancelMnemonic;
begin
  SetLength(FEmbro, Length(FEmbro) - SizeOf(Cardinal));
end;

function TForthMachine.ReserveName(const Name: TString): PForthCommand;
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
  C[High(C)].Code := FControlCommands.call;
  FLastMnemonic := High(C);
  Result := C[High(C)];
end;

procedure TForthMachine.ReadEmbro(P: Pointer; Size: Integer);
begin
  Move(FEmbro[EC], P^, Size);
  Inc(EC, Size);
end;

function TForthMachine.ReadMnemonic: TMnemonic;
begin
  ReadEmbro(@Result, SizeOf(TMnemonic));
end;

procedure TForthMachine.Push(P: Pointer; Size: Integer);
begin
  if FState = FS_COMPILE then
    WriteEmbro(P, Size)
  else
    FStack.Push(P, Size);
end;

procedure TForthMachine.Push(I: TInt);
begin
  Push(@I, SizeOf(I));
end;

procedure TForthMachine.PushMnemonic(M: TMnemonic);
begin
  Push(@M, SizeOf(M));
end;

procedure TForthMachine.PushPtr(P: Pointer);
begin
  Push(@P, SizeOf(P));
end;

procedure TForthMachine.PushEmbroPtr(EmbroPtr: TInt);
begin
  Push(@EmbroPtr, SizeOf(EmbroPtr));
end;

procedure TForthMachine.Pop(P: Pointer; Size: Integer);
begin
  if FState = FS_COMPILE then
    PopEmbro(P, Size)
  else
    FStack.Pop(P, Size);
end;

function TForthMachine.Pop: Integer; 
begin
  Pop(@Result, SizeOf(Result));
end;

function TForthMachine.PopMnemonic: TMnemonic;
begin
  Pop(@Result, SizeOf(Result));
end;

function TForthMachine.PopPtr: TPtr;
begin
  Pop(@Result, SizeOf(Result));
end;

function TForthMachine.PopEmbroPtr: TEmbroPtr;
begin
  Pop(@Result, SizeOf(Result));
end;

function TForthMachine.GetEmbroDumpLines: Integer;
begin
  Result := Length(FEmbroDump);
end;

function TForthMachine.GetEmbroDumpLine;
begin
  Result := FEmbroDump[Index];
end;

function TForthMachine.FindCommand(const Name: TString): PForthCommand;
var
  I: Integer;
begin
  for I := High(C) downto 0 do
    if TString(C[I].Name) = Name then begin
      //Writeln('Found command ', C[I].Name);
      Result := C[I];
      Exit;
    end;
  Result := nil;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TIntArithmetic'}{$ENDIF}
constructor GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}.Create(Machine: TForthMachine);
begin
  FMachine := Machine
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._plus;
var
  a, b: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  FMachine.Stack.pop(@b, SizeOf(b));
  a := a + b;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._minus;
var
  a, b: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  FMachine.Stack.pop(@b, SizeOf(b));
  a := a - b;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._star;
var
  a, b: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  FMachine.Stack.pop(@b, SizeOf(b));
  a := a * b;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._equel;
var
  a, b: T;
begin
  FMachine.Stack.pop(@b, SizeOf(b));
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - Ord(a = b);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._lt;
var
  a, b: T;
begin
  FMachine.Stack.pop(@b, SizeOf(b));
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - Ord(a < b);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._gt;
var
  a, b: T;
begin
  FMachine.Stack.pop(@b, SizeOf(b));
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - Ord(a > b);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._div;
var
  a, b: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  FMachine.Stack.pop(@b, SizeOf(b));
  a := a div b;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._mod;
var
  a, b: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  FMachine.Stack.pop(@b, SizeOf(b));
  a := a mod b;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  //Write(a, ' ');
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._abs;
//var
  //a: T;
begin
  //FMachine.Stack.pop(@a, SizeOf(a));
  //a := System.Abs(a);
  //FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}.neg;
//var
  //a: T;
begin
  //FMachine.Stack.pop(@a, SizeOf(a));
  //a := - a;
  //FMachine.Stack.push(@a, SizeOf(a));
end;

procedure GIntArithmetic{$IFNDEF FLAG_FPC}<T>{$ENDIF}._comma;
begin
  Machine.LogError('unknown arithmetic comma command');
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'int arithmetics'}{$ENDIF}
procedure TIntArithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TIntArithmetic._abs;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := System.Abs(a);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TIntArithmetic.neg; 
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - a;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TIntArithmetic._comma;
var
  a: T;
begin
  Machine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TInt8Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TInt8Arithmetic._abs;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := System.Abs(a);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt8Arithmetic.neg; 
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - a;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt8Arithmetic.ToInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TInt8Arithmetic.FromInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt8Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TInt16Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TInt16Arithmetic._abs;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := System.Abs(a);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt16Arithmetic.neg; 
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - a;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt16Arithmetic.ToInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TInt16Arithmetic.FromInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt16Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TInt32Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TInt32Arithmetic._abs;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := System.Abs(a);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt32Arithmetic.neg; 
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - a;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt32Arithmetic.ToInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TInt32Arithmetic.FromInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt32Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TInt64Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TInt64Arithmetic._abs;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := System.Abs(a);
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt64Arithmetic.neg; 
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  a := - a;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt64Arithmetic.ToInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TInt64Arithmetic.FromInt;
var
  a: T;
  i: TInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TInt64Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TUIntArithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TUIntArithmetic.ToInt;
var
  a: T;
  i: TUint;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TUIntArithmetic.FromInt;
var
  a: T;
  i: TUInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TUIntArithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TUInt8Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TUInt8Arithmetic.ToInt;
var
  a: T;
  i: TUint;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TUInt8Arithmetic.FromInt;
var
  a: T;
  i: TUInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TUInt8Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TUInt16Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TUInt16Arithmetic.ToInt;
var
  a: T;
  i: TUint;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TUInt16Arithmetic.FromInt;
var
  a: T;
  i: TUInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TUInt16Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TUInt32Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TUInt32Arithmetic.ToInt;
var
  a: T;
  i: TUint;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TUInt32Arithmetic.FromInt;
var
  a: T;
  i: TUInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TUInt32Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;

procedure TUInt64Arithmetic._dot;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Write(a, ' ');
end;

procedure TUInt64Arithmetic.ToInt;
var
  a: T;
  i: TUint;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  i := a;
  FMachine.Stack.push(@i, SizeOf(i));
end;

procedure TUInt64Arithmetic.FromInt;
var
  a: T;
  i: TUInt;
begin
  FMachine.Stack.pop(@i, SizeOf(i));
  a := i;
  FMachine.Stack.push(@a, SizeOf(a));
end;

procedure TUInt64Arithmetic._comma;
var
  a: T;
begin
  FMachine.Stack.pop(@a, SizeOf(a));
  Move(a, Machine.Here^, SizeOf(T));
  Machine.IncHere(SizeOf(T));
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

// ( Вся соль :)
 
    function TForthMachine.ROP: Pointer; begin Dec(RP, SizeOf(Result)); Result := Pointer(RP^); end; 
    procedure TForthMachine.RUI(const V: TInt); begin TInt(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUI8(const V: TInt8); begin TInt8(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUI16(const V: TInt16); begin TInt16(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUI32(const V: TInt32); begin TInt32(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUI64(const V: TInt64); begin TInt64(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUU(const V: TUInt); begin TUInt(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUU8(const V: TUInt8); begin TUInt8(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUU16(const V: TUInt16); begin TUInt16(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUU32(const V: TUInt32); begin TUInt32(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUU64(const V: TUInt64); begin TUInt64(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    procedure TForthMachine.RUP(const V: Pointer); begin Pointer(RP^) := V; Inc(RP, SizeOf(V)) end;
   
    function TForthMachine.ROI: TInt; begin Dec(RP, SizeOf(Result)); Result := TInt(RP^); end; 
    function TForthMachine.ROI8: TInt8; begin Dec(RP, SizeOf(Result)); Result := TInt8(RP^); end; 
    function TForthMachine.ROI16: TInt16; begin Dec(RP, SizeOf(Result)); Result := TInt16(RP^); end; 
    function TForthMachine.ROI32: TInt32; begin Dec(RP, SizeOf(Result)); Result := TInt32(RP^); end; 
    function TForthMachine.ROI64: TInt64; begin Dec(RP, SizeOf(Result)); Result := TInt64(RP^); end; 
    function TForthMachine.ROU: TUInt; begin Dec(RP, SizeOf(Result)); Result := TUInt(RP^); end; 
    function TForthMachine.ROU8: TUInt8; begin Dec(RP, SizeOf(Result)); Result := TUInt8(RP^); end; 
    function TForthMachine.ROU16: TUInt16; begin Dec(RP, SizeOf(Result)); Result := TUInt16(RP^); end; 
    function TForthMachine.ROU32: TUInt32; begin Dec(RP, SizeOf(Result)); Result := TUInt32(RP^); end; 
    function TForthMachine.ROU64: TUInt64; begin Dec(RP, SizeOf(Result)); Result := TUInt64(RP^); end; 
    procedure TForthMachine.WUI(const V: TInt); begin TInt(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUP(const V: Pointer); begin Pointer(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    function TForthMachine.WOI: TInt; begin Dec(WP, SizeOf(Result)); Result := TInt(WP^); end; 
    function TForthMachine.WOP: Pointer; begin Dec(WP, SizeOf(Result)); Result := Pointer(WP^); end; 
    procedure TForthMachine.WUI8(const V: TInt8); begin TInt8(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUI16(const V: TInt16); begin TInt16(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUI32(const V: TInt32); begin TInt32(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUI64(const V: TInt64); begin TInt64(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUU(const V: TUInt); begin TUInt(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUU8(const V: TUInt8); begin TUInt8(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUU16(const V: TUInt16); begin TUInt16(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUU32(const V: TUInt32); begin TUInt32(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    procedure TForthMachine.WUU64(const V: TUInt64); begin TUInt64(WP^) := V; Inc(WP, SizeOf(V)) end;
   
    function TForthMachine.WOI8: TInt8; begin Dec(WP, SizeOf(Result)); Result := TInt8(WP^); end; 
    function TForthMachine.WOI16: TInt16; begin Dec(WP, SizeOf(Result)); Result := TInt16(WP^); end; 
    function TForthMachine.WOI32: TInt32; begin Dec(WP, SizeOf(Result)); Result := TInt32(WP^); end; 
    function TForthMachine.WOI64: TInt64; begin Dec(WP, SizeOf(Result)); Result := TInt64(WP^); end; 
    function TForthMachine.WOU: TUInt; begin Dec(WP, SizeOf(Result)); Result := TUInt(WP^); end; 
    function TForthMachine.WOU8: TUInt8; begin Dec(WP, SizeOf(Result)); Result := TUInt8(WP^); end; 
    function TForthMachine.WOU16: TUInt16; begin Dec(WP, SizeOf(Result)); Result := TUInt16(WP^); end; 
    function TForthMachine.WOU32: TUInt32; begin Dec(WP, SizeOf(Result)); Result := TUInt32(WP^); end; 
    function TForthMachine.WOU64: TUInt64; begin Dec(WP, SizeOf(Result)); Result := TUInt64(WP^); end; 
    procedure TForthMachine.LUI(const V: TInt); begin TInt(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUP(const V: Pointer); begin Pointer(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    function TForthMachine.LOI: TInt; begin Dec(LP, SizeOf(Result)); Result := TInt(LP^); end; 
    function TForthMachine.LOP: Pointer; begin Dec(LP, SizeOf(Result)); Result := Pointer(LP^); end; 
    procedure TForthMachine.LUI8(const V: TInt8); begin TInt8(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUI16(const V: TInt16); begin TInt16(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUI32(const V: TInt32); begin TInt32(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUI64(const V: TInt64); begin TInt64(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUU(const V: TUInt); begin TUInt(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUU8(const V: TUInt8); begin TUInt8(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUU16(const V: TUInt16); begin TUInt16(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUU32(const V: TUInt32); begin TUInt32(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    procedure TForthMachine.LUU64(const V: TUInt64); begin TUInt64(LP^) := V; Inc(LP, SizeOf(V)) end;
   
    function TForthMachine.LOI8: TInt8; begin Dec(LP, SizeOf(Result)); Result := TInt8(LP^); end; 
    function TForthMachine.LOI16: TInt16; begin Dec(LP, SizeOf(Result)); Result := TInt16(LP^); end; 
    function TForthMachine.LOI32: TInt32; begin Dec(LP, SizeOf(Result)); Result := TInt32(LP^); end; 
    function TForthMachine.LOI64: TInt64; begin Dec(LP, SizeOf(Result)); Result := TInt64(LP^); end; 
    function TForthMachine.LOU: TUInt; begin Dec(LP, SizeOf(Result)); Result := TUInt(LP^); end; 
    function TForthMachine.LOU8: TUInt8; begin Dec(LP, SizeOf(Result)); Result := TUInt8(LP^); end; 
    function TForthMachine.LOU16: TUInt16; begin Dec(LP, SizeOf(Result)); Result := TUInt16(LP^); end; 
    function TForthMachine.LOU32: TUInt32; begin Dec(LP, SizeOf(Result)); Result := TUInt32(LP^); end; 
    function TForthMachine.LOU64: TUInt64; begin Dec(LP, SizeOf(Result)); Result := TUInt64(LP^); end; 
    
     procedure TForthMachine.drop_ (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_ (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_ (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_ (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_ (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_ (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_ (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_ (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_ (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_ (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_ (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_(Machine, Command) else _interpret_to_(Machine, Command); end;
     procedure TForthMachine._compile_to_ (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@to'); EWO(NextName); end;
     procedure TForthMachine._run_to_ (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_ (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_ (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_ (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_ (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_ (Machine: TForthMachine; Command: PForthCommand); begin EWO('(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_ (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_ptr (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_ptr (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_ptr (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_ptr (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_ptr (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_ptr (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_ptr (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_ptr (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_ptr(Machine, Command) else _interpret_to_ptr(Machine, Command); end;
     procedure TForthMachine._compile_to_ptr (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@ptr-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_ptr (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_ptr (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after ptr-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_ptr (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_ptr; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_ptr (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_ptr (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin EWO('ptr-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_ptr (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_int (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_int (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_int (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_int (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_int (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_int (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_int (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_int (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_int (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_int (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_int (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_int(Machine, Command) else _interpret_to_int(Machine, Command); end;
     procedure TForthMachine._compile_to_int (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_int (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_int (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after int-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_int (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_int (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_int (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_int (Machine: TForthMachine; Command: PForthCommand); begin EWO('int-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_int (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_int8 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 1) end;
     procedure TForthMachine.dup_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1))^), (Pointer(TUInt(WP) + (0))^), 1); Inc(WP, 1) end;
     procedure TForthMachine.nip_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*1))^), (Pointer(TUInt(WP) + (-2*1))^), 1); Dec(WP, 1) end;
     procedure TForthMachine.swap_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1))^), WP^, 1); Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1))^), 1); Move(WP^, (Pointer(TUInt(WP) + (-2*1))^), 1); end;
     procedure TForthMachine.over_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (0))^), 1); Inc(WP, 1) end;
     procedure TForthMachine.tuck_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1*1))^), 2*1); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*1))^), 1); Inc(WP, 1); end;
     procedure TForthMachine.lrot_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(WP) + (-3*1))^), (Pointer(TUInt(WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(WP) + (-2*1))^), 1);
     end;
     procedure TForthMachine.rrot_int8 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(WP) + (-3*1))^), (Pointer(TUInt(WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(WP) + (-3*1))^), 1);
     end;
     procedure TForthMachine.lrotn_int8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-1*N))^), (Pointer(TUInt(WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-1*(N-1)))^), (Pointer(TUInt(WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-1))^), 1);
     end;
     procedure TForthMachine.rrotn_int8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-1))^), (Pointer(TUInt(WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-1*(I+1)))^), (Pointer(TUInt(WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*1))^), 1);
     end;
     procedure TForthMachine.pick_int8 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_int8 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 1); Move(WP^, Here^, 1); EA(1); end;
     procedure TForthMachine._dog_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1) end;
     procedure TForthMachine.ptr_plus_int8 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 1; end;
     procedure TForthMachine._to_int8 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_int8(Machine, Command) else _interpret_to_int8(Machine, Command); end;
     procedure TForthMachine._compile_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int8-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_int8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1); end;
     procedure TForthMachine._interpret_to_int8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after int8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-1))^), C.Data^, 1); Dec(WP, 1);
             end;
     procedure TForthMachine._value_int8 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int8; Move((Pointer(TUInt(WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_int8 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end; end;
     procedure TForthMachine.RunValue_int8 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 1); Inc(WP, 1); end;
    procedure TForthMachine.literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin EWO('int8-(literal)'); Dec(WP, 1); EWV(WP, 1); end;
    procedure TForthMachine.run_literal_int8 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 1); Inc(WP, 1); end;
    
   
    
     procedure TForthMachine.drop_int16 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 2) end;
     procedure TForthMachine.dup_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2))^), (Pointer(TUInt(WP) + (0))^), 2); Inc(WP, 2) end;
     procedure TForthMachine.nip_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*2))^), (Pointer(TUInt(WP) + (-2*2))^), 2); Dec(WP, 2) end;
     procedure TForthMachine.swap_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2))^), WP^, 2); Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-2))^), 2); Move(WP^, (Pointer(TUInt(WP) + (-2*2))^), 2); end;
     procedure TForthMachine.over_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (0))^), 2); Inc(WP, 2) end;
     procedure TForthMachine.tuck_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2*2); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*2))^), 2); Inc(WP, 2); end;
     procedure TForthMachine.lrot_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(WP) + (-3*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(WP) + (-2*2))^), 2);
     end;
     procedure TForthMachine.rrot_int16 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(WP) + (-3*2))^), (Pointer(TUInt(WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(WP) + (-3*2))^), 2);
     end;
     procedure TForthMachine.lrotn_int16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-2*N))^), (Pointer(TUInt(WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-2*(N-1)))^), (Pointer(TUInt(WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2))^), 2);
     end;
     procedure TForthMachine.rrotn_int16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-2))^), (Pointer(TUInt(WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-2*(I+1)))^), (Pointer(TUInt(WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*2))^), 2);
     end;
     procedure TForthMachine.pick_int16 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_int16 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 2); Move(WP^, Here^, 2); EA(2); end;
     procedure TForthMachine._dog_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2) end;
     procedure TForthMachine.ptr_plus_int16 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 2; end;
     procedure TForthMachine._to_int16 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_int16(Machine, Command) else _interpret_to_int16(Machine, Command); end;
     procedure TForthMachine._compile_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int16-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_int16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2); end;
     procedure TForthMachine._interpret_to_int16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after int16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-2))^), C.Data^, 2); Dec(WP, 2);
             end;
     procedure TForthMachine._value_int16 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int16; Move((Pointer(TUInt(WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_int16 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end; end;
     procedure TForthMachine.RunValue_int16 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 2); Inc(WP, 2); end;
    procedure TForthMachine.literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin EWO('int16-(literal)'); Dec(WP, 2); EWV(WP, 2); end;
    procedure TForthMachine.run_literal_int16 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 2); Inc(WP, 2); end;
    
   
    
     procedure TForthMachine.drop_int32 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_int32 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_int32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_int32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_int32 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_int32 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_int32 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_int32 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_int32(Machine, Command) else _interpret_to_int32(Machine, Command); end;
     procedure TForthMachine._compile_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int32-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_int32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_int32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after int32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_int32 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int32; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_int32 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_int32 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin EWO('int32-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_int32 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_int64 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 8) end;
     procedure TForthMachine.dup_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-8))^), (Pointer(TUInt(WP) + (0))^), 8); Inc(WP, 8) end;
     procedure TForthMachine.nip_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*8))^), (Pointer(TUInt(WP) + (-2*8))^), 8); Dec(WP, 8) end;
     procedure TForthMachine.swap_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-8))^), WP^, 8); Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-8))^), 8); Move(WP^, (Pointer(TUInt(WP) + (-2*8))^), 8); end;
     procedure TForthMachine.over_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (0))^), 8); Inc(WP, 8) end;
     procedure TForthMachine.tuck_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-1*8))^), 2*8); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*8))^), 8); Inc(WP, 8); end;
     procedure TForthMachine.lrot_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(WP) + (-3*8))^), (Pointer(TUInt(WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(WP) + (-2*8))^), 8);
     end;
     procedure TForthMachine.rrot_int64 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(WP) + (-3*8))^), (Pointer(TUInt(WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(WP) + (-3*8))^), 8);
     end;
     procedure TForthMachine.lrotn_int64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-8*N))^), (Pointer(TUInt(WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-8*(N-1)))^), (Pointer(TUInt(WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-8))^), 8);
     end;
     procedure TForthMachine.rrotn_int64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-8))^), (Pointer(TUInt(WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-8*(I+1)))^), (Pointer(TUInt(WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*8))^), 8);
     end;
     procedure TForthMachine.pick_int64 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_int64 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 8); Move(WP^, Here^, 8); EA(8); end;
     procedure TForthMachine._dog_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8) end;
     procedure TForthMachine.ptr_plus_int64 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 8; end;
     procedure TForthMachine._to_int64 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_int64(Machine, Command) else _interpret_to_int64(Machine, Command); end;
     procedure TForthMachine._compile_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int64-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_int64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8); end;
     procedure TForthMachine._interpret_to_int64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after int64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-8))^), C.Data^, 8); Dec(WP, 8);
             end;
     procedure TForthMachine._value_int64 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_int64; Move((Pointer(TUInt(WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_int64 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end; end;
     procedure TForthMachine.RunValue_int64 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 8); Inc(WP, 8); end;
    procedure TForthMachine.literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin EWO('int64-(literal)'); Dec(WP, 8); EWV(WP, 8); end;
    procedure TForthMachine.run_literal_int64 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 8); Inc(WP, 8); end;
    
   
    
     procedure TForthMachine.drop_uint (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_uint (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_uint (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_uint (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_uint (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_uint (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_uint (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_uint (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_uint (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_uint (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_uint(Machine, Command) else _interpret_to_uint(Machine, Command); end;
     procedure TForthMachine._compile_to_uint (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_uint (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_uint (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after uint-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_uint (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_uint (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_uint (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_uint (Machine: TForthMachine; Command: PForthCommand); begin EWO('uint-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_uint (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 1) end;
     procedure TForthMachine.dup_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1))^), (Pointer(TUInt(WP) + (0))^), 1); Inc(WP, 1) end;
     procedure TForthMachine.nip_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*1))^), (Pointer(TUInt(WP) + (-2*1))^), 1); Dec(WP, 1) end;
     procedure TForthMachine.swap_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1))^), WP^, 1); Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1))^), 1); Move(WP^, (Pointer(TUInt(WP) + (-2*1))^), 1); end;
     procedure TForthMachine.over_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (0))^), 1); Inc(WP, 1) end;
     procedure TForthMachine.tuck_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1*1))^), 2*1); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*1))^), 1); Inc(WP, 1); end;
     procedure TForthMachine.lrot_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(WP) + (-3*1))^), (Pointer(TUInt(WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-3*1))^), 1);
       Move(WP^, (Pointer(TUInt(WP) + (-2*1))^), 1);
     end;
     procedure TForthMachine.rrot_uint8 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*1))^), WP^, 1);
       Move((Pointer(TUInt(WP) + (-2*1))^), (Pointer(TUInt(WP) + (-1*1))^), 1);
       Move((Pointer(TUInt(WP) + (-3*1))^), (Pointer(TUInt(WP) + (-2*1))^), 1);
       Move(WP^, (Pointer(TUInt(WP) + (-3*1))^), 1);
     end;
     procedure TForthMachine.lrotn_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-1*N))^), (Pointer(TUInt(WP) + (0))^), 1);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-1*(N-1)))^), (Pointer(TUInt(WP) + (-1*N))^), 1);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-1))^), 1);
     end;
     procedure TForthMachine.rrotn_uint8 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-1))^), (Pointer(TUInt(WP) + (0))^), 1);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-1*(I+1)))^), (Pointer(TUInt(WP) + (-1*I))^), 1);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*1))^), 1);
     end;
     procedure TForthMachine.pick_uint8 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -1*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            1);
       Inc(WP, 1 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 1); Move(WP^, Here^, 1); EA(1); end;
     procedure TForthMachine._dog_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 1); Inc(WP, 1 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-1))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 1); Dec(WP, (SizeOf(Pointer)) + 1) end;
     procedure TForthMachine.ptr_plus_uint8 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 1; end;
     procedure TForthMachine._to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_uint8(Machine, Command) else _interpret_to_uint8(Machine, Command); end;
     procedure TForthMachine._compile_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint8-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-1))^), C[O].Data^, 1); Dec(WP, 1); end;
     procedure TForthMachine._interpret_to_uint8 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after uint8-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-1))^), C.Data^, 1); Dec(WP, 1);
             end;
     procedure TForthMachine._value_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint8; Move((Pointer(TUInt(WP) + (-1))^), Here^, 1); Dec(WP, 1); EA(1); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_uint8 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 1); Move(WP^, Here^, 1);} EA(1); end; end;
     procedure TForthMachine.RunValue_uint8 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 1); Inc(WP, 1); end;
    procedure TForthMachine.literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin EWO('uint8-(literal)'); Dec(WP, 1); EWV(WP, 1); end;
    procedure TForthMachine.run_literal_uint8 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 1); Inc(WP, 1); end;
    
   
    
     procedure TForthMachine.drop_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 2) end;
     procedure TForthMachine.dup_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2))^), (Pointer(TUInt(WP) + (0))^), 2); Inc(WP, 2) end;
     procedure TForthMachine.nip_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*2))^), (Pointer(TUInt(WP) + (-2*2))^), 2); Dec(WP, 2) end;
     procedure TForthMachine.swap_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2))^), WP^, 2); Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-2))^), 2); Move(WP^, (Pointer(TUInt(WP) + (-2*2))^), 2); end;
     procedure TForthMachine.over_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (0))^), 2); Inc(WP, 2) end;
     procedure TForthMachine.tuck_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2*2); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*2))^), 2); Inc(WP, 2); end;
     procedure TForthMachine.lrot_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(WP) + (-3*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-3*2))^), 2);
       Move(WP^, (Pointer(TUInt(WP) + (-2*2))^), 2);
     end;
     procedure TForthMachine.rrot_uint16 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*2))^), WP^, 2);
       Move((Pointer(TUInt(WP) + (-2*2))^), (Pointer(TUInt(WP) + (-1*2))^), 2);
       Move((Pointer(TUInt(WP) + (-3*2))^), (Pointer(TUInt(WP) + (-2*2))^), 2);
       Move(WP^, (Pointer(TUInt(WP) + (-3*2))^), 2);
     end;
     procedure TForthMachine.lrotn_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-2*N))^), (Pointer(TUInt(WP) + (0))^), 2);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-2*(N-1)))^), (Pointer(TUInt(WP) + (-2*N))^), 2);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2))^), 2);
     end;
     procedure TForthMachine.rrotn_uint16 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-2))^), (Pointer(TUInt(WP) + (0))^), 2);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-2*(I+1)))^), (Pointer(TUInt(WP) + (-2*I))^), 2);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*2))^), 2);
     end;
     procedure TForthMachine.pick_uint16 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -2*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            2);
       Inc(WP, 2 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 2); Move(WP^, Here^, 2); EA(2); end;
     procedure TForthMachine._dog_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 2); Inc(WP, 2 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-2))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 2); Dec(WP, (SizeOf(Pointer)) + 2) end;
     procedure TForthMachine.ptr_plus_uint16 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 2; end;
     procedure TForthMachine._to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_uint16(Machine, Command) else _interpret_to_uint16(Machine, Command); end;
     procedure TForthMachine._compile_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint16-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-2))^), C[O].Data^, 2); Dec(WP, 2); end;
     procedure TForthMachine._interpret_to_uint16 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after uint16-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-2))^), C.Data^, 2); Dec(WP, 2);
             end;
     procedure TForthMachine._value_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint16; Move((Pointer(TUInt(WP) + (-2))^), Here^, 2); Dec(WP, 2); EA(2); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_uint16 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 2); Move(WP^, Here^, 2);} EA(2); end; end;
     procedure TForthMachine.RunValue_uint16 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 2); Inc(WP, 2); end;
    procedure TForthMachine.literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin EWO('uint16-(literal)'); Dec(WP, 2); EWV(WP, 2); end;
    procedure TForthMachine.run_literal_uint16 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 2); Inc(WP, 2); end;
    
   
    
     procedure TForthMachine.drop_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_uint32 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_uint32 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_uint32 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_uint32 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_uint32(Machine, Command) else _interpret_to_uint32(Machine, Command); end;
     procedure TForthMachine._compile_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint32-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_uint32 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after uint32-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint32; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_uint32 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_uint32 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin EWO('uint32-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_uint32 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
     procedure TForthMachine.drop_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 8) end;
     procedure TForthMachine.dup_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-8))^), (Pointer(TUInt(WP) + (0))^), 8); Inc(WP, 8) end;
     procedure TForthMachine.nip_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*8))^), (Pointer(TUInt(WP) + (-2*8))^), 8); Dec(WP, 8) end;
     procedure TForthMachine.swap_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-8))^), WP^, 8); Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-8))^), 8); Move(WP^, (Pointer(TUInt(WP) + (-2*8))^), 8); end;
     procedure TForthMachine.over_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (0))^), 8); Inc(WP, 8) end;
     procedure TForthMachine.tuck_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-1*8))^), 2*8); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*8))^), 8); Inc(WP, 8); end;
     procedure TForthMachine.lrot_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(WP) + (-3*8))^), (Pointer(TUInt(WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-3*8))^), 8);
       Move(WP^, (Pointer(TUInt(WP) + (-2*8))^), 8);
     end;
     procedure TForthMachine.rrot_uint64 (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*8))^), WP^, 8);
       Move((Pointer(TUInt(WP) + (-2*8))^), (Pointer(TUInt(WP) + (-1*8))^), 8);
       Move((Pointer(TUInt(WP) + (-3*8))^), (Pointer(TUInt(WP) + (-2*8))^), 8);
       Move(WP^, (Pointer(TUInt(WP) + (-3*8))^), 8);
     end;
     procedure TForthMachine.lrotn_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-8*N))^), (Pointer(TUInt(WP) + (0))^), 8);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-8*(N-1)))^), (Pointer(TUInt(WP) + (-8*N))^), 8);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-8))^), 8);
     end;
     procedure TForthMachine.rrotn_uint64 (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-8))^), (Pointer(TUInt(WP) + (0))^), 8);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-8*(I+1)))^), (Pointer(TUInt(WP) + (-8*I))^), 8);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*8))^), 8);
     end;
     procedure TForthMachine.pick_uint64 (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -8*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            8);
       Inc(WP, 8 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 8); Move(WP^, Here^, 8); EA(8); end;
     procedure TForthMachine._dog_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 8); Inc(WP, 8 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-8))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 8); Dec(WP, (SizeOf(Pointer)) + 8) end;
     procedure TForthMachine.ptr_plus_uint64 (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 8; end;
     procedure TForthMachine._to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_uint64(Machine, Command) else _interpret_to_uint64(Machine, Command); end;
     procedure TForthMachine._compile_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint64-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-8))^), C[O].Data^, 8); Dec(WP, 8); end;
     procedure TForthMachine._interpret_to_uint64 (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after uint64-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-8))^), C.Data^, 8); Dec(WP, 8);
             end;
     procedure TForthMachine._value_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_uint64; Move((Pointer(TUInt(WP) + (-8))^), Here^, 8); Dec(WP, 8); EA(8); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_uint64 (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 8); Move(WP^, Here^, 8);} EA(8); end; end;
     procedure TForthMachine.RunValue_uint64 (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 8); Inc(WP, 8); end;
    procedure TForthMachine.literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin EWO('uint64-(literal)'); Dec(WP, 8); EWV(WP, 8); end;
    procedure TForthMachine.run_literal_uint64 (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 8); Inc(WP, 8); end;
    
   
    
     procedure TForthMachine.drop_embro (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4) end;
     procedure TForthMachine.dup_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.nip_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-1*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Dec(WP, 4) end;
     procedure TForthMachine.swap_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-4))^), WP^, 4); Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-4))^), 4); Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4); end;
     procedure TForthMachine.over_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (0))^), 4); Inc(WP, 4) end;
     procedure TForthMachine.tuck_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 2*4); Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-2*4))^), 4); Inc(WP, 4); end;
     procedure TForthMachine.lrot_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-3*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-2*4))^), 4);
     end;
     procedure TForthMachine.rrot_embro (Machine: TForthMachine; Command: PForthCommand);
     begin 
       Move((Pointer(TUInt(WP) + (-1*4))^), WP^, 4);
       Move((Pointer(TUInt(WP) + (-2*4))^), (Pointer(TUInt(WP) + (-1*4))^), 4);
       Move((Pointer(TUInt(WP) + (-3*4))^), (Pointer(TUInt(WP) + (-2*4))^), 4);
       Move(WP^, (Pointer(TUInt(WP) + (-3*4))^), 4);
     end;
     procedure TForthMachine.lrotn_embro (Machine: TForthMachine; Command: PForthCommand); 
     var
       N: Integer;
     begin 
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       Move((Pointer(TUInt(WP) + (-4*N))^), (Pointer(TUInt(WP) + (0))^), 4);
       while N > 0 do begin
         Move((Pointer(TUInt(WP) + (-4*(N-1)))^), (Pointer(TUInt(WP) + (-4*N))^), 4);
         Dec(N);
       end;
       //Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-4))^), 4);
     end;
     procedure TForthMachine.rrotn_embro (Machine: TForthMachine; Command: PForthCommand);
     var
       I: Integer;
       N: Integer;
     begin
       Dec(WP, SizeOf(TInt));
       N := TInt(WP^);
       //Move((Pointer(TUInt(WP) + (-4))^), (Pointer(TUInt(WP) + (0))^), 4);
       for I := 0 to N - 1 do
         Move((Pointer(TUInt(WP) + (-4*(I+1)))^), (Pointer(TUInt(WP) + (-4*I))^), 4);
       Move((Pointer(TUInt(WP) + (0))^), (Pointer(TUInt(WP) + (-N*4))^), 4);
     end;
     procedure TForthMachine.pick_embro (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Move((Pointer(TUInt(WP) + (-SizeOf(TInt) -4*TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))))^), 
            (Pointer(TUInt(WP) + (-SizeOf(TInt)))^),
            4);
       Inc(WP, 4 - SizeOf(TInt));
     end;
     procedure TForthMachine._comma_embro (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, 4); Move(WP^, Here^, 4); EA(4); end;
     procedure TForthMachine._dog_embro (Machine: TForthMachine; Command: PForthCommand); begin Move(Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, (Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^), 4); Inc(WP, 4 - (SizeOf(Pointer))) end;
     procedure TForthMachine._exclamation_embro (Machine: TForthMachine; Command: PForthCommand); begin Move((Pointer(TUInt(WP) + (-(SizeOf(Pointer))-4))^), Pointer((Pointer(TUInt(WP) + (-(SizeOf(Pointer))))^))^, 4); Dec(WP, (SizeOf(Pointer)) + 4) end;
     procedure TForthMachine.ptr_plus_embro (Machine: TForthMachine; Command: PForthCommand); begin PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PtrInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) + 4; end;
     procedure TForthMachine._to_embro (Machine: TForthMachine; Command: PForthCommand); begin if FState <> FS_INTERPRET then _compile_to_embro(Machine, Command) else _interpret_to_embro(Machine, Command); end;
     procedure TForthMachine._compile_to_embro (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@embro-to'); EWO(NextName); end;
     procedure TForthMachine._run_to_embro (Machine: TForthMachine; Command: PForthCommand); var O: TOpcode; begin O := ERO; Move((Pointer(TUInt(WP) + (-4))^), C[O].Data^, 4); Dec(WP, 4); end;
     procedure TForthMachine._interpret_to_embro (Machine: TForthMachine; Command: PForthCommand); var N: TString; C: PForthCommand; begin N := NextName; C := FindCommand(N);
               if C = nil then begin LogError('unkown name after embro-to: ' + N); FSession := False; Exit; end; 
               Move((Pointer(TUInt(WP) + (-4))^), C.Data^, 4); Dec(WP, 4);
             end;
     procedure TForthMachine._value_embro (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := RunValue_embro; Move((Pointer(TUInt(WP) + (-4))^), Here^, 4); Dec(WP, 4); EA(4); Flags := Flags and not 1; end; end;
     procedure TForthMachine._variable_embro (Machine: TForthMachine; Command: PForthCommand); begin with ReserveName(SNN)^ do begin Data := Here; Code := FDataCommands.PutDataPtr; {Dec(WP, 4); Move(WP^, Here^, 4);} EA(4); end; end;
     procedure TForthMachine.RunValue_embro (Machine: TForthMachine; Command: PForthCommand); begin Move(Command.Data^, WP^, 4); Inc(WP, 4); end;
    procedure TForthMachine.literal_embro (Machine: TForthMachine; Command: PForthCommand); begin EWO('embro-(literal)'); Dec(WP, 4); EWV(WP, 4); end;
    procedure TForthMachine.run_literal_embro (Machine: TForthMachine; Command: PForthCommand); begin ERV(WP, 4); Inc(WP, 4); end;
    
   
    
      procedure TForthMachine._plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine._minus (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine._star  (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine._equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine._0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine._ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end; end;
      procedure TForthMachine._0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine._max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
      end;
      procedure TForthMachine._min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
      end;
      procedure TForthMachine._minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
      end;
      procedure TForthMachine._dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' '); end;
      procedure TForthMachine._dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt)); end;
      procedure TForthMachine._ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt)); end;
      procedure TForthMachine._conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)), S);
        Dec(WP, SizeOf(TInt));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine._conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt(WP^), Code);
        Inc(WP, SizeOf(TInt));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.int_plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) + TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine.int_minus (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) - TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine.int_star  (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) * TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
      procedure TForthMachine.int_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) = TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) <> TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) <= TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := BOOL_TRUE*Ord(TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) >= TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt) - SizeOf(TInt)); end;
      procedure TForthMachine.int_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) = 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <> 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) < 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) > 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) := BOOL_TRUE*Ord((TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) >= 0); Dec(WP, SizeOf(TInt) - SizeOf(TInt)) end;
      procedure TForthMachine.int_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^))) <> 0 then begin TInt(WP^) := TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)); Inc(WP, SizeOf(TInt)); end; end;
      procedure TForthMachine.int_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) = 0 then begin Dec(WP, SizeOf(TInt)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.int_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) < TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
      end;
      procedure TForthMachine.int_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
        Dec(WP, SizeOf(TInt));
      end;
      procedure TForthMachine.int_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) > TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^), SizeOf(TInt));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt)))^), SizeOf(TInt));
        end;
      end;
      procedure TForthMachine.int_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt)); Write(TInt(WP^), ' '); end;
      procedure TForthMachine.int_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt)); Inc(WP, SizeOf(TInt)); end;
      procedure TForthMachine.int_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt)); end;
      procedure TForthMachine.int_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)), S);
        Dec(WP, SizeOf(TInt));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.int_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt(WP^), Code);
        Inc(WP, SizeOf(TInt));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.int8_plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) + TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8)); end;
      procedure TForthMachine.int8_minus (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) - TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8)); end;
      procedure TForthMachine.int8_star  (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) * TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8)); end;
      procedure TForthMachine.int8_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) = TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) <> TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) <= TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord(TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) >= TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.int8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) = 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) <> 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) < 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) > 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) <= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) := BOOL_TRUE*Ord((TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) >= 0); Dec(WP, SizeOf(TInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.int8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^))) <> 0 then begin TInt8(WP^) := TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)); Inc(WP, SizeOf(TInt8)); end; end;
      procedure TForthMachine.int8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)) = 0 then begin Dec(WP, SizeOf(TInt8)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.int8_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) < TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
      end;
      procedure TForthMachine.int8_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
        Dec(WP, SizeOf(TInt8));
      end;
      procedure TForthMachine.int8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) > TInt8((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^), SizeOf(TInt8));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt8)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt8)))^), SizeOf(TInt8));
        end;
      end;
      procedure TForthMachine.int8_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt8)); Write(TInt8(WP^), ' '); end;
      procedure TForthMachine.int8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt8; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt8)); Inc(WP, SizeOf(TInt8)); end;
      procedure TForthMachine.int8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt8((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt8)); end;
      procedure TForthMachine.int8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)), S);
        Dec(WP, SizeOf(TInt8));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.int8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt8(WP^), Code);
        Inc(WP, SizeOf(TInt8));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.int16_plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) + TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16)); end;
      procedure TForthMachine.int16_minus (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) - TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16)); end;
      procedure TForthMachine.int16_star  (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) * TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16)); end;
      procedure TForthMachine.int16_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) = TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) <> TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) <= TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord(TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) >= TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.int16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) = 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) <> 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) < 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) > 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) <= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) := BOOL_TRUE*Ord((TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) >= 0); Dec(WP, SizeOf(TInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.int16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^))) <> 0 then begin TInt16(WP^) := TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)); Inc(WP, SizeOf(TInt16)); end; end;
      procedure TForthMachine.int16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)) = 0 then begin Dec(WP, SizeOf(TInt16)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.int16_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) < TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
      end;
      procedure TForthMachine.int16_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
        Dec(WP, SizeOf(TInt16));
      end;
      procedure TForthMachine.int16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) > TInt16((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^), SizeOf(TInt16));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt16)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt16)))^), SizeOf(TInt16));
        end;
      end;
      procedure TForthMachine.int16_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt16)); Write(TInt16(WP^), ' '); end;
      procedure TForthMachine.int16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt16; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt16)); Inc(WP, SizeOf(TInt16)); end;
      procedure TForthMachine.int16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt16((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt16)); end;
      procedure TForthMachine.int16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)), S);
        Dec(WP, SizeOf(TInt16));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.int16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt16(WP^), Code);
        Inc(WP, SizeOf(TInt16));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.int32_plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) + TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32)); end;
      procedure TForthMachine.int32_minus (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) - TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32)); end;
      procedure TForthMachine.int32_star  (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) * TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32)); end;
      procedure TForthMachine.int32_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) = TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) <> TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) <= TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord(TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) >= TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.int32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) = 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) <> 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) < 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) > 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) <= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) := BOOL_TRUE*Ord((TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) >= 0); Dec(WP, SizeOf(TInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.int32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^))) <> 0 then begin TInt32(WP^) := TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)); Inc(WP, SizeOf(TInt32)); end; end;
      procedure TForthMachine.int32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)) = 0 then begin Dec(WP, SizeOf(TInt32)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.int32_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) < TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
      end;
      procedure TForthMachine.int32_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
        Dec(WP, SizeOf(TInt32));
      end;
      procedure TForthMachine.int32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) > TInt32((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^), SizeOf(TInt32));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt32)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt32)))^), SizeOf(TInt32));
        end;
      end;
      procedure TForthMachine.int32_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt32)); Write(TInt32(WP^), ' '); end;
      procedure TForthMachine.int32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt32; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt32)); Inc(WP, SizeOf(TInt32)); end;
      procedure TForthMachine.int32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt32((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt32)); end;
      procedure TForthMachine.int32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)), S);
        Dec(WP, SizeOf(TInt32));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.int32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt32(WP^), Code);
        Inc(WP, SizeOf(TInt32));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.int64_plus  (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) + TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64)); end;
      procedure TForthMachine.int64_minus (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) - TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64)); end;
      procedure TForthMachine.int64_star  (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) * TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64)); end;
      procedure TForthMachine.int64_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) = TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) <> TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) <= TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord(TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) >= TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.int64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) = 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) <> 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) < 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) > 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) <= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) := BOOL_TRUE*Ord((TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) >= 0); Dec(WP, SizeOf(TInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.int64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^))) <> 0 then begin TInt64(WP^) := TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)); Inc(WP, SizeOf(TInt64)); end; end;
      procedure TForthMachine.int64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)) = 0 then begin Dec(WP, SizeOf(TInt64)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.int64_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) < TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
      end;
      procedure TForthMachine.int64_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
        Dec(WP, SizeOf(TInt64));
      end;
      procedure TForthMachine.int64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) > TInt64((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^), SizeOf(TInt64));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TInt64)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TInt64)))^), SizeOf(TInt64));
        end;
      end;
      procedure TForthMachine.int64_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TInt64)); Write(TInt64(WP^), ' '); end;
      procedure TForthMachine.int64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TInt64; begin Read(Temp); Move(Temp, WP^, SizeOf(TInt64)); Inc(WP, SizeOf(TInt64)); end;
      procedure TForthMachine.int64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TInt64((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TInt64)); end;
      procedure TForthMachine.int64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)), S);
        Dec(WP, SizeOf(TInt64));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.int64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TInt64(WP^), Code);
        Inc(WP, SizeOf(TInt64));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.uint_plus  (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) + TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt)); end;
      procedure TForthMachine.uint_minus (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) - TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt)); end;
      procedure TForthMachine.uint_star  (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) * TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt)); end;
      procedure TForthMachine.uint_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) = TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) <> TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) <= TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord(TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) >= TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt) - SizeOf(TInt)); end;
      procedure TForthMachine.uint_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) = 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) <> 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) < 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) > 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) <= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) := BOOL_TRUE*Ord((TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) >= 0); Dec(WP, SizeOf(TUInt) - SizeOf(TInt)) end;
      procedure TForthMachine.uint_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^))) <> 0 then begin TUInt(WP^) := TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)); Inc(WP, SizeOf(TUInt)); end; end;
      procedure TForthMachine.uint_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)) = 0 then begin Dec(WP, SizeOf(TUInt)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.uint_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) < TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
      end;
      procedure TForthMachine.uint_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
        Dec(WP, SizeOf(TUInt));
      end;
      procedure TForthMachine.uint_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) > TUInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^), SizeOf(TUInt));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TUInt)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TUInt)))^), SizeOf(TUInt));
        end;
      end;
      procedure TForthMachine.uint_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TUInt)); Write(TUInt(WP^), ' '); end;
      procedure TForthMachine.uint_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt; begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt)); Inc(WP, SizeOf(TUInt)); end;
      procedure TForthMachine.uint_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TUInt((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TUInt)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt)); end;
      procedure TForthMachine.uint_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)), S);
        Dec(WP, SizeOf(TUInt));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.uint_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TUInt(WP^), Code);
        Inc(WP, SizeOf(TUInt));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.uint8_plus  (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) + TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8)); end;
      procedure TForthMachine.uint8_minus (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) - TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8)); end;
      procedure TForthMachine.uint8_star  (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) * TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8)); end;
      procedure TForthMachine.uint8_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) = TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) <> TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) <= TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord(TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) >= TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt8) - SizeOf(TInt)); end;
      procedure TForthMachine.uint8_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) = 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) <> 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) < 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) > 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) <= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) := BOOL_TRUE*Ord((TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) >= 0); Dec(WP, SizeOf(TUInt8) - SizeOf(TInt)) end;
      procedure TForthMachine.uint8_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^))) <> 0 then begin TUInt8(WP^) := TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)); Inc(WP, SizeOf(TUInt8)); end; end;
      procedure TForthMachine.uint8_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)) = 0 then begin Dec(WP, SizeOf(TUInt8)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.uint8_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) < TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
      end;
      procedure TForthMachine.uint8_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        Dec(WP, SizeOf(TUInt8));
      end;
      procedure TForthMachine.uint8_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) > TUInt8((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^), SizeOf(TUInt8));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TUInt8)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TUInt8)))^), SizeOf(TUInt8));
        end;
      end;
      procedure TForthMachine.uint8_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TUInt8)); Write(TUInt8(WP^), ' '); end;
      procedure TForthMachine.uint8_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt8; begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt8)); Inc(WP, SizeOf(TUInt8)); end;
      procedure TForthMachine.uint8_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TUInt8((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TUInt8)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt8)); end;
      procedure TForthMachine.uint8_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)), S);
        Dec(WP, SizeOf(TUInt8));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.uint8_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TUInt8(WP^), Code);
        Inc(WP, SizeOf(TUInt8));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.uint16_plus  (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) + TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16)); end;
      procedure TForthMachine.uint16_minus (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) - TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16)); end;
      procedure TForthMachine.uint16_star  (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) * TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16)); end;
      procedure TForthMachine.uint16_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) = TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) <> TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) <= TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord(TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) >= TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt16) - SizeOf(TInt)); end;
      procedure TForthMachine.uint16_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) = 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) <> 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) < 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) > 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) <= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) := BOOL_TRUE*Ord((TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) >= 0); Dec(WP, SizeOf(TUInt16) - SizeOf(TInt)) end;
      procedure TForthMachine.uint16_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^))) <> 0 then begin TUInt16(WP^) := TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)); Inc(WP, SizeOf(TUInt16)); end; end;
      procedure TForthMachine.uint16_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)) = 0 then begin Dec(WP, SizeOf(TUInt16)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.uint16_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) < TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
      end;
      procedure TForthMachine.uint16_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        Dec(WP, SizeOf(TUInt16));
      end;
      procedure TForthMachine.uint16_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) > TUInt16((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^), SizeOf(TUInt16));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TUInt16)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TUInt16)))^), SizeOf(TUInt16));
        end;
      end;
      procedure TForthMachine.uint16_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TUInt16)); Write(TUInt16(WP^), ' '); end;
      procedure TForthMachine.uint16_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt16; begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt16)); Inc(WP, SizeOf(TUInt16)); end;
      procedure TForthMachine.uint16_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TUInt16((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TUInt16)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt16)); end;
      procedure TForthMachine.uint16_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)), S);
        Dec(WP, SizeOf(TUInt16));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.uint16_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TUInt16(WP^), Code);
        Inc(WP, SizeOf(TUInt16));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.uint32_plus  (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) + TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32)); end;
      procedure TForthMachine.uint32_minus (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) - TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32)); end;
      procedure TForthMachine.uint32_star  (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) * TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32)); end;
      procedure TForthMachine.uint32_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) = TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) <> TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) <= TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord(TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) >= TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt32) - SizeOf(TInt)); end;
      procedure TForthMachine.uint32_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) = 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) <> 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) < 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) > 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) <= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) := BOOL_TRUE*Ord((TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) >= 0); Dec(WP, SizeOf(TUInt32) - SizeOf(TInt)) end;
      procedure TForthMachine.uint32_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^))) <> 0 then begin TUInt32(WP^) := TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)); Inc(WP, SizeOf(TUInt32)); end; end;
      procedure TForthMachine.uint32_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)) = 0 then begin Dec(WP, SizeOf(TUInt32)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.uint32_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) < TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
      end;
      procedure TForthMachine.uint32_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        Dec(WP, SizeOf(TUInt32));
      end;
      procedure TForthMachine.uint32_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) > TUInt32((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^), SizeOf(TUInt32));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TUInt32)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TUInt32)))^), SizeOf(TUInt32));
        end;
      end;
      procedure TForthMachine.uint32_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TUInt32)); Write(TUInt32(WP^), ' '); end;
      procedure TForthMachine.uint32_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt32; begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt32)); Inc(WP, SizeOf(TUInt32)); end;
      procedure TForthMachine.uint32_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TUInt32((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TUInt32)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt32)); end;
      procedure TForthMachine.uint32_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)), S);
        Dec(WP, SizeOf(TUInt32));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.uint32_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TUInt32(WP^), Code);
        Inc(WP, SizeOf(TUInt32));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.uint64_plus  (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) + TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64)); end;
      procedure TForthMachine.uint64_minus (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) - TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64)); end;
      procedure TForthMachine.uint64_star  (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) * TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64)); end;
      procedure TForthMachine.uint64_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) = TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) <> TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) <= TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord(TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) >= TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))); 
                                                   Dec(WP, 2*SizeOf(TUInt64) - SizeOf(TInt)); end;
      procedure TForthMachine.uint64_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) = 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) <> 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) < 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) > 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) <= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) := BOOL_TRUE*Ord((TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) >= 0); Dec(WP, SizeOf(TUInt64) - SizeOf(TInt)) end;
      procedure TForthMachine.uint64_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^))) <> 0 then begin TUInt64(WP^) := TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)); Inc(WP, SizeOf(TUInt64)); end; end;
      procedure TForthMachine.uint64_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)) = 0 then begin Dec(WP, SizeOf(TUInt64)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.uint64_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) < TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
      end;
      procedure TForthMachine.uint64_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        Dec(WP, SizeOf(TUInt64));
      end;
      procedure TForthMachine.uint64_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) > TUInt64((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^), (Pointer(TUInt(WP) + (-0*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^), (Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^), SizeOf(TUInt64));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(TUInt64)))^), (Pointer(TUInt(WP) + (-1*SizeOf(TUInt64)))^), SizeOf(TUInt64));
        end;
      end;
      procedure TForthMachine.uint64_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(TUInt64)); Write(TUInt64(WP^), ' '); end;
      procedure TForthMachine.uint64_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: TUInt64; begin Read(Temp); Move(Temp, WP^, SizeOf(TUInt64)); Inc(WP, SizeOf(TUInt64)); end;
      procedure TForthMachine.uint64_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + TUInt64((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(TUInt64)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(TUInt64)); end;
      procedure TForthMachine.uint64_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)), S);
        Dec(WP, SizeOf(TUInt64));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.uint64_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), TUInt64(WP^), Code);
        Inc(WP, SizeOf(TUInt64));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.single_plus  (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) + Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single)); end;
      procedure TForthMachine.single_minus (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) - Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single)); end;
      procedure TForthMachine.single_star  (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) * Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single)); end;
      procedure TForthMachine.single_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) = Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) <> Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) <= Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := BOOL_TRUE*Ord(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) >= Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); 
                                                   Dec(WP, 2*SizeOf(Single) - SizeOf(TInt)); end;
      procedure TForthMachine.single_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) = 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) <> 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) < 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) > 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) <= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) := BOOL_TRUE*Ord((Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) >= 0); Dec(WP, SizeOf(Single) - SizeOf(TInt)) end;
      procedure TForthMachine.single_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^))) <> 0 then begin Single(WP^) := Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)); Inc(WP, SizeOf(Single)); end; end;
      procedure TForthMachine.single_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) = 0 then begin Dec(WP, SizeOf(Single)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.single_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) < Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
      end;
      procedure TForthMachine.single_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
        Dec(WP, SizeOf(Single));
      end;
      procedure TForthMachine.single_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) > Single((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^), (Pointer(TUInt(WP) + (-0*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Single)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Single)))^), SizeOf(Single));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(Single)))^), (Pointer(TUInt(WP) + (-1*SizeOf(Single)))^), SizeOf(Single));
        end;
      end;
      procedure TForthMachine.single_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(Single)); Write(Single(WP^), ' '); end;
      procedure TForthMachine.single_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Single; begin Read(Temp); Move(Temp, WP^, SizeOf(Single)); Inc(WP, SizeOf(Single)); end;
      procedure TForthMachine.single_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin Single(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := Single(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + Single((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(Single)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Single)); end;
      procedure TForthMachine.single_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)), S);
        Dec(WP, SizeOf(Single));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.single_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), Single(WP^), Code);
        Inc(WP, SizeOf(Single));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.double_plus  (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) + Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double)); end;
      procedure TForthMachine.double_minus (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) - Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double)); end;
      procedure TForthMachine.double_star  (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) * Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double)); end;
      procedure TForthMachine.double_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) = Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) <> Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) <= Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := BOOL_TRUE*Ord(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) >= Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); 
                                                   Dec(WP, 2*SizeOf(Double) - SizeOf(TInt)); end;
      procedure TForthMachine.double_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) = 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) <> 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) < 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) > 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) <= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) := BOOL_TRUE*Ord((Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) >= 0); Dec(WP, SizeOf(Double) - SizeOf(TInt)) end;
      procedure TForthMachine.double_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^))) <> 0 then begin Double(WP^) := Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)); Inc(WP, SizeOf(Double)); end; end;
      procedure TForthMachine.double_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) = 0 then begin Dec(WP, SizeOf(Double)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.double_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) < Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
      end;
      procedure TForthMachine.double_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
        Dec(WP, SizeOf(Double));
      end;
      procedure TForthMachine.double_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) > Double((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^), (Pointer(TUInt(WP) + (-0*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Double)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Double)))^), SizeOf(Double));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(Double)))^), (Pointer(TUInt(WP) + (-1*SizeOf(Double)))^), SizeOf(Double));
        end;
      end;
      procedure TForthMachine.double_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(Double)); Write(Double(WP^), ' '); end;
      procedure TForthMachine.double_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Double; begin Read(Temp); Move(Temp, WP^, SizeOf(Double)); Inc(WP, SizeOf(Double)); end;
      procedure TForthMachine.double_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin Double(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := Double(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + Double((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(Double)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Double)); end;
      procedure TForthMachine.double_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)), S);
        Dec(WP, SizeOf(Double));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.double_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), Double(WP^), Code);
        Inc(WP, SizeOf(Double));
        FStringCommands.DelRef(S);
      end;
    
   
    
      procedure TForthMachine.extended_plus  (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) + Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended)); end;
      procedure TForthMachine.extended_minus (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) - Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended)); end;
      procedure TForthMachine.extended_star  (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) * Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended)); end;
      procedure TForthMachine.extended_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) = Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) <> Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_lt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_gt (Machine: TForthMachine; Command: PForthCommand);    begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_lte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) <= Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_gte (Machine: TForthMachine; Command: PForthCommand);   begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := BOOL_TRUE*Ord(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) >= Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); 
                                                   Dec(WP, 2*SizeOf(Extended) - SizeOf(TInt)); end;
      procedure TForthMachine.extended_0_equel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) = 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_0_nequel (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) <> 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_0_lt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) < 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_0_gt (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) > 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_0_lte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) <= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_0_gte (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) := BOOL_TRUE*Ord((Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) >= 0); Dec(WP, SizeOf(Extended) - SizeOf(TInt)) end;
      procedure TForthMachine.extended_ask_dup (Machine: TForthMachine; Command: PForthCommand); begin if (Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^))) <> 0 then begin Extended(WP^) := Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)); Inc(WP, SizeOf(Extended)); end; end;
      procedure TForthMachine.extended_0_exit (Machine: TForthMachine; Command: PForthCommand); begin if Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) = 0 then begin Dec(WP, SizeOf(Extended)); FControlCommands._exit(Machine, Command); end end;
      procedure TForthMachine.extended_max (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) < Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
      end;
      procedure TForthMachine.extended_min (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) then
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
        Dec(WP, SizeOf(Extended));
      end;
      procedure TForthMachine.extended_minmax (Machine: TForthMachine; Command: PForthCommand);
      begin
        if Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) > Extended((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^)) then begin
          Move((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^), (Pointer(TUInt(WP) + (-0*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^), (Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^), SizeOf(Extended));
          Move((Pointer(TUInt(WP) + (-0*SizeOf(Extended)))^), (Pointer(TUInt(WP) + (-1*SizeOf(Extended)))^), SizeOf(Extended));
        end;
      end;
      procedure TForthMachine.extended_dot (Machine: TForthMachine; Command: PForthCommand);    begin Dec(WP, SizeOf(Extended)); Write(Extended(WP^), ' '); end;
      procedure TForthMachine.extended_dollar (Machine: TForthMachine; Command: PForthCommand); var Temp: Extended; begin Read(Temp); Move(Temp, WP^, SizeOf(Extended)); Inc(WP, SizeOf(Extended)); end;
      procedure TForthMachine.extended_ptr_plus_exclamation (Machine: TForthMachine; Command: PForthCommand); begin Extended(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := Extended(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + Extended((Pointer(TUInt(WP) + (-SizeOf(Pointer)-SizeOf(Extended)))^)); Dec(WP, SizeOf(Pointer) + SizeOf(Extended)); end;
      procedure TForthMachine.extended_conv_to_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
      begin
        Str(Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)), S);
        Dec(WP, SizeOf(Extended));
        FStringCommands.str_push(Machine, Command, S);
      end;
      procedure TForthMachine.extended_conv_from_str (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TStr;
        Code: Word;
      begin
        S := FStringCommands.str_pop(Machine, Command);
        Val(PChar(@(TStrRec(S^).Sym[0])), Extended(WP^), Code);
        Inc(WP, SizeOf(Extended));
        FStringCommands.DelRef(S);
      end;
    
   
    procedure TForthMachine._abs (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); end;
     procedure TForthMachine._neg (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); end;
    
   
    procedure TForthMachine.int_abs (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := Abs(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))); end;
     procedure TForthMachine.int_neg (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := - TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); end;
    
   
    procedure TForthMachine.int8_abs (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)) := Abs(TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))); end;
     procedure TForthMachine.int8_neg (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)) := - TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); end;
    
   
    procedure TForthMachine.int16_abs (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)) := Abs(TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))); end;
     procedure TForthMachine.int16_neg (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)) := - TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); end;
    
   
    procedure TForthMachine.int32_abs (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)) := Abs(TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))); end;
     procedure TForthMachine.int32_neg (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)) := - TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); end;
    
   
    procedure TForthMachine.int64_abs (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)) := Abs(TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))); end;
     procedure TForthMachine.int64_neg (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)) := - TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); end;
    
   
    procedure TForthMachine.single_abs (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Abs(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); end;
     procedure TForthMachine.single_neg (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := - Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); end;
    
   
    procedure TForthMachine.double_abs (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Abs(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); end;
     procedure TForthMachine.double_neg (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := - Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); end;
    
   
    
     function TForthMachine.ConvertStrTo(const S: TString; var X: TInt): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine._push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then _compile_push(Machine, Command) else _interpret_push(Machine, Command) end;
     procedure TForthMachine._interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt)); end;
     procedure TForthMachine._compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@-push'); EW_(StrToInt(NextName)); end;
     procedure TForthMachine._run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt(WP^) := ER_; Inc(WP, SizeOf(TInt)); end;
     procedure TForthMachine._1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))) end;
     procedure TForthMachine._1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))) end;
     procedure TForthMachine._div (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
     procedure TForthMachine._mod (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
     procedure TForthMachine._divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (0))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine._ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine._ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrToint(const S: TString; var X: TInt): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.int_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then int_compile_push(Machine, Command) else int_interpret_push(Machine, Command) end;
     procedure TForthMachine.int_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt(WP^) := TInt(StrToInt(NextName)); Inc(WP, SizeOf(TInt)); end;
     procedure TForthMachine.int_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int-push'); EW_int(StrToInt(NextName)); end;
     procedure TForthMachine.int_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt(WP^) := ER_int; Inc(WP, SizeOf(TInt)); end;
     procedure TForthMachine.int_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))) end;
     procedure TForthMachine.int_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))) end;
     procedure TForthMachine.int_div (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
     procedure TForthMachine.int_mod (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                   Dec(WP, SizeOf(TInt)); end;
     procedure TForthMachine.int_divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (0))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) mod TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                     TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-2*SizeOf(TInt)))^)) div TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^));
                                                     TInt((Pointer(TUInt(WP) + (-  SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.int_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.int_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrToint8(const S: TString; var X: TInt8): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.int8_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then int8_compile_push(Machine, Command) else int8_interpret_push(Machine, Command) end;
     procedure TForthMachine.int8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt8(WP^) := TInt8(StrToInt(NextName)); Inc(WP, SizeOf(TInt8)); end;
     procedure TForthMachine.int8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int8-push'); EW_int8(StrToInt(NextName)); end;
     procedure TForthMachine.int8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt8(WP^) := ER_int8; Inc(WP, SizeOf(TInt8)); end;
     procedure TForthMachine.int8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))) end;
     procedure TForthMachine.int8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^))) end;
     procedure TForthMachine.int8_div (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8)); end;
     procedure TForthMachine.int8_mod (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                   Dec(WP, SizeOf(TInt8)); end;
     procedure TForthMachine.int8_divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (0))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) mod TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                     TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-2*SizeOf(TInt8)))^)) div TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^));
                                                     TInt8((Pointer(TUInt(WP) + (-  SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.int8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.int8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrToint16(const S: TString; var X: TInt16): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.int16_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then int16_compile_push(Machine, Command) else int16_interpret_push(Machine, Command) end;
     procedure TForthMachine.int16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt16(WP^) := TInt16(StrToInt(NextName)); Inc(WP, SizeOf(TInt16)); end;
     procedure TForthMachine.int16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int16-push'); EW_int16(StrToInt(NextName)); end;
     procedure TForthMachine.int16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt16(WP^) := ER_int16; Inc(WP, SizeOf(TInt16)); end;
     procedure TForthMachine.int16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))) end;
     procedure TForthMachine.int16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^))) end;
     procedure TForthMachine.int16_div (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16)); end;
     procedure TForthMachine.int16_mod (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                   Dec(WP, SizeOf(TInt16)); end;
     procedure TForthMachine.int16_divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (0))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) mod TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                     TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-2*SizeOf(TInt16)))^)) div TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^));
                                                     TInt16((Pointer(TUInt(WP) + (-  SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.int16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.int16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrToint32(const S: TString; var X: TInt32): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.int32_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then int32_compile_push(Machine, Command) else int32_interpret_push(Machine, Command) end;
     procedure TForthMachine.int32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt32(WP^) := TInt32(StrToInt(NextName)); Inc(WP, SizeOf(TInt32)); end;
     procedure TForthMachine.int32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int32-push'); EW_int32(StrToInt(NextName)); end;
     procedure TForthMachine.int32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt32(WP^) := ER_int32; Inc(WP, SizeOf(TInt32)); end;
     procedure TForthMachine.int32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))) end;
     procedure TForthMachine.int32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^))) end;
     procedure TForthMachine.int32_div (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32)); end;
     procedure TForthMachine.int32_mod (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                   Dec(WP, SizeOf(TInt32)); end;
     procedure TForthMachine.int32_divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (0))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) mod TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                     TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-2*SizeOf(TInt32)))^)) div TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^));
                                                     TInt32((Pointer(TUInt(WP) + (-  SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.int32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.int32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrToint64(const S: TString; var X: TInt64): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.int64_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then int64_compile_push(Machine, Command) else int64_interpret_push(Machine, Command) end;
     procedure TForthMachine.int64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt64(WP^) := TInt64(StrToInt(NextName)); Inc(WP, SizeOf(TInt64)); end;
     procedure TForthMachine.int64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@int64-push'); EW_int64(StrToInt(NextName)); end;
     procedure TForthMachine.int64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TInt64(WP^) := ER_int64; Inc(WP, SizeOf(TInt64)); end;
     procedure TForthMachine.int64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))) end;
     procedure TForthMachine.int64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^))) end;
     procedure TForthMachine.int64_div (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64)); end;
     procedure TForthMachine.int64_mod (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                   Dec(WP, SizeOf(TInt64)); end;
     procedure TForthMachine.int64_divmod (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (0))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) mod TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                     TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-2*SizeOf(TInt64)))^)) div TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^));
                                                     TInt64((Pointer(TUInt(WP) + (-  SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.int64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.int64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrTouint(const S: TString; var X: TUInt): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.uint_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then uint_compile_push(Machine, Command) else uint_interpret_push(Machine, Command) end;
     procedure TForthMachine.uint_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt(WP^) := TUInt(StrToInt(NextName)); Inc(WP, SizeOf(TUInt)); end;
     procedure TForthMachine.uint_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint-push'); EW_uint(StrToInt(NextName)); end;
     procedure TForthMachine.uint_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt(WP^) := ER_uint; Inc(WP, SizeOf(TUInt)); end;
     procedure TForthMachine.uint_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))) end;
     procedure TForthMachine.uint_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^))) end;
     procedure TForthMachine.uint_div (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt)); end;
     procedure TForthMachine.uint_mod (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                   Dec(WP, SizeOf(TUInt)); end;
     procedure TForthMachine.uint_divmod (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (0))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) mod TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                     TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-2*SizeOf(TUInt)))^)) div TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^));
                                                     TUInt((Pointer(TUInt(WP) + (-  SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.uint_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.uint_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrTouint8(const S: TString; var X: TUInt8): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.uint8_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then uint8_compile_push(Machine, Command) else uint8_interpret_push(Machine, Command) end;
     procedure TForthMachine.uint8_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt8(WP^) := TUInt8(StrToInt(NextName)); Inc(WP, SizeOf(TUInt8)); end;
     procedure TForthMachine.uint8_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint8-push'); EW_uint8(StrToInt(NextName)); end;
     procedure TForthMachine.uint8_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt8(WP^) := ER_uint8; Inc(WP, SizeOf(TUInt8)); end;
     procedure TForthMachine.uint8_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))) end;
     procedure TForthMachine.uint8_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^))) end;
     procedure TForthMachine.uint8_div (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8)); end;
     procedure TForthMachine.uint8_mod (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                   Dec(WP, SizeOf(TUInt8)); end;
     procedure TForthMachine.uint8_divmod (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (0))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) mod TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                     TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-2*SizeOf(TUInt8)))^)) div TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^));
                                                     TUInt8((Pointer(TUInt(WP) + (-  SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.uint8_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.uint8_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt8(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrTouint16(const S: TString; var X: TUInt16): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.uint16_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then uint16_compile_push(Machine, Command) else uint16_interpret_push(Machine, Command) end;
     procedure TForthMachine.uint16_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt16(WP^) := TUInt16(StrToInt(NextName)); Inc(WP, SizeOf(TUInt16)); end;
     procedure TForthMachine.uint16_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint16-push'); EW_uint16(StrToInt(NextName)); end;
     procedure TForthMachine.uint16_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt16(WP^) := ER_uint16; Inc(WP, SizeOf(TUInt16)); end;
     procedure TForthMachine.uint16_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))) end;
     procedure TForthMachine.uint16_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^))) end;
     procedure TForthMachine.uint16_div (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16)); end;
     procedure TForthMachine.uint16_mod (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                   Dec(WP, SizeOf(TUInt16)); end;
     procedure TForthMachine.uint16_divmod (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (0))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) mod TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                     TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-2*SizeOf(TUInt16)))^)) div TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^));
                                                     TUInt16((Pointer(TUInt(WP) + (-  SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.uint16_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.uint16_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt16(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrTouint32(const S: TString; var X: TUInt32): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.uint32_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then uint32_compile_push(Machine, Command) else uint32_interpret_push(Machine, Command) end;
     procedure TForthMachine.uint32_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt32(WP^) := TUInt32(StrToInt(NextName)); Inc(WP, SizeOf(TUInt32)); end;
     procedure TForthMachine.uint32_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint32-push'); EW_uint32(StrToInt(NextName)); end;
     procedure TForthMachine.uint32_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt32(WP^) := ER_uint32; Inc(WP, SizeOf(TUInt32)); end;
     procedure TForthMachine.uint32_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))) end;
     procedure TForthMachine.uint32_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^))) end;
     procedure TForthMachine.uint32_div (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32)); end;
     procedure TForthMachine.uint32_mod (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                   Dec(WP, SizeOf(TUInt32)); end;
     procedure TForthMachine.uint32_divmod (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (0))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) mod TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                     TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-2*SizeOf(TUInt32)))^)) div TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^));
                                                     TUInt32((Pointer(TUInt(WP) + (-  SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.uint32_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.uint32_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt32(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     function TForthMachine.ConvertStrTouint64(const S: TString; var X: TUInt64): Integer;
     const
       Digits: array[0..15] of TChar = ('0', '1', '2', '3', '4', '5', '6', 
                                        '7', '8', '9', 'A', 'B', 'C', 'D',
                                        'E', 'F');
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
       Result := Ord(Length(S) <> 0);
       if Result = 0 then
         Exit; 
       if S[1] = 'h' then begin
         Inc(Result);
         while Result <= Length(S) do begin
           if not GetDigit(S[Result], D) then
             Exit;
           X := (X shl 4) or D;
           Inc(Result);
         end;
         Result := 0;
       end else
         Val(S, X, Result);
     end;
     procedure TForthMachine.uint64_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then uint64_compile_push(Machine, Command) else uint64_interpret_push(Machine, Command) end;
     procedure TForthMachine.uint64_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt64(WP^) := TUInt64(StrToInt(NextName)); Inc(WP, SizeOf(TUInt64)); end;
     procedure TForthMachine.uint64_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@uint64-push'); EW_uint64(StrToInt(NextName)); end;
     procedure TForthMachine.uint64_run_push  (Machine: TForthMachine; Command: PForthCommand); begin TUInt64(WP^) := ER_uint64; Inc(WP, SizeOf(TUInt64)); end;
     procedure TForthMachine.uint64_1_plus (Machine: TForthMachine; Command: PForthCommand);  begin Inc(TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))) end;
     procedure TForthMachine.uint64_1_minus (Machine: TForthMachine; Command: PForthCommand); begin Dec(TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^))) end;
     procedure TForthMachine.uint64_div (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64)); end;
     procedure TForthMachine.uint64_mod (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                   Dec(WP, SizeOf(TUInt64)); end;
     procedure TForthMachine.uint64_divmod (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (0))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) mod TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                     TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-2*SizeOf(TUInt64)))^)) div TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^));
                                                     TUInt64((Pointer(TUInt(WP) + (-  SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (0))^)); 
                                               end;
     procedure TForthMachine.uint64_ptr_inc (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) + 1; 
       Dec(WP, SizeOf(Pointer));
     end;
     procedure TForthMachine.uint64_ptr_dec (Machine: TForthMachine; Command: PForthCommand);
     begin
       TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) := 
                         TUInt64(Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))^) - 1; 
       Dec(WP, SizeOf(Pointer));
     end;
    
   
    
     procedure TForthMachine.int_convert_to_int8 (Machine: TForthMachine; Command: PForthCommand); begin TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt8)); end;
    
   
    
     procedure TForthMachine.int_convert_to_int16 (Machine: TForthMachine; Command: PForthCommand); begin TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt16)); end;
    
   
    
     procedure TForthMachine.int_convert_to_int32 (Machine: TForthMachine; Command: PForthCommand); begin TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt32)); end;
    
   
    
     procedure TForthMachine.int_convert_to_int64 (Machine: TForthMachine; Command: PForthCommand); begin TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)); 
                                                            Dec(WP, SizeOf(TInt) - SizeOf(TInt64)); end;
    
   
    
     procedure TForthMachine.int8_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)) := TInt8((Pointer(TUInt(WP) + (-SizeOf(TInt8)))^)); 
                                                            Dec(WP, SizeOf(TInt8) - SizeOf(TInt)); end;
    
   
    
     procedure TForthMachine.int16_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)) := TInt16((Pointer(TUInt(WP) + (-SizeOf(TInt16)))^)); 
                                                            Dec(WP, SizeOf(TInt16) - SizeOf(TInt)); end;
    
   
    
     procedure TForthMachine.int32_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)) := TInt32((Pointer(TUInt(WP) + (-SizeOf(TInt32)))^)); 
                                                            Dec(WP, SizeOf(TInt32) - SizeOf(TInt)); end;
    
   
    
     procedure TForthMachine.int64_convert_to_int (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)) := TInt64((Pointer(TUInt(WP) + (-SizeOf(TInt64)))^)); 
                                                            Dec(WP, SizeOf(TInt64) - SizeOf(TInt)); end;
    
   
    
     procedure TForthMachine.uint_convert_to_uint8 (Machine: TForthMachine; Command: PForthCommand); begin TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt8)); end;
    
   
    
     procedure TForthMachine.uint_convert_to_uint16 (Machine: TForthMachine; Command: PForthCommand); begin TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt16)); end;
    
   
    
     procedure TForthMachine.uint_convert_to_uint32 (Machine: TForthMachine; Command: PForthCommand); begin TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt32)); end;
    
   
    
     procedure TForthMachine.uint_convert_to_uint64 (Machine: TForthMachine; Command: PForthCommand); begin TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)) := TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt)))^)); 
                                                            Dec(WP, SizeOf(TUInt) - SizeOf(TUInt64)); end;
    
   
    
     procedure TForthMachine.uint8_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)) := TUInt8((Pointer(TUInt(WP) + (-SizeOf(TUInt8)))^)); 
                                                            Dec(WP, SizeOf(TUInt8) - SizeOf(TUInt)); end;
    
   
    
     procedure TForthMachine.uint16_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)) := TUInt16((Pointer(TUInt(WP) + (-SizeOf(TUInt16)))^)); 
                                                            Dec(WP, SizeOf(TUInt16) - SizeOf(TUInt)); end;
    
   
    
     procedure TForthMachine.uint32_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)) := TUInt32((Pointer(TUInt(WP) + (-SizeOf(TUInt32)))^)); 
                                                            Dec(WP, SizeOf(TUInt32) - SizeOf(TUInt)); end;
    
   
    
     procedure TForthMachine.uint64_convert_to_uint (Machine: TForthMachine; Command: PForthCommand); begin TUInt((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)) := TUInt64((Pointer(TUInt(WP) + (-SizeOf(TUInt64)))^)); 
                                                            Dec(WP, SizeOf(TUInt64) - SizeOf(TUInt)); end;
    
   
    
     procedure TForthMachine.single_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Double)); end;
    
   
    
     procedure TForthMachine.double_convert_to_single (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Single)); end;
    
   
    
     procedure TForthMachine.single_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                            Dec(WP, SizeOf(Single) - SizeOf(Extended)); end;
    
   
    
     procedure TForthMachine.double_convert_to_extended (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                            Dec(WP, SizeOf(Double) - SizeOf(Extended)); end;
    
   
    
     procedure TForthMachine.extended_convert_to_double (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Double)); end;
    
   
    
     procedure TForthMachine.extended_convert_to_single (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                            Dec(WP, SizeOf(Extended) - SizeOf(Single)); end;
    
   
    
     procedure TForthMachine.single_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then single_compile_push(Machine, Command) else single_interpret_push(Machine, Command) end;
     procedure TForthMachine.single_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin Single(WP^) := (StrToFloat(NextName)); Inc(WP, SizeOf(Single)); end;
     procedure TForthMachine.single_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@single-push'); EW_single(StrToFloat(NextName)); end;
     procedure TForthMachine.single_run_push  (Machine: TForthMachine; Command: PForthCommand); begin Single(WP^) := ER_single; Inc(WP, SizeOf(Single)); end;
     procedure TForthMachine.single_slash (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) / Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)); 
                                                   Dec(WP, SizeOf(Single)); end;
     procedure TForthMachine.single_cos (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Cos(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); end;
     procedure TForthMachine.single_sin (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Sin(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); end;
     procedure TForthMachine.single_tan (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := Tan(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); end;
     procedure TForthMachine.single_atan (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^)) := ArcTan(Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); end;
     procedure TForthMachine.single_atan2 (Machine: TForthMachine; Command: PForthCommand); begin Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)) := ArcTan2(Single((Pointer(TUInt(WP) + (-2*SizeOf(Single)))^)), Single((Pointer(TUInt(WP) + (-SizeOf(Single)))^))); Dec(WP, SizeOf(Single)) end;
    
   
    
     procedure TForthMachine.double_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then double_compile_push(Machine, Command) else double_interpret_push(Machine, Command) end;
     procedure TForthMachine.double_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin Double(WP^) := (StrToFloat(NextName)); Inc(WP, SizeOf(Double)); end;
     procedure TForthMachine.double_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@double-push'); EW_double(StrToFloat(NextName)); end;
     procedure TForthMachine.double_run_push  (Machine: TForthMachine; Command: PForthCommand); begin Double(WP^) := ER_double; Inc(WP, SizeOf(Double)); end;
     procedure TForthMachine.double_slash (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) / Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)); 
                                                   Dec(WP, SizeOf(Double)); end;
     procedure TForthMachine.double_cos (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Cos(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); end;
     procedure TForthMachine.double_sin (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Sin(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); end;
     procedure TForthMachine.double_tan (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := Tan(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); end;
     procedure TForthMachine.double_atan (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^)) := ArcTan(Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); end;
     procedure TForthMachine.double_atan2 (Machine: TForthMachine; Command: PForthCommand); begin Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)) := ArcTan2(Double((Pointer(TUInt(WP) + (-2*SizeOf(Double)))^)), Double((Pointer(TUInt(WP) + (-SizeOf(Double)))^))); Dec(WP, SizeOf(Double)) end;
    
   
    
     procedure TForthMachine.extended_push  (Machine: TForthMachine; Command: PForthCommand); begin if FState = FS_COMPILE then extended_compile_push(Machine, Command) else extended_interpret_push(Machine, Command) end;
     procedure TForthMachine.extended_interpret_push  (Machine: TForthMachine; Command: PForthCommand); begin Extended(WP^) := (StrToFloat(NextName)); Inc(WP, SizeOf(Extended)); end;
     procedure TForthMachine.extended_compile_push  (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@extended-push'); EW_extended(StrToFloat(NextName)); end;
     procedure TForthMachine.extended_run_push  (Machine: TForthMachine; Command: PForthCommand); begin Extended(WP^) := ER_extended; Inc(WP, SizeOf(Extended)); end;
     procedure TForthMachine.extended_slash (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) / Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)); 
                                                   Dec(WP, SizeOf(Extended)); end;
     procedure TForthMachine.extended_cos (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := Cos(Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); end;
     procedure TForthMachine.extended_sin (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := Sin(Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); end;
     procedure TForthMachine.extended_tan (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := Tan(Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); end;
     procedure TForthMachine.extended_atan (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^)) := ArcTan(Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); end;
     procedure TForthMachine.extended_atan2 (Machine: TForthMachine; Command: PForthCommand); begin Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)) := ArcTan2(Extended((Pointer(TUInt(WP) + (-2*SizeOf(Extended)))^)), Extended((Pointer(TUInt(WP) + (-SizeOf(Extended)))^))); Dec(WP, SizeOf(Extended)) end;
    
   
    
     procedure TForthMachine.EW_; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_int; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_int; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_int8; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_int8; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_int16; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_int16; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_int32; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_int32; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_int64; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_int64; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_uint; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_uint; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_uint8; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_uint8; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_uint16; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_uint16; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_uint32; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_uint32; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_uint64; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_uint64; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_single; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_single; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_double; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_double; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
     procedure TForthMachine.EW_extended; begin EWV(@V, SizeOf(V)) end;
     function TForthMachine.ER_extended; begin ERV(@Result, SizeOf(Result)) end;
    
   
    
      procedure TForthMachine._wp (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := WP; Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._rp (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := RP; Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._lp (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := LP; Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._lb (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := LB; Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._r_dog (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := Pointer(Pointer(Cardinal(RP) - SizeOf(Pointer))^); Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._r_gt (Machine: TForthMachine; Command: PForthCommand); begin Dec(RP, SizeOf(Pointer)); Pointer(WP^) := Pointer(RP^); Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._lt_r (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, SizeOf(Pointer)); Pointer(RP^) := Pointer(WP^); Inc(RP, SizeOf(Pointer)); end;
      procedure TForthMachine._l_dog (Machine: TForthMachine; Command: PForthCommand); begin Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := Pointer((Pointer(TUInt(LB) + (Integer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))))^)); end;
      procedure TForthMachine._l_exclamation (Machine: TForthMachine; Command: PForthCommand); begin Pointer((Pointer(TUInt(LB) + (Integer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^))))^)) := Pointer((Pointer(TUInt(WP) + (-2*SizeOf(Pointer)))^)); Dec(WP, 2*SizeOf(Pointer)); end;
      procedure TForthMachine._l_plus (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, SizeOf(TInt)); Inc(LP, TInt(WP^)) end;
      procedure TForthMachine.version (Machine: TForthMachine; Command: PForthCommand); begin TInt(WP^) := DFORTHMACHINE_VERSION; Inc(WP, SizeOf(TInt)); end;
      procedure TForthMachine._state (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := @FState; Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._time (Machine: TForthMachine; Command: PForthCommand); begin Integer(WP^) := GetTimer; Inc(WP, SizeOf(TInt)); end;
      procedure TForthMachine._local (Machine: TForthMachine; Command: PForthCommand); begin RunCommand(PForthCommand((@E[Integer(Command^.Data)])^)); end;
      procedure TForthMachine.source_next_char (Machine: TForthMachine; Command: PForthCommand); begin WUU8(Byte(NextChar)) end;
      procedure TForthMachine.source_next_name (Machine: TForthMachine; Command: PForthCommand); begin FStringCommands.str_push(Machine, Command, NextName) end;
      procedure TForthMachine.source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin // if FState <> FS_INTERPRET then compile_source_next_name_passive(Machine, Command) else 
                                                                                                   interpret_source_next_name_passive(Machine, Command) end;
      procedure TForthMachine.interpret_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin FStringCommands.str_push(Machine, Command, NextNamePassive) end;
      procedure TForthMachine.compile_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin EWO('(str)"'); EWStr(NextNamePassive); end;
      procedure TForthMachine.run_source_next_name_passive (Machine: TForthMachine; Command: PForthCommand); begin FStringCommands.str_push(Machine, Command, @E[EC]); end;
      procedure TForthMachine.source_read_to_char (Machine: TForthMachine; Command: PForthCommand); var I: Integer; begin I := SC; Dec(WP, 1); while (S[I] <> TChar(0))and(S[I] <> TChar(WP^)) do Inc(I); FStringCommands.str_push(Machine, Command, TString(Copy(S, SC + 1, I - SC))); SC := I; end;
      procedure TForthMachine.ptr_nil (Machine: TForthMachine; Command: PForthCommand); begin WUP(nil); end;
      procedure TForthMachine.compile_start (Machine: TForthMachine; Command: PForthCommand); begin FState := FS_COMPILE end;
      procedure TForthMachine.interpret_start (Machine: TForthMachine; Command: PForthCommand); begin FState := FS_INTERPRET end;
      procedure TForthMachine.run_start (Machine: TForthMachine; Command: PForthCommand); begin FState := FS_INTERPRET end;
      //procedure TForthMachine.allot (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, SizeOf(TInt)); DA(TInt(WP)^); end;
      procedure TForthMachine.opcode_to_command (Machine: TForthMachine; Command: PForthCommand); begin Pointer((Pointer(TUInt(WP) + (-SizeOf(Integer)))^)) := GetCommandByOpcode(Integer((Pointer(TUInt(WP) + (-SizeOf(Integer)))^))) end;
      procedure TForthMachine.literal (Machine: TForthMachine; Command: PForthCommand); begin EWO('(literal)'); EWI(WOI); end;
      procedure TForthMachine.sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin {if FState <> FS_INTERPRET then compile_sq_ap_sq(Machine, Command) else interpret_sq_ap_sq(Machine, Command)}
                WUI(GetOpcodeByName(NextName)); Literal(Machine, Command);
                EWO('opcode->command'); end;
      procedure TForthMachine.interpret_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin WUP(FindCommand(NextName)) end;
      procedure TForthMachine.compile_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin EWO('run@['']'); EWO(NextName); end;
      procedure TForthMachine.run_sq_ap_sq (Machine: TForthMachine; Command: PForthCommand); begin WUP(C[ERO]); end;
      procedure TForthMachine._tick (Machine: TForthMachine; Command: PForthCommand); begin Pointer(WP^) := FindCommand(NextName); Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine.execute (Machine: TForthMachine; Command: PForthCommand); var P: PForthCommand; begin 
                                             P := WOP; P.Code(Machine, P) end;
      procedure TForthMachine._does_gt (Machine: TForthMachine; Command: PForthCommand); begin EWO('(does>)'); EWO('exit'); end;
      procedure TForthMachine._sq_does_gt_sq (Machine: TForthMachine; Command: PForthCommand); begin Integer(C[FLastMnemonic].Param) := Integer(C[FLastMnemonic].Data); Integer(C[FLastMnemonic].Data) := EC + 4; C[FLastMnemonic].Code := CallDoesGt; end;
      procedure TForthMachine.CallDoesGt (Machine: TForthMachine; Command: PForthCommand); begin FControlCommands.Call(Machine, Command); Pointer(WP^) := Pointer(Command.Param); Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine.Cells (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^))*SizeOf(Integer); end;
      procedure TForthMachine.Cell_plus (Machine: TForthMachine; Command: PForthCommand); begin TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) := TInt((Pointer(TUInt(WP) + (-SizeOf(TInt)))^)) + SizeOf(TInt); end;
      procedure TForthMachine._malloc (Machine: TForthMachine; Command: PForthCommand); var P: Pointer; begin P := Pointer((Pointer(TUInt(WP) + (-SizeOf(Integer)))^)); GetMem(P, Integer((Pointer(TUInt(WP) + (-SizeOf(Integer)))^))); Pointer((Pointer(TUInt(WP) + (-SizeOf(Integer)))^)) := P; end;
      procedure TForthMachine._free (Machine: TForthMachine; Command: PForthCommand); var P: Pointer; begin Dec(WP, SizeOf(Pointer)); P := Pointer(WP^); FreeMem(P); end;
      procedure TForthMachine._last (Machine: TForthMachine; Command: PForthCommand); var P: Pointer; begin Pointer(WP^) := C[High(C)]; {Writeln(Integer(WP^));} Inc(WP, SizeOf(Pointer)); end;
      procedure TForthMachine._xt_dot_n (Machine: TForthMachine; Command: PForthCommand); begin Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := @(PForthCommand((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)).Name[0]); end;
      procedure TForthMachine._xt_dot_d (Machine: TForthMachine; Command: PForthCommand); begin Pointer((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)) := PForthCommand((Pointer(TUInt(WP) + (-SizeOf(Pointer)))^)).Data end;
      procedure TForthMachine._move (Machine: TForthMachine; Command: PForthCommand); begin Dec(WP, SizeOf(Pointer)*3); Move(Pointer((Pointer(TUInt(WP) + (0))^))^, Pointer((Pointer(TUInt(WP) + (SizeOf(Pointer)))^))^, TUint((Pointer(TUInt(WP) + (2*SizeOf(Pointer)))^))); {Writeln(TUInt((Pointer(TUInt(WP) + (0))^)), TUInt((Pointer(TUInt(WP) + (SizeOf(Pointer)))^)), TUint((Pointer(TUInt(WP) + (2*SizeOf(Pointer)))^)));} end;
    
   
    
     procedure TForthMachine._sys_exceptions_execute (Machine: TForthMachine; Command: PForthCommand);
     var
       Res: Integer;
     begin 
       Integer(ExceptionsP^) := 0;
       Inc(ExceptionsP, SizeOf(Integer));
       Integer(ExceptionsP^) := EC;
       Inc(ExceptionsP, SizeOf(Integer));
       Pointer(ExceptionsP^) := WP;
       Inc(ExceptionsP, SizeOf(Pointer));
       Pointer(ExceptionsP^) := RP;
       Inc(ExceptionsP, SizeOf(Pointer));
       execute(Machine, Command);
     end;
     procedure TForthMachine._sys_exceptions_pop (Machine: TForthMachine; Command: PForthCommand);
     begin
       Dec(ExceptionsP, 2*SizeOf(Integer) + 2*SizeOf(Pointer));
       WUI(Integer(ExceptionsP^));
     end;
     procedure TForthMachine._throw (Machine: TForthMachine; Command: PForthCommand); 
     begin 
       Integer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)-2*SizeOf(Integer)])^) := WOI;
       EC := Integer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)-SizeOf(Integer)])^);
       RP := Pointer((@PArrayOfByte(ExceptionsP)^[-1*SizeOf(Pointer)])^);
       WP := Pointer((@PArrayOfByte(ExceptionsP)^[-2*SizeOf(Pointer)])^);
     end;
    
   
    
      type
        PdfFile = ^TdfFile;
        TdfFile = record
          Data: TData;
          Name: String;
          Mode: TInt;
        end;
      procedure TForthMachine.file_open (Machine: TForthMachine; Command: PForthCommand); 
      var 
        F: PdfFile;
        S: TStr;
      begin 
         New(F);
         F^.Mode := WOI; 
         S := FStringCommands.str_pop(Machine, Command); 
         F^.Name := PChar(@(PStrRec(S)^.Sym[0]));
         if F^.Mode = DF_FILE_R then
           F^.Data := TData.Create(F^.Name)
         else
           F^.Data := TData.Create;
         WUP(F); 
         FStringCommands.DelRef(S);
      end;
      procedure TForthMachine.file_close (Machine: TForthMachine; Command: PForthCommand); 
      var
        F: PdfFile;
      begin 
        F := WOP;
        if F^.Mode = DF_FILE_W then
          F^.Data.WriteToFile(F^.Name);
        F^.Data.Free;
        Dispose(F); 
      end;
      procedure TForthMachine.file_w (Machine: TForthMachine; Command: PForthCommand); begin WUI(DF_FILE_W) end;
      procedure TForthMachine.file_r (Machine: TForthMachine; Command: PForthCommand); begin WUI(DF_FILE_R) end;
      procedure TForthMachine.file_write (Machine: TForthMachine; Command: PForthCommand); 
      var
        Src: Pointer;
        S: TInt;
        F: PdfFile;
      begin 
        S := WOI; 
        Src := WOP; 
        //F := WOP; 
        PdfFile((Pointer(TUInt(WP) + (-SizeOf(PdfFile)))^))^.Data.WriteVar(Src, S);
      end;
      procedure TForthMachine.file_read (Machine: TForthMachine; Command: PForthCommand);
      var
        Src: Pointer;
        S: TInt;
        F: PdfFile;
      begin 
        S := WOI; 
        Src := WOP; 
        //F := WOP; 
        //F^.Data.ReadVar(Src, S);
        PdfFile((Pointer(TUInt(WP) + (-SizeOf(PdfFile)))^))^.Data.ReadVar(Src, S);
      end;
      procedure TForthMachine.file_write_from_w (Machine: TForthMachine; Command: PForthCommand);
      begin
      end;
      procedure TForthMachine.file_read_to_w (Machine: TForthMachine; Command: PForthCommand);
      begin
      end;
      procedure TForthMachine.file_size (Machine: TForthMachine; Command: PForthCommand); begin WUI(PdfFile(WOP)^.Data.Size); end;
    
  

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


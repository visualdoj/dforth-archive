unit DExecutable;

interface

uses
  {$I units.inc};

const
{$IFNDEF FLAG_FPC}{$REGION 'coff constants'}{$ENDIF}
       COFF_FLAG_NORELOCS = $0001;
       COFF_FLAG_EXE      = $0002;
       COFF_FLAG_NOLINES  = $0004;
       COFF_FLAG_NOLSYMS  = $0008;
       COFF_FLAG_AR16WR   = $0080; { 16bit little endian }
       COFF_FLAG_AR32WR   = $0100; { 32bit little endian }
       COFF_FLAG_AR32W    = $0200; { 32bit big endian }
       COFF_FLAG_DLL      = $2000;

       COFF_SYM_GLOBAL   = 2;
       COFF_SYM_LOCAL    = 3;
       COFF_SYM_LABEL    = 6;
       COFF_SYM_FUNCTION = 101;
       COFF_SYM_FILE     = 103;
       COFF_SYM_SECTION  = 104;

       COFF_STYP_REG    = $0000; { "regular": allocated, relocated, loaded }
       COFF_STYP_DSECT  = $0001; { "dummy":  relocated only }
       COFF_STYP_NOLOAD = $0002; { "noload": allocated, relocated, not loaded }
       COFF_STYP_GROUP  = $0004; { "grouped": formed of input sections }
       COFF_STYP_PAD    = $0008;
       COFF_STYP_COPY   = $0010;
       COFF_STYP_TEXT   = $0020;
       COFF_STYP_DATA   = $0040;
       COFF_STYP_BSS    = $0080;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'pe constant'}{$ENDIF}
       PE_SUBSYSTEM_WINDOWS_GUI    = 2;
       PE_SUBSYSTEM_WINDOWS_CUI    = 3;
       PE_SUBSYSTEM_WINDOWS_CE_GUI = 9;

       PE_FILE_RELOCS_STRIPPED         = $0001;
       PE_FILE_EXECUTABLE_IMAGE        = $0002;
       PE_FILE_LINE_NUMS_STRIPPED      = $0004;
       PE_FILE_LOCAL_SYMS_STRIPPED     = $0008;
       PE_FILE_AGGRESSIVE_WS_TRIM      = $0010;
       PE_FILE_LARGE_ADDRESS_AWARE     = $0020;
       PE_FILE_16BIT_MACHINE           = $0040;
       PE_FILE_BYTES_REVERSED_LO       = $0080;
       PE_FILE_32BIT_MACHINE           = $0100;
       PE_FILE_DEBUG_STRIPPED          = $0200;
       PE_FILE_REMOVABLE_RUN_FROM_SWAP = $0400;
       PE_FILE_NET_RUN_FROM_SWAP       = $0800;
       PE_FILE_SYSTEM                  = $1000;
       PE_FILE_DLL                     = $2000;
       PE_FILE_UP_SYSTEM_ONLY          = $4000;
       PE_FILE_BYTES_REVERSED_HI       = $8000;

       PE_SCN_CNT_CODE               = $00000020; { Section contains code. }
       PE_SCN_CNT_INITIALIZED_DATA   = $00000040; { Section contains initialized data. }
       PE_SCN_CNT_UNINITIALIZED_DATA = $00000080; { Section contains uninitialized data. }
       PE_SCN_LNK_OTHER              = $00000100; { Reserved. }
       PE_SCN_LNK_INFO               = $00000200; { Section contains comments or some other type of information. }
       PE_SCN_LNK_REMOVE             = $00000800; { Section contents will not become part of image. }
       PE_SCN_LNK_COMDAT             = $00001000; { Section contents comdat. }
       PE_SCN_MEM_FARDATA            = $00008000;
       PE_SCN_MEM_PURGEABLE          = $00020000;
       PE_SCN_MEM_16BIT              = $00020000;
       PE_SCN_MEM_LOCKED             = $00040000;
       PE_SCN_MEM_PRELOAD            = $00080000;
       PE_SCN_ALIGN_MASK             = $00f00000;
       PE_SCN_ALIGN_1BYTES           = $00100000;
       PE_SCN_ALIGN_2BYTES           = $00200000;
       PE_SCN_ALIGN_4BYTES           = $00300000;
       PE_SCN_ALIGN_8BYTES           = $00400000;
       PE_SCN_ALIGN_16BYTES          = $00500000; { Default alignment if no others are specified. }
       PE_SCN_ALIGN_32BYTES          = $00600000;
       PE_SCN_ALIGN_64BYTES          = $00700000;
       PE_SCN_LNK_NRELOC_OVFL        = $01000000; { Section contains extended relocations. }
       PE_SCN_MEM_NOT_CACHED         = $04000000; { Section is not cachable.               }
       PE_SCN_MEM_NOT_PAGED          = $08000000; { Section is not pageable.               }
       PE_SCN_MEM_SHARED             = $10000000; { Section is shareable.                  }
       PE_SCN_MEM_DISCARDABLE        = $02000000;
       PE_SCN_MEM_EXECUTE            = $20000000;
       PE_SCN_MEM_READ               = $40000000;
       PE_SCN_MEM_WRITE              = $80000000;

       PE_DATADIR_EDATA = 0;
       PE_DATADIR_IDATA = 1;
       PE_DATADIR_RSRC = 2;
       PE_DATADIR_PDATA = 3;
       PE_DATADIR_SECURITY = 4;
       PE_DATADIR_RELOC = 5;
       PE_DATADIR_DEBUG = 6;
       PE_DATADIR_DESCRIPTION = 7;
       PE_DATADIR_SPECIAL = 8;
       PE_DATADIR_TLS = 9;
       PE_DATADIR_LOADCFG = 10;
       PE_DATADIR_BOUNDIMPORT = 11;
       PE_DATADIR_IMPORTADDRESSTABLE = 12;
       PE_DATADIR_DELAYIMPORT = 13;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'garabage'}{$ENDIF}
{$ifdef x86_64}
       IMAGE_REL_AMD64_ABSOLUTE    = $0000;  { Reference is absolute, no relocation is necessary }
       IMAGE_REL_AMD64_ADDR64      = $0001;  { 64-bit address (VA). }
       IMAGE_REL_AMD64_ADDR32      = $0002;  { 32-bit address (VA). }
       IMAGE_REL_AMD64_ADDR32NB    = $0003;  { 32-bit address w/o image base (RVA). }
       IMAGE_REL_AMD64_REL32       = $0004;  { 32-bit relative address from byte following reloc }
       IMAGE_REL_AMD64_REL32_1     = $0005;  { 32-bit relative address from byte distance 1 from reloc }
       IMAGE_REL_AMD64_REL32_2     = $0006;  { 32-bit relative address from byte distance 2 from reloc }
       IMAGE_REL_AMD64_REL32_3     = $0007;  { 32-bit relative address from byte distance 3 from reloc }
       IMAGE_REL_AMD64_REL32_4     = $0008;  { 32-bit relative address from byte distance 4 from reloc }
       IMAGE_REL_AMD64_REL32_5     = $0009;  { 32-bit relative address from byte distance 5 from reloc }
       IMAGE_REL_AMD64_SECTION     = $000A;  { Section index }
       IMAGE_REL_AMD64_SECREL      = $000B;  { 32 bit offset from base of section containing target }
       IMAGE_REL_AMD64_SECREL7     = $000C;  { 7 bit unsigned offset from base of section containing target }
       IMAGE_REL_AMD64_TOKEN       = $000D;  { 32 bit metadata token }
       IMAGE_REL_AMD64_SREL32      = $000E;  { 32 bit signed span-dependent value emitted into object }
       IMAGE_REL_AMD64_PAIR        = $000F;
       IMAGE_REL_AMD64_SSPAN32     = $0010;  { 32 bit signed span-dependent value applied at link time }
{$endif x86_64}

{$ifdef arm}
       IMAGE_REL_ARM_ABSOLUTE      = $0000;     { No relocation required }
       IMAGE_REL_ARM_ADDR32        = $0001;     { 32 bit address }
       IMAGE_REL_ARM_ADDR32NB      = $0002;     { 32 bit address w/o image base }
       IMAGE_REL_ARM_BRANCH24      = $0003;     { 24 bit offset << 2 & sign ext. }
       IMAGE_REL_ARM_BRANCH11      = $0004;     { Thumb: 2 11 bit offsets }
       IMAGE_REL_ARM_TOKEN         = $0005;     { clr token }
       IMAGE_REL_ARM_GPREL12       = $0006;     { GP-relative addressing (ARM) }
       IMAGE_REL_ARM_GPREL7        = $0007;     { GP-relative addressing (Thumb) }
       IMAGE_REL_ARM_BLX24         = $0008;
       IMAGE_REL_ARM_BLX11         = $0009;
       IMAGE_REL_ARM_SECTION       = $000E;     { Section table index }
       IMAGE_REL_ARM_SECREL        = $000F;     { Offset within section }
{$endif arm}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$ifdef i386}
       IMAGE_REL_I386_DIR32 = 6;
       IMAGE_REL_I386_IMAGEBASE = 7;
       IMAGE_REL_I386_SECREL32 = 11;
       IMAGE_REL_I386_PCRLONG = 20;
{$endif i386}
{$IFNDEF FLAG_FPC}{$REGION 'other'}{$ENDIF}
       { .reloc section fixup types }
       IMAGE_REL_BASED_HIGHLOW     = 3;  { Applies the delta to the 32-bit field at Offset. }
       IMAGE_REL_BASED_DIR64       = 10; { Applies the delta to the 64-bit field at Offset. }  

       COFF_MAGIC       = $14c;
       COFF_OPT_MAGIC   = $10b;       
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 1 dos code'}{$ENDIF}
const win32stub : array[0..127] of byte=(
  $4D,$5A,$90,$00,$03,$00,$00,$00,$04,$00,$00,$00,$FF,$FF,$00,$00,
  $B8,$00,$00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,
  $0E,$1F,$BA,$0E,$00,$B4,$09,$CD,$21,$B8,$01,$4C,$CD,$21,$54,$68,
  $69,$73,$20,$70,$72,$6F,$67,$72,$61,$6D,$20,$63,$61,$6E,$6E,$6F,
  $74,$20,$62,$65,$20,$72,$75,$6E,$20,$69,$6E,$20,$44,$4F,$53,$20,
  $6D,$6F,$64,$65,$2E,$0D,$0D,$0A,$24,$00,$00,$00,$00,$00,$00,$00);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 2 pe magic'}{$ENDIF}
const pemagic : array[0..3] of byte = (
  $50,$45,$00,$00);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 3 coff header'}{$ENDIF}
type
TCoffHeader = packed record
  Mach:   Word;
  NSects: Word;
  Time:   LongWord;
  Sympos: LongWord;
  Syms:   LongWord;
  Opthdr: Word;
  Flag:   Word;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 4 pe optional header'}{$ENDIF}
const
   PE_DATADIR_ENTRIES = 16;
type
aword = DWORD;
tcoffpedatadir = packed record
  vaddr : longword;
  size  : longword;
end;
tcoffpeoptheader = packed record
   Magic : word;
   MajorLinkerVersion : byte; // The major version number of the linker.
   MinorLinkerVersion : byte; // The minor version number of the linker.
   tsize : longword; // The size of the code section, in bytes, or the sum of 
                     // all such sections if there are multiple code sections.
   dsize : longword; // The size of the initialized data section, in bytes, or 
                     // the sum of all such sections if there are multiple 
                     // initialized data sections.
   bsize : longword; // The size of the uninitialized data section, in bytes, or 
                     // the sum of all such sections if there are multiple 
                     // uninitialized data sections.
   entry : longword; // A pointer to the entry point function, relative to the 
                     // image base address. For executable files, this is the 
                     // starting address. For device drivers, this is the 
                     // address of the initialization function. The entry point 
                     // function is optional for DLLs. When no entry point is 
                     // present, this member is zero.
   text_start : longword; // A pointer to the beginning of the code section, 
                          // relative to the image base.
{$ifndef cpu64bitaddr}
   data_start : longword; // A pointer to the beginning of the data section, 
                          // relative to the image base.
{$endif cpu64bitaddr}
   ImageBase : aword; // The preferred address of the first byte of the image 
                      // when it is loaded in memory. This value is a multiple 
                      // of 64K bytes. The default value for DLLs is 0x10000000. 
                      // The default value for applications is 0x00400000, 
                      // except on Windows CE where it is 0x00010000.
   SectionAlignment : longword; // The alignment of sections loaded in memory, 
                                // in bytes. This value must be greater than or 
                                // equal to the FileAlignment member. The 
                                // default value is the page size for the system.
   FileAlignment : longword; // The alignment of the raw data of sections in the 
                             // image file, in bytes. The value should be a power 
                             // of 2 between 512 and 64K (inclusive). The default 
                             // is 512. If the SectionAlignment member is less 
                             // than the system page size, this member must be 
                             // the same as SectionAlignment.
   MajorOperatingSystemVersion : word; // The major version number of the 
                                       // required operating system.
   MinorOperatingSystemVersion : word; // The minor version number of the 
                                       // required operating system.
   MajorImageVersion : word; // The major version number of the image.
   MinorImageVersion : word; // The minor version number of the image.
   MajorSubsystemVersion : word; // The major version number of the subsystem.
   MinorSubsystemVersion : word; // The minor version number of the subsystem.
   Win32Version : longword; // This member is reserved and must be 0.
   SizeOfImage : longword; // The size of the image, in bytes, including all 
                           // headers. Must be a multiple of SectionAlignment.
   SizeOfHeaders : longword; // The combined size of the MS-DOS stub, the PE 
                             // header, and the section headers, rounded to a 
                             // multiple of the value specified in the 
                             // FileAlignment member.
   CheckSum : longword; // The image file checksum. The following files are 
                        // validated at load time: all drivers, any DLL loaded 
                        // at boot time, and any DLL loaded into a critical 
                        // system process.
   Subsystem : word; // The subsystem required to run this image. The following 
                     // values are defined. 
   DllCharacteristics : word; // The DLL characteristics of the image. 
                              // The following values are defined. ...
   SizeOfStackReserve : aword; // The number of bytes to reserve for the stack. 
                               // Only the memory specified by the 
                               // SizeOfStackCommit member is committed at load 
                               // time; the rest is made available one page 
                               // at a time until this reserve size is reached.
   SizeOfStackCommit : aword; // The number of bytes to commit for the stack.
   SizeOfHeapReserve : aword; // The number of bytes to reserve for the local 
                              // heap. Only the memory specified by the 
                              // SizeOfHeapCommit member is committed at load 
                              // time; the rest is made available one page at 
                              // a time until this reserve size is reached.
   SizeOfHeapCommit : aword; // The number of bytes to commit for the local heap.
   LoaderFlags : longword; // This member is obsolete.
   NumberOfRvaAndSizes : longword; // The number of directory entries in the 
                                   // remainder of the optional header. Each
                                   // entry describes a location and size.
   DataDirectory : array[0..PE_DATADIR_ENTRIES-1] of tcoffpedatadir; 
                               // A pointer to the first IMAGE_DATA_DIRECTORY 
                               // structure in the data directory.
 end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 5 secs offset'}{$ENDIF}
       TSecsOffset = LongWord;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION ' 6 section header'}{$ENDIF}
       tcoffsechdr = packed record
         name     : array[0..7] of char; // An 8-byte, null-padded UTF-8 string. 
                                         // There is no terminating null 
                                         // character if the string is exactly 
                                         // eight characters long. For longer 
                                         // names, this member contains 
                                         // a forward slash (/) followed by 
                                         // an ASCII representation of a decimal 
                                         // number that is an offset into the 
                                         // string table. Executable images 
                                         // do not use a string table and 
                                         // do not support section names 
                                         // longer than eight characters
         vsize    : longword; // The total size of the section when loaded into 
                              // memory, in bytes. If this value is greater than 
                              // the SizeOfRawData member, the section is filled 
                              // with zeroes. This field is valid only 
                              // for executable images and should be set to 0 
                              // for object files.
         rvaofs   : longword; // The address of the first byte of the section 
                              // when loaded into memory, relative to the image 
                              // base. For object files, this is the address of 
                              // the first byte before relocation is applied.
         datasize : longword; // The size of the initialized data on disk, 
                              // in bytes. This value must be a multiple of 
                              // the FileAlignment member of the 
                              // IMAGE_OPTIONAL_HEADER structure. If this value 
                              // is less than the VirtualSize member, the 
                              // remainder of the section is filled with zeroes. 
                              // If the section contains only uninitialized 
                              // data, the member is zero.
         datapos  : longword; // A file pointer to the first page within 
                              // the COFF file. This value must be a multiple 
                              // of the FileAlignment member of the 
                              // IMAGE_OPTIONAL_HEADER structure. 
                              // If a section contains only uninitialized data, 
                              // set this member is zero.
         relocpos : longword; // A file pointer to the beginning of the 
                              // relocation entries for the section. 
                              // If there are no relocations, this value is zero.
         lineno1  : longword; // A file pointer to the beginning of the 
                              // line-number entries for the section. 
                              // If there are no COFF line numbers, 
                              // this value is zero.
         nrelocs  : word;     // The number of relocation entries for the 
                              // section. This value is zero for executable images.
         lineno2  : word;     // The number of line-number entries for the section.
         flags    : longword; // The characteristics of the image. 
                              // The following values are defined <....> 
       end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
       coffsymbol=packed record
         name    : array[0..3] of char; { real is [0..7], which overlaps the strpos ! }
         strpos  : longword;
         value   : longword;
         section : smallint;
         empty   : word;
         typ     : byte;
         aux     : byte;
       end;       

type
  TAppType = (AT_CONSOLE, AT_GUI);

TExeBuilder = class
 private
  FData: TData;
  FAppType: TAppType;
  FFufel: array of Byte;
{$IFNDEF FLAG_FPC}{$REGION 'FileStructure'}{$ENDIF}
  FCoffHeader: TCoffHeader;
  FPeoptHeader: tcoffPeoptHeader;
  //F_TextHeader: TCoffSecHdr;
  //F_DataHeader: TCoffSecHdr;
  //F_BssHeader: TCoffSecHdr;
  //F_IDataHeader: TCoffSecHdr;
  FSections: array of record
                        Name: String;
                        Header: TCoffSecHdr;
                        IsData: Boolean;
                        // дл€ секций, хран€щих данные
                        Datas: array of record
                                         Data: Pointer;
                                         Size: Integer;
                                         DataAlignBytes: Integer;
                                       end;
                      end;
  function GetHeaderSize: Integer;
  function GetSecSize(Index: Integer): Integer;
  function GetSecPos(Index: Integer): Integer;
  procedure AddSectionData(Index: Integer; P: Pointer; Size: Integer);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
  function Align(Pos, Bytes: Integer): Integer;
  function AlFi(Pos: Integer): Integer;
  function AlSe(Pos: Integer): Integer;
  procedure WriteCoffHeader(Data: TData);
  procedure WritePEOptHeader(Data: TData);
  procedure WriteSectionHeader(
        Index: Integer;
        const Name: String;
        IsData, IsReadOnly: Boolean 
       );
  procedure WriteExecutableHeader(Data: TData);
 public
  constructor Create;
  destructor Destroy; override;
  procedure BuildHeader;
  procedure Save(const FileName: TString);
  property AppType: TAppType read FAppType write FAppType;
end;

implementation

function TExeBuilder.GetHeaderSize: Integer;
begin
  Result := SizeOf(win32stub) +
            SizeOf(pemagic) +
            SizeOf(FCoffHeader) +
            SizeOf(FPeoptHeader) +
            Length(FSections) * SizeOf(FSections[0].Header);
end;

function TExeBuilder.GetSecSize(Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;//GetSecPos(Index);
  with FSections[Index] do begin
    for I := 0 to High(Datas) - 1 do
      Result := AlFi(Result + Datas[I].Size);
    Result := Result + Datas[High(Datas)].Size;
    Writeln('Datas[High(Datas)].Size = ', Datas[High(Datas)].Size);
  end;
  Result := Result;// - GetSecPos(Index);
end;

function TExeBuilder.GetSecPos(Index: Integer): Integer;
var
  I: Integer;
begin
  if Index = 0 then
    Result := AlFi(GetHeaderSize)
  else
    Result := AlFi(GetSecPos(Index - 1) + GetSecSize(Index - 1));
end;

procedure TExeBuilder.AddSectionData;
begin
  with FSections[Index] do begin
    SetLength(Datas, Length(Datas) + 1);
    GetMem(Datas[High(Datas)].Data, Size);
    Move(P^, Datas[High(Datas)].Data^, Size);
    Datas[High(Datas)].Size := Size;
  end;
end;

function TExeBuilder.Align(Pos, Bytes: Integer): Integer;
begin
  if Bytes <= 1 then
    Result := Pos
  else begin
    Result := ((Pos + Bytes - 1) div Bytes) * Bytes;
  end;
end;

function TExeBuilder.AlFi(Pos: Integer): Integer;
begin
  Result := Align(Pos, FPeoptHeader.FileAlignment);
end;

function TExeBuilder.AlSe(Pos: Integer): Integer;
begin
  Result := Align(Pos, FPeoptHeader.SectionAlignment);
end;

procedure TExeBuilder.WriteCoffHeader(Data: TData);
begin
  FillChar(FCoffHeader, SizeOf(FCoffHeader),0);  
  FCoffHeader.Mach := COFF_MAGIC;
  FCoffHeader.NSects := 0; // AFTER
  //if writeDbgStrings then
  //  FCoffHeader.sympos := sympos;
  //if hassymbols then
  //  FCoffHeader.syms:=nsyms;
  FCoffHeader.opthdr := sizeof(tcoffpeoptheader);
  FCoffHeader.flag := PE_FILE_EXECUTABLE_IMAGE or PE_FILE_LINE_NUMS_STRIPPED;
  //if target_info.system in [system_x86_64_win64] then
  //  FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_LARGE_ADDRESS_AWARE
  //else
    FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_32BIT_MACHINE;
  //if IsSharedLibrary then
  //  FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_DLL;
  //if FindExeSection('.reloc') = nil then
    FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_RELOCS_STRIPPED;
  //if (FindExeSection('.stab')=nil) and
  //   (FindExeSection('.debug_info')=nil) and
  //   (FindExeSection('.gnu_debuglink')=nil) then
    FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_DEBUG_STRIPPED;
  //if not hassymbols then
    FCoffHeader.flag:=FCoffHeader.flag or PE_FILE_LOCAL_SYMS_STRIPPED;
  //if SetPEFlagsSetExplicity then
  //  FCoffHeader.flag:=FCoffHeader.flag or peflags;
  //Data.WriteVar(@FCoffHeader, SizeOf(FCoffHeader));
end;

procedure TExeBuilder.WritePEOptHeader(Data: TData);
var
  I: Integer;
begin
  FillChar(FPeoptHeader, SizeOf(FPeoptHeader), 0);
  FPeoptHeader.magic := COFF_OPT_MAGIC;
  //FPeoptHeader.MajorLinkerVersion := ord(version_nr) - ord('0');
  //FPeoptHeader.MinorLinkerVersion := (ord(release_nr)-ord('0'))*10 + 
  //                                  (ord(patch_nr)-ord('0'));
  FPeoptHeader.MajorLinkerVersion := 2;
  FPeoptHeader.MinorLinkerVersion := 40;
  FPeoptHeader.tsize := 0;//TextExeSec.Size; // AFTER
  FPeoptHeader.dsize := 0;//DataExeSec.Size; // AFTER
  //if Assigned(BSSExeSec) then
    FPeoptHeader.bsize := 0;//BSSExeSec.Size; // AFTER
  FPeoptHeader.text_start := 0;//TextExeSec.mempos; // AFTER
{$ifndef cpu64bitaddr}
  FPeoptHeader.data_start := 0;//DataExeSec.mempos; // AFTER
{$endif cpu64bitaddr}
  FPeoptHeader.entry := 0;//EntrySym.Address; // AFTER
  FPeoptHeader.ImageBase := $400000;//ImageBase;
  FPeoptHeader.SectionAlignment := $1000;//SectionMemAlign;
  FPeoptHeader.FileAlignment := $200; // дефолтное значение
  FPeoptHeader.MajorOperatingSystemVersion := 4;
  FPeoptHeader.MinorOperatingSystemVersion := 0;
  FPeoptHeader.MajorImageVersion := 1;
  FPeoptHeader.MinorImageVersion := 0;
  //if target_info.system in system_wince then
  //  FPeoptHeader.MajorSubsystemVersion:=3
  //else
    FPeoptHeader.MajorSubsystemVersion := 4;
  FPeoptHeader.MinorSubsystemVersion := 0;
  FPeoptHeader.Win32Version := 0;
  FPeoptHeader.SizeOfImage := 0;//Align(CurrMemPos, SectionMemAlign); // AFTER
  FPeoptHeader.SizeOfHeaders := 0;//textExeSec.DataPos; // AFTER
  FPeoptHeader.CheckSum := 0;
  //if target_info.system in system_wince then
  //  FPeoptHeader.Subsystem:=PE_SUBSYSTEM_WINDOWS_CE_GUI
  //else
  if FAppType = AT_CONSOLE then
    FPeoptHeader.Subsystem:=PE_SUBSYSTEM_WINDOWS_CUI
  else
    FPeoptHeader.Subsystem := PE_SUBSYSTEM_WINDOWS_GUI;
  FPeoptHeader.DllCharacteristics := 0;
  FPeoptHeader.SizeOfStackReserve := 16 * 1024 * 1024; // размер стека Ч 16mb
  FPeoptHeader.SizeOfStackCommit := $1000;
  //if MinStackSizeSetExplicity then
  //  FPeoptHeader.SizeOfStackCommit:=minstacksize;
  //if MaxStackSizeSetExplicity then
  //  FPeoptHeader.SizeOfStackReserve:=maxstacksize;
  FPeoptHeader.SizeOfHeapReserve := $100000;
  FPeoptHeader.SizeOfHeapCommit := $1000;
  FPeoptHeader.NumberOfRvaAndSizes := PE_DATADIR_ENTRIES;
  for I := 0 to PE_DATADIR_ENTRIES - 1 do begin
    FPeoptHeader.DataDirectory[I].vaddr := 0;
    FPeoptHeader.DataDirectory[I].size := 0;
  end;
  // UpdateDataDir('.idata',PE_DATADIR_IDATA);
  // UpdateDataDir('.edata',PE_DATADIR_EDATA);
  // UpdateDataDir('.rsrc',PE_DATADIR_RSRC);
  // UpdateDataDir('.pdata',PE_DATADIR_PDATA);
  // UpdateDataDir('.reloc',PE_DATADIR_RELOC);
  //Data.WriteVar(@FPeoptHeader, SizeOf(FPeoptHeader));
end;

procedure TExeBuilder.WriteSectionHeader;
var
  S: String;
  StrPos: AWord;
begin
  FSections[Index].Name := Name;
  FSections[Index].IsData := IsData;
  with FSections[Index] do begin
    FillChar(Header, SizeOf(Header), 0);
    S := name;
    //if Length(s) > 8 then begin
    //   strpos := FCoffStrs.size+4;
    //   FCoffStrs.WriteStr(s);
    //   FCoffStrs.WriteStr(#0);
    //   s := '/' + ToStr(strpos);
    // end;
    move(S[1], Header.Name, Length(s));
    Header.rvaofs := 0;//mempos; // AFTER
    //if win32 then
      Header.vsize := 0; // AFTER //Size
    //else
    //  Header.vsize:=mempos;

    { Header.dataSize is size of initilized data. For .bss section it must be zero }
    if (S <> '.bss') then
      Header.dataSize := 0;//SizeOf(FFufel);//Size // AFTER
    if (Header.dataSize > 0) and IsData then
      Header.datapos := 0;//datapos; // AFTER
    Header.nrelocs := 0;
    Header.relocpos := 0;
    //if win32 then
      Header.Flags := 
        ((PE_SCN_CNT_CODE or PE_SCN_MEM_EXECUTE) * Ord(not IsData)) or
        (PE_SCN_CNT_INITIALIZED_DATA * Ord(IsData)) or

        (PE_SCN_MEM_WRITE * Ord(not IsReadOnly)) or PE_SCN_MEM_READ or

        PE_SCN_ALIGN_4BYTES // ставим смещение в 4 байта
        ;
      Header.Flags := $E0000060;
          //peencodeHeaderflags(SecOptions, SecAlign);
    //else
    //  Header.Flags := djencodeHeaderflags(SecOptions);  
    //FData.WriteVar(@Header, SizeOf(Header));
    SetLength(Datas, 0);
  end;
end;

procedure TExeBuilder.WriteExecutableHeader(Data: TData);
begin
  //Data.WriteVar(@win32stub, SizeOf(win32stub));
  //Data.WriteVar(@pemagic, SizeOf(pemagic));
  WriteCoffHeader(Data);
  WritePEOptHeader(Data);
end;

constructor TExeBuilder.Create;
begin
  FAppType := AT_CONSOLE;
  FData := TData.Create;
  SetLength(FFufel, 2);
  FillChar(FFufel[0], Length(FFufel), #0);
  FFufel[0] := Ord('j');
  FFufel[1] := Ord('d');
end;

destructor TExeBuilder.Destroy;
begin
  FData.Free;
end;

procedure TExeBuilder.BuildHeader;
var
  I, J, Z, L: Integer;
begin
// 1 проход Ч заполн€ем структуры
  WriteExecutableHeader(FData);
  SetLength(FSections, 1);
  WriteSectionHeader(0, '.flat', True, True);
  //WriteSectionHeader(1, '.data', True, True);
  //WriteSectionHeader(2, '.bss', True, True);
  //WriteSectionHeader(3, '.idata', True, True);
  AddSectionData(0, @FFufel[0], Length(FFufel));
  //AddSectionData(1, @FFufel[0], Length(FFufel));
  //AddSectionData(2, @FFufel[0], Length(FFufel));
  //AddSectionData(3, @FFufel[0], Length(FFufel));
// 2 проход Ч прописываем смещени€ в заголовках секций
  FCoffHeader.NSects := Length(FSections);
  with FPeoptHeader do begin
    SizeOfHeaders := AlFi(GetHeaderSize);
    SizeOfImage := 2*AlSe(GetSecPos(Length(FSections)));
    tsize := AlFi(GetSecSize(0));
    dsize := AlFi(GetSecSize(0));//GetSecSize(1);
    bsize := 0;//GetSecSize(2);
    text_start := AlSe(GetSecPos(0));
    data_start := AlSe(GetSecPos(0));
    entry := text_start;
  end;
  for I := 0 to High(FSections) do 
    with FSections[I].Header do begin
      rvaofs := AlSe(GetSecPos(I)); //mempos 
      vsize := GetSecSize(I);  //Size
      Writeln('vsize = ', vsize);
      //if Name <> '.bss' then
        dataSize := AlFi(vsize);
      if (dataSize > 0) and FSections[I].IsData then
        datapos := GetSecPos(I);
    end;
// 3 проход Ч записываем всЄ в поток
  FData.WriteVar(@win32stub, SizeOf(win32stub));
  FData.WriteVar(@pemagic, SizeOf(pemagic));
  FData.WriteVar(@FCoffHeader, SizeOf(FCoffHeader));
  FData.WriteVar(@FPeoptHeader, SizeOf(FPeoptHeader));
  // заголовки секций
  for I := 0 to High(FSections) do
    FData.WriteVar(@FSections[I].Header, SizeOf(FSections[I].Header));
  // данные в секци€х
  for I := 0 to High(FSections) do begin
    // «абиваем нул€ми до места начала секции
    Z := AlFi(GetSecPos(I)) - FData.Size;
    for J := 0 to Z - 1 do
      FData.WriteByte(0);
    // «аписываем данные
    for J := 0 to High(FSections[I].Datas) do begin
      Z := GetSecPos(I) - FData.Size;
      for L := 0 to Z - 1 do
        FData.WriteByte(0);
      FData.WriteVar(FSections[I].Datas[J].Data, FSections[I].Datas[J].Size);
    end;
  end;
  // добиваем файл нул€ми
  for I := 0 to FPeoptHeader.SizeOfImage - 1 do
    FData.WriteByte(0);
  // FData.WriteVar(@FFufel, SizeOf(FFufel));
  // FData.WriteVar(@FFufel, SizeOf(FFufel));
  // FData.WriteVar(@FFufel, SizeOf(FFufel));
  // FData.WriteVar(@FFufel, SizeOf(FFufel));
end;

procedure TExeBuilder.Save(const FileName: TString);
begin
  FData.WriteToFile(FileName);
end;

end.

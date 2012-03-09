DECLARE(file-exists, file_exists)
  var
    S: TString;
    B: TStr;
  begin
    B := str_top(Machine);
    S := TString(PChar(@(B^.Sym[0])));
    Machine.WUI(Ord(FileExists(S))*BOOL_TRUE);
  end;
  type
    PdfFile = ^TdfFile;
    TdfFile = record
      Data: TData;
      Name: String;
      Mode: TInt;
    end;

DECLARE(file-open, file_open) 
  var 
    F: PdfFile;
    B: TStr;
  body( 
     New(F);
     F^.Mode := WOI; 
     B := str_pop(Machine); 
     F^.Name := PChar(@(PStrRec(B)^.Sym[0]));
     if F^.Mode = DF_FILE_R then
       F^.Data := TData.Create(F^.Name)
     else
       F^.Data := TData.Create;
     WUP(F); 
     DelRef(B);)

DECLARE(file-close, file_close) 
  var
    F: PdfFile;
  body( 
    F := WOP;
    if F^.Mode = DF_FILE_W then
      F^.Data.WriteToFile(F^.Name);
    F^.Data.Free;
    Dispose(F); )

DECLARE(file-w, file_w)
  body(
    WUI(DF_FILE_W))

DECLARE(file-r, file_r)
  body(
    WUI(DF_FILE_R))

DECLARE(file-write, file_write) 
  var
    Src: Pointer;
    I: TInt;
    F: PdfFile;
  body( 
    F := WOP;
    I := WOI;
    Src := WOP;
    F^.Data.WriteVar(Src, I);)

DECLARE(file-read, file_read)
  var
    Src: Pointer;
    I: TInt;
    F: PdfFile;
  body( 
    F := WOP;
    I := WOI;
    Src := WOP;
    F^.Data.ReadVar(Src, I);)

DECLARE(byte-file-read, file_byte_read)
  var
    F: PdfFile;
    V: TInt8;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUI(V);)

DECLARE(word-file-read, file_word_read)
  var
    F: PdfFile;
    V: TInt16;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUI(V);)

DECLARE(dword-file-read, file_dword_read)
  var
    F: PdfFile;
    V: TInt32;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUI(V);)

DECLARE(qword-file-read, file_qword_read)
  var
    F: PdfFile;
    V: TInt64;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUI(V);)

DECLARE(ubyte-file-read, file_ubyte_read)
  var
    F: PdfFile;
    V: TUInt8;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUU(V);)

DECLARE(uword-file-read, file_uword_read)
  var
    F: PdfFile;
    V: TUInt16;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUU(V);)

DECLARE(udword-file-read, file_udword_read)
  var
    F: PdfFile;
    V: TUInt32;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUU(V);)

DECLARE(uqword-file-read, file_uqword_read)
  var
    F: PdfFile;
    V: TUInt64;
  body( 
    F := WOP;
    F^.Data.ReadVar(@V, SizeOf(V));
    WUU(V);)

DECLARE(byte-file-write, file_byte_write)
  var
    F: PdfFile;
    V: TInt8;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(word-file-write, file_word_write)
  var
    F: PdfFile;
    V: TInt16;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(dword-file-write, file_dword_write)
  var
    F: PdfFile;
    V: TInt32;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(qword-file-write, file_qword_write)
  var
    F: PdfFile;
    V: TInt64;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(ubyte-file-write, file_ubyte_write)
  var
    F: PdfFile;
    V: TUInt8;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(uword-file-write, file_uword_write)
  var
    F: PdfFile;
    V: TUInt16;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(udword-file-write, file_udword_write)
  var
    F: PdfFile;
    V: TUInt32;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(uqword-file-write, file_uqword_write)
  var
    F: PdfFile;
    V: TUInt64;
  body( 
    F := WOP;
    V := WOI;
    F^.Data.WriteVar(@V, SizeOf(V));)

DECLARE(str-file-write, file_str_write)
  var
    B: TStr;
    F: PdfFile;
  body( 
    F := WOP;
    B := str_pop(Machine);
    F^.Data.WriteVar(@B^.Sym[0], B^.Len * B^.Width);)

DECLARE(str-file-read, file_str_read)
  var
    B: TStr;
    F: PdfFile;
    Len: Integer;
    Buffer: array of Byte;
  body( 
    F := WOP;
    SetLength(Buffer, 80);
    Len := 0;
    Buffer[Len] := F^.Data.ReadByte;
    while (Buffer[Len] <> 13) and not F^.Data.IsEmpty do begin
      Inc(Len);
      if Len > High(Buffer) then
        SetLength(Buffer, Length(Buffer)*2);
      Buffer[Len] := F^.Data.ReadByte;
    end;
    B := CreateStr(1, Len);
    Move(Buffer[0], B^.Sym[0], Len);
    B^.Sym[Len] := 0;
    str_push(Machine, B);)

DECLARE(file-size, file_size)
  body(WUI(PdfFile(WOP)^.Data.Size);)

DECLARE(*cr, star_cr)
  body(WUP(@CR_windows[0]))

DECLARE(*cr#, star_cr_hash)
  body(WUI(SizeOf(CR_windows)))

DECLARE(file-cr, file_cr) 
  var 
    F: PdfFile; 
  body(  
    F := WOP;
    F^.Data.WriteVar(@CR_windows[0], SizeOf(CR_windows));)

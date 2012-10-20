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
      Name: String;
      Mode: TInt;
      F: File of Byte;
    end;

define(`FILEOPENR',`
    begin
        Assign(PdfFile($1)^.F, $2);
        {$I-}
        Reset(PdfFile($1)^.F);
        {$I+}
        // if IOResult <> 0 then
        //   Exit;
        Writeln("filesize: ", FileSize(PdfFile($1)^.F));
    end;
  ')
define(`FILEOPENW',`
    begin
        Assign(PdfFile($1)^.F, $2);
        {$I-}
        Rewrite(PdfFile($1)^.F);
        {$I+}
        // if IOResult <> 0 then
        //   Exit;
    end;
  ')
define(`FILECLOSE',`Close(PdfFile($1)^.F)')
define(`FILEREAD',`BlockRead(PdfFile($1)^.F, ($2)^, $3);')
define(`FILEWRITE',`BlockWrite(PdfFile($1)^.F, ($2)^, $3);')
define(`FILEEMPTY',`Eof(PdfFile($1)^.F)')
define(`FILESIZE',`FileSize(PdfFile($1)^.F)')

DECLARE(file-open, file_open) 
  var 
    F: Pointer;
    B: TStr;
  body( 
     Writeln("New file");
     New(PdfFile(F));
     PdfFile(F)^.Mode := WOI; 
     B := str_pop(Machine); 
     PdfFile(F)^.Name := PChar(@(PStrRec(B)^.Sym[0]));
     Writeln("TData.Create ", PdfFile(F)^.Name, PdfFile(F)^.Mode = DF_FILE_R);
     if PdfFile(F)^.Mode = DF_FILE_R then begin
       Writeln("Inside if");
       FILEOPENR(F, PdfFile(F)^.Name);
     end else
       FILEOPENW(F, PdfFile(F)^.Name);
     WUP(F); 
     Writeln("DelRef ");
     DelRef(B);)

DECLARE(file-close, file_close) 
  var
    F: PdfFile;
  body( 
    F := WOP;
    FILECLOSE(F);
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
    FILEWRITE(F, Src, I);)

DECLARE(file-read, file_read)
  var
    Src: Pointer;
    I: TInt;
    F: PdfFile;
  body( 
    F := WOP;
    I := WOI;
    Src := WOP;
    FILEREAD(F, Src, I);)

DECLARE(byte-file-read, file_byte_read)
  var
    F: PdfFile;
    V: TInt8;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUI(V);)

DECLARE(word-file-read, file_word_read)
  var
    F: PdfFile;
    V: TInt16;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUI(V);)

DECLARE(dword-file-read, file_dword_read)
  var
    F: PdfFile;
    V: TInt32;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUI(V);)

DECLARE(qword-file-read, file_qword_read)
  var
    F: PdfFile;
    V: TInt64;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUI(V);)

DECLARE(ubyte-file-read, file_ubyte_read)
  var
    F: PdfFile;
    V: TUInt8;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUU(V);)

DECLARE(uword-file-read, file_uword_read)
  var
    F: PdfFile;
    V: TUInt16;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUU(V);)

DECLARE(udword-file-read, file_udword_read)
  var
    F: PdfFile;
    V: TUInt32;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUU(V);)

DECLARE(uqword-file-read, file_uqword_read)
  var
    F: PdfFile;
    V: TUInt64;
  body( 
    F := WOP;
    FILEREAD(F, @V, SizeOf(V));
    WUU(V);)

DECLARE(byte-file-write, file_byte_write)
  var
    F: PdfFile;
    V: TInt8;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(word-file-write, file_word_write)
  var
    F: PdfFile;
    V: TInt16;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(dword-file-write, file_dword_write)
  var
    F: PdfFile;
    V: TInt32;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(qword-file-write, file_qword_write)
  var
    F: PdfFile;
    V: TInt64;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(ubyte-file-write, file_ubyte_write)
  var
    F: PdfFile;
    V: TUInt8;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(uword-file-write, file_uword_write)
  var
    F: PdfFile;
    V: TUInt16;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(udword-file-write, file_udword_write)
  var
    F: PdfFile;
    V: TUInt32;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(uqword-file-write, file_uqword_write)
  var
    F: PdfFile;
    V: TUInt64;
  body( 
    F := WOP;
    V := WOI;
    FILEWRITE(F, @V, SizeOf(V));)

DECLARE(str-file-write, file_str_write)
  var
    B: TStr;
    F: PdfFile;
  body( 
    F := WOP;
    B := str_pop(Machine);
    FILEWRITE(F, @B^.Sym[0], B^.Len * B^.Width);)

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
    FILEREAD(F, @Buffer[Len], Sizeof(Buffer[Len]));
    while (Buffer[Len] <> 13) and not FILEEMPTY(F) do begin
      Inc(Len);
      if Len > High(Buffer) then
        SetLength(Buffer, Length(Buffer)*2);
      FILEREAD(F, @Buffer[Len], Sizeof(Buffer[Len]));
    end;
    B := CreateStr(1, Len);
    Move(Buffer[0], B^.Sym[0], Len);
    B^.Sym[Len] := 0;
    str_push(Machine, B);)

DECLARE(file-size, file_size)
  body(WUI(FILESIZE(WOP));)

DECLARE(*cr, star_cr)
  body(WUP(@CR_windows[0]))

DECLARE(*cr#, star_cr_hash)
  body(WUI(SizeOf(CR_windows)))

DECLARE(file-cr, file_cr) 
  var 
    F: PdfFile; 
  body(  
    F := WOP;
    FILEWRITE(F, @CR_windows[0], SizeOf(CR_windows));)

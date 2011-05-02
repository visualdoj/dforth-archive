unit DCommandsFiles;

interface




uses
  {$I units.inc},

  strings,

  DEmbroCore,
  DCommandsStrings,
  DForthMachine;

  procedure file_exists (Machine: TForthMachine; Command: PForthCommand);
  procedure file_open (Machine: TForthMachine; Command: PForthCommand);
  procedure file_close (Machine: TForthMachine; Command: PForthCommand);
  procedure file_w (Machine: TForthMachine; Command: PForthCommand);
  procedure file_r (Machine: TForthMachine; Command: PForthCommand);
  procedure file_write (Machine: TForthMachine; Command: PForthCommand);
  procedure file_read (Machine: TForthMachine; Command: PForthCommand);
  procedure file_str_write (Machine: TForthMachine; Command: PForthCommand); 
  procedure file_str_read (Machine: TForthMachine; Command: PForthCommand); 
  procedure file_size (Machine: TForthMachine; Command: PForthCommand);
  procedure star_cr (Machine: TForthMachine; Command: PForthCommand);
  procedure star_cr_hash (Machine: TForthMachine; Command: PForthCommand);
  procedure file_cr (Machine: TForthMachine; Command: PForthCommand);

procedure LoadCommands(Machine: TForthMachine);

implementation

      type
        PdfFile = ^TdfFile;
        TdfFile = record
          Data: TData;
          Name: String;
          Mode: TInt;
        end;
      procedure file_exists (Machine: TForthMachine; Command: PForthCommand);
      var
        S: TString;
        B: TStr;
      begin
        B := str_top(Machine);
        S := TString(PChar(@(B^.Sym[0])));
        Machine.WUI(Ord(FileExists(S))*BOOL_TRUE);
      end;
      procedure file_open (Machine: TForthMachine; Command: PForthCommand); 
      var 
        F: PdfFile;
        B: TStr;
      begin with Machine^ do begin New(F);
         F^.Mode := WOI; 
         B := str_pop(Machine); 
         F^.Name := PChar(@(PStrRec(B)^.Sym[0]));
         if F^.Mode = DF_FILE_R then
           F^.Data := TData.Create(F^.Name)
         else
           F^.Data := TData.Create;
         WUP(F); 
         DelRef(B);
       end; end;
      procedure file_close (Machine: TForthMachine; Command: PForthCommand); 
      var
        F: PdfFile;
      begin with Machine^ do begin F := WOP;
        if F^.Mode = DF_FILE_W then
          F^.Data.WriteToFile(F^.Name);
        F^.Data.Free;
        Dispose(F); 
       end; end;
      procedure file_w (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(DF_FILE_W)  end; end;
      procedure file_r (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(DF_FILE_R)  end; end;
      procedure file_write (Machine: TForthMachine; Command: PForthCommand); 
      var
        Src: Pointer;
        I: TInt;
        F: PdfFile;
      begin with Machine^ do begin F := WOP;
        I := WOI;
        Src := WOP;
        F^.Data.WriteVar(WOP, I);
       end; end;
      procedure file_read (Machine: TForthMachine; Command: PForthCommand);
      var
        Src: Pointer;
        I: TInt;
        F: PdfFile;
      begin with Machine^ do begin F := WOP;
        I := WOI;
        Src := WOP;
        F^.Data.WriteVar(WOP, I);
       end; end;
      procedure file_str_write (Machine: TForthMachine; Command: PForthCommand); 
      var
        B: TStr;
        F: PdfFile;
      begin with Machine^ do begin F := WOP;
        B := str_pop(Machine);
        F^.Data.WriteVar(@B^.Sym[0], B^.Len * B^.Width);
       end; end;
      procedure file_str_read (Machine: TForthMachine; Command: PForthCommand); 
      var
        B: TStr;
        F: PdfFile;
        Len: Integer;
        Buffer: array of Byte;
      begin with Machine^ do begin F := WOP;
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
        str_push(Machine, B);
       end; end;
      procedure file_size (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(PdfFile(WOP)^.Data.Size);  end; end;
      procedure star_cr (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUP(@CR_windows[0])  end; end;
      procedure star_cr_hash (Machine: TForthMachine; Command: PForthCommand); begin with Machine^ do begin WUI(SizeOf(CR_windows))  end; end;
      procedure file_cr (Machine: TForthMachine; Command: PForthCommand); 
      var 
        F: PdfFile; 
      begin with Machine^ do begin F := WOP;
        F^.Data.WriteVar(@CR_windows[0], SizeOf(CR_windows));
       end; end;

procedure LoadCommands(Machine: TForthMachine);
begin
  Machine.AddCommand('file-exists', file_open);
  Machine.AddCommand('file-open', file_open);
  Machine.AddCommand('file-close', file_close);
  Machine.AddCommand('file-w', file_w);
  Machine.AddCommand('file-r', file_r);
  Machine.AddCommand('file-str-write', file_str_write);
  Machine.AddCommand('file-str-read', file_str_read);
  Machine.AddCommand('file-write', file_write);
  Machine.AddCommand('file-read', file_read);
  Machine.AddCommand('file-size', file_size);
  Machine.AddCommand('*cr', star_cr);
  Machine.AddCommand('*cr', star_cr_hash);
  Machine.AddCommand('file-cr', file_cr);  
end;

end.

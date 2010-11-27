unit DCommandLine;

interface

uses
  {$I units.inc};

var
  CommandLine: record
                 FileNames: array of TString;
                 Repl: Boolean;
                 System: String;
                 Error: Boolean;
                 Help: Boolean;
               end;

procedure ParseCommandLine;

implementation

procedure SetDefault;
begin
  CommandLine.Error  := False;
  CommandLine.Repl   := True;
  CommandLine.System := 'system.de';
end;

procedure Error(Param: String);
begin
  CommandLine.Error := True;
  Writeln('Error: ' + Param);
end;

procedure Unknown(Param: String);
begin
  CommandLine.Error := True;
  Writeln('Error: unknown commandline ' + Param);
end;

procedure PrintHelp;
begin
  Writeln('Usage: dembro32 <option> <option> ... <option>');
  Writeln('  <option> -e <filename>           see --evaluate');
  Writeln('           -r                      see --norepl');
  Writeln('           +r                      see --repl');
  Writeln('           -s <filename>           see --system');
  Writeln('           -h                      see --help');
  Writeln('           --evaluate <filename>   evaluate file');
  Writeln('           --repl                  run REPL after evaluated all files (default)');
  Writeln('           --norepl                do not run REPL after evaluated all files');
  Writeln('           --system <filename>     change system file location');
  Writeln('           --help                  print this help');
  Writeln('           <other>                 uses as filename to evaluate');  
  CommandLine.Help := True;
end;

procedure ParseCommandLine;
var
  I, J: Integer;
  C: String; // Currect
begin
  SetDefault;
  I := 1;
  while I <= ParamCount do begin
    Inc(I);
    C := ParamStr(I - 1);
    // длинный параметр
    if Pos('--', C) = 1 then begin
      if C = '--help' then
        PrintHelp
      else if C = '--evaluate' then begin
        SetLength(CommandLine.FileNames, Length(CommandLine.FileNames) + 1);
        if I > ParamCount then begin
          Error('there is no filename parameter passed to option --evaluate');
          Exit;
        end;
        CommandLine.FileNames[High(CommandLine.FileNames)] := ParamStr(I);
        Inc(I);
      end else if C = '--repl' then begin
        CommandLine.Repl := True;
      end else if C = '--norepl' then begin
        CommandLine.Repl := False;
      end else if C = '--system' then begin
        if I > ParamCount then begin
          Error('there is no filename parameter passed to option --system');
          Exit;
        end;
        CommandLine.System := ParamStr(I);
        Inc(I);
      end else begin
        Unknown(C);
        Exit;
      end;

    // короткий параметр
    end else if Pos('-', C) <> 0 then begin
      for J := 2 to Length(C) do
        {if C[J] = 'c' then begin
          // CommandLine.Source := ParamStr(I);
          //CommandLine.Mode := CMD_EXE;
          Inc(I);
        end else if C[J] = 'o' then begin
          CommandLine.Dest := ParamStr(I);
          Inc(I);
        end else} 
        if C[J] = 'e' then begin
          SetLength(CommandLine.FileNames, Length(CommandLine.FileNames) + 1);
          if I > ParamCount then begin
            Error('there is no filename parameter passed to option --evaluate');
            Exit;
          end;
          CommandLine.FileNames[High(CommandLine.FileNames)] := ParamStr(I);
          Inc(I);
        end else if C[J] = 'r' then begin
          CommandLine.Repl := False;
        end else if C[J] = 's' then begin
          if I > ParamCount then begin
            Error('there is no filename parameter passed to option -s');
            Exit;
          end;
          CommandLine.System := ParamStr(I);
          Inc(I);
        end else if C[J] = 'h' then begin
          PrintHelp;
        end else begin
          Unknown('flag ' + C);
          Exit;
        end;

    // +x параметр
    end else if C[1] = '+' then begin
      for J := 2 to Length(C) do
        if C[J] = 'r' then begin
          CommandLine.Repl := True;
        end else begin
          Unknown('flag ' + C);
          Exit;
        end;

    // просто параметр ...
    end else begin
      //Unknown(C);
      //Exit;
      SetLength(CommandLine.FileNames, Length(CommandLine.FileNames) + 1);
      CommandLine.FileNames[High(CommandLine.FileNames)] := C;
    end;
  end;
end;

end.

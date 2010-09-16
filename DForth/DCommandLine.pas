unit DCommandLine;

interface

uses
  {$I units.inc};

var
  CommandLine: record
                 Error: Boolean;
                 Mode: (CMD_REPL, CMD_EXE);
                 Source: String;
                 Dest: String;
               end;

procedure ParseCommandLine;

implementation

procedure SetDefault;
begin
  CommandLine.Error  := False;
  CommandLine.Mode   := CMD_REPL;
  CommandLine.Source := '-';
  CommandLine.Dest   := '';
end;

procedure Unknown(Param: String);
begin
  CommandLine.Error := True;
  Writeln('Error: unknown commandline ' + Param);
end;

procedure PrintHelp;
begin
end;

procedure ParseCommandLine;
var
  I, J: Integer;
  C: String; // Currect
begin
  I := 1;
  while I <= ParamCount do begin
    Inc(I);
    C := ParamStr(I - 1);
    // длинный параметр
    if Pos('--', C) <> 0 then begin
      if C = '--help' then
        PrintHelp
      else begin
        Unknown(C);
        Exit;
      end;

    // короткий параметр
    end else if Pos('-', C) <> 0 then begin
      for J := 2 to Length(C) do
        if C[J] = 'c' then begin
          // CommandLine.Source := ParamStr(I);
          CommandLine.Mode := CMD_EXE;
          Inc(I);
        end else if C[J] = 'o' then begin
          CommandLine.Dest := ParamStr(I);
          Inc(I);
        end else if C[J] = 's' then begin
          CommandLine.Source := ParamStr(I);
          Inc(I);
        end else if C[J] = 'h' then begin
          PrintHelp;
        end else begin
          Unknown('flag ' + C);
          Exit;
        end;

    // просто параметр ...
    end else begin
      Unknown(C);
      Exit;
    end;
  end;
end;

end.

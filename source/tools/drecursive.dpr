uses
  SysUtils,
  utils;

var
  SrcPattern: String;
  DstPattern: String;
  Command: String;
  Params: String;

function ErrToStr(Err: Integer): String;
begin
  if Err = 0 then
    Result := 'ok'
  else
    Result := 'failed with code ' + IntToStr(Err);
end;

procedure OnFile(const Folder: String; const Search: TSearchRec);
var
  S, D, P: String;
begin
  if MatchPattern(Search.Name, SrcPattern) then begin
    S := Folder + Search.Name;
    D := ChangeExtension(S, '.' + ExtractExtension(DstPattern));
    P := ChangeSub(ChangeSub(Params, '%s', S), '%d', D);
    Writeln(S, ' -> ', D, '  ', ErrToStr(ExecuteProcess(Command, P)));
    Flush(Output);
  end;
end;

var 
  Folder: String;

begin
  if ParamCount <> 5 then begin
    Writeln('Usage: drecursive <folder> <srcpattern> <dstext> <command> "<params>"');
    Writeln('  <folder> base folder');
    Writeln('  <dstext> extension of output files');
    Writeln('  <command> command line that will executed on each file');
    Writeln('Example: drecursive .\ *.txt tex "cp %s %d"');
    Exit;
  end;
  Folder := ParamStr(1);
  SrcPattern := ParamStr(2);
  DstPattern := ParamStr(3);
  Command := ParamStr(4);
  Params := ParamStr(5);
  ProcessFiles(Folder, True, OnFile);
end.

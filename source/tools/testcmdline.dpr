uses
  cmdline;

var
  S: String = 
'command1 "param | param" | command2 | command3 < in > out && ' +
'command4 | command5 < in1 > out2';
  B: array of Boolean;
  E: TCommandExecuter;

procedure WriteDebugQuotes(const S: String; B: PQuoteMarkers);
var
  I: Integer;
begin
  Writeln(S);
  for I := 1 to Length(S) do
    if B[I] then
      Write('^')
    else
      Write('_');
  Writeln;
end;

begin
  SetLength(B, Length(S));
  MarkQuotes(S, '"', '"', @B[0]);
  WriteDebugQuotes(S, @B[0]);
  E := TCommandExecuter.Create;
  E.Execute(S);
end.

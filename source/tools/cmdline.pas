unit cmdline;

interface

uses
  utils,
  Pipes,
  Process;

type
PQuoteMarkers = ^TQuoteMarkers;
TQuoteMarkers = array[0..1] of Boolean;

TCommandExecuter = class
 private
  FProcesses: array of TProcess; // ������ ���� ���������� ���������
  FProcess: TProcess; // ������� �������
  FQuoteLeft: String; // ����� �������������� ������ ������
  FQuoteRight: String; // ������ �������������� ������ ������
  FPrevSucc: String; // ������ �������� ���������� ������� �� �������������
  FPrevNotSucc: String; // ������ �������� ���������� ������� �� ���������������
  FAsync: String; // ������ ������������ ������� �������
  FPipe: String; // ������ ����������� �������� ����������
  FInp: String; // ������, ��� ������ �������� ���� ����������� �� ������
  FOutp: String; // ������, ��� ������ �������� ����� ����������� �� ������
  function AddProcess: TProcess;
 public
  constructor Create;
  function Execute(Line: String): Integer;
  function ExecuteAsyncList(Start: PChar; Len: Integer; IsQuote: PQuoteMarkers): Integer;
  function MainExecutePipes(Start: PChar; Len: Integer; IsQuote: PQuoteMarkers): Integer;
  function AsyncExecutePipes(Start: PChar; Len: Integer; IsQuote: PQuoteMarkers): Integer;
  function ExecutePipes(Process: TProcess; Start: PChar; Len: Integer; IsQuote: PQuoteMarkers): Integer;
  property QuoteLeft: String read FQuoteLeft write FQuoteLeft;
  property QuoteRight: String read FQuoteRight write FQuoteRight;
  property PrevSucc: String read FPrevSucc write FPrevSucc;
  property PrevNotSucc: String read FPrevNotSucc write FPrevNotSucc;
  property Async: String read FAsync write FAsync;
  property Pipe: String read FPipe write FPipe;
  property Inp: String read FInp write FInp;
  property Outp: String read FOutp write FOutp;
end;

// ������ ������ �� ������
function MemToString(Start: PChar; Len: Integer): String;
// Markers ������ ��������� �� ������ �������� �� ����� Length(S)
procedure MarkQuotes(const Line, L, R: String; IsQuote: PQuoteMarkers);
// ���������� ��� ������� ������ � ������ ���������� ������� �������
function CompareQuotesMem(P1, P2: PChar; Len: Integer; IsQuote: PQuoteMarkers): Boolean;

implementation

function TCommandExecuter.AddProcess: TProcess;
begin
  Result := TProcess.Create(nil);
  Result.Options := [poUsePipes];
  SetLength(FProcesses, Length(FProcesses) + 1);
  FProcesses[High(FProcesses)] := Result;
end;

constructor TCommandExecuter.Create;
begin
  FQuoteLeft := '"';
  FQuoteRight := '"';
  FPrevSucc := '&&';
  FPrevNotSucc := '||';
  FAsync := '&';
  FPipe := '|';
  FInp := '<';
  FOutp := '>';
  FProcess := TProcess.Create(nil);
  FProcess.Options := [poUsePipes];
end;

function TCommandExecuter.Execute(Line: String): Integer;
var
  IsQuote: array of Boolean;
  I, Last: Integer;
begin
  // 1. �������� �������� ������� � ������
  SetLength(IsQuote, Length(Line));
  MarkQuotes(Line, FQuoteLeft, FQuoteRight, @IsQuote[0]);
  // 2. ��������� ������ �� �������������� �������� && � ||, � ����� ���������
  Last := 0;
  I := 1;
  while I <= Length(Line) do begin
    if Length(FPrevSucc) <= Length(Line) - I + 1 then begin
      if CompareQuotesMem(@Line[I], @FPrevSucc[1], 
                          Length(FPrevSucc), @IsQuote[I-1]) then begin
        Result := ExecuteAsyncList(@Line[Last+1], I - Last, @IsQuote[Last+1]);
        if Result <> 0 then
          Exit;
        Inc(I, Length(FPrevSucc));
      end else 
        Inc(I);
      continue;
    end; 
    if Length(FPrevNotSucc) <= Length(Line) - I + 1 then begin
      if CompareQuotesMem(@Line[I], @FPrevNotSucc[1], 
                          Length(FPrevNotSucc), @IsQuote[I-1]) then begin
        Result := ExecuteAsyncList(@Line[Last+1], I - Last, @IsQuote[Last+1]);
        if Result = 0 then
          Exit;
        Inc(I, Length(FPrevNotSucc));
      end else
        Inc(I);
      continue;
    end;
    Inc(I);
  end;
  ExecuteAsyncList(@Line[Last+1], Length(Line) - Last, @IsQuote[Last+1]);
end;

function TCommandExecuter.ExecuteAsyncList;
var
  I, Last: Integer;
begin
  // 3. ��������� �������� & � ���������� ��������� ������ ������
  Last := 0;
  I := 0;
  while I < Len do
    if Length(FAsync) <= Len - I + 1 then begin
      if CompareQuotesMem(@Start[I], @FAsync[1], Length(FAsync), @IsQuote[I]) then begin
        if Last = 0 then begin // ���� ������ ������, ��������� �������� ��������� 
          MainExecutePipes(Start, I - 1, IsQuote);
        end else begin
          AsyncExecutePipes(@Start[Last + 1], I - Last - 1, @IsQuote[Last + 1]);
        end;
        Inc(I, Length(FAsync));
        Last := I - 1;
      end else
        Inc(I);
    end else 
      Inc(I);
  if Last = 0 then begin
    MainExecutePipes(Start, Len, IsQuote);
  end else begin
    AsyncExecutePipes(@Start[Last + 1], Len - Last, @IsQuote[Last + 1]);
  end;
  // ���������� ���������� ������ �������
  // ...
end;

function TCommandExecuter.MainExecutePipes;
begin
  ExecutePipes(FProcess, Start, Len, IsQuote);
end;

function TCommandExecuter.AsyncExecutePipes;
begin
  ExecutePipes(AddProcess, Start, Len, IsQuote);
end;

function TCommandExecuter.ExecutePipes(Process: TProcess; Start: PChar; Len: Integer; IsQuote: PQuoteMarkers): Integer;
var
  SubProcesses: array of TProcess;
  Last, First, I, J: Integer;
  InFile, OutFile: String;
begin
  // 4. ��������� �������� | �� �����, ��������� �� ����������
  SetLength(SubProcesses, 0);
  Last := 0;
  I := 0;
  while I < Len do
    if Length(FPipe) <= Len - I + 1 then begin
      if CompareQuotesMem(@Start[I], @FPipe[1], Length(FPipe), @IsQuote[I]) then begin
        SetLength(SubProcesses, Length(SubProcesses) + 1);
        SubProcesses[High(SubProcesses)] := AddProcess;
        with SubProcesses[High(SubProcesses)] do
          CommandLine := Trim(MemToString(@Start[Last], I - Last));

        // debug
        Writeln(SubProcesses[High(SubProcesses)].CommandLine);
        for J := 0 to I - Last - 1 do
          if IsQuote[Last + J] then
            Write('^')
          else
            Write('_');
        Writeln;

        Inc(I, Length(FPipe));
        Last := I;
      end else
        Inc(I);
    end else
      Inc(I);
  // ������ ����� ����� ����� ������ ��������������� � �����
  First := Len;
  I := Len - 1;
  InFile := '';
  OutFile := '';
  while I >= Last do begin
    if Length(FInp) <= First - I then begin
      if CompareQuotesMem(@Start[I], @FInp[1], Length(FInp), @IsQuote[I]) then begin
        InFile := Trim(MemToString(@Start[I + Length(FInp)], First - I - Length(FInp)));
        First := I;
      end;
    end; 
    if Length(FOutp) <= First - I then begin
      if CompareQuotesMem(@Start[I], @FOutp[1], Length(FOutp), @IsQuote[I]) then begin
        OutFile := Trim(MemToString(@Start[I + Length(FOutp)], First - I - Length(FOutp)));
        First := I;
      end;
    end;
    Dec(I);
  end;
  Process.CommandLine := Trim(MemToString(@Start[Last], First - Last));
        // debug
        Writeln(Process.CommandLine, '      i=', InFile, ' o=', OutFile);
        for J := 0 to Len - Last - 1 do
          if IsQuote[Last + J] then
            Write('^')
          else
            Write('_');
        Writeln;
end;

function MemToString(Start: PChar; Len: Integer): String;
begin
  SetLength(Result, Len);
  Move(Start^, Result[1], Len);
end;

procedure MarkQuotes(const Line, L, R: String; IsQuote: PQuoteMarkers);
var
  InQuote: Boolean;
  I, J: Integer;
begin
  InQuote := False;
  I := 0;
  while I <= Length(Line) do
    if InQuote then begin
      IsQuote[I] := True;
      if Length(R) > Length(Line) - I + 1 then begin
        FillChar(IsQuote[I], Length(Line) - I + 1, True);
        Break;
      end else if memncmp(@R[1], @Line[I], Length(R)) = 0 then begin
        FillChar(IsQuote[I], Length(R), True);
        Inc(I, Length(R));
        InQuote := False;
      end else
        Inc(I);
    end else begin
      IsQuote[I] := False;
      if Length(L) > Length(Line) - I + 1 then begin
        FillChar(IsQuote[I], Length(Line) - I + 1, False);
        Break;
      end else if memncmp(@L[1], @Line[I], Length(L)) = 0 then begin
        FillChar(IsQuote[I], Length(L), True);
        Inc(I, Length(L));
        InQuote := True;
      end else
        Inc(I);
    end;
end;

function CompareQuotesMem(P1, P2: PChar; Len: Integer; IsQuote: PQuoteMarkers): Boolean;
var
  I: Integer;
begin
  for I := 0 to Len - 1 do
    if IsQuote[I] or (P1[I] <> P2[I]) then begin
      Result := False;
      Exit;
    end;
  Result := True;
end;

end.

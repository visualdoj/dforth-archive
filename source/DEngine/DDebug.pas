unit DDebug;

interface

uses
  DOS,
  DUtils;

type
TDebug = class
private
  FLogFile: TString;
  FConsole: Boolean;
  procedure PrintToLogFile(S: TString);
  procedure ClearLogFile;
public
  constructor Create(LogFile: TString = 'log.txt');
  procedure Log(Mes: TString; Group: TString = '  ');
  procedure Error(Mes: TString); inline;
  procedure Fatal(Mes: TString); inline;
  procedure Warrning(Mes: TString); inline;
  procedure Added(Mes: TString); inline;
  procedure Deleted(Mes: TString); inline;
  function Assert(Cond: Boolean; Mes: TString = ''): Boolean;
  // only for fpc with -gl option
  function GetLineInfo(P: Pointer): TString; 
  procedure LogStack(Li: Integer = 0; Count: Integer = 30);
  procedure UnusedVar(var V);
  property Console: Boolean read FConsole write FConsole;
end;

var
  Debug: TDebug;
  SDebug: TDebug; // S = Singleton, = Debug, оставлен для совместимости с первыми версиями движка

procedure Log(Mes: TString; Group: TString = '  ');
procedure Error(Mes: TString);
procedure Fatal(Mes: TString);
procedure Warrning(Mes: TString);
procedure Added(Mes: TString);
procedure Deleted(Mes: TString);
function Assert(Cond: Boolean; Mes: TString = ''): Boolean;

implementation

{$IFDEF FLAG_FPC}{$IFDEF FLAG_DEBUG}
//uses
//  lineinfo;
{$ENDIF}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TDebug'}{$ENDIF}
//  TDebug
//
procedure TDebug.PrintToLogFile(S: TString);
  Var
    //Data: TData;
    F: TextFile;
    Time: TString;
begin
  if FLogFile = '' then
    Exit;
  Assign(F, FLogFile);
  {$I-}
  Append(F);
  {$I+}
  if IOResult <> 0 then
    Exit;
  Time := IntToStr(GetTimer) + ' ';
  while Length(Time) < 10 do
    Time := '0' + Time;
  Writeln(F, Time, S);
  Close(F);
  {Data := TData.Create(FLogFile); 
  Time := IntToStr(GetTimer) + ' ';
  while Length(Time) < 10 do
    Time := '0' + Time;
  Data.WriteVar(@Time[1], Length(Time));
  Data.WriteVar(@S[1], Length(S));
  Data.WriteVar(@EOL[1], Length(EOL));
  Data.WriteToFile(FLogFile);
  Data.Free;}
end;

procedure TDebug.ClearLogFile;
  var
    Data: TData;
begin
  if FLogFile = '' then
    Exit;
  Data := TData.Create;
  Data.WriteToFile(FLogFile);
  Data.Free;
end;

constructor TDebug.Create;
begin
  FLogFile := '';
  {$IFNDEF FLAG_NOLOG}
  FLogFile := LogFile;
  ClearLogFile;
  {$ENDIF}
  FConsole := True;
end;

procedure TDebug.Log;
begin
  {$IFDEF FLAG_CONSOLE}
  if FConsole then
    Writeln(Group + ' ' + Mes);
  {$ENDIF}
  {$IFNDEF FLAG_NOLOG}
  PrintToLogFile(Group + ' ' + Mes);
  {$ENDIF}
end;

procedure TDebug.Error(Mes: TString);
begin
  Log(Mes, '! ');
end;

procedure TDebug.Fatal(Mes: TString);
begin
  Log(Mes, 'x ');
  LogStack;
  Halt;
end;

procedure TDebug.Warrning(Mes: TString);
begin
  Log(Mes, 'w ');
end;

procedure TDebug.Added(Mes: TString);
begin
  Log(Mes, '+ ');
end;

procedure TDebug.Deleted(Mes: TString);
begin
  Log(Mes, '- ');
end;

function TDebug.Assert(Cond: Boolean; Mes: TString = ''): Boolean;
begin
  Result := Cond;
  if not Cond then
    if Mes <> '' then
      Log(Mes, '? ')
    else begin
      Log('assert error', '?');
      LogStack;
    end;
end;

function TDebug.GetLineInfo(P: Pointer): TString; 
  //var
  //  Func, Source: ShortTString;
  //  Line: LongInt;
begin
  Result := '';
  {$IFDEF FLAG_FPC}{$IFDEF FLAG_DEBUG}
  {lineinfo.GetLineInfo(LongWord(P), Func, Source, Line);
  Result := 'Line info: ';
  if Func <> '' then
    Result := Result + Func;
  if Source <> '' then begin
    if Func <> '' then
      Result := Result + ', ';
    if Line <> 0 then
      Result := Result + ' line ' + IntToStr(Line);
    Result := Result + ' of ' + '"' + Source + '"';
  end;
  if Result = 'Line info: ' then
    Result := '';}
  {$ENDIF}{$ENDIF}
end;

procedure TDebug.LogStack(Li: Integer = 0; Count: Integer = 30);
  var
    Frame: Pointer;
    I: Integer;
begin
 {$IFDEF FLAG_FPC}
 Frame := get_frame;
  I := 0;
  while (Frame <> nil) and (I - Li < Count) do begin
    if I >= Li then
      //Log(BackTraceStrFunc(get_caller_addr(Frame)), ' >');
      Log(GetLineInfo(get_caller_addr(Frame)), ' >');
    Frame := get_caller_frame(Frame);
    Inc(I);
  end;
  {$ENDIF}
end;

procedure TDebug.UnusedVar(var V);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'functions'}{$ENDIF}
procedure Log;
begin
  Debug.Log(Mes, Group);
end;

procedure Error(Mes: TString);
begin
  Debug.Error(Mes);
end;

procedure Fatal(Mes: TString);
begin
  Debug.Fatal(Mes);
end;

procedure Warrning(Mes: TString);
begin
  Debug.Warrning(Mes);
end;

procedure Added(Mes: TString);
begin
  Debug.Added(Mes);
end;

procedure Deleted(Mes: TString);
begin
  Debug.Deleted(Mes);
end;

function Assert(Cond: Boolean; Mes: TString = ''): Boolean;
begin
  Result := Debug.Assert(Cond, Mes);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  Debug := TDebug.Create;
  SDebug := Debug;
finalization
  Debug.Free;
end.

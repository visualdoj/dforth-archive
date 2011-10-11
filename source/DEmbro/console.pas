unit console;

interface

{ $DEFINE USE_CRT}

uses
  {$IFDEF USE_CRT}
  CRT,
  {$ENDIF}
  DUtils,
  DEmbroCore;

{$IFDEF USE_CRT}
const
  COLOR_WHITE = White;
  COLOR_BLACK = Black;
  COLOR_GRAY = LightGray;
  COLOR_RED = LightRed;
  COLOR_GREEN = LightGreen;
  COLOR_BLUE = LightBlue;
  COLOR_YELLOW = Yellow;
  COLOR_PINK = LightMagenta;
  COLOR_CYAN = LightCyan;
  COLOR_LIGHTGRAY = LightGray;
  COLOR_LIGHTRED = LightRed;
  COLOR_LIGHTGREEN = LightGreen;
  COLOR_LIGHTBLUE = LightBlue;
  COLOR_LIGHTYELLOW = Yellow;
  COLOR_LIGHTPINK = LightMagenta;
  COLOR_LIGHTCYAN = LightCyan;
  COLOR_DARKGRAY = DarkGray;
  COLOR_DARKRED = Red;
  COLOR_DARKGREEN = Green;
  COLOR_DARKBLUE = Blue;
  COLOR_DARKYELLOW = Brown;
  COLOR_DARKPINK = Magenta;
  COLOR_DARKCYAN = Cyan;
{$ELSE}
const
  COLOR_WHITE = $FFFFFFFF;
  COLOR_BLACK = $000000FF;
  COLOR_GRAY = $8C8C8CFF;
  COLOR_RED = $FF0000FF;
  COLOR_GREEN = $00FF00FF;
  COLOR_BLUE = $0000FFFF;
  COLOR_YELLOW = $FFFF00FF;
  COLOR_PINK = $FF00FFFF;
  COLOR_CYAN = $00FFFFFF;
  COLOR_LIGHTGRAY = $8C8C8CFF;
  COLOR_LIGHTRED = $FF0000FF;
  COLOR_LIGHTGREEN = $00FF00FF;
  COLOR_LIGHTBLUE = $0000FFFF;
  COLOR_LIGHTYELLOW = $FFFF00FF;
  COLOR_LIGHTPINK = $FF00FFFF;
  COLOR_LIGHTCYAN = $00FFFFFF;
  COLOR_DARKGRAY = $444444FF;
  COLOR_DARKRED = $8C0000FF;
  COLOR_DARKGREEN = $008C00FF;
  COLOR_DARKBLUE = $00008CFF;
  COLOR_DARKYELLOW = $8C8C00FF;
  COLOR_DARKPINK = $8C008CFF;
  COLOR_DARKCYAN = $008C8CFF;
{$ENDIF}

type
TConsole = object
  // input/output
  procedure Print(Buf: Pointer; Size: Integer);
  procedure Scan(Buf: Pointer; Size: Integer);
  function ScanToChar(EndChar: Integer; Buf: Pointer; MaxSize: Integer; var Size: Integer): Boolean;
  // input/output utils
  procedure Emit(C: Integer);
  function GetChar: Integer;
  procedure PrintStr(S: TStr);
  function ReadStr: TStr;
  procedure PrintPChar(S: PAnsiChar);
  function ReadPChar: PAnsiChar;
  // clear
  procedure ClearScreen;
  procedure ClearLine;
  procedure Clear(Chars: Integer);
  // colors
  procedure SetFontColor(Color: Integer);
  procedure SetBackgroundColor(Color: Integer);
  procedure SetBlink(Blink: Boolean);
end;

implementation

{$IFDEF USE_CRT}
{$IFNDEF FLAG_FPC}{$REGION 'CRT version'}{$ENDIF}
procedure TConsole.Print(Buf: Pointer; Size: Integer);
var
  I: Integer;
begin
  for I := 0 to Size - 1 do
    Write(TChar(PArrayOfByte(Buf)^[I]));
end;

procedure TConsole.Scan(Buf: Pointer; Size: Integer);
var
  I: Integer;
begin
  for I := 0 to Size - 1 do
    Read(TChar(PArrayOfByte(Buf)^[I]));
end;

function TConsole.ScanToChar(EndChar: Integer; Buf: Pointer; MaxSize: Integer; var Size: Integer): Boolean;
var
  C: TChar;
begin
  Size := 0;
  while Size < MaxSize do begin
    Read(C);
    if Byte(C) = EndChar then begin
      Result := True;
      Exit;
    end;
    TChar(PArrayOfByte(Buf)^[Size]) := C;
    Inc(Size);
  end;
end;

procedure TConsole.Emit(C: Integer);
begin
  Write(TChar(C));
end;

function TConsole.GetChar: Integer;
var
  C: TChar;
begin
  Read(C);
  Result := Ord(C);
end;

procedure TConsole.PrintStr(S: TStr);
var
  I: Integer;
begin
  if S^.Width = 1 then begin
    PrintPChar(@S^.Sym[0]);
  end else begin
    for I := 0 to S^.Len - 1 do begin
      // TODO
    end;
  end;
end;

function TConsole.ReadStr: TStr;
begin
  // TODO
  Result := nil;
end;

procedure TConsole.PrintPChar(S: PAnsiChar);
begin
  Write(S);
end;

function TConsole.ReadPChar: PAnsiChar;
var
  S: TString;
begin
  Readln(S);
  Result := PAnsiChar(S);
end;

procedure TConsole.ClearScreen;
begin
  ClrScr;
end;

procedure TConsole.ClearLine;
begin
  GotoXY(1, WhereY);
  DelLine;
  // GotoXY(1,10);  
  // nothing can do
end;

procedure TConsole.Clear(Chars: Integer);
begin
  // nothing can do
end;

procedure TConsole.SetFontColor(Color: Integer);
begin
  TextColor(Color);
end;

procedure TConsole.SetBackgroundColor(Color: Integer);
begin
  TextBackground(Color);
end;

procedure TConsole.SetBlink(Blink: Boolean);
begin
  // nothing can do
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$ELSE}
{$IFNDEF FLAG_FPC}{$REGION 'simple'}{$ENDIF}
procedure TConsole.Print(Buf: Pointer; Size: Integer);
var
  I: Integer;
begin
  for I := 0 to Size - 1 do
    Write(TChar(PArrayOfByte(Buf)^[I]));
end;

procedure TConsole.Scan(Buf: Pointer; Size: Integer);
var
  I: Integer;
begin
  for I := 0 to Size - 1 do
    Read(TChar(PArrayOfByte(Buf)^[I]));
end;

function TConsole.ScanToChar(EndChar: Integer; Buf: Pointer; MaxSize: Integer; var Size: Integer): Boolean;
var
  C: TChar;
begin
  Size := 0;
  while Size < MaxSize do begin
    Read(C);
    if Byte(C) = EndChar then begin
      Result := True;
      Exit;
    end;
    TChar(PArrayOfByte(Buf)^[Size]) := C;
    Inc(Size);
  end;
end;

procedure TConsole.Emit(C: Integer);
begin
  Write(TChar(C));
end;

function TConsole.GetChar: Integer;
var
  C: TChar;
begin
  Read(C);
  Result := Ord(C);
end;

procedure TConsole.PrintStr(S: TStr);
var
  I: Integer;
begin
  if S^.Width = 1 then begin
    PrintPChar(@S^.Sym[0]);
  end else begin
    for I := 0 to S^.Len - 1 do begin
      // TODO
    end;
  end;
end;

function TConsole.ReadStr: TStr;
begin
  // TODO
  Result := nil;
end;

procedure TConsole.PrintPChar(S: PAnsiChar);
begin
  Write(S);
end;

function TConsole.ReadPChar: PAnsiChar;
var
  S: TString;
begin
  Readln(S);
  Result := PAnsiChar(S);
end;

procedure TConsole.ClearScreen;
begin
end;

procedure TConsole.ClearLine;
begin
end;

procedure TConsole.Clear(Chars: Integer);
begin
  // nothing can do
end;

procedure TConsole.SetFontColor(Color: Integer);
begin
end;

procedure TConsole.SetBackgroundColor(Color: Integer);
begin
end;

procedure TConsole.SetBlink(Blink: Boolean);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$ENDIF}

end.
{$IFDEF CPU32}
  // 32 bits
{$ENDIF}
{$IFDEF CPU64}
  // 64 bits
{$ENDIF}

{$IFDEF MSWINDOWS}
{$ENDIF}

{$IFDEF WIN32}
{$ENDIF}

{$IFDEF ENDIAN_BIG}
  // endian big
{$ELSE}
  // endian little
{$ENDIF}


unit DTreeExpr;

interface

uses
  DDebug,
  DUtils,
  DParser;

type
TTreeExprError = record
end;

TTreeExpr = class
 private
  FName: TString;
  FContent: TString;
  FTrimedContent: TString;
  FCount: Integer;
  FExprs: array of TTreeExpr;
  function GetExpr(Index: Integer): TTreeExpr;
 public
  constructor Create(
        const S: PAnsiChar; 
        SLength: Integer; 
        var BeginIndex: Integer;
        out Error: Boolean
      ); overload;
  constructor Create(
        const S: TString; 
        BeginIndex: Integer;
        out Error: Boolean
      ); overload;
  destructor Destroy; override;
  procedure PrintToLog(const Left: TString = ' ');
  function IsNIL: Boolean;
  function IsSYM: Boolean;
  function IsExpr: Boolean;
  function GetFirstName: TString;
  function TrimContent: TString;
  property Name: TString read FName;
  property Content: TString read FContent;
  property Count: Integer read FCount;
  property Exprs[Index: Integer]: TTreeExpr read GetExpr;
  property FirstName: TString read GetFirstName;
end;

function CreateTreeExpr(
      S: TString; 
      var BeginIndex: Integer; 
      var E: TTreeExpr
    ): Boolean;

implementation

function TTreeExpr.GetExpr(Index: Integer): TTreeExpr;
begin
  Result := FExprs[Index];
end;

constructor TTreeExpr.Create(
      const S: PAnsiChar; 
      SLength: Integer; 
      var BeginIndex: Integer;
      out Error: Boolean
    );
var
  StartIndex: Integer;
begin
  FName := '';
  FContent := '';
  SetLength(FExprs, 0);
  StartIndex := BeginIndex;
  Error := False;
  while BeginIndex < SLength do
    if S[BeginIndex] in [#0..#32] then
      Inc(BeginIndex)
    else
      Break;
  if BeginIndex >= SLength then
    Exit;
  if S[BeginIndex] = '(' then begin
    Inc(BeginIndex);
    while BeginIndex < SLength do
      if S[BeginIndex] in [#0..#32] then
        Inc(BeginIndex)
      else begin
        if S[BeginIndex] = ')' then
          Break
        else begin
          SetLength(FExprs, Length(FExprs) + 1);
          FExprs[High(FExprs)] := TTreeExpr.Create(S, 
                                                   SLength, 
                                                   BeginIndex, 
                                                   Error);
          if Error then
            Break;
        end;
      end;
    FCount := Length(FExprs);
    if BeginIndex >= SLength then begin
      Error := True;
      FContent := Copy(S, StartIndex, BeginIndex - StartIndex); 
      Exit;
    end;
    Inc(BeginIndex);
  end else
    while BeginIndex < SLength do
      if S[BeginIndex] in [#0..#32, '(', ')'] then
        Break
      else begin
        FName := FName + S[BeginIndex];
        Inc(BeginIndex);
      end;
  FContent := TString(Copy(TString(S), StartIndex + 1, BeginIndex - StartIndex)); 
  FTrimedContent := FContent;
  if IsExpr then begin
    while Length(FTrimedContent) > 0 do
      if FTrimedContent[1] in [#0..#32] then
        Delete(FTrimedContent, 1, 1)
      else if FTrimedContent[1] = '(' then begin
        Delete(FTrimedContent, 1, 1);
        Break;
      end else
        Break;
    while Length(FTrimedContent) > 0 do
      if FTrimedContent[Length(FTrimedContent)] in [#0..#32] then
        Delete(FTrimedContent, Length(FTrimedContent), 1)
      else if FTrimedContent[Length(FTrimedContent)] = ')' then begin
        Delete(FTrimedContent, Length(FTrimedContent), 1);
        Break;
      end else
        Break;
  end;
end;

constructor TTreeExpr.Create(
      const S: TString; 
      BeginIndex: Integer;
      out Error: Boolean
    );
begin
  Dec(BeginIndex);
  Create(@S[1], Length(S), BeginIndex, Error);
end;

destructor TTreeExpr.Destroy; 
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    FExprs[I].Free;
end;

procedure TTreeExpr.PrintToLog;
var
  I: Integer;
begin
  if IsNIL then
    Log(Left + 'NIL')
  else if IsSYM then
    Log(Left + FName)
  else begin
    Log(Left + '(' + ' "' + Content + '"');
    for I := 0 to FCount - 1 do
      FExprs[I].PrintToLog(Left + '  ');
    Log(Left + ')');
  end;
end;

function TTreeExpr.IsNIL: Boolean;
begin
  Result := ((FName = '') and (FCount = 0)) or (FName = 'NIL');
end;

function TTreeExpr.IsSYM: Boolean;
begin
  Result := FCount = 0;
end;

function TTreeExpr.IsExpr: Boolean;
begin
  Result := FCount > 0;
end;

function TTreeExpr.GetFirstName: TString;
begin
  if FCount > 0 then
    Result := FExprs[0].Name
  else
    Result := '';
end;

function TTreeExpr.TrimContent: TString;
begin
  Result := FTrimedContent;
end;

function CreateTreeExpr(
      S: TString; 
      var BeginIndex: Integer; 
      var E: TTreeExpr
    ): Boolean;
var
  Error: Boolean;
begin
  Dec(BeginIndex);
  E := TTreeExpr.Create(@S[1], Length(S), BeginIndex, Error);
  Inc(BeginIndex);
  Result := Error;
end;

end.

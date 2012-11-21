{$M+}
unit DTranslater;

interface

uses
  DDebug,
  DUtils,
  DParser,
  
  DIni,
  DXML,
  DXMLExecutor;

type
TLex = record
  Name: TString;
  Value: TUnicode;
end;

TLanguage = class
 private
  FName: TString;
  FTranslatedName: TUnicode;
  // по сути алфавит
  // может помочь при генерации шрифтов
  // вспомогательное данное, для внешнего пользования
  FCharSet: TUnicode;
  // лексемы
  FLexes: array of TLex;
  function GetLex(const Name: TString): TUnicode;
 public
  constructor Create(const Name: TString);
  procedure Clear;
  procedure AddLex(const Name: TString; const Value: TUnicode);
  property Name: TString read FName;
  property TranslatedName: TUnicode read FTranslatedName;
  property CharSet: TUnicode read FCharSet write FCharSet;
  property Lexes[Name: TString]: TUnicode read GetLex; default;
 published
  procedure XMLlangname(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
  procedure XMLcharset(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
  procedure XMLlex(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
end;

TTranslater = class
 private
  FLanguage: TString;
  FLanguages: array of TLanguage;
  FCurrentLanguage: TLanguage;
 public
  constructor Create(const FileName: TString);
  destructor Destroy; override;
  // Поддерживаются ini и xml, выбираются по расширению
  function Load(const FileName: TString): Boolean;
  function LoadIni(const FileName: TString): Boolean;
  function LoadXml(const FileName: TString): Boolean;
  function SetLanguage(Language: TString): Boolean;
  function Translate(Name: TString): TUnicode; 
  property Translations[Name: TString]: TUnicode read Translate; default;
 published
  procedure XMLtranslations(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
  procedure XMLlang(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
end;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TLanguage'}{$ENDIF}
function TLanguage.GetLex(const Name: TString): TUnicode;
  var
    I: Integer;
begin
  for I := 0 to High(FLexes) do begin
    if MatchPattern(Name, FLexes[I].Name) then begin
      Result := FLexes[I].Value;
      Exit;
    end;
  end;
  Result := Name;
end;

constructor TLanguage.Create(const Name: TString);
begin
  FName := Name;
end;

procedure TLanguage.Clear;
begin
  FCharSet := '';
  SetLength(FLexes, 0);
end;

procedure TLanguage.AddLex(const Name: TString; const Value: TUnicode);
begin
  SetLength(FLexes, Length(FLexes) + 1);
  FLexes[High(FLexes)].Name := Name;
  FLexes[High(FLexes)].Value := Value;
end;

procedure TLanguage.XMLlangname(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
begin
  FTranslatedName := Item.GetTextRecursively;
end;

procedure TLanguage.XMLcharset(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
begin
  FCharSet := Item.GetTextRecursively;
end;

procedure TLanguage.XMLlex(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
begin
  AddLex(Item['name'], Item.GetText);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

constructor TTranslater.Create(const FileName: TString);
begin
  //FIni := TIni.Create(FileName);
  FLanguage := 'english';
  Load(FileName);
end;

destructor TTranslater.Destroy;
  var
    I: Integer;
begin
  for I := 0 to High(FLanguages) do
    FLanguages[I].Free;
  SetLength(FLanguages, 0)

  //FIni.Free;
end;

function TTranslater.Load;
begin
  Result := True;
  if FileName = '' then
    Exit;
  if Pos('.ini', FileName) = Length(FileName) - 3 then
    LoadIni(FileName)
  else if Pos('.xml', FileName) = Length(FileName) - 3 then
    LoadXML(FileName)
  else begin
    Result := False;
    DDebug.Error('[TTranslater.Load] unknown extension "' + FileName + '"');
  end;
end;

function TTranslater.LoadIni(const FileName: TString): Boolean;
begin
  Result := False;
  Result := True;
end;

function TTranslater.LoadXml(const FileName: TString): Boolean;
begin
  Result := False;
  if not CommonLoadXML(Self, FileName) then
    Exit;
  Result := True;
end;

function TTranslater.SetLanguage;
begin
  FLanguage := Language;
  Result := True;
end;

function TTranslater.Translate(Name: TString): TUnicode; 
  var
    L: Integer;
begin
  for L := 0 to High(FLanguages) do begin
    if FLanguages[L].Name = FLanguage then begin
      Result := FLanguages[L][Name];
      Exit;
    end;
  end;
  Result := Name;
end;

procedure TTranslater.XMLtranslations(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
begin
end;

procedure TTranslater.XMLlang(Exe: TXMLExecutor; Item: TXMLTag; Into: Boolean);
begin
  SetLength(FLanguages, Length(FLanguages) + 1);
  FCurrentLanguage := TLanguage.Create(Item['name']);
  FLanguages[High(FLanguages)] := FCurrentLanguage;
  Exe.AddTagsFromObj(FCurrentLanguage);
end;

end.

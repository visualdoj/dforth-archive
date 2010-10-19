unit DXML;

interface

uses
  DDebug,
  DUtils,
  DEncoding;

const
  // errors
  XE_NO                         = $00;
  XE_EXPECTED_TAG_OPEN          = $01;
  XE_EXPECTED_TAG_CLOSE         = $02;
  XE_EXPECTED_PARAM_EQUAL       = $03;
  XE_EXPECTED_PARAM_MARK        = $04;
  XE_INCORRECT_CLOSETAG_NAME    = $05;
  XE_INCORRECT_COMMENT          = $06;
  XE_CANNOT_OPEN_FILE           = $07;
  XE_CANNOT_CREATE_DATA         = $07;
  XE_INCORRECT_UTF8_SYMBOL      = $08;

type
TXMLErrorId = Integer;

TXMLLoadingInfo = record
  FileName: TString;
  Line, Pos: Integer;
end;

TXMLErrorInfo = record
  Id: TXMLErrorId;
  Str: TString;
  LoadingInfo: TXMLLoadingInfo;
end;

// TXMLItemType = (xitHeader, xitTag, xitText);

TXMLParam = record
  Name: TString;
  Value: TString;
end;

{PXMLItem = ^TXMLItem;
TXMLItem = record
  Typ: TXMLItemType;
  Text: TString; // for tag it is name; for header it is ''
  Params: array of TXMLParam; // for text it is nil
  Content: array of PXMLItem; // just for tag
end;}

TXMLItem = class
 public
  function GetTextRecursively: TUnicode; virtual;
end;

TListOfXMLParam = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TXMLParam>;
TListOfXMLItem = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TXMLItem>;

TXMLHeader = class(TXMLItem)
 private
  FParams: TListOfXMLParam;
  function GetParamValue(const Param: TString): TString;
 public
  constructor Create;
  destructor Destroy; override;
  function GetParamDef(const Param, Def: TString): TString;
  property Params: TListOfXMLParam read FParams;
  property NamedParams[Name: TString]: TString read GetParamValue; default;
end;

TXMLTag = class(TXMLHeader)
 private
  FName: TString;
  FItems: TListOfXMLItem;
 public
  constructor Create(const Name: TString);
  destructor Destroy; override;
  function GetText: TUnicode;
  function GetTextRecursively: TUnicode; override;
  property Name: TString read FName;
  property Items: TListOfXMLItem read FItems;
end;

TXMLText = class(TXMLItem)
 private
  FText: TUnicode;
 public
  constructor Create(const Text: TUnicode);
  property Text: TUnicode read FText;
end;

TXML = class
 private
  FHeader: TXMLHeader;
  FRoot: TXMLTag;
  FErrors: array of TXMLErrorInfo;
  FEncoding: TString;
  FLoadingInfo: TXMLLoadingInfo;
  procedure AddError(
        Id: TXMLErrorId; 
        const Str: TString; 
        const LoadingInfo: TXMLLoadingInfo
      );
  function GetLastError: TXMLErrorInfo;
  function ReadByte(Data: TData; var LoadingInfo: TXMLLoadingInfo): Byte;
  function ReadEncodedChar(Data: TData; 
                           var LoadingInfo: TXMLLoadingInfo; 
                           out C: TUnicodeChar): Boolean;
 public
  constructor Create;
  destructor Destroy; override;
  function Load(FileName: TString): Boolean; overload;
  function Load(Data: TData): Boolean; overload;
  function Parse(Data: Pointer; Size: Integer): boolean;
  procedure Save(FileName: TString);
  procedure Clear;
  procedure SkipSpaces(Data: TData; var LoadingInfo: TXMLLoadingInfo);
  function ReadParams(Data: TData; Item: TXMLHeader; Finish: TSetOfChar; var LoadingInfo: TXMLLoadingInfo): Boolean;
  function ReadTag(Data: TData; Item: TXMLTag; var LoadingInfo: TXMLLoadingInfo): Boolean;
  function ReadContent(Data: TData; Item: TXMLTag; var EndTag: TString; var LoadingInfo: TXMLLoadingInfo): Boolean;
  function ReadStr(Data: TData; var S: TString; var LoadingInfo: TXMLLoadingInfo): Boolean;
  function GetHeader: TXMLHeader;
  function GetRoot: TXMLTag;
  procedure PrintErrorsToLog;
  function IsLastError: Boolean;
  property Root: TXMLTag read GetRoot;
  property LastError: TXMLErrorInfo read GetLastError;
end;

//procedure XMLSetEmpty(Item: PXMLItem; Typ: TXMLItemType; Text: TString);
//procedure XMLAddParam(Item: PXMLItem; Name, Value: TString);
//function XMLAddContent(Item: PXMLItem; Typ: TXMLItemType; Text: TString): PXMLItem;
//procedure XMLClearRecursive(var Item: TXMLItem);

// DEPRECATED, оставлено для временной совместимости
function XMLParamValue(
      Item: TXMLHeader; 
      const Param: TString; 
      const Def: TString = ''
    ): TString;
//function XMLGetText(Item: PXMLItem): TString;

procedure Test(const FileName: TString);

implementation

{procedure XMLSetEmpty(Item: PXMLItem; Typ: TXMLItemType; Text: TString);
begin
  Item.Typ := Typ;
  Item.Text := Text;
  SetLength(Item.Params, 0);
  SetLength(Item.Content, 0);
end;

procedure XMLAddParam(Item: PXMLItem; Name, Value: TString);
begin
  if Item.Typ = xitText then
    Exit;
  SetLength(Item.Params, Length(Item.Params) + 1);
  Item.Params[High(Item.Params)].Name := Name;
  Item.Params[High(Item.Params)].Value := Value;
end;

function XMLAddContent(Item: PXMLItem; Typ: TXMLItemType; Text: TString): PXMLItem;
begin
  if Item.Typ <> xitTag then
    Exit;
  SetLength(Item.Content, Length(Item.Content) + 1);
  New(Item.Content[High(Item.Content)]);
  Result := Item.Content[High(Item.Content)];
  Result.Typ := Typ;
  Result.Text := Text;
  SetLength(Result.Params, 0);
  SetLength(Result.Content, 0);
end;

procedure XMLClearRecursive(var Item: TXMLItem);
  var
    I: Integer;
begin
  for I := 0 to High(Item.Content) do begin
    XMLClearRecursive(Item.Content[I]^);
    Dispose(Item.Content[I]);
  end;
  SetLength(Item.Content, 0);
  SetLength(Item.Params, 0);
  Item.Text := '';
  Item.Typ := xitText;
end;}

{$IFNDEF FLAG_FPC}{$REGION 'TXMLItem'}{$ENDIF}
function TXMLItem.GetTextRecursively: TUnicode; 
begin
  Result := '';
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TXMLHeader'}{$ENDIF}
function TXMLHeader.GetParamValue(const Param: TString): TString;
begin
  Result := GetParamDef(Param, '');
end;

constructor TXMLHeader.Create;
begin
  FParams := TListOfXMLParam.Create;
end;

destructor TXMLHeader.Destroy;
begin
  FParams.Free;
end;

function TXMLHeader.GetParamDef(const Param, Def: TString): TString;
  var
    I: Integer;
begin
  for I := 0 to FParams.Last do
    if FParams[I].Name = Param then begin
      Result := FParams[I].Value;
      Exit;
    end;
  Result := Def;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TXMLTag'}{$ENDIF}
constructor TXMLTag.Create(const Name: TString);
begin
  inherited Create;
  FName := Name;
  FItems := TListOfXMLItem.Create;
end;

destructor TXMLTag.Destroy;
  var
    I: Integer;
begin
  for I := 0 to FItems.Last do
    FItems[I].Free;
  FItems.Free;
  inherited;
end;

function TXMLTag.GetText;
  var
    I: Integer;
begin
  Result := '';
  for I := 0 to FItems.Last do
    if FItems[I] is TXMLText then
      Result := Result + TXMLText(FItems[I]).Text;
end;

function TXMLTag.GetTextRecursively;
  var
    I: Integer;
begin
  Result := '';
  for I := 0 to FItems.Last do
    Result := Result + FItems[I].GetTextRecursively;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TXMLText'}{$ENDIF}
constructor TXMLText.Create(const Text: TUnicode);
begin
  inherited Create;
  FText := Text;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TXML'}{$ENDIF}
procedure TXML.AddError;
begin
  SetLength(FErrors, Length(FErrors) + 1);
  FErrors[High(FErrors)].Id := Id;
  FErrors[High(FErrors)].Str := Str;
  FErrors[High(FErrors)].LoadingInfo := LoadingInfo;
end;

function TXML.GetLastError: TXMLErrorInfo;
begin
  if IsLastError then begin
    Result := FErrors[High(FErrors)];
    SetLength(FErrors, Length(FErrors) - 1);
  end else begin
    Result.Id := XE_NO;
    Result.Str := '';
    Result.LoadingInfo.FileName := '';
    Result.LoadingInfo.Pos := 0;
    Result.LoadingInfo.Line := 0;
  end;
end;

function TXML.ReadByte(Data: TData; var LoadingInfo: TXMLLoadingInfo): Byte;
begin
  Result := Data.ReadByte;
  Inc(LoadingInfo.Pos);
  if Result = 13 then begin
    Inc(LoadingInfo.Line);
    LoadingInfo.Pos := 0;
  end;
end;

function TXML.ReadEncodedChar;
begin
  if FEncoding = 'utf-8' then begin
    Result := ReadUTF8Char(Data, C);
    if Result then begin
      Inc(LoadingInfo.Pos);
      if C = #13 then begin
        Inc(LoadingInfo.Line);
        LoadingInfo.Pos := 0;
      end;
    end else begin
      // TODO: error
      Error('xml: Incorrect symbol in file');
      AddError(
            XE_INCORRECT_UTF8_SYMBOL, 
            'incorrect utf8 symbol "' + C + '"',
            FLoadingInfo
          );
    end;
  end else begin
    C := TChar(ReadByte(Data, LoadingInfo));
    Result := True;
  end;
end;

constructor TXML.Create;
begin
  FHeader := TXMLHeader.Create;
  FRoot := TXMLTag.Create('');
end;

destructor TXML.Destroy;
begin
  FRoot.Free;
  FHeader.Free;
end;

function TXML.Load(FileName: TString): Boolean;
  label
    FreeAndExit;
  var
    Data: TData;
begin
  Result := False;

  Clear;

  FLoadingInfo.FileName := FileName;
  FLoadingInfo.Pos := 1;
  FLoadingInfo.Line := 1;

  Data := TData.Create(FileName);

  if not Data.Ready then begin
    Data.Free;
    AddError(
          XE_CANNOT_OPEN_FILE, 
          'cannot open file "' + FileName + '"',
          FLoadingInfo
        );
    Exit;
  end;

  if Load(Data) then
    Result := True;

FreeAndExit:
  Data.Free;
end;

function TXML.Load(Data: TData): Boolean; 
  var
    B: Byte;
    I: Integer;
    HeaderName: TString;
begin
  Result := False;

  FEncoding := 'cp1251';

  SkipSpaces(Data, FLoadingInfo);
  B := ReadByte(Data, FLoadingInfo);
  if B <> Ord('<') then begin
    AddError(
          XE_EXPECTED_TAG_OPEN, 
          'symbol "<" expected but "' + TChar(B) + '" found',
          FLoadingInfo
        );
    Exit;
  end;

  if ReadByte(Data, FLoadingInfo) = Ord('?') then begin
    if not ReadStr(Data, HeaderName, FLoadingInfo) then
      Exit;
    {if HeaderName <> 'xml' then
      Сомнительный файл;} 
    if not ReadParams(Data, FHeader, ['?'], FLoadingInfo) then
      Exit;
    ReadByte(Data, FLoadingInfo);
    B := ReadByte(Data, FLoadingInfo);
    if B <> Ord('>') then begin
      AddError(
            XE_EXPECTED_TAG_CLOSE, 
            'symbol ">" expected but "' + TChar(B) + '" found',
            FLoadingInfo
          );
      Exit
    end;
    SkipSpaces(Data, FLoadingInfo);
  end;

  for I := 0 to FHeader.Params.Last do
    if FHeader.Params[I].Name = 'encoding' then begin
      FEncoding := FHeader.Params[I].Value;
      Break;
    end;

  B := ReadByte(Data, FLoadingInfo);
  if B <> Ord('<') then begin
    AddError(
          XE_EXPECTED_TAG_OPEN, 
          'symbol "<" expected but "' + TChar(B) + '" found',
          FLoadingInfo
        );
    Exit;
  end;
  if Byte(Data.GetPtr^) = Ord('!') then
    Exit;
  if not ReadTag(Data, FRoot, FLoadingInfo) then
    Exit;
  Result := True;
end;

function TXML.Parse(Data: Pointer; Size: Integer): Boolean;
  var
    D: TData;
    LoadingInfo: TXMLLoadingInfo;
begin
  LoadingInfo.FileName := '<memory ' + IntToStr(Size) + ' bytes>';
  LoadingInfo.Pos := 1;
  LoadingInfo.Line := 1;

  D := TData.Create(Data, Size);
  if D.Ready then begin
    Result := ReadTag(D, FRoot, LoadingInfo);
  end else begin
    AddError(
          XE_CANNOT_CREATE_DATA, 
          'cannot create TData',
          LoadingInfo
        );
    Result := False;
  end;
  D.Free;
end;

procedure TXML.Save(FileName: TString);
begin
end;

procedure TXML.Clear;
begin
  FRoot.Free;
  FRoot := TXMLTag.Create('');
  FHeader.Params.Count := 0;
end;

procedure TXML.SkipSpaces;
begin
  while Byte(Data.GetPtr^) <= 32 do
    ReadByte(Data, LoadingInfo);
end;

function TXML.ReadParams;
  var
    Param: TXMLParam;
    B: Byte;
begin
  Result := False;
  SkipSpaces(Data, LoadingInfo);
  while not (TChar(Data.GetPtr^) in Finish) do begin
    Param.Name := '';
    while not (TChar(Data.GetPtr^) in [#0..#32, '=']) do
      Param.Name := Param.Name + TChar(ReadByte(Data, LoadingInfo));
    SkipSpaces(Data, LoadingInfo);
    B := ReadByte(Data, LoadingInfo);
    if B <> Ord('=') then begin
      AddError(
            XE_EXPECTED_PARAM_EQUAL, 
            'symbol "=" expected but "' + TChar(B) + '" found',
            LoadingInfo
          );
      Exit;
    end;
    SkipSpaces(Data, LoadingInfo);
    Param.Value := '';
    if TChar(Data.GetPtr^) = '"' then begin
      ReadByte(Data, LoadingInfo);
      while TChar(Data.GetPtr^) <> '"' do
        Param.Value := Param.Value + TChar(ReadByte(Data, LoadingInfo));
      ReadByte(Data, LoadingInfo);
    end else if TChar(Data.GetPtr^) = '''' then begin
      ReadByte(Data, LoadingInfo);
      while TChar(Data.GetPtr^) <> '''' do
        Param.Value := Param.Value + TChar(ReadByte(Data, LoadingInfo));
      ReadByte(Data, LoadingInfo);
    end else begin
      B := ReadByte(Data, LoadingInfo);
      AddError(
            XE_EXPECTED_PARAM_MARK, 
            'symbol " or '' expected but "' + TChar(B) + '" found',
            LoadingInfo
          );
      Exit;
    end;
    Item.Params.Add(Param);
    SkipSpaces(Data, LoadingInfo);
  end;
  Result := True;
end;

function TXML.ReadTag;
  var
    S: TString;
    B: Byte;
begin
  Result := False;
  SkipSpaces(Data, LoadingInfo);
  Item.FName := '';
  while not (TChar(Data.GetPtr^) in [#0..#32, '>', '/']) do
    Item.FName := Item.FName + TChar(ReadByte(Data, LoadingInfo));
  if not ReadParams(Data, Item, ['/', '>'], LoadingInfo) then
    Exit;
  B := ReadByte(Data, LoadingInfo);
  case B of
    Ord('/'): 
      begin
        B := ReadByte(Data, LoadingInfo); 
        if B <> Ord('>') then begin
          AddError(
                XE_EXPECTED_PARAM_MARK, 
                'symbol ">" expected but "' + TChar(B) + '" found',
                LoadingInfo
              );
          Exit;
        end;
      end;
    Ord('>'): 
      begin
        if not ReadContent(Data, Item, S, LoadingInfo) then
           Exit;
        if S <> Item.Name then begin
          AddError(
                XE_INCORRECT_CLOSETAG_NAME, 
                'close tag for "' + Item.Name + '" cannot be "' + S + '"',
                LoadingInfo
              );
          Exit;
        end;
      end;
  else
    AddError(
          XE_EXPECTED_TAG_CLOSE, 
          'symbol ">" or "/" expected but "' + TChar(B) + '" found',
          LoadingInfo
        );
    Exit;
  end;
  Result := True;
end;

function TXML.ReadContent;
  var
    B: Byte;
    Text: TString;
    Tag: TXMLTag;
    C: TUnicodeChar;
begin
  Result := False;
  SkipSpaces(Data, LoadingInfo);
  while True do begin
    Text := '';
    while TChar(Data.GetPtr^) <> '<' do begin
      if not ReadEncodedChar(Data, LoadingInfo, C) then
        Exit;
      Text := Text + C;
    end;
    if Text <> '' then
      Item.Items.Add(TXMLText.Create(Text));
    ReadByte(Data, LoadingInfo);
    if TChar(Data.GetPtr^) = '!' then begin
      ReadByte(Data, LoadingInfo);
      B := ReadByte(Data, LoadingInfo); 
      if B <> Ord('-') then begin
        AddError(
              XE_INCORRECT_COMMENT, 
              'incorrect comment, symbol "-" expected but "' + TChar(B) + '" found',
              LoadingInfo
            );
        Exit;
      end;
      if ReadByte(Data, LoadingInfo) <> Ord('-') then begin
        AddError(
              XE_INCORRECT_COMMENT, 
              'incorrect comment, symbol "-" expected but "' + TChar(B) + '" found',
              LoadingInfo
            );
        Exit;
      end;
      while ReadByte(Data, LoadingInfo) <> Ord('-') do;
      if ReadByte(Data, LoadingInfo) <> Ord('-') then begin
        AddError(
              XE_INCORRECT_COMMENT, 
              'incorrect comment, symbol "-" expected but "' + TChar(B) + '" found',
              LoadingInfo
            );
        Exit;
      end;
      if ReadByte(Data, LoadingInfo) <> Ord('>') then begin
        AddError(
              XE_EXPECTED_TAG_CLOSE, 
              'symbol ">" expected but "' + TChar(B) + '" found',
              LoadingInfo
            );
        Exit;
      end;
    end else if TChar(Data.GetPtr^) <> '/' then begin 
      Tag := TXMLTag.Create('');
      if not ReadTag(Data, Tag, LoadingInfo) then begin
        Tag.Free;
        Exit;
      end;
      Item.Items.Add(Tag);
    end else begin
      Text := '';
      ReadByte(Data, LoadingInfo);
      SkipSpaces(Data, LoadingInfo);
      while not (TChar(Data.GetPtr^) in [#0..#32, '>']) do
        Text := Text + TChar(ReadByte(Data, LoadingInfo));
      EndTag := Text;
      SkipSpaces(Data, LoadingInfo);
      B := ReadByte(Data, LoadingInfo);
      if B <> Ord('>') then begin
        AddError(
              XE_EXPECTED_TAG_CLOSE, 
              'symbol ">" expected but "' + TChar(B) + '" found',
              LoadingInfo
            );
        Exit;
      end;
      Break;
    end;
    SkipSpaces(Data, LoadingInfo);
  end;
  Result := True;
end;

function TXML.ReadStr;
begin
  S := '';
  while Byte(Data.GetPtr^) > 32 do
    S := S + TChar(ReadByte(Data, LoadingInfo));
  Result := True;
end;

function TXML.GetHeader;
begin
  Result := FHeader;
end;

function TXML.GetRoot;
begin
  Result := FRoot;
end;

function TXML.IsLastError: Boolean;
begin
  Result := Length(FErrors) > 0;
end;

procedure TXML.PrintErrorsToLog;
  var
    I: Integer;
begin
  for I := 0 to High(FErrors) do 
    with FErrors[I] do begin
      Log(LoadingInfo.FileName + '(' + 
          IntToStr(LoadingInfo.Line)  + ', ' + 
          IntToStr(LoadingInfo.Pos) + ') error $' +
          IntToHex(Id) + ': ' + 
          Str
         );
    end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

function XMLParamValue;
begin
  Result := Item.GetParamDef(Param, Def);
end;

{function XMLGetText(Item: PXMLItem): TString;
  var
    I: Integer;
begin
  Result := '';
  for I := 0 to High(Item^.Content) do
    with Item^.Content[I]^ do
      if Typ = xitText then
        Result := Result + Text;
end;}

procedure Test(const FileName: TString);
  var
    XML: TXML;
  procedure PrintToLog(const Pre: TString; Tag: TXMLTag);
    var
      I: Integer;
  begin
    for I := 0 to Tag.Params.Last do
      Log(Pre + '[' + Tag.Params[I].Name + '] = ' + Tag.Params[I].Value);
    for I := 0 to Tag.Items.Last do
      if Tag.Items[I] is TXMLText then
        Log(Pre + '@ ' + TXMLText(Tag.Items[I]).Text)
      else if Tag.Items[I] is TXMLTag then
        PrintToLog(Pre + '.' + TXMLTag(Tag.Items[I]).Name, TXMLTag(Tag.Items[I]))
  end;
begin
  XML := TXML.Create;
  if not XML.Load(FileName) then begin
    XML.PrintErrorsToLog;
  end else begin
    Log('[DXML.Test] Successful loaded "' + FileName + '"');
    PrintToLog('   xml', XML.Root);
  end;
  XML.Free;
end;

end.

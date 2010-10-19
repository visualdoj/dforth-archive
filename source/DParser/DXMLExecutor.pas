unit DXMLExecutor;

interface

uses
  DUtils,
  DDebug,
  DClasses,
  DXML;

const
  XMLEXE_MODE_INTO      = 1;
  XMLEXE_MODE_OUT       = 2;
  XMLEXE_MODE_BOTH      = XMLEXE_MODE_INTO or XMLEXE_MODE_OUT;

type
TXMLExecutor = class;

TXMLExeProc = procedure(Exe: TXMLExecutor; Item: TXMLItem; Into: Boolean) of object;
TXMLExeProcText = procedure (Exe: TXMLExecutor; Item: TXMLText) of object;

TXMLPare = record
  Tag: TString;
  Mode: Integer;
  case Integer of
    0: (Proc: TXMLExeProc);
    1: (ProcText: TXMLExeProcText);
end;

TXMLExecutor = class
private
  FTags: array of TXMLPare;
  FPushed: Integer;
public
  constructor Create;
  //      Добавляет функцию для обработки тега.
  //      Tag - название тега, для которого нужно вызывать Proc
  //      Proc - обработчик тега. В параметр этого обработчика передаются
  //         Exe - экзекутор, вызывавший функцию
  //         Item - тег, который нужно обработать
  //         Into - если выставлено True, то обработчик вызыван первый раз, 
  //                до обработки содержимого тега. Если Into = False - все Items тега
  //                обработаны 
  //      Mode - биты режима, могут содержать в себе
  //         XMLEXE_MODE_INTO - вызывать функцию до обработки Items
  //         XMLEXE_MODE_OUT - вызывать функцию после обработки Items
  //         XMLEXE_MODE_BOTH - вызывать функцию в обоих случаях
  //
  //      Внутри обработчика можно вызывать Proc. Однако, когд тег и все его подтеги будут
  //      обработаны, все добавленные обработчики будут автоматически удалены.
  procedure AddTag(Tag: TString; Proc: TXMLExeProc; Mode: Integer = XMLEXE_MODE_INTO);
  // Считывает все published-методы у Obj, начинающиеся с Pre, и вызывает для них AddTag
  procedure AddTagsFromObj(Obj: TObject; Pre: TString = 'XML');
  // Устанавливает дефолтный обработчик, который будет вызываться для тегов, для
  // которых именной обработчик не определен
  procedure SetDefault(Proc: TXMLExeProc);
  // Обработчик текста
  procedure SetOnText(Proc: TXMLExeProcText);
  // Выполнить
  procedure Execute(Item: TXMLItem); overload;
  procedure Execute(XML: TXML); overload;
  // 
  procedure Push;
  procedure Pop;
end;

function CommonLoadXML(Obj: TObject; const FileName: TString): Boolean;

implementation

const
  // Хочу хранить все обработчики в одном массиве.
  // И чтобы не было конфлиетов имен - выбрал такие вот имена для нетегов.
  // Они уж точно не могут быть названиями тегов :)
  XMLEXE_DEFAULTNAME: TString           = '<';
  XMLEXE_TEXTNAME: TString              = '>';          

{$IFNDEF FLAG_FPC}{$REGION 'TXMLExecutor'}{$ENDIF}
constructor TXMLExecutor.Create;
begin
  SetLength(FTags, 0);
  FPushed := -1;
end;

procedure TXMLExecutor.AddTag;
begin
  SetLength(FTags, Length(FTags) + 1);
  FTags[High(FTags)].Tag := Tag;
  FTags[High(FTags)].Proc := Proc;
  FTags[High(FTags)].Mode := Mode;
end;

procedure TXMLExecutor.AddTagsFromObj;
  var
    I: Integer;
    Table: TArrayOfMethodName;
begin
  Table := GetMethodArray(Obj);
  if Table = nil then
    Exit;
  for I := 0 to High(Table) do
    with Table[I] do
      if (Pos(Pre, Name) = 1) and
         (Length(Name) > Length(Pre)) then
         AddTag(Copy(Name, Length(Pre) + 1,
                       Length(Name) - Length(Pre)), TXMLExeProc(Method));
end;

procedure TXMLExecutor.SetDefault(Proc: TXMLExeProc);
begin
  AddTag(XMLEXE_DEFAULTNAME, Proc);
end;

procedure TXMLExecutor.SetOnText;
begin
  SetLength(FTags, Length(FTags) + 1);
  FTags[High(FTags)].Tag := XMLEXE_TEXTNAME;
  FTags[High(FTags)].ProcText := Proc;
end;

procedure TXMLExecutor.Execute(Item: TXMLItem);
  var
    I, J: Integer;
    Pushed: Integer;
    Executed: Boolean;
    Tag: TXMLTag absolute Item;
begin
  if Item is TXMLText then begin
    for I := High(FTags) downto 0 do
      if FTags[I].Tag = XMLEXE_TEXTNAME then begin
        FTags[I].Proc(Self, Item, True);
        Exit;
      end;
  end;
  if not (Item is TXMLTag) then
    Exit;
  Push;
  Pushed := FPushed;
  Executed := False;
  for I := High(FTags) downto 0 do
    if FTags[I].Tag = Tag.Name then begin
      if (FTags[I].Mode and XMLEXE_MODE_INTO > 0) then
        FTags[I].Proc(Self, Item, True);
      for J := 0 to Tag.Items.Last do
        Execute(Tag.Items[J]);
      if (FTags[I].Mode and XMLEXE_MODE_OUT > 0) then
        FTags[I].Proc(Self, Item, False);
      Executed := True;
      Break;
    end;
  if not Executed then
    for I := High(FTags) downto 0 do
      if FTags[I].Tag = XMLEXE_DEFAULTNAME then begin
        if (FTags[I].Mode and XMLEXE_MODE_INTO > 0) then
          FTags[I].Proc(Self, Item, True);
        for J := 0 to Tag.Items.Last do
          Execute(Tag.Items[J]);
        if (FTags[I].Mode and XMLEXE_MODE_OUT > 0) then
          FTags[I].Proc(Self, Item, False);
        Executed := True;
        Break;
      end;
  Pop;
  SetLength(FTags, Pushed + 1);
end;

procedure TXMLExecutor.Execute(XML: TXML);
begin
  Execute(XML.Root);
end;

procedure TXMLExecutor.Push;
begin
  FPushed := High(FTags);
end;

procedure TXMLExecutor.Pop;
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}


function CommonLoadXML;
  var
    XML: TXML;
    Exe: TXMLExecutor;
begin
  Result := False;
  XML := TXML.Create;
  if not XML.Load(FileName) then
    XML.PrintErrorsToLog
  else begin
    Exe := TXMLExecutor.Create;
    Exe.AddTagsFromObj(Obj);
    Exe.Execute(XML);
    Exe.Free;
    Result := True;
  end;
  XML.Free;
end;

end.

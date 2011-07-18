unit DVocabulary;

interface

uses
  {$I units.inc},
  DEmbroCore,
  DCommandsTable;

{
        vocabulary xxx                  создать новый словарь
        xxx                             положить в стек созданный ранее словарь
        voc.use ( v-)                   dup voc.push voc.target !
        ^^^                             voc.pop voc.top voc.target !
        voc.target> ( v-)     
        voc.>target ( v-)      
        voc.target@ ( v-)               

        voc.stack> ( v-)                положить в стек словарь
        voc.>stack ( -v)                извлечь верхний словарь
        voc.stack@ ( -v)                верхний элемент без извлечени€

        GLOBALS                         vGLOBALS voc.use
        LOCALS                          vLOCALS voc.use

        voc.header ( v-x)               создать новый xt-заголовок в словаре
        voc.header.setname ( px-)       установить им€ xt-заголовка
        voc.header.setdata ( ix-)       установить поле данных заголовка
}

type
  PVocItem = ^TVocItem;
  TVocItem = packed record
    Index: Integer; // индекс в таблице команд
    Next: PVocItem;
  end;

  PVoc = ^TVoc;
  TVoc = packed record
    sFIND: Integer;
    sNOTFOUND: Integer;
    Item: PVocItem;
    Time: Integer;
  end;

  function VocAdd(V: PVocItem; Index: Integer): PVocItem; overload;
  function VocDel(V: PVocItem; Marker: PVocItem): PVocItem; overload;
  procedure VocAdd(V: PVoc; Index: Integer); overload;
  procedure VocDel(V: PVoc; Marker: PVocItem); overload;
 
const
  DUPLICATE_ACTION_IGNORE       = 0;
  DUPLICATE_ACTION_EXCEPTION    = 1;
  DUPLICATE_ACTION_REWRITE      = 2;
  DUPLICATE_ACTION_CUSTOM       = 3;

type
  PVocabulary = ^TVocabulary;
  TVocabulary = object
   public
    FTable: PCommandsTable;
    FBlock: Pointer;
   private
    constructor Create(Table: PCommandsTable; EmbroBlock: Pointer);
    destructor Destroy;
    // ќбъ€вить команду без тела. ¬ будущем при определении команды
    // с таким же именем, тело будет подставлено в эту команду
    procedure DeclareForward(const Name: TString);
    // ƒобавить команду, сразу будет видна
    function AddCommand(const Name: TString): TXt;
    // Ќачать создание команды, извне сразу не видна
    function StartCommand(const Name: TString): TXt;
    // ќбновить команду, вызывать нужно при любом изменении Xt
    procedure UpdateCommand(Xt: TXt);
    // «авершить объ€вление команды, созданной раньше командой StartCommand
    procedure DoneCommand(Xt: TXt);
    // ”становить маркер
    procedure SetMarker;
    // —тереть все команды, созданные после маркера, с удалением их шитого кода
    procedure ForgetToMarker;
    // ”далить команду без удалени€ шитого кода
    procedure Forget(const Name: TString);
    // Ќайти последнюю созданную команду с заданным именем
    function Find(const Name: TString): TXt;
    // ¬ыделить Count данных
    procedure Allot(Count: Integer);
    // ¬озвращает указатель вершины шитого кода
    function Here: Pointer;
    // ”далить Count байт текущего слова
    procedure ClearCurrent(Count: Integer);
  end;

implementation

function VocAdd(V: PVocItem; Index: Integer): PVocItem;
begin
  New(Result);
  Result^.Index := Index;
  Result^.Next := V;
end;

function VocDel(V: PVocItem; Marker: PVocItem): PVocItem;
begin
  Result := V;
  while (Result <> nil) and (Result <> Marker) do begin
    Result := Result^.Next;
    Dispose(V);
    V := Result;
  end;
end;

procedure VocAdd(V: PVoc; Index: Integer);
begin
  V^.Item := VocAdd(V^.Item, Index);
end;

procedure VocDel(V: PVoc; Marker: PVocItem);
begin
  V^.Item := VocDel(V^.Item, Marker);
end;

{$IFNDEF FLAG_FPC}{$REGION 'TVocabulary'}{$ENDIF}
constructor TVocabulary.Create(Table: PCommandsTable; EmbroBlock: Pointer);
begin
  FTable := Table;
  FBlock := EmbroBlock;
end;

destructor TVocabulary.Destroy;
begin
end;

procedure TVocabulary.DeclareForward(const Name: TString);
begin
end;

function TVocabulary.AddCommand(const Name: TString): TXt;
begin
  Result := FTable.AddXt;
  Result^.Name := PAnsiChar(Name);
  // ....
end;

function TVocabulary.StartCommand(const Name: TString): TXt;
begin
  Result := FTable.AddXt;
end;

procedure TVocabulary.UpdateCommand(Xt: TXt);
begin
end;

procedure TVocabulary.DoneCommand(Xt: TXt);
begin
end;

procedure TVocabulary.SetMarker;
begin
end;

procedure TVocabulary.ForgetToMarker;
begin
end;

procedure TVocabulary.Forget(const Name: TString);
begin
end;

function TVocabulary.Find(const Name: TString): TXt;
begin
end;

procedure TVocabulary.Allot(Count: Integer);
begin
end;

function TVocabulary.Here: Pointer;
begin
end;

procedure TVocabulary.ClearCurrent(Count: Integer);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

unit DClasses;

interface

uses
  DUtils,
  DEvents;

type
TEntity = class
  procedure Render; virtual;
  procedure Update; virtual;
  procedure OnEvent(Event: TEvent); virtual;
end;

THandler = procedure of object;
THandlerEvent = procedure (ev: TEvent) of object;

TCommand = class
 protected
  procedure DoExecute; virtual;
 public
  procedure Execute;
end;

TCommandEvent = class(TCommand)
 private
  _ev: TEvent;
  _handler: THandlerEvent;
 protected
  procedure DoExecute; override;
 public
  constructor Create(ev: TEvent; handler: THandlerEvent);
  destructor Destroy; override;
end;

{$IFDEF FLAG_FPC}generic TPublisher<THandler> = class
 private var
  FHandlers: array of THandler;
 private
  function GetCount: Integer;
  function GetHandler(Index: Integer): THandler;
 public
  constructor Create;
  procedure Subscribe(Handler: THandler);
  procedure Unsubscribe(Handler: THandler);
  property Count: Integer read GetCount;
  property Handlers[Index: Integer]: THandler read GetHandler; default;
end;

TPublisherHandler = class(specialize TPublisher<THandler>)
 public
  procedure Invoke;
end;
{$ENDIF}

// генератор уникальных идентификаторов
TIDGenerator = class
 private
  FLastID: Cardinal;
 public
  constructor Create;
  function Gen: Cardinal;
end;

THandlerFreeNotifier = procedure (Notifier: TObject) of object;
TUnsibscribe = procedure (ID: Cardinal) of object;
TSubscribeOnFreeNotifier = procedure (
                                 ID: Cardinal;
                                 Handler: THandlerFreeNotifier
                               ) of object;

TNotifierService = record
  Notifier: TObject;
  ID: Cardinal;
  Unsibscribe: TUnsibscribe;
  SubscribeOnFreeNotifier: TSubscribeOnFreeNotifier;
end;

TNotifyManager = class
 private
  FServices: array of TNotifierService;
  procedure OnFreeNotifier(Notifier: TObject);
 protected
 public
  constructor Create;
  destructor Destroy; override;

  procedure Add(const Service: TNotifierService);
  // так же вызывается внутри деструктора, поэтому вызывать имеет смысл
  // если нужно переподписываться
  procedure Unsibscribe; overload;
  procedure Unsibscribe(Notifier: TObject); overload;
end;

{$IFDEF FLAG_FPC}generic{$ENDIF} TNotifierAccess<TParam> = class
 public type
  THandler = procedure (const Param: TParam) of object;
  TSubscribe = procedure (Handler: THandler) of object;
 var private
  FSubscribe: TSubscribe;
 public
  constructor Create(Subscribe: TSubscribe);
  procedure Subscribe(Handler: THandler);
end;

// Класс TNotifyManager сам разруливает систему отписываний
//OnOff: я тут кое-что поправил) надеюсь будет работать в fpc
{$IFDEF FLAG_FPC}generic{$ENDIF} TNotifier<T> = class
//  public
//    type
//      THandler = T;
      //TProcParamFree = procedure (Param: TParam);
      //TAccess = specialization TNotifierAccess<TParam>;
      {TEnumerator = class
       private
        function
      end;
      TAccess = }
  private
    type
      SomeRec = record
        ID: Cardinal;
        Handler: T;
        HandlerFreeNotifier: THandlerFreeNotifier;
      end;
    var
      FIDGenerator: TIDGenerator;
      FListeners: array of SomeRec;
      //FProcParamFree: TProcParamFree;
      procedure Unsubscribe(ID: Cardinal);
      procedure SubscribeOnFreeNotifier(ID: Cardinal; Handler:THandlerFreeNotifier);

      function GetCount: Integer;
      function GetHandler(Index: Integer): T;
  public
    constructor Create; overload;
    //constructor Create(ProcParamFree: TProcParamFree); overload;
    destructor Destroy; override;
    procedure Subscribe(Handler: T; Manager: TNotifyManager);
    property Count: Integer read GetCount;
    property Handlers[Index: Integer]: T read GetHandler; default;
    //procedure Send(const Param: TParam);
end;

TNotifierCommand = {$IFDEF FLAG_FPC}specialize{$ENDIF} TNotifier<TCommand>;

TMethodName = record
  Name: TString;
  Method: TMethod;
end;
TArrayOfMethodName = array of TMethodName;

procedure ObjectFree(Obj: TCommand);
function GetMethodArray(Obj: TObject): TArrayOfMethodName;
procedure FreeAndNil(var Obj);

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TEntity'}{$ENDIF}
procedure TEntity.Render;
begin
end;

procedure TEntity.Update;
begin
end;

procedure TEntity.OnEvent(Event: TEvent);
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TCommand'}{$ENDIF}
procedure TCommand.DoExecute;
begin
end;

procedure TCommand.Execute;
begin
  DoExecute;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TCommandEvent'}{$ENDIF}
procedure TCommandEvent.DoExecute;
begin
  if @_handler <> nil then
    _handler(_ev);
end;

constructor TCommandEvent.Create(ev: TEvent; handler: THandlerEvent);
begin
  _ev := ev;
  _handler := handler;
end;

destructor TCommandEvent.Destroy;
begin
  if _ev <> nil then
    _ev.Free;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TPublisher'}{$ENDIF}
{$IFDEF FLAG_FPC}
function TPublisher.GetCount: Integer;
begin
  Result := Length(FHandlers);
end;

function TPublisher.GetHandler(Index: Integer): THandler;
begin
  Result := FHandlers[Index];
end;

constructor TPublisher.Create;
begin
  SetLength(FHandlers, 0);
end;

procedure TPublisher.Subscribe(Handler: THandler);
  var
    I: Integer;
begin
  for I := 0 to Count - 1 do
    if @FHandlers[I] = @Handler then
      Exit;
  SetLength(FHandlers, Length(FHandlers) + 1);
  FHandlers[High(FHandlers)] := Handler;
end;

procedure TPublisher.Unsubscribe(Handler: THandler);
  var
    I: Integer;
begin
  for I := 0 to Count - 1 do
    if @FHandlers[I] = @Handler then begin
      FHandlers[I] := FHandlers[High(FHandlers)];
      SetLength(FHandlers, Length(FHandlers) - 1);
      Exit;
    end;
end;
{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TPublisherHandler'}{$ENDIF}
{$IFDEF FLAG_FPC}
procedure TPublisherHandler.Invoke;
  var
    I: Integer;
begin
  for I := 0 to Count - 1 do
    Handlers[I];
end;
{$ENDIF}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TIDGenerator'}{$ENDIF}
constructor TIDGenerator.Create;
begin
  FLastID := 0;
end;

function TIDGenerator.Gen: Cardinal;
begin
  Inc(FLastID);
  Result := FLastID;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TNotifyManager'}{$ENDIF}
procedure TNotifyManager.OnFreeNotifier(Notifier: TObject);
  var
    I: Integer;
begin
  I := 0;
  while I < Length(FServices) do 
    if FServices[I].Notifier = Notifier then begin
      FServices[I] := FServices[High(FServices)];
      SetLength(FServices, Length(FServices) - 1);
    end else
      Inc(I);
end;

procedure TNotifyManager.Add(const Service: TNotifierService);
begin
  SetLength(FServices, Length(FServices) + 1);
  FServices[High(FServices)] := Service;
  Service.SubscribeOnFreeNotifier(Service.ID, OnFreeNotifier);
end;

constructor TNotifyManager.Create;
begin
  SetLength(FServices, 0);
end;

destructor TNotifyManager.Destroy; 
begin
  Unsibscribe;
end;

procedure TNotifyManager.Unsibscribe;
  var
    I: Integer;
begin
  for I := 0 to High(FServices) do
    FServices[I].Unsibscribe(FServices[I].ID);
  SetLength(FServices, 0);
end;

procedure TNotifyManager.Unsibscribe(Notifier: TObject);
  var
    I: Integer;
begin
  I := 0;
  while I < Length(FServices) do
    if FServices[I].Notifier = Notifier then begin
      FServices[I].Unsibscribe(FServices[I].ID);
      FServices[I] := FServices[High(FServices)];
      SetLength(FServices, Length(FServices) - 1);
    end else
      Inc(I);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TNotifierAccess'}{$ENDIF}
constructor TNotifierAccess{$IFNDEF FLAG_FPC}<TParam>{$ENDIF}.Create(Subscribe: TSubscribe);
begin
  FSubscribe := Subscribe;
end;

procedure TNotifierAccess{$IFNDEF FLAG_FPC}<TParam>{$ENDIF}.Subscribe(Handler: THandler);
begin
  if @FSubscribe <> nil then
    FSubscribe(Handler);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TNotifier'}{$ENDIF}
procedure TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.Unsubscribe(ID: Cardinal);
  var
    I: Integer;
begin
  I := 0;
  while I < Length(FListeners) do
    if FListeners[I].ID = ID then begin
      FListeners[I] := FListeners[High(FListeners)];
      SetLength(FListeners, Length(FListeners) - 1);
    end else
      Inc(I);
end;

procedure TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.SubscribeOnFreeNotifier(ID: Cardinal; Handler:THandlerFreeNotifier);
  var
    I: Integer;
begin
  for I := 0 to High(FListeners) do
    if FListeners[I].ID = ID then
      FListeners[I].HandlerFreeNotifier := Handler;
end;

function TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.GetCount: Integer;
begin
  Result := Length(FListeners);
end;

function TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.GetHandler(Index: Integer): T;
begin
  Result := FListeners[Index].Handler;
end;

constructor TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.Create;
begin
  //Create(nil);
  FIDGenerator := TIDGenerator.Create;
end;

{constructor TNotifier.Create(ProcParamFree: TProcParamFree);
begin
  FProcParamFree := ProcParamFree;
  SetLength(FListeners, 0);
  FIDGenerator := TIDGenerator.Create;
end;}

destructor TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.Destroy;
  var
    I: Integer;
begin
  FIDGenerator.Free;
  for I := 0 to High(FListeners) do
    if @FListeners[I].HandlerFreeNotifier <> nil then
      FListeners[I].HandlerFreeNotifier(Self);
end;

procedure TNotifier{$IFNDEF FLAG_FPC}<T>{$ENDIF}.Subscribe(Handler: T; Manager: TNotifyManager);
  var
    Service: TNotifierService;
begin
  SetLength(FListeners, Length(FListeners) + 1);
  FListeners[High(FListeners)].ID := FIDGenerator.Gen;
  FListeners[High(FListeners)].Handler := Handler;
  FListeners[High(FListeners)].HandlerFreeNotifier := nil;

  if Manager <> nil then begin
    Service.Notifier := Self;
    Service.ID := FListeners[High(FListeners)].ID;
    Service.Unsibscribe := Unsubscribe;
    Service.SubscribeOnFreeNotifier := SubscribeOnFreeNotifier;
    Manager.Add(Service);
  end;
end;

{procedure TNotifier.Send(const Param: TParam);
  var
    I: Integer;
begin
  for I := 0 to High(FListeners) do
    FListeners[I].Handler(Param);
  if @FProcParamFree <> nil then
    FProcParamFree(Param);
end;}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

procedure ObjectFree;
begin
  Obj.Free;
end;

{$IFDEF FLAG_FPC}
  function GetMethodArray(Obj: TObject): TArrayOfMethodName;
    type
      tmethodnamerec = packed record
        name : pshortstring;
        addr : pointer;
      end;
      tmethodnametable = packed record
        count : Cardinal;
        entries : packed array[0..0] of tmethodnamerec;
      end;
      pmethodnametable =  ^tmethodnametable;
      var
        I: Integer;
        Table: PMethodNameTable;
  begin
    Table := pmethodnametable((Pointer(Obj.ClassType) + vmtMethodTable)^);
    SetLength(Result, Table^.Count);
    for I := 0 to High(Result) do begin
      Result[I].Name := Table^.entries[I].name^;
      Result[I].Method.Code := Table^.entries[I].addr;
      Result[I].Method.Data := Obj;
    end;
  end;
{$ELSE}
  function GetMethodArray(Obj: TObject): TArrayOfMethodName;
    type
      TMethodtableEntry = packed Record
        len: Word;
        addr: Pointer;
        name: ShortString;
      end;
    var
      pp: ^Pointer;
      pMethodTable: Pointer;
      pMethodEntry: ^TMethodTableEntry;
      i, numEntries: Word;
  begin
    pp := Pointer(Integer(Obj.ClassType) + vmtMethodtable);
    pMethodTable := pp^;
    if pMethodTable = nil then begin
      SetLength(Result, 0);
      Exit;
    end;
    SetLength(Result, PWord(pMethodTable)^);
    pMethodEntry := Pointer(Integer( pMethodTable ) + 2);
    for I := 0 to High(Result) do begin
      Result[I].Name := pMethodEntry.name;
      Result[I].Method.Code := pMethodEntry.addr;
      Result[I].Method.Data := Obj;
      pMethodEntry := Pointer(Integer( pMethodEntry ) + pMethodEntry^.len);
    end;
  end;
{$ENDIF}

//var
//  Commander: TNotifierCommand;

procedure FreeAndNil(var Obj);
  var
    Temp: TObject;
begin
  Temp := TObject(Obj);
  TObject(Obj) := nil;
  Temp.Free;
end;

initialization
//  Commander := TNotifierCommand.Create(ObjectFree);
end.

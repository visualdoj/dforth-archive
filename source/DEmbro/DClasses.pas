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

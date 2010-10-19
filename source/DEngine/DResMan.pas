unit DResMan;

interface

uses
  DUtils,
  DDebug;

type
TResource = class;
CResource = class of TResource;
TResMan = class;

TResource = class
 private
  FMan: TResMan;
  FID: TString;
  FRef: Integer;
  procedure IncRef;
  procedure DecRef;
 protected
  class function GetInstance(ID: TString; var Instance: TResource; Man: TResMan = nil): Boolean;
 public
  constructor Create(ID: TString; Man: TResMan); overload; virtual;
  class function Create(Man: TResMan = nil): TResource; overload;
  procedure Free;
  function CopyInstance: TResource;
  property Man: TResMan read FMan;
  property ID: TString read FID;
  property Ref: Integer read FRef;
end;
TListOfResource = {$IFDEF FLAG_FPC}specialize{$ENDIF} TList<TResource>;

TResMan = class
 private
  FResources: TListOfResource;
  procedure Add(Resource: TResource);
  procedure Del(Resource: TResource);
 public
  constructor Create;
  destructor Destroy; override;
  function Find(ID: TString): TResource;
end;

var
  Man: TResMan; // standart manager

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TResMan'}{$ENDIF}
constructor TResMan.Create;
begin
  FResources := TListOfResource.Create;
end;

destructor TResMan.Destroy;
begin
  FResources.Free;
end;

function TResMan.Find(ID: TString): TResource;
  var
    I: Integer;
begin
  for I := 0 to FResources.Last do
    if FResources[I].ID = ID then begin
      Result := FResources[I];
      Exit;
    end;
  Result := nil;
end;

procedure TResMan.Add(Resource: TResource);
begin
  FResources.Add(Resource);
  Added(Resource.ID);
end;

procedure TResMan.Del(Resource: TResource);
  var
    I: Integer;
begin
  for I := 0 to FResources.Last do
    if FResources[I] = Resource then begin
      FResources[I] := FResources[FResources.Last];
      FResources.Count := FResources.Count - 1;
      Deleted(Resource.ID);
      Exit;
    end;
end;

{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TResource'}{$ENDIF}
constructor TResource.Create(ID: TString; Man: TResMan);
begin
  FID := ID;
  FMan := Man;
  FRef := 0;
  FMan.Add(Self);
end;

procedure TResource.IncRef;
begin
  Inc(FRef);
end;

procedure TResource.DecRef;
begin
  Dec(FRef);
end;

class function TResource.GetInstance;
begin
  if Man = nil then
    Man := DResMan.Man;
  Instance := Man.Find(ID);
  Result := Instance = nil;
  if Result then
    Instance := Create(ID, Man);
  Instance.IncRef;
end;

class function TResource.Create(Man: TResMan = nil): TResource;
begin
  TResource.GetInstance(ClassName, Result, Man);
end;

procedure TResource.Free;
begin
  DecRef;
  if FRef <= 0 then begin
    FMan.Del(Self);
    inherited Free;
  end;
  Self := nil;
end;

function TResource.CopyInstance: TResource;
begin
  IncRef;
  Result := Self;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

initialization
  Man := TResMan.Create;
finalization
  Man.Free;
end.

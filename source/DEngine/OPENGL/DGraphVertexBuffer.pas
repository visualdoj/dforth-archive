unit DGraphVertexBuffer;

interface

uses
  GL,
  DGraph,
  DDebug,
  DUtils,
  DMath;

const
  // primitives types
  PT_POINTS             = GL_POINTS;
  PT_LINES              = GL_LINES;
  PT_TRIANGLES          = GL_TRIANGLES;
  PT_QUADS              = GL_QUADS;

  // index type
  IT_BYTE               = GL_UNSIGNED_BYTE;
  IT_WORD               = GL_UNSIGNED_SHORT;
  IT_CARDINAL           = GL_UNSIGNED_INT;

type
{$IFNDEF FLAG_FPC}{$REGION 'TVertexLayer'}{$ENDIF}
TVertexLayer = class
 protected
  FName: TString;
  FGroup: TString;
  FElementSize: Integer;
  FStart: Pointer;
  FStride: Integer;
  FCount: Integer;
  FReady: Boolean;
  FEnabled: Boolean;
  function GetElement(I: Integer): Pointer; //inline;
  procedure SetEnabled(TheEnabled: Boolean);
  procedure SetupLocation(Start: Pointer; Stride, Count: Integer);
  procedure Bind; virtual;
  procedure Unbind; virtual;

  property Stride: Integer read FStride;
 public
  constructor Create(const Name, Group: TString; ElementSize: Integer); overload;


  constructor Create; overload; virtual;
  class function GetElementSize: Integer; virtual;

  // јктивизаци€/деактивизаци€ сло€
  procedure Enable;
  procedure Disable;
  // «аписывать/считывать данные можно только после того, как
  // родительский буфер вызвал SetupLayers
  procedure WriteData(
        ElementStart: Integer; 
        ElementsCount: Integer;
        Data: Pointer;
        DataStride: Integer
      );
  procedure ReadData(
        ElementStart: Integer;
        ElementsCount: Integer;
        Data: Pointer;
        DataStride: Integer
      );
  // уникальное им€ сло€
  property Name: TString read FName;
  // слои одной группы не могут быть довалены в буфер
  property Group: TString read FGroup;
  // –азмер одного элемента
  property ElementSize: Integer read FElementSize;
  //  ол-во элементов
  property Count: Integer read FCount;
  // Ќужно ли слой биндить
  property Enabled: Boolean read FEnabled write SetEnabled;
  // √отов ли слой к записи вершин.
  property Ready: Boolean read FReady;
end;

CVertexLayer = class of TVertexLayer;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLayer2f'}{$ENDIF}
TLayer2f = class(TVertexLayer)
 public
  constructor Create(const Name, Group: TString); overload;
  constructor Create; overload; override;
  class function GetElementSize: Integer; override;
  function Get2f(Index: Integer): TVec2f;
  procedure Set2f(Index: Integer; const V: TVec2f);
  property Items[Index: Integer]: TVec2f read Get2f write Set2f; default;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLayerTexCoord2f'}{$ENDIF}
TLayerTexCoord2f = class(TLayer2f)
 protected
  procedure Bind; override;
  procedure Unbind; override;
 public
  constructor Create; override;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLayer3f'}{$ENDIF}
TLayer3f = class(TVertexLayer)
 public
  constructor Create(const Name, Group: TString); overload;
  constructor Create; overload; override;
  class function GetElementSize: Integer; override;
  function Get3f(Index: Integer): TVec3f;
  procedure Set3f(Index: Integer; const V: TVec3f);
  property Items[Index: Integer]: TVec3f read Get3f write Set3f; default;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TLayerCoord3f'}{$ENDIF}
TLayerCoord3f = class(TLayer3f)
 protected
  procedure Bind; override;
  procedure Unbind; override;
 public
  constructor Create; override;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TVertexBuffer'}{$ENDIF}
TVertexBuffer = class
 private
  //FSize: Cardinal;
  FCount: Integer;

  FLayers: array of TVertexLayer;
  
  FTaskLayers: array of TVertexLayer;
  FTaskCount: Integer;

  //FVertices2f: TLayer2f;
  //FVertices3f: TLayer3f;
  //FVertices4f: TLayer4f;
  FCoords3f: TLayerCoord3f;
  FTexCoords2f: TLayerTexCoord2f;
 public
  FData: Pointer;
  // Ќастройка слоев. 
  // „тобы изменени€ вступили в силу, нужно вызвать SetupLayers
  procedure ResetLayers;
  procedure AddLayer(Layer: TVertexLayer);
  procedure DelLayer(const Name: TString);
  procedure DelGroup(const Group: TString);
 
  procedure SetupLayers;
  // ¬озвращает слой по имени
  function GetLayer(const Name: TString): TVertexLayer;
  function GetGroup(Group: TString): TVertexLayer;

  procedure Bind;
  procedure Unbind;
  procedure RenderRange(Primitive, ElementStart, ElementsCount: Cardinal);

  property Layers[Group: TString]: TVertexLayer read GetGroup;
  property Count: Integer read FCount write FTaskCount;
  //property Vertices2f: TLayer2f;
  //property Vertices3f: TLayer3f;
  property Coords3f: TLayerCoord3f read FCoords3f;
  property TexCoords2f: TLayerTexCoord2f read FTexCoords2f;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TIndexBuffer'}{$ENDIF}
TIndexBuffer = class
 private
  FGraph: TGraph;
  FData: Pointer;
  FPrimitiveType: Cardinal;
  FVerticesPerPrimitive: Cardinal;
  FElementSize: Cardinal;
  FIndexType: Cardinal;
  FCount: Integer;
  function GetIndex(Index, Vertex: Cardinal): Pointer;
 public
  constructor Create(Graph: TGraph);
  procedure Setup(PrimitiveType, IndexType, PrimitivesCount: Cardinal);
  procedure WriteData(
        PrimitiveStart: Cardinal; // с какого примитива начать запись
        PrimitiveCount: Cardinal; // сколько примитивов считываютс€
        IndexType: Cardinal; // какой тип индексов в Data
        Data: Pointer // указатель на индексы нужного типа
      );
  procedure ReadData(
        PrimitiveStart: Cardinal;
        PrimitiveCount: Cardinal;
        IndexType: Cardinal;
        Data: Pointer
      );
  // Index - номер треугольника, Vertex - номер вершины 0..2
  function GetTriangleVertex(Index, Vertex: Cardinal): Cardinal;
  procedure SetTriangleVertex(Index, Vertex, Value: Cardinal);
  // — какого примитива начать, сколько примитивов вывести
  procedure Render(PrimitiveStart, PrimitivesCount: Cardinal);

  property Triangles[Index, Vertex: Cardinal]: Cardinal read GetTriangleVertex 
                                                        write SetTriangleVertex;
  // число примитивов
  property Count: Integer read FCount;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TVertexLayer'}{$ENDIF}
function TVertexLayer.GetElement(I: Integer): Pointer;
begin
  Result := @(PArrayOfByte(FStart)^[I*(FStride)]);
end;

procedure TVertexLayer.SetEnabled(TheEnabled: Boolean);
begin
  FEnabled := TheEnabled;
end;

procedure TVertexLayer.SetupLocation(Start: Pointer; Stride, Count: Integer);
begin
  FStart := Start;
  FStride := Stride;
  FCount := Count;
  FReady := (FStart <> nil) and (FCount > 0);
  FEnabled := FReady;
  
  Log('STRIDE: ' + IntToStr(FStride));
end;

procedure TVertexLayer.Bind;
begin
end;

procedure TVertexLayer.Unbind;
begin
end;

constructor TVertexLayer.Create(const Name, Group: TString; ElementSize: Integer);
begin
  FReady := False;
  FEnabled := False;
  FName := Name;
  FGroup := Group;
  FElementSize := ElementSize;
end;

constructor TVertexLayer.Create; 
begin
end;

class function TVertexLayer.GetElementSize: Integer; 
begin
  Result := 0;
end;

procedure TVertexLayer.Enable;
begin
  SetEnabled(True);
end;

procedure TVertexLayer.Disable;
begin
  SetEnabled(False);
end;

procedure TVertexLayer.WriteData(
      ElementStart: Integer; 
      ElementsCount: Integer;
      Data: Pointer;
      DataStride: Integer
    );
  var
    I: Integer;
begin
  if not FReady then
    Exit;
  if DataStride = 0 then
    DataStride := FElementSize;
  for I := 0 to ElementsCount - 1 do
    if (0 <= I + ElementStart) and (I + ElementStart < FCount) then begin
      Move(
             PArrayOfByte(Data)^[DataStride*I], 
             GetElement(ElementStart + I)^,
             FElementSize
           );
    end;
end;

procedure TVertexLayer.ReadData(
      ElementStart: Integer;
      ElementsCount: Integer;
      Data: Pointer;
      DataStride: Integer
    );
  var
    I: Integer;
begin
  if not FReady then
    Exit;
  if DataStride = 0 then
    DataStride := FElementSize;
  for I := 0 to ElementsCount - 1 do
    if (0 <= I + ElementStart) and (I + ElementStart < FCount) then begin
      Move(
             GetElement(ElementStart + I)^,
             PArrayOfByte(Data)^[DataStride*I], 
             FElementSize
           );
    end;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TLayer2f'}{$ENDIF}
constructor TLayer2f.Create(const Name, Group: TString);
begin
  inherited Create(Name, Group, SizeOf(Single)*2);
end;

constructor TLayer2f.Create; 
begin
end;

class function TLayer2f.GetElementSize: Integer;
begin
  Result := SizeOf(TVec2f);
end;

function TLayer2f.Get2f(Index: Integer): TVec2f;
begin
  //Result := TVec2f(GetElement(Index)^);
  Move(GetElement(Index)^, Result, ElementSize);
end;

procedure TLayer2f.Set2f(Index: Integer; const V: TVec2f);
begin
  Move(V, GetElement(Index)^, ElementSize);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TLayerTexCoord2f'}{$ENDIF}
procedure TLayerTexCoord2f.Bind;
begin
  glEnableClientState(GL_TEXTURE_COORD_ARRAY);
  glTexCoordPointer(2, GL_FLOAT, Stride, FStart);
end;

procedure TLayerTexCoord2f.Unbind;
begin
  glDisableClientState(GL_TEXTURE_COORD_ARRAY);
end;

constructor TLayerTexCoord2f.Create;
begin
  inherited Create('texcoord2f', 'texcoord');
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TLayer3f'}{$ENDIF}
constructor TLayer3f.Create(const Name, Group: TString);
begin
  inherited Create(Name, Group, SizeOf(Single)*3);
end;

constructor TLayer3f.Create;
begin
end;

class function TLayer3f.GetElementSize: Integer;
begin
  Result := SizeOf(TVec3f);
end;

function TLayer3f.Get3f(Index: Integer): TVec3f;
begin
  Result := TVec3f(GetElement(Index)^);
end;

procedure TLayer3f.Set3f(Index: Integer; const V: TVec3f);
begin
  TVec3f(GetElement(Index)^) := V;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TLayerCoord3f'}{$ENDIF}
procedure TLayerCoord3f.Bind;
begin
  glEnableClientState(GL_VERTEX_ARRAY);
  glVertexPointer(3, GL_FLOAT, Stride, FStart);
end;

procedure TLayerCoord3f.Unbind;
begin
  glDisableClientState(GL_VERTEX_ARRAY);
end;

constructor TLayerCoord3f.Create;
begin
  inherited Create('coord3f', 'coord');
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TVertexBuffer'}{$ENDIF}
procedure TVertexBuffer.ResetLayers;
begin
  SetLength(FTaskLayers, 0);
end;

procedure TVertexBuffer.AddLayer(Layer: TVertexLayer);
begin
  DelGroup(Layer.Group);
  SetLength(FTaskLayers, Length(FTaskLayers) + 1);
  FTaskLayers[High(FTaskLayers)] := Layer;
end;

procedure TVertexBuffer.DelLayer(const Name: TString);
  var
    I, J: Integer;
begin
  for I := 0 to High(FTaskLayers) do
    if FTaskLayers[I].Name = Name then begin
      for J := I to High(FTaskLayers) - 1 do
        FTaskLayers[J] := FTaskLayers[J + 1];
      SetLength(FTaskLayers, Length(FTaskLayers) - 1);
      Exit;
    end;
end;

procedure TVertexBuffer.DelGroup(const Group: TString);
  var
    I, J: Integer;
begin
  for I := 0 to High(FTaskLayers) do
    if FTaskLayers[I].Group = Group then begin
      for J := I to High(FTaskLayers) - 1 do
        FTaskLayers[J] := FTaskLayers[J + 1];
      SetLength(FTaskLayers, Length(FTaskLayers) - 1);
      Exit;
    end;
end;

procedure TVertexBuffer.SetupLayers;
  var
    I: Integer;
    VertexSize: Cardinal;
    Start: Integer;
begin
  if FData <> nil then
    FreeMem(FData);
  FCount := FTaskCount;
  VertexSize := 0;
  SetLength(FLayers, Length(FTaskLayers));
  for I := 0 to High(FLayers) do begin
    FLayers[I] := FTaskLayers[I];
    VertexSize := VertexSize + FLayers[I].ElementSize;
  end;
  GetMem(FData, FCount*VertexSize);
  Start := 0;

  Log('=====================');
  for I := 0 to High(FLayers) do begin
    FLayers[I].SetupLocation(
          @(PArrayOfByte(FData)^[Start]), 
          VertexSize, 
          FCount
        );
    Start := Start + FLayers[I].ElementSize;
    Log(FLayers[I].Name + ': group="' + FLayers[I].Group + '" ' + 
        IntToStr(Start));
    if FLayers[I].Name = 'coord3f' then begin
      FCoords3f := TLayerCoord3f(FLayers[I]);
    end;
    if FLayers[I].Name = 'texcoord2f' then begin
      FTexCoords2f := TLayerTexCoord2f(FLayers[I]);
    end;
  end;
end;

function TVertexBuffer.GetLayer;
  var
    I: Integer;
begin
  Result := nil;
  for I := 0 to High(FLayers) do
    if FLayers[I].Name = Name then begin
      Result := FLayers[I];
      Exit;
    end;
  Log('NOT FOUND');
end;

function TVertexBuffer.GetGroup;
begin
  Result := nil;
end;

procedure TVertexBuffer.Bind;
  var
    I: Integer;
begin
  for I := 0 to High(FLayers) do
    FLayers[I].Bind;
end;

procedure TVertexBuffer.Unbind;
  var
    I: Integer;
begin
  for I := 0 to High(FLayers) do
    FLayers[I].Unbind;
end;

procedure TVertexBuffer.RenderRange;
begin
  glDrawArrays(Primitive, ElementStart, ElementsCount);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TIndexBuffer'}{$ENDIF}
function TIndexBuffer.GetIndex(Index, Vertex: Cardinal): Pointer;
begin
  Result := @(PArrayOfByte(FData)^[(Index*FVerticesPerPrimitive + 
                                        Vertex) * FElementSize]);
end;

constructor TIndexBuffer.Create(Graph: TGraph);
begin
  FGraph := Graph;
end;

procedure TIndexBuffer.Setup(PrimitiveType, IndexType, PrimitivesCount: Cardinal);
begin
  if FData <> nil then
    FreeMem(FData);
  FPrimitiveType := PrimitiveType;
  FIndexType := IndexType;
  case FPrimitiveType of
    PT_TRIANGLES: FVerticesPerPrimitive := 3;
  end;
  case FIndexType of
    IT_BYTE: FElementSize := 1;
    IT_WORD: FElementSize := 2;
    IT_CARDINAL: FElementSize := 4;
  end;
  FCount := PrimitivesCount;
  GetMem(FData, FCount * FVerticesPerPrimitive * FElementSize);
end;

procedure TIndexBuffer.WriteData(
      PrimitiveStart: Cardinal; // с какого примитива начать запись
      PrimitiveCount: Cardinal; // сколько примитивов считываютс€
      IndexType: Cardinal; // какой тип индексов в Data
      Data: Pointer // указатель на индексы нужного типа
    );
  //var
  //  I: Integer;
begin
  Move(Data^, GetIndex(0, 0)^, FCount*3*SizeOf(Cardinal));
  Log('TIndexBuffer.WriteData');
  {for I := 0 to PrimitiveCount - 1 do
    Move(TArrayOfByte(Data^)[I*3*SizeOf(Cardinal)], 
         GetIndex(I, 0)^,
         3*SizeOf(Cardinal));}
end;

procedure TIndexBuffer.ReadData(
      PrimitiveStart: Cardinal;
      PrimitiveCount: Cardinal;
      IndexType: Cardinal;
      Data: Pointer
    );
begin
end;

function TIndexBuffer.GetTriangleVertex(Index, Vertex: Cardinal): Cardinal;
begin
  case FIndexType of
    IT_BYTE: Result := Byte(GetIndex(Index, Vertex)^);
    IT_WORD: Result := Word(GetIndex(Index, Vertex)^);
    IT_CARDINAL: Result := Cardinal(GetIndex(Index, Vertex)^);
  end;
end;

procedure TIndexBuffer.SetTriangleVertex(Index, Vertex, Value: Cardinal);
begin
  case FIndexType of
    IT_BYTE: Byte(GetIndex(Index, Vertex)^) := Value;
    IT_WORD: Word(GetIndex(Index, Vertex)^) := Value;
    IT_CARDINAL: Cardinal(GetIndex(Index, Vertex)^) := Value;
  end;
end;

procedure TIndexBuffer.Render(PrimitiveStart, PrimitivesCount: Cardinal);
begin
  glDrawElements(
        FPrimitiveType, 
        PrimitivesCount * FVerticesPerPrimitive, 
        FIndexType, 
        GetIndex(PrimitiveStart, 0)
      );
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

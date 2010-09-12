{
        Поддерживаются только несжатые 32битные tga!
}
unit DGraph;

interface

uses
  GL,
  GLU,
  GLext,
  DDebug,
  DUtils,
  DMath,
  DWinApi;

type
TSprite = class;
TGraph = class;

TTgaHeader = packed record
  idLength: Byte;
  colormapType: Byte;
  imageType: Byte;
  colormapIndex: Word;
  colormapLength: Word;
  colormapEntrySize: Byte;
  xOrigin: Word;
  yOrigin: Word;
  width: Word;
  height: Word;
  pixelSize: Byte;
  imageDesc: Byte;
end;

TProjMode = (pm2D, pm3D);
TBlendMode = (  
                bmNo, 
                bmAlpha, 
                bmMul, 
                bmAdd, 
                bmDiffuse, 
                bmAlphaAdd
             );

TTexture = Integer;
TTextureInfo = record
  FileName: string;
  Width, Height: Integer;
  ID: GLuint;
end;

TSprite = class
private
  FGraph: TGraph;
  FTex: TTexture;
  FFraWid: Integer;
  FFraHei: Integer;
  FFraStart: Integer;
  FFraCount: Integer;
  FFPS: Integer;
  FFrame: Integer;
  FAnimated: Boolean;
  FLooped: Boolean;
  FStart: Integer;
  FFinished: Boolean;
  FFlipX: Boolean;
  FFlipY: Boolean;
  procedure UpdateFrame;
public
  constructor Create(Graph: TGraph);
  procedure SetTexture(Tex: TTexture; FraWid, FraHei: Integer); overload;
  procedure SetTexture(Tex: string; FraWid, FraHei: Integer); overload;
  procedure SetFramesBlock(FraStart, FraCount: Integer);
  procedure SetFlip(X, Y: Boolean);
  procedure StartAnimation(Looped: Boolean);
  procedure StartStatic(Frame: Integer = 0);
  function Finished: Boolean;
  procedure Draw(Pos, Size: TVec2f; Angle: Single = 0);
  property Frame: Integer read FFrame;
  property FPS: Integer read FFPS write FFPS;
end;

// видовая матрица рендера
TModelView = class
 public
  procedure Load(const M: TMatrix4f);
  function Get: TMatrix4f;
  procedure LoadIdentity;
  procedure Translate(const V: TVec3f);
  // Угол в радианах!
  procedure Rotate(Angle: Single; const V: TVec3f);
  procedure Scale(const S: TVec3f);
  procedure Mul(const M: TMatrix4f);
end;

TGraph = class
private
  FWindow: TWindow;
  FTextures: array of TTextureInfo;
  FLineWidth: Single;
  FModelView: TModelView;
  function LoadTexture2DToGL(W, H: Integer; P: Pointer; Param: Integer = 0): GLuint;
  function LoadTga(var W, H: Integer; Data: TData): GLuint;
  function LoadBit(var W, H: Integer; Data: TData): GLuint;
  procedure SetVsync(VSync: Boolean);
  function GetVsync: Boolean;
  procedure SetDepthTest(DepthTest: Boolean);
public
  constructor Create(Window: TWindow);
  destructor Destroy; override;
  function GetScreenSize: TVec2f; inline;
  procedure BeginRender2D(Width, Height: Integer);
  procedure BeginRenderOrtho3d(Width, Height, zNear, zFar: Single);
  procedure BeginRender3D(FOV, Width, Height, zNear, zFar: Single);
  procedure Clear(R, G, B: Single; A: Single = 1);
  procedure EndRender;
  procedure SetBlendMode(Mode: TBlendMode);
  function LoadTex(FileName: string): TTexture;
  function TexWidth(Texture: TTexture): Integer;
  function TexHeight(Texture: TTexture): Integer;
  function GetTexFileName(Texture: TTexture): String;
  function CreateSprite: TSprite; inline;
  procedure SetPointSize(Size: Single); inline;
  procedure SetLineWidth(Width: Single); inline;
  procedure SetTexture(ID: TTexture);
  procedure SetColor(R, G, B, A: Single); inline;
  procedure Color4f(V: TVec4f); inline;
  procedure Vertex2f(V: TVec2f); inline;
  procedure Vertex3f(const V: TVec3f); inline;
  procedure TexCoord2f(V: TVec2f); inline; 
  procedure DrawLine(A, B: TVec2f); overload;
  procedure DrawLine(A, B: TVec3f); overload;
  procedure DrawRect(Pos, Size: TVec2f; Fill: Boolean = True); overload;
  procedure DrawRect(Rect: TRect; Fill: Boolean = True); overload;
  procedure DrawRect(Rect: TRect; C1, C2, C3, C4: TVec4f); overload;
  procedure DrawCircle(Pos: TVec2f; Rad: Single; Fill: Boolean = True);
  procedure DrawPolygon(const Vertices: array of TVec2f; Fill: Boolean = True);
  procedure DrawTexture(Rect: TRect); overload;
  procedure DrawTexture(Rect, TexRect: TRect); overload;
  procedure DrawTexture(Rect: TRect; FlipX, FlipY: Boolean); overload;
  procedure DrawTexture(Pos, Size: TVec2f; Angle: Single); overload;
  procedure DrawTiles(Rect: TRect; Tile: TVec2f);
  procedure DrawPixelsf(
                  Pos: TVec2f; 
                  Size: TVec2i; 
                  Pixels: Pointer
                );

  procedure BeginPolygon;
  procedure BeginQuads;
  procedure BeginTriangled;
  procedure EndPrimitives;

  procedure PushMatrix; inline;
  procedure PopMatrix; inline;
  procedure Translate(V: TVec2f); inline;
  procedure EnableScissor(Rect: TRect);
  procedure DisableScissor;
  //procedure DrawRect();
  property ScreenSize: TVec2f read GetScreenSize;
  property Vsync: Boolean read GetVsync write SetVsync;
  property ModelView: TModelView read FModelView;
  property DepthTest: Boolean write SetDepthTest;
end;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TSprite'}{$ENDIF}
//
//  TSprite//{{{
//
procedure TSprite.UpdateFrame;//{{{
  var
    Time: Integer;
begin
  FFinished := False;
  if FAnimated then begin
    Time := TUtils.GetTimer;
    FFrame := (Time - FStart) * Max(1, FFPS) div 1000;
    if FLooped then
      FFrame := FFraStart + FFrame mod FFraCount
    else begin
      FFinished := FFrame >= FFraCount; 
      FFrame := Min(FFraStart + FFrame, FFraStart + FFraCount - 1);
    end;
  end;
end;
//}}}
constructor TSprite.Create(Graph: TGraph);//{{{
begin
  FGraph := Graph;
  SetTexture(-1, 1, 1);
  FFPS := 30;
  FFlipX := False;
  FFlipY := False;
end;
//}}}
procedure TSprite.SetTexture(Tex: TTexture; FraWid, FraHei: Integer);//{{{
begin
  FTex := Tex;
  FFraWid := Max(1, FraWid);
  FFraHei := Max(1, FraHei);
  FFraStart := 0;
  FFraCount := FraWid * FraHei;
end;
//}}}
procedure TSprite.SetTexture(Tex: string; FraWid, FraHei: Integer);//{{{
begin
  SetTexture(FGraph.LoadTex(Tex), FraWid, FraHei);
end;
//}}}
procedure TSprite.SetFramesBlock(FraStart, FraCount: Integer);//{{{
begin
  FFraStart := FraStart;
  FFraCount := FraCount;
end;
//}}}
procedure TSprite.SetFlip(X, Y: Boolean);//{{{
begin
  FFlipX := X;
  FFlipY := Y;
end;
//}}}
procedure TSprite.StartAnimation(Looped: Boolean);//{{{
begin
  FLooped := Looped;
  FAnimated := True;
  FFrame := FFraStart;
  //FStart := TUtils.GetTimer;
end;
//}}}
procedure TSprite.StartStatic(Frame: Integer = 0);//{{{
begin
  FAnimated := False;
  FFrame := Frame;
end;
//}}}
function TSprite.Finished: Boolean;//{{{
begin
  UpdateFrame;
  Result := FFinished;
end;
//}}}
procedure TSprite.Draw(Pos, Size: TVec2f; Angle: Single = 0);//{{{
  var
    X, Y: Integer;
begin
  UpdateFrame;
  FGraph.SetTexture(FTex);
  Size := Size / 2;
  if FFlipX then
    Size.X := -Size.X;
  if FFlipY then
    Size.Y := -Size.Y; 
  X := FFrame mod FFraWid;
  Y := FFrame div FFraWid;
  glBegin(GL_QUADS);
    FGraph.TexCoord2f(Vec2f(X/FFraWid, Y/FFraHei));
    FGraph.Vertex2f(Pos + Vec2f(-Size.X, -Size.Y));
    FGraph.TexCoord2f(Vec2f((X+1)/FFraWid, Y/FFraHei));
    FGraph.Vertex2f(Pos + Vec2f( Size.X, -Size.Y));
    FGraph.TexCoord2f(Vec2f((X+1)/FFraWid, (Y+1)/FFraHei));
    FGraph.Vertex2f(Pos + Vec2f( Size.X,  Size.Y));
    FGraph.TexCoord2f(Vec2f(X/FFraWid, (Y+1)/FFraHei));
    FGraph.Vertex2f(Pos + Vec2f(-Size.X,  Size.Y));
  glEnd;
end;
//}}}
//}}}
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TModelView'}{$ENDIF}
procedure TModelView.Load(const M: TMatrix4f);
begin
  glLoadMatrixf(@M[0][0]);
end;

function TModelView.Get: TMatrix4f;
begin
  glGetFloatv(GL_MODELVIEW_MATRIX, @Result[0][0]);
end;

procedure TModelView.LoadIdentity;
begin
  glLoadIdentity;
end;

procedure TModelView.Translate(const V: TVec3f);
begin
  glTranslatef(V.X, V.Y, V.Z);
end;

procedure TModelView.Rotate(Angle: Single; const V: TVec3f);
begin
  glRotatef(Angle * 180 / pi, V.X, V.Y, V.Z);
end;

procedure TModelView.Scale(const S: TVec3f);
begin
  glScalef(S.X, S.Y, S.Z);
end;

procedure TModelView.Mul(const M: TMatrix4f);
begin
  glMultMatrixf(@M[0][0]);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TGraph'}{$ENDIF}
//
//  TGraph
//
function TGraph.GetScreenSize: TVec2f;
begin
  Result := FWindow.Size;
end;

function TGraph.LoadTexture2DToGL(W, H: Integer; P: Pointer;//{{{
                                  Param: Integer): GLuint;
begin
  glGenTextures(1, @Result);
  glBindTexture(GL_TEXTURE_2D, Result);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);							// set 1-byte alignment
  
  // set texture to repeat mode
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
  glTexParameteri ( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

  if (Param and 1) = 0 then  
    gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA8, W, H, GL_RGBA, 
                      GL_UNSIGNED_BYTE, P)
  else
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, W, H, 0, GL_RGBA, 
                 GL_UNSIGNED_BYTE, P);

  if (Param and 1) = 0 then begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);    
  end else begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  end;
end;
//}}}
function TGraph.LoadTga(var W, H: Integer; Data: TData): GLuint;//{{{
  var
    Header: TTgaHeader;
    I, J, Y: Integer;
    Texels: array of array[0..3] of Byte;
    Inv: Boolean;
begin
  Data.ReadVar(@Header, SizeOf(Header));
  W := Header.Width;
  H := Header.Height;
  SetLength(Texels, W*H);
  //Data.SeekAbs(SizeOf(Header));// + Header.idLength);
  Inv := Header.imageDesc and $20 = 0;
  for J := 0 to H - 1 do
    for I := 0 to W - 1 do begin
      if Inv then
        Y := H - 1 - J
      else
        Y := H;
      Texels[Y*W + I][2] := Data.ReadByte;
      Texels[Y*W + I][1] := Data.ReadByte;
      Texels[Y*W + I][0] := Data.ReadByte;
      Texels[Y*W + I][3] := Data.ReadByte;
    end;
  Result := LoadTexture2DToGL(W, H, @Texels[0]);
end;
//}}}
function TGraph.LoadBit(var W, H: Integer; Data: TData): GLuint;//{{{
  var
    Tex: array of array[0..3] of Byte;
    I, J: Integer;
    B: Byte;
begin
  W := Data.ReadInt;
  H := Data.ReadInt;
  Data.ReadInt;
  SetLength(Tex, W*H);
  for I := 0 to W*H div 8 - 1 do begin
    B := Data.ReadByte;
    for J := 0 to 7 do begin
      Tex[I*8 + J][0] := 255;// * Ord(B and (1 shl J) > 0);
      Tex[I*8 + J][1] := 255;// * Ord(B and (1 shl J) > 0);
      Tex[I*8 + J][2] := 255;// * Ord(B and (1 shl J) > 0);
      Tex[I*8 + J][3] := 255 * Ord(B and (1 shl J) > 0);
    end;
  end;
  Result := LoadTexture2DToGL(W, H, @Tex[0][0], 0);
end;

//}}}
procedure TGraph.SetVsync(VSync: Boolean);//{{{
begin
  if WGL_EXT_swap_control then
    wglSwapIntervalEXT(Ord(VSync));
end;

//}}}
function TGraph.GetVsync: Boolean;//{{{
begin
  Result := False;
  if WGL_EXT_swap_control then
    Result := wglGetSwapIntervalEXT = 0;
end;

procedure TGraph.SetDepthTest(DepthTest: Boolean);
begin
  if DepthTest then
    glEnable(GL_DEPTH_TEST)
  else
    glDisable(GL_DEPTH_TEST);
end;
//}}}
constructor TGraph.Create(Window: TWindow);//{{{
begin
  FWindow := Window;
  FLineWidth := 1;
  glShadeModel(GL_SMOOTH);  
  FModelView := TModelView.Create;
  LoadExtensions;
  VSync := False;
end;

destructor TGraph.Destroy; 
begin
  FModelView.Free;
end;

//}}}
procedure TGraph.BeginRender2D(Width, Height: Integer);//{{{
begin 
  glViewPort(0, 0, Width, Height);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  glOrtho(0, Width, Height, 0, -1, 1);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;
//}}}
procedure TGraph.BeginRenderOrtho3d(Width, Height, zNear, zFar: Single);
begin
  glViewPort(0, 0, Round(ScreenSize.X), Round(ScreenSize.Y));

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  glOrtho(-Width/2, Width/2, Height/2, -Height/2, zNear, zFar);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure TGraph.BeginRender3D(FOV, Width, Height, zNear, zFar: Single);
begin
  glViewPort(0, 0, Round(Width), Round(Height));

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(FOV, Width/Height, zNear, zFar);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure TGraph.Clear(R, G, B: Single; A: Single = 1);//{{{
begin
  glClearColor(R, G, B, A);
  glClear(GL_COLOR_BUFFER_BIT);
end;
//}}}
procedure TGraph.EndRender;//{{{
begin
  //FWindow.SwapBuffers;
  glFlush;
  glFinish;
end;
//}}}
procedure TGraph.SetBlendMode(Mode: TBlendMode);//{{{
begin
  if Mode = bmNo then
    glDisable(GL_BLEND)
  else begin
    glEnable(GL_BLEND);
      Case Mode of
        bmAlpha:    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        bmMul:      glBlendFunc(GL_ZERO,      GL_SRC_COLOR);
        bmAdd:      glBlendFunc(GL_ONE,       GL_ONE);
        bmDiffuse:  glBlendFunc(GL_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR);
        bmAlphaAdd: glBlendFunc(GL_SRC_ALPHA, GL_ONE);
      end;
  end;
end;
//}}}
function TGraph.LoadTex(FileName: string): TTexture;//{{{
  var
    Data: TData;    
begin
  Result := 0;
  Assert(FileExist(FileName), '[TGraph.LoadText] file not exists');
  while (Result < Length(FTextures)) do 
    if FTextures[Result].FileName = FileName then
      Exit
    else
      Inc(Result); 

  SetLength(FTextures, Length(FTextures) + 1);
  Result := High(FTextures);
  FTextures[Result].FileName := FileName;

  Log('reading data from ' + FileName);
  Data := TData.Create(FileName);
  with FTextures[Result] do
    if Pos('.bit', FileName) = Length(FileName) - 3 then
      ID := LoadBit(Width, Height, Data)
    else
      ID := LoadTga(Width, Height, Data);
  Data.Free;
  SDebug.Added(ToStr([
                     'TTex file="', FileName, '" '
                     ]));
end;
//}}}
function TGraph.TexWidth(Texture: TTexture): Integer;//{{{
begin
  Result := FTextures[Texture].Width;
end;

//}}}
function TGraph.TexHeight(Texture: TTexture): Integer;//{{{
begin
  Result := FTextures[Texture].Height;
end;

//}}}
function TGraph.GetTexFileName;//{{{
begin
  Result := FTextures[Texture].FileName;
end;
//}}}
function TGraph.CreateSprite: TSprite;//{{{
begin
  Result := TSprite.Create(Self);
end;
//}}}
procedure TGraph.SetPointSize(Size: Single); //{{{
begin
  glPointSize(Size);
end;
//}}}
procedure TGraph.SetLineWidth(Width: Single); //{{{
begin
  glLineWidth(Width);
  FLineWidth := Width;
end;
//}}}
procedure TGraph.SetTexture(ID: TTexture);//{{{
begin
  if (0 <= ID) and (ID < Length(FTextures)) then begin
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, FTextures[ID].ID);
  end else
    glDisable(GL_TEXTURE_2D); 
end;
//}}}
procedure TGraph.SetColor(R, G, B, A: Single);//{{{
begin
  glColor4f(R, G, B, A);
end;
//}}}
procedure TGraph.Color4f(V: TVec4f); //{{{
begin
  //glColor4fv(@V);
  glColor4f(V.X, V.Y, V.Z, V.W);
end;
//}}}
procedure TGraph.Vertex2f(V: TVec2f);//{{{
begin
  glVertex2fv(@V);
end;
//}}}
procedure TGraph.Vertex3f(const V: TVec3f);
begin
  glVertex3fv(@V);
end;

procedure TGraph.TexCoord2f(V: TVec2f);//{{{
begin
  glTexCoord2fv(@V);
end;
//}}}
procedure TGraph.DrawLine(A, B: TVec2f);//{{{
begin
  glBegin(GL_LINES);
    Vertex2f(A);
    Vertex2f(B);
  glEnd;
end;
//}}}
procedure TGraph.DrawLine(A, B: TVec3f); 
begin
  glBegin(GL_LINES);
    glVertex3fv(@A);
    glVertex3fv(@B);
  glEnd;
end;

procedure TGraph.DrawRect(Pos, Size: TVec2f; Fill: Boolean = True);//{{{
begin
  Pos := Pos + Vec2f(0.5, 0.5);
  Size := Size + Vec2f(0.0, 0.5);
  if Fill then begin
    glBegin(GL_QUADS);
    Vertex2f(Pos);
    Vertex2f(Pos + Vec2f(Size.X, 0));
    Vertex2f(Pos + Size);
    Vertex2f(Pos + Vec2f(0, Size.Y));
  end else begin
    glBegin(GL_LINES);
    Vertex2f(Pos + Vec2f(0, FLineWidth/2));
    Vertex2f(Pos + Vec2f(Size.X, 0) + Vec2f(0, FLineWidth/2));

    Vertex2f(Pos + Vec2f(Size.X, 0) + Vec2f(-FLineWidth/2, 0));
    Vertex2f(Pos + Size + Vec2f(-FLineWidth/2, 0));

    Vertex2f(Pos + Size + Vec2f(0, -FLineWidth/2));
    Vertex2f(Pos + Vec2f(0, Size.Y) + Vec2f(0, -FLineWidth/2));

    Vertex2f(Pos + Vec2f(0, Size.Y) + Vec2f({FLineWidth/2}0, 0));
    Vertex2f(Pos + Vec2f({FLineWidth/2}0, -1));
  end;
  glEnd;
end;
//}}}
procedure TGraph.DrawRect(Rect: TRect; Fill: Boolean = True);//{{{
begin
  DrawRect(Rect.A, Rect.B - Rect.A, Fill);
end;

//}}}
procedure TGraph.DrawRect(Rect: TRect; C1, C2, C3, C4: TVec4f);//{{{
begin
  glBegin(GL_QUADS);
    Color4f(C1);
    Vertex2f(Rect.A);
    Color4f(C2);
    Vertex2f(Vec2f(Rect.B.X, Rect.A.Y));
    Color4f(C3);
    Vertex2f(Rect.B);
    Color4f(C4);
    Vertex2f(Vec2f(Rect.A.X, Rect.B.Y));
  glEnd;
end;

//}}}
procedure TGraph.DrawCircle;//{{{
  var
    Segments, Angle: Integer;
    K: Single;
begin
  Segments := Round(Abs(6*Rad)); 
  K := 2*pi/Segments;
  if Fill then
    glBegin(GL_POLYGON)
  else
    glBegin(GL_LINE_LOOP);
  for Angle := 0 to Segments - 1 do
    Vertex2f(Pos + Rad * Vec2f(Cos(Angle*K), Sin(Angle*K)));
  glEnd;
end;
//}}}
procedure TGraph.DrawPolygon;//{{{
  var
    I: Integer;
begin
  if Fill then
    glBegin(GL_POLYGON)
  else
    glBegin(GL_LINE_LOOP);
  for I := 0 to High(Vertices) do
    Vertex2f(Vertices[I]);
  glEnd;
end;

//}}}
procedure TGraph.DrawTexture(Rect: TRect);//{{{
begin
  glBegin(GL_QUADS);
    TexCoord2f(Vec2f(0, 0));
    Vertex2f(Vec2f(Rect.A.X, Rect.A.Y));
    TexCoord2f(Vec2f(1, 0));
    Vertex2f(Vec2f(Rect.B.X, Rect.A.Y));
    TexCoord2f(Vec2f(1, 1));
    Vertex2f(Vec2f(Rect.B.X, Rect.B.Y));
    TexCoord2f(Vec2f(0, 1));
    Vertex2f(Vec2f(Rect.A.X, Rect.B.Y));
  glEnd;
end;

//}}}
procedure TGraph.DrawTexture(Rect, TexRect: TRect);//{{{
begin
  glBegin(GL_QUADS);
    TexCoord2f(Vec2f(TexRect.A.X, TexRect.A.Y));
    Vertex2f(Vec2f(Rect.A.X, Rect.A.Y));
    TexCoord2f(Vec2f(TexRect.B.X, TexRect.A.Y));
    Vertex2f(Vec2f(Rect.B.X, Rect.A.Y));
    TexCoord2f(Vec2f(TexRect.B.X, TexRect.B.Y));
    Vertex2f(Vec2f(Rect.B.X, Rect.B.Y));
    TexCoord2f(Vec2f(TexRect.A.X, TexRect.B.Y));
    Vertex2f(Vec2f(Rect.A.X, Rect.B.Y));
  glEnd;
end;

//}}}
procedure TGraph.DrawTexture(Rect: TRect; FlipX, FlipY: Boolean); 
begin
  glBegin(GL_QUADS);
    TexCoord2f(Vec2f(Ord(FlipX), Ord(FlipY)));
    Vertex2f(Vec2f(Rect.A.X, Rect.A.Y));
    TexCoord2f(Vec2f(Ord(not FlipX), Ord(FlipY)));
    Vertex2f(Vec2f(Rect.B.X, Rect.A.Y));
    TexCoord2f(Vec2f(Ord(not FlipX), Ord(not FlipY)));
    Vertex2f(Vec2f(Rect.B.X, Rect.B.Y));
    TexCoord2f(Vec2f(Ord(FlipX), Ord(not FlipY)));
    Vertex2f(Vec2f(Rect.A.X, Rect.B.Y));
  glEnd;
end;

procedure TGraph.DrawTexture(Pos, Size: TVec2f; Angle: Single); 
  var
    S, C: Single;
begin
  with Pos do begin
    S := Sin(Angle - pi);
    C := Cos(Angle - pi);
    glBegin(GL_QUADS);
      TexCoord2f(Vec2f(0, 0));
      Vertex2f(Vec2f(X + (+C*Size.X/2-S*Size.Y/2), Y + (+S*Size.X/2+C*Size.Y/2)));
      TexCoord2f(Vec2f(1, 0));
      Vertex2f(Vec2f(X + (-C*Size.X/2-S*Size.Y/2), Y + (-S*Size.X/2+C*Size.Y/2)));
      TexCoord2f(Vec2f(1, 1));
      Vertex2f(Vec2f(X + (-C*Size.X/2+S*Size.Y/2), Y + (-S*Size.X/2-C*Size.Y/2)));
      TexCoord2f(Vec2f(0, 1));
      Vertex2f(Vec2f(X + (+C*Size.X/2+S*Size.Y/2), Y + (+S*Size.X/2-C*Size.Y/2)));
    glEnd;
  end;
end;

procedure TGraph.DrawTiles(Rect: TRect; Tile: TVec2f);//{{{
  var
    Size: TVec2f;
begin
  Size := Rect.B - Rect.A;
  if Abs(Size.X) < EPS then
    Size.X := 1;
  if Abs(Size.Y) < EPS then
    Size.Y := 1;
  Size := Vec2f(Size.X/Tile.X, Size.Y/Tile.Y);
  glBegin(GL_QUADS);
    TexCoord2f(Vec2f(0, 0));
    Vertex2f(Vec2f(Rect.A.X, Rect.A.Y));
    TexCoord2f(Vec2f(Size.X, 0));
    Vertex2f(Vec2f(Rect.B.X, Rect.A.Y));
    TexCoord2f(Vec2f(Size.X, Size.Y));
    Vertex2f(Vec2f(Rect.B.X, Rect.B.Y));
    TexCoord2f(Vec2f(0, Size.Y));
    Vertex2f(Vec2f(Rect.A.X, Rect.B.Y));
  glEnd;
end;

procedure TGraph.DrawPixelsf(
                Pos: TVec2f; 
                Size: TVec2i; 
                Pixels: Pointer
              );
begin
  glRasterPos2f(Pos.X, FWindow.Size.Y - Pos.Y);
  glDrawPixels(
        Size.X, Size.Y,
        GL_RGBA,
        GL_FLOAT,
        Pixels
      );
end;

//}}}

procedure TGraph.BeginPolygon;
begin
  glBegin(GL_POLYGON);
end;

procedure TGraph.BeginQuads;
begin
  glBegin(GL_QUADS);
end;

procedure TGraph.BeginTriangled;
begin
  glBegin(GL_TRIANGLES);
end;

procedure TGraph.EndPrimitives;
begin
  glEnd;
end;

procedure TGraph.PushMatrix;//{{{
begin
  glPushMatrix;
end;
//}}}
procedure TGraph.PopMatrix;//{{{
begin
  glPopMatrix;
end;
//}}}
procedure TGraph.Translate(V: TVec2f);//{{{
begin
  glTranslatef(V.X, V.Y, 0.0);
end;
//}}}
procedure TGraph.EnableScissor(Rect: TRect);
begin
  glEnable(GL_SCISSOR_TEST);
  glScissor(Round(Rect.A.X), 
            Round(ScreenSize.Y - Rect.B.Y), 
            Round(Rect.B.X - Rect.A.X), 
            Round(Rect.B.Y - Rect.A.Y));
end;

procedure TGraph.DisableScissor;
begin
  glDisable(GL_SCISSOR_TEST);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

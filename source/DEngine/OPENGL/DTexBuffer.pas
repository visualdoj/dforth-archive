{TODO: Необходимо написать поддержку 1D текстур}
unit DTexBuffer;

interface

uses
  Windows,
  GL,
  GLext,
  // SysUtils,
  
  DDebug,
  DUtils,
  DGraph;

const
  // Какие фитчи нужны буфферу
  TB_Alpha      = 1;
  TB_Depth      = 2;
  TB_Stencil    = 4;
  TB_Texture1D  = 8;
  TB_Texture2D  = 16;
  TB_MipMap     = 32;

type
TTexBuffer = class
private
  // размеры могут отличаться от переданных в конструктор
  FWidth: Integer; // ширина буффера
  FHeight: Integer; // высота
  FMode: Integer; // режим
  FReady: Boolean; // готов ли биффер к бою
  FBinded: Boolean; // выставлен ли данный буффер в качестве текущей текстуры
  FRendering: Boolean; // происходит ли рендер в этот буффер

  FDC: HDC; // контекст устройства
  FGLRC: HGLRC; // контекст рендера
  FPBuffer: THandle; // PBuffer идентификатор в OpenGL
  FSavedDC: HDC; // сохраняем текущий DC во время рендера в буффер
  FSavedGLRC: HGLRC; // сохраняем GLRC во время рендера в буффер
  FTarget: GLenum; // тип текстуры - GL_TEXTURE2D/GL_TEXTURE_1D
  FTexture: GLuint; // идентификатор текстуры в OpenGL
public
  constructor Create(Graph: TGraph; Width, Height: Integer; Mode: Integer);
  destructor Destroy; override;
  class function GetSupported: Boolean; // инициализирует расширение
  procedure Bind(Buf: Integer = WGL_FRONT_LEFT_ARB); // установить текстуру
  procedure Unbind(Buf: Integer = WGL_FRONT_LEFT_ARB); // снять текстуру
  procedure StartRender; // начать рендер в буффер
  procedure FinishRender; // завершить рендер в буффер
  property Supported: Boolean read GetSupported;
  property Width: Integer read FWidth;
  property Height: Integer read FHeight;
  property Ready: Boolean read FReady;
  property Binded: Boolean read FBinded;
  property Rendering: Boolean read FRendering;
end;

implementation

var
  CheckedSupported: Integer = -1;

constructor TTexBuffer.Create;
  var
    CurDC: HDC;
    CurGLRC: HGLRC;
    Format: Integer;
    NumFormats: Integer;

    IntAttrs: Array of Integer;
    //Props: Array of Integer;
    FloatAttrs: Array[0..1] Of Single;
    PixelFormats: Array[0..19] of Integer;

    procedure AddAttr(Param, Value: Integer);
    begin
      SetLength(IntAttrs, Length(IntAttrs) + 2);
      IntAttrs[High(IntAttrs) - 1] := Param;
      IntAttrs[High(IntAttrs)    ] := Value;
    end;
    procedure MakeIntAttrs;
    begin
      SetLength(IntAttrs, 0);
      AddAttr(WGL_SUPPORT_OPENGL_ARB, GL_TRUE);
      AddAttr(WGL_DRAW_TO_PBUFFER_ARB, GL_TRUE);
      AddAttr(WGL_PIXEL_TYPE_ARB, WGL_TYPE_RGBA_ARB);
      AddAttr(WGL_RED_BITS_ARB, 8);
      AddAttr(WGL_GREEN_BITS_ARB, 8);
      AddAttr(WGL_BLUE_BITS_ARB, 8);
      AddAttr(WGL_DOUBLE_BUFFER_ARB, GL_TRUE);
      if (FMode and TB_Alpha) > 0 then 
        AddAttr(WGL_ALPHA_BITS_ARB, 8);
      if (FMode and TB_Depth) > 0 then 
        AddAttr(WGL_DEPTH_BITS_ARB, 24);
      if (FMode and TB_Stencil) > 0 then 
        AddAttr(WGL_STENCIL_BITS_ARB, 8);
      if (FMode and (TB_Texture1D or TB_Texture2D)) > 0 then
        if (FMode and TB_Alpha) > 0 then
          AddAttr(WGL_BIND_TO_TEXTURE_RGBA_ARB, GL_TRUE)
        else
          AddAttr(WGL_BIND_TO_TEXTURE_RGB_ARB, GL_TRUE);
      AddAttr(0, 0);
    end;
    procedure MakeProps;
    begin
      SetLength(IntAttrs, 0);
      if (FMode and (TB_Texture1D or TB_Texture2D)) > 0 then
        if (FMode and TB_Alpha) > 0 then
	  AddAttr(WGL_TEXTURE_FORMAT_ARB,  WGL_TEXTURE_RGBA_ARB)
        else
	  AddAttr(WGL_TEXTURE_FORMAT_ARB,  WGL_TEXTURE_RGB_ARB);
      if (FMode and TB_Texture1D) > 0 then begin
        FTarget := GL_TEXTURE_1D;
	AddAttr(WGL_TEXTURE_TARGET_ARB, WGL_TEXTURE_1D_ARB);
      end else if (FMode and TB_Texture2D) > 0 then begin
        FTarget := GL_TEXTURE_2D;
        AddAttr(WGL_TEXTURE_TARGET_ARB, WGL_TEXTURE_2D_ARB);
      end;
      if (FMode and TB_Mipmap) > 0 then
	AddAttr(WGL_MIPMAP_TEXTURE_ARB, GL_TRUE);
      AddAttr(0, 0);
    end;
begin
  FWidth := Width;
  FHeight := Height;
  FMode := Mode;
  FReady := False;
  FBinded := False;
  FRendering := False;
  SDebug.Log('supported cheking');
  if not Supported then
    Exit;
  SDebug.Log('context getting');
  CurDC := wglGetCurrentDC;
  CurGLRC := wglGetCurrentContext;
  SDebug.Log('context getted');

  MakeIntAttrs;

  FloatAttrs[0] := 0;
  FloatAttrs[1] := 0;

  SDebug.Log('FloatAttrs[1] := 0;');
  NumFormats := 0;
  if not wglChoosePixelFormatARB(CurDC, 
                                 @IntAttrs[0], @FloatAttrs[0], 
                                 20, @PixelFormats[0], @NumFormats) then begin
    SDebug.Log('! Error[TTexBuffer.Create]: cannot choose pixel format.');
    Exit;
  end;
  SDebug.Log('wglChoosePixelFormatARB');
  if NumFormats < 1 then begin
    SDebug.Log('! Error[TTexBuffer.Create]: NumFormats < 1.');
    Exit;
  end;
  SDebug.Log('NumFormats < 1');
  
  Format := PixelFormats[0];
  MakeProps;
  FPBuffer := wglCreatePBufferARB(CurDC, Format, FWidth, FHeight, @IntAttrs[0]);
  if FPBuffer = 0 then begin
    SDebug.Log('! Error[TTexBuffer.Create]: FPBuffer = 0.');
    Exit;
  end;
  SDebug.Log(ToStr(['wglCreatePBufferARB(CurDC, Format, Width, Height, @IntAttrs) ', 
             FPBuffer]));
  FDC := wglGetPBufferDCARB(FPBuffer);
  if FDC = 0 then begin
    SDebug.Log('! Error[TTexBuffer.Create]: FDC = 0.');
    Exit;
  end;
  SDebug.Log(ToStr(['wglGetPBufferDCARB ', FDC]));
  FGLRC := wglCreateContext(FDC);
  //wglShareLists(CurGLRC, FGLRC);
  wglQueryPbufferARB(FPBuffer, WGL_PBUFFER_WIDTH_ARB,  @FWidth);
  wglQueryPbufferARB(FPBuffer, WGL_PBUFFER_HEIGHT_ARB, @FHeight);
  SDebug.Log('wglCreateContext');  

  glGenTextures(1, @FTexture);
  SDebug.Log(ToStr(['FTarget: ', FTarget = GL_TEXTURE_2D]));
  glBindTexture(FTarget, FTexture);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
  glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  if (FMode and TB_Mipmap ) > 0 then begin
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, 
                    GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP_SGIS, GL_TRUE);
  end;
  if FTarget = GL_TEXTURE_2D then
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, FWidth, FHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  FReady := True;

  StartRender;
  glViewPort(0, 0, FWidth, FHeight);
  glClearColor(0, 1, 0, 1);
  glClear(GL_COLOR_BUFFER_BIT);
  glDisable(GL_DEPTH_TEST);
  FinishRender;
  SDebug.Log(ToStr(['PBuffer: ', FWidth, 'x', FHeight]));
end;

destructor TTexBuffer.Destroy;
begin
  if not FReady then
    Exit;
end;

class function TTexBuffer.GetSupported: Boolean;
begin
  if CheckedSupported = -1 then begin
    CheckedSupported := Ord(Load_WGL_ARB_pbuffer and 
                            Load_WGL_ARB_pixel_format and
                            Load_WGL_ARB_render_texture);
    SDebug.Log(ToStr(['TTexBuffer.Supported: ' + 
                      IntToStr(Ord(CheckedSupported))]));
  end;
  Result := CheckedSupported > 0;
end;

procedure TTexBuffer.Bind;
begin
  if not FReady then
    Exit;
  glEnable(FTarget);
  glBindTexture(FTarget, FTexture);
  FBinded := wglBindTexImageARB(FPBuffer, Buf);   
  glEnable(FTarget);
  glBindTexture(FTarget, FTexture);
end;

procedure TTexBuffer.Unbind;
begin
  FBinded := False;
  if not FReady then
    Exit;
  glBindTexture(FTarget, FTexture);
  wglReleaseTexImageARB(FPBuffer, Buf);
  glDisable(FTarget);
end;

procedure TTexBuffer.StartRender;
begin
  if not FReady then
    Exit;
  FSavedDC := wglGetCurrentDC;
  FSavedGLRC := wglGetCurrentContext;
  FRendering := wglMakeCurrent(FDC, FGLRC);
end;

procedure TTexBuffer.FinishRender;
begin
  if not FRendering then
    Exit;
  FRendering := False;
  if not FReady then
    Exit;
  wglMakeCurrent(FSavedDC, FSavedGLRC);
  FSavedDC := 0;
  FSavedGLRC := 0;
end;

end.

unit GraphGL;

interface

const
  opengl32  = 'opengl32.dll';
  kernel32  = 'kernel32.dll';

type
  GLbyte = Shortint;
  GLshort = Smallint;
  GLint = Integer;
  GLfloat = Single;
  GLdouble = Double;
  GLubyte = Byte;
  GLboolean = Boolean;
  GLushort = Word;
  GLenum = Cardinal;
  GLvoid = Pointer;

  PGLbyte = ^GLbyte;
  PGLshort = ^GLshort;
  PGLint = ^GLint;
  PGLfloat = ^GLfloat;
  PGLdouble = ^GLdouble;
  PGLubyte = ^GLubyte;
  PGLboolean = ^GLboolean;
  PGLushort = ^GLushort;
  PGLenum = ^GLenum;
  PGLvoid = ^GLvoid;

  GLArrayf3 = array [0..2] of GLfloat;
  GLArray4f = array [0..3] of GLfloat;

var
  wglGetProcAddress: function(ProcName: PAnsiChar): Pointer; stdcall;


function GetProcAddress(hModule: HMODULE; lpProcName: PAnsiChar): Pointer; stdcall; external kernel32 name 'GetProcAddress';
function FreeLibrary(hLibModule: HMODULE): LongBool; stdcall; external kernel32 name 'FreeLibrary';
function LoadLibrary(lpLibFileName: PWideChar): HMODULE; stdcall; external kernel32 name 'LoadLibraryW';

type
  TGL = object
  private
    Handle: LongWord;
    function Load_1_0: Boolean;
    function Load_1_1: Boolean;
  public
{************************************************************}
{ OpenGl 1.0 }
{************************************************************}

  //display-list commands
    NewList: procedure(list: GLint; mode: GLenum); stdcall;
    EndList: procedure; stdcall;
    DeleteLists: procedure(list, range: GLint); stdcall;
    ListBase: procedure(base: GLint); stdcall;
    CallList: procedure(list: GLint); stdcall;
    CallLists: procedure(n: GLint; _type: GLenum; const lists: PGLvoid); stdcall;
    GenLists: function(range: GLint): GLint; stdcall;

  //drawing commands
    _Begin: procedure(mode: GLenum); stdcall;
    Bitmap: procedure(width, height: GLint; xorig, yorig, xmove, ymove: GLfloat; bitmap: GLvoid); stdcall;
    Color3f: procedure(red, green, blue: GLfloat); stdcall;
    Color3fv: procedure(v: PGLfloat); stdcall;
    RasterPos2f: procedure(x, y: GLfloat); stdcall;
    RasterPos2fv: procedure(v: PGLfloat); stdcall;
    TexCoord2f: procedure(s, t: GLfloat); stdcall;
    TexCoord2fv: procedure(v: PGLfloat); stdcall;
    Vertex2f: procedure(x, y: GLfloat); stdcall;
    Vertex2fv: procedure(v: PGLfloat); stdcall;
    Vertex3f: procedure(x, y, z: GLfloat); stdcall;
    Vertex3fv: procedure(v: PGLfloat); stdcall;
    Rectf: procedure(x1, y1, x2, y2: GLfloat); stdcall;
    Rectfv: procedure(v1, v2: PGLfloat); stdcall;
    _End: procedure; stdcall;
    EdgeFlag: procedure(flag: GLboolean); stdcall;
    EdgeFlagv: procedure(flag: PGLboolean); stdcall;
    Normal3f: procedure(nx, ny, nz: GLfloat); stdcall;
    Normal3fv: procedure(v: PGLfloat); stdcall;
    Color4f: procedure(red, green, blue, alpha: GLfloat); stdcall;
    Color4fv: procedure(v: PGLfloat); stdcall;

  //drawing-control commands
    LineWidth: procedure(width: GLfloat); stdcall;
    LineStipple: procedure(factor:  GLubyte; pattern: GLushort); stdcall;
    PointSize: procedure(size: GLfloat); stdcall;
    TexParameterf: procedure(target, pname: GLenum; param: GLfloat); stdcall;
    TexParameterfv: procedure(target, pname: GLenum; params: PGLfloat); stdcall;
    TexImage2D: procedure(target: GLenum; level, internalformat, width, height, border: GLint; format, _type: GLenum; pixels: GLvoid); stdcall;
    TexEnvf: procedure(target, pname: GLenum; param: GLfloat); stdcall;
    TexEnvfv: procedure(target, pname: GLenum; params: PGLfloat); stdcall;
    TexGenf: procedure(coord, pname: GLenum; param: GLfloat); stdcall;
    TexGenfv: procedure(coord, pname: GLenum; params:  PGLfloat); stdcall;
    PolygonMode: procedure(face, mode: GLenum); stdcall;
    FrontFace: procedure(mode: GLenum); stdcall;
    CullFace: procedure(mode: GLenum); stdcall;
    PolygonStipple: procedure(mask: PGLubyte); stdcall;
    ShadeModel: procedure(mode: GLenum); stdcall;
    Scissor: procedure(x, y, width, height: GLint); stdcall;

  //feedback commands
    SelectBuffer: procedure(size: GLint; buffer: PGLenum); stdcall;
    RenderMode: function(mode: GLenum): GLint; stdcall;
    InitNames: procedure; stdcall;
    LoadName: procedure(name: GLenum); stdcall;
    PushName: procedure(name: GLenum); stdcall;

  //framebuf commands
    DrawBuffer: procedure(mode: GLenum); stdcall;
    Clear: procedure(mask: GLenum); stdcall;
    ClearColor: procedure(red, green, blue, alpha: GLfloat); stdcall;
    ClearStencil: procedure(s: GLint); stdcall;
    DepthMask: procedure(flag: GLboolean); stdcall;
    ClearDepth: procedure(depth: GLdouble); stdcall;
    ClearAccum: procedure(red, green, blue, alpha: GLfloat); stdcall;
    ClearIndex: procedure(c: GLfloat); stdcall;

  //misc commands
    Disable: procedure(cap: GLenum); stdcall;
    Enable: procedure(cap: GLenum); stdcall;
    Finish: procedure; stdcall;
    Flush: procedure; stdcall;

  //modeling commands

  //pixel-op commands
    StencilFunc: procedure(func: GLenum; ref: GLint; mask: GLenum); stdcall;
    StencilOp: procedure(fail, zfail, zpass: GLenum); stdcall;
    DepthFunc: procedure(func: GLenum); stdcall;
    BlendFunc: procedure(sfactor, dfactor: GLEnum); stdcall;

  //pixel-rw commands
    CopyPixels: procedure(x, y, width, height: GLint; _type: GLenum); stdcall;
    ReadPixels: procedure(x, y, width, height: GLint; format, _type: GLenum; pixels: GLvoid); stdcall;
    DrawPixels: procedure(width, height: GLint; format, _type: GLenum; pixels: GLvoid); stdcall;
    PixelStoref: procedure(pname: GLenum; param: GLfloat); stdcall;

  //state-req commands
    GetBooleanv: procedure (pname: GLenum; params:  PGLBoolean); stdcall;
    GetDoublev: procedure(pname: GLenum; params: PGLdouble); stdcall;
    GetFloatv: procedure(pname:  GLenum; params: PGLfloat); stdcall;
    GetIntegerv: procedure(pname: GLenum; params: PGLint); stdcall;
    GetString: function(name: GLenum): PChar; stdcall;
    IsEnabled: function(cap: GLenum): Boolean; stdcall;

  //xform commands
    LoadIdentity: procedure; stdcall;
    MatrixMode: procedure(mode: GLenum); stdcall;
    Ortho: procedure(left, right, bottom, top, zNear, zFar: GLdouble); stdcall;
    Viewport: procedure(x, y, width, height:  GLint); stdcall;
    Translatef: procedure(x, y, z: GLfloat); stdcall;
    Rotatef: procedure(angle, x, y, z: GLfloat); stdcall;
    Scalef: procedure(x, y, z: GLfloat); stdcall;
    LoadMatrixf: procedure(m: PGLfloat); stdcall;
    MultMatrixf: procedure(m: PGLfloat); stdcall;

{************************************************************}
{ OpenGl 1.1 }
{************************************************************}

    CopyTexImage2D: procedure(target: GLenum; level: GLint; internalformat: GLenum; x, y, width, height, border: GLint); stdcall;
    CopyTexSubImage2D: procedure(target: GLenum; level, xoffset, yoffset, x, y, width, height: GLint); stdcall;
    TexSubImage2D: procedure(target: GLenum; level, xoffset, yoffset, width, height: GLint; format, _type: GLenum; pixels: GLvoid); stdcall;
    BindTexture: procedure(target, texture: GLenum); stdcall;
    DeleteTextures: procedure(n: GLint; textures: PGLenum); stdcall;
    GenTextures: procedure(n: GLint; textures: PGLenum); stdcall;

{************************************************************}
{ Extensions }
{************************************************************}
  private
    _wglSwapIntervalEXT: function(Interval: LongInt): LongInt; stdcall;

  public
    function Load: Boolean;
    function Close: Boolean;
    function wglSwapIntervalEXT(Interval: LongInt): Boolean;
  end;

var
  GL: TGL;

implementation

function TGL.Load_1_0: Boolean;
begin
  NewList := GetProcAddress(Handle, 'glNewList');
  EndList := GetProcAddress(Handle, 'glEndList');
  DeleteLists := GetProcAddress(Handle, 'glDeleteLists');
  ListBase := GetProcAddress(Handle, 'glListBase');
  CallList := GetProcAddress(Handle, 'glListBase');
  CallLists := GetProcAddress(Handle, 'glListBase');
  GenLists := GetProcAddress(Handle, 'glListBase');

  _Begin := GetProcAddress(Handle, 'glBegin');
  Bitmap := GetProcAddress(Handle, 'glBitmap');
  Color3f := GetProcAddress(Handle, 'glColor3f');
  Color3fv := GetProcAddress(Handle, 'glColor3fv');
  RasterPos2f := GetProcAddress(Handle, 'glRasterPos2f');
  RasterPos2fv := GetProcAddress(Handle, 'glRasterPos2fv');
  TexCoord2f := GetProcAddress(Handle, 'glTexCoord2f');
  TexCoord2fv := GetProcAddress(Handle, 'glTexCoord2fv');
  Vertex2f := GetProcAddress(Handle, 'glVertex2f');
  Vertex2fv := GetProcAddress(Handle, 'glVertex2fv');
  Vertex3f := GetProcAddress(Handle, 'glVertex3f');
  Vertex3fv := GetProcAddress(Handle, 'glVertex3fv');
  Rectf := GetProcAddress(Handle, 'glRectf');
  Rectfv := GetProcAddress(Handle, 'glRectfv');
  _End := GetProcAddress(Handle, 'glEnd');
  EdgeFlag := GetProcAddress(Handle, 'glEdgeFlag');
  EdgeFlagv := GetProcAddress(Handle, 'glEdgeFlagv');
  Normal3f := GetProcAddress(Handle, 'glNormal3f');
  Normal3fv := GetProcAddress(Handle, 'glNormal3fv');
  Color4f := GetProcAddress(Handle, 'glColor4f');
  Color4fv := GetProcAddress(Handle, 'glColor4fv');

  LineWidth := GetProcAddress(Handle, 'glLineWidth');
  LineStipple := GetProcAddress(Handle, 'glLineStipple');
  PointSize := GetProcAddress(Handle, 'glPointSize');
  TexParameterf := GetProcAddress(Handle, 'glTexParameterf');
  TexParameterfv := GetProcAddress(Handle, 'glTexParameterfv');
  TexImage2D := GetProcAddress(Handle, 'glTexImage2D');
  TexEnvf := GetProcAddress(Handle, 'glTexEnvf');
  TexEnvfv := GetProcAddress(Handle, 'glTexEnvfv');
  TexGenf := GetProcAddress(Handle, 'glTexGenf');
  TexGenfv := GetProcAddress(Handle, 'glTexGenfv');
  PolygonMode := GetProcAddress(Handle, 'glPolygonMode');
  FrontFace := GetProcAddress(Handle, 'glFrontFace');
  CullFace := GetProcAddress(Handle, 'glCullFace');
  PolygonStipple := GetProcAddress(Handle, 'glPolygonStipple');
  ShadeModel := GetProcAddress(Handle, 'glShadeModel');
  Scissor := GetProcAddress(Handle, 'glScissor');

  SelectBuffer := GetProcAddress(Handle, 'glSelectBuffer');
  RenderMode := GetProcAddress(Handle, 'glRenderMode');
  InitNames := GetProcAddress(Handle, 'glInitNames');
  LoadName := GetProcAddress(Handle, 'glLoadName');
  PushName := GetProcAddress(Handle, 'glPushName');

  DrawBuffer := GetProcAddress(Handle, 'glDrawBuffer');
  Clear := GetProcAddress(Handle, 'glClear');
  ClearColor := GetProcAddress(Handle, 'glClearColor');
  ClearStencil := GetProcAddress(Handle, 'glClearStencil');
  DepthMask := GetProcAddress(Handle, 'glDepthMask');
  ClearDepth := GetProcAddress(Handle, 'glClearDepth');
  ClearAccum := GetProcAddress(Handle, 'glClearAccum');
  ClearIndex := GetProcAddress(Handle, 'glClearIndex');

  Disable := GetProcAddress(Handle, 'glDisable');
  Enable := GetProcAddress(Handle, 'glEnable');
  Finish := GetProcAddress(Handle, 'glFinish');
  Flush := GetProcAddress(Handle, 'glFlush');

  StencilFunc := GetProcAddress(Handle, 'glStencilFunc');
  StencilOp := GetProcAddress(Handle, 'glStencilOp');
  DepthFunc := GetProcAddress(Handle, 'glDepthFunc');
  BlendFunc := GetProcAddress(Handle, 'glBlendFunc');

  CopyPixels := GetProcAddress(Handle, 'glCopyPixels');
  ReadPixels := GetProcAddress(Handle, 'glReadPixels');
  DrawPixels := GetProcAddress(Handle, 'glDrawPixels');
  PixelStoref := GetProcAddress(Handle, 'glPixelStoref');

  GetBooleanv := GetProcAddress(Handle, 'glGetBooleanv');
  GetDoublev := GetProcAddress(Handle, 'glGetDoublev');
  GetFloatv := GetProcAddress(Handle, 'glGetFloatv');
  GetIntegerv := GetProcAddress(Handle, 'glGetIntegerv');
  GetString := GetProcAddress(Handle, 'glGetString');
  IsEnabled := GetProcAddress(Handle, 'glIsEnabled');

  LoadIdentity := GetProcAddress(Handle, 'glLoadIdentity');
  MatrixMode := GetProcAddress(Handle, 'glMatrixMode');
  Ortho := GetProcAddress(Handle, 'glOrtho');
  Viewport := GetProcAddress(Handle, 'glViewport');
  Translatef := GetProcAddress(Handle, 'glTranslatef');
  Rotatef := GetProcAddress(Handle, 'glRotatef');
  Scalef := GetProcAddress(Handle, 'glScalef');
  LoadMatrixf := GetProcAddress(Handle, 'glLoadMatrixf');
  MultMatrixf := GetProcAddress(Handle, 'glMultMatrixf');
  Result := (@_Begin <> nil) and
    (@Bitmap <> nil) and (@Color3f <> nil) and (@Color3fv <> nil) and
    (@RasterPos2f <> nil) and (@RasterPos2fv <> nil) and (@TexCoord2f <> nil) and
    (@TexCoord2fv <> nil) and (@Vertex2f <> nil) and (@Vertex2fv <> nil) and
    (@Rectf <> nil) and (@Rectfv <> nil) and (@_End <> nil) and (@EdgeFlag <> nil) and
    (@EdgeFlagv <> nil) and (@Normal3f <> nil) and (@Normal3fv <> nil) and
    (@Color4f <> nil) and (@Color4fv <> nil) and (@LineWidth <> nil) and
    (@LineStipple <> nil) and (@PointSize <> nil) and (@TexParameterf <> nil) and
    (@TexParameterfv <> nil) and (@TexImage2D <> nil) and (@TexEnvf <> nil) and
    (@TexEnvfv <> nil) and (@TexGenf <> nil) and (@TexGenfv <> nil) and
    (@PolygonMode <> nil) and (@ShadeModel <> nil) and (@Scissor <> nil) and
    (@SelectBuffer <> nil) and (@RenderMode <> nil) and (@InitNames <> nil) and
    (@LoadName <> nil) and (@PushName <> nil) and (@DrawBuffer <> nil) and
    (@Clear <> nil) and (@ClearColor <> nil) and (@ClearStencil <> nil) and
    (@DepthMask <> nil) and (@ClearDepth <> nil) and (@ClearAccum <> nil) and
    (@ClearIndex <> nil) and (@Disable <> nil) and (@Enable <> nil) and
    (@Finish <> nil) and (@Flush <> nil) and (@StencilFunc <>  nil) and
    (@StencilOp <> nil) and (@CopyPixels <> nil) and (@ReadPixels <> nil) and
    (@DrawPixels <> nil) and (@PixelStoref <> nil) and (@GetBooleanv <> nil) and
    (@GetDoublev <> nil) and (@GetFloatv <> nil) and (@GetIntegerv <> nil) and
    (@GetString <> nil) and (@IsEnabled <>  nil) and (@LoadIdentity <> nil) and
    (@MatrixMode <> nil) and (@Ortho <> nil) and (@Viewport <> nil) and
    (@Translatef <> nil) and (@Rotatef <> nil) and (@Scalef <> nil) and
    (@LoadMatrixf <> nil) and (@MultMatrixf <> nil) and (@DepthFunc <> nil) and
    (@BlendFunc <> nil) and (@NewList <> nil) and (@EndList <> nil) and (@DeleteLists <> nil) and
    (@ListBase <> nil) and (@CallList <> nil) and (@CallLists <> nil) and
    (@GenLists <> nil) and (@Vertex3f <> nil) and (@Vertex3fv <> nil);
end;

function TGL.Load_1_1: Boolean;
begin
  CopyTexImage2D := GetProcAddress(Handle, 'glCopyTexImage2D');
  CopyTexSubImage2D := GetProcAddress(Handle, 'glCopyTexSubImage2D');
  TexSubImage2D := GetProcAddress(Handle, 'glTexSubImage2D');
  BindTexture := GetProcAddress(Handle, 'glBindTexture');
  DeleteTextures := GetProcAddress(Handle, 'glDeleteTextures');
  GenTextures := GetProcAddress(Handle, 'glGenTextures');
  Result := (@CopyTexImage2D <> nil) and (@CopyTexSubImage2D <> nil) and
    (@TexSubImage2D <> nil) and (@BindTexture <> nil) and (@DeleteTextures <> nil) and
    (@GenTextures <> nil);
end;

function TGL.Load: Boolean;
begin
  if Handle <> 0 then
    FreeLibrary(Handle);
  Handle := LoadLibrary(opengl32);
  if Handle <> 0 then
  begin
    wglGetProcAddress := GetProcAddress(Handle, 'wglGetProcAddress');
    if not Load_1_0 or not Load_1_1 then
    begin
      Exit(False);
    end;
  end;
  Result := Handle <> 0;
end;

function TGL.wglSwapIntervalEXT(Interval: LongInt): Boolean;
begin
  if @_wglSwapIntervalEXT = nil then
    _wglSwapIntervalEXT := wglGetProcAddress('wglSwapIntervalEXT');
  Result := @_wglSwapIntervalEXT <> nil;
  if Result then
    _wglSwapIntervalEXT(Interval);
end;

function TGL.Close: Boolean;
begin
   Result := FreeLibrary(Handle);
end;


end.

unit DWinApi;

interface

uses
  messages,
  GL,
  DUtils,
  DDebug,
  DParser,
  DMath,
  DClasses,
  DEvents,
  windows;

const
  KEY_TILDE = 192;
  KEY_ENTER = 13;

  KEY_LEFT = VK_LEFT;
  KEY_RIGHT = VK_RIGHT;
  KEY_DOWN = VK_DOWN;
  KEY_UP = VK_UP;

  KEY_ESCAPE = 27;

  KEY_BACKSPACE = 8;

  KEY_F1  = VK_F1;
  KEY_F2  = VK_F2;
  KEY_F3  = VK_F3;
  KEY_F4  = VK_F4;
  KEY_F5  = VK_F5;
  KEY_F6  = VK_F6;
  KEY_F7  = VK_F7;
  KEY_F8  = VK_F8;
  KEY_F9  = VK_F9;
  KEY_F10 = VK_F10;
  KEY_F11 = VK_F11;
  KEY_F12 = VK_F12;

  MOD_LCTRL = 0;
  MOD_RCTRL = 1;
  MOD_LSHIFT  = 2;
  MOD_RSHIFT  = 3;

  IDM_COPY      = 40006;
  IDM_CUT       = 40007;
  IDM_PASTE     = 40008;

Type
TWinApi = class;

TKey = Cardinal;

TMouseButton = (
                        mbLeft,
                        mbRight,
                        mbMiddle
               );

TClipboardAction = (
                        caCopy,
                        caPaste
                   );

TWinApiEvent = class(TEvent)
end;

TWinApiMouse = class(TWinApiEvent)
private
  FButton: TMouseButton;
  FDown: Boolean;
  FPos: TVec2f;
  FFlags: Cardinal;
public
  constructor Create(Button: TMouseButton; 
                     Down: Boolean; 
                     Pos: TVec2f; 
                     Flags: Cardinal);
  property Button: TMouseButton read FButton;
  property Down: Boolean read FDown;
  property Pos: TVec2f read FPos;
  property Flags: Cardinal read FFlags;
end;

TWinApiMouseWheel = class(TWinApiEvent)
 private
  FDelta: Single;
 public
  constructor Create(Delta: Single);
  property Delta: Single read FDelta;
end;

TWinApiKey = class(TWinApiEvent)
private
  FKey: Cardinal; 
  FDown: Boolean;
  FFirst: Boolean;
  FFlags: Cardinal;
  FModifiers: array[0..3] of Boolean;
  function GetLCtrl: Boolean; inline;
  function GetRCtrl: Boolean; inline;
  function GetCtrl: Boolean; inline;
  function GetLShift: Boolean; inline;
  function GetRShift: Boolean; inline;
  function GetShift: Boolean; inline;
public
  constructor Create(Key: TKey; Down: Boolean; Flags: Cardinal);
  property Key: TKey read FKey;
  property Down: Boolean read FDown;
  property Flags: Cardinal read FFlags;
  property First: Boolean read FFirst;
  property LCtrl: Boolean read GetLCtrl; 
  property RCtrl: Boolean read GetRCtrl;
  property Ctrl: Boolean read GetCtrl;
  property LShift: Boolean read GetLShift;
  property RShift: Boolean read GetRShift;
  property Shift: Boolean read GetShift;
end;

TWinApiChar = class(TWinApiEvent)
private
  FKey: Cardinal;
public
  constructor Create(Key: Cardinal);
  property Key: Cardinal read FKey;
end;

TWinApiClipboard = class(TWinApiEvent)
private
  FAction: TClipboardAction;
public
  constructor Create(Action: TClipboardAction);
  property Action: TClipboardAction read FAction;
end;

TWinApp = TEntity;
{TWinApp = class
  procedure Render; virtual;
  procedure Update; virtual;
  procedure OnEvent(const Event: TEvent); virtual;
end;}

TWindow = class//{{{
private
  FWinApi: TWinApi;
  FApp: TWinApp;
  // пользователю вовсе необязательно знать о том, что приложение под Win32
  FHandle: HWND;
  FDC: HDC;
  FRC: HGLRC;
  FKeys: array[0..255] of Boolean;
  FMouseButtons: array[TMouseButton] of Boolean;
  function WndProc(Msg: Cardinal; wParam, lParam: Integer): Boolean;
  property Handle: HWND read FHandle write FHandle;
  property DC: HDC read FDC write FDC;
  property RC: HGLRC read FRC write FRC;
  class function CreateWindowClass(Name: TString): Boolean;
  function CreatePixelFormat(ColorBits, DepthBits, StencilBits: Integer): Boolean;
  function InitHandle(ClassName, Caption: TString;
                      Flags, FlagsEx: Cardinal;
                      X, Y, W, H: Integer): Boolean;
  function InitDC: Boolean;
  function InitRC: Boolean;
public
  constructor Create(WinApi: TWinApi; Caption: TString; X, Y, Width, Height: Integer);
  destructor Destroy; override;
  procedure Subscribe(App: TWinApp);
  procedure Render;
  procedure Update;
  procedure SwapBuffers; inline;
  procedure SetCaption(Caption: TString);
  function GetWidth: Integer; inline;
  function GetHeight: Integer; inline;
  function GetSize: TVec2i;
  function GetPos: TVec2i;
  function GetMouse: TVec2i; inline;
  function GetKeyPressed(Key: Byte): Boolean;
  function GetMouseButton(Button: TMouseButton): Boolean;
  property WinApi: TWinApi read FWinApi;
  property Caption: TString write SetCaption;
  property Pos: TVec2i read GetPos;
  property Size: TVec2i read GetSize;
  property Mouse: TVec2i read GetMouse;
  property Keys[Key: Byte]: Boolean read GetKeyPressed;
  property MouseButtons[Button: TMouseButton]: Boolean read GetMouseButton;
end;
//}}}
TWinApi = class
private
  FWindows: array of TWindow;
  FExiting: Boolean;

  FFPS: Integer;
public
  constructor Create;
  destructor Destroy; override;
  function CreateWindow(Caption: TString; W, H: Integer): TWindow;
  procedure Run(UpdInterval: Integer);
  procedure ShutDown;
  function SWidth: Integer;
  function SHeight: Integer; 
  function ScreenSize: TVec2i;
  function GetMouse: TVec2i;
  procedure CopyToClipBoard(const S: String);
  function GetFromClipboard: String;
  property Mouse: TVec2i read GetMouse;
  property FPS: Integer read FFPS;
end;

function GetTimer: Integer;

// Сохранение файла в формат ext, возвращает путь к файлу
Function GetSaveFile(Window: TWindow; ext: TString = '*'): TString;
// Загрузка файла формата ext, возвращает путь к файлу
Function GetLoadFile(Window: TWindow; ext: TString = '*'): TString;
// Список файлов в заданной папке
procedure GetFileList(const Folder: TString; var Files: TArrayOfString; Current: Boolean = True);
// Список директорий в заданной папке
procedure GetDirList(const Folder: TString; var Files: TArrayOfString);
// Текущие директории
function GetCurrentDirectory: TString;
procedure SetCurrentDirectory(const Folder: TString);
// Директория, в которой лежит Exe
function GetExeDirectory: TString;

implementation

//Var
//  Windows: Array Of TWindow;

// Обработчик сообщений, приходящих окну//{{{
function WndProc(hWnd: HWND; Msg: Cardinal; wParam: Integer; lParam: Integer): Integer; stdcall;
  var
    Window: TWindow;
begin
  Result := 0;
  {
  // Windows может присылать сообщение только таким образом.
  // Я хочу перекинуть это сообщение моему объекту, который реализует окно.
  // Имею только hWnd, поэтому приходится извращаться.
  // А именно хранить все окна в массиве Windows, и: 
  for I := 0 to High(Windows) do
    if Windows[I].Handle = hWnd then // нашли, пытаемя обработать
      if not Windows[I].WndProc(Msg, wParam, lParam) then // удалось?
        Break
      else
        Exit;
  }
  // TODO: свести все к одному вызову GetWindowLong
  Window := TWindow(GetWindowLongA(hWnd, GWL_USERDATA));
  if Window <> nil then
    if Window.WndProc(Msg, wParam, lParam) then
      Exit;
  Result := DefWindowProcA(hWnd, Msg, wParam, lParam);
end;

constructor TWinApiMouse.Create;
begin
  FButton := Button;
  FDown := Down;
  FPos := Pos;
  FFlags := Flags;
end;

constructor TWinApiMouseWheel.Create(Delta: Single);
begin
  FDelta := Delta;
end;

function TWinApiKey.GetLCtrl;
begin
  Result := FModifiers[MOD_LCTRL];
end;

function TWinApiKey.GetRCtrl;
begin
  Result := FModifiers[MOD_RCTRL];
end;

function TWinApiKey.GetCtrl;
begin
  Result := GetLCtrl or GetRCtrl;
end;

function TWinApiKey.GetLShift;
begin
  Result := FModifiers[MOD_LSHIFT];
end;

function TWinApiKey.GetRShift;
begin
  Result := FModifiers[MOD_RSHIFT];
end;

function TWinApiKey.GetShift;
begin
  Result := GetLShift or GetRShift;
end;

constructor TWinApiKey.Create(Key: TKey; Down: Boolean; Flags: Cardinal);
begin
  FKey := Key;
  FDown := Down;
  FFlags := Flags;
end;

constructor TWinApiChar.Create(Key: Cardinal);
begin
  FKey := Key;
end;

constructor TWinApiClipBoard.Create(Action: TClipboardAction);
begin
  FAction := Action;
end;
//}}}
//  TWinApp//{{{
//
{procedure TWinApp.Render;
begin
end;

procedure TWinApp.Update;
begin
end;

procedure TWinApp.OnEvent;
begin
end;}
//}}}
//  TWindow//{{{
//

// Функция, создающая класс окна с имеенем Name//{{{
{
        Нужно вызывать для каждого Name один раз.
        Используется при инициализации в TWinApi.
}
function LoadIconA(hInstance: HINST; lpIconName: PAnsiChar): HICON; stdcall; external 'user32.dll' name 'LoadIconA';

class function TWindow.CreateWindowClass(Name: TString): Boolean;
  Var
    Wnd: WNDCLASSEX;

begin
  Result := False;
  FillChar(wnd, SizeOf(wnd), 0);
    With wnd do begin
      cbSize        := SizeOf(wnd);
      style         := CS_HREDRAW or
                       CS_VREDRAW or
                       CS_OWNDC;
      lpfnWndProc   := @DWinApi.WndProc;
      hCursor       := LoadCursorA(0, IDC_ARROW);
      hIcon := LoadIconA(hInstance, 'Icon_1');
      lpszClassName := PAnsiChar(Name);
    end;
  //SDebug.Log('Structure created $' + HexStr(@TWindow.CreateWindowClass) + ' $' + HexStr(@RegisterClassExA));
  SDebug.Log('Structure created $' + IntToStr(Cardinal(@TWindow.CreateWindowClass)) + ' $' + IntToStr(Cardinal(@RegisterClassExA)));
    If RegisterClassExA(wnd) = 0 then
      Exit;
  SDebug.Log('RegisterClassExA');
  Result := True;
end;
//}}}
// Функция, устанавливающая формат пикселя в текущем контексе//{{{
function TWindow.CreatePixelFormat(ColorBits, DepthBits, StencilBits: Integer): Boolean;
  Var
    Pfd: PIXELFORMATDESCRIPTOR;
    PixelFormat: Integer;
begin
  Result := False;
  FillChar(pfd, SizeOf(pfd), 0);
  with pfd do begin
    nSize        := SizeOf(PIXELFORMATDESCRIPTOR);
    nVersion     := 2;
    dwFlags      := PFD_DRAW_TO_WINDOW or
                    PFD_SUPPORT_OPENGL or
                    PFD_DOUBLEBUFFER;
    iPixelType   := PFD_TYPE_RGBA;
    cColorBits   := ColorBits;
    cDepthBits   := DepthBits;
    cStencilBits := StencilBits;
    iLayerType   := PFD_MAIN_PLANE;
  end;
  PixelFormat := ChoosePixelFormat(DC, @pfd);
  if (PixelFormat = 0) Or Not SetPixelFormat(DC, PixelFormat, @Pfd) then
      Exit;
  Result := True;
  //Log.PrintLn('CreatePixelFormat(Color = ' + IntToStr(ColorBits) + ', ' +
  //                              'Depth = ' + IntToStr(DepthBits) + ', ' +
  //                              'Stencil = ' + IntToStr(StencilBits) + ');');
end;
//}}}

function TWindow.InitHandle(ClassName, Caption: TString;//{{{
                            Flags, FlagsEx: Cardinal;
                            X, Y, W, H: Integer): Boolean;
begin
  Result := True;
  FHandle := CreateWindowExA(WS_EX_APPWINDOW or WS_EX_WINDOWEDGE, 
                            PAnsiChar('OpenGL'),
                            PAnsiChar(Caption),
                            WS_POPUP or WS_CAPTION,
                            X, Y, W, H, 0, 0, 0, nil);
  if FHandle = 0 then begin
    SDebug.Log('Error[TWindow.Create]: CreateWindowEx');
    Result := False;
  end;
end;
//}}}
function TWindow.InitDC: Boolean;//{{{
begin
  Result := True;
  DC := GetDC(FHandle);
  if (DC = 0) Or Not CreatePixelFormat(32, 24, 8) then begin
    SDebug.Log('Error[TWindow.Create]: CreatePixelFormat');
    Result := False;
  end;
end;
//}}}
function TWindow.InitRC: Boolean;//{{{
begin
  Result := True;
  RC := wglCreateContext(DC);
  if (RC = 0) Or Not wglMakeCurrent(DC, RC) then begin
    SDebug.Log('Error[TWindow.Create]: wglCreateContext or wglMakeCurrent');
    Result := False;
  end;
end;
//}}}
constructor TWindow.Create;//{{{
  Var
    //dwStyle : DWORD;
    Rect  : TRect;
begin
//вычисление размера окна и установка его посередине
//          Size := Vec2i(ClientSize.x + 2*(GetSystemMetrics(SM_CXFIXEDFRAME) + GetSystemMetrics(SM_CXEDGE)),
//          ClientSize.y + 2*(GetSystemMetrics(SM_CYFIXEDFRAME) + GetSystemMetrics(SM_CYEDGE)) + GetSystemMetrics(SM_CYCAPTION));
//        Pos := Vec2i(((GetSystemMetrics(SM_CXSCREEN) - Size.x)  div 2),
//          ((GetSystemMetrics(SM_CYSCREEN) - Size.y) div 2));

  FWinApi := WinApi;
  if not InitHandle('OpenGL', Caption, WS_POPUP or WS_CAPTION, 
                    WS_EX_APPWINDOW or WS_EX_WINDOWEDGE,
                    X, Y, Width, Height) then
    Exit;
  if not InitDC then
    Exit;
  if not InitRC then
    Exit;

  SetWindowLongA(FHandle, 0, WS_VISIBLE);
  Rect.Left   := 0;
  Rect.Top    := 0;
  Rect.Right  := width;
  Rect.Bottom := height;
  //AdjustWindowRect(@Rect, dwStyle, False);
  with Rect do
    MoveWindow(FHandle, 0, 0, Right - Left, Bottom - Top, True);

  ShowCursor(True);
  SetForegroundWindow(FHandle);
  ShowWindow(FHandle, SW_SHOW);
  SetFocus(FHandle);
  UpdateWindow(FHandle);
  //SetWindowLong(FHandle, GWL_STYLE, (WS_CAPTION*Ord(Not FullScreen)) or WS_VISIBLE);
  SetWindowLongA(FHandle, GWL_STYLE,  WS_CAPTION or WS_VISIBLE);  
  SDebug.Log(ToStr(['Window size: ', X, ' ', Y]));
  SetWindowPos(FHandle, 0, X, Y, Width, Height, SWP_FRAMECHANGED or SWP_NOOWNERZORDER);
  glViewport(0, 0, Width, Height);


  SetWindowLongA(FHandle, GWL_USERDATA, Cardinal(Self)); 
  //SetLength(Windows, Length(Windows) + 1);
  //Windows[High(Windows)] := Self;
  //SDebug.Log('TWindow.Create');

  FillChar(FKeys[0], SizeOf(FKeys), 0);
end;
//}}}
destructor TWindow.Destroy;//{{{
begin
  {FIXME: }
  // FWinApi.DelWindow(...)
end;
//}}}
procedure TWindow.Subscribe;//{{{
begin
  FApp := App;
end;
//}}}
function TWindow.WndProc(Msg: Cardinal; wParam, lParam: Integer): Boolean;//{{{
  var
    Event: TEvent;
begin
  //SDebug.Log('TWindow.WndProc in');
  //if (Msg = WM_KEYDOWN) and (wParam = 13) then
  //  FWinApi.ShutDown;
    
  Event := nil;
  if Msg = WM_KEYDOWN then begin
    FKeys[wParam] := True;
    Event := TWinApiKey.Create(wParam, True, 0);
    TWinApiKey(Event).FFirst := (lParam and (1 shl 30)) = 0;
    TWinApiKey(Event).FModifiers[MOD_LCTRL] := (GetKeyState(VK_LCONTROL) and (1 shl 15)) <> 0;
    TWinApiKey(Event).FModifiers[MOD_RCTRL] := (GetKeyState(VK_RCONTROL) and (1 shl 15)) <> 0;
    TWinApiKey(Event).FModifiers[MOD_LSHIFT] := False;
    TWinApiKey(Event).FModifiers[MOD_RSHIFT] := False;
  end else if Msg = WM_KEYUP then begin
    FKeys[wParam] := False;
    Event := TWinApiKey.Create(wParam, False, 0);
  end else if Msg = WM_CHAR then begin
    Event := TWinApiChar.Create(wParam);
  end else if (Msg = WM_LBUTTONDOWN) or
              (Msg = WM_RBUTTONDOWN) or
              (Msg = WM_MBUTTONDOWN) or
              (Msg = WM_LBUTTONDBLCLK) then begin
    if Msg = WM_LBUTTONDOWN then begin
      Event := TWinApiMouse.Create(mbLeft, True, Mouse, 0);
      FMouseButtons[mbLeft] := True;
    end else if Msg = WM_MBUTTONDOWN then begin
      Event := TWinApiMouse.Create(mbMiddle, True, Mouse, 0);
      FMouseButtons[mbMiddle] := True;
    end else if Msg = WM_RBUTTONDOWN then begin
      Event := TWinApiMouse.Create(mbRight, True, Mouse, 0);
      FMouseButtons[mbRight] := True;
    end else if Msg = WM_LBUTTONDBLCLK then begin
      Event := TWinApiMouse.Create(mbLeft, True, Mouse, 1);
    end;
    //else if Msg = WM_LBUTTONDBLCLK then
    //  Event.Button := miDLeft;
  end else if (Msg = WM_LBUTTONUP) or
              (Msg = WM_RBUTTONUP) or
              (Msg = WM_MBUTTONUP) then begin
    if Msg = WM_LBUTTONUP then begin
      Event := TWinApiMouse.Create(mbLeft, False, Mouse, 0);
      FMouseButtons[mbLeft] := False;
    end else if Msg = WM_MBUTTONUP then begin
      Event := TWinApiMouse.Create(mbMiddle, False, Mouse, 0);
      FMouseButtons[mbMiddle] := False;
    end else if Msg = WM_RBUTTONUP then begin
      Event := TWinApiMouse.Create(mbRight, False, Mouse, 0);
      FMouseButtons[mbRight] := False;
    end;
  end;{ else if Msg = WM_COMMAND then begin
    if lParam = IDM_COPY then
      Event := TWinApiClipboard.Create(caCopy)
    else if lParam = IDM_PASTE then
      Event := TWinApiClipboard.Create(caPaste)
    else
      Event := TWinApiClipboard.Create(caPaste);
  end;}
  if Msg = WM_DESTROY then
    WinApi.Shutdown;
  if Msg = WM_MOUSEWHEEL then
    Event := TWinApiMouseWheel.Create(SmallInt(HIWORD(wParam)) div 120);
  if Event <> nil then begin
    FApp.OnEvent(Event);
    Event.Free;
  end;
  Result := False;
  //SDebug.Log('TWindow.WndProc out');
end;
//}}}
procedure TWindow.Render;//{{{
begin
  if FApp <> nil then begin
    FApp.Render;
    SwapBuffers;
  end;
end;
//}}}
procedure TWindow.Update;//{{{
begin
  if FApp <> nil then
    FApp.Update;
end;
//}}}
procedure TWindow.SwapBuffers;//{{{
begin
  Windows.SwapBuffers(FDC);
end;
//}}}
procedure TWindow.SetCaption(Caption: TString);//{{{
begin
  SetWindowTextA(FHandle, PAnsiChar(Caption));
end;

//}}}
function TWindow.GetWidth: Integer;//{{{
begin
  Result := GetSize.X;
end;
//}}}
function TWindow.GetHeight: Integer;//{{{
begin
  Result := GetSize.Y;
end;
//}}}
function TWindow.GetSize: TVec2i;//{{{
  var
    Rect: TRect;
begin
  GetWindowRect(FHandle, @Rect);
  Result := Vec2i(Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
end;
//}}}
function TWindow.GetPos: TVec2i;//{{{
var
  Rect: TRect;
begin
  GetWindowRect(FHandle, @Rect);
  Result := Vec2i(Rect.Left, Rect.Top);
end;
//}}}
function TWindow.GetMouse: TVec2i;//{{{
begin
  Result := FWinApi.Mouse - GetPos;
end;

function TWindow.GetKeyPressed(Key: Byte): Boolean;
begin
  Result := FKeys[Key];
end;

function TWindow.GetMouseButton(Button: TMouseButton): Boolean;
begin
  Result := FMouseButtons[Button];
end;
//}}}//}}}

//  TWinApi//{{{
//
constructor TWinApi.Create;//{{{
begin
  SetLength(FWindows, 0);
  SDebug.Log('SetLength(FWindows, 0)');

  if not TWindow.CreateWindowClass('OpenGL') then begin
    SDebug.Log('Error[TWindow.Create]: CreateWindowClass');
    Exit;
  end;
end;
//}}}
destructor TWinApi.Destroy;//{{{
begin
  //Windows.Free;
end;
//}}}
function TWinApi.CreateWindow(Caption: TString; W, H: Integer): TWindow;//{{{
begin
  Result := TWindow.Create(Self,
                           Caption,
                           Max((SWidth - W) div 2, 0),
                           Max((SHeight - H) div 2, 0),
                           W,
                           H);
  SetLength(FWindows, Length(FWindows) + 1);
  FWindows[High(FWindows)] := Result;
end;
//}}}
procedure TWinApi.Run;//{{{
  var
    //Flag: Boolean;
    //Exiting: Boolean;
    msg: TMsg;
    Time, LastUpdate, FPSCounter, LastFPS: Integer;
    I: Integer;
begin
  FExiting := False;
  LastUpdate := TUtils.GetTimer;
  LastFPS := GetTimer;
  FFPS := 0;
  FPSCounter := 0;
  while not FExiting do begin
    //Flag := False;
    Time := TUtils.GetTimer;
    while Time - LastUpdate > UpdInterval do begin
      for I := 0 to High(FWindows) do
        FWindows[I].Update;
      //flag := True;
      LastUpdate := LastUpdate + UpdInterval;
    end;
    //if Flag then
      for I := 0 to High(FWindows) do begin
        FWindows[I].Render;
        Inc(FPSCounter);
      end;
    if LastFPS + 1000 < GetTimer then begin
      FFPS := FPSCounter;
      FPSCounter := 0;
      //while LastFPS < GetTimer do
      //  LastFPS += 1000;
      LastFPS := GetTimer;
    end;
    while PeekMessageA(@msg, 0, 0, 0, PM_REMOVE) do begin
      TranslateMessage(@msg);
      DispatchMessageA(@msg);
    end;
  end;
end;
//}}}
procedure TWinApi.ShutDown;
begin
  FExiting := True;
end;

function TWinApi.SWidth: Integer;
begin
  Result := ScreenSize.X;
end;

function TWinApi.SHeight: Integer; 
begin
  Result := ScreenSize.Y;
end;

function TWinApi.ScreenSize;
  var
    Mode: DEVMODE;
begin
  EnumDisplaySettingsA(nil, ENUM_CURRENT_SETTINGS, @Mode);
  Result := Vec2i(Mode.dmPelsWidth, Mode.dmPelsHeight);
end;

function TWinApi.GetMouse;
  Var
    Point: TPoint;
begin
  GetCursorPos(@Point);
  Result := Vec2i(Point.X, Point.Y);
end;

procedure TWinApi.CopyToClipBoard(const S: String);
  label
    Error;
  var
    H: HGLOBAL;
    P: PAnsiChar;
begin
  if not OpenClipboard(0) then
    Exit;
  EmptyClipboard;
  H :=  GlobalAlloc(GMEM_MOVEABLE, (Length(S) + 1) * SizeOf(AnsiChar));
  if H = 0 then
    goto Error;
  P := GlobalLock(H);   
  Move(S[1], P^, Length(S));
  P[Length(S)] := #0;
  GlobalUnlock(H);
  SetClipboardData(CF_TEXT, H); 
Error:
  CloseClipboard;
end;

function TWinApi.GetFromClipboard: String;
  var 
    H: HGLOBAL;
    P: PAnsiChar;
begin
  Result := '';
  if not IsClipboardFormatAvailable(CF_TEXT) then
    Exit;
  if not OpenClipboard(0) then
    Exit;
  H := GetClipboardData(CF_TEXT);
  if H = 0 then
    Exit;
  P := GlobalLock(H);
  if P = nil then
    Exit;
  Result := P;
  GlobalUnlock(H);
  CloseClipboard;
end;
//}}}

function GetTimer: Integer;
var
  T, F: LARGE_INTEGER;
begin
  QueryPerformanceFrequency(@F);
  QueryPerformanceCounter(@T);
  Result:=Trunc(1000*T.QuadPart/F.QuadPart);
end;


// Dlg//{{{
Const
  OFN_PATHMUSTEXIST = $00000800;
  OFN_HIDEREADONLY = $00000004;
  OFN_FILEMUSTEXIST = $00001000;

  commdlg32 = 'comdlg32.dll';

Type
  tagOFNA = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PAnsiChar;
    lpstrCustomFilter: PAnsiChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PAnsiChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PAnsiChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PAnsiChar;
    lpstrTitle: PAnsiChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PAnsiChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PAnsiChar;
    pvReserved: Pointer;
    dwReserved: DWORD;
    FlagsEx: DWORD;
  end;
  tagOFNW = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PWideChar;
    lpstrCustomFilter: PWideChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PWideChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PWideChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PWideChar;
    lpstrTitle: PWideChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PWideChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PWideChar;
    pvReserved: Pointer;
    dwReserved: DWORD;
    FlagsEx: DWORD;
  end;
  tagOFN = tagOFNA;
  TOpenFilenameA = tagOFNA;
  TOpenFilenameW = tagOFNW;
  TOpenFilename = TOpenFilenameA;

function GetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall; external commdlg32 name 'GetSaveFileNameA';
function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external commdlg32 name 'GetOpenFileNameA';

Function GetSaveFile;
  Var
  SaveDialog: TOpenFilename;
begin
  ZeroMemory(@SaveDialog, SizeOf(SaveDialog));
    with SaveDialog do begin
    // Размер структуры
      lStructSize   := SizeOf(SaveDialog);
    // Родительское окно (главное окно программы)
      hWndOwner     := Window.Handle;
    // Установка фильтров (текстовые файлы)
      lpstrFilter   := PAnsiChar('Файлы ' + '*.' + ext + #0 + '*.' + ext + #0#0);
    // Если при сохранении не будет указано расширение, то добавится это...
      lpstrDefExt   := PAnsiChar(ext);
    // Директория в которую сохраняем должна существовать
    // Не показывать файлы "только для чтения", т.к. сохранить в них не удастся ;)
      Flags         := OFN_PATHMUSTEXIST or OFN_HIDEREADONLY;
    // Указываем максимальную длинну имени файла (пути) и выделяем буфер
      nMaxFile      := 250;
      nMaxFileTitle := nMaxFile;
      GetMem(lpstrFile, nMaxFile);
      ZeroMemory(lpstrFile, nMaxFile);
    end;
    If GetSaveFileName(SaveDialog) then
      Result := SaveDialog.lpstrFile
    else
      Result := '';
  //FreeMem(SaveDialog.lpstrFile);
end;

Function GetLoadFile;
  Var
  LoadDialog: TOpenFilename;
begin
  ZeroMemory(@LoadDialog, SizeOf(LoadDialog));
    with LoadDialog do begin
    // Размер структуры
      lStructSize   := SizeOf(LoadDialog);
    // Родительское окно (главное окно программы)
      hWndOwner     := Window.Handle;
    // Установка фильтров (текстовые файлы)
      lpstrFilter   := PAnsiChar('Файлы ' + '*.' + ext + #0 + '*.' + ext + #0#0);
    // Если при сохранении не будет указано расширение, то добавится это...
      lpstrDefExt   := PAnsiChar(ext);
    // Директория в которую сохраняем должна существовать
    // Не показывать файлы "только для чтения", т.к. сохранить в них не удастся ;)
      Flags         := OFN_PATHMUSTEXIST or OFN_HIDEREADONLY or OFN_FILEMUSTEXIST;
    // Указываем максимальную длинну имени файла (пути) и выделяем буфер
      nMaxFile      := 250;
      nMaxFileTitle := nMaxFile;
      GetMem(lpstrFile, nMaxFile);
      ZeroMemory(lpstrFile, nMaxFile);
    end;
    If GetOpenFileName(LoadDialog) then
      Result := LoadDialog.lpstrFile
    else
      Result := '';
end;

procedure GetFileList(const Folder: TString; var Files: TArrayOfString; Current: Boolean = True);
  var
    fd: TWin32FindData;
    fh: THandle;
    Pref: TString;
begin
  SetLength(Files, 0);
  if Current then
    Pref := GetCurrentDirectory + '\'
  else
    Pref := '';
  fh := FindFirstFile(PAnsiChar(Pref + Folder + '*'), @fd);  
  if fh <> INVALID_HANDLE_VALUE then begin
    repeat
      if Length(fd.cFileName) > 0 then
        if (fd.cFileName[0] <> '.') and 
           (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) then begin
         // папка
        end else if fd.cFileName[0] = '.' then begin
         // что-то служебное
        end else begin
          SetLength(Files, Length(Files) + 1);
          Files[High(Files)] := fd.cFileName;
        end;
    until not FindNextFile(fh, @fd);
    FindClose(fh);
  end;
end;
//}}}

procedure GetDirList(const Folder: TString; var Files: TArrayOfString);
  var
    fd: TWin32FindData;
    fh: THandle;
begin
  SetLength(Files, 0);
  fh := FindFirstFile(PAnsiChar(GetCurrentDirectory + '\' + Folder + '*'), @fd);  
  if fh <> INVALID_HANDLE_VALUE then begin
    repeat
      if Length(fd.cFileName) > 0 then
        if (fd.cFileName[0] <> '.') and 
           (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) then begin
         // папка
          SetLength(Files, Length(Files) + 1);
          Files[High(Files)] := fd.cFileName;
        end else if fd.cFileName[0] = '.' then begin
         // что-то служебное
        end else begin
        end;
    until not FindNextFile(fh, @fd);
    FindClose(fh);
  end;
end;

function GetCurrentDirectory: TString;
begin
  SetLength(Result, windows.GetCurrentDirectory(0, nil));
  windows.GetCurrentDirectory(Length(Result), @Result[1]);
  SetLength(Result, Length(Result) - 1);
end;

procedure SetCurrentDirectory(const Folder: TString);
begin
  windows.SetCurrentDirectory(PAnsiChar(Folder));
end;

function GetExeDirectory: TString;
var
  P: TString;
  L: Integer;
begin
  P := ParamStr(0);
  L := Length(P);
  while (L > 0) and (P[L] <> '\') do
    Dec(L);
  Result := Copy(P, 1, L - 1);
end;

end.

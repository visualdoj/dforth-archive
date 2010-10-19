unit DWinApi;

interface

uses
  GL,
  GLU,
  GLX,
  X,
  XLib,
  XUtil,

  DUtils,
  DDebug,
  DMath,
  DClasses,
  DEvents;

const
  KEY_TILDE = 192;
  KEY_ENTER = 13;

  KEY_LEFT = VK_LEFT;
  KEY_RIGHT = VK_RIGHT;
  KEY_DOWN = VK_DOWN;
  KEY_UP = VK_UP;

  KEY_ESCAPE = 27;

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

TWindow = class//{{{
private
  FWinApi: TWinApi;
  FApp: TWinApp;
  FKeys: array[0..255] of Boolean;

  FHandle: X.TWindow;
  FRoot: X.TWindow;
  
  FContext: GLXContext;
  FVisualInfo: PXVisualInfo;
  FColorMap   : TColorMap;
  FAttr       : TXSetWindowAttributes;
  FValueMask  : Cardinal;
  FCaption    : PChar;
  FTitle      : TXTextProperty;
  FContext    : GLXContext;
  FVisualInfo : PXVisualInfo;
  FVisualAttr       : array[ 0..10 ] of DWORD;
  //Event          : TXEvent;  
  procedure ChooseVisual;
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
  property WinApi: TWinApi read FWinApi;
  property Caption: TString write SetCaption;
  property Pos: TVec2i read GetPos;
  property Size: TVec2i read GetSize;
  property Mouse: TVec2i read GetMouse;
  property Keys[Key: Byte]: Boolean read GetKeyPressed;
end;
//}}}
TWinApi = class
private
  FWindows: array of TWindow;
  FExiting: Boolean;

  FFPS: Integer;

  FDisaplay: PDisplay;
  FDefault: Cardinal;
public
  constructor Create;
  destructor Destroy; override;
  function CreateWindow(Caption: TString; W, H: Integer): TWindow;
  procedure Run(UpdInterval: Integer);
  procedure ShutDown;
  function GetScreenSize: TVec2i;
  function GetMouse: TVec2i;
  // TODO procedure CopyToClipBoard(const S: String);
  // TODO function GetFromClipboard: String;
  function ScreenSize: TVec2i read GetScreenSize;
  property Mouse: TVec2i read GetMouse;
  property FPS: Integer read FFPS;
end;

function GetTimer: Integer;

// Сохранение файла в формат ext, возвращает путь к файлу
// TODO Function GetSaveFile(Window: TWindow; ext: TString = '*'): TString;
// Загрузка файла формата ext, возвращает путь к файлу
// TODO Function GetLoadFile(Window: TWindow; ext: TString = '*'): TString;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'TWindow'}{$ENDIF}
procedure TWindow.ChooseVisual;
begin
  FVisualAttr[0]  := GLX_RGBA;
  FVisualAttr[1]  := GLX_DOUBLEBUFFER;
  FVisualAttr[2]  := GLX_DEPTH_SIZE;
  FVisualAttr[3]  := 24;
  FVisualAttr[4]  := GLX_STENCIL_SIZE;
  FVisualAttr[5]  := 8;
  FVisualAttr[6]  := None;
  FVisualAttr[7]  := 0;
  FVisualAttr[8]  := 0;
  FVisualInfo := glXChooseVisual(
                       FWinApi.FDisplay, 
                       FWinApi.FDefault, 
                       @FVisualAttr[0]
                     );
  Result := Assigned(FVisual);
  if not Result then
    Error('TWindow.ChooseVisual: cannot choose visual info');
end;

constructor TWindow.Create;
begin
  FWinApi := WinApi;
  ChooseVisual;
  FRoot := RootWindow(FWinApi.FDisplay, FVisualInfo^.screen);
  FColorMap := XCreateColormap(
                     FWinApi.FDisplay, 
                     FRoot, 
                     FVisualInfo^.visual,
                     AllocNone
                   );
  FAttr.colormap := FColorMap;
  FAttr.event_mask := ExposureMask or StructureNotifyMask;
  FValueMask := CWColorMap or CWEventMask or CWX or CWY;

  FHandle := XCreateWindow(
                   FWinApi.Display,
                   FRoot,
                   X, Y,
                   Width, Height,
                   0,
                   FVisualInfo^.depth,
                   InputOutput,
                   FVisualInfo^.visual,
                   FValueMask,
                   @Attr
                 );  
  if FHandle = 0 then begin
    Error('TWindow.Create: cannot get handler');
    Exit;
  end;

  XMapWindow(FWinApi.Display, FHandle);
  glXWaitX;
end;

destructor TWindow.Destroy;
begin
end;

procedure TWindow.Subscribe(App: TWinApp);
begin
  FApp := App;
end;

procedure TWindow.Render;
begin
  if FApp <> nil then begin
    FApp.Render;
    SwapBuffers;
  end;
end;

procedure TWindow.Update;
begin
  if FApp <> nil then
    FApp.Update;
end;

procedure TWindow.SwapBuffers; inline;
begin
end;

procedure TWindow.SetCaption(Caption: TString);
begin
end;

function TWindow.GetWidth: Integer; 
begin
end;

function TWindow.GetHeight: Integer;
begin
end;

function TWindow.GetSize: TVec2i;
begin
end;

function TWindow.GetPos: TVec2i;
begin
end;

function TWindow.GetMouse: TVec2i; 
begin
end;

function TWindow.GetKeyPressed(Key: Byte): Boolean;
begin
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
{$IFNDEF FLAG_FPC}{$REGION 'TWinApi'}{$ENDIF}
constructor TWinApi.Create;
begin
  FDisplay := XOpenDisplay(nil);
  if not Assigned(FDisplay) then begin
    Error('Cannot connect to XServer');
    Exit;
  end;
  FDefault := DefaultScreen(FDisplay);
end;

destructor TWinApi.Destroy;
begin
end;

function TWinApi.CreateWindow(Caption: TString; W, H: Integer): TWindow;
begin
  Result := TWindow.Create(Self, Caption, 0, 0, W, H);
end;

procedure TWinApi.Run(UpdInterval: Integer);
  var
    Flag: Boolean;
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
    Flag := False;
    Time := TUtils.GetTimer;
    while Time - LastUpdate > UpdInterval do begin
      for I := 0 to High(FWindows) do
        FWindows[I].Update;
      flag := True;
      LastUpdate := LastUpdate + UpdInterval;
    end;
    for I := 0 to High(FWindows) do begin
      FWindows[I].Render;
      Inc(FPSCounter);
    end;
    if LastFPS + 1000 < GetTimer then begin
      FFPS := FPSCounter;
      FPSCounter := 0;
      LastFPS := GetTimer;
    end;
    while PeekMessageA(@msg, 0, 0, 0, PM_REMOVE) do begin
      TranslateMessage(@msg);
      DispatchMessageA(@msg);
    end;
  end;
end;

procedure TWinApi.ShutDown;
begin
  FExiting := True;
end;

function TWinApi.ScreenSize: TVec2i;
begin
  Result := Vec2i(0, 0);
end;

function TWinApi.GetMouse: TVec2i;
begin
  Result := Vec2i(0, 0)
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end;

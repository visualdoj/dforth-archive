unit windows;

interface

const
{$IFNDEF FLAG_FPC}{$REGION 'consts'}{$ENDIF}
  CF_TEXT               = 1;

  CS_HREDRAW            = 2;
  CS_OWNDC              = 32;
  CS_VREDRAW            = 1;
  
     INVALID_HANDLE_VALUE = THandle(-1);  

     FILE_ATTRIBUTE_ARCHIVE = 32;
     FILE_ATTRIBUTE_NORMAL = 128;
     FILE_ATTRIBUTE_DIRECTORY = 16;
     FILE_ATTRIBUTE_HIDDEN = 2;
     FILE_ATTRIBUTE_READONLY = 1;
     FILE_ATTRIBUTE_SYSTEM = 4;
     FILE_ATTRIBUTE_TEMPORARY = 256;
     FILE_ATTRIBUTE_SPARSE_FILE = $0200;
     FILE_ATTRIBUTE_REPARSE_POINT = $0400;
     FILE_ATTRIBUTE_COMPRESSED = $0800;
     FILE_ATTRIBUTE_OFFLINE = $1000;
     FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = $2000;
     FILE_ATTRIBUTE_ENCRYPTED = $4000;
     FILE_ATTRIBUTE_VIRTUAL = $20000;

     FILE_FLAG_WRITE_THROUGH = $80000000;
     FILE_FLAG_OVERLAPPED = 1073741824;
     FILE_FLAG_NO_BUFFERING = 536870912;
     FILE_FLAG_RANDOM_ACCESS = 268435456;
     FILE_FLAG_SEQUENTIAL_SCAN = 134217728;
     FILE_FLAG_DELETE_ON_CLOSE = 67108864;
     FILE_FLAG_BACKUP_SEMANTICS = 33554432;
     FILE_FLAG_POSIX_SEMANTICS = 16777216;
     SECURITY_ANONYMOUS = 0;
     SECURITY_IDENTIFICATION = 65536;
     SECURITY_IMPERSONATION = 131072;
     SECURITY_DELEGATION = 196608;
     SECURITY_CONTEXT_TRACKING = 262144;
     SECURITY_EFFECTIVE_ONLY = 524288;
     SECURITY_SQOS_PRESENT = 1048576;
  { CreateFileMapping, VirtualAlloc, VirtualFree, VirtualProtect  }
     SEC_COMMIT = 134217728;
     SEC_IMAGE = 16777216;
     SEC_NOCACHE = 268435456;
     SEC_RESERVE = 67108864;
     PAGE_READONLY = 2;
     PAGE_READWRITE = 4;
     PAGE_WRITECOPY = 8;
     PAGE_EXECUTE = 16;
     PAGE_EXECUTE_READ = 32;
     PAGE_EXECUTE_READWRITE = 64;
     PAGE_EXECUTE_WRITECOPY = 128;
     PAGE_GUARD = 256;
     PAGE_NOACCESS = 1;
     PAGE_NOCACHE = 512;
     MEM_COMMIT = 4096;
     MEM_FREE = 65536;
     MEM_RESERVE = 8192;
     MEM_IMAGE = 16777216;
     MEM_MAPPED = 262144;
     MEM_PRIVATE = 131072;
     MEM_DECOMMIT = 16384;
     MEM_RELEASE = 32768;
     MEM_TOP_DOWN = 1048576;
     MEM_RESET        = $80000;
     MEM_WRITE_WATCH  = $200000;
     MEM_PHYSICAL     = $400000;
     MEM_LARGE_PAGES  = $20000000;
     MEM_4MB_PAGES    = dword($80000000);

     ENUM_CURRENT_SETTINGS  = longword(-1);
     GMEM_MOVEABLE = 2;  
     GWL_STYLE = -(16);  
     GWL_USERDATA = -(21);
     IDC_ARROW = PAnsiChar(32512);
 
     // OpenGL! O_o
     PFD_DOUBLEBUFFER = $1;  
     PFD_DRAW_TO_WINDOW = $4;
     PFD_SUPPORT_OPENGL = $20;
     PFD_MAIN_PLANE = 0;  
     PFD_TYPE_RGBA = 0;  

     PM_REMOVE = 1;  
     SWP_FRAMECHANGED = 32;  
     SWP_NOOWNERZORDER = 512;  
     SW_SHOW = 5;  
     WS_CAPTION = $c00000;
     WS_EX_APPWINDOW = $40000;  
     WS_EX_WINDOWEDGE = $100;
     WS_POPUP = longword($80000000);
     WS_VISIBLE = $10000000;  
     CCHDEVICENAME = 32;     
     CCHFORMNAME = 32;     

     VK_LEFT = 37;
     VK_UP = 38;
     VK_RIGHT = 39;
     VK_DOWN = 40;

     VK_F1  = $70;
     VK_F2  = $71;
     VK_F3  = $72;
     VK_F4  = $73;
     VK_F5  = $74;
     VK_F6  = $75;
     VK_F7  = $76;
     VK_F8  = $77;
     VK_F9  = $78;
     VK_F10 = $79;
     VK_F11 = $7A;
     VK_F12 = $7B;

     MAX_PATH = 260;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}
type
{$IFNDEF FLAG_FPC}{$REGION 'types'}{$ENDIF}
     LPSTR = PAnsiChar;  
     TBYTE = byte;
     TCHAR = char;
     ATOM = word;  
     BCHAR = Byte;
     DWord = Cardinal;
     LONG = LongInt;
     LONGLONG  = int64;     
     SHORT = smallint;     
     LARGE_INTEGER = record
        case byte of
          0: (LowPart : DWORD;
              HighPart : LONG);
          1: (QuadPart : LONGLONG);
       end;     
     PLARGE_INTEGER = ^LARGE_INTEGER;       
     HANDLE = System.THandle;     
     POINTL = record
          x : LONG;
          y : LONG;
       end;     
     LPPOINT = ^POINT;       
     UINT   = cardinal;    
     LONG_PTR = LongInt;
     WPARAM = LONG_PTR;
     LPARAM = LONG_PTR;     
     LRESULT = LONG_PTR;     
     WINBOOL = longbool;
     BOOL = WINBOOL;     
     LPCSTR  = PAnsiChar;
     LPCTSTR = PAnsiChar;
     LPVOID  = pointer;
     PVOID = pointer;     
     DEVMODE = record
          dmDeviceName : array[0..(CCHDEVICENAME)-1] of BCHAR;
          dmSpecVersion : WORD;
          dmDriverVersion : WORD;
          dmSize : WORD;
          dmDriverExtra : WORD;
          dmFields : DWORD;
          case byte of
            1: (dmOrientation : SmallInt;
                dmPaperSize : SmallInt;
                dmPaperLength : SmallInt;
                dmPaperWidth : SmallInt;
                dmScale : SmallInt;
                dmCopies : SmallInt;
                dmDefaultSource : SmallInt;
                dmPrintQuality : SmallInt;
                dmColor : SmallInt;
                dmDuplex : SmallInt;
                dmYResolution : SmallInt;
                dmTTOption : SmallInt;
                dmCollate : SmallInt;
                dmFormName : array[0..(CCHFORMNAME)-1] of BCHAR;
                dmLogPixels : WORD;
                dmBitsPerPel : DWORD;
                dmPelsWidth : DWORD;
                dmPelsHeight : DWORD;
                dmDisplayFlags : DWORD;
                dmDisplayFrequency : DWORD;
                dmICMMethod : DWORD;
                dmICMIntent : DWORD;
                dmMediaType : DWORD;
                dmDitherType : DWORD;
                dmICCManufacturer : DWORD;
                dmICCModel : DWORD
               );
            2: (dmPosition: POINTL;
                dmDisplayOrientation: DWORD;
                dmDisplayFixedOutput: DWORD;
               );
       end;
     LPDEVMODE = ^DEVMODE;
     HGLOBAL = HANDLE;
     HWND = HANDLE;
     HDC = HANDLE;     
     HGLRC = HANDLE;     
     HBRUSH = HANDLE;     
     HCURSOR = HANDLE;     
     HINST = HANDLE;   { Not HINSTANCE, else it has problems with the var HInstance }     
     HICON = HANDLE;     
     HMENU = HANDLE;     
     PIXELFORMATDESCRIPTOR = record
          nSize : WORD;
          nVersion : WORD;
          dwFlags : DWORD;
          iPixelType : BYTE;
          cColorBits : BYTE;
          cRedBits : BYTE;
          cRedShift : BYTE;
          cGreenBits : BYTE;
          cGreenShift : BYTE;
          cBlueBits : BYTE;
          cBlueShift : BYTE;
          cAlphaBits : BYTE;
          cAlphaShift : BYTE;
          cAccumBits : BYTE;
          cAccumRedBits : BYTE;
          cAccumGreenBits : BYTE;
          cAccumBlueBits : BYTE;
          cAccumAlphaBits : BYTE;
          cDepthBits : BYTE;
          cStencilBits : BYTE;
          cAuxBuffers : BYTE;
          iLayerType : BYTE;
          bReserved : BYTE;
          dwLayerMask : DWORD;
          dwVisibleMask : DWORD;
          dwDamageMask : DWORD;
       end;
     PPIXELFORMATDESCRIPTOR = ^PIXELFORMATDESCRIPTOR;       
     POINT = record
          x : LONG;
          y : LONG;
       end;
     TPOINT = POINT;
     RECT = record
          case Integer of
             0: (Left,Top,Right,Bottom : Longint);
             1: (TopLeft,BottomRight : TPoint);
       end;
     TRECT = RECT;
     LPRECT = ^RECT;     
     WNDPROC = function (_para1:HWND; _para2:UINT; _para3:WPARAM; _para4:LPARAM):LRESULT;stdcall;     
     WNDCLASSEX = record
          cbSize : UINT;
          style : UINT;
          lpfnWndProc : WNDPROC;
          cbClsExtra : longint;
          cbWndExtra : longint;
          hInstance : HANDLE;
          hIcon : HICON;
          hCursor : HCURSOR;
          hbrBackground : HBRUSH;
          lpszMenuName : LPCTSTR;
          lpszClassName : LPCTSTR;
          hIconSm : HANDLE;
       end;
     LPWNDCLASSEX = ^WNDCLASSEX;       
     MSG = record
          hwnd : HWND;
          message : UINT;
          wParam : WPARAM;
          lParam : LPARAM;
          time : DWORD;
          pt : POINT;
       end;
     TMSG = MSG;
     LPMSG = ^MSG;       
     FARPROC = pointer;

     FILETIME = record
          dwLowDateTime : DWORD;
          dwHighDateTime : DWORD;
       end;
     LPFILETIME = ^FILETIME;
     _FILETIME = FILETIME;
     TFILETIME = FILETIME;
     PFILETIME = ^FILETIME;

     WIN32_FIND_DATA = record
          dwFileAttributes : DWORD;
          ftCreationTime : FILETIME;
          ftLastAccessTime : FILETIME;
          ftLastWriteTime : FILETIME;
          nFileSizeHigh : DWORD;
          nFileSizeLow : DWORD;
          dwReserved0 : DWORD;
          dwReserved1 : DWORD;
          cFileName : array[0..(MAX_PATH)-1] of TCHAR;
          cAlternateFileName : array[0..13] of TCHAR;
       end;
     LPWIN32_FIND_DATA = ^WIN32_FIND_DATA;
     PWIN32_FIND_DATA = ^WIN32_FIND_DATA;
     _WIN32_FIND_DATA = WIN32_FIND_DATA;
     TWIN32FINDDATA = WIN32_FIND_DATA;
     TWIN32FINDDATAA = WIN32_FIND_DATA;
     WIN32FINDDATAA = WIN32_FIND_DATA;
     PWIN32FINDDATA = ^WIN32_FIND_DATA;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

function AdjustWindowRect(lpRect:LPRECT; dwStyle:DWORD; bMenu:WINBOOL):WINBOOL; stdcall; external 'user32' name 'AdjustWindowRect';
function ChoosePixelFormat(_para1:HDC; _para2:PPIXELFORMATDESCRIPTOR):longint; stdcall; external 'gdi32' name 'ChoosePixelFormat';
function CloseClipboard:WINBOOL; stdcall; external 'user32' name 'CloseClipboard';
function CreateWindowExA(dwExStyle:DWORD; lpClassName:LPCSTR; lpWindowName:LPCSTR; dwStyle:DWORD; X:longint;Y:longint; nWidth:longint; nHeight:longint; hWndParent:HWND; hMenu:HMENU;hInstance:HINST; lpParam:LPVOID):HWND; stdcall; external 'user32' name 'CreateWindowExA';
function DefWindowProcA(hWnd:HWND; Msg:UINT; wParam:WPARAM; lParam:LPARAM):LRESULT; stdcall; external 'user32' name 'DefWindowProcA';
function DispatchMessageA(lpMsg:LPMSG):LONG; stdcall; external 'user32' name 'DispatchMessageA';
function EmptyClipboard:WINBOOL; stdcall; external 'user32' name 'EmptyClipboard';
function EnumDisplaySettingsA(lpszDeviceName:LPCSTR; iModeNum:DWORD; lpDevMode:LPDEVMODE):WINBOOL; stdcall; external 'user32' name 'EnumDisplaySettingsA';
function GetClipboardData(uFormat:UINT):HANDLE; stdcall; external 'user32' name 'GetClipboardData';
function GetCursorPos(lpPoint:LPPOINT):WINBOOL; stdcall; external 'user32' name 'GetCursorPos';
function GetDC(hWnd:HWND):HDC;stdcall; external 'user32' name 'GetDC';
function GetKeyState(nVirtKey:longint):SHORT;stdcall; external 'user32' name 'GetKeyState';
function GetWindowLongA(hWnd:HWND; nIndex:longint):LONG; stdcall; external 'user32' name 'GetWindowLongA';
function GetWindowRect(hWnd:HWND; lpRect:LPRECT):WINBOOL; stdcall; external 'user32' name 'GetWindowRect';
function GlobalAlloc(uFlags:UINT; dwBytes:DWORD):HGLOBAL; stdcall; external 'kernel32' name 'GlobalAlloc';
function GlobalLock(hMem:HGLOBAL):LPVOID; stdcall; external 'kernel32' name 'GlobalLock';
function GlobalUnlock(hMem:HGLOBAL):WINBOOL; stdcall; external 'kernel32' name 'GlobalUnlock';
function IsClipboardFormatAvailable(format:UINT):WINBOOL; stdcall; external 'user32' name 'IsClipboardFormatAvailable';
function LoadCursorA(hInstance:HINST; lpCursorName:LPCSTR):HCURSOR; stdcall; external 'user32' name 'LoadCursorA';
function MoveWindow(hWnd:HWND; X:longint; Y:longint; nWidth:longint; nHeight:longint;bRepaint:WINBOOL):WINBOOL; stdcall; external 'user32' name 'MoveWindow';
function OpenClipboard(hWndNewOwner:HWND):WINBOOL; stdcall; external 'user32' name 'OpenClipboard';
function PeekMessageA(lpMsg:LPMSG; hWnd:HWND; wMsgFilterMin:UINT; wMsgFilterMax:UINT; wRemoveMsg:UINT):WINBOOL; stdcall; external 'user32' name 'PeekMessageA';
function RegisterClassExA(const _para1:WNDCLASSEX):ATOM; stdcall; external 'user32' name 'RegisterClassExA';
function SetClipboardData(uFormat:UINT; hMem:HANDLE):HANDLE; stdcall; external 'user32' name 'SetClipboardData';
function SetFocus(hWnd:HWND):HWND; stdcall; external 'user32' name 'SetFocus';
function SetForegroundWindow(hWnd:HWND):WINBOOL; stdcall; external 'user32' name 'SetForegroundWindow';
function SetPixelFormat(_para1:HDC; _para2:longint;_para3:PPIXELFORMATDESCRIPTOR):WINBOOL; stdcall; external 'gdi32' name 'SetPixelFormat';
function SetWindowLongA(hWnd:HWND; nIndex:longint; dwNewLong:LONG):LONG; stdcall; external 'user32' name 'SetWindowLongA';
function SetWindowTextA(hWnd:HWND; lpString:LPCSTR):WINBOOL; stdcall; external 'user32' name 'SetWindowTextA';
function SetWindowPos(hWnd:HWND; hWndInsertAfter:HWND; X:longint; Y:longint; cx:longint;cy:longint; uFlags:UINT):WINBOOL; stdcall; external 'user32' name 'SetWindowPos';
function ShowCursor(bShow:WINBOOL):longint; stdcall; external 'user32' name 'ShowCursor';
function ShowWindow(hWnd:HWND; nCmdShow:longint):WINBOOL; stdcall; external 'user32' name 'ShowWindow';
function SwapBuffers(_para1:HDC):WINBOOL; stdcall; external 'gdi32' name 'SwapBuffers';
function TranslateMessage(lpMsg:LPMSG):WINBOOL; stdcall; external 'user32' name 'TranslateMessage';
function UpdateWindow(hWnd:HWND):WINBOOL; stdcall; external 'user32' name 'UpdateWindow';
function wglCreateContext(_para1:HDC):HGLRC; stdcall; external 'opengl32' name 'wglCreateContext';
function wglMakeCurrent(_para1:HDC; _para2:HGLRC):WINBOOL; stdcall; external 'opengl32' name 'wglMakeCurrent';
function QueryPerformanceCounter(lpPerformanceCount:PLARGE_INTEGER):WINBOOL; stdcall; external 'kernel32' name 'QueryPerformanceCounter';
function QueryPerformanceFrequency(lpFrequency:PLARGE_INTEGER):WINBOOL; stdcall; external 'kernel32' name 'QueryPerformanceFrequency';
function SetCurrentDirectory(lpPathName:LPCSTR):WINBOOL; stdcall; external 'kernel32' name 'SetCurrentDirectoryA';
function GetCurrentDirectory(nBufferLength:DWORD; lpBuffer:LPSTR):DWORD; stdcall; external 'kernel32' name 'GetCurrentDirectoryA';
function FindFirstFile(lpFileName:LPCSTR; lpFindFileData:LPWIN32_FIND_DATA):HANDLE; stdcall; external 'kernel32' name 'FindFirstFileA';
function FindNextFile(hFindFile:HANDLE; lpFindFileData:LPWIN32_FIND_DATA):WINBOOL; stdcall; external 'kernel32' name 'FindNextFileA';
function FindClose(hFindFile:HANDLE):WINBOOL; stdcall; external 'kernel32' name 'FindClose';

{$IFNDEF FLAG_FPC}
// в free паскале уже встроены в язык кроссплатформенные критические секции
// critical sections
type
  TPthread_fastlock = record
    __status: LongInt;
    __spinlock: Integer;
  end;

  TRTLCriticalSection = record
    __m_reserved,
    __m_count:  Integer;
    __m_owner:  Pointer;
    __m_kind: Integer; // __m_kind := 0 fastlock, __m_kind := 1 recursive lock
    __m_lock: TPthread_fastlock;
  end;

procedure InitCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external 'kernel32.dll' name 'InitializeCriticalSection';
procedure EnterCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external 'kernel32.dll' name 'EnterCriticalSection';
procedure LeaveCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external 'kernel32.dll' name 'LeaveCriticalSection';
procedure DoneCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall; external 'kernel32.dll' name 'DeleteCriticalSection';
{$ENDIF}

// dynlibs
function LoadLibrary(lpLibFileName:LPCSTR):HINST; stdcall; external 'kernel32' name 'LoadLibraryA';
function GetProcAddress(hModule:HINST; lpProcName:LPCSTR):FARPROC; stdcall; external 'kernel32' name 'GetProcAddress';
function FreeLibrary(hLibModule:HINST):WINBOOL; stdcall; external 'kernel32' name 'FreeLibrary';

procedure ZeroMemory(Destination:PVOID; Length:DWORD);
function MAKEWORD(a,b : longint) : WORD;

implementation

procedure ZeroMemory(Destination:PVOID; Length:DWORD);
begin
  FillChar(Destination^,Length,#0);
end;

function MAKEWORD(a,b : longint) : WORD;
begin
   MAKEWORD:=WORD((BYTE(a)) or ((WORD(BYTE(b))) shl 8));
end;

end.


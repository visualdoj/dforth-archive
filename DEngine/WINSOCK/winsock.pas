unit winsock;

interface

uses
  windows;

const
  winsockdll = 'wsock32.dll';  

  WSADESCRIPTION_LEN = 256;
  WSASYS_STATUS_LEN = 128;

{$IFNDEF FLAG_FPC}{$REGION 'const'}{$ENDIF}
  {
  All Windows Sockets error constants are biased by WSABASEERR from
  the "normal"
  }
  WSABASEERR = 10000;

  {
  Windows Sockets definitions of regular Microsoft C error constants
  }
  WSAEINTR = WSABASEERR + 4;
  WSAEBADF = WSABASEERR + 9;
  WSAEACCES = WSABASEERR + 13;
  WSAEFAULT = WSABASEERR + 14;
  WSAEINVAL = WSABASEERR + 22;
  WSAEMFILE = WSABASEERR + 24;

  {
  Windows Sockets definitions of regular Berkeley error constants
  }
  WSAEWOULDBLOCK = WSABASEERR + 35;
  WSAEINPROGRESS = WSABASEERR + 36;
  WSAEALREADY = WSABASEERR + 37;
  WSAENOTSOCK = WSABASEERR + 38;
  WSAEDESTADDRREQ = WSABASEERR + 39;
  WSAEMSGSIZE = WSABASEERR + 40;
  WSAEPROTOTYPE = WSABASEERR + 41;
  WSAENOPROTOOPT = WSABASEERR + 42;
  WSAEPROTONOSUPPORT = WSABASEERR + 43;
  WSAESOCKTNOSUPPORT = WSABASEERR + 44;
  WSAEOPNOTSUPP = WSABASEERR + 45;
  WSAEPFNOSUPPORT = WSABASEERR + 46;
  WSAEAFNOSUPPORT = WSABASEERR + 47;
  WSAEADDRINUSE = WSABASEERR + 48;
  WSAEADDRNOTAVAIL = WSABASEERR + 49;
  WSAENETDOWN = WSABASEERR + 50;
  WSAENETUNREACH = WSABASEERR + 51;
  WSAENETRESET = WSABASEERR + 52;
  WSAECONNABORTED = WSABASEERR + 53;
  WSAECONNRESET = WSABASEERR + 54;
  WSAENOBUFS = WSABASEERR + 55;
  WSAEISCONN = WSABASEERR + 56;
  WSAENOTCONN = WSABASEERR + 57;
  WSAESHUTDOWN = WSABASEERR + 58;
  WSAETOOMANYREFS = WSABASEERR + 59;
  WSAETIMEDOUT = WSABASEERR + 60;
  WSAECONNREFUSED = WSABASEERR + 61;
  WSAELOOP = WSABASEERR + 62;
  WSAENAMETOOLONG = WSABASEERR + 63;
  WSAEHOSTDOWN = WSABASEERR + 64;
  WSAEHOSTUNREACH = WSABASEERR + 65;
  WSAENOTEMPTY = WSABASEERR + 66;
  WSAEPROCLIM = WSABASEERR + 67;
  WSAEUSERS = WSABASEERR + 68;
  WSAEDQUOT = WSABASEERR + 69;
  WSAESTALE = WSABASEERR + 70;
  WSAEREMOTE = WSABASEERR + 71;
  WSAEDISCON = WSABASEERR + 101;

  INADDR_ANY = $00000000;
  INADDR_LOOPBACK = $7F000001;
  INADDR_BROADCAST = $FFFFFFFF;

  AF_INET = 2;
  PF_INET = AF_INET;

  SOCKET_ERROR = -1;
  SOCK_STREAM = 1;
  SOCK_DGRAM = 2;

  IPPROTO_UDP = 17;

  SOL_SOCKET = $ffff;

  SO_BROADCAST = $0020;

  IOCPARM_MASK = $7f;
  IOC_VOID = $20000000;
  IOC_OUT = $40000000;
  IOC_IN = $80000000;
  IOC_INOUT = IOC_IN or IOC_OUT;
  FIONREAD =cardinal( IOC_OUT or
    ((4 and IOCPARM_MASK) shl 16) or
    (102 shl 8) or 127);
  FIONBIO = cardinal(IOC_IN or
    ((4 and IOCPARM_MASK) shl 16) or
    (102 shl 8) or 126);
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

type
tOS_INT  = LongInt;
u_long = dword;
pu_long = ^u_long;
PtrUint = Cardinal; // TODO: узнать что тут должно быть
TSocket = PtrUInt;
ptOS_INT = ^tOS_INT;
  u_short = word;
  u_char = char;

  TWSADATA = record
    wVersion : WORD;              { 2 byte, ofs 0 }
    wHighVersion : WORD;          { 2 byte, ofs 2 }
  {$ifdef win64}
    iMaxSockets : word;           { 2 byte, ofs 390 }
    iMaxUdpDg : word;             { 2 byte, ofs 392 }
    lpVendorInfo : pchar;         { 4 byte, ofs 396 }
    szDescription : array[0..WSADESCRIPTION_LEN] of char; { 257 byte, ofs 4 }
    szSystemStatus : array[0..WSASYS_STATUS_LEN] of char; { 129 byte, ofs 261 }
  {$else win64}
    szDescription : array[0..WSADESCRIPTION_LEN] of char; { 257 byte, ofs 4 }
    szSystemStatus : array[0..WSASYS_STATUS_LEN] of char; { 129 byte, ofs 261 }
    iMaxSockets : word;           { 2 byte, ofs 390 }
    iMaxUdpDg : word;             { 2 byte, ofs 392 }
    lpVendorInfo : pchar;         { 4 byte, ofs 396 }
  {$endif win64}
  end;

  SunB = packed record
    s_b1,s_b2,s_b3,s_b4 : u_char;
  end;

  SunW = packed record
   s_w1,s_w2 : u_short;
  end;

  TInAddr = record
    case integer of
      0 : (S_un_b : SunB);
      1 : (S_un_w : SunW);
      2 : (S_addr : u_long);
  end;

  TSockAddr = record
    case integer of
       0 : ( (* equals to sockaddr_in, size is 16 byte *)
            sin_family : SmallInt;                (* 2 byte *)
            sin_port : u_short;                   (* 2 byte *)
            sin_addr : TInAddr;                   (* 4 byte *)
            sin_zero : array[0..8-1] of char;     (* 8 byte *)
           );
       1 : ((* equals to sockaddr, size is 16 byte *)
            sa_family : Smallint; (* 2 byte *)
            sa_data : array[0..14-1] of char;    (* 14 byte *)
           );
  end;
  PSockAddr = ^TSockAddr;

const
  INVALID_SOCKET = TSocket(not(1));

function WSACleanup: tOS_INT; stdcall; external winsockdll name 'WSACleanup';
function WSAGetLastError:tOS_INT;stdcall;external winsockdll name 'WSAGetLastError';
function WSAStartup(wVersionRequired: word; var WSAData: TWSADATA): tOS_INT; stdcall; external winsockdll name 'WSAStartup';

function Accept(s:TSocket; addr: PSockAddr; addrlen : ptOS_INT) : TSocket;stdcall;external winsockdll name 'accept';
function Alosesocket(s:TSocket):tOS_INT;stdcall;external winsockdll name 'closesocket';
function Bind(s:TSocket; addr: PSockaddr;namelen:tOS_INT):tOS_INT;stdcall;external winsockdll name 'bind';
function Connect(s:TSocket; addr:PSockAddr; namelen:tOS_INT):tOS_INT;stdcall;external winsockdll name 'connect';
function IoctlSocket(s:TSocket; cmd:longint; argp:pu_long):tOS_INT;stdcall;external winsockdll name 'ioctlsocket'; { really a c-long }
function Listen(s:TSocket; backlog:tOS_INT):tOS_INT;stdcall;external winsockdll name 'listen';
function Recv(s:TSocket;buf:pointer; len:tOS_INT; flags:tOS_INT):tOS_INT;stdcall;external winsockdll name 'recv';
function Recvfrom(s:TSocket;buf:pointer; len:tOS_INT; flags:tOS_INT;from:PSockAddr; fromlen:ptOS_INT):tOS_INT;stdcall;  external winsockdll name 'recvfrom';
function Send(s:TSocket;buf:pointer; len:tOS_INT; flags:tOS_INT):tOS_INT;stdcall; external winsockdll name 'send';
function SendTo(s:TSocket; buf:pointer; len:tOS_INT; flags:tOS_INT;toaddr:PSockAddr; tolen:tOS_INT):tOS_INT;stdcall; external winsockdll name 'sendto';
function SetSockOpt(s:TSocket; level:tOS_INT; optname:tOS_INT;optval:pointer; optlen:tOS_INT):tOS_INT;stdcall; external winsockdll name 'setsockopt';
function Socket(af:tOS_INT; t:tOS_INT; protocol:tOS_INT):TSocket;stdcall; external winsockdll name 'socket';
function shutdown(s:TSocket; how:tOS_INT):tOS_INT;stdcall;
      external winsockdll name 'shutdown';
function closesocket(s:TSocket):tOS_INT;stdcall;external winsockdll name 'closesocket'; 

function Inet_ntoa(i : TInAddr):pchar;stdcall;external winsockdll name 'inet_ntoa';
function Inet_addr(cp:pchar):cardinal;stdcall;external winsockdll name 'inet_addr';
function ntohs(netshort:u_short):u_short;stdcall;external winsockdll name 'ntohs';
function htons(hostshort:u_short):u_short;stdcall;external winsockdll name 'htons';


implementation

end.

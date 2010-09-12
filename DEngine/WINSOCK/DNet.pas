unit DNet;

interface

uses
  windows,
  winsock,

  DUtils,
  DDebug,
  DParser;

const
  IP_ANY:        TString = ''; // когда адрес не важен
  IP_BROADCAST:  TString = '255.255.255.255'; // рассылка всем компам в LAN
  IP_LOOPBACK:   TString = '127.0.0.1'; // отправка самому себе

type
TSockApi = class;

TNetAddress = record
  IP: TString;
  Port: Word;
end;

TPacket = TData;
TSocketUDP = class
private
  FSID: winsock.TSocket;
  FReady: Boolean;
  FPort: Word;
public
  constructor Create(Api: TSockApi);
  destructor Destroy; override;
  procedure SetPort(Port: Word);
  function Send(const Address: TNetAddress; const Packet: TPacket): Boolean;
  function Recv(var Address: TNetAddress; var Packet: TPacket): Boolean;
  function Broadcast(const Port: Word; const Packet: TPacket): Boolean;
  property Ready: Boolean read FReady write FReady;
  property Port: Word read FPort write FPort;
end;

TSocketTCP = class
private
  FApi: TSockApi;
  FSID: winsock.TSocket;
  FOposite: TNetAddress;
  FConnected: Boolean;
  FListening: Boolean;
  FBuf: array of Byte;
  FCurBufSize: Integer;
public
  constructor Create(Api: TSockApi; 
                     SID: winsock.TSocket; 
                     Address: TNetAddress); overload;
  constructor Create(Api: TSockApi); overload;
  destructor Destroy; override;
  function Connect(const Address: TNetAddress): Boolean;
  procedure Disconnect;
  function Listen(const Port: Word; const BackLog: Word = 10): Boolean;
  function Accept(out Socket: TSocketTCP): Boolean;
  procedure StopListen;
  function Send(const Packet: TPacket): Boolean;
  function Recv(var Packet: TPacket): Boolean;
  property Oposite: TNetAddress read FOposite;
  property Connected: Boolean read FConnected;
  property Listening: Boolean read FListening;
end;

TSockApi = class
private
  FReady: Boolean;
public
  constructor Create;
  destructor Destroy; override;
end;

function GetWinSockErrorStr(Error: Integer): TString;
function CheckError(R: Integer): Boolean;

// можно вызывать и так: NA('234.76.12.65:3456')
function NA(IP: TString; Port: Word = 0): TNetAddress;

function NA2sockaddr(NA: TNetAddress): TSockAddr;
function sockaddr2NA(Addr: TSockAddr): TNetAddress;
function NA2Str(NA: TNetAddress): TString;

implementation

{$IFNDEF FLAG_FPC}{$REGION 'utils'}{$ENDIF}
function GetWinSockErrorStr(Error: Integer): TString;
begin
  case Error of
    WSAEINTR: Result := 'WSAEINTR';
    WSAEBADF: Result := 'WSAEBADF';
    WSAEACCES: Result := 'WSAEACCES';
    WSAEDISCON: Result := 'WSAEDISCON';
    WSAEFAULT: Result := 'WSAEFAULT';
    WSAEINVAL: Result := 'WSAEINVAL';
    WSAEMFILE: Result := 'WSAEMFILE';
    WSAEWOULDBLOCK: Result := 'WSAEWOULDBLOCK';
    WSAEINPROGRESS: Result := 'WSAEINPROGRESS';
    WSAEALREADY: Result := 'WSAEALREADY';
    WSAENOTSOCK: Result := 'WSAENOTSOCK';
    WSAEDESTADDRREQ: Result := 'WSAEDESTADDRREQ';
    WSAEMSGSIZE: Result := 'WSAEMSGSIZE';
    WSAEPROTOTYPE: Result := 'WSAEPROTOTYPE';
    WSAENOPROTOOPT: Result := 'WSAENOPROTOOPT';
    WSAEPROTONOSUPPORT: Result := 'WSAEPROTONOSUPPORT';
    WSAESOCKTNOSUPPORT: Result := 'WSAESOCKTNOSUPPORT';
    WSAEOPNOTSUPP: Result := 'WSAEOPNOTSUPP';
    WSAEPFNOSUPPORT: Result := 'WSAEPFNOSUPPORT';
    WSAEAFNOSUPPORT: Result := 'WSAEAFNOSUPPORT';
    WSAEADDRINUSE: Result := 'WSAEADDRINUSE';
    WSAEADDRNOTAVAIL: Result := 'WSAEADDRNOTAVAIL';
    WSAENETDOWN: Result := 'WSAENETDOWN';
    WSAENETUNREACH: Result := 'WSAENETUNREACH';
    WSAENETRESET: Result := 'WSAENETRESET';
    WSAECONNABORTED: Result := 'WSWSAECONNABORTEDAEINTR';
    WSAECONNRESET: Result := 'WSAECONNRESET';
    WSAENOBUFS: Result := 'WSAENOBUFS';
    WSAEISCONN: Result := 'WSAEISCONN';
    WSAENOTCONN: Result := 'WSAENOTCONN';
    WSAESHUTDOWN: Result := 'WSAESHUTDOWN';
    WSAETOOMANYREFS: Result := 'WSAETOOMANYREFS';
    WSAETIMEDOUT: Result := 'WSAETIMEDOUT';
    WSAECONNREFUSED: Result := 'WSAECONNREFUSED';
    WSAELOOP: Result := 'WSAELOOP';
    {WSAENAMETOOLONG: Result := 'WSAENAMETOOLONG';
    WSAEHOSTDOWN: Result := 'WSAEHOSTDOWN';
    WSASYSNOTREADY: Result := 'WSASYSNOTREADY';
    WSAVERNOTSUPPORTED: Result := 'WSAVERNOTSUPPORTED';
    WSANOTINITIALISED: Result := 'WSANOTINITIALISED';
    WSAHOST_NOT_FOUND: Result := 'WSAHOST_NOT_FOUND';
    WSATRY_AGAIN: Result := 'WSATRY_AGAIN';
    WSANO_RECOVERY: Result := 'WSANO_RECOVERY';
    WSANO_DATA: Result := 'WSANO_DATA';}
  else
    Result := 'UNKNOWN';
  end;  
end;

function CheckError(R: Integer): Boolean;
  var
    Error: Integer;
begin
  Result := R = 0;
  if not Result then begin
    Error := WSAGetLastError;
    Debug.Error('DNet: winsock error ' + IntToStr(Error) + ' ' + 
                                         GetWinSockErrorStr(Error));
    Debug.LogStack;
  end;
end;

function NA(IP: TString; Port: Word = 0): TNetAddress;
  var
    I, P: TString;
begin
  if (Port = 0) and (Pos(':', IP) <> 0) then begin
    ParseBinary(IP, ':', I, P);
    IP := I; 
    Port := StrToInt(P);
  end;
  Result.IP := IP;
  Result.Port := Port;
end;

function NA2sockaddr(NA: TNetAddress): TSockAddr;
begin
  if NA.IP = '' then
    Result.sin_addr.S_addr := INADDR_ANY
  else
    Result.sin_addr.S_addr := inet_addr(PChar(NA.IP));
  Result.sin_port        := htons(NA.Port);
  Result.sin_family      := AF_INET;  
  FillChar(Result.sin_zero, SizeOf(Result.sin_zero), 0);
end;

function sockaddr2NA(Addr: TSockAddr): TNetAddress;
begin
  Result.IP   := inet_ntoa(Addr.sin_addr);
  Result.Port := ntohs(Addr.sin_port);
end;

function NA2Str(NA: TNetAddress): TString;
begin
  Result := NA.IP + ':' + IntToStr(NA.Port);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TSocketUDP'}{$ENDIF}
constructor TSocketUDP.Create(Api: TSockApi);
  var
    I: Integer;
begin
  FPort := Port;
  FReady := False;
  FSID := Socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  I := 1;
  SetSockopt(FSID, SOL_SOCKET, SO_BROADCAST, PChar(@I), SizeOf(I));
  if ioctlsocket(FSID, Longint(FIONBIO), @I) = -1 then
    Exit;  
  FReady := True;
end;

destructor TSocketUDP.Destroy;
begin
  //shutdown(FSID, 2);
  closesocket(FSID);
end;

procedure TSocketUDP.SetPort(Port: Word);
  var
    Address: TSockAddr;
begin
  Address := NA2sockaddr(NA(IP_ANY, Port));
  FReady := CheckError(WinSock.Bind(FSID, @address, sizeof(Address)));
end;

function TSocketUDP.Send(const Address: TNetAddress; const Packet: TPacket): Boolean;
  var
    SockAddr: TSockAddr;
begin
  SockAddr := NA2SockAddr(Address);
  Result := SendTo(FSID, Packet.GetData, Packet.GetSize, 0, 
                   @SockAddr, SizeOf(SockAddr)) <> 0;
  Packet.Rewind;
end;

function TSocketUDP.Recv(var Address: TNetAddress; var Packet: TPacket): Boolean;
  var
    SockAddr: TSockAddr;
    Count: Integer;
    AddrLen: Integer;
begin
  Result := False;
  AddrLen := SizeOf(SockAddr);
  Count := RecvFrom(FSID, Packet.GetData, Packet.Reserved, 0,
                    @SockAddr, @AddrLen);
  if Count < 0 then begin
    CheckError(0); // error
    Exit;
  end;
  if Count = 0 then
    Exit; // no packets
  Packet.Size := Count;
  Address := SockAddr2NA(SockAddr);
  Result := True;
end;

function TSocketUDP.Broadcast(const Port: Word; const Packet: TPacket): Boolean;
begin
  Result := Send(NA(IP_BROADCAST, Port), Packet);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TSocketTCP'}{$ENDIF}
constructor TSocketTCP.Create(Api: TSockApi; SID: winsock.TSocket; Address: TNetAddress);
  var
    I: Integer;
begin
  SetLength(FBuf, 1024*64);
  FCurBufSize := 0;
  FApi := Api;
  FSID := SID;
  FOposite := Address;
  FConnected := FOposite.IP <> '';
  I := 1;
  if ioctlsocket(FSID, LongInt(FIONBIO), @I) = -1 then
    Exit;
end;

constructor TSocketTCP.Create(Api: TSockApi);
begin
  Create(Api, socket(PF_INET, SOCK_STREAM, 0), NA('', 0));
end;

destructor TSocketTCP.Destroy;
begin
end;

function TSocketTCP.Connect(const Address: TNetAddress): Boolean;
  var
    SockAddr: TSockAddr;
    Error: Integer;
begin
  SockAddr := NA2SockAddr(Address);
  if WinSock.Connect(FSID, @SockAddr, SizeOf(TSockAddr)) <> 0 then begin
    Error := WSAGetLastError;
    Result := Error = WSAEWOULDBLOCK; 
    if not Result then
      CheckError(Error);
  end else
    Result := True;
  if Result then
    FOposite := Address;
  FConnected := Result;
end;

procedure TSocketTCP.Disconnect;
begin
  // TODO
end;

function TSocketTCP.Listen(const Port: Word; const BackLog: Word = 10): Boolean;
  var
    SockAddr: TSockAddr;
begin
  SockAddr := NA2SockAddr(NA('', Port));
  Result := CheckError(WinSock.Bind(FSID, @SockAddr, sizeof(SockAddr)));
  if Result then 
    Result := CheckError(WinSock.Listen(FSID, BackLog));
end;

function TSocketTCP.Accept(out Socket: TSocketTCP): Boolean;
  var
    Address: TSockAddr;
    ASize: Integer;
    SID: Integer;
begin
  ASize := SizeOf(Address);
  SID := WinSock.Accept(FSID, @Address, @ASize);
  Result := SID > 0;
  if Result then
    Socket := TSocketTCP.Create(FApi, SID, sockaddr2NA(Address));
end;

procedure TSocketTCP.StopListen;
begin
  // TODO
end;

function TSocketTCP.Send(const Packet: TPacket): Boolean;
  var
    Tmp: array[0..1024*64 - 1] of Byte;
    Size: Word;
begin
  Move(Packet.GetData^, Tmp[SizeOf(Word)], Packet.GetSize);
  //Tmp[1] := Packet.GetSize and $FF;
  //Tmp[0] := (Packet.GetSize shl 8) and $FF;
  Size := Packet.GetSize;
  Move(Size, Tmp[0], SizeOf(Word));
  Result := winsock.Send(FSID, @Tmp[0], Packet.GetSize + SizeOf(Word), 0) > 0;
end;

function TSocketTCP.Recv(var Packet: TPacket): Boolean;
  var
    Count: Integer;
    PacketSize: Word;
    I: Integer;
begin
  //Debug.LogStack;
  Result := False;
  Count := winsock.Recv(FSID, 
                        @FBuf[FCurBufSize], 
                        Length(FBuf) - FCurBufSize, 
                        0);
  (* TODO check error *)
  (* if Count < 0 then *)
  (*   Exit; *)
  if Count > 0 then
    FCurBufSize := FCurBufSize + Count;
  if FCurBufSize < SizeOf(Word) then
    Exit;
  Move(FBuf[0], PacketSize, SizeOf(Word));
  Log('tcp packet recv size ' + IntToStr(PacketSize));
  if PacketSize + SizeOf(Word) <= FCurBufSize then begin
    Packet.Clear;
    Packet.WriteVar(@FBuf[SizeOf(Word)], PacketSize);
    Packet.Rewind;
    Result := True;
    for I := 0 to FCurBufSize - SizeOf(Word) - PacketSize - 1 do
      FBuf[I] := FBuf[PacketSize + SizeOf(Word) + I];
    //Move(FBuf[2 + PacketSize], FBuf[0], FCurBufSize - 2 - PacketSize);
    FCurBufSize := FCurBufSize - PacketSize - SizeOf(Word);
  end;
  // winsock.Recv(FSID, Packet.GetData, Packet.Reserved, 0);
  //Packet.Size := Count;
  //Packet.Rewind;
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

{$IFNDEF FLAG_FPC}{$REGION 'TSockApi'}{$ENDIF}
constructor TSockApi.Create;
  Var
    winsock_version: Word;
    winsock_data: TWSADATA;
begin
  winsock_version := MAKEWORD(1, 0);
  FReady := CheckError(WSAStartup(winsock_version, winsock_data));
end;

destructor TSockApi.Destroy;
begin
  CheckError(WSACleanup);
end;
{$IFNDEF FLAG_FPC}{$ENDREGION}{$ENDIF}

end.

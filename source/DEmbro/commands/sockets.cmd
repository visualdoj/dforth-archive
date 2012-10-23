DECLARE(ssocket)
  NOTATION(( domain xtype protocol -- socket))
  RUS( создаёт сокет с заданными параметрами.) ENDRUS
  ENG( creates a new socket using passed parameters. ) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(2*CELL); TInt(WVar(-CELL)) := fpSocket(TInt(WVar(-CELL)), TInt(WVar(0)), TInt(WVar(CELL)));) ENDPASCAL

DECLARE(saccept)
  NOTATION(( socket address address# -- socket))
  RUS( принимает подключение от сокета socket, который находится в состоянии прослушивания.) ENDRUS
  ENG( accepts a connection from the socket, which was listening for a connection. ) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(2*CELL); TInt(WVar(-CELL)) := fpAccept(TInt(WVar(-CELL)), Pointer(WVar(0)), Pointer(WVar(CELL)));) ENDPASCAL

DECLARE(sbind)
  NOTATION(( socket address address# -- error))
  RUS( привязывает сокет к заданному адресу.) ENDRUS
  ENG( binds the socket to the address.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(2*CELL); TInt(WVar(-CELL)) := fpBind(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)));) ENDPASCAL

DECLARE(sclose)
  NOTATION(( socket -- error))
  RUS( закрывает сокет s. В случае успеха возвращает 0, иначе ошибку e) ENDRUS
  ENG( closes a socket handle. It returns 0 if the socket was closed succesfully, othewise if it failed. ) ENDENG
  EPO( ) ENDEPO
  PASCAL body( ) ENDPASCAL

DECLARE(sconnect)
  NOTATION(( socket address address# -- error))
  RUS( использует сокет для подключения к адресу address.) ENDRUS
  ENG( uses the socket to open a connection to a peer, whose address is described by address. ) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(2*CELL); TInt(WVar(-CELL)) := fpConnect(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)));) ENDPASCAL

DECLARE(serror)
  NOTATION(( -- code))
  RUS( возвращает код последней ошибки.) ENDRUS
  ENG( returns last error code. ) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WUI(SocketError); ) ENDPASCAL

DECLARE(sgetsockopt)
  NOTATION(( socket level optname optval optlen -- error?))
  RUS( возвращает опции соединения для сокета.) ENDRUS
  ENG( gets the connection options for socket.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(4*CELL); TInt(WVar(-CELL)) := fpGetSockOpt(TInt(WVar(-CELL)), TInt(WVar(0)), TInt(WVar(CELL)), Pointer(WVar(2*CELL)), Pointer(WVar(3*CELL)));) ENDPASCAL

DECLARE(slisten)
  NOTATION(( socket backlog -- error))
  RUS( переводит сокет в режим прослушивания не более backlog соединений единовременно.) ENDRUS
  ENG( listens for up to backlog connections from socket.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(CELL); TInt(WVar(-CELL)) := fpListen(TInt(WVar(-CELL)), TInt(WVar(0)));) ENDPASCAL

DECLARE(srecv)
  NOTATION(( socket message maxmessage# flags -- message#))
  RUS( читает не более message# байт из сокета socket в память message. Сокет должен быть в подключенном состоянии) ENDRUS
  ENG( reads at most maxmessage# bytes from socket into address message. The socket must be in a connected state.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(3*CELL); TInt(WVar(-CELL)) := fpRecv(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)), TInt(WVar(2*CELL)));) ENDPASCAL

DECLARE(srecvfrom)
  NOTATION(( socket message maxmessage# flags address address# -- message#))
  RUS( получает данные в message максимальной длинны maxmessage# из сокета socket. Адрес отправителя записывается в память address, а его длина будет записана в память addresss#.) ENDRUS
  ENG( receives data in buffer message with maximum length maxmessage# from socket S. The location pointed to by from will be filled with the address from the sender, and it's length will be stored in fromlen.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(5*CELL); TInt(WVar(-CELL)) := fpRecvFrom(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)), TInt(WVar(2*CELL)), Pointer(WVar(3*CELL)), Pointer(WVar(4*CELL)));) ENDPASCAL

DECLARE(sshutdown)
  NOTATION(( socket how -- error))
  RUS( закрывает одно из направлений сокета. how: 0 - вход, 1 - выход, 2 - оба направления) ENDRUS
  ENG( closes socket directions. how: 0 - input, 1 - output, 2 - both) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(CELL); TInt(WVar(-CELL)) := fpShutdown(TInt(WVar(-CELL)), TInt(WVar(0))); ) ENDPASCAL

DECLARE(ssend)
  NOTATION(( socket message message# flags -- sent#))
  RUS( отправляет message# байт, начинающихся с адреса message, на сокет socket. Сокет должен быть в подключённом состоянии.) ENDRUS
  ENG( sends message# bytes starting from address message to socket. Socket must be in a connected state.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(3*CELL); TInt(WVar(-CELL)) := fpSend(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)), TInt(WVar(2*CELL)));) ENDPASCAL

DECLARE(ssendto)
  NOTATION(( socket message message# flags address address# -- sent#))
  RUS( отправляет message# байт, начинающихся с адреса message, через сокет socket по адрессу address.) ENDRUS
  ENG( sends data from buffer message with length message# through socket.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(5*CELL); TInt(WVar(-CELL)) := fpSendTo(TInt(WVar(-CELL)), Pointer(WVar(0)), TInt(WVar(CELL)), TInt(WVar(2*CELL)), Pointer(WVar(3*CELL)), TInt(WVar(4*CELL)));) ENDPASCAL

DECLARE(ssetsockopt)
  NOTATION(( socket level optname optval optlen -- error?))
  RUS( устанавливает опции соединения для сокета.) ENDRUS
  ENG( sets the connection options for socket.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( WDec(4*CELL); TInt(WVar(-CELL)) := fpSetSockOpt(TInt(WVar(-CELL)), TInt(WVar(0)), TInt(WVar(CELL)), Pointer(WVar(2*CELL)), TInt(WVar(3*CELL)));) ENDPASCAL

DECLARE(htonl)
  NOTATION(( hostcell -- netcell))
  RUS( меняет порядок младших четырёх байтов с локального на сетевой.) ENDRUS
  ENG( makes sure that the bytes in hostcell are ordered in the correct way for sending over the network and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( TInt(WVar(-CELL)) := htonl(TInt(WVar(-CELL))); ) ENDPASCAL

DECLARE(htons)
  NOTATION(( hostcell -- netcell))
  RUS( меняет порядок младших двух байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in hostcell are ordered in the correct way for sending over the network and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( TInt(WVar(-CELL)) := htons(TInt(WVar(-CELL))); ) ENDPASCAL

DECLARE(ntohl)
  NOTATION(( netcell -- hostcell))
  RUS( меняет порядок младших четырёх байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in netcell, received from the network, are ordered in the correct way for handling by the host machinen, and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( TInt(WVar(-CELL)) := ntohl(TInt(WVar(-CELL))); ) ENDPASCAL

DECLARE(ntohs)
  NOTATION(( netcell -- hostcell))
  RUS( меняет порядок младших двух байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in netcell, received from the network, are ordered in the correct way for handling by the host machinen, and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  PASCAL body( TInt(WVar(-CELL)) := ntohs(TInt(WVar(-CELL))); ) ENDPASCAL


define(`DECLARE_CONST', `DECLARE($1, ifelse($2,`',_$1,_$2))
  NOTATION((-i))
  PASCAL body( WUI(Integer(ifelse($2,`',$1,$2))); ) ENDPASCAL')

DECLARE_CONST(AF_APPLETALK)                 ENG(Addressfamily Appletalk DDP) ENDENG
dnl DECLARE_CONST(AF_ASH)                       ENG(Addressfamily: Ash) ENDENG
dnl DECLARE_CONST(AF_ATMPVC)                    ENG(Addressfamily: ATMPVCs) ENDENG
dnl DECLARE_CONST(AF_ATMSVC)                    ENG(Addressfamily: ATMSVCs) ENDENG
dnl DECLARE_CONST(AF_AX25)                      ENG(Addressfamily Amateur RadioAX.25) ENDENG
DECLARE_CONST(AF_BLUETOOTH)                 ENG(Addressfamily: Bluetoothsockets) ENDENG
dnl DECLARE_CONST(AF_BRIDGE)                    ENG(Addressfamily Multiprotocol bridge) ENDENG
DECLARE_CONST(AF_DECnet)                    ENG(Addressfamily: Reservedfor DECnetproject.) ENDENG
dnl DECLARE_CONST(AF_ECONET)                    ENG(Addressfamily: AcornEconet) ENDENG
DECLARE_CONST(AF_INET)                      ENG(Addressfamily Internet IPProtocol) ENDENG
DECLARE_CONST(AF_INET6)                     ENG(Addressfamily IPversion 6) ENDENG
DECLARE_CONST(AF_IPX)                       ENG(Addressfamily NovellIPX) ENDENG
dnl DECLARE_CONST(AF_IRDA)                      ENG(Addressfamily: IRDA sockets) ENDENG
dnl DECLARE_CONST(AF_KEY)                       ENG(Addressfamily: PF_KEYkey management API) ENDENG
dnl DECLARE_CONST(AF_LLC)                       ENG(Addressfamily: Linux LLC) ENDENG
DECLARE_CONST(AF_LOCAL)                     ENG(Addressfamily: Unix socket) ENDENG
DECLARE_CONST(AF_MAX)                       ENG(Addressfamily Maximumvalue) ENDENG
dnl DECLARE_CONST(AF_NETBEUI)                   ENG(Addressfamily: Reserved for 802.2LLC project) ENDENG
dnl DECLARE_CONST(AF_NETLINK)                   ENG(Addressfamily: ?) ENDENG
dnl DECLARE_CONST(AF_NETROM)                    ENG(Addressfamily Amateur radioNetROM) ENDENG
dnl DECLARE_CONST(AF_PACKET)                    ENG(Addressfamily: Packet family) ENDENG
dnl DECLARE_CONST(AF_PPPOX)                     ENG(Addressfamily: PPPoXsockets) ENDENG
dnl DECLARE_CONST(AF_ROSE)                      ENG(Addressfamily: Amateur RadioX.25PLP) ENDENG
DECLARE_CONST(AF_ROUTE)                     ENG(Addressfamily: Aliastoemulate4.4BSD.) ENDENG
dnl DECLARE_CONST(AF_SECURITY)                  ENG(Addressfamily: Security callback pseudoAF) ENDENG
DECLARE_CONST(AF_SNA)                       ENG(Addresssfamily: Linux SNAproject) ENDENG
dnl DECLARE_CONST(AF_TIPC)                      ENG(Addressfamily: TIPCsockets) ENDENG
DECLARE_CONST(AF_UNIX)                      ENG(Addressfamily Unix domain sockets) ENDENG
DECLARE_CONST(AF_UNSPEC)                    ENG(Addressfamily Not specified) ENDENG
dnl DECLARE_CONST(AF_WANPIPE)                   ENG(Addressfamily: WanpipeAPI Sockets) ENDENG
dnl DECLARE_CONST(AF_X25)                       ENG(Addressfamily Reservedfor X.25projec) ENDENG
DECLARE_CONST(EsockEACCESS)                 ENG(Accessforbidden erro) ENDENG
DECLARE_CONST(EsockEBADF)                   ENG(Alias: badfile descripto) ENDENG
DECLARE_CONST(EsockEFAULT)                  ENG(Alias: anerror occurre) ENDENG
DECLARE_CONST(EsockEINTR)                   ENG(Alias:operationinterrupte) ENDENG
DECLARE_CONST(EsockEINVAL)                  ENG(Alias: Invalidvaluespecifie) ENDENG
DECLARE_CONST(EsockEMFILE)                  ENG(Error code ?) ENDENG
DECLARE_CONST(EsockEMSGSIZE)                ENG(Wrongmessagesizeerror) ENDENG
DECLARE_CONST(EsockENOBUFS)                 ENG(Nobufferspaceavailableerror) ENDENG
DECLARE_CONST(EsockENOTCONN)                ENG(Not connectederror) ENDENG
DECLARE_CONST(EsockENOTSOCK)                ENG(Filedescriptor isnot asocket error) ENDENG
DECLARE_CONST(EsockEPROTONOSUPPORT)         ENG(Protocolnot supported error) ENDENG
DECLARE_CONST(EsockEWOULDBLOCK)             ENG(Operationwouldblock error) ENDENG
DECLARE_CONST(INADDR_ANY)                   ENG(Abitmask matchingany IPaddressonthe local machine.) ENDENG
DECLARE_CONST(INADDR_NONE)                  ENG(Abitmask matchingnovalidIPaddress) ENDENG
DECLARE_CONST(IPPROTO_AH)                   ENG(authenticationheader.) ENDENG
dnl DECLARE_CONST(IPPROTO_COMP)                 ENG(CompressionHeader Protocol.) ENDENG
DECLARE_CONST(IPPROTO_DSTOPTS)              ENG(IPv6 destinationoptions.) ENDENG
DECLARE_CONST(IPPROTO_EGP)                  ENG(Exterior Gateway Protocol.) ENDENG
DECLARE_CONST(IPPROTO_ENCAP)                ENG(Encapsulation Header.) ENDENG
DECLARE_CONST(IPPROTO_ESP)                  ENG(encapsulatingsecurity payload.) ENDENG
DECLARE_CONST(IPPROTO_FRAGMENT)             ENG(IPv6 fragmentation header.) ENDENG
DECLARE_CONST(IPPROTO_GRE)                  ENG(General RoutingEncapsulation.) ENDENG
DECLARE_CONST(IPPROTO_HOPOPTS)              ENG(IPv6 Hop-by-Hop options.) ENDENG
DECLARE_CONST(IPPROTO_ICMP)                 ENG(Internet ControlMessage Protocol.) ENDENG
DECLARE_CONST(IPPROTO_ICMPV6)               ENG(ICMPv6.) ENDENG
DECLARE_CONST(IPPROTO_IDP)                  ENG(XNS IDPprotocol.) ENDENG
DECLARE_CONST(IPPROTO_IGMP)                 ENG(Internet GroupManagement Protocol.) ENDENG
DECLARE_CONST(IPPROTO_IP)                   ENG(Dummy protocolfor TCP.) ENDENG
DECLARE_CONST(IPPROTO_IPIP)                 ENG(IPIPtunnels(older KA9Qtunnelsuse 94).) ENDENG
DECLARE_CONST(IPPROTO_IPV6)                 ENG(IPv6 header.) ENDENG
DECLARE_CONST(IPPROTO_MAX)                  ENG(Maximumvaluefor IPPROTO options) ENDENG
DECLARE_CONST(IPPROTO_MTP)                  ENG(Multicast Transport Protocol.) ENDENG
DECLARE_CONST(IPPROTO_NONE)                 ENG(IPv6 nonext header.) ENDENG
DECLARE_CONST(IPPROTO_PIM)                  ENG(ProtocolIndependent Multicast.) ENDENG
DECLARE_CONST(IPPROTO_PUP)                  ENG(PUPprotocol.) ENDENG
DECLARE_CONST(IPPROTO_RAW)                  ENG(Raw IPpackets.) ENDENG
DECLARE_CONST(IPPROTO_ROUTING)              ENG(IPv6 routingheader.) ENDENG
DECLARE_CONST(IPPROTO_RSVP)                 ENG(ReservationProtocol.) ENDENG
dnl DECLARE_CONST(IPPROTO_SCTP)                 ENG(Stream ControlTransmissionProtocol.) ENDENG
DECLARE_CONST(IPPROTO_TCP)                  ENG(TransmissionControlProtocol.) ENDENG
DECLARE_CONST(IPPROTO_TP)                   ENG(SOTransport ProtocolClass 4.) ENDENG
DECLARE_CONST(IPPROTO_UDP)                  ENG(User DatagramProtocol.) ENDENG
dnl DECLARE_CONST(IPV6_ADDRFORM)                ENG(Change the IPV6 addressintoadifferent addressfamily. Deprecated) ENDENG
dnl DECLARE_CONST(IPV6_ADD_MEMBERSHIP)          ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_AUTHHDR)                 ENG(GetSockOpt/SetSockopt: Deliver authenticationheader messages) ENDENG
dnl DECLARE_CONST(IPV6_CHECKSUM)                ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_DROP_MEMBERSHIP)         ENG(UndocumentedGetsockoptoption?) ENDENG
DECLARE_CONST(IPV6_DSTOPTS)                 ENG(Deliver destinationoptioncontrolmessages) ENDENG
DECLARE_CONST(IPV6_HOPLIMIT)                ENG(Deliver aninteger containingthe HOPcount) ENDENG
DECLARE_CONST(IPV6_HOPOPTS)                 ENG(Deliver hopoptioncontrolmessages) ENDENG
dnl DECLARE_CONST(IPV6_IPSEC_POLICY)            ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_JOIN_ANYCAST)            ENG(UndocumentedGetsockoptoption?) ENDENG
DECLARE_CONST(IPV6_JOIN_GROUP)              ENG(GetSockOpt/SetSockopt: Controlmembership(joingroup)inmulticastgroups) ENDENG
dnl DECLARE_CONST(IPV6_LEAVE_ANYCAST)           ENG(UndocumentedGetsockoptoption?) ENDENG
DECLARE_CONST(IPV6_LEAVE_GROUP)             ENG(GetSockOpt/SetSockopt: Controlmembership(leavegroup)inmulticastgroups) ENDENG
dnl DECLARE_CONST(IPV6_MTU)                     ENG(GetSockOpt/SetSockopt: Get/Set the MTU for the socket) ENDENG
dnl DECLARE_CONST(IPV6_MTU_DISCOVER)            ENG(GetSockOpt/SetSockopt: Get/Set ControlpathMTU Discovery onthe socket) ENDENG
DECLARE_CONST(IPV6_MULTICAST_HOPS)          ENG(GetSockOpt/SetSockopt: Get/Set the multicasthoplimit.) ENDENG
DECLARE_CONST(IPV6_MULTICAST_IF)            ENG(GetSockOpt/SetSockopt: Get/Set devicefor multicastpackagesonthe socket.) ENDENG
DECLARE_CONST(IPV6_MULTICAST_LOOP)          ENG(GetSockOpt/SetSockopt: Controlwhether socket seesmulticastpackagesthat it hassentitself) ENDENG
DECLARE_CONST(IPV6_NEXTHOP)                 ENG(sendmsg: set next hopfor IPV6 datagram) ENDENG
DECLARE_CONST(IPV6_PKTINFO)                 ENG(Change delivery options for incoming IPV6 datagrams) ENDENG
DECLARE_CONST(IPV6_PKTOPTIONS)              ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_PMTUDISC_DO)             ENG(Always DF.) ENDENG
dnl DECLARE_CONST(IPV6_PMTUDISC_DONT)           ENG(Never sendDF frames.) ENDENG
dnl DECLARE_CONST(IPV6_PMTUDISC_WANT)           ENG(Useper route hints.) ENDENG
dnl DECLARE_CONST(IPV6_RECVERR)                 ENG(GetSockOpt/SetSockopt: Controlreceivingofasynchroneouserror options) ENDENG
dnl DECLARE_CONST(IPV6_ROUTER_ALERT)            ENG(GetSockOpt/SetSockopt: Get/Set Pass allforwardedpacketscontainingrouteralertoption) ENDENG
DECLARE_CONST(IPV6_RTHDR)                   ENG(Deliver routingheader controlmessages) ENDENG
dnl DECLARE_CONST(IPV6_RTHDR_LOOSE)             ENG(Hop doesn't needtobeneighbour.) ENDENG
dnl DECLARE_CONST(IPV6_RTHDR_STRICT)            ENG(Hop mustbeaneighbour.) ENDENG
dnl DECLARE_CONST(IPV6_RTHDR_TYPE_0)            ENG(IPv6 Routingheader type 0.) ENDENG
dnl DECLARE_CONST(IPV6_RXDSTOPTS)               ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_RXHOPOPTS)               ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(IPV6_RXSRCRT)                 ENG(UndocumentedGetsockoptoption?) ENDENG
DECLARE_CONST(IPV6_UNICAST_HOPS)            ENG(GetSockOpt/SetSockopt: Get/Set unicast hoplimit) ENDENG
dnl DECLARE_CONST(IPV6_V6ONLY)                  ENG(GetSockOpt/SetSockopt: HandleIPV6 connections only) ENDENG
dnl DECLARE_CONST(IPV6_XFRM_POLICY)             ENG(UndocumentedGetsockoptoption?) ENDENG
DECLARE_CONST(IP_ADD_MEMBERSHIP)            ENG(addanIPgroupmembership) ENDENG
dnl DECLARE_CONST(IP_ADD_SOURCE_MEMBERSHIP)     ENG(joinsource group) ENDENG
dnl DECLARE_CONST(IP_BLOCK_SOURCE)              ENG(block datafromsource) ENDENG
dnl DECLARE_CONST(IP_DEFAULT_MULTICAST_LOOP)    ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_DEFAULT_MULTICAST_TTL)     ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_DROP_MEMBERSHIP)           ENG(drop anIPgroupmembership) ENDENG
dnl DECLARE_CONST(IP_DROP_SOURCE_MEMBERSHIP)    ENG(leavesource group) ENDENG
DECLARE_CONST(IP_HDRINCL)                   ENG(Header isincluded with data.) ENDENG
dnl DECLARE_CONST(IP_MAX_MEMBERSHIPS)           ENG(Maximumgroupmembershipsfor multicastmessages) ENDENG
dnl DECLARE_CONST(IP_MSFILTER)                  ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_MTU_DISCOVER)              ENG(Undocumented?) ENDENG
DECLARE_CONST(IP_MULTICAST_IF)              ENG(set/get IPmulticasti/f) ENDENG
DECLARE_CONST(IP_MULTICAST_LOOP)            ENG(set/get IPmulticastloopback) ENDENG
DECLARE_CONST(IP_MULTICAST_TTL)             ENG(set/get IPmulticastttl) ENDENG
DECLARE_CONST(IP_OPTIONS)                   ENG(IPper-packet options.) ENDENG
dnl DECLARE_CONST(IP_PKTINFO)                   ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_PKTOPTIONS)                ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_PMTUDISC)                  ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(IP_PMTUDISC_DO)               ENG(Always DF.) ENDENG
dnl DECLARE_CONST(IP_PMTUDISC_DONT)             ENG(Never sendDF frames.) ENDENG
dnl DECLARE_CONST(IP_PMTUDISC_WANT)             ENG(Useper route hints.) ENDENG
dnl DECLARE_CONST(IP_RECVERR)                   ENG(Undocumented?) ENDENG
DECLARE_CONST(IP_RECVOPTS)                  ENG(ReceiveallIPoptions w/datagram.) ENDENG
DECLARE_CONST(IP_RECVRETOPTS)               ENG(ReceiveIPoptions for response.) ENDENG
dnl DECLARE_CONST(IP_RECVTOS)                   ENG(Undocumented?) ENDENG
DECLARE_CONST(IP_RECVTTL)                   ENG(Undocumented?) ENDENG
DECLARE_CONST(IP_RETOPTS)                   ENG(Set/get IPper-packet options.) ENDENG
dnl DECLARE_CONST(IP_ROUTER_ALERT)              ENG(Undocumented?) ENDENG
DECLARE_CONST(IP_TOS)                       ENG(IPtype ofserviceandprecedence.) ENDENG
DECLARE_CONST(IP_TTL)                       ENG(IPtime tolive.) ENDENG
dnl DECLARE_CONST(IP_UNBLOCK_SOURCE)            ENG(unblock datafromsource) ENDENG
dnl DECLARE_CONST(MCAST_BLOCK_SOURCE)           ENG(block fromgivengroup) ENDENG
dnl DECLARE_CONST(MCAST_EXCLUDE)                ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(MCAST_INCLUDE)                ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(MCAST_JOIN_GROUP)             ENG(joinany-source group) ENDENG
dnl DECLARE_CONST(MCAST_JOIN_SOURCE_GROUP)      ENG(joinsource-specgruoup) ENDENG
dnl DECLARE_CONST(MCAST_LEAVE_GROUP)            ENG(leaveany-source group) ENDENG
dnl DECLARE_CONST(MCAST_LEAVE_SOURCE_GROUP)     ENG(leavesource-specgroup) ENDENG
dnl DECLARE_CONST(MCAST_MSFILTER)               ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(MCAST_UNBLOCK_SOURCE)         ENG(unblock fromgivengroup) ENDENG
dnl DECLARE_CONST(MSG_CONFIRM)                  ENG(Sendflags:Conformconnection) ENDENG
DECLARE_CONST(MSG_CTRUNC)                   ENG(Receiveflags:ControlData was discarded(buffertoosmall)) ENDENG
DECLARE_CONST(MSG_DONTROUTE)                ENG(Sendflags:don't use gateway) ENDENG
DECLARE_CONST(MSG_DONTWAIT)                 ENG(Receiveflags:Non-blockingoperationrequest.) ENDENG
DECLARE_CONST(MSG_EOF)                      ENG(Aliasfor) ENDENG
DECLARE_CONST(MSG_EOR)                      ENG(Receiveflags:Endofrecord) ENDENG
dnl DECLARE_CONST(MSG_ERRQUERE)                 ENG(Receiveflags:?) ENDENG
dnl DECLARE_CONST(MSG_FIN)                      ENG(Receiveflags:?) ENDENG
dnl DECLARE_CONST(MSG_MORE)                     ENG(Receiveflags:?) ENDENG
DECLARE_CONST(MSG_NOSIGNAL)                 ENG(Receiveflags:SuppressSIG_PIPEsignal.) ENDENG
DECLARE_CONST(MSG_OOB)                      ENG(Receiveflags:receiveout-of-band data.) ENDENG
DECLARE_CONST(MSG_PEEK)                     ENG(Receiveflags:peek at data, don't removefrombuffer.) ENDENG
dnl DECLARE_CONST(MSG_PROXY)                    ENG(Receiveflags:?) ENDENG
dnl DECLARE_CONST(MSG_RST)                      ENG(Receiveflags:?) ENDENG
dnl DECLARE_CONST(MSG_SYN)                      ENG(Receiveflags:?) ENDENG
DECLARE_CONST(MSG_TRUNC)                    ENG(Receiveflags:packet Data was discarded(buffertoosmall)) ENDENG
dnl DECLARE_CONST(MSG_TRYHARD)                  ENG(Receiveflags:?) ENDENG
DECLARE_CONST(MSG_WAITALL)                  ENG(Receiveflags:Wait till operationcompleted.) ENDENG
DECLARE_CONST(NoAddress)                    ENG(Constant indicatinginvalid(no)network address.) ENDENG
dnl DECLARE_CONST(NoAddress6)                   ENG(Constant indicatinginvalid(no)IPV6 network address.) ENDENG
DECLARE_CONST(NoNet)                        ENG(Constant indicatinginvalid(no)network address.) ENDENG
dnl DECLARE_CONST(NoNet6)                       ENG(Constant indicatinginvalid(no)IPV6 network address.) ENDENG
DECLARE_CONST(PF_APPLETALK)                 ENG(Protocolfamily: Appletalk DDP) ENDENG
dnl DECLARE_CONST(PF_ASH)                       ENG(Protocolfamily: Ash) ENDENG
dnl DECLARE_CONST(PF_ATMPVC)                    ENG(Protocolfamily: ATMPVCs) ENDENG
dnl DECLARE_CONST(PF_ATMSVC)                    ENG(Protocolfamily: ATM SVCs) ENDENG
dnl DECLARE_CONST(PF_AX25)                      ENG(Protocolfamily: Amateur RadioAX.25) ENDENG
DECLARE_CONST(PF_BLUETOOTH)                 ENG(Protocolfamily: Bluetoothsockets) ENDENG
dnl DECLARE_CONST(PF_BRIDGE)                    ENG(Protocolfamily: Multiprotocol bridge) ENDENG
DECLARE_CONST(PF_DECnet)                    ENG(ProtocolFamily: DECNETproject) ENDENG
dnl DECLARE_CONST(PF_ECONET)                    ENG(Protocolfamily: AcornEconet) ENDENG
DECLARE_CONST(PF_INET)                      ENG(Protocolfamily: Internet IPProtocol) ENDENG
DECLARE_CONST(PF_INET6)                     ENG(Protocolfamily: IPversion 6) ENDENG
DECLARE_CONST(PF_IPX)                       ENG(Protocolfamily: NovellIPX) ENDENG
dnl DECLARE_CONST(PF_IRDA)                      ENG(Protocolfamily: IRDA sockets) ENDENG
DECLARE_CONST(PF_KEY)                       ENG(Protocolfamily: Key management API) ENDENG
dnl DECLARE_CONST(PF_LLC)                       ENG(Protocolfamily: Linux LLC) ENDENG
DECLARE_CONST(PF_LOCAL)                     ENG(Protocolfamily: Unix socket) ENDENG
DECLARE_CONST(PF_MAX)                       ENG(Protocolfamily: Maximumvalue) ENDENG
dnl DECLARE_CONST(PF_NETBEUI)                   ENG(Protocolfamily: Reservedfor 802.2LLCproject) ENDENG
dnl DECLARE_CONST(PF_NETLINK)                   ENG(Protocolfamily: ?) ENDENG
dnl DECLARE_CONST(PF_NETROM)                    ENG(Protocolfamily:AmateurradioNetROM) ENDENG
dnl DECLARE_CONST(PF_PACKET)                    ENG(Protocolfamily: Packet family) ENDENG
dnl DECLARE_CONST(PF_PPPOX)                     ENG(Protocolfamily: PPPoXsockets) ENDENG
dnl DECLARE_CONST(PF_ROSE)                      ENG(Protocolfamily: Amateur RadioX.25PLP) ENDENG
DECLARE_CONST(PF_ROUTE)                     ENG(ProtocolFamily: ?) ENDENG
dnl DECLARE_CONST(PF_SECURITY)                  ENG(Protocolfamily: Security callback pseudo PF) ENDENG
DECLARE_CONST(PF_SNA)                       ENG(ProtocolFamily: Linux SNAproject) ENDENG
dnl DECLARE_CONST(PF_TIPC)                      ENG(Protocolfamily: TIPCsockets) ENDENG
DECLARE_CONST(PF_UNIX)                      ENG(Protocolfamily: Unix domain sockets) ENDENG
DECLARE_CONST(PF_UNSPEC)                    ENG(Protocolfamily: Unspecified) ENDENG
dnl DECLARE_CONST(PF_WANPIPE)                   ENG(Protocolfamily: WanpipeAPI Sockets) ENDENG
dnl DECLARE_CONST(PF_X25)                       ENG(Protocolfamily: Reservedfor X.25project) ENDENG
dnl DECLARE_CONST(SCM_SRCRT)                    ENG(UndocumentedGetsockoptoption?) ENDENG
dnl DECLARE_CONST(SCM_TIMESTAMP)                ENG(Socket option: ?) ENDENG
DECLARE_CONST(SHUT_RD)                      ENG(Shutdownreadpartoffull duplex socket) ENDENG
DECLARE_CONST(SHUT_RDWR)                    ENG(Shutdownreadandwritepartoffull duplex socket) ENDENG
DECLARE_CONST(SHUT_WR)                      ENG(Shutdownwritepartoffull duplex socket) ENDENG
DECLARE_CONST(SOCK_DGRAM)                   ENG(Typeofsocket:datagram(conn.less)socket (UDP)) ENDENG
dnl DECLARE_CONST(SOCK_MAXADDRLEN)              ENG(Maximumsocket addresslengthfor Bind call.) ENDENG
DECLARE_CONST(SOCK_RAW)                     ENG(Typeofsocket: raw socket) ENDENG
DECLARE_CONST(SOCK_RDM)                     ENG(Typeofsocket:reliably-deliveredmessage) ENDENG
DECLARE_CONST(SOCK_SEQPACKET)               ENG(Typeofsocket:sequential packet socket) ENDENG
DECLARE_CONST(SOCK_STREAM)                  ENG(Typeofsocket:stream (connection) type socket (TCP)) ENDENG
dnl DECLARE_CONST(SOL_ICMPV6)                   ENG(Socket levelvaluesfor IPv6:ICMPV6) ENDENG
dnl DECLARE_CONST(SOL_IP)                       ENG(Undocumented?) ENDENG
dnl DECLARE_CONST(SOL_IPV6)                     ENG(Socket levelvaluesfor IPv6:IPV6) ENDENG
DECLARE_CONST(SOL_SOCKET)                   ENG(Socket optionlevel: Socket level) ENDENG
DECLARE_CONST(SOMAXCONN)                    ENG(Maximumqueuelengthspecifiable by listen.) ENDENG
DECLARE_CONST(SO_ACCEPTCONN)                ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_ATTACH_FILTER)             ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_BINDTODEVICE)              ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_BROADCAST)                 ENG(Socket option: Broadcast) ENDENG
dnl DECLARE_CONST(SO_BSDCOMPAT)                 ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_DEBUG)                     ENG(Socket optionlevel: debug) ENDENG
dnl DECLARE_CONST(SO_DETACH_FILTER)             ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_DONTROUTE)                 ENG(Socket option: Don'troute) ENDENG
DECLARE_CONST(SO_ERROR)                     ENG(Socket option: Error) ENDENG
DECLARE_CONST(SO_KEEPALIVE)                 ENG(Socket option: keep alive) ENDENG
DECLARE_CONST(SO_LINGER)                    ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_NO_CHECK)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_OOBINLINE)                 ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_PASSCRED)                  ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_PEERCRED)                  ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_PEERNAME)                  ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_PRIORITY)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_RCVBUF)                    ENG(Socket option: receivebuffer) ENDENG
DECLARE_CONST(SO_RCVLOWAT)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_RCVTIMEO)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_REUSEADDR)                 ENG(Socket option: Reuseaddress) ENDENG
dnl DECLARE_CONST(SO_SECURITY_AUTHENTICATION)   ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_SECURITY_ENCRYPTION_NETWORK) ENG(Socket option: ?) ENDENG
dnl DECLARE_CONST(SO_SECURITY_ENCRYPTION_TRANSPORT) ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_SNDBUF)                    ENG(Socket option: Sendbuffer) ENDENG
DECLARE_CONST(SO_SNDLOWAT)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_SNDTIMEO)                  ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_TIMESTAMP)                 ENG(Socket option: ?) ENDENG
DECLARE_CONST(SO_TYPE)                      ENG(Socket option: Type) ENDENG
DECLARE_CONST(S_IN)                         ENG(Input socket insocket pair.) ENDENG
DECLARE_CONST(S_OUT)                        ENG(Output socket insocket pair) ENDENG
dnl DECLARE_CONST(TCP_CONGESTION)               ENG(Get/set the congestion-control algorithm for this socket) ENDENG
dnl DECLARE_CONST(TCP_CORK)                     ENG(Get/Set CORKalgorithm:Sendonly completepackets) ENDENG
dnl DECLARE_CONST(TCP_DEFER_ACCEPT)             ENG(Get/Set deferredacceptonserver socket) ENDENG
DECLARE_CONST(TCP_INFO)                     ENG(GetTCPconnectioninformation(linux only)) ENDENG
dnl DECLARE_CONST(TCP_KEEPCNT)                  ENG(Get/Set retry countfor unacknowledgedKEEPALIVEtransmissions.) ENDENG
dnl DECLARE_CONST(TCP_KEEPIDLE)                 ENG(Get/Set inactivity interval between KEEPALIVEtransmissions.) ENDENG
dnl DECLARE_CONST(TCP_KEEPINTVL)                ENG(Get/Set retry interval for unacknowledgedKEEPALIVEtransmissions.) ENDENG
dnl DECLARE_CONST(TCP_LINGER2)                  ENG(Get/Set Linger2flag) ENDENG
DECLARE_CONST(TCP_MAXSEG)                   ENG(Get/Set Maximumsegment size) ENDENG
DECLARE_CONST(TCP_MD5SIG)                   ENG(Get/Set TCPMD5 signatureoption) ENDENG
DECLARE_CONST(TCP_NODELAY)                  ENG(Get/Set Nodelay flag: disableNagle algorithm) ENDENG
dnl DECLARE_CONST(TCP_QUICKACK)                 ENG(Get/Set quik ACK packet option.) ENDENG
dnl DECLARE_CONST(TCP_SYNCNT)                   ENG(Get/Set number ofSYNpacketstosendbefore givinuponconnectionestablishment) ENDENG
dnl DECLARE_CONST(TCP_WINDOW_CLAMP)             ENG(Get/Set maximumpacket size) ENDENG
dnl DECLARE_CONST(UDP_CORK)                     ENG(Get/Set UDPCORKalgorithm ondatagramsockets) ENDENG
dnl DECLARE_CONST(UDP_ENCAP)                    ENG(Get/Set UDPencapsulation flagfor IPSec datagramsockets) ENDENG
dnl DECLARE_CONST(UDP_ENCAP_ESPINUDP)           ENG(? Undocumented datagram option, IPSec related) ENDENG
dnl DECLARE_CONST(UDP_ENCAP_ESPINUDP_NON_IKE)   ENG(?Undocumenteddatagramoption, IPSec related) ENDENG
dnl DECLARE_CONST(UDP_ENCAP_L2TPINUDP)          ENG(? Undocumented datagram option, IPSec relate) ENDENG

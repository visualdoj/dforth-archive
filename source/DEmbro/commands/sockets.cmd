DECLARE(ssocket)
  NOTATION(( domain xtype protocol -- socket))
  RUS( создаёт сокет с заданными параметрами.) ENDRUS
  ENG( creates a new socket using passed parameters. ) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(saccept)
  NOTATION(( socket address address# -- error))
  RUS( принимает подключение от сокета socket, который находится в состоянии прослушивания.) ENDRUS
  ENG( accepts a connection from the socket, which was listening for a connection. ) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(sbind)
  NOTATION(( socket address address# -- error))
  RUS( привязывает сокет к заданному адресу.) ENDRUS
  ENG( binds the socket to the address.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(sclose)
  NOTATION(( socket -- error))
  RUS( закрывает сокет s. В случае успеха возвращает 0, иначе ошибку e) ENDRUS
  ENG( closes a socket handle. It returns 0 if the socket was closed succesfully, othewise if it failed. ) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(sconnect)
  NOTATION(( socket address address# -- error))
  RUS( использует сокет для подключения к адресу address.) ENDRUS
  ENG( uses the socket to open a connection to a peer, whose address is described by address. ) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(slisten)
  NOTATION(( socket backlog -- error))
  RUS( переводит сокет в режим прослушивания не более backlog соединений единовременно.) ENDRUS
  ENG( listens for up to backlog connections from socket.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(ssend)
  NOTATION(( socket message message# flags -- sent#))
  RUS( отправляет message# байт, начинающихся с адреса message, на сокет socket. Сокет должен быть в подключённом состоянии.) ENDRUS
  ENG( sends message# bytes starting from address message to socket. Socket must be in a connected state.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(ssendto)
  NOTATION(( socket message message# flags address address# -- sent#))
  RUS( отправляет message# байт, начинающихся с адреса message, через сокет socket по адрессу address.) ENDRUS
  ENG( sends data from buffer message with length message# through socket.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(htonl)
  NOTATION(( hostcell -- netcell))
  RUS( меняет порядок младших четырёх байтов с локального на сетевой.) ENDRUS
  ENG( makes sure that the bytes in hostcell are ordered in the correct way for sending over the network and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(htons)
  NOTATION(( hostcell -- netcell))
  RUS( меняет порядок младших двух байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in hostcell are ordered in the correct way for sending over the network and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(ntohl)
  NOTATION(( netcell -- hostcell))
  RUS( меняет порядок младших четырёх байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in netcell, received from the network, are ordered in the correct way for handling by the host machinen, and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  body()

DECLARE(ntohs)
  NOTATION(( netcell -- hostcell))
  RUS( меняет порядок младших двух байтов с сетевого на локальный.) ENDRUS
  ENG( makes sure that the bytes in netcell, received from the network, are ordered in the correct way for handling by the host machinen, and returns the correctly ordered result.) ENDENG
  EPO( ) ENDEPO
  body()

{
UniChat - chat for LANs.
UDPSock.pas - UniChat sockets routines.

$Author(s): Dentall
$Last revision: 27/02/2006

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2006 GlumClub team
}

unit UDPSock;

interface
uses WinSock2, main, windows, messages, SysUtils, dialogs;

var
  wsadata: twsadata;
  FHandle, FCHandle: TSocket;
  inited: boolean = False;
  MyIP: string;

procedure Listen(lport: integer; const PeerIP: string; HwndF: Hwnd);
procedure CreateSocket; // Инициализация
procedure DestroySocket; // Закрываем хэндлы
function receivebuf(var buf: array of char): integer; // Прииять информацию
procedure SendPeer2Peer(var data; len: integer);
procedure SendPeer2PeerStr(str: string);
procedure StopServer;
{
Эта функция должна вызываться при получении формой сообщения WM_SOCKET Например:
function TForm1.KOLForm1Message(var Msg: tagMSG;
  var Rslt: Integer): Boolean;
var
len: integer;
buf: array [1..2048] of byte;
begin
Result:=False;

 case Msg.message of

 ..........

 WM_SOCKET:
 begin

        len:=ReceiveBuf(buf); // Len - кол-во записанных данных в буфер

end;

end;

}
implementation

function ErrorTest(const errcode: cardinal): boolean;
var
  wsae: integer;
begin
  result :=  (errcode = INVALID_SOCKET);
  if result then
  begin
    wsae := wsagetlasterror;
    if wsae <> WSAEWOULDBLOCK then
    begin
      //showmessage('Network Error!');
    end
    else
      result := false;
  end;
end;

procedure Listen(lport: integer; const PeerIP: string; HwndF: Hwnd);
var
  adr: tsockaddr;
begin

  fchandle := socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);

  if not errortest(fchandle) then
  begin
    with adr do
    begin
      sin_family := AF_INET;
      sin_port := htons(lPort);
      integer(sin_addr) := inet_addr(pchar(PeerIP));
    end;
    errortest(integer(adr.sin_addr));
    errortest(winsock2.connect(fchandle, @adr, sizeof(adr)));
  end;

  //  if fhandle<>SOCKET_ERROR then exit;
  fhandle := socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
  if not errortest(fhandle) then
  begin
    with adr do
    begin
      sin_family := AF_INET;
      sin_port := htons(LPort); // !!! ПОРТ ПРОСЛУШИВАНИЯ СЕРВЕРА!!!
      sin_addr.S_addr := INADDR_ANY;
    end;
//    adr.
    myIP:=inet_ntoa(adr.sin_addr);

    if not errortest(bind(fhandle, @adr, sizeof(adr))) then
    begin
      wsaasyncselect(fhandle, HwndF, WM_SOCKET, FD_READ);


      // !!! ЗДЕСЬ form1.form.Handle - форма, которой будет послыаться WM_SOCKET при получении данных
    end;
  end;
end;

function receivebuf(var buf: array of char): integer;
begin
  Result := WinSock2.recv(Fhandle, Buf, sizeof(buf), 0);
end;

procedure SendPeer2PeerStr(str: string);
begin
  SendPeer2Peer(str[1], length(str));
end;

procedure SendPeer2Peer(var data; len: integer);
begin
  winsock2.send(fchandle, Data, len, 0);
end;

procedure CreateSocket;
begin
  fhandle := INVALID_SOCKET;
  fcHandle := INVALID_SOCKET;
  wsastartup($202, wsadata);
  Inited := True;
end;

procedure StopServer;
begin
  winsock2.closesocket(fhandle);
end;

procedure DestroySocket;
begin
  if Inited then
  begin
    winsock2.closesocket(fhandle);
    winsock2.closesocket(fcHandle);
    wsacleanup;
    inited := False;
  end;
end;


end.

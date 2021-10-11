{
UniChat - chat for LANs.
chatutils.pas - Misc. procedures and functions module.

$Author(s): Dentall, Dr. Evil
$Last revision: 25/11/2004

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit chatutils;

interface

uses Windows, winsock, udpsock, main, globalconst,SysUtils;

{$I uc_defs.inc}

function uGetLocalHostName: string;
function uHost2IP: string;
function uCheckNet: boolean;
function uGetComputerName: string;
function uGetUserName: string;
function Parse(var S: string; const Separators: string): string;
function Space2Percent(path: string): string;
function DynaKey(const s: string; const value: integer): string;
function ExtractUserIP(data: string): string;
function ExtractUserLogon(data: string): string;
function ExtractUserComp(data: string): string;
function CleanIncorrectSymbols(s: string): string;
function GetChatUserID: string;
function UserKey(const s: string; const value: cardinal = $AB56DE67): string;
function GetNAGTimeOut: integer;
function GetHDDSerial: string;

implementation

function GetNAGTimeOut: integer;
begin
result := (600007 + random(600000));

end;

function GetHDDSerial: string;
var
SerialNum : dword;
a, b : dword;
Buffer  : array [0..255] of char;
begin
Result:='NoCode';
if GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), @SerialNum, a, b, nil, 0) then
Result := IntToStr(SerialNum);
end;

function UserKey(const s: string; const value: cardinal = $AB56DE67): string;
var
  i: integer;
  s1: string[12];
  k1,k2,k3: integer;

begin
  if length(s) = 12 then
    s1 := s
  else if length(s) < 12 then
  begin
    s1 := StringOfChar(#255, 12);
    for i := 1 to length(s) do
      s1[i] := s[i];
  end
  else
    s1 := Copy(s, 1, 12);

  asm
      push EAX
      push EBX
      push ECX
      push EDX

      lea EDX, [offset s1]

      mov EAX, [EDX + 1]
      mov EBX, [EDX + 5]
      mov ECX, [EDX + 9]
      mov EDX, value

      bt EDX,9
      jae @p2
      xor ECX, $10AB1023
@p2:  xor EBX, $BAF62910

      bt EDX, 0
      jae @bsA
      ror EBX, 5
@bsA: bswap EAX

      bt EDX,30
      jae @p23
      xor EAX, $0324BCA1
@p23: xor EBX, $323EBCDA

      bt EDX,1
      jae @oBA
      and ECX, EAX
@oBA: or EBX, EAX

      bt EDX,19
      jae @p12
      xor EAX, $23BA3212
@p12: xor ECX, $12093235

      bt EDX,2
      jae @rE7
      rol EAX, 3
@rE7: ror ECX, 7

      bt EDX,31
      jae @p24
      xor EBX, $123ABFE2
@p24: xor ECX, $F4F74234

      bt EDX,3
      jae @xAB
      bswap EBX
@xAB: xor EAX, EBX

      bt EDX,11
      jae @p4
      xor EBX, $BC872842
@p4:  xor ECX, $01BFAE31

      bt EDX,4
      jae @bsC
      not EAX
@bsC: bswap ECX

      bt EDX,14
      jae @p7
      xor ECX, $294BACE7
@p7:  xor EBX, $659B1EAB

      bt EDX,5
      jae @rC5
      rol EBX, 3
@rC5: ror ECX, 5

      bt EDX,12
      jae @p5
      xor EAX, $12729563
@p5:  xor EBX, $0BCD7B1E1

      bt EDX,6
      jae @aCA
      not EBX
@aCA: and ECX, EAX

      bt EDX,8
      jae @p1
      xor EAX, $56FAA191
@p1:  xor EBX, $9021F213

      bt EDX,7
      jae @ntC
      rol EAX, 4
@ntC: not ECX

      bt EDX,10
      jae @p3
      xor EAX, $2854BCAF
@p3:  xor ECX, $0AFE1323

      bt EDX,13
      jae @p6
      xor ECX, $A1A2A3A4
@p6:  xor EAX, $1BA5E81B

      bt EDX,15
      jae @p8
      xor EAX, $120BC21A
@p8:  xor EBX, $FBC12394

      bt EDX,16
      jae @p9
      xor ECX, $4792B2A4
@p9:  xor EBX, $B5EE24E1

      bt EDX,17
      jae @p10
      xor EBX, $BCAEDFBA
@p10: xor ECX, $8B6AE2A1

      bt EDX,18
      jae @p11
      xor EAX, $47BC1678
@p11: xor EBX, $4B4B6434

      bt EDX,20
      jae @p13
      xor ECX, $34289902
@p13: xor EAX, $BAC34234

      bt EDX,21
      jae @p14
      xor EAX, $0349BBAA
@p14: xor EBX, $AABB3423

      bt EDX,22
      jae @p15
      xor EBX, $34BCFA34
@p15: xor EAX, $B2187A12

      bt EDX,23
      jae @p16
      xor EAX, $C432123A
@p16: xor EAX, $034BCCCC

      bt EDX,24
      jae @p17
      xor EBX, $10239054
@p17: xor EBX, $B234B213

      bt EDX,25
      jae @p18
      xor ECX, $56FAA191
@p18: xor ECX, $23B910F0

      bt EDX,26
      jae @p19
      xor EAX, $0A0B0C0D
@p19: xor EBX, $D0E0B0F0

      bt EDX,27
      jae @p20
      xor EBX, $52321313
@p20: xor ECX, $65745234

      bt EDX,28
      jae @p21
      xor ECX, $123BCDE1
@p21: xor EAX, $1239553B

      bt EDX,29
      jae @p22
      xor EBX, $12BC2312
@p22: xor ECX, $230BCDE1

      mov k1, EBX
      mov k2, EAX
      mov k3, ECX

      pop EDX
      pop ECX
      pop EBX
      pop EAX
  end;
  Result := format('%X%X%X',[k1,k2,k3]);
end;


function ExtractUserIP(data: string): string;
begin
  Result := Parse(data, '/');
end;

function ExtractUserComp(data: string): string;
begin
  Parse(data, '/');
  Result := Parse(data, '/');
end;

function ExtractUserLogon(data: string): string;
begin
  Parse(data, '/');
  Parse(data, '/');
  Result := Parse(data, '/');
end;

{$IFDEF UNICODERSNET}

function DynaKey(const s: string; const value: integer): string;
var
  i: integer;
  s1: string[12];
begin
  if length(s) = 12 then
    s1 := s
  else if length(s) < 12 then
  begin
    s1 := StringOfChar(#255, 12);
    for i := 1 to length(s) do
      s1[i] := s[i];
  end
  else
    s1 := Copy(s, 1, 12);

  asm
      push EAX
      push EBX
      push ECX
      push EDX

      lea EDX, [offset s1]

      mov EAX, [EDX + 1]
      mov EBX, [EDX + 5]
      mov ECX, [EDX + 9]
      mov EDX, value

      bt EDX,9
      jae @p2
      xor ECX, $10AB1023
@p2:  xor EBX, $BAF62910

      bt EDX, 0
      jae @bsA
      ror EBX, 5
@bsA: bswap EAX

      bt EDX,30
      jae @p23
      xor EAX, $0324BCA1
@p23: xor EBX, $323EBCDA

      bt EDX,1
      jae @oBA
      and ECX, EAX
@oBA: or EBX, EAX

      bt EDX,19
      jae @p12
      xor EAX, $23BA3212
@p12: xor ECX, $12093235

      bt EDX,2
      jae @rE7
      rol EAX, 3
@rE7: ror ECX, 7

      bt EDX,31
      jae @p24
      xor EBX, $123ABFE2
@p24: xor ECX, $F4F74234

      bt EDX,3
      jae @xAB
      bswap EBX
@xAB: xor EAX, EBX

      bt EDX,11
      jae @p4
      xor EBX, $BC872842
@p4:  xor ECX, $01BFAE31

      bt EDX,4
      jae @bsC
      not EAX
@bsC: bswap ECX

      bt EDX,14
      jae @p7
      xor ECX, $294BACE7
@p7:  xor EBX, $659B1EAB

      bt EDX,5
      jae @rC5
      rol EBX, 3
@rC5: ror ECX, 5

      bt EDX,12
      jae @p5
      xor EAX, $12729563
@p5:  xor EBX, $0BCD7B1E1

      bt EDX,6
      jae @aCA
      not EBX
@aCA: and ECX, EAX

      bt EDX,8
      jae @p1
      xor EAX, $56FAA191
@p1:  xor EBX, $9021F213

      bt EDX,7
      jae @ntC
      rol EAX, 4
@ntC: not ECX

      bt EDX,10
      jae @p3
      xor EAX, $2854BCAF
@p3:  xor ECX, $0AFE1323

      bt EDX,13
      jae @p6
      xor ECX, $A1A2A3A4
@p6:  xor EAX, $1BA5E81B

      bt EDX,15
      jae @p8
      xor EAX, $120BC21A
@p8:  xor EBX, $FBC12394

      bt EDX,16
      jae @p9
      xor ECX, $4792B2A4
@p9:  xor EBX, $B5EE24E1

      bt EDX,17
      jae @p10
      xor EBX, $BCAEDFBA
@p10: xor ECX, $8B6AE2A1

      bt EDX,18
      jae @p11
      xor EAX, $47BC1678
@p11: xor EBX, $4B4B6434

      bt EDX,20
      jae @p13
      xor ECX, $34289902
@p13: xor EAX, $BAC34234

      bt EDX,21
      jae @p14
      xor EAX, $0349BBAA
@p14: xor EBX, $AABB3423

      bt EDX,22
      jae @p15
      xor EBX, $34BCFA34
@p15: xor EAX, $B2187A12

      bt EDX,23
      jae @p16
      xor EAX, $C432123A
@p16: xor EAX, $034BCCCC

      bt EDX,24
      jae @p17
      xor EBX, $10239054
@p17: xor EBX, $B234B213

      bt EDX,25
      jae @p18
      xor ECX, $56FAA191
@p18: xor ECX, $23B910F0

      bt EDX,26
      jae @p19
      xor EAX, $0A0B0C0D
@p19: xor EBX, $D0E0B0F0

      bt EDX,27
      jae @p20
      xor EBX, $52321313
@p20: xor ECX, $65745234

      bt EDX,28
      jae @p21
      xor ECX, $123BCDE1
@p21: xor EAX, $1239553B

      bt EDX,29
      jae @p22
      xor EBX, $12BC2312
@p22: xor ECX, $230BCDE1


      lea EDX, [s1]
      mov [EDX + 1], EBX
      mov [EDX + 5], EAX
      mov [EDX + 9], ECX

      pop EDX
      pop ECX
      pop EBX
      pop EAX
  end;
  Result := s1;
end;
{$ELSE}

function DynaKey(const s: string; const value: integer): string;
var
  i: integer;
  s1: string[12];
begin
  if length(s) = 12 then
    s1 := s
  else if length(s) < 12 then
  begin
    s1 := StringOfChar(#255, 12);
    for i := 1 to length(s) do
      s1[i] := s[i];
  end
  else
    s1 := Copy(s, 1, 12);

  asm
      push EAX
      push EBX
      push ECX
      push EDX

      lea EDX, [offset s1]

      mov EAX, [EDX + 1]
      mov EBX, [EDX + 5]
      mov ECX, [EDX + 9]
      mov EDX, value

      bt EDX,9
      jae @p2
      xor ECX, $2A289BE2
@p2:  xor EBX, $32BEA272

      bt EDX, 0
      jae @bsA
      ror EBX, 3
@bsA: bswap EAX

      bt EDX,30
      jae @p23
      xor EAX, $2324BCA1
@p23: xor EBX, $323EBCDA

      bt EDX,1
      jae @oBA
      and ECX, EAX
@oBA: or EBX, EAX

      bt EDX,19
      jae @p12
      xor EAX, $223B3212
@p12: xor ECX, $12BABAFA

      bt EDX,2
      jae @rE7
      rol EAX, 3
@rE7: ror ECX, 7

      bt EDX,31
      jae @p24
      xor EBX, $123ABFE2
@p24: xor ECX, $F4F74234

      bt EDX,3
      jae @xAB
      bswap EBX
@xAB: xor EAX, EBX

      bt EDX,11
      jae @p4
      xor EBX, $BC872842
@p4:  xor ECX, $01BFAE31

      bt EDX,4
      jae @bsC
      not EAX
@bsC: bswap ECX

      bt EDX,14
      jae @p7
      xor ECX, $294BACE7
@p7:  xor EBX, $659B1EAB

      bt EDX,5
      jae @rC5
      rol EBX, 3
@rC5: ror ECX, 5

      bt EDX,12
      jae @p5
      xor EAX, $12729563
@p5:  xor EBX, $0BCD7B1E1

      bt EDX,6
      jae @aCA
      not EBX
@aCA: and ECX, EAX

      bt EDX,8
      jae @p1
      xor EAX, $56FAA191
@p1:  xor EBX, $9021F213

      bt EDX,7
      jae @ntC
      rol EAX, 4
@ntC: not ECX

      bt EDX,10
      jae @p3
      xor EAX, $2854BCAF
@p3:  xor ECX, $0AFE1323

      bt EDX,13
      jae @p6
      xor ECX, $A1A2A3A4
@p6:  xor EAX, $1BA5E81B

      bt EDX,15
      jae @p8
      xor EAX, $120BC21A
@p8:  xor EBX, $FBC12394

      bt EDX,16
      jae @p9
      xor ECX, $4792B2A4
@p9:  xor EBX, $B5EE24E1

      bt EDX,17
      jae @p10
      xor EBX, $BCAEDFBA
@p10: xor ECX, $8B6AE2A1

      bt EDX,18
      jae @p11
      xor EAX, $47BC1678
@p11: xor EBX, $4B4B6434

      bt EDX,20
      jae @p13
      xor ECX, $34289902
@p13: xor EAX, $BAC34234

      bt EDX,21
      jae @p14
      xor EAX, $0349BBAA
@p14: xor EBX, $AABB3423

      bt EDX,22
      jae @p15
      xor EBX, $34BCFA34
@p15: xor EAX, $B2187A12

      bt EDX,23
      jae @p16
      xor EAX, $C432123A
@p16: xor EAX, $034BCCCC

      bt EDX,24
      jae @p17
      xor EBX, $10239054
@p17: xor EBX, $B234B213

      bt EDX,25
      jae @p18
      xor ECX, $56FAA191
@p18: xor ECX, $23B910F0

      bt EDX,26
      jae @p19
      xor EAX, $0A0B0C0D
@p19: xor EBX, $D0E0B0F0

      bt EDX,27
      jae @p20
      xor EBX, $52321313
@p20: xor ECX, $65745234

      bt EDX,28
      jae @p21
      xor ECX, $123BCDE1
@p21: xor EAX, $1239553B

      bt EDX,29
      jae @p22
      xor EBX, $12BC2312
@p22: xor ECX, $230BCDE1


      lea EDX, [s1]
      mov [EDX + 1], EBX
      mov [EDX + 5], EAX
      mov [EDX + 9], ECX

      pop EDX
      pop ECX
      pop EBX
      pop EAX
  end;
  Result := s1;
end;
{$ENDIF}

function Space2Percent(path: string): string;
var
  i: integer;
begin
  result := '';
  for i := 1 to length(path) do
    if path[i] = ' ' then
      result := result + '%20'
    else
      result := result + path[i];
end;

function uGetLocalHostName: string;
var
  Buffer: array[0..63] of Char;
  GInitData: TWSAData;

begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  Result := Buffer;
  WSACleanup;
end;

function uHost2IP: string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  I: Integer;
  GInitData: TWSAData;
  hostname: string;
begin
hostname:=uGetLocalHostName;
  Result := '';
  WSAStartup($101, GInitData);
  phe := GetHostByName(@HostName[1]);
  if phe = nil then
    Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I := 0;
  while pPtr^[I] <> nil do
  begin
    Result := inet_ntoa(pPtr^[I]^);
    Inc(I);
  end;
  WSACleanup;
end;

function _Host2IP(var _IP: string; const IF_NUM: integer): boolean;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  I: Integer;
  GInitData: TWSAData;
  hostname: string;
  s: string;
begin
Result:=False;
hostname:=uGetLocalHostName;
  WSAStartup($101, GInitData);
  phe := GetHostByName(@HostName[1]);
  if phe = nil then
    Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I := 0;
  while pPtr^[I] <> nil do
  begin
    s := inet_ntoa(pPtr^[I]^);

    if _IP = s then
    begin
    Result:=True;
    break;
    end;

    if i=IF_NUM then
    begin
    _IP:=s;
    Result:=True;
    break;
    end;

    Inc(I);
  end;
  WSACleanup;
end;


function uCheckNet: boolean;
begin

  Result := (GetSystemMetrics(SM_NETWORK) and $00000001) = $00000001;

end;

function uGetComputerName: string;
var
  I: Cardinal;
  Buffer: array[0..255] of Char;
begin
  I := SizeOf(Buffer);
  windows.GetComputerName(Buffer, I);
  Result := Buffer;
end;

function uGetUserName: string;
var
  I: Cardinal;
  Buffer: array[0..255] of Char;
begin
  I := SizeOf(Buffer);
  windows.GetUserName(Buffer, I);
  Result := Buffer;
end;

function StrScan(Str: PChar; Chr: Char): PChar; assembler;
asm
  {$IFDEF F_P}
  MOV   EAX, [Str]
  MOVZX EDX, [Chr]
  {$ENDIF}
        PUSH    EDI
        PUSH    EAX
        MOV     EDI,Str
        OR      ECX, -1
        XOR     AL,AL
        REPNE   SCASB
        NOT     ECX
        POP     EDI
        XCHG    EAX, EDX
        REPNE   SCASB

        XCHG    EAX, EDI
        POP     EDI

        JE      @@1
        XOR     EAX, EAX
        RET

@@1:    DEC     EAX
end;

function IndexOfChar(const S: string; Chr: Char): Integer;
var
  P, F: PChar;
begin
  P := PChar(S);
  F := StrScan(P, Chr);
  Result := -1;
  if F = nil then
    Exit;
  Result := Integer(F) - Integer(P) + 1;
end;

function IndexOfCharsMin(const S, Chars: string): Integer;
var
  I, J: Integer;
begin
  Result := -1;
  for I := 1 to Length(Chars) do
  begin
    J := IndexOfChar(S, Chars[I]);
    if J > 0 then
    begin
      if (Result < 0) or (J < Result) then
        Result := J;
    end;
  end;
end;

function Parse(var S: string; const Separators: string): string;
var
  Pos: Integer;
begin
  Pos := IndexOfCharsMin(S, Separators);
  if Pos <= 0 then
    Pos := Length(S) + 1;
  Result := S;
  S := Copy(Result, Pos + 1, MaxInt);
  Result := Copy(Result, 1, Pos - 1);
end;

function binarylookup(const phrase: string): integer;
var
  low, high, mid, cmp: integer;
  tmp: string;
begin
  result := -1;
  low := 0;
  high := 97; // Не забывайте корректировать эти значения при добавлении смайлов
  if high > 0 then
  begin
    while low <= high do
    begin
      mid := (low + high) shr 1;
      tmp := copy(phrase, 1, length(Smileys[mid]));
      cmp := CompareStr(tmp, Smileys[mid]);
      if cmp < 0 then
        high := mid - 1
      else if cmp > 0 then
        low := mid + 1
      else
      begin
        result := mid;
        break;
      end;
    end;
  end;
end;

function NoMinus(src: string; var addon: integer):
  integer;
var
  i, z: integer;
  rezult: string;
begin
  addon := 0;
  rezult := '';
  z := length(src);
  for i := 1 to z do
    if src[i] = '-' then
      inc(addon)
    else
      rezult := rezult + src[i];
  Result := BinaryLookUp(rezult);
end;


function CheckSmiles (const input: string): string;
var
  rez, s2: string;
  p: Integer;
  i, addon, len: integer;
  nm: string;
  s: string;
begin
  s := ' '+input; // some bugs
  rez := '';
  i := 1;
  len := length(s);
  while i <= len do
  begin
    if (s[i] = ' ') or (i = 0) then
      if s[i + 1] in [':', ';', '=', 'B', '(', '<', '>', '8', '%', '''', ')',
        'o', 'E', '|', '$', 'P'] then // Ищем сперва любой из первых символов, который
                                      // может быть первым символом смайла
      begin
        p := NoMinus(copy(s, i + 1, 11), addon); // Нашли, копируем 11 символов (макс. длина смайла)
        // Отсеиваем минусы, ищем такой смайл в элементной базе

        if p >= 0 then // Если нашли смайл
        begin
          nm := smileys[p]; // собственно текстовый макрос смайла
          rez := rez + s2; // добавляем остаток
          s2 := ''; // Очищаем остаток (зачем он нужен я сам не помню) ;)

//          if smCount < MaxSmiles then rez := rez + nm else //Если не превышает кол-во смайлов, то добавляем
            rez := rez; // На что заменяем смайл
          s2 := '';
          inc(i, addon + length(nm));
        end;
      end;
    inc(i);
    if (i <= len) and (i <> 0) then
      s2 := s2 + s[i];
  end;
  if s2 <> '' then rez := rez + s2;
  Result :=rez;
end;

function CleanIncorrectSymbols(s: string): string;
var
  I, L: Integer;
begin

  L := Length(S);
  I := 1;
  while (I <= L) and not (S[I] in [#48..#57,#65..#90,#97..#122,'ё','Ё',#192..#255]) do Inc(I);
  Result := Copy(S, I, 32);

  Result:=CheckSmiles(Result);

  if (result='Основной') or (Result='Объявления') then Result:='User_'+CurID;

{Result:='';
  z := length(s);
  if z>32 then z:=32;
  for i := 1 to z do
  begin
  if (s[i] ) then
  Result:=Result+s[i];
  end;}
end;

function GetChatUserID: string;
var
ip: string;
begin
ip:=ParamStr(2);

if ParamStr(1)='-IP' then
begin
if  _Host2IP(ip , strtoint(ParamStr(3))) then
Result:=ip + '/' + uGetComputerName + '/' + uGetUserName
else
Result:=uHost2IP + '/' + uGetComputerName + '/' +
    uGetUserName {  + inttostr(Random(maxint))};
end
     else
Result:=uHost2IP + '/' + uGetComputerName + '/' +
    uGetUserName {  + inttostr(Random(maxint))};


end;

end.


unit URLScan;
{==============================================================================}
{ Scanning RichView for URLs                                                   }
{ Copyright (c) 2001,2003 by Sergey Tkachenko                                  }
{ StrPosW is from http://www.delphi-unicode.net/Library.php                    }
{==============================================================================}
{ ClearHypertext allows to convert all (or selected) hypertext links           }
{ to normal text.                                                              }
{ ScanURLs searches for URLs and makes them hypertext                          }
{ These functions receive new style for text via call of URLScanProcedure.     }
{ Calling for TRichViewEdit.RVData requires call ClearUndo before.             }
{------------------------------------------------------------------------------}
{ Unicode text is not processed in Delphi2 and C++Builder1.                    }
{ Unicode uppercase URLs can be processed only in WinNT/2000/XP                }
{==============================================================================}

interface

{$I RV_Defs.inc}

uses Windows, SysUtils, Classes,
     RVStyle, RichView, CRVFData, RVTable, RVEdit, RVFuncs, RVItem;

type
  TRVURLScanProcedure = procedure (OldStyleNo: Integer;
                                 var NewStyleNo: Integer;
                                 ToHypertext: Boolean) of object;

function ScanURLs(RVData: TCustomRVFormattedData;
                    URLScanProcedure: TRVURLScanProcedure): Boolean;
function ClearHypertext(RVData: TCustomRVFormattedData;
                          URLScanProcedure: TRVURLScanProcedure): Boolean;

implementation

uses CRVData;

{======================= Processing ANSI text =================================}
function IsAddress(const str: String): Boolean;
var s: String;
begin
  // Checks for prefix.
  // For better results, it should check for lengths...
  s := AnsiLowerCase(str);
  Result :=
        (Pos('http://',   s)=1) or
        (Pos('http:\\',   s)=1) or
        (Pos('ftp://',    s)=1) or
        (Pos('ftp:\\',    s)=1) or
        (Pos('file://',   s)=1) or
        (Pos('file:\\',   s)=1) or
        (Pos('gopher://', s)=1) or
        (Pos('mailto:', s)=1) or
        (Pos('https://',  s)=1) or
        (Pos('https:\\',  s)=1) or
        (Pos('news:',     s)=1) or
        (Pos('telnet:',   s)=1) or
        (Pos('wais:',     s)=1) or
        (Pos('www.',      s)=1) or
        (Pos('\\',        s)=1) or
        (Pos('ftp.',      s)=1) or
        (Pos('mms://',      s)=1) or
        (Pos('mms:\\',      s)=1);
end;
{--------------------------------------------------------------}
function IsEmail(const s: String): Boolean;
var p1, p2: Integer;
   pchr: PChar;
begin
  //'@' must exist and '.' must be after it. This is not comprehensive test,
  //but I think that it's ok
  Result := False;
  p1 := Pos('@', s);
  if p1=0 then exit;
  pchr := StrRScan(PChar(s),'.');
  if pchr = nil then exit;
  p2 := pchr - PChar(s)+1;
  if p1>p2 then exit;
  Result := True;
end;
{--------------------------------------------------------------}
function FindChar(pc: PChar; Len: Integer): Integer;
var i: Integer;
begin
  for i := 0 to Len-1 do
    if pc[i] in [' ','"','*','|'] then begin
      Result := i+1;
      exit;
    end;
  Result := 0;
end;
{--------------------------------------------------------------}
// This function uses some undocumented methods
function DetectURLs(var RVData: TCustomRVFormattedData;
                     Index: Integer;
                     URLScanProcedure: TRVURLScanProcedure): Boolean;
var CurrentWord: String;
    i,p: Integer;
    s,s1 : String;
    pc, pcstart: PChar;
    Len, URLStyle: Integer;
    StringList: TStringList;
    sourceitem,item: TCustomRVItemInfo;
begin
   s := RVData.GetItemTextA(Index);
   pc := PChar(s);
   pcstart := pc;
   Len := Length(s);
   StringList := nil;
   while Len>0 do begin
     p := FindChar(pc, Len);
     if p=1 then begin
       inc(pc);
       dec(Len);
       continue;
     end;
     if p=0 then
       p := Len+1;
     SetLength(CurrentWord, p-1);
     Move(pc^, PChar(CurrentWord)^, p-1);
     if {(RV_CharPos(PChar(CurrentWord), '.', p-1)<>0) and}
        (IsAddress(CurrentWord) or IsEmail(CurrentWord)) then begin
        if StringList=nil then
          StringList := TStringList.Create;
        if pcstart<pc then begin
          SetLength(s1, pc-pcstart);
          Move(pcstart^, PChar(s1)^, pc-pcstart);
          StringList.Add(s1);
        end;
        StringList.AddObject(CurrentWord, TObject(1));
        inc(pc, p-1);
        dec(Len, p-1);
        pcstart := pc;
        end
     else begin
       inc(pc, p-1);
       dec(Len, p-1);
     end;
   end;
   Result := StringList<>nil;
   if Result then begin
    URLStyle := RVData.GetItemStyle(Index);
    URLScanProcedure(URLStyle, URLStyle, True);
    if URLStyle=RVData.GetItemStyle(Index) then begin
      StringList.Free;
      Result := False;
      exit;
    end;
    if pcstart<pc then begin
      SetLength(s1, pc-pcstart);
      Move(pcstart^, PChar(s1)^, pc-pcstart);
      StringList.Add(s1);
    end;
    sourceitem := RVData.GetItem(Index);
    for i := StringList.Count-1 downto 1 do begin
      item := TCustomRVItemInfoClass(sourceitem.ClassType).Create(RVData);
      item.Assign(sourceitem);
      item.SameAsPrev := True;
      if StringList.Objects[i]<>nil then
        item.StyleNo := UrlStyle;
      RVData.Items.InsertObject(Index+1,StringList[i],item);
    end;
    if StringList.Objects[0]<>nil then
      sourceitem.StyleNo := UrlStyle;
    RVData.Items[Index] := StringList[0];
   end;
   StringList.Free;
end;
{======================= Processing Unicode text ==============================}
{$IFDEF RICHVIEWDEF3}
function StrPosW(Str, SubStr: PWideChar): PWideChar;

// returns a pointer to the first occurance of SubStr in Str

asm
         PUSH EDI
         PUSH ESI
         PUSH EBX
         OR EAX, EAX
         JZ @@2
         OR EDX, EDX
         JZ @@2
         MOV EBX, EAX
         MOV EDI, EDX
         XOR AX, AX
         MOV ECX, 0FFFFFFFFH
         REPNE SCASW
         NOT ECX
         DEC ECX
         JZ @@2
         MOV ESI, ECX
         MOV EDI, EBX
         MOV ECX, 0FFFFFFFFH
         REPNE SCASW
         NOT ECX
         SUB ECX, ESI
         JBE @@2
         MOV EDI, EBX
         LEA EBX, [ESI - 1] // Note: 2 would be wrong here, we are dealing with numbers not an address
@@1:     MOV ESI, EDX
         LODSW
         REPNE SCASW
         JNE @@2
         MOV EAX, ECX
         PUSH EDI
         MOV ECX, EBX
         REPE CMPSW
         POP EDI
         MOV ECX, EAX
         JNE @@1
         LEA EAX, [EDI - 2]
         JMP @@3

@@2:     XOR EAX, EAX
@@3:     POP EBX
         POP ESI
         POP EDI
end;
{------------------------------------------------------------------------------}
function CharPosW(const Str: PWideChar {EAX}; Chr: WideChar {DX} ; Length: Integer {ECX}): Integer; assembler;
asm
        TEST    EAX,EAX
        JE      @@2
        PUSH    EDI
        PUSH    EBX
        MOV     EDI,Str
        MOV     EBX,Str
        MOV     AX,Chr
        REPNE   SCASW
        MOV     EAX,0
        JNE     @@1
        MOV     EAX,EDI
        SUB     EAX,EBX
@@1:    POP     EBX
        POP     EDI
@@2:
end;
{--------------------------------------------------------------}
function LowerCaseW(const s: WideString): WideString;
var
  Len: Integer;
begin
  Len := Length(s);
  SetLength(Result, Length(s));
  Move(PWideChar(s)^, PWideChar(Result)^, Length(s)*2);
  if Len > 0 then
    CharLowerBuffW(Pointer(Result), Len);
end;
{--------------------------------------------------------------}
function IsAddressW(const str: WideString): Boolean;
var s: WideString;
    ps: PWideChar;
begin
  // Checks for prefix.
  // For better results, it should check for lengths...
  // LowerCaseW will work only for WinNT-based systems
  s := LowerCaseW(str);
  ps := PWideChar(s);
  Result :=
        (StrPosW(ps, 'http://'   )=ps) or
        (StrPosW(ps, 'ftp://'    )=ps) or
        (StrPosW(ps, 'file://'   )=ps) or
        (StrPosW(ps, 'gopher://' )=ps) or
        (StrPosW(ps, 'mailto:' )=ps) or
        (StrPosW(ps, 'https://'  )=ps) or
        (StrPosW(ps, 'news:'     )=ps) or
        (StrPosW(ps, 'telnet:'   )=ps) or
        (StrPosW(ps, 'wais:'     )=ps) or
        (StrPosW(ps, 'www.'      )=ps) or
        (StrPosW(ps, '\\'      )=ps) or
        (StrPosW(ps, '//'      )=ps) or
        (StrPosW(ps, 'ftp.'      )=ps);
end;
{--------------------------------------------------------------}
function IsEmailW(const s: WideString): Boolean;
var i: Integer;
    at: Boolean;
begin
  //'@' must exist and '.' must be after it. This is not comprehensive test,
  //but I think that it's ok
  at := False;
  Result := False;
  for i := 1 to Length(s) do
    case s[i] of
    '@':
       begin
         if at then
           exit;
         at := True;
       end;
    '.':
       begin
         if at then begin
           Result := True;
           exit;
         end;
       end;
    end;
end;
{--------------------------------------------------------------}
function FindCharW(pc: PWideChar; Len: Integer): Integer;
var i: Integer;
begin
  for i := 0 to Len-1 do
    if pc[i] in [WideChar(' '),WideChar(','),WideChar('('),WideChar(')'),
      WideChar(';'),WideChar('"'),WideChar('''')] then begin
      Result := i+1;
      exit;
    end;
  Result := 0;
end;
{--------------------------------------------------------------}
// This function uses some undocumented methods
function DetectURLsW(var RVData: TCustomRVFormattedData;
                     Index: Integer;
                     URLScanProcedure: TRVURLScanProcedure): Boolean;
var CurrentWord: WideString;
    i,p: Integer;
    s : WideString;
    s1: String;
    pc, pcstart: PWideChar;
    Len, URLStyle: Integer;
    StringList: TStringList;
    sourceitem,item: TCustomRVItemInfo;
begin
   s := RVData.GetItemTextW(Index);
   pc := PWideChar(s);
   pcstart := pc;
   Len := Length(s);
   StringList := nil;
   while Len>0 do begin
     p := FindCharW(pc, Len);
     if p=1 then begin
       inc(pc);
       dec(Len);
       continue;
     end;
     if p=0 then
       p := Len+1;
     SetLength(CurrentWord, p-1);
     Move(pc^, PWideChar(CurrentWord)^, (p-1)*2);
     if (CharPosW(PWideChar(CurrentWord), '.', p-1)<>0) and
        (IsAddressW(CurrentWord) or IsEmailW(CurrentWord)) then begin
        if StringList=nil then
          StringList := TStringList.Create;
        if pcstart<pc then begin
          SetLength(s1, (pc-pcstart)*2);
          Move(pcstart^, PChar(s1)^, (pc-pcstart)*2);
          StringList.Add(s1);
        end;
        SetLength(s1, Length(CurrentWord)*2);
        Move(pc^, PChar(s1)^, Length(s1));
        StringList.AddObject(s1, TObject(1));
        inc(pc, p-1);
        dec(Len, p-1);
        pcstart := pc;
        end
     else begin
       inc(pc, p-1);
       dec(Len, p-1);
     end;
   end;
   Result := StringList<>nil;
   if Result then begin
    URLStyle := RVData.GetItemStyle(Index);
    URLScanProcedure(URLStyle, URLStyle, True);
    if URLStyle=RVData.GetItemStyle(Index) then begin
      StringList.Free;
      Result := False;
      exit;
    end;
    if pcstart<pc then begin
      SetLength(s1, (pc-pcstart)*2);
      Move(pcstart^, PChar(s1)^, (pc-pcstart)*2);
      StringList.Add(s1);
    end;
    sourceitem := RVData.GetItem(Index);
    for i := StringList.Count-1 downto 1 do begin
      item := TCustomRVItemInfoClass(sourceitem.ClassType).Create(RVData);
      item.Assign(sourceitem);
      item.SameAsPrev := True;
      if StringList.Objects[i]<>nil then
        item.StyleNo := UrlStyle;
      RVData.Items.InsertObject(Index+1, StringList[i],item);
    end;
    if StringList.Objects[0]<>nil then
      sourceitem.StyleNo := UrlStyle;
    RVData.Items[Index] := StringList[0];
   end;
   StringList.Free;
end;
{$ENDIF}
{========================== Common functions ==================================}
function ScanURLs(RVData: TCustomRVFormattedData;
                    URLScanProcedure: TRVURLScanProcedure): Boolean;
var i,r,c: Integer;
    table: TRVTableItemInfo;
    RVStyle: TRVStyle;
    StyleNo: Integer;
begin
  Result := False;
  RVStyle := RVData.GetRVStyle;
  for i := RVData.Items.Count-1 downto 0 do begin
    StyleNo := RVData.GetItemStyle(i);
    if StyleNo=rvsTable then begin
      table := TRVTableItemInfo(RVData.GetItem(i));
      for r := 0 to table.Rows.Count-1 do
        for c := 0 to table.Rows[r].Count-1 do
          if table.Cells[r,c]<>nil then
            if ScanURLs(TCustomRVFormattedData(table.Cells[r,c].GetRVData), URLScanProcedure) then begin
              Result := True;
              table.Changed;
            end;
      end
    else if (StyleNo>=0) then
      if not RVStyle.TextStyles[StyleNo].Unicode then
         Result := DetectURLs(RVData, i, URLScanProcedure) or Result
      {$IFDEF RICHVIEWDEF3}
      else
         Result := DetectURLsW(RVData, i, URLScanProcedure) or Result
      {$ENDIF};
  end;
end;
{--------------------------------------------------------------}
function ClearHypertext(RVData: TCustomRVFormattedData;
                          URLScanProcedure: TRVURLScanProcedure): Boolean;
var i,r,c: Integer;
    table: TRVTableItemInfo;
    RVStyle: TRVStyle;
    StyleNo: Integer;
begin
  Result := False;
  RVStyle := RVData.GetRVStyle;
  for i := RVData.Items.Count-1 downto 0 do begin
    StyleNo := RVData.GetItemStyle(i);
    if StyleNo=rvsTable then begin
      table := TRVTableItemInfo(RVData.GetItem(i));
      for r := 0 to table.Rows.Count-1 do
        for c := 0 to table.Rows[r].Count-1 do
          if table.Cells[r,c]<>nil then
            if ClearHypertext(TCustomRVFormattedData(table.Cells[r,c].GetRVData), URLScanProcedure) then begin
              Result := True;
              table.Changed;
            end;
      end
    else if (StyleNo>=0) and RVStyle.TextStyles[StyleNo].Jump then begin
       URLScanProcedure(StyleNo,StyleNo,False);
       Result := StyleNo<>RVData.GetItemStyle(i);
       if Result then
         RVData.GetItem(i).StyleNo := StyleNo;
    end;
  end;
  if Result then
    RVData.Normalize;
end;

end.

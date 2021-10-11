{
UniChat - chat for LANs.
UCPlugin.pas - UniChat Plugins object.

$Author(s): Dentall
$Last revision: 05/09/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit UCPlugin;

interface

uses Classes, Windows, Registry, sysutils;

type
  PUniChatPlugin = ^TUniChatPlugin;
  TUniChatPlugin = record
    hModule: cardinal;
    name: Pchar;
    useAsInput: boolean;
    useAsOutput: boolean;
    useAsCommand: boolean;
    workfunc: pointer;
    workfunc_cmd: pointer;
  end;

type
  TUniChatPlugins = class(TObject)

  private
    FPlugList: TList;
    FSavedInPlugins: TStringList;
    FSavedOutPlugins: TStringList;
  public
    constructor Create(apppath: string);
    destructor Destroy; override;
    procedure LoadComplete;
    function LoadPlugin(const path: string): TUniChatPlugin;
    procedure EnableByInput(const PlugName: string);
    procedure EnableByOutput(const PlugName: string);
    procedure DisableByInput(const PlugName: string);
    procedure DisableByOutput(const PlugName: string);
    function ProcessInput(const data: string): string;
    function ProcessOutput(const data: string): string;
    function ExecCommand(const cmd,params: string): integer;
    function GetCount: integer;
  end;

implementation
uses forms,main,globalconst;

{procedure ReadModes(aSection: string; data: Tstrings);
var
  sIniFile: TRegIniFile;
  sPath: string;
  i,z: integer;
begin
  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath,KEY_READ);
  sIniFile.ReadSection(aSection, data);
  z:=data.Count-1;
  data.Clear;
  for i:=0 to z do
  begin
  sPath:=sIniFile.ReadString(aSection,'item'+inttostr(i),'');
  if sPath<>'' then Data.Add(sPath);
  end;

  sIniFile.Free;
end;}

constructor TUniChatPlugins.Create(apppath: string);
var
  fIni: TRegIniFile;
  i,z: integer;
  tmp: string;
begin
  FPlugList := TList.Create;
  FSavedInPlugins := TStringList.Create;
  FSavedOutPlugins := TStringList.Create;

  fIni := TRegIniFile.Create('Software\UniChat145\Plugins',KEY_READ);

  fIni.ReadSection('InputPlugins', FSavedInPlugins);
  fIni.ReadSection('OutputPlugins', FSavedOutPlugins);

  z:=FSavedInPlugins.Count-1;
  FSavedInPlugins.Clear;
  for i:=0 to z do
  begin
  tmp:=fIni.ReadString('InputPlugins','item'+inttostr(i),'');
  if tmp<>'' then FSavedInPlugins.Add(tmp);
  end;

  z:=FSavedOutPlugins.Count-1;
  FSavedOutPlugins.Clear;
  for i:=0 to z do
  begin
  tmp:=fIni.ReadString('OutputPlugins','item'+inttostr(i),'');
  if tmp<>'' then FSavedOutPlugins.Add(tmp);
  end;

  fIni.Free;

  inherited Create;
end;

destructor TUniChatPlugins.Destroy;
var
  i,x,y: integer;
  fIni: TRegIniFile;
begin

  fIni := TRegIniFile.Create('Software\UniChat145\Plugins',KEY_WRITE);
  fIni.EraseSection('InputPlugins');
  fIni.EraseSection('OutputPlugins');
  x:=0;
  y:=0;
  for i := 0 to FPlugList.Count - 1 do
  begin

    if PUniChatPlugin(FPlugList.Items[i]).useAsInput then
    begin
      fIni.WriteString('InputPlugins','item'+inttostr(x) ,
        PUniChatPlugin(FPlugList.Items[i]).name);
        Inc(x);
    end;

    if PUniChatPlugin(FPlugList.Items[i]).useAsOutput then
     begin
      fIni.WriteString('OutputPlugins', 'item'+inttostr(y),PUniChatPlugin(FPlugList.Items[i]).name);
      inc(y);
     end;

    FreeLibrary(PUniChatPlugin(FPlugList.Items[i]).hModule);
    FreeMem(FPlugList.Items[i]);
//    FPlugList.Delete(i);


  end;
  FPlugList.Free;
  fIni.free;
  inherited Destroy;
end;

procedure TUniChatPlugins.LoadComplete;
begin
FSavedInPlugins.Free;
FSavedOutPlugins.Free;
end;

function TUniChatPlugins.LoadPlugin(const path: string): TUniChatPlugin;
var
  PlugInfo: TUniChatPlugin;
  p: pUniChatPlugin;
  getplugname: function: PChar; stdcall;
begin
  Result.name := '';

  PlugInfo.hModule := LoadLibrary(PChar(path));
  if PlugInfo.hModule = 0 then
    exit;
  PlugInfo.workfunc := GetProcAddress(PlugInfo.hModule, 'workfunc');

  GetPlugName := GetProcAddress(PlugInfo.hModule, 'getplugname');
  if (@PlugInfo.workfunc = nil) or (@GetPlugName = nil) then
  begin
    PlugInfo.workfunc_cmd := GetProcAddress(PlugInfo.hModule, 'execcmd');
    if @PlugInfo.workfunc_cmd = nil then
    begin
      FreeLibrary(PlugInfo.hModule);
      exit;
    end
    else
    begin
      PlugInfo.useAsCommand := True;
      PlugInfo.useAsInput := False;
      PlugInfo.useAsOutput := False;
      GetMem(p, sizeof(PlugInfo));
      if p = nil then
      begin
        FreeLibrary(PlugInfo.hModule);
        exit;
      end;
      move(PlugInfo, p^, sizeof(PlugInfo));
      FPlugList.Add(p);
    end;
  end
  else
  begin
    PlugInfo.name := GetPlugName;
    PlugInfo.useAsCommand := False;

    if FSavedInPlugins.IndexOf(PlugInfo.name) <> -1 then
      PlugInfo.useAsInput := True
    else
      PlugInfo.useAsInput := False;

    if FSavedOutPlugins.IndexOf(PlugInfo.name) <> -1 then
      PlugInfo.useAsOutput := True
    else
      PlugInfo.useAsOutput := False;

    GetMem(p, sizeof(PlugInfo));
    if p = nil then
    begin
      FreeLibrary(PlugInfo.hModule);
      exit;
    end;
    move(PlugInfo, p^, sizeof(PlugInfo));
    FPlugList.Add(p);
    Result := PlugInfo;
  end;

end;

procedure TUniChatPlugins.EnableByInput(const PlugName: string);
var
  i: integer;
begin
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).name = PlugName then
    begin
      PUniChatPlugin(FPlugList.Items[i]).useAsInput := True;
      break;
    end;
end;

procedure TUniChatPlugins.EnableByOutput(const PlugName: string);
var
  i: integer;
begin
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).name = PlugName then
    begin
      PUniChatPlugin(FPlugList.Items[i]).useAsOutput := True;
      break;
    end;
end;

procedure TUniChatPlugins.DisableByInput(const PlugName: string);
var
  i: integer;
begin
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).name = PlugName then
    begin
      PUniChatPlugin(FPlugList.Items[i]).useAsInput := False;
      break;
    end;
end;

procedure TUniChatPlugins.DisableByOutput(const PlugName: string);
var
  i: integer;
begin
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).name = PlugName then
    begin
      PUniChatPlugin(FPlugList.Items[i]).useAsOutput := False;
      break;
    end;
end;

function TUniChatPlugins.ProcessInput(const data: string): string;
var
  i: integer;
  wf: function(input: PChar): PChar; stdcall;
begin
  Result := data;
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).useAsInput then
    begin
      wf := PUniChatPlugin(FPlugList.Items[i]).workfunc;
      Result := wf(PChar(Result));
    end;
end;

function TUniChatPlugins.ProcessOutput(const data: string): string;
var
  i: integer;
  wf: function(input: PChar): PChar; stdcall;
begin
  Result := data;
  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).useAsOutput then
    begin
      wf := PUniChatPlugin(FPlugList.Items[i]).workfunc;
      Result := wf(PChar(Result));
    end;
end;

function TUniChatPlugins.ExecCommand(const cmd,params: string): integer;
var
  i: integer;
  wf: function (cmd,params: Pchar): integer; stdcall;
begin
  Result := -1;

if cmd = 'signal' then
begin
playwave(tsSignal, True);
Result:=1;
exit;
end;

  for i := 0 to FPlugList.Count - 1 do
    if PUniChatPlugin(FPlugList.Items[i]).useAsCommand then
    begin
      wf := PUniChatPlugin(FPlugList.Items[i]).workfunc_cmd;
      Result := wf(PChar(cmd),PChar(params));
      if Result=1 then
      exit;
    end;
end;

function TUniChatPlugins.GetCount: integer;
begin
  Result := FPlugList.Count;
end;

end.


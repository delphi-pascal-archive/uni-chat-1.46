unit multiinst;
{

����������:
����������� ��� � �������� �������


if InitInstance then
begin
Application.Initialize;
Application.CreateForm(TFrmSelProject, FrmSelProject);
Application.Run;
end;
��� ��� ������� (� �������)
}


interface

uses Forms, Windows, Dialogs, SysUtils;

const

MI_NO_ERROR = 0;
MI_FAIL_SUBCLASS = 1;
MI_FAIL_CREATE_MUTEX = 2;

{ �������� ������������ ������� ���������� � ������� ��������� ���� �������. }
{ ���������� ������ ������ MI_* ����� ���� ����� ������. }

function GetMIError: Integer;
Function InitInstance : Boolean;

implementation




var
UniqueAppStr : PChar = 'UniChatUnique';   {��������� ��� ������� ����������}
MessageId: Integer;
WProc: TFNWndProc = Nil;
MutHandle: THandle = 0;
MIError: Integer = 0;


function GetMIError: Integer;
begin

Result := MIError;
end;

function NewWndProc(Handle: HWND; Msg: Integer; wParam,

lParam: Longint): Longint; StdCall;
begin

  { ���� ��� - ��������� � �����������... }

if Msg = MessageID then begin
    { ���� �������� ����� ��������������, ��������������� �� }

{ �������� ����� ���������� }
if IsIconic(Application.Handle) then begin
Application.MainForm.WindowState := wsNormal;
ShowWindow(Application.Mainform.Handle, sw_restore);
end;
SetForegroundWindow(Application.MainForm.Handle);
end
{ � ��������� ������ �������� ��������� ����������� ���� }
else
Result := CallWindowProc(WProc, Handle, Msg, wParam, lParam);
end;

procedure SubClassApplication;
begin

{ ������������ ���������. ����������, ����� ���������� }
{ Application.OnMessage ��� �������� ��� �������������. }
WProc := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
Longint(@NewWndProc)));
{ ���� ���������� ������, ������������� ���������� ���� }
if WProc = Nil then
MIError := MIError or MI_FAIL_SUBCLASS;
end;

procedure DoFirstInstance;
begin

SubClassApplication;
MutHandle := CreateMutex(Nil, False, UniqueAppStr);
if MutHandle = 0 then
MIError := MIError or MI_FAIL_CREATE_MUTEX;
end;

procedure BroadcastFocusMessage;
{ ��������� ����������, ���� ��� ������� ���������� ����� ����� ���������. }
var

BSMRecipients: DWORD;
begin
  { �� ���������� �������� ����� }

Application.ShowMainForm := False;
{ �������� ������� ���������� ��������� � ����������� � ������������� }
{ ��������� ����� �� ���� }
BSMRecipients := BSM_APPLICATIONS;
BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
@BSMRecipients, MessageID, 0, 0);
end;

Function InitInstance : Boolean;
begin

MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, UniqueAppStr);
if MutHandle = 0 then
begin
    { ������ Mutex ��� �� ������, �������, ��� ��� �� ������� }

{ ������ ����������. }
//ShowWindow(Application.Handle, SW_ShowNormal);
//Application.ShowMainForm:=True;
DoFirstInstance;
result := True;
end
else
begin
BroadcastFocusMessage;
result := False;
end;
end;

initialization 
begin

//UniqueAppStr := PChar(Application.Exename);
MessageID := RegisterWindowMessage(UniqueAppStr);
ShowWindow(Application.Handle, SW_Hide);
//Application.ShowMainForm:=FALSE;
end;

finalization
begin

if WProc <> Nil then
    { �������� ���������� � �������� ��������� }

SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(WProc));
end;
end.


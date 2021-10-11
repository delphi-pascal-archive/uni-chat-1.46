program unichat;
//{$DEFINE CANMULINSTANCE}
//{$DEFINE UNICODERSNET}

uses
  Forms,
  Windows,
  main in 'main.pas' {fmMain},
  fmSettings in 'fmSettings.pas' {fmSetup},
  sendform in 'sendform.pas' {fmSend},
  infoform in 'infoform.pas' {fmInfo},
  chatutils in 'chatutils.pas',
  commentform in 'commentform.pas' {fmComment},
  about in 'about.pas' {fmAbout},
  SendMassForm in 'SendMassForm.pas' {fmMassSend},
  GlobalConst in 'GlobalConst.pas',
  RoomsForm in 'RoomsForm.pas' {fmRooms},
  udpsock in 'udpsock.pas',
  ExecuteThread in 'ExecuteThread.pas',
  LogForm in 'LogForm.pas' {fmMsgLog},
  UCPlugin in 'UCPlugin.pas',
  DynaStackProtect in 'DynaStackProtect.pas',
  regForm in 'regForm.pas' {fmRegistration},
  topicform in 'topicform.pas' {fmTopic},
  regInfoForm in 'regInfoForm.pas' {fmRegInfo},
  recForm in 'recForm.pas' {fmRec};

{$R *.res}


begin
{$IFNDEF CANMULINSTANCE}
  MemHnd := CreateFileMapping(HWND($FFFFFFFF), nil,
    PAGE_READWRITE, 0, MemFileSize,
    MemFileName);
  if ((GetLastError <> ERROR_ALREADY_EXISTS) or (ParamStr(1)='-server')) and (GlobalFindAtom('fkcik3') = 0) then
  begin
{$ENDIF}


    Application.Initialize;
    Application.Title := 'UniChat v1.46';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;


{$IFNDEF CANMULINSTANCE}

  end
  else
    CloseHandle(MemHnd);
{$ENDIF}
end.


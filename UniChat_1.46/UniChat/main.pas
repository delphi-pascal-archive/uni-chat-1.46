{
UniChat - chat for LANs.
main.pas - main form source module.

$Author(s): Dentall, Dr. Evil
$Last revision: 03/03/2006

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2006 GlumClub team
}

unit main;

{$I uc_defs.inc}



interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Clipbrd,
  Controls, Forms, Dialogs, StdCtrls, ImgList, Menus, ExtCtrls, ComCtrls,
  Buttons, CoolTrayIcon, AppEvnts,
  DCPcrypt2, DCPRC6, ActnMan, ActnColorMaps,
  ShellAPI, SBPro, Sockets, Spin, FileCtrl,
  RVScroll,
  RichView,
  CRVFData,
  RvItem,
  GlobalConst,
  ActnList, ScktComp, XPStyleActnCtrls, ActnCtrls, ActnMenus, ExecuteThread,
  UCPlugin, RVStyle, ToolWin, DynaStackProtect, PJWdwState, JvExStdCtrls,
  JvCombobox, JvListComb, ActnPopup, KeyState, fisHotKey, consts, masks,
  StdStyleActnCtrls;


const
  WM_SOCKET = WM_USER + 100; // Любые свободнее сообщения

type
  TfmMain = class(TForm)
    pmUser: TPopupActionBar;
    miMessage: TMenuItem;
    miSignal: TMenuItem;
    miInfo: TMenuItem;
    N27: TMenuItem;
    miMassMsg: TMenuItem;
    miSay: TMenuItem;
    pmTray: TPopupActionBar;
    miMode: TMenuItem;
    miRestore: TMenuItem;
    miExit: TMenuItem;
    N38: TMenuItem;
    N4: TMenuItem;
    miFilter: TMenuItem;
    meIgnoreMain: TMenuItem;
    N69: TMenuItem;
    miIngnorMsg: TMenuItem;
    miRfsh: TMenuItem;
    N112: TMenuItem;
    miLogs: TMenuItem;
    miIngnorePriv: TMenuItem;
    imPageCtrl: TImageList;
    ct1: TCoolTrayIcon;
    ilTray: TImageList;
    tRfsh: TTimer;
    pnUser: TPanel;
    pnWind: TPanel;
    pg1: TPageControl;
    ttMain: TTabSheet;
    pnedit: TPanel;
    spltr: TSplitter;
    pmSmiles: TPopupMenu;
    mainSmile: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    D1: TMenuItem;
    D2: TMenuItem;
    B1: TMenuItem;
    N7: TMenuItem;
    P1: TMenuItem;
    edText: TMemo;
    pmCommand: TPopupActionBar;
    here1: TMenuItem;
    me1: TMenuItem;
    join1: TMenuItem;
    topic1: TMenuItem;
    chat1: TMenuItem;
    whois1: TMenuItem;
    N81: TMenuItem;
    N8D1: TMenuItem;
    o1: TMenuItem;
    N8: TMenuItem;
    N8O1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    Splitter1: TSplitter;
    N43: TMenuItem;
    N56: TMenuItem;
    N65: TMenuItem;
    N113: TMenuItem;
    T1: TMenuItem;
    X1: TMenuItem;
    N121: TMenuItem;
    N122: TMenuItem;
    N810: TMenuItem;
    N168: TMenuItem;
    N169: TMenuItem;
    N170: TMenuItem;
    pmRE: TPopupActionBar;
    miClear: TMenuItem;
    miTXT: TMenuItem;
    sbpMain: TStatusBarPro;
    od1: TOpenDialog;
    Bevel1: TBevel;
    Panel3: TPanel;
    TimerFlash: TTimer;
    Panel4: TPanel;
    ilMenu: TImageList;
    miActive1: TMenuItem;
    miGaming1: TMenuItem;
    miDND1: TMenuItem;
    miOffline1: TMenuItem;
    miAway1: TMenuItem;
    N31: TMenuItem;
    N53: TMenuItem;
    TimerFlashScr: TTimer;
    sbTotal: TStatusBarPro;
    N54: TMenuItem;
    os1: TSaveDialog;
    N16: TMenuItem;
    N55: TMenuItem;
    pmMacros: TPopupActionBar;
    ilSmilesPack2: TImageList;
    N61: TMenuItem;
    TimerBaloon: TTimer;
    fd1: TFontDialog;
    N70: TMenuItem;
    N82: TMenuItem;
    N8S1: TMenuItem;
    E1: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    pnBalance: TPanel;
    pnTopic_noSmile: TPanel;
    Bevel5: TBevel;
    ilTopic: TImageList;
    TimerFlood: TTimer;
    rvMain: TRichView;
    lvUser: TListView;
    N0s1: TMenuItem;
    RVStyle: TRVStyle;
    N85: TMenuItem;
    B2: TMenuItem;
    N8X1: TMenuItem;
    N86: TMenuItem;
    o4: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N90: TMenuItem;
    o5: TMenuItem;
    O6: TMenuItem;
    E2: TMenuItem;
    N91: TMenuItem;
    RTF1: TMenuItem;
    N58: TMenuItem;
    N92: TMenuItem;
    N94: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    N99: TMenuItem;
    N100: TMenuItem;
    miNoResponse: TMenuItem;
    N101: TMenuItem;
    ttboard: TTabSheet;
    rvBoard: TRichView;
    pmBoard: TPopupActionBar;
    miBoardCopyAll: TMenuItem;
    N103: TMenuItem;
    miBoardCopySelf: TMenuItem;
    miBoardDelSelf: TMenuItem;
    N106: TMenuItem;
    miRefresh: TMenuItem;
    amMain: TActionManager;
    ammbMain: TActionMainMenuBar;
    Client: TClientSocket;
    TimerRecoonect: TTimer;
    pmLink: TPopupActionBar;
    N1: TMenuItem;
    N2: TMenuItem;
    TopicTimer: TTimer;
    pmTopic: TPopupActionBar;
    miChangeTopic: TMenuItem;
    nickf1: TMenuItem;
    N6: TMenuItem;
    action1: TMenuItem;
    N114: TMenuItem;
    miSortBoard: TMenuItem;
    miByNick: TMenuItem;
    miByTime: TMenuItem;
    N118: TMenuItem;
    msg2: TMenuItem;
    TimerRepeat: TTimer;
    TimerSpeed: TTimer;
    TimerMode: TTimer;
    TimerRename: TTimer;
    BoardTimer: TTimer;
    miAutoScroll: TMenuItem;
    N104: TMenuItem;
    TimerUserActivity: TTimer;
    pmSmilesPack2: TPopupMenu;
    N01: TMenuItem;
    D3: TMenuItem;
    o2: TMenuItem;
    F1: TMenuItem;
    N74: TMenuItem;
    X2: TMenuItem;
    Q1: TMenuItem;
    N75: TMenuItem;
    i1: TMenuItem;
    N76: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    gi1: TMenuItem;
    N80: TMenuItem;
    XX1: TMenuItem;
    N381: TMenuItem;
    i2: TMenuItem;
    iY1: TMenuItem;
    N77: TMenuItem;
    N02: TMenuItem;
    N001: TMenuItem;
    I3: TMenuItem;
    mar1: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    s1: TMenuItem;
    o3: TMenuItem;
    bat1: TMenuItem;
    TimerAntiSound: TTimer;
    N115: TMenuItem;
    P2: TMenuItem;
    N116: TMenuItem;
    N117: TMenuItem;
    N119: TMenuItem;
    o7: TMenuItem;
    N120: TMenuItem;
    N811: TMenuItem;
    o8: TMenuItem;
    N123: TMenuItem;
    j1: TMenuItem;
    N124: TMenuItem;
    N125: TMenuItem;
    N127: TMenuItem;
    corporal1: TMenuItem;
    indigene1: TMenuItem;
    bigears1: TMenuItem;
    censored1: TMenuItem;
    scull1: TMenuItem;
    shout1: TMenuItem;
    kick1: TMenuItem;
    N128: TMenuItem;
    TimerAntiMe: TTimer;
    TimerWriteOut: TTimer;
    AntiFastRefreshTimer: TTimer;
    N129: TMenuItem;
    N130: TMenuItem;
    miKick: TMenuItem;
    miBan: TMenuItem;
    miUnban: TMenuItem;
    miKillMsg: TMenuItem;
    miForceSignal: TMenuItem;
    Massadminmessage1: TMenuItem;
    edTopic: TJvImageComboBox;
    Panel5: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    pnNicks: TPanel;
    cbNick: TJvImageComboBox;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    bevBalance: TBevel;
    PJRegWdwState: TPJRegWdwState;
    miRETopic: TMenuItem;
    N135: TMenuItem;
    GHkey: TfisHotKey;
    ape: TApplicationEvents;
    SLState: TKeyState;
    TimerAF: TTimer;
    TimerAntiScr: TTimer;
    HKDisableSL: TfisHotKey;
    NTimer: TTimer;
    aTalk: TAction;
    aEdit: TAction;
    aView: TAction;
    aOptions: TAction;
    aHelp: TAction;
    aContents: TAction;
    aMailDev: TAction;
    aVisitSite: TAction;
    aRegister: TAction;
    aAbout: TAction;
    aPopUpNew: TAction;
    aStartMinim: TAction;
    aShowTBIco: TAction;
    aAskModeComnt: TAction;
    aDisableSmilesGaming: TAction;
    aChangePageWheel: TAction;
    aShowActiveWnd: TAction;
    aMaxLines: TAction;
    aAllOptions: TAction;
    aUsrListPos: TAction;
    aTimeStamp: TAction;
    aTabStyle: TAction;
    aScrBarEditor: TAction;
    aAutoScrollTxt: TAction;
    aDrawSmiles: TAction;
    aFlashTBIco: TAction;
    aFlashSL: TAction;
    aShowTopic: TAction;
    aShowNick: TAction;
    aShowBoard: TAction;
    aShowInfo: TAction;
    aMsgInMain: TAction;
    aLeft: TAction;
    aRight: TAction;
    aHHMM: TAction;
    aHHMMSS: TAction;
    aFlatBtn: TAction;
    aBtn: TAction;
    aTabs: TAction;
    aMode: TAction;
    aRooms: TAction;
    aCmd: TAction;
    aLeave: TAction;
    aPlgIn: TAction;
    aPlgOut: TAction;
    aProtocol: TAction;
    aCopy2Mac: TAction;
    aPasteFrMac: TAction;
    aUserInfo: TAction;
    aPriviledge: TAction;
    aExit: TAction;
    aCopyAll: TAction;
    aClearChat: TAction;
    aClearLine: TAction;
    aClearHistory: TAction;
    aSendLink: TAction;
    aSwitchKbd: TAction;
    aLinkFile: TAction;
    aLinkRes: TAction;
    aRusEng: TAction;
    aEngRus: TAction;
    aToggle: TAction;
    aSay: TAction;
    aRefresh: TAction;
    aBeep: TAction;
    aMsg: TAction;
    aMassMsg: TAction;
    aPrivate: TAction;
    aInfo: TAction;
    aTopicChg: TAction;
    aNoShowMsg: TAction;
    aActive: TAction;
    aGaming: TAction;
    aDND: TAction;
    aDisabled: TAction;
    aAway: TAction;
    aChngComm: TAction;
    aArchiveTab: TAction;
    aArchiveMsg: TAction;
    aBrowseLogs: TAction;
    aSelLogDir: TAction;
    aLogMain: TAction;
    aLogRoom: TAction;
    aLogMsg: TAction;
    aLogPrivate: TAction;
    aMe: TAction;
    aCmdMsg: TAction;
    aCmdTopic: TAction;
    aHere: TAction;
    aNick: TAction;
    aJoin: TAction;
    aChat: TAction;
    aWhois: TAction;
    aAction: TAction;
    aMac12: TAction;
    aMac11: TAction;
    aMac10: TAction;
    aMac9: TAction;
    aMac8: TAction;
    aMac7: TAction;
    aMac6: TAction;
    aMac5: TAction;
    aMac4: TAction;
    aMac3: TAction;
    aMac2: TAction;
    aMac1: TAction;
    aMacPaste12: TAction;
    aMacPaste11: TAction;
    aMacPaste10: TAction;
    aMacPaste9: TAction;
    aMacPaste8: TAction;
    aMacPaste7: TAction;
    aMacPaste6: TAction;
    aMacPaste5: TAction;
    aMacPaste4: TAction;
    aMacPaste3: TAction;
    aMacPaste2: TAction;
    aMacPaste1: TAction;
    miTalk: TMenuItem;
    aNoneMac: TAction;
    aMacPaste13: TMenuItem;
    aMacPaste21: TMenuItem;
    aMacPaste31: TMenuItem;
    aMacPaste41: TMenuItem;
    aMacPaste51: TMenuItem;
    aMacPaste61: TMenuItem;
    aMacPaste71: TMenuItem;
    aMacPaste81: TMenuItem;
    aMacPaste91: TMenuItem;
    aMacPaste101: TMenuItem;
    aMacPaste111: TMenuItem;
    aMacPaste121: TMenuItem;
    N11: TMenuItem;
    aInPluginExec: TAction;
    aOutPluginExec: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    miMsg: TMenuItem;
    atbMain: TActionToolBar;
    aTbMode: TAction;
    aShowToolBar: TAction;
    procedure aNoShowMsgExecute(Sender: TObject);
    procedure aShowToolBarExecute(Sender: TObject);
    procedure ammbMainEnterMenuLoop(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aMacPasteExecute(Sender: TObject);
    procedure aMacrosExecute(Sender: TObject);
    procedure aCmdExecute(Sender: TObject);
    procedure aSelLogDirExecute(Sender: TObject);
    procedure aBrowseLogsExecute(Sender: TObject);
    procedure aArchiveMsgExecute(Sender: TObject);
    procedure aArchiveTabExecute(Sender: TObject);
    procedure aModeExecute(Sender: TObject);
    procedure aChngCommExecute(Sender: TObject);
    procedure aRoomsExecute(Sender: TObject);
    procedure aUserInfoExecute(Sender: TObject);
    procedure aPriviledgeExecute(Sender: TObject);
    procedure aTopicChgExecute(Sender: TObject);
    procedure aInfoExecute(Sender: TObject);
    procedure aPrivateExecute(Sender: TObject);
    procedure aBeepExecute(Sender: TObject);
    procedure aSayExecute(Sender: TObject);
    procedure aToggleExecute(Sender: TObject);
    procedure aEngRusExecute(Sender: TObject);
    procedure aRusEngExecute(Sender: TObject);
    procedure aClearHistoryExecute(Sender: TObject);
    procedure aClearLineExecute(Sender: TObject);
    procedure aClearChatExecute(Sender: TObject);
    procedure aCopyAllExecute(Sender: TObject);
    procedure aShowTopicExecute(Sender: TObject);
    procedure aShowNickExecute(Sender: TObject);
    procedure aShowBoardExecute(Sender: TObject);
    procedure enblNoShowExecute(Sender: TObject);
    procedure aAutoScrollTxtExecute(Sender: TObject);
    procedure aScrBarEditorExecute(Sender: TObject);
    procedure aFlatBtnExecute(Sender: TObject);
    procedure aHHMMSSExecute(Sender: TObject);
    procedure aDrawSmilesExecute(Sender: TObject);
    procedure aLeftExecute(Sender: TObject);
    procedure aMaxLinesExecute(Sender: TObject);
    procedure aAllOptionsExecute(Sender: TObject);
    procedure aContentsExecute(Sender: TObject);
    procedure aMailDevExecute(Sender: TObject);
    procedure aVisitSiteExecute(Sender: TObject);
    procedure aRegisterExecute(Sender: TObject);
    procedure aAboutExecute(Sender: TObject);
    procedure aDummy(Sender: TObject);
    procedure NTimerTimer(Sender: TObject);
    procedure HKDisableSLHotKey(Sender: TObject);
    procedure TimerAntiScrTimer(Sender: TObject);
    procedure TimerAFTimer(Sender: TObject);
    procedure GHkeyHotKey(Sender: TObject);
    procedure pmREPopup(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure ct1DblClick(Sender: TObject);
    procedure cbNickChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tRfshTimer(Sender: TObject);
    procedure apeActivate(Sender: TObject);
    procedure apeDeactivate(Sender: TObject);
    procedure edTextKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure mainSmileClick(Sender: TObject);
    procedure edTopicKeyPress(Sender: TObject; var Key: Char);
    procedure sbpMainPanels4Click(Sender: TObject);
    procedure sbpMainPanels0Click(Sender: TObject);
    procedure sbpMainPanels1Click(Sender: TObject);
    procedure lvUserKeyPress(Sender: TObject; var Key: Char);
    procedure TimerFlashTimer(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure ct1Startup(Sender: TObject; var ShowMainForm: Boolean);
    procedure edTextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbChangeInterface;
    procedure TimerFlashScrTimer(Sender: TObject);
    procedure pmTrayPopup(Sender: TObject);
    procedure miRestoreClick(Sender: TObject);

    procedure TopMainExit(Sender: TObject);
    procedure createTab(TabName: string; IconIndex: integer);
    procedure miMessageClick(Sender: TObject);
    procedure lvUserDblClick(Sender: TObject);
    procedure pg1Change(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure miMassMsgClick(Sender: TObject);
    procedure pmUserPopup(Sender: TObject);
    procedure miTXTClick(Sender: TObject);
    procedure miSendMessage(const toUser, UserID: string);
    procedure msgHandler(Sender: TObject);
    procedure sbpMainPanels2Click(Sender: TObject);
    procedure miChangeCommentClick(Sender: TObject);
    procedure TimerBaloonTimer(Sender: TObject);
    procedure TimerFloodTimer(Sender: TObject);
    procedure N381Click(Sender: TObject);
    procedure rvMainJump(Sender: TObject; id: Integer);
    procedure URLScanEvent(OldStyleNo: Integer; var NewStyleNo: Integer;
      ToHypertext: Boolean);
    procedure rvMainRVMouseUp(Sender: TCustomRichView;
      Button: TMouseButton; Shift: TShiftState; ItemNo, X, Y: Integer);
    procedure RTF1Click(Sender: TObject);
    procedure lvUserInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure meIgnoreMainClick(Sender: TObject);
    procedure miIngnorePrivClick(Sender: TObject);
    procedure miIngnorMsgClick(Sender: TObject);
    procedure N92Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure N97Click(Sender: TObject);
    procedure N100Click(Sender: TObject);
    procedure N99Click(Sender: TObject);
    procedure miBoardDelSelfClick(Sender: TObject);
    procedure miBoardCopyAllClick(Sender: TObject);
    procedure miBoardCopySelfClick(Sender: TObject);
    procedure miRefreshClick(Sender: TObject);

    procedure rvMainRVDblClick(Sender: TCustomRichView;
      ClickedWord: string; Style: Integer);
    procedure ClientConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure TimerRecoonectTimer(Sender: TObject);
    procedure apeException(Sender: TObject; E: Exception);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TopicTimerTimer(Sender: TObject);
    procedure edTopicChange(Sender: TObject);
    procedure pmTopicPopup(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure miByTimeClick(Sender: TObject);
    procedure TimerRepeatTimer(Sender: TObject);
    procedure TimerSpeedTimer(Sender: TObject);
    procedure TimerModeTimer(Sender: TObject);
    procedure TimerRenameTimer(Sender: TObject);
    procedure BoardTimerTimer(Sender: TObject);
    procedure miAutoScrollClick(Sender: TObject);
    procedure OnClickInputPlugin(Sender: TObject);
    procedure OnClickOutputPlugin(Sender: TObject);
    procedure miDisableSmilesClick(Sender: TObject);
    procedure mmMainTalkClick(Sender: TObject);
    procedure TimerUserActivityTimer(Sender: TObject);
    procedure bat1DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure bat1MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
    procedure TimerAntiSoundTimer(Sender: TObject);
    procedure sbpMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edTextChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvUserMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TimerAntiMeTimer(Sender: TObject);
    procedure TimerWriteOutTimer(Sender: TObject);
    procedure AntiFastRefreshTimerTimer(Sender: TObject);
    procedure miKickClick(Sender: TObject);
    procedure miBanClick(Sender: TObject);
    procedure miUnbanClick(Sender: TObject);
    procedure miKillMsgClick(Sender: TObject);
    procedure miForceSignalClick(Sender: TObject);
    procedure Massadminmessage1Click(Sender: TObject);
    procedure spltrMoved(Sender: TObject);

  private
{$IFDEF ACTIONEMU}
    FNewMenuActions: TList;
{$ENDIF}
    procedure WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING); message
      WM_WINDOWPOSCHANGING;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message
      WM_QUERYENDSESSION;
    procedure WMPOWERBROADCAST(var Msg: TWMPower); message WM_POWERBROADCAST;
    procedure WMSOCKET(var Msg: tagMSG); message WM_SOCKET;
    { Private declarations }
  public
{$IFDEF ACTIONEMU}
    procedure LoadMenu(ActionList: TCustomActionList;
      Clients: TActionClients; AMenu: TMenuItem; SetActionList: Boolean = True);
    procedure UpdateActionMainMenuBar(Menu: TMenu);
{$ENDIF}
    { Public declarations }
  end;

{$IFDEF PROTECTANTIFLOOD}
const
  GlobalCRC: longword = 131463341;
  GlobalCRC1: longword = 2534653530;
  GlobalCRC2: longword = 2950934058;
{$ENDIF}

var
  fmMain: TfmMain;
  Cipher: TDCP_RC6;

procedure ReadNicks;
procedure WriteNicks;
procedure PlayWave(signal: TSounds; force: boolean = False);
procedure SendData(Adata: string; const toUser: string);
procedure SendKey(H: Hwnd; Key: char);
function TransCodeEng2Rus(text: string): string;
function TransCodeRus2Eng(text: string): string;
function TransCodeToggle(text: string): string;
function GetFileVersion(const sFileName: string): string;
procedure WriteCache(filename, data: string);
procedure AddTextToMain(Data: string; StyleNo: integer);
procedure AddTextToRV(RV: TRichView; Data: string; StyleNo: integer);
procedure ReadRooms;
procedure WriteRooms;
function IsPagePresent(pagename: string): integer;
function IsUserIgnoredInMsg(const UserName, UserIP: string): boolean;
function IsUserIgnoredInPrivate(const UserName, UserIP: string): boolean;
function IsUserIgnoredInRooms(const UserName, UserIP: string): boolean;
procedure WriteMsgLog(From, toUser, Body: string; msgt: byte; isOut: boolean);
procedure ReadMsgLog;
procedure WriteSettings;

implementation

{$R *.DFM}
uses fmSettings, sendform, Registry, chatutils, Types, infoform, mmsystem,
  about, recForm, SendMassForm, StrUtils, commentform, crc32, ListActns,
  UrlScan,
  RoomsForm, DIUCL, udpsock, logform, regForm, topicform, regInfoForm;

{$IFDEF ACTIONEMU}
type


  TABMenuAction = class(TCustomAction)
  private
    FMenuItem: TMenuItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

destructor TABMenuAction.Destroy;
begin
  if Assigned(FMenuItem) then
    FMenuItem.RemoveFreeNotification(Self);
  inherited;
end;

procedure TABMenuAction.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  if (Operation = opRemove) and (AComponent = FMenuItem) then
    FMenuItem := nil;
end;

procedure TABMenuAction.ExecuteTarget(Target: TObject);
begin
  if Assigned(FMenuItem) then
    FMenuItem.Click;
end;

function TABMenuAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TFmMain.UpdateActionMainMenuBar(Menu: TMenu);

  function RefreshItems: Boolean;
  var
    I: Integer;
  begin
    Result := mmMain.Items.Count <> ActionManager1.ActionBars[0].Items.Count;
    if not Result then
      for I := 0 to mmMain.Items.Count - 1 do
        if AnsiCompareText(mmMain.Items[I].Caption,
          ActionManager1.ActionBars[0].Items[I].Caption) <> 0 then
        begin
          Result := True;
          break;
        end;
  end;

begin
  if not (csLoading in ActionManager1.ComponentState) and RefreshItems then
  begin

    ActionManager1.ActionBars[0].Items.Clear;
    ActionManager1.ActionBars[0].ActionBar := nil;
    LoadMenu(ActionManager1, ActionManager1.ActionBars[0].Items, mmMain.Items);
    ActionManager1.ActionBars[0].ActionBar := ActionMainMenuBar1;

    with ActionMainMenuBar1 do
      SetBounds(0, 0, Controls[ControlCount - 1].BoundsRect.Right + 2 +
        ActionMainMenuBar1.HorzMargin, Height);
  end;
end;


procedure TFmMain.LoadMenu(ActionList: TCustomActionList;
  Clients: TActionClients; AMenu: TMenuItem; SetActionList: Boolean = True);
var
  I: Integer;
  AC: TActionClientItem;
begin
  AMenu.RethinkHotkeys;
  AMenu.RethinkLines;

  Clients.AutoHotKeys := False;
  for I := 0 to AMenu.Count - 1 do
  begin
    AC := Clients.Add;
    AC.Caption := AMenu.Items[I].Caption;

    AC.Tag := Integer(AMenu.Items[I]);
    AC.Action := TContainedAction(AMenu.Items[I].Action);
    AC.Visible := AMenu.Items[I].Visible;

    if AMenu.Items[I].Count > 0 then
      AC.Items.Add

    else if ((AMenu.Items[I].Caption <> '') and (AMenu.Items[I].Action = nil)
      and
      (AMenu.Items[I].Caption <> '-')) then
    begin

      AC.Action := TABMenuAction.Create(Application.MainForm);
      AMenu.Items[I].FreeNotification(AC.Action);
      TABMenuAction(AC.Action).FMenuItem := AMenu.Items[I];
      FNewMenuActions.Add(AC.Action);
      AC.Action.ActionList := ActionManager1;
      AC.Action.Tag := AMenu.Items[I].Tag;
      TCustomAction(AC.Action).ImageIndex := AMenu.Items[I].ImageIndex;
      TCustomAction(AC.Action).HelpContext := AMenu.Items[I].HelpContext;
      TCustomAction(AC.Action).Visible := AMenu.Items[I].Visible;
      TCustomAction(AC.Action).Checked := AMenu.Items[I].Checked;
      TCustomAction(AC.Action).Caption := AMenu.Items[I].Caption;
      TCustomAction(AC.Action).ShortCut := AMenu.Items[I].ShortCut;
      TCustomAction(AC.Action).Enabled := AMenu.Items[I].Enabled;
      TCustomAction(AC.Action).AutoCheck := AMenu.Items[I].AutoCheck;
      TCustomAction(AC.Action).Checked := AMenu.Items[I].Checked;
      TCustomAction(AC.Action).GroupIndex := AMenu.Items[I].GroupIndex;
      AC.ImageIndex := AMenu.Items[I].ImageIndex;
      AC.ShortCut := AMenu.Items[I].ShortCut;
    end;
    AC.Caption := AMenu.Items[I].Caption;
    AC.ImageIndex := AMenu.Items[I].ImageIndex;
    AC.HelpContext := AMenu.Items[I].HelpContext;
    AC.ShortCut := AMenu.Items[I].ShortCut;
    AC.Visible := AMenu.Items[I].Visible;
  end;
end;

{$ENDIF}

procedure RestoreTimers;
begin
  with fmMain do
  begin
    TimerMode.Interval := 20000;
    TimerRename.Interval := 20000;
    BoardTimer.Interval := 20000;
    TimerSpeed.Interval := 5000;
    TopicTimer.Interval := 60000;
    TimerRepeat.Interval := 5000;
    TimerAntiSound.Interval := 10000;
    TimerAntiMe.Interval := 5000;
  end;
end;

procedure ReadMsgLog;
//const
//errCRC = '<Message damaged: CRC32 failed>  ';
var
  fMsg: TUniChatMsg;
  f: file;
  from, toUser, Body: string;
  buf: array[0..2] of byte;
  RC6: TDCP_rc6;
  bytesread: integer;
  fname: string;
begin

  RC6 := TDCP_rc6.Create(fmMain);
  fname := IncludeTrailingBackslash(logdir) + 'messages.clf';
  FileMode := 0;

  assignfile(f, fname);
  if fileexists(fname) then
  begin
{$I-}
    Reset(f, 1);
{$I+}
    if IOResult = 0 then
    begin

      BlockRead(f, buf, 3, bytesread);
      if (buf[0] = $FF) and (buf[1] = $E0) and (buf[2] = $0C) then
      begin
        if not assigned(fmMsgLog) then
        begin
          fmMsgLog := TfmMsgLog.Create(nil);

          while bytesread <> 0 do
          begin

            BlockRead(f, fmsg, sizeof(fmsg), bytesread);

            if bytesread > 0 then
            begin

              fname := DynaKey(#$01#$02#$03#$AD#$8E#$0B#$2D#$59#$17#$DD#$C8#$00,
                fMsg.DHashValue);
              RC6.Init(fname[1], 96, nil);
              SetLength(from, fMsg.FromLen);
              BlockRead(f, from[1], fmsg.FromLen, bytesread);
              SetLength(toUser, fMsg.toLen);
              BlockRead(f, toUser[1], fmsg.toLen, bytesread);
              SetLength(Body, fMsg.len);
              BlockRead(f, Body[1], fmsg.Len, bytesread);
              from := RC6.DecryptString(from);
              toUser := RC6.DecryptString(toUser);
              Body := RC6.DecryptString(Body);
              with fmMsgLog.lvAll.Items.Insert(0) do
              begin
                ImageIndex := fMsg.isOut;
                SubItems.Add('[' + DateToStr(fMsg.DateTime) + ' - ' +
                  TimeToStr(fMsg.DateTime) + ']');
                SubItems.Add(from);
                SubItems.Add(toUser);
                SubItems.Add(Trim(Body));
              end;
              if Boolean(fMsg.isOut) then
              begin
                with fmMsgLog.lvOutComing.Items.Insert(0) do
                begin
                  ImageIndex := fMsg.isOut;
                  SubItems.Add('[' + DateToStr(fMsg.DateTime) + ' - ' +
                    TimeToStr(fMsg.DateTime) + ']');
                  SubItems.Add(from);
                  SubItems.Add(toUser);
                  SubItems.Add(Trim(Body));
                end;
              end
              else
              begin
                with fmMsgLog.lvInComing.Items.Insert(0) do
                begin
                  ImageIndex := fMsg.isOut;
                  SubItems.Add('[' + DateToStr(fMsg.DateTime) + ' - ' +
                    TimeToStr(fMsg.DateTime) + ']');
                  SubItems.Add(from);
                  SubItems.Add(toUser);
                  SubItems.Add(Trim(Body));
                end;
              end;

            end;

          end;
          //          fmMsgLog.lvAll.Update;
          closefile(f);
          fmMsgLog.Show;
        end;
      end
      else
        showmessage('База сообщений поверждена');
    end
    else
      showmessage('Ошибка чтения базы сообщений');
  end
  else
    showmessage('База сообщений не найдена');
end;

procedure WriteMsgLog(From, toUser, Body: string; msgt: byte; isOut: boolean);
var
  fMsg: TUniChatMsg;
  fname: string;
  f: file;
  RC6: TDCP_rc6;
  buf: array[0..2] of byte;

begin

  RC6 := TDCP_rc6.Create(fmMain);

  fname := IncludeTrailingBackslash(logdir) + 'messages.clf';
  FileMode := 1;

  with fMsg do
  begin
    DateTime := Now;
    CRC32 := CalcStrCRC32(Body);
    MsgType := msgt;
    len := length(body);
    FromLen := length(From);
    ToLen := length(toUser);
    DHashValue := Random(MaxInt);
  end;

  fMsg.isOut := Byte(isOut);

  assignfile(f, fname);

  if fileexists(fname) then
  begin
{$I-}
    reset(f, 1);
{$I+}
    if IOREsult = 0 then
      seek(f, filesize(f));

  end
  else
  begin
{$I-}
    rewrite(f, 1);
{$I+}

    buf[0] := $FF;
    buf[1] := $E0;
    buf[2] := $0C;
    if IOResult = 0 then
      BlockWrite(f, buf, 3);
  end;

  if IOResult = 0 then
  begin
    BlockWrite(f, fmsg, sizeof(fmsg));

    fname := DynaKey(#$01#$02#$03#$AD#$8E#$0B#$2D#$59#$17#$DD#$C8#$00, fMsg.DHashValue);
    RC6.Init(fname[1], 96, nil);

    BlockWrite(f, RC6.EncryptString(From)[1], fmsg.fromlen);
    BlockWrite(f, RC6.EncryptString(toUser)[1], fmsg.toLen);
    BlockWrite(f, RC6.EncryptString(Body)[1], fmsg.len);
  end;

  closefile(f);

  RC6.Free;

end;

procedure WriteCache(filename, data: string);
var
  f: textfile;
  cl: integer;
begin

  for cl := 1 to length(filename) do
    if filename[cl] in ['\', '?', '"', '*', '/', ':', '|'] then
      filename[cl] := '_';

  assignfile(f, IncludeTrailingBackslash(logdir) + filename);
  if fileexists(IncludeTrailingBackslash(logdir) + filename) then
{$I-}
    append(f)
{$I+}
  else
{$I-}
    rewrite(f);
{$I+}
  if IOResult = 0 then
  begin
    writeln(f, '[' + DateToStr(Date) + ' - ' + TimeToStr(time) + '] ' + data);
    closefile(f);
  end;
end;

{procedure SimulateKeystroke(Key: byte; extra: DWORD);
begin
  keybd_event(Key, extra, 0, 0);
  keybd_event(Key, extra, KEYEVENTF_KEYUP, 1);
end;}

procedure ShowBalloon(balloon: TBalloons; textshow: string; const force: boolean
  = False);
begin
  with fmMain do
  begin
    if (fmMain.Visible) and (BOnlyInactive) and (balloon <> bsMessage) and
      (balloon <> bsInfo) and (balloon <> bsSignal) and (not force) or
      (CurMode = '4') then
      exit;
    begin
      TimerBaloon.Enabled := True;
      case balloon of
        bsEnterExitMain:
          if BEnterExitMain then
            ct1.ShowBalloonHint('UniChat - разговор', textshow, bitInfo, 10);
        bsEnterExitChannel:
          if BEnterExitChannel then
            ct1.ShowBalloonHint('UniChat - канал', textshow, bitInfo, 10);
        bsEnterExitMainPrivate:
          if BEnterExitPrivate then
            ct1.ShowBalloonHint('UniChat - личный разговор', textshow, bitWarning,
              10);
        bsNickChange:
          if BNickChange then
            ct1.ShowBalloonHint('UniChat - изменение имени', textshow, bitInfo,
              10);
        bsBoardChange:
          if BBoardChange then
            ct1.ShowBalloonHint('UniChat - изменение доски', textshow, bitInfo,
              10);
        bsModeChange:
          if BModeChange then
            ct1.ShowBalloonHint('UniChat - изменение режима', textshow, bitInfo,
              10);
        bsMessage:
          if BMessage then
            ct1.ShowBalloonHint('UniChat - сообщение доставлено', textshow,
              bitInfo, 10);
        bsSignal:
          if BSignal then
            ct1.ShowBalloonHint('UniChat - сигнал', textshow, bitInfo, 10);
        bsInfo:
          if BInfo then
            ct1.ShowBalloonHint('UniChat - запрос информации', textshow,
              bitWarning, 10);
        bsPacketFiltered:
          if BInfo then
            ct1.ShowBalloonHint('UniChat - обнаружена атака', textshow,
              bitError, 10);
        bsMessageReceived:
          if BMessageReceived then
            ct1.ShowBalloonHint('UniChat - входящее сообщение', textshow,
              bitWarning, 10);
        bsTreatment:
          if BTalkTreating then
            ct1.ShowBalloonHint('UniChat - обращение в разговоре', textshow,
              bitWarning, 10);
      end;
    end;
  end;
end;

procedure PlayWave(signal: TSounds; force: boolean = False);
var
  path: string;
begin

  {     '0': fmComment.cbData.Text:=mdActive;
       '1': fmComment.cbData.Text:=mdDND;
       '2': fmComment.cbData.Text:=mdAway;
       '3': fmComment.cbData.Text:=mdOffline;
       '4': fmComment.cbData.Text:=mdGaming;}
  path := ExtractFilePath(application.ExeName) + 'sounds\';

  if (SndEnabled and (CurMode in ['0', '2'])) or force then
    case signal of
      tsEnter: if SndEnter then
          if fileexists(path + 'log_on.wav') then
            PlaySound(PChar(path + 'log_on.wav'), 0, SND_FILENAME or SND_ASYNC);
      tsLeave: if SndLeave then
          if fileexists(path + 'log_off.wav') then
            PlaySound(PChar(path + 'log_off.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsLine: if SndLine then
          if fileexists(path + 'line.wav') then
            PlaySound(PChar(path + 'line.wav'), 0, SND_FILENAME or SND_ASYNC);
      tsNick: if SndNickChange then
          if fileexists(path + 'name.wav') then
            PlaySound(PChar(path + 'name.wav'), 0, SND_FILENAME or SND_ASYNC);
      tsSignal: if SndSignal then
          if fileexists(path + 'beep.wav') then
            PlaySound(PChar(path + 'beep.wav'), 0, SND_FILENAME or SND_ASYNC);
      tsTopic: if SndTopic then
          if fileexists(path + 'topic.wav') then
            PlaySound(PChar(path + 'topic.wav'), 0, SND_FILENAME or SND_ASYNC);
      tsMessage: if SndMessage then
          if fileexists(path + 'message.wav') then
            PlaySound(PChar(path + 'message.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsPrivateEnter: if SndEnterPrivate then
          if fileexists(path + 'private_start.wav') then
            PlaySound(PChar(path + 'private_start.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsPrivateLeave: if SndLeavePrivate then
          if fileexists(path + 'private_finish.wav') then
            PlaySound(PChar(path + 'private_finish.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsChannelEnter: if SndEnterChannel then
          if fileexists(path + 'channel_join.wav') then
            PlaySound(PChar(path + 'channel_join.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsChannelLeave: if SndLeavePrivate then
          if fileexists(path + 'channel_leave.wav') then
            PlaySound(PChar(path + 'channel_leave.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsMassMessage: if SndMultiMsg then
          if fileexists(path + 'mass_message.wav') then
            PlaySound(PChar(path + 'mass_message.wav'), 0, SND_FILENAME or
              SND_ASYNC);
      tsMeLine: if SndMeLine then
          if fileexists(path + 'me_line.wav') then
            PlaySound(PChar(path + 'me_line.wav'), 0, SND_FILENAME or
              SND_ASYNC);
    end;
  //    if fileexists(signal) then
  //    PlaySound(PChar(signal), 0, SND_FILENAME or SND_ASYNC);
end;

{procedure PlaySpecSound(Holyshit: boolean);
var
  hResource: THandle;
  pData: Pointer;
  rname: string;
begin
if holyshit then
rname:='HOLYSHIT' else rname:='HAHAHA';
  hResource:=LoadResource( hInstance, FindResource(hInstance, Pchar(rname), RT_RCDATA));
  try
    pData := LockResource(hResource);

    if pData = nil then
      raise Exception.Create('spec sound not found!');

    // Здесь pData указывает на MyWave
    // Теперь можно, например, проиграть его (Win32):
    PlaySound(pData, 0, SND_MEMORY or SND_ASYNC);
  finally
    FreeResource(hResource);
  end;
end;  }

procedure TfmMain.WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING);
var
  rWorkArea: TRect;
  StickAt: Word;
begin
  StickAt := 20;
  SystemParametersInfo(SPI_GETWORKAREA, 0, @rWorkArea, 0);
  with msg.WindowPos^ do
  begin

    if (x <= rWorkArea.Left + StickAt) and (x > (-Stickat)) then
      x := rWorkArea.Left;

    if (x + cx >= rWorkArea.Right - StickAt) and (x + cx < rWorkArea.Right +
      stickat) then
      x := rWorkArea.Right - cx;

    if (y <= rWorkArea.Top + StickAt) and (y > -5) then
      y := rWorkArea.Top;

    if (y + cy >= rWorkArea.Bottom - StickAt) and (y + cy < rWorkArea.Bottom +
      stickat) then
      y := rWorkArea.Bottom - cy;
  end;

  inherited;
end;

{--- code of owned functions and procedures ---}

{--- Save/Load Settings ---}

procedure SetMode(CurMode: char);
begin


  with fmMain do
  begin
    case CurMode of
      '0':
        begin
          aActive.Checked := True;
//          aActive.ImageIndex := ord(CurSex)  * 10;
//          aTbMode.Caption := aActive.Caption;
//          aTbMode.ImageIndex := aActive.ImageIndex;
   //       miActive1.Checked := True;

        end;
      '1':
        begin
          aDND.Checked := True;
     //     miDND1.Checked := True;
//          aTbMode.Caption := aDND.Caption;
//          aTbMode.ImageIndex := aDND.ImageIndex;
        end;
      '2':
        begin
          aAway.Checked := True;
//          aTbMode.Caption := aAway.Caption;
//          aTbMode.ImageIndex := aAway.ImageIndex;

       //   miAway1.Checked := True;
        end;
      '3':
        begin
          aDisabled.Checked := True;
  //        aTbMode.Caption := aDisabled.Caption;
//          aTbMode.ImageIndex := aDisabled.ImageIndex;

         // miOffline1.Checked := True;
        end;
      '4':
        begin
          aGaming.Checked := True;
  //        aTbMode.Caption := aGaming.Caption;
//          aTbMode.ImageIndex := aGaming.ImageIndex;

//          miGaming1.Checked := True;
        end;
    end;
    ct1.IconIndex := ord(curmode) - 48;
  end;
end;

procedure ReadSettings;
var
  sIniFile: TRegIniFile;
  sPath: string;

begin


  SPath := 'Software\UniChat145'; ;
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);

  if sIniFile.KeyExists('FontsAndColors') then
  begin

    fmMain.RVStyle.LoadReg(sPath + '\FontsAndColors');

  end else
  begin

    fmMain.RVStyle.AddTextStyle;
    fmMain.RVStyle.TextStyles[20].FontName := 'Tahoma';
    fmMain.RVStyle.TextStyles[20].Size := 8;
    fmMain.RVStyle.TextStyles[20].Color := ClWhite;
    fmMain.RVStyle.TextStyles[20].BackColor := ClRed;
  end;


  fmMain.lvUser.Color := fmMain.RVStyle.TextStyles[0].BackColor;
  fmMain.lvUser.Font.Color := fmMain.RVStyle.TextStyles[0].Color;
  fmMain.lvUser.Font.Size := fmMain.RVStyle.TextStyles[0].Size;
  fmMain.lvUser.Font.Style := fmMain.RVStyle.TextStyles[0].Style;
  fmMain.lvUser.Font.Name := fmMain.RVStyle.TextStyles[0].FontName;

  fmMain.edText.Color := fmMain.RVStyle.TextStyles[0].BackColor;
  fmMain.edText.Font.Color := fmMain.RVStyle.TextStyles[0].Color;
  fmMain.edText.Font.Size := fmMain.RVStyle.TextStyles[0].Size;
  fmMain.edText.Font.Style := fmMain.RVStyle.TextStyles[0].Style;
  fmMain.edText.Font.Name := fmMain.RVStyle.TextStyles[0].FontName;

  fmMain.edTopic.Color := fmMain.RVStyle.TextStyles[0].BackColor;
  fmMain.edTopic.Font.Color := fmMain.RVStyle.TextStyles[0].Color;
  fmMain.edTopic.Font.Size := fmMain.RVStyle.TextStyles[0].Size;
  fmMain.edTopic.Font.Style := fmMain.RVStyle.TextStyles[0].Style;
  fmMain.edTopic.Font.Name := fmMain.RVStyle.TextStyles[0].FontName;

  fmMain.cbNick.Color := fmMain.RVStyle.TextStyles[0].BackColor;
  fmMain.cbNick.Font.Color := fmMain.RVStyle.TextStyles[0].Color;
  fmMain.cbNick.Font.Size := fmMain.RVStyle.TextStyles[0].Size;
  fmMain.cbNick.Font.Style := fmMain.RVStyle.TextStyles[0].Style;
  fmMain.cbNick.Font.Name := fmMain.RVStyle.TextStyles[0].FontName;

  fmMain.pg1.Font.Name := fmMain.RVStyle.TextStyles[0].FontName;
  fmMain.pg1.Font.Size := fmMain.RVStyle.TextStyles[0].Size;
  fmMain.pg1.Font.Style := fmMain.RVStyle.TextStyles[0].Style;

  fmMain.rvMain.Color := fmMain.RVStyle.TextStyles[0].BackColor;
  fmMain.rvBoard.Color := fmMain.RVStyle.TextStyles[0].BackColor;

  CurNick := sIniFile.ReadString('LastUser', 'LastNick',
    CleanIncorrectSymbols(uGetUserName));
  CurSex := Chr(sIniFile.ReadInteger('LastUser', 'LastNickSex', 1));
  CurMode := sIniFile.ReadString('LastUser', 'LastNickMode', '0')[1];
  SetMode(CurMode);
  cbItem := sIniFile.ReadInteger('LastUser', 'LastComboBox', 0);

  fmMain.aLogMain.Checked := sIniFile.ReadBool('Protocols', 'Main', False);
  fmMain.aLogRoom.Checked := sIniFile.ReadBool('Protocols', 'Channels',
    False);
  fmMain.aLogMsg.Checked := sIniFile.ReadBool('Protocols', 'Messages',
    True);
  fmMain.aLogPrivate.Checked := sIniFile.ReadBool('Protocols', 'Private', False);
  logdir := sIniFile.ReadString('Protocols', 'LogDir', '');
  if (logdir = '') or not (DirectoryExists(logdir)) then
  begin
    ForceDirectories(ExtractFilePath(application.ExeName) + 'Logs');
    logDir := ExtractFilePath(application.ExeName) + 'Logs';
  end;

  SndEnabled := sIniFile.ReadBool('Sounds', 'SndEnabled', True);
  SndEnter := sIniFile.ReadBool('Sounds', 'SndEnter', True);
  SndLeave := sIniFile.ReadBool('Sounds', 'SndLeave', True);
  SndEnterChannel := sIniFile.ReadBool('Sounds', 'SndEnterChannel', True);
  SndLeaveChannel := sIniFile.ReadBool('Sounds', 'SndLeaveChannel', True);
  SndEnterPrivate := sIniFile.ReadBool('Sounds', 'SndEnterPrivate', True);
  SndLeavePrivate := sIniFile.ReadBool('Sounds', 'SndLeavePrivate', True);
  SndLine := sIniFile.ReadBool('Sounds', 'SndLine', True);
  SndMeLine := sIniFile.ReadBool('Sounds', 'SndMeLine', True);
  SndMessage := sIniFile.ReadBool('Sounds', 'SndMessage', True);
  SndMultiMsg := sIniFile.ReadBool('Sounds', 'SndMultiMsg', True);
  SndTopic := sIniFile.ReadBool('Sounds', 'SndBoardChange', True);
  SndNickChange := sIniFile.ReadBool('Sounds', 'SndNickChange', True);
  SndSignal := sIniFile.ReadBool('Sounds', 'SndSignal', True);

  SysEnterExitMain := sIniFile.ReadBool('SystemMsg', 'EnterExitMain', True);
  SysEnterExitChannel := sIniFile.ReadBool('SystemMsg', 'EnterExitChannel',
    True);
  SYsEnterExitPrivate := sIniFile.ReadBool('SystemMsg', 'EnterExitPrivate',
    True);
  SysNickChange := sIniFile.ReadBool('SystemMsg', 'NickChange', True);
  SysBoardChange := sIniFile.ReadBool('SystemMsg', 'BoardChange', True);
  SysTopicChange := sIniFile.ReadBool('SystemMsg', 'TopicChange', True);
  SysModeChange := sIniFile.ReadBool('SystemMsg', 'ModeChange', True);
  SysMessage := sIniFile.ReadBool('SystemMsg', 'Message', False);
  SysSignal := sIniFile.ReadBool('SystemMsg', 'Signal', True);
  fmMain.pnedit.Height := sIniFile.ReadInteger('Interface', 'pnEdit', 40);

  BOnlyInactive := sIniFile.ReadBool('Baloons', 'Active', True);
  BEnterExitMain := sIniFile.ReadBool('Baloons', 'EnterExitMain', False);
  BEnterExitChannel := sIniFile.ReadBool('Baloons', 'EnterExitChannel', False);
  BEnterExitPrivate := sIniFile.ReadBool('Baloons', 'EnterExitPrivate', True);
  BNickChange := sIniFile.ReadBool('Baloons', 'NickChange', False);
  BBoardChange := sIniFile.ReadBool('Baloons', 'BoardChange', True);
  BModeChange := sIniFile.ReadBool('Baloons', 'ModeChange', True);
  BMessage := sIniFile.ReadBool('Baloons', 'Message', True);
  BSignal := sIniFile.ReadBool('Baloons', 'Signal', True);
  BInfo := sIniFile.ReadBool('Baloons', 'OnInfo', False);

  BMessageReceived := sIniFile.ReadBool('Baloons', 'OnMessageReceived', True);
  BTalkTreating := sIniFile.ReadBool('Baloons', 'OnTalkTreating', True);

  NotifyNewRoom := sIniFile.ReadBool('RoomsOptions', 'NotifyNewRoom', True);
  ShowMyRooms := sIniFile.ReadBool('RoomsOptions', 'ShowMyRooms', True);
  DefaultRoom := sIniFile.ReadString('RoomsOptions', 'DefaultRoom', 'Основной');

  CrbLogin := sIniFile.ReadBool('Main', 'CRBLogin', True);
  CrbLast := sIniFile.ReadBool('Main', 'CRBLast', False);
  CcbAutogender := sIniFile.ReadBool('Main', 'CCBAutogender', False);

  fmMain.aScrBarEditor.checked := sIniFile.ReadBool('Interface', 'ShowSBar', True);
  fmMain.aShowTopic.checked := sIniFile.ReadBool('Interface', 'ShowTopic',
    True);
  fmMain.aShowNick.checked := sIniFile.ReadBool('Interface', 'ShowNicks',
    True);



  fmMain.aShowNickExecute(fmMain);

  //   fmMain.pnNicks.Visible  := fmMain.miShowNicks.checked;

  if sIniFile.ReadBool('Interface', 'ColumnsInUserList', False) then
    fmMain.lvUser.ViewStyle := vsList
  else
    fmMain.lvUser.ViewStyle := vsReport;

  fmMain.aChangePageWheel.checked := sIniFile.ReadBool('Interface',
    'ChangeTabsByWheel', False);
  if fmMain.aShowTopic.checked then
    fmMain.pnTopic_noSmile.Visible := True
  else
    fmMain.pnTopic_noSmile.Visible := False;
  fmMain.bevBalance.Visible := fmMain.pnTopic_noSmile.Visible and
    fmMain.aShowNick.Checked;

  if not fmMain.aScrBarEditor.checked then
  begin
    fmMain.edText.ScrollBars := stdctrls.ssNone;
    fmMain.edText.WordWrap := False;
  end;

  //   fmMain.N37.checked := False;
  //   fmMain.N34.checked := False;
  isSeconds := sIniFile.ReadBool('Interface', 'TimeStamp', True);
  if isSeconds then
    fmMain.aHHMMSS.checked := true
  else
    fmMain.aHHMM.checked := true;

  fmMain.pg1.Style := TTabStyle(sIniFile.ReadInteger('Interface', 'TSSTyle',
    2));
  case fmMain.pg1.Style of
    tsTabs: fmMain.aTabs.Checked := True;
    tsButtons: fmMain.aBtn.Checked := True;
    tsFlatButtons: fmMain.aFlatBtn.Checked := True;
  end;
  fmMain.aShowTBIco.Checked := sIniFile.ReadBool('Interface', 'ShowTaskBarIcon',
    True);

  fmMain.aStartMinim.Checked := sIniFile.ReadBool('Interface', 'StartMinimized', True);
  fmMain.miAutoScroll.Checked := sIniFile.ReadBool('Interface',
    'AutoScrollText', True);
  fmMain.aAutoScrollTxt.checked := fmMain.miAutoScroll.Checked;

  if not fmMain.miAutoScroll.Checked then
    fmMain.rvMain.Options := fmMain.rvMain.Options - [rvoScrollToEnd];

  fmMain.miByNick.Checked := sIniFile.ReadBool('Interface', 'SortBoardByNick',
    True);

  fmMain.miByTime.Checked := not fmMain.miByNick.Checked;
  
  fmMain.aShowToolBar.checked := sIniFile.ReadBool('User Settings', 'ShowToolBar',
    False);

///    fmMain.aShowToolBar.Execute;

//  if not  fmMain.aShowToolBar.checked then ;

  fmMain.aShowActiveWnd.Checked := sIniFile.ReadBool('User Settings', 'ShowWindow',
    False);
  fmMain.aFlashTBIco.Checked := sIniFile.ReadBool('User Settings', 'TrayFlash',
    True);
  fmMain.aDrawSmiles.Checked := sIniFile.ReadBool('User Settings',
    'DrawSmiles', True);
  fmMain.aFlashSL.Checked := sIniFile.ReadBool('User Settings',
    'ScrollFlash', False);
  fmMain.aPopUpNew.Checked := sIniFile.ReadBool('User Settings', 'NewPopup',
    False);
  fmMain.aAskModeComnt.Checked := sIniFile.ReadBool('User Settings', 'QueryComment',
    True);
  fmMain.aMsgInMain.Checked := sIniFile.ReadBool('User Settings',
    'MsgInMainRoom', False);
  fmMain.aNoShowMsg.Checked := sIniFile.ReadBool('User Settings', 'NoMsgWindow',
    False);
  fmMain.aShowInfo.Checked := sIniFile.ReadBool('User Settings', 'ShowHint',
    False);
  fmMain.miNoResponse.Checked := sIniFile.ReadBool('User Settings',
    'NoResponse', True);

  NotifyUserTyping := sIniFile.ReadBool('User Settings', 'NotifyUserTyping',
    True);

  noAskClose := sIniFile.ReadBool('User Settings', 'NoAskClose', False);
  myBoard := Trim(sIniFile.ReadString('Board', 'MyBoardData', ''));
  if length(MyBoard) > 1024 then
    myBoard := copy(MyBoard, 1, 1024);

  // ShowNickLength := sIniFile.ReadInteger('User Settings', 'ShowNickLength', 32);

  massMsg := sIniFile.ReadBool('User Settings', 'MassMsg', False);
  fmMain.aShowBoard.Checked := sIniFile.ReadBool('User Settings', 'ShowBoard',
    True);
  fmMain.aDisableSmilesGaming.Checked := sIniFile.ReadBool('User Settings',
    'DisableSmilesInGaming', False);
  chat_maxlines := sIniFile.ReadInteger('User Settings', 'MaxLines', 0);

  fmMain.ct1.IconVisible := sIniFile.ReadBool('User Settings', 'ShowTaskBarIcon', True);

  if not fmMain.aShowBoard.Checked then
    fmMain.ttboard.PageControl := nil;

  //      sIniFile.WriteBool('User Settings','NoMsgWindow',fmMain.miDOpMsg.Checked);
  //   sIniFile.WriteBool('User Settings','MsgInMainRoom',fmMain.miMsgInMain.Checked);
  with fmMain do
  begin

    aMacPaste1.Caption := sIniFile.ReadString('Macros', 'mac1', '');
    aMacPaste2.Caption := sIniFile.ReadString('Macros', 'mac2', '');
    aMacPaste3.Caption := sIniFile.ReadString('Macros', 'mac3', '');
    aMacPaste4.Caption := sIniFile.ReadString('Macros', 'mac4', '');
    aMacPaste5.Caption := sIniFile.ReadString('Macros', 'mac5', '');
    aMacPaste6.Caption := sIniFile.ReadString('Macros', 'mac6', '');
    aMacPaste7.Caption := sIniFile.ReadString('Macros', 'mac7', '');
    aMacPaste8.Caption := sIniFile.ReadString('Macros', 'mac8', '');
    aMacPaste9.Caption := sIniFile.ReadString('Macros', 'mac9', '');
    aMacPaste10.Caption := sIniFile.ReadString('Macros', 'mac10', '');
    aMacPaste11.Caption := sIniFile.ReadString('Macros', 'mac11', '');
    aMacPaste12.Caption := sIniFile.ReadString('Macros', 'mac12', '');

  end;

  mdActive := sIniFile.ReadString('Mode defaults', 'Active', '');
  mdDND := sIniFile.ReadString('Mode defaults', 'DND', '');
  mdOffline := sIniFile.ReadString('Mode defaults', 'Offline', '');
  mdGaming := sIniFile.ReadString('Mode defaults', 'Gaming', '');
  mdAway := sIniFile.ReadString('Mode defaults', 'Away', '');

  fmMain.tRfsh.Interval := sIniFile.ReadInteger('User Settings', 'RefreshTime',
    300000);

  fmMain.TimerUserActivity.Tag := sIniFile.ReadInteger('User Settings',
    'AutoAwayTime', 10);

  AutoAway := sIniFile.ReadBool('User Settings', 'AutoAwayEnabled', True);

  fmMain.TimerBaloon.Interval := sIniFile.ReadInteger('User Settings',
    'BalloonTime', 2000);

  if fmMain.tRfsh.Interval > 0 then
    fmMain.tRfsh.Enabled := True;

  if fmMain.TimerUserActivity.Tag > 59999 then
    fmMain.TimerUserActivity.Enabled := True;

  DontNotifyTab := sIniFile.ReadBool('User Settings', 'DontNotifyTab', False);
  DontNotifyTray := sIniFile.ReadBool('User Settings', 'DontNotifyTrayFlash',
    False);
  DontShowTalk := sIniFile.ReadBool('User Settings', 'DontShowTalkInMain',
    False);

  ForceMsgInOffline := sIniFile.ReadBool('User Settings',
    'ForceMsgInMainInOffline', False);
  NotifyInOffline := sIniFile.ReadBool('User Settings', 'NotifyOfflineMsg',
    False);

  fmMain.GHkey.Key := sIniFile.ReadInteger('User Settings', 'HotKey', 0);
  fmMain.HKDisableSL.key := sIniFile.ReadInteger('User Settings', 'HotKey_DisableSL', 0);

  BroadcastIP := sIniFile.ReadString('Network', 'BroadcastIP',
    '255.255.255.255');
  Auto2Broad := sIniFile.ReadBool('Network', 'Auto2Broadcast', False);
  DedicatedIP := sIniFile.ReadString('Network', 'DedicatedIP', 'localhost');
  IsServer := sIniFile.ReadBool('Network', 'IsServer', False);
  IsServer_ := IsServer;
  portDedic := sIniFile.ReadInteger('Network', 'DedicatedPort', 6666);

  GroupKey := sIniFile.ReadString('Security', 'GroupKey', '=DefaultKey=');

  isProtectEnabled := sIniFile.ReadBool('Security', 'EnablePacketFilter',
    False);
  NotifyBaloon := sIniFile.ReadBool('Security', 'NotifyPacketFilter', True);
  MaxPackets := sIniFile.ReadInteger('Security', 'PacketBuffer', 3);
  //

  if isProtectEnabled then
  begin
    AntiFloodPacket := TStackProtect.Create;
    if maxPackets < 3 then
      maxpackets := 3;
    AntiFloodPacket.SetStackSize(MaxPackets);
  end;

  Port := sIniFile.ReadString('Network', 'Port', '17889');
  UserNfo := sIniFile.ReadString('User Settings', 'UserInfo', '');
  priv_prefix := sIniFile.ReadString('User Settings', 'UserPrivelege', '');

  AutoPrivate := sIniFile.ReadString('User Settings', 'AutoPrivate', '');
  AutoMessage := sIniFile.ReadString('User Settings', 'AutoMessage', '');
  FlashTasbarOnText := sIniFile.ReadBool('User Settings', 'FlashTaskbar',
    False);

  {$IFNDEF UNICODERSNET}
  if (sIniFile.ReadInteger('', 'Register', 0) < 1) or
  (sIniFile.ReadString('','RegKey','') <> UserKey(GetHDDSerial)) then
  begin
  addTextToMain('Незарегистрированная версия. Пожалуйста, зарегистрируйтесь. '+
   'Подробности в окне "Помощь - Регистрация"',20);
   fmMain.NTimer.Interval := GetNAGTimeOut;
   fmMain.NTimer.ENabled:=True;
   end else fmMain.aRegister.Visible := False;
  {$ENDIF}


  //  end;

    { fmMain.Left := sIniFile.ReadInteger('ChatForm','PosX', 0);
     fmMain.Top := sIniFile.ReadInteger('ChatForm','PosY', 0);
     fmMain.Width := sIniFile.ReadInteger('ChatForm','Width', 460);
     fmMain.Height := sIniFile.ReadInteger('ChatForm','Height', 325);   }

  fmMain.pnUser.width := sIniFile.ReadInteger('ChatForm', 'pnUserWidth', 90);
  if sIniFile.ReadBool('ChatForm', 'ListStateLeft', False) then
  begin
    //fmMain.bv4.Align:=alRight;
    fmMain.pnUser.Align := alRight;
    fmMain.spltr.Align := alRight;
    fmMain.aRight.Checked := True;
  end
  else
  begin
    //fmMain.bv4.Align:=alLeft;
    fmMain.pnUser.Align := alLeft;
    fmMain.spltr.Align := alLeft;
    fmMain.aLeft.Checked := True;
  end;
  //  fmMain.spltr.Left := sIniFile.ReadInteger('ChatForm', 'Splitter', 334);
  sIniFile.Free;


end;

procedure ReadNicks;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
  tCaption: string;
  tImage: integer;
//  z: cardinal;
begin
  //  z:=GetTickCount;
   // z:=GetTickCOunt - z;
  //  showmessage(inttostr(z));


  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);

  for i := 0 to sIniFile.ReadInteger('UsersLogged', 'NicksCount', 0) - 1 do
  begin

    tCaption := Trim(CleanIncorrectSymbols(sIniFile.ReadString('UsersLogged',
      'Nick' + inttostr(i),
      'NewUser' + inttostr(i))));
    if (tcaption = '') then
      tCAption := CleanIncorrectSymbols(uGetUserName);
    tImage := sIniFile.ReadInteger('UsersLogged', 'NickImage' +
      inttostr(i), 0);
    if not (tImage in [0, 10]) then
      tImage := 0;
    with fmSetup.lvUserList.Items.Add do
    begin
      caption := tCaption;
      Checked := sIniFile.ReadBool('UsersLogged', 'NickChecked' + inttostr(i),
        True);
      imageindex := tImage;
    end;
  end;

  sIniFile.Free;
end;


procedure TfmMain.OnClickInputPlugin(Sender: TObject);
begin
  if (sender as TCustomAction).Checked then
    UCPlugins.EnableByInput(StringReplace((sender as TCustomAction).Caption, '&',
      '',
      [rfReplaceAll]))
  else
    UCPlugins.DisableByInput(StringReplace((sender as TCustomAction).Caption, '&',
      '', [rfReplaceAll]));
end;

procedure TfmMain.OnClickOutputPlugin(Sender: TObject);
begin
  if (sender as TCustomAction).Checked then
    UCPlugins.EnableByOutput(StringReplace((sender as TCustomAction).Caption, '&',
      '', [rfReplaceAll]))
  else
    UCPlugins.DisableByOutput(StringReplace((sender as TCustomAction).Caption, '&',
      '', [rfReplaceAll]));
end;

procedure AddMenuItem(const FName: string; const FChkIn, FChkOut: Boolean);
var
Item: TActionClientItem;
aAction : TCustomAction;
begin

aAction := TCustomAction.Create(fmMain.amMain);
aAction.Caption := FName;
aAction.AutoCheck := True;
aAction.Checked := FChkIn;
aAction.OnExecute := fmMain.OnClickInputPlugin;

Item := fmMain.amMain.ActionBars[0].Items[0].Items[9].Items.Add;
Item.Action := Aaction;

fmMain.aInPluginExec.Visible := False;

aAction := TCustomAction.Create(fmMain.amMain);
aAction.Caption := FName;
aAction.AutoCheck := True;
aAction.Checked := FChkOut;
aAction.OnExecute := fmMain.OnClickOutputPlugin;

Item := fmMain.amMain.ActionBars[0].Items[0].Items[8].Items.Add;
Item.Action := Aaction;

fmMain.aOutPluginExec.Visible := False;
end;

procedure SubDir(Dir: string);
var
  SearchRec: TSearchRec;
  Separator: string;
  tmp: TUniChatPlugin;
begin
  if Copy(Dir, Length(Dir), 1) = '\' then
    Separator := ''
  else
    Separator := '\';
  if FindFirst(Dir + Separator + '*.*', faAnyFile, SearchRec) = 0 then
  begin
    if FileExists(Dir + Separator + SearchRec.Name) then
    begin
      if ExtractFileExt(Dir + Separator + SearchRec.Name) = '.ucp' then
      begin


          tmp := UCPlugins.LoadPlugin(Dir + Separator + SearchRec.Name);
          if tmp.name <> '' then
          begin

          AddMenuItem(tmp.name,tmp.useAsInput, tmp.useAsOutput);
          end;

        end;
    end
    else if DirectoryExists(Dir + Separator + SearchRec.Name) then
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        SubDir(Dir + Separator + SearchRec.Name);
      end;
    end;
    while FindNext(SearchRec) = 0 do
    begin
      if FileExists(Dir + Separator + SearchRec.Name) then
      begin
        if AnsiLowerCase(ExtractFileExt(Dir + Separator + SearchRec.Name)) =
          '.ucp' then
        begin


            tmp := UCPlugins.LoadPlugin(Dir + Separator + SearchRec.Name);

            if length(tmp.name) <> 0 then
            begin

            AddMenuItem(tmp.name,tmp.useAsInput, tmp.useAsOutput);
            end;

        end;
      end
      else if DirectoryExists(Dir + Separator + SearchRec.Name) then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          SubDir(Dir + Separator + SearchRec.Name);
        end;
      end;
    end;
  end;
  FindClose(SearchRec);
end;

procedure LoadPlugins;
begin
  SubDir(ExtractFilePath(application.ExeName) + 'Plugins\');
  with fmMain do
  begin
{    if miInputPlugin.Count > 1 then
    begin
      miInputPlugin.Delete(0);
      miOutputPlugin.Delete(0);
    end;}
  end;
  UCPlugins.LoadComplete;
end;

procedure ReadModes(aSection: string; data: Tstrings);
var
  sIniFile: TRegIniFile;
  i, z: integer;
  s: string;
begin
  sIniFile := TRegIniFile.Create(sRegPath, KEY_READ);
  sIniFile.ReadSection(aSection, data);
  z := data.Count - 1;
  data.Clear;
  for i := 0 to z do
  begin
    s := sIniFile.ReadString(aSection, 'item' + inttostr(i), '');
    if s <> '' then Data.Add(s);
  end;

  sIniFile.Free;
end;

procedure WriteModes(aSection: string; AData: TStrings);
var
  sIniFile: TRegIniFile;
  i: integer;
begin
  sIniFile := TRegIniFile.Create(sRegPath, KEY_WRITE);

  sIniFile.EraseSection(aSection);

  sIniFile.Create(aSection);


  for  i := 0 to AData.Count - 1 do
    if AData.strings[i] <> '' then
      sIniFile.WriteString('', 'item' + inttostr(i), AData.strings[i]);

  //   showmessage(data[i]);
  sIniFile.Free;
end;



function GetNickGender(nick: string): integer;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
begin
  Result := 0;

  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);

  for i := 0 to sIniFile.ReadInteger('UsersLogged', 'NicksCount', 0) - 1 do
  begin
    if nick = sIniFile.ReadString('UsersLogged', 'Nick' + inttostr(i), 'NewUser'
      + inttostr(i)) then
    begin
      result := sIniFile.ReadINteger('UsersLogged', 'NickImage' + inttostr(i),
        0);
      exit;
    end;
    {     with fmSetup.lvUserList.Items.Add do
         begin
          Caption:=sIniFile.ReadString('UsersLogged','Nick'+inttostr(i),'NewUser'+inttostr(i));
          Checked:=sIniFile.ReadBool('UsersLogged','NickChecked'+inttostr(i),True);
          ImageIndex:=
         end;}
  end;

  sIniFile.Free;

end;

procedure ReadNicksCombo;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
begin

  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);

  for i := 0 to sIniFile.ReadInteger('UsersLogged', 'NicksCount', 0) - 1 do
  begin

    if sIniFile.ReadBool('UsersLogged', 'NickChecked' + inttostr(i), True) then
    begin
      with fmMain.cbNick.Items.Add do
      begin
        text := Trim(CleanIncorrectSymbols(sIniFile.ReadString('UsersLogged',
          'Nick' + inttostr(i),
          'NewUser' + inttostr(i))));
        if text = '' then
          Text := CleanIncorrectSymbols(uGetUserName);
        ImageIndex := sIniFile.ReadInteger('UsersLogged', 'NickImage' +
          inttostr(i), 0);
        if not (ImageIndex in [0, 10]) then
          ImageIndex := 0;
      end;
    end;
  end;

  sIniFile.Free;

end;

procedure WriteNicks;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
begin
  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_WRITE);
  sIniFile.LazyWrite := True;
  sIniFile.EraseSection('UsersLogged');
  sIniFile.WriteInteger('UsersLogged', 'NicksCount',
    fmSetup.lvUserList.Items.Count);
  for i := 0 to fmSetup.lvUserList.Items.Count - 1 do
  begin
    sIniFile.WriteString('UsersLogged', 'Nick' + inttostr(i),
      fmSetup.lvUserList.Items.Item[i].Caption);
    sIniFile.WriteBool('UsersLogged', 'NickChecked' + inttostr(i),
      fmSetup.lvUserList.Items.Item[i].Checked);
    sIniFile.WriteInteger('UsersLogged', 'NickImage' + inttostr(i),
      fmSetup.lvUserList.Items.Item[i].ImageIndex);
  end;

  sIniFile.Free;
end;
//procedure ReadRooms;

procedure WriteRooms;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
begin

  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_WRITE);

  sIniFile.EraseSection('UserRooms');
  sIniFile.WriteInteger('UserRooms', 'RoomsCount',
    fmRooms.lvUserRooms.Items.Count);
  for i := 0 to fmRooms.lvUserRooms.Items.Count - 1 do
  begin
    sIniFile.WriteString('UserRooms', 'Room' + inttostr(i),
      fmRooms.lvUserRooms.Items.Item[i].Caption);
    sIniFile.WriteBool('UserRooms', 'RoomChecked' + inttostr(i),
      fmRooms.lvUserRooms.Items.Item[i].Checked);
  end;
  sIniFile.Free;
end;


function addjail(const str: string): string;
begin
  Result := str;
  if str <> '' then
    if str[1] <> '#' then
    begin
      REsult := '#' + Str;
    end;

end;

procedure ReadRooms;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
begin
  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);
  fmRooms.cbActiveRoom.Items.Clear;
  fmRooms.cbActiveRoom.Items.Add('#Основной');
  for i := 0 to sIniFile.ReadInteger('UserRooms', 'RoomsCount', 0) - 1 do
  begin

    with fmRooms.lvUserRooms.Items.Add do
    begin
      Caption := AddJail(Trim(sIniFile.ReadString('UserRooms', 'Room' +
        inttostr(i), '#NewRoom' + inttostr(i))));

      Checked := sIniFile.ReadBool('UserRooms', 'RoomChecked' + inttostr(i),
        True);
      //      if checked then fmRooms.cbActiveRoom.Items.Add(caption);

      ImageIndex := 4;
    end;
  end;

  {   i:=fmRooms.cbActiveRoom.Items.IndexOf(DefaultRoom);
     if i=-1 then i:=0;
     fmRooms.cbActiveRoom.ItemIndex:=i;}
  sIniFile.Free;
end;

procedure ReadRoomsMainPage;
var
  sIniFile: TRegIniFile;
  sPath: string;
  i: integer;
  s: string;
begin
  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);
  for i := 0 to sIniFile.ReadInteger('UserRooms', 'RoomsCount', 0) - 1 do
  begin
    if sIniFile.ReadBool('UserRooms', 'RoomChecked' + inttostr(i), False) then
    begin
      s := AddJail(Trim(sIniFile.ReadString('UserRooms', 'Room' + inttostr(i),
        '#NewRoom' + inttostr(i))));
      fmMain.createTab(s, 4);
      SendData('K' + CurNick + #0 + s + #0 + CurSex, '*');
            //      sleep(1000);
      SendData('!' + CurNick + #0 + s, '*');
    end;

  end;
  sIniFile.Free;
end;

procedure WriteSettings;
var
  sIniFile: TRegIniFile;
  sPath: string;
begin

  WriteModes('FilterNameRoom', Name_Room);
  WriteModes('FilterIPRoom', IP_Room);
  WriteModes('FilterNamePrivate', Name_Private);
  WriteModes('FilterIPPrivate', IP_Private);
  WriteModes('FilterNameMsg', Name_Msg);
  WriteModes('FilterIPMsg', IP_Msg);

  SPath := 'Software\UniChat145';

  fmMain.RVStyle.SaveReg(sPath + '\FontsAndColors');

  sIniFile := TRegIniFile.Create(sPath, KEY_WRITE);
  sIniFile.LazyWrite := True;
  sIniFile.WriteString('LastUser', 'LastNick', CurNick);
  sIniFile.WriteInteger('LastUser', 'LastNickSex', Ord(CurSex) - 48);
  sIniFile.WriteInteger('LastUser', 'LastNickMode', Ord(CurMode) - 48);
  sIniFile.WriteInteger('LastUser', 'LastComboBox', fmMain.cbNick.ItemIndex);

  sIniFile.WriteBool('RoomsOptions', 'NotifyNewRoom', NotifyNewRoom);
  sIniFile.WriteBool('RoomsOptions', 'ShowMyRooms', ShowMyRooms);
  sIniFile.WriteString('RoomsOptions', 'DefaultRoom', DefaultRoom);

  sIniFile.WriteString('Security', 'GroupKey', GroupKey);
  sIniFile.WriteBool('Security', 'EnablePacketFilter', isProtectEnabled);
  sIniFile.WriteBool('Security', 'NotifyPacketFilter', NotifyBaloon);
  sIniFile.WriteInteger('Security', 'PacketBuffer', MaxPackets);

  sIniFile.WriteString('Board', 'MyBoardData', MyBoard);


  sIniFile.WriteBool('Sounds', 'SndEnabled', SndEnabled);
  sIniFile.WriteBool('Sounds', 'SndEnter', SndEnter);
  sIniFile.WriteBool('Sounds', 'SndLeave', SndLeave);
  sIniFile.WriteBool('Sounds', 'SndEnterChannel', SndEnterChannel);
  sIniFile.WriteBool('Sounds', 'SndLeaveChannel', SndLeaveChannel);
  sIniFile.WriteBool('Sounds', 'SndEnterPrivate', SndEnterPrivate);
  sIniFile.WriteBool('Sounds', 'SndLeavePrivate', SndLeavePrivate);
  sIniFile.WriteBool('Sounds', 'SndLine', SndLine);
  sIniFile.WriteBool('Sounds', 'SndMeLine', SndMeLine);
  sIniFile.WriteBool('Sounds', 'SndMessage', SndMessage);
  sIniFile.WriteBool('Sounds', 'SndMultiMsg', SndMultiMsg);
  sIniFile.WriteBool('Sounds', 'SndBoardChange', SndTopic);
  sIniFile.WriteBool('Sounds', 'SndNickChange', SndNickChange);
  sIniFile.WriteBool('Sounds', 'SndSignal', SndSignal);

  sIniFile.WriteBool('SystemMsg', 'EnterExitMain', SysEnterExitMain);
  sIniFile.WriteBool('SystemMsg', 'EnterExitChannel', SysEnterExitChannel);
  sIniFile.WriteBool('SystemMsg', 'EnterExitPrivate', SysEnterExitPrivate);
  sIniFile.WriteBool('SystemMsg', 'NickChange', SysNickChange);
  sIniFile.WriteBool('SystemMsg', 'BoardChange', SysBoardChange);
  sIniFile.WriteBool('SystemMsg', 'TopicChange', SysTopicChange);
  sIniFile.WriteBool('SystemMsg', 'ModeChange', SysModeChange);
  sIniFile.WriteBool('SystemMsg', 'Message', SysMessage);
  sIniFile.WriteBool('SystemMsg', 'Signal', SysSignal);

  sIniFile.WriteBool('Baloons', 'Active', BOnlyInactive);
  sIniFile.WriteBool('Baloons', 'EnterExitMain', BEnterExitMain);
  sIniFile.WriteBool('Baloons', 'EnterExitChannel', BEnterExitChannel);
  sIniFile.WriteBool('Baloons', 'EnterExitPrivate', BEnterExitPrivate);
  sIniFile.WriteBool('Baloons', 'NickChange', BNickChange);
  sIniFile.WriteBool('Baloons', 'BoardChange', BBoardChange);
  sIniFile.WriteBool('Baloons', 'ModeChange', BModeChange);
  sIniFile.WriteBool('Baloons', 'Message', BMessage);
  sIniFile.WriteBool('Baloons', 'Signal', BSignal);
  sIniFile.WriteBool('Baloons', 'OnInfo', BInfo);

  sIniFile.WriteBool('Baloons', 'OnMessageReceived', BMessageReceived);
  sIniFile.WriteBool('Baloons', 'OnTalkTreating', BTalkTreating);

  sIniFile.WriteInteger('User Settings', 'BalloonTime',
    fmMain.TimerBaloon.Interval);

  sIniFile.WriteBool('Protocols', 'Main', fmMain.aLogMain.Checked);
  sIniFile.WriteBool('Protocols', 'Channels', fmMain.aLogRoom.Checked);
  sIniFile.WriteBool('Protocols', 'Messages', fmMain.aLogMsg.Checked);
  sIniFile.WriteBool('Protocols', 'Private', fmMain.aLogPrivate.Checked);
  sIniFile.WriteString('Protocols', 'LogDir', LogDir);

  sIniFile.WriteString('Mode defaults', 'Active', mdActive);
  sIniFile.WriteString('Mode defaults', 'DND', mdDND);
  sIniFile.WriteString('Mode defaults', 'Offline', mdOffline);
  sIniFile.WriteString('Mode defaults', 'Gaming', mdGaming);
  sIniFile.WriteString('Mode defaults', 'Away', mdAway);

  sIniFile.WriteBool('Main', 'CRBLogin', CrbLogin);
  sIniFile.WriteBool('Main', 'CRBLast', CrbLast);
  sIniFile.WriteBool('Main', 'CCBAutogender', CcbAutogender);

  sIniFile.WriteString('Network', 'BroadcastIP', BroadcastIP);
  sIniFile.WriteString('Network', 'Port', port);
  sIniFile.WriteString('Network', 'DedicatedIP', DedicatedIP);
  sIniFile.WriteBool('Network', 'IsServer', isServer_);
  sIniFile.WriteBool('Network', 'Auto2Broadcast', Auto2Broad);
  sIniFile.WriteInteger('Network', 'DedicatedPort', portDedic);

  with fmMain do
  begin
    sIniFile.WriteString('Macros', 'mac1', aMacPaste1.Caption);
    sIniFile.WriteString('Macros', 'mac2', aMacPaste2.Caption);
    sIniFile.WriteString('Macros', 'mac3', aMacPaste3.Caption);
    sIniFile.WriteString('Macros', 'mac4', aMacPaste4.Caption);
    sIniFile.WriteString('Macros', 'mac5', aMacPaste5.Caption);
    sIniFile.WriteString('Macros', 'mac6', aMacPaste6.Caption);
    sIniFile.WriteString('Macros', 'mac7', aMacPaste7.Caption);
    sIniFile.WriteString('Macros', 'mac8', aMacPaste8.Caption);
    sIniFile.WriteString('Macros', 'mac9', aMacPaste9.Caption);
    sIniFile.WriteString('Macros', 'mac10', aMacPaste10.Caption);
    sIniFile.WriteString('Macros', 'mac11', aMacPaste11.Caption);
    sIniFile.WriteString('Macros', 'mac12', aMacPaste12.Caption);
  end;

  {  sIniFile.WriteInteger('ChatForm','PosX', fmMain.Left);
    sIniFile.WriteInteger('ChatForm','PosY', fmMain.Top);
    sIniFile.WriteInteger('ChatForm','Width', fmMain.Width);
    sIniFile.WriteInteger('ChatForm','Height', fmMain.Height); }

  sIniFile.WriteInteger('ChatForm', 'pnUserWidth', fmMain.pnUser.width);
  sIniFile.WriteInteger('Interface', 'pnEdit', fmMain.pnedit.height);
  sIniFile.WriteInteger('ChatForm', 'Splitter', fmMain.spltr.Left);

  sIniFile.WriteBool('Interface', 'ShowSBar', fmMain.aScrBarEditor.checked);

  sIniFile.WriteBool('Interface', 'TimeStamp', fmMain.aHHMMSS.checked);
  sIniFile.WriteBool('Interface', 'ChangeTabsByWheel',
    fmMain.aChangePageWheel.checked);

  sIniFile.WriteBool('Interface', 'StartMinimized', fmMain.aStartMinim.checked);
  sIniFile.WriteBool('Interface', 'ShowTopic', fmMain.aShowTopic.Checked);
  sIniFile.WriteBool('Interface', 'ShowNicks', fmMain.aShowNick.Checked);
  //    fmMain.miShowNicks.checked := sIniFile.ReadBool('Interface', 'ShowNicks',
  //    True);
  sIniFile.WriteBool('Interface', 'ShowTaskBarIcon', fmMain.aShowTBIco.Checked);
  sIniFile.WriteBool('Interface', 'AutoScrollText',
    fmMain.miAutoScroll.Checked);
  sIniFile.WriteBool('Interface', 'SortBoardByNick', fmMain.miByNick.Checked);
  sIniFile.WriteBool('Interface', 'ColumnsInUserList', (fmMain.lvUser.ViewStyle
    = vsList));
  //  sIniFile.WriteBool('Interface', 'FadeEffects', isFadeEnabled);

  sIniFile.WriteInteger('Interface', 'TSStyle', integer(fmMain.pg1.style));

  sIniFile.WriteBool('ChatForm', 'ListStateLeft', fmMain.aRight.Checked);
  sIniFile.WriteBool('User Settings', 'ShowWindow', fmMain.aShowActiveWnd.Checked);
  sIniFile.WriteBool('User Settings', 'TrayFlash', fmMain.aFlashTBIco.Checked);
  sIniFile.WriteBool('User Settings', 'DrawSmiles',
    smilestate);
  sIniFile.WriteBool('User Settings', 'NoAskClose', noAskCLose);
  sIniFile.WriteBool('User Settings', 'ScrollFlash',
    fmMain.aFlashSL.Checked);
  sIniFile.WriteBool('User Settings', 'NewPopup', fmMain.aPopUpNew.Checked);
  sIniFile.WriteBool('User Settings', 'QueryComment', fmMain.aAskModeComnt.Checked);
  sIniFile.WriteBool('User Settings', 'MsgInMainRoom',
    fmMain.aMsgInMain.Checked);
  sIniFile.WriteBool('User Settings', 'NoMsgWindow', fmMain.aNoShowMsg.Checked);
  sIniFile.WriteBool('User Settings', 'ShowHint', fmMain.aShowInfo.Checked);
  sIniFile.WriteBool('User Settings', 'MassMsg', MassMsg);
  sIniFile.WriteBool('User Settings', 'NoResponse',
    fmMain.miNoResponse.Checked);
  sIniFile.WriteBool('User Settings', 'ShowBoard', fmMain.aShowBoard.Checked);

  sIniFile.WriteBool('User Settings', 'ShowToolBar', fmMain.aShowToolBar.Checked);

  sIniFile.WriteBool('User Settings', 'DisableSmilesInGaming',
    fmMain.aDisableSmilesGaming.Checked);
  //   sIniFile.WriteBool('User Settings','ShowHidden',fmMain.miDOpMsg.Checked);
  sIniFile.WriteInteger('User Settings', 'HotKey', fmMain.GHkey.Key);
  sIniFile.WriteInteger('User Settings', 'HotKey_DisableSL', fmMain.HKDisableSL.Key);

  sIniFile.WriteInteger('User Settings', 'RefreshTime', fmMain.tRfsh.Interval);
  sIniFile.WriteInteger('User Settings', 'AutoAwayTime',
    fmMain.TimerUserActivity.Tag);
  {  sIniFile.WriteInteger('User Settings', 'ShowNickLength', ShowNickLength);}
  sIniFile.WriteInteger('User Settings', 'MaxLines', chat_maxlines);
  sIniFile.WriteString('User Settings', 'UserInfo', UserNfo);
  sIniFile.WriteString('User Settings', 'UserPrivelege', priv_prefix);

  sIniFile.WriteBool('User Settings', 'AutoAwayEnabled', AutoAway);

  sIniFile.WriteBool('User Settings', 'DontNotifyTab', DontNotifyTab);
  sIniFile.WriteBool('User Settings', 'DontNotifyTrayFlash', DontNotifyTray);
  sIniFile.WriteBool('User Settings', 'DontShowTalkInMain', DontShowTalk);

  sIniFile.WriteBool('User Settings', 'ForceMsgInMainInOffline',
    ForceMsgInOffline);
  sIniFile.WriteBool('User Settings', 'NotifyOfflineMsg', NotifyInOffline);
  sIniFile.WriteBool('User Settings', 'FlashTaskbar', FlashTasbarOnText);
  sIniFile.WriteInteger('', 'Release', 1);
  sIniFile.WriteString('User Settings', 'AutoPrivate', AutoPrivate);
  sIniFile.WriteString('User Settings', 'AutoMessage', AutoMessage);
  sIniFile.WriteBool('User Settings', 'NotifyUserTyping', NotifyUserTyping);

  // := sIniFile.ReadBool(, False);
  //  sIniFile.WriteBool('User Settings', 'AutoAwayEnabled', AutoAway);

  sIniFile.Free;
end;

function IsUserIgnoredInRooms(const UserName, UserIP: string): boolean;
var
  x, y: integer;
  s: string;
begin
  x := Name_Room.IndexOf(UserName);
  y := -1;

  for s in IP_Room do
    if MatchesMask(ExtractUserIP(UserIP), s) then
    begin
      y := 1;
      break;
    end;

  Result := ((x <> -1) or (y <> -1));
end;

function IsUserIgnoredInPrivate(const UserName, UserIP: string): boolean;
var
  x, y: integer;
  s: string;
begin
  x := Name_Private.IndexOf(UserName);
  y := -1;

  for s in IP_Private do
    if MatchesMask(ExtractUserIP(UserIP), s) then
    begin
      y := 1;
      break;
    end;

  Result := ((x <> -1) or (y <> -1));
end;

function IsUserIgnoredInMsg(const UserName, UserIP: string): boolean;
var
  x, y: integer;
  s: string;
begin
  x := Name_Msg.IndexOf(UserName);
  y := -1;

  for s in IP_Msg do
    if MatchesMask(ExtractUserIP(UserIP), s) then
    begin
      y := 1;
      break;
    end;

  Result := ((x <> -1) or (y <> -1));

end;


{procedure SaveSettings;
var
fset: file of TChatSettings;
begin
assignfile(fset,'unichat.ini');
rewrite(fset);
write(fset,ChatSet);
closefile(fset);
end;

procedure LoadSettings;
var
fset: file of TChatSettings;
begin
assignfile(fset,'unichat.ini');
reset(fset);
Read(fset,ChatSet);
closefile(fset);
end; }

{--- End Save/Load settings ---}

{procedure LoadDefaults;
begin

  SndEnabled := True;
  SndEnter := True;
  SndLeave := True;
  SndEnterChannel := True;
  SndLeaveChannel := True;
  SndEnterPrivate := True;
  SndLeavePrivate := True;
  SndLine := True;
  SndMessage := True;
  SndMultiMsg := True;
  SndTopic := True;
  SndNickChange := True;
  SndSignal := True;

  BOnlyInactive := True;
  BEnterExitMain := True;
  BEnterExitChannel := True;
  BEnterExitPrivate := True;
  BNickChange := True;
  BBoardChange := True;
  BModeChange := True;
  BMessage := False;
  BSignal := False;

  SysEnterExitMain := True;
  SysEnterExitChannel := True;
  SysEnterExitPrivate := True;
  SysNickChange := True;
  SysBoardChange := True;
  SysModeChange := True;
  SysMessage := True;
  SysSignal := True;
end;   }

procedure SendData(Adata: string; const toUser: string);
var
  s, prefix: string;
  tmp: array[1..5] of char;
  i: integer;
  str: string;
begin
  i := Random(MaxInt);
  //i:=$FFFFFFFF;
  move(i, tmp, 4);
  str := DynaKey(GroupKey, i);
  Cipher.Init(str[1], 96, nil);

  AData := ChatID + #0 + AData + #0 + CurID;

  if isServer then
  begin
    if length(Adata) < 100 then
    begin
      tmp[5] := '0';
      AData := tmp + Cipher.EncryptString(AData);

      i := length(AData);
      move(i, tmp, 4);

      tmp[5] := #0;
      prefix := #0 + CurID + #0'FORWARD'#0 + toUser + #0'UniChat'#0 + tmp;

      i := length(AData) + length(prefix);
      fmMain.Client.Socket.SendText(inttostr(length(AData) + length(prefix)) +
        prefix + #0 + AData);
    end
    else
    begin
      tmp[5] := '1';
      s := UclCompressStrA(AData, 10);

      AData := tmp + Cipher.EncryptString(s);
      i := length(AData);
      move(i, tmp, 4);

      i := length(AData);
      move(i, tmp, 4);
      tmp[5] := #0;
      prefix := #0 + CurID + #0'FORWARD'#0 + toUser + #0'UniChat'#0 + tmp;

      fmMain.Client.Socket.SendText(inttostr(length(AData) + length(prefix)) +
        prefix + #0 + AData);
    end;
  end
  else
  begin
    if length(Adata) < 100 then
    begin
      tmp[5] := '0';
      AData := tmp + Cipher.EncryptString(AData);
      udpSock.SendPeer2Peer(AData[1], length(Adata));
    end
    else
    begin
      tmp[5] := '1';
      s := UclCompressStrA(AData, 10);
      AData := tmp + Cipher.EncryptString(s);
      udpSock.SendPeer2Peer(AData[1], length(Adata));
    end;
  end;
end;

function GetTimeStamp: string;
begin
  if isSeconds then
    LongTimeFormat := 'HH:MM:SS'
  else
    LongTimeFormat := 'HH:MM';
  Result := '[' + TimeToStr(time) + ']';
end;

function binarylookup(const phrase: string; var smilename: string): integer;
var
  low, high, mid, cmp: integer;
  tmp: string;
begin
  result := -1;
  low := 0;
  high := 97; // Не забывайте корректировать эти значения

  if high > 0 then
  begin
    while low <= high do
    begin
      mid := (low + high) shr 1;
      tmp := copy(phrase, 1, length(Smileys[mid]));
      cmp := CompareStr(tmp, Smileys[mid]);
      tmp := Smileys[mid];
      if cmp < 0 then
        high := mid - 1
      else if cmp > 0 then
        low := mid + 1
      else
      begin
        result := COnvTable[mid];
        Smilename := Smileys[mid];
        break;
      end;
    end;
  end;
end;

function NoMinus(src: string; var addon: integer; var smilename: string):
  integer;
var
  i, z: integer;
  rezult: string;
begin
  addon := 0;
  rezult := '';
  src := parse(src, ' ');
  z := length(src);
  if z < 5 then
  begin
    z := 4;
    for i := 1 to z do
      if src[i] = '-' then
        inc(addon)
      else
        rezult := rezult + src[i];
  end
  else
    rezult := src;
  Result := BinaryLookUp(rezult, Smilename);
end;

procedure AddWithIcons(rv: TCustomRichView; s: string; StyleNo: Integer; var
  ParaNo: Integer);
var
  s2: string;
  p: Integer;
  i, addon, len: integer;
  nm: string;
  bmp: TBitmap;
begin


  s2 := '';
  i := 0;
  len := length(s);
  while i <= len do
  begin
    if (s[i] in [' ', #13, #10]) or (i = 0) then
    begin
      if s[i + 1] in [':', ';', '=', 'B', '(', '<', '>', '8', '%', '''', ')',
        'o', 'E', '|', '$', 'P'] then
      begin
        p := NoMinus(copy(s, i + 1, 11), addon, nm);
        if p >= 0 then
        begin
          if (s2 <> '') then
          begin
            rv.AddTEXTNL(s2, StyleNo, ParaNo, 0);

            s2 := '';
            ParaNo := -1;
          end;
          if p < 63 then
            rv.AddBulletEx(nm, p, fmMain.ilSmilesPack2, ParaNo)
          else
          begin
            bmp := TBitmap.Create;
            bmp.LoadFromResourceName(hInstance, 'Smile' + inttostr(p));
            rv.AddPictureEx(nm, bmp, ParaNo, rvvaBaseline);
            rv.SetItemExtraIntProperty(rv.ItemCount - 1, rvepTransparent,
              clWhite);
          end;
          rv.SetItemExtraIntProperty(rv.ItemCount - 1, rvepVShift, -20);
          s2 := '';
          inc(i, addon + length(nm));
        end;
      end;
    end;

    inc(i);


    if (i <= len) and (i <> 0) then
      s2 := s2 + s[i];
  end;
  if s2 <> '' then
  begin
    rv.AddTextNL(TrimRight(s2), StyleNo, ParaNo, 0);
  end;


end;

procedure AddTextToMain(Data: string; StyleNo: integer);
var
  i: integer;
  tmp: string;
begin
//if StyleNo=20 then StyleNo:=6;
  with fmMain do
  begin

    i := Lo(rvMain.Tag);
    if i = chat_maxlines - 5 then
      rvMain.Tag := (rvMain.ItemCount shl 16) xor i;

    if chat_maxlines > 5 then
      if (i = chat_maxlines) then
      begin

        rvMain.DeleteParas(0, (rvMain.Tag shr 16));
        rvMain.Tag := 4;
      end;

    rvMain.Tag := rvMain.Tag + 1;

    if aLogMain.Checked then
    begin
      tmp := data;
      for i := 1 to length(tmp) do
        if tmp[i] = #0 then
        begin
          tmp[i] := '>';
          break;
        end;
      WriteCache('main.txt', tmp);
    end;

    tmp := '';

    if Pos('-> ' + CurNick + ':', data) > 0 then
    begin
      rvMain.AddTEXTNL(GetTimeStamp, 5, 0, 0);
      ShowBalloon(bsTreatment, 'В "Основном" обращение');
    end
    else
      rvMain.AddTEXTNL(GetTimeStamp, StyleNo, 0, 0);

    for i := 1 to length(Data) do
      if data[i] = #0 then
      begin
        data[i] := '>';
        tmp := copy(data, 1, i);
        data := copy(data, i + 1, length(data));
        Data := UCPlugins.ProcessInput(data);
        break;
      end;

    rvMain.Add(' ' + tmp, StyleNo);
    I := -1;
    if aDrawSmiles.Checked then
      AddWithIcons(rvMain, Data, StyleNo, i)
    else
      rvMain.Add(Data, StyleNo);
    ClearHypertext(rvMain.RVData, URLScanEvent);
    ScanURLs(rvMain.RVData, URLScanEvent);

    rvMain.FormatTail;

  end;
end;

procedure AddTextToRV(RV: TRichView; Data: string; StyleNo: integer);
var
  i: integer;
  tmp: string;
begin
//if StyleNo=20 then StyleNo:=6;
  with fmMain do
  begin

    tmp := '';

    if Pos('-> ' + CurNick + ':', data) > 0 then
    begin
      rv.AddTEXTNL(GetTimeStamp, 5, 0, 0);
    end
    else
      rv.AddTEXTNL(GetTimeStamp, StyleNo, 0, 0);

    for i := 1 to length(Data) do
      if data[i] = #0 then
      begin
        data[i] := '>';
        tmp := copy(data, 1, i);
        data := copy(data, i + 1, length(data));
        Data := UCPlugins.ProcessInput(data);
        break;
      end;

    rv.Add(' ' + tmp, StyleNo);
    I := -1;
    if aDrawSmiles.Checked then
      AddWithIcons(rv, Data, StyleNo, i)
    else
      rv.Add(Data, StyleNo);
    ClearHypertext(rv.RVData, URLScanEvent);
    ScanURLs(rv.RVData, URLScanEvent);

    rv.FormatTail;

  end;
end;

function GetDate(str: string): string;
begin
  parse(str, #0);
  Result := Str;
end;

function GetNick(str: string): string;
begin
  Result := parse(str, #0);
end;

function IsItemPresent(const nick: string): integer;
var
  z: integer;
begin
  Result := -1;
  for z := 0 to boardNick.Count - 1 do
  begin
    if GetNick(boardNick.Strings[z]) = nick then
    begin
      Result := z;
      break;
    end;
  end;
end;

procedure AddTextToBoard(nick, msg: string; const Rfsh: Char);
var
  par: integer;
  i: integer;
  mustLight: boolean;
  data: string;
  tmp: string;

  procedure SelectionSort;
  var
    I, J: Integer;
    bl: boolean;
  begin
    bl := fmMain.miByNick.Checked;
    for I := 0 to BoardNick.Count - 2 do

      for J := BoardNick.Count - 1 downto I + 1 do
        if bl {here sorting by nick} then
        begin
          if AnsiCompareStr(BoardNick.Strings[i], BoardNick.Strings[j]) > 0 then
          begin
            BoardNick.Exchange(i, j);
            BoardData.Exchange(i, j);
          end;
        end
        else if AnsiCompareStr(GetDate(BoardNick.Strings[i]),
          GetDate(BoardNick.Strings[j])) < 0 then
        begin
          BoardNick.Exchange(i, j);
          BoardData.Exchange(i, j);
        end;
  end;

label
  link1;

begin
  with fmMain do
  begin
    MustLight := (Rfsh = '1') and (SysBoardChange);

    if nick = '' then
      goto link1;

    i := IsItemPresent(nick); //BoardNick.IndexOf(nick);
    Data := UCPlugins.ProcessInput(StringReplace(msg, '\n', #13#10,
      [rfReplaceAll]));

    nick := nick + #0 + GetTimeStamp;
    if i <> -1 then
    begin
      if Trim(Data) = '' then
      begin

        boardNick.Delete(i);
        BoardData.Delete(i);
        MustLight := False;
        //rvBoard.Clear;

      end
      else
      begin
        if BoardData.Strings[i] <> data then
        begin
          BoardData.Strings[i] := data;

          if mustLight then
            BoardNick.Strings[i] := nick;
          boardNick.Exchange(0, i);
          BoardData.Exchange(0, i);
        end;
      end;
    end
    else
    begin
      if Trim(Data) <> '' then
      begin

        i := boardData.IndexOf(data);
        if i = -1 then
        begin

          BoardNick.Insert(0, nick);
          BoardData.Insert(0, data);
        end;
      end
      else
        exit;
    end;

    link1: SelectionSort;

    rvBoard.Clear;

    if BoardNick.Count > 0 then
    begin

      rvBoard.AddBreakEx(2, rvbsLine, clBlack);

      for i := 0 to BoardNick.Count - 1 do
      begin
        tmp := boardnick.Strings[i];
        for par := 1 to length(tmp) do
          if tmp[par] = #0 then
          begin
            tmp[par] := ' ';
            break;
          end;

        rvBoard.AddTextNL(tmp, 18, 0, 0);
        rvBoard.AddBreak;
        par := 0;
        if aDrawSmiles.Checked then
          AddWithIcons(rvBoard, boarddata.Strings[i], 19, par)
        else
          rvBoard.AddTextNL(boarddata.Strings[i], 19, par, 0);
        rvBoard.AddBreakEx(2, rvbsLine, clBlack);
      end;
    end;
    ClearHypertext(rvBoard.RVData, URLScanEvent);
    ScanURLs(rvBoard.RVData, URLScanEvent);
    rvBoard.Format;
    if MustLight then
    begin

      if ttboard.TabIndex <> -1 then
        if pg1.ActivePage.Caption <> 'Объявления' then
          pg1.Pages[ttboard.TabIndex].ImageIndex := 7;

      AddTextToMain('Обновлена доска объявлений. ' + GetNick(Nick), 17);
      ShowBalloon(bsBoardChange, 'Обновлена доска объявлений. ' + GetNick(Nick));
    end;
  end;
end;

function IsPagePresent(pagename: string): integer;
var
  z: integer;
begin
  with fmMain do
  begin
    Result := -1;
    for z := 0 to pg1.PageCount - 1 do
      if pg1.Pages[z].Caption = PageName then
      begin
        Result := z;
        break;
      end;
  end;
end;

procedure AddTextToPage(const PageName: string; data: string; StyleNo: integer);
var
  z, i: integer;
  //pos: TPoint;
  tmp: string;
  CurRe: TRichView;
begin
// if StyleNo=20 then StyleNo:=6;
  with fmMain do

  begin
    for z := 0 to pg1.PageCount - 1 do
      if pg1.Pages[z].Caption = PageName then
      begin

        if z <> pg1.ActivePageIndex then
          if (pg1.Pages[z].ImageIndex in [0, 2, 4]) and (not (styleNo in [2, 12,
            10])) then
            pg1.Pages[z].ImageIndex := pg1.Pages[z].ImageIndex + 1;

        tmp := data;
        for i := 1 to length(tmp) do
          if tmp[i] = #0 then
          begin
            tmp[i] := '>';
            break;
          end;

        if (Pagename[1] <> '#') and (aLogPrivate.Checked) then
          WriteCache('talk_' + pagename + '.txt', tmp)
        else if (Pagename[1] = '#') and (aLogPrivate.Checked) then
          WriteCache(pagename + '.txt', tmp);
        tmp := '';

        CurRE := (pg1.Pages[z].FindComponent('memo' + pg1.Pages[z].name) as
          TRichView);

        i := Lo(CurRE.Tag);
        if i = chat_maxlines - 5 then
          CurRE.Tag := (CurRE.ItemCount shl 16) xor i;

        if chat_maxlines > 5 then
          if (i = chat_maxlines) then
          begin

            CurRE.DeleteParas(0, (CurRE.Tag shr 16));
            CurRE.Tag := 4;
          end;
        CurRE.Tag := CurRE.Tag + 1;
        if Pos('-> ' + CurNick + ':', data) > 0 then
        begin
          CurRE.AddTEXTNL(GetTimeStamp, 5, 0, 0);
          ShowBalloon(bsTreatment, 'В комнате ' + PageName + ' обращение');
        end
        else
          CurRE.AddTEXTNL(GetTimeStamp, StyleNo, 0, 0);

        for i := 1 to length(Data) do
          if data[i] = #0 then
          begin
            data[i] := '>';
            tmp := copy(data, 1, i);
            data := copy(data, i + 1, length(data));
            Data := UCPlugins.ProcessInput(data);
            break;
          end;

        CurRE.Add(' ' + tmp, StyleNo);

        I := -1;

        if aDrawSmiles.Checked then
          AddWithIcons(CurRE, Data, StyleNo, i)
        else
          CurRE.Add(Data, StyleNo);
        ClearHypertext(CurRE.RVData, URLScanEvent);
        ScanURLs(CurRE.RVData, URLScanEvent);
        CurRE.FormatTail;
        break;
      end;
  end;
end;

procedure AddNick(const nick: string; const ImgIndx: integer; const UserID:
  string);
var
  i, z: integer;
begin
  doublesnick := '';
  with fmMain do
  begin

    for i := 0 to lvUser.Items.Count - 1 do
    begin
      if lvUser.Items.Item[i].SubItems.Strings[0] = UserID then
      begin
        lvUser.Items.Item[i].ImageIndex := ImgIndx;
        lvUser.Items.Item[i].Caption := nick;
        sbTotal.Panels[0].Text := '  Всего: ' + inttostr(lvUser.Items.count);
        exit;
      end;
    end;

    z := lvUser.Items.IndexOf(lvUser.FindCaption(-1, nick, False, False,
      False));
    if z = -1 then
    begin
      with lvUser.Items.Add do
      begin
        Caption := nick;
        ImageIndex := ImgIndx;
        SubItems.Add(UserID);
      end;
    end
    else
    begin
      AddNick(nick + ' (' + ExtractUserIP(UserID) + ')', imgindx, UserID);
      DOublesNick := nick;
    end;

    sbTotal.Panels[0].Text := '  Всего: ' + inttostr(lvUser.Items.count);
    if lastuser <> '' then
    begin
      i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, lastuser, False, False,
        False));
      if i <> -1 then
        lvUser.Items.Item[i].Selected := True; // :=i;
    end;

  end;
end;

procedure DeleteNick(const UserID: string);
var
  i: integer;
begin
  with fmMain do
  begin
    for i := 0 to lvUser.Items.Count - 1 do
    begin
      if pos(UserID, lvUser.Items.Item[i].SubItems.Strings[0]) > 0 then
      begin
        lvUser.Items.Delete(i);
        sbTotal.Panels[0].Text := '  Всего: ' + inttostr(lvUser.Items.count);
        break;
      end;
    end;
  end;
end;

procedure ChangeNick(const newnick, UserID: string; const ImgIndx: integer);
var
  i: integer;
begin
  with fmMain do
  begin

    for i := 0 to lvUser.Items.Count - 1 do
    begin
      if lvUser.Items.Item[i].SubItems.Strings[0] = UserID then
      begin
        lvUser.Items.Item[i].ImageIndex := ImgIndx;
        lvUser.Items.Item[i].Caption := newnick;
        exit;
      end;
      AddNick(newnick, ImgIndx, UserID);
    end;
  end;
end;

function SetMaleFemale(Data: char; PrefixType: smallint): string;
begin
  if Data = '1' then
  begin
    case PrefixType of
      0: Result := 'а';
      1: Result := ' вошла ';
      2: Result := ' вышла ';
      3: Result := ' переименовалась ';
      4: Result := '"Активна"';
      5: Result := '"Ушла"';
    end;
  end
  else
  begin
    case PrefixType of
      0: Result := '';
      1: Result := ' вошел ';
      2: Result := ' вышел ';
      3: Result := ' переименовался ';
      4: Result := '"Активен"';
      5: Result := '"Ушел"';
    end;
  end;
end;

procedure SendExit;
var
  i: integer;
begin
  for i := 1 to fmMain.pg1.PageCount - 1 do
    if fmMain.pg1.Pages[i].Caption <> 'Объявления' then
      SendData('x' + fmMain.pg1.Pages[i].Caption + #0 + curnick + #0 + CurSex,
        '*');
end;

function GetFileVersion(const sFileName: string): string;
var
  n, Len: Cardinal;
  Value, Buf: PChar;
begin
  Result := '';
  n :=
    GetFileVersionInfoSize(PChar(application.ExeName), n);
  if (n > 0) then
  begin
    Buf := AllocMem(n);
    try
      Windows.GetFileVersionInfo(PChar(application.ExeName), 0, n, Buf);
      //if VerQueryValue(Buf, '\StringFileInfo\080904E4\FileVersion',
      if VerQueryValue(Buf, '\StringFileInfo\041904E3\FileVersion',
        Pointer(Value), Len) then
        Result := Value;
    finally
      FreeMem(Buf, n);
    end;
  end;
  Result := Result + SERVICE_PACK;

end;

procedure SendUserData(const toUser: string; const toID: string);
var
  MS: TMemoryStatus;
  VI: TOSVersionInfo;
  buffer: array[0..127] of char;
  i: integer;
  tmp, tmp1: string;
begin
  tmp := '';

  case CurMode of
    '0': tmp1 := mdActive;
    '1': tmp1 := mdDND;
    '2': if autoaway then
        tmp1 := Format(AwayMessage, [(fmMain.TimerUserActivity.tag) div 60000])
      else
        tmp1 := mdAway;
    '3': tmp1 := mdOffline;
    '4': tmp1 := mdGaming;
  end;
  tmp1 := UCPlugins.ProcessOutput(tmp1);

  if ShowMyRooms then
    for i := 1 to fmMain.pg1.PageCount - 1 do
      if fmMain.pg1.Pages[i].Caption[1] = '#' then
        tmp := tmp + fmMain.pg1.Pages[i].Caption + #13;
  GetWindowText(GetForegroundWindow, buffer, sizeof(buffer));
  MS.dwLength := sizeof(MS);
  GlobalMemoryStatus(MS);
  VI.dwOSVersionInfoSize := SizeOf(VI);
  GetVersionEx(VI);
  if not fmMain.aShowActiveWnd.Checked then
    move('*СКРЫТО ПОЛЬЗОВАТЕЛЕМ*'#0, buffer, 23);
  ShowBalloon(bsInfo, toUser + ' / ' + buffer);
{$IFNDEF ADMINCHAT}
  with MS, VI do
    //UDPClientSend('I'+ToUser+#0+Curnick+#0+uGetUsername+#0+AnsiUpperCase('\\'+uGetLoacalHostName)+#0+uHost2IP(uGetLoacalHostName)+#0+Format('%d.%d.%d', [dwMajorVersion, dwMinorVersion,LoWord(dwBuildNumber)])+#0+buffer+#0+Format('%d KB', [dwTotalPhys div 1024])+#0+Format('%d%%', [dwMemoryLoad])+#0'#Glumclub'#13#10'#AnyNew'#0'No comments'#0'AMD AthlonXP 1600+');
    SendData('I' + toID + #0 +
      CurNick + #0 +
      uGetUserName + #0 +
      AnsiUpperCase('\\' + uGetLocalHostName) + #0 +
      ExtractUserIP(CurID) + #0 +
      Format('%d.%d.%d', [dwMajorVersion, dwMinorVersion, LoWord(dwBuildNumber)])
      + #0 +
      buffer + #0 +
      GetFileVersion(IncludeTrailingBackslash(application.ExeName) +
      'unichat.exe') + #0 +
      Format('%d KB', [dwTotalPhys div 1024]) + #0 +
      Format('%d%%', [dwMemoryLoad]) + #0 +
      UserNfo + #0 +
      tmp + #0 + tmp1, toID);
{$ELSE}
  with MS, VI do
    //UDPClientSend('I'+ToUser+#0+Curnick+#0+uGetUsername+#0+AnsiUpperCase('\\'+uGetLoacalHostName)+#0+uHost2IP(uGetLoacalHostName)+#0+Format('%d.%d.%d', [dwMajorVersion, dwMinorVersion,LoWord(dwBuildNumber)])+#0+buffer+#0+Format('%d KB', [dwTotalPhys div 1024])+#0+Format('%d%%', [dwMemoryLoad])+#0'#Glumclub'#13#10'#AnyNew'#0'No comments'#0'AMD AthlonXP 1600+');
    SendData('I' + toID + #0 +
      CurNick + #0 +
      'Администратор' + #0 +
      AnsiUpperCase('*Недоступно*') + #0 +
      '*Недоступно*' + #0 +
      '*Недоступно*'
      + #0 +
      '*Недоступно*' + #0 +
      '*Недоступно*' + #0 +
      '*Недоступно*' + #0 +
      '*Недоступно*' + #0 +
      UserNfo + #0 +
      '' + #0 + tmp1, toID);
{$ENDIF}
  //showmessage(uGetComputerName);
end;

procedure ExecuteCommand(cmd: char);
var
  tmp: string;
  i, z: integer;
begin
  with fmMain do
    with MsgData do
    begin
      case cmd of
        'm':
          begin
            AddNick(strings[0], strtoint(strings[1]) + 5 * strtoint(strings[3])
              + 10 * strtoint(strings[2]), strings[4]);


            {        AddNick('Den1', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'1');
                    AddNick('Den2', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'2');
                    AddNick('Den3', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'3');
                    AddNick('Den4', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'4');
                    AddNick('Den5', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'5');
                    AddNick('Den6', strtoint(strings[1]) + 5 * strtoint(strings[3])
                        + 10 * strtoint(strings[2]), strings[4]+'6');}

          end;
        'M':
          begin
            if not DontShowTalk then
            begin
              if not IsUserIgnoredInRooms(strings[0], strings[2]) then
              begin

                if CurNick = strings[0] then
                begin
                  if DoublesNick = strings[0] then
                    AddTextToMain('<' + strings[0] + '(' + strings[2] + ')' + #0' ' + strings[1], 3)
                  else
                    AddTextToMain('<' + strings[0] + #0' ' + strings[1], 3);
                end
                else
                begin
                  //if (not DontNotifyTab) then
                  PlayWave(tsLine);

                  if (pg1.ActivePageIndex <> 0) and (not DontNotifyTab) then
                    pg1.Pages[0].ImageIndex := 1;

                  if DoublesNick = strings[0] then
                    AddTextToMain('<' + strings[0] + '(' + strings[2] + ')' + #0' ' + strings[1], 4)
                  else
                    AddTextToMain('<' + strings[0] + #0' ' + strings[1], 4);

                  if FlashTasbarOnText then
                    if CurActive = '1' then
                      if fmMain.Visible then
                        SetForegroundWindow(application.Handle);

                  if not fmMain.Visible then
                  begin
                    if not DontNotifyTray then
                    begin
                      if fmMain.aFlashTBIco.Checked then
                        fmMain.TimerFlash.enabled := True;

                      if (fmMain.aFlashSL.Checked) then
                        fmMain.TimerFlashScr.Enabled := True;

                      if (aPopUpNew.Checked) and (not fmMain.Visible) then
                        ct1DblClick(fmMain);
                    end;
                  end;

                end;
              end;
            end;

          end;
        '9': if NotifyUserTyping then
          begin
            if IsPagePresent(strings[3]) <> -1 then
            begin
              AddNick(strings[0], strtoint(strings[1]) +
                +5 * strtoint(strings[2]) + 20, strings[4]);
            end
            else if strings[3] = CurNick then
              if IsPagePresent(strings[0]) <> -1 then
              begin
                AddNick(strings[0], strtoint(strings[1]) +
                  +5 * strtoint(strings[2]) + 20, strings[4]);
              end;
          end;
        '8': if NotifyUserTyping then
          begin
            if strings[3] = CurID then
            begin
              AddNick(strings[0], strtoint(strings[1]) +
                +5 * strtoint(strings[2]) + 30, strings[4]);



            end;
          end;
        'p':
          begin
            if CurID = strings[0] then
            begin
              if priv_prefix <> '' then
              begin
                if priv_prefix = strings[2] then
                begin
                  tmp := strings[3];
                  add(parse(tmp, ' '));

                  if UCPlugins.ExecCommand(strings[5], tmp) = 1 then
                  begin

                    AddTextToMain(strings[1] +
                      ' выпоняет привилегированную команду: ' + strings[3], 5);
                    SendData('o' + strings[4] + #0 + CurNick + #0 + '0',
                      strings[4]);
                  end
                  else
                  begin
                    SendData('o' + strings[4] + #0 + CurNick + #0 + '1',
                      strings[4]);
                  end;
                end
                else
                begin
                  SendData('o' + strings[4] + #0 + CurNick + #0 + '2',
                    strings[4]);
                end;
              end
              else
                SendData('o' + strings[4] + #0 + CurNick + #0 + '3',
                  strings[4]);
            end;
          end;
        'o':
          if curID = strings[0] then
          begin
            case strings[2][1] of
              '0': AddTextToMain(strings[1] +
                  ': привилегированная команда успешно выполнена', 5);
              '1': AddTextToMain(strings[1] +
                  ': привилегированная команда не распознана', 5);
              '2': AddTextToMain(strings[1] + ': неверная привилегия', 5);
              '3': AddTextToMain(strings[1] +
                  ': нет доступа к привилегированным командам', 5);

            end;
          end;
        '+':
          begin
            SendData('*' + Strings[0] + #0 + CurNick + #0 + CurMode + #0 + CurSex
              + #0 + CurActive, '*');
          end;
        '*': if strings[0] = CurID then
            AddNick(strings[1], strtoint(strings[2]) + 5 * strtoint(strings[4])
              + 10 * strtoint(strings[3]), strings[5]);
        'e', '}':
          begin

            PlayWave(tsEnter);
            if SysEnterExitMain then
              AddTextToMain(Strings[0] + SetMaleFemale(strings[2][1], 1) +
                'в разговор', 2);
            AddNick(strings[0], strtoint(strings[1]) + 5 * strtoint(strings[3])
              + 10 * strtoint(strings[2]), strings[4]);
            ShowBalloon(bsEnterExitMain, Strings[0] +
              SetMaleFemale(strings[2][1], 1) + 'в разговор');
          end;
        'R':
          begin
            case strings[1][1] of
              '0': tmp := SetMaleFemale(strings[2][1], 4);
              '1': tmp := '"Не беспокоить"';
              '2': tmp := SetMaleFemale(strings[2][1], 5);
              '3': tmp := '"Отключен' + SetMaleFemale(strings[2][1], 0) + '"';
              '4': tmp := '"Играю"';
            end;
            if length(strings[4]) > 0 then
              tmp := tmp + ' [' + UCPlugins.ProcessInput(strings[4]) + ']';

            if SysModeChange then
              AddTextToMain(Strings[0] + SetMaleFemale(strings[2][1], 1) +
                'в режим ' + tmp, 11);

            if CurNick <> Strings[0] then
              ShowBalloon(bsModeChange, Strings[0] +
                SetMaleFemale(strings[2][1], 1) + 'в режим ' + tmp);

            AddNick(strings[0], strtoint(strings[1]) + 5 * strtoint(strings[3])
              + 10 * strtoint(strings[2]), strings[5]);
          end;
        'q':
          begin
            {            case strings[1][1] of
                          '0': tmp := SetMaleFemale(strings[2][1], 4);
                          '1': tmp := '"Не беспокоить"';
                          '2': tmp := SetMaleFemale(strings[2][1], 5);
                          '3': tmp := '"Отключен' + SetMaleFemale(strings[2][1], 0) + '"';
                          '4': tmp := '"Играю"';
                        end;
                        if length(strings[4]) > 0 then
                          tmp := tmp + ' [' + strings[4] + ']';

                        if SysModeChange then
                          AddTextToMain(Strings[0] + SetMaleFemale(strings[2][1], 1) +
                            'в режим ' + tmp, 11);

                        if CurNick <> Strings[0] then
                          ShowBalloon(bsModeChange, Strings[0] +
                            SetMaleFemale(strings[2][1], 1) + 'в режим ' + tmp);}

            AddNick(strings[0], strtoint(strings[1]) + 5 * strtoint(strings[3])
              + 10 * strtoint(strings[2]), strings[5]);
          end;

        '2', '3', '5', '6', '7', 'н', 'ю', 'ъ', 'w', 'W', ')', '(', '-', ',':
          begin
            {if strings[0] = 'Основной' then
              AddTextToMain(Strings[1] + ' ' + strings[2], 6)
            else
              AddTextToPage(strings[0], Strings[1] + ' ' + strings[2], 6);}
          end;
        '1':
          begin

          end;
        '4':
          begin
            if strings[0] = 'Основной' then
            begin
              AddTextToMain(Strings[1] + ' ' + strings[2], 6);
              PlayWave(tsMeLine);
            end
            else
            begin
              AddTextToPage(strings[0], Strings[1] + ' ' + strings[2], 6);
              PlayWave(tsMeLine);
            end;
          end;
        '!':
          begin
            if IsPagePresent(strings[1]) <> -1 then
              SendData('%' + strings[0] + #0 + strings[1] + #0 + CurNick, '*');
          end;
        '%':
          begin
            if curnick = strings[0] then
              if strings[1] = 'Основной' then
                AddTextToMain('В чате: ' + strings[2], 2)
              else
                AddTextToPage(strings[1], 'В комнате: ' + strings[2], 2);
          end;
        ':':
          begin
            PlayWave(tsNick);
            if SysNickChange then
              AddTextToMain(Strings[0] + SetMaleFemale(strings[5][1], 3) + 'в '
                + Strings[1], 9);
            if curnick <> strings[1] then
              ShowBalloon(bsNickChange, Strings[0] +
                SetMaleFemale(strings[5][1], 3) + 'в ' + Strings[1]);
            ChangeNick(strings[1], strings[6], strtoint(strings[2]) + 5 *
              strtoint(strings[4]) + 10 * strtoint(strings[3]));
            i := IsItemPresent(strings[0]);
            if i <> -1 then
            begin

              boardNick.Strings[i] := strings[1] + #0 +
                GetDate(boardNick.Strings[i]);

              AddTextToBoard('', '', '0');
            end;
            for i := 0 to pg1.PageCount - 1 do
              if pg1.Pages[i].Caption = Strings[0] then
                pg1.Pages[i].Caption := Strings[1];
          end;
        ';':
          begin
            if curnick <> strings[1] then
              ShowBalloon(bsNickChange, Strings[0] +
                SetMaleFemale(strings[5][1], 3) + 'в ' + Strings[1]);
            ChangeNick(strings[1], strings[6], strtoint(strings[2]) + 5 *
              strtoint(strings[4]) + 10 * strtoint(strings[3]));
            i := IsItemPresent(strings[0]);
            if i <> -1 then
            begin

              boardNick.Strings[i] := strings[1] + #0 +
                GetDate(boardNick.Strings[i]);

              AddTextToBoard('', '', '0');
            end;
            for i := 0 to pg1.PageCount - 1 do
              if pg1.Pages[i].Caption = Strings[0] then
                pg1.Pages[i].Caption := Strings[1];
          end;

        'У': if myboard <> '' then
            sendData('Ж' + strings[0] + #0 + curnick + #0 + MyBoard, '*');
        'Ж':
          begin
            if ttboard.PageControl <> nil then
              AddTextToBoard(strings[1], strings[2], '0');
          end;
        'Д':
          begin
            if ttboard.PageControl <> nil then

              AddTextToBoard(strings[0], strings[1], '1');
          end;
        'д':
          begin
            if ttboard.PageControl <> nil then

              AddTextToBoard(strings[0], strings[1], '0');
          end;
        's':
          if strings[0] = CurID then
          begin
            if (not IsUserIgnoredInMsg(strings[1], strings[3])) then
            begin
              // Plays Sound of enabled
              PlayWave(tsMessage);
              // Writing message to log if logs enabled
              if aLogMsg.Checked then
                WriteMsgLog(strings[1] + ' (' + ExtractUserIP(strings[3]) +
                  ')',
                  CurNick + ' (' + ExtractUserIP(CurID) + ')', strings[2], 0,
                  False);
              // Show sys message if enabled
              if SysMessage then
                AddTextToMain(strings[1] + ' посылает сообщение', 7);
              ShowBalloon(bsMessageReceived, 'Входящее сообщение от ' + strings[1] + ': ' + copy(strings[2], 1, 128 - 24 - 4 - length(strings[1])) + '...');
              // If messages in main
              if aMsgInMain.Checked or (ForceMsgInOffline and (curmode = '3'))
                then
              begin
                AddTextToMain('Входящее от ' + strings[1] + ': ' +
                  strings[2],
                  15);
                if pg1.ActivePageIndex <> 0 then
                  if aNoShowMsg.Checked or (ForceMsgInOffline and (curmode =
                    '3')) then
                    pg1.Pages[0].ImageIndex := 1;

                /// NEW FEATURE WITH FLASH!!!
                if FlashTasbarOnText then
                  if CurActive = '1' then
                    if fmMain.Visible then
                      SetForegroundWindow(application.Handle);

                if not fmMain.Visible then
                  if (ForceMsgInOffline and (curmode = '3')) or
                    (aNoShowMsg.Checked) then
                  begin
                    if fmMain.aFlashTBIco.Checked then
                      fmMain.TimerFlash.enabled := True;
                    if (fmMain.aFlashSL.Checked) then
                      fmMain.TimerFlashScr.Enabled := True;
                    if (aPopUpNew.Checked) then
                      ct1DblClick(fmMain);

                  end;
              end; {End of messages in Main}

              if CurMode <> '3' then
                // If not offline
              begin
                // If not don't open message window
                if not aNoShowMsg.Checked then
                begin
                  fmRec := TfmRec.create(nil);
                  i := -1;
                  if aDrawSmiles.Checked then
                    AddWithIcons(fmRec.rvMain, strings[2], 0, i)
                  else
                    fmRec.rvMain.AddTextNL(strings[2], i, 0, 0);
                  ClearHypertext(fmREc.rvMain.RVData, URLScanEvent);
                  ScanURLs(fmREc.rvMain.RVData, URLScanEvent);
                  fmRec.rvMain.FormatTail;
                  fmRec.lbDate.caption := 'Сообщение получено: ' +
                    DateToStr(Date) + ' - ' + TimeToStr(time);
                  fmRec.Caption := '<- ' + strings[1];
                  fmREc.MsgSenderNick := strings[1];
                  fmRec.MsgSenderID := strings[3];
                  fmRec.rvMain.Color := rvMain.Color;

                  if (CurMode in ['1', '4']) then
                  begin
                    fmREc.Visible := True;
                    showWindow(fmrec.handle, SW_SHOWMINNOACTIVE);
                  end
                  else if CurActive = '0' then
                  begin
                    fmREc.Visible := True;
                    showWindow(fmrec.handle, SW_SHOWNOACTIVATE);
                  end
                  else
                  begin
                    fmREc.Show;
                  end;

                  if not fmMain.Visible then
                    ct1.HideTaskbarIcon;


                {  for i:=0 to Screen.FormCount-1 do
                  if screen.Forms[i] is TfmSend then
                  begin
                  if (screen.Forms[i] as TfmSend).ReceiverID = strings[3] then
                  begin
                  AddTextToRV((screen.Forms[i] as TfmSend).rvMsgData,
                  '<' + strings[1] + #0' ' + strings[2], 15 );


                  end;
                  end;}


                end;
              end;
              // Detects current user mode
              case CurMode of
                '0': tmp := mdActive + #0 + '1';
                '1': tmp := mdDND + #0 + '1';
                '2': if autoaway then
                    tmp := Format(AwayMessage,
                      [(fmMain.TimerUserActivity.tag) div 60000]) + #0 + '1'
                  else
                    tmp := mdAway + #0 + '1';
                '3': if ForceMsgInOffline and NotifyInOffline then
                    tmp := mdOffline + #0 + '1'
                  else
                    tmp := mdOffline + #0 + '0';
                '4': tmp := mdGaming + #0 + '1';
              end;
              // Sending answer to sender
              SendData('Q' + strings[3] + #0 + Curnick + #0 + CurMode + #0
                +
                tmp + #0 + CurSex, strings[3]);

            end
            else if miNoResponse.Checked then
            begin
              SendData('Ф' + strings[3] + #0 + Curnick + #0 + AutoMessage,
                strings[3]);
              exit;
            end;
          end;

        'Ф': if curID = strings[0] then
          begin
            if strings[2] <> '' then
              tmp := ': [' + strings[2] + ']'
            else
              tmp := '';
            AddTextToMain('Вы добавлены в фильтр сообщений у ' + strings[1] +
              tmp, 20);
          end;

        'Q': if curID = strings[0] then
          begin
            //    WriteCache('__Debug.txt','msgQ '+Text);
            tmp := '';
            if strings[2][1] <> '0' then
            begin
              case strings[2][1] of
                '1': tmp := '"Не беспокоить"';
                '2': tmp := SetMaleFemale(strings[5][1], 5);
                '3': tmp := '"Отключен' + SetMaleFemale(strings[5][1], 0) + '"';
                '4': tmp := '"Играю"';
              end;
              if strings[3] <> '' then
                tmp := ' в режиме ' + tmp + ' [' + strings[3] + ']'
              else
                tmp := ' в режиме ' + tmp;
            end;

            if strings[4][1] = '1' then
            begin
              if SysMessage then
                AddTextToMain(strings[1] + ' получает сообщение' + tmp, 7);
              ShowBalloon(bsMessage, strings[1] + ' получает сообщение' + tmp);
            end
            else
            begin
              if SysMessage then
                AddTextToMain(strings[1] + ' находится' + tmp, 7);

              ShowBalloon(bsMessage, strings[1] + ' находится' + tmp);
            end;
          end;
        'L':
          begin
            PlayWave(tsLeave);
            if SysEnterExitMain then
              AddTextToMain(strings[0] + SetMaleFemale(strings[1][1], 2) +
                'из разговорa', 2);
            ShowBalloon(bsEnterExitMain, strings[0] +
              SetMaleFemale(strings[1][1], 2) + 'из разговорa');
            DeleteNick(strings[2]);
          end;
        '{':
          begin
            PlayWave(tsLeave);
            if SysEnterExitMain then
              AddTextToMain(strings[0] + SetMaleFemale(strings[1][1], 1) +
                'в ждущий режим', 2);
            ShowBalloon(bsEnterExitMain, strings[0] +
              SetMaleFemale(strings[1][1], 1) + 'в ждущий режим');
            DeleteNick(strings[2]);
          end;
        'l':
          begin
            PlayWave(tsLeave);
            if SysEnterExitMain then
              AddTextToMain(strings[0] + SetMaleFemale(strings[1][1], 2) +
                'из сети (завершение работы)', 2);
            ShowBalloon(bsEnterExitMain, strings[0] +
              SetMaleFemale(strings[1][1], 2) + 'из сети (завершение работы)');
            DeleteNick(strings[2]);
          end;
        'T':
          begin
            if SysTopicChange then
              AddTextToMain('Тема изменена: " ' + strings[1] + ' "', 10);

            edTopic.Items[0].text := 'Основной: ' + strings[1];
            edTopic.ItemIndex := -1;
            edTopic.ItemIndex := pg1.ActivePageIndex;
            if pg1.ActivePageIndex = 0 then
              edTopic.Hint := edTopic.Items[edTopic.ItemIndex].text;
            //    TopicTimer.Enabled:=True;
            PlayWave(tsTopic);
          end;
        'Т':
          begin
            i := IsPagePresent(strings[1]);
            if i <> -1 then
            begin
              if SysTopicChange then
                AddTextToPage(strings[1], 'Тема изменена: " ' + strings[2] +
                  ' "', 10);
              edTopic.Items[i].text := strings[1] + ': ' +
                strings[2];
              edTopic.ItemIndex := -1;
              edTopic.ItemIndex := pg1.ActivePageIndex;
              if i = pg1.ActivePageIndex then
                edTopic.Hint :=
                  edTopic.Items[edTopic.ItemIndex].text;
              PlayWave(tsTopic);
            end;
          end;
        'G': if curID = strings[1] then
            SendUserData(strings[0], strings[2]);
        'g': if CurNick <> strings[0] then
          begin

            tmp := StringReplace(edTopic.Items.Items[0].Text,
              'Основной' + ': ', '', [rfReplaceAll]);

            if tmp <> '' then
              SendData('t' + strings[0] + #0 + tmp, '*');

          end;
        't':
          begin
            if CurNick = strings[0] then
            begin
              tmp := StringReplace(edTopic.Items.Items[0].text,
                'Основной' + ': ', '', [rfReplaceAll]);

              if tmp <> strings[1] then
              begin
                if SysTopicChange then
                  AddTextToMain('Текущая тема: " ' +
                    UCPlugins.ProcessInput(strings[1]) + ' "', 10);
                //                txtTopic := strings[1];
                edTopic.Items[0].text := 'Основной: ' + strings[1];
                edTopic.ItemIndex := -1;
                edTopic.ItemIndex := 0;
                if pg1.ActivePageIndex = 0 then
                  edTopic.Hint :=
                    edTopic.Items[edTopic.ItemIndex].text;

              end;
            end;
          end;
        'I':
          begin
            if CurID = strings[0] then
            begin
              fmInfo := TfmInfo.Create(Application);
              fmInfo.Caption := {'Инфо: '+} strings[1];
              fmInfo.edUser.text := strings[2];
              fmInfo.lbComp.caption := strings[3];
              fmInfo.edIP.text := strings[4];
              fmInfo.edOS.text := strings[5];
              if aShowActiveWnd.Checked then
                fmInfo.edWindow.text := strings[6]
              else
                fmInfo.edWindow.text := '*НЕ ДОСТУПНО*';
              fmInfo.eduVer.text := strings[7];
              fmInfo.edTotal.text := strings[8];
              fmInfo.edUse.text := strings[9];
              fmInfo.edUsrNfo.Text := strings[10];
              fmInfo.lbChan.Items.Text := strings[11];
              fmInfo.mm.Text := strings[12];
              fmInfo.USER_ID := strings[13];
              //     showmessage(fmInfo.USER_ID);

{              if AnsiCompareStr(GetFileVersion(IncludeTrailingBackslash(application.ExeName) +'unichat.exe'),
               strings[7])>0 then
               begin
               fmInfo.eduVer.Font.Color := clWhite;
               fmInfo.eduVer.Color := 20;
               end;}

              fmInfo.Show;
              //     fmInfo.bn.setfocus;
            end;
          end;
        'B':
          if CurID = strings[1] then
          begin
            PlayWave(tsSignal);
            if SysSignal then
              AddTextToMain(strings[0] + ' посылает сигнал', 7);
            ShowBalloon(bsSignal, strings[0] + ' посылает сигнал');

            case CurMode of
              '0': tmp := mdActive + #0 + '1';
              '1': tmp := mdDND + #0 + '0';
              '2': if autoaway then
                  tmp := Format(AwayMessage, [(fmMain.TimerUserActivity.tag) div
                    60000]) + #0 + '1'
                else
                  tmp := mdAway + #0 + '1';

              '3': tmp := mdOffline + #0 + '0';
              '4': tmp := mdGaming + #0 + '0';
            end;
            SendData('b' + strings[2] + #0 + Curnick + #0 + CurMode + #0 + tmp +
              #0 + CurSex,
              strings[2]);
          end;
        'b': if curID = strings[0] then
            if SysSignal then
            begin
              //          AddTextToMain(strings[1]+' получает сигнал',ClMessage);
                        //======
              tmp := '';
              if SysMessage then
                if strings[2][1] <> '0' then
                begin
                  MsgData.Add('0');
                  case strings[2][1] of
                    '1': tmp := '"Не беспокоить"';
                    '2': tmp := SetMaleFemale(strings[5][1], 5);
                    '3': tmp := '"Отключен' + SetMaleFemale(strings[5][1], 0) +
                      '"';
                    '4': tmp := '"Играю"';
                  end;
                  if strings[3] <> '' then
                    tmp := ' в режиме ' + tmp + ' [' + strings[3] + ']'
                  else
                    tmp := ' в режиме ' + tmp;
                end;

              if strings[4][1] in ['1', '4'] then
              begin
                AddTextToMain(strings[1] + ' получает сигнал' + tmp, 7);
                ShowBalloon(bsSignal, strings[1] + ' получает сигнал' + tmp);
              end
              else
              begin
                AddTextToMain(strings[1] + ' находится' + tmp, 7);
                ShowBalloon(bsSignal, strings[1] + ' находится' + tmp);
              end;
            end;
        //======

        'j': if curID = strings[1] then
          begin
            if not IsUserIgnoredInPrivate(Strings[0], strings[2]) then
            begin
              createTab(strings[0], 2);
              if SysEnterExitPrivate then
                AddTextToPage(strings[0], 'Разговор с ' + strings[0], 1);
              //         ShowBalloon(bsEnterExitMainPrivate,Strings[1]+SetMaleFemale(strings[2][1],1)+'в разговор');
              PlayWave(tsPrivateEnter);
              SendData('J' + strings[2] + #0 + Curnick + #0 + CurSex,
                strings[2]);
            end
            else if miNoResponse.Checked then
              SendData('П' + strings[2] + #0 + Curnick + #0 + AutoPrivate,
                strings[2]);
          end;

        'П': if curID = strings[0] then
          begin
            if strings[2] <> '' then
              tmp := ': [' + strings[2] + ']'
            else
              tmp := '';
            AddTextToMain('Вы добавлены в фильтр приватов у ' + strings[1] +
              tmp, 20);
          end;

        'J': if curID = strings[0] then
          begin
            PlayWave(tsPrivateEnter);
            createTab(strings[1], 2);
            if SysEnterExitPrivate then
              AddTextToPage(strings[1], Strings[1] +
                SetMaleFemale(strings[2][1], 1) + 'в разговор', 2);
            ShowBalloon(bsEnterExitMainPrivate, Strings[1] +
              SetMaleFemale(strings[2][1], 1) + 'в разговор');
          end;
        {    'К': if curnick=strings[1] then
                 begin
                 createTab(strings[0],2);
                 if SysEnterExitPrivate then
                 AddTextToPage(strings[0],'Разговор с '+strings[0],1);
                 ShowBalloon(bsEnterExitMainPrivate,Strings[1]+SetMaleFemale(strings[2][1],1)+'в разговор');
                 PlayWave(tsPrivateEnter);
                 SendData('J'+strings[0]+#0+Curnick+#0+CurSex);
                 end;}
        'K': if IsPagePresent(strings[1]) <> -1 then
          begin
            PlayWave(tsChannelEnter);
            //         createTab(strings[1],2);
            if SysEnterExitChannel then
              AddTextToPage(strings[1], Strings[0] +
                SetMaleFemale(strings[2][1], 1) + 'в комнату', 2);
            ShowBalloon(bsEnterExitChannel, Strings[0] +
              SetMaleFemale(strings[2][1], 1) + 'в комнату');
            if CurNick <> strings[0] then
            begin
              i := IsPagePresent(strings[1]);
              if i <> -1 then
              begin
                SendData('т' + strings[3] + #0 + strings[1] + #0 +
                  StringReplace(edTopic.Items.Items[i].Text, pg1.Pages[i].Caption
                  +
                  ': ', '', [rfReplaceAll]), '*');
              end;
            end;
          end;
        'т':
          begin
            if CurID = strings[0] then
            begin
              i := IsPagePresent(strings[1]);
              if i <> -1 then
              begin
                if SysTopicChange then
                begin
                  tmp := UCPlugins.ProcessInput(strings[2]);
                  if StringReplace(edTopic.Items.Items[i].Text,
                    pg1.Pages[i].Caption
                    +
                    ': ', '', [rfReplaceAll]) <> strings[2] then
                  begin

                    AddTextToPage(strings[1], 'Текущая тема: " ' +
                      tmp +
                      ' "', 10);
                    edTopic.Items[i].text := strings[1] + ': ' +
                      strings[2];
                    if i = pg1.ActivePageIndex then
                      edTopic.Hint :=
                        edTopic.Items[edTopic.ItemIndex].text;

                  end;

                end;
                edTopic.ItemIndex := 0;
              end;
            end;
          end;
        '#':
          if strings[0][1] = '#' then
          begin

            // ====
            if isPagePresent(strings[0]) <> -1 then
              if not IsUserIgnoredInRooms(strings[1], strings[3]) then
              begin

                if CurNick = strings[1] then
                  AddTextToPage(strings[0], '<' + strings[1] + #0' ' +
                    strings[2], 3)
                else
                begin
                  PlayWave(tsLine);
                  AddTextToPage(strings[0], '<' + strings[1] + #0' ' +
                    strings[2], 4);

                  /// NEW FEATURE WITH FLASH!!!
                  if FlashTasbarOnText then
                    if CurActive = '1' then
                      if fmMain.Visible then
                        SetForegroundWindow(application.Handle);

                  if not fmMain.Visible then
                  begin
                    if fmMain.aFlashTBIco.Checked then
                      fmMain.TimerFlash.enabled := True;

                    if (fmMain.aFlashSL.Checked) then
                      fmMain.TimerFlashScr.Enabled := True;

                    if (aPopUpNew.Checked) then
                      ct1DblClick(fmMain);

                  end;
                end;
              end;
          end
          else
          begin
            if (curID = strings[4]) and (IsPagePresent(strings[0]) <> -1) then
              AddTextToPage(strings[0], '<' + strings[1] + #0' ' + strings[2], 3)
            else if (IsPagePresent(strings[1]) <> -1) and (CurID = strings[3])
              then
            begin
              PlayWave(tsLine);
              AddTextToPage(strings[1], '<' + strings[1] + #0' ' + strings[2],
                4);

              /// NEW FEATURE WITH FLASH!!!
              if FlashTasbarOnText then
                if CurActive = '1' then
                  if fmMain.Visible then
                    SetForegroundWindow(application.Handle);

              if not fmMain.Visible then
              begin
                if fmMain.aFlashTBIco.Checked then
                  fmMain.TimerFlash.enabled := True;

                if (fmMain.aFlashSL.Checked) then
                  fmMain.TimerFlashScr.Enabled := True;

                if (aPopUpNew.Checked) then
                  ct1DblClick(fmMain);

              end;

              // ====
            end;

          end;
        //       SendData('#'+pg1.ActivePage.Caption+#0+Curnick+#0+Tmp);
        //       SendData('#'+pg1.ActivePage.Caption+#0+Curnick+#0+Tmp);
        '@':
          if Pos(Curnick + #13, strings[0]) > 0 then
          begin
            if not IsUserIgnoredInMsg(strings[1], strings[3]) then
            begin
              if not MassMsg then
              begin
                // Plays Sound of enabled
                PlayWave(tsMassMessage);
                // Writing message to log if logs enabled
                if aLogMsg.Checked then
                begin
                  WriteMsgLog(strings[1] + ' (' + ExtractUserIP(strings[3]) +
                    ')', StringReplace(Trim(strings[0]), #13, ';',
                    [rfReplaceAll]), strings[2], 1, False);
                end;
                // Show sys message if enabled
                if SysMessage then
                  AddTextToMain(strings[1] + ' посылает сообщение', 8);

                // If messages in main

                if pg1.ActivePageIndex <> 0 then
                  if aNoShowMsg.Checked or (ForceMsgInOffline and (curmode = '3'))
                    then
                    pg1.Pages[0].ImageIndex := 1;

                if aMsgInMain.Checked or (ForceMsgInOffline and (curmode = '3'))
                  then
                begin
                  AddTextToMain('Входящее многоадресное от ' + strings[1] +
                    ': '
                    + strings[2], 16);
                  /// NEW FEATURE WITH FLASH!!!
                  if FlashTasbarOnText then
                    if CurActive = '1' then
                      if fmMain.Visible then
                        SetForegroundWindow(application.Handle);

                  if not fmMain.Visible then
                    if (aNoShowMsg.Checked) or (ForceMsgInOffline and (curmode =
                      '3')) then
                    begin

                      if fmMain.aFlashTBIco.Checked then
                        fmMain.TimerFlash.enabled := True;
                      if (fmMain.aFlashSL.Checked) then
                        fmMain.TimerFlashScr.Enabled := True;
                      if (aPopUpNew.Checked) then
                        ct1DblClick(fmMain);
                    end;
                end;

                // Detects current user mode
                if CurMode <> '3' then
                begin
                  if not aNoShowMsg.Checked then
                  begin
                    fmRec := TfmRec.create(nil);
                    i := -1;
                    AddWithIcons(fmRec.rvMain, strings[2], 0, i);
                    ClearHypertext(fmREc.rvMain.RVData, URLScanEvent);
                    ScanURLs(fmREc.rvMain.RVData, URLScanEvent);
                    fmRec.rvMain.FormatTail;
                    fmRec.lbDate.caption := 'Сообщение получено: ' +
                      DateToStr(Date) + ' - ' + TimeToStr(time);
                    fmRec.Caption := '<= ' + strings[1];
                    fmREc.MsgSenderNick := strings[1];
                    fmRec.MsgSenderID := strings[3];
                    fmRec.rvMain.Color := rvMain.Color;
                    if (CurMode in ['1', '4']) then
                    begin
                      fmREc.Visible := True;
                      showWindow(fmrec.handle, SW_SHOWMINNOACTIVE);

                    end
                    else if CurActive = '0' then
                    begin
                      fmREc.Visible := True;
                      showWindow(fmrec.handle, SW_SHOWNOACTIVATE);

                    end
                    else
                      fmREc.Show;
                    if not fmMain.Visible then
                      ct1.HideTaskbarIcon;
                  end;
                end;

                // Detects current user mode
                case CurMode of
                  '0': tmp := mdActive + #0 + '1';
                  '1': tmp := mdDND + #0 + '1';
                  '2': if autoaway then
                      tmp := Format(AwayMessage, [(fmMain.TimerUserActivity.tag)
                        div 60000]) + #0 + '1'
                    else
                      tmp := mdAway + #0 + '1';
                  '3': if ForceMsgInOffline and NotifyInOffline then
                      tmp := mdOffline + #0 + '1'
                    else
                      tmp := mdOffline + #0 + '0';
                  '4': tmp := mdGaming + #0 + '1';
                end;
                // Sending answer to sender
                SendData('Q' + strings[3] + #0 + Curnick + #0 + CurMode + #0 +
                  tmp + #0 + CurSex, strings[3]);
              end;
            end
            else if miNoResponse.Checked then
              SendData('Ф' + strings[3] + #0 + Curnick + #0 + AutoMessage,
                strings[3]);
          end;

        'x':
          if (IsPagePresent(Strings[0]) <> -1) or (strings[0] = Curnick) then
          begin
            if strings[0][1] = '#' then
            begin
              PlayWave(tsChannelLeave);
              if SysEnterExitChannel then
                AddTextToPage(strings[0], strings[1] +
                  SetMaleFemale(strings[2][1], 2) + 'из комнаты', 2);
              ShowBalloon(bsEnterExitChannel, strings[1] +
                SetMaleFemale(strings[2][1], 2) + 'из комнаты');
            end
            else
            begin
              if isPagePresent(strings[1]) <> -1 then
                if CurNick = strings[0] then
                begin
                  PlayWave(tsPrivateLeave);
                  if SysEnterExitChannel then
                    AddTextToPage(strings[1], strings[1] +
                      SetMaleFemale(strings[2][1], 2) + 'из разговора', 2);
                  ShowBalloon(bsEnterExitMainPrivate, strings[1] +
                    SetMaleFemale(strings[2][1], 2) + 'из личного разговора');
                end;
            end;
          end;
        'С':
          if CurID = strings[1] then
          begin
            AddTextToMain(strings[0] + ' посылает форс-сигнал', 7);
            PlayWave(tsSignal, True);
            ShowBalloon(bsSignal, strings[0] + ' посылает форс-сигнал');
            case CurMode of
              '0': tmp := mdActive + #0 + '1';
              '1': tmp := mdDND + #0 + '0';
              '2': if autoaway then
                  tmp := Format(AwayMessage, [(fmMain.TimerUserActivity.tag) div
                    60000]) + #0 + '1'
                else
                  tmp := mdAway + #0 + '1';

              '3': tmp := mdOffline + #0 + '0';
              '4': tmp := mdGaming + #0 + '0';
            end;
            SendData('b' + strings[2] + #0 + Curnick + #0 + CurMode + #0 + tmp +
              #0 + CurSex,
              strings[2]);
          end;

        '<':
          if CurID = strings[1] then
          begin
{$IFNDEF ANTI_ADMINPACK}
            userlocked := True;
{$ELSE}
            AddTextToMain('Попытка команды BAN с админ-пака ID=' + strings[2],
              20);
{$ENDIF}

          end;
        '>':
          if CurID = strings[1] then
          begin
{$IFNDEF ANTI_ADMINPACK}
            userlocked := False;
{$ELSE}
            AddTextToMain('Попытка команды UNBAN с админ-пака ID=' + strings[2],
              20);
{$ENDIF}
          end;
        '_':
          if CurID = strings[1] then
          begin
{$IFNDEF ANTI_ADMINPACK}
            myBoard := '';
{$ELSE}
            AddTextToMain('Попытка команды KICK BOARD MESSAGE с админ-пака ID='
              + strings[2], 20);
{$ENDIF}
          end;

        '/': if (strings[1] = CurNick) and (fmMain.Tag <> 12) then
          begin
{$IFNDEF ANTI_ADMINPACK}
            sendData('.' + CurNick + #0 + strings[0], '*');

            SendData('L' + CurNick + #0 + CurSex, '*');
            SendExit;

            z := GlobalFindAtom('fkcik1');
            if z <> 0 then
            begin

              GlobalAddAtom('fkcik2');
            end
            else
              GlobalAddAtom('fkcik1');

            z := GlobalFindAtom('fkcik2');
            if z <> 0 then
            begin
              GlobalAddAtom('fkcik3');
            end
            else
              GlobalAddAtom('fkcik2');

            application.Terminate;
{$ELSE}
            AddTextToMain('Попытка команды KICK с админ-пака ID=' + strings[2],
              20);
{$ENDIF}
          end;
        'r': AddTextToMain(strings[1] + ' создал' +
            SetMaleFemale(strings[2][1],
            0) + ' комнату ' + strings[0], 2);
        'f': if ShowMyRooms then
          begin
            for i := 1 to fmMain.pg1.PageCount - 1 do
              if fmMain.pg1.Pages[i].Caption[1] = '#' then
                tmp := tmp + fmMain.pg1.Pages[i].Caption + #13;
            SendData('F' + strings[0] + #0 + tmp, '*');
          end;
        'F': if Curnick = strings[0] then
          begin
            tmp := '';
            for i := 1 to length(strings[1]) do
            begin
              if strings[1][i] = #13 then
              begin

                z :=
                  fmRooms.lvChatRooms.Items.IndexOf(fmRooms.lvChatRooms.FindCaption(-1, tmp, False, False, False));
                if z = -1 then
                  with fmRooms.lvChatRooms.Items.Add do
                  begin
                    caption := tmp;
                    ImageIndex := 4;
                  end;

                {          with fmRooms.lvChatRooms.Items.Add do
                          begin
                          caption:='#Denis';
                          ImageIndex:=4;
                          end;          }

                tmp := '';
              end
              else
                tmp := tmp + strings[1][i];
            end;

          end;

        '.':

          begin

            AddTextToMain(strings[1] + ' выкинул из чата ' + strings[0],
              20);
          end;

      else
        AddTextToMain('Неизвестная команда! Обновите чат!', 20);
      end;
    end;
end;

procedure BreakString(buf: string; length: integer);
var
  i: integer;
  tmp: string;
begin
  tmp := '';
  MsgData.Text := '';
  for i := 1 to length do
  begin
    if buf[i] = #0 then
    begin
      MsgData.Add(tmp);
      tmp := '';
    end
    else
      tmp := tmp + buf[i];
  end;
  MsgData.Add(tmp);

  {showmessage(MsgData.Strings[0]);
  showmessage(MsgData.Strings[1]);
  showmessage(MsgData.Strings[2]);
  showmessage(buf[1]);}

  //'UniChat!_ver13'#0+
  // tmp:=msgData.Strings[0];
  // showmessage(tmp);

  if msgData.Strings[0] = ChatID then
  begin
    msgdata.Delete(0);
    tmp := msgdata.Strings[0];
    tmp[1] := ' ';
    msgdata.strings[0] := TrimLeft(tmp);
    //showmessage(msgData.Text);
    ExecuteCommand(buf[16]);
  end;
end;

procedure RefreshList;
begin
  with fmMain do
  begin
    if lvUser.SelCount > 0 then
      lastuser := lvUser.Selected.Caption
        {lvUser.Items.Item[lvUser.ItemFocused.Index].caption}
    else
      lastuser := '';
    lvUser.Clear;
    sbTotal.Panels[0].Text := '  Всего: ?';
    SendData('+' + CurID, '*');
  end;
end;

procedure ReturnFocus;
begin
  if GetForegroundWindow = fmMain.Handle then
    fmMain.edText.SetFocus;
end;

{--- end of code---}

procedure TfmMain.miExitClick(Sender: TObject);
begin
  ct1.HideTaskbarIcon;

  shtdwn := False;
  StopServer;


  SendData('L' + CurNick + #0 + CurSex, '*');
  SendExit;
  Client.Active := False;
  WriteSettings;
  Application.Terminate;
end;

procedure TfmMain.ct1DblClick(Sender: TObject);
begin
  RestoreTimers;

  if fmMain.Visible then
  begin
    ct1.HideMainForm;
    ct1.HideTaskbarIcon;
    miRestore.ImageIndex := 41;
    //miRestore.Caption:='Восстановить';
  end
  else
  begin

    TimerFlashScr.Enabled := False;
    TimerAntiScr.Enabled := True;


    ct1.ShowMainForm;

    if aShowTBIco.Checked then
      ct1.ShowTaskbarIcon
    else
      ct1.HideTaskbarIcon;

    miRestore.ImageIndex := 62;



    if TimerFlash.Enabled then
    begin
      TimerFlash.Enabled := False;
      ct1.IconIndex := ord(curmode) - 48;
    end;


  end;

end;

procedure TfmMain.WMSOCKET(var Msg: tagMsg);
var
  buf: array[1..16384] of char;
{$IFDEF PROTECTANTIFLOOD}
  crc: longword;
{$ENDIF}
  s, s1: string;
  i: integer;
  tmp: char;
begin
  i := receivebuf(buf);

  if i < 6000 then
  begin

    // Checking CRC Routine for "SetPenalty"

{$IFDEF PROTECTANTIFLOOD}

    asm
      lea EDX, [SetPenalty]
      mov ECX, 266
      xor EAX, EAX
      call CalcCRC32
      mov CRC,EAX
    end;

    if CRC <> GlobalCRC then
      cipher.Free;

    // Checking CRC Routine for "SendUserData"
    asm
      lea EDX, [SendUserData]
      mov ECX, 1102
      xor EAX, EAX
      call CalcCRC32
      mov CRC,EAX
    end;

    if CRC <> GlobalCRC1 then
      cipher.Free;

    // Checking CRC Routine for "ExecuteCommand"
    asm
      lea EDX, [ExecuteCommand]
      mov ECX, 23296
      xor EAX, EAX
      call CalcCRC32
      mov CRC,EAX
    end;

    if CRC <> GlobalCRC2 then
      cipher.Free;

{$ENDIF}

    // end.

    s := copy(buf, 6, i - 5);
    move(buf, i, 4);
    tmp := buf[5];

    if isProtectEnabled then
      if AntiFloodPacket.PushPacket(i) then
      begin
        if NotifyBaloon then
          ShowBalloon(bsPacketFiltered, GetTimeStamp +
            ' обнаружена атака повторными пакетами', True);
        exit;
      end;

    if i <> LastKey then
    begin
      LastKey := i;
      s1 := DynaKey(GroupKey, i);
      Cipher.Init(s1[1], 96, nil);

      if tmp = '1' then
        s := UclDecompressStrA(Cipher.DecryptString(s))
      else
        s := Cipher.DecryptString(s);

      BreakString(s, length(s));

    end;
    { else
    if NotifyBaloon then
    ShowBalloon(bsPacketFiltered,GetTimeStamp+ ' обнаружен повторный пакет', True);}
  end;
end;

procedure TfmMain.WMPOWERBROADCAST(var Msg: TWMPOWER);
begin
  //WriteCache('Debug!.txt','WM_POWRBROADCAST! -> '+inttostr(Msg.PowerEvt));
  //dfs
  case Msg.PowerEvt of
    PBT_APMSUSPEND, PBT_APMSTANDBY:
      begin
        //                                StopServer;
        //
        //UDPServer.Active:=False;
{$IFNDEF NOENTEREXIT}
        SendData('{' + CurNick + #0 + CurSex, '*');
        //                              WriteCache('Debug!.txt','WM_POWRBROADCAST! -> ENter suspend');
{$ENDIF}
        if IsServer then
          Client.Active := False;

      end;
    PBT_APMRESUMESTANDBY, PBT_APMRESUMESUSPEND, PBT_APMRESUMECRITICAL:
      begin
        //                              UDPServer.Active:=True;
        //                               StopServer;
        if isServer then
          TimerRecoonect.enabled := True

        else
        begin
{$IFNDEF NOENTEREXIT}
          SendData('}' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive,
            '*');
{$ENDIF}
          RefreshList;
          SendData('g' + CurNick, '*');
        end;

        //                              WriteCache('Debug!.txt','WM_POWRBROADCAST! -> Exit suspend');
      end;
  end;

  begin
    //WriteCache('Debug!.txt','WM_POWRBROADCAST!');
    //UDPServer.Active:=False;

    WriteSettings;
    Msg.Result := 1;
  end;
end;

procedure TfmMain.cbChangeInterface;
begin
  if CurSex = '0' then
  begin

    aActive.ImageIndex := 0;
    aGaming.ImageIndex := 4;
    aDND.ImageIndex := 1;
    aDisabled.ImageIndex := 3;
    aAway.ImageIndex := 2;

    aActive.Caption := 'Активен';
    aDisabled.Caption := 'Отключен';
    aAway.Caption := 'Ушел';

    amMain.ActionBars[0].Items[0].items[0].Items[0].ImageIndex:=0;
    amMain.ActionBars[0].Items[0].items[0].Items[1].ImageIndex:=4;
    amMain.ActionBars[0].Items[0].items[0].Items[2].ImageIndex:=1;
    amMain.ActionBars[0].Items[0].items[0].Items[3].ImageIndex:=3;
    amMain.ActionBars[0].Items[0].items[0].Items[4].ImageIndex:=2;


    amMain.ActionBars[1].items[0].Items[0].ImageIndex:=0;
    amMain.ActionBars[1].items[0].Items[1].ImageIndex:=4;
    amMain.ActionBars[1].items[0].Items[2].ImageIndex:=1;
    amMain.ActionBars[1].items[0].Items[3].ImageIndex:=3;
    amMain.ActionBars[1].items[0].Items[4].ImageIndex:=2;

{    aActive.ImageIndex := 0;
    aGaming.ImageIndex := 4;
    aDND.ImageIndex := 1;
    aOffline.ImageIndex := 3;
    aAway.ImageIndex := 2;}

{    miActive1.Caption := 'Активен';
    miOffline1.Caption := 'Отключен';
    miAway1.Caption := 'Ушел';}

  end
  else
  begin
    aActive.ImageIndex := 10;
    aGaming.ImageIndex := 14;
    aDND.ImageIndex := 11;
    aDisabled.ImageIndex := 13;
    aAway.ImageIndex := 12;

    aActive.Caption := 'Активна';
    aDisabled.Caption := 'Отключена';
    aAway.Caption := 'Ушла';

    amMain.ActionBars[0].Items[0].items[0].Items[0].ImageIndex:=10;
    amMain.ActionBars[0].Items[0].items[0].Items[1].ImageIndex:=14;
    amMain.ActionBars[0].Items[0].items[0].Items[2].ImageIndex:=11;
    amMain.ActionBars[0].Items[0].items[0].Items[3].ImageIndex:=13;
    amMain.ActionBars[0].Items[0].items[0].Items[4].ImageIndex:=12;


    amMain.ActionBars[1].items[0].Items[0].ImageIndex:=10;
    amMain.ActionBars[1].items[0].Items[1].ImageIndex:=14;
    amMain.ActionBars[1].items[0].Items[2].ImageIndex:=11;
    amMain.ActionBars[1].items[0].Items[3].ImageIndex:=13;
    amMain.ActionBars[1].items[0].Items[4].ImageIndex:=12;

//    ammbMain.

{    miActive1.ImageIndex := 10;
    miGaming1.ImageIndex := 14;
    miDND1.ImageIndex := 11;
    miOffline1.ImageIndex := 13;
    miAway1.ImageIndex := 12;

    miActive1.Caption := 'Активна';
    miOffline1.Caption := 'Отключена';
    miAway1.Caption := 'Ушла';}

  end;
end;

procedure TfmMain.cbNickChange(Sender: TObject);
var
  i: integer;
  CorrNick: string;

begin
  ReturnFocus;

  i := cbNick.ItemIndex;
  if CurNick <> cbNick.Items[i].Text then
  begin
    CorrNick :=
      Trim(CleanIncorrectSymbols(cbNick.Items[cbNick.itemIndex].text));
    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, CorrNick,
      False, False, False));

    if i = -1 then
    begin
      if CorrNick <> '' then
      begin
        cbItem := cbNick.ItemIndex;

        if TimerRename.Enabled then
          SendData(';' + CurNick + #0 +
            CorrNick + #0 + CurMode
            + #0 + inttostr(cbNick.Items[cbItem].ImageIndex div 10)[1]
            + #0 + CurActive + #0 + CurSex, '*')
        else
        begin
          SendData(':' + CurNick + #0 +
            CorrNick + #0
            + CurMode
            + #0 + inttostr(cbNick.Items[cbItem].ImageIndex div 10)[1]
            + #0 + CurActive + #0 + CurSex, '*');
          TimerRename.Enabled := True;
        end;
        CurNick := cbNick.Items[cbItem].text;
        CurSex := inttostr(cbNick.Items[cbItem].ImageIndex div
          10)[1];
        cbchangeInterface;

      end
      else
        cbNick.ItemIndex := cbItem;

    end
    else
      cbNick.ItemIndex := cbItem;

  end
  else
    cbNick.ItemIndex := cbItem;
end;

procedure SetPenalty;
const
  phrase = 'Фраза отфильтрована антифлудом. Ждите %d сек';
begin
  if fmMain.pg1.ActivePageIndex = 0 then
    addTextToMain(format(phrase, [1 + FloodScore div 1000]), 20) else
    if fmMain.pg1.ActivePage.name <> 'ttboard' then
      AddTextToPage(fmMain.pg1.ActivePage.Caption, format(phrase, [1 + FloodScore div 1000]), 20);

  if (1 + FloodScore div 1000) > 7 then
  begin
    fmMain.TopicTimer.tag := 10;
    GlobalAddAtom('TopicTimer');
    GlobalAddAtom('FloodTimer');
  end;

  fmMain.TimerFlood.Interval := FloodScore;
  fmMain.TimerFlood.Enabled := True;
  fmMain.edText.Text := '';

  {  if (Floodscore <= 0) and (fmMain.TimerFlood.Interval = 5000)
     then
    begin
      AddTextToMain('Ваши сообщения расцениваются как флуд. Тайм-аут 2 минуты',
        20);
      fmMain.TimerFlood.Interval := 120000;
      fmMain.TimerFlood.Enabled := True;
      fmMain.TopicTimer.Tag := 10;
      SendData('4' + fmMain.pg1.ActivePage.Caption + #0 + CurNick + #0 +
        'слишком много флудит. Блокировка 2 минуты.', '*');
      GlobalAddAtom('FloodTimer');
      GlobalAddAtom('TopicTimer');
    end;}
end;

procedure TfmMain.edTextKeyPress(Sender: TObject; var Key: Char);
var
  i, compr: integer;
  tmp, tmp1: string;
  z: boolean;
  p: array[1..10] of byte;
begin

  if (pg1.ActivePage.name <> 'ttboard') and (key = #10) then
    key := #13;

  case key of
    #127:
      begin
        if edText.SelLength > 0 then
        begin
          edText.SelText := TransCodeToggle(edText.SelText);
        end
        else
        begin

          edText.text := TransCodeToggle(edText.text);
          SendKey(edText.Handle, Chr($23));
        end;
        key := #0;
      end;

    #13:
      begin
        edtext.text := Trim(edtext.text);
        move(edtext.text[1], p[1], 3);
        if edText.text <> '' then
        begin

          if edtext.Lines.Count > 0 then
            if (pg1.ActivePage.name = 'ttboard') then
              tmp1 := '\n'
            else
            begin
              tmp1 := ' ';
            end;

          tmp := '';

          if edText.Lines.Count > 1 then
          begin

          //  for i := 0 to edtext.Lines.Count - 1 do
          //    tmp := tmp + edtext.Lines[i] + tmp1;

            tmp := StringReplace(edText.text, #$0D#$0A, tmp1, [rfReplaceAll])

          end
          else
            tmp := edText.text;

          txtHist.Add(tmp);
          txtpos := txtHist.Count;
          key := #0;

          z := edText.Text[1] <> '/';
{$IFNDEF ADMINCHAT}
          if z then
          begin

            inc(phrases);
            if TimerSpeed.Enabled then
            begin
              if (not TimerFlood.Enabled) and (phrases > 4) then
              begin

                SetPenalty;
                exit;
              end;
            end
            else
              TimerSpeed.Enabled := True;

            i := length(tmp);
            if i > 15 then
            begin
              compr := length(UclCompressStrA(tmp, 1));
              compr := (compr * 100) div i;
              if compr < 35 then
              begin
                SetPenalty;
                exit;
              end;
            end;

          end;
{$ENDIF}

          if not TimerFlood.Enabled then
          begin

            i := CalcStrCRC32(tmp);
{$IFNDEF ADMINCHAT}
            if (laststring = i) and (z) and
              TimerRepeat.Enabled then
            begin
              TimerRepeat.Enabled := False;
              TimerFlood.Enabled := True;
              laststring := 0;
              SetPenalty;
              exit;

            end;
{$ENDIF}

            lastString := i;
            TimerRepeat.Enabled := True;

            if not z then
            begin
              tmp1 := Parse(tmp, ' ');
              tmp := Trim(tmp);
              if length(tmp) > 0 then
                if tmp[1] = '/' then
                begin
                  tmp[1] := #0;
                end;
              i := CalcStrCRC32(tmp1);
              case i of
{$IFDEF ADMINPACK}
                // getid
                - 842395889:

                  begin
                    AddTextToMain('ID = $' + adminpackID, 20);
                  end;
{$ENDIF}

                // /forcedupgrade
                {
                                1247467164:
                                  begin
                                    tmp := Trim(tmp);
                                    for i := 0 to lvUser.Items.Count - 1 do
                                    begin
                                      if length(tmp) > 0 then
                                      begin
                                        SendData('s' + lvUser.Items.Item[i].SubItems.Strings[0]
                                          + #0 + uum + #0 + tmp,
                                          lvUser.Items.Item[i].SubItems.Strings[0]);
                                      end;
                                    end;
                                  end;
                }
                // upgradeyourchat
                 {
                                474799832: SendData('W', '*');
                }
                568023282, -1892590440:
                  begin
                    i := length(Trim(tmp));
                    if i > 0 then
                    begin
{$IFNDEF ADMINPACK}
                      if TimerSpeed.Enabled then
                      begin
                        if (not TimerFlood.Enabled) and (phrases > 4) then
                          SetPenalty;
                      end
                      else
                        TimerSpeed.Enabled := True;
                      if i > 20 then
                      begin
                        compr := length(UclCompressStrA(tmp, 1));
                        compr := (compr * 100) div i;
                        if compr < 30 then
                          SetPenalty;
                      end;

                      if TimerAntiMe.Enabled then
                      begin
                        SetPenalty;
                      end;

                      TimerAntiMe.Enabled := True;

                      lastString := i;
{$ENDIF}

                      SendData('4' + pg1.ActivePage.Caption +
                        #0 + CurNick + #0 + UCPlugins.ProcessOutput(Trim(tmp)),
                        '*');
                    end;
                  end;
                475676486, -351339018:
{$IFNDEF ADMINPACK}
                  if not TopicTImer.Enabled then
                  begin
                    if TopicTimer.tag <> 10 then
                    begin
                      if length(tmp) < 256 then
                      begin

                        TopicTimer.Enabled := True;
{$ENDIF}
                        if pg1.ActivePageIndex = 0 then
                          SendData('T' + CurNick + #0 +
                            UCPlugins.ProcessOutput(Trim(tmp)) + ' (' +
                            CurNick + ')' + #0 + CurSex, '*')
                        else if pg1.ActivePage.ImageIndex in [4, 5] then
                          SendData('Т' + CurNick + #0 + pg1.ActivePage.Caption +
                            #0 + UCPlugins.ProcessOutput(Trim(tmp)) + ' (' +
                            CurNick + ')' + #0 + CurSex,
                            '*')

                        else
                          TopicTimer.Enabled := False;
{$IFNDEF ADMINPACK}
                      end
                      else
                        showmessage('Длина сообщения топика 256 символов. Будьте кратки.');
                    end
                    else
                      showmessage('Вы расцениваетесь как флудер и не имеете права менять тему');
                  end
                  else
                    showmessage('Сработала защита. Подождите минуту.');
{$ENDIF}
                // extratopic

                {                -915288171:
                                  begin
                                    if pg1.ActivePageIndex = 0 then
                                      SendData('T' + CurNick + #0 +
                                        UCPlugins.ProcessOutput(Trim(tmp)) + #0 + CurSex, '*')
                                    else if pg1.ActivePage.ImageIndex in [4, 5] then
                                      SendData('Т' + CurNick + #0 + pg1.ActivePage.Caption +
                                        #0 + UCPlugins.ProcessOutput(Trim(tmp)) + #0 + CurSex,
                                        '*')
                                    else
                                      TopicTimer.Enabled := False;
                                  end;
                }
                367793996, 595196664: SendData('!' + CurNick + #0 +
                    pg1.ActivePage.Caption, '*');
                -1049992578, -134246454:
                  begin
                    tmp1 := Trim(tmp);

                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                      False, False, False));
                    if i <> -1 then
                    begin
                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                      SendData('j' + CurNick + #0 + tmp1, tmp1);
                    end;

                  end;

                -857700090, 1001671606:
                  begin
                    tmp1 := Trim(tmp);

                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                      False, False, False));
                    if i <> -1 then
                    begin
                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                      SendData('G' + CurNick + #0 + tmp1, tmp1);
                    end;
                  end;

                // -----------------------------------------------------------------------

                -1912815645, -1150725545:
                  begin
                    if not TimerRename.Enabled then
                    begin
                      if pos('#f ', tmp) <> 0 then
                      begin
                        tmp := StringReplace(tmp, '#f ', '', []);
                        tmp1 := 'female';
                      end;

                      tmp := Trim(CleanIncorrectSymbols(tmp));
                      if length(tmp) > 0 then
                      begin
                        if tmp[1] = '/' then
                        begin
                          tmp[1] := #0;
                        end;

                        i := fmMain.cbNick.SearchExactString(tmp, True);
                        if i = -1 then
                        begin
                          with cbNick.Items.Add do
                          begin
                            text := tmp;
                            if tmp1 = 'female' then
                              ImageIndex := 10
                            else
                              ImageIndex := 0;
                          end;
                          if lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp,
                            False,
                            False, False)) = -1 then
                          begin
                            cbNick.ItemIndex := cbNick.Items.Count - 1;
                            cbNick.OnChange(self);
                            ///WriteNicks;
                          end;
                        end
                        else
                        begin
                          if lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp,
                            False,
                            False, False)) = -1 then
                          begin
                            cbNick.ItemIndex := i;
                            cbNick.OnChange(self);
                          end;
                        end;
                      end;
                    end
                    else
                      AddTextToMain('Сменить имя можно раз в 20 секунд', 20);

                  end;

                // -----------------------------------------------------------------------

                1323230921, -663116733:
                  begin
                    tmp := Trim(tmp);
                    tmp1 := Parse(tmp, ' ');

                    for i := 0 to lvUser.Items.Count - 1 do
                      if pos(tmp1, lvUser.Items.Item[i].Caption) = 1 then
                      begin
                        tmp := StringReplace(tmp1 + ' ' + tmp,
                          lvUser.Items.Item[i].Caption, '', []);

                        tmp1 := lvUser.Items.Item[i].Caption;
                        tmp := Trim(tmp);
                        if length(tmp) > 0 then
                        begin
                          SendData('s' + lvUser.Items.Item[i].SubItems.Strings[0]
                            + #0 + CurNick + #0 + UCPlugins.ProcessOutput(tmp),
                            lvUser.Items.Item[i].SubItems.Strings[0]);
                          TimerWriteOut.OnTimer(Self);

                          if fmMain.aMsgInMain.Checked then
                            AddTextToMain('Исходящее к ' + tmp1 + ': ' + tmp,
                              14);

                          if fmMain.aLogMsg.Checked then
                            WriteMsgLog(Curnick + ' (' + ExtractUserIP(CurID) +
                              ')', tmp1 +
                              ' (' +
                              ExtractUserIP(lvUser.Items.Item[i].SubItems.Strings[0])
                              + ')', tmp, 0, True);

                          break;
                        end;
                      end;
                  end;
                1385675578, -1569751876:
                  begin
                    tmp := Trim(tmp);

                    tmp1 := Trim(parse(tmp, '/'));
                    //     showmessage(tmp1);
                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                      False, False, False));
                    if i <> -1 then
                    begin
                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0] + #0 +
                        CurNick;
                      tmp := Trim(tmp);
                      tmp1 := tmp1 + #0 + Trim(parse(tmp, '/')) + #0 +
                        Trim(tmp);
                      SendData('p' + tmp1,
                        lvUser.Items.Item[i].SubItems.Strings[0]);

                      //     showmessage(tmp1);

                    end;

                    //

                  end;
                // getpenaltystatus
                 {
                                1894861607: AddTextToMain('У вас осталось ' +
                                    inttostr(FloodScore) + ' очков', 20);

                }
                // kickelem
                {                785408221:
                                  begin
                                    fmMain.Tag := 12;
                                    laststring := 0;
                                    SendData(',' + CurNick + #0 + Trim(tmp), '*');
                                    SendData('/' + CurNick + #0 + Trim(tmp), '*');
                                  end;
                }
                // extrasignal
                {                2119699139:
                                  begin

                                    laststring := 0;
                                    tmp1 := Trim(tmp);

                                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                                      False, False, False));
                                    if i <> -1 then
                                    begin
                                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                                      SendData('С' + CurNick + #0 + tmp1, tmp1);
                                    end;
                                  end;
                }
                //lockelem
                {
                                1204116734:
                                  begin

                                    laststring := 0;
                                    tmp1 := Trim(tmp);

                                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                                      False, False, False));
                                    if i <> -1 then
                                    begin
                                      AddTextToMain(tmp1 + ' заблокирован', 20);

                                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                                      SendData('(' + CurNick + #0 + tmp1, tmp1);
                                      SendData('<' + CurNick + #0 + tmp1, tmp1);
                                    end;

                                  end;
                }
                // ulockelem
                {
                                460108691:
                                  begin

                                    laststring := 0;
                                    tmp1 := Trim(tmp);

                                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                                      False, False, False));
                                    if i <> -1 then
                                    begin
                                      AddTextToMain(tmp1 + ' разблокирован', 20);
                                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                                      SendData(')' + CurNick + #0 + tmp1, tmp1);
                                      SendData('>' + CurNick + #0 + tmp1, tmp1);
                                    end;

                                  end;
                 }
                // kickelemmsg
                {
                                250953873:
                                  begin
                                    laststring := 0;
                                    SendData('Д' + Trim(tmp) + #0' ', '*');

                                    tmp1 := Trim(tmp);

                                    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, tmp1,
                                      False, False, False));
                                    if i <> -1 then
                                    begin
                                      tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];
                                      SendData('-' + CurNick + #0 + tmp1, tmp1);
                                      SendData('_' + CurNick + #0 + tmp1, tmp1);
                                    end;
                                  end;
                 }

                -1936308221, -1174166089:
                  begin
                    tmp1 := Copy(Trim(tmp), 1, 32);
                    if (length(tmp1) > 1) then
                    begin
                      if tmp1[1] <> '#' then
                        tmp1 := '#' + tmp1;
                      createTab(tmp1, 4);
                      SendData('K' + CurNick + #0 + tmp1 + #0 + CurSex, '*');
                      SendData('!' + CurNick + #0 + tmp1, '*');
                    end
                    else if pg1.ActivePageIndex = 0 then
                      addTexttoMain('Неверный параметр', 20)
                    else if pg1.ActivePageIndex <> 1 then
                      AddTexttoPage(pg1.ActivePage.Caption, 'Неверный параметр',
                        20);

                  end;

              else

                if pg1.ActivePageIndex = 0 then
                  addTexttoMain('Неверная команда: ' + tmp1, 20)
                else if pg1.ActivePageIndex <> 1 then
                  AddTexttoPage(pg1.ActivePage.Caption, 'Неверная команда: ' +
                    tmp1, 20);

              end;
              edText.text := '';
              exit;
            end;

            if pg1.ActivePageIndex = 0 then
            begin

              if not DontShowTalk then
              begin
                tmp := UCPlugins.ProcessOutput(tmp);
                if trim(tmp) <> '' then
                begin
                  if UserLocked then
                    addTextToMain('<' + CurNick + '> ' +
                      tmp, 3)
                  else
                    SendData('M' + CurNick + #0 + tmp,
                      '*');
                end;
                if NotifyUserTyping then
                begin
                  TimerWriteOut.Enabled := False;
                  TimerWriteOut.OnTimer(Self);
                end;

              end
              else
                showmessage('Вы отключили разговор в "Основном", поэтому говорить здесь вы не можете ;)');
            end
            else if pg1.ActivePage.Caption = 'Объявления' then
            begin
              if myBoard <> Trim(tmp) then
              begin
{$IFNDEF ADMINPACK}
                if length(Trim(tmp)) < 1025 then
                begin
{$ENDIF}
                  MyBoard := Trim(tmp);
                  if BoardTimer.Enabled then
                    SendData('д' + Curnick + #0 + MyBoard, '*')
                  else
                  begin
                    SendData('Д' + Curnick + #0 + MyBoard, '*');
                    BoardTimer.Enabled := True;
                  end;
                  if NotifyUserTyping then
                  begin
                    TimerWriteOut.Enabled := False;
                    TimerWriteOut.OnTimer(Self);
                  end;

{$IFNDEF ADMINPACK}
                end
                else
                begin
                  showmessage('Лимит объявления 1024 символа. Будьте кратки!');
                  edText.Text := Trim(tmp);
                  SendKey(edText.Handle, Chr($23));
                end;
{$ENDIF}

              end;
            end
            else if pg1.ActivePage.Caption[1] = '#' then
            begin
              tmp := UCPlugins.ProcessOutput(tmp);
              if trim(tmp) <> '' then
              begin

                if userlocked then
                  AddTextToPage(pg1.ActivePage.Caption, '<' + CurNick + '> ' +
                    tmp, 3)
                else
                  SendData('#' + pg1.ActivePage.Caption + #0 + Curnick + #0 +
                    tmp,
                    '*');
              end;
              if NotifyUserTyping then
              begin

                TimerWriteOut.Enabled := False;
                TimerWriteOut.OnTimer(Self);
              end;

            end
            else
            begin
              i := lvUser.Items.IndexOf(lvUser.FindCaption(-1,
                pg1.ActivePage.Caption, False, False, False));
              if i <> -1 then
              begin
                tmp1 := lvUser.Items.Item[i].SubItems.Strings[0];

                tmp := UCPlugins.ProcessOutput(Tmp);

                if trim(tmp) <> '' then
                begin
                  SendData('#' + pg1.ActivePage.Caption + #0 + Curnick + #0 +
                    tmp + #0 + tmp1, tmp1);
                  if isServer then
                    SendData('#' + pg1.ActivePage.Caption + #0 + Curnick + #0 +
                      tmp
                      + #0 + tmp1, CurID);
                end;

                if NotifyUserTyping then
                begin

                  TimerWriteOut.Enabled := False;
                  TimerWriteOut.OnTimer(Self);
                end;

              end;

            end;

          end;

        end
        else
        begin
          if pg1.ActivePage.Caption = 'Объявления' then
          begin
            SendData('д' + Curnick + #0, '*');
            myBoard := '';
          end;
          key := #0;
        end;
        edText.text := '';
      end;
  end;
end;

procedure StartChatNetwork;
var
  i: integer;
begin
  with fmMain do
  begin
    if IsServer then
    begin
      client.Active := True;
    end
    else
    begin
      CreateSocket;
      Listen(strtoint(port), BroadcastIP, fmMain.Handle);
{$IFNDEF NOENTEREXIT}
      SendData('e' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive,
        '*');
{$ENDIF}
      SendData('g' + CurNick, '*');
      RefreshList;
      SendData('У', '*');
      ReadRoomsMainPage;
      pg1.ActivePageIndex := 0;
      for i := 1 to pg1.PageCount - 1 do
        if DefaultRoom = pg1.Pages[i].Caption then
        begin
          pg1.ActivePageIndex := i;
          break;
        end;
      edTopic.ItemIndex := pg1.ActivePage.PageIndex;
    end;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin


  Application.HintHidePause := 60000;
  TimerFlood.Interval := 2000;
  RestoreTimers;
  hlib := LoadLibrary('USER32.DLL');

  if hlib = 0 then
    TimerUserActivity.Enabled := False;
  GetLastInputInfoSELF := GetProcAddress(hLib, 'GetLastInputInfo');
  if @GetLastInputInfoSELF = nil then
    TimerUserActivity.Enabled := False;
  randomize;
{$IFDEF ACTIONEMU}
  FNewMenuActions := TList.Create;
  UpdateActionMainMenuBar(mmMain);
{$ENDIF}


  CurID := GetChatUserID;

  //  CurID := uHost2IP + '/' + '*Недоступно*' + '/' +
  //    'Администратор' {  + inttostr(Random(maxint))};

  txtPos := 0;
  shtdwn := True;
  //ReadSettings;


  txtHist := TStringList.Create;
  MsgData := TStringList.Create;

  // !!!Filters!!!
  Name_Room := TStringList.Create;
  IP_Room := TStringList.Create;

  Name_Private := TStringList.Create;
  IP_Private := TStringList.Create;

  Name_Msg := TStringList.Create;
  IP_Msg := TStringList.Create;

  BoardNick := TStringList.Create;
  boardData := TStringList.Create;

  Cipher := TDCP_RC6.Create(Self);
  UCPlugins := TUniChatPlugins.Create(Application.ExeName);

  LoadPlugins;

  {  ReadModes('InputPlugins',name_room);
    for i:=0 to name_room.Count -1 do
    UCPlugins.EnableByInput(name_room.Strings[i]);

    ReadModes('OutputPlugins',name_room);
    for i:=0 to name_room.Count -1 do
    UCPlugins.EnableByOutput(name_room.Strings[i]);}

    // Reading Filters Items!!!
  ReadModes('FilterNameRoom', Name_Room);
  ReadModes('FilterIPRoom', IP_Room);
  ReadModes('FilterNamePrivate', Name_Private);
  ReadModes('FilterIPPrivate', IP_Private);
  ReadModes('FilterNameMsg', Name_Msg);
  ReadModes('FilterIPMsg', IP_Msg);

  /// ---------------------------------------------------------------------


  if CrbLogin then
  begin
    if fmMain.cbNick.Items.Count = 0 then cbItem := -1 else

      cbItem :=
        fmMain.cbNick.SearchExactString(CleanIncorrectSymbols(uGetUserName),
        True);

    if cbItem = -1 then
    begin
      if not CcbAutogender then
      begin

        with cbNick.Items.Add do
        begin
          text := CleanIncorrectSymbols(uGetUserName);
          ImageIndex := 0;
        end;

        cbItem :=
          fmMain.cbNick.SearchExactString(CleanIncorrectSymbols(uGetUserName),
          True);
        cbNick.ItemIndex := cbItem;
      end
      else
      begin
        cbItem := GetNickGender(CleanIncorrectSymbols(uGetUserName));

        with cbNick.Items.Add do
        begin
          text := CleanIncorrectSymbols(uGetUserName);
          ImageIndex := cbItem;
        end;
        //        cbNick.Items.AddItem(, cbItem, cbItem, -1, -1, nil);

        cbItem :=
          fmMain.cbNick.SearchExactString(CleanIncorrectSymbols(uGetUserName),
          True);
        cbNick.ItemIndex := cbItem;
      end;

    end
    else
      cbNick.ItemIndex := cbItem;
  end
  else if cbNick.Items.Count > 0 then
  begin
    if (cbItem >= 0) and (cbItem < cbNick.Items.Count) then
      cbNick.ItemIndex := cbItem
    else
    begin
      with cbNick.Items.Add do
      begin
        text := CleanIncorrectSymbols(uGetUserName);
        ImageIndex := 0;
      end;

      //      cbNick.Items.AddItem(, 0, 0, -1, -1, nil);
      cbItem :=
        fmMain.cbNick.SearchExactString(CleanIncorrectSymbols(uGetUserName),
        True);
      cbNick.ItemIndex := cbItem;
    end;

  end
  else
  begin
    with cbNick.Items.Add do
    begin
      text := CleanIncorrectSymbols(uGetUserName);
      ImageIndex := 0;
    end;
    //    cbNick.ItemsEx.AddItem(CleanIncorrectSymbols(uGetUserName), 0, 0, -1, -1, nil);
    cbItem :=
      fmMain.cbNick.SearchExactString(CleanIncorrectSymbols(uGetUserName),
      True);
    cbNick.ItemIndex := cbItem;
  end;

  CurNick := cbNick.Items[cbItem].text;


{$IFDEF ADMINCHAT}
  with cbNick.Items.Add do
  begin
    text := '@Администратор';
    ImageIndex := 0;
  end;
  cbItem := fmMain.cbNick.SearchExactString('@Администратор', True);
  cbNick.ItemIndex := cbItem;
  CurNick := cbNick.Items[cbItem].text;
{$ENDIF}

  //:='Автосоздание: '+CurNick+' ['+DateToStr(Now)+' - '+TimeToStr(Now)+']';
  //reTopic.Font.Color:=clWindowText;
  //reTopic.lines.add('Автосоздание: '+CurNick+' ['+DateToStr(Now)+' - '+TimeToStr(Now)+']');
  //reTopic.lines.add('Автосоздание: '+CurNick+' ['+DateToStr(Now)+' - '+TimeToStr(Now)+']');
  //;
  //
  //CurMode := '0';
  CurSex := inttostr(cbNick.Items[cbItem].ImageIndex div 10)[1];
  CurActive := '1';
  cbchangeInterface;

  with edTopic.Items.Add do
  begin
    text := 'Основной: ' + CurNick + SetMaleFemale(CurSex, 1) + ' [' +
      DateToStr(Now) + ' - ' + TimeToStr(Now) + ']';
    ImageIndex := 0;
  end;

  //  edTopic.ItemsEx.AddItem(, 0, 0, -1, -1, nil);

  if aShowBoard.Checked then
  begin
    with edTopic.Items.Add do
    begin
      text := 'Объявления';
      ImageIndex := 3;
    end;

    //    edTopic.AddItem('Объявления', 3, 3, -1, -1, nil);
  end;

  edTopic.ItemIndex := 0;

  //  txtTopic := CurNick + SetMaleFemale(CurSex, 1) + ' [' + DateToStr(Now) + ' - '
  //    + TimeToStr(Now) + ']';

  AddTextToMain('Добро пожаловать в UniChat, ' + CurNick, 1);

  // Selfsocket!!

//  CurNick := 'Diska' + inttostr(Random(maxint));

  client.Host := DedicatedIP;
  client.Port := portDedic;

  StartChatNetwork;
  //CheckNetTimer.Enabled := True;

  TimerFlash.Enabled := False;

  if GlobalFindAtom('FloodTimer') <> 0 then
  begin
    AddTextToMain('В прошлой сессии вы расценивались как флудер. Минимальный лимит блокировки при нарушениях составляет 16 секунд', 20);
    FloodScore := 15968;
    TimerFlood.Interval := 15958;
    TimerFlood.Enabled := True;
  end;

  if GlobalFindAtom('TopicTimer') <> 0 then
  begin
    TopicTimer.Tag := 10;
  end;

{$IFNDEF UNICODERSNET}
{$IFDEF SELFPROTECT}
  asm
      push EDX
      push ECX
      push EAX
      lea EDX, [CheckKick]
      mov ECX, 32
      xor EAX, EAX
      call CalcCRC32
      mov i,EAX
      pop EDX
      pop ECX
      pop EAX
  end;

  if i <> GlobalCRC1 then
    cipher.Free;
{$ENDIF}
{$ENDIF}

  smilestate := aDrawSmiles.Checked;
  if aDisableSmilesGaming.Checked and (CurMode = '4') then
    aDrawSmiles.Checked := False;
  edTopic.Hint := edTopic.Items[edTopic.ItemIndex].text;
  //ReturnFocus;

//  autoaway := True;
  fmMain.atbMain.Visible :=  aShowToolBar.Checked;

end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ct1.HideMainForm;
  ct1.HideTaskbarIcon;
  Action := caNone;
end;

procedure TfmMain.tRfshTimer(Sender: TObject);
begin
  RefreshList;
end;

procedure TfmMain.apeActivate(Sender: TObject);
begin
  //FlashWindow(application.Handle,False);
  CurActive := '0';
  if (not isServer) or (IsServer and client.Active) then
    SendData('m' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, '*');

end;

procedure TfmMain.apeDeactivate(Sender: TObject);
begin
  TimerWriteOut.Enabled := False;
  CurActive := '1';
  if (not isServer) or (IsServer and client.Active) then
    SendData('m' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, '*');
end;

{procedure SendKey(H: Hwnd; Key: char);
var vKey, ScanCode: Word;

lParam, ConvKey: longint;
begin

ConvKey:= OemKeyScan(ord(Key));
ScanCode:= ConvKey and $000000FF or $FF00;
vKey:= ord(Key);
lParam:= longint(ScanCode) shl 16 or 1;
SendMessage(H, WM_KEYDOWN, vKey, lParam);
lParam:= lParam or $C0000000;
SendMessage(H, WM_KEYUP, vKey, lParam);
end;}

procedure SendKey(H: Hwnd; Key: char);
var
  vKey, ScanCode: Word;
  lParam, ConvKey: longword;
begin

  ConvKey := OemKeyScan(ord(Key));
  ScanCode := ConvKey and $000000FF or $FF00;
  vKey := ord(Key);
  lParam := longint(ScanCode) shl 16 or 1;
  SendMessage(H, WM_KEYDOWN, vKey, lParam);
  lParam := lParam or $C0000000;
  SendMessage(H, WM_KEYUP, vKey, lParam);
end;

function TransCodeToggle(text: string): string;
var
  i, dx: integer;
  tmp: string;
begin
  tmp := text;

  dx := 1;

  //showmessage(inttostr(Pos('->',tmp)));
  if Pos('->', tmp) = 1 then
    dx := pos(':', tmp) + 1
  else if (pos('/', tmp) = 1) then
    dx := pos(' ', tmp);

  for i := dx to length(tmp) do

    case tmp[i] of
      // ENG--RUS
      'q': tmp[i] := 'й';
      'w': tmp[i] := 'ц';
      'e': tmp[i] := 'у';
      'r': tmp[i] := 'к';
      't': tmp[i] := 'е';
      'y': tmp[i] := 'н';
      'u': tmp[i] := 'г';
      'i': tmp[i] := 'ш';
      'o': tmp[i] := 'щ';
      'p': tmp[i] := 'з';
      '[': tmp[i] := 'х';
      ']': tmp[i] := 'ъ';
      'a': tmp[i] := 'ф';
      's': tmp[i] := 'ы';
      'd': tmp[i] := 'в';
      'f': tmp[i] := 'а';
      'g': tmp[i] := 'п';
      'h': tmp[i] := 'р';
      'j': tmp[i] := 'о';
      'k': tmp[i] := 'л';
      'l': tmp[i] := 'д';
      ';': tmp[i] := 'ж';
      '''': tmp[i] := 'э';
      'z': tmp[i] := 'я';
      'x': tmp[i] := 'ч';
      'c': tmp[i] := 'с';
      'v': tmp[i] := 'м';
      'b': tmp[i] := 'и';
      'n': tmp[i] := 'т';
      'm': tmp[i] := 'ь';
      ',': tmp[i] := 'б';
      '.': tmp[i] := 'ю';
      '/': tmp[i] := '.';
      '\': tmp[i] := '\';
      '`': tmp[i] := 'ё';

      '@': tmp[i] := '"';
      '#': tmp[i] := '№';
      '$': tmp[i] := ';';
      '^': tmp[i] := ':';
      '&': tmp[i] := '?';

      'Q': tmp[i] := 'Й';
      'W': tmp[i] := 'Ц';
      'E': tmp[i] := 'У';
      'R': tmp[i] := 'К';
      'T': tmp[i] := 'Е';
      'Y': tmp[i] := 'Н';
      'U': tmp[i] := 'Г';
      'I': tmp[i] := 'Ш';
      'O': tmp[i] := 'Щ';
      'P': tmp[i] := 'З';
      '{': tmp[i] := 'Х';
      '}': tmp[i] := 'Ъ';
      'A': tmp[i] := 'Ф';
      'S': tmp[i] := 'Ы';
      'D': tmp[i] := 'В';
      'F': tmp[i] := 'А';
      'G': tmp[i] := 'П';
      'H': tmp[i] := 'Р';
      'J': tmp[i] := 'О';
      'K': tmp[i] := 'Л';
      'L': tmp[i] := 'Д';
      ':': tmp[i] := 'Ж';
      '"': tmp[i] := 'Э';
      'Z': tmp[i] := 'Я';
      'X': tmp[i] := 'Ч';
      'C': tmp[i] := 'С';
      'V': tmp[i] := 'М';
      'B': tmp[i] := 'И';
      'N': tmp[i] := 'Т';
      'M': tmp[i] := 'Ь';
      '<': tmp[i] := 'Б';
      '>': tmp[i] := 'Ю';
      '?': tmp[i] := ',';
      '~': tmp[i] := 'Ё';

      // RUS==ENG
      'й': tmp[i] := 'q';
      'ц': tmp[i] := 'w';
      'у': tmp[i] := 'e';
      'к': tmp[i] := 'r';
      'е': tmp[i] := 't';
      'н': tmp[i] := 'y';
      'г': tmp[i] := 'u';
      'ш': tmp[i] := 'i';
      'щ': tmp[i] := 'o';
      'з': tmp[i] := 'p';
      'х': tmp[i] := '[';
      'ъ': tmp[i] := ']';
      'ф': tmp[i] := 'a';
      'ы': tmp[i] := 's';
      'в': tmp[i] := 'd';
      'а': tmp[i] := 'f';
      'п': tmp[i] := 'g';
      'р': tmp[i] := 'h';
      'о': tmp[i] := 'j';
      'л': tmp[i] := 'k';
      'д': tmp[i] := 'l';
      'ж': tmp[i] := ';';
      'э': tmp[i] := '''';
      'я': tmp[i] := 'z';
      'ч': tmp[i] := 'x';
      'с': tmp[i] := 'c';
      'м': tmp[i] := 'v';
      'и': tmp[i] := 'b';
      'т': tmp[i] := 'n';
      'ь': tmp[i] := 'm';
      'б': tmp[i] := ',';
      'ю': tmp[i] := '.';
      //     '.': tmp[i]:='/';
      //     '\': tmp[i]:='\';
      'ё': tmp[i] := '`';

      //     '"': tmp[i]:='@';
      '№': tmp[i] := '#';
      //     ';': tmp[i]:='$';
      //     ':': tmp[i]:='^';
      //     '?': tmp[i]:='&';

      'Й': tmp[i] := 'Q';
      'Ц': tmp[i] := 'W';
      'У': tmp[i] := 'E';
      'К': tmp[i] := 'R';
      'Е': tmp[i] := 'T';
      'Н': tmp[i] := 'Y';
      'Г': tmp[i] := 'U';
      'Ш': tmp[i] := 'I';
      'Щ': tmp[i] := 'O';
      'З': tmp[i] := 'P';
      'Х': tmp[i] := '{';
      'Ъ': tmp[i] := '}';
      'Ф': tmp[i] := 'A';
      'Ы': tmp[i] := 'S';
      'В': tmp[i] := 'D';
      'А': tmp[i] := 'F';
      'П': tmp[i] := 'G';
      'Р': tmp[i] := 'H';
      'О': tmp[i] := 'J';
      'Л': tmp[i] := 'K';
      'Д': tmp[i] := 'L';
      'Ж': tmp[i] := ':';
      'Э': tmp[i] := '"';
      'Я': tmp[i] := 'Z';
      'Ч': tmp[i] := 'X';
      'С': tmp[i] := 'C';
      'М': tmp[i] := 'V';
      'И': tmp[i] := 'B';
      'Т': tmp[i] := 'N';
      'Ь': tmp[i] := 'M';
      'Б': tmp[i] := '<';
      'Ю': tmp[i] := '>';
      //     ',': tmp[i]:='?';
      'Ё': tmp[i] := '~';

    end;

  Result := tmp;
  //      showmessage(inttostr(GetKeyboardLayout(0)));

//  ActivateKeyboardLayout(0, HKL_NEXT);
  i := 0;
  if GetKeyboardLayout(0) = 67699721 then
  begin
    while (GetKeyboardLayout(0) <> 68748313) or (i < 5) do
    begin
      ActivateKeyboardLayout(0, HKL_NEXT);
      inc(i);
    end;
  end
  else
  begin

    while (GetKeyboardLayout(0) <> 67699721) or (i < 5) do
    begin
      ActivateKeyboardLayout(0, HKL_NEXT);
      inc(i);
    end;
  end;

  //  begin
  //  if KeybLay<>0 then
  //    UnloadKeyboardLayout(KeybLay);
  //    KeybLay:=LoadKeyboardLayout('00000419', KLF_ACTIVATE);
  //    ActivateKeyboardLayout(0,HKL_PREV);
  //    UnloadKeyboardLayout(KeybLay);
  //    end
  //  else
  //  begin

    //  if KeybLay<>0 then
  ////    UnloadKeyboardLayout(KeybLay);
  //    KeybLay:=LoadKeyboardLayout('00000409', KLF_ACTIVATE);
  //  end;
end;

function TransCodeEng2Rus(text: string): string;
var
  i, dx: integer;
  tmp: string;
begin
  tmp := text;

  dx := 1;
  //showmessage(inttostr(Pos('->',tmp)));
  if Pos('->', tmp) = 1 then
    dx := pos(':', tmp) + 1
  else if pos('/', tmp) = 1 then
    dx := pos(' ', tmp);

  for i := dx to length(tmp) do

    case tmp[i] of
      // ENG--RUS
      'q': tmp[i] := 'й';
      'w': tmp[i] := 'ц';
      'e': tmp[i] := 'у';
      'r': tmp[i] := 'к';
      't': tmp[i] := 'е';
      'y': tmp[i] := 'н';
      'u': tmp[i] := 'г';
      'i': tmp[i] := 'ш';
      'o': tmp[i] := 'щ';
      'p': tmp[i] := 'з';
      '[': tmp[i] := 'х';
      ']': tmp[i] := 'ъ';
      'a': tmp[i] := 'ф';
      's': tmp[i] := 'ы';
      'd': tmp[i] := 'в';
      'f': tmp[i] := 'а';
      'g': tmp[i] := 'п';
      'h': tmp[i] := 'р';
      'j': tmp[i] := 'о';
      'k': tmp[i] := 'л';
      'l': tmp[i] := 'д';
      ';': tmp[i] := 'ж';
      '''': tmp[i] := 'э';
      'z': tmp[i] := 'я';
      'x': tmp[i] := 'ч';
      'c': tmp[i] := 'с';
      'v': tmp[i] := 'м';
      'b': tmp[i] := 'и';
      'n': tmp[i] := 'т';
      'm': tmp[i] := 'ь';
      ',': tmp[i] := 'б';
      '.': tmp[i] := 'ю';
      '/': tmp[i] := '.';
      '\': tmp[i] := '\';
      '`': tmp[i] := 'ё';

      '@': tmp[i] := '"';
      '#': tmp[i] := '№';
      '$': tmp[i] := ';';
      '^': tmp[i] := ':';
      '&': tmp[i] := '?';

      'Q': tmp[i] := 'Й';
      'W': tmp[i] := 'Ц';
      'E': tmp[i] := 'У';
      'R': tmp[i] := 'К';
      'T': tmp[i] := 'Е';
      'Y': tmp[i] := 'Н';
      'U': tmp[i] := 'Г';
      'I': tmp[i] := 'Ш';
      'O': tmp[i] := 'Щ';
      'P': tmp[i] := 'З';
      '{': tmp[i] := 'Х';
      '}': tmp[i] := 'Ъ';
      'A': tmp[i] := 'Ф';
      'S': tmp[i] := 'Ы';
      'D': tmp[i] := 'В';
      'F': tmp[i] := 'А';
      'G': tmp[i] := 'П';
      'H': tmp[i] := 'Р';
      'J': tmp[i] := 'О';
      'K': tmp[i] := 'Л';
      'L': tmp[i] := 'Д';
      ':': tmp[i] := 'Ж';
      '"': tmp[i] := 'Э';
      'Z': tmp[i] := 'Я';
      'X': tmp[i] := 'Ч';
      'C': tmp[i] := 'С';
      'V': tmp[i] := 'М';
      'B': tmp[i] := 'И';
      'N': tmp[i] := 'Т';
      'M': tmp[i] := 'Ь';
      '<': tmp[i] := 'Б';
      '>': tmp[i] := 'Ю';
      '?': tmp[i] := ',';
      '~': tmp[i] := 'Ё';

    end;

  Result := tmp;
  //      showmessage(inttostr(GetKeyboardLayout(0)));

//for i:=0 to 5 do
//begin

//w

  i := 0;
  while (GetKeyboardLayout(0) <> 68748313) or (i < 5) do
  begin
    ActivateKeyboardLayout(0, HKL_NEXT);
    inc(i);
  end;

end;

function TransCodeRus2Eng(text: string): string;
var
  i, dx: integer;
  tmp: string;
begin
  tmp := text;

  dx := 1;
  //showmessage(inttostr(Pos('->',tmp)));
  if Pos('->', tmp) = 1 then
    dx := pos(':', tmp) + 1
  else if pos('/', tmp) = 1 then
    dx := pos(' ', tmp);

  for i := dx to length(tmp) do

    case tmp[i] of

      // RUS==ENG
      'й': tmp[i] := 'q';
      'ц': tmp[i] := 'w';
      'у': tmp[i] := 'e';
      'к': tmp[i] := 'r';
      'е': tmp[i] := 't';
      'н': tmp[i] := 'y';
      'г': tmp[i] := 'u';
      'ш': tmp[i] := 'i';
      'щ': tmp[i] := 'o';
      'з': tmp[i] := 'p';
      'х': tmp[i] := '[';
      'ъ': tmp[i] := ']';
      'ф': tmp[i] := 'a';
      'ы': tmp[i] := 's';
      'в': tmp[i] := 'd';
      'а': tmp[i] := 'f';
      'п': tmp[i] := 'g';
      'р': tmp[i] := 'h';
      'о': tmp[i] := 'j';
      'л': tmp[i] := 'k';
      'д': tmp[i] := 'l';
      'ж': tmp[i] := ';';
      'э': tmp[i] := '''';
      'я': tmp[i] := 'z';
      'ч': tmp[i] := 'x';
      'с': tmp[i] := 'c';
      'м': tmp[i] := 'v';
      'и': tmp[i] := 'b';
      'т': tmp[i] := 'n';
      'ь': tmp[i] := 'm';
      'б': tmp[i] := ',';
      'ю': tmp[i] := '.';
      '.': tmp[i] := '/';
      '\': tmp[i] := '\';
      'ё': tmp[i] := '`';

      '"': tmp[i] := '@';
      '№': tmp[i] := '#';
      ';': tmp[i] := '$';
      ':': tmp[i] := '^';
      '?': tmp[i] := '&';

      'Й': tmp[i] := 'Q';
      'Ц': tmp[i] := 'W';
      'У': tmp[i] := 'E';
      'К': tmp[i] := 'R';
      'Е': tmp[i] := 'T';
      'Н': tmp[i] := 'Y';
      'Г': tmp[i] := 'U';
      'Ш': tmp[i] := 'I';
      'Щ': tmp[i] := 'O';
      'З': tmp[i] := 'P';
      'Х': tmp[i] := '{';
      'Ъ': tmp[i] := '}';
      'Ф': tmp[i] := 'A';
      'Ы': tmp[i] := 'S';
      'В': tmp[i] := 'D';
      'А': tmp[i] := 'F';
      'П': tmp[i] := 'G';
      'Р': tmp[i] := 'H';
      'О': tmp[i] := 'J';
      'Л': tmp[i] := 'K';
      'Д': tmp[i] := 'L';
      'Ж': tmp[i] := ':';
      'Э': tmp[i] := '"';
      'Я': tmp[i] := 'Z';
      'Ч': tmp[i] := 'X';
      'С': tmp[i] := 'C';
      'М': tmp[i] := 'V';
      'И': tmp[i] := 'B';
      'Т': tmp[i] := 'N';
      'Ь': tmp[i] := 'M';
      'Б': tmp[i] := '<';
      'Ю': tmp[i] := '>';
      ',': tmp[i] := '?';
      'Ё': tmp[i] := '~';

    end;

  Result := tmp;

  i := 0;
  while (GetKeyboardLayout(0) <> 67699721) or (i < 5) do
  begin
    ActivateKeyboardLayout(0, HKL_NEXT);
    inc(i);
  end;

  //      showmessage(inttostr(GetKeyboardLayout(0)));
  //      if GetKeyboardLayout(0)=67699721 then
  //      LoadKeyboardLayout('00000419', KLF_ACTIVATE) else
//  UnloadKeyboardLayout(0);
//  Keyblay:=LoadKeyboardLayout('00000409', KLF_ACTIVATE);
//KLF_ACTIVATE
end;

procedure TfmMain.edTopicKeyPress(Sender: TObject; var Key: Char);
begin
  /// This is event!;
  if key = #13 then
  begin
    key := #0;
    //SendData('T'+ChatSet.CurNick+#0+edTopic.Text+' ('+ChatSet.CurNick+')'+#0+ChatSet.CurSex);
    ReturnFocus;
    //edTopic.Free;
  end; // else
  //if key=#27 then ReturnFocus;

end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
//  CloseHandle(MemHnd);
  WriteSettings;
  MsgData.Free;
  txtHist.free;
  Name_Room.Free;
  IP_Room.Free;

  Name_Private.Free;
  IP_Private.Free;

  Name_Msg.Free;
  IP_Msg.Free;

  BoardData.Free;
  BoardNick.free;
  DestroySocket;
  Cipher.Free;
  UCPlugins.Free;

  if isProtectEnabled then
    AntiFloodPacket.Free;
{$IFDEF ACTIONEMU}
  FNewMenuActions.Free;
{$ENDIF}

  CloseHandle(MemHnd);
end;

procedure TfmMain.mainSmileClick(Sender: TObject);
var
  prfx, tmp: string;
  pos: TPoint;
begin
  prfx := '';

  case pmSmiles.Tag of
    0:
      begin
        {        if edText.Text <> '' then
                  if edtext.Text[length(edtext.Text) - 1] <> ' ' then
                    prfx := ' ';
                edtext.Text := edtext.Text + prfx + (sender as TMenuItem).Caption + ' ';
                SendKey(edText.Handle, Chr($23));
                returnfocus;}

        pos := edText.CaretPos;

        tmp := edText.Lines.Strings[pos.y];

        prfx := copy(tmp, 1, pos.X);

        if prfx <> '' then
          if prfx[length(prfx)] <> ' ' then
            prfx := prfx + ' ';

        if edText.Lines.Count = 0 then
          edText.Lines.Add((sender as TMenuItem).Caption + ' ')
        else
          edText.Lines.Strings[pos.y] := prfx + (sender as
            TMenuItem).Caption + ' ' + copy(tmp, pos.X + 1, length(tmp));

        edText.CaretPos := pos;

        SendKey(edText.Handle, Chr($23));

      end;
    1:
      begin

        pos := fmSend.mmMain.CaretPos;

        tmp := fmSend.mmMain.Lines.Strings[pos.y];

        prfx := copy(tmp, 1, pos.X);

        if prfx <> '' then
          if prfx[length(prfx)] <> ' ' then
            prfx := prfx + ' ';

        if fmSend.mmMain.Lines.Count = 0 then
          fmSend.mmMain.Lines.Add((sender as TMenuItem).Caption + ' ')
        else
          fmSend.mmMain.Lines.Strings[pos.y] := prfx + (sender as
            TMenuItem).Caption + ' ' + copy(tmp, pos.X + 1, length(tmp));

        fmSend.mmMain.CaretPos := pos;

        SendKey(fmSend.mmMain.Handle, Chr($23));
        fmSend.bbSend.Enabled := True;
      end;

    2:
      begin
        pos := fmMassSend.mmMain.CaretPos;

        tmp := fmMassSend.mmMain.Lines.Strings[pos.y];

        prfx := copy(tmp, 1, pos.X);

        if prfx <> '' then
          if prfx[length(prfx)] <> ' ' then
            prfx := prfx + ' ';

        if fmMassSend.mmMain.Lines.Count = 0 then
          fmMassSend.mmMain.Lines.Add((sender as TMenuItem).Caption + ' ')
        else
          fmMassSend.mmMain.Lines.Strings[pos.y] := prfx + (sender as
            TMenuItem).Caption + ' ' + copy(tmp, pos.X + 1, length(tmp));

        fmMassSend.mmMain.CaretPos := pos;
        SendKey(fmMassSend.mmMain.Handle, Chr($23));
        fmMassSend.bbSend.Enabled := True;
      end;
  end;
  pmSmiles.Tag := 0;
end;

procedure TfmMain.sbpMainPanels4Click(Sender: TObject);
{var
pnt: TPoint;}
begin
  {pnt.X:=sbpMain.panels[0].Width+sbpMain.panels[1].Width+sbpMain.panels[2].Width;
  pnt.Y:=sbpMain.Height;
  pmLink.Popup(sbpMain.ClientToScreen(pnt).X,sbpMain.ClientToScreen(pnt).Y);}

  N1.Click;
end;

procedure TfmMain.sbpMainPanels0Click(Sender: TObject);
var
  pnt: TPoint;
begin
  pmSmiles.Tag := 0;
  pnt.X := 0;
  pnt.Y := sbpMain.Height;
  //sbpMain.Panels[0].
  pmSmiles.Popup(sbpMain.ClientToScreen(pnt).X, sbpMain.ClientToScreen(pnt).Y);
  //pmSmiles.Popup(0,fmMain.Height);
end;

procedure TfmMain.sbpMainPanels1Click(Sender: TObject);
var
  pnt: TPoint;
begin
  pnt.X := sbpMain.panels[0].Width;
  pnt.Y := sbpMain.Height;
  //sbpMain.Panels[0].
  pmCommand.Popup(sbpMain.ClientToScreen(pnt).X, sbpMain.ClientToScreen(pnt).Y);
  //pmSmiles.Popup(0,fmMain.Height);
end;

procedure TfmMain.lvUserKeyPress(Sender: TObject; var Key: Char);
var
  pos: TPoint;
begin
  //SendKey(edText.Handle,key);
  edText.Text := edText.Text + Trim(key);

  pos.Y := edText.CaretPos.Y;
  pos.X := length(edText.Lines.strings[pos.y]);
  edText.CaretPos := pos;

  //  SendKey(edText.Handle, Chr($23));
  //  edText.SetBounds(0,0,0,0);

  key := #0;
  //  if (sender is TRichView) then (sender as Trichview).Perform(WM_KILLFOCUS,0,0);
  ReturnFocus;
end;

procedure TfmMain.TimerFlashTimer(Sender: TObject);
begin
  if ct1.IconIndex <> 5 then
    ct1.IconIndex := 5
  else
    ct1.IconIndex := ord(curmode) - 48;

end;

procedure TfmMain.N51Click(Sender: TObject);
begin
  //(sender as (TmenuItem)).Checked := not (sender as (TmenuItem)).Checked;
end;

procedure TfmMain.ct1Startup(Sender: TObject; var ShowMainForm: Boolean);
begin


  ReadSettings;


  if aStartMinim.Checked then
  begin
    ShowMainForm := False;
    ct1.HideTaskbarIcon;
  end;

  ReadNicksCombo;
end;

procedure TfmMain.edTextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{$IFDEF UNICODERSNET}
var
  pos: TPoint;
{$ENDIF}
begin
  // on key down - smaller visual latency
  //if edText.Lines.Count<=1 then

  case key of
    38:
      if (ssAlt in Shift) then
      begin
        if (lvUser.ItemIndex = 0) or (lvUser.SelCount = 0) then
          lvUser.ItemIndex := lvUser.Items.Count - 1
        else
          lvUser.ItemIndex := lvUser.ItemIndex - 1;
      end
      else if (ssCtrl in Shift) then
{$IFDEF UNICODERSNET}
      begin
        pos := edText.CaretPos;
        dec(pos.y);
        if pos.y > -1 then
          edText.CaretPos := pos;
      end
      else
{$ENDIF}
      begin
        Key := 0;
        if txtPos > 0 then
        begin
          dec(txtPos);
          edText.Text := TrimRight(txthist.Strings[txtpos]);
          SendKey(edText.Handle, Chr($23));
        end
        else
        begin
          edText.Text := '';
        end;
      end;

    40:
      if (ssAlt in Shift) then
      begin
        if (lvUser.ItemIndex = lvUser.Items.Count - 1) or (lvUser.SelCount = 0)
          then
          lvUser.ItemIndex := 0
        else
          lvUser.ItemIndex := lvUser.ItemIndex + 1;
      end
      else if (ssCtrl in Shift) then
{$IFDEF UNICODERSNET}
      begin
        pos := edText.CaretPos;
        inc(pos.y);
        if pos.y < edText.Lines.Count then
          edText.CaretPos := pos;
      end
      else
{$ENDIF}
      begin

        if txtpos < txtHist.count then
        begin
          Key := 0;
          edText.Text := TrimRight(txthist.Strings[txtpos]);
          inc(txtpos);
          SendKey(edText.Handle, Chr($23));
        end
        else
          edText.Text := '';

      end;

    {    34:
          begin
            pos := edText.CaretPos;
            inc(pos.y);
            if pos.y < edText.Lines.Count then
              edText.CaretPos := pos;
          end;
        33:
          begin
            pos := edText.CaretPos;
            dec(pos.y);
            if pos.y > -1 then
              edText.CaretPos := pos;
          end;}

  end;

  //  showmessage(inttostr(Ord(key)));

end;

procedure TfmMain.TimerFlashScrTimer(Sender: TObject);
begin
  slState.ScrollLock := not slState.ScrollLock;
end;

procedure TfmMain.pmTrayPopup(Sender: TObject);
var
  mi: TMenuItem;
  i: integer;
begin

  if fmMain.Visible then
    miRestore.Caption := 'Свернуть'
  else
    miRestore.Caption := 'Восстановить';

  miMsg.Clear;

  for I := 0 to lvUser.Items.Count - 1 do
  begin
    mi := TMenuItem.Create(miMsg);
    mi.Caption := lvUser.Items.Item[i].Caption;
    mi.ImageIndex := lvUser.Items.Item[i].ImageIndex;
    mi.OnClick := msgHandler;
    miMsg.Add(mi);
  end;

  //mi.Free;

end;

procedure TfmMain.miRestoreClick(Sender: TObject);
begin
  ct1DblClick(sender);
end;

procedure TfmMain.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin

  //LogFileOutput('C:\LOG.TXT','ENDSESSION!->!!!');
  //UDPServer.Active:=False;

  StopServer;
{$IFNDEF NOENTEREXIT}
  SendData('l' + CurNick + #0 + CurSex, '*');
{$ENDIF}
  SendExit;
  WriteSettings;
  Msg.Result := 1;
end;

procedure TfmMain.TopMainExit(Sender: TObject);
begin
  //  edTopic.Free;
  ReturnFocus;
end;

procedure TfmMain.createTab(TabName: string; IconIndex: integer);
var
  newSheet: TTabSheet;
  newMemo: TRichView;
  i {,z}: integer;
begin
  //z:=pg1.ActivePageIndex;
  if IsPagePresent(TabName) = -1 then
  begin
    for i := 0 to pg1.PageCount - 1 do
      if pg1.Pages[i].Caption = TabName then
        exit;
    newSheet := TTabSheet.Create(pg1);
    newsheet.PageControl := pg1;
    newSheet.ImageIndex := IconIndex;
    newSheet.Name := 'sheet' + inttostr(pages_cnt);
    newsheet.Caption := TabName;
    newsheet.Show;

    with edTopic.Items.Add do
    begin
      if IconIndex = 2 then
        text := 'Разговор с ' + TabName
      else
        text := TabName + ': ' + CurNick + SetMaleFemale(CurSex, 1) + ' [' +
          DateToStr(Now) + ' - ' + TimeToStr(Now) + ']';
      if iconindex = 4 then
        iconindex := 1;
      ImageIndex := iconindex;
    end;

    newMemo := TRichView.Create(newsheet);
    newmemo.Name := 'memo' + newsheet.name;
    newmemo.Parent := newsheet;
    newmemo.Align := alClient;
    NewMemo.Style := RVStyle;
    newMemo.HScrollVisible := False;
    newmemo.Color := rvstyle.TextStyles[0].BackColor;
    newmemo.PopupMenu := pmRE;
    newmemo.OnKeyPress := lvUserKeyPress;
    newmemo.OnRVMouseUp := rvMainRVMouseUp;
    newmemo.OnJump := rvMain.OnJump;
    //newmemo.OnMouseMove := rvMainMouseMove;
    newMemo.OnRVDblClick := rvMainRVDblClick;
    newmemo.Delimiters := rvMain.Delimiters;
    newmemo.Options := rvMain.Options;
    newmemo.TabNavigation := rvtnNone;
    newmemo.Format;
    inc(pages_cnt);
    edTopic.ItemIndex := pg1.ActivePage.PageIndex;
    //pg1.OnChange(Self);
  end;
  //pg1.ActivePageIndex:=z;
end;

procedure TfmMain.miMessageClick(Sender: TObject);
begin
  if lvUser.SelCount > 0 then
  begin
    if aMsgInMain.Checked then
    begin
      edText.Text := '/msg /' + lvUser.Selected.Caption + ' ' + edText.Text;
      ReturnFocus;
      SendKey(edText.Handle, Chr($23));
      if NotifyUserTyping then
      begin
        SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
          lvUser.Selected.SubItems.Strings[0],
          lvUser.Selected.SubItems.Strings[0]);
        TimerWriteOut.Enabled := True;
      end;
    end
    else
      miSendMessage(lvUser.Selected.Caption,
        lvUser.Selected.SubItems.Strings[0]);

  end;
end;

procedure TfmMain.lvUserDblClick(Sender: TObject);
begin
  if lvUser.SelCount > 0 then
  begin

    if (length(edText.Text) > 1) and (edText.Text[1] = '/') then
    begin
      if edText.Text[length(edText.Text)] = ' ' then
        edText.Text := edText.Text + '/' + lvUser.Selected.Caption + ' '
      else
        edText.Text := edText.Text + ' /' + lvUser.Selected.Caption + ' ';
      SendKey(edText.Handle, Chr($23));
      ReturnFocus;
    end
    else
      miMessageClick(sender);

  end
  else
  begin
    TimerAF.enabled := True;
    fmMain.enabled := False;
    miMassMsg.Click;
  end;
end;

procedure TfmMain.pg1Change(Sender: TObject);
var
  z: integer;
begin
  z := pg1.Pages[pg1.ActivePageIndex].ImageIndex;

  if z in [1, 3, 5, 7] then
    pg1.Pages[pg1.ActivePageIndex].ImageIndex := z - 1;

  {if pg1.ActivePage.ImageIndex=2 then
  edTopic.Text:='Разговор с '+pg1.ActivePage.Caption else
  }
  edTopic.ItemIndex := pg1.ActivePage.PageIndex;

  edTopic.Hint := edTopic.Items[edTopic.ItemIndex].text;

  ReturnFocus;
end;

procedure TfmMain.N54Click(Sender: TObject);
begin
  if pg1.ActivePageIndex = 0 then
  begin
    if MessageDlg('Вы действительно хотите выйти из чата?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
      miExit.Click;
  end
  else
  begin
    SendData('x' + pg1.ActivePage.Caption + #0 + CurNick + #0 + CurSex, '*');
    edTopic.Items[pg1.ActivePage.PageIndex].Free;
    pg1.ActivePage.Free;
    pg1.OnChange(self);
  end;
end;

procedure TfmMain.miMassMsgClick(Sender: TObject);
begin
  fmMassSend := TfmMassSend.Create(nil);
  fmMassSend.lvRec.Items.Assign(lvUser.Items);
  fmMassSend.lvRec.FindCaption(-1, CurNick, False, False, False).checked :=
    False;
  //if fmMassSend.lvRec.Items.Count>0 then
  fmMassSend.mmMain.Color := rvMain.Color;
  fmMassSend.mmMain.Font.Color := RVStyle.TextStyles.Items[0].Color;

  fmMassSend.lvRec.Color := rvMain.Color;
  fmMassSend.lvRec.Font.Color := RVStyle.TextStyles.Items[0].Color;
  fmMassSend.lvRec.Font.Color := RVStyle.TextStyles.Items[0].Color;
  fmMassSend.lvRec.Font.Name := RVStyle.TextStyles.Items[0].FontName;
  fmMassSend.lvRec.Font.Style := RVStyle.TextStyles.Items[0].Style;
  fmMassSend.lvRec.Font.Size := RVStyle.TextStyles.Items[0].size;

  fmMassSend.mmMain.Font.Color := RVStyle.TextStyles.Items[0].Color;
  fmMassSend.mmMain.Font.Name := RVStyle.TextStyles.Items[0].FontName;
  fmMassSend.mmMain.Font.Style := RVStyle.TextStyles.Items[0].Style;
  fmMassSend.mmMain.Font.Size := RVStyle.TextStyles.Items[0].size;

  fmMassSend.Show

  {else
begin
showmessage('Никого кроме Вас в чате нет!');
fmMassSend.Close;
end;}

end;

procedure TfmMain.pmUserPopup(Sender: TObject);
begin
  if lvUser.SelCount <= 0 then
  begin
    miMessage.Visible := False;
    miSignal.Visible := False;
    miInfo.Visible := False;
    miSay.Visible := False;
    miTalk.Visible := False;
//    miMsg.Visible := False;
    miFilter.Visible := False;
    N4.Visible := False;
    N27.Visible := False;
  end
  else
  begin
    miMessage.Visible := True;
    miSignal.Visible := True;
    miInfo.Visible := True;
    miSay.Visible := True;
    miTalk.Visible := True;
//    miMsg.Visible := True;
    N4.Visible := True;
    N27.Visible := True;
    miFilter.Visible := True
  end;

end;

procedure TfmMain.miTXTClick(Sender: TObject);
var
  CurRE: TRichView;
begin
  os1.DefaultExt := 'txt';
  os1.FilterIndex := 1;
  if os1.Execute then
  begin
    if pg1.ActivePageIndex = 0 then
    begin
      rvMain.SaveText(ChangeFileExt(os1.FileName, '.txt'), 80);
      //rvMain.SaveRTF(ChangeFileExt(os1.FileName,'.rtf'),False);
    end
    else
    begin
      CurRE := (pg1.Pages[pg1.ActivePageIndex].FindComponent('memo' +
        pg1.Pages[pg1.ActivePageIndex].name) as TRichView);
      CurRE.SaveText(ChangeFileExt(os1.FileName, '.txt'), 80);
      //CurRE.SaveRTF(ChangeFileExt(os1.FileName,'.rtf'),False);
      //AddTextToPage(pg1.ActivePage.Caption,'Окно очищено',chatset.clWelcome);

    end;

  end;
end;

procedure TfmMain.miSendMessage(const toUser, UserID: string);
var
  i: integer;
begin

  for i := 0 to Screen.FormCount - 1 do
    if screen.Forms[i] is TfmSend then
      if (screen.Forms[i] as TfmSend).ReceiverID = UserID then
      begin
        (screen.Forms[i] as TfmSend).SetFocus;
        exit;
      end;

  fmSend := TFmSend.Create(nil);
  fmSend.ReceiverNick := toUser;
  fmSend.ReceiverID := UserID;
  fmSend.Caption := '-> ' + toUser;
  fmSend.mmMain.Color := rvMain.Color;
  fmSend.mmMain.Font.Color := RVStyle.TextStyles.Items[0].Color;
  fmSend.mmMain.Font.Name := RVStyle.TextStyles.Items[0].FontName;
  fmSend.mmMain.Font.Style := RVStyle.TextStyles.Items[0].Style;
  fmSend.mmMain.Font.Size := RVStyle.TextStyles.Items[0].size;
  fmSend.Show;
  TimerAF.enabled := True;
  fmMain.enabled := False;

{  if NotifyUserTyping then
  begin
    SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
      UserID, UserID);
    fmMain.TimerWriteOut.Enabled := True;
  end;}

end;

procedure TfmMain.msgHandler(Sender: TObject);
var
  i: integer;
begin
  i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, (Sender as
    TMenuItem).Caption, False, False, False));
  if i <> -1 then
  begin
    miSendMessage((Sender as TMenuItem).Caption,
      lvUser.Items.Item[i].SubItems.Strings[0]);
  end;
end;

procedure TfmMain.sbpMainPanels2Click(Sender: TObject);
var
  pnt: TPoint;
begin
  pnt.X := sbpMain.panels[0].Width + sbpMain.panels[1].Width;
  pnt.Y := sbpMain.Height;
  //sbpMain.Panels[0].
  pmMacros.Popup(sbpMain.ClientToScreen(pnt).X, sbpMain.ClientToScreen(pnt).Y);
  //pmSmiles.Popup(0,fmMain.Height);

end;

procedure TfmMain.miChangeCommentClick(Sender: TObject);
begin
end;

{
//AddTextToPage('Dentall','Hello',20);
// SendData('#'+'Dentall'+#0+'WAD'+#0+'Hello');
AddNick('Vir',0);
Addnick('WAD',10);
Addnick('Boss',0);
Addnick('Trof',0);
with chatset do
SendData('e'+CurNick+#0+CurMode+#0+'1'+#0+CurActive+#0+uHost2IP(uGetLocalHostName));
}

procedure TfmMain.TimerBaloonTimer(Sender: TObject);
begin
  ct1.HideBalloonHint;
  TimerBaloon.Enabled := False;
end;

procedure TfmMain.TimerFloodTimer(Sender: TObject);
{var
  atom: word;}
begin
{  if TimerFlood.Interval = 120000 then
  begin
    atom := GlobalFindAtom('FloodTimer');

    if Atom <> 0 then
      GlobalDeleteAtom(atom);
    SendData('4' + pg1.ActivePage.Caption + #0 + CurNick + #0 +
      SetMaleFemale(CurSex, 2) + 'из флуд тайм-аута', '*');
    TimerFlood.Interval := 5000;
    Inc(FloodScore, 3);
  end;}

  FloodScore := 2 * FloodScore;

  TimerFlood.Enabled := False;
end;

procedure TfmMain.N381Click(Sender: TObject);
var
  tmp: string;
  prfx: string;
begin
  prfx := '';
  if edText.Text <> '' then
    if edtext.Text[length(edtext.Text)] <> ' ' then
      prfx := ' ';
  tmp := (sender as TMenuItem).Caption;

  edText.Text := edText.Text + prfx + Parse(tmp, ' ');
  ReturnFocus;
  SendKey(edText.Handle, Chr($23));

end;

procedure TfmMain.URLScanEvent(OldStyleNo: Integer; var NewStyleNo: Integer;
  ToHypertext: Boolean);
//var Style: TFontInfo;
begin
  if ToHypertext then
  begin
    // Hypertext links will be blue and underlined
    NewStyleNo := 13;
  end;
end;

procedure TfmMain.rvMainJump(Sender: TObject; id: Integer);
var
  RVData: TCustomRVFormattedData;
  ItemNo: Integer;
  tmp: string;
  thread: TExecuteURLThread;
begin
  (sender as TrichView).GetJumpPointLocation(id, RVData, ItemNo);

  tmp := AnsiLowerCase(ExtractFileExt(RVData.GetItemTextA(ItemNo)));
  if (tmp = '.exe') or
    (tmp = '.cmd') or
    (tmp = '.com') or
    (tmp = '.bat') or
    (tmp = '.vbs') then
    if MessageDlg('Расширение файла - "' + tmp + '"' + #13 +
      'Открытие этого файла потенциально небезопасно. Все равно продолжить?',
      mtConfirmation,
      [mbYes, mbNo], 0) = mrNo then
      exit;

  begin
    thread := TExecuteURLThread.Create(True);
    thread.FreeOnTerminate := True;
    thread.Priority := tpLower;
    thread.url := RVData.GetItemTextA(ItemNo);
    thread.Resume;
  end;
end;

procedure TfmMain.rvMainRVMouseUp(Sender: TCustomRichView;
  Button: TMouseButton; Shift: TShiftState; ItemNo, X, Y: Integer);
var
  pos: TPoint;
  sltxt, tmp, prfx: string;
begin
  if button = mbLeft then
  begin

    Sender.Copy;
    sltxt := sender.GetSelText;

    if sender.itemcount > 0 then
      Sender.SetSelectionBounds(0, 0, 0, 0);

    ReturnFOcus;

    if ssCtrl in Shift then
    begin

      pos := edText.CaretPos;

      tmp := edText.Lines.Strings[pos.y];

      prfx := copy(tmp, 1, pos.X);

      if prfx <> '' then
        if prfx[length(prfx)] <> ' ' then
          prfx := prfx + ' ';

      if edText.Lines.Count = 0 then
        edText.Lines.text := sltxt
      else
        edText.Lines.Strings[pos.y] := prfx + sltxt + ' ' + copy(tmp, pos.X + 1,
          length(tmp));

      edText.CaretPos := pos;

      SendKey(edText.Handle, Chr($23));
    end;

  end;
end;

procedure TfmMain.RTF1Click(Sender: TObject);
var
  CurRE: TRichView;
begin

  os1.FilterIndex := 2;
  os1.DefaultExt := 'rtf';
  if os1.Execute then
  begin
    if pg1.ActivePageIndex = 0 then
    begin
      //rvMain.SaveText(ChangeFileExt(os1.FileName,'.txt'),80);
      rvMain.SaveRTF(ChangeFileExt(os1.FileName, '.rtf'), False);
    end
    else
    begin
      CurRE := (pg1.Pages[pg1.ActivePageIndex].FindComponent('memo' +
        pg1.Pages[pg1.ActivePageIndex].name) as TRichView);
      //CurRE.SaveText(ChangeFileExt(os1.FileName,'.txt'),80);
      CurRE.SaveRTF(ChangeFileExt(os1.FileName, '.rtf'), False);
      //AddTextToPage(pg1.ActivePage.Caption,'Окно очищено',chatset.clWelcome);

    end;

  end;

end;

procedure TfmMain.lvUserInfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
begin
  if aShowInfo.Checked then
    infotip := 'Компьютер:'#32 + ExtractUserComp(item.SubItems.Strings[0]) + #13
      +
      'IP адрес:'#32 + ExtractUserIP(item.SubItems.Strings[0])
  else
    infotip := '';
end;

procedure TfmMain.meIgnoreMainClick(Sender: TObject);
begin
  if Name_Room.IndexOf(lvUser.Selected.Caption) = -1 then
    Name_Room.Add(lvUser.Selected.Caption);
end;

procedure TfmMain.miIngnorePrivClick(Sender: TObject);
begin
  if Name_Private.IndexOf(lvUser.Selected.Caption) = -1 then
    Name_Private.Add(lvUser.Selected.Caption);
end;

procedure TfmMain.miIngnorMsgClick(Sender: TObject);
begin
  if Name_Msg.IndexOf(lvUser.Selected.Caption) = -1 then
    Name_Msg.Add(lvUser.Selected.Caption);
end;

procedure TfmMain.N92Click(Sender: TObject);
begin
  if IP_Room.IndexOf(lvUser.Selected.Caption) = -1 then
    IP_Room.Add(ExtractUserIP(lvUser.Selected.SubItems.Strings[0]));
end;

procedure TfmMain.N94Click(Sender: TObject);
begin
  if IP_Private.IndexOf(lvUser.Selected.Caption) = -1 then
    IP_Private.Add(ExtractUserIP(lvUser.Selected.SubItems.Strings[0]));
end;

procedure TfmMain.N97Click(Sender: TObject);
begin
  if IP_Msg.IndexOf(lvUser.Selected.Caption) = -1 then
    IP_Msg.Add(ExtractUserIP(lvUser.Selected.SubItems.Strings[0]));
end;

procedure TfmMain.N100Click(Sender: TObject);
begin
  InputQuery('Автоответ игнорируемым по приватам', 'Введите текст', AutoPrivate)
end;

procedure TfmMain.N99Click(Sender: TObject);
begin
  InputQuery('Автоответ игнорируемым по сообщениям', 'Введите текст',
    AutoMessage)
end;

procedure TfmMain.miBoardDelSelfClick(Sender: TObject);
begin
  myBoard := '';
  SendData('Д' + Curnick + #0, '*');
end;

procedure TfmMain.miBoardCopyAllClick(Sender: TObject);
begin
  rvBoard.SelectAll;
  rvBoard.CopyText;
  if rvBoard.ItemCount > 0 then
    rvBoard.SetSelectionBounds(0, 0, 0, 0);
  ReturnFOcus;
end;

procedure TfmMain.miBoardCopySelfClick(Sender: TObject);
var
  tmp: string;
  pos: TPoint;
begin

  pos := edtext.CaretPos;
  tmp := edtext.Text;

  edtext.Text := myboard;
  edText.SelectAll;
  edText.CopyToClipboard;

  edText.Text := tmp;
  edtext.CaretPos := pos;
  ReturnFocus;

end;

procedure TfmMain.miRefreshClick(Sender: TObject);
begin
  SendData('У', '*');
end;

procedure TfmMain.rvMainRVDblClick(Sender: TCustomRichView;
  ClickedWord: string; Style: Integer);
var
  i: integer;
begin
  for i := 0 to lvUser.Items.Count - 1 do
    if AnsiPos(ClickedWord, lvUser.Items.Item[i].Caption) > 0 then
    begin
      edText.Text := '-> ' + lvUser.Items.Item[i].Caption + ': ' + edText.Text;
      SendKey(edText.Handle, Chr($23));
      Sender.SetSelectionBounds(0, 0, 0, 0);
      edText.SetFocus;
      break;
    end;
end;

procedure TfmMain.ClientConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if (client.tag >= 0) and ShowErrorMessage then
    AddTextToMain('Соединение с ' + DedicatedIP + ':' + inttostr(portDedic) +
      '...', 0);

end;

procedure TfmMain.ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  TimerRecoonect.Interval := 3000;
  AddTextToMain('Соединение разорвано', 20);
  if Auto2Broad then
    AddTextToMain('Повторная попытка через 3 секунды... Попыток до перехода на широковещание: '
      + inttostr(Client.Tag), 1)
  else
    AddTextToMain('Повторная попытка через 3 секунды...', 20);

  client.Active := False;
  TimerRecoonect.Enabled := True;

  sbTotal.Panels[0].Text := '  Всего: ?';
  lvUser.Clear;
end;

procedure TfmMain.ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  i: integer;
begin
  StopServer;
  TimerRecoonect.Enabled := False;
  TimerRecoonect.Interval := 3000;
  DestroySocket;

  Client.Tag := 3;
  IsServer := True;
  //DataWrite:=True;
  AddTextToMain('Соединение установлено', 1);
  ShowErrorMessage := True;
{$IFNDEF NOENTEREXIT}
  SendData('e' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, '*');
{$ENDIF}
  //sleep(100);
  SendData('g' + CurNick, '*');
  //sleep(100);
  RefreshList;
  //sleep(100);
  SendData('У', '*');
  //sleep(100);
  ReadRoomsMainPage;

  pg1.ActivePageIndex := 0;
  //if DefaultRoom='Основной' then  else
  for i := 1 to pg1.PageCount - 1 do
    if DefaultRoom = pg1.Pages[i].Caption then
    begin
      pg1.ActivePageIndex := i;
      break;
    end;
  edTopic.ItemIndex := pg1.ActivePage.PageIndex;
  //  socket.LocalPort := socket.LocalPort+1;
  //AddTextToMain(inttostr(socket.LocalPort),4);
end;

procedure TfmMain.ClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if (Client.Tag >= 0) and Auto2Broad and (isServer) then
  begin

    if Auto2Broad then
    begin
      if ShowErrorMessage then
        AddTextToMain('Ожидание соединения или перехода на широковещание...', 1);
      sbTotal.Panels[0].Text := '  Всего: ?';
      lvUser.Clear;
      ShowErrorMessage := False;
    end;

  end

  else if (not Auto2Broad) and isServer then
  begin
    TimerRecoonect.Interval := 3000;
    //AddTextToMain('Ошибка соединения: ' + inttostr(ErrorCode) + '...', 20);
    if ShowErrorMessage then
      AddTextToMain('Ошибка соединения. Ожидание ответа сервера...', 1);
    Client.Tag := 3;
    sbTotal.Panels[0].Text := '  Всего: ?';
    lvUser.Clear;
    ShowErrorMessage := False;
  end;

  TimerRecoonect.Enabled := True;

  ErrorCode := 0;
end;

procedure processData2(sData: array of char; Len: integer);
var
  i, c: integer;
  s, s1: string;
  tmp: char;
  sample: array[1..9] of char;
begin
  ///sData:=copy(sData,1,len);
  i := -1;
  for c := 1 to len - 13 do
  begin
    move(sData[c], sample[1], 9);
    if sample = #0'UniChat'#0 then
    begin
      i := c;
      break;
    end;
  end;

  if i > 0 then
  begin
    move(sData[i + 9], c, 4);
    s := StringOfChar(' ', c);
    move(sData[i + 15], s[1], c);

    tmp := s[5];
    move(s[1], i, 4);
    s := copy(s, 6, length(s) - 5);

    s1 := DynaKey(GroupKey, i);

    if isProtectEnabled then
      if AntiFloodPacket.PushPacket(i) then
      begin
        if NotifyBaloon then
          ShowBalloon(bsPacketFiltered, GetTimeStamp +
            ' обнаружена атака повторными пакетами', True);
        exit;
      end;

    Cipher.Init(s1[1], 96, nil);

    if tmp = '1' then
      s := UclDecompressStrA(Cipher.DecryptString(s))
    else
      s := Cipher.DecryptString(s);

    BreakString(s, length(s));
  end;
end;

procedure TfmMain.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  nPos, NewLen: integer;
  sTmp: array[1..65384] of char;
  bMore: boolean;
  sData: array[0..65384] of char;
  len: integer;
begin
  len := socket.ReceiveBuf(sData, sizeof(sData));

  bMore := true;
  while bMore do
  begin
    if packetparted then
    begin
      move(sdata, sdata[packetpartlen], len);
      move(packetpart, sdata, packetpartlen);
      packetparted := false;
      len := packetpartlen + len;
    end;
    for nPos := 1 to len do
    begin
      if sData[nPos] = #0 then
        break;
    end;
    NewLen := strtoint(copy(sdata, 1, npos)) + npos + 1;
    if Len > NewLen then
    begin
      move(sdata, stmp, newlen);
      ProcessData2(stmp, newlen);
      len := len - newlen;
      move(sData[NewLen], sData[0], len);
    end
    else
    begin
      if len = newlen then
        ProcessData2(sData, Len)
      else
      begin
        packetparted := true;
        move(sdata, packetpart, len);
        packetpartlen := len;
      end;
      bMore := false;
    end;
  end;
end;

procedure TfmMain.TimerRecoonectTimer(Sender: TObject);

begin
  TimerRecoonect.Enabled := False;
  client.Active := False;
  Client.Tag := Client.Tag - 1;

  if (Client.Tag = 0) and Auto2Broad then
  begin
    AddTextToMain('Переход на широковещание... aдрес: ' + BroadcastIP + ':' +
      Port + '...', 1);
    IsServer := False;
    if not inited then
    begin
      CreateSocket;
      Listen(strtoint(port), BroadcastIP, fmMain.Handle);
    end;
    SendData('e' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, '*');
    SendData('g' + CurNick, '*');
    RefreshList;
    SendData('У', '*');

    //Client.Tag := Client.Tag - 1;

    TimerRecoonect.Interval := 20000;
    TimerRecoonect.Enabled := True;
  end;

  client.Active := True;
end;

procedure TfmMain.apeException(Sender: TObject; E: Exception);
begin
   // WriteCache('__debug.txt', 'Chat crashed with message: ' + e.Message);
end;

procedure TfmMain.N1Click(Sender: TObject);
var
  prfx, tmp: string;
  pos: TPoint;
begin
  od1.InitialDir := '\\' + uGetLocalHostName;
  if od1.Execute then
  begin

    prfx := '';

    case fmMain.pmLink.Tag of
      0:
        begin
          if edText.Text <> '' then
          begin
            edText.Text := edText.Text + ' file:' + Space2percent(od1.FileName);
          end
          else
            edText.Text := 'file:' + Space2percent(od1.FileName);
          SendKey(edText.Handle, Chr($23));
        end;
      1:
        begin
          pos := fmSend.mmMain.CaretPos;
          tmp := fmSend.mmMain.Lines.Strings[pos.y];
          prfx := copy(tmp, 1, pos.X);
          if prfx <> '' then
            if prfx[length(prfx)] <> ' ' then
              prfx := prfx + ' ';
          if fmSend.mmMain.Lines.Count = 0 then
            fmSend.mmMain.Lines.Add('file:' + Space2percent(od1.FileName) + ' ')
          else
            fmSend.mmMain.Lines.Strings[pos.y] := prfx + 'file:' +
              Space2percent(od1.FileName) + ' ' + copy(tmp, pos.X + 1,
              length(tmp));
          fmSend.mmMain.CaretPos := pos;
          SendKey(fmSend.mmMain.Handle, Chr($23));
          fmSend.bbSend.Enabled := True;
        end;
      2:
        begin
          pos := fmMassSend.mmMain.CaretPos;
          tmp := fmMassSend.mmMain.Lines.Strings[pos.y];
          prfx := copy(tmp, 1, pos.X);
          if prfx <> '' then
            if prfx[length(prfx)] <> ' ' then
              prfx := prfx + ' ';
          if fmMassSend.mmMain.Lines.Count = 0 then
            fmMassSend.mmMain.Lines.Add('file:' + Space2percent(od1.FileName) +
              ' ')
          else
            fmMassSend.mmMain.Lines.Strings[pos.y] := prfx + 'file:' +
              Space2percent(od1.FileName) + ' ' + copy(tmp, pos.X + 1,
              length(tmp));
          fmMassSend.mmMain.CaretPos := pos;
          SendKey(fmMassSend.mmMain.Handle, Chr($23));
          fmMassSend.bbSend.Enabled := True;
        end;
    end;
    pmLink.Tag := 0;

  end;

end;

procedure TfmMain.N2Click(Sender: TObject);
var
  dir: string;
  prfx, tmp: string;
  pos: TPoint;
begin
  dir := '';
  if SelectDirectory('Select Directory', '\\' + uGetLocalHostName, dir) then
  begin
    prfx := '';

    case fmMain.pmLink.Tag of
      0:
        begin
          if edText.Text <> '' then
          begin
            edText.Text := edText.Text + ' ' + Space2percent(dir);
          end
          else
            edText.Text := Space2percent(dir);
          SendKey(edText.Handle, Chr($23));

        end;
      1:
        begin
          pos := fmSend.mmMain.CaretPos;
          tmp := fmSend.mmMain.Lines.Strings[pos.y];
          prfx := copy(tmp, 1, pos.X);
          if prfx <> '' then
            if prfx[length(prfx)] <> ' ' then
              prfx := prfx + ' ';
          if fmSend.mmMain.Lines.Count = 0 then
            fmSend.mmMain.Lines.Add(Space2percent(dir) + ' ')
          else
            fmSend.mmMain.Lines.Strings[pos.y] := prfx + Space2percent(dir) + ' '
              + copy(tmp, pos.X + 1, length(tmp));
          fmSend.mmMain.CaretPos := pos;
          SendKey(fmSend.mmMain.Handle, Chr($23));
          fmSend.bbSend.Enabled := True;
          fmSend.SetFocus;
        end;
      2:
        begin
          pos := fmMassSend.mmMain.CaretPos;
          tmp := fmMassSend.mmMain.Lines.Strings[pos.y];
          prfx := copy(tmp, 1, pos.X);
          if prfx <> '' then
            if prfx[length(prfx)] <> ' ' then
              prfx := prfx + ' ';
          if fmMassSend.mmMain.Lines.Count = 0 then
            fmMassSend.mmMain.Lines.Add(Space2percent(dir) + ' ')
          else
            fmMassSend.mmMain.Lines.Strings[pos.y] := prfx + Space2percent(dir)
              +
              ' ' + copy(tmp, pos.X + 1, length(tmp));
          fmMassSend.mmMain.CaretPos := pos;
          SendKey(fmMassSend.mmMain.Handle, Chr($23));
          fmMassSend.bbSend.Enabled := True;
        end;
    end;
    pmLink.Tag := 0;
  end;

end;

procedure TfmMain.TopicTimerTimer(Sender: TObject);
begin
  TopicTimer.Enabled := False;
end;

procedure TfmMain.edTopicChange(Sender: TObject);
var
  z: integer;
begin
  pg1.ActivePageIndex := edTopic.ItemIndex;
  z := pg1.Pages[pg1.ActivePageIndex].ImageIndex;
  if z in [1, 3, 5, 7] then
    pg1.Pages[pg1.ActivePageIndex].ImageIndex := z - 1;
  edTopic.Hint := edTopic.Items[edTopic.ItemIndex].text;
  ReturnFocus;
end;

procedure TfmMain.pmTopicPopup(Sender: TObject);
begin
  if (pg1.ActivePage.ImageIndex in [2, 3, 6, 7]) or TopicTimer.Enabled then
  begin
    miChangeTopic.Enabled := False;
    miRETopic.Enabled := False;
  end
  else
  begin
    miChangeTopic.Enabled := True;
    miRETopic.Enabled := True;
  end;
end;

procedure TfmMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  tmp, tmp1: TCOntrol;
  CurRE: TRichView;
  i: integer;
begin

  tmp := pg1.ControlAtPos(pg1.ScreenToClient(MousePos), False, True);
  if tmp <> nil then
  begin
    tmp1 := (tmp as TTabSheet).ControlAtPos((tmp as
      TTabSheet).ScreenToClient(mousepos), False, True);
    if tmp1 <> nil then
    begin
      CurRE := (tmp1 as TRichView);
      //      CurRE.SetFocus;
      //      CurRe.VScrollPos := CurRe.VScrollPos + WheelDelta;
      i := CurRe.VScrollPos;
      CurRE.SetFocus;
      CurRe.VScrollPos := i;
      //      CurRe.Perform()
      Handled := True;

    end;
  end
  else
  begin
    tmp := pnWind.ControlAtPos(pnWind.ScreenToClient(MousePos), False, True);
    if tmp <> nil then
    begin
      if aChangePageWheel.Checked then
      begin
        if wheeldelta > 0 then
          pg1.SelectNextPage(False, False)
        else
          pg1.SelectNextPage(True, False);
      end
      else
        pg1.ScrollTabs(-wheeldelta);

    end;

  end;

end;

procedure TfmMain.miByTimeClick(Sender: TObject);
begin
  AddTextToBoard('', '', '0');
end;

procedure TfmMain.TimerRepeatTimer(Sender: TObject);
begin
  TimerRepeat.Enabled := False;
end;

procedure TfmMain.TimerSpeedTimer(Sender: TObject);
begin
  Phrases := 0;
  TimerSpeed.Enabled := False;
end;

procedure TfmMain.TimerModeTimer(Sender: TObject);
begin
  TimerMode.Enabled := False;
end;

procedure TfmMain.TimerRenameTimer(Sender: TObject);
begin
  TimerRename.Enabled := False;
end;

procedure TfmMain.BoardTimerTimer(Sender: TObject);
begin
  BoardTimer.Enabled := False;
end;

procedure TfmMain.miAutoScrollClick(Sender: TObject);
var
  i: integer;
  CurRE: TRichView;

begin
  if miAutoScroll.Checked then
  begin
    rvMain.Options := rvMain.Options + [rvoScrollToEnd];

    for i := 1 to pg1.PageCount - 1 do
      if pg1.Pages[i].Name <> 'ttboard' then
      begin
        CurRE := (pg1.Pages[i].FindComponent('memo' + pg1.Pages[i].name) as
          TRichView);
        CurRE.Options := CurRE.Options + [rvoScrollToEnd];
      end;

  end
  else
  begin
    rvMain.Options := rvMain.Options - [rvoScrollToEnd];

    for i := 1 to pg1.PageCount - 1 do
      if pg1.Pages[i].Name <> 'ttboard' then
      begin
        CurRE := (pg1.Pages[i].FindComponent('memo' + pg1.Pages[i].name) as
          TRichView);
        CurRE.Options := CurRE.Options - [rvoScrollToEnd];
      end;
  end;
end;

procedure TfmMain.miDisableSmilesClick(Sender: TObject);
begin
  if (curMode = '4') and (aDisableSmilesGaming.Checked) then
    aDrawSmiles.checked := False
  else
    aDrawSmiles.checked := smilestate;
end;

procedure TfmMain.mmMainTalkClick(Sender: TObject);
{var
  mi: TMenuItem;
  i, z: integer;}
begin
{  z := 0;
  if miMacroses.count = 13 then
    miMacroses.Delete(12);
  for i := 0 to miMacroses.Count - 1 do
    if miMacroses.Items[i].Caption = '' then
    begin
      miMacroses.Items[i].Visible := False;
      inc(z);
    end
    else
      miMacroses.Items[i].Visible := True;

  if z = 12 then
  begin
    mi := TMenuItem.Create(miMacroses);
    mi.Caption := '(нет)';
    mi.Enabled := False;
    miMacroses.Add(mi);
  end;}
end;

procedure TfmMain.TimerUserActivityTimer(Sender: TObject);
var
  nsec: integer;
  lpi: tagLASTINPUTINFO;

begin
  if (CurMode = '0') or autoaway then
  begin

    lpi.cbSize := sizeof(lpi);
    GetLastInputInfoSELF(lpi);

    nsec := (GetTickCount - lpi.dwTime);
    if (nsec >= (TimerUserActivity.tag)) then
    begin
      if not autoaway then
      begin
        TimerUserActivity.Interval := 100;
        autoaway := True;
        CurMode := '2';

        ct1.IconIndex := ord(curmode) - 48;
        SetMode(CurMode);
        SendData('R' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive + #0
          + Format(AwayMessage, [(TimerUserActivity.tag) div 60000]), '*');
      end;
    end
    else if autoaway then
    begin
      TimerUserActivity.Interval := 10000;
      AutoAway := False;
      CurMode := '0';
      ct1.IconIndex := ord(curmode) - 48;
      SetMode(CurMode);
      SendData('R' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive + #0,
        '*');
    end;
  end;
  //AddTextToMain('No activity for '+inttostr(nsec)+' minutes',20);
end;

procedure SetBitampColor(var bmp: TBitmap; Selected: boolean);
var
  x, y: integer;
begin

  for y := 0 to bmp.Height do
    for x := 0 to bmp.Width do
      ///showmessage(inttostr(bmp.Canvas.Pixels[x,y]));
      if bmp.Canvas.Pixels[x, y] = 16644597 then
        if Selected then
          bmp.Canvas.Pixels[x, y] := clMenuHighlight
        else
          bmp.Canvas.Pixels[x, y] := clMenu;

end;

procedure TfmMain.bat1DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  bmp: TBitMap;
  Item: TMenuItem;
begin
  Item := (Sender as TMenuItem);
  bmp := TBitMap.Create;
  bmp.LoadFromResourceName(HInstance, 'SMILE' + inttostr(Item.Tag));
  if Selected then
  begin
    ACanvas.Brush.Color := clMenuHighlight;
    //bmp.TransparentColor:=clMenuHighlight;
  end
  else
  begin
    ACanvas.Brush.Color := clMenu;
    //bmp.TransparentColor//:=clMenu;
  end;
  SetBitampColor(bmp, selected);
  ACanvas.FillRect(ARect);
  ACanvas.Draw(ARect.Left, ARect.Top, bmp);
  ACanvas.TextOut(ARect.Left + bmp.Width + 4, ARect.Top + (bmp.height -
    ACanvas.Font.Size) div 2, Item.Caption);
  bmp.Free;
end;

procedure TfmMain.bat1MeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
var
  bmp: TBitMap;
  Item: TMenuItem;
begin
  Item := (Sender as TMenuItem);
  bmp := TBitMap.Create;
  //Item.Bitmap:=bmp;
  //ACanvas.
  bmp.LoadFromResourceName(HInstance, 'SMILE' + inttostr(Item.Tag));
  Height := bmp.Height + 2;
  Width := Width + bmp.Width;
  bmp.Free;
end;

procedure TfmMain.TimerAntiSoundTimer(Sender: TObject);
begin
  TimerAntiSound.Enabled := False;
  SoundScore := 0;
end;

procedure TfmMain.sbpMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbRight then
  begin
    fmMain.pmSmiles.Tag := 0;
    fmMain.pmLink.Tag := 0;
  end;
end;

procedure TfmMain.edTextChange(Sender: TObject);
var
  tmp: string;
begin

  tmp := edText.Text;

  if NotifyUserTyping then
    if length(tmp) > 0 then
    begin

      if tmp[1] <> '/' then
      begin

        if TimerWriteOut.Enabled then
        begin
          TimerWriteOut.Enabled := False;
          TimerWriteOut.Enabled := True;
        end
        else
        begin
          TimerWriteOut.Enabled := True;
          SendData('9' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
            pg1.ActivePage.Caption, '*');

        end;

      end
      else if (pos('/msg', tmp) = 1) and (TimerWriteOut.Enabled) then
      begin
        TimerWriteOut.Interval := 10000;
        TimerWriteOut.Enabled := False;
        TimerWriteOut.Enabled := True;
      end;

    end;

  if length(tmp) > 5000 then
    edText.text := Copy(tmp, 1, 5000);
end;

procedure TfmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lvUser.Tag := 0;

  //  WriteCache('keylogging.txt','Charcode: '+inttostr(key));

  //  WriteCache('keylogging.txt','KeyData: '+inttostr(Msg.KeyData));

end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in shift then
    lvUser.Tag := 1
  else
    lvUser.Tag := 0;

  if (key = 9) and (ssCtrl in Shift) then
  begin
    pg1.SelectNextPage(True, False);
    key := 0;
  end;

end;

procedure TfmMain.lvUserMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if lvUser.Tag = 1 then
    aSay.Execute;
  lvUser.Tag := 0;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then    
    if edtext.text = '' then
      ct1DblClick(self)
    else
      edText.Text := '';
end;

procedure TfmMain.TimerAntiMeTimer(Sender: TObject);
begin
  TimerAntiMe.Enabled := False;
end;

procedure TfmMain.TimerWriteOutTimer(Sender: TObject);
begin
  TimerWriteOut.Interval := 5000;
  TimerWriteOut.Enabled := False;
  SendData('m' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, '*');
end;

procedure TfmMain.AntiFastRefreshTimerTimer(Sender: TObject);
begin
  AntiFastRefreshTimer.Enabled := False;
end;

procedure TfmMain.miKickClick(Sender: TObject);
begin
{$IFDEF ADMINPACK}
  if lvUser.SelCount > 0 then
  begin
    fmMain.Tag := 12;
    SendData(',' + CurNick + #0 + lvUser.Selected.Caption + #0 + AdminpackID,
      '*');
    SendData('/' + CurNick + #0 + lvUser.Selected.Caption + #0 + AdminpackID,
      '*');
  end;
{$ENDIF}
end;

procedure TfmMain.miBanClick(Sender: TObject);
begin
{$IFDEF ADMINPACK}
  if lvUser.SelCount > 0 then
  begin

    AddTextToMain(lvUser.Selected.Caption + ' заблокирован', 20);
    SendData('(' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID,
      lvUser.Selected.SubItems.Strings[0]);
    SendData('<' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID,
      lvUser.Selected.SubItems.Strings[0]);

  end;
{$ENDIF}
end;

procedure TfmMain.miUnbanClick(Sender: TObject);
begin
{$IFDEF ADMINPACK}
  if lvUser.SelCount > 0 then
  begin
    AddTextToMain(lvUser.Selected.Caption + ' разблокирован', 20);
    SendData(')' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID,
      lvUser.Selected.SubItems.Strings[0]);
    SendData('>' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID,
      lvUser.Selected.SubItems.Strings[0]);
  end;
{$ENDIF}
end;

procedure TfmMain.miKillMsgClick(Sender: TObject);
begin
{$IFDEF ADMINPACK}
  if lvUser.SelCount > 0 then
  begin
    laststring := 0;
    SendData('Д' + lvUser.Selected.Caption + #0' ', '*');
    SendData('-' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID, lvUser.Selected.SubItems.Strings[0]);
    SendData('_' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0] + #0 +
      AdminpackID, lvUser.Selected.SubItems.Strings[0]);
  end;
{$ENDIF}
end;

procedure TfmMain.miForceSignalClick(Sender: TObject);
begin
{$IFDEF ADMINPACK}
  if lvUser.SelCount > 0 then
  begin
    SendData('С' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0],
      lvUser.Selected.SubItems.Strings[0]);
  end;
{$ENDIF}
end;

procedure TfmMain.Massadminmessage1Click(Sender: TObject);
var
  i: integer;
  tmp: string;
begin
{$IFDEF ADMINPACK}
  if InputQuery('Сообщение администратора', 'Введите текст', tmp) then
  begin
    for i := 0 to lvUser.Items.Count - 1 do
    begin
      if lvUser.Items.Item[i].SubItems.Strings[0] <> CurID then
        SendData('s' + lvUser.Items.Item[i].SubItems.Strings[0] + #0 +
          'Administrator' + #0 + tmp, lvUser.Items.Item[i].SubItems.Strings[0]);
    end;
  end;
{$ENDIF}
end;

procedure TfmMain.spltrMoved(Sender: TObject);
begin
  cbNick.DroppedWidth := cbNick.ClientWidth;
  edTopic.DroppedWidth := cbNick.ClientWidth;
end;

//SendData('M'+CURID+#0+CurNick+#0+'dsfdsfds','*');
//

procedure TfmMain.pmREPopup(Sender: TObject);
begin
  if (pg1.ActivePage.ImageIndex in [2, 3, 6, 7]) or TopicTimer.Enabled then
  begin
    miChangeTopic.Enabled := False;
    miRETopic.Enabled := False;
  end
  else
  begin
    miChangeTopic.Enabled := True;
    miRETopic.Enabled := True;
  end;
end;

procedure TfmMain.GHkeyHotKey(Sender: TObject);
begin
  ct1DblClick(Self);
//        SendData('s' + CurID + #0 +
//          'Administrator' + #0 + '23213', CurID);

end;

procedure TfmMain.TimerAFTimer(Sender: TObject);
begin
  TImerAF.enabled := False;
  fmMain.enabled := True;
end;

procedure TfmMain.TimerAntiScrTimer(Sender: TObject);
begin
  TimerAntiScr.Enabled := False;
  slState.ScrollLock := False;
end;

procedure TfmMain.HKDisableSLHotKey(Sender: TObject);
begin
  TimerFlashScr.Enabled := False;
  TimerAntiScr.Enabled := True;
      //  SendData('s' + CurID + #0 +
//          'Administrator' + #0 + '23213', CurID);
//sendData('M'+'Denis'#0'Shitting!'#0'434324'#0'3423', CurID);
end;

procedure TfmMain.NTimerTimer(Sender: TObject);
begin
  AddTextToMain('Пожалуйста, зарегистрируйтесь!', 20);
  NTimer.Interval := GetNAGTimeOut;
end;

procedure TfmMain.aDummy(Sender: TObject);
begin
  // This is an empty event to reference for non-evented items
end;

procedure TfmMain.aAboutExecute(Sender: TObject);
begin
  fmabout := TfmAbout.Create(nil);
  fmAbout.ShowModal;
  fmAbout.Free;
end;

procedure TfmMain.aRegisterExecute(Sender: TObject);
begin
  fmRegInfo := TfmRegInfo.Create(nil);
  fmRegInfo.ShowModal;
  fmRegInfo.Free;
end;

procedure TfmMain.aVisitSiteExecute(Sender: TObject);
var
  thread: TExecuteURLThread;
begin
  thread := TExecuteURLThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Priority := tpNormal;
  thread.url := 'http://www.unichat.net.ru';
  thread.Resume;
end;

procedure TfmMain.aMailDevExecute(Sender: TObject);
var
  thread: TExecuteURLThread;
begin
  thread := TExecuteURLThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Priority := tpNormal;
  thread.url := 'mailto:unichat@inbox.ru?subject=UniChat_ver_' +
    GetFileVersion('unichat.exe');
  thread.Resume;
end;

procedure TfmMain.aContentsExecute(Sender: TObject);
var
  path: string;
begin
  path := ExtractFilePath(application.ExeName) + 'Help\unichat.chm';
  ShellExecute(0, 'open', PChar(path), nil, nil, SW_SHOW);
end;

procedure TfmMain.aAllOptionsExecute(Sender: TObject);
begin
  fmSetup := TfmSetup.Create(self);
  ReadNicks;
  fmSetup.ShowModal;
  fmSetup.free;
end;

procedure TfmMain.aMaxLinesExecute(Sender: TObject);
var
  tmp: string;
begin
  tmp := inttostr(chat_maxlines);
  if InputQuery('Максимальное число строк в чате',
    'Введите число (>5) (0 - без лимита)', tmp) then
  begin
    try
      chat_maxlines := strtoint(tmp);
    except
      chat_maxlines := 0;
      showmessage('Неверное значение. Установлен 0');
    end;
  end;

end;

procedure TfmMain.aLeftExecute(Sender: TObject);
begin

  if aRight.Checked then
  begin
    fmMain.pnUser.Align := alRight;
    fmMain.spltr.Align := alRight;
    //   fmMain.miRight.Checked:=True;
  end
  else
  begin
    //fmMain.bv4.Align:=alLeft;
    fmMain.pnUser.Align := alLeft;
    fmMain.spltr.Align := alLeft;
    //   fmMain.miLeft.Checked:=True;
  end;

end;

procedure TfmMain.aDrawSmilesExecute(Sender: TObject);
begin
  smilestate := aDrawSmiles.checked;
end;

procedure TfmMain.aHHMMSSExecute(Sender: TObject);
begin
  isSeconds := ahhmmss.Checked;
end;

procedure TfmMain.aFlatBtnExecute(Sender: TObject);
begin
  case (sender as TAction).Tag of
    20: pg1.Style := tsFlatButtons;
    21: pg1.Style := tsButtons;
    22: pg1.Style := tsTabs;
  end;
end;

procedure TfmMain.aScrBarEditorExecute(Sender: TObject);
begin
  if aScrBarEditor.Checked then
  begin
    edText.ScrollBars := stdctrls.ssVertical;
    edText.WordWrap := True;
  end
  else
  begin
    edText.ScrollBars := stdctrls.ssNone;
    edText.WordWrap := False;
  end;

end;

procedure TfmMain.aAutoScrollTxtExecute(Sender: TObject);
begin
  miAutoScroll.checked := aAutoScrollTxt.checked;
  miAutoScrollClick(self);
end;

procedure TfmMain.enblNoShowExecute(Sender: TObject);
begin
  aNoShowMsg.Visible := True;
end;

procedure TfmMain.aShowBoardExecute(Sender: TObject);
begin
  if (sender as TAction).Checked then
  begin
    ttboard.PageControl := pg1;
    SendData('У', '*');

    with edTopic.Items.Add do
    begin
      text := 'Объявления';
      imageindex := 3;
    end;

  end
  else
  begin
    edTopic.Items[ttboard.PageIndex].Free;
    ttboard.PageControl := nil;
    pg1.OnChange(Self);
  end;

end;

procedure TfmMain.aShowNickExecute(Sender: TObject);
begin
  bevBalance.Visible := aShowNick.checked and pnTopic_noSmile.Visible;
  pnNicks.Visible := aShowNick.checked;

end;

procedure TfmMain.aShowTopicExecute(Sender: TObject);
begin
  if fmMain.aShowTopic.checked then
    fmMain.pnTopic_noSmile.Visible := True
  else
    fmMain.pnTopic_noSmile.Visible := False;
  bevBalance.Visible := pnTopic_noSmile.Visible;
end;

procedure TfmMain.aCopyAllExecute(Sender: TObject);
var
  z: integer;
  CurRe: TRichView;
begin
  z := pg1.ActivePageIndex;
  if z = 0 then
  begin
    rvMain.SelectAll;
    rvMain.CopyText;
    rvMain.SetSelectionBounds(0, 0, 0, 0);
  end
  else
  begin
    CurRE := (pg1.Pages[z].FindComponent('memo' + pg1.Pages[z].name) as
      TRichView);
    CurRE.SelectAll;
    CurRE.CopyText;
    CurRE.SetSelectionBounds(0, 0, 0, 0);

  end;
  ReturnFOcus;
end;

procedure TfmMain.aClearChatExecute(Sender: TObject);
var
  CurRE: TRichView;
begin
  if pg1.ActivePageIndex = 0 then
  begin
    rvMain.Clear;
    rvMain.Format;
    AddTextToMain('Окно очищено', 12);
  end
  else
  begin
    if pg1.ActivePage.name <> 'ttboard' then
    begin
      CurRE := (pg1.Pages[pg1.ActivePageIndex].FindComponent('memo' +
        pg1.Pages[pg1.ActivePageIndex].name) as TRichView);
      CurRE.Clear;
      CurRE.Format;
      AddTextToPage(pg1.ActivePage.Caption, 'Окно очищено', 12);
    end;
  end;
end;

procedure TfmMain.aClearLineExecute(Sender: TObject);
begin
  edText.Text := '';
end;

procedure TfmMain.aClearHistoryExecute(Sender: TObject);
begin
  txtHist.Clear;
  txtPos := 0;
end;

procedure TfmMain.aRusEngExecute(Sender: TObject);
begin
  if edText.SelLength > 0 then
  begin
    edText.SelText := TransCodeRus2Eng(edText.SelText);
  end
  else
  begin
    edText.text := TransCodeRus2Eng(edText.text);
    SendKey(edText.Handle, Chr($23));
  end;
end;

procedure TfmMain.aEngRusExecute(Sender: TObject);
begin
  if edText.SelLength > 0 then
  begin
    edText.SelText := TransCodeEng2Rus(edText.SelText);
  end
  else
  begin
    edText.text := TransCodeEng2Rus(edText.text);
    SendKey(edText.Handle, Chr($23));
  end;
end;

procedure TfmMain.aToggleExecute(Sender: TObject);
begin
  if edText.SelLength > 0 then
  begin
    edText.SelText := TransCodeToggle(edText.SelText);
  end
  else
  begin

    edText.text := TransCodeToggle(edText.text);
    SendKey(edText.Handle, Chr($23));
  end;
end;

procedure TfmMain.aSayExecute(Sender: TObject);
var
  tmp: string;
begin
  if lvUser.SelCount > 0 then
  begin
    tmp := edText.Text;
    edText.Text := '-> ' + lvUser.Selected.Caption + ': ' + tmp;
    SendKey(edText.Handle, Chr($23));
    edText.SetFocus;
  end;
end;

procedure TfmMain.aBeepExecute(Sender: TObject);
begin
  if lvUser.SelCount > 0 then
    if (SoundScore < 5) then
    begin

      SendData('B' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0],
        lvUser.Selected.SubItems.Strings[0]);

      inc(soundscore);
      TimerAntiSound.Enabled := True;
    end;
end;

procedure TfmMain.aPrivateExecute(Sender: TObject);
begin
  if lvUser.SelCount > 0 then
    if IsPagePresent(lvUser.Selected.Caption) = -1 then
      SendData('j' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0],
        lvUser.Selected.SubItems.Strings[0]);
end;

procedure TfmMain.aInfoExecute(Sender: TObject);
begin
  if lvUser.SelCount > 0 then
    SendData('G' + CurNick + #0 + lvUser.Selected.SubItems.Strings[0],
      lvUser.Selected.SubItems.Strings[0]);
end;

procedure TfmMain.aTopicChgExecute(Sender: TObject);
var
  tmp, tmp1: string;
begin
{$IFNDEF ADMINPACK}
  if not TopicTimer.Enabled then
  begin
    if TopicTimer.tag <> 10 then
    begin
{$ENDIF}

      fmTopic := TfmTopic.Create(nil);



      tmp := StringReplace(edTopic.Items.Items[edTopic.ItemIndex].Text,
        pg1.ActivePage.Caption + ': ', '', [rfReplaceAll]);
      tmp := StringReplace(tmp, '(' + CurNick + ')', '', [rfReplaceAll]);
      tmp1 := tmp;

      fmTopic.leTopic.text := tmp;
      fmTopic.ShowModal;

      if fmTopic.ModalResult = mrOK then
      begin
        tmp := fmTopic.leTopic.text;
        if tmp <> tmp1 then
        begin
{$IFNDEF ADMINPACK}
{$ENDIF}

          if pg1.ActivePage.ImageIndex in [0, 1] then
            SendData('T' + CurNick + #0 + UCPlugins.ProcessOutput(Trim(tmp)) +
              ' (' + CurNick + ')' + #0
              + CurSex, '*')

          else if pg1.ActivePage.ImageIndex in [4, 5] then
            SendData('Т' + CurNick + #0 + pg1.ActivePage.Caption + #0 +
              UCPlugins.ProcessOutput(Trim(tmp)) + ' (' + CurNick + ')' + #0 +
              CurSex, '*');

{$IFNDEF ADMINPACK}
          TopicTimer.Enabled := True;
{$ENDIF}

        end;
        ReturnFocus;

      end;
{$IFNDEF ADMINPACK}
    end
    else
      showmessage('Вы расцениваетесь как флудер и не имеете права менять тему');
  end
  else
    showmessage('Сработала защита: ждите 1 минуту');
{$ENDIF}
end;

procedure TfmMain.aPriviledgeExecute(Sender: TObject);
begin
  InputQuery('Назначить привилегию', 'Введите ключевое слово', priv_prefix);
end;

procedure TfmMain.aUserInfoExecute(Sender: TObject);
begin
  InputQuery('Информация о пользователе', 'Введите текст', UserNfo)
end;

procedure TfmMain.aRoomsExecute(Sender: TObject);
begin
  fmRooms := TfmRooms.Create(nil);
  ReadRooms;
  fmRooms.ShowModal;
end;

procedure TfmMain.aChngCommExecute(Sender: TObject);
begin
  fmComment := TfmComment.Create(Self);

  fmComment.Caption := 'Новый комментарий';
  ReadModes('Mode' + CurMode, fmComment.cbData.Items);

  case CurMode of
    '0': fmComment.cbData.Text := mdActive;
    '1': fmComment.cbData.Text := mdDND;
    '2': fmComment.cbData.Text := mdAway;
    '3': fmComment.cbData.Text := mdOffline;
    '4': fmComment.cbData.Text := mdGaming;
  end;
  //    fmComment.cbData.Items.Add(fmComment.cbData.Text);

  fmComment.ShowModal;

  if fmComment.ModalResult = mrOk then
  begin
    WriteModes('Mode' + CurMode, fmComment.cbData.Items);

    case CurMode of
      '0': mdActive := fmComment.cbData.Text;
      '1': mdDND := fmComment.cbData.Text;
      '2': mdAway := fmComment.cbData.Text;
      '3': mdOffline := fmComment.cbData.Text;
      '4': mdGaming := fmComment.cbData.Text;
    end;
    fmComment.Free;
  end;
end;

procedure TfmMain.aModeExecute(Sender: TObject);
var
  tmp: char;
  tmp1: string;
begin
  // Mode changed!

  tmp := CurMode;

  case (Sender as TAction).Tag of
    1: tmp := '0';
    2: tmp := '4';
    3: tmp := '1';
    4: tmp := '3';
    5: tmp := '2';
  end;

  if tmp <> CurMode then
  begin

    case tmp of
      '4':
        begin
          if aDisableSmilesGaming.Checked then
          begin
            smilestate := aDrawSmiles.Checked;
            aDrawSmiles.Checked := False;
          end;
        end;
    else
      begin
        if (aDisableSmilesGaming.Checked) and (CurMode = '4') then
        begin
          aDrawSmiles.Checked := smilestate;
        end;
      end;
    end;

    tmp1 := '';

    if (tmp <> '0') and aAskModeComnt.Checked then
    begin

      fmComment := TfmComment.Create(Self);

      fmComment.Caption := 'Комментарий для режима ' + (Sender as
        TAction).Caption;
      ReadModes('Mode' + tmp, fmComment.cbData.Items);

      case tmp of
        '0': fmComment.cbData.Text := mdActive;
        '1': fmComment.cbData.Text := mdDND;
        '2': fmComment.cbData.Text := mdAway;
        '3': fmComment.cbData.Text := mdOffline;
        '4': fmComment.cbData.Text := mdGaming;
      end;
      //    fmComment.cbData.Items.Add(fmComment.cbData.Text);

      fmComment.ShowModal;

      if fmComment.ModalResult = mrOk then
      begin

        CurMode := tmp;
        ct1.IconIndex := ord(curmode) - 48;
        WriteModes('Mode' + CurMode, fmComment.cbData.Items);
        case CurMode of
          '0': mdActive := fmComment.cbData.Text;
          '1': mdDND := fmComment.cbData.Text;
          '2': mdAway := fmComment.cbData.Text;
          '3': mdOffline := fmComment.cbData.Text;
          '4': mdGaming := fmComment.cbData.Text;
        end;
        tmp1 := fmComment.cbData.Text;
        if TimerMode.Enabled then
          SendData('q' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive +
            #0
            + UCPlugins.ProcessOutput(tmp1), '*')
        else
          SendData('R' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive +
            #0
            + UCPlugins.ProcessOutput(tmp1), '*');
        TimerWriteOut.Enabled := False;
        TimerMode.Enabled := True;
      end; // else exit;

      fmComment.Free;
    end
    else
    begin
      curmode := tmp;
      // SetMode(CurMode);
      case CurMode of
        '0': mdActive := '';
        '1': mdDND := '';
        '2': mdAway := '';
        '3': mdOffline := '';
        '4': mdGaming := '';
      end;
      ct1.IconIndex := ord(curmode) - 48;
      if TimerMode.Enabled then
        SendData('q' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive + #0
          + UCPlugins.ProcessOutput(tmp1), '*')
      else
        SendData('R' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive + #0
          + UCPlugins.ProcessOutput(tmp1), '*');
      TimerMode.Enabled := True;
      TimerWriteOut.Enabled := False;
      // cbNick.ItemsEx.Items[cbNick.ItemIndex].ImageIndex:=Ord(CurMode)-48;

    end;
  end;
  SetMode(CurMode);
end;

procedure TfmMain.aNoShowMsgExecute(Sender: TObject);
begin
//
if aNoShowMsg.Checked and not aMsgInMain.Checked then
begin
aNoShowMsg.Checked := False;
end;
end;

procedure TfmMain.aArchiveTabExecute(Sender: TObject);
var
  filename: string;
  c: integer;
begin
  if pg1.ActivePageIndex = 0 then
    filename := 'main.txt'
  else if pg1.ActivePage.Caption[1] <> '#' then
    filename := 'talk_' + pg1.ActivePage.Caption + '.txt'
  else
    filename := pg1.ActivePage.Caption + '.txt';

  for c := 1 to length(filename) do
    if filename[c] in ['\', '?', '"', '*', '/', ':', '|'] then
      filename[c] := '_';
  filename := IncludeTrailingBackslash(logdir) + Filename;
  ShellExecute(0, 'open', PChar(filename), nil, nil, SW_SHOW);
end;

procedure TfmMain.aArchiveMsgExecute(Sender: TObject);
begin
  ReadMsgLog;
end;

procedure TfmMain.aBrowseLogsExecute(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(logdir), nil, nil, SW_SHOW);
end;

procedure TfmMain.aSelLogDirExecute(Sender: TObject);
begin
  SelectDirectory('Select Directory', '', logdir);
end;

procedure TfmMain.aCmdExecute(Sender: TObject);
var
  tmp: string;
  pos: TPoint;
begin
  tmp := StringReplace((sender as TAction).Caption, '&', '', [rfReplaceAll]);
  edText.Text := Parse(tmp, ' ') + ' ' + edText.Text;
  //  edText.SelLength := 0;

  pos.Y := edText.CaretPos.Y;
  pos.X := length(edText.Lines.strings[pos.y]);
  edText.CaretPos := pos;

  //  SendKey(edText.Handle, Chr($23));


end;

procedure TfmMain.aMacrosExecute(Sender: TObject);
begin
  case (Sender as TComponent).tag of
    1: aMacPaste1.Caption := edText.Text;
    2: aMacPaste2.Caption := edText.Text;
    3: aMacPaste3.Caption := edText.Text;
    4: aMacPaste4.Caption := edText.Text;
    5: aMacPaste5.Caption := edText.Text;
    6: aMacPaste6.Caption := edText.Text;
    7: aMacPaste7.Caption := edText.Text;
    8: aMacPaste8.Caption := edText.Text;
    9: aMacPaste9.Caption := edText.Text;
    10: aMacPaste10.Caption := edText.Text;
    11: aMacPaste11.Caption := edText.Text;
    12: aMacPaste12.Caption := edText.Text;
  end;
//  (Sender as TAction).Caption := edText.Text;
end;

procedure TfmMain.aMacPasteExecute(Sender: TObject);
begin
  if (Sender as TAction).Caption <> '' then
  begin
    edText.Text := edText.Text + StringReplace((sender as TAction).Caption,
      '&', '', [rfReplaceAll]);
    SendKey(edText.Handle, Chr($23));
  end
  else if (Sender as TAction).tag = 4 then
    N54.Click;
end;

procedure TfmMain.aRefreshExecute(Sender: TObject);
begin
  if not AntiFastRefreshTimer.Enabled then
  begin
    AntiFastRefreshTimer.Enabled := True;
    RefreshList;
  end;
end;

procedure TfmMain.ammbMainEnterMenuLoop(Sender: TObject);
begin
  aMacPaste1.Visible := aMacPaste1.Caption <> '';
  aMacPaste2.Visible := aMacPaste2.Caption <> '';
  aMacPaste3.Visible := aMacPaste3.Caption <> '';
  aMacPaste4.Visible := aMacPaste4.Caption <> '';
  aMacPaste5.Visible := aMacPaste5.Caption <> '';
  aMacPaste6.Visible := aMacPaste6.Caption <> '';
  aMacPaste7.Visible := aMacPaste7.Caption <> '';
  aMacPaste8.Visible := aMacPaste8.Caption <> '';
  aMacPaste9.Visible := aMacPaste9.Caption <> '';
  aMacPaste10.Visible := aMacPaste10.Caption <> '';
  aMacPaste11.Visible := aMacPaste11.Caption <> '';
  aMacPaste12.Visible := aMacPaste12.Caption <> '';

  aNoneMac.Visible := not (aMacPaste1.Visible or
    aMacPaste2.Visible or
    aMacPaste3.Visible or
    aMacPaste4.Visible or
    aMacPaste5.Visible or
    aMacPaste6.Visible or
    aMacPaste7.Visible or
    aMacPaste8.Visible or
    aMacPaste9.Visible or
    aMacPaste10.Visible or
    aMacPaste11.Visible or
    aMacPaste12.Visible);
end;

procedure TfmMain.aShowToolBarExecute(Sender: TObject);
begin
fmMain.atbMain.Visible :=  fmMain.aShowToolBar.checked;
end;

end.


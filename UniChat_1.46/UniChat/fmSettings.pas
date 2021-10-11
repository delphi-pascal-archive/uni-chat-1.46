{
UniChat - chat for LANs.
fmSettings.pas - Main settings form module.

$Author(s): Dentall
$Last revision: 25/09/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}
unit fmSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Menus, StdCtrls, Buttons, ToolWin,
  CheckLst, Spin, Mask, DynaStackProtect,
  JvExControls, JvComponent, JvgWizardHeader;

type
  TfmSetup = class(TForm)
    pmSex: TPopupMenu;
    pnMale: TMenuItem;
    pnFemale: TMenuItem;
    fntDlg: TFontDialog;
    clrDlg: TColorDialog;
    twMain: TTreeView;
    Bevel1: TBevel;
    pnColors: TPanel;
    pnUser: TPanel;
    lvUserList: TListView;
    lb1: TLabel;
    GroupBox1: TGroupBox;
    tb1: TToolBar;
    tbSex: TToolButton;
    edAddNick: TEdit;
    GroupBox2: TGroupBox;
    rbLogin: TRadioButton;
    rbLast: TRadioButton;
    bnAdd: TButton;
    cbAutoGender: TCheckBox;
    bnOK: TButton;
    bnDefault: TButton;
    pmUserList: TPopupMenu;
    N1: TMenuItem;
    pnNotify: TPanel;
    cbInact: TCheckBox;
    clbNotify: TCheckListBox;
    Bevel2: TBevel;
    Label1: TLabel;
    pnSound: TPanel;
    clbSound: TCheckListBox;
    cbSound: TCheckBox;
    pnSys: TPanel;
    clbSys: TCheckListBox;
    pnConnection: TPanel;
    pnMain: TPanel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    hk1: THotKey;
    cbAutoUp: TCheckBox;
    cbStartMinimized: TCheckBox;
    pnInterface: TPanel;
    cbDrawSmiles: TCheckBox;
    cbTrayFlash: TCheckBox;
    cbScrollFlash: TCheckBox;
    cbSbar: TCheckBox;
    rgUserList: TRadioGroup;
    rgTimeStamp: TRadioGroup;
    GroupBox6: TGroupBox;
    seAutoRefresh: TSpinEdit;
    Label4: TLabel;
    seAutoAway: TSpinEdit;
    Label5: TLabel;
    seBallon: TSpinEdit;
    Label8: TLabel;
    cbElement: TComboBox;
    Label7: TLabel;
    cbFontColor: TColorBox;
    cbBackColor: TColorBox;
    Label9: TLabel;
    Label10: TLabel;
    cbCur: TCheckBox;
    cbBold: TCheckBox;
    cbUnder: TCheckBox;
    cbFontName: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    seFontSize: TSpinEdit;
    Bevel3: TBevel;
    edExample: TEdit;
    Label13: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    bnBack: TButton;
    pnFilter: TPanel;
    Label15: TLabel;
    Label17: TLabel;
    pnFRooms: TPanel;
    pgFRoom: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnPrivate: TPanel;
    pgFPrivate: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    pnFMessages: TPanel;
    pgFMsg: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    bnNoMassMsg: TCheckBox;
    mmNameMsg: TListBox;
    mmIPMsg: TListBox;
    mmNameRoom: TListBox;
    mmIPRoom: TListBox;
    mmNamePriv: TListBox;
    mmIPPriv: TListBox;
    lePrivate: TLabeledEdit;
    bnPrivate: TButton;
    Label16: TLabel;
    leMessages: TLabeledEdit;
    bnMessages: TButton;
    Label20: TLabel;
    leRooms: TLabeledEdit;
    bnRooms: TButton;
    Label18: TLabel;
    se1: TSpinEdit;
    Label3: TLabel;
    Label2: TLabel;
    edIP: TEdit;
    bnNetDef: TButton;
    rbBroadcast: TRadioButton;
    rbDedicated: TRadioButton;
    Label19: TLabel;
    edDedicIP: TEdit;
    Label21: TLabel;
    seDedicServer: TSpinEdit;
    Bevel7: TBevel;
    cbAuto2broad: TCheckBox;
    Label23: TLabel;
    cbColumn: TCheckBox;
    pnAdd: TPanel;
    GroupBox3: TGroupBox;
    cbDontNotifyTab: TCheckBox;
    cbDontNotifyTray: TCheckBox;
    cbDontShowTalk: TCheckBox;
    GroupBox7: TGroupBox;
    Label24: TLabel;
    cbForceMsgInOffline: TCheckBox;
    cbNotifyInOffline: TCheckBox;
    pnSecutiry: TPanel;
    Label6: TLabel;
    edGroupKey: TEdit;
    Label14: TLabel;
    cbEnableProtect: TCheckBox;
    lbbuf1: TLabel;
    seMaxPackets: TSpinEdit;
    lbbuf2: TLabel;
    lbWarn: TLabel;
    Label27: TLabel;
    cbNotifyFilter: TCheckBox;
    cbUserTyping: TCheckBox;
    cbFalshTaskbar: TCheckBox;
    txtHeader: TJvgWizardHeader;
    HKDisableSL: THotKey;
    Label22: TLabel;
    procedure HKDisableSLChange(Sender: TObject);
    procedure bnOKClick(Sender: TObject);
    procedure pnMaleClick(Sender: TObject);
    procedure pnFemaleClick(Sender: TObject);
    procedure bnAddClick(Sender: TObject);
    procedure clbSoundClickCheck(Sender: TObject);
    procedure cbSoundClick(Sender: TObject);
    procedure clbNotifyClickCheck(Sender: TObject);
    procedure cbInactClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbLoginClick(Sender: TObject);
    procedure cbAutoGenderClick(Sender: TObject);
    procedure rbLastClick(Sender: TObject);
    procedure twMainDblClick(Sender: TObject);
    procedure twMainCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure twMainChange(Sender: TObject; Node: TTreeNode);
    procedure N1Click(Sender: TObject);
    procedure lvUserListClick(Sender: TObject);
    procedure bnNetDefClick(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure edIPChange(Sender: TObject);
    procedure cbDrawSmilesClick(Sender: TObject);
    procedure cbTrayFlashClick(Sender: TObject);
    procedure cbSbarClick(Sender: TObject);
    procedure rgUserListClick(Sender: TObject);
    procedure rgTimeStampClick(Sender: TObject);
    procedure hk1Change(Sender: TObject);
    procedure cbAutoUpClick(Sender: TObject);
    procedure cbStartMinimizedClick(Sender: TObject);
    procedure seAutoRefreshChange(Sender: TObject);
    procedure clbSysClickCheck(Sender: TObject);
    procedure seBallonChange(Sender: TObject);
    procedure cbScrollFlashClick(Sender: TObject);
    procedure cbElementChange(Sender: TObject);
    procedure cbFontNameChange(Sender: TObject);
    procedure bnBackClick(Sender: TObject);
    procedure bnNoMassMsgClick(Sender: TObject);
    procedure bnPrivateClick(Sender: TObject);
    procedure bnMessagesClick(Sender: TObject);
    procedure bnRoomsClick(Sender: TObject);
    procedure rbBroadcastClick(Sender: TObject);
    procedure edDedicIPChange(Sender: TObject);
    procedure seDedicServerChange(Sender: TObject);
    procedure cbAuto2broadClick(Sender: TObject);
    procedure bnDefaultClick(Sender: TObject);
    procedure seAutoAwayChange(Sender: TObject);
    procedure edAddNickChange(Sender: TObject);
    procedure cbColumnClick(Sender: TObject);
    procedure cbEnableProtectClick(Sender: TObject);
    procedure seMaxPacketsChange(Sender: TObject);
    procedure cbNotifyFilterClick(Sender: TObject);
    procedure cbForceMsgInOfflineClick(Sender: TObject);
    procedure cbDontShowTalkClick(Sender: TObject);
    procedure cbDontNotifyTrayClick(Sender: TObject);
    procedure cbDontNotifyTabClick(Sender: TObject);
    procedure cbNotifyInOfflineClick(Sender: TObject);
    procedure cbUserTypingClick(Sender: TObject);
    procedure cbFalshTaskbarClick(Sender: TObject);
  private
    { Private declarations }

  public
    CanOnChange: boolean;
    UsersChanged: boolean;

    procedure UpdateSheets;

    { Public declarations }
  end;

type
  TPanelEnum = (teCommon, teUser, teInterface, teMsg, teColor, teSound,
    teSysMsg, teNotify,
    teConnection, teFilter, teFlRoom, tePrivate, teSecurity, teAdd);

var
  fmSetup: TfmSetup;

implementation
uses chatutils, RVStyle, StdConvs, JvListComb, main,GlobalConst, fisHotKey;
{$R *.dfm}

function AddToCombo: boolean;
var
  i: integer;
begin
  Result := False;
//  fmMain.cbNick.Clear;
  fmMain.cbNick.Items.Clear;

  for i := 0 to fmSetup.lvUserList.Items.Count - 1 do
  begin
      if fmSetup.lvUserList.Items.Item[i].checked then
      begin

      with fmMain.cbNick.Items.Add do
      begin
      Text:=fmSetup.lvUserList.Items.Item[i].caption;
      ImageIndex:=fmSetup.lvUserList.Items.Item[i].imageindex;
      end;
        Result := True;
      end;
  end;


  if fmMain.cbNick.Items.Count > 0 then
  begin
    if fmMain.cbNick.SearchExactString(CurNick,True) = -1 then
    begin

      with fmMain.cbNick.Items.Add do
      begin
      Text:=CurNick;
      ImageIndex:= 10 * (Ord(CurSex) - 48);
      end;

      cbItem := fmMain.cbNick.SearchExactString(CurNick,True);
      fmMain.cbNick.ItemIndex := cbItem;

    end
    else
      fmMain.cbNick.ItemIndex := fmMain.cbNick.SearchExactString(CurNick,True);
    end else
    begin
      with fmMain.cbNick.Items.Add do
      begin
      Text:=CurNick;
      ImageIndex:= 10 * (Ord(CurSex) - 48);
      end;
      fmMain.cbNick.ItemIndex:=0;
    end;
end;

procedure TfmSetup.bnOKClick(Sender: TObject);
begin
  if Isserver xor IsServer_ then
    showmessage('Для вступления изменений в силу перезапустите чат');

  GroupKey := edGroupKey.Text;

  Name_Room.Assign(mmNameRoom.Items);
  IP_Room.Assign(mmIPRoom.Items);

  Name_Private.Assign(mmNamePriv.Items);
  IP_Private.Assign(mmIPPriv.Items);

  Name_Msg.Assign(mmNameMsg.Items);
  IP_Msg.Assign(mmIPMsg.Items);

  {Name_Room:=mmNameRoom.Items;
  IP_Room:=mmIPRoom.Items;

  Name_Private:=mmNamePriv.Items;
  IP_Private:=mmIPPriv.Items;

  Name_Msg:=mmNameMsg.Items;
  IP_Msg:=mmIPMsg.Items;}

  if UsersChanged then
  begin
  WriteNicks;
  AddToCombo;
  end;
  //ModalResult:=1;
  WriteSettings;
end;

procedure TfmSetup.pnMaleClick(Sender: TObject);
begin
  tbSex.ImageIndex := 0;
end;

procedure TfmSetup.pnFemaleClick(Sender: TObject);
begin
  tbSex.ImageIndex := 10;
end;

procedure TfmSetup.bnAddClick(Sender: TObject);
var
  i: integer;
begin

  if Trim(CleanIncorrectSymbols(edAddNick.text)) <> '' then
  begin
  UsersChanged := True;
    i := lvUserList.Items.IndexOf(lvUserList.FindCaption(-1,
      Trim(CleanIncorrectSymbols(edAddNick.text)), False, False, False));
    if i = -1 then
    begin
      with lvUserList.Items.Add do
      begin
        Caption := Trim(CleanIncorrectSymbols(edAddNick.text));
        ImageIndex := tbSex.ImageIndex;
        checked := True;
      end;
    end
    else
    begin
      lvUserList.Items.Item[i].ImageIndex := tbSex.ImageIndex;
    end;
  end;
end;

procedure TfmSetup.clbSoundClickCheck(Sender: TObject);
begin
  //showmessage('on clickcheck');

  with clbSound do
  begin
    SndEnter := checked[0];
    SndLeave := checked[1];
    SndEnterChannel := checked[2];
    SndLeaveChannel := checked[3];
    SndEnterPrivate := checked[4];
    SndLeavePrivate := checked[5];
    SndLine := checked[6];
    SndMessage := checked[7];
    SndMultiMsg := checked[8];
    SndTopic := checked[9];
    SndNickChange := checked[10];
    SndSignal := checked[11];
    SndMeLine := checked[12];
  end;
end;

procedure TfmSetup.cbSoundClick(Sender: TObject);
begin
  SndEnabled := cbSound.Checked;
end;

procedure TfmSetup.clbNotifyClickCheck(Sender: TObject);
begin

  //Ballons state
  BEnterExitMain := clbNotify.checked[0];
  BEnterExitChannel := clbNotify.checked[1];
  BEnterExitPrivate := clbNotify.checked[2];
  BNickChange := clbNotify.checked[3];
  BBoardChange := clbNotify.checked[4];
  BModeChange := clbNotify.checked[5];
  BMessage := clbNotify.checked[6];
  BSignal := clbNotify.checked[7];
  BInfo := clbNotify.checked[8];
  BMessageReceived := clbNotify.checked[9];
  BTalkTreating := clbNotify.checked[10];
end;

procedure TfmSetup.cbInactClick(Sender: TObject);
begin
  BOnlyInactive := cbInact.Checked;
end;

procedure TfmSetup.UpdateSheets;
begin
  pgFRoom.Pages[0].Caption := 'Псевдоним (' + inttostr(name_Room.Count) + ')';
  pgFRoom.Pages[1].Caption := 'IP адрес (' + inttostr(IP_Room.Count) + ')';

  pgFPrivate.Pages[0].Caption := 'Псевдоним (' + inttostr(Name_Private.Count) +
    ')';
  pgFPrivate.Pages[1].Caption := 'IP адрес (' + inttostr(IP_Private.Count) +
    ')';

  pgFMsg.Pages[0].Caption := 'Псевдоним (' + inttostr(Name_Msg.Count) + ')';
  pgFMsg.Pages[1].Caption := 'IP адрес (' + inttostr(IP_Msg.Count) + ')';
end;

procedure TfmSetup.FormCreate(Sender: TObject);
begin
    CanOnChange:=True;
    UsersChanged := False;
    
  mmNameRoom.Items := Name_Room;
  mmIPRoom.Items := IP_Room;

  mmNamePriv.Items := Name_Private;
  mmIPPriv.Items := IP_Private;

  //lbNameMsg.Items := Name_Msg;

  mmNameMsg.Items := Name_Msg;
  mmIPMsg.Items := IP_Msg;

  UpdateSheets;

  bnNoMassMsg.Checked := MassMsg;

  cbFontName.Items.Assign(Screen.Fonts);

  cbElement.ItemIndex := 0;
  cbElement.OnChange(self);
  CanOnChange := False;
  cbFontNameChange(self);
  cbFontName.Text := fmMain.RVStyle.TextStyles[0].FontName;
  CanOnChange := True;


  twMain.fullexpand;

  cbColumn.Checked := (fmMain.lvUser.ViewStyle = vsList);

  hk1.HotKey := fmMain.GHkey.key;
  HKDisableSL.HotKey := fmMain.HKDisableSL.Key;

  //  fmMain.hkm.
  seAutoRefresh.Value := fmMain.tRfsh.Interval div 60000;

  if @GetLastInputInfoSELF = nil then
  begin
    seAutoAway.Value := 0;
    seAutoAway.Enabled := False;
  end
  else
    seAutoAway.Value := fmMain.TimerUserActivity.Tag div 60000;

  seBallon.Value := fmMain.TimerBaloon.Interval div 1000;

  cbStartMinimized.Checked := fmMain.aStartMinim.Checked;
  cbAutoUp.Checked := fmMain.aPopUpNew.Checked;

  if fmMain.aLeft.Checked then
    rgUserList.ItemIndex := 0
  else
    rgUserList.ItemIndex := 1;

  if fmMain.aHHMM.Checked then
    rgTimeStamp.ItemIndex := 0
  else
    rgTimeStamp.ItemIndex := 1;
  edGroupKey.Text := GroupKey;
  cbNotifyFilter.Checked := NotifyBaloon;
  seMaxPackets.Value := MaxPackets;
  cbEnableProtect.Checked := isProtectEnabled;
//  cbEnableProtect.OnClick(self);

  cbDrawSmiles.checked := fmMain.aDrawSmiles.checked;
  cbTrayFlash.Checked := fmMain.aFlashTBIco.checked;
  cbSbar.Checked := fmMain.aScrBarEditor.Checked;
  cbScrollFlash.Checked := fmMain.aFlashSL.Checked;

  cbInact.Checked := BOnlyInactive;

  clbSys.Checked[0] := SysEnterExitMain;
  clbSys.Checked[1] := SysEnterExitChannel;
  clbSys.Checked[2] := SysEnterExitPrivate;
  clbSys.Checked[3] := SysNickChange;
  clbSys.Checked[4] := SysBoardChange;
  clbSys.Checked[5] := SysTopicChange;
  clbSys.Checked[6] := SysModeChange;
  clbSys.Checked[7] := SysMessage;
  clbSys.Checked[8] := SysSignal;

  clbNotify.Checked[0] := BEnterExitMain;
  clbNotify.Checked[1] := BEnterExitChannel;
  clbNotify.Checked[2] := BEnterExitPrivate;
  clbNotify.Checked[3] := BNickChange;
  clbNotify.Checked[4] := BBoardChange;
  clbNotify.Checked[5] := BModeChange;
  clbNotify.Checked[6] := BMessage;
  clbNotify.Checked[7] := BSignal;
  clbNotify.Checked[8] := BInfo;
  clbNotify.Checked[9] := BMessageReceived;
  clbNotify.Checked[10] := BTalkTreating;


  cbSound.Checked := SndEnabled;
  clbSound.Checked[0] := SndEnter;
  clbSound.Checked[1] := SndLeave;
  clbSound.Checked[2] := SndEnterChannel;
  clbSound.Checked[3] := SndLeaveChannel;
  clbSound.Checked[4] := SndEnterPrivate;
  clbSound.Checked[5] := SndLeavePrivate;
  clbSound.Checked[6] := SndLine;
  clbSound.Checked[7] := SndMessage;
  clbSound.Checked[8] := SndMultiMsg;
  clbSound.Checked[9] := SndTopic;
  clbSound.Checked[10] := SndNickChange;
  clbSound.Checked[11] := SndSignal;
  clbSound.Checked[12] := SndMeLine;

  rbLogin.Checked := crbLogin;
  rbLast.Checked := CrbLast;
  cbAutoGender.Checked := ccbAutogender;

  se1.Value := strtoint(port);
  edIP.Text := BroadcastIP;
  edDedicIP.Text := DedicatedIP;
  seDedicServer.Value := portDedic;
  cbAuto2broad.Checked := Auto2Broad;

  if IsServer_ then
  begin
    rbDedicated.Checked := True;
    rbBroadcast.Checked := False;
  end
  else
  begin
    rbBroadcast.Checked := True;
    rbDedicated.Checked := False;
  end;

  rbBroadcast.OnClick(self);

  cbDontNotifyTab.Checked := DontNotifyTab;
  cbDontNotifyTray.Checked := DontNotifyTray;
  cbDontShowTalk.Checked := DontShowTalk;

  cbForceMsgInOffline.Checked := ForceMsgInOffline;
  cbNotifyInOffline.Checked := NotifyInOffline;
  cbUserTyping.Checked := NotifyUserTyping;
  cbFalshTaskbar.Checked := FlashTasbarOnText;
  cbForceMsgInOffline.OnClick(self);

end;

procedure ShowPanel(pn: TPanelEnum);
begin
  with fmSetup do
  begin
    pnColors.hide;
    pnUser.Hide;
    pnNotify.Hide;
    pnSound.Hide;
    pnSys.Hide;
    pnConnection.Hide;
    pnMain.Hide;
    pnInterface.Hide;
    pnFilter.Hide;
    pnFRooms.Hide;
    pnPrivate.Hide;
    pnFMessages.Hide;
    pnSecutiry.Hide;
    pnAdd.Hide;
    case pn of
      teColor: pnColors.show;
      teUser: pnUser.Show;
      teSound: pnSound.Show;
      teNotify: pnNotify.Show;
      teSysMsg: pnSys.Show;
      teConnection: pnConnection.Show;
      teCommon: pnMain.Show;
      teInterface: pnINterface.show;
      teFilter: pnFilter.Show;
      teFlRoom: pnFRooms.Show;
      tePrivate: pnPrivate.Show;
      teMsg: pnFMessages.Show;
      teSecurity: pnSecutiry.Show;
      teAdd: pnAdd.Show;
    end;
  end;
end;

procedure TfmSetup.rbLoginClick(Sender: TObject);
begin
  crbLogin := rbLogin.Checked;
  crbLast := rbLast.Checked;
end;

procedure TfmSetup.cbAutoGenderClick(Sender: TObject);
begin
  CcbAutogender := cbAutoGender.Checked;
end;

procedure TfmSetup.rbLastClick(Sender: TObject);
begin
  crbLogin := rbLogin.Checked;
  crbLast := rbLast.Checked;
end;

procedure TfmSetup.twMainDblClick(Sender: TObject);
begin
  //twMain.FullExpand;
end;

procedure TfmSetup.twMainCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := False;
end;

procedure TfmSetup.twMainChange(Sender: TObject; Node: TTreeNode);
begin

  //showmessage(inttostr(node.ItemId));
  //showmessage(inttostr(node.AbsoluteIndex));
  //lbCapt.Caption := node.Text;
  txtHeader.PageNo := node.AbsoluteIndex;

  case node.AbsoluteIndex of
    0: ShowPanel(teCommon);
    1: ShowPanel(teUser);
    2: ShowPanel(teConnection);
    3: ShowPanel(teSecurity);
    4: ShowPanel(teInterface);
    5: ShowPanel(teSound);
    6: ShowPanel(teColor);
    7: ShowPanel(teSysMsg);
    8: ShowPanel(teNotify);
    9: ShowPanel(teAdd);
    10: ShowPanel(teFilter);
    11: ShowPanel(teFlRoom);
    12: ShowPanel(tePrivate);
    13: ShowPanel(teMsg);
    //else showpanel(teMsg);
  end;

end;

procedure TfmSetup.N1Click(Sender: TObject);
begin
  if pnUser.Visible then
  begin
    if lvUserList.ItemIndex <> -1 then
    begin
      lvUserList.Selected.Delete;
      UsersChanged := True;
    end;
  end
  else if pnFRooms.Visible then
  begin
    if pgFRoom.ActivePageIndex = 0 then
    begin
      if mmNameRoom.ItemIndex <> -1 then
      begin
        Name_Room.Delete(mmNameRoom.ItemIndex);
        mmNameRoom.Items.Delete(mmNameRoom.ItemIndex);
      end;
    end
    else
    begin
      if mmIPRoom.ItemIndex <> -1 then
      begin
        IP_Room.Delete(mmIPRoom.ItemIndex);
        mmIPRoom.Items.Delete(mmIPRoom.ItemIndex);
      end;
    end;
  end
  else if pnFMessages.Visible then
  begin
    if pgFMsg.ActivePageIndex = 0 then
    begin
      if mmNameMsg.ItemIndex <> -1 then
      begin
        Name_Msg.Delete(mmNameMsg.ItemIndex);
        mmNameMsg.Items.Delete(mmNameMsg.ItemIndex);
      end;
    end
    else
    begin
      if mmIPMsg.ItemIndex <> -1 then
      begin
        IP_Msg.Delete(mmIPMsg.ItemIndex);
        mmIPMsg.Items.Delete(mmIPMsg.ItemIndex);
      end;
    end;
  end
  else if pnPrivate.Visible then
  begin
    if pgFPrivate.ActivePageIndex = 0 then
    begin
      if mmNamePriv.ItemIndex <> -1 then
      begin
        Name_Private.Delete(mmNamePriv.ItemIndex);
        mmNamePriv.Items.Delete(mmNamePriv.ItemIndex);
      end;
    end
    else
    begin
      if mmIPPriv.ItemIndex <> -1 then
      begin
        IP_Private.Delete(mmIPPriv.ItemIndex);
        mmIPPriv.Items.Delete(mmIPPriv.ItemIndex);
      end;
    end;
  end;

  UpdateSheets;
end;

procedure TfmSetup.lvUserListClick(Sender: TObject);
begin
  if lvUserList.ItemIndex <> -1 then
    edAddNick.Text := lvUserList.Selected.Caption;
  //lvUserList.Selected.Delete;
end;

procedure TfmSetup.bnNetDefClick(Sender: TObject);
var
  i, z: integer;
  tmp, tmp1: string;
begin
  se1.Value := 17889;
  tmp := uHost2IP;
  tmp1 := '';
  z := 0;
  for i := 1 to length(tmp) do
  begin
    if tmp[i] = '.' then
      z := z + 1;
    tmp1 := tmp1 + tmp[i];
    if z = 3 then
    begin
      tmp1 := tmp1 + '255';
      break;
    end;
  end;
  edip.Text := tmp1;
  seDedicServer.Value := 6666;
  edDedicIP.text := '80.252.130.250';
  edGroupKey.Text := '=DefaultKey=';
end;

procedure TfmSetup.se1Change(Sender: TObject);
begin
  port := inttostr(se1.value);
end;

procedure TfmSetup.edIPChange(Sender: TObject);
begin
  BroadcastIP := edIP.Text;
end;

procedure TfmSetup.cbDrawSmilesClick(Sender: TObject);
begin
  fmMain.aDrawSmiles.Checked := cbDrawSmiles.Checked;
end;

procedure TfmSetup.cbTrayFlashClick(Sender: TObject);
begin
  fmMain.aFlashTBIco.Checked := cbTrayFlash.Checked;
end;

procedure TfmSetup.cbSbarClick(Sender: TObject);
begin
  fmMain.aScrBarEditor.Checked := cbSbar.Checked;
  fmMain.aScrBarEditorExecute(self);
end;

procedure TfmSetup.rgUserListClick(Sender: TObject);
begin
  if rgUserList.ItemIndex = 0 then
    fmMain.aLeft.Checked := True
  else
    fmMain.aRight.Checked := True;

  fmMain.aLeft.OnExecute(self);
end;

procedure TfmSetup.rgTimeStampClick(Sender: TObject);
begin
  if rgTimeStamp.ItemIndex = 0 then
    fmMain.aHHMM.Checked := True
  else
    fmMain.aHHMMSS.Checked := True;
  fmMain.aHHMMSSExecute(Self);
end;

procedure TfmSetup.hk1Change(Sender: TObject);
begin
fmMain.GHkey.Key := hk1.HotKey;

end;

procedure TfmSetup.cbAutoUpClick(Sender: TObject);
begin
  fmMain.aPopUpNew.Checked := cbAutoUp.Checked;
end;

procedure TfmSetup.cbStartMinimizedClick(Sender: TObject);
begin
  fmMain.aStartMinim.Checked := cbStartMinimized.Checked;
end;

procedure TfmSetup.seAutoRefreshChange(Sender: TObject);
begin
  fmMain.tRfsh.Enabled := False;
  fmMain.tRfsh.Interval := seAutoRefresh.Value * 60000;
  if fmMain.tRfsh.Interval <> 0 then
    fmMain.tRfsh.Enabled := True;
end;

procedure TfmSetup.clbSysClickCheck(Sender: TObject);
begin

  //System messages state
  SysEnterExitMain := clbSys.checked[0];
  SysEnterExitChannel := clbSys.checked[1];
  SysEnterExitPrivate := clbSys.checked[2];
  SysNickChange := clbSys.checked[3];
  SysBoardChange := clbSys.checked[4];
  SysTopicChange := clbSys.checked[5];
  SysModeChange := clbSys.checked[6];
  SysMessage := clbSys.checked[7];
  SysSignal := clbSys.checked[8];

end;

procedure TfmSetup.seBallonChange(Sender: TObject);
begin
  fmMain.TimerBaloon.Interval := seBallon.Value * 1000;
end;

procedure TfmSetup.cbScrollFlashClick(Sender: TObject);
begin
  fmMain.aFlashSL.Checked := cbScrollFlash.Checked;
end;

procedure TfmSetup.cbElementChange(Sender: TObject);
var
  i: integer;
begin
  CanOnChange := False;

  i := cbElement.ItemIndex;

  edExample.Text := cbElement.Text;

  edExample.Font.Name := fmMain.RVStyle.TextStyles[i].FontName;
  edExample.Font.Color := fmMain.RVStyle.TextStyles[i].Color;

  if fmMain.RVStyle.TextStyles[i].BackColor = clNone then
    edExample.Color := clWindow
  else
    edExample.Color := fmMain.RVStyle.TextStyles[i].BackColor;

  edExample.Font.Style := fmMain.RVStyle.TextStyles[i].Style;
  edExample.Font.Size := fmMain.RVStyle.TextStyles[i].Size;
  cbFontColor.Selected := fmMain.RVStyle.TextStyles[i].Color;
  cbBackColor.Selected := fmMain.RVStyle.TextStyles[i].BackColor;

  cbCur.Checked := fmMain.RVStyle.TextStyles[i].Style = [fsItalic];
  cbBold.Checked := (fmMain.RVStyle.TextStyles[i].Style = [fsBold]);
  cbUnder.Checked := fmMain.RVStyle.TextStyles[i].Style = [fsUnderline];
  seFontSize.Value := fmMain.RVStyle.TextStyles[i].Size;
  CanOnChange := True;

  {if

  if cbCur.Checked then fstyle:=fstyle+[fsItalic];
  if cbBold.Checked then fstyle:=fstyle+[fsBold];
  if cbUnder.Checked then fstyle:=fstyle+[fsUnderline];}

end;

procedure TfmSetup.cbFontNameChange(Sender: TObject);
var
  i: integer;
  fstyle: TFontStyles;
begin
  if CanOnChange then
  begin
    i := cbElement.ItemIndex;
    //fstyle:=[];
    if cbCur.Checked then
      fstyle := fstyle + [fsItalic];
    if cbBold.Checked then
      fstyle := fstyle + [fsBold];
    if cbUnder.Checked then
      fstyle := fstyle + [fsUnderline];

    fmMain.RVStyle.TextStyles[i].FontName := cbFontName.Text;
    fmMain.RVStyle.TextStyles[i].Color := cbFontColor.Selected;
    fmMain.RVStyle.TextStyles[i].BackColor := cbBackColor.Selected;
    fmMain.RVStyle.TextStyles[i].Style := fstyle;
    fmMain.RVStyle.TextStyles[i].Size := seFontSize.Value;

    // Update
    edExample.Text := cbElement.Text;
    edExample.Font.Name := fmMain.RVStyle.TextStyles[i].FontName;
    edExample.Font.Color := fmMain.RVStyle.TextStyles[i].Color;

    if fmMain.RVStyle.TextStyles[i].BackColor = clNone then
      edExample.Color := clWindow
    else
      edExample.Color := fmMain.RVStyle.TextStyles[i].BackColor;

    edExample.Font.Style := fmMain.RVStyle.TextStyles[i].Style;
    edExample.Font.Size := fmMain.RVStyle.TextStyles[i].Size;
    edExample.Repaint;

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

    fmMain.rvMain.Format;
    fmMain.rvBoard.Format;
  end;
  {
  cbFontColor.Selected:=fmMain.RVStyle.TextStyles[i].Color;
  cbBackColor.Selected:=fmMain.RVStyle.TextStyles[i].BackColor;
  cbCur.Checked:=Boolean(fmMain.RVStyle.TextStyles[i].Style = [fsItalic]);
  cbBold.Checked:=(fmMain.RVStyle.TextStyles[i].Style = [fsBold]);
  cbUnder.Checked:=fmMain.RVStyle.TextStyles[i].Style = [fsUnderline];}
end;

procedure TfmSetup.bnBackClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 19 do
    fmMain.RVStyle.TextStyles[i].BackColor := cbBackColor.Selected;
  fmMain.rvMain.Format;
  fmMain.rvBoard.Format;
end;

procedure TfmSetup.bnNoMassMsgClick(Sender: TObject);
begin
  MassMsg := bnNoMassMsg.Checked;
end;

procedure TfmSetup.bnPrivateClick(Sender: TObject);
begin
  if pgFPrivate.ActivePageIndex = 0 then
  begin
    if not IsUserIgnoredInPrivate(lePrivate.text, '') and (Trim(lePrivate.text)
      <> '') then
    begin
      mmNamePriv.Items.add(lePrivate.text);
      Name_Private.Add(lePrivate.text);
    end;
  end
  else
  begin
    if not IsUserIgnoredInPrivate('', lePrivate.text) and (Trim(lePrivate.text)
      <> '') then
    begin
      mmIPPriv.Items.add(lePrivate.text);
      IP_Private.Add(lePrivate.text);
    end;
  end;
  UpdateSheets;
end;

procedure TfmSetup.bnMessagesClick(Sender: TObject);
begin
  if pgFMsg.ActivePageIndex = 0 then
  begin
    if not IsUserIgnoredInMsg(leMessages.text, '') and (Trim(leMessages.text) <>
      '') then
    begin
      mmNameMsg.Items.add(leMessages.text);
      Name_Msg.Add(leMessages.text);
    end;
  end
  else
  begin
    if not IsUserIgnoredInMsg('', leMessages.text) and (Trim(leMessages.text) <>
      '') then
    begin
      mmIPMsg.Items.add(leMessages.text);
      IP_Msg.Add(leMessages.text);
    end;
  end;
  UpdateSheets;
end;

procedure TfmSetup.bnRoomsClick(Sender: TObject);
begin
  if pgFRoom.ActivePageIndex = 0 then
  begin
    if not IsUserIgnoredInRooms(leRooms.text, '') and (Trim(leRooms.text) <> '')
      then
    begin
      mmNameRoom.Items.add(leRooms.text);
      Name_Room.Add(leRooms.text);
    end;
  end
  else
  begin
    if (not IsUserIgnoredInRooms('', leRooms.text)) and (Trim(leRooms.text) <>
      '') then
    begin
      mmIPRoom.Items.add(leRooms.text);
      IP_Room.Add(leRooms.text);
    end;
  end;
  UpdateSheets;
end;

procedure TfmSetup.rbBroadcastClick(Sender: TObject);
begin
  if rbDedicated.Checked then
  begin
    isServer_ := True;
    label2.Enabled := False;
    edIP.Enabled := False;
    se1.Enabled := False;
    Label21.Enabled := True;
    seDedicServer.Enabled := True;
    label19.Enabled := True;
    edDedicIP.Enabled := True;
    label3.Enabled := False;
  end
  else
  begin
    label3.Enabled := True;
    label2.Enabled := True;
    edIP.Enabled := True;
    se1.Enabled := True;
    Label21.Enabled := False;
    seDedicServer.Enabled := False;
    label19.Enabled := False;
    edDedicIP.Enabled := False;
    isServer_ := False;
  end;
end;

procedure TfmSetup.edDedicIPChange(Sender: TObject);
begin
  DedicatedIP := edDedicIP.Text;
end;

procedure TfmSetup.seDedicServerChange(Sender: TObject);
begin
  portDedic := seDedicServer.value;
end;

procedure TfmSetup.cbAuto2broadClick(Sender: TObject);
begin
  Auto2Broad := cbAuto2broad.Checked;
end;

procedure TfmSetup.bnDefaultClick(Sender: TObject);
begin
  WriteSettings;
end;

procedure TfmSetup.seAutoAwayChange(Sender: TObject);
begin
  fmMain.TimerUserActivity.Enabled := False;
  fmMain.TimerUserActivity.Tag := seAutoAway.Value * 60000;
  if fmMain.TimerUserActivity.Tag <> 0 then
    fmMain.TimerUserActivity.Enabled := True;
end;

procedure TfmSetup.edAddNickChange(Sender: TObject);
begin
  //if (CleanIncorrectSymbols(edText.t)='') and not (key in [#8]) then key:=#0;

  edAddNick.text := CleanIncorrectSymbols(edAddNick.text);
end;

procedure TfmSetup.cbColumnClick(Sender: TObject);
begin
  if cbColumn.Checked then
    fmMain.lvUser.ViewStyle := vsList
  else
    fmMain.lvUser.ViewStyle := vsReport;
end;

procedure TfmSetup.cbEnableProtectClick(Sender: TObject);
begin
  if cbEnableProtect.Checked then
  begin
    lbbuf1.Enabled := True;
    lbbuf2.Enabled := True;
    lbWarn.Enabled := True;
    seMaxPackets.Enabled := True;
    cbNotifyFilter.Enabled := True;
    isProtectEnabled := True;
    AntiFloodPacket := TStackProtect.Create;
    AntiFloodPacket.SetStackSize(MaxPackets);
  end
  else
  begin
    lbbuf1.Enabled := False;
    lbbuf2.Enabled := False;
    lbWarn.Enabled := False;
    seMaxPackets.Enabled := False;
    cbNotifyFilter.Enabled := False;
    isProtectEnabled := False;
    AntiFloodPacket.Free;
  end;
end;

procedure TfmSetup.seMaxPacketsChange(Sender: TObject);
begin
  MaxPackets := seMaxPackets.Value;
  if isProtectEnabled then
  AntiFloodPacket.SetStackSize(MaxPackets);
end;

procedure TfmSetup.cbNotifyFilterClick(Sender: TObject);
begin
  NotifyBaloon := cbNotifyFilter.Checked;
end;

procedure TfmSetup.cbForceMsgInOfflineClick(Sender: TObject);
begin
  if cbForceMsgInOffline.Checked then
  begin
    cbNotifyInOffline.Enabled := True;
  end
  else
  begin
    cbNotifyInOffline.Enabled := False;
  end;
ForceMsgInOffline := cbForceMsgInOffline.Checked;
end;

procedure TfmSetup.cbDontShowTalkClick(Sender: TObject);
begin
  if cbDontShowTalk.Checked then
  begin

    if MessageDlg('Вы действительно хотите не видить разговор в "основном"?',
      mtWarning,
      [mbYes, mbNo], 0) = mrNo then
      cbDontShowTalk.Checked := False;

  end;
  DontShowTalk := cbDontShowTalk.Checked;
end;

procedure TfmSetup.cbDontNotifyTrayClick(Sender: TObject);
begin
  DontNotifyTray := cbDontNotifyTray.Checked;
end;

procedure TfmSetup.cbDontNotifyTabClick(Sender: TObject);
begin
  DontNotifyTab := cbDontNotifyTab.Checked;
end;

procedure TfmSetup.cbNotifyInOfflineClick(Sender: TObject);
begin
  NotifyInOffline := cbNotifyInOffline.Checked;
end;

procedure TfmSetup.cbUserTypingClick(Sender: TObject);
begin
NotifyUserTyping:=cbUserTyping.Checked;
end;

procedure TfmSetup.cbFalshTaskbarClick(Sender: TObject);
begin
FlashTasbarOnText := cbFalshTaskbar.Checked;
end;

procedure TfmSetup.HKDisableSLChange(Sender: TObject);
begin
fmMain.HKDisableSL.Key := HKDisableSL.HotKey;
end;

end.


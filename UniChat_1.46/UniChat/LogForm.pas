{
UniChat - chat for LANs.
LogForm.pas - Message log form.

$Author(s): Dentall
$Last revision: 30/10/2004

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit LogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, StdCtrls, ExtCtrls, Menus,
   PJWdwState, ActnPopup;

type
  TfmMsgLog = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    lvAll: TListView;
    sb1: TStatusBar;
    ilTabs: TImageList;
    ilList: TImageList;
    lvIncoming: TListView;
    lvOutComing: TListView;
    Memo1: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Image: TImage;
    leSender: TLabeledEdit;
    leReceiver: TLabeledEdit;
    lbCap: TLabel;
    lbDate: TLabel;
    mmMessage: TMemo;
    pmArchiveMsg: TPopupActionBar;
    miMsgLog: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N1: TMenuItem;
    fd1: TFindDialog;
    PJRegWdwState1: TPJRegWdwState;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure lvAllDblClick(Sender: TObject);
    procedure lvAllCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvAllSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure pmArchiveMsgPopup(Sender: TObject);
    procedure msgHandler(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure fd1Find(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgLog: TfmMsgLog;
  last: integer;

implementation

uses main, sendform, SendMassForm, GlobalConst;

{$R *.dfm}

procedure TfmMsgLog.CreateParams(var Params: TCreateParams);

begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
end;

procedure SendMessageLog(const toUser, UserID: string);
begin
  fmSend := TFmSend.Create(nil);
  fmSend.ReceiverNick := toUser;
  fmSend.ReceiverID := UserID;
  fmSend.Caption := '-> ' + toUser;
  fmSend.mmMain.Color := fmMain.rvMain.Color;
  fmSend.mmMain.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  fmSend.mmMain.Text := fmMsgLog.mmMessage.Text;
  fmSend.Show;
end;

procedure TfmMsgLog.msgHandler(Sender: TObject);
var
  i: integer;
begin

  with fmMain do
  begin
    i := lvUser.Items.IndexOf(lvUser.FindCaption(-1, (Sender as
      TMenuItem).Caption, False, False, False));
    if i <> -1 then
    begin
      SendMessageLog((Sender as TMenuItem).Caption,
        lvUser.Items.Item[i].SubItems.Strings[0]);
    end;

  end;
end;

procedure TfmMsgLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfmMsgLog.FormDestroy(Sender: TObject);
begin
  fmMsgLog := nil;
end;

procedure TfmMsgLog.lvAllDblClick(Sender: TObject);
begin
  if (sender as TListView).SelCount > 0 then
  begin

    memo1.Text := (sender as TListView).Selected.SubItems[3];
    memo1.SelectAll;
    memo1.CopyToClipboard;

  end;
end;

procedure TfmMsgLog.lvAllCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
{var
i: integer;}
begin
  {i:=AnsiCompareStr(item1.SubItems.Strings[0], item2.SubItems.Strings[0]);
  if i>1 then
  compare:=1 else
  if i<1 then
  compare:=-1 else compare:=0;}
end;

procedure TfmMsgLog.lvAllSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  b: TBitMap;
begin

  if Selected then
  begin
    //Image.Picture.Destroy;

    {begin
    Image.Picture.Bitmap.Free;
    Image.Picture.Bitmap:=nil;
    end;}
    b := TBitmap.Create;
    b.Height := 16;
    b.Width := 16;
    ilList.GetBitmap(item.ImageIndex, b);
    Image.Picture.Bitmap := b;
    b.Free;

    if item.ImageIndex = 0 then
      lbCap.Caption := 'Входящее сообщение'
    else
      lbCap.Caption := 'Исходящее сообщение';

    lbDate.caption := item.SubItems.Strings[0];
    leSender.Text := item.SubItems.Strings[1];
    leReceiver.Text := item.SubItems.Strings[2];
    mmMessage.Text := item.SubItems.Strings[3];
    //Image.Update;
  end;
end;

procedure TfmMsgLog.pmArchiveMsgPopup(Sender: TObject);
var
  mi: TMenuItem;
  i: integer;
begin

  miMsgLog.Clear;

  for I := 0 to fmMain.lvUser.Items.Count - 1 do
  begin
    mi := TMenuItem.Create(miMsgLog);
    mi.Caption := fmMain.lvUser.Items.Item[i].Caption;
    mi.ImageIndex := fmMain.lvUser.Items.Item[i].ImageIndex;
    mi.OnClick := msgHandler;
    miMsgLog.Add(mi);
  end;

end;

procedure TfmMsgLog.N1Click(Sender: TObject);
begin
  fmMassSend := TfmMassSend.Create(nil);
  fmMassSend.lvRec.Items.Assign(fmMain.lvUser.Items);
  fmMassSend.lvRec.FindCaption(-1, CurNick, False, False, False).checked :=
    False;
  //if fmMassSend.lvRec.Items.Count>0 then
  fmMassSend.mmMain.Color := fmMain.rvMain.Color;
  fmMassSend.mmMain.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  fmMassSend.lvRec.Color := fmMain.rvMain.Color;
  fmMassSend.lvRec.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  fmMassSend.mmMain.Text := mmMessage.Text;
  fmMassSend.Show;
end;

procedure TfmMsgLog.N3Click(Sender: TObject);
begin

fd1.Execute;

end;

procedure TfmMsgLog.fd1Find(Sender: TObject);
var
  i: integer;
  z: string;
  lv: TListView;
begin
  case PageControl1.ActivePageIndex of
    0: lv := lvAll;
    1: lv := lvIncoming;
    2: lv := lvOutComing;
  else
    lv := lvAll;
  end;

if last>=lv.Items.Count - 1 then last:=0;

  for i := last to lv.Items.Count - 1 do
  begin
  z:=AnsiLowerCase(lv.Items.Item[i].SubItems.Strings[3]);
   if pos(AnsiLowercase(fd1.FindText),z)>0 then
   begin
   lv.Items.Item[i].Selected:=True;
   last:=i+1;
   exit;
   end;
  end;
for i:=0 to last -1 do
begin
  z:=AnsiLowerCase(lv.Items.Item[i].SubItems.Strings[3]);
   if pos(AnsiLowercase(fd1.FindText),z)>0 then
   begin
   lv.Items.Item[i].Selected:=True;
   last:=i+1;
   exit;
   end;
end;
last:=0;
end;

procedure TfmMsgLog.PageControl1Change(Sender: TObject);
begin
last:=0;
end;

procedure TfmMsgLog.N5Click(Sender: TObject);
begin
close;
end;

procedure TfmMsgLog.N4Click(Sender: TObject);
begin

{    if MessageDlg('Вы действительно хотите удалить архив?', mtWarning,
      [mbYes, mbNo], 0) = mrYes then}
begin
if DeleteFile(IncludeTrailingBackslash(logdir) + 'messages.clf') then
begin
lvAll.Clear;
lvIncoming.Clear;
lvOutComing.Clear;
end;
end;

end;

procedure TfmMsgLog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
      close;
end;

end.


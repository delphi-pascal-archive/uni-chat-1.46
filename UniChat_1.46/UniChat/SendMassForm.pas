{
UniChat - chat for LANs.
SendMassForm.pas - Outcoming mass message form source module.

$Author(s): Dentall
$Last revision: 11/06/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit SendMassForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Menus, Buttons,
  CheckLst, ExtCtrls, ComCtrls, GlobalConst, PJWdwState, ImgList, ToolWin;
type
  TfmMassSend = class(TForm)
    Panel4: TPanel;
    bbCancel: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    bbSend: TButton;
    lbCount: TLabel;
    mm1: TMainMenu;
    N51: TMenuItem;
    N61: TMenuItem;
    Panel1: TPanel;
    lvRec: TListView;
    Label2: TLabel;
    mmMain: Tmemo;
    Spltr: TSplitter;
    bnSelectAll: TButton;
    bnDelAll: TButton;
    tbSend: TToolBar;
    tbSmiles: TToolButton;
    tbLinks: TToolButton;
    ilIcons: TImageList;
    PJRegWdwState1: TPJRegWdwState;
    procedure bbCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbSendClick(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure mmMainKeyPress(Sender: TObject; var Key: Char);
    procedure N51Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure mmMainChange(Sender: TObject);
    procedure sbSmilesClick(Sender: TObject);
    procedure bnSelectAllClick(Sender: TObject);
    procedure bnDelAllClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sbSmilesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbLinksMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    Receiver: string;
    { Public declarations }
  end;

var
  fmMassSend: TfmMassSend;

implementation
uses main, sendform, chatutils;
{$R *.DFM}

procedure TfmMassSend.CreateParams(var Params: TCreateParams);

begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
end;

procedure TfmMassSend.bbCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfmMassSend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfmMassSend.bbSendClick(Sender: TObject);
var
  i: integer;
  RecStr: string;
begin
  recstr := '';
mmMain.Text:=Trim(mmMain.Text);
  for i := 0 to lvRec.Items.count - 1 do
    if lvRec.Items.Item[i].Checked then
      RecStr := Recstr + lvRec.Items.Item[i].Caption + #13;
  //showmessage(RecStr);
  if length(mmMain.Text) > 0 then
  begin
    sendData('@' + RecStr + #0 + CurNick + #0 + UCPlugins.ProcessOutput(mmMain.Text), '*');
    if fmMAin.aMsgInMain.Checked then
    begin
      AddTextToMain('Исходящее массовое сообщение : ' + mmMain.text, 14);
    end;
    if fmMain.aLogMsg.Checked then
      WriteMsgLog(Curnick + ' (' + ExtractUserIP(CurID) + ')', RecStr +
        ' (*.*.*.*)', mmMain.Text, 0, True);
    //WriteCache('messages.txt','сообщение к '+Recstr+#13#10'--------------------------------------------------------------------------------'+#13#10+
    //mmMain.Text+#13#10'--------------------------------------------------------------------------------'+#13#10);
  end;
  close;
end;

procedure TfmMassSend.mmMainKeyPress(Sender: TObject; var Key: Char);
var
  pos: Tpoint;

begin
  if key = #127 then
  begin
    pos := mmMain.CaretPos;
    key := #0;
    if mmMain.SelLength > 0 then
    begin
      mmMain.SelText := TransCodeToggle(mmMain.SelText);
    end
    else
    begin
      mmMain.text := TransCodeToggle(mmMain.text);
      mmMain.CaretPos := pos;
      //        SendKey(mm.Handle,Chr($23));
    end;
    //showmessage(inttostr(ord(key)));

  end
  else if key = #10 then
    bbSend.Click;

 if length(Trim(mmMain.text))>=5000 then
if key in ['0'..'9','a'..'z','A'..'Z','а'..'я','А'..'Я'] then key := #0;
end;

procedure TfmMassSend.N51Click(Sender: TObject);
var
  pos: Tpoint;
begin
  pos := fmSend.mmMain.CaretPos;
  if mmMain.SelLength > 0 then
  begin
    mmMain.SelText := TransCodeRus2Eng(mmMain.SelText);
  end
  else
  begin
    mmMain.text := TransCodeRus2Eng(mmMain.text);

  end;
  fmSend.mmMain.CaretPos := pos;
end;

procedure TfmMassSend.N61Click(Sender: TObject);
var
  pos: Tpoint;
begin
  pos := fmSend.mmMain.CaretPos;
  if mmMain.SelLength > 0 then
  begin
    mmMain.SelText := TransCodeEng2Rus(mmMain.SelText);
  end
  else
  begin
    mmMain.text := TransCodeEng2Rus(mmMain.text);

  end;
  fmSend.mmMain.CaretPos := pos;

end;

procedure TfmMassSend.mmMainChange(Sender: TObject);
var
I: integer;
pos: TPoint;
begin

i:=length(Trim(mmMain.text));
  lbCount.caption := inttostr(i);
  if i>0 then
  bbSend.Enabled:=True else
  bbSend.Enabled:=False;

   if i>5002 then
   begin
//   mmMain.text[5000]:=#0;
    mmMain.text:= Copy(mmMain.text, 1, 5000);
    pos.y:=mmMain.lines.count -1 ;
    mmMain.CaretPos := pos;
   SendKey(mmMain.Handle,Chr($23));
   end;

end;

procedure TfmMassSend.sbSmilesClick(Sender: TObject);
var
  pnt: TPoint;
begin
  fmMain.pmSmiles.Tag := 2;
  fmMassSend := self;
  pnt.X := 0;
  pnt.Y := tbSmiles.Height;
  fmMain.pmSmiles.Popup(tbSmiles.ClientToScreen(pnt).X,
    tbSmiles.ClientToScreen(pnt).Y);
end;

procedure TfmMassSend.bnSelectAllClick(Sender: TObject);
var
i: integer;
begin
for i:=0 to lvRec.Items.Count -1 do
//if lvRec.Items.Item[i].SubItems.Strings[1]<>CurID then
lvRec.Items.Item[i].Checked:=True;
end;

procedure TfmMassSend.bnDelAllClick(Sender: TObject);
var
i: integer;
begin
for i:=0 to lvRec.Items.Count -1 do
//if lvRec.Items.Item[i].SubItems.Strings[1]<>CurID then
lvRec.Items.Item[i].Checked:=False;
end;

procedure TfmMassSend.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    if (mmMain.Text = '') or NoAskClose then
      close
    else
    begin
      if MessageDlg('Сообщение не отправлено. Все равно закрыть окно?',
        mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then
        close;
    end;
end;

procedure TfmMassSend.sbSmilesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button = mbRight then
  begin
    fmMassSend := self;
    fmMain.pmSmiles.Tag := 2;
  end;
end;

procedure TfmMassSend.tbLinksMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     fmMassSend := self;
    fmMain.pmLink.Tag := 2;
end;

end.

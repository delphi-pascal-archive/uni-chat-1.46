{
UniChat - chat for LANs.
SendForm.pas - Outcoming message form source module.

$Author(s): Dentall, Dr. Evil
$Last revision: 11/06/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2005 GlumClub team
}

unit SendForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Menus, Buttons,
  CheckLst, ExtCtrls, GlobalConst, PJWdwState, ImgList, ComCtrls, ToolWin;
type
  TfmSend = class(TForm)
    Panel4: TPanel;
    bbCancel: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    bbSend: TButton;
    lbCount: TLabel;
    mmMain: TMemo;
    mm1: TMainMenu;
    N51: TMenuItem;
    N61: TMenuItem;
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sbSmilesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbLinksMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    ReceiverNick: string;
    ReceiverID: string;
    { Public declarations }
  end;

var
  fmSend: TfmSend;

implementation
uses main, chatutils;
{$R *.DFM}

procedure TfmSend.CreateParams(var Params: TCreateParams);

begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
end;

procedure TfmSend.bbCancelClick(Sender: TObject);
begin
 close;
end;

procedure TfmSend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.TimerWriteOut.Enabled := False;
   SendData('m' + CurNick + #0 + CurMode + #0 + CurSex + #0 + CurActive, ReceiverID);
  Action := CaFree;
end;

procedure TfmSend.bbSendClick(Sender: TObject);
//var
//i: integer;
begin
  if length(mmMain.Text) > 0 then
  begin

    //i:=fmMain.lvUser.Items.IndexOf(fmMain.lvUser.FindCaption(-1,Receiver,False,False,False));
    //if i<>-1 then
    //begin
    mmMain.Text := Trim(mmMain.Text);

    SendData('s' + ReceiverID + #0 + CurNick + #0 + UCPlugins.ProcessOutput(mmMain.Text), ReceiverID);

    if fmMain.aMsgInMain.Checked then
    begin
      AddTextToMain('Исходящее к ' + ReceiverNick + ': ' + mmMain.text, 14);
    end;
    if fmMain.aLogMsg.Checked then
      WriteMsgLog(Curnick + ' (' + ExtractUserIP(CurID) + ')', ReceiverNick +
        ' (' + ExtractUserIP(ReceiverID) + ')', mmMain.Text, 0, True);
    //   WriteCache('messages.txt','сообщение к '+ReceiverNick+#13#10'--------------------------------------------------------------------------------'+#13#10+
    //    mmMain.Text+#13#10'--------------------------------------------------------------------------------'+#13#10);
    //end else showmessage('Ошибка отправки: данного пользователя нет');
  end;
 close;
end;

procedure TfmSend.mmMainKeyPress(Sender: TObject; var Key: Char);
var
  pos: Tpoint;

begin
  if key = #127 then
  begin
    pos := fmSend.mmMain.CaretPos;
    key := #0;
    if fmSend.mmMain.SelLength > 0 then
    begin
      fmSend.mmMain.SelText := TransCodeToggle(fmSend.mmMain.SelText);
    end
    else
    begin
      fmSend.mmMain.text := TransCodeToggle(fmSend.mmMain.text);
      fmSend.mmMain.CaretPos := pos;
      //        SendKey(mm.Handle,Chr($23));
    end;

  end
  else if key = #10 then
  begin
  key:=#0;
    if bbSend.Enabled then
      bbSend.Click;
  end;

if length(Trim(mmMain.text))>=5000 then
if key in ['0'..'9','a'..'z','A'..'Z','а'..'я','А'..'Я'] then key := #0;

end;

procedure TfmSend.N51Click(Sender: TObject);
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

procedure TfmSend.N61Click(Sender: TObject);
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

procedure TfmSend.mmMainChange(Sender: TObject);
var
  I: integer;
  pos: TPoint;
begin
  i := length(Trim(mmMain.text));
  lbCount.caption := inttostr(i);
  if i > 0 then
    bbSend.Enabled := True
  else
    bbSend.Enabled := False;
  if NotifyUserTyping then
  begin
   if fmMain.TimerWriteOut.Enabled then
      begin
        fmMain.TimerWriteOut.Enabled := False;
        fmMain.TimerWriteOut.Enabled := True;
      end
      else
      begin
        fmMain.TimerWriteOut.Enabled := True;

    SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 + ReceiverID
    , ReceiverID);
      end;
   end;
   if i>5002 then
   begin
//   mmMain.text[5000]:=#0;
    mmMain.text:= Copy(mmMain.text, 1, 5000);
    pos.y:=mmMain.lines.count -1 ;
    mmMain.CaretPos := pos;
   SendKey(mmMain.Handle,Chr($23));
   end;

end;

procedure TfmSend.sbSmilesClick(Sender: TObject);
var
  pnt: TPoint;
begin
  fmSend := self;
  fmMain.pmSmiles.Tag := 1;
  pnt.X := 0;
  pnt.Y := tbSmiles.Height;
  fmMain.pmSmiles.Popup(tbSmiles.ClientToScreen(pnt).X,
    tbSmiles.ClientToScreen(pnt).Y);

end;

procedure TfmSend.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfmSend.sbSmilesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbRight then
  begin
    fmSend := self;
    fmMain.pmSmiles.Tag := 1;
  end;
end;

procedure TfmSend.tbLinksMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    fmSend := self;
    fmMain.pmLink.Tag := 1;
end;

end.


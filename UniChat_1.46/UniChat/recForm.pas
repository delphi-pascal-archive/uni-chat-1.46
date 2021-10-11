{
UniChat - chat for LANs.
recform.pas - Incoming message form source module.

$Author(s): Dentall
$Last revision: 29/12/2004


All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit recform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  GlobalConst, RVScroll, RichView, CRVFData, PJWdwState;

type
  TfmRec = class(TForm)
    Bevel1: TBevel;
    lbDate: TLabel;
    bnOK: TButton;
    bnTalk: TButton;
    bnAnswer: TButton;
    rvMain: TRichView;
    Button1: TButton;
    bnCitate: TButton;
    sbArchive: TSpeedButton;
    PJRegWdwState1: TPJRegWdwState;
    procedure bnOKClick(Sender: TObject);
    procedure bnTalkClick(Sender: TObject);
    procedure bnAnswerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure bnCitateClick(Sender: TObject);
    procedure rvMainJump(Sender: TObject; id: Integer);
    procedure sbArchiveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    MsgSenderNick: string;
    MsgSenderID: string;
    { Public declarations }
  end;

var
  fmRec: TfmRec;

implementation

uses sendform, shellapi, chatutils, main, SendMassForm;

{$R *.DFM}

procedure TfmRec.CreateParams(var Params: TCreateParams);

begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;


end;

procedure TfmRec.bnOKClick(Sender: TObject);
begin
  close;
end;

procedure TfmRec.bnTalkClick(Sender: TObject);
begin
  //SendData('j'+CurNick+#0+msgSenderNick);
  SendData('j' + CurNick + #0 + MsgSenderID, MsgSenderID);
   close;
end;

procedure TfmRec.bnAnswerClick(Sender: TObject);
begin
  fmSend := TFmSend.Create(nil);
  fmSend.ReceiverNick := MsgSenderNick;
  fmSend.ReceiverID := MsgSenderID;
  fmSend.Caption := '-> ' + MsgSenderNick;
  fmSend.mmMain.Color := rvMain.Color;
  fmSend.mmMain.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  fmSend.mmMain.Font.Name:=fmMain.RVStyle.TextStyles.Items[0].FontName;
  fmSend.mmMain.Font.Style:=fmMain.RVStyle.TextStyles.Items[0].Style;
  fmSend.mmMain.Font.Size:=fmMain.RVStyle.TextStyles.Items[0].size;
  fmSend.Show;
  if NotifyUserTyping then
  begin
  SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
  MsgSenderID, MsgSenderID);
  fmMain.TimerWriteOut.Enabled:=True;
  end;
   close;
end;

procedure TfmRec.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := CaFree;
end;

procedure TfmRec.bnCitateClick(Sender: TObject);
var
  pn: TPoint;
  i: integer;
begin
  fmSend := TFmSend.Create(nil);
  fmSend.ReceiverNick := MsgSenderNick;
  fmSend.ReceiverID := MsgSenderID;
  fmSend.Caption := '-> ' + MsgSenderNick;

  fmSend.mmMain.Color := rvMain.Color;
  fmSend.mmMain.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  fmSend.mmMain.Font.Name:=fmMain.RVStyle.TextStyles.Items[0].FontName;
  fmSend.mmMain.Font.Style:=fmMain.RVStyle.TextStyles.Items[0].Style;
  fmSend.mmMain.Font.Size:=fmMain.RVStyle.TextStyles.Items[0].size;

{   fmSend.mmMain.Lines.Add('');

  for s in rvMain.RVData.Items do
  begin
    if (s <> '') then
    if copy(s,1,3) <> '>> ' then
    fmSend.mmMain.Lines.Add('> '+s);
  end;}

  fmSend.mmMain.Lines.Assign(rvMain.RVData.Items);
  fmSend.mmMain.Lines.Insert(0,'');

  for i := fmSend.mmMain.Lines.count-1 downto 1 do
    if (fmSend.mmMain.Lines.Strings[i] <> '') then
    begin
    if copy(fmSend.mmMain.Lines.Strings[i],1,2) = '> ' then
    fmSend.mmMain.Lines.Delete(i) else
      fmSend.mmMain.Lines.Strings[i] := '> ' + fmSend.mmMain.Lines.Strings[i];
    end;

  pn.X := 0;
  pn.Y := 0;
  fmSend.mmMain.CaretPos := pn;
  fmSend.Show;
  if NotifyUserTyping then
  begin
  SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
  MsgSenderID, MsgSenderID);
  fmMain.TimerWriteOut.Enabled:=True;
  end;
  close;
  
end;

procedure TfmRec.rvMainJump(Sender: TObject; id: Integer);
var
  RVData: TCustomRVFormattedData;
  ItemNo: Integer;
  url: string;
begin
  (sender as TrichView).GetJumpPointLocation(id, RVData, ItemNo);
  url := RVData.GetItemTextA(ItemNo);
  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOW);
end;

procedure TfmRec.sbArchiveClick(Sender: TObject);
begin
  ReadMsgLog;
end;

procedure TfmRec.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #10 then
  begin
    bnAnswer.click;
  end
  else if key = #27 then
    close else
  if (rvMain.tag=1) and (key=#13) then
    bnCitate.Click;

end;

procedure TfmRec.FormShow(Sender: TObject);
begin
  if (CurMode in ['1', '4']) then
    showWindow(handle, SW_SHOWMINNOACTIVE) else
if (CurActive = '0') then
begin

    showWindow(handle, SW_SHOWNOACTIVATE);


end;
end;

procedure TfmRec.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
rvMain.tag:=0;
end;

procedure TfmRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ssShift in shift then rvMain.tag:=1 else rvMain.tag:=0;
end;

end.


unit topicform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PJWdwState, Menus;

type
  TfmTopic = class(TForm)
    leTopic: TLabeledEdit;
    bnOK: TButton;
    bnCancel: TButton;
    PJRegWdwState1: TPJRegWdwState;
    mm1: TMainMenu;
    N51: TMenuItem;
    N61: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure leTopicKeyPress(Sender: TObject; var Key: Char);
    procedure N61Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure leTopicChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTopic: TfmTopic;

implementation
uses main;
{$R *.dfm}

procedure TfmTopic.leTopicChange(Sender: TObject);
begin
if length(leTopic.Text)>256 then
begin
leTopic.Text:= Copy(leTopic.Text,1,256);
SendKey(leTopic.Handle, Chr($23));
end;
end;

procedure TfmTopic.N51Click(Sender: TObject);
begin

  if leTopic.SelLength > 0 then
  begin
    leTopic.SelText := TransCodeRus2Eng(leTopic.SelText);
  end
  else
  begin
    leTopic.text := TransCodeRus2Eng(leTopic.text);
    SendKey(leTopic.Handle, Chr($23));
  end;
end;

procedure TfmTopic.N61Click(Sender: TObject);
begin
  if leTopic.SelLength > 0 then
  begin
    leTopic.SelText := TransCodeEng2Rus(leTopic.SelText);
  end
  else
  begin
    leTopic.text := TransCodeEng2Rus(leTopic.text);
    SendKey(leTopic.Handle, Chr($23));
  end;
end;

procedure TfmTopic.leTopicKeyPress(Sender: TObject; var Key: Char);
begin
case key of
#127:
begin
key:=#0;
if leTopic.SelLength > 0 then
  begin
    leTopic.SelText := TransCodeToggle(leTopic.SelText);
  end
  else
  begin
    leTopic.text := TransCodeToggle(leTopic.text);
    SendKey(leTopic.Handle, Chr($23));
  end;
end;
#13:
    begin
    key:=#0;
    bnOK.click;
    end;
#27: close;

end;
end;

procedure TfmTopic.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

end.

{
UniChat - chat for LANs.
commentform.pas - Enter comment form source module.

$Author(s): Dentall
$Last revision: 05/09/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit commentform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, PJWdwState;

type
  TfmComment = class(TForm)
    cbData: TComboBox;
    bnOK: TButton;
    bnCancel: TButton;
    PJRegWdwState1: TPJRegWdwState;
    procedure N61Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure cbDataKeyPress(Sender: TObject; var Key: Char);
    procedure bnOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmComment: TfmComment;

implementation

uses StdConvs, main;

{$R *.dfm}

procedure TfmComment.cbDataKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  if key = #13 then
  begin
  key := #0;
  cbData.SelLength:=0;
  bnOK.Click;
  end
  else if key = #127 then
  begin
    if cbData.SelLength > 0 then
    begin
      cbData.SelText := TransCodeToggle(cbData.SelText);
    end
    else
    begin

      cbData.text := TransCodeToggle(cbData.text);
      SendKey(cbData.Handle, Chr($23));
    end;
    key := #0;
  end;
end;

procedure TfmComment.bnOKClick(Sender: TObject);
var
  i: integer;
  fdata: string;
begin
//  if cbData.Text <> '' then
  begin

fdata:=Trim(copy(cbData.Text,1,128));

   if Trim(fData)<>'' then
   begin
    for i := 0 to cbData.items.Count - 1 do
      if cbdata.Items[i] = fData then
        exit;
    cbData.Items.Add(fData);
    end;
  end;

{    begin

      if length(cbData.Text) <= 128 then
      begin

        for i := 0 to cbData.items.Count - 1 do

      if Trim(cbData.Text)<>'' then
      begin
          if cbdata.Items[i] = cbData.Text then
          begin
          modalResult := mrOk;
          exit;
          end;
        cbData.Items.Add(cbData.Text);
      end;
        modalResult := mrOk;
      end
      else
        showmessage('Комментарий не может превышать 128 символов. Будьте кратки!');
    end;

 }
end;

procedure TfmComment.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #27 then
    close;
end;

procedure TfmComment.N51Click(Sender: TObject);
begin
  if cbData.SelLength > 0 then
  begin
    cbData.SelText := TransCodeRus2Eng(cbData.SelText);
  end
  else
  begin
    cbData.text := TransCodeRus2Eng(cbData.text);
    SendKey(cbData.Handle, Chr($23));
  end;
end;

procedure TfmComment.N61Click(Sender: TObject);
begin
    if cbData.SelLength > 0 then
  begin
    cbData.SelText := TransCodeEng2Rus(cbData.SelText);
  end
  else
  begin
    cbData.text := TransCodeEng2Rus(cbData.text);
    SendKey(cbData.Handle, Chr($23));
  end;
end;

end.

{
UniChat - chat for LANs.
regform.pas - registration form source module.

$Author(s): Dentall
$Last revision: 02/05/2006

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2006 GlumClub team
}
unit regForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, registry;

type
  TfmRegistration = class(TForm)
    leName: TLabeledEdit;
    leCode: TLabeledEdit;
    bnOK: TButton;
    bnCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRegistration: TfmRegistration;

implementation

uses  chatutils, main;

{$R *.dfm}

procedure TfmRegistration.bnOKClick(Sender: TObject);
var
  sIniFile: TRegIniFile;
  sPath: string;
begin
SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_WRITE);
  sIniFile.LazyWrite := True;

if (leCOde.text<>'') and (leName.Text<>'') then
begin
  if (leCOde.text='forever freeware') and (leName.Text='UniChat') then
  begin
  showmessage('Бесплатная регистрация прошла успешно');
   sIniFile.WriteInteger('', 'Register', 1);
   sIniFile.WriteString('','RegName','UniChat');
   sIniFile.WriteString('','RegKey',UserKey(GetHDDSerial));
   fmMain.NTimer.enabled := False;
   ModalResult := mrOk;
  end else
      if leCode.Text <> UserKey(leName.Text) then showmessage('Неверный код')
      else
        if leCode.Text = UserKey(leName.Text) then
        begin
        showmessage('Регистрация прошла успешно. Спасибо за поддержку!');
        sIniFile.WriteInteger('', 'Register', 2);
        sIniFile.WriteString('','RegName',leName.Text);
        sIniFile.WriteString('','RegKey',UserKey(GetHDDSerial));
        fmMain.NTimer.enabled := False;
        modalresult:=mrOK;
        end;
end else ModalResult := mrOk;
sIniFile.Free;
end;

procedure TfmRegistration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := CaFree;
end;

end.

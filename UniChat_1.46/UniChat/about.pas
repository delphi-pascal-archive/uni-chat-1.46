{
UniChat - chat for LANs.
about.pas - About form module.

$Author(s): Dentall
$Last revision: 24/02/2006

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2006 GlumClub team
}

unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RVStyle, RVScroll, RichView, main, CRVFData, jpeg,
  Registry;

type
  TfmAbout = class(TForm)
    Image1: TImage;
    Label3: TLabel;
    lbVer: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Memo1: TMemo;
    lbRCapt: TLabel;
    mmRegInfo: TMemo;
    Label4: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation
uses ShellAPI, chatUtils,  ExecuteThread;
{$R *.dfm}

procedure TfmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := caFree;
end;

procedure TfmAbout.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfmAbout.FormCreate(Sender: TObject);
var
  sIniFile: TRegIniFile;
  sPath: string;

begin

lbVer.Caption := 'Версия '+GetFileVersion('unichat.exe');


  SPath := 'Software\UniChat145';
  sIniFile := TRegIniFile.Create(sPath, KEY_READ);

  if sIniFile.ReadInteger('','Register',0) > 1 then

  if sIniFile.ReadString('','RegKey','') = UserKey(GetHDDSerial) then
  begin
  lbRCapt.Visible := True;
  mmRegInfo.Visible := True;
  sPath:=sIniFile.ReadString('','RegName','');
  mmRegInfo.lines.add(sPath);
  mmRegInfo.Lines.Add(UserKey(sPath));
  end else


sIniFile.Free;

{if (leCOde.text<>'') and (leName.Text<>'') then
begin
  if (leCOde.text='forever freeware') and (leName.Text='UniChat') then
  begin
  showmessage('Бесплатная регистрация прошла успешно');
   sIniFile.WriteInteger('', 'Register', 1);
   sIniFile.WriteString('','RegName','UniChat');
   sIniFile.WriteString('','RegKey',UserKey(uGetComputerName));
   ModalResult := mrOk;
  end else
      if leCode.Text <> UserKey(leName.Text) then showmessage('Неверный код')
      else
        if leCode.Text = UserKey(leName.Text) then
        begin
        showmessage('Регистрация прошла успешно. Спасибо за поддержку!');
        sIniFile.WriteInteger('', 'Register', 2);
        sIniFile.WriteString('','RegName',leName.Text);
        sIniFile.WriteString('','RegKey',UserKey(uGetComputerName));
        modalresult:=mrOK;
        end;
end else ModalResult := mrOk;}

end;

procedure TfmAbout.Image1Click(Sender: TObject);
var
  thread: TExecuteURLThread;
begin
  thread := TExecuteURLThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Priority := tpNormal;
  thread.url := 'http:\\www.unichat.net.ru';
  thread.Resume;
end;

end.


{
UniChat - chat for LANs.
infoform.pas - User information form module.

$Author(s): Dentall, Dr. Evil
$Last revision: 30/10/2004

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit infoform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GlobalConst, PJWdwState;

type
  TfmInfo = class(TForm)
    bnOK: TButton;
    bnRefresh: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label7: TLabel;
    edWindow: TEdit;
    Bevel3: TBevel;
    mm: TMemo;
    Label9: TLabel;
    lbChan: TListBox;
    Bevel4: TBevel;
    edUsrNfo: TEdit;
    Label10: TLabel;
    Bevel5: TBevel;
    edUser: TEdit;
    edIP: TEdit;
    edOS: TEdit;
    eduVer: TEdit;
    edTotal: TEdit;
    edUse: TEdit;
    lbComp: TLabel;
    PJRegWdwState1: TPJRegWdwState;
    TimerAR: TTimer;
    procedure edIPClick(Sender: TObject);
    procedure TimerARTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbCompClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bnOKClick(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure bnRefreshClick(Sender: TObject);
    procedure lbChanDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private

    { Private declarations }
  public
    USER_ID: string;
    { Public declarations }
  end;

var
  fmInfo: TfmInfo;

implementation
uses ShellAPI, main,executethread;
{$R *.dfm}

procedure TfmInfo.CreateParams(var Params: TCreateParams);

begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
end;

procedure TfmInfo.lbCompClick(Sender: TObject);
var
  thread: TExecuteURLThread;
begin
  thread := TExecuteURLThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Priority := tpNormal;
  thread.url := lbComp.Caption;
  thread.Resume;
end;

procedure TfmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfmInfo.bnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfmInfo.bnRefreshClick(Sender: TObject);
begin
  if not TimerAR.Enabled then
  begin
  SendData('G' + CurNick + #0 + User_ID, '*');
  close;
end;

end;

procedure TfmInfo.lbChanDblClick(Sender: TObject);
var
  s: string;
begin

  if lbChan.ItemIndex <> -1 then
  begin
    s := lbChan.Items[lbChan.itemindex];
    if ispagePresent(s) = -1 then
    begin
      fmMain.createTab(s, 4);
      SendData('K' + CurNick + #0 + s + #0 + CurSex, '*');
      SendData('!' + CurNick + #0 + s, '*');
    end;
  end;
end;

procedure TfmInfo.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #27 then
    close;
end;

procedure TfmInfo.FormCreate(Sender: TObject);
begin
TimerARTimer(self);
TimerAR.Enabled := True;
end;

procedure TfmInfo.TimerARTimer(Sender: TObject);
begin
   bnRefresh.Tag := bnRefresh.Tag - 1;
   bnRefresh.Caption := '∆дите '+inttostr(bnRefresh.Tag);
   if bnRefresh.Tag = 0 then
   begin
   bnRefresh.Caption := 'ќбновить';
   bnRefresh.Enabled := True;
   TimerAR.Enabled := False;
   end;
end;

procedure TfmInfo.edIPClick(Sender: TObject);
var
  thread: TExecuteURLThread;
begin
  thread := TExecuteURLThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Priority := tpNormal;
  thread.url := '\\'+edIP.text+'\';
  thread.Resume;
end;

end.

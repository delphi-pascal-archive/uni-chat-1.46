{
UniChat - chat for LANs.
RoomsForm.pas - Rooms form.

$Author(s): Dentall
$Last revision: 24/11/2004

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2004 GlumClub team
}

unit RoomsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, main, GlobalConst,
  PJWdwState;

type
  TfmRooms = class(TForm)
    lvUserRooms: TListView;
    lvChatRooms: TListView;
    Label1: TLabel;
    Label2: TLabel;
    bnCreate: TButton;
    bnCopy: TButton;
    Bevel1: TBevel;
    cbShowRooms: TCheckBox;
    cbInform: TCheckBox;
    Label3: TLabel;
    cbActiveRoom: TComboBox;
    Bevel2: TBevel;
    Label4: TLabel;
    bnClose: TButton;
    bnDelete: TButton;
    bnAdd: TButton;
    bnRefresh: TButton;
    FormStateNew: TPJWdwState;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bnCloseClick(Sender: TObject);
    procedure bnAddClick(Sender: TObject);
    procedure bnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bnCreateClick(Sender: TObject);
    procedure bnRefreshClick(Sender: TObject);
    procedure bnCopyClick(Sender: TObject);
    procedure lvUserRoomsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure cbActiveRoomChange(Sender: TObject);
    procedure lvChatRoomsDblClick(Sender: TObject);
    procedure cbShowRoomsClick(Sender: TObject);
    procedure cbInformClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRooms: TfmRooms;

implementation

{$R *.dfm}

procedure TfmRooms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfmRooms.bnCloseClick(Sender: TObject);
begin
  ShowMyRooms := cbShowRooms.Checked;
  NotifyNewRoom := cbInform.Checked;
  DefaultRoom := cbActiveRoom.Items.Strings[cbActiveRoom.ItemIndex];
  WriteRooms;
  close;
end;

procedure TfmRooms.bnAddClick(Sender: TObject);
var
  s: string;
begin
  InputQuery('Создать комнату', 'Введите название комнаты', s);
  s := Copy(Trim(s),1,32);
  if length(s) > 1 then
  begin
    if s[1] <> '#' then
      s := '#' + s;
    with lvUserRooms.Items.Add do
    begin
      Caption := s;
      ImageIndex := 4;
    end;

  end;
end;

procedure TfmRooms.bnDeleteClick(Sender: TObject);
begin
  if lvUserRooms.ItemIndex <> -1 then
    lvUserRooms.Selected.Delete;
end;

procedure TfmRooms.FormCreate(Sender: TObject);
begin
  cbShowRooms.Checked := ShowMyRooms;
  cbInform.Checked := NotifyNewRoom;
  SendData('f' + Curnick, '*');
end;

procedure TfmRooms.bnCreateClick(Sender: TObject);
var
  i: integer;
begin
  if lvUserRooms.ItemIndex <> -1 then
  begin
    i := lvChatRooms.Items.IndexOf(lvChatRooms.FindCaption(-1,
      lvUserRooms.Selected.Caption, False, False, False));
    if i = -1 then
    begin

      if NotifyNewRoom and (RoomsCreated<3) then
      begin
        SendData('r' + lvUserRooms.Selected.Caption + #0 + Curnick + #0 +
          CurSex,
          '*');
        inc(RoomsCreated);
      end;
      with lvChatRooms.Items.Add do
      begin
        Caption := lvUserRooms.Selected.Caption;
        ImageIndex := lvUserRooms.Selected.ImageIndex;
      end;
      fmMain.createTab(lvUserRooms.Selected.Caption, 4);
      SendData('K' + CurNick + #0 + lvUserRooms.Selected.Caption + #0 + CurSex,
        '*');
      SendData('!' + CurNick + #0 + lvUserRooms.Selected.Caption, '*');
    end;
  end;
end;

procedure TfmRooms.bnRefreshClick(Sender: TObject);
begin
  lvChatRooms.Clear;
  SendData('f' + Curnick, '*');
end;

procedure TfmRooms.bnCopyClick(Sender: TObject);
var
  i: integer;
begin
  if lvChatRooms.ItemIndex <> -1 then
  begin
    i := lvUserRooms.Items.IndexOf(lvUserRooms.FindCaption(-1,
      lvChatRooms.Selected.Caption, False, False, False));
    if i = -1 then
    begin
      with lvUserRooms.Items.Add do
      begin
        Caption := lvChatRooms.Selected.Caption;
        ImageIndex := lvChatRooms.Selected.ImageIndex;
        checked := False;
      end;
    end;
  end;
end;

procedure TfmRooms.lvUserRoomsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  i: integer;
begin
  cbActiveRoom.Items.Clear;
  cbActiveRoom.Items.Add('Основной');
  for i := 0 to lvUserRooms.Items.Count - 1 do
    if lvUserRooms.Items.Item[i].Checked then
      cbActiveRoom.Items.add(lvUserRooms.Items.Item[i].Caption);
  i := fmRooms.cbActiveRoom.Items.IndexOf(DefaultRoom);
  if i = -1 then
    i := 0;
  fmRooms.cbActiveRoom.ItemIndex := i;
end;

procedure TfmRooms.cbActiveRoomChange(Sender: TObject);
begin
  defaultRoom := cbActiveRoom.Items[cbActiveRoom.itemindex];
end;

procedure TfmRooms.lvChatRoomsDblClick(Sender: TObject);
begin
  if lvChatRooms.SelCount > 0 then
    if IsPagePresent(lvChatRooms.Selected.Caption) = -1 then
    begin
      fmMain.createTab(lvChatRooms.Selected.Caption, 4);
      SendData('K' + CurNick + #0 + lvChatRooms.Selected.Caption + #0 + CurSex,
        '*');
      SendData('!' + CurNick + #0 + lvChatRooms.Selected.Caption, '*');
    end;
end;

procedure TfmRooms.cbShowRoomsClick(Sender: TObject);
begin
ShowMyRooms := cbShowRooms.Checked;
end;

procedure TfmRooms.cbInformClick(Sender: TObject);
begin
NotifyNewRoom := cbInform.Checked;
end;

end.

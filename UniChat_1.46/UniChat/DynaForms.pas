unit DynaForms;

interface

uses Classes, SendForm,main,globalconst;

type
 TMessageForms = class(TObject)
 private
   FFormsList: Tlist;
 protected

 public
   constructor Create;
   destructor Destroy; override;


   procedure NewMsgForm(const toUser, UserID: string);
//   procedure IncomingMessage(const toUser, UserID: string);

 end;

implementation

constructor TMessageForms.Create;
begin
   FFormsList := TList.Create;

  inherited Create;
end;

destructor TMessageForms.Destroy;
var
i: integer;
begin

  for i:=0 to FFormsList.Count - 1 do
  begin
  FFormsList.Items[i];
  end;

  inherited Destroy;
end;

procedure TMessageForms.NewMsgForm(const toUser, UserID: string);
var
form: TfmSend;
begin

form := TfmSend.Create(nil);

  form.ReceiverNick := toUser;
  form.ReceiverID := UserID;
  form.Caption := toUser+ ': обмен сообщениями - UniChat';
  form.mmMain.Color := fmMain.rvMain.Color;
  form.mmMain.Font.Color := fmMain.RVStyle.TextStyles.Items[0].Color;
  form.mmMain.Font.Name := fmMain.RVStyle.TextStyles.Items[0].FontName;
  form.mmMain.Font.Style := fmMain.RVStyle.TextStyles.Items[0].Style;
  form.mmMain.Font.Size := fmMain.RVStyle.TextStyles.Items[0].size;
  form.Show;

  if NotifyUserTyping then
  begin
    SendData('8' + CurNick + #0 + CurMode + #0 + CurSex + #0 +
      UserID, UserID);
    fmMain.TimerWriteOut.Enabled := True;
  end;

   FFormsList.Add(form);
end;

end.

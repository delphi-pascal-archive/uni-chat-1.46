unit regInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmRegInfo = class(TForm)
    Memo1: TMemo;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRegInfo: TfmRegInfo;

implementation

uses regForm;

{$R *.dfm}

procedure TfmRegInfo.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfmRegInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := CaFree;
end;

procedure TfmRegInfo.Button2Click(Sender: TObject);
begin
  fmRegistration := TfmRegistration.Create(nil);
  fmRegistration.ShowModal;
  fmRegistration.Free;
end;

end.

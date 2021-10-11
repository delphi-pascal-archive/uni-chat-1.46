{------------------------------------------------------------------------------
  Unit     : fishotKey.pas
  Purpose  : System hot key handling
  Status   : Freeware
  Copyright: ©2000 First Internet Software House, http://www.fishouse.com
  contact  : support@fishouse.com
-------------------------------------------------------------------------------

  History:

  Date                By      Comments
  ----                ----    --------
  18 May 2000         ME      Created
}
unit fisHotKey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, menus;

type
  TfisHotKey = class(TComponent)
  private
    FEnabled: Boolean;
    FRegistered: Boolean;
    FHotkey: TSHortcut;
    FOnHotKeyPressed: TNotifyEvent;

    FHandle: HWND;

    procedure RegisterKey;
    procedure UnRegisterKey;
    { Private declarations }
  protected
    { Protected declarations }
    procedure SetEnabled(const Value: Boolean);
    procedure SetHotKey(const Value: TShortcut);
    procedure NewWindowProc(var Msg: TMessage); virtual;
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Registered: boolean read FRegistered;
  published
    { Published declarations }
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property Key: TShortcut read FHotkey write SetHotkey;
    property OnHotKey: TNotifyEvent read FOnHotKeyPressed write FOnHotKeyPressed;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FISH', [TfisHotKey]);
end;

{ TfisHotKey }

constructor TfisHotKey.Create(aOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FHotKey := 0;
  FRegistered := false;
  if not (csDesigning in ComponentState) then
  begin
   FHandle := Classes.AllocateHWnd(NewWindowProc);
  end;
end;

destructor TfisHotKey.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    UnRegisterKey;
    Classes.DeallocateHWnd(FHandle);
  end;
  inherited;
end;

procedure TfisHotKey.Loaded;
begin
  inherited;
  if (FEnabled) and (not (csDesigning in ComponentState)) then RegisterKey;
end;

procedure TfisHotKey.NewWindowProc(var Msg: TMessage);
begin
  case Msg.Msg of
    WM_HOTKEY:
    begin
      if assigned(FOnHotkeyPressed) then FOnHotKeyPressed(self);
    end;
  end;

  Msg.Result := DefWindowProc(FHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TfisHotKey.RegisterKey;
var
  lVKey: word;
  lvShift: TShiftstate;
  lModifier: UINT;
begin

    lModifier := 0;
    ShortcutToKey(FHotkey, lvKey, lvShift);
    if ssShift in lvShift  then lModifier := lModifier or MOD_SHIFT;
    if ssAlt in lvShift then lModifier := lModifier or MOD_ALT;
    if ssCtrl in lvShift then lModifier := lModifier or MOD_CONTROL;
    FRegistered := RegisterHotKey(FHandle, integer(key),
                    lModifier, LOBYTE(lVKey));

end;

procedure TfisHotKey.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if FEnabled then RegisterKey else UnregisterKey;
end;

procedure TfisHotKey.UnRegisterKey;
begin
  if FRegistered then
  begin
    UnregisterHotKey(FHandle, integer(key));
    FRegistered := False;
  end;
end;

procedure TfisHotKey.SetHotKey(const Value: TShortcut);
begin
  if Value <> FHotkey then
  begin
    FHotkey := Value;
    if not (csDesigning in ComponentState) then
    begin
        UnRegisterKey;
        RegisterKey;
    end;
  end;
end;

end.

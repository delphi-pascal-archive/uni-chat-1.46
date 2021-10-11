{

TStatusBarPro v1.1 - An improved version of Borland TStatusBar
by Kambiz R. Khojasteh

email: khojasteh@www.dci.co.ir
web: http://www.crosswinds.net/~khojasteh/

Special thanks to:
  Rudi Loos (loos@intekom.co.za) for adding Color property to panels.

}

{$IFDEF VER100} // Delphi 3.0
  {$DEFINE SBP_D3}
{$ELSE}
  {$IFDEF VER120} // Delphi 4.0
    {$DEFINE SBP_D4}
  {$ELSE}
    {$DEFINE SBP_D5} // Delphi 5.0 or Higher
  {$ENDIF}
{$ENDIF}

unit SBPro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls {$IFNDEF SBP_D3}, ImgList {$ENDIF};

type

  TStatusBarPro = class;

  TStatusPanelPro = class(TCollectionItem)
  private
    FText: string;
    FHint: String;
    FImageIndex: Integer;
    FPopupMenu: TPopupMenu;
    FWidth: Integer;
    FPanelColor : TColor;                    {RAL}
    FAlignment: TAlignment;
    FBevel: TStatusPanelBevel;
    {$IFNDEF SBP_D3}
    FBiDiMode: TBiDiMode;
    FParentBiDiMode: Boolean;
    {$ENDIF}
    FStyle: TStatusPanelStyle;
    FUpdateNeeded: Boolean;
    FOnCLick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    procedure SetHint(Value: String);
    procedure SetImageIndex(Value: Integer);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetAlignment(Value: TAlignment);
    procedure SetBevel(Value: TStatusPanelBevel);
    procedure SetStyle(Value: TStatusPanelStyle);
    procedure SetText(const Value: string);
    procedure SetWidth(Value: Integer);
    procedure SetPanelColor(Value : TColor);                {RAL}
    {$IFNDEF SBP_D3}
    procedure SetBiDiMode(Value: TBiDiMode);
    procedure SetParentBiDiMode(Value: Boolean);
    function IsBiDiModeStored: Boolean;
    {$ENDIF}
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    {$IFNDEF SBP_D3}
    procedure ParentBiDiModeChanged;
    function UseRightToLeftAlignment: Boolean;
    function UseRightToLeftReading: Boolean;
    {$ENDIF}
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Bevel: TStatusPanelBevel read FBevel write SetBevel default pbLowered;
    {$IFNDEF SBP_D3}
    property BiDiMode: TBiDiMode read FBiDiMode write SetBiDiMode stored IsBiDiModeStored;
    {$ENDIF}
    property Hint: String read FHint write SetHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    {$IFNDEF SBP_D3}
    property ParentBiDiMode: Boolean read FParentBiDiMode write SetParentBiDiMode default True;
    {$ENDIF}
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property Style: TStatusPanelStyle read FStyle write SetStyle default psText;
    property Text: string read FText write SetText;
    property Width: Integer read FWidth write SetWidth;
    property Color : TColor read FPanelColor write SetPanelColor;         {RAL}
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TStatusPanelsPro = class(TCollection)
  private
    FStatusBar: TStatusBarPro;
    function GetItem(Index: Integer): TStatusPanelPro;
    procedure SetItem(Index: Integer; Value: TStatusPanelPro);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(StatusBar: TStatusBarPro);
    function Add: TStatusPanelPro;
    property Items[Index: Integer]: TStatusPanelPro read GetItem write SetItem; default;
  end;

  TDrawPanelProEvent = procedure(StatusBar: TStatusBarPro; Panel: TStatusPanelPro;
    const Rect: TRect) of object;

  TStatusBarPro = class(TWinControl)
  private
    FPanels: TStatusPanelsPro;
    FCanvas: TCanvas;
    FSimpleText: string;
    FSimplePanel: Boolean;
    FSizeGrip: Boolean;
    FUseSystemFont: Boolean;
    FAutoHint: Boolean;
    FOnDrawPanel: TDrawPanelProEvent;
    FOnHint: TNotifyEvent;
    FImages: {$IFNDEF SBP_D3} TCustomImageList {$ELSE} TImageList {$ENDIF};
    FImageChangeLink: TChangeLink;
    FMousePanel: TStatusPanelPro;
    {$IFNDEF SBP_D3}
    procedure DoRightToLeftAlignment(var Str: string; AAlignment: TAlignment;
      ARTLAlignment: Boolean);
    {$ENDIF SBP_D3}
    function IsFontStored: Boolean;
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(Value: {$IFNDEF SBP_D3} TCustomImageList {$ELSE} TImageList {$ENDIF});
    procedure SetPanels(Value: TStatusPanelsPro);
    procedure SetSimplePanel(Value: Boolean);
    procedure UpdateSimpleText;
    procedure SetSimpleText(const Value: string);
    procedure SetSizeGrip(Value: Boolean);
    procedure SyncToSystemFont;
    procedure UpdatePanel(Index: Integer; Repaint: Boolean);
    procedure UpdatePanels(UpdateRects, UpdateText: Boolean);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$IFNDEF SBP_D3}
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    {$ENDIF}
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMWinIniChange(var Message: TMessage); message CM_WININICHANGE;
    procedure CMSysFontChanged(var Message: TMessage); message CM_SYSFONTCHANGED;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMGetTextLength(var Message: TWMGetTextLength); message WM_GETTEXTLENGTH;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetUseSystemFont(const Value: Boolean);
    function FindPanelAtPos(Point: TPoint): TStatusPanelPro;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function DoHint: Boolean; virtual;
    procedure DrawPanel(Panel: TStatusPanelPro; const Rect: TRect); dynamic;
    procedure WndProc(var Message: TMessage); override;
    procedure Click; override;
    procedure DblClick; override;
    function GetPopupMenu: TPopupMenu; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFNDEF SBP_D3}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    {$ENDIF}
    property Canvas: TCanvas read FCanvas;
  published
    {$IFNDEF SBP_D3}
    property Action;
    property AutoHint: Boolean read FAutoHint write FAutoHint default False;
    {$ENDIF}
    property Align default alBottom;
    {$IFNDEF SBP_D3}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    {$ENDIF}
    property Color default clBtnFace;
    property DragCursor;
    {$IFNDEF SBP_D3}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font stored IsFontStored;
    property Images: {$IFNDEF SBP_D3} TCustomImageList {$ELSE} TImageList {$ENDIF}
      read FImages write SetImages;
    property Panels: TStatusPanelsPro read FPanels write SetPanels;
    {$IFNDEF SBP_D3}
    property Constraints;
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor default False;
    property ParentFont default False;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SimplePanel: Boolean read FSimplePanel write SetSimplePanel;
    property SimpleText: string read FSimpleText write SetSimpleText;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default True;
    property UseSystemFont: Boolean read FUseSystemFont write SetUseSystemFont default True;
    property Visible;
    property OnClick;
    {$IFDEF SBP_D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IFNDEF SBP_D3}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDrawPanel: TDrawPanelProEvent read FOnDrawPanel write FOnDrawPanel;
    {$IFNDEF SBP_D3}
    property OnResize;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;
 procedure Register;
implementation

uses CommCtrl {$IFNDEF SBP_D3}, StdActns {$ENDIF};

{$IFDEF SBP_D3}
const
  SB_SETBKCOLOR = $2001;  // lParam = bkColor
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Win32', [TStatusBarPro]);
end;

{ TStatusPanelPro }

constructor TStatusPanelPro.Create(Collection: TCollection);
begin
  FWidth := 50;
  FPanelColor := clBtnFace;                              {RAL}
  FBevel := pbLowered;
  FImageIndex := -1;
  {$IFNDEF SBP_D3}
  FParentBiDiMode := True;
  {$ENDIF}
  inherited Create(Collection);
  {$IFNDEF SBP_D3}
  ParentBiDiModeChanged;
  {$ENDIF}
end;

procedure TStatusPanelPro.Assign(Source: TPersistent);
begin
  if Source is TStatusPanel then
  begin
    Text := TStatusPanel(Source).Text;
    Width := TStatusPanel(Source).Width;
    Alignment := TStatusPanel(Source).Alignment;
    Bevel := TStatusPanel(Source).Bevel;
    Style := TStatusPanel(Source).Style;
  end
  else if Source is TStatusPanelPro then
  begin
    Text := TStatusPanelPro(Source).Text;
    Width := TStatusPanelPro(Source).Width;
    Color := TStatusPanelPro(Source).Color;                  {RAL}
    Alignment := TStatusPanelPro(Source).Alignment;
    Bevel := TStatusPanelPro(Source).Bevel;
    Style := TStatusPanelPro(Source).Style;
    Hint := TStatusPanelPro(Source).Hint;
    ImageIndex := TStatusPanelPro(Source).ImageIndex;
    PopupMenu := TStatusPanelPro(Source).PopupMenu;
    OnClick := TStatusPanelPro(Source).OnClick;
    OnDblClick := TStatusPanelPro(Source).OnDblClick;
  end
  else
    inherited Assign(Source);
end;

{$IFNDEF SBP_D3}
procedure TStatusPanelPro.SetBiDiMode(Value: TBiDiMode);
begin
  if Value <> FBiDiMode then
  begin
    FBiDiMode := Value;
    FParentBiDiMode := False;
    Changed(False);
  end;
end;
{$ENDIF}

{$IFNDEF SBP_D3}
function TStatusPanelPro.IsBiDiModeStored: Boolean;
begin
  Result := not FParentBiDiMode;
end;
{$ENDIF}

{$IFNDEF SBP_D3}
procedure TStatusPanelPro.SetParentBiDiMode(Value: Boolean);
begin
  if FParentBiDiMode <> Value then
  begin
    FParentBiDiMode := Value;
    ParentBiDiModeChanged;
  end;
end;
{$ENDIF}

{$IFNDEF SBP_D3}
procedure TStatusPanelPro.ParentBiDiModeChanged;
begin
  if FParentBiDiMode then
  begin
    if GetOwner <> nil then
    begin
      BiDiMode := TStatusPanelsPro(GetOwner).FStatusBar.BiDiMode;
      FParentBiDiMode := True;
    end;
  end;
end;
{$ENDIF}

{$IFNDEF SBP_D3}
function TStatusPanelPro.UseRightToLeftReading: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode <> bdLeftToRight);
end;
{$ENDIF}

{$IFNDEF SBP_D3}
function TStatusPanelPro.UseRightToLeftAlignment: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode = bdRightToLeft);
end;
{$ENDIF}

function TStatusPanelPro.GetDisplayName: string;
begin
  Result := Text;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TStatusPanelPro.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetBevel(Value: TStatusPanelBevel);
begin
  if FBevel <> Value then
  begin
    FBevel := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetStyle(Value: TStatusPanelStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed(True);
  end;
end;

procedure TStatusPanelPro.SetPanelColor(Value : TColor);               {RAL}
begin                                                                  {RAL}
 if FPanelColor <> Value then                                          {RAL}
  begin                                                                {RAL}
   FPanelColor := Value;                                               {RAL}
   Changed(True);                                                      {RAL}
  end;                                                                 {RAL}
end;                                                                   {RAL}

procedure TStatusPanelPro.SetHint(Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetPopupMenu(Value: TPopupMenu);
begin
  if FPopupMenu <> Value then
  begin
    FPopupMenu := Value;
    if (GetOwner <> nil) and (FPopupMenu <> nil) then
      FPopupMenu.FreeNotification(TStatusPanelsPro(GetOwner).FStatusBar);
    Changed(False);
  end;
end;

{ TStatusPanelsPro }

constructor TStatusPanelsPro.Create(StatusBar: TStatusBarPro);
begin
  inherited Create(TStatusPanelPro);
  FStatusBar := StatusBar;
end;

function TStatusPanelsPro.Add: TStatusPanelPro;
begin
  Result := TStatusPanelPro(inherited Add);
end;

function TStatusPanelsPro.GetItem(Index: Integer): TStatusPanelPro;
begin
  Result := TStatusPanelPro(inherited GetItem(Index));
end;

function TStatusPanelsPro.GetOwner: TPersistent;
begin
  Result := FStatusBar;
end;

procedure TStatusPanelsPro.SetItem(Index: Integer; Value: TStatusPanelPro);
begin
  inherited SetItem(Index, Value);
end;

procedure TStatusPanelsPro.Update(Item: TCollectionItem);
begin
  if Item <> nil then
    FStatusBar.UpdatePanel(Item.Index, False) else
    FStatusBar.UpdatePanels(True, False);
end;

{ TStatusBarPro }

constructor TStatusBarPro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque, csAcceptsControls];
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  Color := clBtnFace;
  Height := 19;
  Align := alBottom;
  FPanels := TStatusPanelsPro.Create(Self);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FSizeGrip := True;
  ParentFont := False;
  FUseSystemFont := True;
  SyncToSystemFont;
end;

destructor TStatusBarPro.Destroy;
begin
  FImageChangeLink.Free;
  FCanvas.Free;
  FPanels.Free;
  inherited Destroy;
end;

procedure TStatusBarPro.CreateParams(var Params: TCreateParams);
const
  GripStyles: array[Boolean] of DWORD = (CCS_TOP, SBARS_SIZEGRIP);
begin
  InitCommonControl(ICC_BAR_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, STATUSCLASSNAME);
  with Params do
  begin
    Style := Style or GripStyles[FSizeGrip and
      (Parent is {$IFNDEF SBP_D3} TCustomForm {$ELSE} TForm {$ENDIF}) and
      ({$IFNDEF SBP_D3} TCustomForm {$ELSE} TForm {$ENDIF} (Parent).BorderStyle
       in [bsSizeable, bsSizeToolWin])];
    WindowClass.style := WindowClass.style and not CS_HREDRAW;
  end;
end;

procedure TStatusBarPro.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, SB_SETBKCOLOR, 0, ColorToRGB(Color));
  UpdatePanels(True, False);
  if FSimpleText <> '' then
    SendMessage(Handle, SB_SETTEXT, 255, Integer(PChar(FSimpleText)));
  if FSimplePanel then
    SendMessage(Handle, SB_SIMPLE, 1, 0);
end;

function TStatusBarPro.DoHint: Boolean;
begin
  if Assigned(FOnHint) then
  begin
    FOnHint(Self);
    Result := True;
  end
  else Result := False;
end;

procedure TStatusBarPro.DrawPanel(Panel: TStatusPanelPro; const Rect: TRect);
var
  X, Y: Integer;
  ImageWidth: Integer;
  Alignment: TAlignment;
  RightSideImage: Boolean;
begin
  if (Panel.Style = psOwnerDraw) and Assigned(FOnDrawPanel) then
    FOnDrawPanel(Self, Panel, Rect)
  else
  begin
    // Changes alignment according to BiDiMode
    Alignment := Panel.Alignment;
    {$IFNDEF SBP_D3}
    if Panel.UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(Alignment);
    {$ENDIF}
    RightSideImage := (Alignment = taRightJustify) {$IFNDEF SBP_D3} or
      ((Alignment = taCenter) and Panel.UseRightToLeftAlignment) {$ENDIF};
    // Determines image's width
    if (FImages <> nil) and (Panel.ImageIndex >= 0) and
       (Panel.ImageIndex < FImages.Count) then
      ImageWidth := FImages.Width
    else
      ImageWidth := 0;
    // Determines X position
    case Alignment of
      taLeftJustify: X := Rect.Left + 1;
      taRightJustify: X := Rect.Right - 1 - ImageWidth;
    else
      {$IFNDEF SBP_D3}
      if Panel.UseRightToLeftAlignment then
        X := Rect.Left + ((Rect.Right - Rect.Left) +
            (ImageWidth + FCanvas.TextWidth(Panel.Text))) div 2 - ImageWidth
      else
      {$ENDIF}
        X := Rect.Left + ((Rect.Right - Rect.Left) -
            (ImageWidth + FCanvas.TextWidth(Panel.Text))) div 2;
    end;
    // Clears panel client area
    FCanvas.Brush.Color := Panel.Color; {RAL Put here so colors can be seen in design mode}
    FCanvas.FillRect(Rect);
    // Draws image
    if ImageWidth > 0 then
    begin
      Y := Rect.Top + ((Rect.Bottom - Rect.Top) - FImages.Height) div 2;
      FImages.Draw(FCanvas, X, Y, Panel.ImageIndex);
      if RightSideImage then
        Dec(X, 2)
      else
        Inc(X, FImages.Width + 2);
    end;
    // Draws text
    if RightSideImage then
      Dec(X, FCanvas.TextWidth(Panel.Text));
    Y := Rect.Top + ((Rect.Bottom - Rect.Top) - FCanvas.TextHeight('H')) div 2;
    {$IFNDEF SBP_D3}
    if Panel.UseRightToLeftReading then
      FCanvas.TextFlags := FCanvas.TextFlags or ETO_RTLREADING
    else
      FCanvas.TextFlags := FCanvas.TextFlags and not ETO_RTLREADING;
    {$ENDIF}
    FCanvas.TextOut(X, Y, Panel.Text);
  end;
end;

procedure TStatusBarPro.SetImages(Value: {$IFNDEF SBP_D3} TCustomImageList {$ELSE} TImageList {$ENDIF});
begin
  if FImages <> nil then
    FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  Invalidate;
end;

procedure TStatusBarPro.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TStatusBarPro.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FImages then
      Images := nil
    else if AComponent is TPopupMenu then
    begin
      for I := 0 to Panels.Count-1 do
        if Panels[I].PopupMenu = AComponent then
          Panels[I].PopupMenu := nil;
    end;
end;

procedure TStatusBarPro.SetPanels(Value: TStatusPanelsPro);
begin
  FPanels.Assign(Value);
end;

procedure TStatusBarPro.SetSimplePanel(Value: Boolean);
begin
  if FSimplePanel <> Value then
  begin
    FSimplePanel := Value;
    if HandleAllocated then
      SendMessage(Handle, SB_SIMPLE, Ord(FSimplePanel), 0);
  end;
end;

{$IFNDEF SBP_D3}
procedure TStatusBarPro.DoRightToLeftAlignment(var Str: string;
  AAlignment: TAlignment; ARTLAlignment: Boolean);
begin
  if ARTLAlignment then ChangeBiDiModeAlignment(AAlignment);

  case AAlignment of
    taCenter: Insert(#9, Str, 1);
    taRightJustify: Insert(#9#9, Str, 1);
  end;
end;
{$ENDIF}

procedure TStatusBarPro.UpdateSimpleText;
const
  RTLReading: array[Boolean] of Longint = (0, SBT_RTLREADING);
begin
  {$IFNDEF SBP_D3}
  DoRightToLeftAlignment(FSimpleText, taLeftJustify, UseRightToLeftAlignment);
  {$ENDIF}
  if HandleAllocated then
    SendMessage(Handle, SB_SETTEXT, 255
      {$IFNDEF SBP_D3} or RTLREADING[UseRightToLeftReading] {$ENDIF},
      Integer(PChar(FSimpleText)));
end;

procedure TStatusBarPro.SetSimpleText(const Value: string);
begin
  if FSimpleText <> Value then
  begin
    FSimpleText := Value;
    UpdateSimpleText;
  end;
end;

{$IFNDEF SBP_D3}
procedure TStatusBarPro.CMBiDiModeChanged(var Message: TMessage);
var
  Loop: Integer;
begin
  inherited;
  if HandleAllocated then
    if not SimplePanel then
    begin
      for Loop := 0 to Panels.Count - 1 do
        if Panels[Loop].ParentBiDiMode then
          Panels[Loop].ParentBiDiModeChanged;
      UpdatePanels(True, True);
    end
    else
      UpdateSimpleText;
end;
{$ENDIF}

{$IFNDEF SBP_D3}
procedure TStatusBarPro.FlipChildren(AllLevels: Boolean);
var
  Loop, FirstWidth, LastWidth: Integer;
  APanels: TStatusPanelsPro;
begin
  if HandleAllocated and
     (not SimplePanel) and (Panels.Count > 0) then
  begin
    { Get the true width of the last panel }
    LastWidth := ClientWidth;
    FirstWidth := Panels[0].Width;
    for Loop := 0 to Panels.Count - 2 do Dec(LastWidth, Panels[Loop].Width);
    { Flip 'em }
    APanels := TStatusPanelsPro.Create(Self);
    try
      for Loop := 0 to Panels.Count - 1 do with APanels.Add do
        Assign(Self.Panels[Loop]);
      for Loop := 0 to Panels.Count - 1 do
        Panels[Loop].Assign(APanels[Panels.Count - Loop - 1]);
    finally
      APanels.Free;
    end;
    { Set the width of the last panel }
    if Panels.Count > 1 then
    begin
      Panels[Panels.Count-1].Width := FirstWidth;
      Panels[0].Width := LastWidth;
    end;
    UpdatePanels(True, True);
  end;
end;
{$ENDIF}

procedure TStatusBarPro.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    RecreateWnd;
  end;
end;

procedure TStatusBarPro.SyncToSystemFont;
{$IFNDEF SBP_D5}
var
  NonClientMetrics: TNonClientMetrics;
{$ENDIF}
begin
  {$IFNDEF SBP_D5}
  if FUseSystemFont then
  begin
    NonClientMetrics.cbSize := sizeof(NonClientMetrics);
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Font.Handle := CreateFontIndirect(NonClientMetrics.lfStatusFont)
  end;
  {$ELSE}
  if FUseSystemFont then
    Font := Screen.HintFont;
  {$ENDIF}
end;

procedure TStatusBarPro.UpdatePanel(Index: Integer; Repaint: Boolean);
var
  Flags: Integer;
  S: string;
  PanelRect: TRect;
begin
  if HandleAllocated then
    with Panels[Index] do
    begin
      if not Repaint then
      begin
        FUpdateNeeded := True;
        SendMessage(Handle, SB_GETRECT, Index, Integer(@PanelRect));
        InvalidateRect(Handle, @PanelRect, True);
        Exit;
      end
      else if not FUpdateNeeded then Exit;
      FUpdateNeeded := False;
      Flags := 0;
      case Bevel of
        pbNone: Flags := SBT_NOBORDERS;
        pbRaised: Flags := SBT_POPOUT;
      end;
      {$IFNDEF SBP_D3}
      if UseRightToLeftReading then Flags := Flags or SBT_RTLREADING;
      {$ENDIF}
      {if Style = psOwnerDraw then} Flags := Flags or SBT_OWNERDRAW;
      S := Text;
      {$IFNDEF SBP_D3}
      if UseRightToLeftAlignment then
        DoRightToLeftAlignment(S, Alignment, UseRightToLeftAlignment)
      else
      {$ENDIF}
        case Alignment of
          taCenter: Insert(#9, S, 1);
          taRightJustify: Insert(#9#9, S, 1);
        end;
      SendMessage(Handle, SB_SETTEXT, Index or Flags, Integer(PChar(S)));
    end;
end;

procedure TStatusBarPro.UpdatePanels(UpdateRects, UpdateText: Boolean);
const
  MaxPanelCount = 128;
var
  I, Count, PanelPos: Integer;
  PanelEdges: array[0..MaxPanelCount - 1] of Integer;
begin
  if HandleAllocated then
  begin
    Count := Panels.Count;
    if UpdateRects then
    begin
      if Count > MaxPanelCount then Count := MaxPanelCount;
      if Count = 0 then
      begin
        PanelEdges[0] := -1;
        SendMessage(Handle, SB_SETPARTS, 1, Integer(@PanelEdges));
        SendMessage(Handle, SB_SETTEXT, 0, Integer(PChar('')));
      end else
      begin
        PanelPos := 0;
        for I := 0 to Count - 2 do
        begin
          Inc(PanelPos, Panels[I].Width);
          PanelEdges[I] := PanelPos;
        end;
        PanelEdges[Count - 1] := -1;
        SendMessage(Handle, SB_SETPARTS, Count, Integer(@PanelEdges));
      end;
    end;
    for I := 0 to Count - 1 do
      UpdatePanel(I, UpdateText);
  end;
end;

procedure TStatusBarPro.CMWinIniChange(var Message: TMessage);
begin
  inherited;
  if (Message.WParam = 0) or (Message.WParam = SPI_SETNONCLIENTMETRICS) then
    SyncToSystemFont;
end;

procedure TStatusBarPro.CNDrawItem(var Message: TWMDrawItem);
var
  SaveIndex: Integer;
begin
  with Message.DrawItemStruct^ do
  begin
    SaveIndex := SaveDC(hDC);
    FCanvas.Lock;
    try
      FCanvas.Handle := hDC;
      FCanvas.Font := Font;
      FCanvas.Brush.Color := Color;
      FCanvas.Brush.Style := bsSolid;
      DrawPanel(Panels[itemID], rcItem);
    finally
      FCanvas.Handle := 0;
      FCanvas.Unlock;
      RestoreDC(hDC, SaveIndex);
    end;
  end;
  Message.Result := 1;
end;

procedure TStatusBarPro.WMGetTextLength(var Message: TWMGetTextLength);
begin
  Message.Result := Length(FSimpleText);
end;

procedure TStatusBarPro.WMPaint(var Message: TWMPaint);
begin
  UpdatePanels(False, True);
  inherited;
end;

procedure TStatusBarPro.WMSize(var Message: TWMSize);
begin
  { Eat WM_SIZE message to prevent control from doing alignment }
  {$IFNDEF SBP_D3}
  if not (csLoading in ComponentState) then Resize;
  {$ENDIF}
  Repaint;
end;

procedure TStatusBarPro.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  if Assigned(FMousePanel) and (FMousePanel.Hint <> '') then
    Message.HintInfo^.HintStr := FMousePanel.Hint
  else
    Message.HintInfo^.HintStr := Hint;
end;

function TStatusBarPro.FindPanelAtPos(Point: TPoint): TStatusPanelPro;
var
  Index: Integer;
  PanelRect: TRect;
begin
  Result := nil;
  for Index := 0 to FPanels.Count-1 do
  begin
    SendMessage(Handle, SB_GETRECT, Index, Integer(@PanelRect));
    if PtInRect(PanelRect, Point) then
    begin
      Result := FPanels[Index];
      Break;
    end;
  end;
end;

procedure TStatusBarPro.WndProc(var Message: TMessage);
var
  OldPanel: TStatusPanelPro;
begin
  if (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_RBUTTONDOWN) then
    FMousePanel := FindPanelAtPos(Point(Message.LParamLo, Message.LParamHi))
  else if ShowHint and (Message.Msg = WM_MOUSEMOVE) then
  begin
    OldPanel := FMousePanel;
    FMousePanel := FindPanelAtPos(Point(Message.LParamLo, Message.LParamHi));
    if OldPanel <> FMousePanel then Application.CancelHint;
  end;
  inherited WndProc(Message);
end;

procedure TStatusBarPro.Click;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.OnClick) then
    FMousePanel.OnClick(FMousePanel)
  else if Assigned(OnClick) then
    FMousePanel.OnClick(Self);
end;

procedure TStatusBarPro.DblClick;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.OnDblClick) then
    FMousePanel.OnDblClick(FMousePanel)
  else if Assigned(OnDblClick) then
    FMousePanel.OnDblClick(Self);
end;

function TStatusBarPro.GetPopupMenu: TPopupMenu;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.PopupMenu) then
  begin
    Result := FMousePanel.PopupMenu;
    {$IFNDEF SBP_D3}
    if Result <> nil then Result.BiDiMode := FMousePanel.BiDiMode;
    {$ENDIF}
  end
  else
    Result := PopupMenu;
end;

function TStatusBarPro.IsFontStored: Boolean;
begin
  Result := not FUseSystemFont and not ParentFont and not DesktopFont;
end;

procedure TStatusBarPro.SetUseSystemFont(const Value: Boolean);
begin
  if FUseSystemFont <> Value then
  begin
    FUseSystemFont := Value;
    if Value then
    begin
      if ParentFont then ParentFont := False;
      SyncToSystemFont;
    end;
  end;
end;

procedure TStatusBarPro.CMColorChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TStatusBarPro.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if FUseSystemFont and ParentFont then FUseSystemFont := False;
end;

{$IFNDEF SBP_D3}
function TStatusBarPro.ExecuteAction(Action: TBasicAction): Boolean;
begin
  if AutoHint and (Action is THintAction) and not DoHint then
  begin
    if SimplePanel or (Panels.Count = 0) then
      SimpleText := THintAction(Action).Hint else
      Panels[0].Text := THintAction(Action).Hint;
    Result := True;
  end
  else Result := inherited ExecuteAction(Action);
end;
{$ENDIF}

procedure TStatusBarPro.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TStatusBarPro.CMSysFontChanged(var Message: TMessage);
begin
  inherited;
  SyncToSystemFont;
end;

procedure TStatusBarPro.ChangeScale(M, D: Integer);
begin
  if FUseSystemFont then  // status bar size based on system font size
    ScalingFlags := [sfTop];
  inherited;
end;

end.

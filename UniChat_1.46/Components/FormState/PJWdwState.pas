{ ##
  @FILE                     PJWdwState.pas
  @COMMENTS                 Window state components source file.
  @PROJECT_NAME             Window State Components
  @PROJECT_DESC             Two components that save state of a window between
                            executions - one in ini file and the other in
                            registry.
  @OTHER_NAMES              + Original unit name was WdwState.pas
                            + Changed to PJWdwState.pas at v4.0
  @AUTHOR                   Peter D Johnson, LLANARTH, Ceredigion, Wales, UK.
  @OWNER                    delphiDabbler
  @EMAIL                    peter.johnson@openlink.org
  @WEBSITE                  http://www.delphidabbler.com/
  @COPYRIGHT                © Peter D Johnson, 1999-2003.
  @LEGAL_NOTICE             These components and source code are placed in the
                            public domain. They may be freely copied and
                            circulated on a not-for-profit basis providing that
                            the code is unmodified and this notice and
                            information about the author and his copyright
                            remains attached to the source code.
  @CREDITS                  + Stefan Winter suggested (and provided prototype
                              coding for) the AutoSaveRestore property. Stefan
                              also provided prototype of code that prevents
                              windows overwriting task bar. He also suggested
                              the OnGetIniData and OnGetRegData events.
                            + Andre Viol suggested that the normal window should
                              flash on screen before minimizing and maximizing
                              as required.
  @HISTORY(
    @REVISION(
      @VERSION              1.0
      @DATE                 15/08/1999
      @COMMENTS             Original version of single TPJWdwState component
                            that stores window state information in ini files.
    )
    @REVISION(
      @VERSION              2.0
      @DATE                 18/10/1999
      @COMMENTS             Re-write which added TPJRegWdwState component that
                            stores window state information in registry.
                            Extracted common functionality of TPJWdwState and
                            TPJRegWdwState into new abstract base class
                            TPJCustomWdwState. TPJWdwState presents same
                            interface and functionality as version 1.
                            TRegWdwState does not compile under Delphi 1.
    )
    @REVISION(
      @VERSION              2.1
      @DATE                 29/11/1999
      @COMMENTS             Renamed ReadState and SaveState methods to
                            ReadWdwState and SaveWdwState respectively since
                            ReadState was masking a method inherited from
                            TComponent.
    )
    @REVISION(
      @VERSION              3.0
      @DATE                 05/04/2000
      @COMMENTS             New version that is not compatible with Delphi 1.
                            + Added AutoSaveRestore property
                            + Modified window restoration code to avoid task
                              bars in positions other than bottom of screen
                            + Prevented forms being restored as minimized from
                              flashing on screen (by cheating!)
    )
    @REVISION(
      @VERSION              3.1
      @DATE                 29/04/2000
      @COMMENTS             Bug fix curing problem of incorrect maximisation
                            (had been using window size when "maximising" rather
                            than maximising to full screen)
    )
    @REVISION(
      @VERSION              4.0
      @DATE                 17/03/2002
      @COMMENTS             + Replaced WinTypes and WinProcs units with Windows
                              unit.
                            + Made use ParamStr(0) for default name of ini file
                              and registry key instead of Application.ExeName.
                            + Changed name of default registry sub key and ini
                              file section from Main Window' to 'Window\<Form
                              Name>' and 'Window_<Form Name>' respectively. This
                              enables use of multiple forms that save their
                              state to registry or ini file without overriting
                              each other's data.
                            + Replaced ReadInt and WriteInt methods of
                              TPJRegWdwState with simple ReadRegInt and
                              WriteRegInt routines.
                            + Rewrote method of auto saving and restoring
                              windows to stop having to manipulate the owning
                              form's OnCreate and OnDestroy event handlers. Now
                              uses a hook class to hook into owning form's
                              messages and pass them to window state components.
                              The window now always momentarily appears in
                              normal state before being maximized or minimized
                              as required.
                            + Added new MinimizeDelay property to control how
                              long the normal window appears before being
                              minimized.
                            + Added OnGetIniData event to TPJWdwState and
                              OnGetRegData event to TPJRegWdwState to allow user
                              to override property values for reading / writing
                              ini file and registry.
                            + Made so that now only one instance of a window
                              state component can be placed on a form.
                            + Removed Section ID handling code from base
                              TPJCustomWdwState class and added dedicated
                              property setters and initialisation for
                              TPJWdwState's IniFileName and TPJRegWdwState's
                              SubKey properties which had relied on the Section
                              ID code from root class.
                            + Changed component palette from 'PJ Stuff' to
                              'PJSoft'.
                            + Changed unit name to PJWdwState.
    )
    @REVISION(
      @VERSION              4.1
      @DATE                 07/08/2002
      @COMMENTS             + Added new Options property to permit user to
                              specify various window display options: to ignore
                              stored window size and/or to ignore stored state
                              (IgnoreState property now deprecated).
                            + Added new OnReadWdwState event that enables user
                              to modify the values read from storage before
                              window is displayed.
    )
    @REVISION(
      @VERSION              4.2
      @DATE                 30/10/2003
      @COMMENTS             + Added new woFitWorkArea option to ensure window is
                              not displayed out of current work area.
                            + When TPJRegWdwState reads/writes the registry we
                              now check that the required key can be opened
                              before reading/writing. Reading no longer creates
                              missing keys.
                            + Rearranged decision logic in
                              TPJCustomWdwState.SetParentComponent method.
                            + Changed component palette to 'DelphiDabbler' from
                              'PJSoft'.
    )
  )
}


unit PJWdwState;


interface


uses
  // Delphi
  Classes, Controls, Messages, Windows, Forms, SysUtils, dialogs;


const
  // Custom message used internally
  PJM_SETWDWSTATE = WM_USER + 99;


type

  // Forward class declaration
  TPJCustomWdwState = class;

  {
  TPJWdwStateHook:
    Class that hooks into window of owning form and passes on WMCreate and
    WMDestroy messages to TPJCustomWdwState component. Instances of this class
    should not be created by user code - this control is designed for private
    use by TPJCustomWdwState.
  }
  TPJWdwStateHook = class(TWinControl)
  private
    fWdwState: TPJCustomWdwState;
      {Reference to owning window state component}
    procedure SendMsgToOwner(var Msg: TMessage);
      {Dispatches given message to component's owner component}
    procedure WMDestroy(var Msg: TMessage); message WM_DESTROY;
      {Handles WM_DESTROY message and dispatches it to owning window state
      component where it is used to automatically save the related form's state}
    procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
      {Handles CM_SHOWINGCHANGED message and dispatches it to owning window
      state component where it is used to automatically restore the related
      form's state}
    procedure PJMSetWindowState(var Msg: TMessage); message PJM_SETWDWSTATE;
      {Handles PJM_SETWDWSTATE message and dispatches it to owning window state
      component where it is used to automatically restore the related form's
      state}
  public
    constructor Create(AOwner: TComponent); override;
      {Class constructor: records reference to owning window state component}
  end;


  {
  EPJCustomWdwState:
    Type of exception raised by TPJCustomWdwState.
  }
  EPJCustomWdwState = class(Exception);


  {
  TPJWdwStateReadEvent:
    Type of event triggered after the window's stored placement information is
    read from storage.
  }
  TPJWdwStateReadEvent = procedure(Sender: TObject; var Left, Top, Width,
    Height, State: Integer) of object;


  {
  TPJWdwStateOptions
    Set of values that are stored in the component's Options property.
  }
  TPJWdwStateOptions = set of (
    woIgnoreState,    // stored wdw state is ignored and wdw is display normal
    woIgnoreSize,     // stored wdw size is ignored and wdw's defaults are used
    woFitWorkArea     // restored wdw appears wholy within desktop work area
                      // (wdw may be resized to fit if woIgnoreSize not set)
  );


  {
  TPJCustomWdwState:
    Abstract base class for components that record window size, position and
    state between program executions.
  }
  TPJCustomWdwState = class(TComponent)
  private // properties
    fAutoSaveRestore: Boolean;
    fMinimizeDelay: Integer;
    fOnReadWdwState: TPJWdwStateReadEvent;
    fOptions: TPJWdwStateOptions;
    function GetIgnoreState: Boolean;
    procedure SetIgnoreState(const Value: Boolean);
  private
    fHook: TPJWdwStateHook;
      {Instance of a privately owned windowed control that is used to intercept
      relevant messages in owning form and custom messages posted by this
      component and to notify this component of the messages}
    fWindow: TForm;
      {Instance of form on which to operate}
    fFormShown: Boolean;
      {Flag false until form has been shown and true afterwards. Any call to
      Restore method while this flag is false is recorded as pending and called
      again once form has been shown}
    fRestorePending: Boolean;
      {Flag true if Restore method has been called while fFormShown flag false:
      such calls set this flag which in turn causes Restore method to be called
      again once the form has been shown}
  protected
    procedure WMDestroy(var Msg: TMessage); message WM_DESTROY;
      {Message handler for owning form's WM_DESTROY message. This message is
      sent to this component by the hook window component. We use this message
      at run time to save the form's state if the AutoSaveRestore property is
      true}
    procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
      {Message handler for owning form's CM_SHOWINGCHANGED message. This message
      is sent to this component by the hook window component. We use this
      message at run time to note that the form's showing state has been changed
      and that any pending window restoration can be executed}
    procedure PJMSetWindowState(var Msg: TMessage); message PJM_SETWDWSTATE;
      {Message handler for owning form's custom PJM_SETWDWSTATE message. This
      message is sent to this component by the hook window component. We use the
      message at run time to set the window state according to the TWindowState
      value passed in LParam. A message is used since Restore method needs to
      ensure the form has been shown before we execute this code. Posting this
      message enables this to happen}
    procedure SetParentComponent(Value: TComponent); override;
      {Override of SetParentComponent method. We use this at run time to set the
      parent of the hook window to the given value. Doing this enables the hook
      window to receive messages from the parent window}
    procedure ReadWdwState(var Left, Top, Width, Height, State: Integer);
      virtual; abstract;
      {Read state of window from storage - user passes default values and method
      returns new values from storage, or defaults if no stored values found.
      Implementation depends on method of storage used by derived classes}
    procedure DoReadWdwState(var Left, Top, Width, Height, State: Integer);
      virtual;
      {Fetches the state of the window from storage using the abstract
      ReadWdwState method then triggers the OnReadWdwState event which permits
      any of the values read to be modifid before passing them back to the
      caller. The default window values per the window's form properties are
      passed into the method}
    procedure SaveWdwState(const Left, Top, Width, Height, State: Integer);
      virtual; abstract;
      {Save state of window to storage per given values. Implementation depends
      on method of storage used by derived classes}
  public
    constructor Create(AOwner: TComponent); override;
      {Class constructor: records reference to any owning form, sets default
      property values and creates a hook window to trap messages from owning
      form}
    procedure Restore;
      {Read window placement and state from storage and set up the window's
      size, positions and state as required}
    procedure Save;
      {Save window placement, size and state to storage}
  published
    property AutoSaveRestore: Boolean
      read fAutoSaveRestore write fAutoSaveRestore default False;
      {When true component automatically restores window state on form creation
      and saves it on form destruction}
    property IgnoreState: Boolean
      read GetIgnoreState write SetIgnoreState default False;
      {When true Restore method ignores the saved state of the window and leaves
      current state unchanged while still setting size and position. When false
      Restore also sets the window state according to the saved state. Changing
      this property updates the Options property: including and excluding
      woIgnoreState in the set as necessary. Use of IgnoreState is now
      deprecated and Options should be used instead}
    property MinimizeDelay: Integer
      read fMinimizeDelay write fMinimizeDelay default 100;
      {When a form is to be started minimized this property determines the delay
      (in ms) between displaying the normalised form on screen and minimising
      it}
    property Options: TPJWdwStateOptions
      read fOptions write fOptions default [];
      {This property provides a set of display options that affect how the
      window is displayed or if certain stored values are ignored: see the
      TPJWdwStateOptions type definition for details. Including/exclusing the
      woIgnoreState value is the same as setting IgnoreState to true or false
      respectively}
    property OnReadWdwState: TPJWdwStateReadEvent
      read fOnReadWdwState write fOnReadWdwState;
      {Event triggered just after the window's state is read from storage: any
      of the values read can be altered before the component sets the window's
      properties. Setting any of the values to MaxInt causes the form's default
      value to be used in place of the stored value}
  end;


  {
  TPJWdwStateGetIniData:
    Type of event handler that is called just before ini file is accessed:
    allows user to change the ini file name and section to be used.
  }
  TPJWdwStateGetIniData = procedure(var IniFilename, Section: string) of object;


  {
  TPJWdwState:
    Implements a component that records a window's size, position and state
    between program executions. An ini file is used to store the information.
  }
  TPJWdwState = class(TPJCustomWdwState)
  private // properties
    fSection: string;
    fIniFileName: string;
    fOnGetIniData: TPJWdwStateGetIniData;
    procedure SetSection(const Value: string);
    procedure SetIniFileName(const Value: string);
  protected
    procedure GetIniInfo(var AIniFileName, ASection: string);
      {Gets ini file name and section name to be used when restoring / saving
      window state. Returns values of IniFileName and Section properties by
      default unless user changes these values by handling OnGetIniData event
      that is triggered by this method}
    procedure ReadWdwState(var Left, Top, Width, Height, State: Integer);
      override;
      {Reads window state from ini file using given values as defaults}
    procedure SaveWdwState(const Left, Top, Width, Height, State: Integer);
      override;
      {Writes window state to ini file}
  public
    constructor Create(AOwner: TComponent); override;
      {Class constructor: sets default property values}
  published
    property IniFileName: string read fIniFileName write SetIniFileName;
      {The name of the ini file in which to save window information - uses path
      and name of executable with extension replaced by .ini if set to empty
      string}
    property Section: string read fSection write SetSection;
      {The name of the section in ini file in which to save window information -
      uses "Window_<Form Name>" (eg 'Window_Form1') if passed emtpy string}
    property OnGetIniData: TPJWdwStateGetIniData
      read fOnGetIniData write fOnGetIniData;
      {Event handler called just before ini file is read when restoring and
      saving window state: allows user to change ini file name and section name.
      If this event is handled then IniFileName and Section properties are
      ignored}
  end;


  {
  TPJWdwStateGetRegData:
    Type of event handler that is called just before registry is accessed:
    allows user to change the registry HKEY and sub key to be used.
  }
  TPJWdwStateGetRegData = procedure(var RootKey: HKEY;
    var SubKey: string) of object;


  {
  TPJRegWdwState:
    Implements a component that records a window's size, position and state
    between program executions. The registry is used to store the information.
  }
  TPJRegWdwState = class(TPJCustomWdwState)
  private // properties
    fRootKey: HKEY;
    fSubKey: string;
    fOnGetRegData: TPJWdwStateGetRegData;
    procedure SetSubKey(const Value: string);
  protected
    procedure GetRegInfo(var ARootKey: HKEY; var ASubKey: string);
      {Gets registry root key and sub key to be used when restoring / saving
      window state. Returns values of RootKey and SubKey properties by default
      unless user changes these values by handling OnGetRegData event that is
      triggered by this method}
    procedure ReadWdwState(var Left, Top, Width, Height, State: Integer);
      override;
      {Reads window info from registry using given values as defaults}
    procedure SaveWdwState(const Left, Top, Width, Height, State: Integer);
      override;
      {Writes window info to registry}
  public
    constructor Create(AOwner: TComponent); override;
      {Class constructor: sets default property values}
  published
    property RootKey: HKEY read fRootKey write fRootKey
      default HKEY_CURRENT_USER;
      {The registry root key to use - must set to a valid HKEY value}
    property SubKey: string read fSubKey write SetSubKey;
      {The sub-key below root key where window information is to be stored - if
      set to empty string the value of
        '/Software/<Program Name>/Window/<Form Name>'
      is used}
    property OnGetRegData: TPJWdwStateGetRegData
      read fOnGetRegData write fOnGetRegData;
      {Event handler called just before registry is read when restoring and
      saving window state: allows user to change registry HKEY and subkey value.
      If this event is handled then RootKey and SubKey properties are ignored}
  end;


procedure Register;
  {Register the components}


implementation


uses
  // Delphi
  IniFiles, Registry;


{ Component registration routine }

procedure Register;
  {Register the components}
begin
  RegisterComponents('DelphiDabbler', [TPJWdwState, TPJRegWdwState]);
end;


{ TPJWdwStateHook }

procedure TPJWdwStateHook.CMShowingChanged(var Msg: TMessage);
  {Handles CM_SHOWINGCHANGED message and dispatches it to owning window state
  component where it is used to automatically restore the related form's state}
begin
  inherited;
  SendMsgToOwner(Msg);
end;

constructor TPJWdwStateHook.Create(AOwner: TComponent);
  {Class constructor: records reference to owning window state component}
begin
  Assert(Assigned(AOwner));
  Assert(AOwner is TPJCustomWdwState);
  inherited;
  fWdwState := AOwner as TPJCustomWdwState;
end;

procedure TPJWdwStateHook.PJMSetWindowState(var Msg: TMessage);
  {Handles PJM_SETWDWSTATE message and dispatches it to owning window state
  component where it is used to automatically restore the related form's state}
begin
  inherited;
  SendMsgToOwner(Msg);
end;

procedure TPJWdwStateHook.SendMsgToOwner(var Msg: TMessage);
  {Dispatches given message to component's owner component}
begin
  fWdwState.Dispatch(Msg);
end;

procedure TPJWdwStateHook.WMDestroy(var Msg: TMessage);
  {Handles WM_DESTROY message and dispatches it to owning window state component
  where it is used to automatically save the related form's state}
begin
  SendMsgToOwner(Msg);
  inherited;
end;


{ TPJCustomWdwState }

resourcestring
  // Error messages
  sErrFormRequired = 'Window state components must be placed on a form';
  sErrSingleInstance = 'Only one window state component is permitted on a '
    + 'form: %s is already present on %s';


procedure TPJCustomWdwState.CMShowingChanged(var Msg: TMessage);
  {Message handler for owning form's CM_SHOWINGCHANGED message. This message is
  sent to this component by the hook window component. We use this message at
  run time to note that the form's showing state has been changed and that any
  pending window restoration can be executed}
begin
  inherited;
  // We only act on this method the first time it's called:
  // fFormShown indicates if we've been here before
  if not fFormShown then
  begin
    // This code executed first time called only
    fFormShown := True;
    if not (csDesigning in ComponentState)
      and (AutoSaveRestore or fRestorePending) then
      // We call restore method if a call to the method is pending or we're
      // auto-saving
      Restore;
  end;
end;

constructor TPJCustomWdwState.Create(AOwner: TComponent);
  {Class constructor: records reference to any owning form, sets default
  property values and creates a hook window to trap messages from owning form}
var
  Idx: Integer; // loops thru form's components
begin
  // Record reference to owning form (raise execption if no owning form)
  if not Assigned(AOwner) or not (AOwner is TForm) then
    raise EPJCustomWdwState.Create(sErrFormRequired);
  fWindow := AOwner as TForm;
  // Ensure there is only one TPJCustomWdwState component on a form
  for Idx := 0 to Pred(AOwner.ComponentCount) do
    if AOwner.Components[Idx] is TPJCustomWdwState then
      raise EPJCustomWdwState.CreateFmt(sErrSingleInstance,
        [AOwner.Components[Idx].Name, AOwner.Name]);
  // All OK: go ahead and create component
  inherited Create(AOwner);
  // Set default property values
  fAutoSaveRestore := False;
  fOptions := [];
  fMinimizeDelay := 100;
  // Hook into owning form (run time only)
  // the hook control is auto-destroyed when this component is destroyed
  if not (csDesigning in ComponentState) then
    fHook := TPJWdwStateHook.Create(Self);
end;

procedure TPJCustomWdwState.DoReadWdwState(var Left, Top, Width, Height,
  State: Integer);
  {Fetches the state of the window from storage using the abstract ReadWdwState
  method then triggers the OnReadWdwState event which permits any of the values
  read to be modifid before passing them back to the caller. The default window
  values per the window's form properties are passed into the method}
var
  DefLeft, DefTop: Integer;     // default window position
  DefWidth, DefHeight: Integer; // default window size
  DefState: Integer;            // default window state
begin
  // Record default placement: this is form's window default window placement
  DefLeft := ((Screen.Width - width) div 2);
  DefTop := ((Screen.Height - height) div 2);
  DefWidth := Width;
  DefHeight := Height;
  DefState := State;
  // Read details from storage (storage method defined by sub-classes)
  ReadWdwState(Left, Top, Width, Height, State);
  if Assigned(fOnReadWdwState) then
  begin
    // Trigger OnReadWdwState event: permits read values to be overridden
    fOnReadWdwState(Self, Left, Top, Width, Height, State);
    // If any of values set to MaxInt in event handler, restore default value
    if Left = MaxInt then Left := DefLeft;
    if Top = MaxInt then Top := DefTop;
    if Width = MaxInt then Width := DefWidth;
    if Height = MaxInt then Height := DefHeight;
    if State = MaxInt then State := DefState;
  end;
end;

function TPJCustomWdwState.GetIgnoreState: Boolean;
  {Read access method for IgnoreState property: checks for presence of
  woIgnoreState in Options property}
begin
  Result := woIgnoreState in fOptions;
end;

procedure TPJCustomWdwState.PJMSetWindowState(var Msg: TMessage);
  {Message handler for owning form's custom PJM_SETWDWSTATE message. This
  message is sent to this component by the hook window component. We use the
  message at run time to set the window state according to the TWindowState
  value passed in LParam. A message is used since Restore method needs to ensure
  the form has been shown before we execute this code. Posting this message
  enables this to happen}
begin
  inherited;
  // Check that a form window is available
  if Assigned(fWindow) then
  begin
  if not IgnoreState then
  begin
    // Change the state of the window as required
    case TWindowState(Msg.LParam) of
      wsMaximized:
        // maximise the window
        fWindow.WindowState := wsMaximized;
      wsMinimized:
      begin
        // minimize the window:
        // pause for required interval before doing minimization
        if fMinimizeDelay > 0 then
          Sleep(fMinimizeDelay);
        // if window is main form, minimize the whole app else minimize window
        if Application.MainForm = fWindow then
          Application.Minimize
        else
          fWindow.WindowState := wsMinimized;
      end;
      wsNormal:
        // normal window state

        fWindow.WindowState := wsNormal;
    end;
    end;
  end;
end;

procedure TPJCustomWdwState.Restore;
  {Read window placement and state from storage and set up the window's size,
  positions and state as required}
var
  Left, Top: Integer;     // position of window
  Width, Height: integer; // dimensions of window
  State: Integer;         // state of window as integer
  Pl: TWindowPlacement;   // info structure for placement of window
  WorkArea: TRect;        // desktop work area not occupied by task & tool bars
  WkW, WkH: Integer;      // width and height of desktop work area
begin
  Assert(not (csDesigning in ComponentState));

  // Check if there is an owning window - get out if not
  if fWindow = nil then
    Exit;

  // If not ready to act on restore command set pending flag for later handling
  if not fFormShown then
  begin
    // note that a restore is pending
    fRestorePending := True;
    Exit;
  end;

  // We are actually doing the restoration: note that not pending any more
  fRestorePending := False;

  // Read info from storage
  // set default values in case any of items are not recorded in storage
  Left := fWindow.Left;
  Top := fWindow.Top;
  Width := fWindow.Width;
  Height := fWindow.Height;
  State := Ord(fWindow.WindowState);
  // read state and size of window from storage - using default set above
  //   the values could be altered by OnReadWdwState event handler that is
  //   triggered inside DoReadWdwState
  DoReadWdwState(Left, Top, Width, Height, State);
  // restore default window size if we're ignoring recorded window size
  if woIgnoreSize in fOptions then
  begin
    Width := fWindow.Width;
    Height := fWindow.Height;
  end;
  // set state to normal if we're ignoring recorded window state
  if woIgnoreState in fOptions then
    State := Ord(wsNormal);

  // Ensure window fits in desktop workarea if option specified
  if woFitWorkArea in Options then
  begin
    // Get size of desktop workarea (excludes taskbar and any other toolbars)
    if SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0) then
    begin
      // Record width and height of work area
      // (0 value Left and Top of windows relate to top left of work area)
      WkW := WorkArea.Right - WorkArea.Left;
      WkH := WorkArea.Bottom - WorkArea.Top;
      // Resize window if too wide or high if resizing permitted
      if (Width > WkW) and not (woIgnoreSize in Options) then
        Width := WkW;
      if (Height > WkH) and not (woIgnoreSize in Options) then
        Height := WkH;
      // Adjust left of window if off left or right of work area (prefer left)
      if Left + Width > WkW then Left := WkW - Width;
      if Left < 0 then Left := 0;
      // Adjust height og window if off top or bottom of work area (prefer top)
      if Top + Height > WkH then Top := WkH - Height;
      if Top < 0 then Top := 0;
    end;
  end;

  // Set window to required size
  // set up the window placement structure
  FillChar(Pl, SizeOf(Pl), #0);
  Pl.Length := SizeOf(TWindowPlacement);
  Pl.rcNormalPosition.Left := Left;
  Pl.rcNormalPosition.Top := Top;
  Pl.rcNormalPosition.Right := Left+Width;
  Pl.rcNormalPosition.Bottom := Top+Height;
  Pl.showCmd := 0;      // needed when restore called late in start-up
  // and set the actaul size: this call allows for task bar etc
  SetWindowPlacement(fWindow.Handle, @Pl);

  // Set window state by posting message to ensure it is done after form shown
  PostMessage(fHook.Handle, PJM_SETWDWSTATE, 0, State);
end;

procedure TPJCustomWdwState.Save;
  {Save window placement, size and state to storage}
var
  Pl: TWindowPlacement; // info structure for placement of window
  R: TRect;             // rectangle to hold normal position & size details
  State: Integer;       // state of window
begin
  Assert(not (csDesigning in ComponentState));

  // Check if there is an owning window - get out if not
  if fWindow = nil then
    Exit;

  // Calculate window's normal size and position using Windows API call - the
  // form's Width, Height, Top and Left properties will give actual window size
  // if form is maximised, which is not what we want here
  Pl.Length := SizeOf(TWindowPlacement);
  GetWindowPlacement(fWindow.Handle, @Pl);
  R := Pl.rcNormalPosition;

  // Record window state (maximised, minimised or normal)
  // we have a special case when form is app's main form: here if minimised it's
  // the application window that's actually minimised not the form
  if (Application.MainForm = fWindow) and IsIconic(Application.Handle) then
    // minimized main form
    State := Ord(wsMinimized)
  else
    // not mimimized main form - we can rely on window state of form
    State := Ord(fWindow.WindowState);

  // Save window info
  SaveWdwState(R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top, State);
end;

procedure TPJCustomWdwState.SetIgnoreState(const Value: Boolean);
  {Write access method for IgnoreState property: includes or excludes
  woIgnoreState property in Options according to Value}
begin
  if Value <> GetIgnoreState then
  begin
    if Value then
      Include(fOptions, woIgnoreState)
    else
      Exclude(fOptions, woIgnoreState);
  end;
end;

procedure TPJCustomWdwState.SetParentComponent(Value: TComponent);
  {Override of SetParentComponent method. We use this at run time to set the
  parent of the hook window to the given value. Doing this enables the hook
  window to receive messages from the parent window}
begin
  inherited;
  if not (csDesigning in ComponentState) and (Value is TWinControl) then
    fHook.Parent := Value as TWinControl;
end;

procedure TPJCustomWdwState.WMDestroy(var Msg: TMessage);
  {Message handler for owning form's WM_DESTROY message. This message is sent to
  this component by the hook window component. We use this message at run time
  to save the form's state if the AutoSaveRestore property is true}
begin
  if not (csDesigning in ComponentState) and AutoSaveRestore then
    Save;
  inherited;
end;


{ TPJWdwState }

constructor TPJWdwState.Create(AOwner: TComponent);
  {Class constructor: sets default property values}
begin
  inherited Create(AOwner);
  SetIniFileName('');
  SetSection('');
end;

procedure TPJWdwState.GetIniInfo(var AIniFileName, ASection: string);
  {Gets ini file name and section name to be used when restoring / saving window
  state. Returns values of IniFileName and Section properties by default unless
  user changes these values by handling OnGetIniData event that is triggered by
  this method}
begin
  // Use IniFileName and Section properties as default values
  AIniFileName := IniFileName;
  ASection := Section;
  // Allow user to change these by handling OnGetIniData event
  if Assigned(fOnGetIniData) then
    fOnGetIniData(AIniFileName, ASection);
end;

procedure TPJWdwState.ReadWdwState(var Left, Top, Width, Height,
  State: Integer);
  {Reads window state from ini file using given values as defaults}
var
  Ini: TIniFile;        // instance of ini file class used to read info
  AIniFileName: string; // name of ini file from which to read window state
  ASection: string;     // section of ini file from which to read window state
begin
  // Get name of ini file name and section to read window state from
  GetIniInfo(AIniFileName, ASection);
  // Open ini file and read window info from it
  Ini := TIniFile.Create(AIniFileName);

  try

    Left   := Ini.ReadInteger(ASection, 'Left', ((screen.MonitorFromWindow(application.MainFormHandle).Width - width) div 2));
    Top    := Ini.ReadInteger(ASection, 'Top', ((screen.MonitorFromWindow(application.MainFormHandle).Height - height) div 2));
    Width  := Ini.ReadInteger(ASection, 'Width', Width);
    Height := Ini.ReadInteger(ASection, 'Height', Height);
    State  := Ini.ReadInteger(ASection, 'State', State);

  finally
    Ini.Free;
  end;
end;

procedure TPJWdwState.SaveWdwState(const Left, Top, Width, Height,
  State: Integer);
  {Writes window state to ini file}
var
  Ini: TIniFile;        // instance of ini file class used to write info
  AIniFileName: string; // name of ini file in which to save window state
  ASection: string;     // section of ini file in which to save window state
begin
  // Get name of ini file name and section to save window state to
  GetIniInfo(AIniFileName, ASection);
  // Open ini file and write window info to it
  Ini := TIniFile.Create(AIniFileName);
  try
    Ini.WriteInteger(ASection, 'Left',   Left);
    Ini.WriteInteger(ASection, 'Top',    Top);
    Ini.WriteInteger(ASection, 'Width',  Width);
    Ini.WriteInteger(ASection, 'Height', Height);
    Ini.WriteInteger(ASection, 'State',  State);
  finally
    Ini.Free;
  end;
end;

procedure TPJWdwState.SetIniFileName(const Value: string);
  {Write access method for IniFileName method: Records new value. If it is run-
  time and Value is empty string then an ini file name based on the name of the
  application is used}
begin
  if (Value = '') and not (csDesigning in ComponentState) then
    fIniFileName := ChangeFileExt(ParamStr(0), '.ini')
  else
    fIniFileName := Value;
end;

procedure TPJWdwState.SetSection(const Value: string);
  {Write access method for Section property: Records section name. If it is run-
  time and Value is empty string then a section name of 'Window_<Form Name>' is
  used}
begin
  if (Value = '') and not (csDesigning in ComponentState) then
    fSection := 'Window_' + fWindow.Name
  else
    fSection := Value;
end;


{ TPJRegWdwState }

function ReadRegInt(const Reg: TRegistry; const AName: string;
  const ADefault: Integer): Integer;
  {Reads integer value from registry using given name under current key and
  returns it. If no such value exists returns given default value}
begin
  if Reg.ValueExists(AName) then
    Result := Reg.ReadInteger(AName)
  else
    Result := ADefault;
end;

procedure WriteRegInt(const Reg: TRegistry; const AName: string;
  const AnInt: Integer);
  {Writes integer value with given name to registry under current key}
begin
  Reg.WriteInteger(AName, AnInt);
end;

constructor TPJRegWdwState.Create(AOwner: TComponent);
  {Class constructor: sets default property values}
begin
  inherited Create(AOwner);
  fRootKey := HKEY_CURRENT_USER;
  SetSubKey('');
end;

procedure TPJRegWdwState.GetRegInfo(var ARootKey: HKEY;
  var ASubKey: string);
  {Gets registry root key and sub key to be used when restoring / saving window
  state. Returns values of RootKey and SubKey properties by default unless user
  changes these values by handling OnGetRegData event that is triggered by this
  method}
begin
  // Use RootKey and SubKey property values by default
  ARootKey := RootKey;
  ASubKey := SubKey;
  // Allow user to change these by handling OnGetRegData event
  if Assigned(fOnGetRegData) then
    fOnGetRegData(ARootKey, ASubKey);
end;

procedure TPJRegWdwState.ReadWdwState(var Left, Top, Width, Height,
  State: Integer);
  {Reads window info from registry using given values as defaults}
var
  Reg: TRegistry;   // instance of registry object used to read info
  ARootKey: HKEY;   // registry root key where window state is stored
  ASubKey: string;  // sub key of registry from which to read window state
begin
  // Get registry keys from which to read window state
  GetRegInfo(ARootKey, ASubKey);
  // Open registry at required key
  Reg := TRegistry.Create;
  try
    Reg.RootKey := ARootKey;
    Reg.OpenKey(ASubKey, False);
    begin
      // Read position, size and state of window
      Width  := ReadRegInt(Reg, 'Width',  Width);
      Height := ReadRegInt(Reg, 'Height', Height);
      Left   := ReadRegInt(Reg, 'Left',  ((screen.MonitorFromWindow(application.MainFormHandle).Width - width) div 2));
      Top    := ReadRegInt(Reg, 'Top',    ((screen.MonitorFromWindow(application.MainFormHandle).Height - height) div 2));
      State  := ReadRegInt(Reg, 'State',  State);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TPJRegWdwState.SaveWdwState(const Left, Top, Width, Height,
  State: Integer);
  {Writes window info to registry}
var
  Reg: TRegistry;   // instance of registry object class used to write info
  ARootKey: HKEY;   // registry root key where window state is stored
  ASubKey: string;  // sub key of registry in which to save window state
begin
  // Get registry keys in which to save window state
  GetRegInfo(ARootKey, ASubKey);
  // Open registry at required key
  Reg := TRegistry.Create;
  try
    Reg.RootKey := ARootKey;
    if Reg.OpenKey(ASubKey, True) then
    begin
      // Write window size, position and state from registry
      WriteRegInt(Reg, 'Left',   Left);
      WriteRegInt(Reg, 'Top',    Top);
      WriteRegInt(Reg, 'Width',  Width);
      WriteRegInt(Reg, 'Height', Height);
      WriteRegInt(Reg, 'State',  State);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TPJRegWdwState.SetSubKey(const Value: string);
  {Write access method for SubKey property: records value and, if value is empty
  string and it's run time the sub key is set to
    \Software\<App File Name>\Window\<Form Name>}
begin
  if (Value = '') and not (csDesigning in ComponentState) then
    fSubKey := Format(
      '\Software\%s\Window\%s',
      [ExtractFileName(ParamStr(0)), fWindow.Name]
    )
  else
    fSubKey := Value;
end;

end.

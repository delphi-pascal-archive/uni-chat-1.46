{****************************************************}
{            KeyState component for Delphi 16/32     }
{ Version:   2.0                                     }
{ Authors:   Aleksey Kuznetsov                       }
{ E-mail:    info@utilmind.com                       }
{ Home page: http://www.utilmind.com                 }
{ Created:   March 16, 1999                          }
{ Modified:  April 25, 1999                          }
{****************************************************}
{                 IMPORTANT NOTE:                    }
{  This code may be used and modified by anyone so   }
{ long as this header and copyright information      }
{ remains intact. By using this code you agree to    }
{ indemnify Aleksey Xacker from any liability that   }
{ might arise from its use. You must obtain written  }
{ consent before selling or redistributing this code }
{****************************************************}
{  Properties:                                       }
{    NumLock    - State of NumLock key               }
{    ScrollLock - State of ScrollLock key            }
{    CapsLock   - State of CapsLock key              }
{    Insert     - State of Insert key                }
{  Methods:                                          }
{    SaveState - Save full key state                 }
{    RestoreState - Restore full key state           }
{****************************************************}
{  Updated version by Pontus Bredin:                 }
{  e-mail: pontus@acacia.se                          }
{                                                    }
{  1999-04-25                                        }
{    - Component now sets the states SystemWide      }
{      under NT.                                     }
{    - The properties now checks the actual state.   }
{    - Removed the published properties, since they  }
{      where not very useful.                        }
{    - Added EventHandlers.                          }
{    - Added Init method. Used to call all events.   }
{                                                    }
{  This version has not been tested in Delphi 1 !!!  }
{                                                    }
{****************************************************}

unit KeyState;

interface

uses {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
     Classes, Forms, Messages;

type
  TKeyState = class(TComponent)
  private
    KeyState      : TKeyboardState;
    SavedKeyState : TKeyboardState;



    procedure SetState(Ctrl: Word; stOn: Boolean);
    procedure SetNumLock(stOn: Boolean);
    function  GetNumLock : boolean;
    procedure SetScrollLock(stOn: Boolean);
    function  GetScrollLock : boolean;
    procedure SetCapsLock(stOn: Boolean);
    function  GetCapsLock : boolean;
    procedure SetInsert(stOn: Boolean);
    function  GetInsert : boolean;
    function IsNT : boolean;
    function State(Ctrl : Word) : boolean;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SaveState;
    procedure RestoreState;
    property NumLock    : Boolean read GetNumLock write SetNumLock;
    property ScrollLock : Boolean read GetScrollLock write SetScrollLock;
    property CapsLock   : Boolean read GetCapsLock write SetCapsLock;
    property Insert     : Boolean read GetInsert write SetInsert;

  end;

procedure Register;

implementation

constructor TKeyState.Create(AOwner : TComponent);
begin
  inherited;
  FillChar(KeyState, SizeOf(TKeyboardState), 0); {Initialize}
  if not (csDesigning in ComponentState) then
  begin


  end;
end;

destructor TKeyState.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin

  end;
  inherited;
end;

function TKeyState.IsNT : boolean;
begin
  Result:=(GetVersion<$80000000);
end;

function TKeyState.State(Ctrl : Word) : boolean;
begin
  Result:=((KeyState[ctrl] and 1)=1);
end;

procedure TKeyState.SetState(Ctrl : word; stOn : boolean);
begin
  GetKeyboardState(KeyState);
  { Toggle KeyState if changed }
  if (State(ctrl) or stOn) then
  begin
    { Toggle KeyState SystemWide }
    keybd_event(Ctrl, 0, 0, 0);
    keybd_event(Ctrl, 0, KEYEVENTF_KEYUP, 0);
  end;
  { if not Windows NT this has to be done. }
  if not IsNT then
  begin
    Application.ProcessMessages; { Has to be here. Otherwise Win95 lose control. }
    { Set KeyState }
    KeyState[Ctrl]:=Byte(stOn);
    SetKeyboardState(KeyState);
  end;
end;

procedure TKeyState.SetNumLock(stOn: Boolean);
begin
  SetState(vk_NumLock, stOn);
end;

function TKeyState.GetNumLock : boolean;
begin
  GetKeyboardState(KeyState);
  Result:=State(vk_NumLock);
end;

procedure TKeyState.SetScrollLock(stOn: Boolean);
begin
  SetState(vk_Scroll, stOn);
end;

function TKeyState.GetScrollLock : boolean;
begin
  GetKeyboardState(KeyState);
  Result:=State(vk_Scroll);
end;

procedure TKeyState.SetCapsLock(stOn: Boolean);
begin
  SetState(vk_Capital, stOn);
end;

function TKeyState.GetCapsLock : boolean;
begin
  GetKeyboardState(KeyState);
  Result:=State(vk_Capital);
end;

procedure TKeyState.SetInsert(stOn: Boolean);
begin
  SetState(vk_Insert,stOn);
end;

function TKeyState.GetInsert : boolean;
begin
  GetKeyboardState(KeyState);
  Result:=State(vk_Insert);
end;

procedure TKeyState.SaveState;
begin
  GetKeyboardState(SavedKeyState);
end;

procedure TKeyState.RestoreState;
begin
  SetKeyboardState(SavedKeyState);
end;






procedure Register;
begin
  RegisterComponents('UtilMind', [TKeyState]);
end;

end.

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

unit SBProReg;

interface

uses
  Windows, Classes{, DsgnIntf};

type
  TStatusBarProEditor = class(TComponentEditor)
  protected
    procedure GetPropEdit(Editor: TPropertyEditor);
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;
  end;

procedure Register;

implementation

uses
  SBPro, TypInfo; 

function TStatusBarProEditor.GetVerbCount: Integer;
begin
  Result:= 1;
end;

function TStatusBarProEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Panels Editor...'
  else
    Result := inherited GetVerb(Index);
end;

procedure TStatusBarProEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    Edit
  else
    inherited ExecuteVerb(Index);
end;

procedure TStatusBarProEditor.GetPropEdit(Editor: TPropertyEditor);
begin
  if Editor.GetName = 'Panels' then
    Editor.Edit;
end;

procedure TStatusBarProEditor.Edit;
var
  List: {$IFDEF SBP_D5} TDesignerSelectionList {$ELSE} TComponentList {$ENDIF};
begin
  {$IFDEF SBP_D5}
  List := TDesignerSelectionList.Create;
  {$ELSE}
  List := TComponentList.Create;
  {$ENDIF}
  try
    List.Add(Component);
    GetComponentProperties(List, [tkClass], Designer, GetPropEdit);
  finally
    List.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('Win32', [TStatusBarPro]);
  RegisterComponentEditor(TStatusBarPro, TStatusBarProEditor);
end;

end.

{
UniChat - chat for LANs.
ExecuteThread.pas - Thread to execute hyperlinks - to disable chat hangs.

$Author(s): Dentall
$Last revision: 27/11/2004


All rights reserved.
Do not use source in shareware projects.
(c) 2002-2004 GlumClub team
}
unit ExecuteThread;

interface

uses
  Classes, ShellAPI, Windows, SysUtils, Dialogs;

type
  TExecuteURLThread = class(TThread)
  public
    url: string;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

procedure TExecuteURLThread.Execute;
{var
option: boolean;}
begin

{option:=False;
if ExtractFileExt(url)='' then
option:=True;}

url:=StringReplace(url,'%20',' ',[rfReplaceAll]);

  if pos('@', url) > 0 then
  if pos('ftp://',url) < 1 then
    if pos('mailto:', url) < 1 then
      url := 'mailto:' + url;

  ShellExecute(0, 'open', PChar(url), nil, nil, SW_SHOW);

{if option then
ShellExecute(0, 'explore', PChar(url), nil, nil, SW_SHOW);}

end;

end.

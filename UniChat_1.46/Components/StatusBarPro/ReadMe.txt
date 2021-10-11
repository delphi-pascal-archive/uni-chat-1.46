TStatusBarPro v1.1 for Delphi 3, 4, and 5
-----------------------------------------

Autor: Kambiz R. Khojasteh
E-mail: khojasteh@www.dci.co.ir
Web: http://www.crosswinds.net/~khojasteh/

Special thanks to:
  Rudi Loos (loos@intekom.co.za) for adding Color property to panels.

D E S C R I P T I O N
---------------------

TStatusBarPro is an improved version of Borland's StatusBar. Each status 
panel in this status bar can have its own color image, hint, popup menu, 
click event and double click event. In addition, TStatusBarPro accepts 
other controls as its child controls.

Important Note:
TStatusBarPro is not a subclass of TstatusBar. This control is a modified 
version of TStatusBar.    


I N S T A L L A T I O N
-----------------------

To install TStatusBarPro add following files into a new or existing package:

  1. SBProReg.pas
  2. SBPro.pas

After installation, TStatusBarPro will add to Win32 component palette.


I M P R O V M E N T S
---------------------

TStatusBarPro has the following new properties:

* Images: TImageList (Delphi 3)
* Images: TCustomImageList (Delphi 4 and 5)
  Images is a list of bitmaps that can be displayed to any panel in the 
  TStatuBarPro. Each panel can specify an image from this list by setting 
  its ImageIndex property.

Delphi 3 users also will find the following properties as new:

* Color: TColor
  Specifies the background color of the control.

* UseSystemFont: Boolean
  Specifies whether the status bar uses the system font.

Type of the following event changed in TStatusBarPro:

* OnDrawPanel: TDrawPanelProEvent
  TDrawPanelProEvent = procedure(StatusBar: TStatusBarPro; Panel: TStatusPanelPro;
                       const Rect: TRect) of object;
  Occurs when an owner draw status panel needs to be redrawn.

Type of the following property changed in TStatusBarPro:

* Panels: TStatusPanelsPro
  Panels property lists the panels (TStatusPanelPro) in the status bar.

Each panel (TStatusPanePro) has the following new properties:

* Color: TColor
  Specifies the background color of the panel.

* ImageIndex: Intege
  Determines the image (from the TStatusBarPro.Images list) that appears 
  on the panel.

* Hint: String
  Contains the text string that can appear when the user moves the mouse 
  over the panel. If this property set to blank, hint property of 
  TStatusBarPro will be used.

* PopupMenu: TPopupMenu
  Identifies the pop-up menu associated with the panel. If this property 
  set to nil, popup menu property of TStatusBarPro will be used.
  
Each panel has the following new events:
  
* OnClick: TNotifyEvent
  Occurs when the use click the panel. If this event is unassigned,
  the OnClick event of TStatusBarPro will fire. 

* OnDblClick: TNotifyEvent
  Occurs when the user double-clicks the primary mouse button when the 
  mouse pointer is over the panel. If this event is unassigned, the 
  OnDblClick event of TStatusBarPro will fire. 


H I S T O R Y
-------------

* Version 1.1 - 24 Sep 2000
  - Color property added to Panels. (Thanks to Rudi Loos)

* Version 1.0 - 8 Mar 2000
  - Initial release.


D I S C L A I M E R											
-------------------

This component is provided AS-IS. I will not be responsable for any dammage			
due to use of this component. This component is freeware for commercial and
non-commercial use.


Thank you,

Kambiz

------------------------------------------------------------------------------
  Unit     : fisHotKey.pas
  Purpose  : System-Wide HotKey Component
  Status   : Freeware
  Version  : 1.00, 19 May 2000
  Copyright: © First Internet Software House Ltd. 2000
  Contact  : http://www.fishouse.com (email: support@fishouse.com)
-------------------------------------------------------------------------------

This component registers a system-wide key combination to the operating system.
When the key combination is created anywhere in the operating system, this
component will get the keypress first and call the OnHotKey event. The application
does not have to be active or visible for the OnHotKey event to be fired.

The HotKey property in our implementation consists of a TShortcut so that any
key combination you can register in a normal shortcut, you can also register as
a HotKey.

Any number of TfisHotKey components can be added to a form. Each component is setup
by selected the desired key combinations from the list in the HotKey property and
then setting the event handler. As long as the component is Enabled the OnHotKey
event will fire when the key combination is pressed.

If the key combination is changed at run time and the component is Enabled, the new
key combination will automatically be registered.

The key combination must be unique to the operating system, i.e No other HotKey can
be registered with the same key combination. To test whether your HotKey registration
has been successful, check the Registered property.

-------------------------------------------------------------------------------

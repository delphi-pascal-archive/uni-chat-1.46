object fmComment: TfmComment
  Left = 532
  Top = 299
  BorderStyle = bsDialog
  ClientHeight = 78
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object cbData: TComboBox
    Left = 8
    Top = 16
    Width = 385
    Height = 21
    ItemHeight = 0
    TabOrder = 0
    OnKeyPress = cbDataKeyPress
  end
  object bnOK: TButton
    Left = 240
    Top = 48
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = bnOKClick
  end
  object bnCancel: TButton
    Left = 320
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object PJRegWdwState1: TPJRegWdwState
    AutoSaveRestore = True
    IgnoreState = True
    Options = [woIgnoreState, woIgnoreSize]
    SubKey = 'Software\UniChat145\CommentForm'
    Left = 80
    Top = 16
  end
end

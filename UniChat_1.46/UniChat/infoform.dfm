object fmInfo: TfmInfo
  Left = 649
  Top = 254
  ActiveControl = bnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 438
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    000B000000230000002F0000002F0000002F0000002F0000002F0000002F0000
    002F0000002F0000002F0000002F0000002F0000002F0000002F000000230000
    0000DCAA86FFA97E79FFA97E79FFA97E79FFA97E79FFA97E79FFA97E79FFA97E
    79FFA97E79FFA97E79FFA97E79FFA97E79FFA97E79FFA97E79FF0000002F0000
    0000DCAA86FFFFF4ECFFFFF1E8FFFFEFE3FFFFECDFFFFFE9DAFFFFE6D5FFFFE3
    D0FFFFE0CBFFFFDDC6FFFFDAC2FFFFDAC2FFFFDAC2FFA97E79FF0000002F0000
    0000DCAA86FFFFF4ECFFFFF4ECFFFFF0E6FFFFEFE3FFFFECDFFFFFE9DAFFFFE6
    D5FFFFE3D0FFA97E79FFFFDDC6FFFFDAC2FFFFDAC2FFA97E79FF0000002F0000
    0000DCAA86FFFFF6F0FFFFF6F0FFFFF4ECFFFFF0E6FFFFEFE3FFFFECDFFFFFE9
    DAFFFFE6D5FFFFE3D0FFFFE0CBFFFFDDC6FFFFDAC2FFA97E79FF0000002F0000
    0000DCAA86FFFFF7F3FFFFF7F3FFFFF6F0FFFFF4ECFFFFF0E6FFFFEFE3FFFFEC
    DFFFFFE9DAFFA97E79FFFFE3D0FFFFE0CBFFFFDDC6FFA97E79FF0000002F0000
    0000DCAA86FFFFF9F5FFFFF9F5FFFFF7F2FFFFF6F0FFFFF4ECFFFFF0E6FFFFEF
    E3FFFFECDFFFFFE9DAFFA97E79FFFFE3D0FFFFE0CBFFA97E79FF0000002F0000
    0000DCAA86FFFFF9F5FFFFF9F5FFFFF9F5FFFFF7F3FFFFF6F0FFFFF4ECFFFFF0
    E6FFFFEFE3FFFFECDFFFFFE9DAFFA97E79FFFFE3D0FFA97E79FF0000002F0000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFF9F5FFFFF7F3FFFFF6F0FFA97E
    79FFFFF0E6FFFFEFE3FFFFECDFFFA97E79FFFFE6D5FFA97E79FF0000002F0000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFF9F5FFFFF7F3FFFFF6
    F0FFA97E79FFA97E79FFA97E79FFFFECDFFFFFE9DAFFA97E79FF0000002F0000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFF8F4FFFFF7
    F2FFFFF6F0FFFFF4ECFFFFF1E7FFFFEFE3FFFFECDFFFA97E79FF0000002F0000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFF9
    F5FFFFF7F2FFFFF6F0FFFFF4ECFFFFF1E8FFFFEFE3FFA97E79FF0000002F0000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFA
    F7FFFFF9F5FFFFF7F3FFFFF6F0FFFFF4ECFFFFF1E8FFA97E79FF000000230000
    0000DCAA86FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFAF7FFFFFA
    F7FFFFF9F5FFFFF7F3FFFFF6F0FFFFF4ECFFFFF4ECFFA97E79FF000000230000
    0000DCAA86FFDCAA86FFDCAA86FFDCAA86FFDCAA86FFDCAA86FFDCAA86FFDCAA
    86FFDCAA86FFDCAA86FFDCAA86FFDCAA86FFDCAA86FFA97E79FF0000000B0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000800000008000000080000000800000008000000080000000800000008000
    0000800000008000000080000000800000008000000080000000FFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  PrintScale = poNone
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object bnOK: TButton
    Left = 116
    Top = 406
    Width = 81
    Height = 25
    Caption = #1054#1050
    TabOrder = 0
    OnClick = bnOKClick
  end
  object bnRefresh: TButton
    Tag = 5
    Left = 16
    Top = 406
    Width = 91
    Height = 25
    Enabled = False
    TabOrder = 1
    OnClick = bnRefreshClick
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 8
    Width = 193
    Height = 390
    Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 76
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 61
      Height = 13
      Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 46
      Height = 13
      Caption = 'IP '#1072#1076#1088#1077#1089':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 64
      Width = 58
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' '#1054#1057':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 80
      Width = 81
      Height = 13
      Caption = #1042#1077#1088#1089#1080#1103' UniChat:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 112
      Width = 73
      Height = 13
      Caption = #1042#1089#1077#1075#1086' '#1087#1072#1084#1103#1090#1080':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 128
      Width = 83
      Height = 13
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 8
      Top = 96
      Width = 177
      Height = 10
      Shape = bsBottomLine
    end
    object Bevel2: TBevel
      Left = 8
      Top = 144
      Width = 177
      Height = 10
      Shape = bsBottomLine
    end
    object Label7: TLabel
      Left = 8
      Top = 160
      Width = 78
      Height = 13
      Caption = #1040#1082#1090#1080#1074#1085#1086#1077' '#1086#1082#1085#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 8
      Top = 192
      Width = 177
      Height = 10
      Shape = bsBottomLine
    end
    object Label9: TLabel
      Left = 8
      Top = 208
      Width = 49
      Height = 13
      Caption = #1050#1086#1084#1085#1072#1090#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 8
      Top = 268
      Width = 177
      Height = 10
      Shape = bsBottomLine
    end
    object Label10: TLabel
      Left = 8
      Top = 344
      Width = 152
      Height = 13
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel5: TBevel
      Left = 8
      Top = 330
      Width = 177
      Height = 10
      Shape = bsBottomLine
    end
    object lbComp: TLabel
      Left = 104
      Top = 32
      Width = 3
      Height = 13
      Cursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbCompClick
    end
    object edWindow: TEdit
      Left = 8
      Top = 178
      Width = 177
      Height = 21
      AutoSelect = False
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object mm: TMemo
      Left = 8
      Top = 284
      Width = 177
      Height = 45
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object lbChan: TListBox
      Left = 8
      Top = 225
      Width = 177
      Height = 43
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = lbChanDblClick
    end
    object edUsrNfo: TEdit
      Left = 8
      Top = 363
      Width = 177
      Height = 21
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object edUser: TEdit
      Left = 104
      Top = 16
      Width = 81
      Height = 13
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edIP: TEdit
      Left = 104
      Top = 48
      Width = 81
      Height = 13
      Cursor = crHandPoint
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      OnClick = edIPClick
    end
    object edOS: TEdit
      Left = 104
      Top = 64
      Width = 81
      Height = 13
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object eduVer: TEdit
      Left = 104
      Top = 80
      Width = 81
      Height = 13
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edTotal: TEdit
      Left = 104
      Top = 112
      Width = 81
      Height = 13
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edUse: TEdit
      Left = 104
      Top = 128
      Width = 81
      Height = 13
      AutoSelect = False
      AutoSize = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
  end
  object PJRegWdwState1: TPJRegWdwState
    AutoSaveRestore = True
    Options = [woIgnoreSize]
    SubKey = 'Software\UniChat145\InfoForm'
    Left = 108
    Top = 160
  end
  object TimerAR: TTimer
    Enabled = False
    Interval = 999
    OnTimer = TimerARTimer
    Left = 56
    Top = 136
  end
end

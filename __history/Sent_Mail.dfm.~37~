object SentMail: TSentMail
  Left = 0
  Top = 0
  Caption = 'SentMail'
  ClientHeight = 342
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    869
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 1
    Top = 21
    Width = 865
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Mesaje trimise'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clScrollBar
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 20
    Width = 865
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Mesaje trimise'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object TLabel
    Left = 208
    Top = 336
    Width = 3
    Height = 13
  end
  object DBMail: TDBGrid
    Left = 0
    Top = 60
    Width = 869
    Height = 263
    TabStop = False
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = True
    DataSource = DS
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    PopupMenu = pMenu
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBMailDrawColumnCell
    OnMouseMove = DBMailMouseMove
    Columns = <
      item
        Expanded = False
        FieldName = 'SENT'
        Title.Alignment = taCenter
        Title.Caption = '!'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 16
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADRESSES'
        Title.Alignment = taCenter
        Title.Caption = 'Destinatar'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 178
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TITLE'
        Title.Alignment = taCenter
        Title.Caption = 'Subiect'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 221
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER'
        Title.Alignment = taCenter
        Title.Caption = 'Trimis de'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BODY'
        Title.Alignment = taCenter
        Title.Caption = 'Mesaj'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 215
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIMESTAMP'
        Title.Alignment = taCenter
        Title.Caption = 'Data'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATACHMENTS'
        Title.Alignment = taCenter
        Title.Caption = 'Atasamente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADRESS_COUNT'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end>
  end
  object Status: TStatusBar
    Left = 0
    Top = 323
    Width = 869
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PBar: TRbProgressBar
    Left = 1
    Top = 325
    Width = 150
    Height = 16
    Anchors = [akLeft, akBottom]
    Visible = False
    TabOrder = 2
    TextShadow = True
    ShowCaption = True
    DefaultFrom = 11966334
    DefaultTo = 14734025
    Max = 100
    Min = 0
    Position = 0
    Step = 1
    BorderLines = [blTop, blBottom, blLeft, blRight]
    BorderColor = clGray
    BorderWidth = 1
    GradientType = gtVertical
    Orientation = pbHorizontal
    ShowText = True
  end
  object DS: TDataSource
    DataSet = QMail
    Left = 40
    Top = 88
  end
  object QMail: TQuery
    AfterScroll = QMailAfterScroll
    DatabaseName = 'dsTest'
    SQL.Strings = (
      
        'SELECT SENT, MID(REPLACE(ADRESSES,"&quot;", '#39'"'#39'), 1, 200) ADRESS' +
        'ES, TITLE, MID(REPLACE(BODY,"&quot;", '#39'"'#39'), 1, 200) BODY, TIMEST' +
        'AMP, MID(REPLACE(ATACHMENTS,"&quot;", '#39'"'#39'),1,200) ATACHMENTS, AD' +
        'RESS_COUNT, ID, USER FROM `dbcabconta`.`SENTMAIL`')
    Left = 8
    Top = 88
  end
  object pMenu: TPopupMenu
    Left = 72
    Top = 88
    object rimitedinnou1: TMenuItem
      Caption = '&Trimite din nou'
      ShortCut = 116
      OnClick = rimitedinnou1Click
    end
    object Editare1: TMenuItem
      Caption = '&Editare'
      ShortCut = 13
      OnClick = Editare1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Sterge1: TMenuItem
      Caption = '&Sterge'
      ShortCut = 46
      OnClick = Sterge1Click
    end
  end
end

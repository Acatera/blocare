object EMail: TEMail
  Left = 0
  Top = 0
  Hint = 'Client facturabil'
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'EMail'
  ClientHeight = 461
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    519
    461)
  PixelsPerInch = 96
  TextHeight = 13
  object LContact: TLabel
    Left = 2
    Top = 186
    Width = 103
    Height = 16
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Persoane contact:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 133
  end
  object STARE: TShape
    Left = 478
    Top = 157
    Width = 36
    Height = 24
    Hint = 'Client facturabil'
    Anchors = [akRight, akBottom]
    Brush.Color = clGreen
    ParentShowHint = False
    Shape = stRoundRect
    ShowHint = True
    ExplicitLeft = 453
    ExplicitTop = 104
  end
  object LStare: TLabel
    Left = 478
    Top = 141
    Width = 36
    Height = 16
    Anchors = [akRight, akBottom]
    Caption = 'Stare:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 88
  end
  object Title: TLabel
    Left = 0
    Top = 9
    Width = 519
    Height = 29
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Adaugare client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object MODULE: TLabeledEdit
    Left = 346
    Top = 157
    Width = 126
    Height = 24
    TabStop = False
    Anchors = [akRight, akBottom]
    EditLabel.Width = 46
    EditLabel.Height = 16
    EditLabel.Caption = 'Module:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnKeyPress = MODULEKeyPress
  end
  object DBContact: TDBGrid
    Left = 2
    Top = 202
    Width = 514
    Height = 210
    Anchors = [akLeft, akRight, akBottom]
    DataSource = DSMail
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawDataCell = DBContactDrawDataCell
    OnDrawColumnCell = DBContactDrawColumnCell
    OnDblClick = DBContactDblClick
    OnKeyPress = DBContactKeyPress
    OnKeyUp = DBContactKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'DENFC'
        Title.Caption = 'Nume'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 179
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEL'
        Title.Caption = 'Telefon'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Caption = 'E-mail'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 151
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCONTRACTE'
        Title.Caption = 'Module'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end>
  end
  object EDenFC: TLabeledEdit
    Left = 2
    Top = 72
    Width = 338
    Height = 24
    Anchors = [akRight, akBottom]
    EditLabel.Width = 60
    EditLabel.Height = 16
    EditLabel.Caption = 'Denumire:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnEnter = EditEnter
    OnExit = EDenFCExit
    OnKeyPress = EditKeyPress
    OnKeyUp = EDenFCKeyUp
  end
  object EAdr: TLabeledEdit
    Left = 2
    Top = 114
    Width = 338
    Height = 24
    Anchors = [akRight, akBottom]
    EditLabel.Width = 45
    EditLabel.Height = 16
    EditLabel.Caption = 'Adresa:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnEnter = EditEnter
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object EEMail: TLabeledEdit
    Left = 2
    Top = 157
    Width = 338
    Height = 24
    Anchors = [akRight, akBottom]
    EditLabel.Width = 41
    EditLabel.Height = 16
    EditLabel.Caption = 'E-mail:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnEnter = EditEnter
    OnExit = EditExit
    OnKeyPress = EEMailKeyPress
  end
  object EFax: TLabeledEdit
    Left = 346
    Top = 114
    Width = 168
    Height = 24
    Anchors = [akRight, akBottom]
    EditLabel.Width = 25
    EditLabel.Height = 16
    EditLabel.Caption = 'Fax:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnEnter = EditEnter
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object ETel: TLabeledEdit
    Left = 346
    Top = 72
    Width = 168
    Height = 24
    Anchors = [akRight, akBottom]
    EditLabel.Width = 48
    EditLabel.Height = 16
    EditLabel.Caption = 'Telefon:'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnEnter = EditEnter
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object Btn_Salvare: TButton
    Left = 164
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akLeft, akRight]
    Caption = 'Salveaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = Btn_SalvareClick
  end
  object Btn_Renunta: TButton
    Left = 276
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akLeft, akRight]
    Caption = 'Renunta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = Btn_RenuntaClick
  end
  object PBottom: TPanel
    Left = 0
    Top = 444
    Width = 519
    Height = 17
    Align = alBottom
    Caption = '[F4 - Adaugare] [F7 - Cautare] [Del - Stergere]'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 9
  end
  object ECauta: TEdit
    Left = 2
    Top = 379
    Width = 514
    Height = 33
    Anchors = [akLeft, akBottom]
    Color = 16113353
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'ECauta'
    Visible = False
    OnExit = ECautaExit
    OnKeyPress = ECautaKeyPress
  end
  object TempDB: TDBGrid
    Left = 2
    Top = 95
    Width = 338
    Height = 242
    Anchors = [akLeft, akRight, akBottom]
    DataSource = DSMail
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Visible = False
    OnDblClick = TempDBDblClick
    OnKeyPress = TempDBKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'DENFUR'
        Title.Caption = 'Denumire'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 169
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFUR'
        Title.Caption = 'Cod Fiscal'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT'
        Title.Caption = 'Contract'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end>
  end
  object Btn_Echiv: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Echivaleaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Visible = False
    OnClick = Btn_EchivClick
  end
  object ECauta2: TEdit
    Left = 2
    Top = 304
    Width = 338
    Height = 33
    Anchors = [akLeft, akBottom]
    Color = 16113353
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    Text = 'ECauta'
    Visible = False
    OnExit = ECauta2Exit
    OnKeyPress = ECauta2KeyPress
  end
  object QMail: TQuery
    DatabaseName = 'dsTest'
    SQL.Strings = (
      
        'SELECT DENFC, TEL, EMAIL, CODCONTRACTE, ID FROM `DBCABCONTA`.`CO' +
        'NTACT`')
    Left = 62
    Top = 272
  end
  object DSMail: TDataSource
    DataSet = QMail
    Left = 96
    Top = 272
  end
end

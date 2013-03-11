object SesizDetail: TSesizDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Adaugare sesizare'
  ClientHeight = 496
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    573
    496)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 2
    Top = 48
    Width = 59
    Height = 16
    Caption = 'Data apel:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 143
    Top = 48
    Width = 103
    Height = 16
    Caption = 'Data programare:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 2
    Top = 93
    Width = 59
    Height = 16
    Caption = 'Problema:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label4: TLabel
    Left = 284
    Top = 47
    Width = 42
    Height = 16
    Caption = 'Pentru:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label5: TLabel
    Left = 2
    Top = 323
    Width = 110
    Height = 16
    Caption = 'Sesizare rezolvata:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label7: TLabel
    Left = 2
    Top = 341
    Width = 57
    Height = 16
    Caption = 'Rezolvari:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object SRez: TShape
    Left = 113
    Top = 319
    Width = 36
    Height = 24
    Hint = 'Sesizare nerezolvata'
    Brush.Color = clRed
    ParentShowHint = False
    Shape = stRoundRect
    ShowHint = True
  end
  object EID: TLabeledEdit
    Left = 2
    Top = 19
    Width = 102
    Height = 24
    TabStop = False
    EditLabel.Width = 73
    EditLabel.Height = 16
    EditLabel.Caption = 'Nr. sesizare:'
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
    OnKeyPress = EIDKeyPress
  end
  object EClient: TLabeledEdit
    Left = 110
    Top = 19
    Width = 461
    Height = 24
    EditLabel.Width = 37
    EditLabel.Height = 16
    EditLabel.Caption = 'Client:'
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
    OnEnter = EClientEnter
    OnExit = EClientExit
    OnKeyPress = EClientKeyPress
    OnKeyUp = EClientKeyUp
  end
  object DApel: TDateTimePicker
    Left = 2
    Top = 67
    Width = 130
    Height = 24
    Date = 40248.487932395830000000
    Time = 40248.487932395830000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnEnter = DApelEnter
    OnExit = DProgramatExit
    OnKeyPress = DApelKeyPress
  end
  object DProgramat: TDateTimePicker
    Left = 143
    Top = 67
    Width = 130
    Height = 24
    Date = 40248.487932395830000000
    Time = 40248.487932395830000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnEnter = DApelEnter
    OnExit = DProgramatExit
    OnKeyPress = DApelKeyPress
  end
  object Btn_Detalii: TButton
    Left = 460
    Top = 67
    Width = 111
    Height = 25
    Caption = 'Situatie client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = Btn_DetaliiClick
  end
  object Problema: TMemo
    Left = 2
    Top = 113
    Width = 569
    Height = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object CPentru: TComboBox
    Left = 284
    Top = 67
    Width = 170
    Height = 24
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 3
    OnEnter = CPentruEnter
    OnKeyPress = CPentruKeyPress
  end
  object CPublic: TCheckBox
    Left = 460
    Top = 47
    Width = 97
    Height = 17
    Caption = 'Public'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnKeyPress = CPublicKeyPress
  end
  object DBRezolvari: TDBGrid
    Left = 2
    Top = 363
    Width = 569
    Height = 84
    TabStop = False
    DataSource = DS
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBRezolvariDrawColumnCell
    OnDblClick = DBRezolvariDblClick
    OnKeyPress = DBRezolvariKeyPress
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'BIFAT_DE'
        Title.Alignment = taCenter
        Title.Caption = 'Angajat'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'BIFAT_OK'
        Title.Alignment = taCenter
        Title.Caption = 'Definitiv'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEXT_REZOLVAT'
        Title.Alignment = taCenter
        Title.Caption = 'Detalii rezolvare'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 347
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'row_id'
        Visible = False
      end>
  end
  object Btn_Renunta: TButton
    Left = 299
    Top = 468
    Width = 80
    Height = 25
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
  object Btn_Salveaza: TButton
    Left = 197
    Top = 468
    Width = 80
    Height = 25
    Caption = 'Salveaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = Btn_SalveazaClick
  end
  object PBottom: TPanel
    Left = 2
    Top = 446
    Width = 569
    Height = 18
    Caption = 
      '[F4 - Adauga rezolvare] [F6 - Modifica rezolvare] [Del - Sterge ' +
      'rezolvare]'
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 11
  end
  object TempDB: TDBGrid
    Left = 110
    Top = 43
    Width = 403
    Height = 64
    Anchors = [akLeft, akRight, akBottom]
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
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Visible = False
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
  object Query: TQuery
    DatabaseName = 'dsTest'
    SQL.Strings = (
      'SELECT * FROM FCOMUN.REZOLVARI')
    Left = 82
    Top = 142
  end
  object DS: TDataSource
    DataSet = Query
    Left = 114
    Top = 142
  end
end

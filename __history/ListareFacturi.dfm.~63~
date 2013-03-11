object ListFact: TListFact
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Procesare facturi'
  ClientHeight = 457
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    591
    457)
  PixelsPerInch = 96
  TextHeight = 16
  object LTitle: TLabel
    Left = 0
    Top = 16
    Width = 591
    Height = 25
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Procesare facturi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 1169
  end
  object LRecordCount: TLabel
    Left = 378
    Top = 285
    Width = 213
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'LRecordCount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LDBGest: TLabel
    Left = 466
    Top = 419
    Width = 32
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'Baza:'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 376
  end
  object DBFact: TDBGrid
    Left = 0
    Top = 135
    Width = 591
    Height = 270
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DS
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBFactDrawColumnCell
    OnKeyPress = DBFactKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'COD'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DENUMIRE'
        Width = 476
        Visible = True
      end>
  end
  object PBottom: TPanel
    Left = 0
    Top = 439
    Width = 591
    Height = 18
    Align = alBottom
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
  end
  object CGest: TComboBox
    Left = 504
    Top = 411
    Width = 85
    Height = 24
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    Enabled = False
    ItemHeight = 16
    TabOrder = 2
  end
  object Btn_List: TButton
    Left = 202
    Top = 408
    Width = 90
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Proceseaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Btn_ListClick
  end
  object Btn_Renunta: TButton
    Left = 299
    Top = 408
    Width = 90
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Renunta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Btn_RenuntaClick
  end
  object Panel1: TPanel
    Left = 5
    Top = 50
    Width = 197
    Height = 56
    TabOrder = 5
    object RBData: TRadioButton
      Left = 4
      Top = 7
      Width = 197
      Height = 17
      Caption = 'Dupa produsul facturat'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = RBDataClick
    end
    object RBNumar: TRadioButton
      Left = 4
      Top = 31
      Width = 185
      Height = 17
      Caption = 'Dupa numarul facturii'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = RBNumarClick
    end
  end
  object Panel2: TPanel
    Left = 205
    Top = 50
    Width = 381
    Height = 56
    TabOrder = 6
    object LData: TLabel
      Left = 5
      Top = 7
      Width = 155
      Height = 21
      Caption = 'Perioada de facturare: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object LNumar: TLabel
      Left = 5
      Top = 31
      Width = 226
      Height = 21
      Caption = 'Numar:                                          -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Z1: TEdit
      Left = 164
      Top = 4
      Width = 28
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '1'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object L1: TEdit
      Left = 191
      Top = 4
      Width = 28
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '01'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object A1: TEdit
      Left = 218
      Top = 4
      Width = 41
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '2010'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object Z2: TEdit
      Left = 283
      Top = 4
      Width = 28
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '31'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object L2: TEdit
      Left = 310
      Top = 4
      Width = 28
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '2'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object A2: TEdit
      Left = 337
      Top = 4
      Width = 41
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '2010'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object ENrInc: TEdit
      Left = 164
      Top = 29
      Width = 95
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = '1'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object ENrSf: TEdit
      Left = 283
      Top = 29
      Width = 95
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = '999999999'
      Visible = False
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
  end
  object Panel3: TPanel
    Left = 5
    Top = 109
    Width = 581
    Height = 22
    TabOrder = 7
    object chAuto: TCheckBox
      Left = 4
      Top = 2
      Width = 165
      Height = 17
      Caption = 'Procesare automata'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = chAutoClick
    end
    object chMail: TCheckBox
      Left = 205
      Top = 2
      Width = 104
      Height = 17
      Caption = 'Trimite mail'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = chAutoClick
    end
    object chEx1: TCheckBox
      Left = 364
      Top = 2
      Width = 107
      Height = 17
      Caption = 'Exemplar 1'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = chAutoClick
    end
    object chEx2: TCheckBox
      Left = 483
      Top = 2
      Width = 99
      Height = 17
      Caption = 'Exemplar 2'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
      OnClick = chAutoClick
    end
  end
  object DS: TDataSource
    DataSet = Query
    Left = 40
    Top = 160
  end
  object Query: TQuery
    DatabaseName = 'dsTest'
    SQL.Strings = (
      'SELECT COD, DENUMIRE'
      'FROM fsoftware.MIV0910 '
      'GROUP BY COD')
    Left = 8
    Top = 160
  end
end

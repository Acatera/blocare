object FurDetail: TFurDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Detalii partener'
  ClientHeight = 407
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    593
    407)
  PixelsPerInch = 96
  TextHeight = 13
  object LTotal: TLabel
    Left = 465
    Top = 175
    Width = 61
    Height = 16
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    Caption = 'Total sold:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    ExplicitLeft = 439
  end
  object LNrFact: TLabel
    Left = 3
    Top = 175
    Width = 106
    Height = 16
    Caption = 'Nr fact neachitate:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LLaZi: TLabel
    Left = 0
    Top = 47
    Width = 593
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Clientul selectat nu are facturi restante.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LContract: TLabel
    Left = 3
    Top = 211
    Width = 55
    Height = 16
    Caption = 'Contracte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LFacturi: TLabel
    Left = 3
    Top = 48
    Width = 39
    Height = 16
    Caption = 'Facturi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EStare: TShape
    Left = 555
    Top = 19
    Width = 35
    Height = 24
    Hint = 'Client facturabil'
    Brush.Color = clGreen
    ParentShowHint = False
    ShowHint = True
  end
  object Label1: TLabel
    Left = 555
    Top = 0
    Width = 36
    Height = 16
    Caption = 'Stare:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LModule: TLabel
    Left = 3
    Top = 323
    Width = 179
    Height = 16
    Caption = 'Situatia modulelor achizitionate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBFact: TDBGrid
    Left = 3
    Top = 64
    Width = 587
    Height = 110
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clWhite
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
    PopupMenu = FactMenu
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBFactDrawColumnCell
    OnDblClick = DBFactDblClick
    OnKeyPress = DBFactKeyPress
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'FIRMA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Firma'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NRDFC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Nr. fact.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATAFC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Data factura'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 86
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SUMADB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taRightJustify
        Title.Caption = 'Total fact'
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
        FieldName = 'SUMACR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Achitat'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 87
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SUMA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taRightJustify
        Title.Caption = 'Rest plata'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 86
        Visible = True
      end>
  end
  object ECOD_FISCAL: TLabeledEdit
    Left = 3
    Top = 19
    Width = 100
    Height = 24
    TabStop = False
    EditLabel.Width = 60
    EditLabel.Height = 16
    EditLabel.Caption = 'Cod fiscal:'
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
    OnKeyPress = ECOD_FISCALKeyPress
  end
  object EDENFUR: TLabeledEdit
    Left = 106
    Top = 19
    Width = 238
    Height = 24
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
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
    TabOrder = 2
    OnKeyPress = ECOD_FISCALKeyPress
  end
  object DBContract: TDBGrid
    Left = 3
    Top = 227
    Width = 587
    Height = 84
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    DataSource = DSC
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBContractDrawColumnCell
    OnMouseMove = DBContractMouseMove
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONCAT(NUMAR, " / ", CONCAT(SUB'
        Title.Alignment = taCenter
        Title.Caption = 'Contract'
        Width = 88
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONCAT(CONCAT(SUBSTRING(DATAIN,'
        Title.Alignment = taCenter
        Title.Caption = 'Durata'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 135
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONCAT(VALOARE, " ", TIPVALUT)'
        Title.Alignment = taCenter
        Title.Caption = 'Valoare'
        Width = 73
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IF(CLASA=12,"Anual",IF(CLASA=6,'
        Title.Caption = 'Frecv.'
        Width = 41
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONTRACT'
        Title.Alignment = taCenter
        Title.Caption = 'Module'
        Width = 99
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'REPLACE(REPLACE(REPLACE(REPLACE'
        Title.Alignment = taCenter
        Title.Caption = 'Firma'
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IF(CONCAT(SUBSTRING(DATAOUT,3,2'
        Title.Caption = 'I'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'OBS'
        Visible = False
      end>
  end
  object Btn_Fisa: TButton
    Left = 498
    Top = 200
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Fisa clientului'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Btn_FisaClick
  end
  object Btn_Extras: TButton
    Left = 400
    Top = 200
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Extras cont'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Btn_ExtrasClick
  end
  object DBModule: TDBGrid
    Left = 3
    Top = 341
    Width = 587
    Height = 44
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    DataSource = DSM
    FixedColor = 16744576
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBModuleDrawColumnCell
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(C)'
        Title.Alignment = taCenter
        Title.Caption = 'Contab.'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(G)'
        Title.Alignment = taCenter
        Title.Caption = 'Gest.'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(S)'
        Title.Alignment = taCenter
        Title.Caption = 'Salarii'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(M)'
        Title.Alignment = taCenter
        Title.Caption = 'Mij. fixe'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(F)'
        Title.Alignment = taCenter
        Title.Caption = 'Farmacii'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(GW)'
        Title.Alignment = taCenter
        Title.Caption = 'Gest. Win.'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(RC)'
        Title.Alignment = taCenter
        Title.Caption = 'Reg. casa'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(EX)'
        Title.Alignment = taCenter
        Title.Caption = 'Exchange'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SUM(GR)'
        Title.Alignment = taCenter
        Title.Caption = 'Gest. rest.'
        Width = 62
        Visible = True
      end>
  end
  object Btn_Mail: TButton
    Left = 302
    Top = 200
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Trimite mail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = Btn_MailClick
  end
  object Btn_Jurnal: TButton
    Left = 204
    Top = 200
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Adauga jurnal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = Btn_JurnalClick
  end
  object CBAll: TCheckBox
    Left = 537
    Top = 47
    Width = 53
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Toate'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 9
    OnClick = CBAllClick
  end
  object Btn_Rulaj: TButton
    Left = 106
    Top = 200
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Rulaj lunar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = Btn_RulajClick
  end
  object EEMail: TLabeledEdit
    Left = 346
    Top = 19
    Width = 206
    Height = 24
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 132
    EditLabel.Height = 16
    EditLabel.Caption = 'eMail pentru facturare:'
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
    TabOrder = 11
    OnEnter = EEMailEnter
    OnExit = EEMailExit
    OnKeyDown = EEMailKeyDown
  end
  object QFact: TQuery
    DatabaseName = 'dsTest'
    ParamCheck = False
    SQL.Strings = (
      
        'SELECT "DSOFT" as FIRMA,  NRDFC, DATAFC, SUMADB, SUMACR, (SUMADB' +
        ' - SUMACR)  AS SUMA FROM `fservices`.`FRES0210` WHERE CODFC = "R' +
        'O4847122"')
    Left = 15
    Top = 99
  end
  object DS: TDataSource
    DataSet = QFact
    Left = 47
    Top = 99
  end
  object QContracte: TQuery
    DatabaseName = 'dsTest'
    ParamCheck = False
    Left = 15
    Top = 267
  end
  object DSC: TDataSource
    DataSet = QContracte
    Left = 47
    Top = 267
  end
  object MQuery: TQuery
    DatabaseName = 'dsTest'
    ParamCheck = False
    SQL.Strings = (
      
        'SELECT CODFUR, SUM(C),SUM(G),SUM(S),SUM(M),SUM(F),SUM(GW),SUM(RC' +
        '),SUM(EX),SUM(GR) FROM DBCABCONTA.AL_MIV GROUP BY CODFUR'
      '')
    Left = 8
    Top = 360
  end
  object DSM: TDataSource
    DataSet = MQuery
    Left = 40
    Top = 360
  end
  object FactMenu: TPopupMenu
    Left = 80
    Top = 99
    object L1: TMenuItem
      Caption = 'Listare factura'
      OnClick = L1Click
    end
    object rimitemail1: TMenuItem
      Caption = 'Trimite mail...'
      OnClick = Trimitemail1Click
    end
  end
end

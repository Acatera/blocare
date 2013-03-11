object ExtrasCont: TExtrasCont
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Extras Cont'
  ClientHeight = 120
  ClientWidth = 416
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
  PixelsPerInch = 96
  TextHeight = 13
  object Btn_Afiseaza: TButton
    Left = 133
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Afiseaza'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Btn_AfiseazaClick
  end
  object Btn_Renunta: TButton
    Left = 214
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Renunta'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Btn_RenuntaClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 200
    Height = 65
    Caption = 'Selectati data extrasului:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Z1: TEdit
      Left = 46
      Top = 26
      Width = 33
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '31'
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object L1: TEdit
      Left = 79
      Top = 26
      Width = 33
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '12'
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
    object A1: TEdit
      Left = 112
      Top = 26
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
      OnEnter = Z1Enter
      OnExit = Z1Exit
      OnKeyPress = Z1KeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 214
    Top = 8
    Width = 194
    Height = 65
    Caption = 'Actiuni:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object CActions: TComboBox
      Left = 16
      Top = 26
      Width = 177
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Listeaza'
      Items.Strings = (
        'Listeaza'
        'Salveaza...'
        'Trimite mail...')
    end
  end
  object R1: TRvQueryConnection
    RuntimeVisibility = rtDeveloper
    Query = Query
    Left = 336
    Top = 56
  end
  object R2: TRvQueryConnection
    RuntimeVisibility = rtDeveloper
    Left = 368
    Top = 56
  end
  object Query: TQuery
    DatabaseName = 'dsTest'
    SQL.Strings = (
      
        'SELECT * FROM FSERVICES.MIV0210 LEFT JOIN FSERVICES.FUR USING(CO' +
        'DFUR) LEFT JOIN FSERVICES.CURS ON DATA=CONCAT(SUBSTRING(ADATA, 7' +
        ', 2), SUBSTRING(ADATA, 5, 2), SUBSTRING(ADATA, 1,4)) WHERE (NUMA' +
        'R IN ("6703", "6704")) AND (COD_VALUTA="EUR")')
    Left = 208
    Top = 56
  end
  object SD: TSaveDialog
    DefaultExt = '*.PDF'
    Filter = 'Portable Document Format|*.pdf'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Title = 'Salvare fisier...'
    Top = 88
  end
  object RS: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generez pagina %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printez pagina %p'
    SystemPrinter.Title = 'Fisa client'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 240
    Top = 56
  end
  object RP: TRvProject
    Engine = RS
    Left = 272
    Top = 56
  end
  object RPDF: TRvRenderPDF
    DisplayName = 'Portable Document Format (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    BufferDocument = True
    DisableHyperlinks = True
    Left = 304
    Top = 56
  end
end

object FEditare: TFEditare
  Left = 0
  Top = 0
  Caption = 'FEditare'
  ClientHeight = 410
  ClientWidth = 647
  Color = clBtnFace
  Constraints.MinHeight = 444
  Constraints.MinWidth = 655
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    647
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object LDatabase: TLabel
    Left = 4
    Top = 24
    Width = 75
    Height = 18
    Caption = 'Baza date:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LTable: TLabel
    Left = 4
    Top = 55
    Width = 50
    Height = 18
    Caption = 'Tabela:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LSQL: TLabel
    Left = 232
    Top = 1
    Width = 109
    Height = 18
    Caption = 'Comanda SQL:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 109
    Width = 647
    Height = 301
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DS
    DefaultDrawing = False
    FixedColor = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    OnDrawDataCell = DBGridDrawDataCell
    OnDblClick = DBGridDblClick
    OnKeyDown = DBGridKeyDown
    OnMouseWheel = DBGridMouseWheel
  end
  object Memo: TMemo
    Left = 0
    Top = 109
    Width = 647
    Height = 301
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 6
    Visible = False
    OnExit = MemoExit
  end
  object CDatabase: TComboBox
    Left = 79
    Top = 21
    Width = 151
    Height = 26
    Style = csDropDownList
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnChange = CDatabaseChange
  end
  object CTable: TComboBox
    Left = 79
    Top = 52
    Width = 151
    Height = 26
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    TabOrder = 2
  end
  object MSQL: TMemo
    Left = 232
    Top = 21
    Width = 411
    Height = 85
    Hint = 'Apasati F9 pentru a executa comanda'
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'SELECT * FROM FUR')
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyDown = MSQLKeyDown
  end
  object Btn_Txt: TRbButton
    Left = 3
    Top = 83
    Width = 22
    Height = 22
    Hint = 'Exporta fisier TXT'
    ParentShowHint = False
    ShowHint = True
    OnClick = Btn_TxtClick
    TabOrder = 4
    TextShadow = True
    ShowCaption = True
    ModalResult = 0
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000000000000000000000000000000000000ADAF00ADAF0
      0ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADA
      F00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF0CBC0BDA2A29C82827E6D6D6B69
      69697272728080808D8D8D9F9F9F0ADAF00ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878CECAB6F2F4E9F2F4E9F3F5EBF4F5ECF7F8F1F7F8F1F7F8F1F7F8F19494
      940ADAF00ADAF00ADAF00ADAF00ADAF0C07878D4CCBCF2F4E97F7F7EBDBDBBF4
      F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171710ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878D9CEC1F2F4E9F2F4E9F2F4E9F4F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171
      710ADAF00ADAF00ADAF00ADAF00ADAF0C07878D8CABFF2F4E97F7F7E7F7F7E7F
      7F7E7F7F7EBDBDBBFFFFFFFFFFFF7171710ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878D4CDBEF2F4E9F2F4E9F2F4E9F4F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171
      710ADAF00ADAF00ADAF00ADAF00ADAF0C07878D1D0BEF2F4E97F7F7E7F7F7E7F
      7F7E7F7F7EBDBDBBFFFFFFFFFFFF7171710ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878D5CDBFF2F4E9F2F4E9F2F4E9F4F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171
      710ADAF00ADAF00ADAF00ADAF00ADAF0C07878D5CEBFF2F4E97F7F7E7F7F7E7F
      7F7EBDBDBBFAFBF7FDFDFCFFFFFF7171710ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878D6CFC1F2F4E9F2F4E9F2F4E9F4F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171
      710ADAF00ADAF00ADAF00ADAF00ADAF0C07878D0CDBBF2F4E9F2F4E9F2F4E9F4
      F6ECF7F8F1FAFBF7FDFDFCFFFFFF7171710ADAF00ADAF00ADAF00ADAF00ADAF0
      C07878E2C6C4426986F2F4E9426986F4F6EC426986FAFBF7426986FFFFFF7171
      710ADAF00ADAF00ADAF00ADAF00ADAF0E3C9C9C17878C17878316B9091AABC6F
      798DD3B6B96F90A9BAB4BE5D829DA3A3A30ADAF00ADAF00ADAF00ADAF00ADAF0
      0ADAF04E9BBD4BBFD4316B903D85A44BBFD4637E944BBFD46D6E845D829DD6D6
      D60ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00A
      DAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF0}
    Spacing = 2
    Layout = blGlyphLeft
    Colors.DefaultFrom = clWhite
    Colors.DefaultTo = 13745839
    Colors.OverFrom = clWhite
    Colors.OverTo = 12489846
    Colors.ClickedFrom = 13029334
    Colors.ClickedTo = 15463415
    Colors.HotTrack = clBlue
    Colors.BorderColor = clGray
    Colors.TextShadow = clWhite
    FadeSpeed = fsVeryFast
    ShowFocusRect = False
    HotTrack = False
    GradientBorder = True
    GroupIndex = 0
    AllowAllUp = False
    Down = False
    GradientType = gtVertical
  end
  object Btn_TblValues: TRbButton
    Left = 26
    Top = 83
    Width = 22
    Height = 22
    Hint = 'Afiseaza valorile tabelei'
    ParentShowHint = False
    ShowHint = True
    OnClick = Btn_TblValuesClick
    TabOrder = 5
    TextShadow = True
    ShowCaption = True
    ModalResult = 0
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000000000000000000000000000000000000ADAF00ADAF0
      0ADAF00ADAF00ADAF0C9CACB8D8C8C7674726B68676F6E6E8484850ADAF00ADA
      F00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF07E7F7DC1B8B4FBE2C5F1
      DAAAE6D1A5F9E8CADBD6C98988826662600ADAF00ADAF00ADAF00ADAF00ADAF0
      0ADAF0A69C97FFE6B9CE9547D1A227EAB544EDCA5FE5CC69E6CD7CFBE1B5F7E7
      E34E454E0ADAF00ADAF00ADAF00ADAF09C9896F7D296CF8108FFAB1FFCBB25FE
      C43BF7CB53F6D268F9DA7DFDE69FE8DDB6F4F1E15151490ADAF00ADAF08D9598
      FDE9C2C77900FCA402F7A91FDA9F4ABC9432EFC25BFBCD71F1D283F2DC92FEE8
      A1DCD0A4BBBEB39292940ADAF0B4B5A3CF9D4DF79A09FFA303D98D12FFFFE3F9
      F7E2BB9C63C6A04EF5D07BFFD981FFDA7FE9D083F1F1BF595A57BAB3B2F1DED5
      ECB965EF9A0CFF9B00E18C08FCFAE0F7F9FFFFFFFFEBE3C7AD975EC7AB58F6D5
      71F0D16BE8D278979691B5B3B1E2CECEF7C67EFFC44CF79707DF8900E1DFC9D4
      E3D9DEE6E3EBF1F4FFFFFFE3E0B0C6AA4EF4C45AE7B055AFADA8A6B1A6DEDECA
      F8CB7CFDC366FFC052E29819C4C0B2AFB3C3C9C6C6D6D5D1E3ECE6F1EBC5D8A9
      49FFBB3ED89B2CB3B3ACAEADB5EBE2D9F5D290F8C062FFC44DECB348DED8D2B6
      B8C8AFB7B8D1C7AAD3A25CE29C2FF5B73FF3BE5DFFD391A5A3A1CCCBCDCAC6BF
      ECD6A4ECC373FFC655F3B045FFFEDEFFEFDCEAC885E2B34FFEC261FFC568FFCC
      68F4C373FFE7BE7978760ADAF0929191EDE4C9F3DFA2F0C361FEC153E9BD6FDD
      A656F0AE3AFFBB3DFBB54EF5B758F0B655EEC888EEDED19998980ADAF0B5B4B8
      D4D3CDD4D4ADFCE99CF8C463EEC260FFC04AF9BD4CF1B44EF0B04FF2B85AEEC7
      7AF7E2BE8C7D820ADAF00ADAF00ADAF0929596E2EAD6E1D8ACE9DAA1FADD99FD
      D57BF1CC78E9CB7BFFD98CEECA90FFE7CCA59D9B0ADAF00ADAF00ADAF00ADAF0
      0ADAF09DA4A3B0ACA2F9F0E4ECDAC3F1D9BAE5D0AAFBE1B9F2DEBBEDE1CC8989
      800ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF00ADAF0939899999490A3
      A1A0B3A7A5AD9F9E938E8FAEB4B00ADAF00ADAF00ADAF00ADAF0}
    Spacing = 2
    Layout = blGlyphLeft
    Colors.DefaultFrom = clWhite
    Colors.DefaultTo = 13745839
    Colors.OverFrom = clWhite
    Colors.OverTo = 12489846
    Colors.ClickedFrom = 13029334
    Colors.ClickedTo = 15463415
    Colors.HotTrack = clBlue
    Colors.BorderColor = clGray
    Colors.TextShadow = clWhite
    FadeSpeed = fsVeryFast
    ShowFocusRect = False
    HotTrack = False
    GradientBorder = True
    GroupIndex = 0
    AllowAllUp = False
    Down = False
    GradientType = gtVertical
  end
  object DSave: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Fisier text|*.txt'
    Title = 'Salvare fisier txt'
    Left = 8
    Top = 120
  end
  object Q: TQuery
    DatabaseName = 'dsTest'
    Left = 40
    Top = 152
  end
  object DS: TDataSource
    DataSet = QTemp
    Left = 72
    Top = 120
  end
  object QTemp: TQuery
    DatabaseName = 'dsTest'
    ParamCheck = False
    Left = 40
    Top = 120
  end
end

object Culori: TCulori
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Alegere culori'
  ClientHeight = 491
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Header: TPaintBox
    Left = 0
    Top = 0
    Width = 375
    Height = 57
    Align = alTop
    Color = clBtnFace
    ParentColor = False
    OnPaint = HeaderPaint
    ExplicitLeft = -133
    ExplicitWidth = 714
  end
  object Footer: TPaintBox
    Left = 0
    Top = 460
    Width = 375
    Height = 31
    Align = alBottom
    Color = clBtnFace
    ParentColor = False
    OnPaint = FooterPaint
    ExplicitTop = 520
    ExplicitWidth = 581
  end
  object SG: TStringGrid
    Left = 0
    Top = 57
    Width = 375
    Height = 185
    Align = alTop
    BiDiMode = bdLeftToRight
    ColCount = 8
    Ctl3D = False
    DefaultRowHeight = 16
    DefaultDrawing = False
    FixedCols = 0
    FixedRows = 0
    Options = [goHorzLine, goDrawFocusSelected, goRowSelect]
    ParentBiDiMode = False
    ParentCtl3D = False
    TabOrder = 0
    OnDrawCell = SGDrawCell
    ColWidths = (
      73
      105
      12
      16
      14
      35
      64
      13)
  end
  object Button1: TButton
    Left = 97
    Top = 428
    Width = 75
    Height = 25
    Caption = 'Aplica'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 227
    Top = 428
    Width = 75
    Height = 25
    Caption = 'Renunta'
    TabOrder = 2
    OnClick = Button2Click
  end
  object gbPage: TGroupBox
    Left = 0
    Top = 254
    Width = 183
    Height = 80
    Caption = 'Culori pagina:'
    TabOrder = 3
    object eFooter: TLabeledEdit
      Left = 122
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 37
      EditLabel.Height = 15
      EditLabel.Caption = 'Footer:'
      TabOrder = 0
      OnClick = eFooterClick
    end
    object eFormColor: TLabeledEdit
      Left = 67
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 39
      EditLabel.Height = 15
      EditLabel.Caption = 'Fundal:'
      TabOrder = 1
      OnClick = eFormColorClick
    end
    object eHeader: TLabeledEdit
      Left = 12
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 41
      EditLabel.Height = 15
      EditLabel.Caption = 'Header:'
      TabOrder = 2
      OnClick = eHeaderClick
    end
  end
  object gbPartner: TGroupBox
    Left = 0
    Top = 340
    Width = 183
    Height = 80
    Caption = 'Detalii clienti:'
    TabOrder = 4
    object eBlocked: TLabeledEdit
      Left = 122
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 36
      EditLabel.Height = 15
      EditLabel.Caption = 'Blocat:'
      TabOrder = 0
      OnClick = eBlockedClick
    end
    object eContract: TLabeledEdit
      Left = 66
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 49
      EditLabel.Height = 15
      EditLabel.Caption = 'Contract:'
      TabOrder = 1
      OnClick = eContractClick
    end
    object eOverdue: TLabeledEdit
      Left = 12
      Top = 40
      Width = 50
      Height = 23
      EditLabel.Width = 53
      EditLabel.Height = 15
      EditLabel.Caption = 'Nr facturi:'
      TabOrder = 2
      OnClick = eOverdueClick
    end
  end
  object gbGridColors: TGroupBox
    Left = 189
    Top = 254
    Width = 185
    Height = 168
    Caption = 'gbGridColors'
    TabOrder = 5
    object eCursor: TLabeledEdit
      Left = 12
      Top = 126
      Width = 75
      Height = 23
      EditLabel.Width = 81
      EditLabel.Height = 15
      EditLabel.Caption = 'Pozitia curenta:'
      TabOrder = 0
      OnClick = eCursorClick
    end
    object eEven: TLabeledEdit
      Left = 101
      Top = 83
      Width = 75
      Height = 23
      EditLabel.Width = 50
      EditLabel.Height = 15
      EditLabel.Caption = 'Rand par:'
      TabOrder = 1
      OnClick = eEvenClick
    end
    object eGridTitle: TLabeledEdit
      Left = 12
      Top = 40
      Width = 75
      Height = 23
      EditLabel.Width = 27
      EditLabel.Height = 15
      EditLabel.Caption = 'Titlu:'
      TabOrder = 2
      OnClick = eGridTitleClick
    end
    object eOdd: TLabeledEdit
      Left = 101
      Top = 40
      Width = 75
      Height = 23
      EditLabel.Width = 64
      EditLabel.Height = 15
      EditLabel.Caption = 'Rand impar:'
      TabOrder = 3
      OnClick = eOddClick
    end
    object eSelection: TLabeledEdit
      Left = 12
      Top = 83
      Width = 75
      Height = 23
      EditLabel.Width = 73
      EditLabel.Height = 15
      EditLabel.Caption = 'Rand selectat:'
      TabOrder = 4
      OnClick = eSelectionClick
    end
  end
  object CD: TColorDialog
    Options = [cdFullOpen]
    Left = 24
    Top = 151
  end
end

object Statii: TStatii
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Statii'
  ClientHeight = 118
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object GPost: TGroupBox
    Left = 0
    Top = 0
    Width = 595
    Height = 81
    Align = alTop
    Caption = 'Numarul de posturi achizitionate:'
    TabOrder = 0
    ExplicitWidth = 593
    object LConta: TLabel
      Left = 8
      Top = 26
      Width = 44
      Height = 16
      Caption = 'Contab.'
    end
    object LGest: TLabel
      Left = 72
      Top = 26
      Width = 29
      Height = 16
      Caption = 'Gest.'
    end
    object LSal: TLabel
      Left = 136
      Top = 26
      Width = 33
      Height = 16
      Caption = 'Salari'
    end
    object LMiFix: TLabel
      Left = 200
      Top = 26
      Width = 45
      Height = 16
      Caption = 'Mij. fixe'
    end
    object LFarm: TLabel
      Left = 265
      Top = 26
      Width = 46
      Height = 16
      Caption = 'Farmaci'
    end
    object LGWin: TLabel
      Left = 329
      Top = 26
      Width = 59
      Height = 16
      Caption = 'Gest. Win.'
    end
    object LRCasa: TLabel
      Left = 393
      Top = 26
      Width = 56
      Height = 16
      Caption = 'Reg. casa'
    end
    object LEx: TLabel
      Left = 457
      Top = 26
      Width = 54
      Height = 16
      Caption = 'Exchange'
    end
    object LGRest: TLabel
      Left = 522
      Top = 26
      Width = 59
      Height = 16
      Caption = 'Gest. rest.'
    end
    object EConta: TSpinEdit
      Left = 8
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object EGest: TSpinEdit
      Left = 72
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object EGWin: TSpinEdit
      Left = 329
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object EFarm: TSpinEdit
      Left = 265
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object ESal: TSpinEdit
      Left = 136
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object EMiFix: TSpinEdit
      Left = 200
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object ERCasa: TSpinEdit
      Left = 393
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 6
      Value = 0
    end
    object EEx: TSpinEdit
      Left = 457
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 7
      Value = 0
    end
    object EGRest: TSpinEdit
      Left = 522
      Top = 48
      Width = 64
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 8
      Value = 0
    end
  end
  object Btn_Save: TButton
    Left = 202
    Top = 87
    Width = 90
    Height = 25
    Caption = 'Actualizeaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Btn_Renunta: TButton
    Left = 299
    Top = 87
    Width = 90
    Height = 25
    Caption = 'Renunta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Btn_RenuntaClick
  end
end

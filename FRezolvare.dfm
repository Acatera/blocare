object Rezolvare: TRezolvare
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Adaugare rezolvare'
  ClientHeight = 111
  ClientWidth = 455
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object LAngajat: TLabel
    Left = 324
    Top = -2
    Width = 49
    Height = 16
    Caption = 'Angajat:'
  end
  object LDetalii: TLabel
    Left = 1
    Top = -2
    Width = 40
    Height = 16
    Caption = 'Detalii:'
  end
  object CAngajat: TComboBox
    Left = 324
    Top = 20
    Width = 127
    Height = 24
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DRezolvare: TMemo
    Left = 1
    Top = 20
    Width = 317
    Height = 90
    TabOrder = 0
  end
  object Btn_Renunta: TButton
    Left = 345
    Top = 85
    Width = 80
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
  object Btn_Salveaza: TButton
    Left = 345
    Top = 54
    Width = 80
    Height = 25
    Caption = 'Salveaza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Btn_SalveazaClick
  end
end

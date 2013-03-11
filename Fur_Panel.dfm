object FurPanel: TFurPanel
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Detalii'
  ClientHeight = 433
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sScrollBox1: TsScrollBox
    Left = 0
    Top = 0
    Width = 273
    Height = 433
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PANEL_LOW'
    object PngSpeedButton1: TPngSpeedButton
      Left = 0
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object PngSpeedButton2: TPngSpeedButton
      Left = 46
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object PngSpeedButton3: TPngSpeedButton
      Left = 92
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object PngSpeedButton4: TPngSpeedButton
      Left = 138
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object PngSpeedButton5: TPngSpeedButton
      Left = 183
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object PngSpeedButton6: TPngSpeedButton
      Left = 228
      Top = 232
      Width = 41
      Height = 41
      Flat = True
    end
    object sPanel1: TsPanel
      Left = 0
      Top = 57
      Width = 269
      Height = 174
      Align = alTop
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        269
        174)
      object g: TStringGrid
        Left = 4
        Top = 4
        Width = 261
        Height = 165
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 1
        DefaultColWidth = 240
        DefaultRowHeight = 64
        DefaultDrawing = False
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmEmail
        TabOrder = 0
        OnDrawCell = gDrawCell
        OnMouseMove = gMouseMove
      end
    end
    object sCoolBar1: TsCoolBar
      Left = 0
      Top = 0
      Width = 269
      Height = 57
      Bands = <>
      SkinData.SkinSection = 'TOOLBAR'
      object LDenFur: mslabelFX
        Left = 5
        Top = 7
        Width = 172
        Height = 42
        Caption = 'Adrese email'
        ParentFont = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
      end
    end
  end
  object q: TQuery
    DatabaseName = 'dsTest'
    ParamCheck = False
    Left = 16
    Top = 72
  end
  object pmEmail: TPopupMenu
    Left = 48
    Top = 72
  end
end

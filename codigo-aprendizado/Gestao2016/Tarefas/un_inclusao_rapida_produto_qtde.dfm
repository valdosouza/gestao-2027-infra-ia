inherited Fr_InclusaoRapidaProdutoQtde: TFr_InclusaoRapidaProdutoQtde
  Caption = 'Inclus'#227'o R'#225'pida de Produtos'
  ClientHeight = 185
  ClientWidth = 710
  ExplicitWidth = 716
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_corpo: TPanel [0]
    Left = 0
    Top = 0
    Width = 710
    Height = 130
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderStyle = bsSingle
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object Label37: TLabel
      Left = 175
      Top = 7
      Width = 77
      Height = 19
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 11
      Top = 6
      Width = 145
      Height = 19
      Caption = 'C'#243'dcódcódcódigo do produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 299
      Top = 62
      Width = 107
      Height = 19
      Caption = 'QUANTIDADE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 588
      Top = 62
      Width = 111
      Height = 19
      Caption = 'VALOR TOTAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label35: TLabel
      Left = 478
      Top = 62
      Width = 106
      Height = 19
      Caption = 'VL. UNIT'#193'RIO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpeedButton2: TSpeedButton
      Left = 254
      Top = 70
      Width = 40
      Height = 40
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object SpeedButton1: TSpeedButton
      Left = 414
      Top = 70
      Width = 40
      Height = 40
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object E_Descricao: TEdit
      Left = 171
      Top = 29
      Width = 532
      Height = 25
      TabStop = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      CharCase = ecUpperCase
      Color = clBlack
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object E_Codigo: TEdit
      Left = 6
      Top = 29
      Width = 163
      Height = 25
      TabStop = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      CharCase = ecUpperCase
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object E_Subtotal: TPanel
      Left = 588
      Top = 84
      Width = 113
      Height = 25
      Alignment = taRightJustify
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '0,00'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 4
    end
    object E_Qtde: TEdit_Setes
      Left = 297
      Top = 84
      Width = 111
      Height = 25
      Alignment = taCenter
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Color = clBlack
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '1'
      OnEnter = E_QtdeEnter
      OnExit = E_QtdeExit
    end
    object E_Vl_Unitario: TEdit_Setes
      Left = 475
      Top = 84
      Width = 111
      Height = 25
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Color = clBlack
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      OnEnter = E_Vl_UnitarioEnter
      OnExit = E_Vl_UnitarioExit
    end
  end
  object pnl_rodape: TPanel [1]
    Left = 0
    Top = 130
    Width = 710
    Height = 55
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Cancela: TButton
      AlignWithMargins = True
      Left = 575
      Top = 5
      Width = 130
      Height = 45
      Align = alRight
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Sb_CancelaClick
    end
    object Sb_Confirma: TButton
      AlignWithMargins = True
      Left = 439
      Top = 5
      Width = 130
      Height = 45
      Align = alRight
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_ConfirmaClick
    end
  end
  inherited MnuBase: TMainMenu
    Left = 0
    Top = 184
  end
end

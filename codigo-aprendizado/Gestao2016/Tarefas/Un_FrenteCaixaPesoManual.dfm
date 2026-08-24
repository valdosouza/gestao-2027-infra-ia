inherited Fr_FrenteCaixaPesoManual: TFr_FrenteCaixaPesoManual
  BorderStyle = bsDialog
  Caption = 'Informe o peso manualmente'
  ClientHeight = 131
  ClientWidth = 495
  ExplicitWidth = 501
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_BalancaManual: TPanel [0]
    Left = 0
    Top = 0
    Width = 495
    Height = 90
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 5
      Width = 148
      Height = 24
      Caption = 'PESO LIQUIDO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 179
      Top = 5
      Width = 135
      Height = 24
      Caption = 'VL. UNIT'#193'RIO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 331
      Top = 5
      Width = 144
      Height = 24
      Caption = 'VALOR TOTAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Vl_PesoManual: TPanel
      Left = 331
      Top = 29
      Width = 155
      Height = 40
      Alignment = taRightJustify
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '0,00'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 1
    end
    object E_Peso_LiquidoManual: TEdit_Setes
      Left = 3
      Top = 29
      Width = 162
      Height = 40
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Color = clBlack
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      OnExit = E_Peso_LiquidoManualExit
    end
    object E_Vl_UnitarioManual: TEdit_Setes
      Left = 167
      Top = 29
      Width = 162
      Height = 40
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Color = clBlack
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = '0,00'
      OnExit = E_Peso_LiquidoManualExit
    end
  end
  object pnl_Rodape: TPanel [1]
    Left = 0
    Top = 90
    Width = 495
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_cancela: TButton
      AlignWithMargins = True
      Left = 364
      Top = 5
      Width = 126
      Height = 31
      Align = alRight
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_cancelaClick
    end
    object Sb_confirma: TButton
      AlignWithMargins = True
      Left = 236
      Top = 5
      Width = 122
      Height = 31
      Align = alRight
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Sb_confirmaClick
    end
  end
end

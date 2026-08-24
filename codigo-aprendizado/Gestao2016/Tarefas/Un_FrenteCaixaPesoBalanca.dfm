inherited Fr_FrenteCaixaPesoBalanca: TFr_FrenteCaixaPesoBalanca
  BorderStyle = bsDialog
  Caption = 'Tela de Pesagem - Aguarde at'#233' aparecer o peso'
  ClientHeight = 134
  ClientWidth = 494
  Menu = nil
  ExplicitWidth = 500
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Balanca: TPanel [0]
    Left = 0
    Top = 0
    Width = 494
    Height = 93
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    TabStop = True
    object Label32: TLabel
      Left = 14
      Top = 7
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
    object Label33: TLabel
      Left = 185
      Top = 7
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
    object Label34: TLabel
      Left = 337
      Top = 7
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
    object E_Peso_Liquido: TPanel
      Left = 8
      Top = 33
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
      TabOrder = 0
    end
    object E_Vl_Peso: TPanel
      Left = 328
      Top = 33
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
      TabOrder = 2
    end
    object E_VL_Unitario: TEdit_Setes
      Left = 164
      Top = 33
      Width = 161
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
      TabOrder = 1
      Text = '0,00'
    end
  end
  object pnl_Rodape: TPanel [1]
    Left = 0
    Top = 93
    Width = 494
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Cancela: TButton
      AlignWithMargins = True
      Left = 367
      Top = 5
      Width = 122
      Height = 31
      Align = alRight
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_CancelaClick
    end
    object Sb_Confirma: TButton
      AlignWithMargins = True
      Left = 239
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
      TabOrder = 1
      OnClick = Sb_ConfirmaClick
    end
    object Sb_LePeso: TButton
      AlignWithMargins = True
      Left = 111
      Top = 5
      Width = 122
      Height = 31
      Align = alRight
      Caption = '&L'#234' Peso - F4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Sb_LePesoClick
    end
  end
  object Balanca: TACBrBAL
    Porta = 'COM1'
    Left = 56
    Top = 92
  end
end

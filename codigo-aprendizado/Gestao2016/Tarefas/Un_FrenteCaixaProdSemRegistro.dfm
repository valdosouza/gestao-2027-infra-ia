inherited Fr_FrenteCaixaProdSemRegistro: TFr_FrenteCaixaProdSemRegistro
  Caption = 'Confirme o item antes de inclui-lo na venda'
  ClientHeight = 121
  ClientWidth = 856
  Menu = nil
  ExplicitWidth = 862
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Prod_Sem_Registro: TPanel [0]
    Left = 0
    Top = 0
    Width = 856
    Height = 80
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label25: TLabel
      Left = 507
      Top = 6
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
      Left = 732
      Top = 6
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
      Left = 622
      Top = 6
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
    object Label37: TLabel
      Left = 11
      Top = 6
      Width = 97
      Height = 19
      Caption = 'DESCRI'#199#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label38: TLabel
      Left = 442
      Top = 6
      Width = 44
      Height = 19
      Caption = 'UNID.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Avl_Vl_Unitario: TEdit_Setes
      Left = 619
      Top = 28
      Width = 111
      Height = 25
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
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
      TabOrder = 3
      Text = '0,00'
      OnEnter = E_Avl_Vl_UnitarioEnter
      OnExit = E_Avl_Vl_UnitarioExit
    end
    object E_Avl_Subtotal: TPanel
      Left = 732
      Top = 28
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
    object E_Avl_Qtde: TEdit_Setes
      Left = 505
      Top = 28
      Width = 111
      Height = 25
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
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
      TabOrder = 2
      Text = '1,00'
      OnEnter = E_Avl_QtdeEnter
      OnExit = E_Avl_QtdeExit
    end
    object E_Avl_Descricao: TEdit
      Left = 7
      Top = 28
      Width = 432
      Height = 25
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
      TabOrder = 0
    end
    object E_Avl_Medida: TEdit
      Left = 440
      Top = 28
      Width = 64
      Height = 25
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
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
      TabOrder = 1
      Text = 'UND'
    end
  end
  object pnl_rodape: TPanel [1]
    Left = 0
    Top = 80
    Width = 856
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Cancela: TButton
      AlignWithMargins = True
      Left = 729
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
      TabOrder = 1
      OnClick = Sb_CancelaClick
      OnKeyDown = Sb_CancelaKeyDown
    end
    object Sb_Confirma: TButton
      AlignWithMargins = True
      Left = 601
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
      OnClick = Sb_ConfirmaClick
    end
  end
end

inherited Fr_FrenteCaixaProdAvulso: TFr_FrenteCaixaProdAvulso
  Anchors = [akLeft]
  Caption = 'Lan'#231'amento de Produto Avulso'
  ClientHeight = 144
  ClientWidth = 946
  ExplicitWidth = 952
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_ValorAvulso: TPanel [0]
    Left = 0
    Top = 0
    Width = 946
    Height = 103
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    DesignSize = (
      946
      103)
    object Label3: TLabel
      Left = 461
      Top = 4
      Width = 136
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'QUANTIDADE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 483
    end
    object Label1: TLabel
      Left = 781
      Top = 4
      Width = 144
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'VALOR TOTAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 803
    end
    object Label10: TLabel
      Left = 619
      Top = 4
      Width = 135
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'VL. UNIT'#193'RIO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 641
    end
    object Label37: TLabel
      Left = 6
      Top = 4
      Width = 124
      Height = 24
      Caption = 'DESCRI'#199#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Vl_Avulso: TEdit_Setes
      Left = 620
      Top = 31
      Width = 155
      Height = 40
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Color = clBlack
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = '0,00'
      OnEnter = E_Vl_AvulsoEnter
      OnExit = E_Vl_AvulsoExit
    end
    object E_Vl_Tl_Avulso: TPanel
      Left = 779
      Top = 31
      Width = 155
      Height = 40
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
      TabOrder = 3
    end
    object E_Qt_Avulso: TEdit_Setes
      Left = 460
      Top = 31
      Width = 155
      Height = 40
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      CharCase = ecUpperCase
      Color = clBlack
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '1,00'
      OnEnter = E_Qt_AvulsoEnter
      OnExit = E_Qt_AvulsoExit
    end
    object E_Avl_Descricao: TEdit
      Left = 6
      Top = 31
      Width = 449
      Height = 40
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      CharCase = ecUpperCase
      Color = clBlack
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = 'PRODUTO AVULSO'
    end
  end
  object pnl_Rodape: TPanel [1]
    Left = 0
    Top = 103
    Width = 946
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Cancela: TButton
      AlignWithMargins = True
      Left = 816
      Top = 5
      Width = 125
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
    end
    object Sb_Confirma: TButton
      AlignWithMargins = True
      Left = 685
      Top = 5
      Width = 125
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

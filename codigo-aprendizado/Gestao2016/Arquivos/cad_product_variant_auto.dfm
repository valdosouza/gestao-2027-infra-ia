inherited CadProductVariantAuto: TCadProductVariantAuto
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Varia'#231#245'es de Produtos'
  ClientHeight = 159
  ClientWidth = 594
  ExplicitWidth = 600
  ExplicitHeight = 208
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Tamanho: TPanel [0]
    Left = 0
    Top = 0
    Width = 594
    Height = 99
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 95
    object SbGerarVariacoes: TSpeedButton
      Left = 140
      Top = 100
      Width = 108
      Height = 27
      Caption = 'Gerar Varia'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      NumGlyphs = 4
      ParentFont = False
    end
    object E_Tamanho: TLabeledEdit
      Left = 6
      Top = 18
      Width = 579
      Height = 22
      EditLabel.Width = 256
      EditLabel.Height = 14
      EditLabel.Caption = 'Defina os tamanhos EX:(34;35;36;37) ou (P;M;G;GG) '
      TabOrder = 0
    end
    object E_Cores: TLabeledEdit
      Left = 6
      Top = 58
      Width = 579
      Height = 22
      EditLabel.Width = 249
      EditLabel.Height = 14
      EditLabel.Caption = 'Defina as Cores EX:(Branco;Azul;Vermelhor;Verde)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Pnl_Bottom: TPanel [1]
    Left = 0
    Top = 99
    Width = 594
    Height = 60
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 95
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 404
      Top = 5
      Width = 90
      Height = 50
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ExplicitLeft = 489
      ExplicitTop = 6
      ExplicitHeight = 57
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 500
      Top = 5
      Width = 89
      Height = 50
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  inherited MnuBase: TMainMenu
    Left = 32
    Top = 320
  end
  object Cds_Tamanho: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 208
    object Cds_TamanhoID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object Cds_TamanhoTB_PRODUCT_ID: TIntegerField
      FieldName = 'TB_PRODUCT_ID'
      Visible = False
    end
    object Cds_TamanhoTB_PRODUCT_VARIANT_ID: TIntegerField
      FieldName = 'TB_PRODUCT_VARIANT_ID'
      Visible = False
    end
    object Cds_TamanhoKIND: TStringField
      DisplayLabel = 'Tamanho'
      FieldName = 'KIND'
      Size = 10
    end
    object Cds_TamanhoQUANTITY: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTITY'
    end
    object Cds_TamanhoPRICE_TAG: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRICE_TAG'
    end
  end
  object Ds_Tamanho: TDataSource
    DataSet = Cds_Tamanho
    Left = 32
    Top = 256
  end
end

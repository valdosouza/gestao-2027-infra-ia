inherited CadProductVariant: TCadProductVariant
  Caption = 'Cadastro de Varia'#231#245'es de Produtos'
  ClientHeight = 372
  ClientWidth = 699
  ExplicitWidth = 705
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 308
    Width = 699
    ExplicitTop = 308
    ExplicitWidth = 699
    inherited SB_Inserir: TSpeedButton
      Left = 72
      ExplicitLeft = 79
    end
    inherited SB_Alterar: TSpeedButton
      Left = 176
      ExplicitLeft = 175
    end
    inherited SB_Excluir: TSpeedButton
      Left = 280
      ExplicitLeft = 283
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 488
      ExplicitLeft = 487
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 592
      ExplicitLeft = 591
    end
    inherited SB_Gravar: TSpeedButton
      Left = 384
      ExplicitLeft = 385
    end
  end
  inherited pnl_fundo: TPanel
    Width = 699
    Height = 52
    Align = alTop
    ExplicitWidth = 699
    ExplicitHeight = 52
    object Label2: TLabel
      Left = 6
      Top = 4
      Width = 44
      Height = 13
      Caption = 'Tamanho'
    end
    object Label3: TLabel
      Left = 160
      Top = 4
      Width = 17
      Height = 13
      Caption = 'Cor'
    end
    object Label4: TLabel
      Left = 434
      Top = 4
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label5: TLabel
      Left = 307
      Top = 4
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Cb_Tamanho: TComboBox
      Left = 6
      Top = 19
      Width = 145
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object Cb_Cor: TComboBox
      Left = 157
      Top = 19
      Width = 145
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object E_Valor: TEdit
      Left = 434
      Top = 19
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0,00'
      OnExit = E_ValorExit
    end
    object E_Quantidade: TEdit
      Left = 307
      Top = 19
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 2
      Text = '0,00'
      OnExit = E_QuantidadeExit
    end
  end
  object DbgVariantes: TDBGrid [2]
    AlignWithMargins = True
    Left = 3
    Top = 55
    Width = 693
    Height = 250
    Align = alClient
    DataSource = Ds_Variante
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = popmenu
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DbgVariantesDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TB_PRODUCT_ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SKU_ID'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAMANHO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTITY'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRICE_TAG'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WEB_ID'
        Width = 62
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 32
    Top = 320
    inherited arefas1: TMenuItem
      object GerarAtutomaticamente1: TMenuItem [0]
        Caption = 'Gerar Atutomaticamente'
        Visible = False
        OnClick = GerarAtutomaticamente1Click
      end
    end
  end
  object Cds_Variante: TClientDataSet
    PersistDataPacket.Data = {
      E60000009619E0BD020000001800000008000000000003000000E60002494404
      000100040000000D54425F50524F445543545F4944040001000400000006534B
      555F494404000100040000000754414D414E484F01004A000000010005574944
      544802000200140003434F5201004A0000000100055749445448020002003C00
      085155414E544954590B0012000000020008444543494D414C53020002000600
      0557494454480200020012000950524943455F5441470B001200000002000844
      4543494D414C53020002000600055749445448020002001200065745425F4944
      04000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 208
    object Cds_VarianteID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PRODUCT_VARIANT"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object Cds_VarianteTB_PRODUCT_ID: TIntegerField
      FieldName = 'TB_PRODUCT_ID'
      Origin = '"TB_PRODUCT_VARIANT"."TB_PRODUCT_ID"'
      Required = True
      Visible = False
    end
    object Cds_VarianteSKU_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 15
      FieldName = 'SKU_ID'
      Origin = '"TB_PRODUCT_VARIANT_SKU"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Cds_VarianteTAMANHO: TWideStringField
      DisplayLabel = 'Tamanho'
      DisplayWidth = 27
      FieldName = 'TAMANHO'
      Origin = '"TB_PRODUCT_VARIANT_SKU"."TAMANHO"'
      Size = 10
    end
    object Cds_VarianteCOR: TWideStringField
      DisplayLabel = 'Cor'
      DisplayWidth = 30
      FieldName = 'COR'
      Origin = '"TB_PRODUCT_VARIANT_SKU"."COR"'
      Size = 30
    end
    object Cds_VarianteQUANTITY: TFMTBCDField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 16
      FieldName = 'QUANTITY'
      Origin = '"TB_PRODUCT_VARIANT_SKU"."QUANTITY"'
      DisplayFormat = '0.0#'
      Precision = 18
      Size = 6
    end
    object Cds_VariantePRICE_TAG: TFMTBCDField
      DisplayLabel = 'Pre'#231'o'
      DisplayWidth = 28
      FieldName = 'PRICE_TAG'
      Origin = '"TB_PRODUCT_VARIANT_SKU"."PRICE_TAG"'
      DisplayFormat = '0.0#'
      Precision = 18
      Size = 6
    end
    object Cds_VarianteWEB_ID: TIntegerField
      DisplayLabel = 'C'#243'digo WEb'
      DisplayWidth = 12
      FieldName = 'WEB_ID'
    end
  end
  object Ds_Variante: TDataSource
    DataSet = Cds_Variante
    Left = 32
    Top = 256
  end
  object popmenu: TPopupMenu
    Left = 520
    Top = 152
    object RetiraroVinculocomaWEb1: TMenuItem
      Caption = 'Retirar o Vinculo com a WEb'
      OnClick = RetiraroVinculocomaWEb1Click
    end
  end
end

inherited CadFatCtrlIcmsST: TCadFatCtrlIcmsST
  Caption = 'Cadstro de ICMS ST Retido '
  ClientHeight = 477
  ClientWidth = 1065
  ExplicitWidth = 1071
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_fundos: TPanel [0]
    Left = 0
    Top = 0
    Width = 1065
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 696
      Height = 19
      Caption = 
        'Verificar os seguinte produtos, eles devem ter registro de reten' +
        #231#227'o de ST (Substitui'#231#227'o TRibut'#225'ria)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 29
      Width = 391
      Height = 19
      Caption = 'Esta Informa'#231'ao '#233' obrigatoria para autoriza'#231#227'o da Nota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Pnl_botao: TPanel [1]
    Left = 0
    Top = 412
    Width = 1065
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      1065
      65)
    object SB_Gravar: TSpeedButton
      Left = 898
      Top = 6
      Width = 79
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitLeft = 809
    end
    object SB_Cancelar: TSpeedButton
      Left = 977
      Top = 6
      Width = 79
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 888
    end
  end
  object DBG_Produtos: TDBGrid [2]
    Left = 0
    Top = 57
    Width = 1065
    Height = 355
    Align = alClient
    Color = clMoneyGreen
    DataSource = Ds_produtos
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ncm'
        Title.Caption = 'N.C.M'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRO_DESCRICAO'
        Title.Caption = 'Produto'
        Width = 320
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDE'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLVENDA'
        Title.Caption = 'Valor Venda'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MVA'
        Title.Caption = 'M.V.A'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VBCSTRET'
        Title.Caption = 'Vlr Base Retido'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PST'
        Title.Caption = 'Al'#237'quota St'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VICMSSUBSTITUTO'
        Title.Caption = 'Valor ICMS Substituto'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VICMSSTRET'
        Title.Caption = 'Valor ICMS Retido'
        Width = 108
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 336
  end
  object cds_produtos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 314
    Top = 189
    object cds_produtosPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_produtosPRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object cds_produtosVBCSTRET: TFMTBCDField
      FieldName = 'VBCSTRET'
      Origin = '"TB_CTRL_ICMS_ST"."VBCSTRET"'
      Precision = 18
      Size = 6
    end
    object cds_produtosPST: TBCDField
      FieldName = 'PST'
      Origin = '"TB_CTRL_ICMS_ST"."PST"'
      OnChange = cds_produtosPSTChange
      Precision = 18
      Size = 2
    end
    object cds_produtosVICMSSUBSTITUTO: TFMTBCDField
      FieldName = 'VICMSSUBSTITUTO'
      Origin = '"TB_CTRL_ICMS_ST"."VICMSSUBSTITUTO"'
      Precision = 18
      Size = 6
    end
    object cds_produtosVICMSSTRET: TFMTBCDField
      FieldName = 'VICMSSTRET'
      Origin = '"TB_CTRL_ICMS_ST"."VICMSSTRET"'
      Precision = 18
      Size = 6
    end
    object cds_produtosITF_ORIGEM_ID: TIntegerField
      FieldName = 'ITF_ORIGEM_ID'
      Origin = '"TB_CTRL_ICMS_ST"."ITF_ORIGEM_ID"'
    end
    object cds_produtosITF_DESTINO_ID: TIntegerField
      FieldName = 'ITF_DESTINO_ID'
      Origin = '"TB_CTRL_ICMS_ST"."ITF_DESTINO_ID"'
    end
    object cds_produtosQTDE: TIntegerField
      FieldName = 'QTDE'
    end
    object cds_produtosVLVENDA: TFloatField
      FieldName = 'VLVENDA'
    end
    object cds_produtosMVA: TFloatField
      FieldName = 'MVA'
      OnChange = cds_produtosMVAChange
    end
    object cds_produtosncm: TStringField
      FieldName = 'ncm'
      Size = 9
    end
  end
  object Ds_produtos: TDataSource
    DataSet = cds_produtos
    Left = 314
    Top = 245
  end
end

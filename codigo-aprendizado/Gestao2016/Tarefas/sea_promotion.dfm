inherited SeaPromotion: TSeaPromotion
  Caption = 'Pesquisa Promo'#231#245'es'
  ClientWidth = 835
  ExplicitWidth = 841
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrB_Parametros: TGroupBox
    Width = 835
    Height = 76
    ExplicitLeft = 8
    ExplicitTop = -6
    ExplicitWidth = 835
    ExplicitHeight = 76
    object Label28: TLabel
      Left = 8
      Top = 13
      Width = 55
      Height = 14
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 311
      Top = 13
      Width = 104
      Height = 14
      Caption = 'Descri'#231#227'o do Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 155
      Top = 13
      Width = 69
      Height = 14
      Caption = 'C'#243'digo Barras'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 69
      Top = 33
      Width = 7
      Height = 14
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 84
      Top = 13
      Width = 50
      Height = 14
      Caption = 'Valor Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Qtde: TMaskEdit
      Left = 6
      Top = 29
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object E_BuscaProduto: TMaskEdit
      Left = 311
      Top = 29
      Width = 519
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object ChBx_Ativa: TCheckBox
      Left = 8
      Top = 53
      Width = 131
      Height = 17
      Caption = 'Promo'#231#227'o ativa'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object E_BuscaCodBarras: TEdit_Setes
      Left = 155
      Top = 29
      Width = 154
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      Text = ''
      IsCodigo = True
    end
    object E_ValorTotal: TMaskEdit
      Left = 82
      Top = 29
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
  end
  inherited Pnl_Resultado: TPanel
    Top = 76
    Width = 835
    Height = 433
    ExplicitTop = 76
    ExplicitWidth = 835
    ExplicitHeight = 433
    inherited Grd_Pesquisa: TStringGrid
      Width = 730
      Height = 415
      ExplicitWidth = 730
      ExplicitHeight = 415
    end
    inherited pnl_botao: TPanel
      Left = 732
      Height = 415
      ExplicitLeft = 732
      ExplicitHeight = 415
      inherited Sb_Sair: TSpeedButton
        Top = 360
        ExplicitLeft = 3
        ExplicitTop = 355
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 305
        ExplicitLeft = 3
        ExplicitTop = 300
      end
      inherited SB_Buscar: TSpeedButton
        Top = 250
        ExplicitLeft = 3
        ExplicitTop = 245
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 195
        ExplicitLeft = 3
        ExplicitTop = 190
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 176
    Top = 112
  end
  inherited Qr_Pesquisa: TSTQuery
    SQL.Strings = (
      
        'select p.id, p.description, prd.pro_descricao, p.price_tag, p.qu' +
        'antity,'
      'prd.pro_codigo'
      'from tb_promotion p'
      '  inner join tb_promotion_items pit'
      
        '  on (pit.tb_promotion_id = p.id) and (pit.tb_institution_id = p' +
        '.tb_institution_id)'
      '  inner join tb_produto prd'
      '  on (prd.pro_codigo = pit.tb_product_id)'
      'where p.tb_institution_id =:institution_id')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'institution_id'
        ParamType = ptUnknown
      end>
    object Qr_PesquisaID: TIntegerField
      Tag = 40
      DisplayLabel = 'Codigo'
      FieldName = 'ID'
      Origin = '"TB_PROMOTION"."ID"'
      Required = True
    end
    object Qr_PesquisaDESCRIPTION: TStringField
      Tag = 240
      DisplayLabel = 'Promo'#231#227'o'
      FieldName = 'DESCRIPTION'
      Origin = '"TB_PROMOTION"."DESCRIPTION"'
      Size = 100
    end
    object Qr_PesquisaPRO_DESCRICAO: TStringField
      Tag = 240
      DisplayLabel = 'Produto'
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_PesquisaPRICE_TAG: TFMTBCDField
      Tag = 90
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRICE_TAG'
      Origin = '"TB_PROMOTION"."PRICE_TAG"'
      Precision = 18
      Size = 6
    end
    object Qr_PesquisaQUANTITY: TBCDField
      Tag = 60
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTITY'
      Origin = '"TB_PROMOTION"."QUANTITY"'
      Precision = 18
      Size = 3
    end
    object Qr_PesquisaPRO_CODIGO: TIntegerField
      Tag = -1
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
end

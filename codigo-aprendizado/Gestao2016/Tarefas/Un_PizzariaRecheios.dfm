object Fr_PizzariaRecheios: TFr_PizzariaRecheios
  Left = 493
  Top = 61
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Produto'
  ClientHeight = 585
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 523
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      487
      523)
    object Label1: TLabel
      Left = 3
      Top = 3
      Width = 268
      Height = 13
      Caption = 'Digite uma op'#231#227'o no caso de n'#227'o constar na lista abaixo'
    end
    object E_OpcaoLivre: TEdit
      Left = 0
      Top = 17
      Width = 484
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object StrGrd_Recheio: TStringGrid
      Left = 2
      Top = 43
      Width = 483
      Height = 475
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clCream
      ColCount = 6
      DefaultColWidth = 40
      DefaultRowHeight = 18
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentFont = False
      TabOrder = 1
      OnClick = StrGrd_RecheioClick
      OnDrawCell = StrGrd_RecheioDrawCell
      ColWidths = (
        40
        40
        40
        40
        40
        40)
      RowHeights = (
        18
        18)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 523
    Width = 487
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      487
      62)
    object SB_Sair_0: TSpeedButton
      Left = 394
      Top = 4
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
    end
    object SB_Confirmar: TSpeedButton
      Left = 303
      Top = 4
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
    end
  end
  object Qr_Crp_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CPI_CODPRO, PRO_DESCRICAO, CPI_TIPO, CPI_QTDE,  CPI_VALOR'
      'FROM TB_CRP_ITENS i'
      '  INNER JOIN TB_PRODUTO p'
      '  ON (p.PRO_CODIGO = i.CPI_CODPRO)'
      '  INNER JOIN TB_MEDIDA m'
      '  ON (m.MED_CODIGO = p.PRO_CODMED)'
      
        'WHERE ( i.cpi_sabor =:cpi_sabor ) or ( cpi_sabor = '#39'TODOS'#39' ) or ' +
        '( cpi_sabor IS NULL)'
      'ORDER BY CPI_TIPO DESC, CPI_SEQUENCIA ASC')
    Left = 108
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cpi_sabor'
        ParamType = ptUnknown
      end>
    object Qr_Crp_ItensCPI_CODPRO: TIntegerField
      Tag = -1
      FieldName = 'CPI_CODPRO'
      Origin = '"TB_CRP_ITENS"."CPI_CODPRO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Crp_ItensPRO_DESCRICAO: TStringField
      Tag = 250
      DisplayLabel = 'Sabor'
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_Crp_ItensCPI_TIPO: TStringField
      FieldName = 'CPI_TIPO'
      Origin = '"TB_CRP_ITENS"."CPI_TIPO"'
      Size = 1
    end
    object Qr_Crp_ItensCPI_QTDE: TBCDField
      Tag = -1
      DisplayLabel = 'Qtde'
      FieldName = 'CPI_QTDE'
      Origin = '"TB_CRP_ITENS"."CPI_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_Crp_ItensCPI_VALOR: TBCDField
      Tag = 75
      DisplayLabel = 'Valor Extra'
      FieldName = 'CPI_VALOR'
      Origin = '"TB_CRP_ITENS"."CPI_VALOR"'
      Precision = 18
      Size = 3
    end
  end
end

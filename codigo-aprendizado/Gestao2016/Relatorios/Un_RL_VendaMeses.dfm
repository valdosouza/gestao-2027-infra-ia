object RL_VendaMeses: TRL_VendaMeses
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'An'#225'lise de Venda'
  ClientHeight = 418
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    857
    418)
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrd_Vendas: TStringGrid
    Left = 0
    Top = 0
    Width = 857
    Height = 319
    Anchors = [akLeft, akTop, akRight]
    Color = clCream
    ColCount = 10
    DefaultColWidth = 64
    DefaultRowHeight = 24
    FixedCols = 1
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24)
  end
  object StrGrd_Marcas: TStringGrid
    Left = 1
    Top = 319
    Width = 856
    Height = 99
    Anchors = [akLeft, akTop, akRight]
    Color = clCream
    ColCount = 10
    DefaultColWidth = 64
    DefaultRowHeight = 24
    FixedCols = 1
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 1
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24)
  end
  object Qr_Clientes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT EMP_CODIGO, EMP_NOME, EMP_FANTASIA'
      'FROM TB_EMPRESA tb_empresa'
      '    INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal'
      '   ON (tb_nota_fiscal.NFL_CODEMP = tb_empresa.EMP_CODIGO)'
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      'WHERE  PED_TIPO = '#39'1'#39)
    Left = 24
    Top = 320
    object Qr_ClientesEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
    object Qr_ClientesEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = 'TB_EMPRESA.EMP_NOME'
      Size = 100
    end
    object Qr_ClientesEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'TB_EMPRESA.EMP_FANTASIA'
      Size = 100
    end
  end
  object Qr_Vendas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT SUM(ITF_VL_UNIT * ITF_QTDE) VDA_VL_TOTAL'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '   INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO)'
      '   INNER JOIN TB_PRODUTO tb_produto'
      '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)')
    Left = 88
    Top = 320
  end
  object Qr_Descontos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CAST(SUM(PED_VL_DESCONTO) AS NUMERIC(18, 2)) VDA_VL_DESCONTO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '    INNER JOIN TB_EMPRESA tb_empresa'
      '    ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)')
    Left = 152
    Top = 320
    object Qr_DescontosVDA_VL_DESCONTO: TBCDField
      FieldName = 'VDA_VL_DESCONTO'
      Precision = 18
      Size = 2
    end
  end
  object Qr_MarcaProduto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_PRODUTO'
      'WHERE MRC_CODIGO = 21 OR MRC_CODIGO = 2'
      'ORDER BY MRC_DESCRICAO')
    Left = 216
    Top = 320
    object Qr_MarcaProdutoMRC_CODIGO: TIntegerField
      FieldName = 'MRC_CODIGO'
      Origin = 'TB_MARCAPRODUTO.MRC_CODIGO'
      Required = True
    end
    object Qr_MarcaProdutoMRC_DESCRICAO: TStringField
      FieldName = 'MRC_DESCRICAO'
      Origin = 'TB_MARCAPRODUTO.MRC_DESCRICAO'
      Size = 60
    end
  end
end

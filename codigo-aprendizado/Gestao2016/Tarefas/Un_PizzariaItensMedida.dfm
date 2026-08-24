object Fr_PizzariaItensMedida: TFr_PizzariaItensMedida
  Left = 493
  Top = 97
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Produto'
  ClientHeight = 446
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 384
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object StrGrd_Medidas: TStringGrid
      Left = 2
      Top = 2
      Width = 443
      Height = 380
      Align = alClient
      Color = clCream
      ColCount = 7
      DefaultColWidth = 40
      DefaultRowHeight = 30
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ParentFont = False
      PopupMenu = PopupMenu
      TabOrder = 0
      OnClick = StrGrd_MedidasClick
      OnDrawCell = StrGrd_MedidasDrawCell
      ExplicitLeft = 4
      ColWidths = (
        40
        40
        40
        40
        40
        40
        40)
      RowHeights = (
        30
        30)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 384
    Width = 447
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      447
      62)
    object SB_Sair_0: TSpeedButton
      Left = 354
      Top = 4
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object SB_Confirmar: TSpeedButton
      Left = 258
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
    object Label1: TLabel
      Left = 81
      Top = 7
      Width = 102
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Informe a Quantidade'
    end
    object UpDown1: TUpDown
      Left = 170
      Top = 23
      Width = 18
      Height = 28
      Anchors = [akRight, akBottom]
      Associate = e_Quantidade
      Min = 1
      Position = 1
      TabOrder = 0
    end
    object e_Quantidade: TEdit_Setes
      Left = 81
      Top = 23
      Width = 89
      Height = 28
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '1'
    end
  end
  object Qr_Medidas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT distinct MED_CODIGO, MED_DESCRICAO, tb_estoque.est_qtde, ' +
        'PRO_DESCRICAO,PRO_CODIGO, PRO_CODSBG,'
      
        'PRO_CAMPANHA,tb_normal.PRC_VL_VDA PRO_VL_NORMAL, tb_promocao.PRC' +
        '_VL_VDA PRO_VL_PROMOCAO, PRO_FORA_LINHA '
      'FROM tb_medida'
      '   INNER JOIN tb_produto'
      '   ON (tb_medida.med_codigo =tb_produto.PRO_CODMED)'
      '   INNER JOIN tb_estoque tb_estoque'
      '   ON (tb_estoque.est_codpro = tb_produto.PRO_CODIGO)'
      '   inner join tb_itens_btn tb_itens_btn'
      '   ON (tb_itens_btn.ibt_codpro = tb_produto.PRO_CODIGO)'
      '   INNER JOIN tb_preco tb_normal'
      
        '   ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_no' +
        'rmal.PRC_CODTPR = 1))'
      '   INNER JOIN tb_preco tb_promocao'
      
        '   ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_' +
        'promocao.prc_codtpr = 2))'
      'WHERE  tb_itens_btn.ibt_codbtn =:BTN_CODIGO and PRO_ATIVO='#39'S'#39
      'AND ( (EST_QTDE >0) or (PRO_EST_NEG = '#39'S'#39') )'
      'ORDER BY MED_DESCRICAO')
    Left = 56
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'BTN_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Preco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select PRC_VL_VDA'
      'FROM tB_PRECO'
      'WHERE PRC_CODTPR = 1 AND PRC_CODPRO =:PRO_CODIGO')
    Left = 136
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object PopupMenu: TPopupMenu
    Left = 248
    Top = 216
    object Desativar1: TMenuItem
      Caption = 'Desativar'
      OnClick = Desativar1Click
    end
    object PausarVenda1: TMenuItem
      Caption = 'Pausar Venda'
      OnClick = PausarVenda1Click
    end
    object HabilitarVenda1: TMenuItem
      Caption = 'Habilitar Venda'
      OnClick = HabilitarVenda1Click
    end
  end
end

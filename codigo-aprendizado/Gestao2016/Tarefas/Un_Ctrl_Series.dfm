object Fr_Ctrl_Serie: TFr_Ctrl_Serie
  Left = 131
  Top = 98
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Controle de S'#233'ries'
  ClientHeight = 593
  ClientWidth = 1170
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1170
    Height = 102
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 1016
    object Label11: TLabel
      Left = 11
      Top = 55
      Width = 67
      Height = 14
      Caption = 'Ordem/Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 89
      Top = 55
      Width = 53
      Height = 14
      Caption = 'Nota Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 667
      Top = 55
      Width = 80
      Height = 14
      Caption = 'N'#250'mero de S'#233'rie'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 10
      Top = 30
      Width = 77
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 89
      Top = 30
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 11
      Top = 15
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 2
      OnClick = ChBx_PeriodoClick
    end
    object E_Pedido: TMaskEdit
      Left = 8
      Top = 71
      Width = 77
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object E_Nota: TMaskEdit
      Left = 86
      Top = 71
      Width = 82
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
    end
    object E_NumeroSerie: TMaskEdit
      Left = 665
      Top = 71
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 5
      Text = ''
    end
    object ChBx_Nome: TCheckBox
      Left = 173
      Top = 15
      Width = 121
      Height = 15
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 294
      Top = 15
      Width = 121
      Height = 15
      Caption = 'Apelido/Fantasia'
      TabOrder = 7
      OnClick = ChBx_FantasiaClick
    end
    object Cb_Empresa: TComboBox
      Left = 171
      Top = 30
      Width = 430
      Height = 22
      Style = csSimple
      CharCase = ecUpperCase
      TabOrder = 8
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 166
      Top = 55
      Width = 499
      Height = 43
      TabOrder = 9
      ExplicitLeft = 166
      ExplicitTop = 55
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 102
    Width = 1170
    Height = 491
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitWidth = 1016
    ExplicitHeight = 501
    DesignSize = (
      1170
      491)
    object SB_Sair_0: TSpeedButton
      Left = 1075
      Top = 431
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 921
      ExplicitTop = 441
    end
    object SB_Buscar: TSpeedButton
      Left = 986
      Top = 431
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitLeft = 832
      ExplicitTop = 441
    end
    object Dbg_Pesquisa: TDBGrid
      Left = 2
      Top = 2
      Width = 1166
      Height = 424
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clCream
      DataSource = Ds_Series
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = Dbg_PesquisaTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PED_ENTRADA'
          Title.Caption = 'Pedido'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SRP_DT_ENTRADA'
          Title.Caption = 'Data Entrada'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NFL_ENTRADA'
          Title.Caption = 'N.F. Entrada'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SRP_NUMERO'
          Title.Caption = 'S'#233'rie'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOFAB'
          Title.Caption = 'C'#243'digo Produto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 317
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_SAIDA'
          Title.Caption = 'Pedido'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SRP_DT_SAIDA'
          Title.Caption = 'Data Sa'#237'da'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NFL_SAIDA'
          Title.Caption = 'N.F. Sa'#237'da'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 80
          Visible = True
        end>
    end
  end
  object Qr_Series: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'SRP_CODIGO, '
      'SRP_NUMERO, '
      'PRO_CODIGOFAB, '
      'PRO_DESCRICAO,'
      ''
      
        'tb_entrada.PED_TIPO PED_ORIGEM, tb_entrada.PED_NUMERO PED_ENTRAD' +
        'A,'
      'tb_nf_entrada.NFL_DT_EMISSAO SRP_DT_ENTRADA, '
      'tb_nf_entrada.NFL_NUMERO NFL_ENTRADA, '
      ''
      'tb_saida.PED_TIPO PED_DESTINO, tb_saida.PED_NUMERO PED_SAIDA,'
      'tb_nf_saida.NFL_DT_EMISSAO SRP_DT_SAIDA,  '
      'tb_nf_saida.NFL_NUMERO NFL_SAIDA'
      ''
      'FROM TB_SERIE_PRODUTO tb_serie'
      '   INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_serie.SRP_CODPRO)'
      ''
      '   LEFT OUTER JOIN tb_itens_nfl tb_itensentrada'
      '   ON (tb_itensentrada.itf_codigo = tb_serie.srp_codent)'
      '   LEFT OUTER JOIN TB_PEDIDO tb_entrada'
      '   ON (tb_entrada.ped_codigo = tb_itensentrada.ITF_CODPED)'
      '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nf_entrada'
      '   ON (tb_nf_entrada.NFL_CODPED = tb_entrada.PED_CODIGO)'
      ''
      '   LEFT OUTER JOIN tb_itens_nfl tb_itenssaida'
      '   ON (tb_itenssaida.itf_codigo = tb_serie.srp_codsai)'
      '   LEFT OUTER JOIN TB_PEDIDO tb_saida'
      '   ON (tb_saida.ped_codigo = tb_itenssaida.ITF_CODPED)'
      '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nf_saida'
      '   ON (tb_nf_saida.NFL_CODPED = tb_saida.PED_CODIGO)'
      '')
    Left = 12
    Top = 464
  end
  object Ds_Series: TDataSource
    AutoEdit = False
    DataSet = Qr_Series
    Left = 15
    Top = 493
  end
  object Qr_Empresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT EMP_CODIGO, EMP_FANTASIA, EMP_NOME'
      'FROM TB_EMPRESA'
      'WHERE (EMP_TIPO = 2)'
      'ORDER BY EMP_FANTASIA')
    Left = 87
    Top = 464
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CODIGOFAB'
      'FROM TB_PRODUTO'
      'ORDER BY PRO_DESCRICAO')
    Left = 120
    Top = 464
  end
end

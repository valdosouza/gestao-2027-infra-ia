object Fr_Ctrl_Lote: TFr_Ctrl_Lote
  Left = 384
  Top = 26
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Controle de Lotes'
  ClientHeight = 548
  ClientWidth = 932
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 932
    Height = 100
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      932
      100)
    object Label2: TLabel
      Left = 8
      Top = 55
      Width = 76
      Height = 14
      Caption = 'N'#250'mero de Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Nr_Lote: TMaskEdit
      Left = 8
      Top = 71
      Width = 105
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
      Text = ''
    end
    object ChBx_SaldoLotePositivo: TCheckBox
      Left = 680
      Top = 74
      Width = 241
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Mostrar somente lotes com saldo positivo'
      TabOrder = 7
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 166
      Top = 55
      Width = 499
      Height = 43
      Anchors = [akTop, akRight]
      TabOrder = 5
      ExplicitLeft = 166
      ExplicitTop = 55
      ExplicitWidth = 499
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 113
      Top = 10
      Width = 428
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      ExplicitLeft = 113
      ExplicitTop = 10
      ExplicitWidth = 428
      ExplicitHeight = 41
      inherited pnl_01: TPanel
        Width = 428
        ExplicitWidth = 428
        inherited ChBx_Nome: TCheckBox
          Left = 42
          ExplicitLeft = 42
        end
        inherited ChBx_Fantasia: TCheckBox
          Left = 198
          ExplicitLeft = 198
        end
      end
      inherited pnl_02: TPanel
        Width = 428
        ExplicitWidth = 428
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 400
          ExplicitLeft = 400
        end
        inherited SB_Empresas: TSpeedButton
          Left = 375
          OnClick = Fm_ListaEmpresasSB_EmpresasClick
          ExplicitLeft = 375
        end
        inherited E_Cd_Empresa: TMaskEdit
          Anchors = [akLeft, akTop]
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 296
          Font.Color = clBlack
          OnClick = Fm_ListaEmpresasDBLCB_EmpresaClick
          ExplicitWidth = 296
        end
      end
    end
    object E_Data_Ini: TDateTimePicker
      Left = 8
      Top = 30
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 91
      Top = 30
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 8
      Top = 15
      Width = 160
      Height = 17
      Caption = 'Data Inicial    Data Final'
      TabOrder = 2
      OnClick = ChBx_PeriodoClick
    end
    object chbx_lote_exato: TCheckBox
      Left = 680
      Top = 55
      Width = 241
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Buscar pelo numero exato do lote'
      TabOrder = 6
    end
  end
  object Pg_Controle: TPageControl
    Left = 0
    Top = 100
    Width = 932
    Height = 448
    ActivePage = tbs_Lotes
    Align = alClient
    TabOrder = 1
    OnChange = Pg_ControleChange
    object tbs_Lotes: TTabSheet
      Caption = 'Lotes'
      ImageIndex = 0
      object DBG_Pesquisa: TDBGrid
        Left = 0
        Top = 0
        Width = 828
        Height = 420
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clCream
        DataSource = Ds_Ctrl_Lote
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = DBG_PesquisaTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CLT_NUMERO'
            Title.Caption = 'N'#250'mero'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLT_CERTIFICADO'
            Title.Caption = 'Certificado'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 91
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLT_DT_VENCIMENTO'
            Title.Caption = 'Vencimento'
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
            FieldName = 'CLT_QT_ENTRADA'
            Title.Caption = 'Entrada'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLT_QT_SAIDA'
            Title.Caption = 'Saida'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLT_QT_SALDO'
            Title.Caption = 'Saldo'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Nome da Empresa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRO_DESCRICAO'
            Title.Caption = 'Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 250
            Visible = True
          end>
      end
      object SB_Buscar_Lote: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 0
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Buscar - F7'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_Buscar_LoteClick
      end
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 362
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Sair - ESC'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_0Click
      end
      object Sb_CalculaLote: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 58
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Recalcula Lote - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_CalculaLoteClick
      end
      object Sb_Ins_Lote: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 116
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Quebra de Lote - F9'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Ins_LoteClick
      end
      object Sb_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 174
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Visualizar - F3'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_VisualizarClick
      end
      object Sb_Inserir: TSpeedButton
        AlignWithMargins = True
        Left = 828
        Top = 232
        Width = 88
        Height = 58
        Margins.Left = 4
        Margins.Right = 4
        Align = alRight
        Caption = 'Inserir - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_InserirClick
      end
    end
    object tbs_Movimento: TTabSheet
      Caption = 'Movimento do Lote'
      ImageIndex = 1
      object Lb_Label_Agente_Entintor: TLabel
        Left = 0
        Top = 0
        Width = 924
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'INFORMA'#199#195'O DE LOTE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Dbg_Movim_Lote: TDBGrid
        Left = 0
        Top = 16
        Width = 924
        Height = 345
        Align = alClient
        Color = clCream
        DataSource = Ds_Movim_Ae
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = Dbg_Movim_LoteDrawColumnCell
        OnTitleClick = DBG_PesquisaTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'MLT_DATA'
            Title.Caption = 'Data'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MLT_TIPO'
            Title.Caption = 'Tipo'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MLT_SENTIDO'
            Title.Caption = 'Sentido'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MLT_QTDE'
            Title.Caption = 'Quantidade'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Empresa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MLT_OBSERVACAO'
            Title.Caption = 'Observa'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 250
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 361
        Width = 924
        Height = 57
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_Sair_1: TSpeedButton
          Left = 832
          Top = 2
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
          OnClick = Sb_Sair_0Click
        end
        object SB_ExcluirQuebra: TSpeedButton
          Left = 648
          Top = 2
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Excluir Quebra'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_ExcluirQuebraClick
        end
        object Sb_Detalhe: TSpeedButton
          Left = 740
          Top = 2
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Detalhe'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_DetalheClick
        end
      end
    end
  end
  object Qr_Ctrl_Lote: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    CLT_CODIGO,'
      '    CLT_CODMHA,'
      '    CLT_CODEMP,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    CLT_NUMERO,'
      '    CLT_CERTIFICADO,'
      '    CLT_CODPRO,'
      '    PRO_DESCRICAO,'
      '    CLT_DT_VENCIMENTO,'
      '    CLT_QT_ENTRADA,'
      '    CLT_QT_SAIDA,'
      '    CLT_QT_SALDO'
      'FROM TB_CTRL_LOTE'
      '   INNER JOIN TB_EMPRESA'
      '   ON (EMP_CODIGO = CLT_CODEMP)'
      '   INNER JOIN TB_PRODUTO'
      '   ON (PRO_CODIGO = CLT_CODPRO)')
    Left = 24
    Top = 464
  end
  object Ds_Ctrl_Lote: TDataSource
    AutoEdit = False
    DataSet = Qr_Ctrl_Lote
    Left = 24
    Top = 492
  end
  object Qr_Movim_AE: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    DataSource = Ds_Ctrl_Lote
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select MLT_CODIGO, MLT_DATA, MLT_TIPO, MLT_CODVCL, MLT_SENTIDO,'
      '  MLT_QTDE, MLT_CODEXT, ep.EMP_NOME, MLT_OBSERVACAO, MLT_LOG'
      'from TB_MOVIMENTO_LOTE ml'
      '   inner join tb_itens_nfl i'
      '   on (i.itf_codigo = ml.mlt_codvcl)'
      '   inner join tb_pedido pe'
      '   on (pe.ped_codigo = i.itf_codped)'
      '   inner join tb_empresa ep'
      '   on (ep.emp_codigo = pe.ped_codemp)'
      'WHERE MLT_CODCLT=:CLT_CODIGO'
      'AND MLT_TIPO <> '#39'PRODU'#199#195'O M.P.'#39
      'and MLT_TIPO <> '#39'PRODU'#199#195'O P.A.'#39
      'and MLT_TIPO <> '#39'EXT_QUEBRA'#39
      'and MLT_TIPO <> '#39'AVULSO'#39
      'UNION'
      
        'select MLT_CODIGO, MLT_DATA, MLT_TIPO, MLT_CODVCL, MLT_SENTIDO, ' +
        'MLT_QTDE, MLT_CODEXT, pr.pro_descricao EMP_NOME, MLT_OBSERVACAO,' +
        ' MLT_LOG'
      'from TB_MOVIMENTO_LOTE ml'
      '   inner join TB_ORPPREV iMP'
      '   on (iMP.pre_codigo = mlt_codvcl)'
      '   inner join tb_orp orp'
      '   on (orp.orp_codigo = iMP.pre_codorp)'
      '   inner join tb_produto pr'
      '   on (pr.pro_codigo = orp.orp_codpro)'
      'WHERE MLT_CODCLT=:CLT_CODIGO'
      'AND MLT_TIPO = '#39'PRODU'#199#195'O M.P.'#39
      'UNION'
      
        'select MLT_CODIGO, MLT_DATA, MLT_TIPO, MLT_CODVCL, MLT_SENTIDO, ' +
        'MLT_QTDE, MLT_CODEXT, '#39#39' EMP_NOME, MLT_OBSERVACAO, MLT_LOG'
      'from TB_MOVIMENTO_LOTE ml'
      'WHERE MLT_CODCLT=:CLT_CODIGO'
      'AND MLT_TIPO = '#39'PRODU'#199#195'O P.A.'#39
      'UNION'
      
        'select MLT_CODIGO, MLT_DATA, MLT_TIPO, MLT_CODVCL, MLT_SENTIDO, ' +
        'MLT_QTDE, MLT_CODEXT, '#39#39' EMP_NOME, MLT_OBSERVACAO, MLT_LOG'
      'from TB_MOVIMENTO_LOTE ml'
      'WHERE MLT_CODCLT=:CLT_CODIGO'
      'AND MLT_TIPO = '#39'EXT_QUEBRA'#39
      'UNION'
      
        'select MLT_CODIGO, MLT_DATA, MLT_TIPO, MLT_CODVCL, MLT_SENTIDO, ' +
        'MLT_QTDE, MLT_CODEXT, '#39#39' EMP_NOME, MLT_OBSERVACAO, MLT_LOG'
      'from TB_MOVIMENTO_LOTE ml'
      'WHERE MLT_CODCLT=:CLT_CODIGO'
      'AND MLT_TIPO = '#39'AVULSO'#39
      'order by 2,5 ASC')
    Left = 88
    Top = 464
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CLT_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_Movim_AEMLT_CODIGO: TIntegerField
      FieldName = 'MLT_CODIGO'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Movim_AEMLT_DATA: TDateField
      FieldName = 'MLT_DATA'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_DATA"'
    end
    object Qr_Movim_AEMLT_TIPO: TStringField
      FieldName = 'MLT_TIPO'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_TIPO"'
      Size = 25
    end
    object Qr_Movim_AEMLT_CODVCL: TIntegerField
      FieldName = 'MLT_CODVCL'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_CODVCL"'
    end
    object Qr_Movim_AEMLT_SENTIDO: TStringField
      FieldName = 'MLT_SENTIDO'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_SENTIDO"'
      Size = 1
    end
    object Qr_Movim_AEMLT_QTDE: TBCDField
      FieldName = 'MLT_QTDE'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_QTDE"'
      DisplayFormat = '0.00###'
      Precision = 18
      Size = 6
    end
    object Qr_Movim_AEMLT_CODEXT: TIntegerField
      FieldName = 'MLT_CODEXT'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_CODEXT"'
    end
    object Qr_Movim_AEEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 60
    end
    object Qr_Movim_AEMLT_OBSERVACAO: TStringField
      FieldName = 'MLT_OBSERVACAO'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_OBSERVACAO"'
      Size = 100
    end
    object Qr_Movim_AEMLT_LOG: TStringField
      FieldName = 'MLT_LOG'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_LOG"'
      Size = 100
    end
  end
  object Ds_Movim_Ae: TDataSource
    DataSet = Qr_Movim_AE
    Left = 88
    Top = 492
  end
end

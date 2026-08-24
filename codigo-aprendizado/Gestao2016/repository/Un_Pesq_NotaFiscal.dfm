object Fr_Pesq_NotaFiscal: TFr_Pesq_NotaFiscal
  Left = 264
  Top = 2
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pesquisar Notas Fiscais'
  ClientHeight = 680
  ClientWidth = 1011
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 57
    Width = 1011
    Height = 198
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label33: TLabel
      Left = 279
      Top = 95
      Width = 60
      Height = 14
      Caption = 'Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label42: TLabel
      Left = 830
      Top = 56
      Width = 24
      Height = 14
      Caption = 'Fone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 6
      Top = 56
      Width = 29
      Height = 14
      Caption = 'Bairro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label49: TLabel
      Left = 301
      Top = 56
      Width = 33
      Height = 14
      Caption = 'Regi'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 488
      Top = 56
      Width = 16
      Height = 14
      Caption = 'U.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label47: TLabel
      Left = 537
      Top = 56
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 95
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label36: TLabel
      Left = 168
      Top = 17
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Nota Fiscal'
      FocusControl = E_BuscaNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 284
      Top = 17
      Width = 72
      Height = 14
      Caption = 'N'#250'mero pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_CodigoCliente: TLabel
      Left = 362
      Top = 17
      Width = 68
      Height = 14
      Caption = 'C'#243'digo Cliente'
    end
    object Label1: TLabel
      Left = 248
      Top = 17
      Width = 32
      Height = 13
      AutoSize = False
      Caption = 'S'#233'rie'
      FocusControl = E_BuscaSerie
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BuscaRazao: TMaskEdit
      Left = 440
      Top = 32
      Width = 480
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
    end
    object E_BuscaObs: TMaskEdit
      Left = 274
      Top = 111
      Width = 258
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      Text = ''
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 32
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 32
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_BuscaBairro: TMaskEdit
      Left = 6
      Top = 70
      Width = 293
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_BuscaRegiao: TMaskEdit
      Left = 299
      Top = 70
      Width = 188
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = ''
    end
    object E_BuscaEstado: TMaskEdit
      Left = 489
      Top = 70
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 9
      Text = ''
    end
    object E_BuscaCidade: TMaskEdit
      Left = 534
      Top = 70
      Width = 289
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 10
      Text = ''
    end
    object E_BuscaFone: TEdit_Setes
      Left = 826
      Top = 70
      Width = 95
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Text = ''
    end
    object Dblcb_BuscaVendedor: TDBLookupComboBox
      Left = 6
      Top = 111
      Width = 266
      Height = 22
      KeyField = 'CLB_CODIGO'
      ListField = 'CLB_NOME'
      ListSource = DM_ListaConsultas.DS_ListaVendedor
      TabOrder = 12
      OnKeyDown = Dblcb_BuscaVendedorKeyDown
    end
    object RG_Tipo_Operacao: TRadioGroup
      Left = 926
      Top = 86
      Width = 82
      Height = 85
      Caption = 'Tipo Opera'#231#227'o'
      Enabled = False
      ItemIndex = 1
      Items.Strings = (
        'Entrada'
        'Saida'
        'Todas')
      TabOrder = 14
      OnClick = RG_Tipo_OperacaoClick
    end
    object E_BuscaNota: TMaskEdit
      Left = 167
      Top = 32
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 9
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object E_BuscaPedido: TMaskEdit
      Left = 281
      Top = 32
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      Text = ''
    end
    object E_BuscaEmpresa: TEdit
      Left = 362
      Top = 32
      Width = 77
      Height = 22
      TabOrder = 5
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 17
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 15
      OnClick = ChBx_PeriodoClick
    end
    object ChBx_Nome: TCheckBox
      Left = 440
      Top = 17
      Width = 121
      Height = 15
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 560
      Top = 17
      Width = 121
      Height = 15
      Caption = 'Apelido/Fantasia'
      TabOrder = 17
      OnClick = ChBx_FantasiaClick
    end
    object Rg_Sit_Nfe: TRadioGroup
      Left = 5
      Top = 134
      Width = 692
      Height = 39
      Caption = 'Situa'#231#227'o Nota Fiscal Eletr'#244'nica'
      Columns = 7
      ItemIndex = 6
      Items.Strings = (
        'Pendentes'
        'Enviadas'
        'Autorizadas'
        'Canceladas'
        'Inutilizada'
        'Denegada'
        'Todas')
      TabOrder = 18
    end
    object Rg_Tipo_Nota: TGroupBox
      Left = 926
      Top = 6
      Width = 82
      Height = 79
      Caption = 'Tipo de Notas'
      TabOrder = 19
      object ChBx_Vendas: TCheckBox
        Left = 7
        Top = 17
        Width = 62
        Height = 17
        Caption = 'Vendas'
        TabOrder = 0
      end
      object ChBx_Compras: TCheckBox
        Left = 8
        Top = 35
        Width = 62
        Height = 17
        Caption = 'Compras'
        TabOrder = 1
      end
      object ChBx_Ajustes: TCheckBox
        Left = 8
        Top = 54
        Width = 62
        Height = 17
        Caption = 'Ajustes'
        TabOrder = 2
      end
    end
    object E_BuscaSerie: TMaskEdit
      Left = 248
      Top = 32
      Width = 32
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object ChBx_Venda_Numerada: TCheckBox
      Left = 9
      Top = 176
      Width = 241
      Height = 17
      Caption = 'Mostrar somente Vendas com N'#250'mero de Nota'
      TabOrder = 20
    end
    inline Fm_lista_cfop: TFm_lista_cfop
      AlignWithMargins = True
      Left = 534
      Top = 92
      Width = 385
      Height = 42
      Margins.Top = 0
      Margins.Bottom = 0
      TabOrder = 21
      ExplicitLeft = 534
      ExplicitTop = 92
      ExplicitWidth = 385
      ExplicitHeight = 42
      inherited pnl_linha_1: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited Sb_open: TSpeedButton
          Left = 361
          ExplicitLeft = 417
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 361
          Height = 22
          ExplicitWidth = 361
          ExplicitHeight = 22
        end
      end
      inherited pnl_top: TPanel
        Width = 385
        ExplicitWidth = 385
        inherited L_name_list: TLabel
          Width = 359
          Height = 16
        end
        inherited Chbx_cfop: TCheckBox
          Visible = False
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 255
    Width = 1011
    Height = 425
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel4'
    TabOrder = 1
    object Panel1: TPanel
      Left = 909
      Top = 2
      Width = 100
      Height = 421
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 256
        Width = 94
        Height = 54
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alBottom
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
        ExplicitLeft = 909
        ExplicitTop = 337
        ExplicitWidth = 92
      end
      object SB_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 310
        Width = 94
        Height = 54
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_VisualizarClick
        ExplicitLeft = 6
        ExplicitTop = 296
      end
      object SB_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 364
        Width = 94
        Height = 54
        Margins.Top = 0
        Align = alBottom
        Caption = 'Sair- Esc'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_Sair_0Click
        ExplicitLeft = 0
        ExplicitTop = 388
      end
      object Lb_TotalVendas: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 1
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total Venda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 923
        ExplicitTop = 2
        ExplicitWidth = 84
      end
      object E_TotalVenda: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 17
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 72
        ExplicitTop = 16
        ExplicitWidth = 28
      end
      object Lb_NumeroVendas: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'N'#250'mero de Vendas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 892
        ExplicitTop = 39
        ExplicitWidth = 92
      end
      object E_NumeroVendas: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 52
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 72
        ExplicitTop = 51
        ExplicitWidth = 28
      end
      object Lb_TicketMedia: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Ticket M'#233'dio '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 894
        ExplicitTop = 74
        ExplicitWidth = 90
      end
      object E_TicketMedia: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 87
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 72
        ExplicitTop = 82
        ExplicitWidth = 28
      end
    end
    object Pg_Resultado: TPageControl
      Left = 2
      Top = 2
      Width = 907
      Height = 421
      ActivePage = tbs_resumo
      Align = alClient
      TabOrder = 1
      object tbs_resultado: TTabSheet
        Caption = 'Resultado da pesquisa :'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DBG_Pesquisa: TDBGrid
          Left = 0
          Top = 0
          Width = 899
          Height = 393
          Align = alClient
          Color = clCream
          DataSource = Ds_Pesquisa
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
          OnDblClick = DBG_PesquisaDblClick
          OnTitleClick = DBG_PesquisaTitleClick
        end
      end
      object tbs_resumo: TTabSheet
        Caption = 'Resumo por Hora'
        ImageIndex = 1
        TabVisible = False
      end
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 1011
    Height = 57
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 1011
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 1011
      ExplicitWidth = 1011
      inherited Sb_open: TSpeedButton
        Left = 987
        ExplicitLeft = 987
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 987
        ExplicitWidth = 987
      end
    end
    inherited pnl_top: TPanel
      Width = 1011
      ExplicitWidth = 1011
      inherited L_name_list: TLabel
        Width = 988
        Height = 16
      end
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Qr_Pesquisa
    Left = 389
    Top = 115
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT NFL_CODIGO, PED_NUMERO, NFL_NUMERO, NFL_DT_EMISSAO, EMP_F' +
        'ANTASIA, EMP_NOME,NFL_VL_TL_NOTA'
      'FROM TB_NOTA_FISCAL Tb_nota_fiscal'
      '  INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '  INNER JOIN TB_PEDIDO tb_pedido'
      '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)')
    Left = 392
    Top = 72
  end
end

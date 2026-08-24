object Fr_Imp_Produtos: TFr_Imp_Produtos
  Left = 597
  Top = 7
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rios de Produtos'
  ClientHeight = 518
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 264
    Top = 48
    Width = 500
    Height = 410
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Pg_Parametros: TPageControl
      Left = 2
      Top = 2
      Width = 496
      Height = 406
      ActivePage = tbs_parametro
      Align = alClient
      TabOrder = 0
      object tbs_parametros: TTabSheet
        Caption = 'Par'#226'metros'
        ImageIndex = 3
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 488
          Height = 378
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label1: TLabel
            Left = 6
            Top = 74
            Width = 75
            Height = 14
            Caption = 'Nome do Grupo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 6
            Top = 111
            Width = 98
            Height = 14
            Caption = 'Nome do Sub-Grupo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 6
            Top = 148
            Width = 75
            Height = 14
            Caption = 'Nome da Marca'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 268
            Top = 39
            Width = 77
            Height = 14
            Caption = 'Tabela de Pre'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 83
            Top = 185
            Width = 218
            Height = 14
            Caption = 'Informe parte ou toda a descri'#231#227'o do produto'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 6
            Top = 185
            Width = 33
            Height = 14
            Caption = 'C'#243'digo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 6
            Top = 223
            Width = 113
            Height = 14
            Caption = 'Localiza'#231#227'o / Endere'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object SB_Cad_produto: TSpeedButton
            Left = 455
            Top = 199
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = SB_Cad_produtoClick
          end
          object DBLCB_Marca: TDBLookupComboBox
            Left = 6
            Top = 163
            Width = 476
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'MRC_CODIGO'
            ListField = 'MRC_DESCRICAO'
            ListSource = DM.Ds_marcaProduto
            ParentFont = False
            TabOrder = 0
            OnKeyDown = DBLCB_MarcaKeyDown
          end
          object DBLCB_Grupos: TDBLookupComboBox
            Left = 6
            Top = 89
            Width = 476
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'GRP_CODIGO'
            ListField = 'GRP_DESCRICAO'
            ListSource = DM.Ds_Grupo
            ParentFont = False
            TabOrder = 1
            OnKeyDown = DBLCB_GruposKeyDown
          end
          object DBLCB_SubGrupos: TDBLookupComboBox
            Left = 6
            Top = 126
            Width = 476
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'SBG_CODIGO'
            ListField = 'SBG_DESCRICAO'
            ListSource = DM.Ds_SubGrupo
            ParentFont = False
            TabOrder = 2
            OnKeyDown = DBLCB_SubGruposKeyDown
          end
          object ChBx_Periodo: TCheckBox
            Left = 6
            Top = 3
            Width = 178
            Height = 12
            Caption = 'Data Inicial         Data Final'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 3
            OnClick = ChBx_PeriodoClick
          end
          object DBLCB_Tabela_Preco: TDBLookupComboBox
            Left = 267
            Top = 54
            Width = 214
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'TPR_CODIGO'
            ListField = 'TPR_NOME'
            ListSource = DM.Ds_Tabelas
            ParentFont = False
            TabOrder = 6
          end
          object E_BuscaDescricaoProduto: TEdit
            Left = 80
            Top = 200
            Width = 371
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 5
          end
          object Grp_Mov_Empresa: TGroupBox
            Left = 6
            Top = 261
            Width = 476
            Height = 56
            Caption = 'Filtro para movimenta'#231#227'o do produto por empresas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            object DBLCB_Empresa: TDBLookupComboBox
              Left = 4
              Top = 29
              Width = 466
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'EMP_CODIGO'
              ListField = 'EMP_NOME'
              ListSource = DM_ListaConsultas.Ds_ListaFornecedor
              ParentFont = False
              TabOrder = 0
              OnKeyDown = DBLCB_EmpresaKeyDown
            end
            object Rb_Empresa: TRadioButton
              Left = 5
              Top = 15
              Width = 115
              Height = 13
              Caption = 'Cliente/Fornecedor'
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = Rb_EmpresaClick
            end
            object Rb_Produto: TRadioButton
              Left = 122
              Top = 15
              Width = 137
              Height = 13
              Caption = 'Fornecedor do Produto'
              TabOrder = 2
              OnClick = Rb_ProdutoClick
            end
            object ChBx_Nome: TCheckBox
              Left = 254
              Top = 11
              Width = 115
              Height = 17
              Caption = 'Nome/Raz'#227'o Social'
              Checked = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              State = cbChecked
              TabOrder = 3
              OnClick = ChBx_NomeClick
            end
            object ChBx_Fantasia: TCheckBox
              Left = 367
              Top = 11
              Width = 101
              Height = 17
              Caption = 'Apelido/Fantasia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnClick = ChBx_FantasiaClick
            end
          end
          object Grp_Vendedor: TGroupBox
            Left = 6
            Top = 317
            Width = 476
            Height = 56
            Caption = 'Nome do Vendedor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            object Rb_Vend_Cliente: TRadioButton
              Left = 5
              Top = 15
              Width = 114
              Height = 13
              Caption = 'Cadastro do Cliente'
              TabOrder = 0
            end
            object Rb_Vend_Pedido: TRadioButton
              Left = 141
              Top = 15
              Width = 131
              Height = 13
              Caption = 'Registrado no Pedido'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
            object dblcb_Vendedor: TDBLookupComboBox
              Left = 5
              Top = 31
              Width = 468
              Height = 22
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              KeyField = 'CLB_CODIGO'
              ListField = 'CLB_NOME'
              ListSource = DM_ListaConsultas.DS_ListaVendedor
              ParentFont = False
              TabOrder = 2
              OnKeyDown = dblcb_VendedorKeyDown
            end
          end
          object E_Data_Ini: TDateTimePicker
            Left = 6
            Top = 18
            Width = 95
            Height = 22
            Date = 39580.000000000000000000
            Time = 39580.000000000000000000
            TabOrder = 9
          end
          object E_Data_Fim: TDateTimePicker
            Left = 102
            Top = 18
            Width = 95
            Height = 22
            Date = 39580.999988425930000000
            Time = 39580.999988425930000000
            TabOrder = 10
          end
          object E_Busca_Local: TEdit
            Left = 6
            Top = 238
            Width = 474
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 11
          end
          inline Fm_ListaEstoques: TFm_ListaEstoques
            Left = 5
            Top = 40
            Width = 260
            Height = 36
            TabOrder = 12
            ExplicitLeft = 5
            ExplicitTop = 40
            ExplicitWidth = 260
            inherited Label1: TLabel
              Width = 255
            end
            inherited Sb_Cadastro: TSpeedButton
              Left = 237
              ExplicitLeft = 234
              ExplicitHeight = 13
            end
            inherited Dblcb_Estoque: TDBLookupComboBox
              Width = 253
              ExplicitWidth = 253
            end
            inherited ChBx_Estoques: TCheckBox
              Left = 153
              OnClick = nil
              ExplicitLeft = 153
            end
          end
          object E_BuscaCodigoProduto: TEdit
            Left = 6
            Top = 200
            Width = 72
            Height = 21
            TabOrder = 4
            OnExit = E_BuscaCodigoProdutoExit
          end
        end
      end
      object tbs_parametro: TTabSheet
        Caption = 'Outros Parametros'
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 488
          Height = 378
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object ChBx_Est_Min: TCheckBox
            Left = 2
            Top = 40
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Produto abaixo do estoque m'#237'nimo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ChBx_SemMov: TCheckBox
            Left = 2
            Top = 23
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Produto sem movimento no per'#237'odo'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object chbx_positivo: TCheckBox
            Left = 2
            Top = 57
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos com saldo positivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object Chbx_Inativos: TCheckBox
            Left = 2
            Top = 91
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Incluir produtos inativos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object Chbx_AlteracaoPrecoCompra: TCheckBox
            Left = 2
            Top = 108
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Mostrar somente as altera'#231#245'es de pre'#231'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ChBx_UltimaAlteracaoVenda: TCheckBox
            Left = 2
            Top = 125
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Somente a '#250'ltima altera'#231#227'o de pre'#231'o'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object Chbx_AnaliseMovimento: TCheckBox
            Left = 2
            Top = 142
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Analisar Somente Movimenta'#231#227'o Per'#237'odo'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = Chbx_AnaliseMovimentoClick
          end
          object Chbx_Vl_Venda_Maior_Zero: TCheckBox
            Left = 2
            Top = 159
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos com Pre'#231'o de venda maior do que zero'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object chbx_negativo: TCheckBox
            Left = 2
            Top = 74
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos com saldo negativo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object ChBx_InternetPublished: TCheckBox
            Left = 2
            Top = 176
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos publicados na Internet'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object Panel6: TPanel
            Left = 2
            Top = 2
            Width = 484
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 10
            object Lb_Nr_Meses_CurvaABC: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 478
              Height = 12
              Align = alTop
              AutoSize = False
              Caption = 'Usar          meses no c'#225'lculo da Curva ABC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object E_Curva_Nr_Mes: TEdit_Setes
              Left = 30
              Top = 0
              Width = 20
              Height = 21
              Alignment = taCenter
              TabOrder = 0
              Text = '3'
              OnChange = E_Curva_Nr_MesChange
            end
          end
          object chbx_zerado: TCheckBox
            Left = 2
            Top = 193
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos com saldo igual a Zero'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object chbx_com_movimento: TCheckBox
            Left = 2
            Top = 210
            Width = 484
            Height = 17
            Align = alTop
            Caption = 'Apenas produtos que movimentaram na data  selecionada'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Estoque &&  Invent'#225'rio'
        ImageIndex = 1
        OnShow = TabSheet1Show
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Estoque_Inventario: TPanel
          Left = 215
          Top = 0
          Width = 273
          Height = 378
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object ChBx_CustoMedio: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 3
            Width = 263
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Calcular o custo m'#233'dio dos produto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object chbx_AuditoriaEstoque: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 41
            Width = 263
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Efetuar auditoria na contagem de Estoque'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = chbx_AuditoriaEstoqueClick
          end
          object ChBx_Contagem: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 22
            Width = 263
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Efetuar contagem de Estoque'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ChBx_ContagemClick
          end
          object Panel7: TPanel
            Left = 2
            Top = 320
            Width = 269
            Height = 56
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 3
            object Sb_Inventario: TSpeedButton
              AlignWithMargins = True
              Left = 186
              Top = 3
              Width = 80
              Height = 50
              Margins.Left = 1
              Align = alRight
              Caption = 'Inventario - F5'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                360C0000424D360C000000000000360000002800000020000000200000000100
                180000000000000C0000C40E0000C40E00000000000000000000FFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFFF8F5EFF0ECE8FFFEFDFF
                FFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFCFFFFFCFEFEFBF7F9F68AACC5167CBF1964959DB0BFEA
                ECEDFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFDFFFDFAB4C7D13282BB288ACB4CADEA78CFF954A4D43D
                7CABABAEB3FDFEFDFFFFFEFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFEFEFBFFFFFCFEFEFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCD4E0E64F8AB32481C13E96E43393DD53B3EB71CDFC76CFFC75
                D1FE3588BA326588D8D8D9FDFDFAFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCEFF1F27492A8F1E6DEFFFCFBFFFFFEFFFFFCFFFF
                FEF3F1EF4A89B63089C63799DC3A80E33863E84494E64EB8F172CDFC71C6F077
                BEDC71CDFA70C6F03281B7577896ECEEECFAF9F8FFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFB58B2DF21B4EB1D87C145789FABB9C2C5C9CC97B5
                C93988BC3C9AD63EA2E343A5E2326DDE3A5EEB4487EC5FBCEF6BC6F568B5E0BC
                B3B2D2CAC495BED676D5FF5EABD22968939FAFBCF4F3F0FDFDFBFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCC1D9E7099DE515C6FE16C6FE18C4FD219AD51373B93C9D
                DD41A3E245A7E347A7E353B1EA416EEE385EEA499EE660BDF362BDF06AB3DEF3
                E0CFFCF5EEF9EDDBCBB8AF84C2E871CEFC44A0D92B5D88EFECE9FFFFFCFFFFFC
                FFFFFCFFFFFCF5F9F92EB0E60CB9F62AC3F81ECAFF22CAFE1487C94FACEA3F80
                E73A70E34FAFE852B1EA4EA1E73A6CE6457BEC60B9F263BFF15CB9F061ADDAF6
                E9DEE8D5CBF1CAB5FAEADAD3CFCBB7BFC477CEF850AAE19FA5AAFFFFFCFFFFFC
                FFFFFCFFFFFDC5E1ED10C0FC0AB9F531BAF12DD2FF2DD0FD1A90CD5BB3ED395F
                EB3E67ED56A2F05CBCEE61BCF060BDF162BEF164C1F269C2F954B2EA58A7D7F4
                E2D1EFCBB8FAEFE5E4B49EF8D8BDDACABA61BEF155AEE0A3A8ADFFFFFCFFFFFC
                FFFFFCFFFDF972BFE50AC1FD12BEFB26ADE635D7FF40DAFD1891CD65BCF4395F
                EA3C66EA60B9F34BA5DB3F98D469C5F667C3F46BC6F567C3F74CACE655A4D1FB
                F1E6F8F2EBE2C5B6ECCAB6F9DFD1D0B8AB57C2FD4FAADFA4A9ADFFFFFCFFFFFC
                FFFFFCEBF2F306AEF00EC4FF14C0FD18A5E44AE2FF46DCFE2B99D45093E83A67
                E453A5F057ACE2338CC74DA5DA6ECAF86DC9F771CDFB69C5F742A3E146A5E0AC
                B8C3FBF6F2F9FBFCF1E5DCD8B7A6B8B7B950BAF849A4D7A4A9AEFFFFFCFFFFFC
                FFFFFCA9CFE70DC4FF17C7FF1BC8FF19A7E44CE0FE54E3FD3099CF75CCFF67BB
                F56AC7F661B6E54BA2D753A9E072CEFD7DD3FC449FD82F8ECB50B3EF41A2DF44
                9CD85BA4E17672BDCFBFE5FFFEF7BBB5B546B6F646A0D8A4A9AEFFFFFCFFFFFC
                FAFDFB47B9E923CDFF1BC8FF1ACAFF19A7E457DFF959E6FD3299CF77D1FD6CC8
                F672CEFD6BBEEB5AAED866BAE664BCEF2A88C62886C92E93D92E93D74AADEA44
                AAE83FA0DF3A89D55983D0DAD2CBC0B5B33AAEEE3A97D4A5AAAEFFFFFCFFFFFC
                F3F9FA31C3F721CAFF22CBFF22CCFF18ABEB5BDFF65FE9FD349BD07ED4FD71CC
                FC72CDFC71C4F06EBCE4419AD33190D03EA1E03A9DDF3A9CDF3599DB3599DB37
                9BDD51B4EE42A5E23294DB3F9BD6529DCD3CA3E53595CFA5AAAFFFFFFCFFFFFD
                CFE5EC24C5F72CD0FE27CDFE27CEFF27AEE66CE5F787DEEA4A97C17BD3FD77D0
                FC72CAF853AEE23991CD2981BC358DC9429CD747A7E445A6E344A5E33FA3E33E
                9FE03C9EDE48ABEA4CB0EC379DDF3694D63499DB2D8ACCA6ABAFFFFFFCFFFFFD
                A5D4E72ACDFB2DD1FE2DD1FE2DD2FF28B2EA89EDFEA4BBAD6398BA83E1FF54B3
                EC2C87C856B3EB50ACE33D96D0358EC83792CA4298CE4AACE74CAEE94AAAE44A
                AAE54AAAE546A8E443A4E24EB0EB4BADE82C91D62787CBA6ABAFFFFFFCFFFEFA
                3BA8E23CDBFF34D4FE31D3FE34D6FF26AEE786EFFC9FCCC2598EB841A7E44FA9
                E065BFF65FBCEE60BCF35DB9EF57AEE1489FD34198CF479BD053A9DA55B0E856
                B3EC51B0EA4FAEE74DADE849AAE64DAEEA54B7F2278BCDC7C7C8FFFFFCFFF9F5
                22B4EC47DFFF47DEFF48DEFF3BD7FF26ACE48EF4FEA2D3CBABA2A64597C65DBF
                F769C4F465C1F365C1F365C1F364C0F263BDF159AFE353A8D849A0D153A8DB5D
                B2E259B8EC59B5ED58B5ED54B2EB58B4EC3F9EDB9AB7C9FFFDFBFFFFFCE2ECF0
                2EC4F348E0FF45DEFF46DEFF45DDFF31A7DA97FEFFA9D1C7FFEDDADDDFD87FAD
                C6369DDD6ECEFE6BC7F56AC3F867C2F468C3F46BC4F464BCEE63B6E35AAFDC52
                A8D95BB2E461B8E865C4FA48A4E33891CB598CB1FCFCF9FFFFFCFFFFFCCCE1EB
                41D7FF4FE2FF4EE2FF48DFFF46DDFF32A8DDB1FFFFAFBFB3F0DCCEDACDC8DFBD
                ACDBB3A3667C9259B3EE6FCAFA71CCFA6DC9F76CC8F66BC6F669C5F66EC2EE66
                BAE75EB1D860B1DF3991C762A7CAAAEDF56899BAFDFDFAFFFFFCFFFFFC86C1DE
                54E7FF55E5FE56E5FE4EE2FF4FDDFB4CAEE9ABFFFDADF4F5EFC7A6CDB2A7FDF7
                EEFEF2E6EDE4DDBDB9B94192C35FBCF37DD4FD70CCFB72CDFC71CCFB71CCF76E
                C8F83794D51D79BB6BBAE1ADE8ECB0E3EB6A9DBCFEFDFBFFFFFCFFFFFC7DC1DC
                66F0FF63ECFE59E8FE5AE8FE57DAF371CCF8BBFFFFB3FCFEC4DBDAE9C7B3F7EB
                E4FBF5EEFDFAF5FFFFFCDCDBD7689BB0459CD161BBEE79D2FE71CAF748A3DD58
                A3C8A3EBF2AFF5FC9ED6DCB0E5EBB1E2E86B9EBEFEFEFBFFFFFCFFFFFC78C1DE
                70FAFF6AEDFF68ECFF61ECFE5EE0F752B1E9ADF5FBC7FEFFCAFDFEBEFBFCBAE9
                F0C3CCC1CAC2B7F0D8C9EABAA7B2ECF0B7F8FB69ADCA3693CD3D8BBE6CBACF4A
                A1D058B2E676CAE3B2E1ECC7EDEAAED6E26C9FC0FEFEFBFFFFFCFFFFFC9ACFE8
                6AF1FC75F7FF70F5FF71F4FF70F3FF59D6F552C4E149C0E562C0EC7FC9E89ADC
                E7C4F6FED9FFFFD0F2F3C9ECE9C6FFFFC0FDFFC8FFFFA6E3EFBEFBFCC5FFFFBE
                FBFFAEE5F296C5DB82B9D2B8E2ED97C4D9A9BECEFFFEFBFFFFFCFFFFFCF7F8F7
                C0D5E262ACD05EBEEE57D3F067E5F76BEDFD71F7FE72F8FF6EF0FF6AECFE54D1
                EB3DB0D740A6E364C1EF92D5EFAEEAF6CCFCFED7FDFDD6FEFECDFDFFCDFDFFCD
                FDFFCDF7FBC7ECE9DBECF4D1E9EE7BA9C8DBE4E5FFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFDFCFEFBF5F9F9EAF2F4D6E7EFB9DDE8A0D7E451C0ED43C4E54BD2F161E7
                FA6FF9FF6EF6FF68E7FA5BDAF050C9EA4EBCE355BAE973BFE794CEE2BDECF3DF
                FEFEE1FCFBE4E8E8E0E8E9D9E9EE659BBBF1F1F0FFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFDFFFEFCFFF8F6EEEDEB9DC9
                DD77B0CD6BBBE960D0F15FDFF872F4FF73F5FF6AEDFF61E5F753D3EC42B7DA3F
                B4D958B0E999D8EFBAE0F0C6E2F095BAD1FEFCFAFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFE
                FBFDFEFCFAFCFAF3F8F890C7DF71F3FF70F2FF6CF0FF70F3FF6CF0FF6BEFFF6B
                EEFF68B2D7EBEFF0F2F3F5C8E1ECECF2F4FFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFDCBDFE96DE9F481FCFF7EF7FE74F4FF74F3FF72F3FF64
                E9FA92BDD9FFFFFDFFFFFCFFFFFDFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFCF0F2F25DC2E651CFE85EE1F477F4FE83FEFF79F8FE67
                AED4F7F8F6FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFCFFFFFCF8F9F9EDF3F1E8EAEE8DC5DD79C1DE91CCE4EB
                F5F3FFFFFDFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC
                FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFF
                FCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFF
                FFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFC}
              Layout = blGlyphTop
              ParentFont = False
              OnClick = Sb_InventarioClick
              ExplicitTop = 8
            end
            object sb_estoque: TSpeedButton
              AlignWithMargins = True
              Left = 104
              Top = 3
              Width = 80
              Height = 50
              Margins.Right = 1
              Align = alRight
              Caption = 'Estoque - F4'
              Enabled = False
              Flat = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Glyph.Data = {
                360C0000424D360C000000000000360000002800000020000000200000000100
                180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFF
                FEFFFFFFFFFFFFFFFDECE6DFDED4CADFD4C9E0D4C7DFD5C4DED6C7DDD5C9DBD5
                C9DCD4C9DDD5C8DFD2CAE1D2CCE2D4CDE1D2CCE0D2CBDAD5CCDBD6CBDBD6C9DE
                D5CAD9D2C7E6E3D8FEFEFBFCFFFFFFFFFEFFFFFEFFFFFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF5F3ECDCC7A9DDBD99DDBC99DDBC95DBBD8FD9BC8ED7BA8FD6BA
                8ED5B88DD4B88BD8B987D8BA85DABB87D7B884D5B782D6BA86E2B57BDDB577DE
                B17CD6AC77B7A27CE6E2D9FBFFFFFEFFFCFEFFFCFEFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF0EDE6E7D4ADEED4A6EED4B0ECD2B0ECD1ABEBD1A8ECCFA6ECCE
                A3EBCDA2E9CCA3EACC94E1C180DDBD7DE4C484DDBE7EDCB979E8BD85C0B997B4
                B39DDFBC8AC0A377D8D2C7FDFFFFFFFFFDFEFFFDFDFFFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF1EEE7E1D5B2E1D3B2F1E8D6F1E9DAE1D5C1EAE4D8EDE7DDDBD1
                C2EFE6D9ECE8DFE1C7A5C09968B69160D5B07FBC9665AB8F51B2AE9549A1D62E
                98D5ADB69BC9AA79DDD2C5FEFFFFFFFFFEFDFFFFFDFFFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF2EFE8E6D3B7E4D1B8F2E9E0F0E8DFE3D8C3ECE8DFECE6DEDED1
                C0F1E7DAEBE7E3E2CFA9C7A86EBB9D65D7B980C3A56BBA9B56C3B59944AAEB15
                9EEDACB9A1D4AC77E1D3C5FFFFFFFFFFFFFDFEFFFCFEFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF2EFE8ECD6B9EAD2B8DECFC5DED2C6E6D7BCE2D4C2E2D2BEE9D3
                B5E6D2B7DECFBFE5CEACD6BA88D2B685E1C395D4B684CDB37BD2BEA469B5E232
                A9ECABBAB1D0AB80E1D5C6FFFFFFFFFEFFFDFEFFFCFEFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF2F0E9E6D6B9E7D6BEEDE4DCEDE5DDE4D9C6EBE3DCEDE7E0DDD7
                C6EDE6D9EAE4E1E2CEB4BEA470B99E6ADBBB8FC0A06CB19659C3BAA276BDEC47
                B4F0B1C1B5CFAC84DFD5C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFFFFFE
                FCFEFFFFFFFFF2F0E9EAD7B9EAD7BBF4EBDFF4EADEEBDDC6EFE8E0EDE8E3DCD6
                C7F0EBDFECE7E5E2CDB8C8AC7DBEA173DAB892C9A87AC09E62C9BA9F95C9EC77
                C2ECCAC7B2D2AD84DFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9EBD9BCECDABFDED4C8DDD4C8E6DAC3E3D6C6E4D6C5E7D8
                BEE4D5BFDED1C4E8D0B7DDC093D7B98CE6C39FDEBD90D5B784E0C597C7C0A1B9
                BBA3DDC7A4CEAF8CDFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E8D9BFE5D7C2E9E4DFE9E5E0E4DCCCEDE4DAF1E7DBE7DB
                C5F2E7D5F0E6DEE7D0B6C6AB79BFA36FDEBD93C6A674B59C67D7BE86C4A362BB
                9656DDBD8CCCB190DFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E4DBC3E4DAC7F1E9E5F1EBE6E4E0D0EDECE4EDEBE8DEDA
                D3EEEBE5EBEAE8E6D5BBCCB484C3AA7ADCC095CBAE7DBDA36FD3BD8EC3AA79C0
                9F6AE0C08DCEB28EDFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E2DBC5EADCC3E1CEB8DFCDB7E6DBC1E2D5B9DFCEB6E9D8
                C3E0CFBADCCCB1E7D3B1DAC29DD6BD96E4C9A0D9BE94D5B88FE3C59CD7BA90D2
                B68AE4C899CDB28DDFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E5D9CCEBD8BBCBB689C4AC7FE1CCAAD2B489CAA97CECCD
                A4D3B187CAAA7AE1C89CCBB189C2A77DDFC295CBAD7FC2A376DDBC90C7A87ABC
                9D6DE1C390CEB28DDFD4C8FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E8DACFEDDABDCFBA88CDB381E6CDA9D4B892C8AC85E5CC
                AAD4B794C7AD84DFC9A0CFB68EC5AA82E0C398D0B285C3A479DCBD91CDAF82BF
                A273E0C391CFB38EE0D5C9FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E4DBC7EEE0C5EDDABDEDDABDF3E5C8F0E3C6EEDFC6F3E2
                CEEADAC5E7D8BDF0DDBEEBD6B6E8D1AFEED6B2EAD0ABE3C9A5E7CDA8E3CAA4DF
                C79DE5CDA2CDB390E0D5C9FFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E6DEC9ECDFC4D4C1ABCBB8A2CCBFA0D1C3A2D3C1A5D3C0
                A4D6C4A7D5C3A1D5C2A0D6C29FD7C19ED6BE99D8C099DABE9ADABD97D8BB94D9
                BE96E4CCA4CCB391DFD5C9FFFFFFFFFFFEFEFEFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E9DCCFE2D2B2C0AA84D7BD9FD7BF9BD8BE99D8BC98DABD
                96DABD91DBBE8FD9BE8FD8BE90D9BD8FDBBC8FDEBD90DFBA8FE4BD90E4BD8DD5
                B385E1C59DCDB493DED5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E9DDCEE0D0B1D7C2A3FFECDBFFE7D3FFE6CAFDE3C4FADF
                BCFADEB7F5D9B0F5D6ABF4D3A6F1CEA2F4CFA3E0BA8FC7A076CCA477EAC493E2
                C092E2C69ECBB291DFD5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E9DDCEE0D1B4D4C0A6FFE9E0FAE4DAFAE4CFF9E1C8F6DE
                C1F6DCBBF2D9B5F6D6AFF6D2AAF4CEA6F1C9A1BF976FE1BA91D0A87BCEA777E3
                C092E0C49CCCB291DFD5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E9DED1DED1B5D2C3A6FFEFE1F8EADBF8E7D4FAE4CFF7E1
                C9F5DEC2F3DCBDF6D9B4F6D7AFF5D3ACEBC7A1AC8760CDA77ED9B183C59E6EE2
                BF91E0C49CCDB392DFD5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E9DED2E0D0B9D1C3A7FFF3E4F5F0DEFBEADAFDE6D5FBE3
                D0F8E0C9F6DDC4F6DCB9F4DBB1F3D8AFE7C99FB8986EDFBC95B7976CC1986AE2
                C093DDC49DCDB393DFD5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF1F0E9E6DECEDFCCB9D2C1A6FFF5EAF8F3E1FEEDE1FDEBDAFCE7
                D5FBE4D0F7E0CAF8DEC3F6DBBCF5D7B7F3D1AFC09A78E4BD99C1A77BD7AB7CE3
                C395D9C59DCFB293DED5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF1F0E9E0DDCFDCCDB3D9C2A3FFF8EFFFF4E3FFF3E4FDF2E0FCEF
                DBFBECD7F7E8D1FBE5C6FBE1BEFBDDB9FCDBB5E9C59ECCA277D1AC7DF2C99BDF
                BF92DEC599CFB391DED5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E0DCD1DACEB2CBBCA3E0F1FCE7EEF5EBEFEEEDEEE9EEED
                E7EDEBE2EDEAE1EAE5DBEAE3D6ECE2D5ECDFCFEEDDCDE6D9C6E6DBC8E2D9C5DE
                CDB0E5C99FCDB38EDED5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFFFFFCFEFFFE
                FCFFFFFFFFFFF2F0E9E6D9D3DBCEB5A6ACA867BBF666B9F55FB9FB61B8FE62B9
                FD64B9FC66BAFB69BDFA6DBEFA70BEF976C0FA7CC3FB84CAF697CAF29CD0EDC1
                CED1E3C9A9CBB48EDFD5C9FFFFFFFFFFFEFDFFFEFDFFFFFFFFFFFEFFFDFEFFFF
                FDFFFFFFFFFFF2F0EAE9DBD1D9CBB599A3A065B2E35EB0E456B2E35AB1E25CB2
                E25EB4E360B5E365B4E76AB4E96DB5E971B8E976BBEB72BEEB81BEEA8DC4E5B1
                C1C6D9C4ABCAB392E0D6C8FFFFFFFFFFFEFEFFFEFDFFFFFFFFFFFBFEFFFDFFFF
                FFFFFFFFFFFFF0EFEDE7DECCE0D3BA998D76A0947CA2967EA3967BA5997BA79B
                7EA99D7FAA9E80AB9F85AC9F86AEA287B3A78AB3A88AB5AA91BAAD96C1B196C3
                B090DCC5A2CAB193E0D8C7FEFFFFFFFDFFFFFEFDFFFFFEFFFFFFFBFEFFFDFFFF
                FFFFFFFFFFFFF0EEECE3D9C7EFE1CAE0D2BBDCCDB5DFCFB7E2D0BFE4D2C3E6D5
                C6EADACBEBDBCCECDBC7EBD8C0E9D6BCE8D4B7E3D0B2E3CCABE2C9A6E2C8A0E4
                C89FECCEA2C5AC90DCD6CBFFFFFFFFFDFFFEFEFEFEFFFEFFFFFFFBFEFFFDFFFF
                FFFFFFFFFFFEF6F4F2E2D9CDE4D9C9E9DECEEBE1D0EBE1D1EDE3D5EFE5D8F0E7
                DAF2EADDF2EBDEF4E8DCF3E5DAF1E3D5EEDFCFEBDECCE6D8C4E3D5C0E3D3BDE0
                D0B8DBC9B0C9B9AAECEAE3FCFFFDFFFEFFFEFFFFFDFFFFFFFFFFFBFEFFFDFFFF
                FEFFFFFEFEFDFFFEFCF8F6F2F6F3EEF6F3EFF6F4EFF5F4EFF1F3F0EFF3F0EFF3
                F0EFF3F0EFF3F0F0F1F1F1F1F2F0F1F2F0F2F1F0F2F0F4F3EFF6F4EFF6F4F0F6
                F5F1F5F3EFF9F6F4FEFFFDFBFEFBFFFEFFFDFFFFFCFFFFFFFFFFFBFEFFFDFFFF
                FDFEFEFDFCFCFEFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF
                FEFFFFFDFFFFFDFFFFFEFFFFFDFFFFFBFEFFFBFEFFFAFFFFFDFFFFFEFFFFFEFF
                FFFFFFFFFFFFFFFFFBFEFCFCFEFBFFFEFDFCFFFFFBFFFFFFFFFF}
              Layout = blGlyphTop
              ParentFont = False
              OnClick = sb_estoqueClick
              ExplicitTop = 8
            end
          end
          object Chbx_zerar_estoque: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 60
            Width = 263
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            ParentCustomHint = False
            Align = alTop
            BiDiMode = bdLeftToRight
            Caption = 'Zerar o estoque (n'#227'o recomend'#225'vel)'
            Color = clBtnFace
            Ctl3D = True
            DoubleBuffered = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBiDiMode = False
            ParentColor = False
            ParentCtl3D = False
            ParentDoubleBuffered = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 4
            OnClick = Chbx_zerar_estoqueClick
          end
          object Panel8: TPanel
            Left = 2
            Top = 97
            Width = 269
            Height = 49
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Panel8'
            TabOrder = 5
            object E_Dt_movim_Final: TDateTimePicker
              Left = 133
              Top = 19
              Width = 105
              Height = 22
              Date = 39580.999988425930000000
              Time = 39580.999988425930000000
              Enabled = False
              TabOrder = 0
            end
            object E_Dt_movim_Inicial: TDateTimePicker
              Left = 22
              Top = 19
              Width = 105
              Height = 22
              Date = 39580.000000000000000000
              Time = 39580.000000000000000000
              Enabled = False
              TabOrder = 1
            end
            object Chbx_Periodo_Movimento: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 263
              Height = 12
              Align = alTop
              Caption = 'Recontar produtos Movimentados neste per'#237'odo'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnClick = Chbx_Periodo_MovimentoClick
            end
          end
          object Chbx_LimparHistoricoEstoque: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 79
            Width = 263
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 1
            ParentCustomHint = False
            Align = alTop
            BiDiMode = bdLeftToRight
            Caption = 'Limpar todo o hist'#243'rico da movimenta'#231#227'o'
            Color = clBtnFace
            Ctl3D = True
            DoubleBuffered = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBiDiMode = False
            ParentColor = False
            ParentCtl3D = False
            ParentDoubleBuffered = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 6
            OnClick = Chbx_LimparHistoricoEstoqueClick
          end
        end
        object Dbg_Inventario: TDBGrid
          Left = 0
          Top = 0
          Width = 215
          Height = 378
          Align = alLeft
          DataSource = Ds_Inventario
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnKeyDown = Dbg_InventarioKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'IVT_DATA'
              Title.Caption = 'Data Invent'#225'rio'
              Width = 115
              Visible = True
            end>
        end
      end
      object tbs_Ordenacao: TTabSheet
        Caption = 'Ordena'#231#227'o'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 488
          Height = 378
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label6: TLabel
            Left = 5
            Top = 4
            Width = 53
            Height = 13
            Caption = 'Ordena'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object CB_Ordena: TComboBox
            Left = 5
            Top = 18
            Width = 221
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'DESCRI'#199#195'O'
            Items.Strings = (
              'DESCRI'#199#195'O'
              'C'#211'DIGO F'#193'BRICA'
              'C'#211'DIGO INTERNO')
          end
        end
      end
    end
  end
  object TPanel
    Left = 0
    Top = 458
    Width = 764
    Height = 60
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 679
      Top = 5
      Width = 80
      Height = 50
      Margins.Left = 0
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
      ExplicitLeft = 668
      ExplicitTop = 3
      ExplicitHeight = 54
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 599
      Top = 5
      Width = 80
      Height = 50
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Imprimir - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitTop = 6
    end
    object Sb_Exportar: TSpeedButton
      AlignWithMargins = True
      Left = 519
      Top = 5
      Width = 80
      Height = 50
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
      Caption = 'Exportar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ExportarClick
      ExplicitTop = 6
    end
    object Pnl_Progresso: TPanel
      Left = 4
      Top = 4
      Width = 476
      Height = 42
      TabOrder = 0
      Visible = False
      object Gg_Progresso: TGauge
        Left = 1
        Top = 1
        Width = 474
        Height = 23
        Align = alTop
        Progress = 0
        ExplicitLeft = 0
        ExplicitWidth = 480
      end
      object Lb_Processamento: TLabel
        Left = 3
        Top = 26
        Width = 84
        Height = 14
        Caption = 'Processamento...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 264
    Height = 410
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label11: TLabel
      Left = 4
      Top = 3
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBx_TipoRelatorio: TListBox
      Left = 2
      Top = 19
      Width = 260
      Height = 389
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 14
      Items.Strings = (
        'CADASTRO DE PRODUTOS'
        'SALDO DO ESTOQUE'
        'MOVIMENTA'#199#195'O'
        'TABELA DE PRODUTOS'
        'CURVA ABC'
        'INVENTARIO'
        'AN'#193'LISE DE ALTERA'#199#195'O DE PRE'#199'O NA COMPRA'
        'PRODUTOS MAIS VENDIDOS'
        'REPOSI'#199#195'O'
        'CONFERENCIA DE ESTOQUE'
        'AN'#193'LISE DE ALTERA'#199#195'O DE PRE'#199'O NA VENDA'
        'INVENT'#193'RIO - FORMATO CODILHEIRA - EXPORTAR'
        'INVENTARIO - FORMATO ENCADERNA'#199#195'O'
        'VENDAS POR ITEM'
        'CADASTRO DE SERVI'#199'OS'
        'EXPORTAR TABELAS DE PRE'#199'O'
        'EXPORTAR - AN'#193'LISE DE COMPRA'
        'PRODUTOS MAIS VENDIDOS POR VENDEDOR'
        'PRODUTOS VENDIDOS POR MARCA'
        'LUCRATIVIDADE'
        'ARQUIVO - BALAN'#199'A TOLEDO'
        'ARQUIVO - BALAN'#199'A FILIZOLA'
        'RESULTADO PRODUTOS'
        'TERMINAL DE PRE'#199'O'
        'VENDAS POR ITEM / LUCRO BRUTO'
        'SALDO DE ESTOQUE E MOVIMENTO POR PERIODO')
      TabOrder = 0
      OnClick = LBx_TipoRelatorioClick
    end
  end
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 764
    Height = 48
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 764
    ExplicitHeight = 48
    inherited pnl_linha_1: TPanel
      Width = 764
      ExplicitWidth = 764
      inherited Sb_open: TSpeedButton
        Left = 740
        ExplicitLeft = 740
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 740
        ExplicitWidth = 740
      end
    end
    inherited pnl_top: TPanel
      Width = 764
      ExplicitWidth = 764
      inherited L_name_list: TLabel
        Width = 741
      end
    end
  end
  object Qr_Tabela: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT TB_PRODUTO.PRO_CODIGO, TB_PRODUTO.PRO_DESCRICAO, '
      'TB_PRODUTO.PRO_CODGRUPO, TB_PRODUTO.PRO_CODSUBGRUPO, '
      
        'TB_PRODUTO.PRO_VLVENDA, TB_PRODUTO.PRO_VLVENDA_2,TB_PRODUTO.PRO_' +
        'VLVENDA_3,TB_PRODUTO.PRO_VLVENDA_4,TB_GRUPOS.GRU_DESCRI, '
      'TB_SUBGRUPOS.SUB_DESCR'
      'FROM TB_GRUPOS TB_GRUPOS'
      'INNER JOIN TB_SUBGRUPOS TB_SUBGRUPOS '
      'ON  (TB_SUBGRUPOS.SUB_CODGRUPO = TB_GRUPOS.GRU_CODIGO) '
      'INNER JOIN TB_PRODUTO TB_PRODUTO '
      'ON  (TB_PRODUTO.PRO_CODSUBGRUPO = TB_SUBGRUPOS.SUB_CODIGO)'
      ''
      ''
      ''
      '')
    Left = 256
    Top = 336
  end
  object Ds_Empresas: TDataSource
    DataSet = DM.Qr_Empresas
    Left = 224
    Top = 300
  end
  object Qr_Produto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGO, EST_CODETS'
      'FROM TB_PRODUTO'
      'WHERE PRO_TIPO = '#39'P'#39
      'ORDER BY PRO_CODIGO')
    Left = 200
    Top = 365
  end
  object Qr_Estoque: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_ESTOQUE'
      'SET EST_QTDE=:EST_QTDE'
      'WHERE EST_CODPRO =:EST_CODPRO AND EST_CODETS=:EST_CODETS')
    Left = 248
    Top = 373
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EST_QTDE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EST_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EST_CODETS'
        ParamType = ptUnknown
      end>
  end
  object Qr_Invetario: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT IVT_CODIGO,IVT_DATA'
      'FROM TB_INVENTARIO'
      'WHERE IVT_CODMHA =:IVT_CODMHA'
      'ORDER BY IVT_DATA')
    Left = 352
    Top = 308
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IVT_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Ds_Inventario: TDataSource
    DataSet = Qr_Invetario
    Left = 336
    Top = 356
  end
  object Qr_Del_Inventario: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'DELETE'
      'FROM TB_INVENTARIO'
      'WHERE IVT_DATA=:IVT_DATA')
    Left = 400
    Top = 428
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IVT_DATA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'DELETE'
      'FROM TB_INVENTARIO'
      'WHERE IVT_DATA=:IVT_DATA')
    Left = 472
    Top = 428
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IVT_DATA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Movim_Custo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT                                        '
      '  PED_TIPO,'
      '  NFL_TIPO,'
      '  ITF_VL_UNIT,'
      '  ITF_QTDE,                                   '
      '  ITF_VL_CUSTO,                               '
      '  ITF_VL_DESC,                                '
      '  ICM_VL_BC_NR ,                              '
      '  ICM_AQ_NR,                                  '
      '  ICM_VL_ST,                                  '
      '  ICM_VL_FRETE,                               '
      '  ICM_VL_SEGURO,                              '
      '  ICM_VL_OUTRAS,                              '
      '  (IPI_VL_BC * (IPI_AQ_NR/100)) IPI_VL_IPI,   '
      '  ITF_CODPRO'
      'FROM TB_ITENS_NFL Itens                       '
      '  INNER JOIN tb_nota_fiscal nota'
      '  ON (nota.NFL_CODIGO = itens.ITF_CODNFL)'
      '  INNER JOIN tb_pedido pedido'
      '  ON (pedido.PED_CODIGO = nota.NFL_CODPED)'
      '  INNER JOIN TB_PRODUTO produto'
      '  ON (produto.PRO_CODIGO = itens.ITF_CODPRO)  '
      '  LEFT OUTER JOIN TB_ITENS_ICMS icms'
      '  ON (icms.ICM_CODITF = itens.ITF_CODIGO )    '
      '  LEFT OUTER JOIN TB_ITENS_IPI ipi            '
      '  ON (ipi.IPI_CODITF = itens.ITF_CODIGO )     '
      'WHERE ( ITF_CODPRO=:PRO_CODIGO )'
      '      AND ( NFL_DT_EMISSAO>=:NFL_DT_EMISSAO)'
      '     AND ( ITF_ESTOQUE = '#39'S'#39')'
      'ORDER BY NFL_DT_EMISSAO, NFL_TIPO')
    Left = 168
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_DT_EMISSAO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Up_Custo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Estoque
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'UPDATE TB_PRODUTO SET                 '
      'PRO_VL_CUSTOANT          = :PRO_VL_CUSTOANT,'
      'PRO_VL_CUSTO                 = :PRO_VL_CUSTO,   '
      'PRO_VL_CUSTOMEDANT  = :PRO_VL_CUSTOMEDANT,'
      'PRO_VL_CUSTOMED         = :PRO_VL_CUSTOMED '
      'WHERE (PRO_CODIGO      = :PRO_CODIGO) ')
    Left = 224
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_VL_CUSTOANT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_VL_CUSTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_VL_CUSTOMEDANT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_VL_CUSTOMED'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
end

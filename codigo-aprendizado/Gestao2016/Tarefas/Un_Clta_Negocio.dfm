object Fr_Clta_Negocio: TFr_Clta_Negocio
  Left = 210
  Top = 60
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'An'#225'lise de Neg'#243'cios'
  ClientHeight = 600
  ClientWidth = 851
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
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
    Width = 851
    Height = 103
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 59
      Width = 64
      Height = 14
      Caption = 'C'#243'd Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Empresa: TSpeedButton
      Left = 498
      Top = 76
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_EmpresaClick
    end
    object Label15: TLabel
      Left = 525
      Top = 61
      Width = 40
      Height = 14
      Caption = 'Meg'#243'cio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Negocio: TSpeedButton
      Left = 820
      Top = 76
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_NegocioClick
    end
    object E_Data_Ini_NFL: TDateTimePicker
      Left = 687
      Top = 33
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 4
    end
    object E_Data_Fim_NFL: TDateTimePicker
      Left = 768
      Top = 33
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 5
    end
    object ChBx_Periodo_Geral: TCheckBox
      Left = 687
      Top = 18
      Width = 128
      Height = 12
      TabStop = False
      Caption = 'Data Inicial   Data Final'
      TabOrder = 3
      OnClick = ChBx_Periodo_GeralClick
    end
    object E_Busca_Cd_Empresa: TMaskEdit
      Left = 4
      Top = 76
      Width = 98
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
      OnExit = E_Busca_Cd_EmpresaExit
    end
    object Rg_TipoMovimentacao: TRadioGroup
      Left = 6
      Top = 14
      Width = 249
      Height = 42
      Caption = 'Tipo de movimenta'#231#227'o'
      Columns = 4
      ItemIndex = 3
      Items.Strings = (
        'Compra'
        'Venda'
        'Ajuste'
        'Todos')
      TabOrder = 0
      OnClick = Rg_TipoMovimentacaoClick
    end
    object Rg_SentidoMovimento: TRadioGroup
      Left = 256
      Top = 14
      Width = 182
      Height = 42
      Caption = 'Sentido da Movimenta'#231#227'o'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Entrada'
        'Sa'#237'da'
        'Todos')
      TabOrder = 1
    end
    object Rg_TipoEmpresa: TRadioGroup
      Left = 438
      Top = 14
      Width = 246
      Height = 42
      Caption = 'Tipo da Empresa'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Fornecedor'
        'Cliente'
        'Todos')
      TabOrder = 2
      OnClick = Rg_TipoEmpresaClick
    end
    object ChBx_Nome: TCheckBox
      Left = 104
      Top = 59
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 7
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 231
      Top = 59
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = ChBx_FantasiaClick
    end
    object Cb_Busca_Empresa: TComboBox
      Left = 105
      Top = 76
      Width = 390
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
    end
    object Dblcb_Negocio: TDBLookupComboBox
      Left = 525
      Top = 76
      Width = 294
      Height = 22
      DataField = 'PED_CODNEG'
      KeyField = 'NEG_CODIGO'
      ListField = 'NEG_DESCRICAO'
      ListSource = DM.Ds_Negocio
      TabOrder = 10
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 531
    Width = 851
    Height = 69
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      851
      69)
    object SB_Sair_0: TSpeedButton
      Left = 757
      Top = 10
      Width = 88
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- ESC'
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
    object SB_Buscar: TSpeedButton
      Left = 668
      Top = 10
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
    end
  end
  object Pg_Informacao: TPageControl
    Left = 0
    Top = 103
    Width = 851
    Height = 428
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Estoque'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 843
        Height = 49
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label14: TLabel
          Left = 635
          Top = 4
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
        object DBLCB_Marca: TDBLookupComboBox
          Left = 632
          Top = 19
          Width = 204
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
        inline Fm_ListaProdutos: TFm_ListaProdutos
          Left = 159
          Top = 3
          Width = 471
          Height = 43
          TabOrder = 1
          ExplicitLeft = 159
          ExplicitTop = 3
          ExplicitWidth = 471
          inherited Label3: TLabel
            Left = 91
            ExplicitLeft = 91
          end
          inherited Sb_Produto: TSpeedButton
            Left = 445
            ExplicitLeft = 445
          end
          inherited E_Cd_Produto: TMaskEdit
            Width = 81
            ExplicitWidth = 81
          end
          inherited E_Busca_Produto: TEdit
            Left = 87
            Width = 355
            ExplicitLeft = 87
            ExplicitWidth = 355
          end
        end
        inline Fm_ListaEstoques: TFm_ListaEstoques
          Left = 3
          Top = 5
          Width = 158
          Height = 36
          TabOrder = 2
          ExplicitLeft = 3
          ExplicitTop = 5
          ExplicitWidth = 158
          inherited Label1: TLabel
            Width = 153
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 135
            ExplicitLeft = 135
          end
          inherited Dblcb_Estoque: TDBLookupComboBox
            Width = 154
            ExplicitWidth = 154
          end
          inherited ChBx_Estoques: TCheckBox
            Left = 113
            Visible = False
            ExplicitLeft = 113
          end
        end
      end
      object Pg_Estoque: TPageControl
        Left = 0
        Top = 49
        Width = 843
        Height = 351
        ActivePage = TabSheet3
        Align = alClient
        TabOrder = 1
        object TabSheet3: TTabSheet
          Caption = 'Movimento'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DBG_Movimento: TDBGrid
            Left = 0
            Top = 0
            Width = 835
            Height = 265
            Align = alClient
            Color = clCream
            DataSource = Ds_PesquisaEstoque
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
            OnTitleClick = DBG_MovimentoTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'NFL_OPERACAO'
                Title.Caption = 'Opera'#231#227'o'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NFL_DT_EMISSAO'
                Title.Caption = 'Data'
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
                FieldName = 'NFL_NUMERO'
                Title.Caption = 'Nota Fiscal'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PED_NUMERO'
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
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'C'#243'digo Produto'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 85
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o do Produto'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 321
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_QTDE'
                Title.Caption = 'Quantidade'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 66
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITF_VL_UNIT'
                Title.Caption = 'Valor Unit'#225'rio'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 82
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITV_SUBTOTAL'
                Title.Caption = 'Valor Subtotal'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 87
                Visible = True
              end>
          end
          object Panel1: TPanel
            Left = 0
            Top = 265
            Width = 835
            Height = 58
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              835
              58)
            object GroupBox3: TGroupBox
              Left = 3
              Top = 0
              Width = 280
              Height = 58
              Anchors = [akLeft]
              Caption = 'Totalizador Compras'
              TabOrder = 0
              DesignSize = (
                280
                58)
              object Lb_Faturamento: TLabel
                Left = 7
                Top = 16
                Width = 53
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Realizadas'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label4: TLabel
                Left = 127
                Top = 16
                Width = 28
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'M'#233'dia'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label7: TLabel
                Left = 65
                Top = 16
                Width = 55
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Quantidade'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 189
                Top = 16
                Width = 50
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Valor Total'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object E_Cpa_Realizada: TEdit_Setes
                Left = 5
                Top = 31
                Width = 55
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 0
                Text = ''
              end
              object E_Cpa_Media: TEdit_Setes
                Left = 123
                Top = 31
                Width = 61
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 1
                Text = ''
              end
              object E_Cpa_Qtde: TEdit_Setes
                Left = 62
                Top = 31
                Width = 60
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 2
                Text = ''
              end
              object E_Cpa_Valor: TEdit_Setes
                Left = 186
                Top = 31
                Width = 89
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 3
                Text = ''
              end
            end
            object GroupBox4: TGroupBox
              Left = 285
              Top = 0
              Width = 280
              Height = 58
              Anchors = [akLeft]
              Caption = 'Totalizador Vendas'
              TabOrder = 1
              DesignSize = (
                280
                58)
              object Label3: TLabel
                Left = 7
                Top = 16
                Width = 53
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Realizadas'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel
                Left = 127
                Top = 16
                Width = 28
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'M'#233'dia'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 65
                Top = 16
                Width = 55
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Quantidade'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label9: TLabel
                Left = 189
                Top = 16
                Width = 50
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Valor Total'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object E_Vda_Realizada: TEdit_Setes
                Left = 5
                Top = 31
                Width = 55
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 0
                Text = ''
              end
              object E_Vda_Media: TEdit_Setes
                Left = 123
                Top = 31
                Width = 61
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 1
                Text = ''
              end
              object E_Vda_Qtde: TEdit_Setes
                Left = 62
                Top = 31
                Width = 60
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 2
                Text = ''
              end
              object E_Vda_Valor: TEdit_Setes
                Left = 186
                Top = 31
                Width = 89
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 3
                Text = ''
              end
            end
            object GroupBox5: TGroupBox
              Left = 567
              Top = 0
              Width = 280
              Height = 58
              Anchors = [akLeft]
              Caption = 'Totalizador Ajustes'
              TabOrder = 2
              DesignSize = (
                280
                58)
              object Label10: TLabel
                Left = 7
                Top = 16
                Width = 53
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Realizadas'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label11: TLabel
                Left = 127
                Top = 16
                Width = 28
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'M'#233'dia'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label12: TLabel
                Left = 65
                Top = 16
                Width = 55
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Quantidade'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object Label13: TLabel
                Left = 189
                Top = 16
                Width = 50
                Height = 14
                Anchors = [akLeft, akBottom]
                Caption = 'Valor Total'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object E_Ajt_Realizada: TEdit_Setes
                Left = 5
                Top = 31
                Width = 55
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 0
                Text = ''
              end
              object E_Ajt_Media: TEdit_Setes
                Left = 123
                Top = 31
                Width = 61
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 1
                Text = ''
              end
              object E_Ajt_Qtde: TEdit_Setes
                Left = 62
                Top = 31
                Width = 60
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 2
                Text = ''
              end
              object E_Ajt_Valor: TEdit_Setes
                Left = 186
                Top = 31
                Width = 88
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft, akBottom]
                ReadOnly = True
                TabOrder = 3
                Text = ''
              end
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Saldo'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Dbg_Saldo: TDBGrid
            Left = 0
            Top = 0
            Width = 835
            Height = 323
            Align = alClient
            Color = clCream
            DataSource = Ds_PesquisaSaldo
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnTitleClick = Dbg_SaldoTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'PRO_CODIGO'
                Title.Caption = 'C'#243'digo'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'Fabrica'#231#227'o'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 114
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
                Width = 480
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EST_QTDE'
                Title.Caption = 'Saldo'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 92
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Movimento Financeiro'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 843
        Height = 49
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Rg_Data: TRadioGroup
          Left = 181
          Top = 3
          Width = 167
          Height = 38
          Caption = 'Tipo de Data'
          Columns = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Vencimento'
            'Pagamento')
          ParentFont = False
          TabOrder = 0
        end
        object E_Data_Ini_FIN: TDateTimePicker
          Left = 5
          Top = 19
          Width = 85
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 1
        end
        object E_Data_Fim_FIN: TDateTimePicker
          Left = 92
          Top = 19
          Width = 86
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 2
        end
        object ChBx_Periodo_Financeiro: TCheckBox
          Left = 5
          Top = 5
          Width = 138
          Height = 12
          Caption = 'Data Inicial    Data Final'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = ChBx_Periodo_FinanceiroClick
        end
        object Rg_Situacao: TRadioGroup
          Left = 352
          Top = 3
          Width = 231
          Height = 38
          Caption = 'Situa'#231#227'o '
          Columns = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Pendentes'
            'Baixadas'
            'Todas')
          ParentFont = False
          TabOrder = 4
        end
        object RG_Financeiro: TRadioGroup
          Left = 585
          Top = 2
          Width = 253
          Height = 38
          Caption = 'Financeiro'
          Columns = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #192' Receber'
            'A Pagar'
            'Todos')
          ParentFont = False
          TabOrder = 5
          TabStop = True
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 342
        Width = 843
        Height = 58
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          843
          58)
        object GroupBox6: TGroupBox
          Left = 3
          Top = 0
          Width = 280
          Height = 58
          Anchors = [akLeft]
          Caption = 'Totalizador Contas a Pagar'
          TabOrder = 0
          DesignSize = (
            280
            58)
          object Label16: TLabel
            Left = 95
            Top = 16
            Width = 65
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor '#224' Pagar'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 186
            Top = 16
            Width = 52
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor Pago'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 4
            Top = 16
            Width = 50
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_VL_Pagar: TEdit_Setes
            Left = 93
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
          object E_VL_Pago: TEdit_Setes
            Left = 183
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 1
            Text = ''
          end
          object E_VL_Tl_Pagar: TEdit_Setes
            Left = 2
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 2
            Text = ''
          end
        end
        object GroupBox7: TGroupBox
          Left = 285
          Top = 0
          Width = 280
          Height = 58
          Anchors = [akLeft]
          Caption = 'Totalizador Contas '#224' Receber'
          TabOrder = 1
          DesignSize = (
            280
            58)
          object Label17: TLabel
            Left = 95
            Top = 16
            Width = 78
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor '#224' Receber'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 186
            Top = 16
            Width = 73
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor Recebido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 4
            Top = 16
            Width = 50
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Valor Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_VL_Receber: TEdit_Setes
            Left = 93
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
          object E_VL_Recebido: TEdit_Setes
            Left = 183
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 1
            Text = ''
          end
          object E_VL_TL_Receber: TEdit_Setes
            Left = 2
            Top = 31
            Width = 90
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 2
            Text = ''
          end
        end
        object GroupBox8: TGroupBox
          Left = 567
          Top = 0
          Width = 280
          Height = 58
          Anchors = [akLeft]
          Caption = 'Totalizador Financeiro'
          TabOrder = 2
          DesignSize = (
            280
            58)
          object Label27: TLabel
            Left = 160
            Top = 16
            Width = 64
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = 'Saldo Liquido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_VL_Saldo_Liquido: TEdit_Setes
            Left = 159
            Top = 31
            Width = 115
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
        end
      end
      object Dbg_Financeiro: TDBGrid
        Left = 0
        Top = 49
        Width = 843
        Height = 293
        Align = alClient
        Color = clCream
        DataSource = Ds_PesquisaFinanceiro
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnTitleClick = Dbg_FinanceiroTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'FIN_FINANCEIRO'
            Title.Caption = 'Opera'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_DT_VENCIMENTO'
            Title.Caption = 'Vencimento'
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
            FieldName = 'NFL_NUMERO'
            Title.Caption = 'Nota Fiscal'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMP_FANTASIA'
            Title.Caption = 'Empresa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 337
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_VL_PARCELA'
            Title.Caption = 'Valor Parcela'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIN_VL_PAGO'
            Title.Caption = 'Valor Pago'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 82
            Visible = True
          end>
      end
    end
  end
  object Qr_PesquisaEstoque: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_PesquisaEstoqueCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      'PED_TIPO,'
      'NFL_NUMERO,'
      'PED_NUMERO,'
      'NFL_DT_EMISSAO, '
      'NFL_TIPO,'
      'NFL_STATUS,'
      'PRO_CODIGOFAB,'
      'PRO_DESCRICAO,'
      'ITF_QTDE, '
      'ITF_VL_UNIT, '
      '(ITF_QTDE* ITF_VL_UNIT) as ITV_SUBTOTAL'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal '
      '    INNER JOIN TB_EMPRESA tb_cliente'
      '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '
      ''
      '    INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '
      ''
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '
      ''
      '    INNER JOIN TB_PRODUTO tb_produto'
      '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '
      ''
      '    LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn'
      '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO)'
      ''
      '    LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor'
      '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO)'
      'WHERE (PRO_CODIGO = 0)')
    Left = 576
    Top = 232
  end
  object Ds_PesquisaEstoque: TDataSource
    DataSet = Qr_PesquisaEstoque
    Left = 576
    Top = 264
  end
  object Qr_PesquisaFinanceiro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_PesquisaFinanceiroCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT DISTINCT    FIN_CODIGO,    NFL_NUMERO,    PED_NUMERO,    ' +
        'FIN_NUMERO,    FIN_DT_VENCIMENTO,    FIN_NR_PARCELA,    FIN_CODE' +
        'MP,    EMP_FANTASIA,    EMP_NOME,    FIN_VL_PARCELA,    FIN_BAIX' +
        'A,     FIN_SITUACAO,    FIN_VL_PAGO,     FIN_CODQTC,     FIN_COD' +
        'FPG,     PED_CODIGO,     NFL_CODIGO,     FIN_TIPO,     FIN_DT_PA' +
        'GTO,    FIN_OPERACAO,    FIN_ETAPA,       FIN_CODMHA,    FIN_COD' +
        'CHQ'
      'FROM    TB_FINANCEIRO tb_financeiro  '
      '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal    '
      '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)   '
      '   LEFT OUTER JOIN TB_PEDIDO tb_pedido    '
      '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)  '
      '   INNER JOIN TB_EMPRESA tb_empresa    '
      '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)  '
      'WHERE FIN_CODIGO IS NOT NULL ')
    Left = 616
    Top = 232
  end
  object Ds_PesquisaFinanceiro: TDataSource
    DataSet = Qr_PesquisaFinanceiro
    Left = 616
    Top = 264
  end
  object Qr_PesquisaSaldo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_PesquisaEstoqueCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      'PRO_CODIGO,'
      'PRO_CODIGOFAB,'
      'PRO_DESCRICAO,'
      'EST_QTDE'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal '
      '    INNER JOIN TB_EMPRESA tb_cliente'
      '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '
      ''
      '    INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) '
      ''
      '    INNER JOIN TB_PEDIDO tb_pedido'
      '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '
      ''
      '    INNER JOIN TB_PRODUTO tb_produto'
      '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '
      ''
      '   INNER JOIN TB_ESTOQUE tb_estoque'
      '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)'
      ''
      '    LEFT OUTER JOIN TB_PROD_FORN Tb_prod_forn'
      '    ON  (Tb_prod_forn.PFR_CODPRO = Tb_produto.PRO_CODIGO)'
      ''
      '    LEFT OUTER JOIN  TB_EMPRESA Tb_fornecedor'
      '    ON  (Tb_prod_forn.PFR_CODFOR = Tb_fornecedor.EMP_CODIGO)'
      'WHERE (PRO_CODIGO = 0)')
    Left = 656
    Top = 232
  end
  object Ds_PesquisaSaldo: TDataSource
    DataSet = Qr_PesquisaSaldo
    Left = 656
    Top = 264
  end
end

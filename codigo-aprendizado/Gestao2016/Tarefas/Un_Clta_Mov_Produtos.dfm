object Fr_Clta_Mov_Produtos: TFr_Clta_Mov_Produtos
  Left = 222
  Top = 34
  Anchors = [akTop, akBottom]
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'An'#225'lise movimenta'#231#227'o produtos'
  ClientHeight = 599
  ClientWidth = 855
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
    Top = 57
    Width = 855
    Height = 146
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label14: TLabel
      Left = 521
      Top = 100
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
    object E_Data_Ini: TDateTimePicker
      Left = 687
      Top = 33
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 3
    end
    object E_Data_Fim: TDateTimePicker
      Left = 768
      Top = 33
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 4
    end
    object ChBx_Periodo: TCheckBox
      Left = 687
      Top = 18
      Width = 128
      Height = 12
      TabStop = False
      Caption = 'Data Inicial   Data Final'
      TabOrder = 2
      OnClick = ChBx_PeriodoClick
    end
    object Rg_SentidoMovimento: TRadioGroup
      Left = 257
      Top = 9
      Width = 182
      Height = 42
      Caption = 'Sentido da Movimenta'#231#227'o'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Entrada'
        'Sa'#237'da'
        'Todos')
      TabOrder = 0
    end
    object Rg_TipoEmpresa: TRadioGroup
      Left = 435
      Top = 9
      Width = 246
      Height = 42
      Caption = 'Tipo da Empresa'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Fornecedor'
        'Cliente'
        'Todos')
      TabOrder = 1
      OnClick = Rg_TipoEmpresaClick
    end
    object DBLCB_Marca: TDBLookupComboBox
      Left = 520
      Top = 115
      Width = 329
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
      TabOrder = 5
      OnKeyDown = DBLCB_MarcaKeyDown
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 4
      Top = 99
      Width = 514
      Height = 43
      TabOrder = 6
      ExplicitLeft = 4
      ExplicitTop = 99
      ExplicitWidth = 514
      inherited Sb_Produto: TSpeedButton
        Left = 487
        ExplicitLeft = 487
      end
      inherited E_Busca_Produto: TEdit
        Width = 382
        ExplicitWidth = 382
      end
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 4
      Top = 57
      Width = 569
      Height = 43
      TabOrder = 7
      ExplicitLeft = 4
      ExplicitTop = 57
      ExplicitWidth = 569
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 569
        ExplicitWidth = 569
        inherited ChBx_Nome: TCheckBox
          Left = 42
          ExplicitLeft = 42
          ExplicitTop = 1
          ExplicitHeight = 14
        end
        inherited ChBx_Fantasia: TCheckBox
          Left = 168
          ExplicitLeft = 168
          ExplicitHeight = 14
        end
      end
      inherited pnl_02: TPanel
        Width = 569
        ExplicitWidth = 569
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 541
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 516
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitLeft = 1
          ExplicitTop = 1
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 448
          ExplicitLeft = 66
          ExplicitTop = 1
          ExplicitWidth = 448
        end
      end
    end
    object ChBx_Canceladas: TCheckBox
      Left = 696
      Top = 79
      Width = 151
      Height = 17
      Caption = 'Mostrar Notas Canceladas'
      TabOrder = 8
    end
    object ChBx_PedidoPendente: TCheckBox
      Left = 696
      Top = 61
      Width = 151
      Height = 17
      Caption = 'Mostrar Pedidos Pendentes'
      TabOrder = 9
      OnClick = ChBx_PedidoPendenteClick
    end
    object Rg_Tipo_Nota: TGroupBox
      Left = 3
      Top = 10
      Width = 248
      Height = 42
      Caption = 'Tipo de Notas'
      TabOrder = 10
      object ChBx_Vendas: TCheckBox
        Left = 9
        Top = 18
        Width = 65
        Height = 17
        Caption = 'Vendas'
        TabOrder = 0
      end
      object ChBx_Compras: TCheckBox
        Left = 80
        Top = 18
        Width = 62
        Height = 17
        Caption = 'Compras'
        TabOrder = 1
      end
      object ChBx_Ajustes: TCheckBox
        Left = 162
        Top = 18
        Width = 62
        Height = 17
        Caption = 'Ajustes'
        TabOrder = 2
      end
    end
  end
  object GroupBox2: TPanel
    Left = 0
    Top = 530
    Width = 855
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 762
      Top = 5
      Width = 88
      Height = 59
      Margins.Left = 0
      Align = alRight
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
      ExplicitLeft = 766
      ExplicitTop = 6
      ExplicitHeight = 61
    end
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 582
      Top = 5
      Width = 88
      Height = 59
      Margins.Left = 0
      Margins.Right = 0
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
      OnClick = SB_BuscarClick
      ExplicitLeft = 587
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Visualizar: TSpeedButton
      AlignWithMargins = True
      Left = 670
      Top = 5
      Width = 92
      Height = 59
      Margins.Left = 0
      Margins.Right = 0
      Align = alRight
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
      ExplicitLeft = 669
      ExplicitTop = 10
      ExplicitHeight = 54
    end
    object Sb_Exportar: TSpeedButton
      AlignWithMargins = True
      Left = 494
      Top = 5
      Width = 88
      Height = 59
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
      ExplicitLeft = 493
      ExplicitTop = 10
      ExplicitHeight = 54
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 855
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      855
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
  inline Fm_LME: TFm_ListaMultiEmpresa
    Left = 0
    Top = 0
    Width = 855
    Height = 57
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 855
    ExplicitHeight = 57
    inherited pnl_linha_1: TPanel
      Width = 855
      ExplicitWidth = 855
      inherited Sb_open: TSpeedButton
        Left = 831
        ExplicitLeft = 831
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 831
        ExplicitWidth = 831
      end
    end
    inherited pnl_top: TPanel
      Width = 855
    end
  end
  object Pg_Resultado: TPageControl
    Left = 0
    Top = 203
    Width = 855
    Height = 269
    ActivePage = tbs_PEdido
    Align = alClient
    TabOrder = 4
    object tbs_PEdido: TTabSheet
      Caption = 'tbs_PEdido'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Dbg_Pedidos: TDBGrid
        Left = 0
        Top = 0
        Width = 847
        Height = 241
        Align = alClient
        Color = clCream
        DataSource = Ds_Pedidos
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
        OnDblClick = Dbg_PedidosDblClick
        OnTitleClick = Dbg_PedidosTitleClick
        Columns = <
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
            FieldName = 'ITF_ESTOQUE'
            Title.Caption = 'Estoque'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PED_DATA'
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
            FieldName = 'PRO_CODIGOFAB'
            Title.Caption = 'C'#243'digo Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 138
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITEM_DESCRICAO'
            Title.Caption = 'Descri'#231#227'o do Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 360
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
            Width = 84
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
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Empresa'
            Visible = True
          end>
      end
    end
    object tbs_Nota: TTabSheet
      Caption = 'tbs_Nota'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBG_Notas: TDBGrid
        Left = 0
        Top = 0
        Width = 847
        Height = 241
        Align = alClient
        Color = clCream
        DataSource = Ds_Notas
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
        OnDblClick = DBG_NotasDblClick
        OnTitleClick = DBG_NotasTitleClick
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
            FieldName = 'ITF_ESTOQUE'
            Title.Caption = 'Estoque'
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
            FieldName = 'NFL_NUMERO'
            Title.Caption = 'Nota Fiscal'
            Width = 80
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
            FieldName = 'PRO_CODIGOFAB'
            Title.Caption = 'C'#243'digo Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 138
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITEM_DESCRICAO'
            Title.Caption = 'Descri'#231#227'o do Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 360
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
            Width = 84
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
          end
          item
            Expanded = False
            FieldName = 'EMP_NOME'
            Title.Caption = 'Empresa'
            Visible = True
          end>
      end
    end
  end
  object Qr_Notas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    OnCalcFields = Qr_NotasCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT PED_TIPO, NFL_DT_EMISSAO, NFL_STATUS, NFL_TIPO,PRO_CODIGO' +
        'FAB,PRO_DESCRICAO,'
      
        'ITF_QTDE,ITF_VL_UNIT,CAST(((ITF_QTDE * ITF_VL_UNIT) - itf_vl_d' +
        'esc) AS DOUBLE PRECISION) as ITV_SUBTOTAL,NFL_CODIGO, NFL_MODELO,'
      
        'PED_NUMERO, EMP_CODIGO,EMP_NOME, EMP_FANTASIA,NFL_NUMERO, END_FO' +
        'NE,END_FAX,END_CELULAR,END_COMERCIAL ,'
      'ITF_ESTOQUE, IAV_DESCRICAO'
      'FROM TB_NOTA_FISCAL nf'
      '    INNER JOIN TB_EMPRESA cl'
      '    ON (cl.EMP_CODIGO = nf.NFL_CODEMP)'
      '    INNER JOIN TB_PEDIDO pd'
      '    ON (pd.PED_CODIGO = nf.NFL_CODPED)'
      '   INNER JOIN TB_ENDERECO en'
      '   ON (en.END_CODEMP = pd.PED_CODEND)'
      '    INNER JOIN TB_ITENS_NFL it'
      '    ON (it.ITF_CODPED = pd.ped_CODIGO)'
      '    INNER JOIN TB_PRODUTO pr'
      '    ON (pr.PRO_CODIGO = it.ITF_CODPRO)'
      '  LEFT OUTER  JOIN TB_ITENS_AVL'
      '  ON (IAV_CODITF = ITF_CODIGO)'
      'WHERE (NFL_CODIGO IS NOT NULL)')
    Left = 488
    Top = 256
    object Qr_NotasNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotasNFL_MODELO: TStringField
      FieldName = 'NFL_MODELO'
      Origin = '"TB_NOTA_FISCAL"."NFL_MODELO"'
      Size = 2
    end
    object Qr_NotasPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
      Origin = '"TB_PEDIDO"."PED_TIPO"'
    end
    object Qr_NotasNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_NotasNFL_STATUS: TStringField
      FieldName = 'NFL_STATUS'
      Origin = '"TB_NOTA_FISCAL"."NFL_STATUS"'
      Size = 1
    end
    object Qr_NotasNFL_TIPO: TStringField
      FieldName = 'NFL_TIPO'
      Origin = '"TB_NOTA_FISCAL"."NFL_TIPO"'
      Size = 2
    end
    object Qr_NotasPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_NotasPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_NotasITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      DisplayFormat = '0.##'
      Precision = 18
      Size = 3
    end
    object Qr_NotasITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 6
    end
    object Qr_NotasITV_SUBTOTAL: TFloatField
      FieldName = 'ITV_SUBTOTAL'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
    end
    object Qr_NotasNFL_OPERACAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'NFL_OPERACAO'
      Size = 15
      Calculated = True
    end
    object Qr_NotasPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_NotasEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_NotasEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_NotasNFL_NUMERO: TStringField
      FieldName = 'NFL_NUMERO'
      Origin = '"TB_NOTA_FISCAL"."NFL_NUMERO"'
      Size = 10
    end
    object Qr_NotasEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotasEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object Qr_NotasEND_FAX: TStringField
      FieldName = 'END_FAX'
      Origin = '"TB_ENDERECO"."END_FAX"'
      Size = 14
    end
    object Qr_NotasEND_CELULAR: TStringField
      FieldName = 'END_CELULAR'
      Origin = '"TB_ENDERECO"."END_CELULAR"'
      Size = 14
    end
    object Qr_NotasEND_COMERCIAL: TStringField
      FieldName = 'END_COMERCIAL'
      Origin = '"TB_ENDERECO"."END_COMERCIAL"'
      Size = 14
    end
    object Qr_NotasITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      Size = 1
    end
    object Qr_NotasIAV_DESCRICAO: TStringField
      FieldName = 'IAV_DESCRICAO'
      Origin = '"TB_ITENS_AVL"."IAV_DESCRICAO"'
      Size = 100
    end
    object Qr_NotasITEM_DESCRICAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'ITEM_DESCRICAO'
      Size = 100
      Calculated = True
    end
  end
  object Ds_Notas: TDataSource
    DataSet = Qr_Notas
    Left = 488
    Top = 312
  end
  object Qr_Pedidos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    OnCalcFields = Qr_PedidosCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PED_DATA,EMP_CODIGO, EMP_FANTASIA, PED_TIPO,'
      ' PRO_CODIGOFAB,PRO_DESCRICAO,ITF_QTDE,ITF_VL_UNIT,'
      'CAST(((ITF_QTDE * ITF_VL_UNIT) - itf_vl_desc) AS DOUBLE PRECISION) as ITV_SUBTOTAL,'
      ' PED_NUMERO, EMP_NOME, PED_CODIGO, END_FONE,END_FAX,'
      'END_CELULAR,END_COMERCIAL, ITF_ESTOQUE,IAV_DESCRICAO'
      'FROM TB_PEDIDO ped    '
      'INNER JOIN TB_EMPRESA cli   '
      ' ON (cli.EMP_CODIGO = ped.PED_CODEMP)   '
      ' INNER JOIN TB_ENDERECO en    '
      ' ON (en.END_CODIGO = ped.PED_CODEND)    '
      'INNER JOIN TB_ITENS_NFL it   '
      ' ON (it.ITF_CODPED = ped.ped_CODIGO)   '
      ' INNER JOIN TB_PRODUTO pr  '
      '  ON (pr.PRO_CODIGO = it.ITF_CODPRO) '
      '  LEFT OUTER  JOIN TB_ITENS_AVL'
      '  ON (IAV_CODITF = ITF_CODIGO)'
      'WHERE (PED_CODIGO IS NOT NULL) and (PED_FATURADO = '#39'N'#39')  ')
    Left = 408
    Top = 256
    object Qr_PedidosPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
      Required = True
    end
    object Qr_PedidosEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PedidosEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_PedidosPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
      Origin = '"TB_PEDIDO"."PED_TIPO"'
    end
    object Qr_PedidosPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_PedidosPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_PedidosITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_PedidosITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_PedidosITV_SUBTOTAL: TFloatField
      FieldName = 'ITV_SUBTOTAL'
      ProviderFlags = []
    end
    object Qr_PedidosPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_PedidosEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_PedidosPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PedidosEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object Qr_PedidosEND_FAX: TStringField
      FieldName = 'END_FAX'
      Origin = '"TB_ENDERECO"."END_FAX"'
      Size = 14
    end
    object Qr_PedidosEND_CELULAR: TStringField
      FieldName = 'END_CELULAR'
      Origin = '"TB_ENDERECO"."END_CELULAR"'
      Size = 14
    end
    object Qr_PedidosEND_COMERCIAL: TStringField
      FieldName = 'END_COMERCIAL'
      Origin = '"TB_ENDERECO"."END_COMERCIAL"'
      Size = 14
    end
    object Qr_PedidosITF_ESTOQUE: TStringField
      FieldName = 'ITF_ESTOQUE'
      Origin = '"TB_ITENS_NFL"."ITF_ESTOQUE"'
      Size = 1
    end
    object Qr_PedidosIAV_DESCRICAO: TStringField
      FieldName = 'IAV_DESCRICAO'
      Origin = '"TB_ITENS_AVL"."IAV_DESCRICAO"'
      Size = 100
    end
    object Qr_PedidosITEM_DESCRICAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'ITEM_DESCRICAO'
      Size = 100
      Calculated = True
    end
  end
  object Ds_Pedidos: TDataSource
    DataSet = Qr_Pedidos
    Left = 408
    Top = 312
  end
end

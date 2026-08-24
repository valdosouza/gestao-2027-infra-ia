inherited SeaProduct: TSeaProduct
  Caption = 'Pesqusiar Produtos'
  ClientHeight = 674
  ClientWidth = 1179
  ExplicitWidth = 1185
  ExplicitHeight = 723
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 143
    Width = 1173
    Height = 528
    ExplicitTop = 143
    ExplicitWidth = 1173
    ExplicitHeight = 528
    inherited DBG_Pesquisa: TDBGrid
      Width = 1077
      Height = 510
      Columns = <
        item
          Expanded = False
          FieldName = 'PRO_CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOFAB'
          Title.Caption = 'C'#243'd. F'#225'brica'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 600
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGONCM'
          Title.Caption = 'N.C.M.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CEST'
          Title.Caption = 'C.E.S.T.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GRP_DESCRICAO'
          Title.Caption = 'Grupo'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SBG_DESCRICAO'
          Title.Caption = 'SubGrupo'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MRC_DESCRICAO'
          Title.Caption = 'Marca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOBAR'
          Title.Caption = 'C'#243'd Barras'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_LOCAL'
          Title.Caption = 'Localiza'#231#227'o Estoque'
          Width = 300
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 1079
      Height = 510
      ExplicitLeft = 1079
      ExplicitHeight = 510
      inherited Sb_Sair_0: TSpeedButton
        Top = 447
        ExplicitTop = 447
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 384
        ExplicitTop = 384
      end
      inherited SB_Buscar: TSpeedButton
        Top = 321
        ExplicitTop = 321
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 258
        ExplicitTop = 258
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 1173
    Height = 134
    ExplicitWidth = 1173
    ExplicitHeight = 134
    object Label28: TLabel
      Left = 413
      Top = 16
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 8
      Top = 54
      Width = 30
      Height = 14
      Caption = 'Grupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label35: TLabel
      Left = 489
      Top = 54
      Width = 107
      Height = 14
      Caption = 'Localiza'#231#227'o/Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 258
      Top = 16
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
    object Label29: TLabel
      Left = 172
      Top = 54
      Width = 49
      Height = 14
      Caption = 'SubGrupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Aplicacao: TLabel
      Left = 606
      Top = 54
      Width = 48
      Height = 14
      Caption = 'Aplica'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label36: TLabel
      Left = 325
      Top = 54
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lb_bsc_codigoFab: TLabel
      Left = 101
      Top = 16
      Width = 148
      Height = 14
      Caption = 'C'#243'd. Fabrica/ C'#243'd. Fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl_busc_cod: TLabel
      Left = 7
      Top = 16
      Width = 69
      Height = 14
      Caption = 'C'#243'digo Interno'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label34: TLabel
      Left = 8
      Top = 92
      Width = 75
      Height = 14
      Caption = 'Tipo de Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BuscaDescricao: TEdit
      Left = 411
      Top = 30
      Width = 353
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_BuscaCodigo: TEdit_Setes
      Left = 5
      Top = 30
      Width = 92
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Text = ''
      IsCodigo = True
    end
    object E_BuscaGRupo: TEdit
      Left = 6
      Top = 68
      Width = 161
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_BuscaLocal: TEdit
      Left = 487
      Top = 68
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_BuscaCodBarras: TEdit_Setes
      Left = 256
      Top = 30
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
      TabOrder = 4
      Text = ''
      IsCodigo = True
    end
    object E_BuscaCodigoFabrica: TEdit
      Left = 98
      Top = 30
      Width = 156
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object E_BuscaSubgrupo: TMaskEdit
      Left = 170
      Top = 68
      Width = 150
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
    object E_BuscaAplicacao: TMaskEdit
      Left = 608
      Top = 68
      Width = 156
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_BuscaMarca: TMaskEdit
      Left = 322
      Top = 68
      Width = 163
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = ''
    end
    object Rg_Publicacao: TRadioGroup
      Left = 770
      Top = 5
      Width = 191
      Height = 47
      Caption = 'Publicados na Internet'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'SIM'
        'N'#195'O'
        'Todos')
      ParentFont = False
      TabOrder = 9
    end
    object Rg_Imagem: TRadioGroup
      Left = 967
      Top = 5
      Width = 201
      Height = 47
      Caption = 'Com imagem'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'SIM'
        'N'#195'O'
        'Todos')
      ParentFont = False
      TabOrder = 10
    end
    object Cb_BuscaTipo: TComboBox
      Left = 7
      Top = 106
      Width = 186
      Height = 21
      Style = csDropDownList
      TabOrder = 11
      OnChange = SB_BuscarClick
      Items.Strings = (
        'Todos'
        'Acabado'
        'Mat.Prima'
        'Consumo')
    end
    object ChBx_Inativos: TCheckBox
      Left = 296
      Top = 109
      Width = 63
      Height = 17
      Caption = 'Inativos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object ChBx_BuscaForaLinha: TCheckBox
      Left = 365
      Top = 109
      Width = 91
      Height = 17
      Caption = 'Fora de Linha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object chbx_comissao: TCheckBox
      Left = 199
      Top = 109
      Width = 91
      Height = 17
      Caption = 'Sem Comiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object Rg_Est_Neg: TRadioGroup
      Left = 967
      Top = 58
      Width = 201
      Height = 47
      Caption = 'Com permiss'#227'o de estoque negativo'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'SIM'
        'N'#195'O'
        'Todos')
      ParentFont = False
      TabOrder = 15
    end
    object Rg_busca_fixed_rate: TRadioGroup
      Left = 770
      Top = 58
      Width = 191
      Height = 47
      Hint = 
        'Este produto tem o pre'#231'o fixo e n'#227'o ser'#225' calculo automaticamente' +
        ' pela margem de lucro na entrada de compra'
      Caption = 'Pre'#231'o Fixo (n'#227'o altera na compra)'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'SIM'
        'N'#195'O'
        'Todos')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
    end
    object Chbx_ncm_invalido: TCheckBox
      Left = 462
      Top = 109
      Width = 235
      Height = 17
      Caption = 'Mostrar NCM(s) inexistentes ou inv'#225'lidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
  end
  inherited MnuBase: TMainMenu
    Top = 40
  end
end

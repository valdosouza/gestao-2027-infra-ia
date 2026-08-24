object Fr_AjustaPreco: TFr_AjustaPreco
  Left = 447
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ajusta Pre'#231'o Venda'
  ClientHeight = 445
  ClientWidth = 456
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
  object Pg_Geral: TPageControl
    Left = 0
    Top = 0
    Width = 456
    Height = 380
    ActivePage = tbs_Individual
    Align = alClient
    TabOrder = 1
    object tbs_Multiplos: TTabSheet
      Caption = 'M'#250'ltiplos'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 352
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 4
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione o Grupo'
          ExplicitWidth = 88
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 46
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione o Sub-Grupo'
          ExplicitWidth = 110
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 130
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione a Tabela de Pre'#231'o'
          ExplicitWidth = 138
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 88
          Width = 438
          Height = 13
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Selecione a Marca'
          ExplicitWidth = 89
        end
        object DBLCB_Grupo: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 21
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'GRP_CODIGO'
          ListField = 'GRP_DESCRICAO'
          ListSource = DM.Ds_Grupo
          TabOrder = 0
          OnKeyDown = DBLCB_GrupoKeyDown
        end
        object DBLCB_SubGrupo: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 63
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'SBG_CODIGO'
          ListField = 'SBG_DESCRICAO'
          ListSource = DM.Ds_SubGrupo
          TabOrder = 1
          OnKeyDown = DBLCB_SubGrupoKeyDown
        end
        object DBLCB_Marca: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 105
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'MRC_CODIGO'
          ListField = 'MRC_DESCRICAO'
          ListSource = DM.Ds_marcaProduto
          TabOrder = 2
          OnKeyDown = DBLCB_MarcaKeyDown
        end
        object DBLCB_TabelaPreco: TDBLookupComboBox
          AlignWithMargins = True
          Left = 5
          Top = 147
          Width = 438
          Height = 21
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          KeyField = 'TPR_CODIGO'
          ListField = 'TPR_NOME'
          ListSource = DM.Ds_Tabelas
          TabOrder = 3
        end
        object GroupBox1: TGroupBox
          Left = 2
          Top = 227
          Width = 444
          Height = 99
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Atualizar pre'#231'os de una Nota de compra Espec'#237'fica'
          TabOrder = 4
          object lc_fornecedor: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 16
            Width = 434
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'C'#243'digo / Nome do Fornecedor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 143
          end
          object Label8: TLabel
            Left = 7
            Top = 55
            Width = 108
            Height = 14
            Caption = 'N'#250'mero da Nota Fiscal'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Nr_Nota: TEdit_Setes
            Left = 6
            Top = 69
            Width = 98
            Height = 21
            TabOrder = 2
            Text = ''
          end
          object DBLCB_Fornecedor: TDBLookupComboBox
            Left = 65
            Top = 30
            Width = 376
            Height = 21
            DataField = 'PED_CODEMP'
            KeyField = 'EMP_CODIGO'
            ListField = 'EMP_NOME'
            ListSource = Ds_Fornecedor
            TabOrder = 1
            OnExit = DBLCB_FornecedorExit
            OnKeyDown = DBLCB_FornecedorKeyDown
          end
          object E_CodFor: TEdit_Setes
            Left = 7
            Top = 30
            Width = 56
            Height = 21
            TabOrder = 0
            Text = ''
            OnExit = E_CodForExit
          end
        end
        object chbx_ValidaGrupoSubgrupo: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 332
          Width = 438
          Height = 15
          Align = alBottom
          Caption = 'Retirar obrigatoriedade dos Grupo, Subgrupo e Marca'
          TabOrder = 5
        end
        object ListBox: TListBox
          Left = 452
          Top = 21
          Width = 241
          Height = 217
          ItemHeight = 13
          TabOrder = 6
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 172
          Width = 438
          Height = 53
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 7
          object Label4: TLabel
            Left = 356
            Top = 10
            Width = 49
            Height = 13
            Caption = 'Margem %'
          end
          object Rg_Tipo: TRadioGroup
            Left = 1
            Top = 1
            Width = 153
            Height = 51
            Align = alLeft
            Caption = '[ Tipo Opera'#231#227'o ]'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Acrescimo'
              'Desconto')
            TabOrder = 0
          end
          object Rg_Casas: TRadioGroup
            Left = 154
            Top = 1
            Width = 196
            Height = 51
            Align = alLeft
            Caption = '[ Casas Decimais ]'
            Columns = 6
            ItemIndex = 0
            Items.Strings = (
              '0'
              '2'
              '3'
              '4'
              '5'
              '6')
            TabOrder = 1
          end
          object E_Margem: TEdit_Setes
            Left = 356
            Top = 29
            Width = 67
            Height = 21
            Alignment = taRightJustify
            TabOrder = 2
            Text = ''
          end
        end
      end
    end
    object tbs_Individual: TTabSheet
      Caption = 'Individual'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 352
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label5: TLabel
          Left = 6
          Top = 5
          Width = 73
          Height = 13
          Caption = 'C'#243'digo Produto'
        end
        object Label9: TLabel
          Left = 125
          Top = 5
          Width = 81
          Height = 13
          Caption = 'C'#243'digo de Barras'
        end
        object Label10: TLabel
          Left = 6
          Top = 42
          Width = 113
          Height = 13
          Caption = 'Descri'#231#227'o dos Produtos'
        end
        object SB_Cad_produto: TSpeedButton
          Left = 364
          Top = 58
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SB_Cad_produtoClick
        end
        object Label11: TLabel
          Left = 6
          Top = 81
          Width = 60
          Height = 13
          Caption = 'Valor Normal'
        end
        object Label12: TLabel
          Left = 126
          Top = 81
          Width = 75
          Height = 13
          Caption = 'Valor Promo'#231#227'o'
        end
        object E_Codigo: TEdit_Setes
          Left = 5
          Top = 21
          Width = 115
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = E_CodigoExit
          IsCodigo = True
        end
        object E_Codigo_Barras: TEdit_Setes
          Left = 125
          Top = 21
          Width = 263
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
          Text = ''
          OnExit = E_Codigo_BarrasExit
          IsCodigo = True
        end
        object E_VL_Normal: TEdit_Setes
          Left = 6
          Top = 97
          Width = 115
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 3
          Text = '0,00'
          OnEnter = E_VL_NormalEnter
        end
        object E_VL_Promocao: TEdit_Setes
          Left = 123
          Top = 97
          Width = 115
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 4
          Text = '0,00'
          OnEnter = E_VL_PromocaoEnter
          OnExit = E_VL_PromocaoExit
        end
        object Chbx_Promocao: TCheckBox
          Left = 6
          Top = 120
          Width = 232
          Height = 17
          Caption = 'Produto em Promo'#231#227'o'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object E_Produto: TEdit
          Left = 8
          Top = 58
          Width = 350
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 380
    Width = 456
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      456
      65)
    object Gg_Progresso: TGauge
      Left = 5
      Top = 16
      Width = 271
      Height = 41
      Anchors = [akLeft, akRight, akBottom]
      Progress = 0
      ExplicitTop = 29
      ExplicitWidth = 210
    end
    object SB_Confirmar: TSpeedButton
      Left = 282
      Top = 6
      Width = 85
      Height = 55
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
      ExplicitLeft = 228
    end
    object SB_Sair_0: TSpeedButton
      Left = 365
      Top = 5
      Width = 85
      Height = 55
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
      ExplicitLeft = 311
    end
  end
  object Qr_Fornecedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      'EMP_CODVDOR'
      'FROM TB_EMPRESA'
      'WHERE EMP_ATIVA = '#39'S'#39
      'ORDER BY EMP_NOME')
    Left = 348
    Top = 98
  end
  object Ds_Fornecedor: TDataSource
    DataSet = Qr_Fornecedor
    Left = 348
    Top = 129
  end
end

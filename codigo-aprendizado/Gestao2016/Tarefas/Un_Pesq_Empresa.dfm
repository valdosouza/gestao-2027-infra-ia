object Fr_Pesq_Empresa: TFr_Pesq_Empresa
  Left = 154
  Top = 2
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pesquisar Empresas'
  ClientHeight = 680
  ClientWidth = 1007
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1007
    Height = 175
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label27: TLabel
      Left = 220
      Top = 16
      Width = 66
      Height = 14
      Caption = 'C.N.P.J / C.P.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 343
      Top = 16
      Width = 99
      Height = 14
      Caption = 'Nome / Raz'#227'o Social'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 578
      Top = 16
      Width = 71
      Height = 14
      Caption = 'Nome Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 306
      Top = 129
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
      Left = 592
      Top = 92
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
    object Label55: TLabel
      Left = 170
      Top = 16
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
    object Label21: TLabel
      Left = 353
      Top = 53
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
      Left = 648
      Top = 53
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
      Left = 6
      Top = 92
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
      Left = 55
      Top = 92
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
    object Label1: TLabel
      Left = 350
      Top = 92
      Width = 28
      Height = 14
      Caption = 'e-mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 129
      Width = 95
      Height = 14
      Caption = 'Ramo de Atividades'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 55
      Width = 56
      Height = 14
      Caption = 'Logradouro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BuscaRazao: TMaskEdit
      Left = 341
      Top = 32
      Width = 234
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = ''
    end
    object E_BuscaFantasia: TMaskEdit
      Left = 576
      Top = 32
      Width = 272
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
	object E_BuscaCNPJ: TMaskEdit
      Left = 216
      Top = 32
      Width = 124
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentFont = False
      TabOrder = 4
      Text = ''
    end
    object E_BuscaObs: TMaskEdit
      Left = 303
      Top = 143
      Width = 333
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
    object ChBx_Fisica: TCheckBox
      Left = 694
      Top = 134
      Width = 87
      Height = 17
      Caption = 'Pessoa F'#237'sica'
      TabOrder = 14
    end
    object ChBx_Juridica: TCheckBox
      Left = 694
      Top = 150
      Width = 95
      Height = 17
      Caption = 'Pessoa Jur'#237'dica'
      TabOrder = 15
    end
    object Chbx_MalaDireta: TCheckBox
      Left = 800
      Top = 134
      Width = 96
      Height = 17
      Caption = 'Sem Mala Direta'
      TabOrder = 16
    end
    object ChBx_Inativos: TCheckBox
      Left = 800
      Top = 152
      Width = 63
      Height = 17
      Caption = 'Inativos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
    object Rg_Busca_Lojista: TRadioGroup
      Left = 836
      Top = 8
      Width = 176
      Height = 81
      Caption = 'Cadastro de Lojista'
      Columns = 2
      ItemIndex = 3
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Aprova'#231#227'o'
        'Todos')
      TabOrder = 19
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 32
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 85
      Top = 32
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 5
      Top = 16
      Width = 145
      Height = 13
      Caption = 'Periodo data de cadastro'
      TabOrder = 0
      OnClick = ChBx_PeriodoClick
    end
    object E_BuscaCodigo: TEdit_Setes
      Left = 168
      Top = 32
      Width = 46
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object E_BuscaBairro: TMaskEdit
      Left = 351
      Top = 68
      Width = 293
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_BuscaRegiao: TMaskEdit
      Left = 646
      Top = 68
      Width = 183
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
    object E_BuscaEstado: TMaskEdit
      Left = 6
      Top = 106
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 9
      Text = ''
    end
    object E_BuscaCidade: TMaskEdit
      Left = 52
      Top = 106
      Width = 293
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 10
      Text = ''
    end
    object E_BuscaFone: TEdit_Setes
      Left = 589
      Top = 106
      Width = 95
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      Text = ''
    end
    object E_BuscaEmail: TMaskEdit
      Left = 348
      Top = 106
      Width = 239
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 11
      Text = ''
    end
    object E_BuscaRAmoAtividade: TMaskEdit
      Left = 6
      Top = 143
      Width = 293
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 18
      Text = ''
    end
    inline Fm_ListaVendedores: TFm_ListaColaboradores
      Left = 688
      Top = 92
      Width = 315
      Height = 41
      TabOrder = 20
      ExplicitLeft = 688
      ExplicitTop = 92
      ExplicitWidth = 315
      ExplicitHeight = 41
      inherited Label19: TLabel
        Width = 315
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 289
        Height = 24
        ExplicitLeft = 285
        ExplicitHeight = 24
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 283
        Hint = 'Ver configura'#231#227'o na aba geral, Restri'#231#227'o por Carteira'
        ExplicitWidth = 283
      end
    end
    object chbx_Bloqueado: TCheckBox
      Left = 917
      Top = 152
      Width = 84
      Height = 17
      Caption = 'Bloqueados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
    object E_BuscaLogradouro: TMaskEdit
      Left = 6
      Top = 68
      Width = 343
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 22
      Text = ''
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 175
    Width = 1007
    Height = 505
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel4'
    TabOrder = 1
    object Lb_ResultadoPesquisa: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 997
      Height = 14
      Align = alTop
      Caption = 'Resultado da pesquisa :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 116
    end
    object DBG_Pesquisa: TDBGrid
      Left = 2
      Top = 22
      Width = 894
      Height = 481
      Align = alClient
      Color = clCream
      DataSource = Ds_Pesquisa
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
      Columns = <
        item
          Expanded = False
          FieldName = 'EMP_CODIGO'
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
          FieldName = 'EMP_NOME'
          Title.Caption = 'Nome/Raz'#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 404
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_CNPJ'
          Title.Caption = 'CNPJ/CPF'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_EMAIL'
          Title.Caption = 'e-mail'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 233
          Visible = True
        end>
    end
    object Panel1: TPanel
      Left = 896
      Top = 22
      Width = 109
      Height = 481
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Sb_Sair_1: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 424
        Width = 103
        Height = 54
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
        OnClick = Sb_Sair_1Click
        ExplicitLeft = 910
        ExplicitTop = 446
        ExplicitWidth = 92
      end
      object SB_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 367
        Width = 103
        Height = 54
        Margins.Top = 1
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
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 312
        Width = 103
        Height = 54
        Margins.Top = 1
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
        ExplicitLeft = 912
        ExplicitTop = 344
        ExplicitWidth = 92
      end
      object SB_Cadastrar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 257
        Width = 103
        Height = 54
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_CadastrarClick
        ExplicitLeft = 910
        ExplicitTop = 284
        ExplicitWidth = 92
      end
    end
  end
  object Ds_Pesquisa: TDataSource
    DataSet = Qr_Pesquisa
    Left = 509
    Top = 299
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Principal
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT EMP_CODIGO, EMP_NOME, EMP_FANTASIA, EMP_CNPJ, END_BAIRRO,' +
        ' END_REGIAO,UFE_SIGLA,'
      'CDD_DESCRICAO, EMP_EMAIL, CLB_NOME'
      'FROM TB_EMPRESA'
      'INNER JOIN TB_ENDERECO'
      'ON (END_CODEMP = EMP_CODIGO)'
      'INNER JOIN TB_UF'
      'ON (UFE_CODIGO = END_CODUFE)'
      'INNER JOIN TB_CIDADE'
      'ON (CDD_CODIGO = END_CODCDD)'
      'LEFT OUTER JOIN TB_COLABORADOR'
      'ON (CLB_CODIGO = EMP_CODVDOR)'
      'WHERE EMP_CODIGO IS NOT NULL')
    Left = 496
    Top = 240
  end
  object IBT_Principal: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 422
    Top = 235
  end
end

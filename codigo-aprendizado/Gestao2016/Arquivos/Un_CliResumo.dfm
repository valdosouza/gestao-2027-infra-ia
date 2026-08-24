object Fr_CliResumo: TFr_CliResumo
  Left = 387
  Top = 150
  Anchors = [akTop, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 330
  ClientWidth = 761
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
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Empresa: TPageControl
    Left = 0
    Top = 0
    Width = 761
    Height = 330
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_fundo: TPanel
        Left = 0
        Top = 0
        Width = 753
        Height = 236
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          753
          236)
        object Lb_bairro: TLabel
          Left = 3
          Top = 84
          Width = 36
          Height = 16
          Caption = 'Bairro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Telefone: TLabel
          Left = 3
          Top = 3
          Width = 57
          Height = 16
          Caption = 'Telefone '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Cliente: TLabel
          Left = 102
          Top = 2
          Width = 100
          Height = 16
          Caption = 'Nome do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Lb_Cep: TLabel
          Left = 7
          Top = 42
          Width = 27
          Height = 16
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_endereco: TLabel
          Left = 108
          Top = 44
          Width = 59
          Height = 16
          Caption = 'Endere'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_compl: TLabel
          Left = 533
          Top = 44
          Width = 84
          Height = 16
          Caption = 'Complemento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_numero: TLabel
          Left = 480
          Top = 44
          Width = 48
          Height = 16
          Caption = 'N'#250'mero'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Lb_ObsCliente: TLabel
          Left = 354
          Top = 84
          Width = 145
          Height = 16
          Caption = 'Observa'#231#245'es do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 6
          Top = 127
          Width = 75
          Height = 16
          Caption = 'Observa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 663
          Top = 126
          Width = 82
          Height = 16
          Caption = 'Valor Entrega'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Cep: TSpeedButton
          Left = 83
          Top = 59
          Width = 23
          Height = 21
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
            000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
            FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
            FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
            9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
            0000777777777777777733333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          Layout = blGlyphTop
          Margin = 0
          NumGlyphs = 2
          OnClick = Sb_CepClick
        end
        object Lb_Doc: TLabel
          Left = 611
          Top = 2
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
        object Label5: TLabel
          Left = 529
          Top = 4
          Width = 36
          Height = 14
          Caption = 'Pessoa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_CNPJ: TSpeedButton
          Left = 725
          Top = 18
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = Sb_CNPJClick
        end
        object E_Telefone: TEdit_Setes
          Left = 3
          Top = 19
          Width = 93
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = E_TelefoneExit
          IsFone = True
        end
        object E_Nome: TEdit
          Left = 100
          Top = 19
          Width = 423
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object E_Endereco: TEdit
          Left = 108
          Top = 60
          Width = 370
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object E_Compl: TEdit
          Left = 534
          Top = 60
          Width = 213
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object E_Bairro: TEdit
          Left = 3
          Top = 101
          Width = 349
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object E_CEP: TMaskEdit
          Left = 5
          Top = 60
          Width = 76
          Height = 21
          CharCase = ecUpperCase
          EditMask = '00000-000;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 4
          Text = ''
          OnExit = E_CEPExit
        end
        object E_Numero: TEdit
          Left = 481
          Top = 60
          Width = 48
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object E_ObsCliente: TEdit
          Left = 354
          Top = 101
          Width = 393
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object ChBx_Ativo: TCheckBox
          Left = 663
          Top = 215
          Width = 82
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Cliente Ativo'
          TabOrder = 12
        end
        object E_OBS: TMemo
          Left = 5
          Top = 143
          Width = 444
          Height = 87
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 10
        end
        object E_Vl_Entrega: TEdit_Setes
          Left = 663
          Top = 144
          Width = 83
          Height = 21
          Alignment = taRightJustify
          TabOrder = 11
          Text = ''
        end
        object gp_carteira: TGroupBox
          Left = 455
          Top = 129
          Width = 121
          Height = 36
          Caption = 'Habilitar Carteira'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          object rdb_Hab_Cart0: TRadioButton
            Left = 7
            Top = 17
            Width = 48
            Height = 17
            Caption = 'N'#227'o'
            TabOrder = 0
          end
          object rdb_Hab_Cart1: TRadioButton
            Left = 61
            Top = 17
            Width = 48
            Height = 17
            Caption = 'SIM'
            TabOrder = 1
          end
        end
        object CB_TpPessoa: TComboBox
          Left = 526
          Top = 19
          Width = 79
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'F'#205'SICA'
          OnExit = CB_TpPessoaExit
          Items.Strings = (
            'F'#205'SICA'
            'JUR'#205'DICA')
        end
        object E_CpfCnpj: TMaskEdit
          Left = 609
          Top = 18
          Width = 114
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 3
          Text = ''
          OnExit = E_CpfCnpjExit
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 236
        Width = 753
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object SB_Inserir: TSpeedButton
          Left = 205
          Top = 2
          Width = 78
          Height = 62
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
          OnClick = SB_InserirClick
          ExplicitLeft = 145
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Alterar: TSpeedButton
          Left = 283
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_AlterarClick
          ExplicitLeft = 224
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Excluir: TSpeedButton
          Left = 361
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_ExcluirClick
          ExplicitLeft = 308
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Gravar: TSpeedButton
          Left = 439
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Gravar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_GravarClick
          ExplicitLeft = 433
          ExplicitTop = 6
        end
        object SB_Cancelar: TSpeedButton
          Left = 517
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Cancelar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_CancelarClick
          ExplicitLeft = 458
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Pesquisar: TSpeedButton
          Left = 595
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Pesquisar- F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 536
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Sair_0: TSpeedButton
          Left = 673
          Top = 2
          Width = 78
          Height = 62
          Align = alRight
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_0Click
          ExplicitLeft = 614
          ExplicitTop = 6
          ExplicitHeight = 54
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 753
        Height = 61
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label28: TLabel
          Left = 100
          Top = 16
          Width = 93
          Height = 14
          Caption = 'Nome/Raz'#227'o Social'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 6
          Top = 17
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
        object Label3: TLabel
          Left = 411
          Top = 16
          Width = 46
          Height = 14
          Caption = 'Endere'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 636
          Top = 17
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
        object E_BuscaNome: TEdit
          Left = 98
          Top = 33
          Width = 308
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object E_BuscaFone: TEdit_Setes
          Left = 3
          Top = 33
          Width = 93
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          IsFone = True
        end
        object E_BuscaEndereco: TEdit
          Left = 411
          Top = 33
          Width = 219
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
        object E_Busca_CPF_CNPJ: TMaskEdit
          Left = 634
          Top = 33
          Width = 114
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 3
          Text = ''
          OnExit = E_CpfCnpjExit
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 61
        Width = 753
        Height = 241
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          753
          241)
        object Label22: TLabel
          Left = 6
          Top = 2
          Width = 116
          Height = 14
          Caption = 'Resultado da pesquisa :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SB_Buscar: TSpeedButton
          Left = 654
          Top = 65
          Width = 92
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
          ExplicitLeft = 600
          ExplicitTop = 86
        end
        object SB_Visualizar: TSpeedButton
          Left = 654
          Top = 116
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
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
        end
        object SB_Cadastrar: TSpeedButton
          Left = 654
          Top = 5
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 600
          ExplicitTop = -14
        end
        object Sb_Sair_1: TSpeedButton
          Left = 654
          Top = 176
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 600
          ExplicitTop = 197
        end
        object DBGrid2: TDBGrid
          Left = 4
          Top = 22
          Width = 644
          Height = 215
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_Pesquisa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
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
          OnDblClick = SB_VisualizarClick
          OnTitleClick = DBGrid2TitleClick
          Columns = <
            item
              Expanded = False
              FieldName = 'END_FONE'
              Title.Caption = 'Fone'
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              Title.Caption = 'Descri'#231#227'o'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 424
              Visible = True
            end>
        end
      end
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ' SELECT '
      '  END_FONE, '
      '   EMP_NOME'
      'FROM TB_EMPRESA tb_empresa '
      
        '   INNER JOIN TB_ENDERECO tb_endereco ON (tb_endereco.END_CODEMP' +
        ' = tb_empresa.EMP_CODIGO) '
      '')
    Left = 368
    Top = 96
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 368
    Top = 144
  end
end

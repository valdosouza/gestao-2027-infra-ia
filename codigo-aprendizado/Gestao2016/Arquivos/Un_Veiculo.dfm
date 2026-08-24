object Fr_Veiculo: TFr_Veiculo
  Left = 366
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro - Ve'#237'culos '
  ClientHeight = 401
  ClientWidth = 539
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
  object Pg_Cadastro: TPageControl
    Left = 0
    Top = 0
    Width = 539
    Height = 401
    ActivePage = tbs_cadastro
    Align = alClient
    Anchors = [akTop, akBottom]
    Style = tsFlatButtons
    TabOrder = 0
    object tbs_cadastro: TTabSheet
      Caption = 'Ve'#237'culos'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PNL_FUNDO: TPanel
        Left = 0
        Top = 0
        Width = 531
        Height = 304
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          531
          304)
        object Label23: TLabel
          Left = 254
          Top = 91
          Width = 26
          Height = 14
          Caption = 'Placa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 3
          Top = 51
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
        object Label1: TLabel
          Left = 327
          Top = 91
          Width = 25
          Height = 14
          Caption = 'Frota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 248
          Top = 51
          Width = 34
          Height = 14
          Caption = 'Modelo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 401
          Top = 91
          Width = 64
          Height = 14
          Caption = 'Kilometragem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 3
          Top = 91
          Width = 58
          Height = 14
          Caption = 'Tipo Ve'#237'culo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 254
          Top = 131
          Width = 20
          Height = 14
          Caption = 'Ano'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SB_MarcaModelo: TSpeedButton
          Left = 499
          Top = 66
          Width = 23
          Height = 22
          Caption = ' ... '
          OnClick = SB_MarcaModeloClick
        end
        object Sb_Tp_veiculo: TSpeedButton
          Left = 226
          Top = 106
          Width = 23
          Height = 22
          Caption = ' ... '
          OnClick = Sb_Tp_veiculoClick
        end
        object Label7: TLabel
          Left = 6
          Top = 132
          Width = 70
          Height = 14
          Caption = 'Cor do Ve'#237'culo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 333
          Top = 131
          Width = 47
          Height = 14
          Caption = 'Cilindrada'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 5
          Top = 247
          Width = 33
          Height = 14
          Caption = 'Chassi'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object TaraKg: TLabel
          Left = 9
          Top = 212
          Width = 37
          Height = 14
          Caption = 'Tara Kg'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Renavan: TLabel
          Left = 176
          Top = 172
          Width = 43
          Height = 14
          Caption = 'Renavan'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 251
          Top = 172
          Width = 75
          Height = 14
          Caption = 'Tipo de Rodado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Carroceria: TLabel
          Left = 5
          Top = 171
          Width = 51
          Height = 14
          Caption = 'Carroceria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object CapacidadeM3: TLabel
          Left = 162
          Top = 213
          Width = 74
          Height = 14
          Caption = 'Capacidade M3'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object CapacidadeKg: TLabel
          Left = 84
          Top = 213
          Width = 75
          Height = 14
          Caption = 'Capacidade KG'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Placa: TMaskEdit
          Left = 251
          Top = 106
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = ''
        end
        object E_Frota: TEdit
          Left = 324
          Top = 106
          Width = 73
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 5
        end
        object E_Km: TEdit_Setes
          Left = 398
          Top = 106
          Width = 122
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
        object E_Ano: TEdit_Setes
          Left = 250
          Top = 144
          Width = 76
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
        object DBLCB_Marca: TDBLookupComboBox
          Left = 4
          Top = 67
          Width = 244
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'MRC_CODIGO'
          ListField = 'MRC_DESCRICAO'
          ListSource = DM.Ds_MarcaVeiculo
          ParentFont = False
          TabOrder = 1
        end
        object DBLCB_Modelos: TDBLookupComboBox
          Left = 248
          Top = 67
          Width = 247
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'MOD_CODIGO'
          ListField = 'MOD_DESCRICAO'
          ListSource = DM.Ds_Modelo
          ParentFont = False
          TabOrder = 2
        end
        object DBLCB_Tp_Veiculo: TDBLookupComboBox
          Left = 5
          Top = 107
          Width = 219
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'TPV_CODIGO'
          ListField = 'TPV_DESCRICAO'
          ListSource = Ds_Tp_Veiculo
          ParentFont = False
          TabOrder = 3
        end
        object Dblcb_CorVeiculo: TDBLookupComboBox
          Left = 5
          Top = 145
          Width = 244
          Height = 21
          KeyField = 'ID'
          ListField = 'DESCRIPTION'
          ListSource = DM.Ds_Color
          TabOrder = 7
        end
        object E_Cilindrada: TEdit_Setes
          Left = 328
          Top = 144
          Width = 76
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          Text = ''
        end
        object E_Chassi: TEdit
          Left = 6
          Top = 261
          Width = 389
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 17
        end
        inline Fm_ListaClientes: TFm_ListaClientes
          Left = 2
          Top = 4
          Width = 520
          Height = 41
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 4
          ExplicitWidth = 520
          ExplicitHeight = 41
          inherited pnl_01: TPanel
            Width = 520
            ExplicitWidth = 520
          end
          inherited pnl_02: TPanel
            Width = 520
            ExplicitWidth = 520
            inherited Sb_Pesq_Empresa: TSpeedButton
              Left = 492
              ExplicitLeft = 413
              ExplicitHeight = 18
            end
            inherited SB_Empresas: TSpeedButton
              Left = 467
              ExplicitLeft = 388
              ExplicitHeight = 18
            end
            inherited DBLCB_Empresa: TDBLookupComboBox
              Width = 399
              ExplicitWidth = 399
            end
          end
        end
        inline Fm_ListaEstados: TFm_ListaEstados
          Left = 239
          Top = 212
          Width = 105
          Height = 37
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 16
          ExplicitLeft = 239
          ExplicitTop = 212
          ExplicitWidth = 105
          ExplicitHeight = 37
          inherited pnl_linha_1: TPanel
            Width = 105
            ExplicitWidth = 105
            inherited Sb_open: TSpeedButton
              Left = 81
              ExplicitLeft = 81
            end
            inherited Dblcb_Lista: TDBLookupComboBox
              Width = 81
              ExplicitWidth = 81
            end
          end
          inherited pnl_top: TPanel
            Width = 105
            ExplicitWidth = 105
          end
        end
        object E_Tara: TEdit_Setes
          Left = 5
          Top = 225
          Width = 76
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          Text = ''
        end
        object E_Renavan: TEdit_Setes
          Left = 172
          Top = 185
          Width = 76
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          Text = ''
        end
        object E_CapacidadeM3: TEdit_Setes
          Left = 163
          Top = 225
          Width = 76
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          Text = ''
        end
        object E_CapacidadeKg: TEdit_Setes
          Left = 84
          Top = 225
          Width = 76
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          Text = ''
        end
        object Cb_TipoRodado: TComboBox
          Left = 250
          Top = 185
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 12
          Items.Strings = (
            'Truck'
            'Toco'
            'Cavalo Mec'#226'nico'
            'VAN'
            'Utilit'#225'rio'
            'Outros')
        end
        object Cb_Carroceria: TComboBox
          Left = 5
          Top = 185
          Width = 165
          Height = 21
          Style = csDropDownList
          TabOrder = 10
          Items.Strings = (
            'N'#227'o Aplic'#225'vel'
            'Aberta'
            'Fechada/Ba'#250
            'Granelera'
            'Porta-Cont'#234'iner'
            'Sider')
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 304
        Width = 531
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          531
          66)
        object SB_Inserir: TSpeedButton
          Left = 12
          Top = 6
          Width = 73
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 7
        end
        object SB_Alterar: TSpeedButton
          Left = 85
          Top = 6
          Width = 73
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 80
        end
        object SB_Excluir: TSpeedButton
          Left = 158
          Top = 6
          Width = 71
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 153
        end
        object SB_Gravar: TSpeedButton
          Left = 229
          Top = 6
          Width = 72
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 224
        end
        object SB_Cancelar: TSpeedButton
          Left = 301
          Top = 6
          Width = 73
          Height = 54
          Anchors = [akRight, akBottom]
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
          ExplicitLeft = 296
        end
        object Sb_Pesquisar: TSpeedButton
          Left = 374
          Top = 6
          Width = 80
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Pesquisar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 369
        end
        object Sb_Sair_0: TSpeedButton
          Left = 454
          Top = 6
          Width = 72
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
          ExplicitLeft = 449
        end
      end
    end
    object tbs_Pesquisa: TTabSheet
      Caption = 'Pesquisa'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        531
        370)
      object SB_Buscar: TSpeedButton
        Left = 444
        Top = 205
        Width = 86
        Height = 54
        Anchors = [akBottom]
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
        ExplicitLeft = 439
        ExplicitTop = 201
      end
      object Sb_Sair_1: TSpeedButton
        Left = 444
        Top = 313
        Width = 86
        Height = 54
        Anchors = [akBottom]
        Caption = 'Sair - ESC'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_1Click
        ExplicitLeft = 439
        ExplicitTop = 309
      end
      object Sb_Cadastrar: TSpeedButton
        Left = 444
        Top = 151
        Width = 85
        Height = 54
        Anchors = [akBottom]
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_CadastrarClick
        ExplicitLeft = 439
        ExplicitTop = 147
      end
      object Sb_Visualizar: TSpeedButton
        Left = 444
        Top = 259
        Width = 86
        Height = 54
        Anchors = [akBottom]
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_VisualizarClick
        ExplicitLeft = 439
        ExplicitTop = 255
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 531
        Height = 138
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label12: TLabel
          Left = 95
          Top = 56
          Width = 25
          Height = 14
          Caption = 'Frota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 162
          Top = 56
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
        object Label14: TLabel
          Left = 316
          Top = 55
          Width = 34
          Height = 14
          Caption = 'Modelo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 8
          Top = 56
          Width = 26
          Height = 14
          Caption = 'Placa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 9
          Top = 95
          Width = 70
          Height = 14
          Caption = 'Cor do Ve'#237'culo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object ME_BuscaFrota: TMaskEdit
          Left = 93
          Top = 70
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 2
          Text = ''
          OnExit = SB_BuscarClick
        end
        object ME_BuscaRazao: TMaskEdit
          Left = 6
          Top = 31
          Width = 514
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 0
          Text = ''
        end
        object ME_Placa: TMaskEdit
          Left = 8
          Top = 70
          Width = 80
          Height = 22
          CharCase = ecUpperCase
          MaxLength = 7
          TabOrder = 1
          Text = ''
          OnExit = SB_BuscarClick
        end
        object E_BuscaMarca: TMaskEdit
          Left = 158
          Top = 70
          Width = 155
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 3
          Text = ''
          OnExit = SB_BuscarClick
        end
        object E_BuscaModelo: TMaskEdit
          Left = 315
          Top = 70
          Width = 205
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 4
          Text = ''
          OnExit = SB_BuscarClick
        end
        object ChBx_Nome: TCheckBox
          Left = 8
          Top = 12
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = ChBx_NomeClick
        end
        object ChBx_Fantasia: TCheckBox
          Left = 135
          Top = 12
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          TabOrder = 6
          OnClick = ChBx_FantasiaClick
        end
        object E_BuscaCor: TMaskEdit
          Left = 8
          Top = 111
          Width = 205
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 7
          Text = ''
          OnExit = SB_BuscarClick
        end
      end
      object Dbg_Pesquisa: TDBGrid
        Left = 3
        Top = 141
        Width = 435
        Height = 222
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clCream
        DataSource = DS_Pesquisa
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = Sb_VisualizarClick
        OnTitleClick = Dbg_PesquisaTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'VEI_PLACA'
            Title.Caption = 'Placa'
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
            FieldName = 'VEI_FROTA'
            Title.Caption = 'Frota'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 70
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
            Width = 162
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MRC_DESCRICAO'
            Title.Caption = 'Marca'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOD_DESCRICAO'
            Title.Caption = 'Modelo'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VEI_ANO'
            Title.Caption = 'Ano'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 46
            Visible = True
          end>
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
      
        'SELECT VEI_CODIGO, VEI_PLACA, VEI_FROTA, EMP_NOME,EMP_FANTASIA,M' +
        'RC_DESCRICAO, MOD_DESCRICAO, VEI_ANO'
      'FROM TB_VEICULO'
      '   INNER JOIN TB_EMPRESA Tb_cliente'
      '   ON  (Tb_cliente.EMP_CODIGO = Tb_veiculo.VEI_CODEMP)  '
      '   INNER JOIN TB_MARCA_VEICULO Tb_marca'
      '   ON  (Tb_marca.MRC_CODIGO = Tb_veiculo.VEI_CODMRC)  '
      '   INNER JOIN TB_MODELO tb_modelo'
      '   ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)  ')
    Left = 336
    Top = 231
  end
  object DS_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 336
    Top = 271
  end
  object Ds_Cliente: TDataSource
    AutoEdit = False
    DataSet = DM_ListaConsultas.Qr_ListaCliente
    Left = 496
    Top = 215
  end
  object Ds_Tp_Veiculo: TDataSource
    DataSet = DM.Qr_Tp_Veiculo
    Left = 500
    Top = 274
  end
  object Qr_UF: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_UF'
      'Order By UFE_SIGLA')
    Left = 13
    Top = 39
  end
  object Ds_UF: TDataSource
    DataSet = Qr_UF
    Left = 135
    Top = 88
  end
end

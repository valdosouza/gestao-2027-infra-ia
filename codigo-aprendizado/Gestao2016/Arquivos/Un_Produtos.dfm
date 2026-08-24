object Fr_Produtos: TFr_Produtos
  Left = 315
  Top = 54
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produtos'
  ClientHeight = 631
  ClientWidth = 774
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 156
    Width = 774
    Height = 410
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object PG_Informacoes: TPageControl
      Left = 2
      Top = 2
      Width = 770
      Height = 406
      ActivePage = tbs_impostos
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object tbs_estoque: TTabSheet
        Caption = 'Estoque'
        ImageIndex = 7
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object Label31: TLabel
            Left = 227
            Top = 43
            Width = 113
            Height = 14
            Caption = 'Localiza'#231#227'o / Endere'#231'o'
            FocusControl = E_Local
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 408
            Top = 83
            Width = 62
            Height = 14
            AutoSize = False
            Caption = 'Qtde. M'#237'nima'
            FocusControl = E_QtdeMinima
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_Peso: TLabel
            Left = 444
            Top = 42
            Width = 56
            Height = 14
            AutoSize = False
            Caption = 'Peso (kg) '
            FocusControl = E_Peso
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 205
            Top = 83
            Width = 73
            Height = 14
            Caption = 'Pre'#231'o de custo'
            FocusControl = E_PrecoCusto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 5
            Top = 83
            Width = 67
            Height = 14
            Caption = 'Custo F'#225'brica'
            FocusControl = E_CustoFab
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 108
            Top = 83
            Width = 59
            Height = 14
            Caption = 'Custo Real'
            FocusControl = E_custoReal
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label32: TLabel
            Left = 516
            Top = 42
            Width = 66
            Height = 14
            AutoSize = False
            Caption = 'Largura (cm)'
            FocusControl = E_Largura
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label40: TLabel
            Left = 587
            Top = 42
            Width = 66
            Height = 14
            AutoSize = False
            Caption = 'Comp. (cm)'
            FocusControl = E_Comprimento
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label41: TLabel
            Left = 658
            Top = 42
            Width = 56
            Height = 14
            AutoSize = False
            Caption = 'Altura (cm)'
            FocusControl = E_Altura
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 5
            Top = 43
            Width = 65
            Height = 14
            Caption = 'Revestimento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_revestimento: TSpeedButton
            Left = 203
            Top = 57
            Width = 21
            Height = 22
            Caption = '...'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = Sb_revestimentoClick
          end
          object Label21: TLabel
            Left = 5
            Top = 3
            Width = 77
            Height = 14
            Caption = 'Tipo Embalagem'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Embalagem: TSpeedButton
            Left = 123
            Top = 18
            Width = 23
            Height = 22
            Caption = '...'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = Sb_EmbalagemClick
          end
          object Label4: TLabel
            Left = 151
            Top = 3
            Width = 33
            Height = 14
            Caption = 'Divisor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 5
            Top = 121
            Width = 106
            Height = 14
            Caption = 'Origem da Mercadoria'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 420
            Top = 2
            Width = 75
            Height = 14
            Caption = 'Tipo do Produto'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 476
            Top = 83
            Width = 71
            Height = 14
            Caption = 'Disponibilidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 635
            Top = 83
            Width = 99
            Height = 14
            AutoSize = False
            Caption = 'Dias Disponibilidade'
            FocusControl = E_Days_to_available
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 579
            Top = 2
            Width = 131
            Height = 14
            AutoSize = False
            Caption = 'Sequencia nas Pesquisas'
            FocusControl = E_Pro_Sequencia
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label46: TLabel
            Left = 308
            Top = 82
            Width = 87
            Height = 14
            Caption = 'Custo Base Troca'
            FocusControl = E_PrecoCusto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBGrid3: TDBGrid
            Left = 0
            Top = 163
            Width = 482
            Height = 191
            Anchors = [akLeft, akTop, akBottom]
            DataSource = Ds_Estoque
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 19
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ETS_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o do Estoque'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 275
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EST_QTDE'
                Title.Caption = 'Qtde Atual'
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
                FieldName = 'EST_RESERVA'
                Title.Caption = 'Reserva'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 60
                Visible = True
              end>
          end
          object Rdg_Composicao: TGroupBox
            Left = 488
            Top = 163
            Width = 233
            Height = 191
            Anchors = [akLeft, akTop, akBottom]
            Caption = 'Estoque por Composi'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            object L_QtdeMinAutoReposicao: TLabel
              Left = 155
              Top = 132
              Width = 62
              Height = 14
              AutoSize = False
              Caption = 'Qtde. M'#237'nima'
              FocusControl = E_QtdeMinAutoReposicao
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object RB_Cps_Sem_Uso: TRadioButton
              Left = 8
              Top = 16
              Width = 210
              Height = 17
              Caption = 'N'#227'o Utilizar este Recurso'
              Checked = True
              TabOrder = 0
              TabStop = True
            end
            object RB_Cps_Som_Itens: TRadioButton
              Left = 8
              Top = 35
              Width = 210
              Height = 17
              Caption = 'Baixar somente os Itens'
              TabOrder = 1
            end
            object RB_Cps_Cascata_Qtde: TRadioButton
              Left = 8
              Top = 55
              Width = 216
              Height = 17
              Caption = 'Executar baixa em Cascata'
              TabOrder = 2
            end
            object RB_Cps_Lanca_Item: TRadioButton
              Left = 8
              Top = 96
              Width = 210
              Height = 17
              Caption = 'Lan'#231'ar no Pedido Somente os Itens'
              TabOrder = 3
            end
            object RB_Cps_Qtde_Item: TRadioButton
              Left = 8
              Top = 76
              Width = 210
              Height = 17
              Caption = 'Quantidade por Numero de Itens'
              TabOrder = 4
            end
            object RB_Cps_auto_reposicao: TRadioButton
              Left = 10
              Top = 117
              Width = 210
              Height = 17
              Caption = 'Reposi'#231#227'o autom'#225'tica (Composi'#231#227'o)'
              TabOrder = 5
            end
            object E_QtdeMinAutoReposicao: TEdit
              Left = 153
              Top = 147
              Width = 72
              Height = 22
              Hint = 'Para utilizar este controle o valor deve ser maior que zero'
              Alignment = taRightJustify
              AutoSize = False
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
            end
          end
          object E_Local: TEdit
            Left = 227
            Top = 57
            Width = 214
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnExit = E_LocalExit
          end
          object E_QtdeMinima: TEdit
            Left = 407
            Top = 98
            Width = 65
            Height = 22
            Hint = 'Para utilizar este controle o valor deve ser maior que zero'
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
          end
          object E_Peso: TEdit
            Left = 444
            Top = 57
            Width = 68
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object E_PrecoCusto: TEdit
            Left = 205
            Top = 98
            Width = 98
            Height = 22
            Hint = 
              #218'ltimo maior valor pago considerando impostos e rateio de frete ' +
              'e outras despesas'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
            OnExit = E_PrecoCustoExit
          end
          object E_CustoFab: TEdit
            Left = 4
            Top = 98
            Width = 98
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnExit = E_CustoFabExit
          end
          object E_custoReal: TEdit
            Left = 105
            Top = 98
            Width = 98
            Height = 22
            Hint = 
              'M'#233'dia ponderada dos custos e quantidades do estoque atual com a ' +
              'nova entrada  incluindo impostos'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            OnExit = E_custoRealExit
          end
          object E_Largura: TEdit
            Left = 516
            Top = 57
            Width = 68
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object E_Comprimento: TEdit
            Left = 587
            Top = 57
            Width = 68
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object E_Altura: TEdit
            Left = 658
            Top = 57
            Width = 60
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object DBLCB_Revestimento: TDBLookupComboBox
            Left = 5
            Top = 57
            Width = 197
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'RVT_CODIGO'
            ListField = 'RVT_DESCRICAO'
            ListSource = DM.Ds_Revestimento
            ParentFont = False
            TabOrder = 5
          end
          object DBLCB_Embalagem: TDBLookupComboBox
            Left = 3
            Top = 17
            Width = 117
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'EMB_CODIGO'
            ListField = 'EMB_ABREVIATURA'
            ListSource = DM.Ds_Embalagem
            ParentFont = False
            TabOrder = 0
          end
          object E_Divisor: TEdit
            Left = 150
            Top = 18
            Width = 49
            Height = 22
            Color = clMenu
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Cb_Origem: TComboBox
            Left = 5
            Top = 137
            Width = 716
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 18
            Text = '0 - Nacional, exceto as indicadas nos c'#243'digos 3, 4, 5 e 8;'
            Items.Strings = (
              '0 - Nacional, exceto as indicadas nos c'#243'digos 3, 4, 5 e 8;'
              
                '1 - Estrangeira - Importa'#231#227'o direta, exceto a indicada no c'#243'digo' +
                ' 6;'
              
                '2 - Estrangeira - Adquirida no mercado interno, exceto a indicad' +
                'a no c'#243'digo 7;'
              
                '3 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
                'ior a 40% e inferior ou igual a 70%;'
              
                '4 - Nacional, cuja prod. tenha sido feita em conf. os proc. prod' +
                'utivos b'#225'sicos conf as legisla'#231#245'es citadas nos Ajustes;'
              
                '5 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o infer' +
                'ior ou igual a 40%;'
              
                '6 - Estrangeira - Importa'#231#227'o direta, sem similar nacional,consta' +
                'nte em lista da CAMEX e g'#225's natural;'
              
                '7 - Estrangeira - Adquirida no mercado interno, sem similar naci' +
                'onal, constante lista CAMEX e g'#225's natural.'
              
                '8 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
                'ior a 70%;')
          end
          object Cb_Tipo_Produto: TComboBox
            Left = 420
            Top = 17
            Width = 153
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              'Produto Acabado'
              'Materia Prima'
              'Produto Consumo'
              'Autom'#225'tico')
          end
          inline Fm_UnidadeComercial: TFm_ListaMedida
            Left = 201
            Top = 6
            Width = 217
            Height = 34
            TabOrder = 2
            ExplicitLeft = 201
            ExplicitTop = 6
            ExplicitHeight = 34
            inherited Label21: TLabel
              Top = -3
              Width = 89
              Caption = 'Unidade Comercial'
              ExplicitTop = -3
              ExplicitWidth = 89
            end
            inherited Dblcb_Medida: TDBLookupComboBox
              Top = 11
              ExplicitTop = 11
            end
          end
          object Cb_available: TComboBox
            Left = 476
            Top = 98
            Width = 153
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 16
            Text = 'Pronta Entrega'
            Items.Strings = (
              'Pronta Entrega'
              'Sob Encomenda')
          end
          object E_Days_to_available: TEdit
            Left = 635
            Top = 98
            Width = 96
            Height = 22
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
          end
          object E_Pro_Sequencia: TEdit
            Left = 579
            Top = 17
            Width = 65
            Height = 22
            AutoSize = False
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object E_PrecoTroca: TEdit
            Left = 306
            Top = 98
            Width = 98
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            OnExit = E_PrecoCustoExit
          end
        end
      end
      object tbs_observacao: TTabSheet
        Caption = 'Observa'#231#245'es'
        object Pnl_obs: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object ChBx_Estoque: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 196
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Permitindo a movimenta'#231#227'o de estoque mesmo sem saldo'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
          end
          object ChBx_ativo: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 142
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Este Produto encontra-se ativo para qualquer transa'#231#227'o'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
          end
          object ChBx_Impressao: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 178
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'N'#227'o permitir a impress'#227'o deste produto em Tabelas de Pre'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object Chbx_Destaque: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 124
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Produto em Destaque'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 4
          end
          object Chbx_Series: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 214
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Este produto '#233' controlado por n'#250'mero de S'#233'rie'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = Chbx_SeriesClick
          end
          object ChBx_exclusivo: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 232
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 
              'Este produto '#233' exclusivo de Revenda. N'#227'o '#233' vendido a consumidor ' +
              'final'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object ChBx_Internet: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 268
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Publicar este produto para visualiza'#231#227'o na Internet'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnClick = ChBx_InternetClick
          end
          object Chbx_ForaLinha: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 160
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Produto Fora de Linha'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 8
          end
          object ChBx_indEscala: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 286
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Produto fabricados em escala industrial relevante'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object E_Observacao: TMemo
            Left = 2
            Top = 2
            Width = 758
            Height = 103
            Align = alTop
            TabOrder = 10
          end
          object Chbx_Promocao: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 106
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Produto em Promo'#231#227'o'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 3
          end
          object Panel4: TPanel
            Left = 615
            Top = 107
            Width = 114
            Height = 186
            Align = alCustom
            BevelOuter = bvNone
            TabOrder = 11
            object Sb_Html: TSpeedButton
              Left = 0
              Top = 0
              Width = 114
              Height = 27
              Align = alTop
              Caption = 'Editor HTML'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Layout = blGlyphTop
              NumGlyphs = 4
              ParentFont = False
              OnClick = Sb_HtmlClick
              ExplicitLeft = 16
              ExplicitTop = 4
            end
          end
          object Chbx_Send_Internet: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 250
            Width = 752
            Height = 17
            Margins.Top = 1
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Enviar este produto para a internet'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
        end
      end
      object tbs_tbpreco: TTabSheet
        Caption = 'Tabelas de Pre'#231'os'
        ImageIndex = 3
        object Pnl_Tabela_Preco: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object DBG_Preco: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 331
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = ds_tabela_preco_2
            DrawingStyle = gdsClassic
            Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyPress = DBG_PrecoKeyPress
            Columns = <
              item
                Expanded = False
                FieldName = 'TPR_NOME'
                ReadOnly = True
                Title.Caption = 'Descrir'#231#227'o'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRC_MAR_LRC'
                Title.Caption = 'Margem de Lucro'
                Width = 97
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRC_VL_VDA'
                Title.Caption = 'Valor de Venda'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRC_AQ_COM'
                Title.Caption = 'Aliq. Comiss'#227'o'
                Width = 81
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRC_QT_MIN'
                Title.Caption = 'Quanti. Min'
                Width = 61
                Visible = True
              end>
          end
          object Chbx_fixed_rate: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 336
            Width = 752
            Height = 17
            Align = alTop
            Caption = 
              'Este produto tem o pre'#231'o fixo e n'#227'o ser'#225' calculo automaticamente' +
              ' pela margem de lucro na entrada de compra'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
          end
        end
      end
      object tbs_fornecedor: TTabSheet
        Caption = 'Fornecedores'
        ImageIndex = 2
        OnShow = tbs_fornecedorShow
        object pnl_fornecedor: TPanel
          Left = 0
          Top = 310
          Width = 762
          Height = 50
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object SB_exc_fornec: TSpeedButton
            AlignWithMargins = True
            Left = 111
            Top = 5
            Width = 100
            Height = 40
            Align = alLeft
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = SB_exc_fornecClick
            ExplicitTop = 244
            ExplicitHeight = 57
          end
          object SB_Ins_fornec: TSpeedButton
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 100
            Height = 40
            Align = alLeft
            Caption = 'Inserir - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = SB_Ins_fornecClick
            ExplicitLeft = 8
            ExplicitTop = 241
            ExplicitHeight = 38
          end
        end
        object DBG_Fornecedor: TDBGrid
          Left = 0
          Top = 0
          Width = 762
          Height = 310
          Align = alClient
          Color = clMoneyGreen
          DataSource = Ds_Prod_Forn
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = DBG_FornecedorDblClick
          OnKeyDown = DBG_FornecedorKeyDown
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'PFR_CODFOR'
              Title.Caption = 'C'#243'digo'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMP_NOME'
              ReadOnly = True
              Title.Caption = 'Nome do Fornecedor'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 666
              Visible = True
            end>
        end
      end
      object tbs_impostos: TTabSheet
        Caption = 'Tributa'#231#227'o'
        ImageIndex = 3
        OnShow = tbs_impostosShow
        object Pnl_Imposto: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label2: TLabel
            Left = 5
            Top = 47
            Width = 127
            Height = 14
            Caption = 'Finalidade para Tributa'#231#227'o'
            FocusControl = E_Fabricante
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 5
            Top = 128
            Width = 76
            Height = 13
            Caption = 'Qtde. Tribut'#225'vel'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object RG_SUBTRIB: TRadioGroup
            Left = 5
            Top = 1
            Width = 135
            Height = 40
            Caption = 'Substitui'#231#227'o Tribut'#225'ria'
            Columns = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              'SIM'
              'N'#195'O')
            ParentFont = False
            TabOrder = 0
          end
          object Cb_Finalid_Tributa: TComboBox
            Left = 5
            Top = 61
            Width = 135
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Items.Strings = (
              '1 - Revenda'
              '2 - Produ'#231#227'o'
              '3 - Consignado'
              '4 - Industrializa'#231#227'o'
              '5 - Consumo Interno'
              '6 - Presta'#231#227'o de Servi'#231'o'
              '7 - Ativo Imobilizado')
          end
          inline Fm_UnidadeTributavel: TFm_ListaMedida
            Left = 4
            Top = 89
            Width = 217
            Height = 34
            TabOrder = 2
            ExplicitLeft = 4
            ExplicitTop = 89
            ExplicitHeight = 34
            inherited Label21: TLabel
              Top = -3
              Width = 89
              Caption = 'Unidade Tribut'#225'vel'
              ExplicitTop = -3
              ExplicitWidth = 89
            end
            inherited Dblcb_Medida: TDBLookupComboBox
              Top = 11
              ExplicitTop = 11
            end
            inherited Ds_ListaMedida: TDataSource
              Top = 3
            end
          end
          object E_Qtde_Trib: TEdit
            Left = 5
            Top = 143
            Width = 77
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object pnl_regra_tributacao: TPanel
            Left = 484
            Top = 2
            Width = 276
            Height = 356
            Align = alRight
            TabOrder = 4
            DesignSize = (
              276
              356)
            object Label45: TLabel
              Left = 1
              Top = 1
              Width = 274
              Height = 23
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'Regra de Tributa'#231#227'o Espec'#237'fica'
              Color = clNavy
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = False
              ExplicitLeft = -89
              ExplicitTop = 3
            end
            object SB_Impostos: TSpeedButton
              Left = 162
              Top = 326
              Width = 108
              Height = 27
              Anchors = [akRight, akBottom]
              Caption = 'Impostos'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Layout = blGlyphTop
              NumGlyphs = 4
              ParentFont = False
              OnClick = SB_ImpostosClick
              ExplicitTop = 279
            end
            object DBG_Impostos: TDBGrid
              Left = 1
              Top = 24
              Width = 274
              Height = 296
              Align = alTop
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              DataSource = Ds_Impostos
              Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NAT_CFOP'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  Title.Caption = 'C.F.O.P'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UFE_SIGLA'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  Title.Caption = 'UF'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 56
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TRB_CSOSN'
                  Title.Caption = 'CSOSN'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end>
            end
          end
          object pnl_beneficio_fiscal: TPanel
            Left = 252
            Top = 2
            Width = 232
            Height = 356
            Align = alRight
            TabOrder = 5
            DesignSize = (
              232
              356)
            object Label44: TLabel
              Left = 1
              Top = 1
              Width = 230
              Height = 23
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'C'#243'digo de Benef'#237'cio Fiscal'
              Color = clNavy
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = False
              ExplicitLeft = 10
              ExplicitTop = 3
              ExplicitWidth = 222
            end
            object Sb_Exc_Beneficio: TSpeedButton
              Left = 118
              Top = 326
              Width = 108
              Height = 27
              Anchors = [akRight, akBottom]
              Caption = 'Excluir'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Layout = blGlyphTop
              NumGlyphs = 4
              ParentFont = False
              OnClick = Sb_Exc_BeneficioClick
              ExplicitTop = 279
            end
            object Sb_Ins_Beneficio: TSpeedButton
              Left = 2
              Top = 326
              Width = 108
              Height = 27
              Anchors = [akRight, akBottom]
              Caption = 'Insere '
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Layout = blGlyphTop
              NumGlyphs = 4
              ParentFont = False
              OnClick = Sb_Ins_BeneficioClick
              ExplicitTop = 279
            end
            object Strgrd_Benefi_UF: TStringGrid
              Left = 1
              Top = 24
              Width = 230
              Height = 296
              Hint = 'C'#243'digo Benef'#237'cio Ex: PR123456'
              Align = alTop
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clMoneyGreen
              ColCount = 4
              DefaultColWidth = 30
              DefaultRowHeight = 17
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              ColWidths = (
                30
                30
                30
                30)
              RowHeights = (
                17
                17)
            end
          end
        end
      end
      object tbs_instalacao: TTabSheet
        Caption = 'Instala'#231#227'o'
        ImageIndex = 6
        OnShow = tbs_instalacaoShow
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object SB_INS_SERV: TSpeedButton
            Left = 1
            Top = 315
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = SB_INS_SERVClick
            ExplicitTop = 239
          end
          object SB_EXC_SERV: TSpeedButton
            Left = 101
            Top = 315
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = SB_EXC_SERVClick
            ExplicitTop = 239
          end
          object Label18: TLabel
            Left = 646
            Top = 314
            Width = 107
            Height = 14
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            Caption = 'Pre'#231'o de Instala'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object grid_instalacao: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 306
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_Servico
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = grid_instalacaoKeyDown
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o do Servi'#231'o de  Instala'#231#227'o'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 431
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRC_VL_VDA'
                Title.Caption = 'Pre'#231'o'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Width = 133
                Visible = True
              end>
          end
          object E_PrecoInstala: TEdit_Setes
            Left = 645
            Top = 330
            Width = 109
            Height = 21
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akRight, akBottom]
            DragMode = dmAutomatic
            TabOrder = 1
            Text = '0,00'
          end
        end
      end
      object tbs_composicao: TTabSheet
        Caption = 'Composi'#231#227'o'
        ImageIndex = 8
        OnShow = tbs_composicaoShow
        object Pnl_Composicao: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Sb_Ins_Produto: TSpeedButton
            Left = 2
            Top = 312
            Width = 94
            Height = 46
            Align = alLeft
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_ProdutoClick
            ExplicitLeft = 4
            ExplicitTop = 261
            ExplicitHeight = 38
          end
          object Sb_Alt_Produto: TSpeedButton
            Left = 96
            Top = 312
            Width = 97
            Height = 46
            Align = alLeft
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Alt_ProdutoClick
            ExplicitLeft = 104
            ExplicitTop = 242
            ExplicitHeight = 38
          end
          object Sb_Exc_Produto: TSpeedButton
            Left = 193
            Top = 312
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_ProdutoClick
            ExplicitLeft = 199
            ExplicitTop = 332
          end
          object dbg_composicao: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 310
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_Prod_Prod
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = dbg_composicaoKeyDown
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'C'#243'digo'
                Width = 82
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o'
                Width = 365
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_VL_CUSTO'
                Title.Caption = 'Custo Real'
                Width = 79
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PPD_QTDE'
                Title.Caption = 'Qtde'
                Width = 55
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PPD_VL_TOTAL'
                Title.Caption = 'Subtotal'
                Width = 80
                Visible = True
              end>
          end
        end
      end
      object Tbs_Aplicacao: TTabSheet
        Caption = 'Aplica'#231#227'o'
        ImageIndex = 13
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object E_Aplicacao: TMemo
            Left = 2
            Top = 2
            Width = 758
            Height = 356
            Align = alClient
            TabOrder = 0
          end
        end
      end
      object tbs_botao: TTabSheet
        Caption = 'Bot'#227'o'
        ImageIndex = 14
        OnShow = tbs_botaoShow
        object Pnl_Botao: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object Sb_Exc_Botao: TSpeedButton
            Left = 196
            Top = 317
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 270
          end
          object Sb_Alt_botao: TSpeedButton
            Left = 91
            Top = 317
            Width = 97
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 270
          end
          object Sb_Ins_botao: TSpeedButton
            Left = 5
            Top = 317
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 270
          end
          object Label14: TLabel
            Left = 9
            Top = 6
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
          object Label17: TLabel
            Left = 65
            Top = 7
            Width = 51
            Height = 14
            Caption = 'Sequ'#234'ncia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 8
            Top = 47
            Width = 95
            Height = 14
            Caption = 'Descri'#231#227'o do Bot'#227'o'
            FocusControl = E_Desc_botao
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit2: TEdit
            Left = 8
            Top = 22
            Width = 53
            Height = 22
            TabStop = False
            Color = clMenu
            DragMode = dmAutomatic
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object E_Desc_botao: TEdit
            Left = 7
            Top = 62
            Width = 289
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnExit = E_BarrasExit
          end
          object E_Sequencia: TEdit
            Left = 61
            Top = 22
            Width = 61
            Height = 21
            TabOrder = 2
          end
          object GroupBox2: TGroupBox
            Left = 344
            Top = 2
            Width = 416
            Height = 356
            Align = alRight
            Caption = 'Pr'#233' Visualiza'#231#227'o do bot'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            DesignSize = (
              416
              356)
            object Sb_Amostra: TSpeedButton
              Left = 8
              Top = 16
              Width = 60
              Height = 60
              Anchors = [akTop, akRight]
              Layout = blGlyphTop
            end
          end
        end
      end
      object tbs_series: TTabSheet
        Caption = 'S'#233'ries'
        ImageIndex = 15
        OnShow = tbs_seriesShow
        object Pnl_Series: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object Sb_Ins_Serie: TSpeedButton
            Left = 6
            Top = 317
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_SerieClick
            ExplicitTop = 270
          end
          object Sb_alt_Serie: TSpeedButton
            Left = 100
            Top = 317
            Width = 97
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_alt_SerieClick
            ExplicitTop = 270
          end
          object Sb_Exc_Serie: TSpeedButton
            Left = 197
            Top = 317
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_SerieClick
            ExplicitTop = 270
          end
          object Dbg_serie: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 309
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_Series
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            PopupMenu = Pop_Serie
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = grid_instalacaoKeyDown
            OnTitleClick = Dbg_serieTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'SRP_NUMERO'
                Title.Caption = 'Rela'#231#227'o de S'#233'ries Dispon'#237'veis no sistema'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SRP_ORIGEM'
                Title.Caption = 'Origem'
                Title.Font.Charset = DEFAULT_CHARSET
                Title.Font.Color = clNavy
                Title.Font.Height = -11
                Title.Font.Name = 'MS Sans Serif'
                Title.Font.Style = []
                Visible = True
              end>
          end
        end
      end
      object tbs_Internet: TTabSheet
        Caption = 'Internet'
        ImageIndex = 16
        OnShow = tbs_InternetShow
        object Pnl_Internet: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object Label42: TLabel
            Left = 6
            Top = 5
            Width = 217
            Height = 14
            Caption = 'Nome da Categoria na Internet - Vers'#227'o 2013'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Category: TSpeedButton
            Left = 353
            Top = 327
            Width = 105
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Editar Categorias'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = Sb_CategoryClick
            ExplicitTop = 280
          end
          object Label47: TLabel
            Left = 355
            Top = 5
            Width = 98
            Height = 14
            Caption = 'C'#243'digo Produto Tray'
            FocusControl = E_Cd_Produto_Tray
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Trw_Cadastro: TTreeView
            Left = 4
            Top = 19
            Width = 343
            Height = 333
            Anchors = [akLeft, akTop, akBottom]
            AutoExpand = True
            HideSelection = False
            Indent = 19
            MultiSelectStyle = []
            ReadOnly = True
            SortType = stText
            TabOrder = 0
            OnClick = Trw_CadastroClick
          end
          object E_Cd_Produto_Tray: TEdit
            Left = 353
            Top = 19
            Width = 103
            Height = 22
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object tbs_Producao: TTabSheet
        Caption = 'Produ'#231#227'o'
        ImageIndex = 16
        OnShow = tbs_ProducaoShow
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            762
            360)
          object Sb_exc_producao: TSpeedButton
            Left = 209
            Top = 315
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_exc_producaoClick
            ExplicitTop = 239
          end
          object Sb_alt_producao: TSpeedButton
            Left = 106
            Top = 315
            Width = 97
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_alt_producaoClick
            ExplicitTop = 239
          end
          object Sb_ins_producao: TSpeedButton
            Left = 6
            Top = 315
            Width = 94
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_ins_producaoClick
            ExplicitTop = 239
          end
          object dbProducao: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 307
            Align = alTop
            Anchors = [akTop, akBottom]
            Color = clMoneyGreen
            Ctl3D = True
            DataSource = dsProducao
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clNavy
            TitleFont.Height = -11
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'FTC_CODVCL'
                Title.Caption = 'C'#243'd.Item'
                Width = 77
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o'
                Width = 244
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FTC_UND'
                Title.Caption = 'Unidade'
                Width = 66
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FTC_CS_UNIT'
                Title.Caption = 'Cons. Unit'#225'rio'
                Width = 95
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_VL_CUSTOMED'
                Title.Caption = 'Custo Unit'#225'rio'
                Width = 82
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FTC_VL_TOTAL'
                Title.Caption = 'Valor Total'
                Width = 88
                Visible = True
              end>
          end
        end
      end
      object tbs_product_similar: TTabSheet
        Caption = 'Produto Similar'
        ImageIndex = 12
        OnShow = tbs_product_similarShow
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 317
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object DBG_Product_Similar: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 313
            Align = alClient
            Color = clMoneyGreen
            DataSource = Ds_Product_Similar
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = dbg_composicaoKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'TB_PRODUCT_ID_SIMILAR'
                Title.Caption = 'C'#243'digo'
                Width = 83
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'C'#243'd F'#225'brica'
                Width = 139
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o do Produto Similar'
                Width = 494
                Visible = True
              end>
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 317
          Width = 762
          Height = 43
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object Sb_Ins_Product_Similar: TSpeedButton
            Left = 2
            Top = 2
            Width = 94
            Height = 39
            Align = alLeft
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_Product_SimilarClick
            ExplicitLeft = 4
            ExplicitTop = 3
            ExplicitHeight = 38
          end
          object Sb_Exc_Product_Similar: TSpeedButton
            Left = 96
            Top = 2
            Width = 100
            Height = 39
            Align = alLeft
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_Product_SimilarClick
            ExplicitLeft = 101
            ExplicitTop = 5
            ExplicitHeight = 38
          end
        end
      end
      object tbs_reposicao: TTabSheet
        Caption = 'Reposi'#231#227'o automatica'
        ImageIndex = 13
        OnShow = tbs_reposicaoShow
        object pnl_reposicao: TPanel
          Left = 0
          Top = 0
          Width = 762
          Height = 360
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Sb_ins_reposicao: TSpeedButton
            Left = 2
            Top = 312
            Width = 94
            Height = 46
            Align = alLeft
            Caption = 'Novo - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_ins_reposicaoClick
            ExplicitLeft = 4
            ExplicitTop = 261
            ExplicitHeight = 38
          end
          object Sb_edi_reposicao: TSpeedButton
            Left = 96
            Top = 312
            Width = 97
            Height = 46
            Align = alLeft
            Caption = 'Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_edi_reposicaoClick
            ExplicitLeft = 102
            ExplicitTop = 336
            ExplicitHeight = 38
          end
          object Sb_del_reposicao: TSpeedButton
            Left = 193
            Top = 312
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_del_reposicaoClick
            ExplicitLeft = 195
            ExplicitTop = 242
            ExplicitHeight = 38
          end
          object Dbg_reposicao: TDBGrid
            Left = 2
            Top = 2
            Width = 758
            Height = 310
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            Color = clMoneyGreen
            DataSource = Ds_reposicao
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = dbg_composicaoKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'PPD_CODPRO_D'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'PRO_CODIGOFAB'
                Title.Caption = 'C'#243'digo'
                Width = 82
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRO_DESCRICAO'
                Title.Caption = 'Descri'#231#227'o'
                Width = 365
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PPD_QTDE_USED'
                Title.Caption = 'Pacote Grande'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PPD_QTDE'
                Title.Caption = 'Pacote Menor'
                Width = 72
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PPD_METODO'
                Title.Caption = 'M'#233'todo'
                Width = 130
                Visible = True
              end>
          end
        end
      end
    end
  end
  object Panel24: TPanel
    Left = 0
    Top = 566
    Width = 774
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Inserir: TSpeedButton
      AlignWithMargins = True
      Left = 147
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 143
      ExplicitTop = 6
    end
    object SB_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 251
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Altera - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AlterarClick
      ExplicitLeft = 728
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 355
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 235
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 563
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitLeft = 1034
      ExplicitTop = 4
      ExplicitHeight = 54
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 667
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
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
      OnClick = SB_Sair_0Click
      ExplicitLeft = 632
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 459
      Top = 5
      Width = 102
      Height = 55
      Margins.Left = 1
      Margins.Right = 1
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
      ExplicitTop = 6
    end
  end
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 156
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 39
      Width = 186
      Height = 14
      Caption = 'Descri'#231#227'o - ( M'#225'ximo 100 caracteres )'
      FocusControl = E_DescricaoProduto
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 7
      Top = 75
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
    object Label13: TLabel
      Left = 397
      Top = 75
      Width = 47
      Height = 14
      Caption = 'Subgrupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SB_Grupos: TSpeedButton
      Left = 737
      Top = 89
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_GruposClick
    end
    object Label30: TLabel
      Left = 7
      Top = 112
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
    object Sb_Marca: TSpeedButton
      Left = 369
      Top = 126
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_MarcaClick
    end
    object Label1: TLabel
      Left = 9
      Top = 3
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
    object lbl_nr_fabricacao: TLabel
      Left = 65
      Top = 3
      Width = 109
      Height = 14
      Caption = 'C'#243'digo Pr'#243'prio/F'#225'brica'
      FocusControl = E_Fabricante
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl_cd_forn: TLabel
      Left = 450
      Top = 3
      Width = 107
      Height = 14
      Caption = 'C'#243'digo do Fornecedor'
      FocusControl = E_CodigoFor
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl_cd_barra: TLabel
      Left = 236
      Top = 3
      Width = 84
      Height = 14
      Caption = 'C'#243'digo de Barras'
      FocusControl = E_Barras
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label39: TLabel
      Left = 620
      Top = 3
      Width = 119
      Height = 14
      Caption = 'C'#243'd. Class. Fiscal (NCM)'
      FocusControl = E_CodClasfiscal
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Classificacao: TSpeedButton
      Left = 738
      Top = 17
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_ClassificacaoClick
    end
    object Label27: TLabel
      Left = 396
      Top = 112
      Width = 118
      Height = 14
      Caption = 'Dados '#218'ltima Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label37: TLabel
      Left = 546
      Top = 112
      Width = 97
      Height = 14
      Caption = 'Data '#218'ltima Venda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label43: TLabel
      Left = 621
      Top = 39
      Width = 121
      Height = 14
      Caption = 'C'#243'digo Especificador S.T'
      FocusControl = E_CEST
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Cest: TSpeedButton
      Left = 739
      Top = 53
      Width = 23
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_CestClick
    end
    object Label16: TLabel
      Left = 649
      Top = 112
      Width = 92
      Height = 14
      Caption = 'Data Vencimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_DescricaoProduto: TEdit
      Left = 7
      Top = 53
      Width = 608
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object DBLCB_Grupo: TDBLookupComboBox
      Left = 5
      Top = 89
      Width = 386
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'GRP_CODIGO'
      ListField = 'GRP_DESCRICAO'
      ListSource = DM.Ds_Grupo
      ParentFont = False
      TabOrder = 7
      OnExit = DBLCB_GrupoExit
    end
    object DBLCB_SubGrupo: TDBLookupComboBox
      Left = 392
      Top = 89
      Width = 340
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'SBG_CODIGO'
      ListField = 'SBG_DESCRICAO'
      ListSource = DM.Ds_SubGrupo
      ParentFont = False
      TabOrder = 8
    end
    object DBLCB_Marca: TDBLookupComboBox
      Left = 5
      Top = 126
      Width = 361
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'MRC_CODIGO'
      ListField = 'MRC_DESCRICAO'
      ListSource = Ds_MarcaProduto
      ParentFont = False
      TabOrder = 9
    end
    object E_Fabricante: TEdit
      Left = 61
      Top = 17
      Width = 172
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 17
      Width = 53
      Height = 22
      TabStop = False
      Color = clMenu
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_CodigoFor: TEdit
      Left = 448
      Top = 17
      Width = 167
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_Barras: TEdit
      Left = 234
      Top = 17
      Width = 210
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      OnExit = E_BarrasExit
    end
    object E_CodClasfiscal: TEdit
      Left = 618
      Top = 17
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 4
      OnKeyPress = E_CodClasfiscalKeyPress
    end
    object E_Dt_Ultima_compra: TMaskEdit
      Left = 394
      Top = 129
      Width = 72
      Height = 21
      TabStop = False
      Alignment = taCenter
      EditMask = '!99/99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      Text = '  /  /    '
    end
    object E_Dt_Ultima_Venda: TMaskEdit
      Left = 546
      Top = 129
      Width = 97
      Height = 21
      TabStop = False
      Alignment = taCenter
      EditMask = '!99/99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ReadOnly = True
      TabOrder = 11
      Text = '  /  /    '
    end
    object E_CEST: TEdit
      Left = 619
      Top = 53
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnKeyPress = E_CodClasfiscalKeyPress
    end
    object E_DT_Vencimento: TDateTimePicker
      Left = 646
      Top = 127
      Width = 111
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 12
    end
    object E_Custo_Last: TEdit
      Left = 465
      Top = 129
      Width = 75
      Height = 21
      Hint = #218'ltimo valor pagor sem impostos e independente da varia'#231#227'o'
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 13
      OnExit = E_PrecoCustoExit
    end
  end
  object Ds_Prod_Forn: TDataSource
    AutoEdit = False
    DataSet = Qr_Prod_Forn
    Left = 924
    Top = 83
  end
  object Ds_MarcaProduto: TDataSource
    DataSet = DM.Qr_MarcaProduto
    Left = 1044
    Top = 120
  end
  object Qr_Insere: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'INSERT INTO TB_IMG_PRODUTO('
      '  IMG_CODIGO,'
      '  IMG_CODPRO,'
      '  IMG_IMAGEM,'
      '  IMG_TIPO)'
      'VALUES('
      '  :IMG_CODIGO,'
      '  :IMG_CODPRO,'
      '  :IMG_IMAGEM,'
      '  :IMG_TIPO)')
    Left = 1200
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IMG_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IMG_CODPRO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IMG_IMAGEM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IMG_TIPO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Servico: TDataSource
    AutoEdit = False
    DataSet = Qr_Servico
    Left = 1146
    Top = 284
  end
  object Ds_Estoque: TDataSource
    DataSet = cds_Estoque
    Left = 855
    Top = 400
  end
  object Qr_Prod_Prod: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT PRO_CODIGOFAB, PRO_DESCRICAO, PRO_VL_CUSTO,PRO_VL_CUSTOME' +
        'D, PPD_QTDE, PPD_CODPRO_D,PPD_CODPRO_M,'
      '(PPD_QTDE * PRO_VL_CUSTO) PPD_VL_TOTAL'
      'FROM TB_PRODUTO tb_produto'
      '  INNER JOIN TB_PROD_PROD tb_prod_prod'
      '   ON (tb_prod_prod.PPD_CODPRO_D = tb_produto.PRO_CODIGO)'
      'WHERE PPD_CODPRO_M=:PRO_CODIGO'
      'and ( (PPD_TIPO IS NULL) OR (PPD_TIPO = '#39'COMPOSICAO'#39'))')
    Left = 935
    Top = 352
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Prod_Prod: TDataSource
    DataSet = Qr_Prod_Prod
    Left = 935
    Top = 400
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 978
    Top = 31
  end
  object Qr_CopiaProduto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_PRODUTO'
      'WHERE PRO_CODIGO =:PRO_CODIGO')
    Left = 1053
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_CopiaBase: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  FTC_CODIGO,'
      '  FTC_CODICT,'
      '  FTC_CODITF,'
      '  FTC_TIPO,'
      '  FTC_CODVCL,'
      '  PRO_DESCRICAO,'
      '  PRO_CODMED,'
      '  FTC_CODPRO,'
      '  PRO_VL_CUSTOMED,'
      '  FTC_CS_UNIT'
      'FROM TB_FICHA_TECNICA tb_ficha_tecnica'
      '  INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)'
      '  INNER JOIN TB_MEDIDA tb_medida'
      '  ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      'where (FTC_CODPRO=:PRO_CODIGO)')
    Left = 1136
    Top = 28
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_CopiaBaseFTC_CODIGO: TIntegerField
      FieldName = 'FTC_CODIGO'
      Origin = 'TB_FICHA_TECNICA.FTC_CODIGO'
      Required = True
    end
    object Qr_CopiaBaseFTC_CODICT: TIntegerField
      FieldName = 'FTC_CODICT'
      Origin = 'TB_FICHA_TECNICA.FTC_CODICT'
    end
    object Qr_CopiaBaseFTC_CODITF: TIntegerField
      FieldName = 'FTC_CODITF'
      Origin = 'TB_FICHA_TECNICA.FTC_CODITF'
    end
    object Qr_CopiaBaseFTC_TIPO: TStringField
      FieldName = 'FTC_TIPO'
      Origin = 'TB_FICHA_TECNICA.FTC_TIPO'
      FixedChar = True
      Size = 1
    end
    object Qr_CopiaBaseFTC_CODVCL: TIntegerField
      FieldName = 'FTC_CODVCL'
      Origin = 'TB_FICHA_TECNICA.FTC_CODVCL'
    end
    object Qr_CopiaBasePRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_CopiaBasePRO_CODMED: TIntegerField
      FieldName = 'PRO_CODMED'
      Origin = 'TB_PRODUTO.PRO_CODMED'
    end
    object Qr_CopiaBaseFTC_CODPRO: TIntegerField
      FieldName = 'FTC_CODPRO'
      Origin = 'TB_FICHA_TECNICA.FTC_CODPRO'
    end
    object Qr_CopiaBaseFTC_CS_UNIT: TFloatField
      FieldName = 'FTC_CS_UNIT'
      Origin = 'TB_FICHA_TECNICA.FTC_CS_UNIT'
    end
    object Qr_CopiaBasePRO_VL_CUSTOMED: TFloatField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = 'TB_PRODUTO.PRO_VL_CUSTOMED'
    end
  end
  object Qr_botao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    AfterOpen = Qr_botaoAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT BTN_CODIGO, BTN_DESCRICAO, IBT_SEQUENCIA,  BTN_ALTURA ,  ' +
        'BTN_LARGURA ,'
      '  BTN_LABEL,  BTN_IMAGEM,  BTN_MRG_SUP '
      'FROM TB_BOTAO tb_botao'
      '  INNER JOIN TB_ITENS_BTN tb_itens_btn'
      '  ON (tb_itens_btn.IBT_CODBTN = tb_botao.BTN_CODIGO)'
      'WHERE IBT_CODPRO=:PRO_CODIGO')
    Left = 1008
    Top = 232
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_botaoBTN_CODIGO: TIntegerField
      FieldName = 'BTN_CODIGO'
      Origin = 'TB_BOTAO.BTN_CODIGO'
      Required = True
    end
    object Qr_botaoBTN_DESCRICAO: TStringField
      FieldName = 'BTN_DESCRICAO'
      Origin = 'TB_BOTAO.BTN_DESCRICAO'
      Size = 50
    end
    object Qr_botaoIBT_SEQUENCIA: TIntegerField
      FieldName = 'IBT_SEQUENCIA'
      Origin = 'TB_ITENS_BTN.IBT_SEQUENCIA'
      Required = True
    end
    object Qr_botaoBTN_ALTURA: TIntegerField
      FieldName = 'BTN_ALTURA'
      Origin = 'TB_BOTAO.BTN_ALTURA'
    end
    object Qr_botaoBTN_LARGURA: TIntegerField
      FieldName = 'BTN_LARGURA'
      Origin = 'TB_BOTAO.BTN_LARGURA'
    end
    object Qr_botaoBTN_LABEL: TStringField
      FieldName = 'BTN_LABEL'
      Origin = 'TB_BOTAO.BTN_LABEL'
      Size = 50
    end
    object Qr_botaoBTN_IMAGEM: TBlobField
      FieldName = 'BTN_IMAGEM'
      Origin = 'TB_BOTAO.BTN_IMAGEM'
      Size = 8
    end
    object Qr_botaoBTN_MRG_SUP: TIntegerField
      FieldName = 'BTN_MRG_SUP'
      Origin = 'TB_BOTAO.BTN_MRG_SUP'
    end
  end
  object Ds_botao: TDataSource
    AutoEdit = False
    DataSet = Qr_botao
    Left = 1008
    Top = 280
  end
  object Qr_Series: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    OnCalcFields = Qr_SeriesCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT SRP_CODIGO, SRP_NUMERO, '
      
        'tb_entrada.PED_TIPO PED_ORIGEM, tb_entrada.PED_NUMERO PED_ENTRAD' +
        'A,'
      'tb_saida.PED_TIPO PED_DESTINO, tb_saida.PED_NUMERO PED_SAIDA'
      ''
      'FROM TB_SERIE_PRODUTO tb_serie'
      '   LEFT OUTER JOIN tb_itens_nfl tb_itensentrada'
      '   ON (tb_itensentrada.itf_codigo = tb_serie.srp_codent)'
      '   LEFT OUTER JOIN TB_PEDIDO tb_entrada'
      '   ON (tb_entrada.ped_codigo = tb_itensentrada.ITF_CODPED)'
      ''
      '   LEFT OUTER JOIN tb_itens_nfl tb_itenssaida'
      '   ON (tb_itenssaida.itf_codigo = tb_serie.srp_codsai)'
      '   LEFT OUTER JOIN TB_PEDIDO tb_saida'
      '   ON (tb_saida.ped_codigo = tb_itenssaida.ITF_CODPED)'
      'WHERE (SRP_CODPRO=:PRO_CODIGO)'
      '  AND (SRP_DISPON = '#39'S'#39')'
      'ORDER BY SRP_NUMERO')
    Left = 1076
    Top = 233
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_SeriesSRP_CODIGO: TIntegerField
      FieldName = 'SRP_CODIGO'
      Origin = 'TB_SERIE_PRODUTO.SRP_CODIGO'
      Required = True
    end
    object Qr_SeriesSRP_NUMERO: TStringField
      FieldName = 'SRP_NUMERO'
      Origin = 'TB_SERIE_PRODUTO.SRP_NUMERO'
      Size = 50
    end
    object Qr_SeriesPED_ORIGEM: TIntegerField
      FieldName = 'PED_ORIGEM'
      Origin = 'TB_PEDIDO.PED_TIPO'
    end
    object Qr_SeriesPED_ENTRADA: TIntegerField
      FieldName = 'PED_ENTRADA'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_SeriesPED_DESTINO: TIntegerField
      FieldName = 'PED_DESTINO'
      Origin = 'TB_PEDIDO.PED_TIPO'
    end
    object Qr_SeriesPED_SAIDA: TIntegerField
      FieldName = 'PED_SAIDA'
      Origin = 'TB_PEDIDO.PED_NUMERO'
    end
    object Qr_SeriesSRP_ORIGEM: TStringField
      FieldKind = fkCalculated
      FieldName = 'SRP_ORIGEM'
      Size = 50
      Calculated = True
    end
    object Qr_SeriesSRP_DESTINO: TStringField
      FieldKind = fkCalculated
      FieldName = 'SRP_DESTINO'
      Size = 50
      Calculated = True
    end
  end
  object Ds_Series: TDataSource
    AutoEdit = False
    DataSet = Qr_Series
    Left = 1079
    Top = 285
  end
  object Pop_Serie: TPopupMenu
    Left = 858
    Top = 189
    object LiberarNmerodeSrie1: TMenuItem
      Caption = 'Liberar N'#250'mero de S'#233'rie'
      OnClick = LiberarNmerodeSrie1Click
    end
  end
  object Qr_Servico: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  PSI_CODIGO,'
      '  PSI_CODPRO,'
      '  PSI_CODSRV,'
      '  tb_servico.PRO_DESCRICAO,'
      '  tb_preco.prc_vl_vda'
      'FROM TB_PROD_SERV tb_prod_serv'
      '    INNER JOIN TB_PRODUTO tb_produto'
      '    ON (tb_prod_serv.PSI_CODPRO = tb_produto.PRO_CODIGO)'
      '    INNER JOIN TB_PRODUTO tb_servico'
      '    ON (tb_prod_serv.PSI_CODSRV = tb_servico.PRO_CODIGO)'
      '    INNER JOIN TB_PRECO TB_PRECO'
      '    ON (TB_PRECO.prc_codpro = tb_servico.PRO_CODIGO)'
      '    AND tb_preco.prc_codtpr = 1'
      'WHERE PSI_CODPRO =:PRO_CODIGO'
      'ORDER BY  tb_servico.PRO_DESCRICAO')
    Left = 1143
    Top = 235
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object Qr_ServicoPSI_CODIGO: TIntegerField
      FieldName = 'PSI_CODIGO'
      Origin = '"TB_PROD_SERV"."PSI_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ServicoPSI_CODPRO: TIntegerField
      FieldName = 'PSI_CODPRO'
      Origin = '"TB_PROD_SERV"."PSI_CODPRO"'
      Required = True
    end
    object Qr_ServicoPSI_CODSRV: TIntegerField
      FieldName = 'PSI_CODSRV'
      Origin = '"TB_PROD_SERV"."PSI_CODSRV"'
      Required = True
    end
    object Qr_ServicoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ServicoPRC_VL_VDA: TFMTBCDField
      FieldName = 'PRC_VL_VDA'
      Origin = '"TB_PRECO"."PRC_VL_VDA"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
  end
  object Qr_Prod_Forn: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  PFR_CODFOR, '
      '  PFR_CODPRO,'
      '  PFR_PRODUTO,'
      '  EMP_FANTASIA,'
      '  EMP_NOME,'
      '  END_FONE'
      'FROM TB_PROD_FORN tb_prod_forn'
      '    INNER JOIN TB_EMPRESA tb_fornecedor'
      '    ON (tb_prod_forn.PFR_CODFOR = tb_fornecedor.EMP_CODIGO)'
      '    LEFT JOIN TB_ENDERECO tb_endereco'
      '    ON (tb_endereco.END_CODEMP = tb_fornecedor.EMP_CODIGO)'
      'WHERE PFR_CODPRO =:PRO_CODIGO'
      'ORDER BY    EMP_FANTASIA')
    Left = 924
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object qrProducao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  FTC_CODIGO,'
      '  FTC_CODICT,'
      '  FTC_CODITF,'
      '  FTC_TIPO,'
      '  FTC_CODVCL,'
      '  PRO_DESCRICAO,'
      '  FTC_UND,'
      '  PRO_VL_CUSTOMED,'
      '  PRO_VL_CUSTO,'
      '  FTC_CS_UNIT,'
      '  (FTC_CS_UNIT * PRO_VL_CUSTOMED) FTC_VL_TOTAL'
      'FROM TB_FICHA_TECNICA tb_ficha_tecnica'
      '  INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)'
      'where (FTC_CODPRO=:PRO_CODIGO)   AND (FTC_TIPO = '#39'F'#39')')
    Left = 852
    Top = 236
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object dsProducao: TDataSource
    DataSet = qrProducao
    Left = 852
    Top = 284
  end
  object MainMenu1: TMainMenu
    Left = 978
    Top = 179
    object TarefaImagens: TMenuItem
      Caption = 'Tarefas'
      object ImagensdeProdutos1: TMenuItem
        Caption = 'Imagens de Produtos'
        OnClick = ImagensdeProdutos1Click
      end
      object abeladePreo1: TMenuItem
        Caption = 'Tabela de Pre'#231'o'
        OnClick = abeladePreo1Click
      end
      object VariaodeProdutos1: TMenuItem
        Caption = 'Varia'#231#227'o de Produtos'
        OnClick = VariaodeProdutos1Click
      end
      object AjustarPreoporEscala1: TMenuItem
        Caption = 'Ajustar Pre'#231'o por Escala'
        OnClick = AjustarPreoporEscala1Click
      end
    end
  end
  object Qr_Product_Similar: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT P.PRO_CODIGOFAB, P.PRO_DESCRICAO,'
      'S.TB_PRODUCT_ID_MASTER,'
      'S.TB_PRODUCT_ID_SIMILAR'
      'FROM TB_PRODUTO P'
      '  INNER JOIN TB_PRODUCT_SIMILAR S'
      '  ON (S.TB_PRODUCT_ID_SIMILAR = P.PRO_CODIGO)'
      'WHERE S.TB_PRODUCT_ID_MASTER=:PRO_CODIGO')
    Left = 1095
    Top = 352
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Product_Similar: TDataSource
    DataSet = Qr_Product_Similar
    Left = 1095
    Top = 400
  end
  object ds_tabela_preco_2: TDataSource
    DataSet = Cds_Tabela_Preco
    Left = 859
    Top = 83
  end
  object Cds_Tabela_Preco: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 852
    Top = 35
    object Cds_Tabela_PrecoTPR_NOME: TWideStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Required = True
      Size = 50
    end
    object Cds_Tabela_PrecoTPR_MAR_LRC: TFMTBCDField
      FieldName = 'TPR_MAR_LRC'
      Origin = '"TB_TABELA_PRECO"."TPR_MAR_LRC"'
      Required = True
      Precision = 18
      Size = 6
    end
    object Cds_Tabela_PrecoTPR_CASA_DECIMAL: TIntegerField
      FieldName = 'TPR_CASA_DECIMAL'
      Origin = '"TB_TABELA_PRECO"."TPR_CASA_DECIMAL"'
      Required = True
    end
    object Cds_Tabela_PrecoPRC_AQ_COM: TBCDField
      FieldName = 'PRC_AQ_COM'
      Origin = '"TB_PRECO"."PRC_AQ_COM"'
      Required = True
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Cds_Tabela_PrecoPRC_VL_VDA: TFMTBCDField
      FieldName = 'PRC_VL_VDA'
      Origin = '"TB_PRECO"."PRC_VL_VDA"'
      Required = True
      DisplayFormat = '0.00####'
      Precision = 18
      Size = 6
    end
    object Cds_Tabela_PrecoPRC_MAR_LRC: TFMTBCDField
      FieldName = 'PRC_MAR_LRC'
      Origin = '"TB_PRECO"."PRC_MAR_LRC"'
      Required = True
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Cds_Tabela_PrecoPRC_QT_MIN: TBCDField
      FieldName = 'PRC_QT_MIN'
      Origin = '"TB_PRECO"."PRC_QT_MIN"'
      Required = True
      Precision = 18
      Size = 3
    end
    object Cds_Tabela_PrecoPRC_CODTPR: TIntegerField
      FieldName = 'PRC_CODTPR'
      Required = True
    end
    object Cds_Tabela_PrecoPRC_CODIGO: TIntegerField
      FieldName = 'PRC_CODIGO'
      Required = True
    end
    object Cds_Tabela_PrecoTPR_MAR_PRIORITARIA: TStringField
      FieldName = 'TPR_MAR_PRIORITARIA'
      Size = 1
    end
  end
  object cds_Estoque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 852
    Top = 359
    object cds_EstoqueETS_DESCRICAO: TWideStringField
      FieldName = 'ETS_DESCRICAO'
      Origin = '"TB_ESTOQUES"."ETS_DESCRICAO"'
      Size = 100
    end
    object cds_EstoqueEST_CODIGO: TIntegerField
      FieldName = 'EST_CODIGO'
      Origin = '"TB_ESTOQUE"."EST_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_EstoqueEST_QTDE: TFMTBCDField
      FieldName = 'EST_QTDE'
      Origin = '"TB_ESTOQUE"."EST_QTDE"'
      Precision = 18
      Size = 6
    end
    object cds_EstoqueEST_QTDE_MIN: TBCDField
      FieldName = 'EST_QTDE_MIN'
      Origin = '"TB_ESTOQUE"."EST_QTDE_MIN"'
      Precision = 18
      Size = 3
    end
    object cds_EstoqueETS_CODIGO: TIntegerField
      FieldName = 'ETS_CODIGO'
      Origin = '"TB_ESTOQUES"."ETS_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_EstoqueETS_PRINCIPAL: TWideStringField
      FieldName = 'ETS_PRINCIPAL'
      Origin = '"TB_ESTOQUES"."ETS_PRINCIPAL"'
      FixedChar = True
      Size = 1
    end
    object cds_EstoqueEST_CODPRO: TIntegerField
      FieldName = 'EST_CODPRO'
      Origin = '"TB_ESTOQUE"."EST_CODPRO"'
      Required = True
    end
  end
  object Qr_Impostos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        ' SELECT TRB_CODIGO, NAT_CFOP, UFE_SIGLA, TRB_CONSUMIDOR,TRB_MICR' +
        'O, TRB_ORIGEM,  '
      
        ' ICMS_NR.TBI_GRUPO TRB_CST, ICMS_SN.TBI_GRUPO TRB_CSOSN, TRB_ST_' +
        'ICMS, TRB_AQ_ICMS, TRB_RD_AQ_ICMS,'
      ' TRB_RD_BS_ICMS,'
      ' OBS_DESCRICAO'
      ' FROM TB_TRIBUTACAO TRI'
      '   LEFT OUTER  JOIN TB_OBSERVACAO OBS'
      '   ON (OBS.OBS_CODIGO = TRI.TRB_CODOBS)'
      '   LEFT OUTER JOIN TB_UF UF'
      '   ON (UF.UFE_CODIGO = TRI.TRB_ESTADO)'
      '   LEFT OUTER JOIN TB_NATUREZA'
      '   ON (NAT_CODIGO = TRB_CODNAT)'
      ''
      '   LEFT OUTER JOIN TB_TRIB_ICMS_NR ICMS_NR'
      '  ON (ICMS_NR.TBI_CODIGO =TRB_CODTBI_ICMS_NR)'
      ''
      '   LEFT OUTER JOIN TB_TRIB_ICMS_SN ICMS_SN'
      '  ON (ICMS_SN.TBI_CODIGO =TRB_CODTBI_ICMS_SN)'
      ''
      ' WHERE (TRB_CODIGO IS NOT NULL)'
      ' and TRI.TRB_CODMHA = :TRB_CODMHA'
      ' and TRI.TRB_CODPRO = :TRB_CODPRO'
      'and TRI.TRB_CODPRO > 0')
    Left = 936
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TRB_CODMHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRB_CODPRO'
        ParamType = ptUnknown
      end>
    object Qr_ImpostosTRB_CODIGO: TIntegerField
      FieldName = 'TRB_CODIGO'
      Origin = '"TB_TRIBUTACAO"."TRB_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ImpostosNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
    object Qr_ImpostosUFE_SIGLA: TStringField
      FieldName = 'UFE_SIGLA'
      Origin = '"TB_UF"."UFE_SIGLA"'
      FixedChar = True
      Size = 2
    end
    object Qr_ImpostosTRB_CONSUMIDOR: TStringField
      FieldName = 'TRB_CONSUMIDOR'
      Origin = '"TB_TRIBUTACAO"."TRB_CONSUMIDOR"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_MICRO: TStringField
      FieldName = 'TRB_MICRO'
      Origin = '"TB_TRIBUTACAO"."TRB_MICRO"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_ORIGEM: TStringField
      FieldName = 'TRB_ORIGEM'
      Origin = '"TB_TRIBUTACAO"."TRB_ORIGEM"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_CST: TStringField
      FieldName = 'TRB_CST'
      Origin = '"TB_TRIB_ICMS_NR"."TBI_GRUPO"'
      FixedChar = True
      Size = 2
    end
    object Qr_ImpostosTRB_CSOSN: TStringField
      FieldName = 'TRB_CSOSN'
      Origin = '"TB_TRIB_ICMS_SN"."TBI_GRUPO"'
      FixedChar = True
      Size = 3
    end
    object Qr_ImpostosTRB_ST_ICMS: TStringField
      FieldName = 'TRB_ST_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_ST_ICMS"'
      FixedChar = True
      Size = 1
    end
    object Qr_ImpostosTRB_AQ_ICMS: TBCDField
      FieldName = 'TRB_AQ_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosTRB_RD_AQ_ICMS: TBCDField
      FieldName = 'TRB_RD_AQ_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_RD_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosTRB_RD_BS_ICMS: TBCDField
      FieldName = 'TRB_RD_BS_ICMS'
      Origin = '"TB_TRIBUTACAO"."TRB_RD_BS_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_ImpostosOBS_DESCRICAO: TStringField
      FieldName = 'OBS_DESCRICAO'
      Origin = '"TB_OBSERVACAO"."OBS_DESCRICAO"'
      Size = 50
    end
  end
  object Ds_Impostos: TDataSource
    DataSet = Qr_Impostos
    Left = 936
    Top = 280
  end
  object Ds_reposicao: TDataSource
    DataSet = Cds_reposicao
    Left = 1007
    Top = 408
  end
  object Cds_reposicao: TClientDataSet
    Left = 1006
    Top = 358
    object Cds_reposicaoPPD_CODPRO_M: TIntegerField
      FieldName = 'PPD_CODPRO_M'
    end
    object Cds_reposicaoPPD_CODPRO_D: TIntegerField
      FieldName = 'PPD_CODPRO_D'
    end
    object Cds_reposicaoPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Size = 50
    end
    object Cds_reposicaoPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
    object Cds_reposicaoPPD_QTDE: TFloatField
      FieldName = 'PPD_QTDE'
    end
    object Cds_reposicaoPPD_METODO: TStringField
      FieldName = 'PPD_METODO'
    end
    object Cds_reposicaoPPD_QTDE_USED: TFloatField
      FieldName = 'PPD_QTDE_USED'
    end
  end
end

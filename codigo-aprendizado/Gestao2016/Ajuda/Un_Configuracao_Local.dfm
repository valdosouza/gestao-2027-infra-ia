object Fr_Configuracao_Local: TFr_Configuracao_Local
  Left = 397
  Top = 49
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es locais para este computador'
  ClientHeight = 407
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Configuracao: TPageControl
    Left = 0
    Top = 0
    Width = 594
    Height = 407
    ActivePage = Tbs_Impressao
    Align = alClient
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    object Tbs_Geral: TTabSheet
      Caption = 'Geral'
      ImageIndex = 2
      OnShow = Tbs_GeralShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Btn_Ok_1: TButton
          Left = 344
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_OK_1Click
        end
        object Btn_Cn_1: TButton
          Left = 423
          Top = 349
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
        end
        object GB_Aniver: TGroupBox
          Left = 4
          Top = 1
          Width = 569
          Height = 72
          Caption = 'Aniversariantes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label12: TLabel
            Left = 294
            Top = 20
            Width = 68
            Height = 13
            AutoSize = False
            Caption = 'Data Inicial'
            FocusControl = E_Aniv_DataIni
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label54: TLabel
            Left = 443
            Top = 20
            Width = 47
            Height = 14
            Caption = 'Data Final'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Rb_Aniv_Dia: TRadioButton
            Left = 13
            Top = 18
            Width = 62
            Height = 17
            Caption = 'Do Dia'
            TabOrder = 0
          end
          object Rb_Aniv_Semana: TRadioButton
            Left = 87
            Top = 17
            Width = 81
            Height = 17
            Caption = 'Da Semana'
            TabOrder = 1
          end
          object Rb_Aniv_Mes: TRadioButton
            Left = 192
            Top = 17
            Width = 61
            Height = 17
            Caption = 'Do M'#234's'
            TabOrder = 2
          end
          object E_Aniv_DataIni: TMaskEdit
            Left = 374
            Top = 15
            Width = 40
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            EditMask = '!99/99;1;_'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 5
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 3
            Text = '  /  '
          end
          object E_Aniv_DataFim: TMaskEdit
            Left = 519
            Top = 17
            Width = 40
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            EditMask = '!99/99;1;_'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 5
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
            Text = '  /  '
          end
          object ChBx_Aniver: TCheckBox
            Left = 8
            Top = 49
            Width = 409
            Height = 17
            Caption = 'Abrir a tela de aniversariantes ao executar o programa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
        end
        object Chbx_dt_Padrao: TCheckBox
          Left = 8
          Top = 80
          Width = 386
          Height = 17
          Caption = 
            'Marcar campo data  para Telas de Pesquisas que contenham este pa' +
            'rametro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Btn_Ap_1: TButton
          Left = 498
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 4
          OnClick = Btn_Ap_1Click
        end
      end
    end
    object Tbs_OrdemServico: TTabSheet
      Caption = 'Ordem de Servi'#231'o'
      ImageIndex = 6
      OnShow = Tbs_OrdemServicoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Btn_Ok_3: TButton
          Left = 344
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_Ok_3Click
        end
        object Button10: TButton
          Left = 423
          Top = 349
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Button10Click
        end
        object Btn_Ap_3: TButton
          Left = 498
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Btn_Ap_3Click
        end
        object PageControl1: TPageControl
          Left = 2
          Top = 2
          Width = 582
          Height = 341
          ActivePage = TabSheet1
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 3
          object TabSheet1: TTabSheet
            Caption = 'Auto Center'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 574
              Height = 313
              Align = alClient
              Caption = 'Op'#231#245'es para Auto-Center e Similares'
              TabOrder = 0
              object Label11: TLabel
                Left = 9
                Top = 38
                Width = 185
                Height = 14
                Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object ChBx_Placa: TCheckBox
                Left = 7
                Top = 18
                Width = 448
                Height = 17
                Caption = 'Mostrar consulta por placa na tela principal do sistema'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object Cb_ImpOrdemServico: TComboBox
                Left = 6
                Top = 53
                Width = 466
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 1
                Text = 'MODELO 1 - NORMAL'
                Items.Strings = (
                  'MODELO 1 - NORMAL'
                  'MODELO 2 - EXPANDIDO')
              end
            end
          end
        end
      end
    end
    object Tbs_Impressao: TTabSheet
      Caption = 'Impress'#227'o'
      ImageIndex = 8
      OnShow = Tbs_ImpressaoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Label59: TLabel
          Left = 8
          Top = 123
          Width = 179
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Cupom'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label60: TLabel
          Left = 242
          Top = 123
          Width = 62
          Height = 14
          Caption = 'N'#250'mero Vias'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label61: TLabel
          Left = 307
          Top = 124
          Width = 92
          Height = 14
          Caption = 'Tipo de Impressora'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label62: TLabel
          Left = 521
          Top = 124
          Width = 39
          Height = 14
          Caption = 'Colunas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object ChBx_Vis_Relatorio: TCheckBox
          Left = 6
          Top = 6
          Width = 448
          Height = 17
          Caption = 
            'Visualizar os Relat'#243'rios Antes de Imprimi-los  - Com exce'#231#227'o dos' +
            ' impress'#245'es no modo Texto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ChBx_Cupom: TCheckBox
          Left = 6
          Top = 22
          Width = 448
          Height = 17
          Caption = 
            'Uso Impressora Tipo Cupom e quero imprimir Automaticamente ap'#243's ' +
            'o faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Btn_Ok_4: TButton
          Left = 346
          Top = 348
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 2
          OnClick = Btn_Ok_4Click
        end
        object Btn_Cn_4: TButton
          Left = 425
          Top = 348
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 3
        end
        object Btn_Ap_4: TButton
          Left = 500
          Top = 348
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 4
          OnClick = Btn_Ap_4Click
        end
        object Chb_ImpSalto: TCheckBox
          Left = 6
          Top = 38
          Width = 156
          Height = 16
          Caption = 'Ejetar Folha ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object Chb_ImpCondensa: TCheckBox
          Left = 6
          Top = 54
          Width = 212
          Height = 16
          Caption = 'Condensa Itens da Impress'#227'o dos Itens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object GroupBox24: TGroupBox
          Left = 5
          Top = 74
          Width = 300
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object E_PortaImpressao: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object E_SaltoImpressao: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object E_Cpm_Modelo: TComboBox
          Left = 7
          Top = 137
          Width = 231
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 8
          Text = 'MODELO 1  - MATRICIAL'
          Items.Strings = (
            'MODELO 1  - MATRICIAL'
            'MODELO 2  - T'#201'RMICA'
            'MODELO 3 - MATRICIAL KAROLI')
        end
        object E_Cpm_Nr_Vias: TEdit_Setes
          Left = 241
          Top = 137
          Width = 63
          Height = 21
          Alignment = taRightJustify
          TabOrder = 9
          Text = ''
        end
        object Cb_Cpm_TipoImpressora: TComboBox
          Left = 308
          Top = 138
          Width = 213
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 10
          Text = 'Epson'
          Items.Strings = (
            'Bobina'
            'Epson'
            'Grafico'
            'HP'
            'Personalizado'
            'Rima')
        end
        object E_Cpm_Colunas: TEdit_Setes
          Left = 522
          Top = 137
          Width = 48
          Height = 21
          TabOrder = 11
          Text = '50'
        end
        object Rg_Rdp_Fte_Padrao: TRadioGroup
          Left = 8
          Top = 164
          Width = 91
          Height = 127
          Caption = 'Fonte Padr'#227'o'
          ItemIndex = 0
          Items.Strings = (
            'Normal'
            'Comp 12'
            'Comp 15'
            'Comp 17'
            'Comp 20')
          TabOrder = 12
        end
      end
    end
    object Tbs_Produto: TTabSheet
      Caption = 'Produtos'
      ImageIndex = 7
      OnShow = Tbs_ProdutoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Chbx_CodigoExato: TCheckBox
          Left = 6
          Top = 6
          Width = 500
          Height = 17
          Caption = 'Ativar busca por c'#243'digo exato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ChBx_Distingue_Produto: TCheckBox
          Left = 6
          Top = 22
          Width = 500
          Height = 17
          Caption = 
            'Fazer distin'#231#227'o de Produtos entre Acabado e Mat'#233'ria-Prima nas op' +
            'era'#231#245'es de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Btn_Ok_5: TButton
          Left = 344
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 2
          OnClick = Btn_Ok_5Click
        end
        object Btn_Cn_5: TButton
          Left = 423
          Top = 349
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 3
        end
        object Btn_Ap_5: TButton
          Left = 498
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 4
          OnClick = Btn_Ap_5Click
        end
      end
    end
    object tbs_pedidos: TTabSheet
      Caption = 'Pedido(s)'
      ImageIndex = 8
      OnShow = tbs_pedidosShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 0
        Top = 344
        Width = 586
        Height = 35
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          35)
        object Btn_Ok_9: TButton
          Left = 344
          Top = 5
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_Ok_9Click
        end
        object Btn_Cn_9: TButton
          Left = 423
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
        end
        object Btn_Ap_9: TButton
          Left = 498
          Top = 5
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Btn_Ap_9Click
        end
      end
      object pg_pedidos: TPageControl
        Left = 0
        Top = 0
        Width = 586
        Height = 344
        ActivePage = tbs_controle_compra
        Align = alClient
        TabOrder = 1
        OnChange = pg_pedidosChange
        object tbs_controle_compra: TTabSheet
          Caption = 'Controle de Compra'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label41: TLabel
            Left = 7
            Top = 85
            Width = 203
            Height = 14
            Caption = 'Modelos de Impress'#227'o - Estilo Laser / Jato'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 8
            Top = 50
            Width = 185
            Height = 14
            Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object cbx_modeloLaser_cpa: TComboBox
            Left = 7
            Top = 99
            Width = 466
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Modelo 1 - Simples'
              'Modelo 2 - Paisagem '
              'Modelo 3 - G'#234'nio Ferramentas')
          end
          object rdg_PedCpa_Imp: TRadioGroup
            Left = 4
            Top = 2
            Width = 270
            Height = 46
            Caption = 'Imprimir Pedido em Impressora'
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Matricial'
              'Jato / Laser'
              'Ambos')
            ParentFont = False
            TabOrder = 1
          end
          object GroupBox16: TGroupBox
            Left = 266
            Top = 2
            Width = 295
            Height = 46
            Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            object e_porta_ImpCpa: TEdit
              Left = 7
              Top = 19
              Width = 227
              Height = 21
              TabOrder = 0
            end
            object e_salto_cpa: TEdit_Setes
              Left = 237
              Top = 19
              Width = 52
              Height = 21
              Alignment = taRightJustify
              TabOrder = 1
              Text = ''
            end
          end
          object cbx_modeloMat_cpa: TComboBox
            Left = 6
            Top = 63
            Width = 466
            Height = 21
            Style = csDropDownList
            TabOrder = 3
            Items.Strings = (
              'MODELO 1 - NORMAL')
          end
          object GroupBox17: TGroupBox
            Left = 474
            Top = 58
            Width = 87
            Height = 60
            Caption = 'Itens por Folha'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            object e_itens_cpa: TEdit_Setes
              Left = 7
              Top = 19
              Width = 74
              Height = 21
              Alignment = taRightJustify
              TabOrder = 0
              Text = ''
            end
          end
        end
        object tbs_controle_Frente: TTabSheet
          Caption = 'Frente de Caixa'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 578
            Height = 316
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label48: TLabel
              Left = 5
              Top = 47
              Width = 185
              Height = 14
              Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label49: TLabel
              Left = 287
              Top = 46
              Width = 184
              Height = 14
              Caption = 'Modelos de Impress'#227'o - Estilo T'#233'rmica'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label53: TLabel
              Left = 6
              Top = 141
              Width = 214
              Height = 14
              Caption = 'Selecione a Tabela de Venda ao Consumidor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label56: TLabel
              Left = 287
              Top = 141
              Width = 216
              Height = 14
              Caption = 'Selecione a Tabela de Venda ao Revendedor'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label47: TLabel
              Left = 287
              Top = 177
              Width = 92
              Height = 14
              Caption = 'Tipo de Impressora'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label57: TLabel
              Left = 514
              Top = 177
              Width = 39
              Height = 14
              Caption = 'Colunas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object cbx_modeloMat_Frt: TComboBox
              Left = 5
              Top = 61
              Width = 280
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              Items.Strings = (
                'MODELO 1  - NORMAL')
            end
            object cbx_modeloTer_frt: TComboBox
              Left = 285
              Top = 60
              Width = 280
              Height = 21
              Style = csDropDownList
              TabOrder = 1
              Items.Strings = (
                'MODELO 1  - NORMAL'
                'MODELO 2 - 30 COLUNAS')
            end
            object ChBx_DesativaECF: TCheckBox
              Left = 5
              Top = 180
              Width = 267
              Height = 17
              Caption = 'Desativar o Emissor de Cupom Fiscal'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object GroupBox13: TGroupBox
              Left = 5
              Top = 85
              Width = 561
              Height = 55
              Caption = 'Controle Gaveta de Dinheiro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              object Label50: TLabel
                Left = 5
                Top = 13
                Width = 35
                Height = 13
                Caption = 'Modelo'
              end
              object Label51: TLabel
                Left = 151
                Top = 13
                Width = 54
                Height = 13
                Caption = 'Porta Serial'
              end
              object Label52: TLabel
                Left = 242
                Top = 13
                Width = 85
                Height = 13
                Caption = 'String de Abertura'
              end
              object Label55: TLabel
                Left = 430
                Top = 13
                Width = 123
                Height = 13
                Caption = 'A'#231#227'o abertura antecipada'
              end
              object Cb_Gvta_modelo: TComboBox
                Left = 5
                Top = 26
                Width = 145
                Height = 21
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemIndex = 2
                ParentFont = False
                TabOrder = 0
                Text = 'gavNenhuma'
                Items.Strings = (
                  'gavImpressoraComum'
                  'gavImpressoraECF'
                  'gavNenhuma'
                  'gavSerialGerbo'
                  'gavSerialMenno')
              end
              object Cb_Gvta_porta: TComboBox
                Left = 151
                Top = 26
                Width = 90
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                Text = 'COM1'
                Items.Strings = (
                  'COM1'
                  'COM2'
                  'COM3'
                  'COM4'
                  'COM5'
                  'COM6'
                  'COM7'
                  'COM8')
              end
              object Cb_Gvta_StrAbertura: TComboBox
                Left = 242
                Top = 26
                Width = 185
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                Items.Strings = (
                  ''
                  '#027,v,#140 | Bematech'
                  '#254 | Daruma'
                  '#027,p,0,#050,#200 | Mecaf'
                  '#027,p,#000,#050,#200 | Schalter'
                  'Impressora Epson (via Impress'#227'o)')
              end
              object Cb_Gvta_AcaoAntecip: TComboBox
                Left = 430
                Top = 26
                Width = 128
                Height = 21
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                Items.Strings = (
                  'aaAguardar'
                  'aaException'
                  'aaIgnorar')
              end
            end
            object Dblcb_TabelasConsumidor: TDBLookupComboBox
              Left = 5
              Top = 155
              Width = 280
              Height = 21
              KeyField = 'TPR_CODIGO'
              ListField = 'TPR_NOME'
              TabOrder = 4
            end
            object Dblcb_TabelasRevendedor: TDBLookupComboBox
              Left = 285
              Top = 155
              Width = 280
              Height = 21
              KeyField = 'TPR_CODIGO'
              ListField = 'TPR_NOME'
              TabOrder = 5
            end
            object rdg_PedfRT_Imp: TGroupBox
              Left = 5
              Top = 2
              Width = 264
              Height = 45
              Caption = 'Imprimir Pedido em Impressora'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              object RB_ImpMatricial_Frt: TRadioButton
                Left = 5
                Top = 20
                Width = 68
                Height = 17
                Caption = 'Matricial'
                TabOrder = 0
              end
              object RB_ImpTermica_Frt: TRadioButton
                Left = 78
                Top = 20
                Width = 62
                Height = 17
                Caption = 'T'#233'rmica'
                TabOrder = 1
              end
              object RB_ImpPedido_Frt: TRadioButton
                Left = 149
                Top = 20
                Width = 106
                Height = 17
                Caption = 'Pedido de Venda'
                TabOrder = 2
              end
            end
            object GroupBox27: TGroupBox
              Left = 272
              Top = 2
              Width = 295
              Height = 46
              Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              object e_salto_Frt: TEdit_Setes
                Left = 237
                Top = 19
                Width = 52
                Height = 21
                Alignment = taRightJustify
                TabOrder = 0
                Text = ''
              end
              object e_porta_Frt: TEdit
                Left = 7
                Top = 19
                Width = 227
                Height = 21
                TabOrder = 1
              end
            end
            object Chb_ImpCupom: TCheckBox
              Left = 5
              Top = 196
              Width = 267
              Height = 16
              Caption = 'Imprimir Cupom na Frente de Caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object Chb_Visualiza_Cupom: TCheckBox
              Left = 5
              Top = 211
              Width = 267
              Height = 16
              Caption = 'Visualizar Cupom antes de Imprimir'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object ChBx_CodigoBarra: TCheckBox
              Left = 5
              Top = 226
              Width = 267
              Height = 17
              Caption = 'Imprimir C'#243'digo de Barras no Cupom'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object Chbx_ProdutoAvulso: TCheckBox
              Left = 5
              Top = 242
              Width = 267
              Height = 17
              Caption = 'Utilizar produto avulso para lan'#231'ar no caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object Cb_TipoImpressora: TComboBox
              Left = 288
              Top = 191
              Width = 221
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 12
              Text = 'Bobina'
              Items.Strings = (
                'Bobina'
                'Epson'
                'Grafico'
                'HP'
                'Personalizado'
                'Rima')
            end
            object E_Nr_Colunas: TEdit_Setes
              Left = 512
              Top = 190
              Width = 52
              Height = 21
              TabOrder = 13
              Text = '50'
            end
            object ChBx_UsarCodigoFAb: TCheckBox
              Left = 5
              Top = 258
              Width = 283
              Height = 17
              Caption = 'No c'#243'digo reduzido usar o N'#186' Fabrica'#231#227'o / Montadora'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object ChBx_Imp_Item_Checkout: TCheckBox
              Left = 5
              Top = 274
              Width = 395
              Height = 17
              Caption = 
                'Utilizar sistem'#225'tica de impress'#227'o item a item na leitura do prod' +
                'uto no checkout'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object ChBx_InformaValor: TCheckBox
              Left = 5
              Top = 291
              Width = 278
              Height = 17
              Caption = 'Ativa Digita'#231#227'o do Valor e Peso na Frente de Caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
            end
          end
        end
        object tbs_controle_Pizzaria: TTabSheet
          Caption = 'Pizzaria'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel15: TPanel
            Left = 0
            Top = 0
            Width = 578
            Height = 316
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object Label5: TLabel
              Left = 5
              Top = 48
              Width = 185
              Height = 14
              Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 287
              Top = 48
              Width = 184
              Height = 14
              Caption = 'Modelos de Impress'#227'o - Estilo T'#233'rmica'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object rdg_PedPiz_Imp: TGroupBox
              Left = 5
              Top = 3
              Width = 172
              Height = 45
              Caption = 'Imprimir Pedido em Impressora'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object RB_ImpMatricial_Piz: TRadioButton
                Left = 5
                Top = 20
                Width = 68
                Height = 17
                Caption = 'Matricial'
                TabOrder = 0
              end
              object RB_ImpTermica_Piz: TRadioButton
                Left = 78
                Top = 20
                Width = 62
                Height = 17
                Caption = 'T'#233'rmica'
                TabOrder = 1
              end
            end
            object GroupBox29: TGroupBox
              Left = 181
              Top = 3
              Width = 392
              Height = 46
              Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object e_salto_Piz: TEdit_Setes
                Left = 334
                Top = 19
                Width = 52
                Height = 21
                Alignment = taRightJustify
                TabOrder = 0
                Text = ''
              end
              object e_porta_Piz: TEdit
                Left = 7
                Top = 19
                Width = 322
                Height = 21
                TabOrder = 1
              end
            end
            object cbx_modeloMat_Piz: TComboBox
              Left = 5
              Top = 62
              Width = 277
              Height = 21
              Style = csDropDownList
              TabOrder = 2
              Items.Strings = (
                'MODELO 1  - NORMAL')
            end
            object cbx_modeloTer_Piz: TComboBox
              Left = 285
              Top = 62
              Width = 287
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              Items.Strings = (
                'MODELO 1  - NORMAL')
            end
            object GroupBox22: TGroupBox
              Left = 384
              Top = 87
              Width = 185
              Height = 58
              Caption = 'Tratar string Identificador'
              TabOrder = 4
              object Label18: TLabel
                Left = 4
                Top = 16
                Width = 25
                Height = 13
                Caption = 'Inicio'
              end
              object Label63: TLabel
                Left = 54
                Top = 16
                Width = 45
                Height = 13
                Caption = 'Tamanho'
              end
              object E_Tra_Str_Ini_Piz: TEdit
                Left = 4
                Top = 31
                Width = 46
                Height = 21
                TabOrder = 0
              end
              object E_Tra_Str_Tam_Piz: TEdit
                Left = 53
                Top = 31
                Width = 49
                Height = 21
                TabOrder = 1
              end
            end
          end
        end
      end
    end
    object tbs_orcamento: TTabSheet
      Caption = 'Or'#231'amento'
      ImageIndex = 10
      OnShow = tbs_orcamentoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Label13: TLabel
          Left = 7
          Top = 52
          Width = 185
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 8
          Top = 91
          Width = 203
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Laser / Jato'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Btn_Ok_11: TButton
          Left = 344
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_Ok_11Click
        end
        object Btn_Cn_11: TButton
          Left = 423
          Top = 349
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Btn_Cn_11Click
        end
        object Btn_Ap_11: TButton
          Left = 498
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Btn_Ap_11Click
        end
        object rdg_PedOrc_Imp: TRadioGroup
          Left = 4
          Top = 2
          Width = 270
          Height = 46
          Caption = 'Imprimir Pedido em Impressora'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Matricial'
            'Jato / Laser'
            'Ambos')
          ParentFont = False
          TabOrder = 3
        end
        object GroupBox19: TGroupBox
          Left = 277
          Top = 2
          Width = 295
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          object e_porta_ImpOrc: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object e_salto_Orc: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object GroupBox21: TGroupBox
          Left = 482
          Top = 51
          Width = 87
          Height = 60
          Caption = 'Itens por Folha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object e_itens_oRC: TEdit_Setes
            Left = 7
            Top = 19
            Width = 74
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
        object Cbx_TipoMatric: TComboBox
          Left = 7
          Top = 67
          Width = 466
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          Items.Strings = (
            'MODELO 1'
            'MODELO 2')
        end
        object Cbx_TipoLaser: TComboBox
          Left = 6
          Top = 107
          Width = 470
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            'MODELO 1 -  NORMAL'
            'MODELO 2 -  NORMAL(COM INFORMA'#199'AO DO VEICULO)'
            'MODELO 3  - EXTFORMA'
            'MODELO 4  - EXTIMPLAS'
            'MODELO 5  - RICAMO'
            'MODELO 6  - IMPRIMARK'
            'MODELO 7 - G'#202'NIO'
            'MODELO 8 - S'#195'O LUIZ EXTINTORES')
        end
      end
    end
    object Tbs_Balanca: TTabSheet
      Caption = 'Balan'#231'a'
      ImageIndex = 9
      OnShow = Tbs_BalancaShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 379
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          379)
        object Label30: TLabel
          Left = 194
          Top = 100
          Width = 77
          Height = 13
          Caption = 'Ultima Resposta'
        end
        object Label31: TLabel
          Left = 194
          Top = 55
          Width = 82
          Height = 13
          Caption = 'Ultimo Peso Lido:'
        end
        object Label32: TLabel
          Left = 378
          Top = 246
          Width = 40
          Height = 13
          Caption = 'TimeOut'
        end
        object Label33: TLabel
          Left = 194
          Top = 153
          Width = 52
          Height = 13
          Caption = 'Mensagem'
        end
        object btnConectar: TButton
          Left = 192
          Top = 29
          Width = 92
          Height = 25
          Caption = 'Ativar'
          TabOrder = 0
          OnClick = btnConectarClick
        end
        object btnDesconectar: TButton
          Left = 284
          Top = 29
          Width = 92
          Height = 25
          Caption = 'Desativar'
          Enabled = False
          TabOrder = 1
          OnClick = btnDesconectarClick
        end
        object btnLerPeso: TButton
          Left = 376
          Top = 29
          Width = 92
          Height = 25
          Caption = 'Ler Peso'
          Enabled = False
          TabOrder = 2
          OnClick = btnLerPesoClick
        end
        object sttPeso: TStaticText
          Left = 194
          Top = 71
          Width = 233
          Height = 24
          AutoSize = False
          BevelKind = bkTile
          Caption = '0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object sttResposta: TStaticText
          Left = 194
          Top = 117
          Width = 233
          Height = 36
          AutoSize = False
          BevelKind = bkTile
          Caption = 'sttResposta'
          TabOrder = 4
        end
        object E_Timer: TEdit_Setes
          Left = 378
          Top = 262
          Width = 73
          Height = 21
          Alignment = taRightJustify
          TabOrder = 5
          Text = '2000'
        end
        object chbMonitorar: TCheckBox
          Left = 378
          Top = 225
          Width = 233
          Height = 17
          Caption = 'Monitorar a Balan'#231'a'
          TabOrder = 6
        end
        object Memo3: TMemo
          Left = 194
          Top = 173
          Width = 231
          Height = 42
          TabOrder = 7
        end
        object Panel11: TPanel
          Left = 8
          Top = 8
          Width = 177
          Height = 321
          BevelOuter = bvLowered
          TabOrder = 8
          object Label40: TLabel
            Left = 16
            Top = 6
            Width = 39
            Height = 13
            Caption = 'Balanca'
          end
          object Label10: TLabel
            Left = 16
            Top = 49
            Width = 54
            Height = 13
            Caption = 'Porta Serial'
          end
          object Label42: TLabel
            Left = 16
            Top = 92
            Width = 46
            Height = 13
            Caption = 'Baud rate'
          end
          object Label43: TLabel
            Left = 16
            Top = 137
            Width = 43
            Height = 13
            Caption = 'Data Bits'
          end
          object Label44: TLabel
            Left = 16
            Top = 181
            Width = 26
            Height = 13
            Caption = 'Parity'
          end
          object Label45: TLabel
            Left = 16
            Top = 271
            Width = 63
            Height = 13
            Caption = 'Handshaking'
          end
          object Label46: TLabel
            Left = 16
            Top = 224
            Width = 42
            Height = 13
            Caption = 'Stop Bits'
          end
          object Cb_Tipo_Balanca: TComboBox
            Left = 16
            Top = 22
            Width = 145
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Nenhuma'
              'Filizola'
              'Toledo'
              'Urano')
          end
          object Cb_Porta_Serial: TComboBox
            Left = 16
            Top = 65
            Width = 145
            Height = 21
            TabOrder = 1
            Text = 'COM1'
            Items.Strings = (
              'COM1'
              'COM2'
              'COM3'
              'COM4'
              'COM5'
              'COM6'
              'COM7'
              'COM8')
          end
          object Cb_Baud_Rate: TComboBox
            Left = 16
            Top = 110
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemIndex = 6
            TabOrder = 2
            Text = '9600'
            Items.Strings = (
              '110'
              '300'
              '600'
              '1200'
              '2400'
              '4800'
              '9600'
              '14400'
              '19200'
              '38400'
              '56000'
              '57600')
          end
          object Cb_Data_Bits: TComboBox
            Left = 16
            Top = 153
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemIndex = 3
            TabOrder = 3
            Text = '8'
            Items.Strings = (
              '5'
              '6'
              '7'
              '8')
          end
          object Cb_HandShaking: TComboBox
            Left = 16
            Top = 289
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 6
            Text = 'Nenhum'
            Items.Strings = (
              'Nenhum'
              'XON/XOFF'
              'RTS/CTS'
              'DTR/DSR')
          end
          object Cb_Paridade: TComboBox
            Left = 16
            Top = 198
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 4
            Text = 'none'
            Items.Strings = (
              'none'
              'odd'
              'even'
              'mark'
              'space')
          end
          object Cb_BitsParada: TComboBox
            Left = 16
            Top = 242
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 5
            Text = 's1'
            Items.Strings = (
              's1'
              's1,5'
              's2'
              '')
          end
        end
        object chbx_Balanca: TCheckBox
          Left = 192
          Top = 7
          Width = 145
          Height = 17
          Caption = 'Ativar o Uso da Balan'#231'a'
          TabOrder = 9
        end
        object Button5: TButton
          Left = 468
          Top = 29
          Width = 92
          Height = 25
          Caption = 'Registrar TARA'
          Enabled = False
          TabOrder = 10
          OnClick = Button5Click
        end
        object Btn_Ok_12: TButton
          Left = 344
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 11
          OnClick = Btn_Ok_12Click
        end
        object Btn_Cn_12: TButton
          Left = 423
          Top = 349
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 12
        end
        object Btn_AP_12: TButton
          Left = 498
          Top = 349
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 13
          OnClick = Btn_AP_12Click
        end
        object GroupBox28: TGroupBox
          Left = 192
          Top = 218
          Width = 180
          Height = 89
          Caption = 'C'#243'digo de Barras da Balan'#231'a'
          TabOrder = 14
          object Label64: TLabel
            Left = 9
            Top = 32
            Width = 148
            Height = 13
            Caption = 'N'#250'meros de Caracter por Bloco'
          end
          object Label65: TLabel
            Left = 6
            Top = 47
            Width = 73
            Height = 13
            Caption = 'C'#243'digo Produto'
          end
          object Lb_blc_bar_Preco_Peso: TLabel
            Left = 86
            Top = 48
            Width = 57
            Height = 13
            Caption = 'Pre'#231'o/Peso'
          end
          object Rb_bal_bar_Peso: TRadioButton
            Left = 7
            Top = 16
            Width = 51
            Height = 17
            Caption = 'Peso'
            TabOrder = 0
            OnClick = Rb_bal_bar_PesoClick
          end
          object Rb_bal_bar_Preco: TRadioButton
            Left = 79
            Top = 16
            Width = 51
            Height = 17
            Caption = 'Pre'#231'o'
            TabOrder = 1
            OnClick = Rb_bal_bar_PrecoClick
          end
          object E_bal_bar_Cd_Produto: TEdit_Setes
            Left = 6
            Top = 61
            Width = 74
            Height = 21
            TabOrder = 2
            Text = ''
          end
          object E_bal_bar_Preco_Peso: TEdit_Setes
            Left = 85
            Top = 61
            Width = 86
            Height = 21
            TabOrder = 3
            Text = ''
          end
        end
      end
    end
  end
  object OpenDialogo: TOpenDialog
    Left = 300
    Top = 121
  end
  object Act_Acoes: TActionList
    Left = 468
    Top = 106
    object Act_Diversos: TAction
      Caption = 'Configura'#231#245'es Gerais '
      ShortCut = 8238
    end
  end
  object Balanca: TACBrBAL
    Modelo = balUrano
    Porta = 'COM1'
    Left = 504
    Top = 104
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    Left = 361
    Top = 134
  end
  object ACBrGAV1: TACBrGAV
    Porta = 'COM1'
    AberturaAntecipada = aaIgnorar
    Left = 538
    Top = 104
  end
end

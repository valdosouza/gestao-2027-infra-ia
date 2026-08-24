object Fr_Configuracao: TFr_Configuracao
  Left = 397
  Top = 49
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es Gerais '
  ClientHeight = 602
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Configuracao: TPageControl
    Left = 0
    Top = 0
    Width = 594
    Height = 602
    ActivePage = Tbs_Geral
    Align = alClient
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    object Tbs_Geral: TTabSheet
      Caption = 'Geral'
      ImageIndex = 2
      OnShow = Tbs_GeralShow
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object lb_qtd_itens: TLabel
          Left = 11
          Top = 78
          Width = 117
          Height = 13
          Caption = 'N'#250'mero de Itens na NFE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 486
          Top = 168
          Width = 74
          Height = 13
          Caption = 'R$ Vale Cupom'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Btn_Ok_1: TButton
          Left = 344
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_OK_1Click
        end
        object Btn_Cn_1: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Btn_Cn_1Click
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
        object Chbx_Conserto: TCheckBox
          Left = 8
          Top = 151
          Width = 400
          Height = 17
          Caption = 'Ativar Tarefa de Conserto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = Chbx_DevolucaoClick
        end
        object Chbx_dt_Padrao: TCheckBox
          Left = 8
          Top = 121
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
          TabOrder = 4
        end
        object GroupBox1: TGroupBox
          Left = 164
          Top = 75
          Width = 404
          Height = 44
          Caption = 'Nome do V'#237'nculo para Atualiza'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object E_Atualizador: TEdit
            Left = 6
            Top = 17
            Width = 391
            Height = 21
            TabOrder = 0
          end
        end
        object chk_cliente_cpf: TCheckBox
          Left = 8
          Top = 167
          Width = 400
          Height = 17
          Caption = 'Efetuar Valida'#231#227'o de CPF ou CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object rg_pessoaPredominante: TRadioGroup
          Left = 8
          Top = 345
          Width = 185
          Height = 49
          Caption = 'Tipo de Pessoa Predominante:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Pessoa F'#237'sica'
            'Pessoa Jur'#237'dica')
          ParentFont = False
          TabOrder = 7
        end
        object Btn_Ap_1: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 8
          OnClick = Btn_Ap_1Click
        end
        object ed_qtd_nfe: TEdit_Setes
          Left = 12
          Top = 92
          Width = 76
          Height = 21
          TabOrder = 9
          Text = ''
        end
        object Chbx_Devolucao: TCheckBox
          Left = 8
          Top = 184
          Width = 400
          Height = 17
          Caption = 'Ativar Tarefa de Devolu'#231#227'o de Mercadoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = Chbx_DevolucaoClick
        end
        object GpB_Devolucao: TGroupBox
          Left = 432
          Top = 121
          Width = 139
          Height = 45
          Caption = 'Produto Para Devolu'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          object Sb_Produto: TSpeedButton
            Left = 110
            Top = 16
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = Sb_ProdutoClick
          end
          object E_Cd_Produto: TEdit_Setes
            Left = 9
            Top = 15
            Width = 95
            Height = 21
            TabOrder = 0
            Text = ''
          end
        end
        object chbx_Pesq_CodBarra: TCheckBox
          Left = 8
          Top = 136
          Width = 386
          Height = 17
          Caption = 'Dar prefer'#234'ncia pelo C'#243'digo de Barra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object ed_vl_cupom: TEdit_Setes
          Left = 492
          Top = 184
          Width = 65
          Height = 21
          Alignment = taRightJustify
          TabOrder = 13
          Text = ''
        end
        object chbx_email_auto: TCheckBox
          Left = 8
          Top = 215
          Width = 400
          Height = 17
          Caption = 'Enviar E-mail autom'#225'tico apos Autoriza'#231#227'o.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object rg_ClientePredominante: TRadioGroup
          Left = 194
          Top = 345
          Width = 185
          Height = 49
          Caption = 'Tipo de Cliente Predominante:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Cosumidor Final'
            'Revendedor')
          ParentFont = False
          TabOrder = 15
        end
        object Chbx_Troca: TCheckBox
          Left = 9
          Top = 199
          Width = 400
          Height = 17
          Caption = 'Ativar Tarefa de Troca de Mercadoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnClick = Chbx_DevolucaoClick
        end
        object ChBx_MostraEstabelecimento: TCheckBox
          Left = 8
          Top = 246
          Width = 425
          Height = 17
          Caption = 'Mostrar dados da Empresa no Pedido e na Ordem de Servi'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object Chbx_Decreto108352014: TCheckBox
          Left = 8
          Top = 262
          Width = 425
          Height = 17
          Caption = 
            'Meus produtos est'#227'o contemplados no decreto 10.835/2014 - MVA Re' +
            'duzida'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object Chbx_MultiEmpresaMostraTodas: TCheckBox
          Left = 9
          Top = 278
          Width = 425
          Height = 17
          Caption = 
            'Para casos de Multi-Empresa, nas pesquisas mostrar todas as empr' +
            'esas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object Chbx_Cli_Ctrl_Email: TCheckBox
          Left = 9
          Top = 397
          Width = 425
          Height = 17
          Caption = 
            'Validar cadastro de clientes n'#227'o permitindo cadastro duplo de e-' +
            'mail'#39's'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object Chbx_Cli_Ctrl_Fone: TCheckBox
          Left = 9
          Top = 413
          Width = 425
          Height = 17
          Caption = 
            'Validar cadastro de clientes n'#227'o permitindo cadastro duplo de te' +
            'lefones'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object Chbx_MultiEmpresaEscolheNFe: TCheckBox
          Left = 9
          Top = 294
          Width = 425
          Height = 17
          Caption = 
            'Para casos de Multi-Empresa,  Escolher em qual delas ser'#225' emitid' +
            'a a NF-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object ChBx_ImpostoAproximado: TCheckBox
          Left = 9
          Top = 309
          Width = 425
          Height = 17
          Caption = 
            'Informar automaticamente o valor aproximado dos impostos  - Lei ' +
            'n'#186' 12.741 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
        end
        object ChBx_EmailSistemaNfe: TCheckBox
          Left = 8
          Top = 230
          Width = 400
          Height = 17
          Caption = 
            'Utilizar email do sistema para opera'#231#245'es da Nota Fiscal Eletr'#244'ni' +
            'ca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
        end
        object ChBx_Vend_List_cliente: TCheckBox
          Left = 10
          Top = 324
          Width = 425
          Height = 17
          Caption = 
            'Restringir visualiza'#231#227'o de clientes conforme carteira do vendedo' +
            'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 25
        end
        object GroupBox19: TGroupBox
          Left = 426
          Top = 211
          Width = 139
          Height = 45
          Caption = 'C'#243'digo Terminal WEb'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 26
          object E_Terminal: TEdit_Setes
            Left = 9
            Top = 15
            Width = 123
            Height = 21
            TabOrder = 0
            Text = ''
          end
        end
        object Chbx_PAF_NFC_E: TCheckBox
          Left = 9
          Top = 429
          Width = 425
          Height = 17
          Caption = 'Ativar o PAF-NFC-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 27
        end
        object chbx_enable_notification: TCheckBox
          Left = 9
          Top = 446
          Width = 425
          Height = 17
          Caption = 'Ativar notifica'#231#227'o na '#225'rea de trabalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 28
        end
        object chbx_Reforma_tributaria: TCheckBox
          Left = 9
          Top = 463
          Width = 425
          Height = 17
          Caption = 'Ativar Reforma Tribut'#225'ria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 29
        end
      end
    end
    object Tbs_Financeiro: TTabSheet
      Caption = 'Financeiro'
      ImageIndex = 4
      OnShow = Tbs_FinanceiroShow
      object Sb_FN_Ok: TButton
        Left = 405
        Top = 428
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 0
      end
      object Sb_FN_Cancelar: TButton
        Left = 482
        Top = 428
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 1
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          586
          556)
        object GroupBox11: TGroupBox
          Left = 2
          Top = 2
          Width = 582
          Height = 61
          Align = alTop
          Caption = 'Cobran'#231'a de Multas e Juros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label24: TLabel
            Left = 112
            Top = 18
            Width = 94
            Height = 13
            Caption = 'Percentual de Juros'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 211
            Top = 18
            Width = 115
            Height = 13
            Caption = 'Car'#234'ncia para Cobran'#231'a'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 92
            Top = 36
            Width = 8
            Height = 13
            Caption = '%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 199
            Top = 36
            Width = 8
            Height = 13
            Caption = '%'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 304
            Top = 36
            Width = 21
            Height = 13
            Caption = 'Dias'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 10
            Top = 18
            Width = 95
            Height = 13
            Caption = 'Percentual da Multa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object E_Multa: TEdit_Setes
            Left = 8
            Top = 32
            Width = 81
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
          object E_Juros: TEdit_Setes
            Left = 111
            Top = 32
            Width = 85
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
          object E_Carencia: TEdit_Setes
            Left = 210
            Top = 32
            Width = 90
            Height = 21
            Alignment = taRightJustify
            TabOrder = 2
            Text = ''
          end
        end
        object Chbx_Ativa_Cobranca: TCheckBox
          Left = 2
          Top = 63
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Ativar Controle de Cobran'#231'a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Chbx_Cheque_Devolvido: TCheckBox
          Left = 2
          Top = 80
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Mostrar Valores Referente a Cheques Devolvidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Chbx_Cheque_PreDatado: TCheckBox
          Left = 2
          Top = 97
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Mostrar Valores Referente a Cheques Pr'#233'-Datado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Chbx_Saldo_Devedor: TCheckBox
          Left = 2
          Top = 114
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Mostrar Valores Referente a Saldo Devedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Chbx_Credito: TCheckBox
          Left = 2
          Top = 131
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Utilizar Forma de Pagamento: "Cr'#233'dito"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object ch_cliente_saldo: TCheckBox
          Left = 2
          Top = 148
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Bloquear Cliente com Saldo devedor acima do limite de Cr'#233'dito'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object chk_Saldo_atraso: TCheckBox
          Left = 2
          Top = 165
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Bloquear Cliente com Saldo devedor em atraso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object Btn_Ok_2: TButton
          Left = 347
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 8
          OnClick = Btn_Ok_2Click
        end
        object Btn_Cn_2: TButton
          Left = 426
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 9
          OnClick = Btn_Cn_1Click
        end
        object Btn_Ap_2: TButton
          Left = 501
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 10
          OnClick = Btn_Ap_2Click
        end
        object Chbx_Val_Ppagto_CP: TCheckBox
          Left = 2
          Top = 199
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Validar Formas de Pagamentos no Contas '#224' Pagar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object Chbx_Val_Ppagto_CR: TCheckBox
          Left = 2
          Top = 182
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Validar Formas de Pagamentos no Contas '#224' Receber'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object ChBx_LiberaDigitacaoBanco: TCheckBox
          Left = 2
          Top = 216
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Liberar a Digita'#231#227'o de valores na tela de Lan'#231'amento Banc'#225'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object Chbx_Fin_FichaCadastral: TCheckBox
          Left = 2
          Top = 233
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Liberar a aba ficha Financeira no Cadastro de cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object chbx_Fin_Referencia: TCheckBox
          Left = 2
          Top = 250
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Liberar a aba de refer'#234'ncias no cadastros de clientes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object Chbx_Fin_BaixaAutomatica: TCheckBox
          Left = 2
          Top = 267
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Efetuar baixa autom'#225'tica dos faturamentos informados em Dinheiro' +
            ' e/ou Cheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object ChBx_MostraTelaFinanceiro: TCheckBox
          Left = 2
          Top = 284
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Mostrar a tela do Financeiro no processo de faturamento da venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object ChBx_DadosCartao: TCheckBox
          Left = 2
          Top = 301
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Tornar obrigat'#243'rio a informa'#231#227'o dos dados do cart'#227'o  no momento ' +
            'do faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object ChBx_DadosCheque: TCheckBox
          Left = 2
          Top = 318
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Tornar obrigat'#243'rio a informa'#231#227'o dos dados do cheque  no momento ' +
            'do faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object ChBx_TEF: TCheckBox
          Left = 2
          Top = 335
          Width = 582
          Height = 17
          Align = alTop
          Caption = 'Ativar TEF (Tranfer'#234'ncia Eletr'#244'nica de Fundos)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object Chbx_Autorizar_Contas_Pagar: TCheckBox
          Left = 2
          Top = 352
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Controlar a baixa do contas '#224' pagar apenas para documentos autor' +
            'izados (usu'#225'rios n'#227'o administradores)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object ChBx_Fat_Vda_Auto_Cta_Ger: TCheckBox
          Left = 2
          Top = 369
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Faturamento de Venda - Deixar autom'#225'tico o plano de contas vincu' +
            'lado com a forma de pagamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object ChBx_Fat_Vda_Auto_Boleto_impressao: TCheckBox
          Left = 2
          Top = 386
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Faturamento de Venda - Gerar boleto automaticamente e mostrar op' +
            #231#227'o para impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
        end
        object ChBx_EnvioBoletoEmail: TCheckBox
          Left = 2
          Top = 403
          Width = 582
          Height = 17
          Align = alTop
          Caption = 
            'Enviar boleto automaticamento ap'#243's a gera'#231#227'o - (Envia apenas a p' +
            'rimeira parcela'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
        end
      end
    end
    object Tbs_OrdemServico: TTabSheet
      Caption = 'Ordem de Servi'#231'o'
      ImageIndex = 6
      OnShow = Tbs_OrdemServicoShow
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label66: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 28
          Width = 576
          Height = 13
          Align = alTop
          Caption = 'M'#243'dulo de Servi'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 92
        end
        object ChBx_Servicos: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 576
          Height = 17
          Align = alTop
          Caption = 'Ativar M'#243'dulo de Servi'#231'os'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = ChBx_ServicosClick
        end
        object PageControl1: TPageControl
          Left = 2
          Top = 71
          Width = 582
          Height = 435
          ActivePage = TabSheet6
          Align = alClient
          TabOrder = 1
          object TabSheet1: TTabSheet
            Caption = 'Auto Center'
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 574
              Height = 407
              Align = alClient
              Caption = 'Op'#231#245'es para Auto-Center e Similares'
              TabOrder = 0
              object Label11: TLabel
                Left = 9
                Top = 137
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
              object ChBx_Veiculo: TCheckBox
                Left = 7
                Top = 18
                Width = 425
                Height = 17
                Caption = 
                  'Tornar obrigat'#243'rio o preenchimento do veiculo caso haja servi'#231'o ' +
                  'incluso'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object ChBx_Placa: TCheckBox
                Left = 7
                Top = 50
                Width = 448
                Height = 17
                Caption = 'Mostrar consulta por placa na tela principal do sistema'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object Chbx_Tecnico: TCheckBox
                Left = 7
                Top = 34
                Width = 425
                Height = 17
                Caption = 'Tornar obrigat'#243'rio o preenchimento do t'#233'cnico'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object Chbx_Instalador_vendedor: TCheckBox
                Left = 7
                Top = 66
                Width = 448
                Height = 17
                Caption = 'Mostrar os Instaladores na mesma lista dos Vendedores'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object Cb_ImpOrdemServico: TComboBox
                Left = 6
                Top = 152
                Width = 466
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 4
                Text = 'MODELO 1 - NORMAL'
                Items.Strings = (
                  'MODELO 1 - NORMAL'
                  'MODELO 2 - EXPANDIDO')
              end
              object ChBx_SistemaAndroid: TCheckBox
                Left = 7
                Top = 82
                Width = 218
                Height = 17
                Caption = 'Utilizo Sistema Mobile em Tablet Android'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object ChBx_Obs_Veiculo_NF: TCheckBox
                Left = 8
                Top = 99
                Width = 374
                Height = 17
                Caption = 'Informar os dados do ve'#237'culo no campo Observa'#231#227'o da Nota Fiscal'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
              object ChBx_NovaVersaoOS: TCheckBox
                Left = 8
                Top = 115
                Width = 374
                Height = 17
                Caption = 'Nova Vers'#227'o de Ordem de Servi'#231'o'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 7
              end
            end
          end
          object TabSheet6: TTabSheet
            Caption = 'Tributa'#231#227'o Servi'#231'os'
            ImageIndex = 3
            object Label58: TLabel
              Left = 3
              Top = 36
              Width = 132
              Height = 13
              Caption = 'C'#243'digo Servi'#231'o (LC 116/03)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label8: TLabel
              Left = 3
              Top = 20
              Width = 355
              Height = 13
              Caption = 'Somente ative esta op'#231#227'o ap'#243's orienta'#231#227'o do seu contabilista'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label69: TLabel
              Left = 3
              Top = 72
              Width = 199
              Height = 13
              Caption = 'C'#243'digo do Regime Especial de Tributa'#231#227'o'
            end
            object Chbx_Nfse_Conjugada: TCheckBox
              Left = 3
              Top = 2
              Width = 293
              Height = 17
              Caption = 'Permitir a emiss'#227'o de Nf-e Conjugada (Servi'#231'os + Pe'#231'as)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object ComboBox3: TComboBox
              Left = 3
              Top = 88
              Width = 241
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 1
              Text = '01 - Microempresa Municipal; '
              Items.Strings = (
                '01 - Microempresa Municipal; '
                '02 - Estimativa;'
                '03 - Sociedade de Profissionais; '
                '04 - Cooperativa;'
                '05 - Microempres'#225'rio Individual (MEI);'
                '06 - Microempres'#225'rio e Empresa de Pequeno Porte (ME/EPP)')
            end
            object E_Nfse_Cd_LC116: TEdit
              Left = 3
              Top = 50
              Width = 130
              Height = 21
              TabOrder = 2
            end
          end
        end
        object Cb_modulo_servico: TComboBox
          AlignWithMargins = True
          Left = 5
          Top = 47
          Width = 576
          Height = 21
          Align = alTop
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            '<<SEM MODULO>>'
            'AUTO CENTER'
            'EXTINTORES'
            'EQUIPAMENTOS ELETR'#212'NICOS'
            'PET SHOP'
            'MOVELEIRO'
            'GR'#193'FICA')
        end
        object Panel20: TPanel
          Left = 2
          Top = 506
          Width = 582
          Height = 48
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 3
          object Btn_Ok_3: TButton
            AlignWithMargins = True
            Left = 340
            Top = 5
            Width = 79
            Height = 38
            Margins.Right = 1
            Align = alRight
            Caption = 'OK'
            TabOrder = 0
            OnClick = Btn_Ok_3Click
          end
          object Button10: TButton
            AlignWithMargins = True
            Left = 421
            Top = 5
            Width = 75
            Height = 38
            Margins.Left = 1
            Margins.Right = 1
            Align = alRight
            Caption = 'Cancelar'
            TabOrder = 1
            OnClick = Btn_Cn_1Click
          end
          object Btn_Ap_3: TButton
            AlignWithMargins = True
            Left = 498
            Top = 5
            Width = 79
            Height = 38
            Margins.Left = 1
            Align = alRight
            Caption = 'Aplicar'
            TabOrder = 2
            OnClick = Btn_Ap_3Click
          end
        end
      end
    end
    object Tbs_Impressao: TTabSheet
      Caption = 'Impress'#227'o'
      ImageIndex = 8
      OnShow = Tbs_ImpressaoShow
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
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
        object Label35: TLabel
          Left = 12
          Top = 294
          Width = 150
          Height = 13
          Caption = 'Largura Bobina -Novos Formato'
        end
        object Label36: TLabel
          Left = 12
          Top = 334
          Width = 164
          Height = 13
          Caption = 'Margem Esquerda -Novos Formato'
        end
        object Label37: TLabel
          Left = 12
          Top = 373
          Width = 149
          Height = 13
          Caption = 'Margem Direita -Novos Formato'
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
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 2
          OnClick = Btn_Ok_4Click
        end
        object Btn_Cn_4: TButton
          Left = 425
          Top = 525
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 3
          OnClick = Btn_Cn_1Click
        end
        object Btn_Ap_4: TButton
          Left = 500
          Top = 525
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
          Left = 5
          Top = 137
          Width = 231
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 8
          Text = 'MODELO 1 - MATRICIAL'
          Items.Strings = (
            'MODELO 1 - MATRICIAL'
            'MODELO 2 - T'#201'RMICA'
            'MODELO 3 - MAT. KAROLI'
            'MODELO 4 - GG'
            'MODELO 5 - MAT. DOCES PRINCESA'
            'MODELO 6 - MAC BATERIAS')
        end
        object E_Cpm_Nr_Vias: TEdit
          Left = 242
          Top = 138
          Width = 63
          Height = 21
          Alignment = taRightJustify
          TabOrder = 9
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
        object GroupBox4: TGroupBox
          Left = 306
          Top = 74
          Width = 276
          Height = 46
          Caption = 'Porta de Impress'#227'o -  Zebra/Argox/Elgin'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          object E_PortaImpZebra: TEdit
            Left = 7
            Top = 19
            Width = 265
            Height = 21
            TabOrder = 0
          end
        end
        object E_LarguraBobina: TEdit
          Left = 12
          Top = 310
          Width = 93
          Height = 21
          TabOrder = 14
        end
        object E_MarDirBobina: TEdit
          Left = 12
          Top = 350
          Width = 93
          Height = 21
          TabOrder = 15
        end
        object E_MarEsqBobina: TEdit
          Left = 12
          Top = 389
          Width = 93
          Height = 21
          TabOrder = 16
        end
      end
    end
    object Tbs_Produto: TTabSheet
      Caption = 'Produtos'
      ImageIndex = 7
      OnShow = Tbs_ProdutoShow
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Chbx_CodigoExato: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 2
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
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
          AlignWithMargins = True
          Left = 5
          Top = 19
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
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
        object GroupBox9: TGroupBox
          Left = 288
          Top = 389
          Width = 278
          Height = 69
          Caption = 'Movimenta'#231#227'o de Produtos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label21: TLabel
            Left = 6
            Top = 22
            Width = 181
            Height = 13
            Caption = 'Verificar se h'#225' inatividade por mais de '
          end
          object Label22: TLabel
            Left = 253
            Top = 22
            Width = 22
            Height = 13
            Caption = 'dias.'
          end
          object E_ProMovimento: TEdit_Setes
            Left = 189
            Top = 18
            Width = 57
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
          object ChBx_DesativaProduto: TCheckBox
            Left = 5
            Top = 44
            Width = 249
            Height = 17
            Caption = 'Desativar produto com saldo zero no cadastro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object GroupBox12: TGroupBox
          Left = 5
          Top = 389
          Width = 281
          Height = 69
          Caption = 'C'#225'lculo de Margem de Lucro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Lb_Formula: TLabel
            Left = 4
            Top = 30
            Width = 270
            Height = 33
            AutoSize = False
            Caption = 
              'Pre'#231'o de Venda = Pre'#231'o de Custo / [( 100 - Taxa de Lucro ) / 100' +
              ' ]'
            WordWrap = True
          end
          object Rd_Calculo_Tipo_1: TRadioButton
            Left = 8
            Top = 14
            Width = 113
            Height = 17
            Caption = 'C'#225'lculo Tipo 1'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = Rd_Calculo_Tipo_1Click
          end
          object Rd_Calculo_Tipo_2: TRadioButton
            Left = 137
            Top = 15
            Width = 113
            Height = 17
            Caption = 'C'#225'lculo Tipo 2'
            TabOrder = 1
            OnClick = Rd_Calculo_Tipo_2Click
          end
        end
        object ChBx_Observacao_NFe: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 36
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Agregar ( observa'#231#227'o da descri'#231#227'o do produto ) na observa'#231#227'o da ' +
            'NFe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = Chbx_DevolucaoClick
        end
        object rdg_Preco_venda: TRadioGroup
          Left = 288
          Top = 329
          Width = 280
          Height = 42
          Caption = 'Atualiza'#231#227'o de Pre'#231'o de Venda'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Pre'#231'o de Custo'
            'Custo Real')
          ParentFont = False
          TabOrder = 5
        end
        object Rg_AtualizaPrecoVenda: TRadioGroup
          Left = 287
          Top = 245
          Width = 281
          Height = 42
          Caption = 'Atualiza'#231#227'o de Pre'#231'o de Venda na Compra'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Autom'#225'tico'
            'Manual'
            'N'#227'o atualizar')
          ParentFont = False
          TabOrder = 6
        end
        object chk_contAba: TGroupBox
          Left = 7
          Top = 245
          Width = 278
          Height = 144
          Caption = 'Controle de Aba'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object ChBx_ABA_Fornecedor: TCheckBox
            Left = 7
            Top = 14
            Width = 97
            Height = 17
            Caption = 'Fornecedor'
            TabOrder = 0
          end
          object ChBx_ABA_imposto: TCheckBox
            Left = 7
            Top = 30
            Width = 97
            Height = 17
            Caption = 'Impostos'
            TabOrder = 1
          end
          object ChBx_ABA_TabeladePrec: TCheckBox
            Left = 7
            Top = 46
            Width = 103
            Height = 17
            Caption = 'Tabela de Pre'#231'o'
            TabOrder = 2
          end
          object ChBx_ABA_imagem: TCheckBox
            Left = 7
            Top = 62
            Width = 97
            Height = 17
            Caption = 'Imagem'
            TabOrder = 3
          end
          object ChBx_ABA_instacao: TCheckBox
            Left = 7
            Top = 77
            Width = 97
            Height = 17
            Caption = 'Instala'#231#227'o'
            TabOrder = 4
          end
          object ChBx_ABA_estoque: TCheckBox
            Left = 7
            Top = 93
            Width = 97
            Height = 17
            Caption = 'Estoque'
            TabOrder = 5
          end
          object ChBx_ABA_aviamento: TCheckBox
            Left = 7
            Top = 124
            Width = 120
            Height = 17
            Caption = 'Insumo de Produ'#231#227'o'
            TabOrder = 6
          end
          object ChBx_ABA_composicao: TCheckBox
            Left = 7
            Top = 109
            Width = 97
            Height = 17
            Caption = 'Composi'#231#227'o'
            TabOrder = 7
          end
          object ChBx_ABA_Aplicacao: TCheckBox
            Left = 151
            Top = 14
            Width = 97
            Height = 17
            Caption = 'Aplica'#231#227'o'
            TabOrder = 8
          end
          object ChBx_ABA_Botoes: TCheckBox
            Left = 151
            Top = 30
            Width = 97
            Height = 17
            Caption = 'Bot'#245'es'
            TabOrder = 9
          end
        end
        object rdg_Rel_inv: TRadioGroup
          Left = 287
          Top = 288
          Width = 280
          Height = 42
          Caption = 'Relat'#243'rio Inventario e Saldo Estoque'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Pre'#231'o de Custo'
            'Custo Real')
          ParentFont = False
          TabOrder = 8
        end
        object Btn_Ok_5: TButton
          Left = 344
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 9
          OnClick = Btn_Ok_5Click
        end
        object Btn_Cn_5: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 10
          OnClick = Btn_Cn_1Click
        end
        object Btn_Ap_5: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 11
          OnClick = Btn_Ap_5Click
        end
        object chbx_ProdMultiEmpresa: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 53
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Compartilhar Produto(s) Multi Empresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object chbx_crtl_codFab: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 70
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Controlar Duplica'#231#227'o de C'#243'digo de F'#225'brica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object chbx_lbl_produto: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 87
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Produtos do Tipo de Revenda de Ve'#237'culos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object chbx_aq_comissao: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 104
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Validar Aliquota de Comiss'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object GroupBox23: TGroupBox
          Left = 317
          Top = 458
          Width = 138
          Height = 57
          Caption = 'C'#243'digo do Produto Buffet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          object Sb_Buffet: TSpeedButton
            Left = 108
            Top = 24
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = Sb_BuffetClick
          end
          object E_Cd_Pro_Buffet: TMaskEdit
            Left = 7
            Top = 24
            Width = 97
            Height = 21
            TabOrder = 0
            Text = ''
          end
        end
        object GroupBox25: TGroupBox
          Left = 6
          Top = 458
          Width = 309
          Height = 58
          Caption = 'Defini'#231#227'o de Casas Decimais'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          object Rg_Casas_Venda: TRadioGroup
            Left = 4
            Top = 15
            Width = 149
            Height = 40
            Caption = '[ Vendas ]'
            Columns = 5
            ItemIndex = 0
            Items.Strings = (
              '2'
              '3'
              '4'
              '5'
              '6')
            TabOrder = 0
          end
          object Rg_Casas_Compra: TRadioGroup
            Left = 156
            Top = 15
            Width = 149
            Height = 40
            Caption = '[ Compras ]'
            Columns = 5
            ItemIndex = 0
            Items.Strings = (
              '2'
              '3'
              '4'
              '5'
              '6')
            TabOrder = 1
          end
        end
        object chbx_venc_lote: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 121
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Validar Data de Vencimento no Cadastro do Lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object ChBx_CalculoAutoPrecoVenda: TCheckBox
          Left = 291
          Top = 372
          Width = 277
          Height = 17
          Caption = 'Efetuar o c'#225'lculo automatico ao editar cadastro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object Chbx_RegistrarAlteraPreco: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 138
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Registrar as altera'#231#245'es de pre'#231'o de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object ChBx_Detalhar_ST: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 155
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Detalhar os dados da Substitui'#231#227'o Tribut'#225'ria nos itens da NF-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object ChBx_ItensPedidoM2: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 189
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Utilizar Calculo de M'#178' para informar quantidade de itens nos ped' +
            'idos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object ChBx_ItensPedidoMod50: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 172
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Efetuar arredondamento mod(50) Ex: { Entre 12,01 e 12,49 = 12,50' +
            ' | Entre 12,51 e 12,99 = 13,00 }'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
        end
        object chbx_SemBenef: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 223
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Informar na nota ""SEM CBENEF" quando o produto n'#227'o tiver benefi' +
            'cio Fiscal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
        end
        object Chbx_NaoValidaEAN: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 206
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'N'#227'o validar o c'#243'digo de Barras - Poder'#225' ter problemas na autroiz' +
            'a'#231#227'o das Noras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 25
        end
      end
    end
    object Tbs_Pessoal: TTabSheet
      Caption = 'Controle de Pessoal'
      ImageIndex = 8
      OnShow = Tbs_PessoalShow
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Chbx_CompColaborador: TCheckBox
          Left = 8
          Top = 9
          Width = 313
          Height = 17
          Caption = 'Compartilhar os colaboradores entre as Empresas registradas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Btn_Ok_6: TButton
          Left = 347
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 1
          OnClick = Btn_Ok_6Click
        end
        object Btn_Cn_6: TButton
          Left = 426
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = Btn_Cn_1Click
        end
        object Btn_Ap_6: TButton
          Left = 501
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 3
          OnClick = Btn_Ap_6Click
        end
      end
    end
    object Tbs_comissao: TTabSheet
      Caption = 'Comiss'#245'es'
      ImageIndex = 6
      OnShow = Tbs_comissaoShow
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Label1: TLabel
          Left = 434
          Top = 267
          Width = 54
          Height = 13
          Caption = 'Aliq Padr'#227'o'
        end
        object Memo1: TMemo
          Left = 8
          Top = 24
          Width = 561
          Height = 105
          DragMode = dmAutomatic
          Lines.Strings = (
            'Comiss'#227'o do item de venda ou servi'#231'o somente'
            'Comissao pela aliquota do cadastro do vendedor Somente'
            
              'Comiss'#227'o do item de venda  + aliquota de comiss'#227'o de vendedor se' +
              ' for marcado que ele recebe por'
            '    venda tamb'#233'm'
            
              'Comiss'#227'o do item de servi'#231'o  + aliquota de comiss'#227'o de vendedor ' +
              'se for marcado que ele recebe por '
            '     servi'#231'o tamb'#233'm')
          TabOrder = 0
        end
        object Memo2: TMemo
          Left = 8
          Top = 155
          Width = 561
          Height = 105
          DragMode = dmAutomatic
          Lines.Strings = (
            'Comiss'#227'o do item de venda ou servi'#231'o somente'
            'Comissao pela aliquota do cadastro do vendedor Somente'
            
              'Comiss'#227'o do item de venda  + aliquota de comiss'#227'o de vendedor se' +
              ' for marcado que ele recebe por'
            '    venda tamb'#233'm'
            
              'Comiss'#227'o do item de servi'#231'o  + aliquota de comiss'#227'o de vendedor ' +
              'se for marcado que ele recebe por '
            '     servi'#231'o tamb'#233'm')
          TabOrder = 1
        end
        object chk_Com_Vend_ped: TCheckBox
          Left = 8
          Top = 266
          Width = 417
          Height = 17
          Caption = 
            'Distribuir comiss'#227'o entre o vendedor do Cadasro do cliente e o V' +
            'endedor do Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Chk_Com_Desc: TCheckBox
          Left = 8
          Top = 289
          Width = 547
          Height = 17
          Caption = 
            'Quando o vendedor tiver o mesmo nome do Cliente colocar a aliquo' +
            'ta de comiss'#227'o como Desconto no pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object RB_Com_Fat: TRadioButton
          Left = 8
          Top = 6
          Width = 305
          Height = 17
          Caption = 'Pagar comiss'#227'o no faturamento '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object RB_Com_Rec: TRadioButton
          Left = 8
          Top = 136
          Width = 281
          Height = 17
          Caption = 'Pagar comiss'#227'o no Contas a Receber'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object E_Aliq_Com_Padrao: TEdit_Setes
          Left = 492
          Top = 265
          Width = 74
          Height = 21
          Alignment = taRightJustify
          TabOrder = 6
          Text = ''
        end
        object chk_visualisa_com: TCheckBox
          Left = 8
          Top = 309
          Width = 248
          Height = 17
          Caption = 'Mostra Aliquota de Comiss'#227'o do Vendedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object Btn_Ok_7: TButton
          Left = 344
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 8
          OnClick = Btn_Ok_7Click
        end
        object Btn_Cn_7: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 9
          OnClick = Btn_Cn_1Click
        end
        object Btn_Ap_7: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 10
          OnClick = Btn_Ap_7Click
        end
        object ChBx_ComissaoFrenteCaixa: TCheckBox
          Left = 9
          Top = 329
          Width = 248
          Height = 17
          Caption = 'Gerar Comiss'#227'o na Frente de Caixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
      end
    end
    object tbs_pedidos: TTabSheet
      Caption = 'Pedido(s)'
      ImageIndex = 8
      OnShow = tbs_pedidosShow
      object Panel6: TPanel
        Left = 0
        Top = 521
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
          OnClick = Btn_Cn_1Click
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
        Top = 88
        Width = 586
        Height = 433
        ActivePage = tbs_controle_compra
        Align = alClient
        TabOrder = 1
        OnChange = pg_pedidosChange
        object tbs_controle_venda: TTabSheet
          Caption = 'Controle de Venda'
          object Label2: TLabel
            Left = 4
            Top = 404
            Width = 517
            Height = 16
            Caption = 
              'Algumas configura'#231#245'es foram transferidas para a tela de pedido d' +
              'e Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object rdg_Lucratividade: TRadioGroup
            Left = 408
            Top = 53
            Width = 159
            Height = 56
            Caption = 'Lucratividade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Pelo Valor de Venda'
              'Pelo Valor de Custo')
            ParentFont = False
            TabOrder = 0
          end
          object ChBx_InformaValor: TCheckBox
            Left = 5
            Top = 3
            Width = 278
            Height = 17
            Caption = 'Ativa Digita'#231#227'o do Valor e Peso na Frente de Caixa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Chbx_Rec_Bruta_Venda: TCheckBox
            Left = 4
            Top = 19
            Width = 245
            Height = 17
            Caption = 'Apresentar receita bruta no relat'#243'rio de vendas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object Chbx_Custo_Relatorio_Venda: TCheckBox
            Left = 4
            Top = 34
            Width = 245
            Height = 17
            Caption = 'Apresentar valor de custo no relat'#243'rio de vendas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object chbk_Valida_Transp: TCheckBox
            Left = 4
            Top = 49
            Width = 368
            Height = 17
            Caption = 'Efetuar  Valida'#231#227'o de Transporte'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object chbx_reg_obs_naNF: TCheckBox
            Left = 4
            Top = 63
            Width = 368
            Height = 17
            Caption = 'Registrar Informa'#231#245'es de Parcelamento na Observa'#231#227'o da Nota'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ChBx_PedidoInternet: TCheckBox
            Left = 4
            Top = 79
            Width = 321
            Height = 17
            Caption = 'Mostrar a tela de Pedido pela Internet na Tela de Consulta Web'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object GroupBox7: TGroupBox
            Left = 410
            Top = 4
            Width = 157
            Height = 47
            Caption = 'C'#243'digo do Cliente Consumidor '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            object Sb_Consumidor: TSpeedButton
              Left = 125
              Top = 19
              Width = 23
              Height = 22
              Caption = '...'
              OnClick = Sb_ConsumidorClick
            end
            object E_CodConsumo: TEdit_Setes
              Left = 7
              Top = 19
              Width = 113
              Height = 21
              TabOrder = 0
              Text = ''
            end
          end
          object Chbx_PerguntasInternet: TCheckBox
            Left = 4
            Top = 93
            Width = 345
            Height = 17
            Caption = 
              'Mostrar a tela de Perguntas pela Internet na Tela de Consulta We' +
              'b'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object Chbx_Res_Vda_Hora: TCheckBox
            Left = 3
            Top = 110
            Width = 430
            Height = 17
            Caption = 
              'Mostrar Resumo de Vendas por Hora na pesquisa de Notas Fiscais P' +
              'rodutos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
        end
        object tbs_controle_compra: TTabSheet
          Caption = 'Controle de Compra'
          ImageIndex = 1
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
          object ChBx_Ctrl_Nota_Compra: TCheckBox
            Left = 5
            Top = 120
            Width = 388
            Height = 17
            Caption = 
              'Controlar o numera'#231#227'o de notas de compra para evitar lan'#231'amentos' +
              ' Duplos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ChBx_Nfe_Compra: TCheckBox
            Left = 5
            Top = 137
            Width = 400
            Height = 17
            Caption = 'Ativar NF-e para opera'#231#227'oes de Compra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Chbx_controle_compra: TCheckBox
            Left = 6
            Top = 154
            Width = 328
            Height = 17
            Caption = 'Controlar a seq'#252#234'ncia do n'#250'mero de pedido de Compra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object cbx_modeloLaser_cpa: TComboBox
            Left = 7
            Top = 99
            Width = 466
            Height = 21
            Style = csDropDownList
            TabOrder = 3
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
            TabOrder = 4
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
            TabOrder = 5
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
            TabOrder = 6
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
            TabOrder = 7
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
          object Grb_Ctrl_Compra: TGroupBox
            Left = 3
            Top = 194
            Width = 137
            Height = 59
            Caption = 'Valor total de Compra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            object Label9: TLabel
              Left = 8
              Top = 15
              Width = 64
              Height = 13
              Caption = 'Limite Mensal'
            end
            object E_Ctrl_Cpa_Valor_Total: TEdit_Setes
              Left = 6
              Top = 29
              Width = 121
              Height = 21
              Alignment = taRightJustify
              TabOrder = 0
              Text = ''
              OnExit = E_Ctrl_Cpa_Valor_TotalExit
            end
          end
          object chbx_ValidaDiferencaCompra: TCheckBox
            Left = 6
            Top = 171
            Width = 328
            Height = 17
            Caption = 'Validar diferen'#231'a de valor desde a '#250'ltima compra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
        end
        object tbs_controle_Frente: TTabSheet
          Caption = 'Frente de Caixa'
          ImageIndex = 3
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 578
            Height = 405
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
              Top = 176
              Width = 188
              Height = 14
              Caption = 'Selecione a Tabela de Vendas Principal'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Label47: TLabel
              Left = 287
              Top = 176
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
              Top = 176
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
            object Lb_ListPrintWindows: TLabel
              Left = 313
              Top = 230
              Width = 217
              Height = 14
              Caption = 'Lista de Impressoras instaladas no Windows'
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
              Width = 275
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              Items.Strings = (
                'MODELO 1 - EPSON'
                'MODELO 2 - BEMATECH MP4200'
                'MODELO 3 - BEMATECH MP4000'
                'MODELO 4 - BEMATECH MP100S'
                'MODELO 5 - GERENCIADOR DO WINDOWS'
                'MODELO 6 - BEMATECH MP2500')
            end
            object cbx_modeloTer_frt: TComboBox
              Left = 285
              Top = 61
              Width = 280
              Height = 21
              Style = csDropDownList
              TabOrder = 1
              Items.Strings = (
                'MODELO 1  - NORMAL'
                'MODELO 2 - 30 COLUNAS')
            end
            object GroupBox13: TGroupBox
              Left = 5
              Top = 85
              Width = 561
              Height = 86
              Caption = 'Controle Gaveta de Dinheiro/ Corte de Papel'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              DesignSize = (
                561
                86)
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
                Width = 115
                Height = 13
                Caption = 'String de Abertura/Corte'
              end
              object Label55: TLabel
                Left = 430
                Top = 13
                Width = 123
                Height = 13
                Caption = 'A'#231#227'o abertura antecipada'
              end
              object lbl_status: TLabel
                Left = 276
                Top = 59
                Width = 278
                Height = 13
                AutoSize = False
                Caption = 'Status:Impressora/Gaveta - em desenvolvimento'
              end
              object lb_CodStatus: TLabel
                Left = 257
                Top = 59
                Width = 17
                Height = 13
                AutoSize = False
                Caption = '0 - '
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
                  'Impressora Epson (via Impress'#227'o)'
                  'Impressora Bematech (via DLL)'
                  'Impressora Diebold  (via Impress'#227'o)')
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
              object Button2: TButton
                Left = 3
                Top = 53
                Width = 111
                Height = 25
                Anchors = [akRight, akBottom]
                Caption = 'Abrir Gaveta'
                TabOrder = 4
                OnClick = Button2Click
              end
              object Button1: TButton
                Left = 114
                Top = 53
                Width = 141
                Height = 25
                Anchors = [akRight, akBottom]
                Caption = 'Status - Gaveta/Impressora'
                TabOrder = 5
                OnClick = Button1Click
              end
            end
            object Dblcb_TabelasConsumidor: TDBLookupComboBox
              Left = 5
              Top = 190
              Width = 280
              Height = 21
              KeyField = 'TPR_CODIGO'
              ListField = 'TPR_NOME'
              ListSource = Ds_TabelaConsumidor
              TabOrder = 3
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
              TabOrder = 4
              object RB_ImpMatricial_Frt: TRadioButton
                Left = 4
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
              TabOrder = 5
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
              Top = 216
              Width = 316
              Height = 16
              Caption = 'Imprimir Cupom na Frente de Caixa - N'#227'o contempla a NFCE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object Chb_Visualiza_Cupom: TCheckBox
              Left = 5
              Top = 231
              Width = 267
              Height = 16
              Caption = 'Visualizar Cupom / NFCE antes de Imprimir'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnClick = Chb_Visualiza_CupomClick
            end
            object ChBx_CodigoBarra: TCheckBox
              Left = 5
              Top = 246
              Width = 267
              Height = 17
              Caption = 'Imprimir C'#243'digo de Barras no Cupom'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object Chbx_ProdutoAvulso: TCheckBox
              Left = 5
              Top = 262
              Width = 267
              Height = 17
              Caption = 'Utilizar produto avulso para lan'#231'ar no caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object Cb_TipoImpressora: TComboBox
              Left = 288
              Top = 190
              Width = 221
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 10
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
              Top = 189
              Width = 52
              Height = 21
              TabOrder = 11
              Text = '50'
            end
            object ChBx_UsarCodigoFAb: TCheckBox
              Left = 5
              Top = 278
              Width = 283
              Height = 17
              Caption = 'No c'#243'digo reduzido usar o N'#186' Fabrica'#231#227'o / Montadora'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object ChBx_Imp_Item_Checkout: TCheckBox
              Left = 5
              Top = 294
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
              TabOrder = 13
            end
            object Chbx_Frt_Desconto: TCheckBox
              Left = 5
              Top = 310
              Width = 395
              Height = 17
              Caption = 'Mostrar op'#231#227'o de desconto'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object Chbx_Vda_Sem_Ctrl_Estoque: TCheckBox
              Left = 5
              Top = 326
              Width = 564
              Height = 17
              Caption = 'Controlar estoque na Frente de Caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object chbx_CortePapel: TCheckBox
              Left = 5
              Top = 340
              Width = 564
              Height = 17
              Caption = 'Acionar Corte de Papel'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
            end
            object Cb_ListPrintWindows: TComboBox
              Left = 312
              Top = 246
              Width = 254
              Height = 21
              Style = csDropDownList
              TabOrder = 17
            end
            object chbx_frt_nota_Promissoria: TCheckBox
              Left = 6
              Top = 355
              Width = 564
              Height = 17
              Caption = 
                'Imprimir Nota Promiss'#243'ria para cliente REGISTRADO e forma de pag' +
                'amento CARTEIRA'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 18
            end
            object chbx_frt_bloqueia_F11: TCheckBox
              Left = 6
              Top = 371
              Width = 564
              Height = 17
              Caption = 
                'Bloquear Tecla F11 impedindo informar m'#250'ltiplas quantidades (Dev' +
                'e passar item a item)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 19
            end
          end
        end
        object tbs_controle_Pizzaria: TTabSheet
          Caption = 'Pizzaria'
          ImageIndex = 4
          object Panel15: TPanel
            Left = 0
            Top = 0
            Width = 578
            Height = 405
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
            object GroupBox30: TGroupBox
              Left = 6
              Top = 87
              Width = 224
              Height = 58
              Caption = 'C'#225'lculo das Pizzas'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object Rd_Media_Pizzaria: TRadioButton
                Left = 6
                Top = 17
                Width = 207
                Height = 17
                Caption = 'Pela m'#233'dia dos valores de cada sabor'
                TabOrder = 0
              end
              object Rd_Maior_Pizzaria: TRadioButton
                Left = 6
                Top = 36
                Width = 194
                Height = 17
                Caption = 'Pelo maior valor do sabor escolhido'
                Checked = True
                TabOrder = 1
                TabStop = True
              end
            end
            object cbx_modeloMat_Piz: TComboBox
              Left = 5
              Top = 62
              Width = 277
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              Items.Strings = (
                'MODELO 1  - NORMAL')
            end
            object cbx_modeloTer_Piz: TComboBox
              Left = 285
              Top = 62
              Width = 287
              Height = 21
              Style = csDropDownList
              TabOrder = 4
              Items.Strings = (
                'MODELO 1  - NORMAL')
            end
            object GroupBox10: TGroupBox
              Left = 232
              Top = 87
              Width = 145
              Height = 58
              Caption = 'Identificador de chamadas'
              TabOrder = 5
              object Chbx_Ativar_Identificador_Piz: TCheckBox
                Left = 8
                Top = 14
                Width = 118
                Height = 17
                Caption = 'Ativar - Porta COM'
                TabOrder = 0
              end
              object E_PortaCom_Piz: TEdit
                Left = 6
                Top = 31
                Width = 121
                Height = 21
                CharCase = ecUpperCase
                TabOrder = 1
              end
            end
            object ChBx_AutoFaturamentoEntrega: TCheckBox
              Left = 6
              Top = 147
              Width = 355
              Height = 17
              Caption = 
                'Faturar os pedidos antes da impress'#227'o - Para pedidos do tipo ent' +
                'rega'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object GroupBox22: TGroupBox
              Left = 384
              Top = 87
              Width = 185
              Height = 58
              Caption = 'Tratar string Identificador'
              TabOrder = 7
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
            object Chbx_ZerarPedidoPizza: TCheckBox
              Left = 6
              Top = 194
              Width = 278
              Height = 17
              Caption = 'Zerar o n'#250'mero do Pedido a cada dia ao abrir o caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object GroupBox3: TGroupBox
              Left = 385
              Top = 145
              Width = 185
              Height = 58
              Caption = 'Comiss'#227'o para Motoboy'
              TabOrder = 9
              object Label3: TLabel
                Left = 4
                Top = 16
                Width = 69
                Height = 13
                Caption = 'Valor da Di'#225'ria'
              end
              object E_Diariamotoboy: TEdit_Setes
                Left = 3
                Top = 32
                Width = 92
                Height = 21
                Alignment = taRightJustify
                TabOrder = 0
                Text = ''
              end
            end
            object ChBx_Piz_GuilhotinaOneByOne: TCheckBox
              Left = 6
              Top = 210
              Width = 278
              Height = 17
              Caption = 'Acionar guilhotina entre a impress'#227'o Caixa e Balc'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object chbx_piz_reduzir_valor_Entrega: TCheckBox
              Left = 6
              Top = 227
              Width = 361
              Height = 17
              Caption = 'Permitir a Redu'#231'ao do Valor da Entrega na tela de atendimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object ChBx_AutoFaturamentoBalcao: TCheckBox
              Left = 6
              Top = 163
              Width = 355
              Height = 17
              Caption = 
                'Faturar os pedidos antes da impress'#227'o - Para pedidos do tipo bal' +
                'c'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object ChBx_AutoFaturamentoMesa: TCheckBox
              Left = 6
              Top = 178
              Width = 355
              Height = 17
              Caption = 
                'Faturar os pedidos antes da impress'#227'o - Para pedidos do tipo mes' +
                'a'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
          end
        end
      end
      object grp_geral: TGroupBox
        Left = 0
        Top = 0
        Width = 586
        Height = 88
        Align = alTop
        Caption = 'Geral'
        TabOrder = 2
        object chbx_Ctrl_Est_Auto: TCheckBox
          Left = 5
          Top = 14
          Width = 366
          Height = 17
          Caption = 'Controle Automatico do Estoque pela baixa dos pedidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object GroupBox6: TGroupBox
          Left = 8
          Top = 35
          Width = 561
          Height = 46
          Caption = 'Caminho do Banco de Destino: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object edtCaminhoBancoEnviaPedido: TEdit
            Left = 7
            Top = 19
            Width = 514
            Height = 21
            TabOrder = 0
          end
        end
      end
    end
    object Tbs_Balanca: TTabSheet
      Caption = 'Balan'#231'a'
      ImageIndex = 9
      OnShow = Tbs_BalancaShow
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Label30: TLabel
          Left = 208
          Top = 135
          Width = 77
          Height = 13
          Caption = 'Ultima Resposta'
        end
        object Label31: TLabel
          Left = 208
          Top = 90
          Width = 82
          Height = 13
          Caption = 'Ultimo Peso Lido:'
        end
        object Label32: TLabel
          Left = 208
          Top = 280
          Width = 40
          Height = 13
          Caption = 'TimeOut'
        end
        object Label33: TLabel
          Left = 208
          Top = 188
          Width = 52
          Height = 13
          Caption = 'Mensagem'
        end
        object btnConectar: TButton
          Left = 203
          Top = 16
          Width = 105
          Height = 25
          Caption = 'Ativar'
          TabOrder = 0
          OnClick = btnConectarClick
        end
        object btnDesconectar: TButton
          Left = 331
          Top = 16
          Width = 105
          Height = 25
          Caption = 'Desativar'
          Enabled = False
          TabOrder = 1
          OnClick = btnDesconectarClick
        end
        object btnLerPeso: TButton
          Left = 204
          Top = 56
          Width = 105
          Height = 25
          Caption = 'Ler Peso'
          Enabled = False
          TabOrder = 2
          OnClick = btnLerPesoClick
        end
        object sttPeso: TStaticText
          Left = 208
          Top = 106
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
          Left = 208
          Top = 152
          Width = 233
          Height = 36
          AutoSize = False
          BevelKind = bkTile
          Caption = 'sttResposta'
          TabOrder = 4
        end
        object E_Timer: TEdit_Setes
          Left = 208
          Top = 296
          Width = 73
          Height = 21
          Alignment = taRightJustify
          TabOrder = 5
          Text = '2000'
        end
        object chbMonitorar: TCheckBox
          Left = 208
          Top = 259
          Width = 233
          Height = 17
          Caption = 'Monitorar a Balan'#231'a'
          TabOrder = 6
        end
        object Memo3: TMemo
          Left = 208
          Top = 208
          Width = 233
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
          Left = 12
          Top = 332
          Width = 145
          Height = 17
          Caption = 'Ativar o Uso da Balan'#231'a'
          TabOrder = 9
        end
        object Button5: TButton
          Left = 332
          Top = 56
          Width = 105
          Height = 25
          Caption = 'Registrar TARA'
          Enabled = False
          TabOrder = 10
          OnClick = Button5Click
        end
        object Btn_Ok_12: TButton
          Left = 338
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 11
          OnClick = Btn_Ok_12Click
        end
        object Btn_Cn_12: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 12
          OnClick = Btn_Cn_1Click
        end
        object Btn_AP_12: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 13
          OnClick = Btn_AP_12Click
        end
        object GroupBox28: TGroupBox
          Left = 8
          Top = 406
          Width = 180
          Height = 71
          Caption = 'C'#243'digo de Barras da Balan'#231'a'
          TabOrder = 14
          object Label64: TLabel
            Left = 9
            Top = 14
            Width = 148
            Height = 13
            Caption = 'N'#250'meros de Caracter por Bloco'
          end
          object Label65: TLabel
            Left = 6
            Top = 29
            Width = 73
            Height = 13
            Caption = 'C'#243'digo Produto'
          end
          object Lb_blc_bar_Preco_Peso: TLabel
            Left = 86
            Top = 30
            Width = 57
            Height = 13
            Caption = 'Pre'#231'o/Peso'
          end
          object E_bal_bar_Cd_Produto: TEdit_Setes
            Left = 6
            Top = 43
            Width = 74
            Height = 21
            TabOrder = 0
            Text = ''
          end
          object E_bal_bar_Preco_Peso: TEdit_Setes
            Left = 85
            Top = 43
            Width = 86
            Height = 21
            TabOrder = 1
            Text = ''
          end
        end
        object GroupBox5: TGroupBox
          Left = 8
          Top = 355
          Width = 180
          Height = 45
          Caption = 'Tipo de Leitura'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          object Rb_Bal_Preco: TRadioButton
            Left = 5
            Top = 20
            Width = 68
            Height = 17
            Caption = 'Pre'#231'o'
            TabOrder = 0
            OnClick = Rb_Bal_PrecoClick
          end
          object Rb_Bal_Peso: TRadioButton
            Left = 78
            Top = 20
            Width = 62
            Height = 17
            Caption = 'Peso'
            TabOrder = 1
            OnClick = Rb_Bal_PesoClick
          end
        end
      end
    end
    object tbs_Despacho: TTabSheet
      Caption = 'Despacho e Separa'#231#227'o'
      ImageIndex = 11
      OnShow = tbs_DespachoShow
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Label15: TLabel
          Left = 6
          Top = 108
          Width = 108
          Height = 14
          Caption = 'Modelos de Impress'#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 23
          Top = 86
          Width = 467
          Height = 13
          Caption = 
            'O uso da separa'#231#227'o de mercadoria e do c'#243'digo de barras  n'#227'o pode' +
            'm ser usados simult'#226'neamente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object chbx_Ctrl_despacho: TCheckBox
          Left = 7
          Top = 5
          Width = 236
          Height = 17
          Caption = 'Utilizar controle de depacho de mercadoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chbx_Ctrl_despachoClick
        end
        object Chbx_Ctrl_separacao: TCheckBox
          Left = 6
          Top = 26
          Width = 236
          Height = 17
          Caption = 'Utilizar controle de separa'#231#227'o de mercadoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = Chbx_Ctrl_separacaoClick
        end
        object GroupBox14: TGroupBox
          Left = 278
          Top = 2
          Width = 300
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object E_PortaImpressao_dsp: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object E_SaltoImpressao_dsp: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object Sb_OK_10: TButton
          Left = 347
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 3
          OnClick = Sb_OK_10Click
        end
        object Sb_Cn_10: TButton
          Left = 426
          Top = 525
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 4
          OnClick = Sb_Cn_10Click
        end
        object Sb_Ap_10: TButton
          Left = 501
          Top = 525
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 5
          OnClick = Sb_Ap_10Click
        end
        object chbx_Imp_auto_Separacao: TCheckBox
          Left = 6
          Top = 46
          Width = 282
          Height = 17
          Caption = 'Impress'#227'o autom'#225'tica para a impressora da separa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object cbx_Impressao_Dsp: TComboBox
          Left = 6
          Top = 122
          Width = 466
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            'MODELO 1 - CUPOM'
            'MODELO 2 - MATRICIAL')
        end
        object Chbx_despacho_by_cod_barra: TCheckBox
          Left = 6
          Top = 67
          Width = 355
          Height = 17
          Caption = 'Ativar campo de c'#243'digo de barras do produto para despachar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Outros Tributos'
      ImageIndex = 11
      OnShow = TabSheet7Show
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          556)
        object Btn_Ok_11: TButton
          Left = 344
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_Ok_11Click
        end
        object Btn_Cn_11: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Btn_Cn_11Click
        end
        object Btn_Ap_11: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Btn_Ap_11Click
        end
        object GroupBox8: TGroupBox
          Left = 6
          Top = 6
          Width = 179
          Height = 44
          Caption = 'Gera'#231#227'o de Cr'#233'dito ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Label19: TLabel
            Left = 12
            Top = 20
            Width = 103
            Height = 13
            Caption = 'Informar Taxa do M'#234's'
          end
          object E_Tx_Cr_ICMS: TEdit_Setes
            Left = 117
            Top = 16
            Width = 50
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
        object GroupBox18: TGroupBox
          Left = 191
          Top = 6
          Width = 179
          Height = 44
          Caption = 'Imposto Municipal Aproximado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          object Label34: TLabel
            Left = 12
            Top = 20
            Width = 87
            Height = 13
            Caption = 'Taxa para Servi'#231'o'
          end
          object E_Tx_Aprox_Mun: TEdit_Setes
            Left = 117
            Top = 16
            Width = 50
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
      end
    end
    object tbsTEF: TTabSheet
      Caption = 'TEF'
      ImageIndex = 11
      OnShow = tbsTEFShow
      object Panel17: TPanel
        Left = 200
        Top = 248
        Width = 185
        Height = 41
        Caption = 'Panel17'
        TabOrder = 0
      end
      object Panel18: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 556
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          586
          556)
        object Label7: TLabel
          Left = 100
          Top = 63
          Width = 91
          Height = 13
          Caption = 'Descri'#231#227'o Terminal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 6
          Top = 63
          Width = 54
          Height = 13
          Caption = 'ID Terminal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 6
          Top = 25
          Width = 34
          Height = 13
          Caption = 'ID Loja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 6
          Top = 110
          Width = 62
          Height = 13
          Caption = 'Porta PinPad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 99
          Top = 25
          Width = 92
          Height = 13
          Caption = 'N'#250'mro I.P. Servidor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btn_ok_13: TButton
          Left = 344
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 6
          OnClick = btn_ok_13Click
        end
        object btn_cn_13: TButton
          Left = 423
          Top = 526
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 7
          OnClick = Btn_Cn_1Click
        end
        object btn_ap_13: TButton
          Left = 498
          Top = 526
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 8
          OnClick = btn_ap_13Click
        end
        object ChBx_TEF_Ativa_Local: TCheckBox
          Left = 4
          Top = 6
          Width = 419
          Height = 17
          Caption = 'Ativar TEF (Tranfer'#234'ncia Eletr'#244'nica de Fundos) neste terminal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object E_TEF_ID_Loja: TEdit_Setes
          Left = 6
          Top = 41
          Width = 91
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object E_TEF_Porta_PinPad: TEdit_Setes
          Left = 6
          Top = 126
          Width = 91
          Height = 21
          TabOrder = 5
          Text = ''
        end
        object E_TEF_Desc_Terminal: TEdit
          Left = 99
          Top = 79
          Width = 182
          Height = 21
          TabOrder = 4
        end
        object E_TEF_IP: TEdit
          Left = 99
          Top = 41
          Width = 182
          Height = 21
          TabOrder = 2
        end
        object E_TEF_ID_Terminal: TEdit
          Left = 6
          Top = 80
          Width = 91
          Height = 21
          TabOrder = 3
        end
        object Chbx_TEF_Comp_Quebra_Linha: TCheckBox
          Left = 6
          Top = 153
          Width = 347
          Height = 17
          Caption = 'Quebrar linha no comprovante para deix'#225'-lo mais leg'#237'vel'
          TabOrder = 9
        end
        object Chbx_TEF_Comp_Mostra_Usuario: TCheckBox
          Left = 6
          Top = 169
          Width = 347
          Height = 17
          Caption = 'Mostrar o Usu'#225'rio do Caixa na 1'#186' Via'
          TabOrder = 10
        end
        object Chbx_Send_Qr_code_Pinpad: TCheckBox
          Left = 6
          Top = 186
          Width = 347
          Height = 17
          Caption = 'Enviar o QrCode do Pix para o PINPAD'
          TabOrder = 11
        end
      end
    end
    object tbs_estoque: TTabSheet
      Caption = 'Estoque'
      ImageIndex = 13
      OnShow = tbs_estoqueShow
      object Panel22: TPanel
        Left = 0
        Top = 515
        Width = 586
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          586
          41)
        object Button7: TButton
          Left = 343
          Top = 10
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Button7Click
        end
        object Button8: TButton
          Left = 500
          Top = 10
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 1
          OnClick = Button8Click
        end
        object Button9: TButton
          Left = 425
          Top = 10
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = Btn_Cn_1Click
        end
      end
      object Panel21: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 515
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object ChBx_est_Avise_Saldo_Zero: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 2
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Ativar envio de email quando estoque tiver saldo igual ou menor ' +
            'que zero'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object GroupBox20: TGroupBox
          AlignWithMargins = True
          Left = 5
          Top = 22
          Width = 576
          Height = 46
          Align = alTop
          Caption = 'Informe o e-mail de quem vai receber a notifica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object E_est_email_notifica: TEdit
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 566
            Height = 21
            Align = alTop
            TabOrder = 0
          end
        end
        object Chbx_est_auto_reposicao: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 71
          Width = 576
          Height = 17
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Ativar no cadastro a reposi'#231#227'o autom'#225'tica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
  end
  object OpenDialogo: TOpenDialog
    Left = 412
    Top = 169
  end
  object Act_Acoes: TActionList
    Left = 356
    Top = 186
    object Act_Diversos: TAction
      Caption = 'Configura'#231#245'es Gerais '
      ShortCut = 8238
    end
  end
  object Balanca: TACBrBAL
    Modelo = balUrano
    Porta = 'COM1'
    Left = 208
    Top = 176
  end
  object Ds_NF_Informatizada: TDataSource
    Left = 492
    Top = 294
  end
  object ACBrGAV1: TACBrGAV
    Porta = 'COM1'
    AberturaAntecipada = aaIgnorar
    Left = 434
    Top = 304
  end
  object Ds_TabelaConsumidor: TDataSource
    DataSet = DM.Qr_Tabelas
    Left = 394
    Top = 248
  end
end

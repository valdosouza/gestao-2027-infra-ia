inherited TasGeraNfeConfig: TTasGeraNfeConfig
  Caption = 'TasGeraNfeConfig'
  ClientHeight = 538
  Menu = Mnu_Principal
  ExplicitWidth = 592
  ExplicitHeight = 587
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Height = 510
    ActivePage = tbs_config
    ExplicitHeight = 441
    object tbs_config: TTabSheet
      Caption = 'tbs_config'
      ImageIndex = 9
      ExplicitHeight = 413
      object Panel8: TPanel
        Left = 0
        Top = 415
        Width = 578
        Height = 67
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitTop = 346
        object SB_Cfg_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 215
          Top = 2
          Width = 90
          Height = 63
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
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
          OnClick = SB_Cfg_AlterarClick
          ExplicitLeft = 212
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Cfg_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 305
          Top = 2
          Width = 92
          Height = 63
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
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
          OnClick = SB_Cfg_GravarClick
          ExplicitTop = 3
        end
        object Sb_Cfg_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 397
          Top = 2
          Width = 92
          Height = 63
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
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
          OnClick = Sb_Cfg_CancelarClick
          ExplicitLeft = 395
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Cfg_Sair: TSpeedButton
          AlignWithMargins = True
          Left = 489
          Top = 2
          Width = 87
          Height = 63
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
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
          OnClick = Sb_Cfg_SairClick
          ExplicitLeft = 493
          ExplicitTop = 3
        end
      end
      object Pnl_Nfe: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 415
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        ExplicitHeight = 346
        object Label18: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es da Nota Fiscal Eletr'#244'nica'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 280
        end
        object Pg_NFeConfig: TPageControl
          Left = 2
          Top = 18
          Width = 574
          Height = 395
          ActivePage = TabSheet3
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 326
          object tbs_ConfigGeral: TTabSheet
            Caption = 'Geral'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Config_Geral: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 318
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object Label24: TLabel
                Left = 110
                Top = 83
                Width = 180
                Height = 13
                Caption = 'e-mail para envio da nota ao Contador'
              end
              object Label2: TLabel
                Left = 381
                Top = 83
                Width = 59
                Height = 13
                Caption = 'S'#233'rie da N.F'
              end
              object Rg_Orien_Danfe: TRadioGroup
                Left = 219
                Top = 8
                Width = 80
                Height = 73
                Caption = 'DANFE'
                ItemIndex = 0
                Items.Strings = (
                  'Retrato'
                  'Paisagem')
                TabOrder = 0
              end
              object Rg_Emissao: TRadioGroup
                Left = 5
                Top = 6
                Width = 100
                Height = 211
                Caption = 'Forma de Emiss'#227'o'
                ItemIndex = 0
                Items.Strings = (
                  'Normal'
                  'Conting'#234'ncia'
                  'SCAN'
                  'DPEC'
                  'FDSA'
                  'SVCAN'
                  'SVC-RS'
                  'SVC-SP')
                TabOrder = 1
              end
              object GroupBox6: TGroupBox
                Left = 398
                Top = 9
                Width = 179
                Height = 70
                Caption = 'Duplicatas'
                Color = clBtnFace
                ParentColor = False
                TabOrder = 2
                object ChBx_NotaDuplicata: TCheckBox
                  Left = 5
                  Top = 19
                  Width = 156
                  Height = 17
                  Caption = 'Utilizar Nota Fiscal Duplicata'
                  TabOrder = 0
                end
                object ChBx_NotaDuplicataOcultaAVista: TCheckBox
                  Left = 5
                  Top = 41
                  Width = 156
                  Height = 17
                  Caption = 'Oculta Pagamentos '#224' Vista'
                  TabOrder = 1
                end
              end
              object Rg_Ambiente: TRadioGroup
                Left = 107
                Top = 8
                Width = 111
                Height = 73
                Caption = 'Ambiente de Destino'
                ItemIndex = 1
                Items.Strings = (
                  'Produ'#231#227'o'
                  'Homologa'#231#227'o')
                TabOrder = 3
              end
              object chbx_Visualizar: TCheckBox
                Left = 111
                Top = 123
                Width = 122
                Height = 17
                Caption = 'Visualizar Mensagem'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object Rg_posicao_CAnhoto: TRadioGroup
                Left = 300
                Top = 8
                Width = 97
                Height = 72
                Caption = 'Posi'#231#227'o Canhoto'
                ItemIndex = 0
                Items.Strings = (
                  'Cabe'#231'alho'
                  'Rodap'#233)
                TabOrder = 5
              end
              object E_email_contador: TEdit
                Left = 110
                Top = 98
                Width = 267
                Height = 22
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
              object chbx_copia_nfe: TCheckBox
                Left = 111
                Top = 139
                Width = 248
                Height = 17
                Caption = 'Receber C'#243'pia de NF-e no email principal '
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 7
              end
              object ChBx_MostraCodigoDestinatario: TCheckBox
                Left = 111
                Top = 157
                Width = 294
                Height = 17
                Caption = 'Mostrar c'#243'digo do destinat'#225'rio junto ao nome'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 8
              end
              object E_NF_Serie: TEdit
                Left = 381
                Top = 98
                Width = 73
                Height = 22
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 9
              end
              object Chbx_Bloqueia_Fechamento_Caixa: TCheckBox
                Left = 111
                Top = 175
                Width = 378
                Height = 17
                Caption = 'Bloquear fechamento de caixa enquanto houver NF-e pendente'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 10
              end
            end
          end
          object tbs_arquivosNfe: TTabSheet
            Caption = 'Arquivos'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Config_Arquivos: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 318
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object Sb_PathNFe: TSpeedButton
                Left = 250
                Top = 18
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathNFeClick
              end
              object Label35: TLabel
                Left = 5
                Top = 4
                Width = 97
                Height = 13
                Caption = 'Pasta Arquivos NF-e'
              end
              object Label39: TLabel
                Left = 5
                Top = 42
                Width = 142
                Height = 13
                Caption = 'Pasta Arquivos Cancelamento'
              end
              object Sb_PathCan: TSpeedButton
                Left = 250
                Top = 56
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathCanClick
              end
              object Label46: TLabel
                Left = 5
                Top = 80
                Width = 192
                Height = 13
                Caption = 'Pasta Arquivos CC-e - Carta de Corre'#231#227'o'
              end
              object Sb_PathCCe: TSpeedButton
                Left = 250
                Top = 94
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathCCeClick
              end
              object Label40: TLabel
                Left = 280
                Top = 4
                Width = 127
                Height = 13
                Caption = 'Pasta Arquivos Inutiliza'#231#227'o'
              end
              object Sb_PathInu: TSpeedButton
                Left = 544
                Top = 17
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathInuClick
              end
              object Label41: TLabel
                Left = 274
                Top = 42
                Width = 103
                Height = 13
                Caption = 'Pasta Arquivos DPEC'
              end
              object Sb_PathDPEC: TSpeedButton
                Left = 539
                Top = 56
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathDPECClick
              end
              object Label47: TLabel
                Left = 274
                Top = 80
                Width = 108
                Height = 13
                Caption = 'Pasta Arquivos Evento'
              end
              object Sb_PathEvento: TSpeedButton
                Left = 539
                Top = 94
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathEventoClick
              end
              object Label7: TLabel
                Left = 5
                Top = 119
                Width = 104
                Height = 13
                Caption = 'Pasta Arquivos NFC-e'
              end
              object Sb_PathNFCe: TSpeedButton
                Left = 251
                Top = 133
                Width = 23
                Height = 24
                Caption = '...'
                NumGlyphs = 2
                OnClick = Sb_PathNFCeClick
              end
              object cbxSalvarArqs: TCheckBox
                Left = 6
                Top = 159
                Width = 210
                Height = 17
                Caption = 'Salvar Arquivos em Pastas Separadas'
                TabOrder = 0
                Visible = False
              end
              object cbxPastaMensal: TCheckBox
                Left = 6
                Top = 175
                Width = 210
                Height = 17
                Caption = 'Criar Pastas Mensalmente'
                TabOrder = 1
                Visible = False
              end
              object cbxAdicionaLiteral: TCheckBox
                Left = 6
                Top = 191
                Width = 210
                Height = 17
                Caption = 'Adicionar Literal no nome das pastas'
                TabOrder = 2
                Visible = False
              end
              object cbxEmissaoPathNFe: TCheckBox
                Left = 6
                Top = 207
                Width = 233
                Height = 17
                Caption = 'Salvar NFe pelo campo Data de Emiss'#227'o'
                TabOrder = 3
                Visible = False
              end
              object cbxSalvaCCeCancelamentoPathEvento: TCheckBox
                Left = 6
                Top = 223
                Width = 233
                Height = 17
                Caption = 'Salvar Arqs Canc./CCe na pasta Eventos'
                TabOrder = 4
                Visible = False
              end
              object cbxSepararPorCNPJ: TCheckBox
                Left = 6
                Top = 239
                Width = 233
                Height = 17
                Caption = 'Separar Arqs pelo CNPJ do Certificado'
                TabOrder = 5
                Visible = False
              end
              object edtPathCCe: TEdit
                Left = 5
                Top = 96
                Width = 243
                Height = 21
                TabOrder = 6
              end
              object edtPathNFe: TEdit
                Left = 5
                Top = 20
                Width = 243
                Height = 21
                TabOrder = 7
              end
              object edtPathCan: TEdit
                Left = 5
                Top = 58
                Width = 243
                Height = 21
                TabOrder = 8
              end
              object edtPathInu: TEdit
                Left = 278
                Top = 20
                Width = 260
                Height = 21
                TabOrder = 9
              end
              object edtPathDPEC: TEdit
                Left = 278
                Top = 58
                Width = 260
                Height = 21
                TabOrder = 10
              end
              object edtPathEvento: TEdit
                Left = 278
                Top = 96
                Width = 260
                Height = 21
                TabOrder = 11
              end
              object cbxSepararPorModelo: TCheckBox
                Left = 6
                Top = 255
                Width = 239
                Height = 17
                Caption = 'Separar Arqs pelo Modelo do Documento'
                TabOrder = 12
                Visible = False
              end
              object edtPathNFCe: TEdit
                Left = 5
                Top = 135
                Width = 243
                Height = 21
                TabOrder = 13
              end
            end
          end
          object tbs_config_NFC_e: TTabSheet
            Caption = 'NFC-e'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Config_NFCe: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 298
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 318
              object Label30: TLabel
                Left = 7
                Top = 241
                Width = 91
                Height = 13
                Caption = 'Linha entre cupons'
              end
              object Label32: TLabel
                Left = 106
                Top = 241
                Width = 72
                Height = 13
                Caption = 'Largura Bobina'
              end
              object Panel2: TPanel
                Left = 6
                Top = 131
                Width = 559
                Height = 55
                BevelInner = bvRaised
                BevelOuter = bvLowered
                TabOrder = 4
                object Label23: TLabel
                  Left = 154
                  Top = 10
                  Width = 25
                  Height = 13
                  Caption = 'Porta'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label25: TLabel
                  Left = 3
                  Top = 10
                  Width = 35
                  Height = 13
                  Caption = 'Modelo'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label26: TLabel
                  Left = 379
                  Top = 10
                  Width = 53
                  Height = 13
                  Caption = 'Velocidade'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object Label27: TLabel
                  Left = 451
                  Top = 10
                  Width = 96
                  Height = 13
                  Caption = 'Linhas entre cupons'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object cbxPortaNFCe: TComboBox
                  Left = 154
                  Top = 26
                  Width = 223
                  Height = 21
                  TabOrder = 0
                end
                object CbxModeloNFCe: TComboBox
                  Left = 3
                  Top = 26
                  Width = 145
                  Height = 21
                  Style = csDropDownList
                  TabOrder = 1
                end
                object CbxVelocidadeNFCe: TComboBox
                  Left = 379
                  Top = 26
                  Width = 68
                  Height = 21
                  TabOrder = 2
                  Items.Strings = (
                    '9600'
                    '115200')
                end
                object edtLinhasEntreCupomNFCE: TSpinEdit
                  Left = 451
                  Top = 26
                  Width = 103
                  Height = 22
                  MaxValue = 50
                  MinValue = 1
                  TabOrder = 3
                  Value = 1
                end
              end
              object ChBx_NFCe: TCheckBox
                Left = 6
                Top = 6
                Width = 308
                Height = 17
                Caption = 'Ativar a emiss'#227'o de Nota Fiscal de Consumidor Eletr'#244'nica'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object GroupBox1: TGroupBox
                Left = 6
                Top = 24
                Width = 295
                Height = 99
                Caption = 'NFC-e Nota Fiscal Consumidor'
                TabOrder = 1
                object Label33: TLabel
                  Left = 5
                  Top = 14
                  Width = 75
                  Height = 13
                  Caption = 'IdToken/IdCSC'
                end
                object Label34: TLabel
                  Left = 5
                  Top = 52
                  Width = 57
                  Height = 13
                  Caption = 'Token/CSC'
                end
                object edtIdToken: TEdit
                  Left = 5
                  Top = 30
                  Width = 276
                  Height = 21
                  TabOrder = 0
                end
                object edtToken: TEdit
                  Left = 5
                  Top = 68
                  Width = 276
                  Height = 21
                  TabOrder = 1
                end
              end
              object chkImprimirDescAcresItemNFCE: TCheckBox
                Left = 7
                Top = 190
                Width = 215
                Height = 17
                Caption = 'Imprime desconto/acr'#233'scimo por item'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object ChBx_ESCPOS: TCheckBox
                Left = 14
                Top = 124
                Width = 297
                Height = 17
                Caption = 'Ativar 2'#186' modo de impress'#227'o para muitos Itens - ESC/POS'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object ChBx_EscPos_AtivaInicio: TCheckBox
                Left = 7
                Top = 205
                Width = 215
                Height = 17
                Caption = 'Ativar ESC/POS na inicializa'#231#227'o'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object chbx_Imp_auto_Esc_pos: TCheckBox
                Left = 8
                Top = 220
                Width = 265
                Height = 17
                Caption = 'Imprimir ou Visualizar automaticamente ao autorizar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
              object E_Linha_Entre_Cupom: TEdit
                Left = 7
                Top = 257
                Width = 93
                Height = 21
                TabOrder = 7
              end
              object E_LarguraBobina: TEdit
                Left = 106
                Top = 257
                Width = 93
                Height = 21
                TabOrder = 8
              end
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Outras informa'#231#245'es'
            ImageIndex = 3
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Config_Outras: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 318
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object chbx_Rastrea_completo: TCheckBox
                Left = 8
                Top = 34
                Width = 465
                Height = 17
                Caption = 'Preencher Tag Lote (Mostrar Rastreamento Completo)'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object chbx_Prenche_Lote_Valida: TCheckBox
                Left = 8
                Top = 17
                Width = 361
                Height = 17
                Caption = 'Preencher Lote e Validade'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object chbx_mostra_Lote: TCheckBox
                Left = 8
                Top = 0
                Width = 361
                Height = 17
                Caption = 'Mostrar Lote'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
            end
          end
          object TabSheet3: TTabSheet
            Caption = 'Certificado'
            ImageIndex = 4
            ExplicitHeight = 298
            object Pnl_Config_Certificado: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 367
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 298
              object lSSLLib1: TLabel
                Left = 6
                Top = 150
                Width = 44
                Height = 13
                Alignment = taRightJustify
                Caption = 'SSLType'
                Color = clBtnFace
                ParentColor = False
              end
              object lblXmlSign: TLabel
                Left = 6
                Top = 304
                Width = 57
                Height = 13
                Alignment = taRightJustify
                Caption = 'XMLSignLib'
                Color = clBtnFace
                ParentColor = False
              end
              object lblSSLLib: TLabel
                Left = 6
                Top = 184
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'SSLLib'
                Color = clBtnFace
                ParentColor = False
              end
              object lblCryptLib: TLabel
                Left = 6
                Top = 222
                Width = 38
                Height = 13
                Alignment = taRightJustify
                Caption = 'CryptLib'
                Color = clBtnFace
                ParentColor = False
              end
              object lblHttpLib: TLabel
                Left = 6
                Top = 261
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'HttpLib'
                Color = clBtnFace
                ParentColor = False
              end
              object GroupBox2: TGroupBox
                Left = 2
                Top = 43
                Width = 562
                Height = 102
                Align = alTop
                Caption = 'Dados do Certificado'
                TabOrder = 0
                DesignSize = (
                  562
                  102)
                object sbtnGetCert: TSpeedButton
                  Left = 295
                  Top = 22
                  Width = 163
                  Height = 26
                  Caption = 'Carregar o certificado'
                  NumGlyphs = 2
                  OnClick = sbtnGetCertClick
                end
                object Label17: TLabel
                  Left = 6
                  Top = 12
                  Width = 79
                  Height = 13
                  Caption = 'N'#250'mero de S'#233'rie'
                end
                object Label28: TLabel
                  Left = 6
                  Top = 52
                  Width = 99
                  Height = 13
                  Caption = 'Senha do Certificado'
                end
                object Lb_Explica_Certificado: TLabel
                  Left = 166
                  Top = 54
                  Width = 182
                  Height = 42
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  AutoSize = False
                  Caption = 'Explica'#231#245'es sobre o Tipo do Certificado'
                  WordWrap = True
                  ExplicitWidth = 407
                  ExplicitHeight = 35
                end
                object E_Serie_Certificado: TEdit
                  Left = 6
                  Top = 26
                  Width = 284
                  Height = 22
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object E_Senha_Certificado: TEdit
                  Left = 4
                  Top = 70
                  Width = 156
                  Height = 22
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  PasswordChar = '*'
                  TabOrder = 1
                end
              end
              object Rg_SSLTLS: TRadioGroup
                Left = 173
                Top = 149
                Width = 256
                Height = 73
                Caption = 'Configura'#231#245'es de SSL e TLS'
                ItemIndex = 1
                Items.Strings = (
                  'Usar SSL 2.0 e TSL 1.0'
                  'Usar SSL 3.0 e TSL 1.0')
                TabOrder = 1
              end
              object Rg_TipoCertificado: TRadioGroup
                Left = 2
                Top = 2
                Width = 562
                Height = 41
                Align = alTop
                Caption = 'Tipo do Certificado'
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'Utilizando Arquivo Certificado'
                  'Utiliza Cart'#227'o/Pendrive/Windows')
                TabOrder = 2
                OnClick = Rg_TipoCertificadoClick
              end
              object cbSSLType: TComboBox
                Left = 7
                Top = 165
                Width = 160
                Height = 21
                Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
                Style = csDropDownList
                TabOrder = 3
                OnChange = cbSSLTypeChange
              end
              object cbSSLLib: TComboBox
                Left = 6
                Top = 205
                Width = 160
                Height = 21
                Style = csDropDownList
                TabOrder = 4
                OnChange = cbSSLLibChange
              end
              object cbXmlSignLib: TComboBox
                Left = 6
                Top = 321
                Width = 160
                Height = 21
                Style = csDropDownList
                TabOrder = 5
                OnChange = cbXmlSignLibChange
              end
              object cbHttpLib: TComboBox
                Left = 6
                Top = 283
                Width = 160
                Height = 21
                Style = csDropDownList
                TabOrder = 6
                OnChange = cbHttpLibChange
              end
              object cbCryptLib: TComboBox
                Left = 6
                Top = 243
                Width = 160
                Height = 21
                Style = csDropDownList
                TabOrder = 7
                OnChange = cbCryptLibChange
              end
            end
          end
          object tbs_config_nfe: TTabSheet
            Caption = 'NF-e'
            ImageIndex = 5
            ExplicitHeight = 298
            object Pnl_Config_Nfe: TPanel
              Left = 0
              Top = 0
              Width = 566
              Height = 367
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              ExplicitHeight = 298
              object Label37: TLabel
                Left = 7
                Top = 5
                Width = 86
                Height = 13
                Caption = 'Margem Esquerda'
              end
              object Label38: TLabel
                Left = 106
                Top = 5
                Width = 80
                Height = 13
                Caption = 'Margem Superior'
              end
              object Label48: TLabel
                Left = 205
                Top = 5
                Width = 73
                Height = 13
                Caption = 'Margem Inferior'
              end
              object E_Nfe_Margem_Esquerda: TEdit
                Left = 7
                Top = 24
                Width = 93
                Height = 21
                TabOrder = 0
              end
              object E_Nfe_Margem_Superior: TEdit
                Left = 106
                Top = 24
                Width = 93
                Height = 21
                TabOrder = 1
              end
              object E_Nfe_Margem_Inferior: TEdit
                Left = 205
                Top = 24
                Width = 93
                Height = 21
                TabOrder = 2
              end
              object chbx_Sem_Codigo_Barras: TCheckBox
                Left = 11
                Top = 49
                Width = 291
                Height = 17
                Caption = 'N'#227'o enviar o c'#243'digo de barras na Nota Fiscal'
                TabOrder = 3
              end
            end
          end
        end
      end
    end
  end
  object Mnu_Principal: TMainMenu
    Left = 148
    Top = 304
    object MenuItem1: TMenuItem
      Caption = 'Tarefas'
      object MenuItem2: TMenuItem
        Caption = 'Status do Servi'#231'o'
        OnClick = MnuStatusServicoClick
      end
      object MenuItem10: TMenuItem
        Caption = '-'
      end
      object MenuItem11: TMenuItem
        Caption = 'Sair'
        OnClick = MenuItem11Click
      end
    end
  end
end

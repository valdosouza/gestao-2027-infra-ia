object Fr_geranfe_Srv: TFr_geranfe_Srv
  Left = 527
  Top = 45
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NFS-e - Nota Fiscal Eletr'#244'nica de Servi'#231'o'
  ClientHeight = 555
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Mnu_Principal
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pg_Principal: TPageControl
    Left = 0
    Top = 28
    Width = 647
    Height = 527
    ActivePage = tbs_NFS_e
    Align = alClient
    TabOrder = 0
    object tbs_NFS_e: TTabSheet
      Caption = 'NFS-e'
      ImageIndex = 1
      object Pnl_Botao: TPanel
        Left = 0
        Top = 434
        Width = 639
        Height = 65
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Sb_Enviar: TSpeedButton
          Left = 105
          Top = 2
          Width = 90
          Height = 61
          Align = alRight
          Caption = 'Enviar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_EnviarClick
          ExplicitLeft = 99
          ExplicitTop = 3
        end
        object Sb_Gerar: TSpeedButton
          Left = 15
          Top = 2
          Width = 90
          Height = 61
          Align = alRight
          Caption = 'Gerar RPS - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_GerarClick
          ExplicitLeft = 90
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_sair_0: TSpeedButton
          Left = 547
          Top = 2
          Width = 90
          Height = 61
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
          OnClick = Sb_sair_0Click
          ExplicitLeft = 626
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Envia_Mensagem: TSpeedButton
          Left = 457
          Top = 2
          Width = 90
          Height = 61
          Align = alRight
          Caption = 'Enviar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_Envia_MensagemClick
          ExplicitLeft = 451
          ExplicitTop = 6
        end
        object Sb_Imprimir: TSpeedButton
          Left = 367
          Top = 2
          Width = 90
          Height = 61
          Align = alRight
          Caption = 'Imprimir - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_ImprimirClick
          ExplicitLeft = 357
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_Consultar: TSpeedButton
          Left = 195
          Top = 2
          Width = 90
          Height = 61
          Align = alRight
          Caption = 'Consultar - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_ConsultarClick
          ExplicitLeft = 189
          ExplicitTop = 3
        end
        object Sb_Cancelar: TSpeedButton
          Left = 285
          Top = 2
          Width = 82
          Height = 61
          Align = alRight
          Caption = 'Cancelar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_CancelarClick
          ExplicitLeft = 362
          ExplicitTop = 6
          ExplicitHeight = 54
        end
      end
      object pnl_NF_e: TPanel
        Left = 0
        Top = 0
        Width = 639
        Height = 434
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        PopupMenu = PpMnu
        TabOrder = 1
        DesignSize = (
          639
          434)
        object Lb_titulo: TLabel
          Left = 2
          Top = 2
          Width = 635
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Acompanhamento da Opera'#231#227'o com Nota Fiscal Eletr'#244'nica'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 410
        end
        object MM_Acompanhamento: TMemo
          Left = 2
          Top = 18
          Width = 635
          Height = 359
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Ctl3D = False
          Lines.Strings = (
            '')
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WantReturns = False
          WantTabs = True
        end
        object E_Obs: TMemo
          Left = 898
          Top = 382
          Width = 447
          Height = 69
          TabOrder = 1
        end
        object CkBx_Recibo_Manual: TCheckBox
          Left = 4
          Top = 398
          Width = 293
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Informar o N'#250'mero do Recibo Provis'#243'rio Manualmente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CkBx_Lote_Manual: TCheckBox
          Left = 4
          Top = 383
          Width = 293
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Informar o n'#250'mero do Lote Manualmente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Pnl_Cancelamento: TPanel
          Left = 139
          Top = 112
          Width = 312
          Height = 192
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 4
          Visible = False
          object lb_TituloCancelamento: TLabel
            Left = 0
            Top = 0
            Width = 310
            Height = 13
            Align = alTop
            Alignment = taCenter
            Caption = 'INFORME O MOTIVO DO CANCELAMENTO'
            Color = clNavy
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            ExplicitWidth = 248
          end
          object Label9: TLabel
            Left = 4
            Top = 120
            Width = 177
            Height = 13
            Caption = 'Descreva a justificativa Manualmente'
          end
          object Rg_Cancelamento: TRadioGroup
            Left = 4
            Top = 14
            Width = 303
            Height = 105
            Caption = 'C'#243'digo de Cancelamento'
            ItemIndex = 0
            Items.Strings = (
              '1 - Erro de emiss'#227'o'
              '2 - Servi'#231'o n'#227'o concluido'
              '3 - RPS Cancelado na Emiss'#227'o')
            TabOrder = 0
          end
          object E_Motivo_Cancelamento: TEdit
            Left = 4
            Top = 136
            Width = 303
            Height = 19
            TabOrder = 1
          end
          object Btn_Confirmar: TButton
            Left = 157
            Top = 161
            Width = 75
            Height = 25
            Caption = 'Confirmar'
            TabOrder = 2
            OnClick = Btn_ConfirmarClick
          end
          object Btn_Cancelar: TButton
            Left = 233
            Top = 161
            Width = 74
            Height = 25
            Caption = 'Cancelar'
            TabOrder = 3
            OnClick = Btn_CancelarClick
          end
        end
        object Btn_Xml_Nota: TButton
          Left = 520
          Top = 401
          Width = 113
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Ver XML da Nota'
          TabOrder = 5
          Visible = False
          OnClick = Btn_Xml_NotaClick
        end
        object Btn_Xml_retorno: TButton
          Left = 414
          Top = 401
          Width = 113
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Ver XML Retorno'
          TabOrder = 6
          Visible = False
          OnClick = Btn_Xml_retornoClick
        end
        object chbx_forcar_consulta: TCheckBox
          Left = 4
          Top = 414
          Width = 293
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'For'#231'ar consulta quando nota estiver autorizada na prefeitura'
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
    object tbs_config: TTabSheet
      Caption = 'Configua'#231#245'es'
      object Pnl_Nfe: TPanel
        Left = 0
        Top = 0
        Width = 639
        Height = 432
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label18: TLabel
          Left = 2
          Top = 2
          Width = 635
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es da Nota Fiscal Eletr'#234'nica'
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
          Width = 635
          Height = 412
          ActivePage = tbs_ConfigGeral
          Align = alClient
          TabOrder = 0
          object tbs_ConfigGeral: TTabSheet
            Caption = 'Configura'#231#245'es'
            ImageIndex = 2
            object Pnl_Config_Geral: TPanel
              Left = 0
              Top = 0
              Width = 627
              Height = 384
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object PageControl1: TPageControl
                Left = 2
                Top = 2
                Width = 623
                Height = 380
                ActivePage = tbs_outras
                Align = alClient
                TabOrder = 0
                object tbs_Certfificado: TTabSheet
                  Caption = 'Certificado'
                  object lblHttpLib: TLabel
                    Left = 4
                    Top = 217
                    Width = 34
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'HttpLib'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lblCryptLib: TLabel
                    Left = 4
                    Top = 178
                    Width = 38
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'CryptLib'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lblSSLLib: TLabel
                    Left = 4
                    Top = 140
                    Width = 34
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'SSLLib'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lblXmlSign: TLabel
                    Left = 4
                    Top = 255
                    Width = 57
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'XMLSignLib'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object Rg_TipoCertificado: TRadioGroup
                    Left = 5
                    Top = 3
                    Width = 470
                    Height = 41
                    Caption = 'Tipo do Certificado'
                    Columns = 2
                    ItemIndex = 0
                    Items.Strings = (
                      'Utilizando Arquivo Certificado'
                      'Utiliza Cart'#227'o/Pendrive/Windows')
                    TabOrder = 0
                    OnClick = Rg_TipoCertificadoClick
                  end
                  object GroupBox2: TGroupBox
                    Left = 5
                    Top = 45
                    Width = 470
                    Height = 95
                    Caption = 'Dados do Certificado'
                    TabOrder = 1
                    DesignSize = (
                      470
                      95)
                    object sbtnGetCert: TSpeedButton
                      Left = 296
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
                      Left = 165
                      Top = 54
                      Width = 301
                      Height = 35
                      Anchors = [akLeft, akTop, akRight, akBottom]
                      AutoSize = False
                      Caption = 'Explica'#231#245'es sobre o Tipo do Certificado'
                      WordWrap = True
                      ExplicitWidth = 298
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
                      Left = 6
                      Top = 66
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
                  object cbCryptLib: TComboBox
                    Left = 4
                    Top = 194
                    Width = 160
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 2
                    OnChange = cbCryptLibChange
                  end
                  object cbSSLLib: TComboBox
                    Left = 4
                    Top = 156
                    Width = 160
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 3
                    OnChange = cbSSLLibChange
                  end
                  object cbHttpLib: TComboBox
                    Left = 4
                    Top = 234
                    Width = 160
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 4
                    OnChange = cbHttpLibChange
                  end
                  object cbXmlSignLib: TComboBox
                    Left = 4
                    Top = 272
                    Width = 160
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 5
                    OnChange = cbXmlSignLibChange
                  end
                end
                object tbs_webservice: TTabSheet
                  Caption = 'WbService'
                  ImageIndex = 1
                  object lSSLLib1: TLabel
                    Left = 3
                    Top = 52
                    Width = 44
                    Height = 13
                    Alignment = taRightJustify
                    Caption = 'SSLType'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object Rg_Ambiente: TRadioGroup
                    Left = 0
                    Top = 3
                    Width = 224
                    Height = 46
                    Caption = 'Ambiente de Destino'
                    Columns = 2
                    ItemIndex = 1
                    Items.Strings = (
                      'Produ'#231#227'o'
                      'Homologa'#231#227'o')
                    TabOrder = 0
                  end
                  object cbSSLType: TComboBox
                    Left = 3
                    Top = 71
                    Width = 175
                    Height = 21
                    Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
                    Style = csDropDownList
                    TabOrder = 1
                    OnChange = cbSSLTypeChange
                  end
                  object Rg_SSLTLS: TRadioGroup
                    Left = 4
                    Top = 94
                    Width = 174
                    Height = 73
                    Caption = 'Configura'#231#245'es de SSL e TLS'
                    ItemIndex = 1
                    Items.Strings = (
                      'Usar SSL 2.0 e TSL 1.0'
                      'Usar SSL 3.0 e TSL 1.0')
                    TabOrder = 2
                  end
                  object GroupBox3: TGroupBox
                    Left = 3
                    Top = 169
                    Width = 291
                    Height = 134
                    Caption = 'Acesso a Sistema Web'
                    TabOrder = 3
                    object Label6: TLabel
                      Left = 8
                      Top = 51
                      Width = 31
                      Height = 13
                      Caption = 'Senha'
                    end
                    object Label20: TLabel
                      Left = 8
                      Top = 15
                      Width = 36
                      Height = 13
                      Caption = 'Usu'#225'rio'
                    end
                    object Label5: TLabel
                      Left = 8
                      Top = 87
                      Width = 64
                      Height = 13
                      Caption = 'Frase secreta'
                    end
                    object E_Pws_WEb: TEdit
                      Left = 8
                      Top = 65
                      Width = 249
                      Height = 21
                      PasswordChar = '*'
                      TabOrder = 1
                    end
                    object E_User_Web: TEdit
                      Left = 8
                      Top = 29
                      Width = 249
                      Height = 21
                      TabOrder = 0
                    end
                    object E_Frase_WEb: TEdit
                      Left = 8
                      Top = 101
                      Width = 249
                      Height = 21
                      TabOrder = 2
                    end
                  end
                end
                object tbs_outras: TTabSheet
                  Caption = 'Outras'
                  ImageIndex = 2
                  object Label58: TLabel
                    Left = 7
                    Top = 37
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
                  object Label69: TLabel
                    Left = 7
                    Top = 73
                    Width = 199
                    Height = 13
                    Caption = 'C'#243'digo do Regime Especial de Tributa'#231#227'o'
                  end
                  object Label10: TLabel
                    Left = 146
                    Top = 37
                    Width = 137
                    Height = 13
                    Caption = 'C'#243'digo Tributa'#231#227'o Mun'#237'cipio'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clNavy
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label11: TLabel
                    Left = 289
                    Top = 32
                    Width = 65
                    Height = 13
                    Caption = 'C'#243'digo CNAE'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clNavy
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label12: TLabel
                    Left = 251
                    Top = 72
                    Width = 219
                    Height = 13
                    Caption = 'Provedor dos Servi'#231'os utilizado pelo Prefeitura'
                  end
                  object Label1: TLabel
                    Left = 10
                    Top = 114
                    Width = 75
                    Height = 13
                    Caption = 'Layout Utilizado'
                  end
                  object Label3: TLabel
                    Left = 192
                    Top = 114
                    Width = 33
                    Height = 13
                    Caption = 'Vers'#227'o'
                  end
                  object Label4: TLabel
                    Left = 3
                    Top = 162
                    Width = 107
                    Height = 13
                    Caption = 'Formato Discrimina'#231#227'o'
                  end
                  object Label13: TLabel
                    Left = 434
                    Top = 32
                    Width = 58
                    Height = 13
                    Caption = 'C'#243'digo NBS'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clNavy
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object chbx_Visualizar: TCheckBox
                    Left = 8
                    Top = 3
                    Width = 122
                    Height = 17
                    Caption = 'Visualizar Mensagem'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clNavy
                    Font.Height = -11
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                  end
                  object chbx_copia_nfe: TCheckBox
                    Left = 8
                    Top = 19
                    Width = 248
                    Height = 17
                    Caption = 'Receber C'#243'pia de NF-e no email principal '
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clNavy
                    Font.Height = -11
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object E_Nfse_Cd_LC116: TEdit
                    Left = 7
                    Top = 51
                    Width = 136
                    Height = 21
                    TabOrder = 2
                  end
                  object Cb_CRET: TComboBox
                    Left = 7
                    Top = 89
                    Width = 241
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 3
                    Text = '00 - Nenhum'
                    Items.Strings = (
                      '00 - Nenhum'
                      '01 - MicroempresaMunicipal,'
                      '02 - Estimativa,'
                      '03 - SociedadeProfissionais,'
                      '04 - Cooperativa,'
                      '05 - MicroempresarioIndividual,'
                      '06 - MicroempresarioEmpresaPP,'
                      '07 - LucroReal,'
                      '08 - LucroPresumido,'
                      '09 - SimplesNacional])')
                  end
                  object E_CodigoTribMunicipio: TEdit
                    Left = 145
                    Top = 51
                    Width = 143
                    Height = 21
                    TabOrder = 4
                  end
                  object E_CodigoCnae: TEdit
                    Left = 290
                    Top = 51
                    Width = 143
                    Height = 21
                    TabOrder = 5
                  end
                  object Cb_Provedor: TComboBox
                    Left = 251
                    Top = 88
                    Width = 241
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 6
                    Items.Strings = (
                      'PadraoNacional'
                      'ISSNet'
                      'IPMSistemas')
                  end
                  object cbLayoutNFSe: TComboBox
                    Left = 10
                    Top = 133
                    Width = 159
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 7
                    Text = 'Nacional'
                    Items.Strings = (
                      'Nacional'
                      'Provedor')
                  end
                  object Cb_versao_utilizado: TComboBox
                    Left = 192
                    Top = 133
                    Width = 120
                    Height = 21
                    Style = csDropDownList
                    TabOrder = 8
                    Items.Strings = (
                      've100'
                      've101'
                      've102'
                      've103'
                      've200'
                      've201'
                      've202'
                      've203'
                      've204')
                  end
                  object cbFormatoDiscr: TComboBox
                    Left = 10
                    Top = 181
                    Width = 120
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 9
                    Text = 'Nacional'
                    Items.Strings = (
                      'Nacional'
                      'Provedor')
                  end
                  object E_CodigoNBS: TEdit
                    Left = 435
                    Top = 51
                    Width = 143
                    Height = 21
                    TabOrder = 10
                  end
                end
              end
            end
          end
          object tbs_arquivosNfe: TTabSheet
            Caption = 'Arquivos'
            object Pnl_Config_Arquivos: TPanel
              Left = 0
              Top = 0
              Width = 627
              Height = 384
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object Sb_Path_NFSe: TSpeedButton
                Left = 255
                Top = 18
                Width = 23
                Height = 24
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                  333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                  0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                  07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                  07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                  0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                  33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                  B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                  3BB33773333773333773B333333B3333333B7333333733333337}
                NumGlyphs = 2
                OnClick = Sb_Path_NFSeClick
              end
              object Label35: TLabel
                Left = 5
                Top = 4
                Width = 104
                Height = 13
                Caption = 'Pasta Arquivos NFS-e'
              end
              object Label39: TLabel
                Left = 5
                Top = 42
                Width = 96
                Height = 13
                Caption = 'Pasta Arquivos RPS'
              end
              object Sb_Path_RPS: TSpeedButton
                Left = 255
                Top = 56
                Width = 23
                Height = 24
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                  333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                  0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                  07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                  07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                  0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                  33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                  B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                  3BB33773333773333773B333333B3333333B7333333733333337}
                NumGlyphs = 2
                OnClick = Sb_Path_RPSClick
              end
              object Sb_Path_Schemas: TSpeedButton
                Left = 255
                Top = 95
                Width = 23
                Height = 24
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                  333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                  0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                  07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                  07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                  0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                  33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                  B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                  3BB33773333773333773B333333B3333333B7333333733333337}
                NumGlyphs = 2
                OnClick = Sb_Path_SchemasClick
              end
              object Label30: TLabel
                Left = 6
                Top = 81
                Width = 108
                Height = 13
                Caption = 'Schemas do Provedor:'
              end
              object Label2: TLabel
                Left = 4
                Top = 120
                Width = 143
                Height = 13
                Caption = 'Arquivo Inicializa'#231#227'o Provedor'
              end
              object Sb_Arq_Ini_Provedor: TSpeedButton
                Left = 253
                Top = 134
                Width = 23
                Height = 24
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                  333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                  0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                  07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                  07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                  0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                  33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                  B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                  3BB33773333773333773B333333B3333333B7333333733333337}
                NumGlyphs = 2
                OnClick = Sb_Arq_Ini_ProvedorClick
              end
              object Label7: TLabel
                Left = 4
                Top = 160
                Width = 94
                Height = 13
                Caption = 'Nome da Prefeitura '
              end
              object Label8: TLabel
                Left = 4
                Top = 200
                Width = 87
                Height = 13
                Caption = 'Logo da Prefeitura'
              end
              object Sb_LogoPrefeitura: TSpeedButton
                Left = 253
                Top = 214
                Width = 23
                Height = 24
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                  333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                  0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                  07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                  07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                  0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                  33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                  B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                  3BB33773333773333773B333333B3333333B7333333733333337}
                NumGlyphs = 2
                OnClick = Sb_LogoPrefeituraClick
              end
              object E_Path_NFSe: TEdit
                Left = 5
                Top = 20
                Width = 245
                Height = 21
                TabOrder = 0
              end
              object E_Path_RPS: TEdit
                Left = 5
                Top = 58
                Width = 245
                Height = 21
                TabOrder = 1
              end
              object E_Path_Schemas: TEdit
                Left = 5
                Top = 97
                Width = 245
                Height = 21
                TabOrder = 2
              end
              object E_Arq_Ini_Provedor: TEdit
                Left = 3
                Top = 136
                Width = 245
                Height = 21
                TabOrder = 3
              end
              object E_NomePrefeitura: TEdit
                Left = 3
                Top = 176
                Width = 276
                Height = 21
                TabOrder = 4
              end
              object E_LogoPrefeitura: TEdit
                Left = 3
                Top = 216
                Width = 245
                Height = 21
                TabOrder = 5
              end
            end
          end
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 432
        Width = 639
        Height = 67
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          639
          67)
        object SB_Cfg_Alterar: TSpeedButton
          Left = 270
          Top = 6
          Width = 90
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
          OnClick = SB_Cfg_AlterarClick
          ExplicitLeft = 212
        end
        object SB_Cfg_Gravar: TSpeedButton
          Left = 366
          Top = 6
          Width = 92
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
          OnClick = SB_Cfg_GravarClick
        end
        object Sb_Cfg_Cancelar: TSpeedButton
          Left = 453
          Top = 6
          Width = 92
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
          OnClick = Sb_Cfg_CancelarClick
          ExplicitLeft = 395
        end
        object Sb_Cfg_Sair: TSpeedButton
          Left = 545
          Top = 6
          Width = 87
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
          OnClick = Sb_Cfg_SairClick
          ExplicitLeft = 487
        end
      end
    end
    object tbs_xml_retorno: TTabSheet
      Caption = 'XML de Retorno'
      ImageIndex = 2
      object WBXmlRetorno: TWebBrowser
        Left = 0
        Top = 0
        Width = 639
        Height = 432
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 559
        ExplicitHeight = 446
        ControlData = {
          4C0000000B420000A62C00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126200000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel1: TPanel
        Left = 0
        Top = 432
        Width = 639
        Height = 67
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          639
          67)
        object SpeedButton4: TSpeedButton
          Left = 545
          Top = 6
          Width = 87
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Voltar'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SpeedButton4Click
          ExplicitLeft = 487
        end
      end
    end
    object tbs_xml_nota: TTabSheet
      Caption = 'XML da Nota'
      ImageIndex = 3
      object WBXmlNotas: TWebBrowser
        Left = 0
        Top = 0
        Width = 639
        Height = 432
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 559
        ExplicitHeight = 446
        ControlData = {
          4C0000000B420000A62C00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126200000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel2: TPanel
        Left = 0
        Top = 432
        Width = 639
        Height = 67
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          639
          67)
        object SpeedButton1: TSpeedButton
          Left = 545
          Top = 6
          Width = 87
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Voltar'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SpeedButton1Click
          ExplicitLeft = 487
        end
      end
    end
  end
  object Pnl_Validade: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 641
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Pnl_Cert_Validade: TPanel
      Left = 0
      Top = 0
      Width = 264
      Height = 22
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Validade do Certificado Digital'
      TabOrder = 0
    end
    object Pnl_Cert_Expira: TPanel
      Left = 264
      Top = 0
      Width = 377
      Height = 22
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'O certificado expira em 1 dia(s)'
      TabOrder = 1
    end
  end
  object Mnu_Principal: TMainMenu
    Left = 500
    Top = 328
    object MnuTarefas: TMenuItem
      Caption = 'Tarefas'
      object MnuSchemas: TMenuItem
        Caption = 'Atualizar Schemas'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object Qr_Nota: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '      PED_CODIGO, '
      '      PED_PRAZO,'
      '      PED_VL_PEDIDO,'
      '      FPT_DESCRICAO,'
      '      PED_DATA,'
      '      NFL_CODIGO,'
      '     NFL_NUMERO, '
      '     NFL_CODTRP,'
      '      PED_CODFPG,'
      '      EMP_CODIGO, '
      '      EMP_NOME, '
      '      EMP_CNPJ, '
      '      EMP_INSC_EST,'
      '      EMP_INSC_MUN,'
      '      EMP_EMAIL,'
      '      END_ENDER,'
      '      END_NUMERO,'
      '      END_COMPLEM,'
      '      END_BAIRRO,'
      '      END_CEP,  '
      '      CDD_IBGE, '
      '      CDD_DESCRICAO,'
      '      END_FONE, '
      '     END_CELULAR,'
      '      UFE_SIGLA, '
      '      UFE_CODIGO,'
      '      END_PAIS,  '
      '      CLI_ISS_RET,'
      '      NFL_DT_EMISSAO, '
      '      NFL_VL_TL_SRV,'
      '      NFL_STATUS,'
      '     CLI_ISS_EXIGIB,'
      '    NFS_NUMERO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '      INNER JOIN TB_PEDIDO pd'
      '      ON (pd.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '      inner join tb_formapagto fp'
      '      on (fp.fpt_codigo = pd.ped_codfpg)'
      ''
      '      INNER JOIN TB_EMPRESA tb_empresa'
      '      ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '     INNER JOIN TB_CLIENTE tb_cliente'
      '     ON (tb_cliente.CLI_CODEMP = tb_empresa.EMP_CODIGO)  '
      ''
      '     INNER  JOIN TB_ENDERECO tb_endereco                  '
      '     ON (tb_endereco.END_CODIGO = pd.PED_CODEND)'
      ''
      '     INNER JOIN TB_CIDADE tb_cidade'
      '     ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '     INNER JOIN TB_UF tb_uf'
      '     ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '     INNER  JOIN TB_PAIS tb_pais'
      '     ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)   '
      '    left outer join tb_retorno_nfs nfse'
      '    ON (NFS_CODNFL = NFL_CODIGO)'
      '     '
      'WHERE (NFL_CODIGO=:NFL_CODIGO)  ')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 368
    Top = 88
    ParamData = <
      item
        Name = 'NFL_CODIGO'
      end>
  end
  object Qr_Itens: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'select '
      '   PRO_CODIGO,'
      '    PRO_DESCRICAO,'
      '    ITF_QTDE,'
      '    ITF_VL_UNIT,'
      '    ITF_VL_DESC,'
      '    ISS_VL_BC ,'
      '    ISS_AQ_NR,'
      '    ISS_VL_NR,'
      '    ISS_MUN_IBGE,'
      '    ISS_LST_SRV,'
      '    ISS_SIT_TRIB,'
      '    ISS_VL_PIS,'
      '    ISS_VL_CFS,'
      '    ISS_VL_RET,'
      '    ( ITF_QTDE *  ITF_VL_UNIT) ISS_VL_SUBTOTAL'
      '    '
      'from TB_ITENS_ISSQN'
      '    INNER JOIN TB_ITENS_NFL'
      '    ON (ITF_CODIGO = ISS_CODITF)'
      '   INNER JOIN TB_PRODUTO'
      '  ON (PRO_CODIGO = ITF_CODPRO)'
      'WHERE ISS_CODNFL =:NFL_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 470
    Top = 100
    ParamData = <
      item
        Name = 'NFL_CODIGO'
      end>
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*-nfe.XML'
    Filter = 
      'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|To' +
      'dos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 464
    Top = 56
  end
  object PpMnu: TPopupMenu
    Left = 108
    Top = 400
    object AtualizarAtravsdoXML1: TMenuItem
      Caption = 'Atualizar Atrav'#233's do XML'
      OnClick = AtualizarAtravsdoXML1Click
    end
  end
  object Qr_Observacao: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'select '
      'OBN_CODIGO,'
      'OBN_TIPO,'
      'OBN_DETALHE'
      'from TB_OBS_NFE'
      'where OBN_CODNFL=:NFL_CODIGO AND OBN_TIPO=:OBN_TIPO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 313
    Top = 181
    ParamData = <
      item
        Name = 'NFL_CODIGO'
      end
      item
        Name = 'OBN_TIPO'
      end>
  end
  object Qr_Parcelamento: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PARCELAMENTO '
      'WHERE PAR_CODPED=:PAR_CODPED'
      'ORDER BY PAR_PARCELA')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 312
    Top = 80
    ParamData = <
      item
        Name = 'PAR_CODPED'
      end>
  end
  object ACBrMail: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 168
    Top = 352
  end
  object Dfe_NFSe: TACBrNFSeXDANFSeRL
    Sistema = 'Setes - Gest'#227'o Computacional'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.099999999999999000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    CasasDecimais.Aliquota = 2
    CasasDecimais.MaskAliquota = ',0.00'
    ACBrNFSe = NFS_e
    Cancelada = False
    ImprimeCanhoto = True
    TamanhoFonte = 6
    FormatarNumeroDocumentoNFSe = True
    Provedor = proNenhum
    Producao = snSim
    Left = 70
    Top = 345
  end
  object NFS_e: TACBrNFSeX
    MAIL = ACBrMail
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.ExibirErroSchema = False
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.CodigoMunicipio = 0
    Configuracoes.Geral.Provedor = proIPM
    Configuracoes.Geral.Versao = ve100
    Configuracoes.Geral.Emitente.DadosEmitente.Email = 'contato@provedor.com.br'
    Configuracoes.Geral.LayoutNFSe = lnfsPadraoNacionalv1
    Configuracoes.Geral.GerarTodasSecoes = False
    Configuracoes.Geral.Documentar = False
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    DANFSE = Dfe_NFSe
    Left = 30
    Top = 345
  end
end

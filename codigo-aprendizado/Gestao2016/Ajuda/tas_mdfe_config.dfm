inherited TasMdfeConfig: TTasMdfeConfig
  Caption = 'Configura'#231#227'o Manisfeto Eletr'#244'nico'
  ClientHeight = 487
  ClientWidth = 625
  ExplicitWidth = 631
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 422
    Width = 625
    Height = 65
    ExplicitTop = 422
    ExplicitWidth = 625
    ExplicitHeight = 65
    inherited SB_Inserir: TSpeedButton
      Left = 9
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 10
      ExplicitTop = 5
      ExplicitHeight = 55
    end
    inherited SB_Alterar: TSpeedButton
      Left = 111
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 107
      ExplicitTop = 5
      ExplicitHeight = 55
    end
    inherited SB_Excluir: TSpeedButton
      Left = 213
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 209
      ExplicitTop = 5
      ExplicitHeight = 55
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 417
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 417
      ExplicitTop = 4
      ExplicitHeight = 55
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 519
      Height = 55
      Margins.Left = 0
      Margins.Right = 2
      ExplicitLeft = 520
      ExplicitTop = 5
      ExplicitHeight = 55
    end
    inherited SB_Gravar: TSpeedButton
      Left = 315
      Height = 55
      Margins.Left = 0
      Margins.Right = 0
      ExplicitLeft = 311
      ExplicitTop = 5
      ExplicitHeight = 55
    end
  end
  inherited pnl_fundo: TPanel
    Top = 28
    Width = 625
    Height = 394
    ExplicitTop = 28
    ExplicitWidth = 625
    ExplicitHeight = 394
    object Pg_MFDeConfig: TPageControl
      Left = 2
      Top = 2
      Width = 621
      Height = 390
      ActivePage = tbs_ConfigGeral
      Align = alClient
      TabOrder = 0
      object tbs_ConfigGeral: TTabSheet
        Caption = 'Geral'
        ImageIndex = 2
        object Pnl_Config_Geral: TPanel
          Left = 0
          Top = 0
          Width = 613
          Height = 362
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label35: TLabel
            Left = 107
            Top = 83
            Width = 106
            Height = 13
            Caption = 'Pasta Arquivos MDF-e'
          end
          object Sb_PathNFe: TSpeedButton
            Left = 352
            Top = 97
            Width = 23
            Height = 24
            Caption = '...'
            NumGlyphs = 2
            OnClick = Sb_PathNFeClick
          end
          object Rg_Orien_Damdfe: TRadioGroup
            Left = 219
            Top = 6
            Width = 74
            Height = 73
            Caption = 'DAMDFE'
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
            Height = 189
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
              'SVC-SP'
              'OFF-lINE')
            TabOrder = 1
          end
          object Rg_Ambiente: TRadioGroup
            Left = 107
            Top = 6
            Width = 111
            Height = 73
            Caption = 'Ambiente de Destino'
            ItemIndex = 1
            Items.Strings = (
              'Produ'#231#227'o'
              'Homologa'#231#227'o')
            TabOrder = 2
          end
          object chbx_Visualizar: TCheckBox
            Left = 108
            Top = 120
            Width = 122
            Height = 17
            Caption = 'Visualizar Mensagem'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object chbx_copia_mdfe_proprio: TCheckBox
            Left = 108
            Top = 136
            Width = 248
            Height = 17
            Caption = 'Receber C'#243'pia de MDF-e no email principal '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object chbx_copia_mdfe_contador: TCheckBox
            Left = 108
            Top = 152
            Width = 248
            Height = 17
            Caption = 'Enviar C'#243'pia de MDF-e no email Contador'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object E_Pasta_MDFe: TEdit
            Left = 107
            Top = 99
            Width = 243
            Height = 21
            TabOrder = 6
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Certificado'
        ImageIndex = 1
        object pnl_config_cert: TPanel
          Left = 0
          Top = 0
          Width = 613
          Height = 362
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label2: TLabel
            Left = 9
            Top = 141
            Width = 41
            Height = 13
            Alignment = taRightJustify
            Caption = 'SSLType'
            Color = clBtnFace
            ParentColor = False
          end
          object lblXmlSign: TLabel
            Left = 11
            Top = 299
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'XMLSignLib'
            Color = clBtnFace
            ParentColor = False
          end
          object lblSSLLib: TLabel
            Left = 10
            Top = 184
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'SSLLib'
            Color = clBtnFace
            ParentColor = False
          end
          object lblCryptLib: TLabel
            Left = 4
            Top = 222
            Width = 40
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
          object Gb_Dados_Cert: TGroupBox
            Left = 2
            Top = 43
            Width = 609
            Height = 95
            Align = alTop
            Caption = 'Dados do Certificado'
            TabOrder = 0
            DesignSize = (
              609
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
            object Label3: TLabel
              Left = 6
              Top = 52
              Width = 100
              Height = 13
              Caption = 'Senha do Certificado'
            end
            object Lb_Explica_Certificado: TLabel
              Left = 165
              Top = 54
              Width = 406
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
          object Rg_SSLTLS: TRadioGroup
            Left = 172
            Top = 144
            Width = 256
            Height = 73
            Caption = 'Configura'#231#245'es de SSL e TLS'
            ItemIndex = 1
            Items.Strings = (
              'Usar SSL 2.0 e TSL 1.0'
              'Usar SSL 3.0 e TSL 1.0')
            TabOrder = 1
            OnClick = Rg_SSLTLSClick
          end
          object Rg_TipoCertificado: TRadioGroup
            Left = 2
            Top = 2
            Width = 609
            Height = 41
            Align = alTop
            Caption = 'Tipo do Certificado'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Utilizando Arquivo Certificado'
              'Utiliza Cart'#227'o/Pendrive/Windows')
            TabOrder = 2
          end
          object cbSSLType: TComboBox
            Left = 6
            Top = 158
            Width = 160
            Height = 21
            Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
            Style = csDropDownList
            TabOrder = 3
            OnChange = cbSSLTypeChange
          end
          object cbSSLLib: TComboBox
            Left = 6
            Top = 200
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 4
            OnChange = cbSSLLibChange
          end
          object cbXmlSignLib: TComboBox
            Left = 6
            Top = 316
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 5
            OnChange = cbXmlSignLibChange
          end
          object cbHttpLib: TComboBox
            Left = 6
            Top = 278
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 6
            OnChange = cbHttpLibChange
          end
          object cbCryptLib: TComboBox
            Left = 6
            Top = 238
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 7
            OnChange = cbCryptLibChange
          end
        end
      end
    end
  end
  object Pnl_Validade: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 619
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
    TabOrder = 2
    object Pnl_Cert_Validade: TPanel
      Left = 0
      Top = 0
      Width = 308
      Height = 22
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Validade do Certificado Digital'
      TabOrder = 0
    end
    object Pnl_Cert_Expira: TPanel
      Left = 308
      Top = 0
      Width = 311
      Height = 22
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'O certificado expira em 1 dia(s)'
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 456
    Top = 56
  end
end

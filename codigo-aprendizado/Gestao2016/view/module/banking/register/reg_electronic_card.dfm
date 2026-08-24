inherited RegElectronicCard: TRegElectronicCard
  Caption = 'Cadastro de Cart'#245'es Eletr'#244'nicos'
  ClientHeight = 405
  ClientWidth = 566
  ExplicitWidth = 572
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 341
    Width = 566
    ExplicitTop = 185
    ExplicitWidth = 566
    inherited SB_Inserir: TSpeedButton
      Left = 17
      Width = 86
      ExplicitLeft = 51
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      Width = 87
      ExplicitLeft = 130
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Excluir: TSpeedButton
      Left = 194
      Width = 93
      ExplicitLeft = 212
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 378
      Width = 87
      ExplicitLeft = 386
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      Width = 94
      ExplicitLeft = 464
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Gravar: TSpeedButton
      Left = 289
      Width = 87
      ExplicitLeft = 285
      ExplicitTop = 5
      ExplicitWidth = 87
    end
  end
  inherited pnl_fundo: TPanel
    Width = 566
    Height = 341
    ExplicitWidth = 566
    ExplicitHeight = 185
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 562
      Height = 337
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = -2
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 6
        Top = 106
        Width = 152
        Height = 14
        Caption = 'Nome de Contato da Operadora'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 346
        Top = 105
        Width = 24
        Height = 14
        Caption = 'Fone'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 454
        Top = 105
        Width = 86
        Height = 14
        Caption = 'V'#225'lidade Contrato'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 20
        Width = 49
        Height = 22
        Color = clScrollBar
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object grbx_vista: TGroupBox
        Left = 165
        Top = 46
        Width = 193
        Height = 58
        Caption = 'Pagamento '#224' vista'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label4: TLabel
          Left = 5
          Top = 13
          Width = 88
          Height = 14
          AutoSize = False
          Caption = 'Taxa de Desconto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label8: TLabel
          Left = 96
          Top = 13
          Width = 84
          Height = 14
          AutoSize = False
          Caption = 'Prazo Pagamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object E_Aliq_Cred: TEdit
          Left = 4
          Top = 29
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object E_Prz_Cred: TEdit
          Left = 95
          Top = 29
          Width = 90
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
      object grbx_parcela: TGroupBox
        Left = 368
        Top = 46
        Width = 188
        Height = 58
        Caption = 'Pagamento Parcelado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Label9: TLabel
          Left = 4
          Top = 12
          Width = 88
          Height = 14
          AutoSize = False
          Caption = 'Taxa de Desconto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label5: TLabel
          Left = 95
          Top = 11
          Width = 84
          Height = 14
          AutoSize = False
          Caption = 'Prazo Pagamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object E_Aliq_Debi: TEdit
          Left = 3
          Top = 28
          Width = 90
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object E_Prz_DEbi: TEdit
          Left = 93
          Top = 28
          Width = 90
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
      object E_Contato: TEdit
        Left = 6
        Top = 121
        Width = 339
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object E_Fone: TEdit
        Left = 345
        Top = 121
        Width = 107
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
      object E_Validade: TEdit
        Left = 452
        Top = 121
        Width = 101
        Height = 22
        Hint = 'Formato aceito: DD/MM/AAAA'
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
      object dbrg_tipo: TRadioGroup
        Left = 7
        Top = 46
        Width = 155
        Height = 58
        Caption = 'Tipo do Cart'#227'o'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Cr'#233'dito'
          'D'#233'bito')
        ParentFont = False
        TabOrder = 1
      end
      inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
        Left = 4
        Top = 144
        Width = 551
        Height = 41
        TabOrder = 7
        ExplicitLeft = 4
        ExplicitTop = 144
        ExplicitWidth = 551
        ExplicitHeight = 41
        inherited L_ContaBancaria: TLabel
          Width = 551
        end
        inherited Sb_ContaBancaria: TSpeedButton
          Left = 524
          Height = 26
          ExplicitHeight = 26
        end
        inherited DBLCB_ContaBancaria: TDBLookupComboBox
          Width = 515
          DataField = 'CTE_CODCTB'
          ExplicitWidth = 515
        end
      end
      inline Fm_CentroCusto: TFm_CentroCusto
        Left = 6
        Top = 183
        Width = 450
        Height = 71
        TabOrder = 8
        ExplicitLeft = 6
        ExplicitTop = 183
        ExplicitHeight = 71
        inherited Grb_Cta_CentroCusto: TGroupBox
          Height = 71
          ExplicitHeight = 71
          inherited E_Codigo_Plano: TEdit_Setes
            TabStop = False
          end
        end
        inherited Qr_PlanoContas: TSTQuery
          Left = 310
          Top = 59
        end
        inherited Ds_PlanoContas: TDataSource
          Top = 51
        end
      end
      inline Fm_CentroResultado: TFm_CentroResultado
        Left = 7
        Top = 250
        Width = 451
        Height = 71
        TabOrder = 9
        TabStop = True
        ExplicitLeft = 7
        ExplicitTop = 250
        ExplicitHeight = 71
        inherited Grb_Cta_Resultado: TGroupBox
          Height = 71
          ExplicitHeight = 71
          inherited DBLCB_Plano: TDBLookupComboBox
            DataField = 'CTE_CODPLC_C'
          end
          inherited E_Codigo_Plano: TEdit_Setes
            TabStop = False
          end
        end
      end
      inline Fm_FormaPagto: TFm_FormaPagto
        Left = 56
        Top = 4
        Width = 498
        Height = 42
        TabOrder = 10
        ExplicitLeft = 56
        ExplicitTop = 4
        ExplicitWidth = 498
        ExplicitHeight = 42
        inherited Lb_FormaPagamento: TLabel
          Width = 492
        end
        inherited pnl_Forma: TPanel
          Width = 498
          Height = 28
          ExplicitWidth = 498
          ExplicitHeight = 28
          inherited SB_FormaPag: TSpeedButton
            Left = 472
            Height = 25
            ExplicitLeft = 474
            ExplicitTop = 15
            ExplicitHeight = 28
          end
          inherited DBLCB_FormaPagto: TDBLookupComboBox
            Width = 463
            DataField = 'CTE_CODFPT'
            ExplicitWidth = 463
          end
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 464
    Top = 65520
  end
end

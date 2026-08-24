inherited RegTaxation: TRegTaxation
  Caption = 'Cadastros de Tributa'#231#245'es para Nota Fiscal Eletr'#244'nica'
  ClientHeight = 635
  ClientWidth = 617
  ExplicitWidth = 623
  ExplicitHeight = 684
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 571
    Width = 617
    ExplicitTop = 571
    ExplicitWidth = 617
    inherited SB_Inserir: TSpeedButton
      Left = 8
      Width = 99
      ExplicitLeft = 14
      ExplicitTop = 5
      ExplicitWidth = 99
    end
    inherited SB_Alterar: TSpeedButton
      Left = 109
      Width = 99
      ExplicitLeft = 114
      ExplicitTop = 5
      ExplicitWidth = 99
    end
    inherited SB_Excluir: TSpeedButton
      Left = 210
      Width = 99
      ExplicitLeft = 214
      ExplicitTop = 5
      ExplicitWidth = 99
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 412
      Width = 99
      ExplicitLeft = 414
      ExplicitTop = 5
      ExplicitWidth = 99
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 513
      Width = 99
      ExplicitLeft = 514
      ExplicitTop = 5
      ExplicitWidth = 99
    end
    inherited SB_Gravar: TSpeedButton
      Left = 311
      Width = 99
      ExplicitLeft = 312
      ExplicitTop = 5
      ExplicitWidth = 99
    end
  end
  inherited pnl_fundo: TPanel
    Width = 617
    Height = 571
    ExplicitWidth = 617
    ExplicitHeight = 571
    object pl_fundo: TPanel
      Left = 2
      Top = 2
      Width = 613
      Height = 567
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      DesignSize = (
        613
        567)
      object L_Aq_ICMS: TLabel
        Left = 9
        Top = 200
        Width = 66
        Height = 14
        Caption = 'Aliquota ICMS'
        FocusControl = E_Aq_ICMS
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Red_Base: TLabel
        Left = 192
        Top = 200
        Width = 103
        Height = 14
        Caption = 'Redu'#231#227'o da Base em'
        FocusControl = E_Red_Base
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Observacao: TLabel
        Left = 8
        Top = 473
        Width = 156
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Observa'#231#245'es para a Nota Fiscal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 416
      end
      object Sb_Observacao: TSpeedButton
        Left = 578
        Top = 489
        Width = 23
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '...'
        OnClick = Sb_ObservacaoClick
        ExplicitTop = 432
      end
      object L_Red_Aliq: TLabel
        Left = 83
        Top = 200
        Width = 92
        Height = 14
        Caption = 'Red na Aliquota em'
        FocusControl = E_Red_Aliq
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Natureza: TLabel
        Left = 8
        Top = 516
        Width = 177
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'C.F.O.P. - Descri'#231#227'o Situa'#231#227'o Normal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 459
      end
      object SB_Natureza: TSpeedButton
        Left = 578
        Top = 532
        Width = 24
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = SB_NaturezaClick
        ExplicitTop = 475
      end
      object L_Origem: TLabel
        Left = 5
        Top = 3
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
      object Sb_Sit_Trib_ICMS: TSpeedButton
        Left = 575
        Top = 59
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = Sb_Sit_Trib_ICMSClick
      end
      object Sb_Sit_Trib_CSOSN: TSpeedButton
        Left = 575
        Top = 96
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = Sb_Sit_Trib_CSOSNClick
      end
      object Sb_Modal_ICMS_St: TSpeedButton
        Left = 575
        Top = 135
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = Sb_Modal_ICMS_StClick
      end
      object L_Situacao_tributaria: TLabel
        Left = 8
        Top = 48
        Width = 206
        Height = 13
        Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Simples_Nacional: TLabel
        Left = 8
        Top = 83
        Width = 288
        Height = 13
        Caption = 'CSOSN - C'#243'digo de Situa'#231#227'o da Opera'#231#227'o Simples Nacional'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Modal_ICMS: TLabel
        Left = 8
        Top = 120
        Width = 196
        Height = 13
        Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Modal_ICMS_ST: TLabel
        Left = 300
        Top = 120
        Width = 213
        Height = 13
        Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS ST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Modal_ICMS: TSpeedButton
        Left = 274
        Top = 135
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = Sb_Modal_ICMSClick
      end
      object Sb_Desoneracao: TSpeedButton
        Left = 274
        Top = 175
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = Sb_DesoneracaoClick
      end
      object L_Desoneracao: TLabel
        Left = 8
        Top = 160
        Width = 117
        Height = 13
        Caption = 'Motivo da Desonera'#231#227'o '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 309
        Top = 200
        Width = 79
        Height = 14
        Caption = 'Aliquota Diferida'
        FocusControl = E_Aliq_Diferida
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Aq_ICMS: TEdit
        Left = 9
        Top = 216
        Width = 69
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object E_Red_Base: TEdit
        Left = 190
        Top = 216
        Width = 115
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object E_Red_Aliq: TEdit
        Left = 80
        Top = 216
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object Pnl_Outros: TGroupBox
        Left = 7
        Top = 335
        Width = 594
        Height = 132
        Caption = 'Outros Crit'#233'rios'
        TabOrder = 11
        object L_Transacao_Produto: TLabel
          Left = 377
          Top = 9
          Width = 182
          Height = 14
          Caption = 'Tipo da transa'#231#227'o do Produto/Servi'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object L_CodigoNCM: TLabel
          Left = 377
          Top = 87
          Width = 119
          Height = 14
          Caption = 'C'#243'd. Class. Fiscal (NCM)'
          FocusControl = E_CodigoNCM
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Classificacao: TSpeedButton
          Left = 502
          Top = 101
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
        end
        object chbx_sit_trb: TCheckBox
          Left = 8
          Top = 16
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para produtos com Substitui'#231#227'o Tribut'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object chbx_Consumidor: TCheckBox
          Left = 8
          Top = 33
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para Opera'#231#227'o com Consumidor Final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object chbx_micro: TCheckBox
          Left = 8
          Top = 49
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para Empresa Optante pelo Simples Nacional'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object chbx_diferido: TCheckBox
          Left = 8
          Top = 64
          Width = 317
          Height = 17
          Caption = 'Imposto ICMS Diferido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object chbx_destaque: TCheckBox
          Left = 8
          Top = 79
          Width = 317
          Height = 17
          Caption = 'Destacar valores na Nota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object CHBX_ST_ICMS: TCheckBox
          Left = 8
          Top = 94
          Width = 270
          Height = 17
          Caption = 'Regra aplicada como Substituto Tribut'#225'rio - ICMS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object Cb_Transacao_Produto: TComboBox
          Left = 377
          Top = 29
          Width = 206
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            '0 - Outras'
            '1 - Revenda'
            '2 - Produ'#231#227'o'
            '3 - Consignado'
            '4 - Industrializa'#231#227'o'
            '5 - Consumo Interno'
            '6 - Presta'#231#227'o de Servi'#231'o'
            '7 - Ativo Imobilizado')
        end
        object E_CodigoNCM: TEdit
          Left = 377
          Top = 101
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 9
        end
        object Chbx_Sentido: TCheckBox
          Left = 8
          Top = 110
          Width = 270
          Height = 17
          Caption = 'Utilizar CFOP de Entrada'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = Fm_ListaEstadosDblcb_ListaExit
        end
        inline Fm_ListaEstados: TFm_ListaEstados
          Left = 377
          Top = 51
          Width = 96
          Height = 37
          TabOrder = 8
          ExplicitLeft = 377
          ExplicitTop = 51
          ExplicitWidth = 96
          ExplicitHeight = 37
          inherited pnl_linha_1: TPanel
            Width = 96
            ExplicitWidth = 96
            inherited Sb_open: TSpeedButton
              Left = 72
              ExplicitLeft = 72
            end
            inherited Dblcb_Lista: TDBLookupComboBox
              Width = 72
              OnExit = Fm_ListaEstadosDblcb_ListaExit
              ExplicitWidth = 72
            end
          end
          inherited pnl_top: TPanel
            Width = 96
            ExplicitWidth = 96
            inherited L_name_list: TLabel
              Width = 90
              Height = 13
            end
          end
        end
      end
      object Pg_Outros: TPageControl
        Left = 7
        Top = 251
        Width = 592
        Height = 82
        ActivePage = tbs_outros
        TabOrder = 10
        object tbs_ipi: TTabSheet
          Caption = 'IPI'
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_IPI: TLabel
              Left = 479
              Top = 6
              Width = 67
              Height = 14
              Caption = 'Aliquota de IPI'
              FocusControl = E_Aq_IPI
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Situacao_tributaria_IPI: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_IPI: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_IPI: TEdit
              Left = 477
              Top = 22
              Width = 100
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
            object Dblcb_Situacao_tributaria_IPI: TDBLookupComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              DataField = 'TRB_CODTBI_IPI'
              KeyField = 'TBI_CODIGO'
              ListField = 'DESCRICAO'
              TabOrder = 0
            end
          end
        end
        object tbs_pis: TTabSheet
          Caption = 'PIS'
          ImageIndex = 1
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_PIS: TLabel
              Left = 479
              Top = 6
              Width = 57
              Height = 14
              Caption = 'Aliquota PIS'
              FocusControl = E_Aq_Pis
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Situacao_tributaria_PIS: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_PIS: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_Pis: TEdit
              Left = 477
              Top = 22
              Width = 100
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
            object Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              DataField = 'TRB_CODTBI_PIS'
              KeyField = 'TBP_CODIGO'
              ListField = 'DESCRICAO'
              TabOrder = 0
            end
          end
        end
        object tbs_cofins: TTabSheet
          Caption = 'COFINS'
          ImageIndex = 2
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_Cofins: TLabel
              Left = 480
              Top = 6
              Width = 73
              Height = 14
              Caption = 'Aliquota Cofins'
              FocusControl = E_Aq_Cofins
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Situacao_tributaria_CFS: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_CFS: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_Cofins: TEdit
              Left = 477
              Top = 22
              Width = 100
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
            object Dblcb_Situacao_tributaria_CFS: TDBLookupComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              DataField = 'TRB_CODTBI_CFS'
              KeyField = 'TBC_CODIGO'
              ListField = 'DESCRICAO'
              TabOrder = 0
            end
          end
        end
        object tbs_outros: TTabSheet
          Caption = 'Outros'
          ImageIndex = 3
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_IRPJ: TLabel
              Left = 7
              Top = 6
              Width = 41
              Height = 14
              Caption = 'Al'#237'q IRPJ'
              FocusControl = E_Aq_IRPJ
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_CSLL: TLabel
              Left = 82
              Top = 6
              Width = 47
              Height = 14
              Caption = 'Al'#237'q CSLL'
              FocusControl = E_Aq_CSLL
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_Siscomex: TLabel
              Left = 154
              Top = 6
              Width = 89
              Height = 14
              Caption = 'Al'#237'quota Siscomex'
              FocusControl = E_Aq_Siscomex
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_Tec: TLabel
              Left = 261
              Top = 6
              Width = 31
              Height = 14
              Caption = 'Aliq I.I.'
              FocusControl = E_Aq_Tec
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_ISS: TLabel
              Left = 345
              Top = 6
              Width = 25
              Height = 14
              Caption = 'I.S.S.'
              FocusControl = E_Aq_ISS
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_AQ_AFRMM: TLabel
              Left = 424
              Top = 6
              Width = 89
              Height = 14
              Caption = 'Aliquota A.F.R.M.M'
              FocusControl = E_AQ_AFRMM
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Aq_IRPJ: TEdit
              Left = 7
              Top = 22
              Width = 72
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
            object E_Aq_CSLL: TEdit
              Left = 80
              Top = 22
              Width = 71
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
            object E_Aq_Siscomex: TEdit
              Left = 152
              Top = 22
              Width = 103
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Aq_Tec: TEdit
              Left = 256
              Top = 22
              Width = 81
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
            object E_Aq_ISS: TEdit
              Left = 340
              Top = 22
              Width = 81
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
            object E_AQ_AFRMM: TEdit
              Left = 422
              Top = 22
              Width = 103
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
          end
        end
      end
      object Cb_Origem: TComboBox
        Left = 5
        Top = 20
        Width = 594
        Height = 22
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
      object Chbx_Red_Base_ST: TCheckBox
        Left = 11
        Top = 240
        Width = 294
        Height = 17
        Caption = 'Propagar a redu'#231#227'o da Base de C'#225'lculo para a Base S.T'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object Dblcb_Modal_ICMS_ST: TDBLookupComboBox
        Left = 298
        Top = 133
        Width = 271
        Height = 21
        DataField = 'TRB_CODMDB_ICMS_ST'
        KeyField = 'MDB_CODIGO'
        ListField = 'DESCRICAO'
        TabOrder = 4
      end
      object Dblcb_Situacao_tributaria: TDBLookupComboBox
        Left = 8
        Top = 63
        Width = 566
        Height = 21
        DataField = 'TRB_CODTBI_ICMS_NR'
        KeyField = 'TBI_CODIGO'
        ListField = 'DESCRICAO'
        TabOrder = 1
      end
      object Dblcb_Simples_Nacional: TDBLookupComboBox
        Left = 8
        Top = 98
        Width = 562
        Height = 21
        DataField = 'TRB_CODTBI_ICMS_SN'
        KeyField = 'TBI_CODIGO'
        ListField = 'DESCRICAO'
        TabOrder = 2
      end
      object Dblcb_Modal_ICMS: TDBLookupComboBox
        Left = 8
        Top = 136
        Width = 266
        Height = 21
        DataField = 'TRB_CODMDB_ICMS_NR'
        KeyField = 'MDB_CODIGO'
        ListField = 'DESCRICAO'
        TabOrder = 3
      end
      object Dblcb_Desoneracao: TDBLookupComboBox
        Left = 8
        Top = 176
        Width = 266
        Height = 21
        KeyField = 'DSI_CODIGO'
        ListField = 'DSI_DESCRICAO'
        ListSource = Ds_Desoneracao
        TabOrder = 5
      end
      object DBLCB_Natureza: TDBLookupComboBox
        Left = 8
        Top = 533
        Width = 563
        Height = 21
        Anchors = [akLeft, akBottom]
        DataField = 'TRB_CODNAT'
        KeyField = 'NAT_CODIGO'
        ListField = 'CFOP'
        ListSource = DM.Ds_Natureza
        TabOrder = 13
      end
      object DBLCB_Observacao: TDBLookupComboBox
        Left = 6
        Top = 492
        Width = 566
        Height = 21
        Anchors = [akLeft, akBottom]
        DataField = 'TRB_CODOBS'
        KeyField = 'OBS_CODIGO'
        ListField = 'OBS_DESCRICAO'
        TabOrder = 12
      end
      object E_Aliq_Diferida: TEdit
        Left = 307
        Top = 216
        Width = 81
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 408
    Top = 96
    inherited arefas1: TMenuItem
      object AplicarReformaTributria1: TMenuItem [0]
        Caption = 'Aplicar Reforma Tribut'#225'ria'
        OnClick = AplicarReformaTributria1Click
      end
      object VisualizarReformatributria1: TMenuItem [1]
        Caption = 'Visualizar Reforma tribut'#225'ria'
        OnClick = VisualizarReformatributria1Click
      end
    end
  end
  object qr_Desoneracao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DSI_CODIGO,  DSI_DESCRICAO'
      'FROM TB_DESONERA_ICMS')
    Left = 250
    Top = 94
  end
  object Ds_Desoneracao: TDataSource
    DataSet = qr_Desoneracao
    Left = 250
    Top = 111
  end
end

inherited RegTaxes: TRegTaxes
  Caption = 'Reforma Tribut'#225'ria'
  ClientHeight = 395
  ClientWidth = 629
  ExplicitWidth = 635
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 331
    Width = 629
    ExplicitTop = 331
    ExplicitWidth = 629
    inherited SB_Inserir: TSpeedButton
      Left = 2
      ExplicitLeft = 353
    end
    inherited SB_Alterar: TSpeedButton
      Left = 106
      ExplicitLeft = 457
    end
    inherited SB_Excluir: TSpeedButton
      Left = 210
      ExplicitLeft = 561
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 418
      ExplicitLeft = 769
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 522
      ExplicitLeft = 873
    end
    inherited SB_Gravar: TSpeedButton
      Left = 314
      ExplicitLeft = 665
    end
  end
  inherited pnl_fundo: TPanel
    Width = 629
    Height = 331
    ExplicitWidth = 629
    ExplicitHeight = 331
    object pg_main: TPageControl
      AlignWithMargins = True
      Left = 5
      Top = 216
      Width = 619
      Height = 110
      ActivePage = tbs_CBS
      Align = alClient
      TabOrder = 1
      object tbs_ibs: TTabSheet
        Caption = 'IBS'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Ibs: TPanel
          Left = 0
          Top = 0
          Width = 611
          Height = 82
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Pg_IBS_UF_MUN: TPageControl
            Left = 2
            Top = 2
            Width = 607
            Height = 78
            ActivePage = tbs_Ibs_Mun
            Align = alClient
            TabOrder = 0
            object tbs_ibs_uf: TTabSheet
              Caption = 'UF'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Pnl_Ibs_Uf: TPanel
                Left = 0
                Top = 0
                Width = 599
                Height = 50
                Align = alClient
                BevelInner = bvRaised
                BevelOuter = bvLowered
                TabOrder = 0
                object Lb_IBS_UF_Aliquota: TLabel
                  Left = 6
                  Top = 4
                  Width = 39
                  Height = 14
                  Caption = 'Aliquota'
                  FocusControl = E_IBS_UF_Aliquota
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_UF_Aliq_Red: TLabel
                  Left = 81
                  Top = 4
                  Width = 63
                  Height = 14
                  Caption = 'Redu'#231#227'o Aliq'
                  FocusControl = E_IBS_UF_ALIQ_RED
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_UF_Aliq_efet: TLabel
                  Left = 156
                  Top = 4
                  Width = 54
                  Height = 14
                  Caption = 'Aliq Efetiva'
                  FocusControl = E_IBS_UF_ALIQ_EFET
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_UF_Aliq_Dif: TLabel
                  Left = 231
                  Top = 4
                  Width = 58
                  Height = 14
                  Caption = 'Aliq Diferida'
                  FocusControl = E_IBS_UF_ALIQ_DIF
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object E_IBS_UF_Aliquota: TEdit
                  Left = 5
                  Top = 20
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
                  TabOrder = 0
                  OnExit = E_IBS_UF_AliquotaExit
                end
                object E_IBS_UF_ALIQ_RED: TEdit
                  Left = 80
                  Top = 20
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
                  TabOrder = 1
                  OnExit = E_IBS_UF_ALIQ_REDExit
                end
                object E_IBS_UF_ALIQ_EFET: TEdit
                  Left = 155
                  Top = 20
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
                  TabOrder = 2
                  OnExit = E_IBS_UF_ALIQ_EFETExit
                end
                object E_IBS_UF_ALIQ_DIF: TEdit
                  Left = 230
                  Top = 20
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
                  TabOrder = 3
                  OnExit = E_IBS_UF_ALIQ_DIFExit
                end
              end
            end
            object tbs_Ibs_Mun: TTabSheet
              Caption = 'Municipio'
              ImageIndex = 1
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object Pnl_ibs_Mun: TPanel
                Left = 0
                Top = 0
                Width = 599
                Height = 50
                Align = alClient
                BevelInner = bvRaised
                BevelOuter = bvLowered
                TabOrder = 0
                object Lb_IBS_Mun_Aliquota: TLabel
                  Left = 6
                  Top = 3
                  Width = 39
                  Height = 14
                  Caption = 'Aliquota'
                  FocusControl = E_IBS_MUN_ALIQUOTA
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_Mun_Aliq_Red: TLabel
                  Left = 81
                  Top = 3
                  Width = 63
                  Height = 14
                  Caption = 'Redu'#231#227'o Aliq'
                  FocusControl = E_IBS_MUN_ALIQ_RED
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_Mun_Aliq_efet: TLabel
                  Left = 156
                  Top = 3
                  Width = 54
                  Height = 14
                  Caption = 'Aliq Efetiva'
                  FocusControl = E_IBS_MUN_ALIQ_EFET
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object Lb_IBS_Mun_Aliq_Dif: TLabel
                  Left = 231
                  Top = 3
                  Width = 58
                  Height = 14
                  Caption = 'Aliq Diferida'
                  FocusControl = E_IBS_MUN_ALIQ_DIF
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                end
                object E_IBS_MUN_ALIQUOTA: TEdit
                  Left = 5
                  Top = 19
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
                  TabOrder = 0
                  OnExit = E_IBS_MUN_ALIQUOTAExit
                end
                object E_IBS_MUN_ALIQ_RED: TEdit
                  Left = 80
                  Top = 19
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
                  TabOrder = 1
                  OnExit = E_IBS_MUN_ALIQ_REDExit
                end
                object E_IBS_MUN_ALIQ_EFET: TEdit
                  Left = 155
                  Top = 19
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
                  TabOrder = 2
                  OnExit = E_IBS_MUN_ALIQ_EFETExit
                end
                object E_IBS_MUN_ALIQ_DIF: TEdit
                  Left = 230
                  Top = 19
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
                  TabOrder = 3
                  OnExit = E_IBS_MUN_ALIQ_DIFExit
                end
              end
            end
          end
        end
      end
      object tbs_CBS: TTabSheet
        Caption = 'CBS'
        ImageIndex = 1
        object pnl_cbs: TPanel
          Left = 0
          Top = 0
          Width = 611
          Height = 82
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Lb_CBS_UF_Aliquota: TLabel
            Left = 7
            Top = 5
            Width = 39
            Height = 14
            Caption = 'Aliquota'
            FocusControl = E_CBS_ALIQUOTA
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_CBS_UF_Red_Aliq: TLabel
            Left = 82
            Top = 5
            Width = 63
            Height = 14
            Caption = 'Redu'#231#227'o Aliq'
            FocusControl = E_CBS_ALIQ_RED
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_CBS_UF_Aliq_Efet: TLabel
            Left = 157
            Top = 5
            Width = 54
            Height = 14
            Caption = 'Aliq Efetiva'
            FocusControl = E_CBS_ALIQ_EFET
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Lb_CBS_UF_Aliq_Dif: TLabel
            Left = 232
            Top = 5
            Width = 58
            Height = 14
            Caption = 'Aliq Diferida'
            FocusControl = E_CBS_ALIQ_DIF
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_CBS_ALIQUOTA: TEdit
            Left = 6
            Top = 21
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
            TabOrder = 0
            OnExit = E_CBS_ALIQUOTAExit
          end
          object E_CBS_ALIQ_RED: TEdit
            Left = 81
            Top = 21
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
            TabOrder = 1
            OnExit = E_CBS_ALIQ_REDExit
          end
          object E_CBS_ALIQ_EFET: TEdit
            Left = 156
            Top = 21
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
            TabOrder = 2
            OnExit = E_CBS_ALIQ_EFETExit
          end
          object E_CBS_ALIQ_DIF: TEdit
            Left = 231
            Top = 21
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
            TabOrder = 3
            OnExit = E_CBS_ALIQ_DIFExit
          end
        end
      end
    end
    inline FmListaTaxIncidency: TFmListaTaxIncidency
      AlignWithMargins = True
      Left = 5
      Top = 57
      Width = 619
      Height = 47
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 5
      ExplicitTop = 57
      ExplicitWidth = 619
      inherited pnl_linha_1: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited Sb_open: TSpeedButton
          Left = 595
          Visible = False
          ExplicitLeft = 585
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 595
          ExplicitWidth = 595
        end
      end
      inherited pnl_top: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited L_name_list: TLabel
          Width = 613
          Height = 16
        end
      end
    end
    object pnl_line_01: TPanel
      Left = 2
      Top = 2
      Width = 625
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object L_Codigo: TLabel
        Left = 8
        Top = 8
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
      object L_Descricao: TLabel
        Left = 57
        Top = 8
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 24
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
      object E_Descricao: TEdit
        Left = 58
        Top = 24
        Width = 563
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
    inline FmListaCstCbsIbs: TFmListaCstCbsIbs
      AlignWithMargins = True
      Left = 5
      Top = 110
      Width = 619
      Height = 47
      Align = alTop
      TabOrder = 3
      ExplicitLeft = 5
      ExplicitTop = 110
      ExplicitWidth = 619
      inherited pnl_linha_1: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited Sb_open: TSpeedButton
          Left = 595
          Visible = False
          ExplicitLeft = 595
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 595
          KeyField = 'DESCRIPTION'
          OnClick = FmListaCstCbsIbsDblcb_ListaClick
          ExplicitWidth = 595
        end
      end
      inherited pnl_top: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited L_name_list: TLabel
          Width = 613
          Height = 16
          Caption = 'Lista CST - CBS/IBS'
          ExplicitWidth = 96
        end
      end
    end
    inline FmListaClassTribIbsCbs: TFmListaClassTribIbsCbs
      AlignWithMargins = True
      Left = 5
      Top = 163
      Width = 619
      Height = 47
      Align = alTop
      TabOrder = 4
      ExplicitLeft = 5
      ExplicitTop = 163
      ExplicitWidth = 619
      inherited pnl_linha_1: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited Sb_open: TSpeedButton
          Left = 595
          Visible = False
          ExplicitLeft = 595
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 595
          ExplicitWidth = 595
        end
      end
      inherited pnl_top: TPanel
        Width = 619
        ExplicitWidth = 619
        inherited L_name_list: TLabel
          Width = 613
          Height = 16
          Caption = 'Lista de Classifica'#231#227'o Tribut'#225'ria - CBS/IBS'
          ExplicitWidth = 204
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    inherited arefas1: TMenuItem
      object AplicarnaRegradetributao1: TMenuItem [0]
        Caption = 'Aplicar na Regra de tributa'#231#227'o'
        OnClick = AplicarnaRegradetributao1Click
      end
    end
  end
end

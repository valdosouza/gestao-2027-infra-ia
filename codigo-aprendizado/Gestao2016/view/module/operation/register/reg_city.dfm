inherited RegCity: TRegCity
  Caption = 'Cadastro de Cidades'
  ClientHeight = 160
  ClientWidth = 632
  ExplicitWidth = 638
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 96
    Width = 632
    ExplicitTop = 96
    ExplicitWidth = 632
    inherited SB_Inserir: TSpeedButton
      Left = 5
      ExplicitLeft = 5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 109
      ExplicitLeft = 109
    end
    inherited SB_Excluir: TSpeedButton
      Left = 213
      ExplicitLeft = 213
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 421
      ExplicitLeft = 421
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 525
      ExplicitLeft = 525
    end
    inherited SB_Gravar: TSpeedButton
      Left = 317
      ExplicitLeft = 317
    end
  end
  inherited pnl_fundo: TPanel
    Width = 632
    Height = 96
    ExplicitWidth = 632
    ExplicitHeight = 96
    object L_Codigo: TLabel
      Left = 5
      Top = 6
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
      Left = 82
      Top = 6
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_IBGE: TLabel
      Left = 5
      Top = 48
      Width = 59
      Height = 14
      Caption = 'C'#243'digo IBGE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_AliquotaISS: TLabel
      Left = 127
      Top = 48
      Width = 79
      Height = 14
      Caption = 'Aliquota ISS (%)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 5
      Top = 20
      Width = 73
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
      Left = 82
      Top = 20
      Width = 455
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_IBGE: TEdit
      Left = 5
      Top = 64
      Width = 118
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_AliquotaISS: TEdit
      Left = 127
      Top = 64
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    inline Fm_ListaEditaEstado: TFm_ListaEstados
      Left = 537
      Top = 3
      Width = 90
      Height = 38
      TabOrder = 2
      ExplicitLeft = 537
      ExplicitTop = 3
      ExplicitWidth = 90
      inherited pnl_linha_1: TPanel
        Width = 90
        ExplicitTop = 17
        ExplicitWidth = 90
        inherited Sb_open: TSpeedButton
          Left = 66
          ExplicitLeft = 66
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 66
          ExplicitWidth = 66
        end
      end
      inherited pnl_top: TPanel
        Width = 90
        ExplicitWidth = 90
        inherited L_name_list: TLabel
          Width = 84
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 408
    Top = 8
  end
end

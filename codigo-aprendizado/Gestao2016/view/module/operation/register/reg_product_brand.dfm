inherited RegProductBrand: TRegProductBrand
  Caption = 'Cadastro de Marca de Produto'
  ClientHeight = 167
  ClientWidth = 601
  ExplicitWidth = 607
  ExplicitHeight = 216
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 103
    Width = 601
    ExplicitTop = 103
    ExplicitWidth = 601
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 87
      ExplicitLeft = 2
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Alterar: TSpeedButton
      Left = 92
      ExplicitLeft = 106
    end
    inherited SB_Excluir: TSpeedButton
      Left = 196
      ExplicitLeft = 210
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 404
      ExplicitLeft = 418
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 508
      Width = 88
      ExplicitLeft = 508
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 300
      ExplicitLeft = 314
    end
  end
  inherited pnl_fundo: TPanel
    Width = 601
    Height = 103
    ExplicitWidth = 601
    ExplicitHeight = 103
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
      Left = 63
      Top = 25
      Width = 533
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
    inline Fm_ListaFornecedores1: TFm_ListaFornecedores
      Left = 6
      Top = 52
      Width = 590
      Height = 41
      TabOrder = 2
      ExplicitLeft = 6
      ExplicitTop = 52
      ExplicitWidth = 590
      ExplicitHeight = 41
      inherited pnl_01: TPanel
        Width = 590
        ExplicitWidth = 590
        inherited ChBx_Nome: TCheckBox
          Left = 42
          ExplicitLeft = 42
          ExplicitTop = 1
          ExplicitHeight = 14
        end
        inherited ChBx_Fantasia: TCheckBox
          Left = 168
          ExplicitLeft = 168
          ExplicitTop = 1
          ExplicitHeight = 14
        end
      end
      inherited pnl_02: TPanel
        Width = 590
        ExplicitWidth = 590
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 562
          ExplicitLeft = 565
        end
        inherited SB_Empresas: TSpeedButton
          Left = 537
          ExplicitLeft = 540
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitLeft = 1
          ExplicitTop = 1
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 469
          ExplicitLeft = 66
          ExplicitTop = 1
          ExplicitWidth = 469
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 264
    Top = 0
  end
end

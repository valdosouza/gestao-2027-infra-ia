inherited RegSubgroupMenu: TRegSubgroupMenu
  ClientHeight = 169
  ClientWidth = 552
  ExplicitWidth = 558
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 105
    Width = 552
    ExplicitTop = 105
    ExplicitWidth = 552
    inherited SB_Inserir: TSpeedButton
      Left = -8
      Width = 90
      ExplicitLeft = 39
      ExplicitWidth = 90
    end
    inherited SB_Alterar: TSpeedButton
      Left = 84
      Width = 91
      ExplicitLeft = 102
      ExplicitWidth = 91
    end
    inherited SB_Excluir: TSpeedButton
      Left = 177
      Width = 91
      ExplicitLeft = 206
      ExplicitWidth = 91
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 363
      Width = 91
      ExplicitLeft = 374
      ExplicitWidth = 91
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 456
      Width = 91
      ExplicitLeft = 478
      ExplicitWidth = 91
    end
    inherited SB_Gravar: TSpeedButton
      Left = 270
      Width = 91
      ExplicitLeft = 270
      ExplicitTop = 5
      ExplicitWidth = 91
    end
  end
  inherited pnl_fundo: TPanel
    Width = 552
    Height = 105
    ExplicitWidth = 552
    ExplicitHeight = 105
    object L_Abas: TLabel [1]
      Left = 5
      Top = 44
      Width = 178
      Height = 14
      Caption = 'Nome da Aba na Tela de Atendimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [2]
      Left = 253
      Top = 46
      Width = 156
      Height = 14
      Caption = 'Caminho da Porta de Impressora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Impressora: TSpeedButton [3]
      Left = 510
      Top = 61
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_ImpressoraClick
    end
    inherited ChBx_Ativo: TCheckBox
      Top = 83
      Width = 542
      TabOrder = 2
      ExplicitTop = 83
      ExplicitWidth = 542
    end
    inherited E_Codigo: TEdit
      TabOrder = 3
    end
    inherited E_Descricao: TEdit
      TabOrder = 1
    end
    object E_Abas: TEdit
      Left = 6
      Top = 59
      Width = 239
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
    object Dblcb_Impressora: TDBLookupComboBox
      Left = 251
      Top = 61
      Width = 257
      Height = 21
      DataField = 'SBG_CODIMP'
      KeyField = 'IMP_CODIGO'
      ListField = 'IMP_DESCRICAO'
      ListSource = DM.Ds_Impressora
      TabOrder = 4
    end
  end
  inherited MnuBase: TMainMenu
    Left = 104
    Top = 88
  end
end

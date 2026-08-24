inherited CadContract: TCadContract
  Caption = 'Cadastro de Contratos'
  ClientHeight = 198
  ClientWidth = 626
  ExplicitWidth = 632
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 134
    Width = 626
    ExplicitTop = 134
    ExplicitWidth = 626
    inherited SB_Inserir: TSpeedButton
      Left = -1
      ExplicitLeft = -1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      ExplicitLeft = 103
    end
    inherited SB_Excluir: TSpeedButton
      Left = 207
      ExplicitLeft = 207
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 415
      ExplicitLeft = 415
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 519
      ExplicitLeft = 519
    end
    inherited SB_Gravar: TSpeedButton
      Left = 311
      ExplicitLeft = 311
    end
  end
  inherited pnl_fundo: TPanel
    Width = 626
    Height = 134
    ExplicitWidth = 626
    ExplicitHeight = 134
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 84
      Height = 14
      Align = alTop
      Caption = 'T'#237'tulo do Contrato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 47
      Width = 79
      Height = 14
      Margins.Top = 1
      Margins.Right = 300
      Margins.Bottom = 1
      Align = alTop
      Caption = 'Tipo do Contrato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_edit_contract: TSpeedButton
      Left = 5
      Top = 95
      Width = 120
      Height = 33
      Caption = 'Editar do Contato'
      OnClick = Sb_edit_contractClick
    end
    object Sb_select_data: TSpeedButton
      Left = 131
      Top = 95
      Width = 120
      Height = 33
      Caption = 'Sele'#231#227'o de Dados'
      OnClick = Sb_select_dataClick
    end
    object Sb_Chaves: TSpeedButton
      Left = 257
      Top = 95
      Width = 120
      Height = 33
      Caption = 'Chaves / Tags'
      OnClick = Sb_ChavesClick
    end
    object E_Tittle: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 23
      Width = 616
      Height = 22
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alTop
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CB_Kind: TComboBox
      AlignWithMargins = True
      Left = 5
      Top = 63
      Width = 319
      Height = 21
      Margins.Top = 1
      Margins.Right = 300
      Margins.Bottom = 1
      Align = alTop
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 32
    Top = 16
  end
end

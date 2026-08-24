inherited RegCategory: TRegCategory
  Caption = 'Cadastro de Categorias'
  ClientHeight = 384
  ClientWidth = 565
  ExplicitWidth = 571
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 320
    Width = 565
    ExplicitTop = 320
    ExplicitWidth = 565
    inherited SB_Inserir: TSpeedButton
      Left = -3
      Width = 94
      ExplicitLeft = -5
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 93
      Width = 94
      ExplicitLeft = 91
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 189
      Width = 90
      ExplicitLeft = 189
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 375
      Width = 93
      ExplicitLeft = 372
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 470
      Width = 90
      ExplicitLeft = 464
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Gravar: TSpeedButton
      Left = 281
      Width = 92
      ExplicitLeft = 277
      ExplicitTop = 5
      ExplicitWidth = 92
    end
  end
  inherited pnl_fundo: TPanel
    Width = 565
    Height = 57
    Align = alTop
    ExplicitWidth = 565
    ExplicitHeight = 57
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
    object Lb_Codigo: TLabel
      Left = 5
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
    object E_Codigo: TEdit
      Left = 5
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
      Width = 497
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
  object Trw_Cadastro: TTreeView [2]
    Left = 0
    Top = 57
    Width = 565
    Height = 263
    Align = alClient
    AutoExpand = True
    HideSelection = False
    Indent = 19
    MultiSelectStyle = []
    ReadOnly = True
    SortType = stText
    TabOrder = 2
    OnClick = Trw_CadastroClick
  end
  inherited MnuBase: TMainMenu
    Left = 280
    Top = 88
  end
end

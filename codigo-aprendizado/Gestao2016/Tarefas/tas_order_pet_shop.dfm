inherited TasOrderPetShop: TTasOrderPetShop
  Caption = 'Atendimento Pet'
  ClientHeight = 307
  ClientWidth = 764
  ExplicitWidth = 770
  ExplicitHeight = 356
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 243
    Width = 764
    ExplicitTop = 243
    ExplicitWidth = 764
    inherited SB_Inserir: TSpeedButton
      Left = 137
      Visible = False
      ExplicitLeft = 327
    end
    inherited SB_Alterar: TSpeedButton
      Left = 241
      ExplicitLeft = 241
    end
    inherited SB_Excluir: TSpeedButton
      Left = 345
      ExplicitLeft = 535
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 553
      ExplicitLeft = 743
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 657
      ExplicitLeft = 847
    end
    inherited SB_Gravar: TSpeedButton
      Left = 449
      ExplicitLeft = 639
    end
  end
  inherited pnl_fundo: TPanel
    Width = 764
    Height = 243
    ExplicitWidth = 764
    ExplicitHeight = 243
    object Label13: TLabel
      Left = 6
      Top = 4
      Width = 111
      Height = 14
      Caption = 'Data e hora de Entrada'
      FocusControl = E_Dt_Entrada
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 617
      Top = 4
      Width = 113
      Height = 14
      Caption = 'Data e hora de Previsto'
      FocusControl = E_Dt_Prevista
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 6
      Top = 45
      Width = 187
      Height = 14
      Caption = 'Observa'#231#227'o / Detalhes do atendimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 618
      Top = 196
      Width = 101
      Height = 14
      Caption = 'Data e hora de Saida'
      FocusControl = E_Dt_Saida
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inline Fm_ListaPet: TFm_ListaPet
      Left = 152
      Top = 7
      Width = 458
      Height = 39
      TabOrder = 2
      ExplicitLeft = 152
      ExplicitTop = 7
      ExplicitWidth = 458
      inherited Label19: TLabel
        Width = 458
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 407
        ExplicitLeft = 407
      end
      inherited Sb_Pesquisa: TSpeedButton
        Left = 432
        ExplicitLeft = 432
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 403
        ExplicitWidth = 403
      end
    end
    object E_Dt_Entrada: TMaskEdit
      Left = 5
      Top = 21
      Width = 82
      Height = 22
      Color = clHighlightText
      EditMask = '!99/99/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object E_Hr_Entrada: TMaskEdit
      Left = 91
      Top = 21
      Width = 53
      Height = 22
      Color = clHighlightText
      EditMask = '00:00;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
    end
    object E_Dt_Prevista: TMaskEdit
      Left = 616
      Top = 21
      Width = 81
      Height = 22
      Color = clHighlightText
      EditMask = '!99/99/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
    end
    object E_Hr_Prevista: TMaskEdit
      Left = 702
      Top = 21
      Width = 53
      Height = 22
      Color = clHighlightText
      EditMask = '00:00;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Text = '  :  '
    end
    object E_Obs: TMemo
      Left = 6
      Top = 61
      Width = 751
      Height = 132
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Dt_Saida: TMaskEdit
      Left = 617
      Top = 213
      Width = 80
      Height = 22
      Color = clHighlightText
      EditMask = '!99/99/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 6
      Text = '  /  /    '
    end
    object E_Hr_Saida: TMaskEdit
      Left = 702
      Top = 213
      Width = 53
      Height = 22
      Color = clHighlightText
      EditMask = '00:00;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 7
      Text = '  :  '
    end
  end
  inherited MnuBase: TMainMenu
    Left = 16
    Top = 64
    inherited arefas1: TMenuItem
      object ProcedimentosPeridicos1: TMenuItem [0]
        Caption = 'Procedimentos Peri'#243'dicos'
        OnClick = ProcedimentosPeridicos1Click
      end
      object Contatos1: TMenuItem [1]
        Caption = 'Contatos'
        OnClick = Contatos1Click
      end
    end
  end
end

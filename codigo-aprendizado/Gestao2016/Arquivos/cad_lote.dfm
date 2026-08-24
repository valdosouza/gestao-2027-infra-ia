inherited CadLote: TCadLote
  Caption = 'Cadastro Avulso de Lotes'
  ClientHeight = 262
  ClientWidth = 628
  ExplicitWidth = 634
  ExplicitHeight = 306
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 198
    Width = 628
    ExplicitTop = 198
    ExplicitWidth = 628
    inherited SB_Inserir: TSpeedButton
      Left = 1
      ExplicitLeft = 8
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      ExplicitLeft = 110
    end
    inherited SB_Excluir: TSpeedButton
      Left = 209
      ExplicitLeft = 212
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 417
      ExplicitLeft = 416
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 521
      ExplicitLeft = 520
    end
    inherited SB_Gravar: TSpeedButton
      Left = 313
      ExplicitLeft = 308
    end
  end
  inherited pnl_fundo: TPanel
    Width = 628
    Height = 198
    ExplicitWidth = 628
    ExplicitHeight = 198
    object Label11: TLabel
      Left = 121
      Top = 46
      Width = 76
      Height = 14
      Caption = 'N'#250'mero do Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 6
      Top = 46
      Width = 25
      Height = 14
      Caption = 'Data:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 529
      Top = 46
      Width = 84
      Height = 14
      Caption = 'Data Vencimento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 459
      Top = 46
      Width = 55
      Height = 14
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 335
      Top = 46
      Width = 107
      Height = 14
      Caption = 'N'#250'mero do Certificado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 87
      Width = 60
      Height = 14
      Caption = 'Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 2
      Top = 2
      Width = 624
      Height = 43
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 624
      inherited Sb_Produto: TSpeedButton
        Left = 487
        ExplicitLeft = 487
      end
      inherited E_Busca_Produto: TEdit
        Width = 382
        ExplicitWidth = 382
      end
    end
    object E_Nr_Lote: TEdit
      Left = 119
      Top = 62
      Width = 211
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 2
    end
    object E_Qt_Produto: TEdit
      Left = 458
      Top = 62
      Width = 65
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = E_Qt_ProdutoExit
    end
    object E_Nr_Certificado: TEdit
      Left = 333
      Top = 62
      Width = 122
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
    end
    object E_Dt_Lote: TMaskEdit
      Left = 8
      Top = 63
      Width = 107
      Height = 21
      EditMask = '!##/##/####;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
    end
    object E_Dt_Vencimento: TMaskEdit
      Left = 528
      Top = 62
      Width = 89
      Height = 21
      EditMask = '!##/##/####;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      Text = '  /  /    '
    end
    object E_Observacao: TMemo
      Left = 6
      Top = 102
      Width = 611
      Height = 68
      TabOrder = 6
    end
    object ChBx_Atualiza_Estoque: TCheckBox
      Left = 8
      Top = 176
      Width = 514
      Height = 17
      Caption = 'Atualizar o saldo de estoque com a quantidade deste Lote'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 32
  end
end

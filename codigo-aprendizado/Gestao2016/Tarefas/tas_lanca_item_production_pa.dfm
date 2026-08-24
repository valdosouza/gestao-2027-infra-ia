inherited TasLancaItemProductionPA: TTasLancaItemProductionPA
  Caption = 'Lan'#231'amento de Produto Acabado'
  ClientWidth = 654
  ExplicitWidth = 660
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 654
    ExplicitWidth = 654
    object Label10: TLabel [2]
      Left = 538
      Top = 46
      Width = 73
      Height = 13
      Caption = 'Qtde Produzida'
      FocusControl = E_Qtde_Produzida
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Qtde_Produzida: TEdit_Setes
      Left = 536
      Top = 60
      Width = 109
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
  end
  inherited Panel2: TPanel
    Width = 654
    ExplicitWidth = 654
    inherited Sb_Sair_0: TSpeedButton
      Left = 571
      ExplicitLeft = 568
    end
    inherited Sb_Pesquisar: TSpeedButton
      Left = 491
      ExplicitLeft = 490
    end
    inherited SB_Gravar: TSpeedButton
      Left = 411
      ExplicitLeft = 412
    end
  end
end

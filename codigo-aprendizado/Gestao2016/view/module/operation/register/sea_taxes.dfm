inherited SeaTaxes: TSeaTaxes
  Caption = 'SeaTaxes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 55
    Height = 448
    ExplicitTop = 55
    ExplicitHeight = 448
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 875
    end
    inherited DBG_Pesquisa: TDBGrid
      Height = 430
    end
    inherited pnl_pesq_right: TPanel
      Height = 430
      ExplicitHeight = 430
      inherited Sb_Sair_0: TSpeedButton
        Top = 367
        ExplicitTop = 343
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 304
        ExplicitTop = 280
      end
      inherited SB_Buscar: TSpeedButton
        Top = 241
        ExplicitTop = 217
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 178
        ExplicitTop = 154
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 46
    ExplicitHeight = 46
    object L_BuscaDescricao: TLabel
      Left = 6
      Top = 3
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
    object Lb_CST: TLabel
      Left = 483
      Top = 3
      Width = 20
      Height = 14
      Caption = 'CST'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Classe: TLabel
      Left = 585
      Top = 3
      Width = 33
      Height = 14
      Caption = 'Classe'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TMaskEdit
      Left = 5
      Top = 17
      Width = 472
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = ''
    end
    object E_CST: TMaskEdit
      Left = 480
      Top = 17
      Width = 100
      Height = 21
      TabOrder = 1
      Text = ''
    end
    object E_Classe: TMaskEdit
      Left = 582
      Top = 17
      Width = 100
      Height = 21
      TabOrder = 2
      Text = ''
    end
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 120
  end
  inherited cds_search: TClientDataSet
    object cds_searchID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
    end
    object cds_searchDESCRIPTION: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRIPTION'
      Size = 50
    end
    object cds_searchCST: TStringField
      FieldName = 'CST'
      Size = 100
    end
    object cds_searchCLASSTRIB: TStringField
      FieldName = 'CLASSTRIB'
      Size = 10
    end
  end
end

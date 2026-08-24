inherited SeaContacts: TSeaContacts
  Caption = 'SeaContacts'
  ClientHeight = 372
  ClientWidth = 667
  ExplicitWidth = 673
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 81
    Width = 661
    Height = 288
    ExplicitTop = 81
    ExplicitWidth = 661
    ExplicitHeight = 288
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 657
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 565
      Height = 270
    end
    inherited pnl_pesq_right: TPanel
      Left = 567
      Height = 270
      ExplicitLeft = 567
      ExplicitHeight = 270
      inherited Sb_Sair_0: TSpeedButton
        Top = 207
        ExplicitTop = 207
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 144
        ExplicitTop = 144
      end
      inherited SB_Buscar: TSpeedButton
        Top = 81
        ExplicitTop = 81
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 18
        ExplicitLeft = 6
        ExplicitTop = 152
        ExplicitWidth = 86
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 661
    Height = 72
    ExplicitWidth = 661
    ExplicitHeight = 72
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 657
      Height = 61
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 441
        Top = 16
        Width = 29
        Height = 14
        Caption = 'Cargo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 9
        Top = 16
        Width = 88
        Height = 14
        Caption = 'Contato / Empresa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCargo: TEdit
        Left = 439
        Top = 36
        Width = 212
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_BuscaContato: TEdit
        Left = 6
        Top = 32
        Width = 427
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
    end
  end
  inherited MnuBase: TMainMenu
    Left = 224
    Top = 200
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
    end
  end
end

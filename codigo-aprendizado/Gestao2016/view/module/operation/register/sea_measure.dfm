inherited SeaMeasure: TSeaMeasure
  Caption = 'Pesquisa de Medidas\Unidades'
  ClientHeight = 358
  ClientWidth = 581
  ExplicitWidth = 587
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 575
    Height = 276
    ExplicitTop = 103
    ExplicitWidth = 575
    ExplicitHeight = 242
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 571
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 479
      Height = 258
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Caption = 'C'#243'digo'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 335
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 481
      Height = 258
      ExplicitLeft = 481
      ExplicitHeight = 224
      inherited Sb_Sair_0: TSpeedButton
        Top = 195
        ExplicitTop = 177
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 132
        ExplicitTop = 114
      end
      inherited SB_Buscar: TSpeedButton
        Top = 69
        ExplicitTop = 51
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 6
        ExplicitTop = -12
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 575
    Height = 70
    ExplicitWidth = 575
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 571
      Height = 66
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 63
      object L_BuscaDescricao: TLabel
        Left = 59
        Top = 16
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
      object L_BuscaCodigo: TLabel
        Left = 10
        Top = 16
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaDescricao: TEdit
        Left = 59
        Top = 32
        Width = 492
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
      object E_BuscaCodigo: TEdit
        Left = 7
        Top = 32
        Width = 49
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
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 128
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end

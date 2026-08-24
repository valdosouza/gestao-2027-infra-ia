inherited SeaGroupMenu: TSeaGroupMenu
  Caption = 'Pesquisa de Grupo e SubGrupo do Card'#225'pio'
  ClientHeight = 438
  ClientWidth = 594
  ExplicitWidth = 600
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 95
    Width = 588
    Height = 340
    ExplicitTop = 95
    ExplicitWidth = 588
    ExplicitHeight = 340
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 584
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 492
      Height = 322
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 494
      Height = 322
      ExplicitLeft = 494
      ExplicitHeight = 322
      inherited Sb_Sair_0: TSpeedButton
        Top = 259
        ExplicitTop = 330
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 196
        ExplicitTop = 267
      end
      inherited SB_Buscar: TSpeedButton
        Top = 133
        ExplicitTop = 204
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 70
        ExplicitTop = 141
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 588
    Height = 86
    ExplicitWidth = 588
    ExplicitHeight = 86
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 584
      Height = 82
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Lb_grupo: TLabel
        Left = 11
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Grupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_subgrupo: TLabel
        Left = 291
        Top = 16
        Width = 49
        Height = 14
        Caption = 'SubGrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaGrupo: TEdit
        Left = 8
        Top = 32
        Width = 280
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
      object E_BuscaSubGrupo: TEdit
        Left = 289
        Top = 32
        Width = 245
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
      object ChBx_GrupoVazio: TCheckBox
        AlignWithMargins = True
        Left = 8
        Top = 60
        Width = 92
        Height = 17
        Caption = 'Grupos vazios'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object ChBx_GrupoInativo: TCheckBox
        AlignWithMargins = True
        Left = 106
        Top = 60
        Width = 92
        Height = 17
        Caption = 'Grupos Inativos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'descricao'
    end
    object cds_searchdescricao_subgrupo: TStringField
      DisplayLabel = 'SubGrupo'
      FieldName = 'descricao_subgrupo'
    end
    object cds_searchcodigo_subgrupo: TIntegerField
      FieldName = 'codigo_subgrupo'
      Visible = False
    end
  end
end

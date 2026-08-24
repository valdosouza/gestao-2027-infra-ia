inherited SeaJobPosition: TSeaJobPosition
  Caption = 'Pesquisa de cargos'
  ClientHeight = 347
  ClientWidth = 651
  ExplicitWidth = 657
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 63
    Width = 645
    Height = 281
    ExplicitTop = 63
    ExplicitWidth = 645
    ExplicitHeight = 281
    inherited DBG_Pesquisa: TDBGrid
      Width = 549
      Height = 263
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descric'#227'o'
          Width = 426
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 551
      Height = 263
      ExplicitLeft = 551
      ExplicitHeight = 263
      inherited Sb_Sair_0: TSpeedButton
        Top = 200
        ExplicitTop = 317
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 137
        ExplicitTop = 254
      end
      inherited SB_Buscar: TSpeedButton
        Top = 74
        ExplicitTop = 191
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 11
        ExplicitTop = 128
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 645
    Height = 54
    ExplicitWidth = 645
    ExplicitHeight = 54
    object Lb_Descricao: TLabel
      Left = 8
      Top = 3
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object E_Descricao: TEdit
      Left = 8
      Top = 19
      Width = 449
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  inherited cds_search: TClientDataSet
    ProviderName = ''
    object cds_searchCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cds_searchDescricao: TStringField
      FieldName = 'Descricao'
    end
  end
end

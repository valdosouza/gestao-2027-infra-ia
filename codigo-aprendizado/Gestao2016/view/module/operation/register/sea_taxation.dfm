inherited SeaTaxation: TSeaTaxation
  Caption = 'Pesquisa de Tributa'#231#245'es para Nota Fiscal Eletr'#244'nica'
  ClientHeight = 550
  ClientWidth = 622
  ExplicitWidth = 628
  ExplicitHeight = 599
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 119
    Width = 616
    Height = 428
    ExplicitTop = 119
    ExplicitWidth = 616
    ExplicitHeight = 428
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 612
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 520
      Height = 410
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'NAT_CFOP'
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UFE_SIGLA'
          Width = 23
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CONSUMIDOR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_MICRO'
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_ST_CIMS'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_AQ_ICMS'
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_RD_BS_ICMS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_RD_AQ_ICMS'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBS_DESCRICAO'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CODIGONCM'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Reforma'
          Title.Caption = 'Reforma Trib.'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 522
      Height = 410
      ExplicitLeft = 522
      ExplicitHeight = 410
      inherited Sb_Sair_0: TSpeedButton
        Top = 347
        ExplicitTop = 184
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 284
        ExplicitTop = 121
      end
      inherited SB_Buscar: TSpeedButton
        Top = 221
        ExplicitTop = 58
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 158
        ExplicitTop = -5
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 616
    Height = 110
    ExplicitWidth = 616
    ExplicitHeight = 110
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 612
      Height = 106
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object L_Busca_NCM: TLabel
        Left = 6
        Top = 62
        Width = 119
        Height = 14
        Caption = 'C'#243'd. Class. Fiscal (NCM)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      inline Fm_ListaCFOP_UF: TFm_ListaCFOP_UF
        Left = 2
        Top = 16
        Width = 608
        Height = 43
        Align = alTop
        TabOrder = 2
        ExplicitLeft = 2
        ExplicitTop = 16
        ExplicitWidth = 608
        ExplicitHeight = 43
        DesignSize = (
          608
          43)
        inherited RG_Tipo_S_E: TRadioGroup
          Height = 43
          ExplicitLeft = 0
          ExplicitHeight = 43
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 391
          Height = 22
          OnKeyDown = nil
          ExplicitWidth = 391
          ExplicitHeight = 22
        end
        inherited Fm_ListaBuscaEstado: TFm_ListaEstados
          Height = 37
          ExplicitLeft = 131
          ExplicitHeight = 37
          inherited pnl_linha_1: TPanel
            ExplicitWidth = 82
            inherited Sb_open: TSpeedButton
              Visible = False
            end
            inherited Dblcb_Lista: TDBLookupComboBox
              Height = 22
              ExplicitWidth = 58
              ExplicitHeight = 22
            end
          end
          inherited pnl_top: TPanel
            ExplicitWidth = 82
            inherited L_name_list: TLabel
              Width = 76
              Height = 13
            end
          end
        end
      end
      object chbx_consumidor: TCheckBox
        Left = 133
        Top = 84
        Width = 254
        Height = 17
        Caption = 'Regra aplicada para venda ao Consumidor Final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_NCM: TEdit
        Left = 5
        Top = 80
        Width = 121
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 168
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchNAT_CFOP: TStringField
      DisplayLabel = 'CFOP'
      FieldName = 'NAT_CFOP'
      Size = 10
    end
    object cds_searchUFE_SIGLA: TStringField
      DisplayLabel = 'UF'
      FieldName = 'UFE_SIGLA'
      Size = 2
    end
    object cds_searchTRB_CONSUMIDOR: TStringField
      DisplayLabel = 'Consumidor'
      FieldName = 'TRB_CONSUMIDOR'
      Size = 1
    end
    object cds_searchTRB_MICRO: TStringField
      DisplayLabel = 'Micro Empresa'
      FieldName = 'TRB_MICRO'
      Size = 1
    end
    object cds_searchTRB_CST: TStringField
      DisplayLabel = 'CST'
      FieldName = 'TRB_CST'
      Size = 2
    end
    object cds_searchTRB_ST_CIMS: TStringField
      DisplayLabel = 'Subs Trib'
      FieldName = 'TRB_ST_CIMS'
      Size = 1
    end
    object cds_searchTRB_AQ_ICMS: TFloatField
      DisplayLabel = 'Aliquota'
      FieldName = 'TRB_AQ_ICMS'
    end
    object cds_searchTRB_RD_BS_ICMS: TFloatField
      DisplayLabel = 'Red. Base'
      FieldName = 'TRB_RD_BS_ICMS'
    end
    object cds_searchTRB_RD_AQ_ICMS: TFloatField
      DisplayLabel = 'Red. Aliquota'
      FieldName = 'TRB_RD_AQ_ICMS'
    end
    object cds_searchOBS_DESCRICAO: TStringField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBS_DESCRICAO'
      Size = 50
    end
    object cds_searchTRB_CODIGONCM: TStringField
      DisplayLabel = 'C'#243'digo NCM'
      FieldName = 'TRB_CODIGONCM'
      Size = 50
    end
    object cds_searchReforma: TStringField
      FieldName = 'Reforma'
      Size = 3
    end
  end
end

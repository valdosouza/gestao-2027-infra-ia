inherited SeaOwnFleetOs: TSeaOwnFleetOs
  Caption = 'Controle de manuten'#231#227'o de frota pr'#243'pria'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 63
    Height = 440
    ExplicitTop = 63
    ExplicitHeight = 440
    inherited DBG_Pesquisa: TDBGrid
      Height = 422
      Columns = <
        item
          Expanded = False
          FieldName = 'TB_INSTITUTION_ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_RECORD'
          Title.Caption = 'Data'
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TB_VEHICLE_ID'
          Title.Caption = 'Placa'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KM'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBS'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'MRC_DESCRICAO'
          Title.Caption = 'Marca'
          Width = 216
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MOD_DESCRICAO'
          Title.Caption = 'Modelo'
          Width = 306
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Height = 422
      ExplicitHeight = 422
      inherited Sb_Sair_0: TSpeedButton
        Top = 359
        ExplicitTop = 359
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 296
        ExplicitTop = 296
      end
      inherited SB_Buscar: TSpeedButton
        Top = 233
        ExplicitTop = 233
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 170
        ExplicitTop = 170
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 54
    ExplicitHeight = 54
    object Label2: TLabel
      Left = 191
      Top = 8
      Width = 26
      Height = 14
      Caption = 'Placa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 23
      Width = 90
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 96
      Top = 23
      Width = 90
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 8
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object E_Placa: TEdit
      Left = 189
      Top = 23
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_OWN_FLEET_OS"."TB_INSTITUTION_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_OWN_FLEET_OS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchTB_VEHICLE_ID: TWideStringField
      FieldName = 'TB_VEHICLE_ID'
      Origin = '"TB_OWN_FLEET_OS"."TB_VEHICLE_ID"'
      Required = True
      Size = 7
    end
    object cds_searchDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = '"TB_OWN_FLEET_OS"."DT_RECORD"'
    end
    object cds_searchKM: TWideStringField
      FieldName = 'KM'
      Origin = '"TB_OWN_FLEET_OS"."KM"'
      Size = 15
    end
    object cds_searchOBS: TBlobField
      FieldName = 'OBS'
      Origin = '"TB_OWN_FLEET_OS"."OBS"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object cds_searchMRC_DESCRICAO: TWideStringField
      FieldName = 'MRC_DESCRICAO'
      Origin = '"TB_MARCA_VEICULO"."MRC_DESCRICAO"'
      Size = 100
    end
    object cds_searchMOD_DESCRICAO: TWideStringField
      FieldName = 'MOD_DESCRICAO'
      Size = 100
    end
  end
  inherited DSP: TDataSetProvider
    Top = 152
  end
end

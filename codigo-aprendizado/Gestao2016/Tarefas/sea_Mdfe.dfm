inherited SeaMdfe: TSeaMdfe
  Caption = 'Pesquisa MDFE'
  ExplicitLeft = -59
  ExplicitTop = -93
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 74
    Height = 429
    ExplicitTop = 65
    ExplicitHeight = 441
    inherited DBG_Pesquisa: TDBGrid
      Height = 417
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'Codigo'
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMBER'
          Title.Caption = 'N'#250'mero'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_EMISSION'
          Title.Caption = 'Data de Emiss'#227'o'
          Width = 153
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      inherited Sb_Sair_0: TSpeedButton
        Top = 374
        ExplicitTop = 374
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 314
        ExplicitTop = 314
      end
      inherited SB_Buscar: TSpeedButton
        Top = 254
        ExplicitTop = 254
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 194
        ExplicitTop = 194
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 65
    ExplicitHeight = 65
    object Label1: TLabel
      Left = 173
      Top = 7
      Width = 70
      Height = 14
      Caption = 'MDFE N'#250'mero:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Periodo: TCheckBox
      Left = 7
      Top = 6
      Width = 128
      Height = 12
      TabStop = False
      Caption = 'Data Inicial   Data Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChBx_PeriodoClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 7
      Top = 21
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 88
      Top = 21
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 2
    end
    object E_BuscaMdfe: TEdit
      Left = 173
      Top = 21
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 3
    end
    object Rg_Situacao: TRadioGroup
      Left = 300
      Top = 6
      Width = 490
      Height = 39
      Caption = 'Situa'#231#227'o MDFe'
      Columns = 6
      ItemIndex = 5
      Items.Strings = (
        'Pendentes'
        'Enviadas'
        'Autorizadas'
        'Canceladas'
        'Encerradas'
        'Todas')
      TabOrder = 4
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cds_searchNUMBER: TWideStringField
      FieldName = 'NUMBER'
      Size = 10
    end
    object cds_searchDT_EMISSION: TDateTimeField
      FieldName = 'DT_EMISSION'
    end
  end
end

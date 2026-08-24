inherited CadPetDeadline: TCadPetDeadline
  Caption = 'Cadastro de Procedimentos Peri'#243'dicos'
  ClientHeight = 390
  ClientWidth = 629
  ExplicitWidth = 635
  ExplicitHeight = 439
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 326
    Width = 629
    ExplicitTop = 326
    ExplicitWidth = 629
    inherited SB_Inserir: TSpeedButton
      Left = 2
      ExplicitLeft = 2
    end
    inherited SB_Alterar: TSpeedButton
      Left = 106
      ExplicitLeft = 106
    end
    inherited SB_Excluir: TSpeedButton
      Left = 210
      ExplicitLeft = 210
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 418
      ExplicitLeft = 418
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 522
      ExplicitLeft = 522
    end
    inherited SB_Gravar: TSpeedButton
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnl_fundo: TPanel
    Width = 629
    Height = 49
    Align = alTop
    ExplicitWidth = 629
    ExplicitHeight = 49
    object Label1: TLabel
      Left = 6
      Top = 2
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
    object Label5: TLabel
      Left = 365
      Top = 2
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 485
      Top = 2
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Description: TEdit
      Left = 6
      Top = 18
      Width = 353
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
    object E_Dt_Inicial: TDateTimePicker
      Left = 363
      Top = 18
      Width = 116
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object E_Dt_final: TDateTimePicker
      Left = 483
      Top = 18
      Width = 116
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
  end
  object Dbg_ListAnnotation: TDBGrid [2]
    Left = 0
    Top = 49
    Width = 629
    Height = 277
    Align = alClient
    Color = clCream
    DataSource = Ds_procedures
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = Dbg_ListAnnotationDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Width = 346
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INITIAL_DATE'
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FINAL_DATE'
        Width = 119
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 24
    Top = 280
  end
  object Cds_procedures: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 120
    object Cds_proceduresID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PET_DEADLINE"."ID"'
      Required = True
      Visible = False
    end
    object Cds_proceduresTB_PET_ID: TIntegerField
      FieldName = 'TB_PET_ID'
      Origin = '"TB_PET_DEADLINE"."TB_PET_ID"'
      Required = True
      Visible = False
    end
    object Cds_proceduresDESCRIPTION: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 65
      FieldName = 'DESCRIPTION'
      Origin = '"TB_PET_DEADLINE"."DESCRIPTION"'
      Size = 50
    end
    object Cds_proceduresINITIAL_DATE: TDateField
      DisplayLabel = 'Data Inicial'
      DisplayWidth = 24
      FieldName = 'INITIAL_DATE'
      Origin = '"TB_PET_DEADLINE"."INITIAL_DATE"'
    end
    object Cds_proceduresFINAL_DATE: TDateField
      DisplayLabel = 'Data Final'
      DisplayWidth = 24
      FieldName = 'FINAL_DATE'
      Origin = '"TB_PET_DEADLINE"."FINAL_DATE"'
    end
  end
  object Ds_procedures: TDataSource
    DataSet = Cds_procedures
    Left = 472
    Top = 178
  end
end

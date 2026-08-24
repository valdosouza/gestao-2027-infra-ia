inherited SeaPet: TSeaPet
  Caption = 'Consulta Pet'
  ClientWidth = 832
  ExplicitWidth = 838
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 146
    Width = 826
    Height = 357
    ExplicitTop = 146
    ExplicitWidth = 826
    ExplicitHeight = 357
    inherited DBG_Pesquisa: TDBGrid
      Width = 730
      Height = 339
    end
    inherited pnl_pesq_right: TPanel
      Left = 732
      Height = 339
      ExplicitLeft = 732
      ExplicitHeight = 339
      inherited Sb_Sair_0: TSpeedButton
        Top = 276
        ExplicitTop = 276
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 213
        ExplicitTop = 213
      end
      inherited SB_Buscar: TSpeedButton
        Top = 150
        ExplicitTop = 150
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 87
        ExplicitTop = 87
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 826
    Height = 137
    ExplicitWidth = 826
    ExplicitHeight = 137
    object Label1: TLabel
      Left = 4
      Top = 1
      Width = 60
      Height = 14
      Caption = 'Nome do Pet'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 4
      Top = 46
      Width = 40
      Height = 14
      Caption = 'Pelagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 535
      Top = 1
      Width = 25
      Height = 14
      Caption = 'Ra'#231'a'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 282
      Top = 1
      Width = 26
      Height = 14
      Caption = 'Idade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 278
      Top = 46
      Width = 17
      Height = 14
      Caption = 'Cor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 507
      Top = 46
      Width = 54
      Height = 14
      Caption = 'Frequ'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Name: TEdit
      Left = 4
      Top = 17
      Width = 272
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
    object CB_Race: TComboBox
      Left = 535
      Top = 17
      Width = 285
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object CB_Hair: TComboBox
      Left = 4
      Top = 63
      Width = 272
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object E_Age: TEdit
      Left = 282
      Top = 17
      Width = 39
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
    object Rg_Sexo: TRadioGroup
      Left = 327
      Top = 4
      Width = 199
      Height = 36
      Caption = 'Sexo'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'MACHO'
        'F'#202'MEA'
        'TODOS')
      TabOrder = 2
    end
    object Cb_Color: TComboBox
      Left = 278
      Top = 63
      Width = 224
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object Cb_attendance: TComboBox
      Left = 507
      Top = 63
      Width = 310
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 6
    end
    inline Fm_ListaClientes: TFm_ListaClientes
      AlignWithMargins = True
      Left = 3
      Top = 89
      Width = 662
      Height = 43
      TabOrder = 7
      TabStop = True
      ExplicitLeft = 3
      ExplicitTop = 89
      ExplicitWidth = 662
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 662
        ExplicitWidth = 662
      end
      inherited pnl_02: TPanel
        Width = 662
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 634
          ExplicitLeft = 620
          ExplicitTop = 23
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 609
          ExplicitLeft = 628
          ExplicitTop = 17
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 541
          ExplicitWidth = 533
        end
      end
      inherited Qr_ListaEmpresa: TSTQuery
        Top = 19
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 48
    Top = 184
  end
  inherited cds_search: TClientDataSet
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PET"."ID"'
      Required = True
      Visible = False
    end
    object cds_searchNAME: TWideStringField
      DisplayLabel = 'Nome do Pet'
      DisplayWidth = 52
      FieldName = 'NAME'
      Origin = '"TB_PET"."NAME"'
      Size = 100
    end
    object cds_searchAGE: TIntegerField
      DisplayLabel = 'Idade'
      DisplayWidth = 12
      FieldName = 'AGE'
      Origin = '"TB_PET"."AGE"'
    end
    object cds_searchRACE: TWideStringField
      DisplayLabel = 'Ra'#231'a'
      DisplayWidth = 35
      FieldName = 'RACE'
      Origin = '"TB_PET"."RACE"'
      Size = 50
    end
    object cds_searchHAIR: TWideStringField
      DisplayLabel = 'Pelagem'
      DisplayWidth = 52
      FieldName = 'HAIR'
      Origin = '"TB_PET"."HAIR"'
      Size = 50
    end
    object cds_searchCOLOR: TWideStringField
      DisplayLabel = 'Cor'
      DisplayWidth = 48
      FieldName = 'COLOR'
      Origin = '"TB_PET"."COLOR"'
      Size = 50
    end
    object cds_searchGENDER: TWideStringField
      DisplayLabel = 'Sexo'
      DisplayWidth = 9
      FieldName = 'GENDER'
      Origin = '"TB_PET"."GENDER"'
      FixedChar = True
      Size = 1
    end
    object cds_searchTB_CUSTOMER_ID: TIntegerField
      DisplayWidth = 20
      FieldName = 'TB_CUSTOMER_ID'
      Origin = '"TB_PET"."TB_CUSTOMER_ID"'
      Required = True
      Visible = False
    end
    object cds_searchCASTRATED: TWideStringField
      DisplayLabel = 'Castrados'
      DisplayWidth = 13
      FieldName = 'CASTRATED'
      Origin = '"TB_PET"."CASTRATED"'
      FixedChar = True
      Size = 1
    end
    object cds_searchATTENDANCE: TWideStringField
      DisplayLabel = 'Frequ'#234'ncia'
      DisplayWidth = 60
      FieldName = 'ATTENDANCE'
      Origin = '"TB_PET"."ATTENDANCE"'
      Size = 50
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      DisplayLabel = 'Nome do Cliente'
      DisplayWidth = 115
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_searchDT_RECORD: TDateField
      DisplayLabel = 'Data Cadastro'
      DisplayWidth = 18
      FieldName = 'DT_RECORD'
      Origin = '"TB_PET"."DT_RECORD"'
    end
  end
end

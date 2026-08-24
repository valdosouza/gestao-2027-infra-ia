inherited SeaElectEquip: TSeaElectEquip
  Caption = 'Pesquisa Equipamento Eletr'#244'nico'
  ClientHeight = 632
  ClientWidth = 998
  ExplicitWidth = 1004
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 111
    Width = 992
    Height = 518
    ExplicitTop = 111
    ExplicitWidth = 992
    ExplicitHeight = 518
    inherited DBG_Pesquisa: TDBGrid
      Width = 896
      Height = 500
    end
    inherited pnl_pesq_right: TPanel
      Left = 898
      Height = 500
      ExplicitLeft = 898
      ExplicitHeight = 500
      inherited Sb_Sair_0: TSpeedButton
        Top = 437
        ExplicitTop = 437
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 374
        ExplicitTop = 374
      end
      inherited SB_Buscar: TSpeedButton
        Top = 311
        ExplicitTop = 311
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 248
        ExplicitTop = 248
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 992
    Height = 102
    ExplicitWidth = 992
    ExplicitHeight = 102
    object Label28: TLabel
      Left = 8
      Top = 6
      Width = 119
      Height = 14
      Caption = 'Dispositivo /Equipamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 371
      Top = 6
      Width = 34
      Height = 14
      Caption = 'Modelo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 205
      Top = 6
      Width = 30
      Height = 14
      Caption = 'Marca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 576
      Top = 6
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 781
      Top = 6
      Width = 18
      Height = 14
      Caption = 'IMEI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Device: TEdit
      Left = 6
      Top = 22
      Width = 195
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
    object E_Modelo: TEdit
      Left = 371
      Top = 22
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Marca: TEdit
      Left = 203
      Top = 22
      Width = 166
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 1
    end
    object E_Serie: TEdit
      Left = 576
      Top = 22
      Width = 201
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
    object E_IMei: TEdit
      Left = 781
      Top = 22
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 4
      Top = 51
      Width = 668
      Height = 43
      TabOrder = 5
      TabStop = True
      ExplicitLeft = 4
      ExplicitTop = 51
      ExplicitWidth = 668
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 668
        ExplicitWidth = 668
        inherited ChBx_Nome: TCheckBox
          Top = -2
          ExplicitTop = -2
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = -2
          ExplicitLeft = 198
          ExplicitTop = -2
        end
      end
      inherited pnl_02: TPanel
        Width = 668
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 640
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 615
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 547
          ExplicitWidth = 539
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 56
    Top = 48
  end
  inherited cds_search: TClientDataSet
    AutoCalcFields = False
    Top = 210
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_ELECT_EQUIP"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchTB_CUSTOMER_ID: TIntegerField
      FieldName = 'TB_CUSTOMER_ID'
      Origin = '"TB_ELECT_EQUIP"."TB_CUSTOMER_ID"'
      Required = True
      Visible = False
    end
    object cds_searchDEVICE: TWideStringField
      DisplayLabel = 'Dispositivo'
      FieldName = 'DEVICE'
      Origin = '"TB_ELECT_EQUIP"."DEVICE"'
      Size = 50
    end
    object cds_searchBRAND: TWideStringField
      DisplayLabel = 'Marca'
      FieldName = 'BRAND'
      Origin = '"TB_ELECT_EQUIP"."BRAND"'
      Size = 50
    end
    object cds_searchMODEL: TWideStringField
      DisplayLabel = 'Modelo'
      FieldName = 'MODEL'
      Origin = '"TB_ELECT_EQUIP"."MODEL"'
      Size = 50
    end
    object cds_searchSERIE: TWideStringField
      DisplayLabel = 'Serie'
      FieldName = 'SERIE'
      Origin = '"TB_ELECT_EQUIP"."SERIE"'
      Size = 50
    end
    object cds_searchIMEI: TWideStringField
      FieldName = 'IMEI'
      Origin = '"TB_ELECT_EQUIP"."IMEI"'
      Size = 50
    end
    object cds_searchACCESSORIES: TWideStringField
      DisplayLabel = 'Acess'#243'rios'
      FieldName = 'ACCESSORIES'
      Origin = '"TB_ELECT_EQUIP"."ACCESSORIES"'
      Size = 255
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      DisplayLabel = 'Cliente'
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
  end
end

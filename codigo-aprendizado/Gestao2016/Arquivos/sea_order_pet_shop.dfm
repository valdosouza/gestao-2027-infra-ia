inherited SeaOrderPetShop: TSeaOrderPetShop
  Caption = 'Atendimento Pet'
  ClientWidth = 866
  ExplicitWidth = 872
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 141
    Width = 860
    Height = 362
    ExplicitTop = 141
    ExplicitWidth = 860
    ExplicitHeight = 362
    inherited DBG_Pesquisa: TDBGrid
      Width = 764
      Height = 344
    end
    inherited pnl_pesq_right: TPanel
      Left = 766
      Height = 344
      ExplicitLeft = 766
      ExplicitHeight = 344
      inherited Sb_Sair_0: TSpeedButton
        Top = 281
        ExplicitTop = 287
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 155
        Caption = 'Atendimento - F8'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
          333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
          C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
          F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
          F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
          00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
          3333333373FF7333333333333000333333333333377733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ExplicitTop = 161
      end
      inherited SB_Buscar: TSpeedButton
        Top = 92
        ExplicitTop = 98
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 29
        ExplicitTop = 35
      end
      object Sb_PEdido: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 218
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Pedido - F9'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_PEdidoClick
        ExplicitLeft = 6
        ExplicitTop = 215
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 860
    Height = 132
    ExplicitWidth = 860
    ExplicitHeight = 132
    object Label28: TLabel
      Left = 7
      Top = 48
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
    object Label8: TLabel
      Left = 575
      Top = 48
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
    object Label11: TLabel
      Left = 630
      Top = 48
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
    object Label26: TLabel
      Left = 202
      Top = 48
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
    object Label29: TLabel
      Left = 406
      Top = 48
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
      TabOrder = 9
    end
    object E_pet_name: TMaskEdit
      Left = 5
      Top = 64
      Width = 195
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object E_Age: TMaskEdit
      Left = 575
      Top = 64
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
    end
    inline Fm_ListaVendedores: TFm_ListaColaboradores
      Left = 6
      Top = 90
      Width = 315
      Height = 36
      TabOrder = 8
      ExplicitLeft = 6
      ExplicitTop = 90
      ExplicitWidth = 315
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 315
        Caption = 'Atendente'
        ExplicitWidth = 50
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 289
        Margins.Bottom = 1
        ExplicitLeft = 17
        ExplicitTop = 0
        ExplicitHeight = 21
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 283
        ExplicitWidth = 283
      end
    end
    object CB_Race: TComboBox
      Left = 202
      Top = 64
      Width = 199
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object CB_Hair: TComboBox
      Left = 406
      Top = 64
      Width = 166
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object Cb_Color: TComboBox
      Left = 630
      Top = 64
      Width = 224
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 7
    end
    inline Fm_ListaClientes: TFm_ListaClientes
      AlignWithMargins = True
      Left = 192
      Top = 4
      Width = 662
      Height = 43
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 192
      ExplicitTop = 4
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
    Left = 8
    Top = 200
  end
  inherited cds_search: TClientDataSet
    Top = 210
    object cds_searchPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchPED_NUMERO: TIntegerField
      DisplayLabel = 'Pedido'
      DisplayWidth = 15
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object cds_searchPED_DATA: TDateField
      DisplayLabel = 'Data'
      DisplayWidth = 15
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 65
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_searchNAME: TWideStringField
      DisplayLabel = 'Nome do Pet'
      DisplayWidth = 49
      FieldName = 'NAME'
      Origin = '"TB_PET"."NAME"'
      Size = 100
    end
    object cds_searchRACE: TWideStringField
      DisplayLabel = 'Ra'#231'a'
      DisplayWidth = 28
      FieldName = 'RACE'
      Origin = '"TB_PET"."RACE"'
      Size = 50
    end
    object cds_searchHAIR: TWideStringField
      DisplayLabel = 'Pelagem'
      DisplayWidth = 31
      FieldName = 'HAIR'
      Origin = '"TB_PET"."HAIR"'
      Size = 50
    end
    object cds_searchCOLOR: TWideStringField
      DisplayLabel = 'Cor'
      DisplayWidth = 24
      FieldName = 'COLOR'
      Origin = '"TB_PET"."COLOR"'
      Size = 50
    end
    object cds_searchAGE: TIntegerField
      DisplayLabel = 'Idade'
      DisplayWidth = 12
      FieldName = 'AGE'
      Origin = '"TB_PET"."AGE"'
    end
    object cds_searchPED_FATURADO: TWideStringField
      FieldName = 'PED_FATURADO'
      Origin = '"TB_PEDIDO"."PED_FATURADO"'
      Size = 1
    end
    object cds_searchPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = '"TB_PEDIDO"."PED_CODEMP"'
      Required = True
      Visible = False
    end
  end
end

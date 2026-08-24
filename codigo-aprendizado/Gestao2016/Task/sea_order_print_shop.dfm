inherited SeaOrderPrintShop: TSeaOrderPrintShop
  Caption = 'Ordem de Servi'#231'o - Gr'#225'fica'
  ClientHeight = 617
  ClientWidth = 1001
  ExplicitWidth = 1007
  ExplicitHeight = 666
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 159
    Width = 995
    Height = 455
    ExplicitTop = 159
    ExplicitWidth = 995
    ExplicitHeight = 455
    inherited DBG_Pesquisa: TDBGrid
      Width = 891
      Height = 437
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgTitleClick]
      OnDrawColumnCell = DBG_PesquisaDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PED_CODIGO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PED_NUMERO'
          Title.Caption = 'Pedido'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_DATA'
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_HORA'
          Title.Caption = 'Hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Title.Caption = 'Cliente'
          Width = 372
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_FONE'
          Title.Caption = 'Fone'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_CELULAR'
          Title.Caption = 'Celular'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIT_DESCRICAO'
          Title.Caption = 'Situa'#231#227'o'
          Width = 324
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIT_COLOR'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PED_VL_PEDIDO'
          Title.Caption = 'Valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MATERIAL'
          Title.Caption = 'Material'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TB_SITUATION_ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PED_CODEMP'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'VENDEDOR'
          Title.Caption = 'Vendedor'
          Width = 321
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MANUFACTURER'
          Title.Caption = 'Fabricante'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KNIFE'
          Title.Caption = 'Faca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_FATURADO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DT_FORECAST'
          Title.Caption = 'Data Prevista'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_FORECAST'
          Title.Caption = 'Hora Prevista'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_FINAL'
          Title.Caption = 'Data Final'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_FINAL'
          Title.Caption = 'Hora Final'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_DELIVERY'
          Title.Caption = 'Data Entrega'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_DELIVERY'
          Title.Caption = 'Hora Entrega'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TECNICO'
          Title.Caption = 'T'#233'cnico'
          Width = 313
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 893
      Width = 100
      Height = 437
      ExplicitLeft = 893
      ExplicitWidth = 100
      ExplicitHeight = 437
      inherited Sb_Sair_0: TSpeedButton
        Top = 374
        Width = 94
        ExplicitTop = 390
        ExplicitWidth = 94
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 248
        Width = 94
        Caption = 'Ordem - F8'
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
        ExplicitTop = 327
        ExplicitWidth = 94
      end
      inherited SB_Buscar: TSpeedButton
        Top = 185
        Width = 94
        ExplicitTop = 264
        ExplicitWidth = 94
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 122
        Width = 94
        ExplicitLeft = 6
        ExplicitTop = 121
        ExplicitWidth = 86
      end
      object Sb_PEdido: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 311
        Width = 94
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
        ExplicitTop = 361
        ExplicitWidth = 86
      end
      object Lb_valor_produtos: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 1
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total Produtos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 923
        ExplicitTop = 2
        ExplicitWidth = 84
      end
      object E_valor_produtos: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 17
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 72
        ExplicitTop = 16
        ExplicitWidth = 28
      end
      object Lb_valor_servicos: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total Servi'#231'os'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 892
        ExplicitTop = 39
        ExplicitWidth = 92
      end
      object E_valor_servicos: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 52
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 72
        ExplicitTop = 51
        ExplicitWidth = 28
      end
      object Lb_valor_total: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 94
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 894
        ExplicitTop = 74
        ExplicitWidth = 90
      end
      object E_valor_total: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 87
        Width = 94
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 995
    Height = 150
    ExplicitWidth = 995
    ExplicitHeight = 150
    object Label28: TLabel
      Left = 7
      Top = 48
      Width = 37
      Height = 14
      Caption = 'Material'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 540
      Top = 48
      Width = 24
      Height = 14
      Caption = 'Faca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 329
      Top = 48
      Width = 51
      Height = 14
      Caption = 'Fabricante'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 743
      Top = 48
      Width = 61
      Height = 14
      Caption = 'Equipamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 191
      Top = 8
      Width = 32
      Height = 14
      Caption = 'Pedido'
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
      TabOrder = 3
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 272
      Top = 6
      Width = 713
      Height = 43
      TabOrder = 4
      TabStop = True
      ExplicitLeft = 272
      ExplicitTop = 6
      ExplicitWidth = 713
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 713
        ExplicitWidth = 713
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
        Width = 713
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 685
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 660
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 592
          Font.Color = clBlack
          ExplicitWidth = 584
        end
      end
    end
    object E_Material: TEdit
      Left = 5
      Top = 64
      Width = 316
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Faca: TEdit
      Left = 540
      Top = 64
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Fabricante: TEdit
      Left = 327
      Top = 64
      Width = 207
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 6
    end
    object E_Equipamento: TEdit
      Left = 743
      Top = 64
      Width = 242
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    inline Fm_ListaSituacao: TFm_ListaSituacao
      Left = 7
      Top = 89
      Width = 322
      Height = 39
      TabOrder = 9
      ExplicitLeft = 7
      ExplicitTop = 89
      ExplicitWidth = 322
      inherited Label14: TLabel
        Width = 322
        Caption = 'Situa'#231#227'o atual'
        ExplicitWidth = 68
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 296
        ExplicitLeft = 296
      end
      inherited DBLCB_Situacao: TDBLookupComboBox
        Width = 293
        ExplicitWidth = 293
      end
    end
    inline Fm_ListaVendedores: TFm_ListaColaboradores
      Left = 330
      Top = 89
      Width = 330
      Height = 36
      TabOrder = 10
      ExplicitLeft = 330
      ExplicitTop = 89
      ExplicitWidth = 330
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 330
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 304
        Margins.Bottom = 1
        ExplicitLeft = 285
        ExplicitHeight = 17
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 301
        ExplicitWidth = 301
      end
    end
    object E_Nr_Pedido: TEdit
      Left = 189
      Top = 24
      Width = 84
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
    inline Fm_ListaTecnico: TFm_ListaColaboradores
      Left = 660
      Top = 89
      Width = 330
      Height = 37
      TabOrder = 11
      ExplicitLeft = 660
      ExplicitTop = 89
      ExplicitWidth = 330
      ExplicitHeight = 37
      inherited Label19: TLabel
        Width = 330
        Caption = 'Nome do T'#233'cnico'
        ExplicitWidth = 83
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 304
        Height = 20
        ExplicitLeft = 188
        ExplicitHeight = 46
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 301
        ExplicitWidth = 301
      end
    end
    object chbx_sem_tecnico: TCheckBox
      Left = 663
      Top = 128
      Width = 324
      Height = 17
      Caption = 'Mostrar apenas  ordens sem o t'#233'cnico definido'
      TabOrder = 12
      OnClick = chbx_sem_tecnicoClick
    end
  end
  inherited MnuBase: TMainMenu
    Left = 56
    Top = 224
  end
  inherited cds_search: TClientDataSet
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PRINT_SHOP_OS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object cds_searchPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
    end
    object cds_searchPED_HORA: TTimeField
      FieldName = 'PED_HORA'
      Origin = '"TB_PEDIDO"."PED_HORA"'
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_searchEND_FONE: TWideStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object cds_searchEND_CELULAR: TWideStringField
      FieldName = 'END_CELULAR'
      Origin = '"TB_ENDERECO"."END_CELULAR"'
      Size = 14
    end
    object cds_searchSIT_DESCRICAO: TWideStringField
      FieldName = 'SIT_DESCRICAO'
      Origin = '"TB_SITUACAO"."SIT_DESCRICAO"'
      Size = 100
    end
    object cds_searchSIT_COLOR: TWideStringField
      FieldName = 'SIT_COLOR'
      Origin = '"TB_SITUACAO"."SIT_COLOR"'
    end
    object cds_searchPED_VL_PEDIDO: TBCDField
      FieldName = 'PED_VL_PEDIDO'
      Origin = '"TB_PEDIDO"."PED_VL_PEDIDO"'
      Precision = 18
      Size = 2
    end
    object cds_searchMATERIAL: TWideStringField
      FieldName = 'MATERIAL'
      Origin = '"TB_PRINT_SHOP_OS"."MATERIAL"'
      Size = 50
    end
    object cds_searchTB_SITUATION_ID: TIntegerField
      FieldName = 'TB_SITUATION_ID'
      Origin = '"TB_PRINT_SHOP_OS"."TB_SITUATION_ID"'
    end
    object cds_searchPED_CODEMP: TIntegerField
      FieldName = 'PED_CODEMP'
      Origin = '"TB_PEDIDO"."PED_CODEMP"'
      Required = True
    end
    object cds_searchVENDEDOR: TWideStringField
      FieldName = 'VENDEDOR'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object cds_searchMANUFACTURER: TWideStringField
      FieldName = 'MANUFACTURER'
      Origin = '"TB_PRINT_SHOP_OS"."MANUFACTURER"'
      Size = 50
    end
    object cds_searchKNIFE: TWideStringField
      FieldName = 'KNIFE'
      Origin = '"TB_PRINT_SHOP_OS"."KNIFE"'
      Size = 50
    end
    object cds_searchPED_FATURADO: TWideStringField
      FieldName = 'PED_FATURADO'
      Origin = '"TB_PEDIDO"."PED_FATURADO"'
      Size = 1
    end
    object cds_searchDT_FINAL: TDateField
      FieldName = 'DT_FINAL'
      Origin = '"TB_PRINT_SHOP_OS"."DT_FINAL"'
    end
    object cds_searchHR_FINAL: TTimeField
      FieldName = 'HR_FINAL'
      Origin = '"TB_PRINT_SHOP_OS"."HR_FINAL"'
    end
    object cds_searchDT_FORECAST: TDateField
      FieldName = 'DT_FORECAST'
      Origin = '"TB_PRINT_SHOP_OS"."DT_FORECAST"'
    end
    object cds_searchHR_FORECAST: TTimeField
      FieldName = 'HR_FORECAST'
      Origin = '"TB_PRINT_SHOP_OS"."HR_FORECAST"'
    end
    object cds_searchDT_DELIVERY: TDateField
      FieldName = 'DT_DELIVERY'
      Origin = '"TB_PRINT_SHOP_OS"."DT_DELIVERY"'
    end
    object cds_searchHR_DELIVERY: TTimeField
      FieldName = 'HR_DELIVERY'
      Origin = '"TB_PRINT_SHOP_OS"."HR_DELIVERY"'
    end
    object cds_searchTECNICO: TWideStringField
      FieldName = 'TECNICO'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
  end
  inherited DSP: TDataSetProvider
    Left = 160
    Top = 152
  end
end

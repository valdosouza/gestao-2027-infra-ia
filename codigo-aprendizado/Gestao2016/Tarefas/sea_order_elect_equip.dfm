inherited SeaOrderElectEquip: TSeaOrderElectEquip
  Caption = 'Ordem de Servi'#231'o - Eletr'#244'nicos'
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
          FieldName = 'CST_CODIGO'
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
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_DATA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_HORA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMP_FANTASIA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_FONE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'END_CELULAR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIT_DESCRICAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TECNICO'
          Title.Caption = 'T'#233'cnico'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_VL_PEDIDO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CST_APARELHO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CST_CODSIT'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PED_CODEMP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VENDEDOR'
          Width = 302
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SERIE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMEI'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PED_FATURADO'
          Width = 59
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CST_DT_CONSERTO'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_CONSERTO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_FORECAST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_FORECAST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CST_DT_ENTREGA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HR_ENTREGA'
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
      Left = 370
      Top = 48
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
    object Label1: TLabel
      Left = 204
      Top = 48
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
    object Label8: TLabel
      Left = 575
      Top = 48
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
    object Label11: TLabel
      Left = 780
      Top = 48
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
      Width = 668
      Height = 43
      TabOrder = 4
      TabStop = True
      ExplicitLeft = 272
      ExplicitTop = 6
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
          Font.Color = clBlack
          ExplicitWidth = 539
        end
      end
    end
    object E_Device: TEdit
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
      TabOrder = 5
    end
    object E_Modelo: TEdit
      Left = 370
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
    object E_Marca: TEdit
      Left = 202
      Top = 64
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
      TabOrder = 6
    end
    object E_Serie: TEdit
      Left = 575
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
      TabOrder = 8
    end
    object E_IMei: TEdit
      Left = 780
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
      TabOrder = 9
    end
    inline Fm_ListaSituacao: TFm_ListaSituacao
      Left = 7
      Top = 89
      Width = 322
      Height = 39
      TabOrder = 10
      ExplicitLeft = 7
      ExplicitTop = 89
      ExplicitWidth = 322
      inherited Label14: TLabel
        Width = 322
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
      TabOrder = 11
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
      TabOrder = 12
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
      TabOrder = 13
      OnClick = chbx_sem_tecnicoClick
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchCST_CODIGO: TIntegerField
      FieldName = 'CST_CODIGO'
      Origin = '"TB_CONSERTO"."CST_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cds_searchPED_NUMERO: TIntegerField
      DisplayLabel = 'Pedido'
      DisplayWidth = 12
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object cds_searchPED_DATA: TDateField
      DisplayLabel = 'Data'
      DisplayWidth = 12
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
      Required = True
    end
    object cds_searchPED_HORA: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'PED_HORA'
      Origin = '"TB_PEDIDO"."PED_HORA"'
    end
    object cds_searchEMP_FANTASIA: TWideStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 47
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object cds_searchEND_FONE: TWideStringField
      DisplayLabel = 'Fone'
      DisplayWidth = 17
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object cds_searchEND_CELULAR: TWideStringField
      DisplayLabel = 'Celular'
      DisplayWidth = 17
      FieldName = 'END_CELULAR'
      Origin = '"TB_ENDERECO"."END_CELULAR"'
      Size = 14
    end
    object cds_searchSIT_DESCRICAO: TWideStringField
      DisplayLabel = 'Situa'#231#227'o'
      DisplayWidth = 41
      FieldName = 'SIT_DESCRICAO'
      Origin = '"TB_SITUACAO"."SIT_DESCRICAO"'
      Size = 100
    end
    object cds_searchPED_VL_PEDIDO: TBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 18
      FieldName = 'PED_VL_PEDIDO'
      Origin = '"TB_PEDIDO"."PED_VL_PEDIDO"'
      Precision = 18
      Size = 2
    end
    object cds_searchCST_APARELHO: TWideStringField
      DisplayLabel = 'Dispositivo/Aparelho'
      DisplayWidth = 60
      FieldName = 'CST_APARELHO'
      Origin = '"TB_CONSERTO"."CST_APARELHO"'
      Size = 50
    end
    object cds_searchCST_CODSIT: TIntegerField
      DisplayWidth = 14
      FieldName = 'CST_CODSIT'
      Origin = '"TB_CONSERTO"."CST_CODSIT"'
      Required = True
      Visible = False
    end
    object cds_searchPED_CODEMP: TIntegerField
      DisplayLabel = 'C'#243'digo Cliente'
      DisplayWidth = 15
      FieldName = 'PED_CODEMP'
      Origin = '"TB_PEDIDO"."PED_CODEMP"'
      Required = True
      Visible = False
    end
    object cds_searchVENDEDOR: TWideStringField
      DisplayLabel = 'Vendedor/Atendente'
      DisplayWidth = 120
      FieldName = 'VENDEDOR'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 50
    end
    object cds_searchSERIE: TWideStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      Origin = '"TB_CONSERTO"."SERIE"'
      Size = 50
    end
    object cds_searchIMEI: TWideStringField
      FieldName = 'IMEI'
      Origin = '"TB_CONSERTO"."IMEI"'
      Size = 50
    end
    object cds_searchPED_FATURADO: TWideStringField
      DisplayLabel = 'Faturado'
      FieldName = 'PED_FATURADO'
      Origin = '"TB_PEDIDO"."PED_FATURADO"'
      Size = 1
    end
    object cds_searchCST_DT_CONSERTO: TDateField
      DisplayLabel = 'Data Conserto'
      FieldName = 'CST_DT_CONSERTO'
      Origin = '"TB_CONSERTO"."CST_DT_CONSERTO"'
    end
    object cds_searchHR_CONSERTO: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'HR_CONSERTO'
      Origin = '"TB_CONSERTO"."HR_CONSERTO"'
    end
    object cds_searchDT_FORECAST: TDateField
      DisplayLabel = 'Data Prevista'
      FieldName = 'DT_FORECAST'
      Origin = '"TB_CONSERTO"."DT_FORECAST"'
    end
    object cds_searchHR_FORECAST: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'HR_FORECAST'
      Origin = '"TB_CONSERTO"."HR_FORECAST"'
    end
    object cds_searchCST_DT_ENTREGA: TDateField
      DisplayLabel = 'Data Entrega'
      FieldName = 'CST_DT_ENTREGA'
      Origin = '"TB_CONSERTO"."CST_DT_ENTREGA"'
    end
    object cds_searchHR_ENTREGA: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'HR_ENTREGA'
      Origin = '"TB_CONSERTO"."HR_ENTREGA"'
    end
    object cds_searchTECNICO: TWideStringField
      FieldName = 'TECNICO'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object cds_searchSIT_COLOR: TWideStringField
      FieldName = 'SIT_COLOR'
      Origin = '"TB_SITUACAO"."SIT_COLOR"'
    end
  end
  inherited DSP: TDataSetProvider
    Left = 120
    Top = 152
  end
end

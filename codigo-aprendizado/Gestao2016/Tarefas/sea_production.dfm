inherited SeaProduction: TSeaProduction
  Caption = 'Pesquisa Ordem de Produ'#231#227'o'
  ClientWidth = 818
  ExplicitWidth = 824
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 96
    Width = 812
    Height = 407
    ExplicitTop = 96
    ExplicitWidth = 812
    ExplicitHeight = 407
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 808
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 712
      Height = 389
      Columns = <
        item
          Expanded = False
          FieldName = 'ORP_NUMERO'
          Title.Caption = 'Ordem'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORP_DTCAD'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORP_DTPREV'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 321
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORP_INDSIT'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORP_CODPRO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORP_QTDPREV'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORP_DTINI'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORP_DTFIM'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORP_QTDREAL'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 714
      Width = 96
      Height = 389
      ExplicitLeft = 714
      ExplicitWidth = 96
      ExplicitHeight = 389
      inherited Sb_Sair_0: TSpeedButton
        Top = 326
        Width = 90
        ExplicitLeft = 718
        ExplicitTop = 352
        ExplicitWidth = 94
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 263
        Width = 90
        ExplicitLeft = 718
        ExplicitTop = 292
        ExplicitWidth = 94
      end
      inherited SB_Buscar: TSpeedButton
        Top = 200
        Width = 90
        ExplicitLeft = 718
        ExplicitTop = 232
        ExplicitWidth = 94
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 137
        Width = 90
        ExplicitLeft = 718
        ExplicitTop = 172
        ExplicitWidth = 94
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 812
    Height = 87
    ExplicitWidth = 812
    ExplicitHeight = 87
    object Label1: TLabel
      Left = 173
      Top = 7
      Width = 64
      Height = 14
      Caption = 'ORP N'#250'mero:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 174
      Top = 45
      Width = 45
      Height = 14
      Caption = 'Situa'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 44
      Width = 60
      Height = 14
      Caption = 'Tipo de Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object edCod: TEdit
      Left = 173
      Top = 21
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 0
    end
    object Cb_Situacao: TComboBox
      Left = 174
      Top = 59
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Todas'
      Items.Strings = (
        'Todas'
        'Ativo'
        'Inativo'
        'Produzindo'
        'Finalizada')
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 295
      Top = 5
      Width = 514
      Height = 43
      TabOrder = 2
      ExplicitLeft = 295
      ExplicitTop = 5
      ExplicitWidth = 514
      inherited Sb_Produto: TSpeedButton
        Left = 487
        ExplicitLeft = 487
      end
      inherited E_Busca_Produto: TEdit
        Width = 382
        ExplicitWidth = 382
      end
    end
    object E_Data_Ini: TDateTimePicker
      Left = 7
      Top = 21
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 3
    end
    object E_Data_Fim: TDateTimePicker
      Left = 88
      Top = 21
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 4
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
      TabOrder = 5
      OnClick = ChBx_PeriodoClick
    end
    object cbDatas: TComboBox
      Left = 7
      Top = 59
      Width = 161
      Height = 21
      ItemIndex = 0
      TabOrder = 6
      Text = 'Cadastro'
      Items.Strings = (
        'Cadastro'
        'Data Prevista'
        'Data Inicio'
        'Data Final')
    end
  end
  inherited MnuBase: TMainMenu
    Left = 744
    Top = 144
  end
  inherited cds_search: TClientDataSet
    object cds_searchORP_CODIGO: TIntegerField
      FieldName = 'ORP_CODIGO'
      Origin = '"TB_ORP"."ORP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchORP_NUMERO: TWideStringField
      FieldName = 'ORP_NUMERO'
      Origin = '"TB_ORP"."ORP_NUMERO"'
      Required = True
      Size = 10
    end
    object cds_searchORP_DTCAD: TDateField
      DisplayLabel = 'Cadastro'
      FieldName = 'ORP_DTCAD'
      Origin = '"TB_ORP"."ORP_DTCAD"'
    end
    object cds_searchORP_DTPREV: TDateField
      DisplayLabel = 'Previsto'
      FieldName = 'ORP_DTPREV'
      Origin = '"TB_ORP"."ORP_DTPREV"'
    end
    object cds_searchORP_INDSIT: TWideStringField
      FieldName = 'ORP_INDSIT'
      Origin = '"TB_ORP"."ORP_INDSIT"'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cds_searchORP_CODPRO: TIntegerField
      FieldName = 'ORP_CODPRO'
      Origin = '"TB_ORP"."ORP_CODPRO"'
      Required = True
    end
    object cds_searchORP_QTDPREV: TBCDField
      FieldName = 'ORP_QTDPREV'
      Origin = '"TB_ORP"."ORP_QTDPREV"'
      Required = True
      Precision = 18
      Size = 2
    end
    object cds_searchORP_DTINI: TDateTimeField
      FieldName = 'ORP_DTINI'
      Origin = '"TB_ORP"."ORP_DTINI"'
    end
    object cds_searchORP_DTFIM: TDateTimeField
      FieldName = 'ORP_DTFIM'
      Origin = '"TB_ORP"."ORP_DTFIM"'
    end
    object cds_searchORP_QTDREAL: TBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'ORP_QTDREAL'
      Origin = '"TB_ORP"."ORP_QTDREAL"'
      Required = True
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchPRO_DESCRICAO: TWideStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
  end
  inherited DSP: TDataSetProvider
    Constraints = False
  end
end

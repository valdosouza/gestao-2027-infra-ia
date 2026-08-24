inherited SeaPrePaidCard: TSeaPrePaidCard
  Caption = 'Pesquisa de cart'#245'es pr'#233'-pago'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 58
    Height = 445
    ExplicitTop = 58
    ExplicitHeight = 445
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 875
    end
    inherited DBG_Pesquisa: TDBGrid
      Height = 427
      PopupMenu = PopupMenu
      Columns = <
        item
          Expanded = False
          FieldName = 'TERMINAL'
          Title.Caption = 'Terminal'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMBER'
          Title.Caption = 'N'#250'mero'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DT_RECORD'
          Title.Caption = 'Data'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CREDIT_VALUE'
          Title.Caption = 'Valor Cr'#233'dito'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEBIT_VALUE'
          Title.Caption = 'Valor D'#233'bito'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HISTORY'
          Title.Caption = 'Hist'#243'rico'
          Width = 302
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Height = 427
      ExplicitHeight = 427
      inherited Sb_Sair_0: TSpeedButton
        Top = 364
        ExplicitTop = 379
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 301
        Visible = False
        ExplicitLeft = 6
        ExplicitTop = 313
      end
      inherited SB_Buscar: TSpeedButton
        Top = 238
        ExplicitLeft = 6
        ExplicitTop = 265
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 175
        ExplicitTop = 199
      end
      object Lb_TotalCredito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 1
        Width = 86
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Cr'#233'ditos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
      object E_TotalCredito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 17
        Width = 86
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
      object Lb_TotalDebito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 86
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor D'#233'bitos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
      object E_TotalDebito: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 52
        Width = 86
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
      object Lb_Saldo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 86
        Height = 14
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Saldo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
      object E_Saldo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 87
        Width = 86
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 49
    ExplicitHeight = 49
    object Label36: TLabel
      Left = 178
      Top = 2
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'N'#250'mero Cart'#227'o'
      FocusControl = E_Numero
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 472
      Top = 6
      Width = 74
      Height = 13
      AutoSize = False
      Caption = 'Hist'#243'rico'
      FocusControl = E_Numero
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Numero: TMaskEdit
      Left = 176
      Top = 21
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 3
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 90
      Top = 21
      Width = 82
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 2
    end
    object E_Data_Ini: TDateTimePicker
      Left = 5
      Top = 21
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 3
    end
    object Rg_Tipo_Valor: TRadioGroup
      Left = 276
      Top = 4
      Width = 190
      Height = 40
      Caption = 'Tipo Valor'
      Columns = 3
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito'
        'Todos')
      TabOrder = 4
    end
    object E_Historico: TEdit
      Left = 472
      Top = 21
      Width = 401
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
  end
  inherited MnuBase: TMainMenu
    Left = 88
    Top = 160
    inherited arefas1: TMenuItem
      object Cliente1: TMenuItem [0]
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_PRE_PAID_CARD"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_PRE_PAID_CARD"."TB_INSTITUTION_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchTERMINAL: TIntegerField
      FieldName = 'TERMINAL'
      Origin = '"TB_PRE_PAID_CARD"."TERMINAL"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_searchDT_RECORD: TDateField
      FieldName = 'DT_RECORD'
      Origin = '"TB_PRE_PAID_CARD"."DT_RECORD"'
    end
    object cds_searchCREDIT_VALUE: TBCDField
      FieldName = 'CREDIT_VALUE'
      Origin = '"TB_PRE_PAID_CARD"."CREDIT_VALUE"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchDEBIT_VALUE: TBCDField
      FieldName = 'DEBIT_VALUE'
      Origin = '"TB_PRE_PAID_CARD"."DEBIT_VALUE"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object cds_searchHISTORY: TWideStringField
      FieldName = 'HISTORY'
      Origin = '"TB_PRE_PAID_CARD"."HISTORY"'
      Size = 100
    end
    object cds_searchTB_ORDER_ID: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_PRE_PAID_CARD"."TB_ORDER_ID"'
    end
    object cds_searchCREATED_AT: TSQLTimeStampField
      FieldName = 'CREATED_AT'
      Origin = '"TB_PRE_PAID_CARD"."CREATED_AT"'
    end
    object cds_searchUPDATED_AT: TSQLTimeStampField
      FieldName = 'UPDATED_AT'
      Origin = '"TB_PRE_PAID_CARD"."UPDATED_AT"'
    end
    object cds_searchNUMBER: TWideStringField
      FieldName = 'NUMBER'
      Origin = '"TB_PRE_PAID_CARD"."NUMBER"'
      Size = 15
    end
  end
  object PopupMenu: TPopupMenu
    Left = 664
    Top = 225
    object VisualizarPedido1: TMenuItem
      Caption = 'Visualizar Pedido'
      OnClick = VisualizarPedido1Click
    end
  end
end

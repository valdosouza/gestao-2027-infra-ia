inherited SeaLojaTrayOrder: TSeaLojaTrayOrder
  Caption = 'Pedidos efetuados na Loja Virtual'
  ClientWidth = 831
  ExplicitWidth = 837
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrB_Parametros: TGroupBox
    Width = 831
    Height = 60
    ExplicitWidth = 831
    ExplicitHeight = 60
    object lb_Filter_Value: TLabel
      Left = 180
      Top = 11
      Width = 58
      Height = 14
      Caption = 'C'#243'digo Web'
    end
    object ChBx_Periodo: TCheckBox
      Left = 8
      Top = 15
      Width = 135
      Height = 13
      Caption = 'Data Inicial    Data Final'
      TabOrder = 0
      OnClick = ChBx_PeriodoClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 6
      Top = 31
      Width = 83
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 90
      Top = 31
      Width = 83
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 2
    end
    object E_Codigo_Web: TEdit
      Left = 179
      Top = 31
      Width = 70
      Height = 22
      TabOrder = 3
    end
  end
  inherited Pnl_Resultado: TPanel
    Top = 60
    Width = 831
    Height = 449
    ExplicitTop = 60
    ExplicitWidth = 831
    ExplicitHeight = 449
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 827
    end
    inherited Grd_Pesquisa: TStringGrid
      Width = 726
      Height = 431
      ExplicitWidth = 726
      ExplicitHeight = 431
    end
    inherited pnl_botao: TPanel
      Left = 728
      Height = 431
      ExplicitLeft = 728
      ExplicitHeight = 431
      inherited Sb_Sair: TSpeedButton
        Top = 376
        ExplicitLeft = 733
        ExplicitTop = 389
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 321
        ExplicitLeft = 733
        ExplicitTop = 335
      end
      inherited SB_Buscar: TSpeedButton
        Top = 266
        ExplicitLeft = 733
        ExplicitTop = 281
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 211
        ExplicitLeft = 733
        ExplicitTop = 227
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 32
  end
  inherited Qr_Pesquisa: TSTQuery
    SQL.Strings = (
      'select *'
      'from tb_loja_tray_order lto')
    object Qr_PesquisaID: TIntegerField
      Tag = 50
      DisplayLabel = 'Pedido'
      FieldName = 'ID'
      Origin = '"TB_LOJA_TRAY_ORDER"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaSTATUS: TStringField
      Tag = 120
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'STATUS'
      Origin = '"TB_LOJA_TRAY_ORDER"."STATUS"'
      Size = 50
    end
    object Qr_PesquisaDT_RECORD: TDateField
      Tag = 70
      DisplayLabel = 'Data'
      FieldName = 'DT_RECORD'
      Origin = '"TB_LOJA_TRAY_ORDER"."DT_RECORD"'
    end
    object Qr_PesquisaCUSTOMER_ID: TIntegerField
      Tag = -1
      FieldName = 'CUSTOMER_ID'
      Origin = '"TB_LOJA_TRAY_ORDER"."CUSTOMER_ID"'
    end
    object Qr_PesquisaPARTIAL_TOTAL: TBCDField
      Tag = 70
      DisplayLabel = 'SubTotal'
      FieldName = 'PARTIAL_TOTAL'
      Origin = '"TB_LOJA_TRAY_ORDER"."PARTIAL_TOTAL"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaTAXES: TBCDField
      Tag = -1
      FieldName = 'TAXES'
      Origin = '"TB_LOJA_TRAY_ORDER"."TAXES"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaDISCOUNT: TBCDField
      Tag = -1
      FieldName = 'DISCOUNT'
      Origin = '"TB_LOJA_TRAY_ORDER"."DISCOUNT"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaSHIPMENT: TStringField
      Tag = 100
      DisplayLabel = 'Entrega'
      FieldName = 'SHIPMENT'
      Origin = '"TB_LOJA_TRAY_ORDER"."SHIPMENT"'
      Size = 50
    end
    object Qr_PesquisaSHIPMENT_VALUE: TBCDField
      Tag = 70
      DisplayLabel = 'Valor Frete'
      FieldName = 'SHIPMENT_VALUE'
      Origin = '"TB_LOJA_TRAY_ORDER"."SHIPMENT_VALUE"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaDT_SHIPMENT: TDateField
      Tag = 70
      DisplayLabel = 'Data Entrega'
      FieldName = 'DT_SHIPMENT'
      Origin = '"TB_LOJA_TRAY_ORDER"."DT_SHIPMENT"'
    end
    object Qr_PesquisaPAYMENT_FORM: TStringField
      Tag = 140
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'PAYMENT_FORM'
      Origin = '"TB_LOJA_TRAY_ORDER"."PAYMENT_FORM"'
      Size = 50
    end
    object Qr_PesquisaTOTAL_VALUE: TBCDField
      Tag = 70
      DisplayLabel = 'Valor Total'
      FieldName = 'TOTAL_VALUE'
      Origin = '"TB_LOJA_TRAY_ORDER"."TOTAL_VALUE"'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaDT_PAYMENT: TDateField
      Tag = 80
      DisplayLabel = 'Data Pagamento'
      FieldName = 'DT_PAYMENT'
      Origin = '"TB_LOJA_TRAY_ORDER"."DT_PAYMENT"'
    end
    object Qr_PesquisaMODIFIED: TSQLTimeStampField
      Tag = 110
      DisplayLabel = #218'ltima Altera'#231#227'o'
      FieldName = 'MODIFIED'
      Origin = '"TB_LOJA_TRAY_ORDER"."MODIFIED"'
    end
  end
  object DataSource1: TDataSource
    Left = 272
    Top = 260
  end
end

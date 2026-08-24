inherited TasItemsSalesBefore: TTasItemsSalesBefore
  BorderStyle = bsDialog
  Caption = #218'ltimas vendas deste item para este Cliente'
  ClientHeight = 218
  ClientWidth = 480
  Menu = nil
  ExplicitWidth = 486
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Servicos: TDBGrid [0]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 474
    Height = 212
    Align = alClient
    Color = clCream
    DataSource = ds_items
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PED_DATA'
        Title.Caption = 'Data'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_NUMERO'
        Title.Caption = 'N'#250'mero Pedido'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_UNIT'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 109
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_QTDE'
        Title.Caption = 'Quantidade'
        Width = 102
        Visible = True
      end>
  end
  object ds_items: TDataSource
    DataSet = Qr_Items
    Left = 168
    Top = 160
  end
  object Qr_Items: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Items
    ForcedRefresh = True
    AfterOpen = Qr_ItemsAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select first 6 pd.ped_data, pd.ped_numero, i.itf_vl_unit, I.itf_' +
        'qtde'
      'FROM tb_pedido pd'
      '  INNER JOIN TB_NOTA_FISCAL NF '
      '  ON (NFL_CODPED = PED_CODIGO) '
      '  inner join tb_itens_nfl I'
      '  on (I.itf_codped = pd.ped_codigo)'
      'WHERE PED_CODEMP=:EMP_CODIGO'
      ' and pd.PED_TIPO = 1'
      ' and I.itf_codpro =:itf_codpro'
      'order by pd.ped_data desc')
    Left = 172
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'itf_codpro'
        ParamType = ptUnknown
      end>
    object Qr_ItemsPED_DATA: TDateField
      FieldName = 'PED_DATA'
      Origin = '"TB_PEDIDO"."PED_DATA"'
    end
    object Qr_ItemsPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_ItemsITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_ItemsITF_QTDE: TBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
  end
  object IBT_Items: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Left = 240
    Top = 104
  end
end

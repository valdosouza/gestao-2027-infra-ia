inherited RL_ReportListExtintores: TRL_ReportListExtintores
  Caption = 'Lista de Extintores'
  ClientHeight = 405
  ClientWidth = 850
  ExplicitWidth = 866
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      70.000000000000000000
      75.000000000000000000
      0.000000000000000000)
    inherited PageHeader: TQRBand
      Height = 150
      Size.Values = (
        396.875000000000000000
        1955.270833333333000000)
      ExplicitHeight = 150
      inherited E_Titulo: TQRLabel
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        FontSize = 10
      end
      inherited Img_Logo: TQRImage
        Left = 7
        Top = 4
        Width = 150
        Height = 104
        Size.Values = (
          275.166666666666700000
          18.520833333333330000
          10.583333333333330000
          396.875000000000000000)
        ExplicitLeft = 7
        ExplicitTop = 4
        ExplicitWidth = 150
        ExplicitHeight = 104
      end
      inherited Lb_Emp_Nome: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          5.291666666666667000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Doc: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          52.916666666666660000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_End: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          103.187500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Fones: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          150.812500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_www: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          246.062500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_email: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          198.437500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      object QRMemo10: TQRMemo
        Left = 31
        Top = 133
        Width = 144
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          82.020833333333320000
          351.895833333333300000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Cliente')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo9: TQRMemo
        Left = 422
        Top = 133
        Width = 52
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1116.541666666667000000
          351.895833333333300000
          137.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Carga N')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo8: TQRMemo
        Left = 355
        Top = 133
        Width = 68
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          939.270833333333200000
          351.895833333333300000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Tipo')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo7: TQRMemo
        Left = 253
        Top = 133
        Width = 72
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          669.395833333333200000
          351.895833333333300000
          190.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' S'#233'rie')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo6: TQRMemo
        Left = 174
        Top = 133
        Width = 80
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          460.375000000000000000
          351.895833333333300000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Marca')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo5: TQRMemo
        Left = 574
        Top = 133
        Width = 62
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1518.708333333333000000
          351.895833333333300000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          'N'#186' Selo')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo4: TQRMemo
        Left = 513
        Top = 133
        Width = 61
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1357.312500000000000000
          351.895833333333300000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Data Carga')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo2: TQRMemo
        Left = 474
        Top = 133
        Width = 39
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1254.125000000000000000
          351.895833333333300000
          103.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Ensaio')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo1: TQRMemo
        Left = 0
        Top = 133
        Width = 32
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          351.895833333333300000
          84.666666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' N'#176)
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo11: TQRMemo
        Left = 325
        Top = 133
        Width = 30
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          859.895833333333200000
          351.895833333333300000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Ano')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRMemo3: TQRMemo
        Left = 634
        Top = 133
        Width = 105
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1677.458333333333000000
          351.895833333333300000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' Info. Lotes')
        ParentFont = False
        Transparent = True
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
    end
    object QRBand1: TQRBand
      Left = 26
      Top = 188
      Width = 739
      Height = 18
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        47.625000000000000000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object E_Ext_Cliente: TQRMemo
        Left = 31
        Top = 0
        Width = 144
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          82.020833333333320000
          0.000000000000000000
          381.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' Cliente')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Carga: TQRMemo
        Left = 422
        Top = 0
        Width = 52
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1116.541666666667000000
          0.000000000000000000
          137.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' Carga N')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Tipo: TQRMemo
        Left = 355
        Top = 0
        Width = 68
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          939.270833333333200000
          0.000000000000000000
          179.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' Tipo')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Serie: TQRMemo
        Left = 253
        Top = 0
        Width = 72
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          669.395833333333200000
          0.000000000000000000
          190.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' S'#233'rie')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Marca: TQRMemo
        Left = 174
        Top = 0
        Width = 80
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          460.375000000000000000
          0.000000000000000000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' Marca')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Mnt_Selo: TQRMemo
        Left = 574
        Top = 0
        Width = 62
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1518.708333333333000000
          0.000000000000000000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '000000000')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Mnt_Dt_Carga: TQRMemo
        Left = 513
        Top = 0
        Width = 61
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1357.312500000000000000
          0.000000000000000000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' 01/01/0000')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Mnt_Ensaio: TQRMemo
        Left = 474
        Top = 0
        Width = 39
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1254.125000000000000000
          0.000000000000000000
          103.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0000')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Numero: TQRMemo
        Left = 0
        Top = 0
        Width = 32
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          0.000000000000000000
          84.666666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' 0000')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Ano: TQRMemo
        Left = 325
        Top = 0
        Width = 30
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          859.895833333333200000
          0.000000000000000000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          '0000')
        ParentFont = False
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object E_Ext_Localizacao: TQRMemo
        Left = 634
        Top = 0
        Width = 105
        Height = 19
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          50.270833333333330000
          1677.458333333333000000
          0.000000000000000000
          277.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          ' 0%')
        ParentFont = False
        Transparent = True
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
    end
    object QRBand3: TQRBand
      Left = 26
      Top = 206
      Width = 739
      Height = 26
      AlignToBottom = False
      BeforePrint = QRBand3BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        68.791666666666680000
        1955.270833333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object E_Qtde_Extintores: TQRLabel
        Left = 4
        Top = 5
        Width = 185
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          13.229166666666670000
          489.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Quantidade total de Extintores :'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Top = 0
  end
  object Qr_Ordem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 152
  end
  object Qr_Lotes: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select FIRST 1 ORS_DT_ENCERRAMENTO,tb_ctrl_lote.clt_numero '
      'from tb_movimento_lote '
      '  inner join tb_ctrl_lote '
      '  on (tb_ctrl_lote.clt_codigo = tb_movimento_lote.mlt_codclt) '
      ' INNER JOIN tb_ext_itens_ors '
      
        '  ON (tb_ext_itens_ors.ios_codigo = tb_movimento_lote.mlt_codvcl' +
        ') '
      '  INNER JOIN tb_ext_ordem_servico '
      
        '  ON (tb_ext_ordem_servico.ors_codigo = tb_ext_itens_ors.ios_cod' +
        'ors ) '
      'WHERE MLT_CODEXT =:EXT_CODIGO '
      'ORDER BY ORS_DT_ENCERRAMENTO DESC')
    Left = 223
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EXT_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_LotesORS_DT_ENCERRAMENTO: TDateField
      FieldName = 'ORS_DT_ENCERRAMENTO'
      Origin = '"TB_EXT_ORDEM_SERVICO"."ORS_DT_ENCERRAMENTO"'
    end
    object Qr_LotesCLT_NUMERO: TStringField
      FieldName = 'CLT_NUMERO'
      Origin = '"TB_CTRL_LOTE"."CLT_NUMERO"'
      Size = 50
    end
  end
end

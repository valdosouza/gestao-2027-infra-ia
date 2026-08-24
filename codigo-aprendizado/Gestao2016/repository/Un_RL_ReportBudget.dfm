inherited RL_ReportBudget: TRL_ReportBudget
  Caption = 'Pedido de Venda'
  ClientHeight = 462
  ClientWidth = 967
  ExplicitWidth = 975
  ExplicitHeight = 489
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      #39#39)
    Page.Values = (
      75.000000000000000000
      2970.000000000000000000
      75.000000000000000000
      2100.000000000000000000
      70.000000000000000000
      75.000000000000000000
      0.000000000000000000)
    inherited QrbRodape: TQRBand
      Top = 269
      Height = 150
      Size.Values = (
        396.875000000000000000
        1955.270833333333000000)
      ExplicitTop = 269
      ExplicitHeight = 150
      inherited QRLabel21: TQRLabel
        Size.Values = (
          44.979166666666670000
          357.187500000000000000
          18.520833333333330000
          261.937500000000000000)
        FontSize = 10
      end
      inherited QRShape11: TQRShape
        Size.Values = (
          394.229166666666700000
          5.291666666666667000
          0.000000000000000000
          1944.687500000000000000)
      end
      inherited Lb_Vl_Pecas: TQRLabel
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          100.541666666667000000
          309.562500000000000000)
        FontSize = 10
      end
      inherited Lb_Vl_Desconto: TQRLabel
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          185.208333333333000000
          309.562500000000000000)
        FontSize = 10
      end
      inherited QRLabel26: TQRLabel
        Size.Values = (
          44.979166666666670000
          1383.770833333333000000
          100.541666666666700000
          246.062500000000000000)
        FontSize = 10
      end
      inherited QRLabel27: TQRLabel
        Size.Values = (
          44.979166666666670000
          1381.125000000000000000
          185.208333333333300000
          246.062500000000000000)
        FontSize = 10
      end
      inherited QRLabel28: TQRLabel
        Size.Values = (
          60.854166666666680000
          1375.833333333333000000
          224.895833333333300000
          246.062500000000000000)
        FontSize = 14
      end
      inherited Lb_Vl_Total: TQRLabel
        Size.Values = (
          60.854166666666680000
          1629.833333333333000000
          224.895833333333300000
          309.562500000000000000)
        FontSize = 14
      end
      inherited QRLabel31: TQRLabel
        Size.Values = (
          44.979166666666670000
          15.875000000000000000
          10.583333333333330000
          444.500000000000000000)
        FontSize = 10
      end
      inherited Lb_TipoCob: TQRLabel
        Size.Values = (
          44.979166666666700000
          465.666666666667000000
          10.583333333333300000
          1471.083333333330000000)
        FontSize = 10
      end
      inherited QRLabel16: TQRLabel
        Size.Values = (
          44.979166666666670000
          1383.770833333333000000
          142.875000000000000000
          246.062500000000000000)
        FontSize = 10
      end
      inherited Lb_Vl_SubTotal: TQRLabel
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          142.875000000000000000
          309.562500000000000000)
        FontSize = 10
      end
      inherited Lb_Assinatura: TQRLabel
        Size.Values = (
          44.979166666666670000
          775.229166666666800000
          338.666666666666700000
          1053.041666666667000000)
        FontSize = 10
      end
      inherited Lb_LocalData: TQRLabel
        Size.Values = (
          44.979166666666670000
          34.395833333333340000
          338.666666666666700000
          677.333333333333400000)
        FontSize = 10
      end
      inherited QRLabel17: TQRLabel
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          246.062500000000000000
          177.270833333333300000)
        FontSize = 10
      end
      inherited Lb_NomeVendedor: TQRLabel
        Size.Values = (
          44.979166666666670000
          203.729166666666700000
          246.062500000000000000
          1087.437500000000000000)
        FontSize = 10
      end
      inherited QRLabel18: TQRLabel
        Size.Values = (
          47.625000000000000000
          15.875000000000000000
          55.562500000000000000
          216.958333333333300000)
        FontSize = 10
      end
      inherited E_Obs: TQRMemo
        Size.Values = (
          134.937500000000000000
          15.875000000000000000
          103.187500000000000000
          1299.104166666667000000)
        FontSize = 8
      end
      inherited Lb_Vl_Servico: TQRLabel
        Size.Values = (
          44.979166666666700000
          1629.833333333330000000
          58.208333333333300000
          309.562500000000000000)
        FontSize = 10
      end
      inherited QRLabel1: TQRLabel
        Size.Values = (
          44.979166666666670000
          1370.541666666667000000
          58.208333333333340000
          256.645833333333300000)
        FontSize = 10
      end
    end
    inherited Titulo: TQRBand
      Top = 28
      Height = 113
      Size.Values = (
        298.979166666666700000
        1955.270833333333000000)
      ExplicitTop = 28
      ExplicitHeight = 113
      object Lb_Emp_Nome: TQRLabel
        Left = 181
        Top = 2
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          5.291666666666667000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'ALESSANDRA CRISTINA DOS SANTOS & CIA LTDA - ME'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_Doc: TQRLabel
        Left = 181
        Top = 20
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          52.916666666666660000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'CNPJ : 04.947.758/0001-92 - IE.: 903.93437-94'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_End: TQRLabel
        Left = 181
        Top = 39
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          103.187500000000000000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 
          'Rua Dr. Levy Buquera, 420 - Sitio Cercado - 81910-190 - Curitiba' +
          ' - PR'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_email: TQRLabel
        Left = 181
        Top = 75
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          198.437500000000000000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'vendas@genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_Fones: TQRLabel
        Left = 181
        Top = 57
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          150.812500000000000000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'TELEVENDAS: (41) 3378-6200 / 3528-2524 / 3379-2580'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Lb_Emp_www: TQRLabel
        Left = 181
        Top = 93
        Width = 498
        Height = 17
        Size.Values = (
          44.979166666666670000
          478.895833333333400000
          246.062500000000000000
          1317.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'www.genioferramentas.com.br'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object Img_Logo: TQRImage
        Left = 36
        Top = 20
        Width = 127
        Height = 73
        Size.Values = (
          193.145833333333300000
          95.250000000000000000
          52.916666666666660000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Stretch = True
      end
    end
    inherited Grp_Cliente: TQRGroup
      Top = 141
      Height = 105
      Size.Values = (
        277.812500000000000000
        1955.270833333333000000)
      ExplicitTop = 141
      ExplicitHeight = 105
      inherited QRShape20: TQRShape
        Top = 21
        Height = 85
        Size.Values = (
          224.895833333333300000
          5.291666666666667000
          55.562500000000000000
          1944.687500000000000000)
        ExplicitTop = 21
        ExplicitHeight = 85
      end
      inherited QRLabel3: TQRLabel
        Top = 23
        Size.Values = (
          44.979166666666670000
          79.375000000000000000
          60.854166666666670000
          142.875000000000000000)
        FontSize = 10
        ExplicitTop = 23
      end
      inherited QRLabel4: TQRLabel
        Top = 39
        Size.Values = (
          44.979166666666670000
          39.687500000000000000
          103.187500000000000000
          182.562500000000000000)
        FontSize = 10
        ExplicitTop = 39
      end
      inherited QRLabel5: TQRLabel
        Top = 71
        Size.Values = (
          44.979166666666670000
          95.250000000000000000
          187.854166666666700000
          127.000000000000000000)
        FontSize = 10
        ExplicitTop = 71
      end
      inherited Lb_CNPJ: TQRLabel
        Top = 87
        Size.Values = (
          44.979166666666670000
          87.312500000000000000
          230.187500000000000000
          134.937500000000000000)
        FontSize = 10
        ExplicitTop = 87
      end
      inherited Lb_Cli_Endereco: TQRLabel
        Top = 39
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          103.187500000000000000
          912.812500000000000000)
        FontSize = 10
        ExplicitTop = 39
      end
      inherited Lb_Cli_Nome: TQRLabel
        Top = 25
        Size.Values = (
          44.979166666666670000
          222.250000000000000000
          66.145833333333340000
          857.250000000000000000)
        FontSize = 10
        ExplicitTop = 25
      end
      inherited Lb_Cli_bairro: TQRLabel
        Top = 71
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          187.854166666666700000
          870.479166666666600000)
        FontSize = 10
        ExplicitTop = 71
      end
      inherited Lb_Cli_Cnpj: TQRLabel
        Top = 87
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          230.187500000000000000
          185.208333333333300000)
        FontSize = 10
        ExplicitTop = 87
      end
      inherited Lb_Cli_Codigo: TQRLabel
        Top = 23
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          60.854166666666670000
          222.250000000000000000)
        FontSize = 10
        ExplicitTop = 23
      end
      inherited Lb_Cli_cep: TQRLabel
        Top = 39
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          103.187500000000000000
          171.979166666666700000)
        FontSize = 10
        ExplicitTop = 39
      end
      inherited Lb_Cli_Cidade: TQRLabel
        Top = 71
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          187.854166666666700000
          269.875000000000000000)
        FontSize = 10
        ExplicitTop = 71
      end
      inherited Lb_Cli_IncEst: TQRLabel
        Top = 87
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          230.187500000000000000
          214.312500000000000000)
        FontSize = 10
        ExplicitTop = 87
      end
      inherited QRLabel7: TQRLabel
        Top = 23
        Size.Values = (
          44.979166666666670000
          1095.375000000000000000
          60.854166666666670000
          142.875000000000000000)
        FontSize = 10
        ExplicitTop = 23
      end
      inherited QRLabel8: TQRLabel
        Top = 39
        Size.Values = (
          44.979166666666670000
          1145.645833333333000000
          103.187500000000000000
          92.604166666666670000)
        FontSize = 10
        ExplicitTop = 39
      end
      inherited QRLabel9: TQRLabel
        Top = 71
        Size.Values = (
          44.979166666666670000
          1092.729166666667000000
          187.854166666666700000
          142.875000000000000000)
        FontSize = 10
        ExplicitTop = 71
      end
      inherited Lb_Ie: TQRLabel
        Top = 87
        Size.Values = (
          44.979166666666670000
          981.604166666666700000
          230.187500000000000000
          254.000000000000000000)
        FontSize = 10
        ExplicitTop = 87
      end
      inherited QRLabel12: TQRLabel
        Top = 39
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          103.187500000000000000
          100.541666666666700000)
        FontSize = 10
        ExplicitTop = 39
      end
      inherited Lb_Cli_FoneC: TQRLabel
        Top = 38
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          100.541666666666700000
          309.562500000000000000)
        FontSize = 10
        ExplicitTop = 38
      end
      inherited QRLabel13: TQRLabel
        Top = 55
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          145.520833333333300000
          76.729166666666670000)
        FontSize = 10
        ExplicitTop = 55
      end
      inherited Lb_Cli_Fax: TQRLabel
        Top = 54
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          142.875000000000000000
          309.562500000000000000)
        FontSize = 10
        ExplicitTop = 54
      end
      inherited QRLabel34: TQRLabel
        Top = 71
        Size.Values = (
          44.979166666666670000
          1529.291666666667000000
          187.854166666666700000
          68.791666666666670000)
        FontSize = 10
        ExplicitTop = 71
      end
      inherited Lb_Cli_Celular: TQRLabel
        Top = 70
        Size.Values = (
          44.979166666666670000
          1629.833333333333000000
          185.208333333333300000
          309.562500000000000000)
        FontSize = 10
        ExplicitTop = 70
      end
      inherited QRLabel10: TQRLabel
        Top = 55
        Size.Values = (
          44.979166666666670000
          47.625000000000000000
          145.520833333333300000
          174.625000000000000000)
        FontSize = 10
        ExplicitTop = 55
      end
      inherited Lb_Cli_Complemento: TQRLabel
        Top = 55
        Size.Values = (
          44.979166666666670000
          230.187500000000000000
          145.520833333333300000
          870.479166666666600000)
        FontSize = 10
        ExplicitTop = 55
      end
      inherited QRLabel14: TQRLabel
        Top = 55
        Size.Values = (
          44.979166666666670000
          1103.312500000000000000
          145.520833333333300000
          132.291666666666700000)
        FontSize = 10
        ExplicitTop = 55
      end
      inherited Lb_Cli_Contato: TQRLabel
        Top = 55
        Size.Values = (
          44.979166666666670000
          1248.833333333333000000
          145.520833333333300000
          269.875000000000000000)
        FontSize = 10
        ExplicitTop = 55
      end
      object Lb_Orcamento: TQRLabel
        Left = 3
        Top = 1
        Width = 345
        Height = 19
        Size.Values = (
          50.270833333333330000
          7.937500000000000000
          2.645833333333333000
          912.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Or'#231'amento N'#176
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object Lb_Data: TQRLabel
        Left = 437
        Top = 1
        Width = 297
        Height = 17
        Size.Values = (
          44.979166666666670000
          1156.229166666667000000
          2.645833333333333000
          785.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Curitiba, 09 de Outubro de 2006'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    inherited StrB_Produto: TQRStringsBand
      Top = 246
      Size.Values = (
        60.854166666666670000
        1955.270833333333000000)
      ExplicitTop = 246
      inherited QRShape15: TQRShape
        Size.Values = (
          60.854166666666680000
          238.125000000000000000
          2.645833333333333000
          1013.354166666667000000)
      end
      inherited QRShape5: TQRShape
        Size.Values = (
          60.854166666666680000
          5.291666666666667000
          2.645833333333333000
          235.479166666666700000)
      end
      inherited QRShape7: TQRShape
        Size.Values = (
          60.854166666666680000
          1391.708333333333000000
          2.645833333333333000
          243.416666666666700000)
      end
      inherited QRShape9: TQRShape
        Size.Values = (
          60.854166666666680000
          1632.479166666667000000
          2.645833333333333000
          317.500000000000000000)
      end
      inherited QRShape10: TQRShape
        Size.Values = (
          60.854166666666680000
          1248.833333333333000000
          2.645833333333333000
          145.520833333333300000)
      end
      inherited Lb_SubVl_Pro: TQRLabel
        Size.Values = (
          44.979166666666670000
          1648.354166666667000000
          10.583333333333330000
          283.104166666666700000)
        FontSize = 10
      end
      inherited Lb_VlUnit_Pro: TQRLabel
        Size.Values = (
          44.979166666666670000
          1415.520833333333000000
          10.583333333333330000
          206.375000000000000000)
        FontSize = 10
      end
      inherited Lb_Qtde_Pro: TQRLabel
        Size.Values = (
          44.979166666666670000
          1272.645833333333000000
          10.583333333333330000
          111.125000000000000000)
        FontSize = 10
      end
      inherited Lb_Codigo_Pro: TQRLabel
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          10.583333333333330000
          216.958333333333400000)
        FontSize = 10
      end
      inherited Lb_Descricao_Pro: TQRLabel
        Size.Values = (
          44.979166666666670000
          246.062500000000000000
          10.583333333333330000
          976.312500000000000000)
        FontSize = 10
      end
    end
  end
  inherited Qr_Pedido: TSTQuery
    SQL.Strings = (
      'SELECT '
      'EMP_NOME,'
      'ctc_codemp,'
      'END_ENDER,'
      'END_NUMERO,'
      'END_COMPLEM,'
      'END_CONTATO,'
      'END_CEP,'
      'END_FONE,'
      'END_BAIRRO,'
      'CDD_DESCRICAO,'
      'END_FAX,'
      'EMP_CNPJ,'
      'EMP_INSC_EST,'
      'END_CELULAR,'
      'FPT_DESCRICAO,'
      'CTC_PRAZO PRAZO,'
      'CTC_OBS OBS,'
      'CLB_NOME,'
      'CTC_NUMERO,'
      'CTC_DATA,'
      'UFE_SIGLA ,'
      'CTC_VL_DESCONTO'
      ''
      'FROM TB_COTACAO ctc'
      '   INNER JOIN TB_EMPRESA emp'
      '  ON (emp.EMP_CODIGO = ctc.CTC_CODEMP)'
      ''
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = emp.EMP_CODIGO)'
      ''
      '  INNER JOIN tb_cidade tb_cidade'
      '  ON (tb_cidade.cdd_codigo = tb_endereco.end_codcdd)'
      ''
      '  INNER JOIN tb_uf tb_uf'
      '  ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      ''
      '  INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '  ON (tb_formapagto.FPT_CODIGO = ctc.CTC_CODFPG)'
      ''
      '  INNER JOIN TB_COLABORADOR tb_colaborador'
      '  ON (tb_colaborador.CLB_CODIGO = ctc.CTC_CODVDO)'
      ''
      'WHERE(CTC_CODPED =:PED_CODIGO)')
    Top = 8
  end
  inherited Qr_ItensPro: TSTQuery
    Left = 377
    Top = 8
  end
  object Qr_Cliente: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT  EMP_NOME, EMP_FANTASIA, EMP_CODIGO, END_ENDER, END_CEP, ' +
        'END_FONE,  END_BAIRRO, END_CELULAR, CDD_DESCRICAO,UFE_SIGLA,END_' +
        'FAX,EMP_CNPJ, EMP_INSC_EST, EMP_EMAIL,END_NUMERO'
      'FROM  TB_EMPRESA tb_empresa'
      '         INNER JOIN TB_ENDERECO tb_endereco'
      '         ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '         INNER JOIN TB_CIDADE'
      '         ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '        ON (tb_uf.UFE_CODIGO = TB_ENDERECO.END_CODUFE)'
      'WHERE (EMP_CODIGO=:EMP_CODIGO) ')
    Left = 448
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end

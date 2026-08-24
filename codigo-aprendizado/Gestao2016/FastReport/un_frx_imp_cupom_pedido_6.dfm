inherited FrxImpCupomPedido6: TFrxImpCupomPedido6
  Caption = 'Modelo Cupom - 6'
  ClientWidth = 299
  ExplicitWidth = 315
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 45008.431026666670000000
    Datasets = <
      item
        DataSet = frxDataItens
        DataSetName = 'frxDataItens'
      end
      item
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
      end>
    Variables = <
      item
        Name = ' CabecalhoEmpresa'
        Value = Null
      end
      item
        Name = 'NomeFantasia'
        Value = Null
      end
      item
        Name = 'DocFiscal'
        Value = Null
      end
      item
        Name = 'Endereco'
        Value = Null
      end
      item
        Name = 'Fones'
        Value = Null
      end
      item
        Name = 'email'
        Value = Null
      end
      item
        Name = 'website'
        Value = Null
      end
      item
        Name = 'Titulo'
        Value = Null
      end
      item
        Name = ' Footer'
        Value = Null
      end
      item
        Name = 'SumProduct'
        Value = Null
      end
      item
        Name = 'SumService'
        Value = Null
      end
      item
        Name = ' General'
        Value = Null
      end
      item
        Name = 'StrConnection'
        Value = Null
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 200.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      EndlessHeight = True
      inherited PageHeader1: TfrxPageHeader
        Height = 266.448980000000000000
        Width = 287.244280000000000000
        inherited lbTitulo: TfrxMemoView
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[Titulo]')
        end
        inherited Logo: TfrxPictureView
          Visible = False
        end
        inherited lbDocFiscal: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[DocFiscal]')
        end
        inherited lbEndereco: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[Endereco]')
        end
        inherited lbFones: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[Fones]')
        end
        inherited lbWebSites: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[website]')
        end
        inherited lbemail: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[email]')
        end
        inherited lbNomeFantasia: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
        object Memo3: TfrxMemoView
          Top = 132.283550000000000000
          Width = 52.913385826771700000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 148.181200000000000000
          Width = 52.913385826771700000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 162.519790000000000000
          Width = 52.913385826771700000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FONES:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 177.637910000000000000
          Width = 52.913385826771700000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CPF:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 55.031540000000000000
          Top = 132.283550000000000000
          Width = 64.251829370000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_NUMERO"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baWidth
          Left = 52.913385826771700000
          Top = 148.181200000000000000
          Width = 234.330894173228300000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_FANTASIA"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baWidth
          Left = 52.913385826771700000
          Top = 162.519790000000000000
          Width = 234.330894173228300000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."END_FONE"] / [frxDBaseReport."END_CELULAR"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baWidth
          Left = 52.913385826771700000
          Top = 177.637910000000000000
          Width = 234.330894173228300000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_CNPJ"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 128.504381260000000000
          Top = 132.435683330000000000
          Width = 37.795119370000000000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 166.299500630000000000
          Top = 132.283550000000000000
          Width = 120.944779370000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."DATA"] [Time]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 194.315090000000000000
          Width = 287.244280000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo13: TfrxMemoView
          Top = 196.535560000000000000
          Width = 64.251975830000000000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENDERE'#199'O:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baWidth
          Top = 209.653680000000000000
          Width = 287.244280000000000000
          Height = 26.456692910000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBaseReport."END_ENDER"] , [frxDBaseReport."END_NUMERO"]  [f' +
              'rxDBaseReport."END_COMPLEM"] - [frxDBaseReport."END_BAIRRO"] - [' +
              'frxDBaseReport."CDD_DESCRICAO"] - [frxDBaseReport."UFE_SIGLA"]  ' +
              '- CEP: [frxDBaseReport."END_CEP"]')
          ParentFont = False
          WordBreak = True
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 238.110390000000000000
          Width = 287.244280000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Top = 239.110390000000000000
          Width = 170.078815830000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o dos Produtos')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 0.307050000000000000
          Top = 253.228346460000000000
          Width = 41.574795830000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 44.795300000000000000
          Top = 253.228346460000000000
          Width = 75.590565830000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Unit'#225'rio')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 204.094654170000000000
          Top = 253.228346460000000000
          Width = 83.149625830000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Sub-Total')
          ParentFont = False
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 589.606680000000000000
        Width = 287.244280000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220470000000010000
          Memo.UTF8W = (
            'Pagina N'#186)
        end
        inherited Memo42: TfrxMemoView
          Memo.UTF8W = (
            'Relat'#243'rio emitido em:')
        end
        inherited Memo1: TfrxMemoView
          Memo.UTF8W = (
            '[<Date>]  [<Time>]')
          Formats = <
            item
              Kind = fkDateTime
            end
            item
            end>
        end
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            '[Page]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 347.716760000000000000
        Width = 287.244280000000000000
        DataSet = frxDataItens
        DataSetName = 'frxDataItens'
        RowCount = 0
        object Memo19: TfrxMemoView
          Align = baWidth
          Top = 1.000000000000000000
          Width = 287.244280000000000000
          Height = 13.220470000000000000
          DataField = 'PRO_DESCRICAO'
          DataSet = frxDataItens
          DataSetName = 'frxDataItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataItens."PRO_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 2.086580000000000000
          Top = 15.117956460000000000
          Width = 41.574795830000000000
          Height = 13.220470000000000000
          DataField = 'ITF_QTDE'
          DataSet = frxDataItens
          DataSetName = 'frxDataItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataItens."ITF_QTDE"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 46.574830000000000000
          Top = 15.117956460000000000
          Width = 75.590565830000000000
          Height = 13.220470000000000000
          DataSet = frxDataItens
          DataSetName = 'frxDataItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataItens."ITF_VL_UNIT"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baRight
          Left = 211.653714170000000000
          Top = 15.117956460000000000
          Width = 75.590565830000000000
          Height = 13.220470000000000000
          DataSet = frxDataItens
          DataSetName = 'frxDataItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataItens."ITF_VL_SUBTOTAL"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 438.425480000000000000
        Width = 287.244280000000000000
        Stretched = True
        object Memo23: TfrxMemoView
          Top = 4.000000000000000000
          Width = 181.417405830000000000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral do Cupom')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 204.094654170000000000
          Top = 4.000000000000000000
          Width = 83.149625830000000000
          Height = 13.220470000000000000
          AutoWidth = True
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_PEDIDO"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 1.000000000000000000
          Width = 287.244280000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo24: TfrxMemoView
          Top = 19.118120000000000000
          Width = 60.472445830000000000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baWidth
          Left = 60.472445830000000000
          Top = 19.118120000000000000
          Width = 226.771834170000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CLB_NOME"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Top = 34.236240000000000000
          Width = 71.811035830000000000
          Height = 13.220470000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baWidth
          Top = 49.354360000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_OBS"]')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      'SELECT '
      ' PED_CODIGO, '
      ' EMP_FANTASIA, '
      ' EMP_CODIGO, '
      ' EMP_PESSOA, '
      ' EMP_CNPJ, '
      ' EMP_INSC_EST, '
      ' EMP_NOME, '
      ' PED_CODEMP, '
      ' PED_NUMERO, '
      ' EMP_TIPO, '
      ' PED_DATA DATA, '
      ' PED_QT_PRODUTO, '
      ' PED_OBS, '
      ' PED_VL_FRETE, '
      ' PED_VL_DESCONTO, '
      ' PED_VL_PEDIDO, '
      ' PED_PRAZO, '
      ' PED_VL_PRODUTO, '
      ' PED_VL_ODESPESA, '
      ' PED_VL_ST, '
      ' CLB_NOME, '
      ' FPT_DESCRICAO, '
      ' EMP_CODVDOR, '
      ' END_ENDER, '
      ' END_NUMERO, '
      ' END_COMPLEM, '
      ' END_BAIRRO, '
      ' CDD_DESCRICAO, '
      ' UFE_SIGLA, '
      ' END_CEP, '
      ' END_FONE, '
      ' END_FAX, '
      ' END_CONTATO, '
      ' END_CELULAR, '
      ' EMP_EMAIL, '
      ' PED_ENTREGA, '
      ' PED_GARANTIA, '
      ' PED_VL_CREDITO, '
      ' PED_DT_ALTERA, '
      ' PED_VL_SERVICO, '
      ' PED_TIPO, '
      ' VALUE_RECIVED, '
      ' VALUE_CHANGE, '
      ' PED_INDPRES '
      ' FROM TB_PEDIDO tb_pedido '
      '   INNER JOIN TB_EMPRESA tb_empresa ON '
      '   tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP '
      '   INNER JOIN TB_ENDERECO tb_endereco '
      '   on (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '
      '   INNER JOIN TB_CIDADE tb_cidade ON '
      '   (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '
      '   INNER JOIN TB_UF tb_uf '
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '
      '   LEFT OUTER JOIN TB_FORMAPAGTO tb_formapagto ON '
      '   (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG) '
      '   LEFT OUTER JOIN TB_COLABORADOR tb_colaborador ON '
      '   (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) '
      '   LEFT OUTER JOIN TB_COTACAO tb_cotacao ON '
      '   (tb_cotacao.CTC_CODPED = tb_pedido.PED_CODIGO) '
      '   left outer join TB_RESTAURANTE '
      '   ON (TB_PEDIDO_ID = PED_CODIGO)'
      ' WHERE(PED_CODIGO =:PED_CODIGO) ')
    ParamData = <
      item
        DataType = ftWideString
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Value = '0'
      end>
  end
  object frxDataItens: TfrxDBDataset
    UserName = 'frxDataItens'
    CloseDataSource = False
    DataSet = Qr_Itens
    BCDToCurrency = False
    Left = 112
    Top = 64
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT ITF_CODIGO, ITF_CODPED, ITF_CODNFL, ITF_CODPRO, PRO_CODIG' +
        'OFAB,PRO_CODIGO, PRO_DESCRICAO, '
      
        'ITF_QTDE, ITF_VL_CUSTO, PRO_SUB_TRIB, ITF_VL_UNIT, ITF_AQ_COM, M' +
        'ED_ABREVIATURA,MRC_DESCRICAO, '
      
        'PRO_CODIGOFOR, ITF_VL_DESC, (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBT' +
        'OTAL, '
      
        '((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_VL_SUBTOTAL_CD,PRO_' +
        'LOCAL,ita.iav_descricao '
      'FROM  TB_ITENS_NFL it '
      'INNER JOIN TB_PRODUTO pr ON pr.PRO_CODIGO = it.ITF_CODPRO '
      'INNER JOIN TB_MEDIDA me   ON  (me.MED_CODIGO = pr.PRO_CODMED) '
      
        'INNER JOIN TB_MARCA_PRODUTO ma   ON  (ma.MRC_CODIGO = pr.PRO_COD' +
        'MRC) '
      
        'LEFT OUTER JOIN tb_itens_avl ita on ita.iav_coditf = it.itf_codi' +
        'go '
      'WHERE it.ITF_CODPED =:PED_CODIGO AND pr.PRO_TIPO <> '#39'S'#39)
    Left = 200
    Top = 72
    ParamData = <
      item
        DataType = ftWideString
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
        Value = '0'
      end>
  end
end

inherited FrxReportGerencialNfeSebrae: TFrxReportGerencialNfeSebrae
  Caption = 'Relat'#243'rio Nfe - Gerencial Sebrae'
  ClientWidth = 274
  ExplicitWidth = 290
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 44372.646774930550000000
    ScriptText.Strings = (
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  GroupFooter1.visible := (<frxDBaseReport."NFE_CODSIT"> = 2);  ' +
        '                                                                ' +
        '    '
      'end;'
      ''
      'begin'
      'end.')
    Datasets = <
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
        Name = 'ValoTotalCofins'
        Value = ''
      end
      item
        Name = 'ValoTotalII'
        Value = ''
      end
      item
        Name = 'ValorTotalPisST'
        Value = ''
      end
      item
        Name = 'ValorTotalPis'
        Value = ''
      end
      item
        Name = 'ValorTotalCofinsST'
        Value = ''
      end
      item
        Name = 'ValorTotalDesconto'
        Value = ''
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      inherited PageHeader1: TfrxPageHeader
        Width = 1046.929810000000000000
        inherited lbTitulo: TfrxMemoView
          Width = 1046.929810000000000000
          Memo.UTF8W = (
            '[Titulo]')
        end
        inherited lbDocFiscal: TfrxMemoView
          Memo.UTF8W = (
            '[DocFiscal]')
        end
        inherited lbEndereco: TfrxMemoView
          Memo.UTF8W = (
            '[Endereco]')
        end
        inherited lbFones: TfrxMemoView
          Memo.UTF8W = (
            '[Fones]')
        end
        inherited lbWebSites: TfrxMemoView
          Memo.UTF8W = (
            '[website]')
        end
        inherited lbemail: TfrxMemoView
          Memo.UTF8W = (
            '[email]')
        end
        inherited lbNomeFantasia: TfrxMemoView
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 453.543600000000000000
        Width = 1046.929810000000000000
        inherited Memo41: TfrxMemoView
          Left = 879.968460000000000000
          Top = 2.220470000000000000
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
            end
            item
              Kind = fkDateTime
            end
            item
            end>
        end
        inherited Memo2: TfrxMemoView
          Left = 952.441560000000000000
          Memo.UTF8W = (
            '[Page]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 207.874150000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBaseReport."NFE_CODSIT"'
        object frxDBaseReportNFE_CODSIT: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[IIF(<frxDBaseReport."NFE_CODSIT"> =2,'#39'AUTORIZADO'#39','#39'CANCELADO'#39')]')
        end
        object Memo3: TfrxMemoView
          Top = 22.677180000000000000
          Width = 62.740157480000000000
          Height = 13.228346456692900000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#218'MERO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 65.149660000000000000
          Top = 22.677180000000000000
          Width = 36.283464566929100000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'S'#201'RIE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 104.692913385827000000
          Top = 22.677180000000000000
          Width = 85.417322830000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA EMISS'#195'O')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 192.755905511811000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTOS')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 260.031496060000000000
          Top = 22.677180000000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS ST')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 326.173228350000000000
          Top = 22.677180000000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FRETE')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 392.314960629921000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SEGURO')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 458.834645669291000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'IPI')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 526.110236220472000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS DESP')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 593.007874015748000000
          Top = 22.677180000000000000
          Width = 77.858267716535400000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 673.889763779528000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL NFE')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 740.787401574803000000
          Top = 22.677180000000000000
          Width = 77.858267716535400000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'BASE ICMS')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 820.157480314961000000
          Top = 22.677180000000000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 888.188976380000000000
          Top = 22.677180000000000000
          Width = 58.960629920000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MODELO')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 948.661417320000000000
          Top = 22.677180000000000000
          Width = 58.960629920000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 272.126160000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object frxDBaseReportNFL_NUMERO: TfrxMemoView
          Width = 62.740157480000000000
          Height = 13.228346460000000000
          DataField = 'NFL_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_NUMERO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 64.252010000000000000
          Width = 36.283464570000000000
          Height = 13.228346460000000000
          DataField = 'NFL_SERIE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_SERIE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 104.692913390000000000
          Width = 85.417322830000000000
          Height = 13.228346460000000000
          DataField = 'NFL_DT_EMISSAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_DT_EMISSAO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 192.755905510000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_TL_PROD'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_TL_PROD"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 260.031496060000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_ICMS_SUBST'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_ICMS_SUBST"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 326.173228350000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_FRETE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_FRETE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 392.314960630000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_SEGURO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 458.834645670000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_IPI'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_IPI"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 526.110236220472000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_DESP_ACESS'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_DESP_ACESS"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 593.007874020000000000
          Width = 77.858267720000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_DESCONTO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_DESCONTO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 673.889763779528000000
          Width = 64.251968503937000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_TL_NOTA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_TL_NOTA"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 740.787401570000000000
          Width = 77.858267720000000000
          Height = 13.228346460000000000
          DataField = 'NFL_BS_ICMS'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_BS_ICMS"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 820.157480310000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataField = 'NFL_VL_ICMS'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_VL_ICMS"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 888.188976380000000000
          Width = 58.960629920000000000
          Height = 13.228346460000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_MODELO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 948.661417320000000000
          Width = 58.960629920000000000
          Height = 13.228346460000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_TIPO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 317.480520000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo32: TfrxMemoView
          Left = 3.779530000000000000
          Width = 132.283508500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO ICMS:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO ICMS ST:')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236240000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO FRETE:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.354360000000000000
          Width = 132.283508500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO NFE:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 162.519790000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_ICMS">,MasterData1)]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 162.519790000000000000
          Top = 15.118120000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_ICMS_SUBST">,MasterData1)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 162.519790000000000000
          Top = 30.236240000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_FRETE">,MasterData1)]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 162.519790000000000000
          Top = 45.354360000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_TL_NOTA">,MasterData1)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 270.244280000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DESCONTO:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 270.244280000000000000
          Top = 15.118120000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO IMP IMP:')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 270.244280000000000000
          Top = 30.236240000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL DO IPI:')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 428.984540000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotalDesconto]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 428.984540000000000000
          Top = 15.118120000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValoTotalII]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 428.984540000000000000
          Top = 30.236240000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_IPI">,MasterData1)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 534.811380000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL COFINS:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 534.811380000000000000
          Top = 15.118120000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL PIS ST')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 534.811380000000000000
          Top = 30.236240000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL COFINS ST:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 693.551640000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValoTotalCofins]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 693.551640000000000000
          Top = 15.118120000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotalPisST]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 693.551640000000000000
          Top = 30.236240000000000000
          Width = 83.149606300000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotalCofinsST]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 800.921770000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL SEGURO:')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 800.921770000000000000
          Top = 15.118120000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL PIS:')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 800.921770000000000000
          Top = 30.236240000000000000
          Width = 154.960688500000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL ISSQN:')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 959.662030000000000000
          Width = 83.149598980000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_SEGURO">,MasterData1)]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 959.662030000000000000
          Top = 15.118120000000000000
          Width = 83.149598980000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotalPis]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 959.662030000000000000
          Top = 30.236240000000000000
          Width = 83.149598980000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."NFL_VL_TL_SRV">,MasterData1)]')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    SQL.Strings = (
      
        'SELECT NF.nfl_numero, NF.nfl_serie, NF.nfl_dt_emissao, NF.nfl_vl' +
        '_tl_prod, NF.nfl_vl_icms_subst, NF.nfl_vl_frete, NF.nfl_vl_segur' +
        'o, NF.nfl_vl_ipi, NF.nfl_vl_desp_acess,'
      
        '0 NFL_VL_DESCONTO, NF.nfl_vl_tl_nota, NF.nfl_bs_icms, NF.nfl_vl_' +
        'icms, NF.nfl_tipo, nfe.nfe_codsit, nfe.nfe_motivo, nf.nfl_vl_tl_' +
        'srv, NFL_MODELO'
      'FROM tb_nota_fiscal NF'
      '   INNER JOIN tb_retorno_nfe nfe'
      '   on (nfe.nfe_codnfl = nf.nfl_codigo)'
      'where nfe.nfe_codsit>1'
      'AND NFL_DT_EMISSAO BETWEEN '#39'03/01/2000'#39' AND '#39'03/31/2021'#39
      'order by nfe.nfe_codsit, nf.nfl_numero')
  end
end

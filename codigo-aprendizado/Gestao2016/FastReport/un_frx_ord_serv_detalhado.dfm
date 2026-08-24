inherited FrxOrdServDetalhado: TFrxOrdServDetalhado
  Caption = 'Relat'#243'rio de Servi'#231'os Prestados'
  ClientWidth = 321
  ExplicitWidth = 337
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43109.371149791710000000
    ScriptText.Strings = (
      'var'
      '  subtotalPeca : Real;'
      '  subtotalServ  :Real;'
      '  totalPeca : Real;'
      '  totalServ  :Real;'
      '      '
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  subtotalPeca := 0;         '
      '  subtotalServ := 0;'
      'end;'
      ''
      '                                               '
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDBaseReport."PRO_TIPO"> = '#39'P'#39' ) THEN'
      '  Begin              '
      
        '    subtotalPeca := subtotalPeca + (<frxDBaseReport."ITF_QTDE"> ' +
        '* <frxDBaseReport."ITF_VL_UNIT">);  '
      
        '    totalPeca    := totalPeca + (<frxDBaseReport."ITF_QTDE"> * <' +
        'frxDBaseReport."ITF_VL_UNIT">);          '
      '  end                '
      '  else'
      '  Begin              '
      
        '    subtotalServ := subtotalServ + (<frxDBaseReport."ITF_QTDE"> ' +
        '* <frxDBaseReport."ITF_VL_UNIT">);  '
      
        '    totalServ    := totalServ + (<frxDBaseReport."ITF_QTDE"> * <' +
        'frxDBaseReport."ITF_VL_UNIT">);          '
      '  end;              '
      'end;'
      '  '
      'procedure Page1OnBeforePrint_inherited(Sender: TfrxComponent);'
      'begin'
      '  totalPeca := 0;         '
      '  totalServ := 0;  '
      'end;'
      ''
      'Begin'
      '  '
      'end.          '
      '    ')
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
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      BackPictureVisible = False
      OnBeforePrint = 'Page1OnBeforePrint_inherited'
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
        Top = 600.945270000000000000
        Width = 1046.929810000000000000
        inherited Memo41: TfrxMemoView
          Left = 929.102350000000000000
          Top = 2.220469999999978000
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
        object Memo44: TfrxMemoView
          Left = 254.008040000000000000
          Top = 2.000000000000000000
          Width = 102.015770000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 61.000000000000000000
        Top = 207.874150000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxDBaseReport."PED_CODIGO"'
        object Memo3: TfrxMemoView
          Left = 168.000000000000000000
          Top = 42.000000000000000000
          Width = 63.000000000000000000
          Height = 19.000000000000000000
          DataField = 'VEI_PLACA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."VEI_PLACA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 297.000000000000000000
          Top = 42.000000000000000000
          Width = 61.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."KM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 76.000000000000000000
          Top = 42.000000000000000000
          Width = 91.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PED_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_NUMERO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 4.000000000000000000
          Top = 42.000000000000000000
          Width = 69.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DATA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."DATA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 233.000000000000000000
          Top = 42.000000000000000000
          Width = 62.000000000000000000
          Height = 19.000000000000000000
          DataField = 'VEI_FROTA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."VEI_FROTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 631.000000000000000000
          Top = 43.000000000000000000
          Width = 219.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O DAS PECAS E SERVI'#199'OS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 852.000000000000000000
          Top = 43.000000000000000000
          Width = 49.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 968.000000000000000000
          Top = 43.000000000000000000
          Width = 75.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SUBTOTAL')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 903.000000000000000000
          Top = 43.000000000000000000
          Width = 63.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VL. UNIT.')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 548.000000000000000000
          Top = 43.000000000000000000
          Width = 52.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD.')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 4.000000000000000000
          Top = 21.000000000000000000
          Width = 69.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 76.000000000000000000
          Top = 21.000000000000000000
          Width = 91.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186' ORDEM')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 168.000000000000000000
          Top = 21.000000000000000000
          Width = 63.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PLACA')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 297.000000000000000000
          Top = 21.000000000000000000
          Width = 65.779530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OD'#212'METRO')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 233.000000000000000000
          Top = 21.000000000000000000
          Width = 62.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FROTA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 363.000000000000000000
          Top = 21.000000000000000000
          Width = 84.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 450.000000000000000000
          Top = 21.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MODELO')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 450.000000000000000000
          Top = 42.000000000000000000
          Width = 97.000000000000000000
          Height = 17.000000000000000000
          DataField = 'MOD_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MOD_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 363.000000000000000000
          Top = 42.000000000000000000
          Width = 84.000000000000000000
          Height = 17.000000000000000000
          DataField = 'MRC_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MRC_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 602.000000000000000000
          Top = 43.000000000000000000
          Width = 33.559060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TIPO')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 4.000000000000000000
          Top = 3.000000000000000000
          Width = 57.338590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 68.000000000000000000
          Top = 2.000000000000000000
          Width = 621.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_NOME"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object Memo25: TfrxMemoView
          Left = 629.031850000000000000
          Top = 3.779530000000022000
          Width = 219.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PRO_DESCRICAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 903.031850000000000000
          Top = 3.779530000000022000
          Width = 63.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."ITF_VL_UNIT"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 852.031850000000000000
          Top = 3.779530000000022000
          Width = 49.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."ITF_QTDE"]')
          ParentFont = False
        end
        object m_subtotal: TfrxMemoView
          Left = 968.031850000000000000
          Top = 3.779530000000022000
          Width = 75.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."ITF_VL_SUBTOTAL"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 548.031850000000000000
          Top = 3.779530000000022000
          Width = 52.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PRO_CODIGOFAB'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_CODIGOFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object m_Tipo: TfrxMemoView
          Left = 602.031850000000000000
          Top = 3.779530000000022000
          Width = 26.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PRO_TIPO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_TIPO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 112.000000000000000000
        Top = 336.378170000000000000
        Width = 1046.929810000000000000
        object Memo31: TfrxMemoView
          Left = 4.000000000000000000
          Top = 2.000000000000000000
          Width = 95.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PE'#199'AS/VEICULO')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 4.000000000000000000
          Top = 20.000000000000000000
          Width = 95.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'M.O./VEICULO')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 4.000000000000000000
          Top = 38.000000000000000000
          Width = 95.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL/VEICULO')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 102.000000000000000000
          Top = 20.000000000000000000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[subtotalServ]')
          ParentFont = False
        end
        object E_Sub: TfrxMemoView
          Left = 102.000000000000000000
          Top = 2.000000000000000000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[subtotalPeca]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 102.000000000000000000
          Top = 38.173228349999990000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."ITF_VL_SUBTOTAL">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 104.811070000000000000
          Top = 57.000000000000000000
          Width = 931.409400000000000000
          Height = 46.440940000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."OBS"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 4.000000000000000000
          Top = 57.000000000000000000
          Width = 97.811070000000000000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#227'o:')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 510.236550000000000000
        Width = 1046.929810000000000000
        object Memo28: TfrxMemoView
          Left = 7.559060000000000000
          Top = 39.779529999999970000
          Width = 95.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL/VEICULO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 105.559060000000000000
          Top = 21.779529999999960000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[totalServ]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 105.559060000000000000
          Top = 3.779529999999965000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[totalPeca]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 105.559060000000000000
          Top = 39.952758350000010000
          Width = 81.000000000000000000
          Height = 15.874015750000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBaseReport."ITF_VL_SUBTOTAL">,MasterData1)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      'SELECT PED_DATA AS DATA , PED_CODIGO, PED_NUMERO,'
      
        'PRO_TIPO, PRO_DESCRICAO, ITF_QTDE, ITF_VL_UNIT, (ITF_QTDE *  ITF' +
        '_VL_UNIT) AS ITF_VL_SUBTOTAL,'
      
        'EMP_NOME, VEI_FROTA, VEI_PLACA, vck.km, OS.obs, MRC_DESCRICAO, M' +
        'OD_DESCRICAO,'
      'ITF_CODIGO, PRO_CODIGOFAB'
      'FROM TB_PEDIDO tb_pedido'
      'INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal'
      'ON  (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO)'
      'INNER JOIN TB_EMPRESA tb_empresa'
      'ON  (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      'INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      'ON  (tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO )'
      'INNER JOIN TB_PRODUTO Tb_produto'
      'ON  (Tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      'INNER JOIN TB_VEHICLE_SO OS'
      'ON  (OS.TB_ORDER_ID = tb_pedido.PED_CODIGO)'
      'INNER JOIN TB_VEICULO Tb_veiculo'
      'ON  (TB_VEICULO.VEI_PLACA = OS.TB_VEHICLE_ID )'
      'INNER JOIN TB_MARCA_VEICULO tb_marca_veiculo'
      'ON  (tb_marca_veiculo.MRC_CODIGO = Tb_veiculo.VEI_CODMRC)'
      'INNER JOIN TB_MODELO tb_modelo'
      'ON  (tb_modelo.MOD_CODIGO = Tb_veiculo.VEI_CODMOD)'
      'left outer join TB_VEHICLE_CHECKLIST vck'
      'on (vck.TB_ORDER_ID = OS.TB_ORDER_ID)'
      'WHERE (PED_CODIGO IS NOT NULL) AND (NFL_STATUS = '#39'F'#39')'
      'AND (PED_TIPO = 1)')
  end
end

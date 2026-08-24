inherited Frx_Recibo: TFrx_Recibo
  Caption = 'Recibo'
  ExplicitWidth = 391
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 45377.422497835650000000
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
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      inherited PageHeader1: TfrxPageHeader
        Height = 189.472480000000000000
        Width = 287.244280000000000000
        Stretched = True
        inherited lbTitulo: TfrxMemoView
          Width = 287.244280000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[Titulo]')
        end
        inherited Logo: TfrxPictureView
          Width = 2.598330000000000000
          Height = 13.291280000000000000
          Visible = False
          Visibility = [vsPreview, vsExport]
          Stretched = False
        end
        inherited lbDocFiscal: TfrxMemoView
          Left = 0.000000000000000000
          Top = 16.220470000000000000
          Width = 285.504020000000000000
          Memo.UTF8W = (
            '[DocFiscal]')
        end
        inherited lbEndereco: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Top = 35.220470000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[Endereco]')
          WordBreak = True
        end
        inherited lbFones: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Top = 53.220470000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[Fones]')
        end
        inherited lbWebSites: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Top = 89.220470000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[website]')
        end
        inherited lbemail: TfrxMemoView
          Align = baWidth
          Left = 0.000000000000000000
          Top = 71.220470000000000000
          Width = 287.244280000000000000
          Memo.UTF8W = (
            '[email]')
        end
        inherited lbNomeFantasia: TfrxMemoView
          Left = 2.039270000000000000
          Width = 285.205010000000000000
          HAlign = haBlock
          Memo.UTF8W = (
            '[NomeFantasia]')
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 136.063080000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 68.031540000000000000
          Top = 136.063080000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[NUMERO]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baWidth
          Top = 170.078850000000000000
          Width = 287.244280000000000000
          Height = 19.393630000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          HAlign = haBlock
          Memo.UTF8W = (
            '[DETALHE]')
          ParentFont = False
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Height = 49.236240000000000000
        Top = 268.346630000000000000
        Width = 287.244280000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220470000000010000
          Memo.UTF8W = (
            'Pagina N'#186)
        end
        inherited Memo42: TfrxMemoView
          Left = 257.228510000000000000
          Top = 28.456710000000000000
          Width = 10.495980000000000000
          Visible = False
          Memo.UTF8W = (
            'Relat'#243'rio emitido em:')
        end
        inherited Memo1: TfrxMemoView
          Left = 272.126160000000000000
          Top = 26.456710000000000000
          Width = 7.559060000000000000
          Visible = False
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
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
            item
              Kind = fkDateTime
            end
            item
            end
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
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo6: TfrxMemoView
          Align = baWidth
          Top = 26.456710000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          Memo.UTF8W = (
            '[LOCAL_DATA]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 596.503710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.BottomLine.Width = 2.000000000000000000
          Memo.UTF8W = (
            '[SACADO]')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    SQL.Strings = (
      'SELECT * '
      'FROM tb_recibo  '
      'WHERE   REC_CODIGO = :REC_CODIGO')
    ParamData = <
      item
        DataType = ftWideString
        Name = 'REC_CODIGO'
        ParamType = ptUnknown
        Value = '9'
      end>
  end
end

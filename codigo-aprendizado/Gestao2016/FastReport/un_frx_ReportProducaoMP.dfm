inherited frx_ReportProducaoMP: Tfrx_ReportProducaoMP
  Caption = 'Relatorio de Produ'#231#227'o - MP'
  ClientHeight = 182
  ClientWidth = 330
  ExplicitWidth = 346
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 45571.583680162040000000
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
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        inherited lbTitulo: TfrxMemoView
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
        Top = 393.071120000000000000
        inherited Memo41: TfrxMemoView
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
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 309.921460000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object Memo3: TfrxMemoView
          Left = 504.425480000000000000
          Top = 1.889765000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'CLT_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."CLT_NUMERO"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 605.504330000000000000
          Top = 1.889765000000011000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataField = 'CLT_DT_VENCIMENTO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."CLT_DT_VENCIMENTO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 400.630180000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'CONSTOTAL'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReport."CONSTOTAL"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 389.291590000000000000
          Height = 18.897650000000000000
          DataField = 'MP'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MP"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 55.000000000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o do Mat'#233'ria Prima')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 400.630180000000000000
          Top = 55.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Consumo')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 502.677490000000000000
          Top = 55.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 604.724800000000000000
          Top = 55.000000000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Vencimento')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 204.874150000000000000
          Top = 28.354359999999980000
          Width = 510.236550000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PA"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 4.779529999999999000
          Top = 28.354359999999980000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto Produzido :')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 140.842610000000000000
          Top = 28.354359999999980000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."PRO_CODIGO"]')
        end
        object Line1: TfrxLineView
          Top = 52.133890000000060000
          Width = 714.331170000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 4.559059999999999000
          Top = 3.779529999999994000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data da Produ'#231#227'o :')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 142.960730000000000000
          Top = 3.779529999999994000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."ORP_DTCAD"]')
        end
        object Memo14: TfrxMemoView
          Left = 276.685220000000000000
          Top = 3.779529999999994000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero do Lote :')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 415.086890000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[frxDBaseReport."ORP_NUMERO"]')
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      'SELECT'
      'op.orp_numero,'
      'op.orp_dtcad,'
      'pa.pro_codigo,'
      'pa.pro_descricao'
      'PA, mp.pro_descricao MP,'
      'ml.mlt_qtde ConsTotal,'
      'cl.clt_numero, cl.clt_dt_vencimento'
      'FROM TB_ORPPREV opp'
      '    inner join tb_orp op  on (op.orp_codigo = opp.pre_codorp)'
      
        '    inner join tb_produto mp  on (mp.pro_codigo = opp.pre_codpro' +
        ')'
      '    inner join tb_produto pa  on (pa.pro_codigo = op.orp_codpro)'
      
        '    inner join tb_movimento_lote ml  on ( opp.pre_codigo = ml.ml' +
        't_codvcl )'
      
        '    inner join tb_ctrl_lote cl  on (cl.clt_codigo = ml.mlt_codcl' +
        't)'
      'WHERE opp.PRE_CODORP =:PRE_CODORP'
      'order by MP')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRE_CODORP'
        ParamType = ptUnknown
      end>
    object Qr_ConsultaPA: TStringField
      FieldName = 'PA'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ConsultaMP: TStringField
      FieldName = 'MP'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ConsultaCLT_NUMERO: TStringField
      FieldName = 'CLT_NUMERO'
      Origin = '"TB_CTRL_LOTE"."CLT_NUMERO"'
      Size = 50
    end
    object Qr_ConsultaCLT_DT_VENCIMENTO: TDateField
      FieldName = 'CLT_DT_VENCIMENTO'
      Origin = '"TB_CTRL_LOTE"."CLT_DT_VENCIMENTO"'
    end
    object Qr_ConsultaORP_DTCAD: TDateField
      FieldName = 'ORP_DTCAD'
      Origin = '"TB_ORP"."ORP_DTCAD"'
    end
    object Qr_ConsultaPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ConsultaORP_NUMERO: TStringField
      FieldName = 'ORP_NUMERO'
      Origin = '"TB_ORP"."ORP_NUMERO"'
      Required = True
      Size = 10
    end
    object Qr_ConsultaCONSTOTAL: TBCDField
      FieldName = 'CONSTOTAL'
      Origin = '"TB_MOVIMENTO_LOTE"."MLT_QTDE"'
      Precision = 18
      Size = 3
    end
  end
end

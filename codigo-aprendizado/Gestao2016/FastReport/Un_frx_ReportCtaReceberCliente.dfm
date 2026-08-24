inherited frx_ReportCtaReceberCliente: Tfrx_ReportCtaReceberCliente
  Caption = 'frx_ReportCtaReceberCliente'
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 43565.982036296290000000
    ScriptText.Strings = (
      'var'
      '  DiasCarencia : Integer;'
      '  PercentualMulta : Real;'
      '  PercentualJuros : Real;'
      
        '  ValorParcela : Real;                                          ' +
        '      '
      '  ValorSubtotal : Real;'
      '  ValorTotal : Real;  '
      '  ValorDescontada : Real;'
      '  ValorDescontadaTotal : Real;'
      '  ValorCredito : Real;'
      '  ValorCreditoTotal : Real;'
      ''
      'procedure FormataDetalhe;'
      'Begin'
      '  if <frxDBaseReport."FIN_OPERACAO"> = '#39'C'#39' then'
      '  Begin'
      '    E_Fone.Font.Color := clBlack;'
      '    E_Emissao.Font.Color := clBlack;'
      '    E_Pedido.Font.Color := clBlack;'
      '    E_Vencimento.Font.Color := clBlack;'
      '    E_Vl_Parcela.Font.Color := clBlack;  '
      '  end'
      '  else'
      '  Begin'
      '    E_Fone.Font.Color :=clred;'
      '    E_Emissao.Font.Color := clred;'
      '    E_Pedido.Font.Color := clred;'
      '    E_Vencimento.Font.Color := clred;'
      '    E_Vl_Parcela.Font.Color := clred;'
      '  end;'
      '  if <frxDBaseReport."FIN_SITUACAO"> = '#39'T'#39' then'
      '  Begin'
      '    E_Fone.Font.Style := 10;'
      '    E_Emissao.Font.Style := 10;   '
      '    E_Pedido.Font.Style := 10;'
      '    E_Vencimento.Font.Style := 10;'
      '    E_Vl_Parcela.Font.Style :=10;'
      '  End'
      '  else'
      '  Begin'
      '    E_Fone.Font.Style := 0;'
      '    E_Emissao.Font.Style := 0;   '
      '    E_Pedido.Font.Style := 0;   '
      '    E_Vencimento.Font.Style := 0;   '
      '    E_Vl_Parcela.Font.Style := 0;  '
      '  end;'
      'end;'
      ''
      'procedure PreencheDetalhe;'
      'Var'
      '  Lc_valor : Real;'
      '  Lc_dias : Real;'
      '  Lc_Vl_Multa : Real;'
      '  Lc_Vl_Juros : Real;'
      'Begin'
      '  Lc_dias := 0;'
      '  Lc_Vl_Multa := 0;'
      '  Lc_Vl_Juros := 0;'
      '  DiasCarencia := 0;                        '
      '  Lc_valor := <frxDBaseReport."FIN_VL_PARCELA">;'
      '       '
      '  if (<frxDBaseReport."FIN_OPERACAO"> = '#39'C'#39' ) THEN        '
      '  Begin                                           '
      
        '    if ( <frxDBaseReport."FIN_DT_VENCIMENTO"> + DiasCarencia) < ' +
        'Date then'
      '    Begin          '
      '      Lc_dias := Date - <frxDBaseReport."FIN_DT_VENCIMENTO">;'
      '      Lc_Vl_Multa := Lc_valor * PercentualMulta;'
      '      Lc_Vl_Juros := Lc_valor * ( PercentualJuros * Lc_dias ) ;'
      '    end;'
      '    ValorParcela := Lc_valor + Lc_Vl_Multa + Lc_Vl_Juros;'
      
        '    ValorSubtotal := ValorSubtotal + Lc_valor + Lc_Vl_Multa + Lc' +
        '_Vl_Juros;'
      
        '    ValorTotal := ValorTotal + Lc_valor + Lc_Vl_Multa + Lc_Vl_Ju' +
        'ros;'
      '  end'
      '  else'
      '  Begin'
      
        '    ValorParcela := <frxDBaseReport."FIN_VL_PARCELA">;          ' +
        '                 '
      
        '    ValorCredito := ValorCredito + <frxDBaseReport."FIN_VL_PARCE' +
        'LA">;'
      
        '    ValorCreditoTotal := ValorCreditoTotal + <frxDBaseReport."FI' +
        'N_VL_PARCELA">;      '
      '  end;'
      '  if (<frxDBaseReport."FIN_SITUACAO"> = '#39'T'#39' ) THEN  '
      '  Begin'
      
        '    ValorDescontada := ValorDescontada + <frxDBaseReport."FIN_VL' +
        '_PARCELA">;           '
      
        '    ValorDescontadaTotal := ValorDescontadaTotal +  <frxDBaseRep' +
        'ort."FIN_VL_PARCELA">;      '
      '  End;        '
      'end;'
      '  '
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'Begin'
      '  PreencheDetalhe;'
      '  FormataDetalhe;      '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  ValorSubtotal := 0;'
      '  ValorDescontada := 0;  '
      '  ValorCredito := 0;  '
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
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        Height = 132.779530000000000000
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
        Top = 506.457020000000000000
        inherited Memo41: TfrxMemoView
          Top = 2.220470000000034000
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
      object GroupHeader1: TfrxGroupHeader
        Description = 'Data de Vencimento'
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBaseReport."FIN_CODEMP"'
        object Memo3: TfrxMemoView
          Left = 3.559060000000000000
          Width = 494.291590000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_NOME"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 390.779530000000000000
          Top = 22.677179999999990000
          Width = 84.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 652.724411890000000000
          Top = 22.677179999999990000
          Width = 63.118107800000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Parcela')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 567.685041810000000000
          Top = 22.677179999999990000
          Width = 80.881889760000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 283.779530000000000000
          Top = 22.677179999999990000
          Width = 105.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 476.598427640000000000
          Top = 22.677179999999990000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 40.795300000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677180000000000000
        ParentFont = False
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object E_Emissao: TfrxMemoView
          Left = 387.000000000000000000
          Width = 84.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NFL_DT_EMISSAO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."NFL_DT_EMISSAO"]')
          ParentFont = False
        end
        object E_Vl_Parcela: TfrxMemoView
          Left = 648.944881890000000000
          Width = 66.897637800000000000
          Height = 17.000000000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorParcela]')
          ParentFont = False
        end
        object E_Vencimento: TfrxMemoView
          Left = 563.905511810000000000
          Width = 80.881889760000000000
          Height = 17.000000000000000000
          DataField = 'FIN_DT_VENCIMENTO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."FIN_DT_VENCIMENTO"]')
          ParentFont = False
        end
        object E_Fone: TfrxMemoView
          Left = 280.000000000000000000
          Width = 105.000000000000000000
          Height = 17.000000000000000000
          DataField = 'END_FONE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."END_FONE"]')
          ParentFont = False
        end
        object E_Pedido: TfrxMemoView
          Left = 472.818897640000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataField = 'FIN_NUMERO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."FIN_NUMERO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 321.260050000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object Memo14: TfrxMemoView
          Left = 132.283550000000000000
          Top = 3.779530000000022000
          Width = 176.811070000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal da Divida')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 132.283550000000000000
          Top = 22.677180000000020000
          Width = 176.811070000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal Descontado')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 443.205010000000000000
          Top = 3.779530000000022000
          Width = 154.133890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal Cr'#233'ditos')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 443.205010000000000000
          Top = 22.677180000000020000
          Width = 154.133890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal')
          ParentFont = False
        end
        object E_Vl_SubTotal_credito: TfrxMemoView
          Left = 603.638220000000000000
          Top = 3.779530000000022000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorCredito]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 603.638220000000000000
          Top = 22.677180000000020000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorSubtotal - (ValorDescontada + ValorCredito)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 315.819110000000000000
          Top = 3.779530000000022000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorSubtotal]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 315.819110000000000000
          Top = 22.677180000000020000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorDescontada]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 41.574830000000020000
          Width = 718.110236220000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        Description = 'Valores totais do relat'#243'rio'
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        object Memo21: TfrxMemoView
          Left = 130.944960000000000000
          Top = 20.354359999999980000
          Width = 176.811070000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal da Divida')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 130.944960000000000000
          Top = 39.252009999999990000
          Width = 176.811070000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal Descontado')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 441.866420000000000000
          Top = 20.354359999999980000
          Width = 154.133890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal Cr'#233'ditos')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 441.866420000000000000
          Top = 39.252009999999990000
          Width = 154.133890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Subtotal')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 602.299630000000000000
          Top = 20.354359999999980000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorCreditoTotal]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 602.299630000000000000
          Top = 39.252009999999990000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotal - (ValorDescontadaTotal + ValorCreditoTotal)]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 314.480520000000000000
          Top = 20.354359999999980000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorTotal]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 314.480520000000000000
          Top = 39.252009999999990000
          Width = 112.251997800000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ValorDescontadaTotal]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Top = 0.779530000000022500
          Width = 717.283860000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15790320
          HAlign = haCenter
          Memo.UTF8W = (
            'VALORES TOTAIS DO RELAT'#211'RIO')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    Active = True
    object Qr_ConsultaFIN_CODQTC: TIntegerField
      FieldName = 'FIN_CODQTC'
      Origin = '"TB_FINANCEIRO"."FIN_CODQTC"'
    end
    object Qr_ConsultaFIN_DT_VENCIMENTO: TDateField
      FieldName = 'FIN_DT_VENCIMENTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_VENCIMENTO"'
    end
    object Qr_ConsultaFIN_DT_PAGTO: TDateField
      FieldName = 'FIN_DT_PAGTO'
      Origin = '"TB_FINANCEIRO"."FIN_DT_PAGTO"'
    end
    object Qr_ConsultaFIN_CODEMP: TIntegerField
      FieldName = 'FIN_CODEMP'
      Origin = '"TB_FINANCEIRO"."FIN_CODEMP"'
    end
    object Qr_ConsultaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_ConsultaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = '"TB_EMPRESA"."EMP_FANTASIA"'
      Size = 100
    end
    object Qr_ConsultaEND_FONE: TStringField
      FieldName = 'END_FONE'
      Origin = '"TB_ENDERECO"."END_FONE"'
      Size = 14
    end
    object Qr_ConsultaEND_REGIAO: TStringField
      FieldName = 'END_REGIAO'
      Origin = '"TB_ENDERECO"."END_REGIAO"'
      Size = 25
    end
    object Qr_ConsultaFIN_NUMERO: TStringField
      FieldName = 'FIN_NUMERO'
      Origin = '"TB_FINANCEIRO"."FIN_NUMERO"'
    end
    object Qr_ConsultaFIN_VL_PARCELA: TBCDField
      FieldName = 'FIN_VL_PARCELA'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PARCELA"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaFIN_VL_PAGO: TBCDField
      FieldName = 'FIN_VL_PAGO'
      Origin = '"TB_FINANCEIRO"."FIN_VL_PAGO"'
      Precision = 18
      Size = 2
    end
    object Qr_ConsultaFIN_CODFPG: TIntegerField
      FieldName = 'FIN_CODFPG'
      Origin = '"TB_FINANCEIRO"."FIN_CODFPG"'
    end
    object Qr_ConsultaFIN_BAIXA: TStringField
      FieldName = 'FIN_BAIXA'
      Origin = '"TB_FINANCEIRO"."FIN_BAIXA"'
      Size = 1
    end
    object Qr_ConsultaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_ConsultaFIN_OPERACAO: TStringField
      FieldName = 'FIN_OPERACAO'
      Origin = '"TB_FINANCEIRO"."FIN_OPERACAO"'
      Size = 1
    end
    object Qr_ConsultaFIN_CODMHA: TIntegerField
      FieldName = 'FIN_CODMHA'
      Origin = '"TB_FINANCEIRO"."FIN_CODMHA"'
    end
    object Qr_ConsultaFIN_CODPED: TIntegerField
      FieldName = 'FIN_CODPED'
      Origin = '"TB_FINANCEIRO"."FIN_CODPED"'
    end
    object Qr_ConsultaFIN_CODCHQ: TIntegerField
      FieldName = 'FIN_CODCHQ'
      Origin = '"TB_FINANCEIRO"."FIN_CODCHQ"'
    end
    object Qr_ConsultaFIN_CODNFL: TIntegerField
      FieldName = 'FIN_CODNFL'
      Origin = '"TB_FINANCEIRO"."FIN_CODNFL"'
    end
    object Qr_ConsultaFIN_TIPO: TStringField
      FieldName = 'FIN_TIPO'
      Origin = '"TB_FINANCEIRO"."FIN_TIPO"'
      Size = 2
    end
    object Qr_ConsultaFIN_SITUACAO: TStringField
      FieldName = 'FIN_SITUACAO'
      Origin = '"TB_FINANCEIRO"."FIN_SITUACAO"'
      Size = 1
    end
    object Qr_ConsultaFIN_DT_REPROGRAMADA: TDateField
      FieldName = 'FIN_DT_REPROGRAMADA'
      Origin = '"TB_FINANCEIRO"."FIN_DT_REPROGRAMADA"'
    end
  end
end

inherited FrxOrderServiceFurniture: TFrxOrderServiceFurniture
  Caption = 'FrxOrderServiceFurniture'
  ClientHeight = 135
  ClientWidth = 307
  ExplicitWidth = 323
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 44648.418279027780000000
    ScriptText.Strings = (
      'function MascaraFone(pc_Fone: string): string;'
      'var'
      '  Lc_Text : String;'
      'begin'
      '  Lc_Text := pc_Fone;'
      
        '  if (Copy(Lc_Text,1,4) = '#39'0800'#39')OR (Copy(Lc_Text,1,4) = '#39'0300'#39')' +
        ' then'
      '  Begin//0800-41-1910'
      '    case Length(Lc_Text) of'
      
        '      5..6:Result   := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_Text,5,' +
        '2);'
      
        '      7..10:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_Text,5,2' +
        ') + '#39'-'#39' + Copy(Lc_Text,7,4);'
      
        '      11:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_Text,5,3) +' +
        ' '#39'-'#39' + Copy(Lc_Text,8,4);'
      '    else'
      '      Result := Lc_Text;'
      '    end;'
      '  end'
      '  else'
      '  Begin'
      '    case Length(Lc_Text) of'
      '      5..8:   Begin'
      '                case Length(Lc_Text) of'
      
        '                  5:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_' +
        'Text,5,1);'
      
        '                  6:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_' +
        'Text,5,2);'
      
        '                  7:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_' +
        'Text,5,3);'
      
        '                  8:Result := Copy(Lc_Text,1,4) + '#39'-'#39' + Copy(Lc_' +
        'Text,5,4);'
      '                end;'
      '              end;'
      '      9:      Begin'
      
        '                Result := Copy(Lc_Text,1,5) + '#39'-'#39' + Copy(Lc_Text' +
        ',6,4);'
      '              end;'
      '      10..11: Begin'
      '                case Length(Lc_Text) of'
      
        '                  10:Result := '#39'('#39' + Copy(Lc_Text,1,2) + '#39') '#39' + ' +
        'Copy(Lc_Text,3,4) + '#39'-'#39' + Copy(Lc_Text,7,4);'
      
        '                  11:Result := '#39'('#39' + Copy(Lc_Text,1,2) + '#39') '#39' + ' +
        'Copy(Lc_Text,3,5) + '#39'-'#39' + Copy(Lc_Text,8,4);'
      '                end;'
      '             end;'
      '    end;'
      '  end;'
      ''
      'end;  '
      '  '
      
        'procedure PageHeader1OnBeforePrint_inherited(Sender: TfrxCompone' +
        'nt);'
      '  var'
      '  CNPJ, CEP : String;'
      '  Fone,Celular : String;'
      
        '  ListaFones : String;                                          ' +
        '                '
      'begin'
      '  CNPJ    := <frxDBaseReport."EMP_CNPJ">;'
      '  CEP     := <frxDBaseReport."END_CEP">;      '
      '  Fone    := <frxDBaseReport."END_FONE">;  '
      '  Celular := <frxDBaseReport."END_CELULAR">;'
      
        '        //Utilizar o copy para formatar strings   01731131925   ' +
        '                   '
      '  case Length(CNPJ) of'
      
        '    11: frxDBaseReportEMP_CNPJ.Text := Copy(CNPJ,1,3)+'#39'.'#39'+Copy(C' +
        'NPJ,4,3)+'#39'.'#39'+Copy(CNPJ,7,3)+'#39'-'#39'+Copy(CNPJ,10,2);   '
      
        '    14: frxDBaseReportEMP_CNPJ.Text := Copy(CNPJ,1,2)+'#39'.'#39'+Copy(C' +
        'NPJ,3,3)+'#39'.'#39'+Copy(CNPJ,6,3)+'#39'/'#39'+Copy(CNPJ,9,4)+'#39'-'#39'+Copy(CNPJ,13,' +
        '2);'
      '  end;'
      '  //81810140'
      '      '
      
        '  frxDBaseReportEND_CEP.Text := Copy(CEP,1,2)+'#39'.'#39'+Copy(CEP,3,3)+' +
        #39'-'#39'+Copy(CEP,6,3);'
      '  ListaFones := '#39#39';                      '
      '  if Fone <> '#39#39' then'
      '   ListaFones := MascaraFone(Fone);                     '
      '  if ListaFones <> '#39#39' then'
      '  Begin'
      '    if Celular <> '#39#39' then'
      
        '       ListaFones := ListaFones + '#39'  /  '#39' + MascaraFone(Celular)' +
        ';  '
      '  end'
      '  else'
      '  Begin'
      '    if Celular <> '#39#39' then'
      '       ListaFones := MascaraFone(Celular);  '
      '  end;            '
      
        '  frxDBaseReportEND_FONE.text := ListaFones;                    ' +
        '                           '
      'end;'
      ''
      'begin'
      'end.')
    Datasets = <
      item
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
      end
      item
        DataSet = frxDBaseReportItens
        DataSetName = 'frxDBaseReportItens'
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
      inherited PageHeader1: TfrxPageHeader
        Height = 296.448980000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint_inherited'
        inherited lbTitulo: TfrxMemoView
          Height = 24.566929130000000000
          Font.Height = -19
          Memo.UTF8W = (
            'ORDEM DE SERVI'#199'OS')
          VAlign = vaCenter
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
        object frxDBaseReportEMP_FANTASIA: TfrxMemoView
          Left = 75.590600000000000000
          Top = 157.063080000000000000
          Width = 638.740570000000000000
          Height = 18.897637800000000000
          DataField = 'EMP_FANTASIA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EMP_FANTASIA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 3.779527559055120000
          Top = 157.063080000000000000
          Width = 66.558750000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779527560000000000
          Top = 177.826771650000000000
          Width = 58.999690000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBaseReportEND_ENDER: TfrxMemoView
          Left = 64.252010000000000000
          Top = 177.826771650000000000
          Width = 650.079160000000000000
          Height = 18.897637800000000000
          StretchMode = smActualHeight
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBaseReport."END_ENDER"] ,  [frxDBaseReport."END_NUMERO"] - ' +
              '[frxDBaseReport."END_COMPLEM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo4: TfrxMemoView
          Left = 3.779527559055120000
          Top = 199.503951650000000000
          Width = 40.102040000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 46.133890000000000000
          Top = 199.503951650000000000
          Width = 170.078850000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."END_BAIRRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBaseReportEND_FONE: TfrxMemoView
          Left = 294.921460000000000000
          Top = 199.503951650000000000
          Width = 419.527830000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Left = 3.779527559055120000
          Top = 221.480314960630000000
          Width = 66.558750000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CPF/CNPJ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 273.126160000000000000
          Top = 221.480314960630000000
          Width = 47.661100000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 326.039580000000000000
          Top = 221.480314960630000000
          Width = 215.433210000000000000
          Height = 18.897637795275600000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CDD_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 545.031850000000000000
          Top = 221.480314960630000000
          Width = 24.983920000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 605.504330000000000000
          Top = 221.480314960630000000
          Width = 36.322510000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBaseReportEND_CEP: TfrxMemoView
          Left = 643.299630000000000000
          Top = 221.480314960000000000
          Width = 71.811070000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDBaseReportUFE_SIGLA: TfrxMemoView
          Left = 575.268090000000000000
          Top = 221.480314960630000000
          Width = 26.456710000000000000
          Height = 18.897637795275600000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."UFE_SIGLA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Top = 248.315090000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 3.779527560000000000
          Top = 250.960629921260000000
          Width = 123.251700000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'M'#243'vel/Equipamento:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 219.433210000000000000
          Top = 272.881889763780000000
          Width = 47.661100000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Modelo:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 3.559060000000000000
          Top = 272.881889763780000000
          Width = 43.881570000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca:')
          ParentFont = False
        end
        object frxDBaseReportCST_MARCA: TfrxMemoView
          Left = 272.126160000000000000
          Top = 272.881889760000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."MODEL"]')
          ParentFont = False
        end
        object frxDBaseReportCST_MODELO: TfrxMemoView
          Left = 56.692950000000000000
          Top = 272.881889763780000000
          Width = 154.960730000000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."BRAND"]')
          ParentFont = False
        end
        object frxDBaseReportCST_APARELHO: TfrxMemoView
          Left = 128.504020000000000000
          Top = 250.960629921260000000
          Width = 219.212740000000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EQUIPMENT"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 352.937227560000000000
          Top = 250.960629921260000000
          Width = 74.117810000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ambiente:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 430.086890000000000000
          Top = 250.960629921260000000
          Width = 283.464627950000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."ENVIRONMENT"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 295.346630000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Top = 153.401670000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo59: TfrxMemoView
          Left = 226.771800000000000000
          Top = 200.315090000000000000
          Width = 62.779220000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefones')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBaseReportEMP_CNPJ: TfrxMemoView
          Left = 75.590600000000000000
          Top = 222.992270000000000000
          Width = 124.724490000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 412.787570000000000000
          Top = 114.275590550000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_NUMERO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 337.196970000000000000
          Top = 114.275590550000000000
          Width = 70.338280000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 562.189240000000000000
          Top = 114.275590550000000000
          Width = 151.181200000000000000
          Height = 18.897637800000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."PED_DATA"] [frxDBaseReport."PED_HORA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 511.953000000000000000
          Top = 114.275590550000000000
          Width = 47.661100000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hora: ')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 990.236860000000000000
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
      object Executado: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 480.000310000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo23: TfrxMemoView
          Top = 7.937007870000000000
          Width = 132.283464570000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Servi'#231'o Executado:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baWidth
          Left = 132.283464570000000000
          Top = 7.937007870000000000
          Width = 585.827235430000000000
          Height = 15.118110236220500000
          StretchMode = smMaxHeight
          DataField = 'EXECUTED'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EXECUTED"]')
          ParentFont = False
          WordBreak = True
        end
        object Line7: TfrxLineView
          Top = 3.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 257.008040000000000000
        Top = 710.551640000000000000
        Width = 718.110700000000000000
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.000000000000000000
          Width = 134.590290000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#245'es Gerais: ')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.897650000000000000
          Width = 710.551395910000000000
          Height = 79.370105590000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Line3: TfrxLineView
          Top = 107.740260000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 111.519685040000000000
          Width = 62.779220000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'T'#233'cnico:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 72.929190000000000000
          Top = 111.519685040000000000
          Width = 415.748300000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."TECNICO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 500.677490000000000000
          Top = 111.519685039370000000
          Width = 96.794990000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Produtos:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 500.677490000000000000
          Top = 132.307086614173000000
          Width = 96.794990000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Servi'#231'os:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 500.677490000000000000
          Top = 153.472440944882000000
          Width = 96.794990000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Deslocamento:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 500.677490000000000000
          Top = 174.259842519685000000
          Width = 96.794990000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descontos:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 500.677490000000000000
          Top = 195.047244094488000000
          Width = 96.794990000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object frxDBaseReportPED_VL_PRODUTO: TfrxMemoView
          Left = 600.945270000000000000
          Top = 111.519685040000000000
          Width = 113.385826770000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_PRODUTO"]')
          ParentFont = False
        end
        object frxDBaseReportPED_VL_SERVICO: TfrxMemoView
          Left = 600.945270000000000000
          Top = 132.307086610000000000
          Width = 113.385826770000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_SERVICO"]')
          ParentFont = False
        end
        object frxDBaseReportPED_VL_FRETE: TfrxMemoView
          Left = 600.945270000000000000
          Top = 153.472440940000000000
          Width = 113.385826770000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_FRETE"]')
          ParentFont = False
        end
        object frxDBaseReportPED_VL_DESCONTO: TfrxMemoView
          Left = 600.945270000000000000
          Top = 174.259842520000000000
          Width = 113.385826770000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_DESCONTO"]')
          ParentFont = False
        end
        object frxDBaseReportPED_VL_PEDIDO: TfrxMemoView
          Left = 600.945270000000000000
          Top = 195.047244090000000000
          Width = 113.385826770000000000
          Height = 17.007874015748000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReport."PED_VL_PEDIDO"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 130.417322830000000000
          Width = 62.779220000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Situa'#231#227'o :')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 71.811070000000000000
          Top = 130.417322830000000000
          Width = 272.126160000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."SIT_DESCRICAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 3.440940000000000000
          Top = 150.314972830000000000
          Width = 85.456400000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atendimento:')
          ParentFont = False
        end
        object frxDBaseReportDT_FORECAST: TfrxMemoView
          Left = 94.149660000000000000
          Top = 150.314972830000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxDBaseReport."DT_ATTENDANCE"] -  [frxDBaseReport."HR_ATTENDAN' +
              'CE"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 170.078740157480000000
          Width = 157.267470000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Condi'#231#245'es de Pagamento: ')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 166.299320000000000000
          Top = 170.078740157480000000
          Width = 325.039580000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxDBaseReport."FPT_DESCRICAO">] / [<frxDBaseReport."PED_PRAZO' +
              '">]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Top = 217.346630000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 217.346630000000000000
          Width = 712.858380000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'ESTE DOCUMENTO N'#195#402'O VALE COMO RECIBO DE PAGAMENTO***MANTENHA SEU' +
              'S DADOS ATUALIZADOS. ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 442.205010000000000000
          Top = 236.290970000000000000
          Width = 274.432900000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Visto:___________________________________')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Top = 3.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Contatado: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 427.086890000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo21: TfrxMemoView
          Top = 8.000000000000000000
          Width = 132.283464570000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Problema Constatado:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baWidth
          Left = 132.283464570000000000
          Top = 8.000000000000000000
          Width = 585.827235430000000000
          Height = 15.118110236220500000
          StretchMode = smMaxHeight
          DataField = 'FOUND'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."FOUND"]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Top = 3.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Informado: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 374.173470000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo19: TfrxMemoView
          Top = 4.913385830000000000
          Width = 132.283464570000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Problema Informado:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baWidth
          Left = 132.283464570000000000
          Top = 4.913385830000000000
          Width = 585.827235430000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'REPORTED'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."REPORTED"]')
          ParentFont = False
        end
      end
      object ObservacoesOS: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 532.913730000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo47: TfrxMemoView
          Top = 7.937007870000000000
          Width = 132.283464570000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#245'es da O.S:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Align = baWidth
          Left = 132.283464570000000000
          Top = 7.937007870000000000
          Width = 585.827235430000000000
          Height = 15.118110236220500000
          StretchMode = smMaxHeight
          DataField = 'NOTE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."NOTE"]')
          ParentFont = False
          WordBreak = True
        end
        object Line9: TfrxLineView
          Top = 4.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Listaitens: TfrxDetailData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 631.181510000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReportItens
        DataSetName = 'frxDBaseReportItens'
        RowCount = 0
        Stretched = True
        object Memo50: TfrxMemoView
          Left = 90.708661420000000000
          Top = 1.779530000000000000
          Width = 355.275590550000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataField = 'PRO_DESCRICAO'
          DataSet = frxDBaseReportItens
          DataSetName = 'frxDBaseReportItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReportItens."PRO_DESCRICAO"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo49: TfrxMemoView
          Top = 1.779530000000000000
          Width = 86.929190000000000000
          Height = 13.228346456692900000
          StretchMode = smMaxHeight
          DataField = 'PRO_CODIGOFAB'
          DataSet = frxDBaseReportItens
          DataSetName = 'frxDBaseReportItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReportItens."PRO_CODIGOFAB"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 445.984251970000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 13.228346456692900000
          StretchMode = smMaxHeight
          DataSet = frxDBaseReportItens
          DataSetName = 'frxDBaseReportItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBaseReportItens."ITF_QTDE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 536.692913385827000000
          Top = 1.779530000000000000
          Width = 86.929190000000000000
          Height = 13.228346456692900000
          StretchMode = smMaxHeight
          DataSet = frxDBaseReportItens
          DataSetName = 'frxDBaseReportItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBaseReportItens."ITF_VL_UNIT"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 627.401574803150000000
          Top = 1.779530000000000000
          Width = 86.929133858267700000
          Height = 13.228346456692900000
          StretchMode = smMaxHeight
          DataSet = frxDBaseReportItens
          DataSetName = 'frxDBaseReportItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDBaseReportItens."ITF_QTDE">*<frxDBaseReportItens."ITF_VL_' +
              'UNIT">)-<frxDBaseReportItens."ITF_VL_DESC">]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 585.827150000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReportItens
        DataSetName = 'frxDBaseReportItens'
        RowCount = 0
        Stretched = True
        object Memo54: TfrxMemoView
          Left = 1.779530000000000000
          Top = 4.779530000000000000
          Width = 83.149574570000000000
          Height = 17.007876460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo Item')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Top = 4.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo55: TfrxMemoView
          Left = 90.708661420000000000
          Top = 5.000000000000000000
          Width = 355.275590550000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o dos Itens')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 445.984251968504000000
          Top = 4.889763780000000000
          Width = 86.929133860000000000
          Height = 17.007876460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 536.692913390000000000
          Top = 4.889763780000000000
          Width = 86.929133860000000000
          Height = 17.007876460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Unit'#225'rio')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 627.401574800000000000
          Top = 4.889763780000000000
          Width = 86.929133860000000000
          Height = 17.007876460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Subtotal')
          ParentFont = False
        end
      end
    end
  end
  inherited Qr_Consulta: TSTQuery
    SQL.Strings = (
      
        'select pe.ped_numero, pe.ped_data,pe.ped_hora, em.emp_fantasia, ' +
        'en.end_ender, en.end_numero, en.end_cep,end_bairro, '
      
        'en.end_fone, en.end_celular, em.emp_cnpj, en.end_complem, ci.cdd' +
        '_descricao, uf.ufe_sigla, '
      'fu.equipment,fu.environment, fu.brand,fu.model,  '
      'fu.reported, fu.FOUND, fu.EXECUTED, fu.note,   '
      
        'tec.clb_nome tecnico, si.sit_descricao, fu.dt_attendance, pe.ped' +
        '_prazo, fo.fpt_descricao, '
      
        'pe.ped_vl_produto, pe.ped_vl_servico, pe.ped_vl_frete, pe.ped_vl' +
        '_desconto, pe.ped_vl_pedido, '
      ' fu.HR_attendance '
      'from tb_furniture_os fu'
      ''
      '  inner join tb_pedido pe '
      '  on (pe.ped_codigo = fu.tb_order_id) '
      '  inner join tb_empresa em '
      '  on (em.emp_codigo = pe.ped_codemp) '
      '  inner join tb_endereco en '
      '  on (en.end_codigo = pe.ped_codend) '
      '  inner join tb_cidade ci '
      '  on (ci.cdd_codigo = en.end_codcdd) '
      '  inner join tb_uf uf '
      '  on (uf.ufe_codigo = en.end_codufe) '
      '  inner join tb_colaborador tec'
      '  on (ate.clb_codigo = pe.ped_codvdo) '
      '  inner join tb_situacao si '
      '  on (si.sit_codigo = fu.tb_situacao_id)'
      '  inner join tb_formapagto fo '
      '  on (fo.fpt_codigo = pe.ped_codfpg)')
    Left = 184
  end
  object Qr_Itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_SEQUENCIA,'
      '  ITF_CODPED,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_DESCRICAO,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  MED_ABREVIATURA,'
      '  ITF_VL_DESC,'
      
        '  ( ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC)  * ITF_AQ_IPI)/100 ' +
        'ITF_VL_IPI'
      'FROM TB_ITENS_NFL it'
      '   INNER JOIN TB_PRODUTO pr'
      '   ON  (pr.PRO_CODIGO = it.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA md'
      '   ON  (md.MED_CODIGO = pr.PRO_CODMED)'
      'WHERE (ITF_CODPED =:PED_CODIGO)'
      'ORDER BY PRO_DESCRICAO')
    Left = 248
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object frxDBaseReportItens: TfrxDBDataset
    UserName = 'frxDBaseReportItens'
    CloseDataSource = False
    DataSet = Qr_Itens
    BCDToCurrency = False
    Left = 200
    Top = 80
  end
end

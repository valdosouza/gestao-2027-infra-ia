inherited FrxWarrantyTermEletcEquip: TFrxWarrantyTermEletcEquip
  Caption = 'FrxWarrantyTermEletcEquip'
  ClientHeight = 195
  ClientWidth = 307
  ExplicitWidth = 323
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxBase: TfrxReport
    ReportOptions.LastChange = 44587.714192893520000000
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
      '      '
      
        'procedure PageHeader1OnBeforePrint_inherited(Sender: TfrxCompone' +
        'nt);'
      ' var'
      '  CNPJ, CEP : String;'
      '  Fone,Celular : String;'
      
        '  ListaFones : String;                                          ' +
        '                '
      'begin'
      '  CNPJ    := <frxDBaseReport."EMP_CNPJ">;'
      '  CEP     := <frxDBaseReport."END_CEP">;      '
      '  Fone    := <frxDBaseReport."END_FONE">;  '
      '  Celular := <frxDBaseReport."END_CELULAR">;'
      
        '  //Utilizar o copy para formatar strings 01731131925 / 07742094' +
        '000113                                                          ' +
        ' '
      '  case Length(CNPJ) of'
      
        '    11: frxDBaseReportEMP_CNPJ.Text := Copy(CNPJ,1,3)+'#39'.'#39'+Copy(C' +
        'NPJ,4,3)+'#39'.'#39'+Copy(CNPJ,7,3)+'#39'-'#39'+Copy(CNPJ,10,2);   '
      
        '    14: frxDBaseReportEMP_CNPJ.Text := Copy(CNPJ,1,2)+'#39'.'#39'+Copy(C' +
        'NPJ,3,3)+'#39'.'#39'+Copy(CNPJ,6,3)+'#39'/'#39'+Copy(CNPJ,9,4)+'#39'-'#39'+Copy(CNPJ,13,' +
        '2);'
      '  end;  '
      ''
      ''
      ' //81810140                '
      
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
      '  frxDBaseReportEND_FONE.text := ListaFones;  '
      ''
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
      PaperSize = 256
      inherited PageHeader1: TfrxPageHeader
        Height = 337.346630000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint_inherited'
        inherited lbTitulo: TfrxMemoView
          Height = 24.566929130000000000
          Font.Height = -19
          Memo.UTF8W = (
            'ORDEM DE SERVI'#199'OS')
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
        object Line1: TfrxLineView
          Top = 246.315090000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 273.874015750000000000
          Width = 89.235930000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Equipamento:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 298.803340000000000000
          Top = 273.874015750000000000
          Width = 47.661100000000000000
          Height = 17.000000000000000000
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
          Left = 510.236550000000000000
          Top = 273.874015750000000000
          Width = 43.881570000000000000
          Height = 17.000000000000000000
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
          Left = 555.590910000000000000
          Top = 273.874015750000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataField = 'CST_MARCA'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_MARCA"]')
          ParentFont = False
        end
        object frxDBaseReportCST_MODELO: TfrxMemoView
          Left = 351.496290000000000000
          Top = 273.874015750000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          DataField = 'CST_MODELO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_MODELO"]')
          ParentFont = False
        end
        object frxDBaseReportCST_APARELHO: TfrxMemoView
          Left = 98.267780000000000000
          Top = 273.874015750000000000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          DataField = 'CST_APARELHO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_APARELHO"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 295.771653543307000000
          Width = 108.133580000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero de S'#233'rie:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 298.803340000000000000
          Top = 295.771653543307000000
          Width = 36.322510000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IMEI:')
          ParentFont = False
        end
        object frxDBaseReportSERIE: TfrxMemoView
          Left = 117.165430000000000000
          Top = 295.771653540000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          DataField = 'SERIE'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."SERIE"]')
          ParentFont = False
        end
        object frxDBaseReportIMEI: TfrxMemoView
          Left = 340.157700000000000000
          Top = 295.771653540000000000
          Width = 170.078727950000000000
          Height = 18.897650000000000000
          DataField = 'IMEI'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."IMEI"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 315.669450000000000000
          Width = 74.117810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Acess'#243'rios:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 86.929190000000000000
          Top = 315.669450000000000000
          Width = 627.401980000000000000
          Height = 18.897650000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_ACESSORIO"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 337.346630000000000000
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
        object Line9: TfrxLineView
          Top = 273.567100000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 247.551330000000000000
          Width = 712.858380000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPROVANTE DE SAIDA - TERMOS DE GARANTIA')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 415.748300000000000000
          Top = 113.385900000000000000
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
          Left = 340.157700000000000000
          Top = 113.385900000000000000
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
          Left = 565.149970000000000000
          Top = 113.385900000000000000
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
          Left = 514.913730000000000000
          Top = 113.385900000000000000
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
        object frxDBaseReportEMP_FANTASIA: TfrxMemoView
          Left = 75.590602440000000000
          Top = 154.960730000000000000
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
          Left = 3.779530000000000000
          Top = 154.960730000000000000
          Width = 66.558750000000000000
          Height = 18.897637800000000000
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
          Left = 3.779530000000000000
          Top = 175.724421650000000000
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
          Left = 64.252012440000000000
          Top = 175.724421650000000000
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
          Left = 3.779530000000000000
          Top = 197.401601650000000000
          Width = 40.102040000000000000
          Height = 18.897637800000000000
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
          Left = 46.133892440000000000
          Top = 197.401601650000000000
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
          Left = 294.921462440000000000
          Top = 197.401601650000000000
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
          Left = 3.779530000000000000
          Top = 219.377964960000000000
          Width = 66.558750000000000000
          Height = 18.897637800000000000
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
          Left = 273.126162440000000000
          Top = 219.377964960000000000
          Width = 47.661100000000000000
          Height = 18.897637800000000000
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
          Left = 326.039582440000000000
          Top = 219.377964960000000000
          Width = 215.433210000000000000
          Height = 18.897637800000000000
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
          Left = 545.031852440000000000
          Top = 219.377964960000000000
          Width = 24.983920000000000000
          Height = 18.897637800000000000
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
          Left = 605.504332440000000000
          Top = 219.377964960000000000
          Width = 36.322510000000000000
          Height = 18.897637800000000000
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
          Left = 643.299632440000000000
          Top = 219.377964960000000000
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
          Left = 575.268092440000000000
          Top = 219.377964960000000000
          Width = 26.456710000000000000
          Height = 18.897637800000000000
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
        object Memo59: TfrxMemoView
          Left = 226.771802440000000000
          Top = 198.212740000000000000
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
          Left = 79.370130000000000000
          Top = 219.212740000000000000
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
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 1080.945580000000000000
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
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 302.362400000000000000
        Top = 755.906000000000000000
        Width = 718.110700000000000000
        object Memo26: TfrxMemoView
          Left = 1.779530000000000000
          Top = 21.897650000000000000
          Width = 710.551395910000000000
          Height = 102.047285590000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'GARANTIA: 90 DIAS NAS PE'#199'AS INSTALADAS, CONTRA DEFEITO DE FABRIC' +
              'A'#199#195'O. '
            
              'N'#195#402'O COBRE FALHAS DECORRENTES DE USO INADEQUADO, BATIDAS, RISCOS' +
              ', QUEDAS, QUEBRAS, TRINCAS, '
            
              'ARRANH'#213'ES, AMASSADOS. ESTA CONDI'#199#195'O DE APLICA A TODA EXTENS'#195'O DA' +
              ' PE'#199'A, INCLUINDO O ARO '
            
              'PARA AQUELA QUE O CONTENHA. GARANTIA MEDIANTE A APRESENTA'#199#195'O DES' +
              'TE COMPROVANTE E SELO '
            'DE GARANTIA INTACTO (SE APLIC'#193'VEL A PE'#199'A).'
            ''
            
              'Declaro ter utilizado o Servi'#231'o dessa empresa e que o produto fo' +
              'i devolvido em perfeito estado de '
            'funcionamento e testado antes da assinatura deste comprovante. ')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Top = 126.740260000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 130.519685040000000000
          Width = 77.897340000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Respons'#225'vel:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 86.929190000000000000
          Top = 130.519685040000000000
          Width = 404.409710000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."RESPONSAVEL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 500.677490000000000000
          Top = 130.519685039370000000
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
          Top = 151.307086614173000000
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
          Top = 172.472440944882000000
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
          Top = 193.259842519685000000
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
          Top = 214.047244094488000000
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
          Top = 130.519685040000000000
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
          Top = 151.307086610000000000
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
          Top = 172.472440940000000000
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
          Top = 193.259842520000000000
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
          Top = 214.047244090000000000
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
          Top = 149.417322830000000000
          Width = 77.897340000000000000
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
          Top = 149.417322830000000000
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
          Left = 3.220470000000000000
          Top = 169.094502830000000000
          Width = 77.897340000000000000
          Height = 17.007874015748000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Saida:')
          ParentFont = False
        end
        object frxDBaseReportDT_FORECAST: TfrxMemoView
          Left = 82.590600000000000000
          Top = 169.094502830000000000
          Width = 90.708720000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_DT_ENTREGA"]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Top = 236.346630000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 260.731910000000000000
          Width = 274.432900000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '________________________________________')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 240.126160000000000000
          Width = 138.369820000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'T'#233'cnico Respons'#225'vel:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 143.622140000000000000
          Top = 240.126160000000000000
          Width = 313.700990000000000000
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
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 279.582870000000000000
          Width = 274.432900000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Assinatura T'#233'cnico')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 294.803340000000000000
          Top = 260.685220000000000000
          Width = 274.432900000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '________________________________________')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 294.803340000000000000
          Top = 279.536180000000000000
          Width = 274.432900000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Assinatura Cliente')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 593.386210000000000000
          Top = 256.905690000000000000
          Width = 115.692640000000000000
          Height = 32.125994020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(   ) Via do Cliente'
            '(   ) Via da Empresa')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 187.212740000000000000
          Width = 77.897340000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hora Sa'#237'da:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 83.149660000000000000
          Top = 187.212740000000000000
          Width = 90.708720000000000000
          Height = 17.007874020000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 2.779530000000000000
          Top = 5.000000000000000000
          Width = 236.637600000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SOBRE A GARANTIA DO SERVI'#199'O:')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Executado: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 521.575140000000000000
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
          DataField = 'EXECUTADO'
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."EXECUTADO"]')
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
      object Contatado: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 468.661720000000000000
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
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_CONSTATADO"]')
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
        Top = 415.748300000000000000
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
          Height = 15.118110236220500000
          StretchMode = smMaxHeight
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBaseReport."CST_RELATADO"]')
          ParentFont = False
        end
      end
      object ObservacoesOS: TfrxMasterData
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 574.488560000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        Stretched = True
        object Memo53: TfrxMemoView
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
        object Memo54: TfrxMemoView
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
        object Line8: TfrxLineView
          Top = 4.000000000000000000
          Width = 718.110236220000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Listaitens: TfrxDetailData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 672.756340000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReportItens
        DataSetName = 'frxDBaseReportItens'
        RowCount = 0
        Stretched = True
        object Memo55: TfrxMemoView
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
        object Memo56: TfrxMemoView
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
        object Memo57: TfrxMemoView
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
        object Memo58: TfrxMemoView
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
        object Memo60: TfrxMemoView
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
        Top = 627.401980000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReportItens
        DataSetName = 'frxDBaseReportItens'
        RowCount = 0
        Stretched = True
        object Memo61: TfrxMemoView
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
        object Memo62: TfrxMemoView
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
        object Memo63: TfrxMemoView
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
        object Memo64: TfrxMemoView
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
        object Memo65: TfrxMemoView
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
      
        'select pe.ped_numero, pe.ped_data, pe.ped_hora, em.emp_fantasia,' +
        ' en.end_ender, en.end_numero, en.end_cep,end_bairro,'
      
        'en.end_fone, en.end_celular, em.emp_cnpj, en.end_complem, ci.cdd' +
        '_descricao, uf.ufe_sigla,'
      
        'co.cst_aparelho,co.cst_marca,co.cst_modelo, co.serie, co.imei, c' +
        'o.cst_acessorio,'
      
        'co.cst_relatado, co.cst_constatado, co.executado, co.note,  co.d' +
        't_forecast,'
      
        'ate.clb_nome responsavel, si.sit_descricao, co.cst_dt_entrega, p' +
        'e.ped_prazo, fo.fpt_descricao,'
      
        'pe.ped_vl_produto, pe.ped_vl_servico, pe.ped_vl_frete, pe.ped_vl' +
        '_desconto, pe.ped_vl_pedido,'
      
        'tec.clb_nome tecnico, co.HR_CONSERTO, co.HR_ENTREGA,co.HR_FORECA' +
        'ST '
      'from tb_conserto co'
      '   inner join tb_pedido pe'
      '   on (pe.ped_codigo = co.cst_codped)'
      '   inner join tb_empresa em'
      '   on (em.emp_codigo = pe.ped_codemp)'
      '   inner join tb_endereco en'
      '   on (en.end_codigo = pe.ped_codend)'
      '   inner join tb_cidade ci'
      '   on (ci.cdd_codigo = en.end_codcdd)'
      '   inner join tb_uf uf'
      '   on (uf.ufe_codigo = en.end_codufe)'
      '   inner join tb_colaborador ate'
      '   on (ate.clb_codigo = pe.ped_codvdo)'
      '   inner join tb_situacao si'
      '   on (si.sit_codigo = co.cst_codsit)'
      '   inner join tb_formapagto fo'
      '   on (fo.fpt_codigo = pe.ped_codfpg)'
      '   inner join tb_colaborador tec'
      '   on (tec.clb_codigo = co.TB_COLABORADOR_ID)'
      'where pe.ped_codigo = 5627')
    Left = 208
    Top = 8
  end
  inherited frxXLSExport1: TfrxXLSExport
    Left = 16
    Top = 120
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
    Left = 208
    Top = 72
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
    Left = 128
    Top = 64
  end
end

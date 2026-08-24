object FrxCttTrocaBrecho: TFrxCttTrocaBrecho
  Left = 0
  Top = 0
  Caption = 'Contrato de troca em brech'#243's'
  ClientHeight = 204
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxBase: TfrxReport
    Version = '5.3.16'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43076.475621412000000000
    ReportOptions.LastChange = 45351.713756273150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  '
      'begin'
      'end.')
    OnStartReport = 'frxBaseOnStartReport'
    Left = 32
    Top = 16
    Datasets = <
      item
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
      end>
    Variables = <
      item
        Name = ' Empresa'
        Value = Null
      end
      item
        Name = 'Empresa'
        Value = ''
      end
      item
        Name = 'EmpresaCNPJ'
        Value = ''
      end
      item
        Name = 'EmpresaIE'
        Value = ''
      end
      item
        Name = 'EmpresaEndereco'
        Value = ''
      end
      item
        Name = 'EmpresaEnderecoNumero'
        Value = ''
      end
      item
        Name = 'EmpresaBairro'
        Value = ''
      end
      item
        Name = 'EmpresaCidade'
        Value = ''
      end
      item
        Name = 'EmpresaUF'
        Value = ''
      end
      item
        Name = ' Cliente'
        Value = Null
      end
      item
        Name = 'Cliente'
        Value = ''
      end
      item
        Name = 'ClienteCPF'
        Value = ''
      end
      item
        Name = 'ClienteEndereco'
        Value = ''
      end
      item
        Name = 'ClienteEnderecoNumero'
        Value = ''
      end
      item
        Name = 'ClienteBairro'
        Value = ''
      end
      item
        Name = 'ClienteCidade'
        Value = ''
      end
      item
        Name = 'ClienteUF'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 154.960730000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object lbTitulo: TfrxMemoView
          Align = baWidth
          Top = 1.393630000000000000
          Width = 718.110700000000000000
          Height = 24.559060000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Frame.TopLine.Width = 2.000000000000000000
          Frame.BottomLine.Width = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Contrato de Troca')
          ParentFont = False
        end
        object MM_Empresa: TfrxMemoView
          Align = baWidth
          Top = 37.795300000000000000
          Width = 718.110700000000000000
          Height = 52.913420000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[Empresa]  ')
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object MM_Cliente: TfrxMemoView
          Align = baWidth
          Top = 94.488250000000000000
          Width = 718.110700000000000000
          Height = 52.913420000000000000
          DataSet = frxDBaseReport
          DataSetName = 'frxDBaseReport'
          Memo.UTF8W = (
            '[Cliente]  ')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 612.283860000000000000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        DataSet = frxDBaseReport
        DataSetName = 'frxDBaseReport'
        RowCount = 0
        object RR_Body: TfrxRichView
          Align = baClient
          Width = 718.110700000000000000
          Height = 612.283860000000000000
          GapX = 2.000000000000000000
          GapY = 1.000000000000000000
          RichEdit = {
            7B5C727466315C616E73695C616E7369637067313235325C64656666305C6E6F
            7569636F6D7061745C6465666C616E67313034367B5C666F6E7474626C7B5C66
            305C6673776973735C66707271325C666368617273657430204170746F733B7D
            7B5C66315C666E696C5C666368617273657430205461686F6D613B7D7D0D0A7B
            5C2A5C67656E657261746F722052696368656432302031302E302E3232363231
            7D5C766965776B696E64345C756331200D0A5C706172645C73613136305C736C
            3235325C736C6D756C74315C716A5C6B65726E696E67325C625C66305C667332
            3220436C5C2765317573756C6120315C7061720D0A5C6230204F207072657365
            6E746520636F6E747261746F2074656D20636F6D6F206F626A657469766F2C20
            6669726D61722061636F72646F2E20417320706172746573206163696D617320
            6369746164617320656D20656E7472652C2073692C206A7573746F2065206163
            65727461646F206F2070726573656E746520636F6E747261746F206465207472
            6F63612E202876616C6F722064652063725C2765396469746F20706172612075
            74696C697A6172206E61206C6F6A61292E205175652073652072656765726120
            70656C617320636C617573756C61732073656775696E74657320652070656C61
            7320646573637269746173206E6F2070726573656E74652E5C7061720D0A5C62
            20436C5C2765317573756C6120325C7061720D0A5C6230204173207061727465
            73206163696D612063697461646173206465636C6172616D2071756520612070
            617274697220646120617373696E617475726120646573746520636F6E747261
            746F2C2074656D20706F7373652065206469726569746F7320746F7461697320
            736F6272652061206D65726361646F726961206176616C696164612E2053656E
            646F20656C61207574696C697A61646F206F2076616C6F7220746F74616C206F
            75207061726369616C2C20666963616E646F20617373696D20636F6D2073616C
            646F2070617261207574696C697A6172206E6F2064656E74726F206465203620
            6D657365732E53656E646F2064652065787472656D6120696D706F72745C2765
            326E6369612C2074657220656D206D5C2765336F73206F20766F756368657220
            64652074726F63612E5C7061720D0A5C6220436C5C2765317573756C6120335C
            7061720D0A5C623020412074726F636120646F732070726F6475746F73207365
            2066617A20696D65646961746F2061705C2766337320617373696E6174757261
            20646F20636F6E747261746F2C207472616E73666572696E646F20746F74616C
            20706F73736520646F732062656E73207472616E7366657269646120616F2063
            6C69656E746520636F6D6F2076616C6F7220656D2063725C2765396469746F2E
            5C7061720D0A5C6220436C5C2765317573756C6120345C7061720D0A5C623020
            4465636C6172616D6F73207175652061206E65676F6369615C2765375C276533
            6F20666F6920666569746120646520666F726D61206573706F6E745C2765326E
            65612C20706F7220706573736F61732069645C2766346E6561206520636F6D70
            6574656E74652070617261207461692066696D2E5C7061720D0A5C6220436C5C
            2765317573756C6120355C7061720D0A5C623020416C5C2765396D206461206C
            656769736C615C2765375C2765336F2070657274696E656E7465206120706572
            6D7574612C2061706C6963616D2D736520636F6D706C656D656E7461726D656E
            7465206173206E6F726D61732072656C61746976617320612074726F63612E20
            53656E646F206F2070726573656E746520696E737472756D656E746F20697272
            656675745C27653176656C20652069727265766F675C27653176656C2E5C7061
            720D0A5C6220436C5C2765317573756C6120365C7061720D0A5C623020446563
            6C61726F207175652074656E686F2063695C2765616E63696120646F73206372
            69745C27653972696F732064612074726F63612C206520646520717565206F20
            76616C652074656D20612076616C69646164652064652036206D657365732061
            20706172746972206461206461746120646520617373696E617475726120646F
            20636F6E7461746F2E204369656E7465206465207175652061705C2766337320
            612064617461206C696D6974652C206F2076616C652070657264657261207375
            612076616C69646164652064652075746C6C697A615C2765375C2765336F2E5C
            7061720D0A506F72206573746172656D20617373696D206A7573746F73206520
            636F6E7472617461646F732C20617320706172746573206669726D616D206F20
            70726573656E746520696E737472756D656E746F2C20656D2064756173207669
            61732E5C7061720D0A0D0A5C706172645C6B65726E696E67305C66315C667331
            365C7061720D0A5C7061720D0A7D0D0A00}
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 869.291900000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 287.244280000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[<Date>]  [<Time>]')
          Formats = <
            item
              Kind = fkDateTime
            end
            item
            end>
        end
        object Memo42: TfrxMemoView
          Align = baCenter
          Left = -30.236240000000000000
          Top = 41.574830000000000000
          Width = 778.583180000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'PERMUTANTE')
          ParentFont = False
        end
      end
    end
  end
  object frxDBaseReport: TfrxDBDataset
    UserName = 'frxDBaseReport'
    CloseDataSource = False
    DataSet = Qr_Consulta
    BCDToCurrency = False
    Left = 112
    Top = 16
  end
  object Qr_Consulta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IBT_Consulta
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_PESSOA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    EMP_INSC_MUN,'
      '    EMP_SUB_TRIB,'
      '    EMP_CRT,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    END_FONE,'
      '    END_FAX,'
      '    END_CELULAR,'
      '   END_COMERCIAL,'
      '   END_PORTARIA,'
      '   END_CONTATO ,'
      '    END_COMPLEM,'
      '    EMP_EMAIL,'
      '    EMP_SITE,'
      '    EMP_CREA,'
      '    EMP_NUMINSC_SUBS,'
      '    CDD_IBGE,'
      '    END_CODCDD,'
      '    CDD_DESCRICAO,'
      '    END_CODUFE,'
      '    UFE_SIGLA,'
      '    UFE_CODIGO,'
      '   END_PAIS,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO  ,'
      'EMP_RESP_TEC,'
      'EMP_RESPONSAVEL,'
      '  EMP_TIP_FAT'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      '  inner join tb_cliente ct'
      'on (ct.CLI_CODEMP = EMP_CODIGO)'
      'WHERE  (END_PRINCIPAL = '#39'S'#39') AND '
      '  (EMP_CODIGO=:EMP_CODIGO)')
    Left = 200
    Top = 16
    ParamData = <
      item
        DataType = ftWideString
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
        Value = '2'
      end>
  end
  object frxPDFExport1: TfrxPDFExport
    FileName = 'relatorio.pdf'
    UseFileCache = True
    DefaultPath = 'c:\Sistema\'
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Compressed = False
    OpenAfterExport = True
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'Setes'
    Subject = 'Relat'#243'rio'
    ProtectionFlags = []
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 32
    Top = 64
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 112
    Top = 64
  end
  object frxRichObject1: TfrxRichObject
    Left = 200
    Top = 72
  end
  object frxDialog: TfrxDialogControls
    Left = 32
    Top = 120
  end
end

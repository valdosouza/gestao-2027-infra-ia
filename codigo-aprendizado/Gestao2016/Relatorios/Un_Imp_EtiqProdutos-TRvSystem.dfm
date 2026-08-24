object Fr_Imp_EtiqProdutos: TFr_Imp_EtiqProdutos
  Left = 242
  Top = 58
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsSingle
  Caption = 'Impress'#227'o de Etiquetas de produtos'
  ClientHeight = 601
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 331
    Width = 886
    Height = 136
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Lb_DetalhesPedido: TLabel
      Left = 2
      Top = 2
      Width = 882
      Height = 20
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'LISTA DE PRODUTOS ESCOLHIDOS PARA IMPRESS'#195'O DE ETQUETAS'
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object StrGrd_Escolhidos: TStringGrid
      Left = 2
      Top = 22
      Width = 882
      Height = 112
      Align = alClient
      Color = clCream
      ColCount = 12
      DefaultColWidth = 40
      DefaultRowHeight = 18
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StrGrd_EscolhidosDrawCell
      OnSelectCell = StrGrd_EscolhidosSelectCell
      ColWidths = (
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40
        40)
      RowHeights = (
        18
        18)
    end
  end
  object GrBx_Pesquisa: TGroupBox
    Left = 0
    Top = 0
    Width = 886
    Height = 140
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      886
      140)
    object Lb_Codigo: TLabel
      Left = 5
      Top = 14
      Width = 144
      Height = 14
      Caption = 'C'#243'digos (Interno / Fab./ Forn.)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Descricao: TLabel
      Left = 157
      Top = 14
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 575
      Top = 14
      Width = 30
      Height = 14
      Caption = 'Grupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBL_CD_BARRA: TLabel
      Left = 419
      Top = 14
      Width = 69
      Height = 14
      Caption = 'C'#243'digo Barras'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 727
      Top = 15
      Width = 49
      Height = 14
      Caption = 'SubGrupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 54
      Width = 186
      Height = 14
      Caption = 'Selecione a Tabela de Pre'#231'o desejada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 254
      Top = 54
      Width = 47
      Height = 14
      Caption = 'N'#186' Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 348
      Top = 54
      Width = 68
      Height = 14
      Caption = 'N'#186' Nota Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Empresa: TSpeedButton
      Left = 856
      Top = 68
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_EmpresaClick
    end
    object Label7: TLabel
      Left = 440
      Top = 51
      Width = 64
      Height = 14
      Caption = 'C'#243'd Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 6
      Top = 91
      Width = 118
      Height = 14
      Caption = 'Localiza'#231#227'o  no Estoque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 252
      Top = 91
      Width = 85
      Height = 14
      Caption = 'Marca do Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BuscaCodigo: TMaskEdit
      Left = 5
      Top = 29
      Width = 144
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object E_BuscaDescricao: TMaskEdit
      Left = 152
      Top = 29
      Width = 265
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object E_BuscaGrupo: TMaskEdit
      Left = 575
      Top = 29
      Width = 150
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object E_BuscaCodBarras: TEdit_Setes
      Left = 419
      Top = 29
      Width = 154
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object E_BuscaSubgrupo: TMaskEdit
      Left = 727
      Top = 29
      Width = 150
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
    end
    object Dblcb_Tabelas: TDBLookupComboBox
      Left = 5
      Top = 68
      Width = 244
      Height = 22
      KeyField = 'TPR_CODIGO'
      ListField = 'TPR_NOME'
      ListSource = Ds_Tabela
      TabOrder = 5
    end
    object E_BuscaPedido: TEdit_Setes
      Left = 254
      Top = 68
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = ''
    end
    object E_BuscaNota: TEdit
      Left = 347
      Top = 68
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Busca_Cd_Empresa: TMaskEdit
      Left = 439
      Top = 68
      Width = 67
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = ''
      OnExit = E_Busca_Cd_EmpresaExit
    end
    object ChBx_Nome: TCheckBox
      Left = 512
      Top = 51
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 12
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 633
      Top = 51
      Width = 121
      Height = 17
      TabStop = False
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = ChBx_FantasiaClick
    end
    object Cb_Busca_Empresa: TComboBox
      Left = 509
      Top = 68
      Width = 343
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
    end
    object E_busca_Localizacao: TMaskEdit
      Left = 5
      Top = 105
      Width = 244
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object Chb_Digitacao: TCheckBox
      Left = 537
      Top = 105
      Width = 260
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Executar a Pesquisa durante a digita'#231#227'o.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = Chb_DigitacaoClick
    end
    object E_busca_Marca: TMaskEdit
      Left = 251
      Top = 104
      Width = 278
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      Text = ''
      OnChange = E_BuscaCodigoChange
    end
    object Chbx_SaldoEstoque: TCheckBox
      Left = 537
      Top = 89
      Width = 305
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Somente Produtos com saldo de Estoque positivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = Chb_DigitacaoClick
    end
    object chbx_ProdutosInativos: TCheckBox
      Left = 537
      Top = 120
      Width = 260
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Mostrar os produtos Inativos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = Chb_DigitacaoClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 140
    Width = 886
    Height = 147
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object DBG_Pesquisa: TDBGrid
      Left = 2
      Top = 2
      Width = 882
      Height = 143
      Align = alClient
      Color = clCream
      DataSource = DS_Pesquisa
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clNavy
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = DBG_PesquisaTitleClick
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOFAB'
          Title.Caption = 'F'#225'brica'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 288
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_CODIGOBAR'
          Title.Caption = 'C'#243'digo de Barras'
          Width = 156
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GRP_DESCRICAO'
          Title.Caption = 'Grupo'
          Width = 183
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SBG_DESCRICAO'
          Title.Caption = 'SubGrupo'
          Width = 183
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_LOCAL'
          Title.Caption = 'Localiza'#231#227'o Estoque'
          Width = 370
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_QTDE'
          Title.Caption = 'Quantidade'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 538
    Width = 886
    Height = 63
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Sb_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 789
      Top = 5
      Width = 92
      Height = 53
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 790
      ExplicitTop = 4
      ExplicitHeight = 54
    end
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 695
      Top = 5
      Width = 92
      Height = 53
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitLeft = 692
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Imprimir: TSpeedButton
      AlignWithMargins = True
      Left = 601
      Top = 5
      Width = 92
      Height = 53
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Imprimir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ImprimirClick
      ExplicitTop = 6
    end
    object Sb_Produtos: TSpeedButton
      AlignWithMargins = True
      Left = 507
      Top = 5
      Width = 92
      Height = 53
      Hint = 'Cadastro de Produtos'
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Produtos - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4B9
        B9B9E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF9F9F97C7D9072727ED2D2D2FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3678D6530
        8D27486F47A9AAA9F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF4F4F4646A8D2050DB1239CC2C357487878BDEDEDEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA5D8B5937A5253C
        A1231F90091F7A16597458B9B9B9F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFECECEC576390164FE9185CFF124BFF093DFD0A29B4383D6C989898E8E8
        E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E1E1538D4D31A81E1D910331
        9E1B178D001D95031C960921731B677967C7C7C7FCFCFCFFFFFFFFFFFFFFFFFF
        E2E2E24A5E991A5AF50C52FF1B5EFF1852FF0B45FF0E4AFF1045F40E28A04648
        69A8A8A8F0F0F0FFFFFFFFFFFFFFFFFFD6D7D64C92422DAF1A169800199A0331
        A81E159800179900179A001AA103169507266E22778278D7D7D7FFFFFFD8D8D9
        3F5BA51D63FD135DFF1158FF2168FF1D5CFF114FFF1350FF1352FF1555FF1347
        E915298E57576EDCDCDCFFFFFFCACDCA43993628B51513A10014A30018A50430
        B12013A20015A30015A30015A30016A50018AB031295066A836AD1D2D5345AB3
        216CFF1965FF1964FF1762FF2670FF2466FF1759FF185AFF195BFF195BFF195D
        FF1B62FF1133B6BDBDBFE5E7E53FA32F21BC0F10AC0012AD0013AD0016AE042F
        B92111AC0012AD0012AD0011AD0012AD0012AE0017B7045D855B5373B82576FF
        1F6EFF1F6DFF1F6DFF1D6BFF2C78FF2A70FF2065FF2267FF2066FF1D64FF1F65
        FF216BFF1744C7C4C4C6C3CCC035CC260BB70010B70010B80010B80013B8042E
        C22217B9081CBB0C1DBC0E1CBB0C11B8010EB80013BE0460875E4D78C52A7FFF
        2576FF2576FF2576FF2374FF3281FF4083FF387CFF3B7EFF3D7FFF357AFF246F
        FF2775FF1A4AC6C4C4C6C6CDC334CF270AC1000EC1000EC1000EC1000FC3013C
        D1352DCB2134CB2834CB2938CC2C33CB2712C40510C70260895F507BC53088FF
        2B80FF2B80FF2B7FFF297EFF3C8DFF5094FF5796FF5996FF5896FF5C99FF468B
        FF2A7EFF1D51CAC4C4C6C7CFC434D62808CC000CCC000BCC0009CE0026CB1D3E
        BA332EC6233FD8364DDB4550DA4753DB4B3BD7310DD101618A5F527EC83692FF
        3189FF3189FF318AFF388DFF1C6CFF105FFF357FFF61A1FF77AFFF77AEFF75AD
        FF4192FF1E57CCC7C7C9C7D0C62BE52A03DA0008D60008D90129D32326B1170E
        A30015A90321BB1438D53057E5516BE7656CE86722DF195F8B5C5381CA3D9BFF
        3692FF3894FF3F96FF2073FF0B5EFF095DFF0558FF1465FF448CFF7BB5FF99C7
        FF71B4FF205FD0B1B1B4A47F72769C1F04D60000ED062ADB281CB91009B2000D
        B6000DB6000BB5000EB8001CC91240E13A76F17350EF4A5C8C595484CC42A4FF
        3E9CFF429DFF237BFF136BFF176DFF166BFF1468FF0E61FF065AFF1669FF559A
        FF84C6FF276AD5864843FB922FFF911EB872085EA12021C41D20D01F33CD2839
        CE2E3CD0313BD13037D02C2ECD2425CE1B31DC2A3DF33861905D5586CD48AFFF
        4CA7FF3F91FF438FFF4E96FF5196FF5295FF5193FF4D90FF478AFF397EFF2373
        FF2176FD966978FD9714FFB512FFB215FFA702F88107B7701878A9475EE56260
        EB6163E35C63E35C63E45C64E55E67E66240E63924C718A8B7A74F83CC74C9FF
        7CB9FF7BB5FF7EB6FF7BB4FF79B2FF77AFFF76ADFF74ACFF74AAFF75AFFF538F
        F896626DFFA109FFB500FFB412FFB617FFAF00FFB500FFAB00F07F07B5792982
        C06177F37979EF757AEF7680F17D51F44E29C71DA6B7A4FFFFFF8AA7DD4897FF
        85C2FFA0D0FF99C9FF93C5FF92C3FF91C2FF90C0FF8FBFFF91C3FF6A9DF0AD72
        5CFFAE01FFBC00FFB600FFBB14FFBC18FFB600FFB700FFB800FFBE00FFAC00E8
        7107A3AA5F91FD9999FA9857FE562EC821B9C4B6FFFFFFFFFFFFFFFFFFD3E0FD
        6394EC569FFFA1D3FFB8DDFFAED5FFAAD2FFAAD2FFAFD5FF78B0F6B87E51FFB8
        00FFC300FFBF00FFBE00FFC314FFC318FFBE00FFBF00FFBF00FFBF00FFC300FF
        AD00C69A60AFFFBD5CFF5B33C426C7CEC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC0D3FD558EEF71B0FEBFE3FFCFE9FFCAE5FF7AC2FF3968D3F0A11CFFCF
        00FFC700FFC700FFC700FFCA13FFCC1BFFC806FFC90AFFC90AFFC701FFC900FD
        B101C2A5635BFF673DC22DD5D9D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFAAC1F55092FF96C8FF89CCFF2975E8B0AAB8F8AC22FFD6
        00FFCF00FFCF00FFD000FFD31FFFD63FFFD924FFD626FFD72AFFD625FFD204FF
        BA02809F1746C83FE3E5E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF6F8FE8EAEED4D88EDD7D8DFEEEBEAF9B223FFDE
        00FFD600FFD800FFD811FFB91EFFAD18FFCA32FFE149FFE54AFFE34CFFE131FF
        CE0297724AF2F3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3DEDCFAB823FFE5
        00FFE000FFDD16FFBD1CFFAA00FFAB00FFAA00FFB91AFFD648FFEB6AFFF16CFF
        DC19A0725EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3DEDCFABB23FFEA
        00FFDF1CFFC218FFB400FFB700FFB800FFB800FFB500FFB400FFC31EFFE365FF
        E846A07256FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2DEDBFCBF22FFE5
        1CFFC91CFFC515FFCB26FFCD30FFCE34FFCF35FFCE33FFCD2CFFC71DFFCE14FF
        B828B19286FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E4E1FFB433FFE2
        48FFE158FFE060FFE062FFE061FFE061FFE060FFE061FFE162FFEC68FFBC40BA
        8772F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE9CFB7EFAB
        5DFFD86FFFF487FFEE80FFEB7CFFEB7CFFEB7CFFEC7EFFF684FEBB49BD9584FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFD
        FCF6C8A0EBAD61FFE78EFFFDA6FFF59CFFF49DFFFE9FF9B74CC0A294FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFBF4F0F7BD8EF2B871FFF4B7FFFFBCF3B150C4B0A7FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF6EAE2F4B480EEA456CEC0B8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Sb_ProdutosClick
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 467
    Width = 886
    Height = 71
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object Label3: TLabel
      Left = 495
      Top = 7
      Width = 97
      Height = 13
      Caption = 'Modelos de Etiqueta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Rg_Tipo: TRadioGroup
      Left = 3
      Top = 3
      Width = 101
      Height = 61
      Caption = 'Tipo de C'#243'digo'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'EAN'
        'UPC')
      ParentFont = False
      TabOrder = 0
    end
    object Pnl_ConfiguraEtiqueta: TPanel
      Left = 163
      Top = 8
      Width = 325
      Height = 56
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        325
        56)
      object Label2: TLabel
        Left = 6
        Top = 11
        Width = 143
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Tipo da Etiqueta a ser utilzada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object SB_Etiqueta: TSpeedButton
        Left = 295
        Top = 27
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SB_EtiquetaClick
      end
      object DBLCB_Etiqueta: TDBLookupComboBox
        Left = 6
        Top = 27
        Width = 283
        Height = 21
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'CGE_CODIGO'
        ListField = 'CGE_DESCRICAO'
        ListSource = Ds_Etiqueta
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 106
      Top = 3
      Width = 54
      Height = 61
      Caption = 'Altura'
      TabOrder = 2
      object E_Altura: TEdit
        Left = 4
        Top = 22
        Width = 42
        Height = 21
        TabOrder = 0
        Text = '1'
      end
    end
    object Cb_Modelos: TComboBox
      Left = 495
      Top = 22
      Width = 382
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = Cb_ModelosChange
      Items.Strings = (
        'Etiqueta c'#243'digo de barras'
        'Zebra GC420 - [Descri'#231#227'o e Pre'#231'o Medida]'
        'Zebra GC420 - [Descri'#231#227'o e Pre'#231'o] '
        'Etiqueta C'#243'digo Interno'
        'Etiqueta Localiza'#231#227'o Prateleira'
        'Etiqueta Argox - Envia Pe'#231'as (105 x 45mm)'
        'Etiqueta Elgin - [Descri'#231#227'o e Pre'#231'o Medida]'
        'Etiqueta Bobina Termica - [Descri'#231#227'o | Barras e Pre'#231'o] '
        'Etiqueta Argox -  [Descri'#231#227'o /Barras / Pre'#231'o]'
        'Zebra GK420T - [Descricao/Barras/Preco]'
        
          'Zebra GC420D - [Barras/Descricao/SKU/Localiza'#231#227'o/Data] 10cm X 2c' +
          'm'
        'Zebra ZD220 - [Descricao/Barras/Preco]'
        'Zebra ZD220 - [Descricao/Barras/Preco/Empresa]'
        'Etiqueta com imagem e detalhe')
    end
    object ChBx_Tipo: TCheckBox
      Left = 496
      Top = 45
      Width = 135
      Height = 17
      Caption = 'Etiquetas com Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object ChBx_visualiza: TCheckBox
      Left = 637
      Top = 45
      Width = 135
      Height = 17
      Caption = 'Visualizar na Tela antes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 287
    Width = 886
    Height = 44
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 5
    DesignSize = (
      886
      44)
    object SB_Add_Tudo: TSpeedButton
      Left = 3
      Top = 1
      Width = 114
      Height = 40
      Anchors = [akLeft]
      Caption = 'Adicionar todos'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333333333FFF3333333333333
        00333333333333FF77F3333333333300903333333333FF773733333333330099
        0333333333FF77337F3333333300999903333333FF7733337333333700999990
        3333333777333337F3333333099999903333333373F333373333333330999903
        33333333F7F3337F33333333709999033333333F773FF3733333333709009033
        333333F7737737F3333333709073003333333F77377377F33333370907333733
        33333773773337333333309073333333333337F7733333333333370733333333
        3333377733333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      OnClick = SB_Add_TudoClick
    end
    object SB_Adicionar: TSpeedButton
      Left = 117
      Top = 1
      Width = 114
      Height = 40
      Anchors = [akLeft]
      Caption = 'Adicionar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      OnClick = SB_AdicionarClick
    end
    object SB_Retirar: TSpeedButton
      Left = 231
      Top = 1
      Width = 114
      Height = 40
      Anchors = [akLeft]
      Caption = 'Retirar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      OnClick = SB_RetirarClick
    end
    object SB_Retirar_Tudo: TSpeedButton
      Left = 345
      Top = 1
      Width = 114
      Height = 40
      Anchors = [akLeft]
      Caption = 'Retirar Todos'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333FFF3333333333333707333333333333F777F3333333333370
        9033333333F33F7737F33333373337090733333337F3F7737733333330037090
        73333333377F7737733333333090090733333333373773773333333309999073
        333333337F333773333333330999903333333333733337F33333333099999903
        33333337F3333F7FF33333309999900733333337333FF7773333330999900333
        3333337F3FF7733333333309900333333333337FF77333333333309003333333
        333337F773333333333330033333333333333773333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      OnClick = SB_Retirar_TudoClick
    end
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 256
    Top = 112
  end
  object DS_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 256
    Top = 144
  end
  object Ds_Etiqueta: TDataSource
    DataSet = Qr_Etiqueta
    Left = 296
    Top = 144
  end
  object Qr_Etiqueta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_EtiquetaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  CGE_CODIGO,'
      '  CGE_DESCRICAO,'
      '  CGE_PG_ALTURA,'
      '  CGE_PG_LARGURA,'
      '  CGE_SUPERIOR,'
      '  CGE_INFERIOR,'
      '  CGE_DIREITA,'
      '  CGE_ESQUERA,'
      '  CGE_ET_ALTURA,'
      '  CGE_ET_LARGURA,'
      '  CGE_DIS_COLUNA,'
      '  CGE_TYPEFONTE,'
      '  CGE_SIZEFONTE,'
      '  CGE_PAGESIZE,'
      '  CGE_NR_COLUNA,'
      '  CGE_ETI_SUPERIOR'
      'FROM TB_CFG_ETIQUETA')
    Left = 296
    Top = 112
  end
  object Qr_Qtde: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT ITF_QTDE'
      'FROM TB_ITENS_NFL'
      'WHERE ITF_CODIGO = ('
      '    SELECT MAX(ITF_CODIGO)'
      '    FROM TB_ITENS_NFL I'
      '    WHERE ITF_CODPRO = :PRO_CODIGO'
      '    AND I.itf_oper = '#39'C'#39
      ')')
    Left = 336
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRO_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_MalaDireta: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    Constraints = <
      item
        FromDictionary = True
      end>
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT EMP_CODIGO, EMP_TIPO, EMP_FANTASIA, EMP_NOME, EMP_DT_FUND' +
        'A, EMP_DT_CADASTRO, END_ENDER,  END_CONTATO, END_BAIRRO, END_CEP' +
        ', CDD_DESCRICAO, UFE_SIGLA, END_COMPLEM'
      'FROM TB_EMPRESA tb_empresa '
      '   INNER JOIN TB_ENDERECO'
      '   ON (TB_ENDERECO.END_CODEMP = TB_EMPRESA.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE'
      '   ON (TB_CIDADE.CDD_CODIGO = TB_ENDERECO.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = TB_ENDERECO.END_CODUFE)')
    Left = 456
    Top = 384
  end
  object Qr_Tabela: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    AfterOpen = Qr_TabelaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * '
      'FROM TB_TABELA_PRECO'
      'ORDER BY TPR_NOME ASC')
    Left = 336
    Top = 8
  end
  object Ds_Tabela: TDataSource
    DataSet = Qr_Tabela
    Left = 364
    Top = 8
  end
  object ACBrETQ: TACBrETQ
    LimparMemoria = False
    Porta = 'LPT1'
    Ativo = False
    Left = 648
    Top = 379
  end
  object PopupMenu1: TPopupMenu
    Left = 432
    Top = 164
    object CadastrodoProduto1: TMenuItem
      Caption = 'Cadastro do Produto'
    end
  end
  object Rv_BarCode: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 608
    Top = 224
  end
  object Rv_CodigoInterno: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 712
    Top = 224
  end
end

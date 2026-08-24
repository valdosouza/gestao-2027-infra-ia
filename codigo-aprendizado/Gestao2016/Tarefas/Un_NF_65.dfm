object Fr_NF_65: TFr_NF_65
  Left = 362
  Top = 41
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o - Notas Fiscais'
  ClientHeight = 557
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Operacao
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 88
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 496
      Top = 3
      Width = 68
      Height = 14
      Caption = 'Nota Fiscal N'#186
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 3
      Width = 110
      Height = 14
      Caption = 'Natureza da Opera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 330
      Top = 3
      Width = 27
      Height = 14
      Caption = 'CFOP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 390
      Top = 2
      Width = 80
      Height = 14
      Caption = 'Data da Emiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 55
      Top = 43
      Width = 63
      Height = 14
      Caption = 'Raz'#227'o Social'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 455
      Top = 43
      Width = 68
      Height = 14
      Caption = 'C.N.P.J / C.P.F.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 4
      Top = 43
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object E_Nota: TDBEdit
      Left = 495
      Top = 18
      Width = 112
      Height = 22
      DataField = 'NFC_CODIGO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Natureza: TDBEdit
      Left = 4
      Top = 18
      Width = 324
      Height = 22
      DataField = 'NAT_DESCRICAO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Cfop: TDBEdit
      Left = 330
      Top = 18
      Width = 57
      Height = 22
      DataField = 'NAT_CFOP'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Dt_Emissao: TDBEdit
      Left = 389
      Top = 18
      Width = 104
      Height = 22
      DataField = 'NFL_DT_EMISSAO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
    end
    object E_RazaoSocial: TDBEdit
      Left = 53
      Top = 57
      Width = 397
      Height = 22
      DataField = 'EMP_NOME'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Cnpj_CPf: TDBEdit
      Left = 454
      Top = 57
      Width = 152
      Height = 22
      DataField = 'EMP_CNPJ'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_CodCli: TDBEdit
      Left = 4
      Top = 57
      Width = 48
      Height = 22
      DataField = 'EMP_CODIGO'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 452
    Width = 616
    Height = 43
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      616
      43)
    object Label17: TLabel
      Left = 505
      Top = 2
      Width = 78
      Height = 12
      Anchors = [akTop, akRight]
      Caption = 'Valor Total da Nota'
      FocusControl = E_VL_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 504
    end
    object E_VL_Nota: TDBEdit
      Left = 505
      Top = 14
      Width = 103
      Height = 22
      Anchors = [akTop, akRight]
      DataField = 'NFL_VL_TL_NOTA'
      DataSource = DS_Nota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 495
    Width = 616
    Height = 62
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    DesignSize = (
      616
      62)
    object Sb_Sair_0: TSpeedButton
      Left = 519
      Top = 4
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 515
    end
  end
  object Pg_Itens: TPageControl
    Left = 0
    Top = 88
    Width = 616
    Height = 364
    ActivePage = tbs_itens
    Align = alClient
    TabOrder = 3
    object tbs_itens: TTabSheet
      Caption = 'Produtos'
      inline Fm_Itens_Pedido: TFm_Itens_Pedido
        Left = 0
        Top = 0
        Width = 608
        Height = 336
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 608
        ExplicitHeight = 336
        inherited StrGrd_Itens_Pedido: TStringGrid
          Width = 608
          Height = 336
          ExplicitWidth = 608
          ExplicitHeight = 336
          ColWidths = (
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70
            70)
          RowHeights = (
            18
            18
            18
            18
            18)
        end
        inherited PopupMenu1: TPopupMenu
          inherited RegistraNmerodolote1: TMenuItem
            OnClick = Fm_Itens_PedidoRegistraNmerodolote1Click
          end
          object RegistraNmerodeSrie1: TMenuItem
            Caption = 'Registra N'#250'mero de S'#233'rie'
            OnClick = RegistraNmerodeSrie1Click
          end
        end
      end
    end
    object tbs_outras: TTabSheet
      Caption = 'Outras Informa'#231#245'es'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        608
        336)
      object Label40: TLabel
        Left = 4
        Top = 3
        Width = 116
        Height = 14
        Caption = 'Observa'#231#245'es do Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 2
        Top = 107
        Width = 92
        Height = 14
        Caption = 'Nome do Vendedor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label43: TLabel
        Left = 312
        Top = 107
        Width = 101
        Height = 14
        Caption = 'Forma de Pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object sb_obs_nfe: TSpeedButton
        Left = 299
        Top = 294
        Width = 152
        Height = 37
        Anchors = [akRight, akBottom]
        Caption = 'Observa'#231#245'es da N.F'
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
          333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
          333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
          C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
          F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
          F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
          00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
          3333333373FF7333333333333000333333333333377733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        Transparent = False
        OnClick = sb_obs_nfeClick
      end
      object Sb_Servico: TSpeedButton
        Left = 453
        Top = 294
        Width = 152
        Height = 37
        Anchors = [akRight, akBottom]
        Caption = 'Detalhe Servi'#231'o - F8'
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
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
          3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
          700077337F3333373777887007333337007733F773F333337733700070333333
          077037773733333F7F37703707333300080737F373333377737F003333333307
          78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
          078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
          70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
          3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
          33337F73FF737773333307800077033333337337773373333333}
        NumGlyphs = 2
        ParentFont = False
        Transparent = False
        OnClick = Sb_ServicoClick
      end
      object Sb_Financeiro: TSpeedButton
        Left = 145
        Top = 294
        Width = 153
        Height = 37
        Hint = 'Contas '#224' Receber'
        Anchors = [akRight, akBottom]
        Caption = 'Financeiro '
        Flat = True
        Glyph.Data = {
          36080000424D3608000000000000360400002800000020000000200000000100
          08000000000000040000120B0000120B00000001000000000000000001000000
          020099CC9900F5FFF50098CB9800F2FFF200F7FFF700F1FFF100EEFFEE0097CC
          970097CA9700CCFFCC00D0EFD000E9FFE900DBFFDB00EBFFEB00F9FFF900EDFF
          ED00CEFFCE0000CCFF00DDFFDD00E7FFE70095CA9500D8FFD800D5FFD5003399
          CC00E5FFE50098979800C8F4FF0096C9960043DAFF00E3FFE300E1FFE100D1FF
          D100D4F7FF00FBFFFB00D3ECD30037D7FF00DFFFDF006BE2FF002AD5FF0083E6
          FF00FFFFFF00BBF2FF0016D1FF00B0F0FF00C0E3C000A5EDFF00BFEFBF001FD3
          FF00B9DEB900D4EFD4007FE5FF00BDE1BD00D3FFD300D7FFD700BBECBB009DCD
          E6004CDBFF009BEBFF0094C9940000CBFF009ACD9A0086E7FF00C4E4C4007BE4
          FF00B4DCB40074E4FF004CA5D200ABD5EA00DFF9FF00CAF1CA005CDFFF00AFD8
          AF00C4EFC40064E0FF00FDFFFD00B8EAB800409FCF00D0ECD0008EC6E20077BB
          DD0054DDFF0093EAFF009DCF9D009FD09F00CCE5F2008CE9FF0081C0DF0003CD
          FF00ABD6AB0057ABD500C8E9C800A2D2A200B8DBED000ECFFF00A3D4A300D7EA
          F50063B0D70093C89300C6F2C6006CB5DA00C3E0EF009CCE9C00E0EFF700A7D2
          A700C8E5C800FEFFFE00A7D9A700D7F0D700E1F2E100B3E4B300D0E9D000CCEB
          CC00CCE7CC00E9F9E900E3F6E300EAF4F900EAFBFF00C3F5C300AFE0AF00DCF3
          DC00ACDCAC00A6D5A600C7F8C70009CEFF00E7F4E700C1E8C100CDF5CD00DEF6
          DE00C5E5C600D1F6D100C9FCC9009ACE9A00DBEEDB009A9F9B00F3F8FC00D7EC
          D700E5F8E500A2CDA200D6F3D600D1FAD100EFFCEF00ECF6EB00FBFEFF00DAF7
          DA0000C7FF00CDF9CD00F4FDFF009DC99D00EDF9ED00F0FAF000E4FBE400A2A5
          A200F4FDF400CCFCCC00ECFCEC00A2989500E1F9E100EBFCEB00A8ACA900DDFB
          DD0006CAFB00E8FCE800D5F8D500D6FCD600F7FAFD0098A49900D9FBD90005CC
          FF00DFFDDF00F7FDF700F1FDF100F2FCF20050CCC900E6FBE60062C7EB0008CB
          FC00F4FBF4009AC69A00D4FCD400B2B9B300DBFCDB00A7CC9000E2FCE20000CE
          FF007AD8F500FBFDFE00BDCCBD00EAFDEA00D2FDD20082E7FA00E6ECE600F9FF
          FA00C8D8C800D3E0D30070CFEF00F8FDF80090DEF60097C29700FFFFF600FAFD
          FA0059BAE1008EACAF00BDE4F300FFFFF9005BBDD100DFE6DF0018D0FA0002CF
          FF000ACDFA0040BFDC0026C6EC00FEFEF000FFFFFD007ABAC2006ADBE600EFF6
          E100ECF3D800F8FFF1002FD2F30074E2F10078ADB80011C9F60046D6EE00DEF1
          D1006FBCE0005AD2D50001D0FF0037C9E80097B49700EFFFEB00C8F3EC001CCC
          F300C1DAAA00FBFAEA00CDE1B60046C6E000A1E9EB0086E2E700D9E8C4000BD3
          FF009AE0D80086CCA6009DE8EB00C5EED800E2F5E900AEE6D500D8F3E700F1FF
          F200EEFCE6006ECCB600D9FBF0009BCC98009BCC970000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000119100000000000000000000000000000000000000000000000000
          00000002154F5507020000000000000000000000000000000000000000000000
          00001D60150904A3AC0200000000000000000000000000000000000000000000
          005C3E1A493E711D085D09000000000000000000000000000000000000000002
          1702421F020F0F1D2E05047B1B00000000000000000000000000000000000280
          0E022055780FAF1109064F3C1B27000000000000000000000000000000040418
          164720041A540A07601603161B1919130000000000000000000000000B04BE7C
          630E16470D026332030A73AB1B19191959000000000000000000020B7A543602
          178D042009711102077904031B44441919270000000000000000021202217804
          1704B6A83C0D116C090763321B625B44444E290000000000000000856C120236
          4D0226091A0C0F08028A050287516562625B44B7000000000000000212606C37
          022682A8710C0C9F081D03491B505858516565C8020000000000023012022155
          600E80471A1591334F0742061B453939505851C8490400000000020B0A6F1802
          174A8D261F1A0D0F240C0510875E5E45453950EC061654000000008404120236
          30A51426A11A150D114F4F031B565666665E39B7066E098E000000047C84127F
          1817A569327F8C0D0F086D1B5246686156665EEA6305025A080202040B773836
          1817B369427F4F0D0F081B342B1C2288756861CD0A7905020700020B0B4D3821
          18370E8B49351A150F1B533B2D2B1C22908875C8730403423C0000006C0B3830
          3018171426201A9EDF2A29532F2D2B1C222A2AB7031D6C070400000000022112
          3030170E142699132227433F533B2D2B1C2290B779060908AF02000000000002
          21BE647C141B481E3A4827433F532F2D2B1C34C80403351D0F02000000000000
          005537471B3431281E3A4827433F3B2F1C486A82066007093300000000000000
          000085D73B7D2C3125253A4827413F943D2A4C964005ACA30400000000000000
          000000341E137D2C31251E3A48439013C57E8610062E40085502000000000000
          000000003D2F3D5F2C28251E5257F706966E8972240335321102000000000000
          0000000000007D2A5F2C28283407050610237040329770810000000000000000
          00000000000000003F2D27250C9E050306236B2A234002000000000000000000
          000000000000000000133D161133240306104C6E960000000000000000000000
          000000000000000000000000027407242410C304000000000000000000000000
          0000000000000000000000000000020574060200000000000000000000000000
          0000000000000000000000000000000004000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = Sb_FinanceiroClick
      end
      object E_Ped_Obs: TDBMemo
        Left = 3
        Top = 18
        Width = 601
        Height = 89
        DataField = 'PED_OBS'
        DataSource = DS_Nota
        TabOrder = 0
      end
      object E_Vendedor: TDBEdit
        Left = 1
        Top = 124
        Width = 304
        Height = 22
        DataField = 'CLB_NOME'
        DataSource = DS_Nota
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_Prazo: TDBEdit
        Left = 310
        Top = 124
        Width = 294
        Height = 22
        DataField = 'PED_PRAZO'
        DataSource = DS_Nota
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object Qr_Nota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_NotaAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '      PED_CODIGO, '
      '    PED_NUMERO,'
      '      NFL_CODIGO, '
      '      PED_CODFPG,'
      '     PED_TIPO,'
      '      NAT_DESCRICAO, '
      '      NAT_CFOP, '
      '      EMP_CODIGO, '
      '      EMP_NOME, '
      '      EMP_CNPJ, '
      '      NFL_DT_EMISSAO, '
      '      NFL_BS_ICMS, '
      '      NFL_VL_ICMS, '
      '      NFL_BS_ICMS_SUBST, '
      '      NFL_VL_ICMS_SUBST, '
      '      NFL_VL_TL_NOTA,'
      '     NFC_CODIGO,'
      '     PED_OBS,'
      '    CLB_NOME,'
      '     PED_PRAZO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '      INNER JOIN TB_PEDIDO tb_pedido'
      '      ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '      INNER JOIN TB_EMPRESA tb_empresa'
      '      ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '      INNER JOIN TB_NATUREZA tb_natureza'
      '      ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)'
      ''
      ''
      '      INNER  JOIN TB_COLABORADOR tb_colaborador'
      '      ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      ''
      '      LEFT OUTER  JOIN TB_RETORNO_NFC'
      '      ON (NFC_CODNFL = NFL_CODIGO)'
      'WHERE (NFL_CODIGO=:NFL_CODIGO)  '
      ''
      '')
    Left = 72
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NFL_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_NotaPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
      Origin = '"TB_PEDIDO"."PED_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
      Origin = '"TB_PEDIDO"."PED_NUMERO"'
    end
    object Qr_NotaNFL_CODIGO: TIntegerField
      FieldName = 'NFL_CODIGO'
      Origin = '"TB_NOTA_FISCAL"."NFL_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaPED_CODFPG: TIntegerField
      FieldName = 'PED_CODFPG'
      Origin = '"TB_PEDIDO"."PED_CODFPG"'
      Required = True
    end
    object Qr_NotaPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
      Origin = '"TB_PEDIDO"."PED_TIPO"'
    end
    object Qr_NotaNAT_DESCRICAO: TStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = '"TB_NATUREZA"."NAT_DESCRICAO"'
      Size = 250
    end
    object Qr_NotaNAT_CFOP: TStringField
      FieldName = 'NAT_CFOP'
      Origin = '"TB_NATUREZA"."NAT_CFOP"'
      Size = 10
    end
    object Qr_NotaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = '"TB_EMPRESA"."EMP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_NotaEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Origin = '"TB_EMPRESA"."EMP_NOME"'
      Size = 100
    end
    object Qr_NotaEMP_CNPJ: TStringField
      FieldName = 'EMP_CNPJ'
      Origin = '"TB_EMPRESA"."EMP_CNPJ"'
      Size = 14
    end
    object Qr_NotaNFL_DT_EMISSAO: TDateField
      FieldName = 'NFL_DT_EMISSAO'
      Origin = '"TB_NOTA_FISCAL"."NFL_DT_EMISSAO"'
    end
    object Qr_NotaNFL_BS_ICMS: TBCDField
      FieldName = 'NFL_BS_ICMS'
      Origin = '"TB_NOTA_FISCAL"."NFL_BS_ICMS"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS: TBCDField
      FieldName = 'NFL_VL_ICMS'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_ICMS"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_BS_ICMS_SUBST: TBCDField
      FieldName = 'NFL_BS_ICMS_SUBST'
      Origin = '"TB_NOTA_FISCAL"."NFL_BS_ICMS_SUBST"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_ICMS_SUBST: TBCDField
      FieldName = 'NFL_VL_ICMS_SUBST'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_ICMS_SUBST"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFL_VL_TL_NOTA: TBCDField
      FieldName = 'NFL_VL_TL_NOTA'
      Origin = '"TB_NOTA_FISCAL"."NFL_VL_TL_NOTA"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_NotaNFC_CODIGO: TIntegerField
      FieldName = 'NFC_CODIGO'
      Origin = '"TB_RETORNO_NFC"."NFC_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object Qr_NotaPED_OBS: TBlobField
      FieldName = 'PED_OBS'
      Origin = '"TB_PEDIDO"."PED_OBS"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object Qr_NotaCLB_NOME: TStringField
      FieldName = 'CLB_NOME'
      Origin = '"TB_COLABORADOR"."CLB_NOME"'
      Size = 100
    end
    object Qr_NotaPED_PRAZO: TStringField
      FieldName = 'PED_PRAZO'
      Origin = '"TB_PEDIDO"."PED_PRAZO"'
      Size = 200
    end
  end
  object DS_Nota: TDataSource
    AutoEdit = False
    DataSet = Qr_Nota
    Left = 72
    Top = 224
  end
  object Mnu_Operacao: TMainMenu
    Left = 209
    Top = 2
    object Mnu_Operacao_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object Itm_CadastroDestinatrio: TMenuItem
        Caption = 'Cadastro Destinat'#225'rio'
        OnClick = Itm_CadastroDestinatrioClick
      end
      object Itm_Autorizar: TMenuItem
        Caption = 'Opera'#231#245'es NFC-e'
        OnClick = Itm_AutorizarClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ImprimirPedido1: TMenuItem
        Caption = 'Imprimir Pedido'
        OnClick = ImprimirPedido1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object RecalcularaComisso1: TMenuItem
        Caption = 'Recalcular a Comiss'#227'o'
        OnClick = RecalcularaComisso1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
end

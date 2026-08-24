inherited Fr_Caixa: TFr_Caixa
  Left = 263
  Top = 39
  Caption = 'Lancamentos no Caixa'
  ClientHeight = 607
  ClientWidth = 724
  Font.Name = 'MS Sans Serif'
  PrintScale = poPrintToFit
  ExplicitWidth = 730
  ExplicitHeight = 656
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel [0]
    Left = 0
    Top = 160
    Width = 724
    Height = 280
    Align = alClient
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Dbg_DetalheCaixa: TDBGrid
      Left = 2
      Top = 2
      Width = 720
      Height = 276
      TabStop = False
      Align = alClient
      Color = clMoneyGreen
      DataSource = Ds_Pesquisa
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      PopupMenu = Ppm_Caixa
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = Dbg_DetalheCaixaDrawColumnCell
      OnTitleClick = Dbg_DetalheCaixaTitleClick
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'MVF_DATA'
          Title.Caption = 'Data'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MVF_HISTORISCO'
          Title.Caption = 'Hist'#243'rico Interno'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 342
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MVF_VL_CREDITO'
          Title.Caption = 'Valor Cr'#233'dito'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MVF_VL_DEBITO'
          Title.Caption = 'Valor D'#233'bito'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FPT_DESCRICAO'
          Title.Caption = 'Forma de Pagamento'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLC_DEBITO'
          Title.Caption = 'Centro de Custo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLC_CREDITO'
          Title.Caption = 'Contas de Resultado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 300
          Visible = True
        end>
    end
  end
  object GroupBox3: TGroupBox [1]
    Left = 0
    Top = 440
    Width = 724
    Height = 101
    Align = alBottom
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = True
    object Label14: TLabel
      Left = 169
      Top = 16
      Width = 130
      Height = 13
      AutoSize = False
      Caption = 'Descri'#231#227'o do Historico'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 404
      Top = 16
      Width = 45
      Height = 13
      AutoSize = False
      Caption = 'Valor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 622
      Top = 16
      Width = 66
      Height = 13
      AutoSize = False
      Caption = 'Caixa do Dia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 483
      Top = 16
      Width = 37
      Height = 14
      Caption = 'Usu'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_HistoricoInterno: TMaskEdit
      Left = 160
      Top = 33
      Width = 240
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object CB_Caixa: TComboBox
      Left = 623
      Top = 33
      Width = 96
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 33
      Width = 77
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 81
      Top = 33
      Width = 80
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Enabled = False
      TabOrder = 1
    end
    object DBLCB_Usuario: TDBLookupComboBox
      Left = 482
      Top = 33
      Width = 135
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'USU_CODIGO'
      ListField = 'USU_LOGIN'
      ListSource = Ds_Usuario
      ParentFont = False
      TabOrder = 4
      OnKeyDown = DBLCB_UsuarioKeyDown
    end
    object ChBx_Periodo: TCheckBox
      Left = 6
      Top = 17
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 6
      OnClick = ChBx_PeriodoClick
    end
    object E_Valor: TEdit_Setes
      Left = 401
      Top = 33
      Width = 80
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      Text = ''
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 4
      Top = 56
      Width = 254
      Height = 42
      TabOrder = 7
      ExplicitLeft = 4
      ExplicitTop = 56
      ExplicitWidth = 254
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 248
      end
      inherited pnl_Forma: TPanel
        Width = 254
        Height = 28
        ExplicitWidth = 254
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 228
          Height = 25
          ExplicitLeft = 227
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 219
          Height = 22
          ExplicitWidth = 219
          ExplicitHeight = 22
        end
      end
    end
  end
  object Panel6: TPanel [2]
    Left = 0
    Top = 541
    Width = 724
    Height = 66
    Hint = 'Opera'#231#245'es com Registros'
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    DesignSize = (
      724
      66)
    object SB_AbreCaixa: TSpeedButton
      Left = 355
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Inciar|Inciar o Caixa'
      Anchors = [akRight, akBottom]
      Caption = 'Abre Caixa - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFE7D1CDCEA299E7D1CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF1E5E3C59186A75242B25D4CAC5F4FC69388F0E3E1FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBBC
        B5AC604FB15E4DB47E71BF9D92BD9285BB7263B26B5CDBBBB5FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7F6C9998EAA56
        44B67668C9B9B2D6D7D4E1EAEADBDDD9D0C4BDC38F82B56858CB9B91FAF7F6FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5EDEBBE8274AF5B49BB90
        84CBC7BFBD998DB27568C5A9A1BB8579C7A79ED5D1CAC8A69CBC7565C1897EF8
        F1F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5EBEAB77567B1604FC4AAA0DEE7
        E6BBA1959F48389E4A3AA04F3FA75C4DAA5F50C5ABA1E3ECEACEBDB4C07D6EC0
        847AF9F4F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFABA7F73AC5948C1A79FC4B7B1CAC3
        BFA97A708E372A8D372B8F3A2E97473C9A4C40B1877ED1D0CAD1C7C2CDB9B2BC
        7769C38F84FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEA7A09D4536B5928BB6A49C862F248735
        2B7C20167B1F15791D147A1E15822C2487342C8C3B3296554A9C564DC6B9B4C1
        A89FA95E51D7B6B1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF2E8E69341349A5A50D1D7D6BDB2AE7A261E6D09
        006D0C046B0C036B0B036C0C04731811781F197D2720812A238C463EC5C0BAD9
        DEDBAF7A729F554DF6F0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFBF928C832419AA918B9F7A7594635D6C0E056E10
        0670120870130972150A72150A771D137B231A7E2920802C2481312AA37973B5
        9F99BDA8A396463EC8A29EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF9F4F387352E853A33A3837D6803006F0E03761A0D781E
        117A20127A21137B22147B22147E2619822D2084312586352A88382E86342B86
        362EB9A49F9E615C954D47FBFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFDCC6C46A0601A0746FC1B6B39253497A1F107E2717812A
        1A832D1C832E1C842F1D842F1D85301E8835258A392A8C3C2E8D3E318C3E319F
        6A60CDC8C4B18F8A7D2820E1CFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFB88A8576170BB9A49ED2D2CFA36F648129178633208937
        238B39258C3A258D3B268D3C268D3B268E3D2890402E914332924535904233A9
        7A70D9DAD7C3B5AF8D3B31C29A96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF9E5C538A3A2FB59D948A3F2E8B3A288C39258F3F299243
        2C94462E95472F96482F97482F96482F95462E964731974A35974B38964B3998
        4F409C5D4EC2AFA89C5A4FA66A63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFAF7F7914338965547BCA59C8E3D2B8E3D2794462E984B329B4F
        359D52379E54399F55389F55399F54389E53379C50359C50379C513B9C513D99
        4F3B9C5343C4B5ACA87265985147FBF9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF0E6E48C3B2DA4685CE5E9EAC8B4AB95462C9C5136A0573AA35B
        3DA65F40A76142A86242A86242A86141A65F40A45C3EA2583AA0563BA0573F9C
        513AC4B6AAE8EAEBB17D7294493BF1E8E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE9DAD7893624AD8375D1C5BDB7917F9E5236A45C3EA86243AC67
        46AE6B49B06D4BB16E4BB16E4BB16D4AAF6B49AD6846AA6443A65E3FA35B3EA1
        583EB19882D0CDC3B69084914535EADBD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE6D4D08B3822B89789B07A67994728A76041AC6746B06E4BB473
        4FB77752B97953BA7B54BA7B54BA7A53B87852B5744FB26F4BAE6947A96142A5
        5D419D4D31B18470BE9F9390412EE6D4D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE3CFCB933E26C29B90CEBBB0B5846AAD6745B3714EB87853BD7E
        57C0835AC2865DC3875EC3885EC2865CC0835ABD7F57BA7953B5734EB06B49A9
        6140B17D64CFBBB1C4A09596442FE3CFCAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE3CEC998462CC39D8FF2FDFFD3BCADB26D49BA7B55C0825AC589
        5EC88E63CB9166CC9367CC9467CB9365C98F63C58A5FC1835BBC7C55B6744FAE
        6644CCAE9EF0FCFDC49E929A472FE2CDC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE4D0CA9C4B30C8A597CAAC9BB77E5EB97954C0835AC78C61CC93
        67D19A6CD49F6FD5A171D5A170D49F6ED19A6BCD9467C88D61C2845BBB7B55B5
        714DB17555C7A897C6A2959A482FE3CFC9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE5D2CCA3563ACDAD9FC5947DB46F48BF815AC78D63CF986DD5A0
        72DAA775DDAB78DEAD7ADEAC7ADCAA78D9A573D49D6ECE9568C78C61C0825AB9
        7853AB613BBD8971C8A5979B4A2FE4D0CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE6D4CEAA6247D1B1A3E8E6E0CFBDA8C48860D09C74D6A57ADDAD
        80E2B584E6BA86E8BC86E8BA84E4B580DFAE7AD9A674D39C6DCB9265C3875DBA
        7951CDAD97E2DFD8C8A3949C4C30E4D1CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE7D5CFB06B52D4B6A9EFF2F0DCD3C4CB9570D3A179DCAE84E3B8
        8CEAC08FEEC68FF2CA93F1CA93ECC189E4B47CDEA974D6A170CD9567C28557B8
        754BD6BEACEDF1F0C7A3949D4D31E5D1CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE8D6D0B5745DD8BDB2CBA892C49373D3BDA3E4D4BFE0BB96E5B9
        8BEBD1A9F4E8CDF9E1B6F8D296F1CF9EEDDEC2E1C7A1D49C68CD9768D5BB9FCD
        AC91B06F49C19881C9A6999D4C30E4D1CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE8D7D2B67760D1B3A6E0CABFD8B4A0EBEFE7FFFFFFF0DDCBEED2
        B6F0EEDEFFFFFFFFF7E8FBE3BDF9E8CFFFFFFFEEF4EBE2BE9DE0BFA4FBFEFFF4
        F3F2C79981D2B4A5CAA99C9B4A2EE4D0CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE7D6D0B16850C8A291ECE5DFEDE6E0EFE6DFF0E7DFF3EDE5F6F0
        E8F7F1E7F7F1E5F8F2E8F8F3EAF7F0E6F5ECDFF3E9DEF0E8DEECE3D8E6D9CDE2
        D4C8E0D4CADCD1C7B88B789E492FE1CCC6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFEDE1DDAF705DC99481D3A48FD1A791D6AD94DBB398E0B99CE6C0
        9EE9C4A0ECC7A0EDC79FECC59BE9BF94E3B68ADCAB80D49F75CB9168C08058B5
        6E48AB603DA75837A45437A25C46EADCD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF6EFEDDBC0B6CBA391CCA18DD3AA94D8B099DCB8A1DFBE
        A6E3C3A9E6C6AAE7C7ABE6C6A9E4C0A3DFB89AD9B192D2A687CB997AC38C6EB8
        7B5EAD6A4CB27761D1AEA2F3EBE8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F3F1EFE2DDF2E6E0F4E9E4F7F0EBF9F4
        F0FAF6F2FBF7F4FCF9F7FCF9F8FCF9F6FBF7F5FAF6F2F9F4F0F8F1EEF6EFEBF4
        ECE8F2E8E4F9F6F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AbreCaixaClick
    end
    object SB_Sair_0: TSpeedButton
      Left = 625
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Sair|Sair do Cadastro'
      Anchors = [akRight, akBottom]
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 677
    end
    object SB_Inserir: TSpeedButton
      Left = 69
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Novo|Novo cadastro'
      Anchors = [akRight, akBottom]
      Caption = 'Inserir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_InserirClick
    end
    object SB_Alterar: TSpeedButton
      Left = 166
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Editar|Modificar o Registro de Contas '#224' Receber'
      Anchors = [akRight, akBottom]
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_AlterarClick
      ExplicitLeft = 223
    end
    object SB_Excluir: TSpeedButton
      Left = 258
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Apagar|Apagar do Arquivo a Conta '#224' Receber'
      Anchors = [akRight, akBottom]
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 315
    end
    object SB_Buscar: TSpeedButton
      Left = 533
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Pesquisar|Pesquisa cadastro'
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 585
    end
    object Sb_Fechar_Caixa: TSpeedButton
      Left = 441
      Top = 6
      Width = 91
      Height = 54
      Hint = 'Inciar|Inciar o Caixa'
      Anchors = [akRight, akBottom]
      Caption = 'Fecha Caixa - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFCDE7CF99CE9ECDE7D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFE3F1E486C58C42A64C4CB2574FAC5A88C68EE1F0E2FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5DB
        BA4FAC594DB15771B77793C19784C18B63BC6C5CB265B5DBB9FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FBF78EC99544AA
        4F69B770B3CCB4D6D8D4EDE0E9DBDCDABED3BF82C48958B56291CB98F6FAF7FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBF5EC74BE7D49AF5484BD
        89C0D0C08EBF9368B270A1C7A479BB809FC9A2CCD8CB9DCBA165BD6F7EC186F0
        F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF5EB67B7704FB159A2C6A4E8DE
        E595C099389E423A9E443FA0484DA75650AA59A2C8A5ECE4E9B4D3B76EC1767A
        C081F2F9F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFDFB73BA7A49AC52A0C2A2B3C6B2C1CB
        BF71AB732A8E302B8D312E8F343C9741409A467FB381CBD3CAC4D2C4B3CFB569
        BC7184C38CFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0CEA4369E3E8CB68E9EB99D2486292B87
        2E157C19157B18147916157A182482262C872E328C354A994D4E9C51B5C9B4A0
        C4A251AA58B1D7B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE6F2E7349339519B53D9D0D6B1BDAF1E7B1F006D
        01046C05036B05036B04046C0511731219781A207D21237F253E8D3FBDC8BADE
        D8DB73B0754D9F51EFF6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF8CBF8E19831D8DAC8B77A0755E945E056D07066E
        0908700B09700C0A720E0A720E1377161A7B1D207E232480262A822A74A4739B
        B799A5BDA33E963F9EC89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF3F9F32E862F34853480A57E006900036F070D76131178
        17127A19137A1A147B1B147B1B197E1F20822725842B2A862F2E87322B862E2E
        8630A0BA9F5D9F5C479447FAFBFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC4DCC4016B0170A06FB5C1B34A924D107A18177E201A81
        231C83261C83271D84281D84281E852925882F2A8A332E8C36318D38318C3861
        A164C6CEC48BB38A207D21CFE1CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF85B8870B770FA1BA9FD2D2CF65A36917812220862C2389
        30258B32258C33268D34268D35268D34288E362E903A32913D35923F33903C70
        AB75D9D9D7B0C5AF318D3496C297FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF539E552F8A3496B8972E8B38288B33258C32298F382C92
        3C2E943F2F95402F96412F97412F96412E953F31964135974438974539964540
        984A4E9D56A9C4AA4F9E5363A666FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF7FAF738913D47984E9DBEA02B8E38278E362E943F329844359B
        48379D4B399E4D389F4E399F4E389F4D379E4C359C49379C4A3B9C4B3D9C4B3B
        9949439B4EADC8AE66AA6B47984CF9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE4F0E52D8C355CA364ECE4E9ACCAAF2C953F369C4A3AA0503DA3
        5440A65842A75A42A85B42A85B41A85A40A6583EA4553AA2513BA0503FA0513A
        9C4BAACAAEEDE6EA72B1793A9444E6F1E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD7E9D924892F75B17CBFD3C080BA8A369E4B3EA45543A85B46AC
        6049AE644BB0664BB1674BB1674AB16649AF6446AD6143AA5D3FA6573EA3543E
        A15181BC8BC4D6C584B98A35913ED8EADAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD0E6D2228B3089BC9067B17528994041A75946AC604BB0674FB4
        6C52B77053B97254BA7454BA7453BA7352B8714FB56D4BB26847AE6242A95A41
        A557319C4670B57C93C1992E903BD0E6D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCBE3CE26933790C198B0D2B66AB77C45AC604EB36A53B87257BD
        775AC07C5DC27F5EC3815EC3815CC27F5AC07C57BD7853BA724EB56C49B06440
        A95964B475B1D1B796C39D2F963DCAE3CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC9E3CC2C983E90C39AFFF4FBADD5B749B26655BA745AC07B5EC5
        8263C88866CB8B67CC8D67CC8D65CB8C63C9885FC5835BC17C55BC754FB66D44
        AE5F9ECEAAFDF2FA92C39A2F9A41C7E2CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCAE4CF309C4498C8A19BCDA75EB97754B9725AC07C61C78567CC
        8D6CD1936FD49871D59A70D59A6ED4986BD19367CD8D61C8865BC27D55BB744D
        B46A55B36D96CAA296C59E2F9A41C9E3CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCCE5D03AA34FA0CDA97EC49049B4685ABF7B63C7876DCF9272D5
        9975DAA078DDA47ADEA67ADEA678DCA373D99E6ED49668CE8E61C7855AC07B53
        B9713BAB5971BC8498C7A12F9B43CAE4CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCEE6D247AA5BA4D0AEE0EBE3A5D8B560C48274D0967AD69F80DD
        A784E2AF86E6B486E8B584E8B480E4AE7ADFA774D99F6DD39565CB8B5DC38051
        B97297D0A7D8E6DB95C79F309D45CAE4CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCFE7D352B065AAD4B4F0F1F0C3E4CD70CB8F79D39B84DCA88CE3
        B28FE9BA8FEFC093F2C493F1C489ECBB7CE4AD74DDA270D69A67CD8E57C27D4B
        B86DACD9B9F0EFEF94C7A0319D46CBE5CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD0E8D55CB56FB2D7BA91CDA272C78CA0DCB5BDE9CE96E2B68BE4
        B4A7F0CACAF9E3B4FBDB96F8CB9DF3CABFF3D89EE8BF67D49567CE8F9DDBB390
        D1A548B26781C49299C9A3309D45CAE4CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD2E8D660B671A7D0AFBFE0C8A0D7B1E5F2E9FFFFFFCBF0DAB6EE
        CFDAF8E9FFFFFFE8FFF6BDFBE0D0F9E6FFFFFFE6F8EE9DE2BAA4E0BBFFFBFEF3
        F4F381C795A5D2B19CCAA52E9B43CAE4CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD0E7D450B16192C99EDFEEE3E0EFE4DEF0E4DEF2E5E4F5EBE8F8
        EEE6F9EFE4FAEFE6FAF0E8FAF1E5F9EEDEF7E9DDF4E7DDF2E5D8EFDFCCE9D5C8
        E4D0CAE3D0C7DFCC77BA852F9E42C6E1CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDDEDDF5DAF6B81C9908FD39F91D2A294D6A998DBAE9CE0B59EE6
        BBA0E9BF9FECC29FEDC29BECC094E9B98AE3B080DCA575D49868CB8A58C07948
        B5663DAB5937A75037A44D46A256D8EADBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEDF6EFB6DBBD91CB9F8DCC9D94D3A599D8ACA1DCB4A6DF
        BAA9E3BFAAE6C3ABE7C3A9E6C2A3E4BC9ADFB492D9AC87D2A07ACB946EC3875E
        B8754CAD6461B272A2D1ABE8F3EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F8F3DDEFE1E0F2E5E4F4E8EBF7EFF0F9
        F3F2FAF5F4FBF7F7FCF8F8FCF9F6FCF8F5FBF7F2FAF5F0F9F3EEF8F1EBF6EEE8
        F4EBE4F2E7F4F9F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Fechar_CaixaClick
      ExplicitLeft = 498
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 724
    Height = 160
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    DesignSize = (
      724
      160)
    object Lb_Atual: TLabel
      Left = 590
      Top = 79
      Width = 127
      Height = 16
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Movimento Atual'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 647
    end
    object Lb_Ultimo: TLabel
      Left = 590
      Top = 3
      Width = 127
      Height = 16
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Movimento Anterior'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 647
    end
    object E_VL_Sld_Ant: TLabel
      Left = 590
      Top = 58
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0,00'
      Color = clBackground
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 590
      Top = 41
      Width = 127
      Height = 16
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Saldo Anterior'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 647
    end
    object Label26: TLabel
      Left = 590
      Top = 117
      Width = 127
      Height = 16
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Saldo Atual'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 647
    end
    object E_Dt_Ultimo: TLabel
      Left = 590
      Top = 20
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '00/00/0000'
      Color = clBackground
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object E_Dt_Atual: TLabel
      Left = 590
      Top = 96
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '00/00/0000'
      Color = clBackground
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object E_VL_Sld_Atual: TLabel
      Left = 590
      Top = 135
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0,00'
      Color = clBackground
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Dbg_Totalizador: TDBGrid
      Left = 2
      Top = 4
      Width = 582
      Height = 150
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clMoneyGreen
      DataSource = Ds_Totais_FPT
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = Dbg_DetalheCaixaTitleClick
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FPT_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o das forma de pagmentos'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 383
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MVF_VALOR'
          Title.Caption = 'Valor'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 156
          Visible = True
        end>
    end
  end
  inherited MnuBase: TMainMenu
    inherited arefas1: TMenuItem
      object EfetuarRetirada2: TMenuItem [0]
        Caption = 'Efetuar Retirada'
        OnClick = EfetuarRetirada2Click
      end
      object TransferirparaoBanco: TMenuItem [1]
        Caption = 'Transferir para o Banco'
        OnClick = TransferirparaoBancoClick
      end
      object RelatriodeCaixa2: TMenuItem [2]
        Caption = 'Relat'#243'rio de Caixa'
        OnClick = RelatriodeCaixa2Click
      end
      object RelatoriodeCheques2: TMenuItem [3]
        Caption = 'Relatorio de Cheques'
        OnClick = RelatoriodeCheques2Click
      end
    end
  end
  object Qr_Pesquisa: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT  MVF_CODIGO, MVF_CODCTB, MVF_DATA, MVF_CODHTB,  '
      
        '  MVF_CODPLC_C,  tb_ctacredito.PLC_DESCRICAO AS PLC_CREDITO,  MV' +
        'F_CODPLC_D,'
      
        '  tb_ctadebito.PLC_DESCRICAO AS PLC_DEBITO,  MVF_VL_CREDITO,  MV' +
        'F_VL_DEBITO,'
      
        '  MVF_HISTORISCO,  MVF_TIPO,  MVF_CODQTC,  MVF_CODUSU, FPT_DESCR' +
        'ICAO'
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro'
      '   INNER JOIN TB_PLANOCONTAS tb_ctacredito'
      
        '   ON (tb_ctacredito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC' +
        '_C)'
      '   INNER JOIN TB_PLANOCONTAS tb_ctadebito'
      
        '   ON (tb_ctadebito.PLC_CODIGO = tb_movim_financeiro.MVF_CODPLC_' +
        'D)'
      '  inner join tb_FormaPAgto '
      '  on (tb_FormaPAgto.FPT_CODIGO = tb_movim_financeiro.MVF_CODFPT)'
      'WHERE (MVF_CODCTB = 0)')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 49
    Top = 216
    object Qr_PesquisaMVF_CODIGO: TIntegerField
      FieldName = 'MVF_CODIGO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_PesquisaMVF_CODCTB: TIntegerField
      FieldName = 'MVF_CODCTB'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODCTB"'
      Required = True
    end
    object Qr_PesquisaMVF_DATA: TDateField
      FieldName = 'MVF_DATA'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_DATA"'
    end
    object Qr_PesquisaMVF_CODHTB: TIntegerField
      FieldName = 'MVF_CODHTB'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODHTB"'
    end
    object Qr_PesquisaMVF_CODPLC_C: TIntegerField
      FieldName = 'MVF_CODPLC_C'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODPLC_C"'
      Required = True
    end
    object Qr_PesquisaPLC_CREDITO: TStringField
      FieldName = 'PLC_CREDITO'
      Origin = '"TB_PLANOCONTAS"."PLC_DESCRICAO"'
      Size = 100
    end
    object Qr_PesquisaMVF_CODPLC_D: TIntegerField
      FieldName = 'MVF_CODPLC_D'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODPLC_D"'
      Required = True
    end
    object Qr_PesquisaPLC_DEBITO: TStringField
      FieldName = 'PLC_DEBITO'
      Origin = '"TB_PLANOCONTAS"."PLC_DESCRICAO"'
      Size = 100
    end
    object Qr_PesquisaMVF_VL_CREDITO: TBCDField
      FieldName = 'MVF_VL_CREDITO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_VL_CREDITO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaMVF_VL_DEBITO: TBCDField
      FieldName = 'MVF_VL_DEBITO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_VL_DEBITO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_PesquisaMVF_HISTORISCO: TStringField
      FieldName = 'MVF_HISTORISCO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_HISTORISCO"'
      Size = 100
    end
    object Qr_PesquisaMVF_TIPO: TStringField
      FieldName = 'MVF_TIPO'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_TIPO"'
      Size = 1
    end
    object Qr_PesquisaMVF_CODQTC: TIntegerField
      FieldName = 'MVF_CODQTC'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODQTC"'
    end
    object Qr_PesquisaMVF_CODUSU: TIntegerField
      FieldName = 'MVF_CODUSU'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODUSU"'
    end
    object Qr_PesquisaFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Required = True
      Size = 51
    end
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    OnStateChange = Ds_PesquisaStateChange
    Left = 49
    Top = 248
  end
  object Ds_Usuario: TDataSource
    DataSet = DM.Qr_ListaUsuario
    Left = 544
    Top = 384
  end
  object Qr_Totais_FPT: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      
        'SELECT MVF_CODFPT, fpt_descricao, CAST(SUM (MVF_VL_CREDITO - MVF' +
        '_VL_DEBITO) AS NUMERIC(18, 2)) as MVF_VALOR'
      'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro'
      '  LEFT JOIN tb_formapagto'
      '  ON (tb_formapagto.fpt_codigo = tb_movim_financeiro.mvf_codfpt)'
      'WHERE (MVF_CODCTB = 0)'
      'AND (MVF_CODMHA =:MVF_CODMHA)'
      'GROUP BY MVF_CODFPT,fpt_descricao'
      'having SUM (MVF_VL_CREDITO - MVF_VL_DEBITO) <>0')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 252
    Top = 75
    ParamData = <
      item
        Name = 'MVF_CODMHA'
        DataType = ftString
        Value = '1'
      end>
    object Qr_Totais_FPTMVF_CODFPT: TIntegerField
      FieldName = 'MVF_CODFPT'
      Origin = '"TB_MOVIM_FINANCEIRO"."MVF_CODFPT"'
    end
    object Qr_Totais_FPTFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Origin = '"TB_FORMAPAGTO"."FPT_DESCRICAO"'
      Size = 50
    end
    object Qr_Totais_FPTMVF_VALOR: TBCDField
      FieldName = 'MVF_VALOR'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object Ds_Totais_FPT: TDataSource
    DataSet = Qr_Totais_FPT
    Left = 248
    Top = 120
  end
  object Ppm_Caixa: TPopupMenu
    Left = 388
    Top = 267
    object AplicarPlanoContas1: TMenuItem
      Caption = 'Aplicar Plano Contas'
      OnClick = AplicarPlanoContas1Click
    end
  end
end

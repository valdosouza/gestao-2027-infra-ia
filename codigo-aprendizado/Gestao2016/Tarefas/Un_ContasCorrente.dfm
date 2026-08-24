object Fr_ContasCorrente: TFr_ContasCorrente
  Left = 270
  Top = 81
  BorderStyle = bsSingle
  Caption = 'Lan'#231'amento Banc'#225'rio'
  ClientHeight = 641
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_ContaCorrente: TPageControl
    Left = 0
    Top = 0
    Width = 786
    Height = 641
    ActivePage = tbs_ContaCorrente
    Align = alClient
    TabOrder = 0
    object tbs_ContaCorrente: TTabSheet
      Caption = 'tbs_ContaCorrente'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 778
        Height = 613
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          778
          613)
        object SB_Filtrar: TSpeedButton
          Left = 696
          Top = 2
          Width = 77
          Height = 58
          Hint = 'Pesquisar|Pesquisa cadastro'
          Caption = '&Filtrar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
            3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
            33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
            333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_FiltrarClick
        end
        object Panel2: TPanel
          Left = 2
          Top = 546
          Width = 774
          Height = 65
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            774
            65)
          object SB_Sair_0: TSpeedButton
            Left = 689
            Top = 4
            Width = 80
            Height = 56
            Hint = 'Sair|Sair do Cadastro'
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
            OnClick = SB_Sair_0Click
            ExplicitLeft = 685
          end
          object SB_Inserir: TSpeedButton
            Left = 288
            Top = 4
            Width = 80
            Height = 56
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
            ExplicitLeft = 284
          end
          object SB_Alterar: TSpeedButton
            Left = 368
            Top = 4
            Width = 80
            Height = 56
            Hint = 'Editar|Modificar o Registro de Contas '#224' Receber'
            Anchors = [akRight, akBottom]
            Caption = '&Alterar - F3'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_AlterarClick
            ExplicitLeft = 364
          end
          object SB_Excluir: TSpeedButton
            Left = 448
            Top = 4
            Width = 80
            Height = 56
            Hint = 'Apagar|Apagar do Arquivo a Conta '#224' Receber'
            Anchors = [akRight, akBottom]
            Caption = '&Excluir - F4'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_ExcluirClick
            ExplicitLeft = 444
          end
          object SB_Buscar: TSpeedButton
            Left = 522
            Top = 2
            Width = 80
            Height = 56
            Hint = 'Pesquisar|Pesquisa cadastro'
            Anchors = [akRight, akBottom]
            Caption = '&Buscar - F7'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_BuscarClick
          end
          object Sb_Antecipar: TSpeedButton
            Left = 608
            Top = 4
            Width = 80
            Height = 56
            Hint = 'Apagar|Apagar do Arquivo a Conta '#224' Receber'
            Anchors = [akRight, akBottom]
            Caption = 'Antecipar - F8'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              360C0000424D360C000000000000360000002800000020000000200000000100
              180000000000000C000074120000741200000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1E3E3E3FEFE
              FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFEFEFEF9F9F9FDFDFDFAFAFAE3E4E4DCDDDDC3C5C5B2B4
              B4EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFEAEBEBD8D9D9D0D1D1C6C8C8D7D8D8DBDCDCDADCDBD3D6D5C5C7
              C7B1B4B4C0C1C1FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFAFAFAE1E1E1E2E3E3E2E2E2DDDEDEDDDEDED9DADAD3D6D5CBCECDA8AA
              A9B4B5B5B6B9B9A5A7A7DDDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFDFDFDE1E1E1E1E1E1DFE0E0DCDDDDDADBDBD7D8D8D4D6D6CCCFCEA6A8
              A8A8A9A9B9BBBBB8BABAACAFAFAEAFAFF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F3F4F4DADCDCDEDFDFDFDFDFDDDEDEDBDCDCD7D8D8B7BFC2D0D4D3CCCFCEA7A8
              A8ABACACB9BBBBB9BBBBB8BABAB1B4B49C9F9FB8B8B8F8F8F8FFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9
              DBDCDCDADBDBD7D9D8D8D9D9DADBDBC7CDCE82959C414A4ED0D4D3CCCFCEA7A9
              A9AAABABB9BBBBB9BBBBB9BBBBB9BBBBB6B8B8A7A9A9A4A4A4E4E4E4FDFDFDFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              F6F6F6D7D9D9CBCECDACADADB9BABA71808547575D323638D1D5D4CCCFCEA8A9
              A9ADAFAFB9BABABABBBBBABCBCB9BBBBB9BBBB959696CBCBCBEAEAEAFDFDFDFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFDBDDDDCFD2D1B6B7B6ABADAD6D7B8045555A3D4243D2D5D4CBCFCEABAD
              ADAFB1B1B8BABABABBBBB9BBBBB9BBBBB9BBBBBFBFBFFCFCFCFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD8DBDAD0D2D1BABBBBACADAD76898E7B8D92A8B3B6C9CCCBB3B7B6A9AA
              AAAAACACB6B7B7BABCBCB9BBBBB9BBBBB9BBBBD7D8D8FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFD7DAD9D0D3D2BCBDBCABADADB8BDBDC7C8C8CFD0D08C91903D49465C64
              627E82819A9C9CA8AAAAB3B5B5B9BBBBBABBBBD4D6D6EEEFEFFAFAFAFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FEFEFED7DAD9D4D7D6C4C5C5C7C8C8D9DADAD4D5D59B9F9F434F4C3F4B483945
              42374240454E4D6C7170939594A5A6A6B1B2B2BEBFBFC6C8C8A9ACACCACBCBFD
              FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FBFBFBD2D4D4D9DBDADDDEDED4D5D4CDCFCEA9ADAC4D595645524F424E4B3C48
              4537424034403D2F3B38353F3D59605E888A8AA5A7A7C2C5C4ADAFAFA5A6A6A1
              A3A3D4D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F8F8
              EBECECDDDEDED5D6D6D4D6D5D1D2D2B6B9B856625F4E5A574A5754424E4B3F4B
              483A454336413E323D3B2E38362B35332A35324D5452A7ABAAAFB1B18C8D8DA5
              A6A69FA1A19EA0A0DEDEDEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE
              F3F3F3E2E3E3D5D6D6D4D5D5C3C5C5606B69586562505D5A4C5955465350414D
              4A3D4846374340333F3C2F3A382C3734293431495150B5B9B8B0B3B28E8F8FA5
              A7A7A5A6A6A3A5A59A9C9C969797E3E3E3FDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFF4F5F5DFE0E07D8684606D6A59666354615E4D5956475350434F
              4C3F4B483A454335413E313D3A2E3936515958464F52B1B5B5B0B3B2919292A4
              A6A6A5A7A7A5A7A7A4A6A6909191B0B0B0EAEAEAFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAECECC0C5C48F96954C54513038363D48
              45414C493D494637424035413E79807F3E474A465559AFB4B3B0B3B2959696A4
              A6A6A4A5A5A5A6A6A5A7A7A7A8A8FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F5DDDAD6B7B9
              B789918F56605E3F4A489396959A9C9C7D898DA3AAACA7A8A96C6B7484858694
              95959FA1A1A4A6A6A4A6A6B6B7B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCB18EB7855BFEFD
              FCFFFFFFD8DADAB5B8B7D2D2D2B0B1B1C3C5C5B9BABB463F522D233B2A213840
              3B4965646A8A8B8B9A9B9BA9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFAF7C67D36C17226CDAC
              8AFFFFFFE1E2E2C7C8C8CFD0D0C3C4C4B2B3B450495C352B442F263D2B223926
              1D3421192F261F3248444F747377F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9CDACC9822DC9822DC580
              2EDCCDBADEDDDCC2C3C3C0C1C1BABABB5A52663D324C382D473329422C233B27
              1E35231B311F172D1C14281C1528ABA9AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5A660CF953FD09135CDA1
              5FF1E8DAFFFFFFF4F4F4DADADB8C86944A3E5A4136523A304A3329422E253D2A
              2138251D3321192E292235ADABB0FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF7F1E7E7C993D6A03CCD9E
              46FDFBF9FFFFFFFFFFFFFFFFFFFFFFFFF9F9FAD3D1D7A5A0AB726C753B34442B
              2239271E35413B4DCCCBCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F1E0DDB044DCAE
              43EBDBB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDE8DAE0D7C6E8
              E6E6B7B4BCE4E3E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD289E2BC
              49DEBC60FDFCF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0C371D5B25BFF
              FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFAF0E9CC
              61E6C64EE9D494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EFE1D0A64BD4B169F9
              F5EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF6
              E0EBD25FE9CD51EFDEA3FFFFFFFFFFFFFFFFFFFFFFFFFDFCF9C89442E2CFB0FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFCF9E9F0DB7AEBD153ECD885FBF7E8FFFFFFFFFEFED6B086B98648FCFAF8FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFEF8EFC5EFD97DE7CA55E9D181D5AB61D2A972F7F1EBFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFEFCF7FBF5E4FDFBF5FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_AnteciparClick
            ExplicitLeft = 604
          end
        end
        object GroupBox2: TGroupBox
          Left = 2
          Top = 408
          Width = 774
          Height = 138
          Align = alBottom
          Caption = ' Digite sua op'#231#227'o de busca '
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label21: TLabel
            Left = 687
            Top = 52
            Width = 28
            Height = 14
            Caption = 'Valor:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 166
            Top = 54
            Width = 110
            Height = 13
            AutoSize = False
            Caption = 'Hist'#243'rico Banc'#225'rio:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 422
            Top = 54
            Width = 71
            Height = 13
            AutoSize = False
            Caption = 'Historico:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 593
            Top = 10
            Width = 74
            Height = 13
            AutoSize = False
            Caption = 'N'#250'mero Doc'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 9
            Top = 12
            Width = 54
            Height = 14
            Caption = 'Ordena'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_HistoricoInterno: TMaskEdit
            Left = 419
            Top = 69
            Width = 261
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
            TabOrder = 7
            Text = ''
          end
          object E_HistBancario: TMaskEdit
            Left = 164
            Top = 69
            Width = 252
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
            TabOrder = 6
            Text = ''
          end
          object E_Valor: TEdit_Setes
            Left = 684
            Top = 69
            Width = 80
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 8
            Text = ''
          end
          object E_Nr_Doc: TMaskEdit
            Left = 591
            Top = 25
            Width = 92
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
          object E_Data_Ini: TDateTimePicker
            Left = 5
            Top = 70
            Width = 77
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            Enabled = False
            TabOrder = 4
          end
          object E_Data_Fim: TDateTimePicker
            Left = 83
            Top = 70
            Width = 80
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            Enabled = False
            TabOrder = 5
          end
          object E_Dt_Original: TDateTimePicker
            Left = 685
            Top = 25
            Width = 83
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            Enabled = False
            TabOrder = 3
          end
          object ChBx_Dt_Orig: TCheckBox
            Left = 686
            Top = 8
            Width = 82
            Height = 17
            Caption = 'Data Original'
            TabOrder = 11
            OnClick = ChBx_Dt_OrigClick
          end
          object CB_Ordena: TComboBox
            Left = 7
            Top = 26
            Width = 102
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'DATA'
            Items.Strings = (
              'DATA'
              'HIST'#211'RICO'
              'LAN'#199'AMENTO'
              '')
          end
          object ChBx_Periodo: TCheckBox
            Left = 7
            Top = 55
            Width = 128
            Height = 12
            Caption = 'Data Inicial    Data Final'
            TabOrder = 12
            OnClick = ChBx_PeriodoClick
          end
          inline Fm_FormaPagto: TFm_FormaPagto
            Left = 5
            Top = 93
            Width = 278
            Height = 42
            TabOrder = 9
            ExplicitLeft = 5
            ExplicitTop = 93
            ExplicitHeight = 42
            inherited pnl_Forma: TPanel
              Height = 28
              ExplicitHeight = 28
              inherited SB_FormaPag: TSpeedButton
                Height = 25
                ExplicitLeft = 251
                ExplicitTop = 17
                ExplicitHeight = 28
              end
              inherited DBLCB_FormaPagto: TDBLookupComboBox
                Height = 22
                ExplicitHeight = 22
              end
            end
          end
          object RGp_Conciliacao: TRadioGroup
            Left = 285
            Top = 88
            Width = 236
            Height = 45
            Caption = 'Concilila'#231#227'o'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'Conferidos'
              'Pendentes'
              'Todos')
            TabOrder = 10
          end
          inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
            Left = 107
            Top = 10
            Width = 482
            Height = 41
            TabOrder = 1
            ExplicitLeft = 107
            ExplicitTop = 10
            ExplicitWidth = 482
            ExplicitHeight = 41
            inherited L_ContaBancaria: TLabel
              Width = 482
            end
            inherited Sb_ContaBancaria: TSpeedButton
              Left = 455
              Height = 26
              ExplicitLeft = 455
              ExplicitTop = 15
            end
            inherited DBLCB_ContaBancaria: TDBLookupComboBox
              Width = 446
              Height = 22
              ExplicitWidth = 446
              ExplicitHeight = 22
            end
          end
          object RG_TipoLancamento: TRadioGroup
            Left = 524
            Top = 89
            Width = 236
            Height = 45
            Caption = 'Tipo de Lan'#231'amento'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'Autom'#225'tico'
              'Manual'
              'Todos')
            TabOrder = 13
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 63
          Width = 771
          Height = 289
          Alignment = taRightJustify
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 2
          object StrGrd_Lancamento: TStringGrid
            Left = 2
            Top = 2
            Width = 767
            Height = 285
            Align = alClient
            Color = clMoneyGreen
            ColCount = 18
            DefaultColWidth = 40
            DefaultRowHeight = 18
            RowCount = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
            ParentFont = False
            PopupMenu = Ppm_Banco
            TabOrder = 0
            OnDblClick = StrGrd_LancamentoDblClick
            OnDrawCell = StrGrd_LancamentoDrawCell
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
        object Panel7: TPanel
          Left = 2
          Top = 3
          Width = 690
          Height = 57
          Alignment = taRightJustify
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 3
          object Label31: TLabel
            Left = 227
            Top = 20
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Total D'#233'bitos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label33: TLabel
            Left = 107
            Top = 20
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Total Cr'#233'ditos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label34: TLabel
            Left = 349
            Top = 20
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Saldo Atual'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label25: TLabel
            Left = 1
            Top = 20
            Width = 97
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Saldo Anterior'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Lb_Vl_Sld_Ant: TLabel
            Left = 1
            Top = 34
            Width = 97
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Credito: TLabel
            Left = 107
            Top = 34
            Width = 100
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Debito: TLabel
            Left = 227
            Top = 34
            Width = 100
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Sld_Atual: TLabel
            Left = 349
            Top = 34
            Width = 100
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 461
            Top = 20
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Valor Futuro'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Lb_Vl_Futuro: TLabel
            Left = 461
            Top = 34
            Width = 100
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 578
            Top = 20
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Saldo Futuro'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Lb_Vl_SLd_Futuro: TLabel
            Left = 578
            Top = 34
            Width = 100
            Height = 18
            Alignment = taCenter
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ChBx_MoverData: TCheckBox
            Left = 4
            Top = 3
            Width = 645
            Height = 17
            Caption = 
              'Mover as datas dos lan'#231'amentos com valor futuro e que n'#227'o foram ' +
              'confirmados/Conferidos'
            TabOrder = 0
          end
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 353
          Width = 389
          Height = 57
          Anchors = [akLeft, akBottom]
          Caption = 'Totalizador Saldo Atual'
          TabOrder = 4
          DesignSize = (
            389
            57)
          object Label10: TLabel
            Left = 135
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total D'#233'bitos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label11: TLabel
            Left = 4
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total Cr'#233'ditos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label13: TLabel
            Left = 257
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Saldo'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object E_VL_Tl_Credito_Atual: TLabel
            Left = 4
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E_VL_Tl_Debito_Atual: TLabel
            Left = 135
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E_VL_Tl_Saldo_Atual: TLabel
            Left = 257
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object GroupBox3: TGroupBox
          Left = 394
          Top = 353
          Width = 381
          Height = 57
          Anchors = [akLeft, akBottom]
          Caption = 'Totalizador Saldo Futuro'
          TabOrder = 5
          DesignSize = (
            381
            57)
          object Label1: TLabel
            Left = 135
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total D'#233'bitos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label8: TLabel
            Left = 4
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total Cr'#233'ditos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label9: TLabel
            Left = 257
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Saldo'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object E_VL_Tl_Credito_Futuro: TLabel
            Left = 4
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E_VL_Tl_Debito_Futuro: TLabel
            Left = 135
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E_VL_Tl_Saldo_Futuro: TLabel
            Left = 257
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
    object tbs_Antecipar: TTabSheet
      Caption = 'tbs_Antecipar'
      ImageIndex = 1
      object pn_geral: TPanel
        Left = 0
        Top = 0
        Width = 778
        Height = 547
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          778
          547)
        object SB_Add_Tudo: TSpeedButton
          Left = 4
          Top = 455
          Width = 109
          Height = 30
          Anchors = [akLeft, akBottom]
          Caption = 'Marcar todos'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_Add_TudoClick
        end
        object SB_Retirar_Tudo: TSpeedButton
          Left = 114
          Top = 455
          Width = 107
          Height = 30
          Anchors = [akLeft, akBottom]
          Caption = 'Desmarcar todos'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333333333333333333333333FFF33FF333FFF339993370733
            999333777FF37FF377733339993000399933333777F777F77733333399970799
            93333333777F7377733333333999399933333333377737773333333333990993
            3333333333737F73333333333331013333333333333777FF3333333333910193
            333333333337773FF3333333399000993333333337377737FF33333399900099
            93333333773777377FF333399930003999333337773777F777FF339993370733
            9993337773337333777333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          ParentFont = False
          OnClick = SB_Retirar_TudoClick
        end
        object StrGrd_Antecipa: TStringGrid
          Left = 2
          Top = 2
          Width = 774
          Height = 451
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          ColCount = 15
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 0
          OnClick = StrGrd_AntecipaClick
          OnDrawCell = StrGrd_AntecipaDrawCell
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
            40
            40
            40
            40)
          RowHeights = (
            18
            18)
        end
        object GroupBox4: TGroupBox
          Left = 7
          Top = 486
          Width = 210
          Height = 56
          Anchors = [akRight, akBottom]
          Caption = 'Totalizador'
          TabOrder = 1
          DesignSize = (
            210
            56)
          object Label14: TLabel
            Left = 4
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total Cr'#233'ditos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label15: TLabel
            Left = 105
            Top = 17
            Width = 100
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Total D'#233'bitos'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Lb_Vl_Rec_Sel: TLabel
            Left = 4
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Lb_Vl_Pag_Sel: TLabel
            Left = 105
            Top = 31
            Width = 100
            Height = 18
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object GroupBox5: TGroupBox
          Left = 228
          Top = 452
          Width = 545
          Height = 92
          Anchors = [akRight, akBottom]
          Caption = 'Valore Antecipa'#231#227'o'
          TabOrder = 2
          object Label17: TLabel
            Left = 6
            Top = 12
            Width = 55
            Height = 14
            Caption = 'Valor Juros'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 440
            Top = 49
            Width = 100
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'Valdo Liquido'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Lb_VL_Liquido: TLabel
            Left = 440
            Top = 65
            Width = 100
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0,00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label16: TLabel
            Left = 108
            Top = 53
            Width = 119
            Height = 14
            Caption = 'Historico do Lan'#231'amento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 6
            Top = 53
            Width = 85
            Height = 14
            Caption = 'Data Antecipa'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Vl_Juros: TEdit_Setes
            Left = 4
            Top = 27
            Width = 80
            Height = 21
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            Text = ''
            OnChange = E_Vl_JurosChange
            OnExit = E_Vl_JurosExit
          end
          object E_Historico: TEdit
            Left = 105
            Top = 67
            Width = 294
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 3
          end
          inline Fm_ListaHistoricoBancario: TFm_ListaHistoricoBancario
            Left = 85
            Top = 13
            Width = 456
            Height = 41
            TabOrder = 1
            TabStop = True
            ExplicitLeft = 85
            ExplicitTop = 13
            inherited Sb_Historico: TSpeedButton
              ExplicitLeft = 430
            end
            inherited DBLCB_Historico: TDBLookupComboBox
              OnKeyDown = nil
              ExplicitLeft = 3
              ExplicitWidth = 420
            end
            inherited Qr_HistBancario: TSTQuery
              Left = 199
              Top = 43
            end
            inherited Ds_HistBancario: TDataSource
              Left = 295
              Top = 44
            end
          end
          object E_Dt_Antecipacao: TDateTimePicker
            Left = 4
            Top = 67
            Width = 99
            Height = 22
            Date = 39580.356281493060000000
            Time = 39580.356281493060000000
            TabOrder = 2
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 547
        Width = 778
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          778
          66)
        object SB_Confirmar: TSpeedButton
          Left = 593
          Top = 5
          Width = 90
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Confirmar - F10'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_ConfirmarClick
          ExplicitLeft = 589
        end
        object SpeedButton1: TSpeedButton
          Left = 683
          Top = 5
          Width = 90
          Height = 54
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
          OnClick = SpeedButton1Click
          ExplicitLeft = 679
        end
      end
    end
  end
  object Ds_ContaBancaria: TDataSource
    AutoEdit = False
    Left = 156
    Top = 240
  end
  object Ds_Cliente: TDataSource
    Left = 176
    Top = 160
  end
  object Ppm_Banco: TPopupMenu
    Left = 444
    Top = 195
    object AplicarPlanoContas1: TMenuItem
      Caption = 'Aplicar Plano Contas'
      OnClick = AplicarPlanoContas1Click
    end
    object Adicionarantecipao1: TMenuItem
      Caption = 'Adicionar '#224' antecipa'#231#227'o'
      OnClick = Adicionarantecipao1Click
    end
  end
end

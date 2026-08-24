object Fr_Frete: TFr_Frete
  Left = 190
  Top = 111
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tabela de Frete '
  ClientHeight = 594
  ClientWidth = 1016
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundos: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 49
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 64
      Top = 5
      Width = 98
      Height = 14
      Caption = 'Descri'#231#227'o da Tabela'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 493
      Top = 5
      Width = 77
      Height = 14
      Caption = 'Valor Despacho'
      FocusControl = E_Vl_Despacho
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 596
      Top = 5
      Width = 48
      Height = 14
      Caption = 'Valor TAS'
      FocusControl = E_Vl_Tas
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 699
      Top = 5
      Width = 87
      Height = 14
      Caption = 'Valor GRIS m'#237'nimo'
      FocusControl = E_Vl_Gris_min
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 802
      Top = 5
      Width = 63
      Height = 14
      Caption = 'Taxa GRIS %'
      FocusControl = E_Aq_Gris
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 907
      Top = 5
      Width = 66
      Height = 14
      Caption = 'Valor Ped'#225'gio'
      FocusControl = E_Vl_Pedagio
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 5
      Top = 21
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 64
      Top = 21
      Width = 427
      Height = 21
      TabOrder = 1
    end
    object E_Vl_Despacho: TEdit
      Left = 493
      Top = 21
      Width = 101
      Height = 21
      TabOrder = 2
    end
    object E_Vl_Tas: TEdit
      Left = 596
      Top = 21
      Width = 101
      Height = 21
      TabOrder = 3
    end
    object E_Vl_Gris_min: TEdit
      Left = 699
      Top = 21
      Width = 101
      Height = 21
      TabOrder = 4
    end
    object E_Aq_Gris: TEdit
      Left = 803
      Top = 21
      Width = 101
      Height = 21
      TabOrder = 5
    end
    object E_Vl_Pedagio: TEdit
      Left = 907
      Top = 21
      Width = 101
      Height = 21
      TabOrder = 6
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 530
    Width = 1016
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Alterar: TSpeedButton
      Left = 340
      Top = 2
      Width = 78
      Height = 60
      Align = alRight
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
      ExplicitLeft = 334
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Excluir: TSpeedButton
      Left = 418
      Top = 2
      Width = 78
      Height = 60
      Align = alRight
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
      ExplicitLeft = 415
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Gravar: TSpeedButton
      Left = 496
      Top = 2
      Width = 78
      Height = 60
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GravarClick
      ExplicitLeft = 490
      ExplicitTop = 6
    end
    object SB_Cancelar: TSpeedButton
      Left = 574
      Top = 2
      Width = 78
      Height = 60
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 580
      ExplicitTop = 6
    end
    object Sb_Sair_0: TSpeedButton
      Left = 936
      Top = 2
      Width = 78
      Height = 60
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
      ExplicitLeft = 930
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Ins_Coluna: TSpeedButton
      Left = 730
      Top = 2
      Width = 103
      Height = 60
      Align = alRight
      Caption = 'Nova Coluna - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_Ins_ColunaClick
      ExplicitLeft = 724
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object Sb_Ins_Destino: TSpeedButton
      Left = 833
      Top = 2
      Width = 103
      Height = 60
      Align = alRight
      Caption = 'Novo Destino - F9'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_Ins_DestinoClick
      ExplicitLeft = 827
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Envia_web: TSpeedButton
      Left = 652
      Top = 2
      Width = 78
      Height = 60
      Align = alRight
      Caption = 'Internet - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF7F7F7F3F3F3F4F4F4F3F3F3F3F3F3F2F2F2B6B6B65C5C
        5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C797979F0F0F0F4F4F4F4
        F4F4F4F4F4F4F4F4F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC4C4C4C5C5C5C5C5C5C5C5C5C3C3C3B5B5B5A2A2A29D9D
        9D9C9C9C9B9B9B9A9A9A989898979797969696959595A7A7A7C2C2C2C5C5C5C5
        C5C5C5C5C5C5C5C5C9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE4E4E4EEEEEEECECECEAEAEAE8E8E8E5E5E5C3C3C3B7B7
        B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7C3C3C3ECECECEDEDEDEB
        EBEBE9E9E9E7E7E7DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC9C9C9BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCECECEF0F0
        F0EDECEBEAE7E6E6E3E1E2DEDCDFDBD8DBD7D4D4D4D3D7D7D7C2C2C2BFBFBFBF
        BFBFBFBFBFBFBFBFCECECEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4AAA9
        A9B1ACA9A7A5A39C9C9CA1A1A1939291B0AAA6A8A7A6B3B3B3FDFDFDFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFF1F0F0D7D7D7E3E3E3BABAB9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFAF7F7E3D8D6C9BBB8CFC0BDB3A39FF9F5F5FEFEFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7F7D5BCB8AE77
        6AA05A3DA8613CB87A57AB6130A4572A9F5836AA705ECCADA5F6F1F0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDD7BFBC9E5A48A5582AB770
        2DD6A975EACEA8EBCFA6E7C99DE5C69CDEBA8FCC9A69B16D3CA25F45C9A9A1FB
        F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7F7B88C86AA664BC08553CC9657D5A3
        5EE3BE80F8E9CEFBEED6F8E5C1EFD4A5E4C28FDEB98ABF7D35B26B2CA1552BA6
        6B5EF3EBEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFAF7F7AF7C75A35835AE6428B8732DBE7C2CCA8C
        33DFB568F7E5C0FCEFD3FBEDD0F7E4BFEDD2A6DEBA8AC18341B26B2AAE63289F
        5126985343F1E8E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFEFDFDB2847E974627A65826AC6228B5702CC1802ED5A2
        51E9C888F9E7C4FAE9C5F9E6BEF8E7C6F4DFBAE5BD83BE7E32B06928A65A24A1
        53239846209B584DF9F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFD1B6B38D38239D4D26A25322AD6327B87328CC954ADCAF
        65F5DFB7F6DFB1F5DDABF4D9A2F1D39AEDCC92EDCFA2D4A05EB56F28AA5E239E
        4E2097451F8F3A1FB68984FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF9F5F593493F913A1D9B4921A45622B16929C28541D09B52EACB
        9BF4DFB8F4DCAFF3D9A7F1D59EEECF95E7C181DFB372DEB681BB7C38AD6425A3
        552197451E903A1D924437EADDDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFCDAFAC882F1E913A1BA05128AB622DBC7E45CA9558C3832CDEB4
        73F2DBB3F2D8AAF1D5A2EFD099EBC789D19738C88A2FC07F2BC58D4FB06D31A3
        592499491F913A1B954937AF7D78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFEFEFEA1655E8B331F984626A05225AF6935C08751BB782EC1812ED3A0
        55EFD4A9EED1A2E9C68CD8A44DCE912FCA8D2FC5862EBF7D2BB77229BD804AA7
        5B249B4C20903D1C8F3C26934941F9F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF7F2F18C3B318D361F943F1C9F5022A95F28BE834DB57129D1A36BC386
        34CC933FCC9036CC8F32CB8E31C98B30C68730BE7E2BB97729B26E28AE6626B2
        6F3F9D4D1F95401C8E3E28944638E1D0CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE7DAD88C372A8C341C953F1CA05024B77A4EAF682AD8AF85DFBC95CE9B
        5CC68837CA8E3CC6872FC5862DC3832CC1802DBD7A2AB87328B26B27AA6124A7
        5F2DB7774CB671499B4E369F5946C9A7A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDBC6C48E392C8D351D9641209E4D22B97C53DDBC9ED7AF8AD7AF86D7AE
        80CD995AC38537CA934ECB9552BE7C2ABC792BB97428B46E27AF6727A95E23A7
        5B28C68C62BC7C53B3704FA7634CBB918DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFD8C0BF903D318E3720923D1CA55B37C49170E4C7AEC48E62CEA075D8B0
        87D2A677D3A675D3A776D1A36FBA772CB7732BB46E28B06826AB6225A65922AC
        6332C18356C28763B3704EA75E46B88D89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE0CDCB8B3429923F2A923C1EAA6546CEA389EFDCC9D9B493E4C5A8E8CC
        AED3A77CCE9F70CFA071CE9E6FB77431B26B28AF6625AC6224A75C24A25422A8
        5E30BE7E53D2A890B46E4CA35B44C29B97FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF1E9E8862D22974838A0563FB2745BDEC0ADEED9C7EBD3BBEFD8C1ECD3
        B7E5C6A6CB996EC48D5CB47032AF6525AD6426AB6024A75C24A456229F4F209E
        4F25BA784FBE8262B069499E5440D6BCBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFDFBFB934A42A25C4FB88273B77D68E8D1C3EED9C8EBD2BCE8CDB2E6C6
        A8E9CCAEDBB28DBA7A44AC6227AA5F25A95E26A65A24A355229F4F1F9B4A1F9B
        4923B5714BB16B49AD6547974A3CF2EBEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFB88B88B1786FAF7465C49688EAD7CBEEDACBECD5C2ECD4BEE3C1
        A4DFB999DCB38FC68E63B67241AA612EA75C2BA152219E4E219B491F984620B2
        6C46A25534A4583BA85F44A2655EFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFEBDFDEA5655EB68076BB887ACEA698F1E1D6EAD4C2E8CDB6E4C5
        ABCB9876D3A380D9AD8AB8774DAA6339A05124AD69459A481F97441F94401EA7
        5D3C8B331A872C1A9F5543D3B8B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFB58883BA8780C2948AB57C6DD7B4A6EDDACDEBD4C4E0C0
        A9A0532CB97A56B67550AA6542B87C5C9C4C25A45B3A9C4E2D974423A15434B5
        73549F533A994C3D9E5D57FCFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF5EFEFA56863C79D96BC897FC08E81E9D3C6E7CDBCE6CA
        B9CD9F88B87C60C69276A45938C388659A49289B4A2B944124954328A55D45C2
        8B74AB6A57964839E4D5D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE5D6D5AF7872C39790BD8D83D6B4A8E7CFC0DEBE
        ACC79782AF6B4EA96246B4765BCD9D82BC8570B77F6DAD6E5DAC6953AC6954BA
        7E689E5446CFB2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3D2D0B17B76C59A94D5B4ABE8D2C6C99D
        8FBB8676A7624FA45B41BB7E62BA7E64A05844A56151B37662B77B66B87C66A0
        5949CEAFACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E8E7B2807CBC8B85CDA7A0C79C
        93B47C71AD6F639F5647A25B4DA25C4DA15A4DA05A4EAF7060AF6F5DA05D54E2
        D1CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDDAC3C1B07C77BE8E
        86C69991C49890B7827AB78077AF7165AA685AA25B4EA4655CCBAAA6FBF9F9FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF1E8
        E8D2B6B4C19996BC8F8ABA8C86BE938ECCABA8EADDDCFDFCFCFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Envia_webClick
      ExplicitLeft = 646
      ExplicitTop = 6
      ExplicitHeight = 54
    end
  end
  object StrGrd_Frete: TStringGrid
    Left = 0
    Top = 49
    Width = 1016
    Height = 481
    Align = alClient
    Color = clCream
    DefaultColWidth = 40
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 3
    FixedRows = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goColMoving, goEditing, goTabs]
    ParentFont = False
    PopupMenu = PpM_Grid
    TabOrder = 2
    OnDrawCell = StrGrd_FreteDrawCell
    OnSelectCell = StrGrd_FreteSelectCell
    ColWidths = (
      40
      40
      40
      40
      40)
    RowHeights = (
      18
      18
      18)
  end
  object Pnl_Escala: TPanel
    Left = 350
    Top = 256
    Width = 281
    Height = 129
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    Visible = False
    DesignSize = (
      279
      127)
    object Lb_Caption_Escala: TLabel
      Left = 2
      Top = 2
      Width = 275
      Height = 16
      Align = alTop
      Caption = 'CADASTRO DE ESCALAS  - COLUNAS'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 269
    end
    object Label15: TLabel
      Left = 6
      Top = 21
      Width = 75
      Height = 14
      Caption = 'Valor da Escala'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Grv_Coluna: TSpeedButton
      Left = 71
      Top = 21
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Grv_ColunaClick
      ExplicitLeft = 117
      ExplicitTop = 67
    end
    object Sb_Can_Coluna: TSpeedButton
      Left = 149
      Top = 21
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Can_ColunaClick
      ExplicitLeft = 195
      ExplicitTop = 67
    end
    object E_VL_Escala: TEdit_Setes
      Left = 4
      Top = 36
      Width = 104
      Height = 21
      Alignment = taRightJustify
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      Text = '0,00'
      OnExit = E_VL_EscalaExit
    end
  end
  object Pnl_Destinos: TPanel
    Left = 288
    Top = 64
    Width = 443
    Height = 169
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    Visible = False
    DesignSize = (
      441
      167)
    object Lb_Caption_Destino: TLabel
      Left = 2
      Top = 2
      Width = 437
      Height = 16
      Align = alTop
      Caption = 'CADASTRO DE DESTINOS - LINHAS'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 257
    end
    object Lb_Local: TLabel
      Left = 63
      Top = 64
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 9
      Top = 65
      Width = 16
      Height = 14
      Caption = 'U.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 327
      Top = 24
      Width = 56
      Height = 14
      Caption = 'Valor A.D.V'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Grv_Destino: TSpeedButton
      Left = 279
      Top = 107
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Grv_DestinoClick
    end
    object Sb_Can_Destino: TSpeedButton
      Left = 357
      Top = 107
      Width = 78
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Can_DestinoClick
    end
    object RG_TipoLocal: TRadioGroup
      Left = 5
      Top = 21
      Width = 185
      Height = 43
      Caption = 'Defina o Tipo do local'
      Columns = 2
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Cidade'
        'Local')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnClick = RG_TipoLocalClick
    end
    object DBLCB_Cidade: TDBLookupComboBox
      Left = 61
      Top = 79
      Width = 374
      Height = 22
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'CDD_CODIGO'
      ListField = 'CDD_DESCRICAO'
      ListSource = DM.Ds_Cidades
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
    object DBLCB_UF: TDBLookupComboBox
      Left = 8
      Top = 79
      Width = 52
      Height = 21
      Ctl3D = True
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      ParentCtl3D = False
      TabOrder = 2
    end
    object E_VL_ADV: TEdit_Setes
      Left = 328
      Top = 39
      Width = 103
      Height = 21
      Alignment = taRightJustify
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      Text = '0,00'
      OnExit = E_VL_ADVExit
    end
    object E_Localidade: TEdit
      Left = 73
      Top = 79
      Width = 374
      Height = 21
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
    end
  end
  object Ds_Empresas: TDataSource
    DataSet = DM.Qr_Empresas
    Left = 96
    Top = 440
  end
  object Qr_Adicao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  ADC_CODIGO,'
      '  ADC_CODDIM,'
      '  ADC_NUMERO,'
      '  ADC_SEQUENCIA,'
      '  ADC_CODFAB,'
      '  ADC_VL_DESC,'
      '  ADC_PEDCPA,'
      '  ADC_ITMCPA'
      'FROM TB_ADIC_IMP'
      'WHERE ADC_CODDIM =:ADC_CODDIM')
    Left = 168
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADC_CODDIM'
        ParamType = ptUnknown
      end>
  end
  object Ds_Adicao: TDataSource
    DataSet = Qr_Adicao
    Left = 170
    Top = 448
  end
  object PpM_Grid: TPopupMenu
    Left = 272
    Top = 200
    object ExcluirColuna: TMenuItem
      Caption = 'Excluir Coluna'
      OnClick = ExcluirColunaClick
    end
    object ExcluirLinha: TMenuItem
      Caption = 'Excluir Linha'
      OnClick = ExcluirLinhaClick
    end
  end
  object Qr_AtualizaDestino: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_FRETE_DESTINO (FDT_CODIGO, FDT_CODFRT, ' +
        'FDT_CODCDD, FDT_ADV, FDT_LOCAL)'
      
        '                                VALUES (:FDT_CODIGO, :FDT_CODFRT' +
        ', :FDT_CODCDD, :FDT_ADV, :FDT_LOCAL)'
      '                              MATCHING (FDT_CODIGO);')
    Left = 256
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FDT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDT_CODFRT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDT_CODCDD'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDT_ADV'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDT_LOCAL'
        ParamType = ptUnknown
      end>
  end
  object Qr_AtualizaPeso: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_FRETE_PESO (FPS_CODIGO, FPS_CODFRT, FPS' +
        '_VALOR,FPS_POSICAO,FPS_LARGURA)'
      
        '                             VALUES (:FPS_CODIGO, :FPS_CODFRT, :' +
        'FPS_VALOR,:FPS_POSICAO,:FPS_LARGURA)'
      '                           MATCHING (FPS_CODIGO);')
    Left = 400
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FPS_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPS_CODFRT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPS_VALOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPS_POSICAO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPS_LARGURA'
        ParamType = ptUnknown
      end>
  end
  object Qr_AtualizaDestinoPeso: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_FRETE_DESTINO_PESO (FDP_CODFDT, FDP_COD' +
        'FPS, FDP_VALOR, FDP_CODFRT)'
      
        '                                     VALUES  (:FDP_CODFDT, :FDP_' +
        'CODFPS, :FDP_VALOR, :FDP_CODFRT)'
      
        '                                   MATCHING (FDP_CODFDT, FDP_COD' +
        'FPS,FDP_CODFRT);')
    Left = 528
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FDP_CODFDT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDP_CODFPS'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDP_VALOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FDP_CODFRT'
        ParamType = ptUnknown
      end>
  end
  object Qr_FreteDestino: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT FDT_CODIGO, FDT_CODFRT, FDT_CODCDD, FDT_ADV, FDT_LOCAL'
      'FROM TB_FRETE_DESTINO '
      'WHERE FDT_CODFRT =:FRT_CODIGO'
      'ORDER BY FDT_LOCAL')
    Left = 264
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FRT_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_FretePeso: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT FPS_CODIGO, FPS_CODFRT, FPS_VALOR,FPS_POSICAO,FPS_LARGURA'
      'FROM TB_FRETE_PESO '
      'WHERE FPS_CODFRT =:FRT_CODIGO'
      'ORDER BY FPS_POSICAO')
    Left = 400
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FRT_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_DestinoPeso: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT FDP_VALOR'
      'FROM  TB_FRETE_DESTINO_PESO'
      
        'WHERE (FDP_CODFDT =:FDT_CODIGO) AND  (FDP_CODFPS =:FPS_CODIGO) A' +
        'ND (FDP_CODFRT=:FRT_CODIGO)')
    Left = 528
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FDT_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FPS_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FRT_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 336
    Top = 256
  end
end

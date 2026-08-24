object Fr_Imp_MapaCarga: TFr_Imp_MapaCarga
  Left = 496
  Top = 76
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mapa de Carregamento'
  ClientHeight = 541
  ClientWidth = 680
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
  object Pg_MapaCarga: TPageControl
    Left = 0
    Top = 0
    Width = 680
    Height = 541
    ActivePage = TabSheet1
    Align = alClient
    Anchors = [akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Grb_MnhaEmpresa: TGroupBox
        Left = 0
        Top = 0
        Width = 672
        Height = 50
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          672
          50)
        object chbx_Empresas: TCheckBox
          Left = 7
          Top = 8
          Width = 165
          Height = 14
          Caption = 'Selecionar todas as Empresas'
          TabOrder = 0
          OnClick = chbx_EmpresasClick
        end
        object Dblcb_Mha_Empresa: TDBLookupComboBox
          Left = 5
          Top = 24
          Width = 564
          Height = 21
          Anchors = [akLeft, akRight]
          KeyField = 'EMP_CODIGO'
          ListField = 'EMP_NOME'
          ListSource = DM_ListaConsultas.Ds_ListaEstabelecimento
          TabOrder = 1
        end
      end
      object Pnl_Fundo: TPanel
        Left = 0
        Top = 50
        Width = 672
        Height = 397
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          672
          397)
        object Label3: TLabel
          Left = 4
          Top = 42
          Width = 63
          Height = 13
          Caption = 'Pedido Inicial'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 81
          Top = 42
          Width = 58
          Height = 13
          Caption = 'Pedido Final'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 331
          Top = 42
          Width = 46
          Height = 13
          Caption = 'Vendedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SB_Add_Tudo: TSpeedButton
          Left = 4
          Top = 360
          Width = 109
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Marcar todos'
          Enabled = False
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
          Left = 115
          Top = 360
          Width = 107
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Desmarcar todos'
          Enabled = False
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
        object Label6: TLabel
          Left = 151
          Top = 42
          Width = 53
          Height = 13
          Caption = 'Data Inicial'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 242
          Top = 42
          Width = 48
          Height = 13
          Caption = 'Data Final'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 4
          Top = 3
          Width = 80
          Height = 14
          Caption = 'Tipo de Relat'#243'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_PedINI: TMaskEdit
          Left = 4
          Top = 57
          Width = 70
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
        end
        object E_PedFIM: TMaskEdit
          Left = 75
          Top = 57
          Width = 71
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
        end
        object DBLCB_Vendedor: TDBLookupComboBox
          Left = 332
          Top = 57
          Width = 337
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'CLB_CODIGO'
          ListField = 'CLB_NOME'
          ListSource = DM_ListaConsultas.DS_ListaVendedor
          ParentFont = False
          TabOrder = 4
          OnKeyDown = DBLCB_VendedorKeyDown
        end
        object E_Data_Ini: TDateTimePicker
          Left = 148
          Top = 57
          Width = 89
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 2
        end
        object E_Data_Fim: TDateTimePicker
          Left = 238
          Top = 57
          Width = 88
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          TabOrder = 3
        end
        object CB_Tipo: TComboBox
          Left = 4
          Top = 18
          Width = 230
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 5
          Text = 'Agrupado por produtos'
          OnChange = CB_TipoChange
          Items.Strings = (
            'Agrupado por produtos'
            'Agrupado por vendedor'
            'Dados financeiros'
            'Carga por Forma de Pagamento')
        end
        object StrGrd_Pedido: TStringGrid
          Left = 4
          Top = 84
          Width = 661
          Height = 254
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          ColCount = 9
          DefaultColWidth = 40
          DefaultRowHeight = 18
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentFont = False
          TabOrder = 6
          OnClick = StrGrd_PedidoClick
          OnDrawCell = StrGrd_PedidoDrawCell
          OnKeyDown = StrGrd_PedidoKeyDown
          ColWidths = (
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
        object GroupBox2: TGroupBox
          Left = 225
          Top = 338
          Width = 443
          Height = 56
          Anchors = [akRight, akBottom]
          Caption = 'Digite os dados para salvar ou imprimir o mapa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object Label5: TLabel
            Left = 5
            Top = 13
            Width = 81
            Height = 13
            Caption = 'Placa do ve'#237'culo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 92
            Top = 14
            Width = 88
            Height = 13
            Caption = 'Nome do motorista'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object E_Placa: TMaskEdit
            Left = 5
            Top = 28
            Width = 82
            Height = 22
            Ctl3D = True
            EditMask = '>LLL-0000;0;_'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            MaxLength = 8
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            Text = ''
          end
          object E_Motorista: TMaskEdit
            Left = 91
            Top = 28
            Width = 347
            Height = 22
            Ctl3D = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
        end
        object Rg_Agrupamento: TRadioGroup
          Left = 238
          Top = 6
          Width = 234
          Height = 34
          Caption = 'Agrupamento'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Itens do Pedido'
            'Ficha de Estoque')
          TabOrder = 8
        end
        object ChBx_NaoMostraLote: TCheckBox
          Left = 478
          Top = 12
          Width = 115
          Height = 17
          Caption = 'N'#227'o mostrar Lote '
          TabOrder = 9
        end
      end
      object Pnl_Botao: TPanel
        Left = 0
        Top = 447
        Width = 672
        Height = 66
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          672
          66)
        object SB_Imprimir: TSpeedButton
          Left = 44
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
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
        end
        object SB_Filtrar: TSpeedButton
          Left = 226
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Filtrar- F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C0000110B0000110B00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFEDEDEDA4A4A49E9E9EE4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFB9B9B9A2A2A2919191878787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFC9C9C99F9F9FAFAFAF8E8E8EF2F2F2FEFEFEFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFC0C0C0969696B6B6B6989898E1E1E1EDEDEDFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFBCBCBC898989AFAFAF9A9A9ADEDEDED5D5D5E7E7E7F9F9F9FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFC0C0C06060607B7B7B888888DEDEDED1D1D1D1D1D1D9D9D9EAEAEAF9
            F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFB8B8B85B5B5B6E6E6E767676DEDEDED1D1D1D1D1D1D0D0D0D1D1D1DA
            DADAEBEBEBFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF7676765454547F7F7F8F8F8FCECECED5D5D5D1D1D1D1D1D1D1D1D1D0
            D0D0D2D2D2DCDCDCEDEDEDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFA8A8A82727275E5E5E9B9B9BCFCFCFA9A9A9DFDFDFD0D0D0D0D0D0D1D1D1D1
            D1D1D1D1D1D0D0D0D2D2D2DDDDDDEDEDEDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7
            E73838384F4F4F979797C2C2C2E6E6E6E9E9E9C0C0C0E6E6E6D8D8D8D2D2D2D0
            D0D0D1D1D1D1D1D1D0D0D0CFCFCFD7D7D7ECECECFDFDFDFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7474
            744C4C4C7A7A7A9E9E9EBABABAD0D0D0DDDDDDB8B8B8F9F9F9FBFBFBE7E7E7D4
            D4D4D0D0D0D1D1D1D2D2D2D5D5D5E4E4E4FAFAFAFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB6B6B64040
            405A5A5A6E6E6E7D7D7D8D8D8D939494888888949494BEBEBEFFFFFFFEFEFEF0
            F0F0E5E5E5E9E9E9F0F0F0F5F5F5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDED5252525151
            516C6C6C7E7E7E9495959D9D9DA4A5A5999A9A7C7C7C838383DBDBDBFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C8C8C5050506565
            657B7B7B969696A4A4A5ABACACA8A8A89B9C9C7B7B7B6D6D6D8B8B8BFEFEFEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2C2C25151516161617B7B
            7B979798A3A3A4B6B6B7BFBFBFB1B2B29D9D9E8787886767676E6E6EB8B8B8FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F36A6A6A6060607B7B7B9898
            98A8A8A8B7B6B6C0C0C0D7D8D9C6C7C8ACADAE9394946E6E6E6B6B6B858585E6
            E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9797976060607171719A9A9AA5A3
            A4B2B1B1C7C7C7CCCCCCCECFCFC2C3C4ACADAE999A9A7575756F6F6F7C7C7CAE
            AEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF646464676767858585A3A3A3AFAE
            AFC3C3C3CFCFCFDCDBDCCACACABCBEBEAFB0B0A3A4A59A9A9B7D7D7D8888889C
            9C9CC5C5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF9F9F98282826D6D6D7272728080809D9D9DB9B8
            B8D1CFD0D8D8D9DAD9DAC9C9C8B0B1B1AAABACA6A8A8AFB1B199999A8D8D8D98
            9898B1B1B1F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFA8A8A87272726C6C6C7272727B7B7B898989A3A2
            A2B0AFB0B1B1B1AEAEAF9E9E9E8C8C8C959697989999A5A7A7B4B5B595959599
            9999989898C2C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFDADADA4B4B4B5050505959596363636D6D6D7272727B7B
            7B807F7F8282828080807F7F7F7D7C7D787979868686A0A0A0B7B8B8ACADAD98
            99988F8F8F848484C9C9C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF848484585858696969818181959595A2A2A2A3A3A3B9B9
            B9DFDBDCEAE8E9E4E4E4D9D8D9DAD7D9C6C5C6E1E3E4E3E5E5E1E3E4E2E5E597
            98985C5C5C5C5C5C6E6E6EF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFEFEFEFA9A9A97777776767676464646464646363636B6B
            6BD0CCCCDBD7D9EAEAEAD0D0D0D7D5D7CAC8CAC4C5C6DDE0E0DADDDDC8CBCC91
            9293363636565656BDBDBDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF8F8F8EDEDEDE1E1E1D5D5D5CCCC
            CCDFDCDCD2CFCFE6E5E6DEDEDFD6D6D7D8D6D8C2C0C1CED0D0CCCFCFB4B6B7B6
            B8B9E9E8E8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFF7F7F7D3CECED9D7D9EAE9EAD3D3D4D9D8D8D7D6D7BDBCBEC9CBCCC7C8C9BD
            BEBFDEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFCFCFCDAD4D5D1CFD1E2E1E2DEDEDED5D4D4D7D5D7D5D3D3C9C9C9CBCECEBE
            C0C1D1D1D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFEFEFEDEDADAD3CFD0D6D4D6E8E7E8D4D4D4DAD9D9DEDEDEDCDCDBCAC7C8D1
            D2D2CBCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFE5E3E3D8D1D1D4D2D5D6D4D5D5D5D4D2D3D3D4D2D2D2CECEE2E0E0FF
            FFFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFF1F1F1D8D1D1D5D3D4D6D6D7D5D2D2D4D0D0DCDADAF9F9F9FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFBFCFCDAD7D7D3CCCDCECBCCE1DEDFF8F8F8FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFE8E9E8E8E7E7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_FiltrarClick
        end
        object Sb_Sair_0: TSpeedButton
          Left = 579
          Top = 6
          Width = 88
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
        end
        object Sb_RetiraPedido: TSpeedButton
          Left = 138
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Retirar - F3'
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
            FFC9E1C894BC9087AA8482AB7FBDC3BDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF77AD735ED15C63DC6156C45299A398FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF7AAF7767F8684CFF4D65DE639BA49BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF0F1F0E5E5E5DDE3
            DD61995E62F46244F54463D762879E85CAD2CAD7D7D6E2E2E2F0F0F0FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F6F1B3BFB278A974509F4D4EA64A4EA8
            4A53B04F66F56644EF434CD74B24A9212EB42C28AB244AAB4777A974A4B3A2DC
            DEDCFCFCFCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFC4DDC361A05C59C5565FDF5D57F35657FD5757FE
            5859FB584DEF4C41E74036E53529E7282DE32C29E3292CDA2C21CC1E31BB2E55
            9A509BA89AF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFCFDFC9EC59A4FA94B64ED6451FF5245FB4540F4403EF03E3CEC
            3C3AE9383EE73C41E5403FE23E43E14041DD4043DB4242DA403CDA3B28D92720
            CF1F2CA6277B9A79ECECECFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFA0C79C51B44E5FFC5F43FC443FF63F42F44141F0413DED3D51F4
            5066F4654DEA4D42E44060F0605DEA5C5BEB5A47E1453ED53C41D43F44D1413D
            D13A21D52028B424829A80F2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFC8E0C64FAA4B5FFC6041FC4141F64142F34142F1413EEE3E51F65159CC
            5742973D5DE85C45EA4362D660408C3A45A8415CDC5C4CE04B3ED03C40CF3D41
            CC3E42CB4022D3212FA72AAEB7ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF71AD6C5FE95E40FC413DF63D3FF43D3EF03E3BEC3B4FF84E5BC958549D
            4D559D5062EE6144E84360D85E8AA188AFD1AD4C9C475DDB5B43D3403FCC3C3F
            CB3D40C73E3CC93921C320689C64E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            CFE3CD5CC45A67FF6757FF5759FF5959FF5958FE5957FE5861F66149A044D5E2
            D382B87E62ED6144E64362DB609DA59CFFFFFFB4D6B14FB24B53E1513CC83A3F
            C93D3FC43C40C23D2BCC29309F2CD2D4D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            B7D6B5439F4056B15256AF5256AF5256AF5256AF5258B154479E426E9F6BFFFF
            FF7DB47962ED6144E44362DC60979E96FFFFFFE7F3E654AF4F57E5563BC6393F
            C63C3FC23C42C03F27D42624A820BFC9BEF4F5F4FFFFFFFFFFFFFFFFFFFFFFFF
            FAFCFAF5F9F5F6F9F6F6F9F6F6F9F6F6F9F6F6F9F6F6F9F6F5F9F5FCFDFCFFFF
            FF7CB77862EC6144E24362DB5FA2AAA2FFFFFF80B87C52BF4F4DD94C3DC43A3F
            C33C3FC13C41C53E25D72523A71FBFC8BEF7F8F7FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF739C7064F16344E0425FD35C5E88595E9A5948AC455AE25A3EC73B3FC33C3E
            C13B3DC43A3DCB3A28D62730A32CD3DCD2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF0EAC5CA
            C456845266F06542DB4168E06749AB4453C8505AE35943CC413EC33B3FC13C3D
            C43B3CCA3936D4341FC91D549950F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E7DF90B08E72A27072CA7069E4
            6661DB5F4CDC4B3FD33D51E04F55E55350DC4F3EC93D3EC43B3FC23C3EC33B3E
            C83B3BCE391FD91E2CA728ACCEA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFEDF4EC7CB17953B15064E86261EA614FE34F45E1
            4446DF443FD23C40D03D3DCC393CC93A3DC73A3FC63C3FC23C3EC13B3FC73C37
            CF351FD91F2AB3287FB47AF8FBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFD3E6D15FA55B65D96459F15742E0413CDC3B3FD93D3FD6
            3D3FD43D40D13E40CF3D40CC3D3FCA3D41C63E43C2403FC13C3BC9392DD22B20
            D01F30A72C7AB275F4F9F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFEBF4EA60A65B64E1634CED4A3DDD3B3FDC3E40D93F40D73E40D5
            3E3FD13D3FCF3C40CD3D40CA3E3FC73C34CA3128D0272AD02822C62030AC2C5F
            A35AB3D2B0FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF8DBD8A5FCA5D50EF4F3EDE3C40DD3F40DB3E40D73E40D43E3ED2
            3D45D74242CF3F40CA3E3CC83A29D2272CBE2927AB233BAA3780B97CC6DCC3F5
            F9F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF0F7F056AE5258EC573EE13B40DD3F40DB3F40D93E3FD53D41D53F55E0
            535FD55C62E86141CE3F57CA554D844A99C596D1E4CFF8FAF8FEFFFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD6E8D563B06079F17743DE423EDB3D3CD83A3ED63C3ED23C5CE55B5BB8
            5845923F61E36043CD4063DC61A0A69FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFC3DEC162A55E9DF19E7DE77C69E16853DB5145D4434CE14B51BC4EBDD7
            BB81B67D61E36043CA4062DB5F9AA498FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD6E8D464AA619BF19B84E78288E68686E48478DF7682E9815DAB59FFFF
            FF7DB27962E56142C93F61D95FA8B3A7CDDECB547C515A87575A87585A87575A
            88575B88585C8859558252B6BBB5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF1F7F061A85E91E79084E78285E48385E38388E1868AE28886CB8475AA
            7162A05E5BDE5A41CB3E5ED45C6B9167589A535CD35954E9524EE84B4CED4B4A
            F1494BF54A5AF6584AAE45BDC4BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF89BA8585CC828DEC8C84E28285E18385DF8383DE828CE08B84CD
            817DC37A75D67349D0476DD66C6FB36A73CF7283EC8281EE8080F07F7FF47E7D
            F67D80FF7F6CDC6972AF6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFDEEDDD63A45F95E09388E68684DF8284DE8384DD8383DB8288DE
            868DDF8B8CDD8A7FDD7D84E18386E88581EC807DEB7B7CEE7A7AF1797AF5787B
            FE7A6FE86E4C9E46DAEAD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFC2DCC05B9F5693DA918FE58D88E08783DB8183D98183D8
            8282DA8081DD7F81E17F7FE47E7EE77C7CE97B79ED7879F3787EFA7D7CFB7B6D
            DC6C4B9C45BBD8B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFC8DEC65D9E5877BA7385D1838EDC8C91DF8F85DD
            8485E2847FE07D7FE37D7EE87D80EF7E84F38391F78F86EC8674D7725BB1576A
            A965DBEBDAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9F2E9AFCEAC71AA6D5B9F5668B16475C1
            7060B05C8EE38D81EA807FD37D67BB6474C17060A85B68A86484B580C5DCC3F7
            FAF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFDFCF7FAF6F5F9F5E5F1
            E46EA869A8EFA7A1FBA08CD28A8AA587E3EFE2F2F7F2FAFCFAFEFFFEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF7DB0795AA45669AD6551A14CB5BDB4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_RetiraPedidoClick
        end
        object Sb_Pesq_MapaCarga: TSpeedButton
          Left = 491
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Pesquisar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Pesq_MapaCargaClick
        end
        object Sb_Salvar: TSpeedButton
          Left = 314
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Salvar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_SalvarClick
        end
        object Sb_Apl_Lote: TSpeedButton
          Left = 402
          Top = 6
          Width = 88
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar Lote - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Apl_LoteClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 672
        Height = 59
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label36: TLabel
          Left = 7
          Top = 15
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Pedido'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Placa: TLabel
          Left = 86
          Top = 15
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Placa'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 330
          Top = 15
          Width = 124
          Height = 13
          AutoSize = False
          Caption = 'Nome do Motorista'
          FocusControl = E_BuscaPedido
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaMotorista: TEdit
          Left = 327
          Top = 30
          Width = 342
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
          TabOrder = 4
        end
        object E_BuscaPedido: TEdit_Setes
          Left = 4
          Top = 30
          Width = 79
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
          TabOrder = 0
          Text = ''
        end
        object E_Busca_Data_Ini: TDateTimePicker
          Left = 158
          Top = 30
          Width = 82
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object E_Busca_Data_Fim: TDateTimePicker
          Left = 241
          Top = 30
          Width = 85
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ChBx_Periodo: TCheckBox
          Left = 160
          Top = 15
          Width = 128
          Height = 13
          Caption = 'Data Inicial    Data Final'
          TabOrder = 5
          OnClick = ChBx_PeriodoClick
        end
        object E_BuscaPlaca: TMaskEdit
          Left = 85
          Top = 30
          Width = 70
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
        end
      end
      object Pnl_Busca: TGroupBox
        Left = 0
        Top = 59
        Width = 672
        Height = 454
        Align = alClient
        Caption = 'Resultados da Pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          672
          454)
        object SB_Buscar: TSpeedButton
          Left = 576
          Top = 288
          Width = 92
          Height = 54
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
        end
        object SB_Visualizar: TSpeedButton
          Left = 576
          Top = 342
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Visualizar - F8'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_VisualizarClick
        end
        object Sb_Voltar: TSpeedButton
          Left = 576
          Top = 396
          Width = 92
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Voltar - Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_VoltarClick
        end
        object DBG_Pesquisa: TDBGrid
          Left = 2
          Top = 15
          Width = 568
          Height = 437
          Align = alLeft
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clCream
          DataSource = Ds_MapaCarga
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnTitleClick = DBG_PesquisaTitleClick
          Columns = <
            item
              Expanded = False
              FieldName = 'DT_PRINT'
              Title.Caption = 'Data'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PLAQUE'
              Title.Caption = 'Placa'
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DRIVER'
              Title.Caption = 'Motorista'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORDERS'
              Title.Caption = 'Pedidos'
              Visible = True
            end>
        end
      end
    end
  end
  object DS_Qr_MapaCarga: TDataSource
    DataSet = Qr_Pesquisa
    Left = 400
    Top = 40
  end
  object Qr_Pesquisa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PED_DATA, PED_CODIGO, PED_NUMERO, EMP_FANTASIA,'
      'CLB_NOME, PED_VL_PEDIDO'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal '
      '   INNER JOIN TB_PEDIDO tb_pedido '
      '   ON  (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '
      '   INNER JOIN TB_EMPRESA tb_empresa '
      '   ON  (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '   INNER JOIN TB_COLABORADOR Tb_colaborador'
      '   ON  (Tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO)'
      'ORDER BY '
      'NFL_DT_EMISSAO, PED_NUMERO')
    Left = 400
  end
  object Qr_MapaCarga: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select "TB_MAPACARGA"."ID"'
      '      ,"TB_MAPACARGA"."DT_PRINT"'
      '      ,"TB_MAPACARGA"."PLAQUE"'
      '      ,"TB_MAPACARGA"."DRIVER"'
      '      ,"TB_MAPACARGA"."ORDERS"'
      '      ,"TB_MAPACARGA"."ORDERS_ID"'
      'from "TB_MAPACARGA"'
      'order by'
      '"TB_MAPACARGA"."ID"')
    Left = 480
  end
  object Ds_MapaCarga: TDataSource
    DataSet = Qr_MapaCarga
    Left = 480
    Top = 40
  end
end

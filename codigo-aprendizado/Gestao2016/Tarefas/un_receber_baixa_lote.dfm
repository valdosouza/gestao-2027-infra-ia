object FR_RECEBER_BAIXA_LOTE: TFR_RECEBER_BAIXA_LOTE
  Left = 216
  Top = 0
  Caption = 'Receber Baixa de Lote'
  ClientHeight = 699
  ClientWidth = 984
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pn_geral: TPanel
    Left = 0
    Top = 94
    Width = 992
    Height = 467
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      992
      467)
    object SB_Add_Tudo: TSpeedButton
      Left = 4
      Top = 438
      Width = 109
      Height = 24
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
      Left = 114
      Top = 438
      Width = 107
      Height = 24
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
    object StrGrd_Parcela: TStringGrid
      Left = 2
      Top = 2
      Width = 988
      Height = 432
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clCream
      ColCount = 11
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
      OnClick = StrGrd_ParcelaClick
      OnDrawCell = StrGrd_ParcelaDrawCell
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
        40)
      RowHeights = (
        18
        18)
    end
  end
  object pnl_botoes: TPanel
    Left = 0
    Top = 638
    Width = 984
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      984
      61)
    object SB_BAIXA: TSpeedButton
      Left = 835
      Top = 4
      Width = 77
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Baixar - F9'
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
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
        77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
        07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 13
      OnClick = SB_BAIXAClick
    end
    object sb_sair: TSpeedButton
      Left = 912
      Top = 4
      Width = 77
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Spacing = 13
      OnClick = sb_sairClick
    end
    object SB_Buscar: TSpeedButton
      Left = 756
      Top = 4
      Width = 79
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE7E7E7ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0F0F09F9F9F9696969D9D9DF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFB0AEB0CECDCE9D9C9DA5A5A5ADADADF9F9F9FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFBBB4B8F9F5F8B5B4B59C9B9C999999C3C3C3FEFEFEFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEDEBECBDB1B5FAF5F8A09FA0A9A9A98F8F8FD9D9D9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDEDADCC4B8BBF3EFF2939292AEAEAE919191EAEAEAFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFCAC5C8D2C8CAE3E0E28D8C8CA7A7A7A8A8A8F9F9F9FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFDFDFDBEB7B9DFD6D9C6C3C4989798939393C8C8C8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9B8AFB2E5DDDFB0AEAFA0A0A08C8B8BE2E2
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B8ADB1E3DCDFA19FA09C9C9C9A9A
        9AF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEDEEB9AFB2DBD4D69B9A9A8C8C
        8CBBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFBFBFBFDFDFDFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEAEBC1B7B8CDC8C99796
        96828282D3D3D3F5F5F5E8E8E8C4C4C4A9A9A99E9E9FA5A5A5BBBBBBD5D5D5EC
        ECECFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEBECC5BBBDBFBB
        BB8E8E8E83838389898A80808398989BADACACB5B5B3ACACAC94949773747587
        8787C8C8C8F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E1E2D2D0
        D0C3C3C48D8D90BCBBBCF0EFECF9F8F6FCFCF9FEFDFBFDFCFAFBF9F8F0F0EEB5
        B6B6717173A9A9A9ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9696
        99B7B6B9E4E3E0FBF9F6FDFAF7FEFBF8FFFCF9FFFDFBFFFCFAFEFBF9FDF8F7FD
        F8F7ECEBE8868688969696EEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDCDCEA1A0
        A2EDEBE7FCF8F4FBF6F1FCF7F1FDF9F4FEFAF5FEFAF6FEFAF5FDF9F5FCF9F5FC
        F5F3FCF1F3F6F2F0898A8CA6A6A6FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7929295EAE7
        E1FBF6F0FAF3EBFBF4EDFDF7F1FDF7F1FDF8F2FDF8F2FDF8F2FDF8F3FCF8F2FB
        F8F3FBF3F1FCEEF0EFEDEB757577D4D4D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFB1C7C5C1F9F2
        EBFAF1E7FAF1E8FCF5EDFDF6EEFDF6EEFDF6EFFDF6EFFDF6EFFDF7F0FCF6F0FC
        F6F0FBF7F1FBF0EEFCEEEFC6C7C58E8E8FFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE98979AE3DED6FBF1
        E7F9EFE3FBF1E6FCF5ECFDF4ECFDF5ECFDF5EBFDF5ECFDF5ECFDF5EDFDF5EDFC
        F5EEFCF5EEFBF5EFFCE9EBF2EBEA7B7C7DEBEBEBFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E8A1A0A0EDE5DAFBEF
        E1FAEDDFFCF2E8FCF4EAFDF4E9FDF3E9FDF3E9FDF4E9FDF4EAFDF4EBFDF4EBFD
        F5ECFCF4ECFBF5EDFCEDEAFAECEC999A9AD2D2D2FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDCDCDAAA6A4F0E5D8FAEC
        DCFAECDDFCF3E8FDF2E7FEF2E7FEF3E7FEF2E7FEF2E7FEF3E8FEF3E9FDF4E9FD
        F4EAFCF4EAFBF4ECFCEFEAFCEAEAB6B6B5BCBCBCFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1C1C1A7A39FF0E2D3FAEA
        D8FAECDDFDF2E8FDF2E6FEF1E5FEF1E5FEF2E4FEF1E5FEF1E5FEF2E6FEF2E7FD
        F2E8FCF3E9FCF4EAFCF0E9FDE8E7C1BFBFB8B8B9FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFE09D9995E9D9C8FBE8
        D4FBE9D5FCEDDCFEEFE0FEF0E2FEF1E3FEF1E4FEF1E4FEF1E5FEF1E6FEF2E6FE
        F2E7FDF2E7FCF2E7FCEEE4FCE6E1BDBBBAC4C5C5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F69D9B97D5C5B4FDE8
        D1FAE7D1FCE7D0FCE5CDFDE6CDFEE6CEFEE7D0FEE7D1FEE8D3FEE9D5FDEAD6FD
        EBD8FCECDAFBEDDEFCEADEFBE6E0A9A9A9E5E5E5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEBAB9B9B0A292F7E0
        C9FDEBD8FDF0E4FDEEDDFDECDAFEEAD7FEEAD5FEEAD6FEEAD7FEECD9FEEDDCFE
        EFE0FDF1E3FCF2E7FEEAE2F2E5DE99999BFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E590877BDDC8
        B0FEEAD4FDF0E3FDEFE0FEEFDFFEEFDFFEEFDFFEEFE0FEEFE0FEEFE1FDF0E2FD
        F0E3FDF1E4FDF0E3FEE7DCD5CFCAB5B6B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCBAB7B5A894
        80ECD5BEFFF2E3FDEEDEFDEDDDFEEDDDFEEEDCFEEEDDFEEEDEFEEEDFFDEFE0FD
        EFE1FDF1E3FFEBDDEEDBD0A0A0A0F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E09990
        88B29B84ECDBCBFFF0E0FFEFDEFFEEDCFEEDDCFEEDDCFEEDDDFDEEDEFEF0E0FF
        F1E3FFECDBEAD4C5B1ADADD2D2D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEB
        ECA79C93A99685D7C7BAF4E3D2FFEDDBFFEFDDFFEFDEFFEFDFFFF0E0FFEEDCF5
        DECBD4C1B2AEAAA8C4C4C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFD9D9D9A9A4A1A6988CB1A091C9B6A4DAC7B5E3CFBCE1CEBBD8C4B1C8B4A3B5
        AAA0A5A4A4D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFF0F0F0BDBDBDB0ADA9ADA59CAA9F94A99D93ACA298ABA59FA9A8A8BE
        BEBFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E6D4D4D4CECECED7D7D7EAEAEBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = SB_BuscarClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 984
    Height = 94
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label12: TLabel
      Left = 169
      Top = 13
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
    object Label4: TLabel
      Left = 236
      Top = 13
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
    object Label3: TLabel
      Left = 320
      Top = 13
      Width = 59
      Height = 14
      Caption = 'N'#186' Duplicata'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_CodigoCliente: TLabel
      Left = 406
      Top = 13
      Width = 68
      Height = 14
      Caption = 'C'#243'digo Cliente'
    end
    object Sb_Empresa: TSpeedButton
      Left = 874
      Top = 27
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_EmpresaClick
    end
    object E_BuscaPedido: TEdit_Setes
      Left = 169
      Top = 27
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object E_BuscaCliente: TEdit
      Left = 485
      Top = 27
      Width = 386
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_BuscaNota: TEdit_Setes
      Left = 236
      Top = 27
      Width = 82
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
    end
    object E_BuscaFinanceiro: TEdit
      Left = 320
      Top = 27
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object ChBx_Nome: TCheckBox
      Left = 485
      Top = 9
      Width = 113
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 600
      Top = 9
      Width = 102
      Height = 17
      Caption = 'Apelido/Fantasia'
      TabOrder = 8
      OnClick = ChBx_FantasiaClick
    end
    object E_Data_Ini: TDateTimePicker
      Left = 7
      Top = 27
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 88
      Top = 27
      Width = 79
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 7
      Top = 13
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object E_cd_Cliente: TEdit
      Left = 406
      Top = 27
      Width = 77
      Height = 22
      TabOrder = 5
      OnExit = E_cd_ClienteExit
    end
    object Rg_Data: TRadioGroup
      Left = 5
      Top = 49
      Width = 167
      Height = 38
      Caption = 'Tipo de Data'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Vencimento'
        'Pagamento')
      TabOrder = 10
    end
    object Rg_Situacao: TRadioGroup
      Left = 174
      Top = 49
      Width = 235
      Height = 38
      Caption = 'Situa'#231#227'o '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Normais'
        'Baixadas'
        'Todas')
      TabOrder = 11
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 711
      Top = 49
      Width = 194
      Height = 40
      TabOrder = 12
      ExplicitLeft = 711
      ExplicitTop = 49
      ExplicitWidth = 194
      ExplicitHeight = 40
      inherited Lb_FormaPagamento: TLabel
        Width = 188
      end
      inherited pnl_Forma: TPanel
        Width = 194
        Height = 26
        ExplicitWidth = 194
        ExplicitHeight = 26
        inherited SB_FormaPag: TSpeedButton
          Left = 168
          Height = 23
          ExplicitLeft = 171
          ExplicitHeight = 26
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 159
          Height = 22
          ExplicitWidth = 159
          ExplicitHeight = 22
        end
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 599
    Width = 984
    Height = 39
    Align = alBottom
    Caption = 'Totalizador'
    TabOrder = 3
    object Label6: TLabel
      Left = 6
      Top = 13
      Width = 184
      Height = 16
      Caption = 'Valor total do Contas '#224' Receber'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 270
      Top = 13
      Width = 182
      Height = 16
      Caption = 'Valor total dos Cr'#233'ditos a ceder'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Vl_Prazo: TLabel
      Left = 500
      Top = 13
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Vl_Credito: TLabel
      Left = 236
      Top = 13
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Vl_Vencer: TLabel
      Left = 736
      Top = 13
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Vl_Vencida: TLabel
      Left = 960
      Top = 13
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 773
      Top = 13
      Width = 108
      Height = 16
      Caption = 'Valor total Vencido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 549
      Top = 13
      Width = 113
      Height = 16
      Caption = 'Valor total '#224' Vencer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object qr_busca: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT                                             '
      '  FIN_CODIGO,                                               '
      '  NFL_NUMERO,                                               '
      '  PED_NUMERO,                                               '
      '  FIN_NUMERO,                                               '
      '  FIN_DT_VENCIMENTO,                                        '
      '  FIN_CODEMP,                                               '
      '  EMP_FANTASIA,                                             '
      '  EMP_NOME,                                                 '
      '  FIN_VL_PARCELA,                                           '
      '  FIN_BAIXA,                                                '
      '  FIN_SITUACAO,                                             '
      '  FIN_CODQTC,                                               '
      '  FIN_CODFPG,                                               '
      '  PED_CODIGO,                                               '
      '  NFL_CODIGO,                                               '
      
        '  FIN_TIPO,                                                     ' +
        '                                       '
      '  FIN_DT_PAGTO,                                             '
      '  FIN_OPERACAO,                                             '
      '  FIN_ETAPA,                                                '
      '  FIN_CODMHA,                                               '
      '  FIN_CODCHQ,'
      '  FIN_NR_PARCELA,'
      'FIN_DATA,'
      'FIN_CODPED'
      'FROM                                                        '
      '  TB_FINANCEIRO tb_financeiro                               '
      'INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal                    '
      '  ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '
      'LEFT OUTER JOIN TB_PEDIDO tb_pedido                         '
      '  ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED)      '
      'INNER JOIN TB_EMPRESA tb_empresa                            '
      '  ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP)     '
      '')
    Left = 56
    Top = 292
  end
  object dts_busca: TDataSource
    DataSet = qr_busca
    Left = 104
    Top = 284
  end
end

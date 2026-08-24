inherited Fr_Lanca_Pagto: TFr_Lanca_Pagto
  Left = 330
  Top = 69
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Lan'#231'amentos de Contas a Pagar'
  ClientHeight = 498
  ClientWidth = 676
  Font.Name = 'MS Sans Serif'
  OldCreateOrder = False
  PrintScale = poPrintToFit
  ExplicitWidth = 682
  ExplicitHeight = 547
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 676
    Height = 434
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = -176
    ExplicitHeight = 443
    DesignSize = (
      676
      434)
    object Label3: TLabel
      Left = 8
      Top = 4
      Width = 84
      Height = 14
      Caption = 'Data Lan'#231'amento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 102
      Top = 5
      Width = 116
      Height = 14
      Caption = 'Nota Fiscal / Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 7
      Top = 310
      Width = 100
      Height = 14
      Caption = 'Observa'#231#227'o da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 453
      Top = 400
      Width = 93
      Height = 20
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lb_VL_Total: TLabel
      Left = 549
      Top = 400
      Width = 115
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 226
      Top = 5
      Width = 90
      Height = 14
      Caption = 'Modelo Nota Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 324
      Top = 5
      Width = 81
      Height = 14
      Caption = 'S'#233'rie Nota Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 454
      Top = 5
      Width = 218
      Height = 391
      Anchors = [akTop, akRight]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 10
      object StGrd_Prazo: TStringGrid
        Left = 2
        Top = 2
        Width = 214
        Height = 387
        Align = alClient
        Color = clMoneyGreen
        ColCount = 3
        DefaultRowHeight = 20
        RowCount = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnClick = StGrd_PrazoClick
        OnDrawCell = StGrd_PrazoDrawCell
        OnSelectCell = StGrd_PrazoSelectCell
        ColWidths = (
          64
          64
          64)
        RowHeights = (
          20
          20)
      end
      object Tpk_Prazo: TDateTimePicker
        Left = 24
        Top = 24
        Width = 87
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        Date = 38500.743145937500000000
        Time = 38500.743145937500000000
        Checked = False
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = Tpk_PrazoChange
      end
    end
    object Grb_Empresa: TGroupBox
      Left = 7
      Top = 192
      Width = 443
      Height = 48
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      TabStop = True
      object Sb_Fornecedores: TSpeedButton
        Left = 411
        Top = 18
        Width = 25
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_FornecedoresClick
      end
      object DBLCB_Empresa: TDBLookupComboBox
        Left = 65
        Top = 18
        Width = 340
        Height = 21
        KeyField = 'EMP_CODIGO'
        ListField = 'EMP_NOME'
        ListSource = DM_ListaConsultas.Ds_ListaFornecedor
        TabOrder = 1
        OnExit = DBLCB_EmpresaExit
        OnKeyDown = DBLCB_EmpresaKeyDown
      end
      object E_Cod_For: TMaskEdit
        Left = 5
        Top = 18
        Width = 55
        Height = 21
        TabOrder = 0
        Text = ''
        OnExit = E_Cod_ForExit
      end
    end
    object GroupBox6: TGroupBox
      Left = 7
      Top = 81
      Width = 442
      Height = 47
      Caption = 'Valor / N'#250'meros Parcelas - Parcelamentos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      TabStop = True
      object Sb_Prazo: TSpeedButton
        Left = 413
        Top = 18
        Width = 25
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_PrazoClick
      end
      object E_Nr_PArcelas: TMaskEdit
        Left = 92
        Top = 17
        Width = 34
        Height = 21
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Text = '   '
        OnExit = E_Nr_PArcelasExit
      end
      object E_Prazo: TMaskEdit
        Left = 128
        Top = 17
        Width = 284
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = ''
        OnExit = E_PrazoExit
      end
      object E_VL_Doc: TEdit_Setes
        Left = 6
        Top = 17
        Width = 82
        Height = 22
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnExit = E_VL_DocExit
      end
    end
    object E_Nr_Doc: TEdit
      Left = 98
      Top = 18
      Width = 123
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
    end
    object E_Obs: TMemo
      Left = 6
      Top = 327
      Width = 440
      Height = 100
      TabOrder = 9
    end
    object E_Dt_Emissao: TDateTimePicker
      Left = 7
      Top = 17
      Width = 88
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 125
      Width = 445
      Height = 65
      Caption = ' Natureza da opera'#231#227'o '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      TabStop = True
      inline Fm_lista_cfop: TFm_lista_cfop
        AlignWithMargins = True
        Left = 5
        Top = 16
        Width = 435
        Height = 47
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 16
        ExplicitWidth = 441
        ExplicitHeight = 42
        inherited pnl_linha_1: TPanel
          Width = 435
          ExplicitWidth = 441
          inherited Sb_open: TSpeedButton
            Left = 411
            ExplicitLeft = 417
          end
          inherited Dblcb_Lista: TDBLookupComboBox
            Width = 411
            Height = 22
            ExplicitWidth = 417
            ExplicitHeight = 22
          end
        end
        inherited pnl_top: TPanel
          Width = 435
          ExplicitWidth = 441
          inherited L_name_list: TLabel
            Width = 409
            Height = 16
          end
          inherited Chbx_cfop: TCheckBox
            Visible = False
            ExplicitTop = -2
          end
        end
      end
    end
    inline Fm_CentroCusto: TFm_CentroCusto
      Left = 5
      Top = 242
      Width = 445
      Height = 65
      TabOrder = 8
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 242
      ExplicitWidth = 445
      ExplicitHeight = 65
      inherited Grb_Cta_CentroCusto: TGroupBox
        Width = 445
        Height = 65
        ExplicitWidth = 445
        ExplicitHeight = 65
      end
    end
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 6
      Top = 40
      Width = 441
      Height = 42
      TabOrder = 4
      TabStop = True
      ExplicitLeft = 6
      ExplicitTop = 40
      ExplicitWidth = 441
      ExplicitHeight = 42
      inherited Lb_FormaPagamento: TLabel
        Width = 435
      end
      inherited pnl_Forma: TPanel
        Width = 441
        Height = 28
        ExplicitWidth = 441
        ExplicitHeight = 28
        inherited SB_FormaPag: TSpeedButton
          Left = 415
          Height = 25
          ExplicitLeft = 241
          ExplicitTop = 15
          ExplicitHeight = 28
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 406
          ExplicitWidth = 406
        end
      end
    end
    object E_Nr_Modelo: TEdit
      Left = 224
      Top = 18
      Width = 98
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
    end
    object E_Nr_Serie: TEdit
      Left = 324
      Top = 18
      Width = 88
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 434
    Width = 676
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 429
    DesignSize = (
      676
      64)
    object SB_Confirmar: TSpeedButton
      Left = 490
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
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 492
    end
    object SB_Fechar: TSpeedButton
      Left = 581
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
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C30E0000C30E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000020300000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000002E4800528000466C003B5C00324F00273D001E2F001520000D1400
        060A000102000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000131D0019280018260018
        26001826004F7B0267A60466A60367A40266A100649D006299005E9300598B00
        5382004C7600446A00395A00324D002032000102000000000000000000000000
        0000000000000000000000000000000000000019270060970061990060980060
        98006098005E930B66AD1C76CB1C7AC91A78C61876C31473BE1270B90E6EB60C
        6CB1096AAE0769AA0468A60267A500649E001725000000000000000000000000
        00000000000000000000000000000000000000314D00649E0D4571103F681040
        69103E670452820E6DB42382D22487D32588D32485D32284D32284D22182D220
        80D11F7FD01D7CCD1B7ACB1772C60767AC002233000000000000000000000000
        000000000000000000000000000000000000002F4A01619A123C6414375D1438
        5E14365C0550801173B9288AD7298FD7278DD6288ED6288DD5268CD5258BD425
        8AD42489D32387D22287D21F7FD10B6CB1002337000000000000000000000000
        000000000000000000000000000000000000002E49016199113C6513385F1339
        6013385E0352831576BD2B8FD92A92D8268DD62C93D92B93D9288FD7258CD529
        90D82890D7268DD5258CD52488D50E71B800273C000000000000000000000000
        000000000000000000000000000000000000004065015F96123C6313385F1339
        6013395F035486197AC12E92DC2C93D9288FD72F96DB2E95DB2B91D8278DD62C
        93D92B93D9278ED6268DD6288CD71175BB002A43000000000000000000000000
        000000000000000000000000000000000000004771045A901339601339601339
        601339600256891C7DC53195DD2D94DB2A91D83299DD3197DC2C93D92990D72F
        96DB2E95DB2990D8288FD72B8FDA1276BD002F4A000000000000000000000000
        00000000000000000000000000000000000000456D04598F13385F1339601339
        5F12396002588C1F81C93599DF2F97DD2D95DC359DE0349ADE2E95DB2A91D832
        99DD3197DC2C93D92A90D72E92DC167AC3003351000000000000000000000000
        000000000000000000000000000000000405004F7E05578E1439601339601338
        5F113B62025A8F2485CD399EE33196D72C8BC9379ADA379FE33198DD2C93D935
        9CDF349ADE2F96DB2B92D93196DE1A7DC7003757000000000000000000000000
        00000000000000000000000000000000070C005A8B044767122C53133A621338
        5F113C63035C922A8CD43594D41B639F134F86205C86348FC8349CE12E95DA38
        9FE1379EE03299DD2D94DA359AE01C80C8003A5C000000000000000000000000
        00000000000000000000000000000000050E005B79056F14052C210F28501439
        61103D65045F952C8DD31B68AF1267B31570BE0E519122608A3499DA3097DD3C
        A2E33AA1E2359CDF2D94DA389DE21F84CC003F63000000000000000000000000
        00000000000000000000000000000000020300403D30A63D319E3A0033160D22
        47103C6606649C2781C81265B01C84D01D87D3136EBC1A55883493CE329ADF3F
        A5E53DA3E4389FE12F96DB3AA0E32489D100436A000000000000000000000000
        000000000000000000002100055407157E1B2A993257C46977DC8E42AE4D0343
        100529480867A22681C92270B659A6DE5BA8DF3180C3195D96389AD7349BDF42
        A8E73FA6E53CA2E33097DB3EA4E6278CD3004670000000000000000000000000
        000000000E000461061EA92939C54B4DCE625CD17165D27C70D38683DE9B5CC0
        650C61330663A03193DC387CBAB8D2E8C6DDF15286B92A82BD3DA4E5349BDF45
        ABE943A9E73FA6E53098DC41A7E72B8FD5004A75000000000000000000000000
        000B0006740922BD3235C4493FC4524AC75F57CB6C63CF796FD3857AD69194E7
        A85AB68F03649F3EA1E63F9FDF4388C34F8EC53B92CF49B0EC3EA5E5369DDF48
        AEEB45ACE942AAE83298DD44A9E93095DA014F7E000102000000000000000200
        02620418B92827BF3A33C24741C8554ECC615BD06D66D17C6FD38582DD9A71D0
        7A197A4F0968A840A3E74DB4EF2F99DE40AAE94CB4F04CB3EE3FA6E5379EE04B
        B1ED48AFEB47ADEA349ADE46ABEB3499DF025484000305000000000000002800
        0BA3151EC03227BF3826B63422A52C1C922B1E8E374BB95C7ADD9258C2640F64
        220340600F6FAE44A7EA4BB2EF2F99DF45AFEE49B3F049B3F03BA6E7319DE346
        B2F043AFEF41AEEE2A97DF40ACEE379CE0035788000508000000000000015A02
        12BA2214B022097A0D004400001E00003143005C7834A64246B54E0755281030
        580943741274B045AAEE53B5ED45A0D960B8E866BBE96ABDE864B3E062AFDB79
        C2E57BC1E27CC0E273B4D575BBE13CA0E4045B8F00060B000000000000036907
        0AA413004100000500000000000000002E5200678A0C7F170A4C351233611537
        5F0746731277B654B0ECDEDDCEFEF6D8FFF6DDFCF2DDFFF3DDFFF3DEFDEFDFFD
        EEE0FDEDE1FFF1E2FCEDE3FFE9D15CACE0025F9800080D000000000000016402
        00480000000000000000000000000000446C025F910E40541335621339611437
        5D064876127BBC79C1E6DDCCD9736CF1655EEF7A75F1ADA9F5CDC9F7706CF257
        52F1726DF3E3E1FC706CF5FFF5E76CB4E002619C000B12000000000000005800
        001200000000000000000000000000004670045A911437631339601339601437
        5D044978177EC086CBE8AFA6E13F3BF3B1AEFAC3C1FB4E47F14942F1BBB9FA75
        70F4A09DF7E8E8FD5B57F4FFF8EC73B9E20365A2000E17000000000000001400
        00030000000000000000000000000000466F04598E13385F1339601339601437
        5E034B7A1A83C68CCEEAB7ADE3403BF28783F5EFEFFE847FF5352EEEFFFFFF81
        7CF5B2B0F8F2F3FE5C58F6FEF6EA7CBEE3076CAB00101B000000000000000000
        00000000000000000000000000000000476F05588D14385E1339601339601338
        5E024E7E1D88CB92D1E9B8ADE33E38F29592F7E9E9FD645FF33028EEDAD8FC77
        71F4938FF6B4B1FB5750D3C0B3A46AB2DF0D73B100121E000000000000000000
        00000000000000000000000000000000476F05588D14385E1339601339601339
        5F005182228CCF9BD6E9B8ADE52D26F16A65F3807CF56D69F4AEACF96B67F460
        5BF3706BF5726DF3DCC3C9BAD1D54DB6F61375B1001725000000000000000000
        00000000000000000000000000000000477008538614375D13396013395F1339
        600053862691D49CD0E7E9DEE7AFADF9BDBAF8D2CFF9F0EDFBFFFFFBF2EEF8FD
        F8F7FFFEF6FFFFF0EDE0D166C0F14FB8F7187BB9001B2C000000000000000000
        0000000000000000000000000000000047700A4F8015355A14375D14375C1338
        5E0055892995D99DCAE2FFF3D5FFFFEAFFFFE6FFFAE2FFF5E0FFF0DDFFEFDBFB
        EBD9F2E8D9E7E3D691C5E24DBAF950B4F6197DBF001F32000000000000000000
        000000000000000000000000000000004974055D950A4F80095081094F810950
        81005A902F95D96CBDEECDD6D2C5D7DBB3D3E0A5CFE493CAE784C5EA75C0ED64
        B9ED58B3ED4BACEA41A5E73D9FDF3193D70E74B600253B000000000000000000
        0000000000000000000000000000000033510049740047700047700047700049
        73005C923091D744AAF13FA8EC38A2E52F98DD2791D6218ACE1982C5157DBF0F
        75B60A70B0066BA903659F00619A00588C00588B001825000000000000000000
        0000000000000000000000000000000000000000000000000000000000000004
        06005D92086EAC0B6EAB0569A502649E006099005A90005486004E7C00426A00
        3F65002E4A002C46001C2C001725000B11000609000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000005
        0800426800476F003656002F4A00223600192700121C00070B00030500000000
        0000000000000000000000000000000000000000000000000000}
      Layout = blGlyphTop
      ParentFont = False
      Spacing = 0
      OnClick = SB_FecharClick
      ExplicitLeft = 583
    end
    object Chbx_Credito: TCheckBox
      Left = 8
      Top = 4
      Width = 96
      Height = 17
      Caption = 'Gerar Cr'#233'dito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Chbx_CreditoClick
    end
  end
  object Qr_Acao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT MAX(NFL_NUMERO) FROM TB_NOTA_FISCAL WHERE (NFL_TIPO = '#39'SI' +
        #39') OR (NFL_TIPO = '#39'EI'#39')')
    Left = 192
    Top = 288
  end
  object Ds_Fornecedor: TDataSource
    DataSet = DM.Qr_Empresas
    Left = 354
    Top = 281
  end
  object Qr_Endereco: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_ENDERECO'
      'INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP=:END_CODEMP)')
    Left = 317
    Top = 289
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'END_CODEMP'
        ParamType = ptUnknown
      end>
  end
  object Qr_Empresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  EMP_STCRED,'
      '  EMP_OBSERV,'
      '  EMP_DT_CADASTRO,'
      '  EMP_PESSOA,'
      '  EMP_VL_CRED,'
      '  EMP_CODVDOR,'
      '  EMP_ML_DRT,'
      '  EMP_CODBCO,'
      '  EMP_AGENCIA,'
      '  EMP_CONTABCO,'
      '  EMP_EMAIL,'
      '  EMP_SITE,'
      '  EMP_RAM_ATIV,'
      '  EMP_DT_FUNDA,'
      '  EMP_CODTRANSP,'
      '  EMP_MULTIPLICADOR'
      'FROM TB_EMPRESA'
      '   WHERE (EMP_CODIGO =:EMP_CODIGO)')
    Left = 272
    Top = 291
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EMP_CODIGO'
        ParamType = ptUnknown
      end>
  end
end

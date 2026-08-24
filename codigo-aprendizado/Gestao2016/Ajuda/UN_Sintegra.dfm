object Fr_Sintegra: TFr_Sintegra
  Left = 328
  Top = 147
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gerar Arquivo Sintegra'
  ClientHeight = 426
  ClientWidth = 539
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 545
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 539
    Height = 120
    Align = alTop
    Caption = ' Cabe'#231'alho do Arquivo '
    TabOrder = 0
    object Label3: TLabel
      Left = 286
      Top = 23
      Width = 211
      Height = 13
      Caption = 'C'#243'digo de Identifica'#231#227'o do Conv'#234'nio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 3
      Top = 68
      Width = 207
      Height = 13
      Caption = 'Natureza das Opera'#231#245'es Informadas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 286
      Top = 68
      Width = 124
      Height = 13
      Caption = 'Finalidade do Arquivo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 3
      Top = 24
      Width = 32
      Height = 13
      Caption = 'CNPJ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 154
      Top = 23
      Width = 13
      Height = 13
      Caption = 'IE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Cb_Convenio: TComboBox
      Left = 286
      Top = 39
      Width = 245
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      ParentFont = False
      TabOrder = 2
      Text = '3 - Conv'#234'nio 57/95 Alt. 76/03'
      Items.Strings = (
        '1 - Conv'#234'nio 57/95 Vers'#227'o 31/99 Alt. 30/02'
        '2 - Conv'#234'nio 57/95 Vers'#227'o 69/02 Alt. 142/02  '
        '3 - Conv'#234'nio 57/95 Alt. 76/03')
    end
    object Cb_Natureza: TComboBox
      Left = 3
      Top = 84
      Width = 282
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      ParentFont = False
      TabOrder = 3
      Text = '3 - Totalidade das opera'#231#245'es do informante'
      Items.Strings = (
        
          '1 - Interestaduais - Somente opera'#231#245'es sujeitas ao regime de Sub' +
          'stitui'#231#227'o Tribut'#225'ria'
        
          '2 - Interestaduais - Opera'#231#245'es com ou sem Substitui'#231#227'o Tribut'#225'ri' +
          'a'
        '3 - Totalidade das opera'#231#245'es do informante')
    end
    object Cb_Finalidade: TComboBox
      Left = 286
      Top = 84
      Width = 245
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 4
      Text = '1 - Normal'
      Items.Strings = (
        '1 - Normal'
        '2 - Retifica'#231#227'o Total de Arquivo'
        '5 - Desfazimento de Arquivo')
    end
    object E_CNPJ: TEdit
      Left = 2
      Top = 40
      Width = 138
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 28
      ParentFont = False
      TabOrder = 0
      Text = '11111111111111'
    end
    object E_Insc_Estadual: TEdit
      Left = 153
      Top = 39
      Width = 127
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 28
      ParentFont = False
      TabOrder = 1
      Text = 'ISENTO'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 120
    Width = 539
    Height = 85
    Align = alTop
    Caption = ' Dados Complementares '
    TabOrder = 1
    object Label6: TLabel
      Left = 9
      Top = 26
      Width = 74
      Height = 13
      Caption = 'Respons'#225'vel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_Responsavel: TEdit
      Left = 8
      Top = 42
      Width = 241
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 28
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox3: TGroupBox
      Left = 256
      Top = 7
      Width = 273
      Height = 74
      Caption = ' Per'#237'odo '
      TabOrder = 1
      object Label7: TLabel
        Left = 9
        Top = 19
        Width = 35
        Height = 13
        Caption = 'Inicial'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 127
        Top = 19
        Width = 28
        Height = 13
        Caption = 'Final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object E_Data_Ini: TDateTimePicker
        Left = 7
        Top = 35
        Width = 86
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object E_Data_Fim: TDateTimePicker
        Left = 124
        Top = 34
        Width = 85
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 205
    Width = 295
    Height = 140
    Align = alLeft
    Caption = ' Gerar registros '
    TabOrder = 2
    object ChLBx_Registro: TCheckListBox
      Left = 2
      Top = 15
      Width = 291
      Height = 123
      Align = alClient
      Columns = 3
      ItemHeight = 13
      Items.Strings = (
        'Gerar 50'
        'Gerar 51'
        'Gerar 53'
        'Gerar 54'
        'Gerar 60M'
        'Gerar 70'
        'Gerar 74'
        'Gerar 85'
        'Gerar 86')
      TabOrder = 0
      OnClick = ChLBx_RegistroClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 539
    Height = 81
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      539
      81)
    object Label10: TLabel
      Left = 5
      Top = 7
      Width = 112
      Height = 13
      Caption = 'Vers'#227'o do validador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SB_Sair: TSpeedButton
      Left = 452
      Top = 22
      Width = 80
      Height = 54
      Anchors = [akBottom]
      Caption = 'Sair - ESC'
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
      OnClick = SB_SairClick
    end
    object SB_Gerar: TSpeedButton
      Left = 370
      Top = 22
      Width = 80
      Height = 54
      Anchors = [akBottom]
      Caption = 'Gerar - F3'
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
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEBEBAFBB
        B7789890548779457E6E447D6E5182756D8C8398A4A0C7C8C8E5E5E5EDEDEDF4
        F4F4FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4ECEA7A9F96217E66057B
        5C047B5C047A5B047A5B047A5B047B5B047C5C05795A1D765F67887FC6C7C7F3
        F3F3F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1CABF208C70088464088061097E
        60097E60087E5F087D5F077D5E077D5F087E60097E6008826209866528836CAA
        B7B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF9FCFB72B4A20C88680E88680F88690E87680F87
        68118869138A6B158D6E188E70188B6E0F85660883630D87670F88690F8C6C0F
        8B6B8CB4AAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFCFDFD6EB7A4129372169373169373129070199475159A
        78129D782CAE8C43BE9E49C6A641C7A849C4A847B1971B94750F8F6E16937316
        937316987793CABCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF90C9BA1B9E7D1E9E7E1D9E7D1C9C7B3FB29653C8AB8CD7
        C3D0EDE5F2FAF7FBFEFDFAFDFCF1FAF8D9F6EFC4F5EBA2E4D643B095199B7A1E
        9E7E1E9E7E1B9E7DB5D9D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD0E8E226AA8926AA8926AA8825A88756C4A9B9EFE2F0FAF8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FDFAB0F0E242BDA025
        A88627AA8926AA8937AE90E8F3F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFDFEFE66C4AC2DB69430B5932FB59336BC9BC3EEE3FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFE94E8D533
        BC9B2FB59230B6942DB6938AD0BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFD4EEE738C19E39C19F3AC29F34BF9C8ED7C4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFE73
        D6BE38C29F39C19F38C19F43C3A3EEF8F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF96DECC3FCCA942CCA845CFAC48C09FF7FCFAFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        F9F749CBAA42CDA942CCA940CCA8ADE4D6E7F7F3F4FBF9FFFFFFFFFFFFFFFFFF
        FCFEFD6EDDC14AD8B54CD8B54AD6B29FD9C8FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF7F390
        E1CC56D6B64AD6B34AD6B34AD6B34ED7B54CD4B1B6E2D5FFFFFFFFFFFFFFFFFF
        F3FCFA52D7B64DDAB754E0BD4ED4B2E7F5F1FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF7F448
        C7A756E4C152DFBC52E0BC52DFBC57E4C148C8A5EEF8F5FFFFFFFFFFFFFFFFFF
        F9FDFC70C7AF53BC9E43B8976DC7AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE
        E3D950D9B75CECC85AE8C45BE9C659E6C393D5C2FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDCDCD1E6EAE4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF82CFBB62EFCB62F1CD67F6D250D2AFEFF8F5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFEFEFEA26534AC7A51FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFEEF8F562D4B76CFCD867F6D28CD4BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDFD1C4924C07924C07D6C3B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFBDE6DB6DF3D257DDB9E9F6F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFB386569B560C9B560DA36728F4EFEBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF86DFCA7DD4BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E7DCCFA56216A56215A56216A66113C0996EFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF2ECE5E1E8DEE4ECE4FBF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        C39B69AF6D1CAE6D1EAE6D1EAE6D1EAE6D1DDECDB9FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF9F6F2B67B37B77328BA7A35C08B51FBF8F5FFFFFFFFFFFFFFFFFFEBE1D4
        BA7C2DB97B2BB87A29B87A29B87929BD7C2AC5904BFCFBF9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFEADECFB97A28B97A28B97A28C48A44FEFCFAFFFFFFFFFFFFFFFFFFEFDECC
        CD9252C78A41C28735C28634C38633CE9B59EED9C0FEFEFDFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFD3B285C38632C28634C38735D6A872FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE4C39FCD9441CC9340CD933FCE9C52F8F4EEFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1
        E9DDCD9644CC933FCC9340CD9341E7CBADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF7EEE4D2984AD6A14DD59F4BD69F4ADBB57AFDFBF9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F5D9
        AF70D69F4AD59E4BD7A14ED29A4EF9F3ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDDB384DEAB58DEAA56DEAA56DFAA54E5C38DFCF9F5FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7F0E3BF84DF
        AA54DEAA56DFAB56DDAA57E0BB91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF9F1E9D9A258E8B864E6B460E6B460E6B45FE8C07EF4E9D4FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDF4E6CFE7BE78E6B45FE6
        B460E6B561E9B965D69F5AFAF5EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEDD9C1E0AC57EFC26FECBE6AECBE6AEDBE69ECBE69EECC
        91F3E0C1F8EEDDFAF3E8FAF3E8F8EDDCF2DFBDEDCA8CECBE69EDBE69ECBE6AED
        BE6AEFC36FDAA253EEDBC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFECD3B4E7B965F5C979F3C671F3C672F3C673F3C6
        72F3C671F3C672F2C674F2C674F3C672F3C671F3C672F3C673F3C672F3C671F4
        C875E0AB57E8CEB1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0DCBEEAC370F8D285F8CE7BF8CC77F8CE
        7AF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF8CE7BF9CF7BF9CF7DF8D388EA
        C47FEFDCC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0E1F2DCA8FAE3A9FCDE9BFCD6
        88FDD684FDD684FDD784FED785FED986FFDA87FDD785F7D07FF3D390F4E3C0FB
        F5ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4EBF9F0D9F7E3
        AEF4D487F4CE7BF4CC7AF1C775EBBC6AE1AC59DBA65AE5C594F8EFE3FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFA
        F7F8EEDFF1DFC0ECD3AAE9CEA7EAD1B4F1E0CEFBF6F1FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_GerarClick
    end
    object Lb_Processamento: TLabel
      Left = 189
      Top = 40
      Width = 73
      Height = 13
      Caption = 'Processamento'
    end
    object Gg_Progresso: TGauge
      Left = 186
      Top = 54
      Width = 178
      Height = 20
      Progress = 0
    end
    object ComboBox5: TComboBox
      Left = 5
      Top = 23
      Width = 77
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '5.2.3'
      Items.Strings = (
        '5.2.3'
        '5.2.4')
    end
  end
  object GroupBox5: TGroupBox
    Left = 296
    Top = 205
    Width = 243
    Height = 140
    Align = alRight
    Caption = 'Lista de Invent'#225'rios'
    TabOrder = 4
    object Dbg_Inventario: TDBGrid
      Left = 3
      Top = 16
      Width = 232
      Height = 116
      DataSource = Ds_Inventario
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'IVT_CODIGO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IVT_DATA'
          Title.Caption = 'Data'
          Width = 92
          Visible = True
        end>
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Arquivos Texto|*.txt'
    Options = [ofHideReadOnly]
    Title = 'Salvar Arquivo'
    Left = 480
    Top = 236
  end
  object Qr_Registro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      'PED_TIPO,'
      'EMP_PESSOA,'
      'EMP_CNPJ, '
      'EMP_INSC_EST, '
      'EMP_NOME,'
      'UFE_SIGLA, '
      'NFL_DT_EMISSAO,'
      'NFL_STATUS,'
      'NFL_TIPO,'
      'NFL_MODELO,'
      'NFL_SERIE, '
      'NFL_NUMERO, '
      'tb_natureza.nat_cfop,'
      'icms.ICM_AQ_NR,'
      
        'SUM(((itens.itf_qtde * itens.itf_vl_unit) - itens.itf_vl_desc)) ' +
        'ITF_VL_PRODUTO,'
      'SUM(icms.icm_vl_frete) icm_vl_frete,'
      'SUM(icms.icm_vl_seguro) icm_vl_seguro,'
      'SUM(icms.icm_vl_outras) icm_vl_outras,'
      'SUM(icms.ICM_VL_ST) ICM_VL_ST,'
      'SUM((ipi.ipi_vl_bc * ipi.ipi_aq_nr)/100) IPI_VALOR,'
      'SUM(icms.ICM_VL_BC_NR) ICM_VL_BC_NR'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      '   INNER JOIN TB_UF tb_uf'
      '  ON (tb_endereco.END_CODUFE = tb_uf.UFE_CODIGO)'
      '   INNER JOIN TB_ITENS_NFL itens'
      '   ON (itens.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO )'
      '   INNER JOIN TB_ITENS_ICMS icms'
      '   ON (icms.ICM_CODITF = itens.ITF_CODIGO )'
      '   INNER JOIN TB_NATUREZA tb_natureza'
      '   ON (tb_natureza.NAT_CODIGO = icms.icm_CODNAT)'
      '   LEFT OUTER JOIN TB_ITENS_IPI ipi'
      '   ON (ipi.IPI_CODITF = itens.ITF_CODIGO )'
      '   INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = itens.ITF_CODPRO)'
      'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM'
      '  AND (NFL_NUMERO <> '#39#39')'
      '  AND (NFL_NUMERO <> '#39'0'#39')'
      '  AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL))'
      '  AND (NFL_CODMHA=:NFL_CODMHA)'
      'GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14'
      'ORDER BY NFL_DT_EMISSAO, NFL_NUMERO')
    Left = 16
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_ItensRegistro: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      'EMP_PESSOA,'
      'EMP_CNPJ,'
      'NAT_CFOP,'
      'NFL_MODELO,'
      'NFL_SERIE,'
      'NFL_NUMERO,'
      'NFL_TIPO,'
      'PRO_DESCRICAO,'
      'PRO_CODIGONCM,'
      'MED_ABREVIATURA,'
      'ITF_CODIGO,'
      'ITF_CODPRO,'
      'ITF_QTDE,'
      '(ITF_QTDE * ITF_VL_UNIT) ITF_VL_PRODUTO,'
      'ITF_VL_DESC,'
      'ICM_VL_BC_NR,'
      'ICM_VL_NR,'
      '((IPI_VL_BC *IPI_AQ_NR)/100) IPI_VL_IPI,'
      'ICM_VL_BC_ST,'
      'ICM_AQ_NR,'
      'TBI_GRUPO'
      'FROM TB_NOTA_FISCAL'
      '   INNER JOIN TB_NATUREZA'
      '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)'
      '   INNER JOIN TB_PEDIDO'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '   INNER JOIN TB_EMPRESA'
      '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      '   INNER JOIN TB_ITENS_NFL'
      '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO )'
      '   INNER JOIN TB_ITENS_ICMS'
      '   ON (tb_itens_icms.ICM_CODITF = tb_itens_nfl.ITF_CODIGO )'
      '   INNER JOIN tb_trib_icms_sn'
      '   ON (TBI_CODIGO = ICM_CODTBI_SN)'
      '   LEFT OUTER JOIN TB_ITENS_IPI'
      '   ON (tb_itens_ipi.IPI_CODITF = tb_itens_nfl.ITF_CODIGO )'
      '   INNER JOIN TB_PRODUTO'
      '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA'
      '   ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM'
      '  AND (NFL_NUMERO <> '#39#39')'
      '  AND (NFL_NUMERO <> '#39'0'#39')'
      '  AND NFL_CODMHA =:NFL_CODMHA'
      'ORDER BY NFL_CODIGO, ITF_CODIGO')
    Left = 72
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Registro70: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      'EMP_PESSOA,'
      'EMP_CNPJ, '
      'EMP_INSC_EST, '
      'EMP_NOME,'
      'UFE_SIGLA,'
      'NFL_DT_EMISSAO,'
      'NFL_STATUS,'
      'NFL_TIPO,'
      'NFL_MODELO, '
      'NFL_SERIE, '
      'NFL_NUMERO, '
      'NAT_CFOP, '
      'nat_registro,'
      'NFL_BS_ICMS, '
      'NFL_VL_ICMS, '
      'NFL_BS_ICMS_SUBST, '
      'NFL_VL_ICMS_SUBST, '
      'NFL_VL_TL_PROD,'
      'NFL_VL_FRETE,'
      'NFL_VL_SEGURO,'
      'NFL_VL_DESP_ACESS, '
      'NFL_VL_IPI,'
      'NFL_VL_TL_NOTA,'
      'NFL_CTA_FRETE'
      ''
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      ''
      '   inner JOIN TB_NATUREZA tb_natureza'
      '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)'
      ''
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '  inner JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_empresa.EMP_CODIGO = tb_endereco.END_CODEMP)'
      ''
      ''
      '   INNER JOIN tb_uf tb_uf'
      '   ON (tb_uf.ufe_codigo = tb_endereco.end_codufe)'
      'WHERE (NFL_tipo = '#39'EM'#39')'
      '  AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)'
      '  AND NFL_CODMHA =:NFL_CODMHA'
      '  AND (NFL_NUMERO <> '#39#39')'
      '  AND (NAT_REGISTRO = 70)'
      'ORDER BY NFL_DT_EMISSAO')
    Left = 208
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_Registro53: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      'PED_TIPO,'
      ''
      'EMP_PESSOA,'
      'EMP_CNPJ, '
      'EMP_INSC_EST, '
      'EMP_NOME,'
      ''
      'UFE_SIGLA, '
      ''
      'NFL_DT_EMISSAO,'
      'NFL_STATUS,'
      'NFL_TIPO,'
      'NFL_MODELO, '
      'NFL_SERIE, '
      'NFL_NUMERO, '
      'NAT_CFOP, '
      'NFL_BS_ICMS, '
      'NFL_VL_ICMS, '
      'NFL_BS_ICMS_SUBST, '
      'NFL_VL_ICMS_SUBST, '
      'NFL_VL_TL_PROD,'
      'NFL_VL_FRETE,'
      'NFL_VL_SEGURO,'
      'NFL_VL_DESP_ACESS, '
      'NFL_VL_IPI,'
      'NFL_VL_TL_NOTA,'
      ''
      'ICM_AQ_NR,'
      'ICM_CODNAT'
      ''
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      ''
      '   INNER JOIN TB_NATUREZA tb_natureza'
      '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)'
      ''
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      ''
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP)'
      ''
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND)'
      ''
      '   INNER JOIN TB_UF tb_uf'
      '  ON (tb_endereco.END_CODUFE = tb_uf.UFE_CODIGO)'
      ''
      '   INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO )'
      ''
      '   LEFT OUTER JOIN TB_ITENS_ICMS tb_itens_icms'
      '   ON (tb_itens_icms.ICM_CODITF = tb_itens_nfl.ITF_CODIGO )'
      ''
      '   LEFT OUTER JOIN TB_ITENS_IPI tb_itens_ipi'
      '   ON (tb_itens_ipi.IPI_CODITF = tb_itens_nfl.ITF_CODIGO )'
      ''
      '   INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM'
      '  AND (NFL_NUMERO <> '#39#39')'
      '  AND (NFL_NUMERO <> '#39'0'#39')'
      '  AND ((NAT_REGISTRO = 0) OR (NAT_REGISTRO IS NULL))'
      '  AND (NFL_CODMHA=:NFL_CODMHA)'
      '  AND NFL_BS_ICMS_SUBST >0'
      'ORDER BY NFL_DT_EMISSAO, NFL_NUMERO'
      '')
    Left = 120
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NFL_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Qr_EqptoECF: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT ECF_CODIGO, ECF_DESCRICAO, ECF_ID_REDE, ECF_IDENTIFICACAO' +
        ' , MEF_MODELO, PEF_CODIGO'
      'FROM TB_Eqpto_ECF'
      '  INNER JOIN TB_MODELO_ECF'
      '  ON (MEF_CODIGO = ECF_CODMEF)'
      '  INNER JOIN TB_PORTA_ECF'
      '  ON (PEF_CODIGO = ECF_CODPEF)'
      ' '
      'WHERE ECF_ATIVO ='#39'S'#39)
    Left = 296
    Top = 32
  end
  object Qr_VendasECF: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      #39'01'#39' NFL_MODELO,'
      'NFL_SERIE,'
      'NFL_DT_EMISSAO,'
      'NFL_TIPO,'
      'PRO_DESCRICAO,'
      'PRO_CODIGONCM,'
      'ITF_CODIGO,'
      'ITF_CODPRO,'
      'ITF_QTDE,'
      '(ITF_QTDE * ITF_VL_UNIT) ITF_VL_PRODUTO,'
      'ITF_VL_DESC'
      'FROM TB_NOTA_FISCAL tb_nota_fiscal'
      '   INNER JOIN TB_PEDIDO tb_pedido'
      '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED)'
      '   INNER JOIN TB_ITENS_NFL tb_itens_nfl'
      '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO )'
      '   INNER JOIN TB_PRODUTO tb_produto'
      '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)'
      'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM')
    Left = 368
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATAINI'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATAFIM'
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
    Left = 448
    Top = 32
  end
  object Qr_Inventario: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT distinct  IVT_CODIGO, ivt_data'
      'FROM TB_INVENTARIO'
      'WHERE IVT_CODMHA=:IVT_CODMHA'
      'and  IVT_QT_ATUAL > 0')
    Left = 480
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IVT_CODMHA'
        ParamType = ptUnknown
      end>
  end
  object Ds_Inventario: TDataSource
    DataSet = Qr_Inventario
    Left = 480
    Top = 172
  end
  object ACBrSintegra: TACBrSintegra
    VersaoValidador = vv524
    Informa88SME = False
    Informa88SMS = False
    Informa88EAN = False
    Informa88C = False
    InformaSapiMG = False
    Left = 184
    Top = 213
  end
end

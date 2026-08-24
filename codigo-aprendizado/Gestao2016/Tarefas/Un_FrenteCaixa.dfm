object Fr_FrenteCaixa: TFr_FrenteCaixa
  Left = 185
  Top = 0
  Align = alTop
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'Frente de Caixa'
  ClientHeight = 718
  ClientWidth = 1292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MenuOper
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Touch.InteractiveGestures = []
  Touch.InteractiveGestureOptions = []
  Touch.ParentTabletOptions = False
  Touch.TabletOptions = []
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    1292
    718)
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_topo: TPanel
    Left = 0
    Top = 0
    Width = 1292
    Height = 20
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWindow
    TabOrder = 0
    object Img_Frente: TImage
      Left = 2
      Top = 2
      Width = 1288
      Height = 16
      Align = alClient
      Center = True
      ParentShowHint = False
      Proportional = True
      ShowHint = False
      ExplicitWidth = 1008
      ExplicitHeight = 131
    end
  end
  object E_M_Fisco: TMemo
    Left = 1282
    Top = 266
    Width = 465
    Height = 145
    TabOrder = 1
    Visible = False
  end
  object Pnl_Corpo: TPanel
    Left = 0
    Top = 20
    Width = 1292
    Height = 573
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 3
    object Pnl_Corpo_Items: TPanel
      Left = 176
      Top = 0
      Width = 1116
      Height = 573
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BorderWidth = 5
      TabOrder = 0
      object StrGrd_Produtos: TStringGrid
        Left = 7
        Top = 108
        Width = 1102
        Height = 458
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        ColCount = 21
        Ctl3D = False
        DefaultRowHeight = 25
        FixedColor = clWindow
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        GradientEndColor = clWindow
        GridLineWidth = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        PopupMenu = popmenu
        TabOrder = 0
        OnDrawCell = StrGrd_ProdutosDrawCell
        OnKeyDown = StrGrd_ProdutosKeyDown
        ColWidths = (
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64)
        RowHeights = (
          25
          25)
      end
      object Pnl_Lanca_Items: TPanel
        Left = 7
        Top = 70
        Width = 1102
        Height = 38
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          1102
          38)
        object Label31: TLabel
          Left = 6
          Top = 7
          Width = 32
          Height = 20
          Alignment = taCenter
          Caption = 'F11'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label30: TLabel
          Left = 99
          Top = 7
          Width = 22
          Height = 20
          Alignment = taCenter
          Caption = 'F2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Lb_Item_lancado: TLabel
          Left = 300
          Top = 4
          Width = 796
          Height = 29
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Lan'#231'ar item'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -24
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 805
        end
        object E_Qtde: TEdit_Setes
          Left = 44
          Top = 5
          Width = 53
          Height = 28
          TabStop = False
          CharCase = ecUpperCase
          Color = clScrollBar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 0
          Text = '1'
          OnEnter = E_QtdeEnter
          OnExit = E_QtdeExit
          OnKeyPress = E_QtdeKeyPress
        end
        object E_BuscaCodigo: TEdit_Setes
          Left = 124
          Top = 5
          Width = 170
          Height = 28
          TabStop = False
          CharCase = ecUpperCase
          Color = clScrollBar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
          Text = ''
          OnEnter = E_BuscaCodigoEnter
          OnExit = E_BuscaCodigoExit
          OnKeyPress = E_BuscaCodigoKeyPress
          IsCodigo = True
        end
      end
      object Pnl_Cliente: TPanel
        Left = 7
        Top = 7
        Width = 1102
        Height = 63
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object Label19: TLabel
          Left = 5
          Top = 3
          Width = 87
          Height = 18
          Caption = 'C'#243'd. Cliente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 106
          Top = 3
          Width = 95
          Height = 18
          Caption = 'Nome Cliente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Status: TLabel
          Left = 485
          Top = 20
          Width = 92
          Height = 37
          Caption = 'LIVRE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Lb_Status_Caixa: TLabel
          Left = 486
          Top = 3
          Width = 128
          Height = 20
          Caption = 'Status do Caixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object E_Cd_Cliente: TEdit_Setes
          Left = 3
          Top = 23
          Width = 100
          Height = 30
          TabStop = False
          Alignment = taRightJustify
          BevelInner = bvNone
          BevelOuter = bvSpace
          BevelKind = bkFlat
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = ''
          OnEnter = E_Cd_ClienteEnter
          OnExit = E_Cd_ClienteExit
          OnKeyPress = E_Cd_ClienteKeyPress
        end
        object E_Nome_Cliente: TEdit
          Left = 105
          Top = 23
          Width = 374
          Height = 30
          TabStop = False
          BevelInner = bvNone
          BevelKind = bkFlat
          BevelOuter = bvSpace
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
    object Grp_Totalizador: TPanel
      Left = 0
      Top = 0
      Width = 176
      Height = 573
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BiDiMode = bdLeftToRight
      BorderWidth = 5
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object Lb_Valor_Pedido: TLabel
        Left = 7
        Top = 26
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Valor Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 97
      end
      object Lb_Valor_Desconto: TLabel
        Left = 7
        Top = 156
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Valor Desconto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 117
      end
      object Lb_Valor_Total: TLabel
        Left = 7
        Top = 222
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 80
      end
      object Lb_Taxa_Desconto: TLabel
        Left = 7
        Top = 90
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Taxa Desconto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 114
      end
      object E_Quantidade: TLabel
        Left = 7
        Top = 549
        Width = 162
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = '0'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 6
        ExplicitTop = 484
        ExplicitWidth = 160
      end
      object Lb_TipoVenda: TLabel
        Left = 7
        Top = 513
        Width = 162
        Height = 16
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'CONSUMIDOR - F12'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 444
        ExplicitWidth = 160
      end
      object Lb_Label_Qtde_Total: TLabel
        Left = 7
        Top = 529
        Width = 162
        Height = 20
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'QUANTIDADE '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 463
        ExplicitWidth = 160
      end
      object Lb_Valor_troco: TLabel
        Left = 7
        Top = 350
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Valor Troco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 87
      end
      object E_Data: TLabel
        Left = 7
        Top = 414
        Width = 162
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = '00/00/000'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 6
        ExplicitTop = 344
        ExplicitWidth = 160
      end
      object E_Hora: TLabel
        Left = 7
        Top = 438
        Width = 162
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = '00:00:00'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 6
        ExplicitTop = 366
        ExplicitWidth = 160
      end
      object Lbl_Caixa: TLabel
        Left = 7
        Top = 462
        Width = 162
        Height = 27
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'ECF'
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 6
        ExplicitTop = 393
        ExplicitWidth = 160
      end
      object E_Usuario: TLabel
        Left = 7
        Top = 489
        Width = 162
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Lb_Usuario'
        Color = clWindow
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 6
        ExplicitTop = 416
        ExplicitWidth = 160
      end
      object Lb_Label_totalizador: TLabel
        Left = 7
        Top = 7
        Width = 162
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'TOTALIZADOR'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 112
      end
      object Lb_Vl_Economia: TLabel
        Left = 7
        Top = 286
        Width = 162
        Height = 19
        Align = alTop
        Caption = 'Economia/Promo'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 160
      end
      object E_VL_Troco: TPanel
        Left = 7
        Top = 369
        Width = 162
        Height = 45
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsSingle
        Caption = '0,00'
        Color = clNavy
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        ExplicitTop = 323
      end
      object E_Vl_Total: TPanel
        Left = 7
        Top = 241
        Width = 162
        Height = 45
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsSingle
        Caption = '0,00'
        Color = clNone
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        ExplicitTop = 195
      end
      object E_Vl_Pedido: TPanel
        Left = 7
        Top = 45
        Width = 162
        Height = 45
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsSingle
        Caption = '0,00'
        Color = clNone
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
      end
      object E_Aq_Desconto: TEdit_Setes
        Left = 7
        Top = 109
        Width = 162
        Height = 47
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Color = clWhite
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        Text = '0,00'
        OnEnter = E_Aq_DescontoEnter
        OnExit = E_Aq_DescontoExit
        OnKeyPress = E_Aq_DescontoKeyPress
      end
      object E_Vl_Desconto: TEdit_Setes
        Left = 7
        Top = 175
        Width = 162
        Height = 47
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Color = clWhite
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        Text = '0,00'
        OnEnter = E_Vl_DescontoEnter
        OnExit = E_Vl_DescontoExit
        OnKeyPress = E_Vl_DescontoKeyPress
      end
      object E_Vl_Economia: TPanel
        Left = 7
        Top = 305
        Width = 162
        Height = 45
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsSingle
        Caption = '0,00'
        Color = clWhite
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  object Pnl_rodape: TPanel
    Left = 0
    Top = 653
    Width = 1292
    Height = 65
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 4
    DesignSize = (
      1292
      65)
    object Sb_Desconto: TImage
      Left = 5
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = SB_DescontoClick
    end
    object SB_Cliente: TImage
      Left = 150
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = SB_ClienteClick
    end
    object SB_Pesquisa: TImage
      Left = 292
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = SB_PesquisaClick
    end
    object Sb_logout: TImage
      Left = 868
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = Sb_logoutClick
    end
    object SB_Faturar: TImage
      Left = 724
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = SB_FaturarClick
    end
    object Sb_ExcluiVenda: TImage
      Left = 580
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = Sb_ExcluiVendaClick
    end
    object Sb_ExcluiItem: TImage
      Left = 436
      Top = 7
      Width = 140
      Height = 58
      Anchors = [akLeft, akBottom]
      Center = True
      Picture.Data = {
        0A544A504547496D6167657E050000FFD8FFE000104A46494600010101006000
        600000FFDB004300010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101FFDB00430101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101FFC0001108003A00AA03011100021101031101
        FFC4001900010003010100000000000000000000000008090A0B05FFC4001F10
        00020301010101010101000000000000000403050602070801090A21FFC4001A
        010100020301000000000000000000000000050802040703FFC4002A11010003
        0100010205030403000000000000010203041105060712213141132232145161
        91A1B1D1FFDA000C03010002110311003F00851FD6CFEB87BDFDBFEF7E8B96C8
        7A4EA321F2AE3F537399F32F37CA5DBD4949ADA4A3798AD5FD03791D5B30FE6A
        EFF57F90F7729AD6D23D5B94AD7A0A6A5879979B5B6BA91CB2AD2B1E63F77E66
        7FE94D7DF9EFCF54F72FAA75E38766D87A1F3EFA63C5C78696CF2DF3CED348EA
        EA8A4C7EBEBBF8FD4AC5FE6A614B4679C7F3BE94AC7BB9C80000000000000000
        000000000000000955F2AFDAFF004DFC5DE814DE87F3CFAC6A314E563D033659
        7E2D1E6F01B14B89F9999A2DB62A46B9A3D153D873F9D473C6D2FCBCA77D7361
        4EFD65BAC9D8AD85A95BC78B47FEFF00B4E7A1FB8FD67DBBD59F5FA4F76DCD6A
        5A26F8FCF69E5E8AC4F99CBA79FCFE9ED9DBF3168F9ABFCB3B5348ADE37F5E67
        FE837E07D479BF9F69B71AEB2C76D34588CA5EEBF22B2B5F64BE57516F428585
        FE720B19ADD296C21A3B661BAC89D9535246B85799FB5A0EA4FD8B9D19C34F33
        E23E9E569F8FE2B7B5F6E3E4DBA77BF3F4EBCD86BD184452F186FA655B6B8C5E
        74ACDA33BCDA9169AD667C79988FB39AD922A780000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000012A7ED6F953D07E2CFA67D5BE78
        F44A8B0AF7711A7B28F2F6AE41246A6D300D3CCF78BDC5233D471C4FD4E92939
        5DBE6683FEA6FF003614EFC6ADB55D8A2AE14B45EB168FCFFC4FF64E7B8FD0FA
        BDBBEB3DDE93D79DE96E6DAF18DED13F2F472CDA7FA7E9CE7C445B3DB3F16F31
        FC6DF36768ADE96AC456334180000000000000000000000000000000F42A6A6D
        6FED6B28A8AB2C2EAF2EAC12A9A6A6A9499B2B5B6B5B26634EBAB2B2BD38E66D
        FB07DB9A155249586565A6658E0823EE5EF9E7F4CE94BEB7A65952DA69A5AB4C
        F3A566F7BDEF315A5294AC4DAD6B5A622B588999998888F2D7B799FF0095DD96
        93CDFCFF0045B9F60ACC66DAFF001194BAD8E3D8FD7596327A9B4A141ED066A7
        611A77129E6A2B69DBAB9664DB69597B57AED76268BAE24EB527ABEB3E2BF4F2
        EF9C7F047A36E3E4DBA7BE9CFD3AF361A7473CCDA670DEF956DAE3335CAD599C
        AF36A4CD6D68FDBF4998FAAEA7FBFDE63E6BABF85B43B5D4F9EE1F4BB2C85F56
        A993D6DFE4E86E34D9856D16B492CD6CEDF58A0C5A52AF63226A48FC35AD2D1B
        9DAAB74C73275045FBCF8633317FA4CFDA7F2E8DF1538B8F7F6CEBD3BF2736DD
        18695AE1BEB865A6D8D6F5D26F196B7ACDF38BCD6B368A5A22D358F3F6873502
        494E800000000000000000000000000000006C47FCB2F98F9AE8B59EA3BBD079
        EE1EF76F8FA191BC8ECAE7274367AACB34C5E295CC339CD0BA84F6F48C4F5ECB
        08CD35638B492A73CCB77D7EC32F7C75A7D333F6F33E3CFDBCFF008581F825C5
        C7B6FDBD3AF2736BD3CF9CDB0E8D30CAFBE169D29599C75B5674CE66B33599A5
        A27E5998FB4B6CE69AC7BFFFD9}
      Stretch = True
      OnClick = Sb_ExcluiItemClick
    end
    object Label11: TLabel
      Left = 150
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Clientes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_ClienteClick
    end
    object Label12: TLabel
      Left = 150
      Top = 8
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_ClienteClick
    end
    object Label13: TLabel
      Left = 292
      Top = 8
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_PesquisaClick
    end
    object Label15: TLabel
      Left = 870
      Top = 6
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F10'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_logoutClick
    end
    object Label17: TLabel
      Left = 436
      Top = 8
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_ExcluiItemClick
    end
    object Label21: TLabel
      Left = 5
      Top = 8
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_DescontoClick
    end
    object Label9: TLabel
      Left = 868
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Fechar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_logoutClick
    end
    object Label6: TLabel
      Left = 292
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Pesquisa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_PesquisaClick
    end
    object Label5: TLabel
      Left = 4
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Desconto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_DescontoClick
    end
    object Label27: TLabel
      Left = 724
      Top = 6
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F9'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_FaturarClick
    end
    object Label24: TLabel
      Left = 580
      Top = 8
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'F8'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_ExcluiVendaClick
    end
    object Label23: TLabel
      Left = 580
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Exclui'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_ExcluiVendaClick
    end
    object Label18: TLabel
      Left = 436
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Marca Item'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Sb_ExcluiItemClick
    end
    object Label26: TLabel
      Left = 725
      Top = 32
      Width = 140
      Height = 30
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Finalizar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = SB_FaturarClick
    end
  end
  object Pnl_TEF_Geral: TPanel
    Left = 0
    Top = 593
    Width = 1292
    Height = 60
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 5
    object Pnl_Msg_TEF: TPanel
      Left = 2
      Top = 2
      Width = 331
      Height = 56
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object lMensagemOperador: TLabel
        Left = 2
        Top = 2
        Width = 327
        Height = 52
        Align = alClient
        Alignment = taCenter
        Caption = 'lMensagemOperador'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 98
        ExplicitHeight = 13
      end
      object Label48: TLabel
        Left = 2
        Top = 1
        Width = 118
        Height = 13
        Caption = 'Mensagem Operador'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
    object Pnl_tef_Msg: TPanel
      Left = 438
      Top = 2
      Width = 852
      Height = 56
      Align = alClient
      TabOrder = 1
      object mm_Tef: TMemo
        Left = 1
        Top = 1
        Width = 850
        Height = 54
        TabStop = False
        Align = alClient
        ReadOnly = True
        TabOrder = 0
      end
    end
    object Pnl_Tef_Cancela: TPanel
      Left = 333
      Top = 2
      Width = 105
      Height = 56
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object bCancelarResp: TButton
        Left = 5
        Top = 2
        Width = 92
        Height = 52
        Caption = 'Cancelar - TEF'
        TabOrder = 0
        Visible = False
        WordWrap = True
      end
    end
  end
  object Pnl_TabelaPreco: TPanel
    Left = 392
    Top = 328
    Width = 421
    Height = 97
    Anchors = []
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    Visible = False
    DesignSize = (
      419
      95)
    object Sb_Confirma_TabelaPreco: TButton
      Left = 168
      Top = 62
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = '&Confirma - F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Sb_Confirma_TabelaPrecoClick
    end
    object Sb_Cancela_TabelaPreco: TButton
      Left = 290
      Top = 62
      Width = 122
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cance&la - ESC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Sb_Cancela_TabelaPrecoClick
    end
    inline Fm_ListaTabelaPreco: TFm_ListaTabelaPreco
      Left = 3
      Top = 3
      Width = 414
      Height = 56
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 414
      ExplicitHeight = 56
      DesignSize = (
        414
        56)
      inherited Label53: TLabel
        Width = 414
        Height = 24
        Align = alTop
        Caption = 'Informe qual Tabela de Pre'#231'o Ser'#225' Utilizada'
        Color = clNavy
        Font.Color = clWhite
        Font.Height = -21
        ParentColor = False
        ExplicitWidth = 407
        ExplicitHeight = 24
      end
      inherited Sb_Preco: TSpeedButton
        Left = 405
        Top = 30
        Visible = False
        ExplicitLeft = 405
        ExplicitTop = 30
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Left = 2
        Top = 25
        Width = 411
        Height = 31
        Anchors = [akRight, akBottom]
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        ParentFont = False
        ExplicitLeft = 2
        ExplicitTop = 25
        ExplicitWidth = 411
        ExplicitHeight = 31
      end
      inherited Qr_Tabelas: TSTQuery
        Top = 11
      end
      inherited Ds_Tabelas: TDataSource
        Left = 179
        Top = 11
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 496
  end
  object Ac_Funcoes: TActionList
    Left = 110
    Top = 506
    object Ac_Gaveta: TAction
      Caption = 'Frente de Caixa'
      ShortCut = 16455
      OnExecute = Ac_GavetaExecute
    end
    object Liberacao: TAction
      Caption = 'Liberacao'
      ShortCut = 16449
      OnExecute = LiberacaoExecute
    end
    object GoCodigoCliente: TAction
      Caption = 'GoCodigoCliente'
      ShortCut = 16500
      OnExecute = GoCodigoClienteExecute
    end
  end
  object MenuOper: TMainMenu
    Left = 740
    Top = 244
    object Tarefas: TMenuItem
      AutoCheck = True
      Caption = 'Tarefas'
      object VendasBalcao: TMenuItem
        Caption = 'Carregar pedido n'#227'o faturado'
        OnClick = VendasBalcaoClick
      end
      object PedidosEmitidos: TMenuItem
        Caption = 'Pedidos Emitidos'
        OnClick = PedidosEmitidosClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CartoPrPago1: TMenuItem
        Caption = 'Movimento Cart'#227'o Pr'#233'-Pago'
        OnClick = CartoPrPago1Click
      end
      object LanamentoCrditoPrPago1: TMenuItem
        Caption = 'Lan'#231'amento Cr'#233'dito Pr'#233'-Pago'
        OnClick = LanamentoCrditoPrPago1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object ProgramaPAYBACK1: TMenuItem
        Caption = 'Programa PAYBACK'
        OnClick = ProgramaPAYBACK1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Observao1: TMenuItem
        Caption = 'Observa'#231#227'o'
        ShortCut = 16463
        OnClick = Observao1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MnuPromoces: TMenuItem
        Caption = 'Promo'#231#245'es'
        OnClick = MnuPromocesClick
      end
      object AlterarPreosconformeTabelaAtiva1: TMenuItem
        Caption = 'Alterar Tabelas de Pre'#231'os '
        OnClick = AlterarPreosconformeTabelaAtiva1Click
      end
      object AlterarPreo1: TMenuItem
        Caption = 'Alterar Pre'#231'o'
        OnClick = AlterarPreo1Click
      end
      object AdministrativoTEF1: TMenuItem
        Caption = 'Administrativo TEF'
        OnClick = AdministrativoTEF1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object LanamentodeCaixa1: TMenuItem
        Caption = 'Lan'#231'amento de Caixa'
        OnClick = LanamentodeCaixa1Click
      end
      object FechamentoVendas1: TMenuItem
        Caption = 'Fechamento Vendas'
        OnClick = FechamentoVendas1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MnuSalvarComanda: TMenuItem
        Caption = 'Salvar Comanda'
        ShortCut = 16496
        OnClick = MnuSalvarComandaClick
      end
      object MnuConsultarComanda: TMenuItem
        Caption = 'Consultar Comanda'
        ShortCut = 16497
        OnClick = MnuConsultarComandaClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MnuSalvarDelivery: TMenuItem
        Caption = 'Salvar Delivery'
        ShortCut = 16498
        OnClick = MnuSalvarDeliveryClick
      end
      object MnuConsultarDelivery: TMenuItem
        Caption = 'Consultar Delivery'
        ShortCut = 16499
        OnClick = MnuConsultarDeliveryClick
      end
      object ComissoDelivery1: TMenuItem
        Caption = 'Comiss'#227'o Motoboy'
        OnClick = ComissoDelivery1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object OcultarBarradeTarefasWindows: TMenuItem
        Caption = 'Ocultar Barra de Tarefas Windows'
        Checked = True
        OnClick = OcultarBarradeTarefasWindowsClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Sair2: TMenuItem
        Caption = 'Sair'
        OnClick = Sair2Click
      end
    end
    object Atualizao1: TMenuItem
      Caption = '| Atualiza'#231#227'o - Ctrl + F5 |'
      ShortCut = 16500
      OnClick = Atualizao1Click
    end
    object MenuOperMenuFiscal: TMenuItem
      Caption = 'Menu Fiscal - Ctrl + F6 |'
      ShortCut = 16501
      OnClick = MenuOperMenuFiscalClick
    end
  end
  object Qr_Pedido: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '  PED_CODIGO,'
      '  PED_CODEMP,'
      '  PED_CODVDO,'
      '  EMP_CONSUMIDOR,'
      '  EMP_NOME,'
      '  EMP_MICRO,'
      '  UFE_CODIGO,'
      '  UFE_SIGLA,'
      '  EMP_FABRICA,'
      '  EMP_SUB_TRIB,'
      '  EMP_INSC_EST,'
      '  EMP_CNPJ,'
      '  CDD_DESCRICAO,'
      '  END_NUMERO,'
      '  END_PAIS,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_ENDER,'
      ' ped_codend,'
      ' PED_VL_PEDIDO,'
      'PED_PRAZO,'
      'PED_DATA,'
      
        'PED_VL_SERVICO, PED_VL_PRODUTO, PED_VL_ODESPESA, PED_VL_IPI, PED' +
        '_VL_FRETE, PED_VL_DESCONTO, PED_NUMERO,PED_CODFPG, FPT_DESCRICAO'
      ''
      'FROM TB_PEDIDO tb_pedido'
      '   INNER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)'
      '   INNER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '   INNER JOIN TB_PAIS tb_pais'
      '   ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      '   INNER JOIN TB_FORMAPAGTO tb_formapagto'
      '   ON(tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG)'
      ''
      'WHERE (PED_CODIGO=:PED_CODIGO) ')
    Left = 320
    Top = 504
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object popmenu: TPopupMenu
    Left = 818
    Top = 317
    object Cadastrodeproduto1: TMenuItem
      Caption = 'Cadastro de produto'
      OnClick = Cadastrodeproduto1Click
    end
    object DadosNCM1: TMenuItem
      Caption = 'Dados NCM'
      OnClick = DadosNCM1Click
    end
    object VerprodutosdestaPromoo1: TMenuItem
      Caption = 'Ver produtos desta Promo'#231#227'o'
      OnClick = VerprodutosdestaPromoo1Click
    end
  end
  object TEF: TACBrTEFD
    Identificacao.NomeAplicacao = 'Gest'#227'o Setes'
    Identificacao.VersaoAplicacao = '2.016'
    Identificacao.SoftwareHouse = 'Setes'
    Identificacao.RazaoSocial = 'F.D.S - Desenvolvimento'
    MultiplosCartoes = True
    NumeroMaximoCartoes = 3
    AutoAtivarGP = False
    ExibirMsgAutenticacao = False
    AutoFinalizarCupom = False
    EsperaSTS = 7
    SuportaSaque = False
    SuportaDesconto = False
    TEFPayGo.AutoAtivarGP = False
    TEFPayGo.ArqTemp = 'C:\PAYGO\REQ\intpos.tmp'
    TEFPayGo.ArqReq = 'C:\PAYGO\REQ\intpos.001'
    TEFPayGo.ArqSTS = 'C:\PAYGO\RESP\intpos.sts'
    TEFPayGo.ArqResp = 'C:\PAYGO\RESP\intpos.001'
    TEFPayGoWeb.SuportaViasDiferenciadas = True
    TEFPayGoWeb.UtilizaSaldoTotalVoucher = False
    TEFPayGoWeb.ConfirmarTransacoesPendentes = True
    TEFPayGoWeb.PerguntarCartaoDigitadoAposCancelarLeitura = False
    TEFDial.ArqLOG = 'TEF_DIAL.log'
    TEFDial.Habilitado = True
    TEFDial.AutoAtivarGP = False
    TEFDial.ArqTemp = 'C:\TEF_DIAL\req\intpos.tmp'
    TEFDial.ArqReq = 'C:\TEF_DIAL\req\intpos.001'
    TEFDial.ArqSTS = 'C:\TEF_DIAL\resp\intpos.sts'
    TEFDial.ArqResp = 'C:\TEF_DIAL\resp\intpos.001'
    TEFDial.GPExeName = 'C:\TEF_DIAL\tef_dial.exe'
    TEFDisc.AutoAtivarGP = False
    TEFDisc.ArqTemp = 'C:\TEF_Disc\req\intpos.tmp'
    TEFDisc.ArqReq = 'C:\TEF_Disc\req\intpos.001'
    TEFDisc.ArqSTS = 'C:\TEF_Disc\resp\intpos.sts'
    TEFDisc.ArqResp = 'C:\TEF_Disc\resp\intpos.001'
    TEFDisc.GPExeName = 'C:\TEF_Disc\tef_Disc.exe'
    TEFHiper.AutoAtivarGP = False
    TEFHiper.ArqTemp = 'c:\HiperTEF\req\IntPos.tmp'
    TEFHiper.ArqReq = 'C:\HiperTEF\req\IntPos.001'
    TEFHiper.ArqSTS = 'C:\HiperTEF\resp\IntPos.sts'
    TEFHiper.ArqResp = 'C:\HiperTEF\resp\IntPos.001'
    TEFHiper.GPExeName = 'C:\HiperTEF\HiperTEF.exe'
    TEFCliSiTef.ArqLOG = 'CliSiTef.log'
    TEFCliSiTef.EnderecoIP = '127.0.0.1'
    TEFCliSiTef.CodigoLoja = '00000000'
    TEFCliSiTef.NumeroTerminal = 'SE000001'
    TEFCliSiTef.PortaPinPad = 8
    TEFCliSiTef.OnExibeMenu = TEFCliSiTefExibeMenu
    TEFCliSiTef.OnObtemCampo = TEFCliSiTefObtemCampo
    TEFCliSiTef.ExibirErroRetorno = True
    TEFVeSPague.ArqLOG = 'VeSPague.log'
    TEFVeSPague.Aplicacao = 'ACBr_TEFDDemo'
    TEFVeSPague.AplicacaoVersao = '1.0'
    TEFVeSPague.GPExeName = 'C:\VeSPague\Client\VeSPagueClient.bat'
    TEFVeSPague.GPExeParams = '189.115.24.32 65432'
    TEFVeSPague.EnderecoIP = 'localhost'
    TEFVeSPague.Porta = '60906'
    TEFVeSPague.TimeOut = 500
    TEFVeSPague.TemPendencias = False
    TEFVeSPague.TransacaoCRT = 'Cartao Vender'
    TEFVeSPague.TransacaoCHQ = 'Cheque Consultar'
    TEFVeSPague.TransacaoCNC = 'Administracao Cancelar'
    TEFVeSPague.TransacaoReImpressao = 'Administracao Reimprimir'
    TEFVeSPague.TransacaoPendente = 'Administracao Pendente'
    TEFGPU.AutoAtivarGP = False
    TEFGPU.ArqTemp = 'C:\TEF_GPU\req\intpos.tmp'
    TEFGPU.ArqReq = 'C:\TEF_GPU\req\intpos.001'
    TEFGPU.ArqSTS = 'C:\TEF_GPU\resp\intpos.sts'
    TEFGPU.ArqResp = 'C:\TEF_GPU\resp\intpos.001'
    TEFGPU.GPExeName = 'C:\TEF_GPU\GPU.exe'
    TEFBanese.ArqTemp = 'C:\bcard\req\pergunta.tmp'
    TEFBanese.ArqReq = 'C:\bcard\req\pergunta.txt'
    TEFBanese.ArqSTS = 'C:\bcard\resp\status.txt'
    TEFBanese.ArqResp = 'C:\bcard\resp\resposta.txt'
    TEFBanese.ArqRespBkp = 'C:\bcard\resposta.txt'
    TEFBanese.ArqRespMovBkp = 'C:\bcard\copiamovimento.txt'
    TEFAuttar.AutoAtivarGP = False
    TEFAuttar.ArqTemp = 'C:\Auttar_TefIP\req\intpos.tmp'
    TEFAuttar.ArqReq = 'C:\Auttar_TefIP\req\intpos.001'
    TEFAuttar.ArqSTS = 'C:\Auttar_TefIP\resp\intpos.sts'
    TEFAuttar.ArqResp = 'C:\Auttar_TefIP\resp\intpos.001'
    TEFAuttar.GPExeName = 'C:\Program Files (x86)\Auttar\IntegradorTEF-IP.exe'
    TEFGood.AutoAtivarGP = False
    TEFGood.ArqTemp = 'C:\good\gettemp.dat'
    TEFGood.ArqReq = 'C:\good\getreq.dat'
    TEFGood.ArqSTS = 'C:\good\getstat.dat'
    TEFGood.ArqResp = 'C:\good\getresp.dat'
    TEFGood.GPExeName = 'C:\good\GETGoodMed.exe'
    TEFFoxWin.AutoAtivarGP = False
    TEFFoxWin.ArqTemp = 'C:\FwTEF\req\intpos.tmp'
    TEFFoxWin.ArqReq = 'C:\FwTEF\req\intpos.001'
    TEFFoxWin.ArqSTS = 'C:\FwTEF\rsp\intpos.sts'
    TEFFoxWin.ArqResp = 'C:\FwTEF\rsp\intpos.001'
    TEFFoxWin.GPExeName = 'C:\FwTEF\bin\FwTEF.exe'
    TEFCliDTEF.ArqResp = ''
    TEFPetrocard.AutoAtivarGP = False
    TEFPetrocard.ArqTemp = 'C:\CardTech\req\intpos.tmp'
    TEFPetrocard.ArqReq = 'C:\CardTech\req\intpos.001'
    TEFPetrocard.ArqSTS = 'C:\CardTech\resp\intpos.sts'
    TEFPetrocard.ArqResp = 'C:\CardTech\resp\intpos.001'
    TEFPetrocard.GPExeName = 'C:\CardTech\sac.exe'
    TEFCrediShop.AutoAtivarGP = False
    TEFCrediShop.ArqTemp = 'C:\tef_cshp\req\intpos.tmp'
    TEFCrediShop.ArqReq = 'C:\tef_cshp\req\intpos.001'
    TEFCrediShop.ArqSTS = 'C:\tef_cshp\resp\intpos.sts'
    TEFCrediShop.ArqResp = 'C:\tef_cshp\resp\intpos.001'
    TEFCrediShop.GPExeName = 'C:\tef_cshp\vpos_tef.exe'
    TEFTicketCar.ArqTemp = 'C:\TCS\TX\INTTCS.tmp'
    TEFTicketCar.ArqReq = 'C:\TCS\TX\INTTCS.001'
    TEFTicketCar.ArqSTS = 'C:\TCS\RX\INTTCS.RET'
    TEFTicketCar.ArqResp = 'C:\TCS\RX\INTTCS.001'
    TEFTicketCar.GPExeName = 'C:\TCS\tcs.exe'
    TEFTicketCar.NumLoja = 0
    TEFTicketCar.NumCaixa = 0
    TEFTicketCar.AtualizaPrecos = False
    TEFConvCard.AutoAtivarGP = False
    TEFConvCard.ArqTemp = 'C:\ger_convenio\tx\crtsol.tmp'
    TEFConvCard.ArqReq = 'C:\ger_convenio\tx\crtsol.001'
    TEFConvCard.ArqSTS = 'C:\ger_convenio\rx\crtsol.ok'
    TEFConvCard.ArqResp = 'C:\ger_convenio\rx\crtsol.001'
    TEFConvCard.GPExeName = 'C:\ger_convcard\convcard.exe'
    TEFCliSiTefModular.AutoAtivarGP = False
    TEFCliSiTefModular.ArqTemp = 'C:\Client\req\intpos.tmp'
    TEFCliSiTefModular.ArqReq = 'C:\Client\req\intpos.001'
    TEFCliSiTefModular.ArqSTS = 'C:\Client\resp\intpos.sts'
    TEFCliSiTefModular.ArqResp = 'C:\Client\resp\intpos.001'
    TEFCliSiTefModular.GPExeName = 'C:\Client\ClientSiTef.exe'
    TEFDirecao.AutoAtivarGP = False
    TEFDirecao.ArqTemp = 'C:\TEF_DIAL\req\intpos.tmp'
    TEFDirecao.ArqReq = 'C:\TEF_DIAL\req\intpos.001'
    TEFDirecao.ArqSTS = 'C:\TEF_DIAL\resp\intpos.sts'
    TEFDirecao.ArqResp = 'C:\TEF_DIAL\resp\intpos.001'
    TEFDirecao.GPExeName = 'C:\DPOS8\Bin\GPDirecao.exe'
    TEFElgin.AutoAtivarGP = False
    TEFElgin.ArqTemp = 'C:\Cliente\req\intpos.tmp'
    TEFElgin.ArqReq = 'C:\Cliente\req\intpos.001'
    TEFElgin.ArqSTS = 'C:\Cliente\resp\intpos.sts'
    TEFElgin.ArqResp = 'C:\Cliente\resp\intpos.001'
    TEFElgin.GPExeName = 'C:\ELGIN\TEFPassivo\E1_TEFPay_Passivo.exe'
    OnAguardaResp = TEFAguardaResp
    OnExibeMsg = TEFExibeMsg
    OnExibeQRCode = TEFExibeQRCode
    OnBloqueiaMouseTeclado = TEFBloqueiaMouseTeclado
    OnRestauraFocoAplicacao = TEFRestauraFocoAplicacao
    OnComandaECF = TEFComandaECF
    OnComandaECFSubtotaliza = TEFComandaECFSubtotaliza
    OnComandaECFAbreVinculado = TEFComandaECFAbreVinculado
    OnComandaECFImprimeVia = TEFComandaECFImprimeVia
    OnInfoECF = TEFInfoECF
    OnAntesFinalizarRequisicao = TEFAntesFinalizarRequisicao
    OnDepoisConfirmarTransacoes = TEFDepoisConfirmarTransacoes
    OnMudaEstadoReq = TEFMudaEstadoReq
    OnMudaEstadoResp = TEFMudaEstadoResp
    Left = 32
    Top = 88
  end
  object ImageList1: TImageList
    Left = 344
    Top = 368
    Bitmap = {
      494C01010200E402F00210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F0000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C0008080800000000000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000C0C0C000C0C0
      C00000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F000000000000000000000000000000000000000000C0C0C0000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF007F7F7F00FFFF
      FF00000000000000000000FF000000800000008000000000000000000000FFFF
      FF007F7F7F007F7F7F00000000000000000000000000C0C0C00080808000FFFF
      FF0000000000000000000000FF0000008000000080000000000000000000FFFF
      FF00808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF000000000000FF
      00000000000000FF00000080000000FF000000800000008000000000000000FF
      0000000000007F7F7F00000000000000000000000000C0C0C000000000000000
      FF00000000000000FF00000080000000FF000000800000008000000000000000
      FF00000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF00000080000000000000FFFF
      FF00000000007F7F7F00000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF000000800000000000FFFF
      FF00000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF00000080000000FF00000000000000FF
      000000000000BFBFBF00000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF00000080000000FF00000000000000
      FF0000000000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007F7F7F00BFBFBF00000000000000000000000000FFFFFF0080808000FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF0080808000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF000000000000000000000000000000000000000000C0C0C0000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BFBF
      BF00BFBFBF000000000000000000000000000000000000000000FFFFFF00C0C0
      C00000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00C0C0C0008080800000000000000000000000000080808000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F83FF83F00000000
      E00FE00F00000000C007C0070000000080038003000000008003800300000000
      0001000100000000000100010000000000010001000000000001000100000000
      000100010000000080038003000000008003800300000000C007C00700000000
      E00FE00F00000000F83FF83F0000000000000000000000000000000000000000
      000000000000}
  end
  object IBT_Pesq_Produto: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 228
    Top = 452
  end
  object Qr_PesqProduto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Pesq_Produto
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '   PRO_CODIGO,'
      '   PRO_CODIGOFAB,'
      '  PRO_CODIGOBAR,'
      '   PRO_CODIGOFOR,'
      '  PRO_CODIGONCM,'
      '  PRO_ORIGEM,'
      '   PRO_DESCRICAO,'
      '   EST_QTDE,'
      '   PRO_VL_CUSTO,'
      '   MED_ABREVIATURA,'
      '   PRC_VL_VDA,'
      '   PRC_AQ_COM,'
      '   PRO_CAMPANHA'
      'FROM TB_PRODUTO tb_produto'
      '   INNER JOIN TB_PRECO tb_preco '
      '   ON (tb_preco.PRC_CODPRO = tb_produto.PRO_CODIGO) '
      '   INNER JOIN TB_ESTOQUE tb_estoque'
      '   ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO)'
      '  INNER JOIN tb_medida tb_medida'
      '   ON (tb_medida.med_codigo = tb_produto.pro_codmed)'
      ''
      'WHERE (PRO_CODIGO IS NOT NULL) AND (PRC_CODTPR =:PRC_CODTPR)')
    Left = 232
    Top = 400
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRC_CODTPR'
        ParamType = ptUnknown
      end>
  end
end

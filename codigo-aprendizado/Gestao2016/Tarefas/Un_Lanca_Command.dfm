object Fr_Lanca_Command: TFr_Lanca_Command
  Left = 185
  Top = 0
  Align = alClient
  Anchors = []
  BorderIcons = [biMaximize]
  BorderStyle = bsNone
  Caption = 'Lan'#231'a Comanda'
  ClientHeight = 662
  ClientWidth = 1292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Fiscal
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  DesignSize = (
    1292
    662)
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
    Height = 642
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 3
    object Pnl_Corpo_Items: TPanel
      Left = 176
      Top = 0
      Width = 1116
      Height = 642
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BorderWidth = 5
      TabOrder = 0
      object StrGrd_Produtos: TStringGrid
        Left = 7
        Top = 86
        Width = 1102
        Height = 549
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        ColCount = 17
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
          64)
        RowHeights = (
          25
          25)
      end
      object Pnl_Lanca_Items: TPanel
        Left = 7
        Top = 48
        Width = 1102
        Height = 38
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Label31: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 7
          Width = 32
          Height = 20
          Margins.Top = 5
          Align = alLeft
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
          AlignWithMargins = True
          Left = 102
          Top = 7
          Width = 22
          Height = 20
          Margins.Top = 5
          Align = alLeft
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
          AlignWithMargins = True
          Left = 306
          Top = 5
          Width = 791
          Height = 28
          Align = alClient
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
          ExplicitLeft = 300
          ExplicitTop = 6
          ExplicitWidth = 796
          ExplicitHeight = 29
        end
        object E_Qtde: TEdit_Setes
          AlignWithMargins = True
          Left = 43
          Top = 5
          Width = 53
          Height = 28
          TabStop = False
          Align = alLeft
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
          AlignWithMargins = True
          Left = 130
          Top = 5
          Width = 170
          Height = 28
          Align = alLeft
          CharCase = ecUpperCase
          Color = clScrollBar
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentCtl3D = False
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
        Height = 41
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object Label19: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 10
          Width = 120
          Height = 26
          Margins.Top = 8
          Align = alLeft
          AutoSize = False
          Caption = 'F5 - Comanda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Numero_Comanda: TEdit_Setes
          AlignWithMargins = True
          Left = 131
          Top = 5
          Width = 170
          Height = 31
          Align = alLeft
          CharCase = ecUpperCase
          Color = clScrollBar
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnEnter = E_Numero_ComandaEnter
          OnExit = E_Numero_ComandaExit
          OnKeyPress = E_Numero_ComandaKeyPress
          IsCodigo = True
          ExplicitHeight = 32
        end
      end
    end
    object Grp_Totalizador: TPanel
      Left = 0
      Top = 0
      Width = 176
      Height = 642
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
        Width = 97
        Height = 19
        Align = alTop
        Caption = 'Valor Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 7
        Top = 7
        Width = 112
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
        TabOrder = 0
      end
      object pnl_F10: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 569
        Width = 156
        Height = 63
        Align = alBottom
        Caption = 'pnl_F10'
        TabOrder = 1
        DesignSize = (
          156
          63)
        object img_F10: TImage
          Left = 1
          Top = 1
          Width = 154
          Height = 61
          Align = alClient
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
          ExplicitLeft = 6
          ExplicitTop = 6
        end
        object Lb_F10: TLabel
          Left = 5
          Top = 3
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
          OnClick = Lb_F10Click
        end
        object Lb_Fechar: TLabel
          Left = 5
          Top = 28
          Width = 140
          Height = 30
          Alignment = taCenter
          AutoSize = False
          Caption = 'Fechar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          OnClick = Lb_FecharClick
        end
      end
      object pnl_F4: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 93
        Width = 156
        Height = 63
        Align = alTop
        TabOrder = 2
        DesignSize = (
          156
          63)
        object img_F4: TImage
          Left = 1
          Top = 1
          Width = 154
          Height = 61
          Align = alClient
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
          ExplicitLeft = 6
          ExplicitTop = 6
        end
        object Lb_F4: TLabel
          Left = 5
          Top = 3
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
          OnClick = Lb_F4Click
        end
        object Lb_Salvar: TLabel
          Left = 5
          Top = 33
          Width = 140
          Height = 30
          Alignment = taCenter
          AutoSize = False
          Caption = 'Salvar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          OnClick = Lb_SalvarClick
        end
      end
      object pnl_F6: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 162
        Width = 156
        Height = 63
        Align = alTop
        TabOrder = 3
        DesignSize = (
          156
          63)
        object img_f6: TImage
          Left = 1
          Top = 1
          Width = 154
          Height = 61
          Align = alClient
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
          OnClick = img_f6Click
          ExplicitLeft = 6
          ExplicitTop = 6
        end
        object Lb_F6: TLabel
          Left = 5
          Top = 0
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
          OnClick = Lb_F6Click
        end
        object Lb_Pesquisa: TLabel
          Left = 5
          Top = 28
          Width = 140
          Height = 30
          Alignment = taCenter
          AutoSize = False
          Caption = 'Pesquisa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          OnClick = Lb_PesquisaClick
        end
      end
    end
  end
  object Pnl_TabelaPreco: TPanel
    Left = 392
    Top = 299
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
      Top = 65
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
        ExplicitHeight = 30
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
    Left = 216
    Top = 504
  end
  object Qr_PesqProduto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
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
    Left = 272
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PRC_CODTPR'
        ParamType = ptUnknown
      end>
  end
  object Ac_Funcoes: TActionList
    Left = 206
    Top = 450
    object Ac_Gaveta: TAction
      Caption = 'Frente de Caixa'
      ShortCut = 16455
    end
    object Liberacao: TAction
      Caption = 'Liberacao'
      ShortCut = 16496
      OnExecute = LiberacaoExecute
    end
    object GoCodigoCliente: TAction
      Caption = 'GoCodigoCliente'
      ShortCut = 16500
      OnExecute = GoCodigoClienteExecute
    end
  end
  object Mnu_Fiscal: TMainMenu
    Left = 740
    Top = 244
    object Tarefas: TMenuItem
      AutoCheck = True
      Caption = 'Tarefas'
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
      end
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
  end
  object ImageList1: TImageList
    Left = 344
    Top = 368
    Bitmap = {
      494C01010200F000F80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
end

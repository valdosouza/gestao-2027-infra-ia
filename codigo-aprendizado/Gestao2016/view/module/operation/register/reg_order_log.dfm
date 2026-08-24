inherited RegOrderLog: TRegOrderLog
  Caption = 'Log de Pedido'
  ClientHeight = 588
  ClientWidth = 751
  ExplicitWidth = 757
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 13
  object Label12: TLabel [0]
    Left = 0
    Top = 252
    Width = 751
    Height = 20
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Detalhes do Pedido'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 742
  end
  object GroupBox1: TGroupBox [1]
    Left = 0
    Top = 0
    Width = 751
    Height = 105
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object L_Pedido: TLabel
      Left = 173
      Top = 14
      Width = 32
      Height = 14
      Caption = 'Pedido'
      FocusControl = E_Pedido
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_BuscaFantasia: TLabel
      Left = 496
      Top = 14
      Width = 71
      Height = 14
      Caption = 'Nome Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_BuscaRazao: TLabel
      Left = 242
      Top = 14
      Width = 99
      Height = 14
      Caption = 'Nome / Raz'#227'o Social'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object RG_Situacao: TRadioGroup
      Left = 6
      Top = 54
      Width = 205
      Height = 43
      Caption = 'Situa'#231#227'o do Documento'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Excluidos'
        'Ativos'
        'Todos')
      TabOrder = 3
    end
    object E_Pedido: TMaskEdit
      Left = 169
      Top = 31
      Width = 68
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
    object Rg_Tipo: TRadioGroup
      Left = 220
      Top = 54
      Width = 277
      Height = 43
      Caption = 'Tipo do Documento'
      Columns = 4
      ItemIndex = 3
      Items.Strings = (
        'Venda'
        'Compra'
        'Ajuste'
        'Todos')
      TabOrder = 4
    end
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 31
      Width = 81
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Checked = False
      TabOrder = 0
    end
    object E_Data_Fim: TDateTimePicker
      Left = 86
      Top = 31
      Width = 81
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      Checked = False
      TabOrder = 1
    end
    object ChBx_Periodo: TCheckBox
      Left = 7
      Top = 16
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 5
    end
    object ChBx_Bloqueados: TCheckBox
      Left = 503
      Top = 62
      Width = 128
      Height = 12
      Caption = 'Somente Bloqueados'
      TabOrder = 6
    end
    object E_BuscaRazao: TMaskEdit
      Left = 239
      Top = 31
      Width = 252
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = ''
    end
    object E_BuscaFantasia: TMaskEdit
      Left = 497
      Top = 31
      Width = 242
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = ''
    end
  end
  object DBG_Pesquisa: TDBGrid [2]
    Left = 0
    Top = 105
    Width = 751
    Height = 147
    Align = alTop
    Color = clCream
    DataSource = dsPedido
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PED_NUMERO'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FPT_DESCRICAO'
        Title.Caption = 'Tipo Cobran'#231'a'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 123
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PED_DATA'
        Title.Caption = 'Data'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOME'
        Title.Caption = 'Cliente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 218
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USU_NOME'
        Title.Caption = 'Usu'#225'rio'
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
        FieldName = 'PED_DT_ALTERA'
        Title.Caption = #218'ltima Modifica'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 117
        Visible = True
      end>
  end
  object DBG_Itens: TDBGrid [3]
    Left = 0
    Top = 272
    Width = 751
    Height = 252
    TabStop = False
    Align = alBottom
    Anchors = [akTop, akBottom]
    Color = clCream
    DataSource = dsDetalhesPedido
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PRO_CODIGOFAB'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRO_DESCRICAO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 304
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_QTDE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_UNIT'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITF_VL_SUBTOTAL'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 123
        Visible = True
      end>
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 524
    Width = 751
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 546
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
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
      ExplicitTop = 4
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 648
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
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
      ExplicitTop = 4
    end
    object SB_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 342
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Excluir - F4'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFF2F2F2A2A2ADDEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF7F7F7A4A4AFD9D9D9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF7F7F76565AF4C4CEF57578EE4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB
        FBFB6E6EAD4848EF4E4E91DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F7F7F76464AE7B7BFFBEBEFF6E6EF758588EE4E4E4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6E
        6EAC7777FFA6A6FF6161FC505091DEDEDEFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7
        6464AE7070FF9595FF8282FFB7B7FF7171F858588EE4E4E4FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6E6EAC7D
        7DFF9393FF4B4BFF7A7AFF5858FC505091DEDEDEFFFFFFFFFFFFF6F6F66464AE
        6363FF8484FF6F6FFF7E7EFF9090FFBEBEFF7272F858588EE4E4E4FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6F6FAC7F7FFF9D
        9DFF5757FF4747FF3939FF6868FF4D4DFC505091DDDDDDFFFFFF6A6AB75454FF
        7070FF5E5EFF6E6EFF7E7EFF8B8BFF9C9CFFC2C2FF7171F858588EE4E4E4FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6F6FAC8080FFA4A4FF64
        64FF5656FF4848FF3737FF2828FF5252FF3E3EFC535395EEEEEE3939F16C6CFF
        5454FF5959FF6B6BFF7979FF8787FF9494FFA3A3FFC3C3FF6F6FF858588EE4E4
        E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6E6EAC7E7EFFA8A8FF6F6FFF62
        62FF5454FF4545FF3636FF2121FF2A2AFF5656FF3E3ED8F2F2F2D4D4DD4141E8
        6A6AFF5D5DFF6464FF7474FF8181FF8D8DFF9A9AFFA7A7FFC0C0FF6B6BF75858
        8EE4E4E4FFFFFFFFFFFFFFFFFFFBFBFB6E6EAC7B7BFFA9A9FF7878FF6B6BFF5E
        5EFF4F4FFF4040FF2E2EFF3333FF5454FF4141DEDFDFE4FFFFFFFFFFFFD6D6DE
        4343E66E6EFF6464FF6B6BFF7979FF8585FF9090FF9A9AFFA5A5FFB9B9FF6767
        F658588DE3E3E3FFFFFFFBFBFB6E6EAB7777FFA7A7FF7D7DFF7171FF6565FF57
        57FF4A4AFF3737FF3B3BFF5959FF4242DCE1E1E5FFFFFFFFFFFFFFFFFFFFFFFF
        D6D6DE4343E57070FF6868FF6E6EFF7B7BFF8585FF8E8EFF9696FF9E9EFFB0B0
        FF6161F55B5B8DDCDCDC7272AB7171FFA3A3FF7F7FFF7474FF6969FF5C5CFF4F
        4FFF3F3FFF4141FF5B5BFF4343DBE1E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFD6D6DD4343E46F6FFF6A6AFF6F6FFF7A7AFF8282FF8989FF8E8EFF9393
        FFA3A3FF5959EC3232A56868FA9B9BFF7D7DFF7474FF6A6AFF5F5FFF5454FF44
        44FF4646FF5C5CFF4242D9E1E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD6D6DD4141E26C6CFF6868FF6C6CFF7575FF7B7BFF8080FF8383
        FF8585FF8F8FFF7D7DFF8C8CFF7777FF7070FF6868FF5F5FFF5454FF4747FF48
        48FF5B5BFF4242D7E1E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFD6D6DD4040E06767FF6363FF6767FF6D6DFF7272FF7575
        FF7676FF7777FF7D7DFF7070FF6A6AFF6363FF5C5CFF5353FF4747FF4848FF57
        57FF4242D6E1E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFD6D6DD3E3EDE5F5FFF5D5DFF5F5FFF6363FF6565
        FF6767FF6666FF6363FF6161FF5C5CFF5656FF4E4EFF4444FF4545FF5252FF40
        40D4E1E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DD3B3BDD5656FF5353FF5454FF5757
        FF5757FF5656FF5454FF5252FF4D4DFF4848FF3F3FFF4040FF4B4BFF3E3ED2E1
        E1E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8D8DE4040D34949FF4949FF4D4D
        FF4E4EFF4D4DFF4646FF4141FF3E3EFF3939FF3939FF4040FD3E3EC6E5E5E8FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D5DA62F2FFD3F3FFF4B4B
        FF4E4EFF4E4EFF4B4BFF3B3BFF2D2DFF2929FF3535FF2727F753538BEAEAEAFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6D6DA21818F12D2DFF4646FF5050
        FF5050FF5050FF4F4FFF4C4CFF3939FF1D1DFF1313FF2020FF1313E6595984E4
        E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFBFBFB6C6CA00808F41B1BFF4545FF5454FF5353
        FF5454FF5555FF5656FF5151FF5151FF4343FF1C1CFF0101FF0909FF0505E958
        5883E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFBFBFB6C6C9F0000F40A0AFF4747FF5A5AFF5858FF5959
        FF5B5BFF5A5AFF4141FF5A5AFF5757FF5757FF5656FF3D3DFF1414FF0000FF00
        00E7585883E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFBFBFB6C6C9F0000F20A0AFF5555FF6C6CFF6767FF6666FF6969
        FF6C6CFF2A2AFF0000FF3535FF6E6EFF6868FF6767FF6B6BFF6868FF4444FF05
        05FF0000E6585881E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFBFBFB6C6C9E0000F10B0BFF6464FF8080FF7979FF7979FF7C7CFF7F7F
        FF3333FF0000FF0000E70000FF3F3FFF8181FF7B7BFF7979FF7A7AFF8181FF59
        59FF0505FF0000E4585881E4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFB6C6C9C0000F00D0DFF7171FF9191FF8A8AFF8A8AFF8D8DFF9090FF3A3A
        FF0000FF3030BFB3B3C52121CB0000FF4848FF9393FF8B8BFF8A8AFF8A8AFF92
        92FF6565FF0606FF0000E358587FE4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFBFBFB
        6C6C9B0000EE0F0FFF8080FFA5A5FF9C9CFF9C9CFF9F9FFFA3A3FF4242FF0000
        FF2C2CC1E1E1E4FFFFFFD6D6DB1F1FCD0000FF5252FFA6A6FF9E9EFF9C9CFF9C
        9CFFA5A5FF7373FF0707FF0000E158587FE4E4E4FFFFFFFFFFFFFAFAFA6C6C9B
        0000ED1010FF8F8FFFB8B8FFAFAFFFAFAFFFB2B2FFB6B6FF4A4AFF0000FF2C2C
        BFE1E1E4FFFFFFFFFFFFFFFFFFD6D6DB1F1FCA0000FF5B5BFFBABAFFB1B1FFAF
        AFFFAFAFFFB9B9FF8080FF0707FF0000E058587DE3E3E3FFFFFF7171A10000EC
        1C1CFF9F9FFFCCCCFFC1C1FFC1C1FFC5C5FFC9C9FF5151FF0000FF2C2CBEE1E1
        E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DB1F1FC90000FF6565FFCDCDFFC3
        C3FFC1C1FFC1C1FFCDCDFF8F8FFF1313FF0000DF585882EFEFEF1E1ECC0000FF
        6262FFEAEAFFD5D5FFD3D3FFD8D8FFDCDCFF5959FF0000FF2C2CBBE1E1E3FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DB1F1FC80000FF6F6FFFE1
        E1FFD6D6FFD3D3FFD6D6FFE6E6FF4A4AFF0000FF2B2BB0F1F1F1CACAE81818CF
        0505FF8484FFF5F5FFEBEBFFEFEFFF6161FF0000FF2C2CB9E1E1E3FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DB1F1FC50000FF79
        79FFF4F4FFEBEBFFF2F2FF6D6DFF0101FF2323BED6D6DBFFFFFFFFFFFFCCCCE8
        1818CD0000FF9191FFFEFEFF6969FF0000FF2C2CB8E1E1E3FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DB1F1FC300
        00FF8484FFFFFFFF7777FF0000FF2323BCD8D8DCFFFFFFFFFFFFFFFFFFFFFFFF
        CCCCE71818CA0505FF4040FF0000FF2C2CB6E1E1E3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6DA1F
        1FC20101FF4141FF0000FF2323BBD8D8DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCCCCE51818CA0000FB2C2CB5E1E1E3FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6
        D6DA1F1FC00000FE2323B9D8D8DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC8C8E55858BEE0E0E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFD3D3D95757BED7D7DCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 334
      ExplicitTop = 6
      ExplicitHeight = 54
    end
    object SB_Retonar: TSpeedButton
      AlignWithMargins = True
      Left = 444
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Retornar - F5'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      Margin = 15
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_RetonarClick
      ExplicitTop = 4
    end
    object sb_autorizaPedido: TSpeedButton
      AlignWithMargins = True
      Left = 240
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Autorizar Pedido'
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
      Margin = 15
      NumGlyphs = 2
      ParentFont = False
      OnClick = sb_autorizaPedidoClick
      ExplicitTop = 4
    end
    object Sb_Desbloqueia: TSpeedButton
      AlignWithMargins = True
      Left = 138
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Desbloquear Pedido'
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
        5000555555555555577755555555555550B0555555555555F7F7555555555550
        00B05555555555577757555555555550B3B05555555555F7F557555555555000
        3B0555555555577755755555555500B3B0555555555577555755555555550B3B
        055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
        555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
        55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
        555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
        55555575FFFF7755555555570000755555555557777775555555}
      Layout = blGlyphTop
      Margin = 15
      NumGlyphs = 2
      ParentFont = False
      OnClick = Sb_DesbloqueiaClick
      ExplicitLeft = 134
      ExplicitTop = 5
      ExplicitHeight = 54
    end
  end
  inherited MnuBase: TMainMenu
    Left = 344
    Top = 152
  end
  object memDetalhesPedido: TClientDataSet
    Left = 368
    Top = 304
    object memDetalhesPedidoPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Size = 15
    end
    object memDetalhesPedidoPRO_DESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'PRO_DESCRICAO'
      Size = 100
    end
    object memDetalhesPedidoITF_QTDE: TCurrencyField
      DisplayLabel = 'Quantidade'
      FieldName = 'ITF_QTDE'
    end
    object memDetalhesPedidoITF_VL_UNIT: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'ITF_VL_UNIT'
    end
    object memDetalhesPedidoITF_VL_SUBTOTAL: TCurrencyField
      DisplayLabel = 'SubTotal'
      FieldName = 'ITF_VL_SUBTOTAL'
    end
  end
  object dsDetalhesPedido: TDataSource
    DataSet = memDetalhesPedido
    Left = 368
    Top = 352
  end
  object memPedido: TClientDataSet
    Left = 200
    Top = 152
    object memPedidoPED_NUMERO: TIntegerField
      FieldName = 'PED_NUMERO'
    end
    object memPedidoFPT_DESCRICAO: TStringField
      FieldName = 'FPT_DESCRICAO'
      Size = 51
    end
    object memPedidoPED_DATA: TDateField
      FieldName = 'PED_DATA'
    end
    object memPedidoEMP_NOME: TStringField
      FieldName = 'EMP_NOME'
      Size = 100
    end
    object memPedidoUSU_NOME: TStringField
      FieldName = 'USU_NOME'
      Size = 100
    end
    object memPedidoPED_DT_ALTERA: TDateTimeField
      FieldName = 'PED_DT_ALTERA'
    end
    object memPedidoPED_CODIGO: TIntegerField
      FieldName = 'PED_CODIGO'
    end
    object memPedidoPED_FATURADO: TStringField
      FieldName = 'PED_FATURADO'
      Size = 1
    end
    object memPedidoPED_APROVADO: TStringField
      FieldName = 'PED_APROVADO'
      Size = 1
    end
    object memPedidoPED_TIPO: TIntegerField
      FieldName = 'PED_TIPO'
    end
  end
  object dsPedido: TDataSource
    DataSet = memPedido
    OnDataChange = dsPedidoDataChange
    Left = 200
    Top = 200
  end
end

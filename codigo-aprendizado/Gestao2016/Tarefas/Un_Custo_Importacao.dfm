object Fr_Custo_Importacao: TFr_Custo_Importacao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Custo de Importa'#231#227'o'
  ClientHeight = 520
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 455
    Width = 824
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      824
      65)
    object SB_Sair_0: TSpeedButton
      Left = 729
      Top = 5
      Width = 89
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 741
      ExplicitTop = 18
    end
    object SB_Confirmar: TSpeedButton
      Left = 638
      Top = 5
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Atualizar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitLeft = 650
      ExplicitTop = 18
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 824
    Height = 47
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label6: TLabel
      Left = 7
      Top = 4
      Width = 39
      Height = 14
      Caption = 'Invoice'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 134
      Top = 4
      Width = 22
      Height = 14
      Caption = 'Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 327
      Top = 4
      Width = 85
      Height = 14
      Caption = 'Cota'#231#227'o Governo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 228
      Top = 4
      Width = 80
      Height = 14
      Caption = 'Cota'#231#227'o Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data: TDateTimePicker
      Left = 131
      Top = 19
      Width = 92
      Height = 21
      Date = 39580.000000000000000000
      Time = 39580.000000000000000000
      TabOrder = 1
    end
    object E_Cotacao_Gov: TEdit_Setes
      Left = 324
      Top = 19
      Width = 95
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      TabOrder = 3
      Text = ''
    end
    object RG_TradeSystem: TRadioGroup
      Left = 425
      Top = 5
      Width = 185
      Height = 36
      Caption = 'Sistema de Trade'
      Columns = 2
      Items.Strings = (
        'FOB'
        'EX WORK')
      TabOrder = 4
    end
    object E_Nr_Invoice: TEdit
      Left = 6
      Top = 19
      Width = 119
      Height = 21
      TabOrder = 0
    end
    object E_Cotacao_Compra: TEdit_Setes
      Left = 225
      Top = 19
      Width = 95
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      TabOrder = 2
      Text = ''
    end
    object Button1: TButton
      Left = 742
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Calcular'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object Pg_Geral: TPageControl
    Left = 0
    Top = 47
    Width = 824
    Height = 408
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Produtos'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 816
        Height = 336
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          816
          336)
        object dbg_itens: TDBGrid
          Left = 2
          Top = 2
          Width = 812
          Height = 293
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = ds_itens
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnTitleClick = dbg_operacaoTitleClick
          Columns = <
            item
              Expanded = False
              FieldName = 'TB_PRODUCT_ID'
              Title.Caption = 'C'#243'digo Produto'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRO_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 358
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTDE'
              Title.Caption = 'Quantidade'
              Width = 72
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNIT_VALUE'
              Title.Caption = 'Valor Unit'#225'rio'
              Width = 83
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QUOTATION'
              Title.Caption = 'Cota'#231#227'o'
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUBTOTAL'
              Title.Caption = 'Valor Subtotal'
              Visible = True
            end>
        end
        object Sb_Ins_Produto: TBitBtn
          Left = 6
          Top = 299
          Width = 131
          Height = 32
          Anchors = [akRight, akBottom]
          Caption = 'Novo Produto - F2'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
            0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
            33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          OnClick = Sb_Ins_ProdutoClick
        end
        object Sb_Alt_Produto: TBitBtn
          Left = 139
          Top = 299
          Width = 131
          Height = 32
          Anchors = [akRight, akBottom]
          Caption = 'Alterar Produto - F3'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            5555555500005577777777777777777500005000000000000000007500005088
            80FFFFFF0FFFF0750000508180F4444F0F44F0750000508880FFFFFF0FFFF075
            0000508180F4444F0F44F0750000508880FFFFFF0FFFF0750000508180F4444F
            0F44F0750000508880FF0078088880750000508180F400007844807500005088
            80FF7008007880750000508180F4408FF80080750000508880FFF70FFF800075
            0000500000000008FF803007000050EEEEEEEE70880B43000000500000000000
            00FBB43000005555555555550BFFBB43000055555555555550BFFBB400005555
            55555555550BFFBB0000}
          ParentFont = False
          TabOrder = 2
          OnClick = Sb_Alt_ProdutoClick
        end
        object Sb_Exc_Produto: TBitBtn
          Left = 272
          Top = 299
          Width = 131
          Height = 32
          Anchors = [akRight, akBottom]
          Caption = 'Excluir Produto - F4'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
            6666666666666666666666660000666666666666666666666666666666666666
            0000666666666666661F66666666666666668F66000066661F66666666666666
            668F6666666666660000666111F6666661F666666888F6666668F66600006661
            11F666661F6666666888F666668F666600006666111F66611F66666666888F66
            688F6666000066666111F611F6666666666888F688F66666000066666611111F
            66666666666688888F66666600006666666111F66666666666666888F6666666
            000066666611111F66666666666688888F666666000066666111F61F66666666
            666888F68F66666600006661111F66611F66666668888F66688F666600006611
            11F6666611F666668888F6666688F66600006611F6666666611F666688F66666
            66688F6600006666666666666666666666666666666666660000666666666666
            6666666666666666666666660000666666666666666666666666666666666666
            0000}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 3
          OnClick = Sb_Exc_ProdutoClick
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 336
        Width = 816
        Height = 44
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          816
          44)
        object Label15: TLabel
          Left = 710
          Top = 3
          Width = 50
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Valor Total'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_VL_Produtos: TEdit
          Left = 707
          Top = 19
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '0,00'
        end
        object Sb_LancaItensPedidoCompra: TBitBtn
          Left = 6
          Top = 7
          Width = 213
          Height = 32
          Anchors = [akRight, akBottom]
          Caption = 'Lan'#231'ar itens no Pedido de Compra'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
            0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
            33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          OnClick = Sb_LancaItensPedidoCompraClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Opera'#231#227'o'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 42
        Width = 816
        Height = 294
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          816
          294)
        object Sb_Ins_Mercadoria: TSpeedButton
          Left = 131
          Top = 256
          Width = 117
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Insere Avulso'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
            0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
            33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
          ParentFont = False
          Transparent = False
          OnClick = Sb_Ins_MercadoriaClick
          ExplicitTop = 375
        end
        object Sb_Def_Mercadoria: TSpeedButton
          Left = 7
          Top = 256
          Width = 123
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Insere Padr'#227'o'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C39038C01
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CD602F7025A038C01
            000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C9402B502F70239035A038C01
            0000000000001F7C1F7C1F7C1F7C1F7C31025202B502D602F7025A037B038C01
            00001F7C1F7C1F7C1F7C1F7CEF01100252029402B502F70239035A039C038C01
            1F7C1F7C1F7C1F7C8C01AD011002310252021F00D602F7025A037B039C038C01
            1F7C1F7C1F7C8C01AD01EF01100252021F001F001F0039035A039C03DE038C01
            1F7C1F7C1F7C8C01AD01100231021F001F00D6021F001F007B039C03FF038C01
            1F7C1F7C1F7CAD01EF011002520294021F001F001F005A039C03DE03FF038C01
            1F7C1F7C1F7CAD01100231025202B502D6021F005A037B039C03FF03FF038C01
            1F7C1F7C1F7CEF01100252029402B502F70239035A038C01DE038C018C018C01
            1F7C1F7C1F7C100231025202B502D602F7028C018C018C018C018C018C011F7C
            1F7C1F7C1F7C100252029402B502F70239038C018C018C018C018C011F7C1F7C
            1F7C1F7C1F7C31025202B502D6028C018C018C018C018C018C011F7C1F7C1F7C
            1F7C1F7C1F7C520294028C018C018C018C011F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C8C018C018C011F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          ParentFont = False
          Transparent = False
          OnClick = Sb_Def_MercadoriaClick
          ExplicitTop = 375
        end
        object Sb_Exc_Mercadoria: TSpeedButton
          Left = 249
          Top = 256
          Width = 120
          Height = 32
          Anchors = [akLeft, akBottom]
          Caption = 'Excluir'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
            6666666666666666666666660000666666666666666666666666666666666666
            0000666666666666661F66666666666666668F66000066661F66666666666666
            668F6666666666660000666111F6666661F666666888F6666668F66600006661
            11F666661F6666666888F666668F666600006666111F66611F66666666888F66
            688F6666000066666111F611F6666666666888F688F66666000066666611111F
            66666666666688888F66666600006666666111F66666666666666888F6666666
            000066666611111F66666666666688888F666666000066666111F61F66666666
            666888F68F66666600006661111F66611F66666668888F66688F666600006611
            11F6666611F666668888F6666688F66600006611F6666666611F666688F66666
            66688F6600006666666666666666666666666666666666660000666666666666
            6666666666666666666666660000666666666666666666666666666666666666
            0000}
          NumGlyphs = 2
          ParentFont = False
          Transparent = False
          OnClick = Sb_Exc_MercadoriaClick
          ExplicitTop = 375
        end
        object dbg_operacao: TDBGrid
          Left = 2
          Top = 2
          Width = 812
          Height = 249
          Align = alTop
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = ds_operacao
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnTitleClick = dbg_operacaoTitleClick
          Columns = <
            item
              Expanded = False
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'CTP_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 292
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_REFERENCIA'
              Title.Caption = 'Refer'#234'ncia'
              Width = 99
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_VL_ORIG'
              Title.Caption = 'Valor Original'
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_COTACAO'
              Title.Caption = 'Valor Cota'#231#227'o'
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_VL_REAL'
              ReadOnly = True
              Title.Caption = 'Valor final'
              Width = 97
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_NF'
              PickList.Strings = (
                'SIM'
                'N'#195#402'O')
              Title.Caption = 'Destaca'
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CTP_CALC'
              PickList.Strings = (
                'SIM'
                'N'#195#402'O')
              Title.Caption = 'Calcular'
              Width = 66
              Visible = True
            end>
        end
      end
      object Rg_Options: TRadioGroup
        Left = 0
        Top = 0
        Width = 816
        Height = 42
        Align = alTop
        Caption = 'Escolha uma das op'#231#227'o para Filtrar a lista'
        Columns = 5
        ItemIndex = 4
        Items.Strings = (
          'MERCADORIA + FRETE'
          'DESPESAS COM IMPOSTOS'
          'DESPESAS DIVERSAS'
          'DEP'#211'SITO CLIENTE'
          'TODOS')
        TabOrder = 1
        OnClick = Rg_OptionsClick
      end
      object Panel1: TPanel
        Left = 0
        Top = 336
        Width = 816
        Height = 44
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          816
          44)
        object Label8: TLabel
          Left = 174
          Top = 2
          Width = 91
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Mercadoria + Frete'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 282
          Top = 2
          Width = 95
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Despesas Impostos'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 387
          Top = 2
          Width = 95
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Despesas Diversas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 494
          Top = 2
          Width = 74
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Despesas Total'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 600
          Top = 2
          Width = 82
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Valor Depositado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 708
          Top = 2
          Width = 78
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'Saldo Opera'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_VL_Mercadoria: TEdit
          Left = 171
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '0,00'
        end
        object E_VL_Imposto: TEdit
          Left = 277
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0,00'
        end
        object E_VL_Diversos: TEdit
          Left = 384
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '0,00'
        end
        object E_VL_Despesas: TEdit
          Left = 491
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = '0,00'
        end
        object E_VL_DEpositado: TEdit
          Left = 598
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '0,00'
        end
        object E_VL_Saldo: TEdit
          Left = 705
          Top = 18
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft, akBottom]
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '0,00'
        end
      end
    end
  end
  object cds_operacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Dsp_operacao'
    AfterOpen = cds_operacaoAfterOpen
    BeforePost = cds_operacaoBeforePost
    AfterPost = cds_operacaoAfterPost
    AfterDelete = cds_operacaoAfterDelete
    Left = 364
    Top = 240
    object cds_operacaoCTP_CODIGO: TIntegerField
      FieldName = 'CTP_CODIGO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_operacaoCTP_CODPED: TIntegerField
      FieldName = 'CTP_CODPED'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_CODPED"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_operacaoCTP_DESCRICAO: TWideStringField
      FieldName = 'CTP_DESCRICAO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_DESCRICAO"'
      Size = 100
    end
    object cds_operacaoCTP_BS_CALCULO: TFMTBCDField
      FieldName = 'CTP_BS_CALCULO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_BS_CALCULO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object cds_operacaoCTP_VL_ORIG: TFMTBCDField
      FieldName = 'CTP_VL_ORIG'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_VL_ORIG"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object cds_operacaoCTP_COTACAO: TBCDField
      FieldName = 'CTP_COTACAO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_COTACAO"'
      DisplayFormat = '0.00##'
      Precision = 18
    end
    object cds_operacaoCTP_VL_REAL: TFMTBCDField
      FieldName = 'CTP_VL_REAL'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_VL_REAL"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object cds_operacaoCTP_CODITF: TIntegerField
      FieldName = 'CTP_CODITF'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_CODITF"'
    end
    object cds_operacaoCTP_CODPRO: TIntegerField
      FieldName = 'CTP_CODPRO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_CODPRO"'
    end
    object cds_operacaoCTP_ORIGEM: TWideStringField
      FieldName = 'CTP_ORIGEM'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_ORIGEM"'
      FixedChar = True
      Size = 1
    end
    object cds_operacaoCTP_NF: TWideStringField
      FieldName = 'CTP_NF'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_NF"'
      Size = 3
    end
    object cds_operacaoCTP_TIPO: TWideStringField
      FieldName = 'CTP_TIPO'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_TIPO"'
      Size = 3
    end
    object cds_operacaoCTP_CALC: TWideStringField
      FieldName = 'CTP_CALC'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_CALC"'
      Size = 3
    end
    object cds_operacaoCTP_REFERENCIA: TWideStringField
      FieldName = 'CTP_REFERENCIA'
      Origin = '"TB_CUSTO_PEDIDO"."CTP_REFERENCIA"'
      Size = 30
    end
  end
  object Dsp_operacao: TDataSetProvider
    DataSet = Qr_Operacao
    Left = 364
    Top = 136
  end
  object Qr_Operacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '    CTP_CODIGO,'
      '    CTP_CODPED,'
      '    CTP_DESCRICAO,'
      '    CTP_BS_CALCULO,'
      '    CTP_VL_ORIG,'
      '    CTP_COTACAO,'
      '    CTP_VL_REAL,'
      '    CTP_CODITF,'
      '    CTP_CODPRO,'
      '    CTP_ORIGEM,'
      '    CTP_NF,'
      '    CTP_TIPO,'
      '    CTP_CALC,'
      '   CTP_REFERENCIA'
      'from  TB_CUSTO_PEDIDO'
      'where CTP_CODPED =:CTP_CODPED')
    Left = 364
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTP_CODPED'
        ParamType = ptUnknown
      end>
  end
  object ds_operacao: TDataSource
    DataSet = cds_operacao
    Left = 366
    Top = 290
  end
  object Qr_itens: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select ip.id, ip.tb_order_id,  tb_product_id, pro_descricao, qtd' +
        'e, unit_value, quotation, ( (unit_value * quotation) * qtde) sub' +
        'total'
      'from  tb_itens_import ip'
      '  inner join tb_produto pr'
      '  ON (pr.pro_codigo = ip.tb_product_id)'
      'where ( ip.tb_order_id =:order_id )')
    Left = 76
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'order_id'
        ParamType = ptUnknown
      end>
    object Qr_itensID: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_ITENS_IMPORT"."ID"'
      Required = True
    end
    object Qr_itensTB_ORDER_ID: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_ITENS_IMPORT"."TB_ORDER_ID"'
    end
    object Qr_itensTB_PRODUCT_ID: TIntegerField
      FieldName = 'TB_PRODUCT_ID'
      Origin = '"TB_ITENS_IMPORT"."TB_PRODUCT_ID"'
    end
    object Qr_itensPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_itensQTDE: TBCDField
      FieldName = 'QTDE'
      Origin = '"TB_ITENS_IMPORT"."QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_itensUNIT_VALUE: TFMTBCDField
      FieldName = 'UNIT_VALUE'
      Origin = '"TB_ITENS_IMPORT"."UNIT_VALUE"'
      Precision = 18
      Size = 6
    end
    object Qr_itensQUOTATION: TBCDField
      FieldName = 'QUOTATION'
      Origin = '"TB_ITENS_IMPORT"."QUOTATION"'
      Precision = 18
      Size = 2
    end
    object Qr_itensSUBTOTAL: TFMTBCDField
      FieldName = 'SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 11
    end
  end
  object ds_itens: TDataSource
    DataSet = Qr_itens
    Left = 78
    Top = 234
  end
  object Qr_Order: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'UPDATE OR INSERT INTO TB_ORDER_IMPORT (TB_INSTITUTION_ID, TB_ORD' +
        'ER_ID, NUMBER, DATA, INVOICE_NUMBER, QUOTATION_STATE, TRADE_SYST' +
        'EM)'
      
        '                                                              VA' +
        'LUES  (:TB_INSTITUTION_ID, :TB_ORDER_ID, :NUMBER, :DATA, :INVOIC' +
        'E_NUMBER, :QUOTATION_STATE, :TRADE_SYSTEM)'
      
        '                                                         MATCHIN' +
        'G (TB_INSTITUTION_ID, TB_ORDER_ID);')
    Left = 20
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TB_INSTITUTION_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TB_ORDER_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMBER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INVOICE_NUMBER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'QUOTATION_STATE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TRADE_SYSTEM'
        ParamType = ptUnknown
      end>
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = '"TB_ITENS_IMPORT"."ID"'
      Required = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'TB_ORDER_ID'
      Origin = '"TB_ITENS_IMPORT"."TB_ORDER_ID"'
    end
    object IntegerField3: TIntegerField
      FieldName = 'TB_PRODUCT_ID'
      Origin = '"TB_ITENS_IMPORT"."TB_PRODUCT_ID"'
    end
    object IBStringField1: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object IBBCDField1: TBCDField
      FieldName = 'QTDE'
      Origin = '"TB_ITENS_IMPORT"."QTDE"'
      Precision = 18
      Size = 3
    end
    object FMTBCDField1: TFMTBCDField
      FieldName = 'UNIT_VALUE'
      Origin = '"TB_ITENS_IMPORT"."UNIT_VALUE"'
      Precision = 18
      Size = 6
    end
    object IBBCDField2: TBCDField
      FieldName = 'QUOTATION'
      Origin = '"TB_ITENS_IMPORT"."QUOTATION"'
      Precision = 18
      Size = 2
    end
    object FMTBCDField2: TFMTBCDField
      FieldName = 'SUBTOTAL'
      ProviderFlags = []
      Precision = 18
      Size = 11
    end
  end
end

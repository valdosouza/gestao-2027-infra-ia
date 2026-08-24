inherited CadPromotion: TCadPromotion
  Caption = 'Cadastro de Promo'#231#245'es'
  ClientHeight = 492
  ExplicitWidth = 320
  ExplicitHeight = 541
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 428
    ExplicitTop = 428
    inherited SB_Excluir: TSpeedButton
      ExplicitLeft = 393
    end
  end
  inherited pnl_fundo: TPanel
    Height = 428
    ExplicitHeight = 428
    object GroupBox1: TGroupBox
      Left = 2
      Top = 57
      Width = 811
      Height = 62
      Align = alTop
      Caption = 'Informe os produtos que participar'#227'o desta promo'#231#227'o'
      TabOrder = 0
      DesignSize = (
        811
        62)
      object Label5: TLabel
        Left = 6
        Top = 18
        Width = 81
        Height = 13
        Caption = 'C'#243'digo de Barras'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object E_Cd_Barras: TEdit
        Left = 19
        Top = 33
        Width = 172
        Height = 21
        Anchors = [akTop]
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 0
        OnExit = E_Cd_BarrasExit
      end
      inline Fm_ListaProdutos: TFm_ListaProdutos
        Left = 177
        Top = 17
        Width = 516
        Height = 43
        TabOrder = 1
        ExplicitLeft = 177
        ExplicitTop = 17
        ExplicitWidth = 516
        inherited Sb_Produto: TSpeedButton
          Left = 487
          ExplicitLeft = 487
        end
        inherited E_Cd_Produto: TMaskEdit
          MaxLength = 6
        end
        inherited E_Busca_Produto: TEdit
          Width = 382
          ExplicitWidth = 382
        end
      end
    end
    object pnl_row_1: TPanel
      Left = 2
      Top = 2
      Width = 811
      Height = 55
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object Label28: TLabel
        Left = 362
        Top = 5
        Width = 48
        Height = 14
        Caption = 'Promo'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 244
        Top = 5
        Width = 64
        Height = 14
        Caption = 'Valor Unit'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 12
        Top = 5
        Width = 55
        Height = 14
        Caption = 'Quantidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 423
        Top = 5
        Width = 294
        Height = 14
        Caption = 'Dispon'#237'vel apenas para opera'#231#245'es de Frente de Caixa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 127
        Top = 5
        Width = 50
        Height = 14
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_promocao: TMaskEdit
        Left = 360
        Top = 21
        Width = 446
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = ''
      end
      object E_Valor: TMaskEdit
        Left = 240
        Top = 21
        Width = 115
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = ''
      end
      object e_Quantidade: TMaskEdit
        Left = 6
        Top = 21
        Width = 115
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnExit = e_QuantidadeExit
      end
      object E_ValorTotal: TMaskEdit
        Left = 123
        Top = 21
        Width = 115
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = ''
        OnExit = E_ValorTotalExit
      end
    end
    object DBG_Produtos: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 163
      Width = 805
      Height = 219
      Align = alClient
      Color = clMoneyGreen
      DataSource = Ds_Items
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowSelect]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clNavy
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'TB_INSTITUTION_ID'
          ReadOnly = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TB_PROMOTION_ID'
          ReadOnly = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TB_PRODUCT_ID'
          ReadOnly = False
          Title.Caption = 'C'#243'digo Produto'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_DESCRICAO'
          ReadOnly = False
          Title.Caption = 'Descri'#231#227'o do Produto'
          Width = 545
          Visible = True
        end>
    end
    object pnl_row_2: TPanel
      Left = 2
      Top = 119
      Width = 811
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Sb_Ins_Produto: TBitBtn
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 131
        Height = 35
        Align = alLeft
        Caption = 'Novo Produto - F7'
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
        TabOrder = 0
        OnClick = Sb_Ins_ProdutoClick
      end
      object Sb_Exc_Produto: TBitBtn
        AlignWithMargins = True
        Left = 140
        Top = 3
        Width = 131
        Height = 35
        Align = alLeft
        Caption = 'Excluir Produto - F8'
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
        TabOrder = 1
        OnClick = Sb_Exc_ProdutoClick
      end
    end
    object pnl_row_3: TPanel
      Left = 2
      Top = 385
      Width = 811
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
      object Label6: TLabel
        Left = 8
        Top = 2
        Width = 81
        Height = 14
        Caption = 'Data de Validade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object ChBx_Ativa: TCheckBox
        Left = 706
        Top = 20
        Width = 95
        Height = 17
        Caption = 'Promo'#231#227'o ativa'
        TabOrder = 0
      end
      object E_Dt_Expiration: TMaskEdit
        Left = 6
        Top = 17
        Width = 83
        Height = 22
        Alignment = taCenter
        CharCase = ecUpperCase
        EditMask = '##/##/####;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        OnExit = e_QuantidadeExit
        OnKeyDown = E_Dt_ExpirationKeyDown
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 200
  end
  object cds_Items: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 314
    Top = 189
    object cds_ItemsTB_INSTITUTION_ID: TIntegerField
      FieldName = 'TB_INSTITUTION_ID'
      Origin = '"TB_PROMOTION_ITEMS"."TB_INSTITUTION_ID"'
      Required = True
    end
    object cds_ItemsTB_PROMOTION_ID: TIntegerField
      FieldName = 'TB_PROMOTION_ID'
      Origin = '"TB_PROMOTION_ITEMS"."TB_PROMOTION_ID"'
      Required = True
    end
    object cds_ItemsTB_PRODUCT_ID: TIntegerField
      FieldName = 'TB_PRODUCT_ID'
      Origin = '"TB_PROMOTION_ITEMS"."TB_PRODUCT_ID"'
      Required = True
    end
    object cds_ItemsPRO_DESCRICAO: TWideStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
  end
  object Ds_Items: TDataSource
    DataSet = cds_Items
    Left = 314
    Top = 245
  end
end

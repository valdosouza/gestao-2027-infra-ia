inherited CadContractChavesTags: TCadContractChavesTags
  BorderIcons = [biSystemMenu]
  Caption = 'Controles de Chaves e Tags'
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 636
    Height = 69
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 632
      Height = 62
      Align = alTop
      Caption = 'Informe a rela'#231#227'o das Chaves com as Tags a serem substituidas'
      TabOrder = 0
      DesignSize = (
        632
        62)
      object Label5: TLabel
        Left = 6
        Top = 18
        Width = 55
        Height = 13
        Caption = 'Chave/Tag'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 181
        Top = 18
        Width = 115
        Height = 13
        Caption = 'Nome do Campo Origem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object E_Chave: TEdit
        Left = 4
        Top = 35
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
      end
      object ChBx_Ativa: TCheckBox
        Left = 699
        Top = 37
        Width = 95
        Height = 17
        Caption = 'Promo'#231#227'o ativa'
        TabOrder = 4
      end
      object E_Field: TEdit
        Left = 179
        Top = 35
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
        TabOrder = 1
      end
      object Sb_Inserir: TBitBtn
        AlignWithMargins = True
        Left = 359
        Top = 18
        Width = 131
        Height = 39
        Align = alRight
        Caption = 'Inserir - F2'
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
        TabOrder = 2
        OnClick = Sb_InserirClick
      end
      object Sb_Excluir: TBitBtn
        AlignWithMargins = True
        Left = 496
        Top = 18
        Width = 131
        Height = 39
        Align = alRight
        Caption = 'Excluir - F3'
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
        OnClick = Sb_ExcluirClick
      end
    end
    object pnl_row_2: TPanel
      Left = 2
      Top = 64
      Width = 632
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 332
    Width = 636
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 446
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitTop = 4
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 542
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  object DBG_Produtos: TDBGrid [2]
    AlignWithMargins = True
    Left = 3
    Top = 72
    Width = 630
    Height = 257
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
        FieldName = 'ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TB_CONTRACT_ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CHAVE'
        Title.Caption = 'Chave/Tag'
        Width = 280
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIELD'
        Title.Caption = 'Nome do Campo Origem'
        Width = 280
        Visible = True
      end>
  end
  inherited MnuBase: TMainMenu
    Left = 32
    Top = 344
  end
  object cds_Items: TClientDataSet
    PersistDataPacket.Data = {
      700000009619E0BD010000001800000004000000000003000000700002494404
      000100000000000E54425F434F4E54524143545F494404000100000000000543
      484156450100490000000100055749445448020002006400054649454C440100
      4900000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 322
    Top = 197
    object cds_ItemsID: TIntegerField
      FieldName = 'ID'
    end
    object cds_ItemsTB_CONTRACT_ID: TIntegerField
      FieldName = 'TB_CONTRACT_ID'
    end
    object cds_ItemsCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 100
    end
    object cds_ItemsFIELD: TStringField
      FieldName = 'FIELD'
      Size = 100
    end
  end
  object Ds_Items: TDataSource
    DataSet = cds_Items
    Left = 314
    Top = 245
  end
end

object fr_obs_nfe: Tfr_obs_nfe
  Left = 389
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Observa'#231#227'o Nfe'
  ClientHeight = 316
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 269
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object DBMemo1: TDBMemo
      Left = 4
      Top = 5
      Width = 512
      Height = 260
      DataField = 'OBN_DETALHE'
      DataSource = dst_obs_nfe
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 269
    Width = 520
    Height = 47
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      520
      47)
    object Sb_Last_end: TSpeedButton
      Left = 489
      Top = 19
      Width = 25
      Height = 22
      Hint = #218'ltimo Endere'#231'o'
      Anchors = [akRight, akBottom]
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333393333
        333333333337F3333333333333397333333333333337FF333333333333C94333
        3333333333737F333333333333C9473333333333337373F3333333333CC94433
        3333333337F7F7F3333333333CC94473333333333737F73F33333333CCC94443
        333333337F37F37F33333333CCC94447333333337337F373F333333CCCC94444
        33333337F337F337F333333CCCC94444733333373337F3373F3333CCCCC94444
        4333337F3337FF337F3333CCCCC94444473333733F7773FF73F33CCCCC393444
        443337F37737F773F7F33CCC33393374447337F73337F33737FFCCC333393333
        444377733337F333777FC3333339333337437333333733333373}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Sb_Last_endClick
    end
    object Sb_Prior_end: TSpeedButton
      Left = 466
      Top = 19
      Width = 25
      Height = 22
      Hint = 'Anterior Endere'#231'o'
      Anchors = [akRight, akBottom]
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
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Sb_Prior_endClick
    end
    object Sb_Next_end: TSpeedButton
      Left = 442
      Top = 19
      Width = 25
      Height = 22
      Hint = 'Pr'#243'ximo Endere'#231'o'
      Anchors = [akRight, akBottom]
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
        33333FF3333333333333447333333333333377FFF33333333333744473333333
        333337773FF3333333333444447333333333373F773FF3333333334444447333
        33333373F3773FF3333333744444447333333337F333773FF333333444444444
        733333373F3333773FF333334444444444733FFF7FFFFFFF77FF999999999999
        999977777777777733773333CCCCCCCCCC3333337333333F7733333CCCCCCCCC
        33333337F3333F773333333CCCCCCC3333333337333F7733333333CCCCCC3333
        333333733F77333333333CCCCC333333333337FF7733333333333CCC33333333
        33333777333333333333CC333333333333337733333333333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Sb_Next_endClick
    end
    object Sb_First_end: TSpeedButton
      Left = 419
      Top = 19
      Width = 25
      Height = 22
      Hint = 'Primeiro Endere'#231'o'
      Anchors = [akRight, akBottom]
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003C3333339333
        337437FFF3337F3333F73CCC33339333344437773F337F33377733CCC3339337
        4447337F73FF7F3F337F33CCCCC3934444433373F7737F773373333CCCCC9444
        44733337F337773337F3333CCCCC9444443333373F337F3337333333CCCC9444
        473333337F337F337F333333CCCC94444333333373F37F33733333333CCC9444
        7333333337F37F37F33333333CCC944433333333373F7F373333333333CC9447
        33333333337F7F7F3333333333CC94433333333333737F7333333333333C9473
        33333333333737F333333333333C943333333333333737333333333333339733
        3333333333337F33333333333333933333333333333373333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Sb_First_endClick
    end
    object Label32: TLabel
      Left = 379
      Top = 3
      Width = 133
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Navega'#231#227'o de Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object dst_obs_nfe: TDataSource
    DataSet = qr_Obs_nfe
    Left = 16
    Top = 256
  end
  object qr_Obs_nfe: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select obn_detalhe'
      'from tb_obs_nfe a'
      'where'
      'obn_codnfl =:obn_codnfl')
    Left = 48
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'obn_codnfl'
        ParamType = ptUnknown
      end>
  end
end

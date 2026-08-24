object Fr_FotoProduto: TFr_FotoProduto
  Left = 159
  Top = 133
  BorderStyle = bsDialog
  Caption = 'Imagem 360 X 360'
  ClientHeight = 425
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 722
    Height = 365
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 371
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 360
      Height = 360
      Center = True
      Stretch = True
    end
    object Pg_Informa: TPageControl
      Left = 360
      Top = 2
      Width = 359
      Height = 361
      ActivePage = Tbs_Memo
      Style = tsFlatButtons
      TabOrder = 0
      object Tbs_Memo: TTabSheet
        Caption = 'Detalhes do Produto'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Fundo1: TPanel
          Left = 0
          Top = 0
          Width = 351
          Height = 330
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object MM_Detalhe: TRichEdit
            Left = 2
            Top = 2
            Width = 347
            Height = 326
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HideScrollBars = False
            Lines.Strings = (
              'MM_Detalhe')
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            Zoom = 100
          end
        end
      end
      object Tbs_Html: TTabSheet
        Caption = 'Detalhes do Produto'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_Fundo2: TPanel
          Left = 0
          Top = 0
          Width = 351
          Height = 330
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object WebBrowser: TWebBrowser
            Left = 2
            Top = 2
            Width = 347
            Height = 326
            Align = alClient
            TabOrder = 0
            ControlData = {
              4C000000DD230000B12100000000000000000000000000000000000000000000
              000000004C000000000000000000000001000000E0D057007335CF11AE690800
              2B2E126208000000000000004C0000000114020000000000C000000000000046
              8000000000000000000000000000000000000000000000000000000000000000
              00000000000000000100000000000000000000000000000000000000}
          end
        end
      end
    end
  end
  object Pnl_Botao: TPanel
    Left = 0
    Top = 365
    Width = 722
    Height = 60
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 369
    object Lb_Mensagem: TLabel
      AlignWithMargins = True
      Left = 220
      Top = 17
      Width = 497
      Height = 26
      Margins.Top = 15
      Margins.Bottom = 15
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Enter confirma | Esc cancela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitLeft = 424
      ExplicitTop = 6
      ExplicitWidth = 189
      ExplicitHeight = 13
    end
    object Pnl_navega: TPanel
      Left = 2
      Top = 2
      Width = 215
      Height = 56
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 64
      object pnl_navega_top: TPanel
        Left = 0
        Top = 0
        Width = 215
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Capa do '#192'lbum '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitTop = -1
        ExplicitWidth = 213
      end
      object pnl_navega_botao: TPanel
        Left = 0
        Top = 24
        Width = 215
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 25
        ExplicitWidth = 213
        ExplicitHeight = 38
        object Sb_First: TSpeedButton
          Left = 0
          Top = 0
          Width = 50
          Height = 32
          Hint = 'Primeiro Endere'#231'o'
          Align = alLeft
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
          OnClick = Sb_FirstClick
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitHeight = 31
        end
        object Sb_Next: TSpeedButton
          Left = 100
          Top = 0
          Width = 50
          Height = 32
          Hint = 'Pr'#243'ximo Endere'#231'o'
          Align = alLeft
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
          OnClick = Sb_NextClick
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitHeight = 31
        end
        object Sb_Prior: TSpeedButton
          Left = 50
          Top = 0
          Width = 50
          Height = 32
          Hint = 'Anterior Endere'#231'o'
          Align = alLeft
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
          OnClick = Sb_PriorClick
          ExplicitLeft = -5
          ExplicitTop = 6
          ExplicitHeight = 31
        end
        object Sb_Last: TSpeedButton
          Left = 150
          Top = 0
          Width = 50
          Height = 32
          Hint = #218'ltimo Endere'#231'o'
          Align = alLeft
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
          OnClick = Sb_LastClick
          ExplicitLeft = 596
          ExplicitTop = 1
          ExplicitHeight = 31
        end
      end
    end
  end
  object Qr_Imagem: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterOpen = Qr_ImagemAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT ID, pro_detalhes, table_id, content,target,kind'
      'FROM tb_images'
      '   INNER JOIN TB_PRODUTO'
      '  ON (tb_produto.PRO_CODIGO = tb_images.table_id)'
      'WHERE tb_images.table_id=:IMG_CODPRO'
      'ORDER BY tb_images.kind, tb_images.ID ASC')
    Left = 176
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IMG_CODPRO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Imagem: TDataSource
    DataSet = Qr_Imagem
    Left = 176
    Top = 88
  end
  object Ftp_Cliente: TIdFTP
    IPVersion = Id_IPv4
    Host = 'setes.com.br'
    ConnectTimeout = 0
    Password = 'ansgpi2189'
    Username = 'setes'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ReadTimeout = 0
    Left = 8
    Top = 112
  end
end

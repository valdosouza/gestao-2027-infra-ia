object Fr_Cotacao: TFr_Cotacao
  Left = 350
  Top = 51
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Or'#231'amento Venda / Servi'#231'o'
  ClientHeight = 696
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Controle
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Cotacao: TPageControl
    Left = 0
    Top = 0
    Width = 832
    Height = 696
    ActivePage = tbs_cotacao
    Align = alClient
    TabOrder = 0
    object tbs_cotacao: TTabSheet
      Caption = 'tbs_cotacao'
      OnShow = tbs_cotacaoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        824
        668)
      object Pnl_Fundo: TPanel
        Left = 0
        Top = 0
        Width = 824
        Height = 605
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          824
          605)
        object pnl_Totalizar: TPanel
          Left = 2
          Top = 550
          Width = 820
          Height = 53
          Align = alBottom
          BevelInner = bvLowered
          TabOrder = 1
          DesignSize = (
            820
            53)
          object Label22: TLabel
            Left = 86
            Top = 3
            Width = 55
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Quantidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 8
          end
          object Label11: TLabel
            Left = 178
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Produtos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 100
          end
          object Label12: TLabel
            Left = 395
            Top = 4
            Width = 25
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 317
          end
          object Label7: TLabel
            Left = 605
            Top = 3
            Width = 46
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Desconto'
            FocusControl = E_VL_Desconto
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 527
          end
          object Label8: TLabel
            Left = 682
            Top = 3
            Width = 50
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Valor Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 604
          end
          object Label26: TLabel
            Left = 551
            Top = 3
            Width = 46
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Aliq Desc'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 473
          end
          object Lb_Opcional: TLabel
            Left = 293
            Top = 3
            Width = 43
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Servi'#231'os'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 215
          end
          object Label5: TLabel
            Left = 470
            Top = 4
            Width = 71
            Height = 14
            Anchors = [akTop, akRight]
            Caption = 'Valor Adicional'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 392
          end
          object E_VL_Produto: TPanel
            Left = 178
            Top = 21
            Width = 112
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
          end
          object E_VL_Desconto: TEdit_Setes
            Left = 602
            Top = 21
            Width = 78
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = '0,00'
            OnExit = E_VL_DescontoExit
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 86
            Top = 21
            Width = 89
            Height = 24
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Color = clMenu
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = '0,00'
          end
          object E_Aq_Desconto: TEdit_Setes
            Left = 549
            Top = 21
            Width = 53
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '0,00'
            OnExit = E_Aq_DescontoExit
          end
          object E_VL_Frete: TEdit_Setes
            Left = 393
            Top = 21
            Width = 73
            Height = 24
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = '0,00'
            OnExit = E_VL_FreteExit
          end
          object E_Vl_Servico: TPanel
            Left = 290
            Top = 21
            Width = 102
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 5
          end
          object E_VL_Cotacao: TPanel
            Left = 681
            Top = 21
            Width = 128
            Height = 24
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 6
          end
          object E_Vl_Adicional: TEdit_Setes
            Left = 468
            Top = 21
            Width = 80
            Height = 24
            TabStop = False
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            Text = '0,00'
            OnExit = E_Vl_AdicionalExit
          end
        end
        object PG_Itens: TPageControl
          Left = 2
          Top = 145
          Width = 820
          Height = 405
          ActivePage = TabSh_Servico
          Align = alClient
          MultiLine = True
          TabOrder = 0
          object TS_Produto: TTabSheet
            Caption = '&Produtos'
            DragMode = dmAutomatic
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Produto: TPanel
              Left = 0
              Top = 0
              Width = 812
              Height = 377
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object DBG_Produtos: TDBGrid
                Left = 2
                Top = 2
                Width = 808
                Height = 326
                Align = alClient
                Color = clMoneyGreen
                Ctl3D = True
                DataSource = Ds_Itens_Pro
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Lucida Console'
                Font.Style = []
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
                ParentCtl3D = False
                ParentFont = False
                PopupMenu = Pop_Produto
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clNavy
                TitleFont.Height = -11
                TitleFont.Name = 'Arial'
                TitleFont.Style = []
                OnDrawColumnCell = DBG_ProdutosDrawColumnCell
                OnDblClick = DBG_ProdutosDblClick
                OnKeyDown = DBG_ProdutosKeyDown
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'PRO_CODIGOFAB'
                    Title.Caption = 'Codigo'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 105
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_DESCRICAO'
                    Title.Caption = 'Descri'#231#227'o Produto'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 280
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PRO_VL_CUSTO'
                    Title.Caption = 'Custo'
                    Width = 73
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_MRG_LUCRO'
                    Title.Caption = '%'
                    Width = 32
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_QTDE'
                    Title.Caption = 'Qtde'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 46
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_VL_UNIT'
                    Title.Caption = 'Pre'#231'o'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 68
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_VL_SUBTOTAL'
                    Title.Caption = 'SubTotal'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 93
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'TPR_NOME'
                    Title.Caption = 'Tabela de Pre'#231'o'
                    Width = 350
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'PRO_LOCAL'
                    Title.Caption = 'Localiza'#231#227'o no Estoque'
                    Width = 300
                    Visible = True
                  end>
              end
              object pnl_Produto_item: TPanel
                AlignWithMargins = True
                Left = 5
                Top = 331
                Width = 802
                Height = 41
                Align = alBottom
                TabOrder = 1
                object Sb_InclusaoRapido: TBitBtn
                  AlignWithMargins = True
                  Left = 2
                  Top = 2
                  Width = 131
                  Height = 37
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alLeft
                  Caption = 'Incus'#227'o R'#225'pida'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  Glyph.Data = {
                    06030000424D06030000000000003600000028000000100000000F0000000100
                    180000000000D0020000C30E0000C30E00000000000000000000F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0FCF9F6F4F4
                    F5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0FBF9F57A9AEBF8F8F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F5F5F595ADEEE2E7F4F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0EFEFEFD3DEF22C69E9FAF9F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFEFF6F5F51569E9DDE5F3EFEFEFF0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFEFFF
                    FCF62688EC2E88EBFCF9F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0FFFBF648A7EF1A8DEDD5E5F4EFEFEFF0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F7F4F37FCAF216
                    9EF02DA2EFFFFEF6FAF6F3F3F3F3F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F3F2F2B8E4F40CAAF116A9F021A8F14DB5F182C7F2E0ECF5F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0E6F2F500B8F505B6F50B
                    B3F315AFF117ABF10DA2F1F4F5F5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F8F5F5F5F6F5C4EAF569D2F40EB9F511B5F435BAF1F7F5F4F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0EFEFF0FEF7F60F
                    C7F50EC4F50BBFF5CDEBF5F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F1F1F182E4F60ED2FA0ECDF809C8F6FFF8F6F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F3F5F618D8F822
                    DAF822D9FA80E3F7F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F7F6F6F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
                    F0F0F0F0F0F0F0F0F0F0}
                  ParentFont = False
                  TabOrder = 0
                  OnClick = Sb_InclusaoRapidoClick
                end
                object Sb_Exc_Produto: TBitBtn
                  AlignWithMargins = True
                  Left = 654
                  Top = 2
                  Width = 146
                  Height = 37
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alRight
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
                  TabOrder = 1
                  OnClick = Sb_Exc_ProdutoClick
                end
                object Sb_Alt_Produto: TBitBtn
                  AlignWithMargins = True
                  Left = 507
                  Top = 2
                  Width = 145
                  Height = 37
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alRight
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
                object Sb_Ins_Produto: TBitBtn
                  AlignWithMargins = True
                  Left = 374
                  Top = 2
                  Width = 131
                  Height = 37
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alRight
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
                  TabOrder = 3
                  OnClick = Sb_Ins_ProdutoClick
                end
              end
            end
          end
          object TabSh_Servico: TTabSheet
            Caption = 'Servi'#231'os'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Pnl_Servico: TPanel
              Left = 0
              Top = 0
              Width = 812
              Height = 377
              Align = alClient
              BevelInner = bvRaised
              BevelOuter = bvLowered
              TabOrder = 0
              object DBGrid2: TDBGrid
                Left = 2
                Top = 2
                Width = 808
                Height = 326
                Align = alClient
                Color = clMoneyGreen
                Ctl3D = True
                DataSource = Ds_Itens_Srv
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Lucida Console'
                Font.Style = []
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowSelect, dgTitleClick]
                ParentCtl3D = False
                ParentFont = False
                PopupMenu = Pop_Servico
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clNavy
                TitleFont.Height = -11
                TitleFont.Name = 'Arial'
                TitleFont.Style = []
                OnDrawColumnCell = DBG_ProdutosDrawColumnCell
                OnDblClick = DBGrid2DblClick
                OnKeyDown = DBGrid2KeyDown
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'ICT_CODVCL'
                    Title.Caption = 'C'#243'digo'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 96
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_DESCRICAO'
                    Title.Caption = 'Descri'#231#227'o Produto'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 340
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_QTDE'
                    Title.Caption = 'Qtde'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 55
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_VL_UNIT'
                    Title.Caption = 'Valor Unit'#225'rio'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 90
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ICT_VL_SUBTOTAL'
                    Title.Caption = 'SubTotal'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clNavy
                    Title.Font.Height = -13
                    Title.Font.Name = 'Arial'
                    Title.Font.Style = []
                    Width = 90
                    Visible = True
                  end>
              end
              object Panel4: TPanel
                AlignWithMargins = True
                Left = 5
                Top = 331
                Width = 802
                Height = 41
                Align = alBottom
                TabOrder = 1
                object Sb_Ins_Servico: TBitBtn
                  Left = 87
                  Top = 1
                  Width = 131
                  Height = 39
                  Align = alRight
                  Caption = 'Novo Servi'#231'o - F2'
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
                  OnClick = Sb_Ins_ServicoClick
                end
                object Sb_Alt_Servico: TBitBtn
                  Left = 218
                  Top = 1
                  Width = 145
                  Height = 39
                  Align = alRight
                  Caption = 'Alterar Servi'#231'o - F3'
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
                  TabOrder = 1
                  OnClick = Sb_Alt_ServicoClick
                end
                object Sb_Exc_Servico: TBitBtn
                  Left = 363
                  Top = 1
                  Width = 146
                  Height = 39
                  Align = alRight
                  Caption = 'Excluir Servi'#231'o - F4'
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
                  TabOrder = 2
                  OnClick = Sb_Exc_ServicoClick
                end
                object Sb_Servico: TBitBtn
                  Left = 509
                  Top = 1
                  Width = 146
                  Height = 39
                  Align = alRight
                  Caption = 'Detalhe Servi'#231'o - F8'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  Glyph.Data = {
                    76010000424D7601000000000000760000002800000020000000100000000100
                    04000000000000010000120B0000120B00001000000000000000000000000000
                    800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
                    3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
                    700077337F3333373777887007333337007733F773F333337733700070333333
                    077037773733333F7F37703707333300080737F373333377737F003333333307
                    78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
                    078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
                    70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
                    3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
                    33337F73FF737773333307800077033333337337773373333333}
                  NumGlyphs = 2
                  ParentFont = False
                  TabOrder = 3
                  OnClick = Sb_ServicoClick
                end
                object Sb_Tecnico: TBitBtn
                  Left = 655
                  Top = 1
                  Width = 146
                  Height = 39
                  Align = alRight
                  Caption = 'T'#233'cnicos - F9'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clNavy
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Style = []
                  Glyph.Data = {
                    76010000424D7601000000000000760000002800000020000000100000000100
                    04000000000000010000120B0000120B00001000000000000000000000000000
                    800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
                    BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
                    BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
                    BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
                    BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
                    EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
                    EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
                    EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
                    EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
                  NumGlyphs = 2
                  ParentFont = False
                  TabOrder = 4
                  OnClick = Sb_TecnicoClick
                end
              end
            end
          end
          object TabSheet5: TTabSheet
            Caption = 'Observa'#231#227'o'
            ImageIndex = 3
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            DesignSize = (
              812
              377)
            object Label27: TLabel
              Left = 7
              Top = 338
              Width = 91
              Height = 14
              Anchors = [akLeft, akBottom]
              AutoSize = False
              Caption = 'Prazo de Entrega'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ExplicitTop = 302
            end
            object Label3: TLabel
              Left = 106
              Top = 338
              Width = 41
              Height = 14
              Anchors = [akLeft, akBottom]
              Caption = 'Garantia'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ExplicitTop = 302
            end
            object Validade: TLabel
              Left = 424
              Top = 338
              Width = 41
              Height = 14
              Anchors = [akLeft, akBottom]
              Caption = 'Validade'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ExplicitTop = 302
            end
            object E_obs: TMemo
              Left = 0
              Top = 0
              Width = 812
              Height = 203
              Align = alTop
              TabOrder = 0
            end
            object E_Dt_Entrega: TEdit
              Left = 5
              Top = 353
              Width = 95
              Height = 21
              Anchors = [akLeft, akBottom]
              AutoSize = False
              TabOrder = 1
            end
            object E_Garantia: TEdit
              Left = 104
              Top = 353
              Width = 313
              Height = 21
              Anchors = [akLeft, akBottom]
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Validade: TEdit
              Left = 422
              Top = 353
              Width = 308
              Height = 21
              Anchors = [akLeft, akBottom]
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            inline Fm_ListaAuxiliarVenda: TFm_ListaColaboradores
              Left = 5
              Top = 207
              Width = 225
              Height = 36
              TabOrder = 4
              ExplicitLeft = 5
              ExplicitTop = 207
              ExplicitWidth = 225
              ExplicitHeight = 36
              inherited Label19: TLabel
                Width = 225
                Caption = 'Auxiliar Venda'
                ExplicitWidth = 70
              end
              inherited Sb_Cadastro: TSpeedButton
                Left = 199
                Height = 19
                ExplicitLeft = 199
                ExplicitHeight = 19
              end
              inherited Dblcb_Vendedor: TDBLookupComboBox
                Width = 196
                ExplicitWidth = 196
              end
              inherited Qr_ListaVendedor: TSTQuery
                Transaction = DM.IB_Transacao
                UpdateTransaction = DM.IB_Transacao
              end
            end
          end
        end
        object Panel3: TPanel
          Left = 2
          Top = 2
          Width = 820
          Height = 143
          Align = alTop
          Caption = 'Panel3'
          TabOrder = 2
          object Label1: TLabel
            Left = 9
            Top = 6
            Width = 44
            Height = 14
            Caption = 'N'#250'mero'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 128
            Top = 6
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
            Left = 233
            Top = 45
            Width = 159
            Height = 14
            Caption = 'Contatos / Telefones / WhatsApp'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 222
            Top = 6
            Width = 33
            Height = 14
            Caption = 'C'#243'digo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object SB_Cliente: TSpeedButton
            Left = 693
            Top = 21
            Width = 20
            Height = 22
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            OnClick = SB_ClienteClick
          end
          object Lb_Numero: TLabel
            Left = 6
            Top = 22
            Width = 107
            Height = 19
            Caption = 'ORC - 0000/07'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 233
            Top = 83
            Width = 137
            Height = 14
            Caption = 'N'#250'mero de Parcelas/ Prazos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Parcelamento: TSpeedButton
            Left = 474
            Top = 94
            Width = 20
            Height = 22
            Caption = '...'
            OnClick = Sb_ParcelamentoClick
          end
          object Label10: TLabel
            Left = 504
            Top = 45
            Width = 68
            Height = 14
            Caption = 'Email de envio'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Sb_Pesq_Cliente: TSpeedButton
            Left = 717
            Top = 21
            Width = 21
            Height = 22
            Glyph.Data = {
              E6010000424DE60100000000000036000000280000000C0000000C0000000100
              180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
              79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
              177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
              FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
              A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
              FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
              D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
              C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
              FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
              E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF}
            OnClick = Sb_Pesq_ClienteClick
          end
          object E_Cd_Empresa: TEdit
            Left = 220
            Top = 22
            Width = 81
            Height = 21
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnExit = E_Cd_EmpresaExit
          end
          object E_Contato: TEdit
            Left = 231
            Top = 60
            Width = 266
            Height = 21
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object E_Data: TDateTimePicker
            Left = 127
            Top = 22
            Width = 89
            Height = 22
            Date = 39583.726933773150000000
            Time = 39583.726933773150000000
            TabOrder = 0
          end
          object E_Nr_Parcelas: TMaskEdit
            Left = 233
            Top = 96
            Width = 37
            Height = 21
            EditMask = '000;1;_'
            MaxLength = 3
            TabOrder = 7
            Text = '000'
            OnExit = E_Nr_ParcelasExit
          end
          object E_Prazo: TMaskEdit
            Left = 272
            Top = 96
            Width = 199
            Height = 21
            MaxLength = 200
            TabOrder = 8
            Text = #192' VISTA'
          end
          object E_email: TEdit
            Left = 503
            Top = 60
            Width = 240
            Height = 21
            CharCase = ecLowerCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object Cb_Empresa: TComboBox
            Left = 307
            Top = 22
            Width = 383
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 2
            OnExit = Cb_EmpresaExit
          end
          object ChBx_Nome: TCheckBox
            Left = 307
            Top = 5
            Width = 121
            Height = 16
            TabStop = False
            Caption = 'Nome/Raz'#227'o Social'
            Checked = True
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 9
            OnClick = ChBx_NomeClick
          end
          object ChBx_Fantasia: TCheckBox
            Left = 434
            Top = 5
            Width = 121
            Height = 16
            TabStop = False
            Caption = 'Apelido/Fantasia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            OnClick = ChBx_FantasiaClick
          end
          inline Fm_FormaPagto: TFm_FormaPagto
            Left = 3
            Top = 80
            Width = 224
            Height = 42
            TabOrder = 6
            ExplicitLeft = 3
            ExplicitTop = 80
            ExplicitWidth = 224
            ExplicitHeight = 42
            inherited Lb_FormaPagamento: TLabel
              Width = 218
            end
            inherited pnl_Forma: TPanel
              Width = 224
              Height = 28
              ExplicitWidth = 224
              ExplicitHeight = 28
              inherited SB_FormaPag: TSpeedButton
                Left = 198
                Height = 25
                ExplicitLeft = 200
                ExplicitHeight = 28
              end
              inherited DBLCB_FormaPagto: TDBLookupComboBox
                Width = 189
                ExplicitWidth = 189
              end
            end
          end
          inline Fm_VendedorCotacao: TFm_ListaColaboradores
            Left = 5
            Top = 45
            Width = 225
            Height = 36
            TabOrder = 3
            ExplicitLeft = 5
            ExplicitTop = 45
            ExplicitWidth = 225
            ExplicitHeight = 36
            inherited Label19: TLabel
              Width = 225
            end
            inherited Sb_Cadastro: TSpeedButton
              Left = 199
              Height = 19
              ExplicitLeft = 199
              ExplicitHeight = 19
            end
            inherited Dblcb_Vendedor: TDBLookupComboBox
              Width = 196
              ExplicitWidth = 196
            end
            inherited Qr_ListaVendedor: TSTQuery
              Transaction = DM.IB_Transacao
              UpdateTransaction = DM.IB_Transacao
            end
          end
          object DBLCB_Prazo: TDBLookupComboBox
            Left = 233
            Top = 116
            Width = 266
            Height = 21
            KeyField = 'PRZ_PRAZO'
            ListField = 'PRZ_PRAZO'
            ListSource = dts_PrazoControlado
            TabOrder = 11
          end
        end
        object Pnl_Calculo_Custo: TPanel
          Left = 489
          Top = 145
          Width = 326
          Height = 25
          Anchors = [akTop, akRight]
          BevelOuter = bvNone
          TabOrder = 3
          object Label16: TLabel
            AlignWithMargins = True
            Left = -2
            Top = 3
            Width = 174
            Height = 13
            Align = alRight
            Caption = 'Percentual sobre o Custo do Produto'
          end
          object E_Mrg_Lucro: TEdit_Setes
            AlignWithMargins = True
            Left = 178
            Top = 3
            Width = 64
            Height = 19
            Align = alRight
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
            ExplicitHeight = 21
          end
          object Button1: TButton
            AlignWithMargins = True
            Left = 248
            Top = 3
            Width = 75
            Height = 19
            Align = alRight
            Caption = 'Recalcular'
            TabOrder = 1
            OnClick = Button1Click
          end
        end
      end
      object Pnl_Botao: TPanel
        Left = 0
        Top = 605
        Width = 824
        Height = 63
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object SB_Inserir: TSpeedButton
          AlignWithMargins = True
          Left = 84
          Top = 4
          Width = 78
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_InserirClick
          ExplicitLeft = 2
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Alterar: TSpeedButton
          AlignWithMargins = True
          Left = 162
          Top = 4
          Width = 82
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_AlterarClick
          ExplicitLeft = 85
          ExplicitTop = 5
        end
        object SB_Excluir: TSpeedButton
          AlignWithMargins = True
          Left = 244
          Top = 4
          Width = 80
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_ExcluirClick
          ExplicitLeft = 162
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object SB_Gravar: TSpeedButton
          AlignWithMargins = True
          Left = 324
          Top = 4
          Width = 82
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Gravar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_GravarClick
          ExplicitLeft = 247
          ExplicitTop = 5
        end
        object SB_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 406
          Top = 4
          Width = 86
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Cancelar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = SB_CancelarClick
          ExplicitLeft = 324
          ExplicitTop = 1
          ExplicitHeight = 54
        end
        object SB_Pedido: TSpeedButton
          AlignWithMargins = True
          Left = 581
          Top = 4
          Width = 83
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Pedido - F10'
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
          Transparent = False
          OnClick = SB_PedidoClick
          ExplicitLeft = 523
          ExplicitTop = 3
        end
        object Sb_Pesquisar: TSpeedButton
          AlignWithMargins = True
          Left = 492
          Top = 4
          Width = 89
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Pesquisar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Transparent = False
          OnClick = Sb_PesquisarClick
          ExplicitLeft = 413
          ExplicitHeight = 54
        end
        object Sb_Sair_0: TSpeedButton
          AlignWithMargins = True
          Left = 742
          Top = 4
          Width = 78
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
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
          Transparent = False
          OnClick = Sb_Sair_0Click
          ExplicitLeft = 663
          ExplicitHeight = 54
        end
        object SB_Enviar: TSpeedButton
          AlignWithMargins = True
          Left = 664
          Top = 4
          Width = 78
          Height = 55
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alRight
          Caption = 'Enviar - F11'
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
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
            0000377777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
            77F07F773FFFFFFF77F70FFF7700000000007F337777777777770FFFFF0FFFFF
            FFF07F333F7F3FFFF3370FFF700F0000FFF07F3F777F777733370F707F0FFFFF
            FFF07F77337F3FFFFFF7007EEE0F000000F077FFFF7F777777370777770FFFFF
            FFF07777777F3FFFFFF7307EEE0F000000F03773FF7F7777773733707F0FFFFF
            FFF03337737F3FFF33373333700F000FFFF03333377F77733FF73333330FFFFF
            00003333337F3FF377773333330F00FF0F033333337F77337F733333330FFFFF
            00333333337FFFFF773333333300000003333333337777777333}
          Layout = blGlyphTop
          NumGlyphs = 2
          ParentFont = False
          Transparent = False
          OnClick = SB_EnviarClick
          ExplicitLeft = 606
          ExplicitTop = 5
        end
      end
      object Pnl_TabelaPreco: TPanel
        Left = 93
        Top = 212
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
            Left = 43
            Top = 65531
          end
          inherited Ds_Tabelas: TDataSource
            Left = 179
            Top = 11
          end
        end
      end
    end
    object tbs_pesquisa: TTabSheet
      Caption = 'tbs_pesquisa'
      ImageIndex = 1
      OnShow = tbs_pesquisaShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 48
        Width = 824
        Height = 185
        Align = alTop
        Caption = ' Digite sua op'#231#227'o de busca '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label36: TLabel
          Left = 4
          Top = 21
          Width = 60
          Height = 17
          AutoSize = False
          Caption = 'Cota'#231#227'o'
          FocusControl = E_BuscaCotacao
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 324
          Top = 60
          Width = 28
          Height = 14
          Caption = 'e-mail'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 347
          Top = 99
          Width = 24
          Height = 14
          Caption = 'Fone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 8
          Top = 97
          Width = 16
          Height = 14
          Caption = 'U.F'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 57
          Top = 97
          Width = 33
          Height = 14
          Caption = 'Cidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_BuscaCliente: TMaskEdit
          Left = 254
          Top = 37
          Width = 567
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
          Text = ''
        end
        object E_BuscaCotacao: TMaskEdit
          Left = 4
          Top = 37
          Width = 84
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = ''
        end
        object ChBx_BuscaNome: TCheckBox
          Left = 260
          Top = 20
          Width = 121
          Height = 17
          Caption = 'Nome/Raz'#227'o Social'
          Checked = True
          State = cbChecked
          TabOrder = 9
          OnClick = ChBx_BuscaNomeClick
        end
        object ChBx_BuscaFantasia: TCheckBox
          Left = 382
          Top = 20
          Width = 121
          Height = 17
          Caption = 'Apelido/Fantasia'
          TabOrder = 10
          OnClick = ChBx_BuscaFantasiaClick
        end
        object E_Data_Ini: TDateTimePicker
          Left = 91
          Top = 37
          Width = 79
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Checked = False
          Enabled = False
          TabOrder = 1
        end
        object E_Data_Fim: TDateTimePicker
          Left = 172
          Top = 37
          Width = 80
          Height = 22
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Checked = False
          Enabled = False
          TabOrder = 2
        end
        object ChBx_Periodo: TCheckBox
          Left = 93
          Top = 22
          Width = 128
          Height = 12
          Caption = 'Data Inicial    Data Final'
          TabOrder = 11
          OnClick = ChBx_PeriodoClick
        end
        inline Fm_ListaVendedores: TFm_ListaColaboradores
          Left = 6
          Top = 60
          Width = 315
          Height = 36
          TabOrder = 4
          ExplicitLeft = 6
          ExplicitTop = 60
          ExplicitWidth = 315
          ExplicitHeight = 36
          inherited Label19: TLabel
            Width = 315
          end
          inherited Sb_Cadastro: TSpeedButton
            Left = 289
            Height = 22
            Margins.Bottom = 0
            ExplicitLeft = 285
            ExplicitHeight = 17
          end
          inherited Dblcb_Vendedor: TDBLookupComboBox
            Width = 286
            ExplicitWidth = 286
          end
        end
        object E_BuscaEmail: TMaskEdit
          Left = 322
          Top = 75
          Width = 246
          Height = 22
          CharCase = ecLowerCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 5
          Text = ''
        end
        object E_BuscaEstado: TMaskEdit
          Left = 7
          Top = 111
          Width = 43
          Height = 22
          BevelOuter = bvNone
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 6
          Text = ''
        end
        object E_BuscaCidade: TMaskEdit
          Left = 55
          Top = 111
          Width = 289
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 7
          Text = ''
        end
        object E_BuscaFone: TEdit_Setes
          Left = 347
          Top = 111
          Width = 109
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          Text = ''
        end
        inline Fm_ListaProdutos: TFm_ListaProdutos
          Left = 4
          Top = 140
          Width = 500
          Height = 43
          TabOrder = 12
          ExplicitLeft = 4
          ExplicitTop = 140
          ExplicitWidth = 500
          inherited Sb_Produto: TSpeedButton
            Left = 469
            ExplicitLeft = 487
          end
          inherited E_Busca_Produto: TEdit
            Width = 364
            ExplicitWidth = 364
          end
        end
        inline Fm_ListaMarca_Produto: TFm_ListaMarcaProduto
          Left = 503
          Top = 143
          Width = 318
          Height = 35
          TabOrder = 13
          TabStop = True
          ExplicitLeft = 503
          ExplicitTop = 143
          ExplicitWidth = 318
          ExplicitHeight = 35
          inherited Label32: TLabel
            Width = 30
            Caption = 'Marca'
            ExplicitWidth = 30
          end
          inherited Sb_Recipiente_Fabricante_3: TSpeedButton
            Left = 292
            ExplicitLeft = 292
          end
          inherited Dblcb_Marca: TDBLookupComboBox
            Width = 286
            ExplicitWidth = 286
          end
          inherited Qr_ListaMarca: TSTQuery
            Top = 36
          end
          inherited Ds_ListaMarca: TDataSource
            Top = 34
          end
        end
      end
      object Grp_Pesquisa: TGroupBox
        Left = 0
        Top = 233
        Width = 824
        Height = 435
        Align = alClient
        Caption = 'Resultado'
        TabOrder = 1
        object pnl_Botao_Vertical: TPanel
          Left = 722
          Top = 15
          Width = 100
          Height = 418
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object Sb_Sair_1: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 361
            Width = 94
            Height = 54
            Margins.Top = 1
            Align = alBottom
            Caption = 'Sair- Esc'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = Sb_Sair_1Click
            ExplicitLeft = 627
            ExplicitTop = 343
            ExplicitWidth = 114
          end
          object SB_Visualizar: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 305
            Width = 94
            Height = 54
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alBottom
            Caption = 'Visualizar - F8'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_VisualizarClick
            ExplicitLeft = 6
            ExplicitTop = 313
          end
          object SB_Buscar: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 249
            Width = 94
            Height = 54
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alBottom
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
            ExplicitLeft = 630
            ExplicitTop = 192
            ExplicitWidth = 114
          end
          object SB_Cadastrar: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 193
            Width = 94
            Height = 54
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alBottom
            Caption = 'Cadastrar - F2'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Layout = blGlyphTop
            ParentFont = False
            OnClick = SB_CadastrarClick
            ExplicitLeft = 627
            ExplicitTop = 181
            ExplicitWidth = 114
          end
        end
        object Pg_Busca: TPageControl
          Left = 2
          Top = 15
          Width = 720
          Height = 418
          ActivePage = tbs_busca_cotacao_itens
          Align = alClient
          TabOrder = 1
          object tbs_busca_cotacao: TTabSheet
            Caption = 'Or'#231'amentos'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object DBG_Pesquisa: TDBGrid
              Left = 0
              Top = 0
              Width = 712
              Height = 390
              Align = alClient
              Color = clCream
              DataSource = Ds_Pesquisa
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnDblClick = SB_VisualizarClick
              OnTitleClick = DBG_PesquisaTitleClick
              Columns = <
                item
                  Expanded = False
                  FieldName = 'CTC_DATA'
                  Title.Caption = 'Data'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -13
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CTC_NUMERO'
                  Title.Caption = 'Or'#231'amento'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -13
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 84
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CTC_FANTASIA'
                  Title.Caption = 'Nome do Cliente'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -13
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 413
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CTC_VL_COTACAO'
                  Title.Caption = 'Valor Total'
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clNavy
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = []
                  Width = 93
                  Visible = True
                end>
            end
          end
          object tbs_busca_cotacao_itens: TTabSheet
            Caption = 'Resumo Itens'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object DBG_Pesquisa_Itens: TDBGrid
              Left = 0
              Top = 0
              Width = 712
              Height = 390
              Align = alClient
              Color = clCream
              DataSource = Ds_Pesquisa_itens
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnDblClick = SB_VisualizarClick
              OnTitleClick = DBG_Pesquisa_ItensTitleClick
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PRO_CODIGO'
                  Title.Caption = 'C'#243'digo'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRO_CODIGOFAB'
                  Title.Caption = 'C. F'#225'brica'
                  Width = 84
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRO_DESCRICAO'
                  Title.Caption = 'Descri'#231#227'o'
                  Width = 444
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'QT_ITENS'
                  Title.Caption = 'Qtde'
                  Width = 47
                  Visible = True
                end>
            end
          end
        end
      end
      inline Fm_LME: TFm_ListaMultiEmpresa
        Left = 0
        Top = 0
        Width = 824
        Height = 48
        Align = alTop
        TabOrder = 2
        ExplicitWidth = 824
        ExplicitHeight = 48
        inherited pnl_linha_1: TPanel
          Width = 824
          ExplicitWidth = 824
        end
        inherited pnl_top: TPanel
          Width = 824
          ExplicitWidth = 824
        end
      end
    end
    object tbs_Config_Global: TTabSheet
      Caption = 'Configura'#231#245'es Globais'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 824
        Height = 668
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          824
          668)
        object Label15: TLabel
          Left = 2
          Top = 2
          Width = 820
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es Globais'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          ExplicitWidth = 183
        end
        object Btn_Ok_Local: TButton
          Left = 578
          Top = 638
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Btn_Ok_LocalClick
        end
        object Btn_Cn_Local: TButton
          Left = 663
          Top = 638
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Btn_Cn_LocalClick
        end
        object Btn_Ap_Local: TButton
          Left = 738
          Top = 638
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Btn_Ap_LocalClick
        end
        object Chbx_controle_orcamento: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 83
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Controlar a seq'#252#234'ncia do n'#250'mero de pedido de Or'#231'amento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Chbx_Comp_Orcamentos: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 102
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Compartilhar os or'#231'amentos entre as Empresas registradas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ChBx_Manipula_Orc: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 121
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Manipular o or'#231'amento mostrando o custo com bot'#227'o de calculo de ' +
            'margem de Lucro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object ChBx_Libera_Valor: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 140
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Liberar o campo Valor Unit'#225'rio de Venda mesmo para Usu'#225'rio n'#227'o a' +
            'dministrador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object pnl_cfg_g_top: TPanel
          Left = 2
          Top = 22
          Width = 820
          Height = 59
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 7
          object GroupBox20: TGroupBox
            Left = 0
            Top = 0
            Width = 313
            Height = 59
            Align = alLeft
            Caption = 'Controle de Or'#231'amentos Antigos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object chbx_dias_Orc: TCheckBox
              Left = 7
              Top = 22
              Width = 291
              Height = 17
              TabStop = False
              Caption = 'Excluir Or'#231'amentos n'#227'o aprovados em                     dia(s)'
              TabOrder = 1
              OnClick = chbx_dias_OrcClick
            end
            object E_dias_Orc: TEdit_Setes
              Left = 214
              Top = 19
              Width = 49
              Height = 21
              TabStop = False
              Alignment = taRightJustify
              TabOrder = 0
              Text = ''
            end
          end
          object Rg_Parcela_Orca: TRadioGroup
            Left = 313
            Top = 0
            Width = 159
            Height = 59
            Align = alLeft
            Caption = 'Tipo de Parcelamento:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Aberto'
              'Controlado')
            ParentFont = False
            TabOrder = 1
          end
        end
        object chbx_nao_mostra_valor_usuario: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 159
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'N'#227'o mostrar valores na tela de consulta para usu'#225'rios n'#227'o Admini' +
            'stradores'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object chbx_somente_vendedor_altera: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 178
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Controlar a edi'#231#227'o do or'#231'amento pelo pr'#243'prio Vendedor ou Adminis' +
            'trador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object chbx_Alerta_Estoque: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 197
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Mostrar mensagem de Alerta para Produtos sem estoque - N'#227'o bloqu' +
            'eia a opera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object Chbx_somente_produto_cadastrado: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 216
          Width = 814
          Height = 17
          Margins.Top = 2
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Incluir somente produtos previamente cadastrados.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
      end
    end
    object tbs_Config_Local: TTabSheet
      Caption = 'Configura'#231#245'es Locais'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 824
        Height = 668
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        DesignSize = (
          824
          668)
        object Label14: TLabel
          Left = 2
          Top = 2
          Width = 820
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es Locais'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 174
        end
        object Label17: TLabel
          Left = 7
          Top = 74
          Width = 185
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Matricial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 8
          Top = 113
          Width = 203
          Height = 14
          Caption = 'Modelos de Impress'#227'o - Estilo Laser / Jato'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label39: TLabel
          Left = 8
          Top = 152
          Width = 155
          Height = 14
          Caption = 'Modelo de interface de Trabalho'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Button2: TButton
          Left = 585
          Top = 638
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 664
          Top = 638
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 739
          Top = 638
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          TabOrder = 2
          OnClick = Button4Click
        end
        object rdg_PedOrc_Imp: TRadioGroup
          Left = 4
          Top = 26
          Width = 270
          Height = 46
          Caption = 'Imprimir Pedido em Impressora'
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Matricial'
            'Jato / Laser'
            'Ambos')
          ParentFont = False
          TabOrder = 3
        end
        object GroupBox19: TGroupBox
          Left = 277
          Top = 26
          Width = 295
          Height = 46
          Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          object e_porta_ImpOrc: TEdit
            Left = 7
            Top = 19
            Width = 227
            Height = 21
            TabOrder = 0
          end
          object e_salto_Orc: TEdit_Setes
            Left = 237
            Top = 19
            Width = 52
            Height = 21
            Alignment = taRightJustify
            TabOrder = 1
            Text = ''
          end
        end
        object GroupBox21: TGroupBox
          Left = 482
          Top = 75
          Width = 87
          Height = 60
          Caption = 'Itens por Folha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object e_itens_oRC: TEdit_Setes
            Left = 7
            Top = 19
            Width = 74
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = ''
          end
        end
        object Cbx_TipoMatric: TComboBox
          Left = 7
          Top = 89
          Width = 466
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          Items.Strings = (
            'MODELO 1'
            'MODELO 2'
            'MODELO 3 - ORDEM DE SERVI'#199'O')
        end
        object Cbx_TipoLaser: TComboBox
          Left = 6
          Top = 129
          Width = 470
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            'MODELO 01 -  NORMAL'
            'MODELO 02 -  NORMAL(COM INFORMA'#199'AO DO VEICULO)'
            'MODELO 03  - EXTFORMA'
            'MODELO 04  - EXTIMPLAS'
            'MODELO 05  - RICAMO'
            'MODELO 06  - IMPRIMARK'
            'MODELO 07 - G'#202'NIO'
            'MODELO 08 - S'#195'O LUIZ EXTINTORES'
            'MODELO 09 - BALAN'#199'AS PINHAIS'
            'MODELO 10 - AUDAX EXINTORES'
            'MODELO 11 - DOCES SENSA'#199#195'O'
            'MODELO 12 - LEVMINIO'
            'MODELO 13 - BRASIL SACOLAS')
        end
        object Cb_InterfaceCotacao: TComboBox
          Left = 6
          Top = 168
          Width = 470
          Height = 21
          Style = csDropDownList
          TabOrder = 8
          Items.Strings = (
            'MODELO DE VENDAS'
            'MODELOS DE CONFEC'#199#195'O DE VESTUARIO'
            'MODELO DE COMUNICA'#199#195'O VISUAL'
            'MODELO DE USINAGEM')
        end
      end
    end
  end
  object Ds_Itens_Pro: TDataSource
    DataSet = Qr_Itens_Pro
    Left = 32
    Top = 320
  end
  object PrintDialog: TPrintDialog
    Left = 744
    Top = 48
  end
  object Qr_Pesquisa: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      
        'SELECT CTC_CODIGO,  CTC_DATA, CTC_NUMERO, CTC_FANTASIA, CTC_VL_C' +
        'OTACAO , EMP_FANTASIA'
      'FROM TB_COTACAO tb_cotacao'
      '    LEFT OUTER JOIN TB_EMPRESA tb_empresa'
      '   ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP)')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 72
    Top = 440
  end
  object Ds_Pesquisa: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa
    Left = 72
    Top = 480
  end
  object Ds_Usuario: TDataSource
    Left = 206
    Top = 8
  end
  object Ds_FormaPagto: TDataSource
    Left = 251
  end
  object Qr_Itens_Pro: TSTQuery
    OnCalcFields = Qr_Itens_ProCalcFields
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      'PRO_CODIGOFAB,'
      'PRO_VL_CUSTO,'
      'PRO_DIVISOR,'
      'PRO_LOCAL,'
      'TPR_MODALIDADE,'
      'ICT_CODIGO,'
      'ICT_CODCTC,'
      'ICT_TIPO,'
      'ICT_CODVCL,'
      'ICT_DESCRICAO,'
      'ICT_QTDE,'
      'ICT_VL_UNIT,'
      'ICT_AQ_COM,'
      'ICT_VL_DESC,'
      'ICT_AQ_DESC,'
      'ICT_AQ_IPI,'
      'ICT_AQ_ICMS,'
      'ICT_CODEST,'
      'ICT_CODTPR,'
      'PRO_CODIGO,'
      'ICT_VL_CUSTO,'
      '  CAST((ICT_QTDE * ICT_VL_UNIT) AS NUMERIC(18, 9)) AS ICT_VL_SUBTOTAL,'
      'TPR_NOME'
      'FROM TB_ITENS_CTC tb_itens_ctc'
      '   left JOIN TB_PRODUTO tb_produto'
      '  on (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL)'
      '   INNER JOIN TB_TABELA_PRECO tb_tabela_preco'
      '   on (tb_tabela_preco.TPR_CODIGO = tb_itens_ctc.ICT_CODTPR)'
      ''
      ''
      'WHERE '
      '  (ICT_CODCTC =:CTC_CODIGO) AND (ICT_TIPO <> '#39'S'#39')'
      'ORDER BY ICT_CODIGO')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 81
    Top = 48
    ParamData = <
      item
        Name = 'CTC_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
    object Qr_Itens_ProPRO_CODIGOFAB: TStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_Itens_ProPRO_VL_CUSTO: TFMTBCDField
      FieldName = 'PRO_VL_CUSTO'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_Itens_ProPRO_DIVISOR: TIntegerField
      FieldName = 'PRO_DIVISOR'
      Origin = '"TB_PRODUTO"."PRO_DIVISOR"'
    end
    object Qr_Itens_ProTPR_MODALIDADE: TStringField
      FieldName = 'TPR_MODALIDADE'
      Origin = '"TB_TABELA_PRECO"."TPR_MODALIDADE"'
      FixedChar = True
      Size = 1
    end
    object Qr_Itens_ProICT_CODIGO: TIntegerField
      FieldName = 'ICT_CODIGO'
      Origin = '"TB_ITENS_CTC"."ICT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Itens_ProICT_CODCTC: TIntegerField
      FieldName = 'ICT_CODCTC'
      Origin = '"TB_ITENS_CTC"."ICT_CODCTC"'
    end
    object Qr_Itens_ProICT_TIPO: TStringField
      FieldName = 'ICT_TIPO'
      Origin = '"TB_ITENS_CTC"."ICT_TIPO"'
      Size = 1
    end
    object Qr_Itens_ProICT_CODVCL: TIntegerField
      FieldName = 'ICT_CODVCL'
      Origin = '"TB_ITENS_CTC"."ICT_CODVCL"'
    end
    object Qr_Itens_ProICT_DESCRICAO: TStringField
      FieldName = 'ICT_DESCRICAO'
      Origin = '"TB_ITENS_CTC"."ICT_DESCRICAO"'
      Size = 100
    end
    object Qr_Itens_ProICT_QTDE: TBCDField
      FieldName = 'ICT_QTDE'
      Origin = '"TB_ITENS_CTC"."ICT_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_Itens_ProICT_VL_UNIT: TFMTBCDField
      FieldName = 'ICT_VL_UNIT'
      Origin = '"TB_ITENS_CTC"."ICT_VL_UNIT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_Itens_ProICT_AQ_COM: TBCDField
      FieldName = 'ICT_AQ_COM'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_COM"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_ProICT_VL_DESC: TBCDField
      FieldName = 'ICT_VL_DESC'
      Origin = '"TB_ITENS_CTC"."ICT_VL_DESC"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_ProICT_AQ_DESC: TBCDField
      FieldName = 'ICT_AQ_DESC'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_DESC"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_ProICT_AQ_IPI: TBCDField
      FieldName = 'ICT_AQ_IPI'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_IPI"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_ProICT_AQ_ICMS: TBCDField
      FieldName = 'ICT_AQ_ICMS'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_ICMS"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_ProICT_CODEST: TIntegerField
      FieldName = 'ICT_CODEST'
      Origin = '"TB_ITENS_CTC"."ICT_CODEST"'
    end
    object Qr_Itens_ProICT_CODTPR: TIntegerField
      FieldName = 'ICT_CODTPR'
      Origin = '"TB_ITENS_CTC"."ICT_CODTPR"'
    end
    object Qr_Itens_ProPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = '"TB_PRODUTO"."PRO_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object Qr_Itens_ProICT_VL_CUSTO: TBCDField
      FieldName = 'ICT_VL_CUSTO'
      Origin = '"TB_ITENS_CTC"."ICT_VL_CUSTO"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 3
    end
    object Qr_Itens_ProICT_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ICT_VL_SUBTOTAL'
      ProviderFlags = []
      DisplayFormat = '0.00'
      Precision = 18
      Size = 9
    end
    object Qr_Itens_ProTPR_NOME: TStringField
      FieldName = 'TPR_NOME'
      Origin = '"TB_TABELA_PRECO"."TPR_NOME"'
      Size = 50
    end
    object Qr_Itens_ProPRO_LOCAL: TStringField
      FieldName = 'PRO_LOCAL'
      Origin = '"TB_PRODUTO"."PRO_LOCAL"'
      Size = 100
    end
  end
  object Qr_Acao: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 432
    Top = 16
  end
  object Ds_Itens_Srv: TDataSource
    DataSet = Qr_Itens_Srv
    Left = 176
    Top = 304
  end
  object Qr_Itens_Srv: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      'ICT_CODIGO,'
      'ICT_CODCTC,'
      'ICT_TIPO,'
      'ICT_CODVCL,'
      'ICT_DESCRICAO,'
      'ICT_QTDE,'
      'ICT_VL_UNIT,'
      'ICT_AQ_COM,'
      'ICT_VL_DESC,'
      'ICT_AQ_DESC,'
      'ICT_AQ_IPI,'
      'ICT_AQ_ICMS,'
      'ICT_CODEST,'
      'ICT_CODTPR,'
      '  CAST((ICT_QTDE * ICT_VL_UNIT) AS NUMERIC(18, 9)) AS ICT_VL_SUBTOTAL'
      'FROM TB_ITENS_CTC'
      'WHERE '
      '  (ICT_CODCTC =:CTC_CODIGO) AND (ICT_TIPO = '#39'S'#39')'
      'ORDER BY ICT_CODIGO'
      '')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 177
    Top = 56
    ParamData = <
      item
        Name = 'CTC_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
    object Qr_Itens_SrvICT_CODIGO: TIntegerField
      FieldName = 'ICT_CODIGO'
      Origin = '"TB_ITENS_CTC"."ICT_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_Itens_SrvICT_CODCTC: TIntegerField
      FieldName = 'ICT_CODCTC'
      Origin = '"TB_ITENS_CTC"."ICT_CODCTC"'
    end
    object Qr_Itens_SrvICT_TIPO: TStringField
      FieldName = 'ICT_TIPO'
      Origin = '"TB_ITENS_CTC"."ICT_TIPO"'
      Size = 1
    end
    object Qr_Itens_SrvICT_CODVCL: TIntegerField
      FieldName = 'ICT_CODVCL'
      Origin = '"TB_ITENS_CTC"."ICT_CODVCL"'
    end
    object Qr_Itens_SrvICT_DESCRICAO: TStringField
      FieldName = 'ICT_DESCRICAO'
      Origin = '"TB_ITENS_CTC"."ICT_DESCRICAO"'
      Size = 100
    end
    object Qr_Itens_SrvICT_QTDE: TBCDField
      FieldName = 'ICT_QTDE'
      Origin = '"TB_ITENS_CTC"."ICT_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_Itens_SrvICT_VL_UNIT: TFMTBCDField
      FieldName = 'ICT_VL_UNIT'
      Origin = '"TB_ITENS_CTC"."ICT_VL_UNIT"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 6
    end
    object Qr_Itens_SrvICT_AQ_COM: TBCDField
      FieldName = 'ICT_AQ_COM'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_COM"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_SrvICT_VL_DESC: TBCDField
      FieldName = 'ICT_VL_DESC'
      Origin = '"TB_ITENS_CTC"."ICT_VL_DESC"'
      DisplayFormat = '0.00'
      MinValue = 120629.940400000000000000
      Precision = 18
      Size = 2
    end
    object Qr_Itens_SrvICT_AQ_DESC: TBCDField
      FieldName = 'ICT_AQ_DESC'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_DESC"'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_SrvICT_AQ_IPI: TBCDField
      FieldName = 'ICT_AQ_IPI'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_IPI"'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_SrvICT_AQ_ICMS: TBCDField
      FieldName = 'ICT_AQ_ICMS'
      Origin = '"TB_ITENS_CTC"."ICT_AQ_ICMS"'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_SrvICT_CODEST: TIntegerField
      FieldName = 'ICT_CODEST'
      Origin = '"TB_ITENS_CTC"."ICT_CODEST"'
    end
    object Qr_Itens_SrvICT_CODTPR: TIntegerField
      FieldName = 'ICT_CODTPR'
      Origin = '"TB_ITENS_CTC"."ICT_CODTPR"'
    end
    object Qr_Itens_SrvICT_VL_SUBTOTAL: TFMTBCDField
      FieldName = 'ICT_VL_SUBTOTAL'
      ProviderFlags = []
      DisplayFormat = '0.00'
      Precision = 18
      Size = 9
    end
  end
  object Qr_Itens: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      'ICT_TIPO,'
      'ICT_CODVCL,'
      'PRO_CODIGOFAB,'
      'ICT_DESCRICAO,'
      'ICT_QTDE,'
      'ICT_VL_CUSTO,'
      'ICT_VL_UNIT,'
      'ICT_AQ_DESC,'
      'ICT_VL_DESC,'
      'ICT_AQ_COM,'
      'ICT_AQ_IPI,'
      'ICT_AQ_ICMS,'
      'ICT_CODEST,'
      'ICT_CODTPR,'
      'CAST((ICT_QTDE * ICT_VL_UNIT) AS NUMERIC(18, 9)) AS ICT_VL_SUBTOTAL,'
      'ICT_ALTURA,'
      'ICT_LARGURA'
      'FROM TB_ITENS_CTC tb_itens_ctc'
      '  LEFT OUTER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL)'
      'WHERE '
      '  (ICT_CODCTC =:CTC_CODIGO) '
      '')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 553
    Top = 48
    ParamData = <
      item
        Name = 'CTC_CODIGO'
      end>
  end
  object Qr_Ordem: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT ORD_CODIGO'
      'FROM TB_ORDEMSERVICO tb_ordemservico'
      '   INNER JOIN TB_VEICULO tb_veiculo'
      '   ON (tb_veiculo.VEI_CODIGO = tb_ordemservico.ORD_CODVEI)'
      '   INNER JOIN TB_MARCA_VEICULO tb_marca'
      '   ON (tb_marca.MRC_CODIGO = tb_veiculo.VEI_CODMRC)'
      '   INNER JOIN TB_MODELO tb_modelo'
      '   ON (tb_modelo.MOD_CODIGO = tb_veiculo.VEI_CODMOD)'
      '   INNER JOIN TB_TP_VEICULO tb_tp_veiculo'
      '   ON (tb_tp_veiculo.TPV_CODIGO = tb_veiculo.VEI_CODTPV)'
      'WHERE'
      '  ORD_CODPED =:CTC_CODPED')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 688
    Top = 16
    ParamData = <
      item
        Name = 'CTC_CODPED'
        DataType = ftInteger
        Size = 4
      end>
  end
  object dts_PrazoControlado: TDataSource
    DataSet = qr_prazo_controlado
    Left = 572
    Top = 180
  end
  object qr_prazo_controlado: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo'
      'where'
      'prz_vl_minimo <= :prz_vl_minimo')
    ForcedRefresh = False
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 492
    Top = 132
    ParamData = <
      item
        Name = 'prz_vl_minimo'
      end>
    object qr_prazo_controladoPRZ_PRAZO: TStringField
      FieldName = 'PRZ_PRAZO'
      Origin = 'TB_PRAZO.PRZ_PRAZO'
      Required = True
      Size = 51
    end
    object qr_prazo_controladoPRZ_CODIGO: TIntegerField
      FieldName = 'PRZ_CODIGO'
      Origin = 'TB_PRAZO.PRZ_CODIGO'
      Required = True
    end
  end
  object Pop_Produto: TPopupMenu
    Left = 316
    Top = 180
    object CadastrodoProduto: TMenuItem
      Caption = 'Cadastro do Produto'
      OnClick = CadastrodoProdutoClick
    end
  end
  object Pop_Servico: TPopupMenu
    Left = 348
    Top = 180
    object MenuItem1: TMenuItem
      Caption = 'Cadastro do Servi'#231'o'
      OnClick = MenuItem1Click
    end
  end
  object Mnu_Controle: TMainMenu
    Left = 420
    Top = 92
    object Mnu_Tarefas: TMenuItem
      Caption = 'Tarefas'
      object popLucratividade: TMenuItem
        Caption = 'Lucratividade'
        OnClick = popLucratividadeClick
      end
      object Pop_ConfigLocal: TMenuItem
        Caption = 'Configura'#231#245'es Locais'
        OnClick = Pop_ConfigLocalClick
      end
      object Pop_ConfigGlobal: TMenuItem
        Caption = 'Configura'#231#245'es Globais'
        OnClick = Pop_ConfigGlobalClick
      end
      object AlteraTabeladePreo: TMenuItem
        Caption = 'Altera Tabela de Pre'#231'o'
        OnClick = AlteraTabeladePreoClick
      end
      object MnuCustodoPedido: TMenuItem
        Caption = 'Custos para o Pedido'
        OnClick = MnuCustodoPedidoClick
      end
    end
  end
  object ActionList1: TActionList
    Left = 652
    Top = 160
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 16496
      OnExecute = Action1Execute
    end
  end
  object Qr_Pesquisa_itens: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    UpdateTransaction = DM.IB_Transacao
    SQL.Strings = (
      
        'SELECT PRO_CODIGO, PRO_CODIGOFAB, PRO_DESCRICAO, SUM(ICT_QTDE) Q' +
        'T_ITENS'
      'FROM TB_COTACAO c'
      '  LEFT OUTER JOIN TB_CONSERTO tb_conserto'
      '  ON (c.CTC_CODPED =  tb_conserto.CST_CODPED)'
      '  LEFT OUTER JOIN TB_PEDIDO Tb_pedido'
      '  ON  (Tb_pedido.PED_CODIGO = c.CTC_CODPED)'
      '  LEFT OUTER JOIN TB_EMPRESA Tb_empresa'
      '  ON  (Tb_empresa.EMP_CODIGO = c.CTC_CODEMP)'
      '  INNER JOIN TB_ITENS_CTC I'
      '  on (i.ict_codctc = c.ctc_codigo)'
      '  INNER JOIN TB_PRODUTO P'
      '  ON (P.pro_codigo = I.ict_codvcl)'
      'group BY 1,2,3'
      'order by pro_descricao')
    ForcedRefresh = True
    Database = DM.IBD_Gestao
    BufferChunks = 1000
    ParamCheck = True
    Left = 152
    Top = 440
  end
  object Ds_Pesquisa_itens: TDataSource
    AutoEdit = False
    DataSet = Qr_Pesquisa_itens
    Left = 152
    Top = 480
  end
end

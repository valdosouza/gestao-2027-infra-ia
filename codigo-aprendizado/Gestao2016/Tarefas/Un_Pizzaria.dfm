object Fr_Pizzaria: TFr_Pizzaria
  Left = 128
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Atendimento Pizzaria'
  ClientHeight = 652
  ClientWidth = 1016
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Mnu_Principal
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_fundos: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 582
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Pg_Cardapio: TPageControl
      AlignWithMargins = True
      Left = 5
      Top = 164
      Width = 643
      Height = 413
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Pnl_Left: TPanel
      Left = 651
      Top = 161
      Width = 363
      Height = 419
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        363
        419)
      object Label10: TLabel
        Left = 8
        Top = 217
        Width = 101
        Height = 20
        Anchors = [akLeft, akBottom]
        Caption = 'Total de Itens:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 229
      end
      object E_Qt_Total: TLabel
        Left = 126
        Top = 217
        Width = 39
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 229
      end
      object GbObsPedido: TGroupBox
        Left = 0
        Top = 243
        Width = 363
        Height = 92
        Align = alBottom
        Caption = 'Observa'#231#227'o do Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object E_OBS: TMemo
          Left = 2
          Top = 18
          Width = 359
          Height = 72
          Align = alClient
          Lines.Strings = (
            'Memo1')
          TabOrder = 0
        end
      end
      object StrGrd_ItensVenda: TStringGrid
        Left = 0
        Top = 0
        Width = 363
        Height = 211
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clMoneyGreen
        ColCount = 13
        DefaultColWidth = 40
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        ParentFont = False
        TabOrder = 1
        OnDrawCell = StrGrd_ItensVendaDrawCell
        ColWidths = (
          40
          40
          40
          40
          40
          40
          40
          40
          40
          40
          40
          40
          40)
        RowHeights = (
          20
          20)
      end
      object Pnl_Total: TPanel
        Left = 0
        Top = 335
        Width = 363
        Height = 84
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          363
          84)
        object SubTotal: TLabel
          Left = 4
          Top = 1
          Width = 49
          Height = 16
          Caption = 'Subtotal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 267
          Top = 1
          Width = 47
          Height = 16
          Caption = 'Entrega'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 181
          Top = 1
          Width = 58
          Height = 16
          Caption = 'Desconto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 92
          Top = 1
          Width = 56
          Height = 16
          Caption = 'Adicional'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 244
          Top = 41
          Width = 72
          Height = 16
          Anchors = [akRight, akBottom]
          Caption = 'Valor total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 240
        end
        object E_VL_SubTotal: TEdit_Setes
          Left = 3
          Top = 16
          Width = 86
          Height = 24
          TabStop = False
          Alignment = taRightJustify
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '0,00'
        end
        object E_VL_Entrega: TEdit_Setes
          Left = 266
          Top = 16
          Width = 87
          Height = 24
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '0,00'
          OnExit = E_VL_EntregaExit
        end
        object E_Vl_Desconto: TEdit_Setes
          Left = 178
          Top = 16
          Width = 86
          Height = 24
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '0,00'
          OnExit = E_Vl_DescontoExit
        end
        object E_VL_Adicional: TEdit_Setes
          Left = 90
          Top = 16
          Width = 86
          Height = 24
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '0,00'
          OnExit = E_VL_AdicionalExit
        end
        object E_Vl_Pedido: TEdit_Setes
          Left = 243
          Top = 57
          Width = 115
          Height = 24
          TabStop = False
          Alignment = taRightJustify
          Anchors = [akRight, akBottom]
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '0,00'
        end
      end
      object Sb_Exc_Item: TBitBtn
        Left = 268
        Top = 215
        Width = 90
        Height = 32
        Anchors = [akRight, akBottom]
        Caption = 'Excluir Item'
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
        OnClick = Sb_Exc_ItemClick
      end
      object Sb_Imp_Item: TBitBtn
        Left = 177
        Top = 215
        Width = 90
        Height = 32
        Anchors = [akRight, akBottom]
        Caption = 'Imprimir Item'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
          8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
          8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
          8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 4
        OnClick = Sb_Imp_ItemClick
      end
    end
    object Pnl_Top: TPanel
      Left = 2
      Top = 2
      Width = 1012
      Height = 159
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Pnl_Top'
      TabOrder = 2
      object Pg_modalidade: TPageControl
        Left = 118
        Top = 0
        Width = 894
        Height = 159
        ActivePage = tbs_Entrega
        Align = alClient
        MultiLine = True
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnExit = Pg_modalidadeExit
        object tbs_Entrega: TTabSheet
          Caption = 'Entrega'
          object GbDadosClientes: TGroupBox
            Left = 0
            Top = 0
            Width = 705
            Height = 131
            Align = alClient
            Caption = 'Dados da entrega ou de cliente no balc'#227'o com cadastro'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            object Lb_bairro: TLabel
              Left = 7
              Top = 96
              Width = 36
              Height = 16
              Caption = 'Bairro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_Telefone: TLabel
              Left = 7
              Top = 15
              Width = 57
              Height = 16
              Caption = 'Telefone '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_Cliente: TLabel
              Left = 111
              Top = 14
              Width = 100
              Height = 16
              Caption = 'Nome do Cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Lb_Cep: TLabel
              Left = 619
              Top = 15
              Width = 27
              Height = 16
              Caption = 'CEP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_endereco: TLabel
              Left = 7
              Top = 56
              Width = 59
              Height = 16
              Caption = 'Endere'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_compl: TLabel
              Left = 447
              Top = 56
              Width = 84
              Height = 16
              Caption = 'Complemento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_numero: TLabel
              Left = 379
              Top = 56
              Width = 48
              Height = 16
              Caption = 'N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Lb_ObsCliente: TLabel
              Left = 358
              Top = 96
              Width = 145
              Height = 16
              Caption = 'Observa'#231#245'es do Cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Cep: TSpeedButton
              Left = 674
              Top = 31
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_CepClick
            end
            object Sb_Cliente: TSpeedButton
              Left = 570
              Top = 31
              Width = 23
              Height = 21
              Caption = '...'
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_ClienteClick
            end
            object Sb_Endereco: TSpeedButton
              Left = 355
              Top = 73
              Width = 23
              Height = 21
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
                000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
                FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
                FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
                9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
                0000777777777777777733333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333333333333333
                3333333333333333333333333333333333333333333333333333}
              Layout = blGlyphTop
              Margin = 0
              NumGlyphs = 2
              OnClick = Sb_EnderecoClick
            end
            object E_Nome: TEdit
              Left = 110
              Top = 31
              Width = 460
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object E_Endereco: TEdit
              Left = 7
              Top = 72
              Width = 347
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnKeyDown = E_EnderecoKeyDown
            end
            object E_Compl: TEdit
              Left = 448
              Top = 72
              Width = 246
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object E_Bairro: TEdit
              Left = 7
              Top = 113
              Width = 349
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object E_CEP: TMaskEdit
              Left = 599
              Top = 31
              Width = 69
              Height = 24
              CharCase = ecUpperCase
              EditMask = '00000-000;0;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 9
              ParentFont = False
              TabOrder = 2
              Text = ''
              OnExit = E_CEPExit
            end
            object E_Numero: TEdit
              Left = 380
              Top = 72
              Width = 68
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object E_ObsCliente: TEdit
              Left = 358
              Top = 113
              Width = 334
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object E_Telefone: TEdit_Setes
              Left = 5
              Top = 31
              Width = 102
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = ''
              OnEnter = E_TelefoneEnter
              OnExit = E_TelefoneExit
              OnKeyDown = E_TelefoneKeyDown
              IsFone = True
            end
          end
          object GroupBox2: TGroupBox
            AlignWithMargins = True
            Left = 708
            Top = 0
            Width = 175
            Height = 128
            Margins.Top = 0
            Align = alRight
            Caption = 'Hist'#243'rico de Pedidos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              175
              128)
            object Lb_Nr_Pedidos: TLabel
              Left = 5
              Top = 14
              Width = 70
              Height = 16
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 85
              Top = 13
              Width = 38
              Height = 16
              Caption = #218'ltimo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object E_Nr_Pedidos: TEdit_Setes
              Left = 5
              Top = 30
              Width = 76
              Height = 24
              TabStop = False
              Alignment = taCenter
              CharCase = ecUpperCase
              DragMode = dmAutomatic
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = ''
            end
            object Sb_UltimoPedido: TBitBtn
              Left = 75
              Top = 90
              Width = 97
              Height = 31
              Anchors = [akLeft, akBottom]
              Caption = #218'ltimo Pedido'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnClick = Sb_UltimoPedidoClick
            end
            object E_DataUltimoPedido: TEdit_Setes
              Left = 86
              Top = 30
              Width = 85
              Height = 24
              TabStop = False
              Alignment = taCenter
              CharCase = ecUpperCase
              DragMode = dmAutomatic
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
              Text = ''
            end
            object Sb_AtualizaHistorico: TBitBtn
              Left = 3
              Top = 92
              Width = 68
              Height = 31
              Anchors = [akLeft, akBottom]
              Caption = 'Atualiza'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnClick = Sb_AtualizaHistoricoClick
            end
          end
        end
        object tbs_Balcao: TTabSheet
          Caption = 'Balc'#227'o'
          ImageIndex = 1
          OnShow = tbs_BalcaoShow
          object GroupBox5: TGroupBox
            Left = 0
            Top = 0
            Width = 886
            Height = 131
            Align = alClient
            Caption = 'Dados da Atendimento no Balc'#227'o sem Cadastro do Cliente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object Label5: TLabel
              Left = 7
              Top = 17
              Width = 100
              Height = 16
              Caption = 'Nome do Cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Identifica_balcao: TSpeedButton
              Left = 208
              Top = 63
              Width = 149
              Height = 34
              Caption = 'Identificar Cliente'
              OnClick = Sb_Identifica_balcaoClick
            end
            object E_Cliente_Balcao: TEdit
              Left = 5
              Top = 33
              Width = 352
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnExit = E_Cliente_BalcaoExit
            end
          end
        end
        object tbs_Mesa: TTabSheet
          Caption = 'Mesa'
          ImageIndex = 2
          OnShow = tbs_MesaShow
          object grp_mesa: TGroupBox
            Left = 0
            Top = 0
            Width = 177
            Height = 131
            Align = alLeft
            Caption = 'Dados da Mesa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object Label3: TLabel
              Left = 16
              Top = 26
              Width = 60
              Height = 16
              Caption = 'N'#218'MERO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Identifica_Mesa: TSpeedButton
              Left = 19
              Top = 78
              Width = 149
              Height = 34
              Caption = 'Identificar Cliente'
              OnClick = Sb_Identifica_MesaClick
            end
            object E_NR_Mesa: TEdit
              Left = 17
              Top = 48
              Width = 60
              Height = 24
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object pnl_Mesa: TPanel
            AlignWithMargins = True
            Left = 180
            Top = 8
            Width = 703
            Height = 123
            Margins.Top = 8
            Margins.Bottom = 0
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
          end
        end
      end
      object Rg_Modalidade: TRadioGroup
        AlignWithMargins = True
        Left = 5
        Top = 3
        Width = 110
        Height = 153
        Margins.Left = 5
        Align = alLeft
        Caption = 'Modalidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Entrega'
          'Balc'#227'o'
          'Mesa')
        ParentFont = False
        TabOrder = 1
        OnClick = Rg_ModalidadeClick
      end
    end
  end
  object Pnl_botao: TPanel
    Left = 0
    Top = 582
    Width = 1016
    Height = 70
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SB_Alterar: TSpeedButton
      Left = 159
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_AlterarClick
      ExplicitLeft = 155
      ExplicitTop = 6
      ExplicitHeight = 59
    end
    object SB_Inserir: TSpeedButton
      Left = 64
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Novo - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_InserirClick
      ExplicitLeft = 54
      ExplicitTop = 6
      ExplicitHeight = 59
    end
    object SB_Faturar: TSpeedButton
      Left = 634
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Faturar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_FaturarClick
      ExplicitLeft = 640
      ExplicitTop = 4
    end
    object SB_Cancelar: TSpeedButton
      Left = 444
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 440
      ExplicitTop = 5
      ExplicitHeight = 59
    end
    object SB_Sair_1: TSpeedButton
      Left = 919
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Sair - Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_Sair_1Click
      ExplicitLeft = 915
      ExplicitTop = 5
      ExplicitHeight = 59
    end
    object Sb_Pesquisar: TSpeedButton
      Left = 539
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Pesquisar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_PesquisarClick
      ExplicitLeft = 541
      ExplicitTop = 6
      ExplicitHeight = 59
    end
    object Sb_Imprimir: TSpeedButton
      Left = 824
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Imprimir - F11'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = Sb_ImprimirClick
      ExplicitLeft = 830
      ExplicitTop = 1
    end
    object SB_Entregar: TSpeedButton
      Left = 729
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Entregar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFBFBFBC1C1C0AAA8A7B7B6B5EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFD2D3
        D3D1D2D2EDEDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDE
        DEDE5F5A592E2623362D293B332E534C4AB9B8B7FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD87888B30323B1B1B
        22161820949497FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDED50
        4B4939302A4A4334463F31322A25433934443B37C7C7C7FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F16A6D70262B3423262F181A
        2246474ED5D5D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88868538
        312A615A4269614C6B6552544D393029244B403B5E5A56F9F9F9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF6F6F6FBFBFBCBCCCE25293221242D1719215A5C
        61F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA40393755
        4E3B746B4D7B7975D3D3D3736A4E4C4434382F2B453C37C1C0C0FFFFFFFFFFFF
        FFFFFFFFFFFFDEDEDD817C7A5E5654645C5973706E2E3036272B3421242D7878
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1C0BF362F2857
        503B6865598F8D849C988C6E675167604D342C264D423C93908EFFFFFFFFFFFF
        FFFFFFD7D6D64C4643483F3551483B51473E50443F2B2627252932292D374041
        49F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A2A1453C325C
        574493928ED1CEC3A3A095D5D5D4A8A3953C352B4A3F3A7C7775FFFFFFFFFFFF
        FBFBFB635E5D52493967624CC1BFB98A83743F362D2C252222252D252B372027
        34808387C2C1BEDCDCDCDADADAC1C1BEB8B7B3BFBEBBD6D6D58D8B8B473E3362
        5A457E7B74BCBAB0ABA8A0CECECEA9A3953F362C483D3977736FFFFFFFFFFFFF
        D0CECF372E28605A456C6858CACACA87847755514657554E2A2E352E2B2D422F
        205142337F7D736A685F4A43314640293F392236301A3D39243A372C40383063
        5B43747063A7A59D99958A494538625E4B3A322A4B403A7C7776FFFFFFFFFFFF
        9695943C362F4B49435957526E6B6386837984827775736A473C336A4527834A
        16703F136D624D827F71746F5C83795B82785B61593E413A20352F1C352D285B
        544595948C8E897CECECEC958D765F5741322A254D423D979493FFFFFFD7D7D6
        5D5C545F5E577371698C897F928E868E8B7E68624F3730293C2F23714E308356
        30814A1A6E573470694A78756170694C8C825C8F845F5048263A34162D261D5E
        584F858177767160DEDEDE99917E3C352A362C2A443C38C2C1C1FFFFFFDBDBDA
        86847B7571676965578C8A8386847DFBFAF77E77682C252E352B30785A3E9E77
        549F7145583D3E1614681B1A681B1A5E232052322F5526233E252229231F176B
        67615B544658503B5B574A454031494131564E3B494234B0AFABFFFFFFFFFFFF
        CDCDCC342D28494131ADA59872694D79788D2727531F193E614234876342A078
        559D6F42321F5A0000A000009B00009800009600008A0000800000771D1D666D
        6A5D352C22372F293C342A514A36766D4F908666837E68E7E6E5FFFFFFFFFFFF
        FFFFFF867E793030312F53771F4483121644231D266545277A512E875A35976A
        448C623F130E9E0000B100009700009B00008E00009700008F00007C4F4E8835
        33662E2833524B3370664C857B5C897F619A9381E4E4E2FFFFFFFFFFFFFFFFFF
        FFFFFFB0C5D21B77CD116EF3003ABF141C255D3E1D7C52308A5D388F5F398755
        2D7140133820450100B50000B100008D3530412724540000961F1E788987831C
        1B6F000071413F66938C79A29D8CCECBC4F9F9F9FFFFFFFFFFFFFFFFFFFFFFFF
        EAEDEE2B97D92197FF0E60E0003DBF0C1F444F3622915E348B5A32754B28563D
        28655F595E523E3834581818AE0000A53E385C423C4A0000913C3B82A5A197A3
        9A92666288535283A2A19DF3F3F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        A8C7D41296F8238DFF0E61E0003FC60032900E357D4A3F3E4F3C2B4A4038514B
        497173744D4947524F42A6A5AE6060B5141493010191000096615F84443F5750
        5656736F6F908C94AEACA6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        7CAEC91C95FF238CFE0F64E3003AB5212A3C192D4C1A30534B454158514E574F
        4B72727145403E2726276B6964C5C5B9A7A7B67171A6333477817A7127535F37
        B3C9386877524E63E2E2DFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        6DA4CB2090FF228CFE0F66E710317A433A2F302A232928294C454158504C574F
        4B6E6D6C564E4A4D47443836364141403837308F8D8184857E716B621D83AA6F
        FFFF77D7D04E483F5B5958514E4E979797FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        66A1D02493FF2490FF0F68E7233D7A5248402D2A273F3D3D433E3B524A46574F
        4B6967665A53505A524D554E495E616661676F8A909894999C6C6764357A9753
        E7FF64A9A7453E3A322F2C3A3532A9A9A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        6AA6CA167FE81464CE0647B72136674D433B3634327379844B48484D4541564D
        4965626064605E554D49554C4872757C848D9B474A4F79797CCAC9C9969A9954
        7B856D73716D6A696966639D9A99F8F8F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        B8C2C80337920031A30031A5103076372F2862646A939EAE5556594E4742574F
        4B5D58556C6C6A574E495C534E5E5E6270747851514D8F8F8EFFFFFFFFFFFFF1
        F1F1B0ADAD565856A9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        DEE1E3307ABA1387F71683FF2066C7233C614B74AD888F9B4F4B4A5B524D5850
        4D564B427570685E5147776C64A5A3A2F2F2F2CFCFCFF4F4F4FFFFFFFFFFFFFF
        FFFFB7B7B7555554A3A3A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE8F2F584BED940A2DC298DD81C7ED62678D0515B6768615C6E6764534A
        3E3D41521E4FB0246BC2A5BEDBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFDFDFDDFDFDFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFEFEFEE2E8EAD4E6EED4DEE5E9E9E9F6F6F6F7F7F7747F
        A30142D2005BFF0069EA075CC08E9FB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEDF7254D
        DD1E439E284164101B2900040D01030BAEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D9FDB0016
        5E171307514E41535249302F280B06003F3F3FFEFEFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5A71BA0004
        100000000F080055514557564E3E4D62475A82FEFEFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF617EDE002F
        D000277100357211549D1A72D4087EF1598ACEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBEC8EA033B
        F10064F60081FF007BFF007DFF0096FBB2CFD8FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9DAB
        CE0E6AD5007DFF007EFF027EEC78B4D5FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFDBDFE17EA0C86C9AC5BFD1D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_EntregarClick
      ExplicitLeft = 630
      ExplicitTop = 6
      ExplicitHeight = 59
    end
    object SB_Gravar: TSpeedButton
      Left = 349
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_GravarClick
      ExplicitLeft = 351
      ExplicitTop = 6
      ExplicitHeight = 59
    end
    object SB_Excluir: TSpeedButton
      Left = 254
      Top = 2
      Width = 95
      Height = 66
      Align = alRight
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 250
      ExplicitTop = 5
      ExplicitHeight = 59
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 51
    Top = 169
    object CORTESIA1: TMenuItem
      Caption = 'CORTESIA'
    end
    object IMPRIMIRCOMANDA1: TMenuItem
      Caption = 'IMPRIMIR COMANDA'
    end
  end
  object Qr_Lista_SubGrupo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT MED_CODIGO, MED_DESCRICAO'
      'FROM TB_MEDIDA tb_medida'
      '  INNER JOIN TB_PRECO tb_preco'
      '  ON (tb_preco.PRC_CODMED = tb_medida.MED_CODIGO)'
      '  INNER JOIN TB_PRODUTO tb_produto'
      '  ON (tb_produto.PRO_CODIGO = tb_preco.PRC_CODPRO)'
      '  INNER JOIN TB_SUBGRUPOS tb_subgrupos'
      '  ON (tb_subgrupos.SBG_CODIGO = tb_produto.PRO_CODSBG)'
      'WHERE SBG_ABAS=:SBG_ABAS')
    Left = 56
    Top = 219
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SBG_ABAS'
        ParamType = ptUnknown
      end>
    object Qr_Lista_SubGrupoMED_CODIGO: TIntegerField
      FieldName = 'MED_CODIGO'
      Origin = 'TB_MEDIDA.MED_CODIGO'
      Required = True
    end
    object Qr_Lista_SubGrupoMED_DESCRICAO: TStringField
      FieldName = 'MED_DESCRICAO'
      Origin = 'TB_MEDIDA.MED_DESCRICAO'
    end
  end
  object Qr_Produtos: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CAMPANHA'
      'FROM TB_PRODUTO PRO'
      '   INNER JOIN TB_GRUPOS tb_grupo'
      '   ON (tb_grupo.GRP_CODIGO = PRO.PRO_CODGRP)'
      'WHERE PRO_TIPO = '#39'P'#39' '
      '      AND GRP_DESCRICAO=:GRP_DESCRICAO')
    Left = 431
    Top = 13
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GRP_DESCRICAO'
        ParamType = ptUnknown
      end>
    object Qr_ProdutosPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = 'TB_PRODUTO.PRO_CODIGO'
      Required = True
    end
    object Qr_ProdutosPRO_DESCRICAO: TStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'TB_PRODUTO.PRO_DESCRICAO'
      Size = 100
    end
    object Qr_ProdutosPRO_VALOR: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PRO_VALOR'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object Qr_ProdutosPRO_CAMPANHA: TStringField
      FieldName = 'PRO_CAMPANHA'
      Origin = 'TB_PRODUTO.PRO_CAMPANHA'
      Size = 1
    end
  end
  object Ds_Produtos: TDataSource
    DataSet = Qr_Produtos
    Left = 535
    Top = 77
  end
  object Qr_Itens_RTR: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  ITF_CODIGO,'
      '  ITF_CODPED,'
      '  ITF_CODPRO,'
      '  ITR_NR_ITEM,'
      '  ITR_DESCRICAO,'
      '  ITR_QTDE,'
      '  ITR_VL_UNIT,'
      '  ITF_VL_DESC,'
      '  ITF_ESTOQUE,'
      '  ITR_OBS,'
      '  ITR_CODGRC,'
      '  ITR_CODSBG,'
      '  ITR_CORTESIA'
      'FROM tb_itens_nfl'
      '  INNER JOIN tb_itens_rtr'
      '  ON (ITR_CODITF = ITF_CODIGO)'
      'WHERE ITF_CODPED =:PED_CODIGO'
      'ORDER BY ITR_NR_ITEM,ITR_DESCRICAO, ITF_CODIGO,  ITR_VL_UNIT')
    Left = 490
    Top = 14
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
    object Qr_Itens_RTRITF_CODIGO: TIntegerField
      Tag = -1
      FieldName = 'ITF_CODIGO'
      Origin = 'TB_ITENS_NFL.ITF_CODIGO'
      Required = True
    end
    object Qr_Itens_RTRITF_CODPED: TIntegerField
      Tag = -1
      FieldName = 'ITF_CODPED'
      Origin = 'TB_ITENS_NFL.ITF_CODPED'
    end
    object Qr_Itens_RTRITF_CODPRO: TIntegerField
      Tag = -1
      FieldName = 'ITF_CODPRO'
      Origin = 'TB_ITENS_NFL.ITF_CODPRO'
    end
    object Qr_Itens_RTRITR_NR_ITEM: TIntegerField
      Tag = 30
      DisplayLabel = 'Item'
      FieldName = 'ITR_NR_ITEM'
      Origin = 'TB_ITENS_RTR.ITR_NR_ITEM'
      Required = True
    end
    object Qr_Itens_RTRITR_DESCRICAO: TStringField
      Tag = 150
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'ITR_DESCRICAO'
      Origin = 'TB_ITENS_RTR.ITR_DESCRICAO'
      Size = 100
    end
    object Qr_Itens_RTRITF_QTDE: TBCDField
      Tag = 75
      DisplayLabel = 'Qtde'
      FieldName = 'ITR_QTDE'
      Origin = 'TB_ITENS_NFL.ITF_QTDE'
      Precision = 18
      Size = 3
    end
    object Qr_Itens_RTRITF_VL_UNIT: TFloatField
      Tag = 75
      DisplayLabel = 'Vl.Unit'
      FieldName = 'ITR_VL_UNIT'
      Origin = 'TB_ITENS_NFL.ITF_VL_UNIT'
    end
    object Qr_Itens_RTRITF_VL_DESC: TBCDField
      Tag = -1
      FieldName = 'ITF_VL_DESC'
      Origin = 'TB_ITENS_NFL.ITF_VL_DESC'
      Precision = 18
      Size = 2
    end
    object Qr_Itens_RTRITF_ESTOQUE: TStringField
      Tag = -1
      FieldName = 'ITF_ESTOQUE'
      Origin = 'TB_ITENS_NFL.ITF_ESTOQUE'
      FixedChar = True
      Size = 1
    end
    object Qr_Itens_RTRITR_OBS: TStringField
      Tag = 200
      DisplayLabel = 'Obs'
      FieldName = 'ITR_OBS'
      Origin = 'TB_ITENS_RTR.ITR_OBS'
      Size = 255
    end
    object Qr_Itens_RTRITR_CODGRC: TIntegerField
      Tag = -1
      FieldName = 'ITR_CODGRC'
      Origin = 'TB_ITENS_RTR.ITR_CODGRC'
    end
    object Qr_Itens_RTRITR_CODSBG: TIntegerField
      Tag = -1
      FieldName = 'ITR_CODSBG'
      Origin = 'TB_ITENS_RTR.ITR_CODSBG'
    end
    object Qr_Itens_RTRITR_CORTESIA: TStringField
      Tag = -1
      FieldName = 'ITR_CORTESIA'
      Origin = 'TB_ITENS_RTR.ITR_CORTESIA'
      FixedChar = True
      Size = 1
    end
  end
  object Qr_Prox_Item: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select Max(itr_nr_item) ITR_ULT_ITEM'
      'from tb_itens_rtr'
      '  inner join tb_itens_nfl'
      '  on (ITF_CODIGO = itr_coditf)'
      'where itf_codped =:PED_CODIGO')
    Left = 586
    Top = 22
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end>
  end
  object Mnu_Principal: TMainMenu
    Left = 336
    Top = 208
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object Relatrios1: TMenuItem
        Caption = 'Relat'#243'rios'
        OnClick = Relatrios1Click
      end
      object LanamentosCaixa1: TMenuItem
        Caption = 'Lan'#231'amentos Caixa'
        OnClick = LanamentosCaixa1Click
      end
      object Fechamento1: TMenuItem
        Caption = 'Fechamento'
        OnClick = Fechamento1Click
      end
      object Comisso1: TMenuItem
        Caption = 'Comiss'#227'o'
        OnClick = Comisso1Click
      end
      object NotasFiscais1: TMenuItem
        Caption = 'Pedidos Emitidos'
        OnClick = NotasFiscais1Click
      end
      object PrgoramaPAYBACK1: TMenuItem
        Caption = 'Programa PAYBACK'
        OnClick = PrgoramaPAYBACK1Click
      end
      object PedidosIfood1: TMenuItem
        Caption = 'Pedidos Ifood'
        OnClick = PedidosIfood1Click
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
    object AtualizaoCtrlF51: TMenuItem
      Caption = '| Atualiza'#231#227'o - Ctrl + F5 |'
      ShortCut = 16500
      OnClick = AtualizaoCtrlF51Click
    end
  end
  object pop_Pausa_By_Name: TPopupMenu
    Left = 512
    Top = 216
    object MnuDesativarByName: TMenuItem
      Caption = 'Desativar'
      OnClick = MnuDesativarByNameClick
    end
    object MnuPausarByName: TMenuItem
      Caption = 'Pausar Venda'
      OnClick = MnuPausarByNameClick
    end
    object MnuHabilitarByName: TMenuItem
      Caption = 'Habilitar Venda'
      OnClick = MnuHabilitarByNameClick
    end
  end
  object pop_Pausa_By_Codigo: TPopupMenu
    Left = 512
    Top = 296
    object MnuDesativarByCodigo: TMenuItem
      Caption = 'Desativar'
      OnClick = MnuDesativarByCodigoClick
    end
    object MnuPausaByCodigo: TMenuItem
      Caption = 'Pausar Venda'
      OnClick = MnuPausaByCodigoClick
    end
    object MnuHabilitarByCodigo: TMenuItem
      Caption = 'Habilitar Venda'
      OnClick = MnuHabilitarByCodigoClick
    end
  end
end

inherited Fr_Itens_Produto_Vda: TFr_Itens_Produto_Vda
  Caption = 'Itens de Venda'
  ClientHeight = 632
  ExplicitHeight = 661
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Produtos: TDBGrid
    Top = 332
    Height = 253
  end
  inherited pnl_botao_lista: TPanel
    Top = 588
    ExplicitTop = 588
  end
  inherited Pg_Main: TPageControl
    Height = 329
    ExplicitHeight = 329
    inherited tbs_item: TTabSheet
      ExplicitHeight = 301
      inherited Fm_ListaEstoques: TFm_ListaEstoques
        inherited Sb_Cadastro: TSpeedButton
          ExplicitLeft = 694
          ExplicitHeight = 13
        end
      end
      inherited pnl_dados_items: TPanel
        Height = 184
        ExplicitHeight = 184
        object Sb_last_sales_items: TSpeedButton [16]
          Left = 5
          Top = 146
          Width = 234
          Height = 32
          Caption = #218'ltimas vendas deste item para este Cliente'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
            33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
            FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
            FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
            FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
            FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
            FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
            3333333773FFFF77333333333FBFBF3333333333377777333333}
          NumGlyphs = 2
          OnClick = Sb_last_sales_itemsClick
        end
        object pnl_base_troca: TPanel
          Left = 726
          Top = 132
          Width = 121
          Height = 46
          TabOrder = 16
          Visible = False
          object Chbx_sem_base_troca: TCheckBox
            Left = 1
            Top = 1
            Width = 119
            Height = 18
            Align = alTop
            Caption = 'Sem base de troca'
            TabOrder = 0
          end
          object E_VL_Base_troca: TEdit_Setes
            AlignWithMargins = True
            Left = 4
            Top = 22
            Width = 113
            Height = 20
            Align = alClient
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = ''
            ExplicitHeight = 22
          end
        end
      end
      inherited pnl_rodape: TPanel
        Top = 232
        ExplicitTop = 232
        inherited pnl_estoque: TPanel
          inherited Lb_Tipo: TLabel
            Top = 17
            ExplicitTop = 17
          end
          inherited Lb_CustoUnitario: TLabel
            Top = 17
            ExplicitTop = 17
          end
          inherited Sb_Corte: TSpeedButton
            Top = 4
            ExplicitTop = 4
          end
          inherited E_CustoUnitario: TEdit_Setes
            Top = 36
            ExplicitTop = 36
          end
          inherited E_Qtde_Disp: TPanel
            Top = 36
            ExplicitTop = 36
          end
        end
      end
    end
    inherited tbs_tributacao: TTabSheet
      ExplicitHeight = 301
      inherited pnl_tributacao: TPanel
        Height = 301
        ExplicitHeight = 301
        inherited Label1: TLabel
          Top = 276
          ExplicitTop = 276
        end
        inherited Lb_Tipo_Regra: TLabel
          Top = 250
          ExplicitTop = 250
        end
        inherited LB_cst_csosn: TLabel
          Top = 224
          ExplicitTop = 224
        end
        inherited fm_ListaTributacao: Tfm_ListaTributacao
          Margins.Bottom = 1
        end
        inherited chbx_do_not_set_financeiro: TCheckBox
          Top = 49
          Visible = True
          ExplicitTop = 49
        end
      end
    end
  end
  inherited AcaoMostra: TActionList
    Left = 436
    Top = 80
  end
end

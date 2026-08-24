inherited Fr_Itens_Produto_Dev: TFr_Itens_Produto_Dev
  Caption = 'Itens de Devolu'#231#227'o'
  ClientHeight = 621
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Produtos: TDBGrid
    Height = 290
  end
  inherited pnl_botao_lista: TPanel
    Top = 577
    ExplicitTop = 492
  end
  inherited Pg_Main: TPageControl
    inherited tbs_item: TTabSheet
      ExplicitHeight = 213
      inherited pnl_dados_items: TPanel
        ExplicitHeight = 96
      end
      inherited pnl_rodape: TPanel
        ExplicitTop = 144
        inherited pnl_estoque: TPanel
          inherited Lb_Tipo: TLabel
            Top = 18
            ExplicitTop = 18
          end
          inherited Lb_CustoUnitario: TLabel
            Top = 18
            ExplicitTop = 18
          end
          inherited Sb_Corte: TSpeedButton
            Top = 4
            ExplicitTop = 4
          end
        end
      end
    end
    inherited tbs_tributacao: TTabSheet
      ExplicitHeight = 213
      inherited pnl_tributacao: TPanel
        ExplicitHeight = 213
      end
    end
  end
end

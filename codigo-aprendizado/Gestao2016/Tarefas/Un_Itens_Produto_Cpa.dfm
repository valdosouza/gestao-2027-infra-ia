inherited Fr_Itens_Produto_Cpa: TFr_Itens_Produto_Cpa
  Caption = 'Itens de Compra'
  ClientHeight = 599
  ExplicitHeight = 628
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Produtos: TDBGrid
    Height = 268
  end
  inherited pnl_botao_lista: TPanel
    Top = 555
    ExplicitTop = 555
  end
  inherited Pg_Main: TPageControl
    inherited tbs_item: TTabSheet
      inherited pnl_rodape: TPanel
        inherited pnl_estoque: TPanel
          inherited Lb_Tipo: TLabel
            Top = 18
            ExplicitTop = 18
          end
          inherited Lb_CustoUnitario: TLabel
            Top = 18
            ExplicitTop = 18
          end
        end
      end
    end
  end
end

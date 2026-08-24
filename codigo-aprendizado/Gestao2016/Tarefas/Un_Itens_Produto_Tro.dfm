inherited Fr_Itens_Produto_Tro: TFr_Itens_Produto_Tro
  Caption = 'Itens de Troca'
  ClientHeight = 580
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBG_Produtos: TDBGrid
    Top = 244
    Height = 289
  end
  inherited pnl_botao_lista: TPanel
    Top = 536
    ExplicitTop = 536
  end
  inherited Pg_Main: TPageControl
    Height = 241
    ExplicitHeight = 241
    inherited tbs_item: TTabSheet
      ExplicitHeight = 213
      inherited pnl_dados_items: TPanel
        Height = 96
        ExplicitHeight = 96
      end
      inherited pnl_rodape: TPanel
        Top = 144
        ExplicitTop = 144
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
      ExplicitHeight = 213
      inherited pnl_tributacao: TPanel
        Height = 213
        ExplicitHeight = 213
        inherited Label1: TLabel
          Top = 188
          ExplicitTop = 188
        end
      end
    end
  end
end

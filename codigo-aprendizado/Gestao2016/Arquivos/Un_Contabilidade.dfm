inherited Fr_Contabilidade: TFr_Contabilidade
  Caption = 'Cadastro do Contador'
  ExplicitWidth = 674
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PG_Informacoes: TPageControl
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 656
        ExplicitHeight = 224
        inherited pg_fiscal: TPageControl
          inherited TabSheet6: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 648
            ExplicitHeight = 196
          end
          inherited TabSheet8: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 648
            ExplicitHeight = 196
          end
        end
      end
      inherited Contato: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      inherited tbs_Endereco: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 656
        ExplicitHeight = 224
      end
      inherited TabSheet1: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 656
        ExplicitHeight = 224
        inherited Pnl_Tributacao: TPanel
          inherited ChBx_Ativa: TCheckBox
            Left = 323
            Top = 183
            Visible = False
            ExplicitLeft = 323
            ExplicitTop = 183
          end
          object ChBx_Contador: TCheckBox
            Left = 323
            Top = 200
            Width = 94
            Height = 18
            Caption = 'Contador Ativo'
            TabOrder = 5
          end
        end
      end
    end
  end
  inherited Qr_BuscaEmail: TSTQuery
    Left = 344
  end
end

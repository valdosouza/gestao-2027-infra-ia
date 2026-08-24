inherited Fr_GeraNfe_Ajt: TFr_GeraNfe_Ajt
  Caption = 'Nota Fiscal Eletronica - Ajustes'
  ClientWidth = 592
  ExplicitWidth = 598
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Width = 592
    ExplicitWidth = 592
    inherited tbs_NF_e: TTabSheet
      ExplicitWidth = 584
      inherited Panel4: TPanel
        Width = 584
        ExplicitWidth = 584
      end
      inherited pnl_NF_e: TPanel
        Width = 584
        ExplicitWidth = 584
        inherited Lb_titulo: TLabel
          Width = 580
        end
        inherited MM_Acompanhamento: TMemo
          Width = 580
          ExplicitWidth = 580
        end
        inherited CkBx_Nota_Manual: TCheckBox
          Width = 574
          ExplicitWidth = 574
        end
        inherited ChBx_NF_Referenciada: TCheckBox
          Width = 574
          ExplicitWidth = 574
        end
        inherited ChBx_NF_PreExistente: TCheckBox
          Width = 574
          ExplicitWidth = 574
        end
        inherited ChBx_Otimiza_obs: TCheckBox
          Width = 574
          ExplicitWidth = 574
        end
      end
    end
  end
  inherited Pnl_Validade: TPanel
    Width = 586
    ExplicitWidth = 586
    inherited Pnl_Cert_Expira: TPanel
      Width = 322
      ExplicitWidth = 322
    end
  end
  inherited Qr_Combustivel: TSTQuery
    Left = 332
  end
end

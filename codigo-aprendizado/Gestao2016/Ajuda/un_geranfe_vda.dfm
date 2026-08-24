inherited Fr_GeraNfe_vda: TFr_GeraNfe_vda
  Caption = 'Nota Fiscal Eletronica - Vendas'
  ClientHeight = 627
  ExplicitWidth = 592
  ExplicitHeight = 656
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Height = 599
    ExplicitHeight = 599
    inherited tbs_NF_e: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 578
      ExplicitHeight = 571
      inherited Panel4: TPanel
        Top = 506
        ExplicitTop = 506
        inherited Sb_NF_Conferir: TSpeedButton
          ExplicitLeft = 2
        end
      end
      inherited pnl_NF_e: TPanel
        Height = 506
        ExplicitHeight = 506
        inherited MM_Acompanhamento: TMemo
          Height = 368
          ExplicitHeight = 368
        end
        inherited CkBx_Nota_Manual: TCheckBox
          Top = 389
          ExplicitTop = 389
        end
        inherited ChBx_NF_Referenciada: TCheckBox
          Top = 409
          ExplicitTop = 409
        end
        inherited ChBx_NF_PreExistente: TCheckBox
          Top = 428
          ExplicitTop = 428
        end
        inherited ChBx_Otimiza_obs: TCheckBox
          Top = 447
          ExplicitTop = 447
        end
        object Chbx_boleto: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 485
          Width = 568
          Height = 17
          Margins.Top = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Imprimir e/ou enviar boleto por email'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object Chbx_Duplicata: TCheckBox
          AlignWithMargins = True
          Left = 5
          Top = 466
          Width = 568
          Height = 17
          Margins.Top = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Imprimir Duplicata'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
    end
  end
  inherited Qr_Combustivel: TSTQuery
    Left = 324
    Top = 200
  end
end

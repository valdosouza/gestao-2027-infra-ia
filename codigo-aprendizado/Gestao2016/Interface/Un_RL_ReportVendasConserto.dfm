inherited RL_ReportVendasConserto: TRL_ReportVendasConserto
  Caption = 'RL_ReportVendasConserto'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.012500000000000000
      2970.000000000000000000
      100.012500000000000000
      2100.000000000000000000
      39.687500000000000000
      39.687500000000000000
      0.000000000000000000)
    inherited PageHeader: TQRBand
      Size.Values = (
        410.104166666666700000
        2021.416666666667000000)
      inherited E_Titulo: TQRLabel
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          293.687500000000000000
          1899.708333333333000000)
        FontSize = 10
      end
      inherited Img_Logo: TQRImage
        Size.Values = (
          275.166666666666700000
          18.520833333333330000
          10.583333333333330000
          396.875000000000000000)
      end
      inherited Lb_Cliente: TQRLabel
        Size.Values = (
          44.979166666666670000
          817.562500000000000000
          354.541666666666700000
          740.833333333333400000)
        FontSize = 10
      end
      inherited Lb_Nota: TQRLabel
        Size.Values = (
          44.979166666666670000
          343.958333333333400000
          354.541666666666700000
          187.854166666666700000)
        FontSize = 10
      end
      inherited Lb_Pedido: TQRLabel
        Size.Values = (
          44.979166666666670000
          171.979166666666700000
          354.541666666666700000
          169.333333333333300000)
        FontSize = 10
      end
      inherited Lb_Data: TQRLabel
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          354.541666666666700000
          156.104166666666700000)
        FontSize = 10
      end
      inherited Lb_VL_Venda: TQRLabel
        Size.Values = (
          44.979166666666670000
          1791.229166666667000000
          354.541666666666700000
          219.604166666666700000)
        FontSize = 10
      end
      inherited Lb_Vl_Custo: TQRLabel
        Size.Values = (
          44.979166666666670000
          1566.333333333333000000
          354.541666666666700000
          219.604166666666700000)
        FontSize = 10
      end
      inherited QRLabel22: TQRLabel
        Size.Values = (
          44.979166666666670000
          537.104166666666800000
          354.541666666666700000
          272.520833333333400000)
        FontSize = 9
      end
      inherited Lb_Emp_Nome: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          5.291666666666667000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Doc: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          52.916666666666660000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_End: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          103.187500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_Fones: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          150.812500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_www: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          246.062500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
      inherited Lb_Emp_email: TQRLabel
        Size.Values = (
          44.979166666666670000
          428.625000000000000000
          198.437500000000000000
          1426.104166666667000000)
        FontSize = 9
      end
    end
    inherited Grp_Pedido: TQRGroup
      Size.Values = (
        0.000000000000000000
        2021.416666666667000000)
    end
    inherited DetalheVenda: TQRBand
      Top = 215
      Size.Values = (
        0.000000000000000000
        2021.416666666667000000)
      ExplicitTop = 215
    end
    inherited Ftr_Pedido: TQRBand
      Top = 215
      Size.Values = (
        50.270833333333330000
        2021.416666666667000000)
      ExplicitTop = 215
      inherited E_VL_Custo: TQRLabel
        Size.Values = (
          39.687500000000000000
          1566.333333333333000000
          5.291666666666667000
          219.604166666666700000)
        FontSize = 8
      end
      inherited E_Vl_Venda: TQRLabel
        Size.Values = (
          39.687500000000000000
          1791.229166666667000000
          5.291666666666667000
          219.604166666666700000)
        FontSize = 8
      end
      inherited E_Data: TQRLabel
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          5.291666666666667000
          156.104166666666700000)
        FontSize = 8
      end
      inherited E_Pedido: TQRLabel
        Size.Values = (
          39.687500000000000000
          171.979166666666700000
          5.291666666666667000
          169.333333333333300000)
        FontSize = 8
      end
      inherited E_Nota: TQRLabel
        Size.Values = (
          39.687500000000000000
          343.958333333333400000
          5.291666666666667000
          187.854166666666700000)
        FontSize = 8
      end
      inherited E_Cliente: TQRLabel
        Size.Values = (
          39.687500000000000000
          817.562500000000000000
          5.291666666666667000
          740.833333333333400000)
        FontSize = 8
      end
      inherited E_cnpj: TQRLabel
        Size.Values = (
          44.979166666666670000
          537.104166666666800000
          5.291666666666667000
          272.520833333333400000)
        FontSize = 8
      end
    end
    inherited Grp_Dia: TQRGroup
      Height = 22
      Size.Values = (
        58.208333333333330000
        2021.416666666667000000)
      ExplicitHeight = 22
    end
    inherited Ftr_Dia: TQRBand
      Top = 234
      Height = 19
      Size.Values = (
        50.270833333333330000
        2021.416666666667000000)
      ExplicitTop = 234
      ExplicitHeight = 19
      inherited QRLabel1: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          5.291666666666667000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_SubTotal: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          5.291666666666667000
          264.583333333333300000)
        FontSize = 8
      end
    end
    inherited Sumario: TQRBand
      Top = 253
      Size.Values = (
        420.687500000000000000
        2021.416666666667000000)
      ExplicitTop = 253
      inherited Lb_Vl_Frete: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          156.104166666666700000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Frete: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          156.104166666666700000
          264.583333333333300000)
        FontSize = 8
      end
      inherited QRLabel19: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          301.625000000000000000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Total: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          301.625000000000000000
          264.583333333333300000)
        FontSize = 8
      end
      inherited Lb_Sbt_Vendas: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          13.229166666666670000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Vendas: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          13.229166666666670000
          264.583333333333300000)
        FontSize = 8
      end
      inherited Lb_Vl_Desconto: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          60.854166666666680000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Desconto: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          60.854166666666680000
          264.583333333333300000)
        FontSize = 8
      end
      inherited Lb_Vl_Outras: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          203.729166666666700000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Outras: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          203.729166666666700000
          264.583333333333300000)
        FontSize = 8
      end
      inherited Lb_VL_IPI: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          251.354166666666700000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_IPI: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          251.354166666666700000
          264.583333333333300000)
        FontSize = 8
      end
      inherited Lb_VL_TL_Rec_Bruta: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          349.250000000000000000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_VL_TL_Rec_Bruta: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          349.250000000000000000
          264.583333333333300000)
        FontSize = 8
      end
      inherited QRLabel10: TQRLabel
        Size.Values = (
          44.979166666666670000
          1455.208333333333000000
          108.479166666666700000
          272.520833333333300000)
        FontSize = 10
      end
      inherited E_Vl_TL_ST: TQRLabel
        Size.Values = (
          44.979166666666670000
          1740.958333333333000000
          108.479166666666700000
          264.583333333333300000)
        FontSize = 8
      end
    end
  end
end

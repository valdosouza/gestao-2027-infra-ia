inherited RL_ReportChequeRastrearOrigem: TRL_ReportChequeRastrearOrigem
  Caption = 'RL_ReportChequeRastrearOrigem'
  ClientHeight = 541
  ClientWidth = 880
  ExplicitWidth = 896
  ExplicitHeight = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited Qrpt: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39
      '0'
      '0')
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      70.000000000000000000
      75.000000000000000000
      0.000000000000000000)
    inherited PageHeader: TQRBand
      Size.Values = (
        415.395833333333300000
        1955.270833333333000000)
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
    inherited Grupo1: TQRGroup
      Size.Values = (
        95.250000000000000000
        1955.270833333333000000)
      Expression = 'Qr_Consulta.FIN_CODQTC'
      inherited QRLabel13: TQRLabel
        Size.Values = (
          44.979166666666700000
          7.937500000000000000
          2.645833333333330000
          1314.979166666670000000)
        FontSize = 10
      end
      inherited E_Nome_Cliente: TQRLabel
        Size.Values = (
          44.979166666666670000
          7.937500000000000000
          44.979166666666670000
          1846.791666666667000000)
        FontSize = 10
      end
    end
    inherited Bnd_Financeiro: TQRLoopBand
      Size.Values = (
        58.208333333333330000
        1955.270833333333000000)
      inherited Lb_Pedido: TQRLabel
        Size.Values = (
          44.979166666666670000
          809.625000000000000000
          5.291666666666667000
          169.333333333333300000)
        FontSize = 10
      end
      inherited Lb_Nota: TQRLabel
        Size.Values = (
          44.979166666666670000
          986.895833333333300000
          5.291666666666667000
          187.854166666666700000)
        FontSize = 10
      end
      inherited Lb_Parcela: TQRLabel
        Size.Values = (
          44.979166666666670000
          1182.687500000000000000
          5.291666666666667000
          224.895833333333300000)
        FontSize = 10
      end
      inherited Lb_Valor: TQRLabel
        Size.Values = (
          44.979166666666670000
          1680.104166666667000000
          5.291666666666667000
          209.020833333333300000)
        FontSize = 10
      end
      inherited Lb_Dt_Pagto: TQRLabel
        Size.Values = (
          44.979166666666670000
          1426.104166666667000000
          5.291666666666667000
          238.125000000000000000)
        FontSize = 10
      end
    end
    inherited Bnd_Cheque: TQRLoopBand
      Size.Values = (
        52.916666666666670000
        1955.270833333333000000)
      inherited Lb_Data: TQRLabel
        Size.Values = (
          44.979166666666670000
          240.770833333333300000
          2.645833333333333000
          201.083333333333300000)
        FontSize = 10
      end
      inherited Lb_Emitente: TQRLabel
        Size.Values = (
          44.979166666666670000
          447.145833333333400000
          2.645833333333333000
          756.708333333333400000)
        FontSize = 10
      end
      inherited Lb_Banco: TQRLabel
        Size.Values = (
          44.979166666666670000
          1214.437500000000000000
          2.645833333333333000
          127.000000000000000000)
        FontSize = 10
      end
      inherited Lb_Agencia: TQRLabel
        Size.Values = (
          44.979166666666670000
          1346.729166666667000000
          2.645833333333333000
          140.229166666666700000)
        FontSize = 10
      end
      inherited Lb_Cheque: TQRLabel
        Size.Values = (
          44.979166666666670000
          1486.958333333333000000
          2.645833333333333000
          193.145833333333300000)
        FontSize = 10
      end
      inherited Lb_Chq_Valor: TQRLabel
        Size.Values = (
          44.979166666666670000
          1682.750000000000000000
          2.645833333333333000
          211.666666666666700000)
        FontSize = 10
      end
    end
  end
end

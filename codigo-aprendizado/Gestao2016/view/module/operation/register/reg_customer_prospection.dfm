inherited RegCustomerProspection: TRegCustomerProspection
  Caption = 'Cadastro de Prospec'#231#227'o de Clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PG_Informacoes: TPageControl
      inherited Contato: TTabSheet
        TabVisible = False
      end
      inherited tbs_Endereco: TTabSheet
        inherited Pnl_Endereco: TPanel
          inherited Chbx_Whatsup: TCheckBox
            Left = 414
            Top = 154
            ExplicitLeft = 414
            ExplicitTop = 154
          end
        end
        inherited Pnl_Navegacao: TPanel
          inherited Label32: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 3
            Width = 646
            Margins.Top = 1
            Margins.Bottom = 1
          end
          inherited SB_Ins_Ender: TSpeedButton
            Top = 18
            Height = 23
          end
          inherited Sb_Next_end: TSpeedButton
            Top = 18
            Height = 23
          end
          inherited Sb_Last_end: TSpeedButton
            Top = 18
            Height = 23
          end
          inherited Sb_First_end: TSpeedButton
            Top = 18
            Height = 23
          end
          inherited Sb_Prior_end: TSpeedButton
            Top = 18
            Height = 23
          end
          inherited Sb_Exc_Ender: TSpeedButton
            Top = 18
            Height = 23
          end
        end
      end
      inherited TabSheet1: TTabSheet
        TabVisible = False
      end
    end
  end
  inherited Pnl_Cliente: TPanel
    inherited Label2: TLabel
      Left = 691
      ExplicitLeft = 691
    end
    inherited Label3: TLabel
      Left = 696
      Top = 48
      ExplicitLeft = 696
      ExplicitTop = 48
    end
    inherited Lb_IncEstadual: TLabel
      Left = 832
      ExplicitLeft = 832
    end
    inherited Lb_IncMunicipal: TLabel
      Left = 984
      ExplicitLeft = 984
    end
    inherited Sb_CNPJ: TSpeedButton
      Left = 806
      ExplicitLeft = 806
    end
    inherited E_Insc_Est: TEdit
      Left = 835
      TabStop = False
      ExplicitLeft = 835
    end
    inherited CB_TpPessoa: TComboBox
      Left = 693
      Top = 63
      TabStop = False
      ExplicitLeft = 693
      ExplicitTop = 63
    end
    inherited E_Data: TDateTimePicker
      Width = 86
      ExplicitWidth = 86
    end
    inherited E_Insc_Mun: TEdit
      Left = 985
      TabStop = False
      ExplicitLeft = 985
    end
    inherited E_CpfCnpj: TMaskEdit
      Left = 693
      TabStop = False
      ExplicitLeft = 693
    end
  end
  inherited Menu: TMainMenu
    Left = 34
    Top = 409
  end
  inherited Qr_BuscaFone: TSTQuery
    Left = 88
    Top = 408
  end
  inherited Qr_BuscaEmail: TSTQuery
    Left = 160
    Top = 408
  end
  inherited Qr_Contato: TSTQuery
    Left = 245
    Top = 411
  end
  inherited Qr_Endereco: TSTQuery
    Left = 309
    Top = 411
  end
end

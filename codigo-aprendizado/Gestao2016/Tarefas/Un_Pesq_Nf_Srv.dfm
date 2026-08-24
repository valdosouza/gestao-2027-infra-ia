inherited Fr_Pesq_NF_Srv: TFr_Pesq_NF_Srv
  Caption = 'Pesquisar Notas Fiscal de Servi'#231'o Eletr'#244'nica'
  ClientWidth = 926
  ExplicitWidth = 942
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 926
    ExplicitWidth = 926
    inherited Label37: TLabel
      Left = 267
      Width = 60
      Caption = 'N'#250'mero RPS'
      ExplicitLeft = 267
      ExplicitWidth = 60
    end
    inherited L_CodigoCliente: TLabel
      Left = 394
      ExplicitLeft = 394
    end
    inherited Label1: TLabel
      Left = 232
      ExplicitLeft = 232
    end
    object Label3: TLabel [11]
      Left = 333
      Top = 17
      Width = 32
      Height = 14
      Caption = 'Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inherited E_BuscaRazao: TMaskEdit
      Left = 472
      Width = 449
      ExplicitLeft = 472
      ExplicitWidth = 449
    end
    inherited E_BuscaNota: TMaskEdit
      Width = 64
      ExplicitWidth = 64
    end
    inherited E_BuscaPedido: TMaskEdit
      Left = 332
      Width = 62
      ExplicitLeft = 332
      ExplicitWidth = 62
    end
    inherited E_BuscaEmpresa: TEdit
      Left = 394
      ExplicitLeft = 394
    end
    inherited ChBx_Nome: TCheckBox
      Left = 472
      ExplicitLeft = 472
    end
    inherited ChBx_Fantasia: TCheckBox
      Left = 596
      Top = 16
      TabOrder = 18
      ExplicitLeft = 596
      ExplicitTop = 16
    end
    inherited Rg_Sit_Nfe: TRadioGroup
      TabOrder = 22
    end
    inherited E_BuscaSerie: TMaskEdit
      Left = 232
      TabOrder = 17
      ExplicitLeft = 232
    end
    inherited ChBx_Venda_Numerada: TCheckBox
      Left = 3
      Top = 175
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 175
    end
    object E_BuscaRPS: TMaskEdit
      Left = 265
      Top = 32
      Width = 66
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
  end
  inherited Panel4: TPanel
    Width = 926
    ExplicitWidth = 926
    inherited Panel1: TPanel
      Left = 824
      ExplicitLeft = 824
      inherited SB_Buscar: TSpeedButton
        ExplicitLeft = 870
        ExplicitTop = 280
      end
      inherited SB_Visualizar: TSpeedButton
        ExplicitLeft = 2
        ExplicitTop = 310
      end
      inherited Lb_TotalVendas: TLabel
        ExplicitLeft = 870
        ExplicitTop = 4
        ExplicitWidth = 92
      end
      inherited E_TotalVenda: TLabel
        ExplicitLeft = 870
        ExplicitTop = 19
        ExplicitWidth = 92
      end
      inherited Lb_NumeroVendas: TLabel
        ExplicitLeft = 870
        ExplicitTop = 40
      end
      inherited E_NumeroVendas: TLabel
        ExplicitLeft = 870
        ExplicitTop = 55
        ExplicitWidth = 92
      end
      inherited Lb_TicketMedia: TLabel
        ExplicitLeft = 870
        ExplicitTop = 75
        ExplicitWidth = 92
      end
      inherited E_TicketMedia: TLabel
        ExplicitLeft = 870
        ExplicitTop = 90
        ExplicitWidth = 92
      end
    end
    inherited Pg_Resultado: TPageControl
      Width = 822
      ActivePage = tbs_resultado
      ExplicitWidth = 822
      inherited tbs_resultado: TTabSheet
        ExplicitWidth = 814
        inherited DBG_Pesquisa: TDBGrid
          Width = 814
        end
      end
      inherited tbs_resumo: TTabSheet
        ExplicitWidth = 814
      end
    end
  end
  inherited Fm_LME: TFm_ListaMultiEmpresa
    Width = 926
    ExplicitWidth = 926
    inherited pnl_linha_1: TPanel
      Width = 926
      ExplicitWidth = 926
      inherited Sb_open: TSpeedButton
        Left = 902
        ExplicitLeft = 944
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 902
        ExplicitWidth = 902
      end
    end
    inherited pnl_top: TPanel
      Width = 926
      ExplicitWidth = 926
      inherited L_name_list: TLabel
        Width = 903
      end
    end
  end
end

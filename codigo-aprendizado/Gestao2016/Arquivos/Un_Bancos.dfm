inherited Fr_Bancos: TFr_Bancos
  Caption = 'Cadastro de Bancos'
  ClientWidth = 666
  ExplicitWidth = 672
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 666
    ExplicitWidth = 666
    inherited PG_Informacoes: TPageControl
      Width = 662
      ExplicitWidth = 662
      inherited TabSheet3: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 654
        ExplicitHeight = 224
        inherited pg_fiscal: TPageControl
          Width = 654
          ActivePage = TabSheet6
          ExplicitWidth = 654
          inherited TabSheet6: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 646
            ExplicitHeight = 196
            inherited Pnl_Observacao: TPanel
              Width = 646
              ExplicitWidth = 646
              inherited obs_Geral: TMemo
                Width = 642
                ExplicitWidth = 642
              end
            end
          end
          inherited TabSheet8: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 24
            ExplicitWidth = 646
            ExplicitHeight = 196
            inherited Obs_Fiscal: TMemo
              Width = 646
              ExplicitWidth = 646
            end
          end
        end
      end
      inherited Contato: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 654
        ExplicitHeight = 0
        inherited Pnl_Contato: TPanel
          Width = 654
          ExplicitWidth = 654
          inherited DBG_Socios: TDBGrid
            Width = 650
          end
        end
      end
      inherited tbs_Endereco: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 654
        ExplicitHeight = 224
        inherited Pnl_Endereco: TPanel
          Width = 654
          ExplicitWidth = 654
        end
        inherited Pnl_Navegacao: TPanel
          Width = 654
          ExplicitWidth = 654
          inherited Label32: TLabel
            Left = 527
            ExplicitLeft = 527
          end
          inherited SB_Ins_Ender: TSpeedButton
            Left = 572
            ExplicitLeft = 569
            ExplicitTop = 16
          end
          inherited Sb_Next_end: TSpeedButton
            Left = 472
            ExplicitLeft = 466
          end
          inherited Sb_Last_end: TSpeedButton
            Left = 522
            ExplicitLeft = 522
            ExplicitTop = 16
          end
          inherited Sb_First_end: TSpeedButton
            Left = 447
            ExplicitLeft = 441
            ExplicitTop = 16
          end
          inherited Sb_Prior_end: TSpeedButton
            Left = 497
            ExplicitLeft = 492
            ExplicitTop = 16
          end
          inherited Sb_Exc_Ender: TSpeedButton
            Left = 547
            ExplicitLeft = 543
            ExplicitTop = 16
          end
        end
      end
      inherited TabSheet1: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 27
        ExplicitWidth = 654
        ExplicitHeight = 224
        inherited Pnl_Tributacao: TPanel
          Width = 422
          ExplicitWidth = 422
          inherited Label58: TLabel
            Width = 412
          end
          inherited Cb_Ind_IE_Dest: TComboBox
            Width = 412
            ExplicitWidth = 412
          end
          inherited ChBx_Consumidor: TCheckBox
            Width = 412
            ExplicitWidth = 412
          end
          inherited ChBx_MicroEmpresa: TCheckBox
            Width = 412
            ExplicitWidth = 412
          end
          inherited Chbx_IgnoraST: TCheckBox
            Width = 412
            ExplicitWidth = 412
          end
        end
        inherited pnl_regra_tributacao: TPanel
          Left = 422
          ExplicitLeft = 422
        end
      end
    end
  end
  inherited Panel1: TPanel
    Width = 666
    ExplicitWidth = 666
  end
  inherited Pnl_Cliente: TPanel
    Width = 666
    ExplicitWidth = 666
    inherited Label2: TLabel
      Left = 374
      Top = 6
      Width = 33
      Caption = 'C.N.P.J'
      Visible = False
      ExplicitLeft = 374
      ExplicitTop = 6
      ExplicitWidth = 33
    end
    inherited Label3: TLabel
      Left = 292
      Top = 6
      Visible = False
      ExplicitLeft = 292
      ExplicitTop = 6
    end
    inherited Lb_IncEstadual: TLabel
      Left = 696
      Top = 4
      Visible = False
      ExplicitLeft = 696
      ExplicitTop = 4
    end
    inherited Lb_IncMunicipal: TLabel
      Left = 696
      Top = 48
      Visible = False
      ExplicitLeft = 696
      ExplicitTop = 48
    end
    inherited Sb_CNPJ: TSpeedButton
      Left = 495
      Visible = False
      ExplicitLeft = 495
    end
    object Label4: TLabel [14]
      Left = 156
      Top = 5
      Width = 86
      Height = 14
      Caption = 'N'#250'mero do Banco'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    inherited E_Nome: TEdit
      TabOrder = 4
    end
    inherited E_Fantasia: TEdit
      TabOrder = 5
    end
    inherited E_Insc_Est: TEdit
      Left = 696
      Top = 20
      TabStop = False
      TabOrder = 10
      Visible = False
      ExplicitLeft = 696
      ExplicitTop = 20
    end
    inherited CB_TpPessoa: TComboBox
      Left = 289
      Top = 21
      ItemIndex = 1
      TabOrder = 11
      Text = 'JUR'#205'DICA'
      Visible = False
      ExplicitLeft = 289
      ExplicitTop = 21
    end
    inherited E_Email: TEdit
      TabOrder = 8
    end
    inherited E_Site: TEdit
      TabOrder = 9
    end
    inherited E_Fundacao: TMaskEdit
      TabOrder = 7
    end
    inherited E_Data: TDateTimePicker
      Width = 95
      ExplicitWidth = 95
    end
    inherited E_Insc_Mun: TEdit
      Left = 695
      Top = 63
      TabStop = False
      TabOrder = 13
      Visible = False
      ExplicitLeft = 695
      ExplicitTop = 63
    end
    inherited Dblcb_Ramo_Atividade: TDBLookupComboBox
      TabOrder = 6
    end
    inherited E_CpfCnpj: TMaskEdit
      Left = 372
      Width = 117
      TabStop = False
      TabOrder = 2
      Visible = False
      ExplicitLeft = 372
      ExplicitWidth = 117
    end
    object E_Nr_Banco: TEdit
      Left = 154
      Top = 20
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  inherited Qr_BuscaFone: TSTQuery
    Left = 232
    Top = 80
  end
end

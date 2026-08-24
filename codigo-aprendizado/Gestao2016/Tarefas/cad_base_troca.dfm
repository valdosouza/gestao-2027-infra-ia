inherited CadBaseTroca: TCadBaseTroca
  Caption = 'Editar dados da Base de troca'
  ClientHeight = 358
  ClientWidth = 776
  ExplicitWidth = 782
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 294
    Width = 776
    ExplicitTop = 294
    ExplicitWidth = 776
    inherited SB_Inserir: TSpeedButton
      Left = 149
      Visible = False
      ExplicitLeft = 29
    end
    inherited SB_Alterar: TSpeedButton
      Left = 253
      Visible = False
      ExplicitLeft = 125
    end
    inherited SB_Excluir: TSpeedButton
      Left = 357
      Visible = False
      ExplicitLeft = 233
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 565
      ExplicitLeft = 437
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 669
      Visible = False
      ExplicitLeft = 541
    end
    inherited SB_Gravar: TSpeedButton
      Left = 461
      ExplicitLeft = 335
    end
  end
  inherited pnl_fundo: TPanel
    Width = 776
    Height = 294
    ExplicitWidth = 776
    ExplicitHeight = 294
    object Label4: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 176
      Width = 766
      Height = 14
      Align = alBottom
      Caption = 'Observa'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 66
    end
    inline Fm_ListaProdutos: TFm_ListaProdutos
      Left = 2
      Top = 2
      Width = 772
      Height = 43
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 772
      inherited Sb_Produto: TSpeedButton
        Left = 741
        Enabled = False
        ExplicitLeft = 609
      end
      inherited E_Cd_Produto: TMaskEdit
        ReadOnly = True
      end
      inherited E_Busca_Produto: TEdit
        Width = 635
        ReadOnly = True
        ExplicitWidth = 635
      end
    end
    inline Fm_ListaEmpresas: TFm_ListaEmpresas
      Left = 2
      Top = 45
      Width = 772
      Height = 43
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 2
      ExplicitTop = 45
      ExplicitWidth = 772
      ExplicitHeight = 43
      inherited pnl_01: TPanel
        Width = 772
        ExplicitWidth = 772
        inherited ChBx_Nome: TCheckBox
          Top = -2
          ExplicitTop = -2
        end
        inherited ChBx_Fantasia: TCheckBox
          Top = -2
          ExplicitLeft = 198
          ExplicitTop = -2
        end
      end
      inherited pnl_02: TPanel
        Width = 772
        inherited Sb_Pesq_Empresa: TSpeedButton
          Left = 744
          Enabled = False
          ExplicitLeft = 543
          ExplicitHeight = 20
        end
        inherited SB_Empresas: TSpeedButton
          Left = 719
          Enabled = False
          ExplicitLeft = 518
          ExplicitHeight = 20
        end
        inherited E_Cd_Empresa: TMaskEdit
          ReadOnly = True
          ExplicitHeight = 20
        end
        inherited DBLCB_Empresa: TDBLookupComboBox
          Width = 651
          ReadOnly = True
          ExplicitWidth = 643
        end
      end
    end
    inline Fm_ListaVendedores: TFm_ListaColaboradores
      AlignWithMargins = True
      Left = 5
      Top = 91
      Width = 766
      Height = 36
      Align = alTop
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 91
      ExplicitWidth = 766
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 766
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 740
        Height = 19
        Enabled = False
        ExplicitLeft = 285
        ExplicitHeight = 17
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 737
        ReadOnly = True
        ExplicitWidth = 737
      end
    end
    object E_Obs: TMemo
      Left = 2
      Top = 193
      Width = 772
      Height = 99
      Align = alBottom
      TabOrder = 4
    end
    object Panel1: TPanel
      Left = 2
      Top = 130
      Width = 772
      Height = 43
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 1
        Width = 62
        Height = 14
        Caption = 'Data Entrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 103
        Top = 1
        Width = 64
        Height = 14
        Caption = 'Peso Entrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 285
        Top = 1
        Width = 54
        Height = 14
        Caption = 'Peso Sa'#237'da'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 381
        Top = 1
        Width = 54
        Height = 14
        Caption = 'Peso Saldo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 477
        Top = 1
        Width = 59
        Height = 14
        Caption = 'Valor Venda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 564
        Top = 1
        Width = 56
        Height = 14
        Caption = 'Valor Troca'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 191
        Top = 1
        Width = 52
        Height = 14
        Caption = 'Data Saida'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Data_Entrada: TDateTimePicker
        Left = 5
        Top = 16
        Width = 92
        Height = 21
        Date = 39488.445386284720000000
        Time = 39488.445386284720000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Peso_Entrada: TEdit_Setes
        Left = 101
        Top = 16
        Width = 81
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
        Text = ''
        OnExit = E_Peso_EntradaExit
      end
      object E_Peso_Saida: TEdit_Setes
        Left = 285
        Top = 16
        Width = 92
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 3
        Text = ''
      end
      object E_Peso_Saldo: TEdit_Setes
        Left = 381
        Top = 16
        Width = 88
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 4
        Text = ''
      end
      object E_Vl_Venda: TEdit_Setes
        Left = 475
        Top = 16
        Width = 81
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 5
        Text = ''
      end
      object E_VL_Troca: TEdit_Setes
        Left = 562
        Top = 16
        Width = 81
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 6
        Text = ''
      end
      object E_Data_Saida: TEdit_Setes
        Left = 185
        Top = 16
        Width = 97
        Height = 21
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 2
        Text = ''
      end
    end
  end
end

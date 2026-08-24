object Fr_Fatura_Vda: TFr_Fatura_Vda
  Left = 339
  Top = 90
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Faturamento'
  ClientHeight = 543
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object E_M_Nota: TMemo
    Left = 680
    Top = 4
    Width = 465
    Height = 145
    TabOrder = 0
  end
  object E_M_Fisco: TMemo
    Left = 680
    Top = 156
    Width = 465
    Height = 145
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 0
    Top = 296
    Width = 679
    Height = 180
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Pg_Resumo: TPageControl
      Left = 2
      Top = 2
      Width = 675
      Height = 176
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Dados da Nota'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 148
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            667
            148)
          object Label22: TLabel
            Left = 6
            Top = 3
            Width = 105
            Height = 14
            Caption = 'Base C'#225'lculo do ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 141
            Top = 3
            Width = 67
            Height = 14
            Caption = 'Valor do ICMS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 271
            Top = 3
            Width = 124
            Height = 14
            Caption = 'Base C'#225'lculo ICMS Subst.'
            FocusControl = E_Vl_Bs_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 403
            Top = 3
            Width = 114
            Height = 14
            Caption = 'Valor ICMS Substitui'#231#227'o'
            FocusControl = E_Vl_Icms_St
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 7
            Top = 39
            Width = 68
            Height = 14
            Caption = 'Valor do Frete'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 140
            Top = 39
            Width = 78
            Height = 14
            Caption = 'Valor do Seguro'
            FocusControl = E_Vl_Seguro
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 271
            Top = 39
            Width = 84
            Height = 14
            Caption = 'Outras despesas'
            FocusControl = E_Vl_Outras
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 403
            Top = 39
            Width = 53
            Height = 14
            Caption = 'Valor do IPI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 536
            Top = 3
            Width = 117
            Height = 14
            Caption = 'Valor Total dos Produtos'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label33: TLabel
            Left = 536
            Top = 39
            Width = 111
            Height = 14
            Caption = 'Valor Total dos Servi'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 536
            Top = 110
            Width = 90
            Height = 14
            Caption = 'Valor Total da Nota'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label34: TLabel
            Left = 5
            Top = 74
            Width = 55
            Height = 14
            Caption = 'Quantidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 246
            Top = 74
            Width = 94
            Height = 14
            Caption = 'Peso Bruto (em Kg)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label36: TLabel
            Left = 354
            Top = 74
            Width = 102
            Height = 14
            Caption = 'Peso L'#237'quido (em Kg)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label38: TLabel
            Left = 141
            Top = 74
            Width = 38
            Height = 14
            Caption = 'Especie'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 465
            Top = 74
            Width = 64
            Height = 14
            Caption = 'Placa Ve'#237'culo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 542
            Top = 74
            Width = 13
            Height = 14
            Caption = 'UF'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 595
            Top = 74
            Width = 27
            Height = 14
            Caption = 'RNTC'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 7
            Top = 110
            Width = 30
            Height = 14
            Caption = 'Marca'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 143
            Top = 110
            Width = 90
            Height = 14
            Caption = 'N'#250'mero do Volume'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label39: TLabel
            Left = 273
            Top = 110
            Width = 100
            Height = 14
            Caption = 'Desconto Concedido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object E_Vl_Bs_Icms_St: TEdit_Setes
            Left = 268
            Top = 17
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = ''
          end
          object E_Vl_Icms_St: TEdit_Setes
            Left = 401
            Top = 17
            Width = 130
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object E_Vl_Seguro: TEdit_Setes
            Left = 138
            Top = 52
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            Text = ''
          end
          object E_Vl_Outras: TEdit_Setes
            Left = 269
            Top = 52
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            Text = ''
          end
          object E_VL_Produto: TPanel
            Left = 535
            Top = 17
            Width = 127
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
          end
          object E_VL_ICMS: TEdit_Setes
            Left = 138
            Top = 17
            Width = 129
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '0,00'
          end
          object E_VL_Bs_ICMS: TEdit_Setes
            Left = 6
            Top = 17
            Width = 130
            Height = 22
            Alignment = taRightJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,00'
          end
          object E_VL_IPI: TEdit_Setes
            Left = 401
            Top = 52
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 8
            Text = '0,00'
          end
          object E_VL_Frete: TEdit_Setes
            Left = 6
            Top = 52
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 5
            Text = '0,00'
          end
          object E_VL_Servico: TPanel
            Left = 535
            Top = 52
            Width = 125
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 9
          end
          object E_VL_Nota: TPanel
            Left = 535
            Top = 123
            Width = 127
            Height = 22
            Alignment = taRightJustify
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clLime
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 19
          end
          object E_Qt_Produto: TEdit_Setes
            Left = 6
            Top = 88
            Width = 130
            Height = 21
            Alignment = taRightJustify
            TabOrder = 10
            Text = '0,00'
            OnChange = E_Qt_ProdutoChange
          end
          object E_Especie: TEdit
            Left = 138
            Top = 88
            Width = 104
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 11
          end
          object E_PesoLiq: TEdit_Setes
            Left = 352
            Top = 88
            Width = 108
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 13
            Text = ''
          end
          object E_PesoBruto: TEdit_Setes
            Left = 244
            Top = 88
            Width = 105
            Height = 21
            Alignment = taRightJustify
            Enabled = False
            TabOrder = 12
            Text = ''
          end
          object E_PlacaVeiculo: TMaskEdit
            Left = 463
            Top = 88
            Width = 72
            Height = 21
            TabOrder = 14
            Text = ''
          end
          object E_RNTC: TEdit
            Left = 592
            Top = 88
            Width = 70
            Height = 21
            TabOrder = 16
          end
          object E_Marca: TEdit
            Left = 6
            Top = 123
            Width = 130
            Height = 21
            Enabled = False
            MaxLength = 10
            TabOrder = 17
          end
          object E_vol_Numero: TEdit
            Left = 138
            Top = 123
            Width = 129
            Height = 21
            Enabled = False
            MaxLength = 8
            TabOrder = 18
          end
          object E_Vl_desconto: TPanel
            Left = 269
            Top = 122
            Width = 126
            Height = 22
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Caption = '0,00'
            Color = clRed
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 20
          end
          object E_Uf_Veiculo: TDBLookupComboBox
            Left = 539
            Top = 88
            Width = 51
            Height = 21
            KeyField = 'UFE_CODIGO'
            ListField = 'UFE_SIGLA'
            ListSource = DM.Ds_UF
            TabOrder = 15
          end
        end
      end
      object Tbs_TpFaturamento: TTabSheet
        Caption = 'Tipo de Faturamento'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 148
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Rg_Faturamento: TRadioGroup
            Left = 2
            Top = 2
            Width = 663
            Height = 49
            Align = alTop
            Caption = ' Tipo Faturamento '
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Faturamento Normal'
              'Faturamento Representa'#231#227'o Indireta'
              'Faturamento Representa'#231#227'o Direta')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Etiqueta de Endere'#231'amento'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 148
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object GroupBox14: TGroupBox
            Left = 6
            Top = 3
            Width = 300
            Height = 46
            Caption = 'Porta P/ Modelos Draft / Saltos Ap'#243's Impress'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object E_PortaImpressao_dsp: TEdit
              Left = 7
              Top = 19
              Width = 227
              Height = 21
              TabOrder = 0
            end
            object E_SaltoImpressao_dsp: TEdit_Setes
              Left = 237
              Top = 19
              Width = 52
              Height = 21
              Alignment = taRightJustify
              TabOrder = 1
              Text = ''
            end
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 679
    Height = 296
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 5
      Top = 3
      Width = 173
      Height = 65
      Caption = ' Datas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label6: TLabel
        Left = 10
        Top = 19
        Width = 40
        Height = 14
        Caption = 'Emiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Dt_Saida: TDateTimePicker
        Left = 86
        Top = 35
        Width = 78
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object E_Dt_Emissao: TDateTimePicker
        Left = 6
        Top = 35
        Width = 78
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object chbx_data_saida: TCheckBox
        Left = 88
        Top = 19
        Width = 76
        Height = 17
        Caption = 'Sa'#237'da'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
        OnClick = chbx_data_saidaClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 69
      Width = 449
      Height = 97
      Caption = 'Informa'#231#245'es sobre o Transporte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Sb_Transportadora: TSpeedButton
        Left = 395
        Top = 29
        Width = 25
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = Sb_TransportadoraClick
      end
      object Label2: TLabel
        Left = 7
        Top = 14
        Width = 114
        Height = 14
        Caption = 'Nome da Transportador'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 7
        Top = 53
        Width = 97
        Height = 14
        Caption = 'Modalidade do Frete'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Pesq_Transportadora: TSpeedButton
        Left = 420
        Top = 29
        Width = 23
        Height = 22
        Glyph.Data = {
          E6010000424DE60100000000000036000000280000000C0000000C0000000100
          180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
          79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
          177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
          FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
          A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
          FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
          D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
          C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
          FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
          E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF}
        OnClick = Sb_Pesq_TransportadoraClick
      end
      object DBLCB_Transportadora: TDBLookupComboBox
        Left = 6
        Top = 30
        Width = 389
        Height = 21
        KeyField = 'EMP_CODIGO'
        ListField = 'EMP_FANTASIA'
        ListSource = DM_ListaConsultas.Ds_ListaTransportadora
        TabOrder = 0
        OnKeyDown = DBLCB_TransportadoraKeyDown
      end
      object Dblcb_Modal_Frete: TDBLookupComboBox
        Left = 6
        Top = 68
        Width = 435
        Height = 21
        KeyField = 'MDF_GRUPO'
        ListField = 'DESCRICAO'
        ListSource = Ds_Moral_Frete
        TabOrder = 1
        OnKeyDown = DBLCB_TransportadoraKeyDown
      end
    end
    object Panel3: TPanel
      Left = 459
      Top = 4
      Width = 218
      Height = 288
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 144
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'Outros Par'#226'metros'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object ChBx_AutorizacaoNFE: TCheckBox
        Left = 5
        Top = 25
        Width = 145
        Height = 17
        Caption = 'Solicitar autoriza'#231#227'o NF-e'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Chbx_ICMS: TCheckBox
        Left = 5
        Top = 41
        Width = 204
        Height = 17
        Caption = 'Somar o ICMS ao Valor Total da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Chbx_SomaIPI_Bs_ICMS: TCheckBox
        Left = 6
        Top = 56
        Width = 185
        Height = 17
        Caption = 'Somar o IPI na Base de ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object Chbx_SomaIPI_Bs_ICMS_St: TCheckBox
        Left = 7
        Top = 72
        Width = 189
        Height = 17
        Caption = 'Somar o IPI na Base de ICMS Subst. Trib.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object chbx_Mva_Original: TCheckBox
        Left = 7
        Top = 87
        Width = 189
        Height = 17
        Caption = 'Usar o Mva Original'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object ChBx_ListaNcm: TCheckBox
        Left = 8
        Top = 103
        Width = 203
        Height = 17
        Caption = 'Validar lista de NCM para c'#225'lculo S.T'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object Pg_OBs: TPageControl
      Left = 0
      Top = 165
      Width = 453
      Height = 127
      ActivePage = Tbs_Obs_Produto
      Style = tsFlatButtons
      TabOrder = 3
      object Tbs_Obs_Produto: TTabSheet
        Caption = 'Observa'#231#245'es Nota Produto'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object E_Obs: TMemo
          Left = 0
          Top = 0
          Width = 445
          Height = 96
          Align = alClient
          TabOrder = 0
        end
      end
      object Tbs_Obs_Servico: TTabSheet
        Caption = 'Observa'#231#245'es Nota Servi'#231'o'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object E_Obs_Servico: TMemo
          Left = 0
          Top = 0
          Width = 445
          Height = 96
          Align = alClient
          TabOrder = 0
        end
      end
    end
  end
  object pnl_botao: TPanel
    Left = 0
    Top = 476
    Width = 679
    Height = 67
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object SB_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 489
      Top = 5
      Width = 90
      Height = 57
      Align = alRight
      Caption = 'Confirmar - F10'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ConfirmarClick
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 585
      Top = 5
      Width = 89
      Height = 57
      Align = alRight
      Caption = 'Fechar - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 520
    Top = 136
  end
  object Qr_Orcamento: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CTC_NUMERO, CTC_DATA'
      'FROM TB_COTACAO'
      'WHERE CTC_CODPED=:CTC_CODPED')
    Left = 137
    Top = 187
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CTC_CODPED'
        ParamType = ptUnknown
      end>
  end
  object Ds_Moral_Frete: TDataSource
    DataSet = DM.Qr_Modal_Frete
    Left = 358
    Top = 21
  end
  object AcaoMostra: TActionList
    Left = 292
    Top = 168
    object Action1: TAction
      Caption = 'Inclus'#227'o de Itens de Produto'
      ShortCut = 16496
      OnExecute = Action1Execute
    end
  end
end

object Fr_Fatura_Ajt: TFr_Fatura_Ajt
  Left = 298
  Top = 164
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros de Gera'#231#227'o de Notas Fiscais - Ajuste de Estoque'
  ClientHeight = 585
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 367
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label9: TLabel
      Left = 7
      Top = 224
      Width = 100
      Height = 14
      Caption = 'Observa'#231#227'o da Nota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 3
      Width = 173
      Height = 64
      Caption = 'Datas '
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
      object E_Dt_Emissao: TDateTimePicker
        Left = 6
        Top = 35
        Width = 78
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 0
      end
      object E_Dt_Saida: TDateTimePicker
        Left = 87
        Top = 35
        Width = 79
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 1
      end
      object chbx_data_saida: TCheckBox
        Left = 89
        Top = 19
        Width = 54
        Height = 13
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
      end
    end
    object E_Obs: TMemo
      Left = 4
      Top = 239
      Width = 447
      Height = 122
      TabOrder = 1
    end
    object RG_Tipo_S_E: TRadioGroup
      Left = 182
      Top = 3
      Width = 120
      Height = 64
      Caption = 'Tipo da Opera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Sa'#237'da'
        'Entrada')
      ParentFont = False
      TabOrder = 2
      OnClick = RG_Tipo_S_EClick
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 126
      Width = 449
      Height = 97
      Caption = 'Informa'#231#245'es sobre o Transporte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object Label7: TLabel
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
      object Label33: TLabel
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
      object Sb_Pesq_Cliente: TSpeedButton
        Left = 422
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
        OnClick = Sb_Pesq_ClienteClick
      end
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
      object DBLCB_Transportadora: TDBLookupComboBox
        Left = 6
        Top = 30
        Width = 386
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
    object GroupBox4: TGroupBox
      Left = 303
      Top = 3
      Width = 209
      Height = 64
      Caption = 'Controle de Retorno das Notas Fiscais'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ChBx_Retorno: TCheckBox
        Left = 5
        Top = 18
        Width = 198
        Height = 17
        Caption = 'Controlar o retorno deste documento'
        TabOrder = 0
        OnClick = ChBx_RetornoClick
      end
      object ChBx_Baixa: TCheckBox
        Left = 5
        Top = 37
        Width = 187
        Height = 17
        Caption = 'Baixar o retorno deste documento'
        Enabled = False
        TabOrder = 1
        OnClick = ChBx_BaixaClick
      end
    end
    object GroupBox6: TGroupBox
      Left = 514
      Top = 4
      Width = 177
      Height = 63
      Caption = 'Tipo de Controle'
      TabOrder = 5
      object Lb_Controle: TLabel
        Left = 84
        Top = 13
        Width = 87
        Height = 14
        Caption = 'N'#250'mero do Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Rb_Ctrl_Pedido: TRadioButton
        Left = 5
        Top = 17
        Width = 74
        Height = 17
        Caption = 'Pedido'
        TabOrder = 0
        OnClick = Rb_Ctrl_PedidoClick
      end
      object Rb_Ctrl_Nf: TRadioButton
        Left = 5
        Top = 36
        Width = 78
        Height = 17
        Caption = 'Nota Fiscal'
        TabOrder = 1
        OnClick = Rb_Ctrl_NfClick
      end
      object E_DocVinculado: TEdit_Setes
        Left = 83
        Top = 30
        Width = 87
        Height = 22
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = ''
        OnKeyPress = E_DocVinculadoKeyPress
      end
    end
    object Panel3: TPanel
      Left = 457
      Top = 74
      Width = 234
      Height = 287
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 6
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 230
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
        ExplicitWidth = 144
      end
      object Chbx_Financeiro: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 58
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Gerar cr'#233'dito no Contas '#224' Pagar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ChBx_AutorizacaoNFE: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 22
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Solicitar autoriza'#231#227'o NF-e'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
        OnClick = ChBx_AutorizacaoNFEClick
      end
      object ChBx_SomaICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 76
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Somar o ICMS ao Total da Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object ChBx_Nota_Manual: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 40
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Informar N'#250'mero da Nota Manualmente'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Chbx_SomaIPI_Bs_ICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 94
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Somar o IPI na Base de ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object Chbx_SomaIPI_Bs_ICMS_St: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 112
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Somar o IPI na Base de ICMS Subst. Trib.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ChBx_DevolucaoMercadoria: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 184
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Controle de devolu'#231#227'o de Mercadoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object Chbx_NaoAtualizarEstoque: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 202
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'N'#227'o atualizar estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object ChBx_Distribuir_ICMS: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 130
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Distribuir o Valor do ICMS normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object ChBx_Distribuir_ICMS_ST: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 148
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Distribuir o Valor do ICMS - Subs. Tribut'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object ChBx_Distribuir_IPI: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 166
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Distribuir o Valor do IPI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object chbx_Mva_Original: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 220
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Usar o Mva Original'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object ChBx_ListaNcm: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 238
        Width = 224
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Validar lista de NCM para c'#225'lculo S.T'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object chbx_Cancela_fora_prazo: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 256
        Width = 224
        Height = 17
        Hint = 
          'Ajusta valores fiscais sem circula'#231#227'o de mercadoria - Devolu'#231#227'o ' +
          'fora do Prazo'
        Margins.Top = 1
        Margins.Bottom = 0
        Align = alTop
        Caption = 'NF-e Cancelamento fora do prazo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
      end
    end
    inline Fm_lista_cfop: TFm_lista_cfop
      AlignWithMargins = True
      Left = 10
      Top = 76
      Width = 441
      Height = 42
      Margins.Top = 0
      Margins.Bottom = 0
      TabOrder = 7
      ExplicitLeft = 10
      ExplicitTop = 76
      ExplicitWidth = 441
      ExplicitHeight = 42
      inherited pnl_linha_1: TPanel
        Width = 441
        ExplicitWidth = 441
        inherited Sb_open: TSpeedButton
          Left = 417
          ExplicitLeft = 417
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 417
          ExplicitWidth = 417
        end
      end
      inherited pnl_top: TPanel
        Width = 441
        ExplicitWidth = 441
        inherited L_name_list: TLabel
          Width = 415
          Height = 16
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 519
    Width = 696
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      696
      66)
    object SB_Confirmar: TSpeedButton
      Left = 503
      Top = 6
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
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
    end
    object SB_Sair_0: TSpeedButton
      Left = 599
      Top = 5
      Width = 90
      Height = 54
      Anchors = [akRight, akBottom]
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
      ExplicitLeft = 586
    end
  end
  object E_M_Fisco: TMemo
    Left = 717
    Top = 8
    Width = 457
    Height = 64
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Panel4: TPanel
    Left = 0
    Top = 367
    Width = 696
    Height = 152
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
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
      Left = 275
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
      Left = 409
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
      Left = 274
      Top = 38
      Width = 117
      Height = 14
      Caption = 'Outras desp acess'#243'rias'
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
      Left = 544
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
    object Label10: TLabel
      Left = 603
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
    object Label5: TLabel
      Left = 544
      Top = 38
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
    object Label39: TLabel
      Left = 271
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
    object Label35: TLabel
      Left = 254
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
      Left = 362
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
      Left = 473
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
      Left = 550
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
    object Label1: TLabel
      Left = 399
      Top = 109
      Width = 88
      Height = 14
      Caption = 'Valor IPI Devolvido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Vl_Bs_Icms_St: TEdit_Setes
      Left = 273
      Top = 17
      Width = 132
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
      Left = 407
      Top = 17
      Width = 133
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
      Width = 133
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
      Left = 273
      Top = 52
      Width = 132
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
      Left = 543
      Top = 17
      Width = 134
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
      Width = 133
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
      Width = 128
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
      Left = 407
      Top = 52
      Width = 133
      Height = 21
      Alignment = taRightJustify
      TabOrder = 8
      Text = '0,00'
    end
    object E_VL_Frete: TEdit_Setes
      Left = 7
      Top = 52
      Width = 128
      Height = 21
      Alignment = taRightJustify
      TabOrder = 5
      Text = '0,00'
    end
    object E_Qt_Produto: TEdit_Setes
      Left = 6
      Top = 88
      Width = 128
      Height = 21
      Alignment = taRightJustify
      TabOrder = 10
      Text = '0,00'
      OnChange = E_Qt_ProdutoChange
    end
    object E_RNTC: TEdit
      Left = 598
      Top = 88
      Width = 76
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
    object E_Vol_Numero: TEdit
      Left = 138
      Top = 123
      Width = 129
      Height = 21
      Enabled = False
      MaxLength = 8
      TabOrder = 18
    end
    object E_VL_Nota: TPanel
      Left = 543
      Top = 51
      Width = 134
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
    object E_Vl_desconto: TPanel
      Left = 269
      Top = 123
      Width = 126
      Height = 21
      Alignment = taRightJustify
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
      TabOrder = 19
      TabStop = True
    end
    object E_Especie: TEdit
      Left = 138
      Top = 88
      Width = 111
      Height = 21
      Enabled = False
      MaxLength = 10
      TabOrder = 11
    end
    object E_PesoLiq: TEdit_Setes
      Left = 360
      Top = 88
      Width = 106
      Height = 21
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 13
      Text = ''
    end
    object E_PesoBruto: TEdit_Setes
      Left = 252
      Top = 88
      Width = 103
      Height = 21
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 12
      Text = ''
    end
    object E_PlacaVeiculo: TMaskEdit
      Left = 471
      Top = 88
      Width = 72
      Height = 21
      TabOrder = 14
      Text = ''
    end
    object E_Uf_Veiculo: TDBLookupComboBox
      Left = 547
      Top = 88
      Width = 51
      Height = 21
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      TabOrder = 15
    end
    object E_vIPIDevolv: TPanel
      Left = 397
      Top = 123
      Width = 126
      Height = 21
      Alignment = taRightJustify
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
      TabStop = True
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 888
    Top = 53
  end
  object Ds_Moral_Frete: TDataSource
    DataSet = DM.Qr_Modal_Frete
    Left = 390
    Top = 189
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

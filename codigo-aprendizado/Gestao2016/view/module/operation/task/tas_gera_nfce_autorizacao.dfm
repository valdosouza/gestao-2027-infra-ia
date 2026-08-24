inherited TasGeraNfceAutorizacao: TTasGeraNfceAutorizacao
  Caption = 'Autoriza'#231#227'o NFC-e'
  ClientHeight = 688
  OnKeyDown = FormKeyDown
  ExplicitHeight = 717
  PixelsPerInch = 96
  TextHeight = 13
  inherited pg_Principal: TPageControl
    Height = 660
    ActivePage = tbs_NFC_e
    ExplicitHeight = 660
    object tbs_NFC_e: TTabSheet
      Caption = 'tbs_NFC_e'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_NFC_e: TPanel
        Left = 0
        Top = 0
        Width = 578
        Height = 323
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label3: TLabel
          Left = 2
          Top = 2
          Width = 574
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Acompanhamento processo'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 194
        end
        object MM_Acompanhamento: TMemo
          Left = 2
          Top = 18
          Width = 574
          Height = 303
          Align = alClient
          Ctl3D = False
          Lines.Strings = (
            '')
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WantReturns = False
          WantTabs = True
        end
        object Memo2: TMemo
          Left = 898
          Top = 382
          Width = 447
          Height = 69
          TabOrder = 1
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 568
        Width = 578
        Height = 64
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Sb_NFC_Autorizar: TSpeedButton
          AlignWithMargins = True
          Left = 84
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Autorizar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NFC_AutorizarClick
          ExplicitTop = 3
        end
        object Sb_NFC_Sair: TSpeedButton
          AlignWithMargins = True
          Left = 494
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_NFC_SairClick
          ExplicitTop = 3
        end
        object Sb_NFC_Consultar: TSpeedButton
          AlignWithMargins = True
          Left = 166
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Consultar - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NFC_ConsultarClick
          ExplicitTop = 3
        end
        object Sb_NFC_Imprimir: TSpeedButton
          AlignWithMargins = True
          Left = 330
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Imprimir - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_NFC_ImprimirClick
          ExplicitLeft = 332
          ExplicitTop = 6
          ExplicitHeight = 54
        end
        object Sb_NFC_Cancelar: TSpeedButton
          AlignWithMargins = True
          Left = 248
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Cancelar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NFC_CancelarClick
          ExplicitTop = 3
        end
        object Sb_NFC_Envia: TSpeedButton
          AlignWithMargins = True
          Left = 412
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Enviar - F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 1
          OnClick = Sb_NFC_EnviaClick
          ExplicitTop = 3
        end
        object Sb_NFC_Conferir: TSpeedButton
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 82
          Height = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Conferir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          Spacing = 0
          OnClick = Sb_NFC_ConferirClick
          ExplicitTop = 3
        end
      end
      object Pnl_NFCE_Opcao: TPanel
        Left = 0
        Top = 323
        Width = 578
        Height = 245
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object Label21: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 185
          Width = 271
          Height = 16
          Margins.Top = 1
          Margins.Right = 300
          Margins.Bottom = 1
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Para o programa '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 6
        end
        object Label20: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 203
          Width = 271
          Height = 16
          Margins.Top = 1
          Margins.Right = 300
          Margins.Bottom = 1
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Nota Fiscal Eletr'#244'nica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 6
          ExplicitTop = 200
        end
        object Label22: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 221
          Width = 271
          Height = 21
          Margins.Top = 1
          Margins.Right = 300
          Margins.Bottom = 1
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = #233' obrigat'#243'rio perguntar ao cliente.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 6
          ExplicitTop = 217
          ExplicitHeight = 16
        end
        object ChBx_InformarCPFnaNota: TCheckBox
          AlignWithMargins = True
          Left = 10
          Top = 166
          Width = 565
          Height = 17
          Margins.Left = 8
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'F8 - Informar C.P.F na Nota Fiscal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object pnl_emission_option: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 3
          Width = 271
          Height = 159
          Margins.Top = 1
          Margins.Right = 300
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label4: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 1
            Width = 265
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Tipo de Emiss'#227'o '
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 81
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 118
            Width = 265
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Indicador de presen'#231'a do comprador'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 178
          end
          object Label6: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 79
            Width = 265
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Formato do DANFE (NFC-e)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 132
          end
          object Label16: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 40
            Width = 265
            Height = 14
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 'Justificativa no caso de emiss'#227'o OFF-LINE'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 205
          end
          object Cb_TipoEmissao: TComboBox
            AlignWithMargins = True
            Left = 3
            Top = 17
            Width = 265
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Style = csDropDownList
            TabOrder = 0
            OnChange = Cb_TipoEmissaoChange
            Items.Strings = (
              '4 - Emiss'#227'o normal da NFC-e'
              '9 - Conting'#234'ncia off-line da NFC-e')
          end
          object Cb_IndPresenca: TComboBox
            AlignWithMargins = True
            Left = 3
            Top = 134
            Width = 265
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Style = csDropDownList
            TabOrder = 1
            Items.Strings = (
              '1 - Opera'#231#227'o presencial'
              '4 - NFC-e em opera'#231#227'o com entrega em domic'#237'lio')
          end
          object Cb_ForDanfe: TComboBox
            AlignWithMargins = True
            Left = 3
            Top = 95
            Width = 265
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            Style = csDropDownList
            ItemIndex = 1
            TabOrder = 2
            Text = '5 - DANFE NFC-e em mensagem eletr'#244'nica.'
            OnChange = Cb_ForDanfeChange
            Items.Strings = (
              '4 - DANFE NFC-e.'
              '5 - DANFE NFC-e em mensagem eletr'#244'nica.')
          end
          object edt_Justificativa_Offline: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 56
            Width = 265
            Height = 21
            Margins.Top = 1
            Margins.Bottom = 1
            Align = alTop
            MaxLength = 25
            TabOrder = 3
          end
        end
      end
    end
  end
  inherited Qr_lote: TSTQuery
    Top = 336
  end
end

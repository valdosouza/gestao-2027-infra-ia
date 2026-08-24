inherited TasSyncRetaguardaWeb: TTasSyncRetaguardaWeb
  Left = 394
  Top = 201
  BorderIcons = []
  BorderWidth = 2
  Caption = 'Sincronia Retaguarda Web'
  ClientHeight = 438
  ClientWidth = 511
  Color = clWindow
  Ctl3D = False
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 521
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 13
  object Gg_Progresso: TGauge [0]
    Left = 0
    Top = 334
    Width = 511
    Height = 36
    Align = alBottom
    Progress = 0
    ExplicitTop = 174
    ExplicitWidth = 428
  end
  object Lb_Processamento: TLabel [1]
    AlignWithMargins = True
    Left = 3
    Top = 315
    Width = 505
    Height = 16
    Margins.Top = 1
    Align = alBottom
    Caption = 'Processamento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 91
  end
  object Pg_Principal: TPageControl [2]
    Left = 0
    Top = 0
    Width = 511
    Height = 314
    ActivePage = tbs_recebimento
    Align = alClient
    TabOrder = 0
    object Tbs_Processamento: TTabSheet
      Caption = 'Processamento'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Lst_Process: TListBox
        Left = 0
        Top = 0
        Width = 503
        Height = 286
        Align = alClient
        ItemHeight = 13
        Items.Strings = (
          '')
        TabOrder = 0
      end
    end
    object tbs_recebimento: TTabSheet
      Caption = 'Recebimento'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Pnl_Top: TPanel
        Left = 0
        Top = 0
        Width = 503
        Height = 113
        Margins.Left = 5
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 0
        object Label4: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 493
          Height = 36
          Align = alTop
          Caption = 
            'Marcar a op'#231#227'o abaixo apenas se houver suspeita de que houve fal' +
            'ha na sincronia normal'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 489
        end
        object pnl_top_Left: TPanel
          Left = 2
          Top = 44
          Width = 499
          Height = 67
          Align = alClient
          TabOrder = 0
          object chbx_setTimeTo: TCheckBox
            AlignWithMargins = True
            Left = 8
            Top = 4
            Width = 487
            Height = 17
            Margins.Left = 7
            Align = alTop
            Caption = 'Sincronizar a partir da data e hora abaixo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object Dtp_Inicio: TDateTimePicker
            AlignWithMargins = True
            Left = 4
            Top = 27
            Width = 154
            Height = 36
            Align = alLeft
            Date = 43594.669666122690000000
            Time = 43594.669666122690000000
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            ExplicitHeight = 26
          end
          object Dtp_Hora: TDateTimePicker
            AlignWithMargins = True
            Left = 164
            Top = 27
            Width = 94
            Height = 36
            Align = alLeft
            Date = 43594.669666122690000000
            Time = 43594.669666122690000000
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            Kind = dtkTime
            ParentFont = False
            TabOrder = 2
            ExplicitHeight = 26
          end
        end
      end
    end
    object tbs_envio: TTabSheet
      Caption = 'Envio'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 503
        Height = 286
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 493
          Height = 18
          Align = alTop
          Caption = 'Informe um per'#237'odo para envio da movimenta'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 338
        end
        object Label2: TLabel
          Left = 9
          Top = 24
          Width = 77
          Height = 18
          Caption = 'Data Inicial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 121
          Top = 25
          Width = 72
          Height = 18
          Caption = 'Data Final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Data_Ini: TDateTimePicker
          Left = 9
          Top = 45
          Width = 110
          Height = 26
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object E_Data_Fim: TDateTimePicker
          Left = 122
          Top = 45
          Width = 110
          Height = 26
          Date = 39580.356281493060000000
          Time = 39580.356281493060000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  object pnl_Botao: TPanel [3]
    Left = 0
    Top = 370
    Width = 511
    Height = 68
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 417
      Top = 5
      Width = 89
      Height = 58
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
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 583
      ExplicitTop = 7
      ExplicitHeight = 54
    end
    object Sb_Confirmar: TSpeedButton
      AlignWithMargins = True
      Left = 322
      Top = 5
      Width = 89
      Height = 58
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
      OnClick = Sb_ConfirmarClick
      ExplicitTop = 6
    end
  end
  inherited MnuBase: TMainMenu
    Left = 16
    Top = 200
    inherited arefas1: TMenuItem
      object SincronizartodososClientes1: TMenuItem [0]
        Caption = 'Sincronizar Geral'
        OnClick = SincronizartodososClientes1Click
      end
      object AjustarCNPJDuplicados1: TMenuItem [1]
        Caption = 'Ajustar CNPJ Duplicados'
        OnClick = AjustarCNPJDuplicados1Click
      end
      object ValidaCNPJs1: TMenuItem [2]
        Caption = 'Valida CNPJs'
        OnClick = ValidaCNPJs1Click
      end
    end
  end
end

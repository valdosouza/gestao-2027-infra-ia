inherited CadSchedule: TCadSchedule
  Caption = 'Agendamento'
  ClientHeight = 271
  ClientWidth = 769
  ExplicitWidth = 775
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 207
    Width = 769
    ExplicitTop = 207
    ExplicitWidth = 769
    inherited SB_Inserir: TSpeedButton
      Left = 142
      ExplicitLeft = 149
    end
    inherited SB_Alterar: TSpeedButton
      Left = 246
      ExplicitLeft = 245
    end
    inherited SB_Excluir: TSpeedButton
      Left = 350
      ExplicitLeft = 353
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 558
      ExplicitLeft = 557
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 662
      ExplicitLeft = 661
    end
    inherited SB_Gravar: TSpeedButton
      Left = 454
      ExplicitLeft = 455
    end
  end
  inherited pnl_fundo: TPanel
    Width = 769
    Height = 207
    ExplicitWidth = 769
    ExplicitHeight = 207
    object Label2: TLabel
      Left = 9
      Top = 4
      Width = 22
      Height = 14
      Caption = 'Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 106
      Top = 4
      Width = 23
      Height = 14
      Caption = 'Hora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 186
      Top = 4
      Width = 41
      Height = 14
      Caption = 'Dura'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 624
      Top = 4
      Width = 24
      Height = 14
      Caption = 'Fone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 254
      Top = 4
      Width = 77
      Height = 14
      Caption = 'Nome do Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 89
      Width = 66
      Height = 14
      Caption = 'Observa'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Data: TDateTimePicker
      Left = 6
      Top = 20
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
    object E_Duration: TMaskEdit
      Left = 184
      Top = 20
      Width = 61
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
    end
    object E_Phone: TEdit_Setes
      Left = 623
      Top = 20
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
      IsFone = True
    end
    object E_Served: TEdit
      Left = 255
      Top = 20
      Width = 364
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    inline Fm_ListaAtendente: TFm_ListaColaboradores
      Left = 6
      Top = 49
      Width = 315
      Height = 36
      TabOrder = 5
      ExplicitLeft = 6
      ExplicitTop = 49
      ExplicitWidth = 315
      ExplicitHeight = 36
      inherited Label19: TLabel
        Width = 315
        Caption = 'Atendente'
        ExplicitWidth = 50
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 289
        Height = 19
        ExplicitLeft = 285
        ExplicitHeight = 17
      end
      inherited Dblcb_Vendedor: TDBLookupComboBox
        Width = 286
        ExplicitWidth = 286
      end
    end
    inline Fm_ListaSituacao: TFm_ListaSituacao
      Left = 328
      Top = 49
      Width = 305
      Height = 39
      TabOrder = 6
      ExplicitLeft = 328
      ExplicitTop = 49
      ExplicitWidth = 305
      inherited Label14: TLabel
        Width = 305
        Caption = 'Situa'#231#227'o do Agendamento'
        ExplicitWidth = 126
      end
      inherited Sb_Cadastro: TSpeedButton
        Left = 279
        ExplicitLeft = 279
      end
      inherited DBLCB_Situacao: TDBLookupComboBox
        Width = 276
        ExplicitWidth = 276
      end
    end
    object E_Note: TMemo
      Left = 8
      Top = 105
      Width = 753
      Height = 96
      Lines.Strings = (
        'E_Note')
      TabOrder = 7
    end
    object Cb_Hora: TComboBox
      Left = 102
      Top = 20
      Width = 78
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = '08:00'
      Items.Strings = (
        '08:00'
        '09:00'
        '10:00'
        '11:00'
        '12:00'
        '13:00'
        '14:00'
        '15:00'
        '16:00'
        '17:00'
        '18:00'
        '19:00'
        '20:00')
    end
  end
  inherited MnuBase: TMainMenu
    Left = 704
    Top = 48
  end
end

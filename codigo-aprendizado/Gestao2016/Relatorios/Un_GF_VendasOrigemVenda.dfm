object GF_VendasOrigemVenda: TGF_VendasOrigemVenda
  Left = 333
  Top = 145
  Caption = 'Gr'#225'fico'
  ClientHeight = 422
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 357
    Width = 680
    Height = 65
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      680
      65)
    object Sb_Sair_0: TSpeedButton
      Left = 603
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
    end
    object Sb_Exportar: TSpeedButton
      Left = 522
      Top = 6
      Width = 80
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Exportar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_ExportarClick
    end
  end
  object Qr_Venda: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select clb_nome, DESCRIPTION,SUM(tb_nota_fiscal.nfl_vl_tl_nota)'
      'from tb_nota_fiscal'
      '  inner join tb_pedido'
      '  on (ped_codigo = nfl_codped)'
      '  inner join tb_colaborador'
      '  on (clb_codigo = ped_codvdo)'
      '  INNER JOIN tb_sale_origen'
      '  ON (ID = PED_TP_CONTATO)'
      'where ped_tp_contato <> '#39#39' and ped_codvdo = 141'
      'GROUP BY 1,2')
    Left = 96
    Top = 56
  end
end

unit Un_RL_ReportProductPriceList;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportProduct, Data.DB, AnsiStrings, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportProductPriceList = class(TRL_ReportProduct)
    QRBand1: TQRBand;
    QRGroup2: TQRGroup;
    E_Grupo: TQRLabel;
    Ft_SubGrupo: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRExpr2: TQRExpr;
    QRGroup3: TQRGroup;
    E_Subgrupo: TQRLabel;
    E_DescricaoProduto: TQRLabel;
    E_VL_Preco: TQRLabel;
    E_codigoProduto: TQRLabel;
    E_Unidade: TQRLabel;
    E_Embalagem: TQRLabel;
    E_Divisor: TQRLabel;
    E_Un_emb: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    procedure wheresql;override;
    procedure OrderBy;Override;
    procedure PreencherGrupo;Override;
    procedure PreencherSubgrupo;
    procedure PreencherDetalhe;Override;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportProductPriceList: TRL_ReportProductPriceList;

implementation

{$R *.dfm}

procedure TRL_ReportProductPriceList.OrderBy;
begin
  case AnsiIndexStr(UpperCase(Parametros.Ordenacao), ['PRO_DESCRICAO', 'PRO_CODIGOFAB','PRO_CODIGO']) of
    0:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_DESCRICAO ASC ';
    1:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGOFAB ASC ';
    2:OrderByTxt := ' ORDER BY GRP_DESCRICAO, SBG_DESCRICAO, PRO_CODIGO ASC ';
  end;

end;

procedure TRL_ReportProductPriceList.PreencherDetalhe;
begin
  inherited;
  with Qr_Consulta do
  Begin
    E_codigoProduto.Caption := FieldByName('PRO_CODIGOFAB').AsString;
    E_DescricaoProduto.Caption := FieldByName('PRO_DESCRICAO').AsString;
    E_Unidade.Caption :=  FieldByName('MED_DESCRICAO').AsString;
    E_VL_Preco.Caption := FloatToStrF(FieldByName('PRC_VL_VDA').AsCurrency,ffNumber,10,2);
    E_Embalagem.Caption :=  FieldByName('EMB_DESCRICAO').AsString;
    E_Divisor.Caption :=  FieldByName('PRO_DIVISOR').AsString;
    if (FieldByName('PRO_DIVISOR').AsFloat > 0) AND (not FieldByName('PRO_DIVISOR').IsNull) then
      E_Un_emb.Caption := FloatToStrF(FieldByName('PRC_VL_VDA').AsCurrency/FieldByName('PRO_DIVISOR').AsFloat,ffFixed,10,2)
    else
      E_Un_emb.Caption := FloatToStrF(FieldByName('PRC_VL_VDA').AsCurrency/1,ffFixed,10,2);
  End;
end;

procedure TRL_ReportProductPriceList.PreencherGrupo;
begin
  E_Grupo.Caption := Qr_Consulta.FieldByName('GRP_DESCRICAO').asString;
end;

procedure TRL_ReportProductPriceList.PreencherSubgrupo;
begin
  E_Subgrupo.Caption := Qr_Consulta.FieldByName('SBG_DESCRICAO').asString;
end;

procedure TRL_ReportProductPriceList.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherDetalhe
end;

procedure TRL_ReportProductPriceList.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherGrupo;
end;

procedure TRL_ReportProductPriceList.QRGroup3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherSubGrupo;
end;

procedure TRL_ReportProductPriceList.wheresql;
begin
  inherited;
  WhereTxt := concat(WhereTxt,
                    ' AND ( PRO_IMPRIME = ''S'' )'
                   );
end;

end.

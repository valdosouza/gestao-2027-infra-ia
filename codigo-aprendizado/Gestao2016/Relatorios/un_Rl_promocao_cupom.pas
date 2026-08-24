unit un_Rl_promocao_cupom;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery;

type
  TRL_Promo_Cupom = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRGroup1: TQRGroup;
    QRLabel2: TQRLabel;
    qr_promocao: TSTQuery;
    QRLabel5: TQRLabel;
    lbl_fornecedor: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    lb_cupom: TQRLabel;
    QRBand2: TQRBand;
    QRDBText2: TQRDBText;
    QRLabel6: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    it_vl_cupom:Currency;
    it_nome_forn:String;
    procedure pc_busca();
  end;

  var

  RL_Promo_Cupom: TRL_Promo_Cupom;

implementation

{$R *.dfm}
USES
Un_DM, UN_Sistema, UN_Imp_Empresas;



{ TRL_Promo_Cupom }

procedure TRL_Promo_Cupom.pc_busca;
begin
  it_nome_forn:= Fr_Imp_Empresa.DBLCB_Empresa.Text;
  qr_promocao.Active:=false;
  qr_promocao.SQL.Clear;
  qr_promocao.SQL.Add(' select SUM(A.ped_vl_pedido) ped_vl_pedido,                     ');
  qr_promocao.SQL.Add(' d.emp_codigo,d.emp_nome from tb_pedido a                      ');
  qr_promocao.SQL.Add(' inner join tb_itens_nfl b on b.itf_codped = a.ped_codigo      ');
  qr_promocao.SQL.Add(' inner join tb_prod_forn c on c.pfr_codpro = b.itf_codpro      ');
  qr_promocao.SQL.Add(' inner join tb_empresa d on d.emp_codigo = a.ped_codemp        ');
  qr_promocao.SQL.Add(' where                                                         ');
  qr_promocao.SQL.Add(' c.pfr_codfor = :codfor                                        ');
  qr_promocao.SQL.Add(' and d.emp_tipo <> 0                                           ');
  qr_promocao.SQL.Add(' group by 3,2 order by 3,2                                        ');

  qr_promocao.ParamByName('codfor').AsInteger:= Fr_Imp_Empresa.DBLCB_Empresa.KeyValue;
  qr_promocao.Active:=true;
  qr_promocao.FetchAll;
  qr_promocao.First;
  it_vl_cupom:= StrToFloatDef(Fc_Tb_Geral('L','GRL_G_VL_CUPOM', ''),0);
end;

procedure TRL_Promo_Cupom.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Cab_Relatorio(Qrpt);
  Pc_Busca;
end;

procedure TRL_Promo_Cupom.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   lbl_fornecedor.Caption:=it_nome_forn;
end;

procedure TRL_Promo_Cupom.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  lc_qtd:integer;
begin
  lc_qtd:=1;
  if (qr_promocao.FieldByname('PED_VL_PEDIDO').IsNull) or (qr_promocao.FieldByname('PED_VL_PEDIDO').AsCurrency =0) then
  lc_qtd:=0;
  if lc_qtd > 0 then
  begin
  lc_qtd:= qr_promocao.FieldByname('PED_VL_PEDIDO').AsVariant div it_vl_cupom;
  lb_cupom.Caption:=IntToStr(lc_qtd);
  end
  else
  lb_cupom.Caption:=IntToStr(0);
end;                                 

end.

unit UN_RL_OrcaCst_Entg;

interface
                                                      
uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, DB, StrUtils, STQuery, QuickRpt, ExtCtrls;

type
  TRL_OrcaCst_Entg = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    E_VLPeca: TQRLabel;
    E_VLServico: TQRLabel;
    QRLabel16: TQRLabel;
    E_VLDesc: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    E_DataConserto: TQRLabel;
    QRLabel20: TQRLabel;
    E_DataEntrega: TQRLabel;
    QRBand1: TQRBand;
    QRLabel22: TQRLabel;
    E_DataEntrada_1: TQRLabel;
    QRLabel28: TQRLabel;
    E_NomeEmpresa: TQRLabel;
    QRLabel4: TQRLabel;
    E_VLTotal: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRImage3: TQRImage;
    E_NomeCliente: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    E_DataEntrega_2: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel6: TQRLabel;
    E_Situacao: TQRLabel;
    E_Marca: TQRLabel;
    E_Modelo: TQRLabel;
    E_NumSerie: TQRLabel;
    E_Aparelho: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Numero_1: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel18: TQRLabel;
    Lb_Numero_2: TQRLabel;
    qr_conserto: TSTQuery;
    QR_COTACAO: TSTQuery;
    MM_Relatado_1: TQRRichText;
    MM_Constatado: TQRRichText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_PEdido : Integer;
    procedure PC_Busca;
    procedure Pc_Preencher;
  end;

var
  RL_OrcaCst_Entg: TRL_OrcaCst_Entg;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_OrcaCst_Entg.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  pc_Busca;
end;

procedure TRL_OrcaCst_Entg.Pc_Busca;
begin
  Qr_Cotacao.Active := False;
  Qr_Cotacao.ParamByName('CTC_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Cotacao.Active := True;
  Qr_Cotacao.FetchAll;
  Qr_Cotacao.First;

  qr_conserto.Active:=false;
  qr_conserto.ParamByName('PED_CODIGO').AsInteger:= Qr_Cotacao.FieldByName('CTC_CODPED').AsInteger;
  qr_conserto.Active:=true;
  Pc_Preencher;
end;

procedure TRL_OrcaCst_Entg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qrpt);
  Action := Cafree;
  RL_OrcaCst_Entg := nil
end;

procedure TRL_OrcaCst_Entg.Pc_Preencher;
begin
  Lb_Numero_1.Caption :=  Qr_Cotacao.FieldByName('ctc_numero').AsString;
  E_DataEntrada_1.Caption:=qr_Cotacao.fieldbyname('CTC_DATA').AsString + ' ' + Copy(TimeToStr(now), 1, 5) + ' hs';
  E_Aparelho.Caption:= Qr_Conserto.FieldByName('CST_APARELHO').AsString;
  E_NumSerie.Caption := Qr_Conserto.FieldByName('CST_NUMERO').AsString;
  E_Marca.Caption := Qr_Conserto.FieldByName('CST_MARCA').AsString;
  E_Modelo.Caption := Qr_Conserto.FieldByName('CST_MODELO').AsString;
  MM_Relatado_1.Lines.Clear;
  MM_Relatado_1.Lines.Add(Qr_Conserto.FieldByName('CST_RELATADO').Text);
  MM_Constatado.Lines.Clear;
  MM_Constatado.Lines.Add(Qr_Conserto.FieldByName('CST_CONSTATADO').Text);
  Lb_Numero_2.Caption := Qr_Cotacao.FieldByName('ctc_numero').AsString;

  if Qr_Conserto.FieldByname('CST_VL_PECAS').AsCurrency >0 then
    E_VLPeca.Caption:= FormatFloat('#,##0.00',Qr_Conserto.FieldByname('CST_VL_PECAS').AsCurrency)
  else
    E_VLPeca.Caption:= '';

  if Qr_Conserto.FieldByname('CST_VL_MOBRA').AsCurrency >0 then
    E_VLServico.Caption:= FormatFloat('#,##0.00',Qr_Conserto.FieldByname('CST_VL_MOBRA').AsCurrency)
  else
    E_VLServico.Caption:='';

  if QR_COTACAO.FieldByname('CTC_VL_DESCONTO').AsCurrency >0 then
    E_VLDesc.Caption :=FormatFloat('#,##0.00',qr_cotacao.FieldByname('CTC_VL_DESCONTO').AsCurrency)
  else
    E_VLDesc.Caption := '';

  if QR_COTACAO.FieldByname('CTC_VL_Cotacao').AsCurrency  >0 then
    E_VLTotal.Caption := FormatFloat('#,##0.00',qr_cotacao.FieldByname('CTC_VL_Cotacao').AsCurrency)
  else
    E_VLTotal.Caption := '';

  Pc_AtivaEstabelecimento;

  E_NomeEmpresa.Caption := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
  if Length(qr_conserto.FieldByName('CST_Dt_conserto').AsString)>0 then
    E_DataConserto.Caption := qr_conserto.FieldByName('CST_Dt_conserto').AsString
  else
    E_DataConserto.Caption := '';

  if Length(Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString)>0 then
    E_DataEntrega.Caption := Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString
  else
    E_DataEntrega.Caption := '';

  if Length(Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString)>0 then
    E_DataEntrega_2.Caption := Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString
  else
    E_DataEntrega_2.Caption := '';

  E_Situacao.Caption := Qr_Conserto.FieldByName('SIT_DESCRICAO').AsString;
  E_NomeCliente.Caption := Qr_Cotacao.FieldByName('EMP_NOME').AsString;
end;

end.

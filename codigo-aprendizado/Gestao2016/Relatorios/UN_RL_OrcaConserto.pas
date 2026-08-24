unit UN_RL_OrcaConserto;

interface
                                                                                                  
uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QRCtrls, DB, StrUtils, STQuery, QuickRpt, ExtCtrls;

type
  TRL_OrcaConserto = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    E_Aparelho: TQRLabel;
    E_Marca: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    E_Modelo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    E_VLPeca: TQRLabel;
    E_VLServico: TQRLabel;
    QRLabel16: TQRLabel;
    E_VLDesc: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    E_DataConserto: TQRLabel;
    QRLabel20: TQRLabel;
    E_DataEntrega: TQRLabel;
    QRLabel25: TQRLabel;
    QRImage3: TQRImage;
    QRBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    E_DataEntrada_1: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    E_NomeCliente: TQRLabel;
    QRLabel4: TQRLabel;
    E_VLTotal: TQRLabel;
    Lb_Numero_2: TQRLabel;
    E_NumSerie: TQRLabel;
    QRLabel5: TQRLabel;
    E_DataEntrada_2: TQRLabel;
    E_FoneContato: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Numero_1: TQRLabel;
    Img_2Logo: TQRImage;
    qr_cotacao: TSTQuery;
    qr_conserto: TSTQuery;
    MM_Relatado_1: TQRRichText;
    MM_Acessorio_1: TQRRichText;
    MM_Relatado_2: TQRRichText;
    MM_Constatado: TQRRichText;
    MM_Acessorio_2: TQRRichText;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_PEdido : Integer;
    it_texto:String;
    PROCEdure Pc_preencher;
    procedure PC_Busca;    
  end;

var
  RL_OrcaConserto: TRL_OrcaConserto;

implementation

uses     Un_DM, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_OrcaConserto.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
BEgin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Fc_BuscaImagemEmpresa(img_2logo.Picture, 'LOGO');
  pc_Busca;
end;

procedure TRL_OrcaConserto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_OrcaConserto := Nil
end;

procedure TRL_OrcaConserto.Pc_preencher;
begin
  Lb_Numero_1.Caption :=Qr_Cotacao.FieldByName('ctc_numero').AsString;
  MM_Relatado_1.Lines.Clear;
  MM_Relatado_2.Lines.Clear;
  MM_Constatado.Lines.Clear;
  E_DataEntrada_1.Caption:= qr_Cotacao.fieldbyname('CTC_DATA').AsString + ' ' + Copy(TimeToStr(now), 1, 5) + ' hs';
  E_Aparelho.Caption:= Qr_Conserto.FieldByName('CST_APARELHO').AsString;
  E_NumSerie.Caption:= Qr_Conserto.FieldByName('CST_NUMERO').AsString;
  E_Marca.Caption:= Qr_Conserto.FieldByName('CST_MARCA').AsString;
  E_Modelo.Caption:= Qr_Conserto.FieldByName('CST_MODELO').AsString;
  MM_Relatado_1.Lines.Clear;
  MM_Relatado_2.Lines.Clear;
  MM_Relatado_1.Lines.Add(Qr_Conserto.FieldByName('CST_RELATADO').AsString);
  MM_Relatado_2.Lines.Add(Qr_Conserto.FieldByName('CST_RELATADO').AsString);

  MM_Acessorio_1.Lines.Clear;
  MM_Acessorio_2.Lines.Clear;
  MM_Acessorio_1.Lines.Add(Qr_Conserto.FieldByName('CST_ACESSORIO').AsString);
  MM_Acessorio_2.Lines.Add(Qr_Conserto.FieldByName('CST_ACESSORIO').AsString);

  MM_Constatado.Lines.Clear;
  MM_Constatado.Lines.Add(Qr_Conserto.FieldByName('CST_Constatado').AsString);

  Lb_Numero_2.Caption := Qr_Cotacao.FieldByName('ctc_numero').AsString;
  E_DataEntrada_2.Caption:=qr_Cotacao.fieldbyname('CTC_DATA').AsString + ' ' + Copy(TimeToStr(now), 1, 5) + ' hs';

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

  if Length(Qr_Conserto.FieldByName('CST_DT_CONSERTO').AsString)>0 then
    E_DataConserto.Caption := Qr_Conserto.FieldByName('CST_DT_CONSERTO').AsString
  else
    E_DataConserto.Caption := '';

  if Length(Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString)>0 then
    E_DataEntrega.Caption := Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString
  else
    E_DataEntrega.Caption := '';

  E_NomeCliente.Caption := Qr_Cotacao.FieldByName('EMP_NOME').AsString;
  E_FoneContato.Caption := fc_MascaraFone(qr_cotacao.FieldByName('END_FONE').AsString) + '  ' + fc_MascaraFone(qr_cotacao.FieldByName('END_CELULAR').AsString);
end;    
procedure TRL_OrcaConserto.PC_Busca;
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

end.

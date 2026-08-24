unit UN_RL_Duplicata;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, STQuery, jpeg;

type
  TFr_RL_Duplicata = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    QRRichText9: TQRRichText;
    QRRichText10: TQRRichText;
    QRRichText11: TQRRichText;
    QRRichText12: TQRRichText;
    E_Firma: TQRRichText;
    QRLabel1: TQRLabel;
    E_NomeCliente: TQRLabel;
    QRLabel3: TQRLabel;
    E_Endereco: TQRLabel;
    QRLabel5: TQRLabel;
    E_Cidade: TQRLabel;
    QRLabel7: TQRLabel;
    E_Estado: TQRLabel;
    QRLabel9: TQRLabel;
    E_Cep: TQRLabel;
    QRLabel11: TQRLabel;
    E_PracaPAgto: TQRLabel;
    QRLabel13: TQRLabel;
    E_CNPJ: TQRLabel;
    QRLabel15: TQRLabel;
    E_IncEstadual: TQRLabel;
    E_DataEmissao: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRRichText8: TQRRichText;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    E_Aliq_Valor_Limite_1: TQRLabel;
    E_Condicao_1: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel10: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRLabel12: TQRLabel;
    QRImage2: TQRImage;
    E_ValorExtenso: TQRLabel;
    E_VL_Venda: TQRLabel;
    E_Vl_Dup: TQRLabel;
    E_Dup_Os: TQRLabel;
    E_Vencim: TQRLabel;
    E_Fatura: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRRichText14: TQRRichText;
    QRRichText15: TQRRichText;
    QRRichText16: TQRRichText;
    QRRichText17: TQRRichText;
    E_Firma_2: TQRRichText;
    QRLabel14: TQRLabel;
    E_NomeCliente_2: TQRLabel;
    QRLabel19: TQRLabel;
    E_Endereco_2: TQRLabel;
    QRLabel22: TQRLabel;
    E_Cidade_2: TQRLabel;
    QRLabel24: TQRLabel;
    E_Estado_2: TQRLabel;
    QRLabel26: TQRLabel;
    E_Cep_2: TQRLabel;
    QRLabel28: TQRLabel;
    E_PracaPAgto_2: TQRLabel;
    QRLabel30: TQRLabel;
    E_CNPJ_2: TQRLabel;
    QRLabel32: TQRLabel;
    E_IncEstadual_2: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRRichText19: TQRRichText;
    E_Aliq_Valor_Limite_2: TQRLabel;
    E_Condicao_2: TQRLabel;
    QRLabel41: TQRLabel;
    QRShape24: TQRShape;
    QRLabel42: TQRLabel;
    QRImage4: TQRImage;
    E_ValorExtenso_2: TQRLabel;
    E_VL_Venda_2: TQRLabel;
    E_Vl_Dup_2: TQRLabel;
    E_Dup_Os_2: TQRLabel;
    E_Vencim_2: TQRLabel;
    E_Fatura_2: TQRLabel;
    Lb_endereco_1: TQRLabel;
    Lb_CepCidUF1: TQRLabel;
    Lb_CNPJ1: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel21: TQRLabel;
    Lb_InscEstad1: TQRLabel;
    Lb_Razao1: TQRLabel;
    Qr_Duplicata: TSTQuery;
    LB_Fone1: TQRLabel;
    logotipo: TQRImage;
    QRLabel8: TQRLabel;
    QRLabel43: TQRLabel;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    LB_Fone2: TQRLabel;
    E_DataEmissao_2: TQRLabel;
    Lb_Razao2: TQRLabel;
    Lb_endereco_2: TQRLabel;
    Lb_CepCidUF2: TQRLabel;
    Lb_CNPJ2: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_InscEstad2: TQRLabel;
    QRLabel34: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel35Print(sender: TObject; var Value: String);
    procedure E_ValorExtenso_2Print(sender: TObject; var Value: String);
    procedure QRLabel18Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Financeiro:Integer;
  end;

var
  Fr_RL_Duplicata: TFr_RL_Duplicata;

implementation

uses     Un_DM, Un_Funcoes, UN_Sistema, Un_Regra_Negocio;
{$R *.dfm}

procedure TFr_RL_Duplicata.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Qr_Duplicata.Active := False;
  Qr_Duplicata.ParamByName('FIN_CODNFL').AsInteger := It_Financeiro;
  Qr_Duplicata.Active := True;
  Qr_Duplicata.First;
  Fc_BuscaImagemEmpresa(logotipo.Picture,'DUPLICATA');

  Pc_AtivaEstabelecimento;
  with DM.Qr_Estabelecimento do
  Begin
    Lb_Razao1.Caption:= FieldByName('EMP_NOME').AsString;
    LB_Fone1.Caption:='FONE: '+ fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_endereco_1.Caption:=FieldByName('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByName('END_NUMERO').AsString;
    Lb_CepCidUF1.Caption:=FieldByName('END_BAIRRO').AsString + ' - CEP :'+ Fc_MascaraCep(FieldByName('END_CEP').AsString)+' - '+FieldByName('CDD_DESCRICAO').AsString+' - '+FieldByName('UFE_SIGLA').AsString;
    Lb_CNPJ1.Caption:= fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    Lb_InscEstad1.Caption:=FieldByName('EMP_INSC_EST').AsString;

    E_Firma.Lines.Clear;
    E_Firma.Lines.Add('Reconhe�o(emos) a exatid�o desta Duplicata de Prestção de Serviços/Venda Mercantil na import�ncia acima ');
    E_Firma.Lines.Add('que pagarei(emos) a ' + FieldByName('EMP_NOME').AsString + ', ou � sua ordem na pra�a e vencimentos acima indicados ');
  end;
  //Primeira Via
  E_NomeCliente.Caption:= Qr_Duplicata.FieldByName('FIN_CODEMP').AsString + ' - ' + Qr_Duplicata.FieldByName('EMP_NOME').AsString;
  E_Endereco.Caption:= Qr_Duplicata.FieldByName('END_ENDER').AsString + ', ' + Qr_Duplicata.FieldByName('END_NUMERO').AsString;
  E_Cidade.Caption:=Qr_Duplicata.FieldByName('CDD_DESCRICAO').AsString;
  E_Estado.Caption:=Qr_Duplicata.FieldByName('UFE_SIGLA').AsString;
  E_PracaPAgto.Caption:=Qr_Duplicata.FieldByName('CDD_DESCRICAO').AsString;
  E_Cep.Caption := Fc_MascaraCep(Qr_Duplicata.FieldByName('END_CEP').AsString);
  IF Length(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString) = 11 then
    E_CNPJ.Caption:= fc_MascaraCPF(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString)
  else
    E_CNPJ.Caption:=fc_MascaraCNPJ(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString);


  E_IncEstadual.Caption:=Qr_Duplicata.FieldByName('EMP_INSC_EST').AsString;
  E_DataEmissao.Caption:=DateToStr(Date);
  //Segunda Via
  with DM.Qr_Estabelecimento do
  Begin
    Lb_Razao2.Caption:= FieldByName('EMP_NOME').AsString;
    LB_Fone2.Caption:='FONE: '+ fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_endereco_2.Caption:=FieldByName('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByName('END_NUMERO').AsString;
    Lb_CepCidUF2.Caption:=FieldByName('END_BAIRRO').AsString + ' - CEP :'+ Fc_MascaraCep(FieldByName('END_CEP').AsString)+' - '+FieldByName('CDD_DESCRICAO').AsString+' - '+FieldByName('UFE_SIGLA').AsString;
    Lb_CNPJ2.Caption:= fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    Lb_InscEstad2.Caption:=FieldByName('EMP_INSC_EST').AsString;
  end;

  E_NomeCliente_2.Caption:= Qr_Duplicata.FieldByName('FIN_CODEMP').AsString + ' - ' + Qr_Duplicata.FieldByName('EMP_NOME').AsString;
  E_Endereco_2.Caption:= Qr_Duplicata.FieldByName('END_ENDER').AsString + ', '+ Qr_Duplicata.FieldByName('END_NUMERO').AsString;
  E_Cidade_2.Caption:=Qr_Duplicata.FieldByName('CDD_DESCRICAO').AsString;
  E_Estado_2.Caption:=Qr_Duplicata.FieldByName('UFE_SIGLA').AsString;
  E_PracaPAgto_2.Caption:=Qr_Duplicata.FieldByName('CDD_DESCRICAO').AsString;
  E_Cep_2.Caption:= Fc_MascaraCep(Qr_Duplicata.FieldByName('END_CEP').AsString);
  IF Length(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString) = 11 then
    E_CNPJ_2.Caption:= fc_MascaraCPF(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString)
  else
    E_CNPJ_2.Caption:=fc_MascaraCNPJ(Qr_Duplicata.FieldByName('EMP_CNPJ').AsString);
  E_IncEstadual_2.Caption:=Qr_Duplicata.FieldByName('EMP_INSC_EST').AsString;
  E_DataEmissao_2.Caption:=DateToStr(Date);

end;

procedure TFr_RL_Duplicata.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);

begin
  with Qr_Duplicata do
  Begin
    E_Vl_Dup.Caption      :=  FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
    E_Vl_Dup_2.Caption    :=  FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);

    E_Dup_Os.Caption      :=  FieldByName('FIN_NUMERO').AsString;
    E_Dup_Os_2.Caption    :=  FieldByName('FIN_NUMERO').AsString;

    E_Fatura.Caption      :=  FieldByName('FIN_CODIGO').AsString;
    E_Fatura_2.Caption    :=  FieldByName('FIN_CODIGO').AsString;

    E_VL_Venda.Caption    :=  FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffFixed,10,2);
    E_VL_Venda_2.Caption  :=  FloatToStrF(FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffFixed,10,2);

    E_Vencim.Caption      :=  FieldByName('FIN_DT_VENCIMENTO').AsString;
    E_Vencim_2.Caption    :=  FieldByName('FIN_DT_VENCIMENTO').AsString;

    if (FieldByName('FIN_ALIQ_DESC').AsFloat > 0 )  then
    Begin
      E_Aliq_Valor_Limite_1.Caption :=  'Desconto de ' + FloatToStrF(FieldByName('FIN_ALIQ_DESC').AsFloat,ffFixed,10,2)  +'% Sobre R$ ' + FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2) + ' At� ' + FieldByName('FIN_DT_LIMIT_DESC').asAnsiString;
      E_Aliq_Valor_Limite_2.Caption :=  'Desconto de ' + FloatToStrF(FieldByName('FIN_ALIQ_DESC').AsFloat,ffFixed,10,2)  +'% Sobre R$ ' + FloatToStrF(FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2) + ' At� ' + FieldByName('FIN_DT_LIMIT_DESC').asAnsiString;
    End
    else
    Begin
      E_Aliq_Valor_Limite_1.Caption :=  'Desconto de                                                   % Sobre R$                          At�';
      E_Aliq_Valor_Limite_2.Caption :=  'Desconto de                                                   % Sobre R$                          At�';
    End;
    E_Condicao_1.Caption := 'Condições Especiais: ' + FieldByName('FIN_COND_ESPECIAIS').asAnsiString;
    E_Condicao_2.Caption := 'Condições Especiais: ' + FieldByName('FIN_COND_ESPECIAIS').asAnsiString;
  End;
end;

procedure TFr_RL_Duplicata.QRLabel35Print(sender: TObject;
  var Value: String);
Var
  lc_X:String;
  lc_Extenso:String;
begin

  lc_Extenso:= Fc_Extenso(Qr_Duplicata.FieldByName('FIN_VL_PARCELA').AsCurrency);
  lc_X:=' X-X-X-X ';
  E_ValorExtenso_2.Font.Size:=10;
  E_ValorExtenso_2.Font.Name:='Arial';

  E_ValorExtenso_2.Caption:=lc_Extenso+lc_X;

end;

procedure TFr_RL_Duplicata.E_ValorExtenso_2Print(sender: TObject;
  var Value: String);
begin
  E_ValorExtenso_2.Font.Size:=10;
  E_ValorExtenso_2.Font.Name:='Arial';

end;

procedure TFr_RL_Duplicata.QRLabel18Print(sender: TObject;
  var Value: String);
Var
lc_X:String;
lc_Extenso:String;

begin
  lc_Extenso:=fC_Extenso(Qr_Duplicata.FieldByName('FIN_VL_PARCELA').AsCurrency);
  lc_X:=' X-X-X-X ';
  E_ValorExtenso.Font.Size:=10;
  E_ValorExtenso.Font.Name:='Arial';
  E_ValorExtenso.Caption:=lc_Extenso+lc_X;


end;

end.

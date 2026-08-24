unit UN_RL_Orcamento_4;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Qrctrls, QuickRpt, ExtCtrls, STQuery, jpeg;

type
  TRL_Orcamento_4 = class(TForm)
    Qrpt: TQuickRep;
    Rodape: TQRBand;
    Cabecalho: TQRBand;
    Bd_DetalheStr: TQRStringsBand;
    Lb_Item: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Emp_Resp: TQRLabel;
    Lb_Emp_Vendedo: TQRLabel;
    Lb_MSG_Pecas: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    Lb_Validade: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    Lb_PrazoPagto: TQRLabel;
    QRLabel54: TQRLabel;
    Lb_PrazoEntrega: TQRLabel;
    QRLabel56: TQRLabel;
    Lb_Garantia: TQRLabel;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Lb_QtdeTotal: TQRLabel;
    Lb_UnitTotal: TQRLabel;
    Lb_Total: TQRLabel;
    LB_desconto: TQRLabel;
    QRLabel3: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_Ac: TQRLabel;
    QRLabel59: TQRLabel;
    QRMemo4: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRMemo13: TQRMemo;
    QRMemo14: TQRMemo;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo12: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    QRLabel14: TQRLabel;
    QRLabel22: TQRLabel;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_Orcamento: TQRLabel;
    Lb_Data: TQRLabel;
    Ex_Logo: TQRImage;
    Qr_Cotacao: TSTQuery;
    Qr_Cliente: TSTQuery;
    Qr_Itens: TSTQuery;
    QRBand2: TQRBand;
    Lb_End_Estabelecimento: TQRLabel;
    Lb_www_Estabelecimento: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Pedido : Integer;
    I_Item:Integer;
    I_Qtde:Integer;
    I_Desconto:Real;
    I_Total:real;
    I_VLUnit:real;
    procedure Pc_Orcamento;
    procedure Pc_Cliente;
    procedure Pc_Detalhe;
    procedure Pc_Rodape;

end;

var
RL_Orcamento_4:TRL_Orcamento_4;
implementation

uses     Un_Msg, Un_DM, UN_Pedido_Vda, Un_Nota_Fiscal, UN_Sistema, Un_Funcoes, Un_Regra_Negocio;
{$R *.DFM}


procedure TRL_Orcamento_4.Pc_Orcamento;
VaR
  SqlTxt:String;
  PCliente,PData,PPlaca,PFrota:Boolean;
  Lc_I:Integer;
  Lc_Ano,Lc_mes,Lc_dia:String;
begin
  Fc_BuscaImagemEmpresa(ex_Logo.Picture,'LOGO');
  Ex_Logo.Stretch:=TRUE;
  Bd_DetalheStr.Items.Clear;
  For Lc_I:=1 to 17 do
    Bd_DetalheStr.Items.Add(IntToStr(Lc_I));
  I_Item:=0;
  I_Qtde:=0;
  I_Total:=0;
  Screen.Cursor:=crHourGlass;
  Qr_Cotacao.Active:=False;
  Qr_Cotacao.ParamByName('PED_CODIGO').AsInteger:= It_Cd_Pedido;
  Qr_Cotacao.Active:=True;
  Qr_Cotacao.First;
  Lb_Orcamento.Caption:= Qr_Cotacao.FIELDBYNAME('CTC_NUMERO').AsString;

  Lc_dia := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Cotacao.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,7,4);

  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;

  Qr_Itens.Active:=False;
  Qr_Itens.ParamByName('PED_CODIGO').AsInteger:= It_Cd_Pedido;
  Qr_Itens.Active:=True;
  Qr_Itens.FetchAll;
  Bd_DetalheStr.Items.Clear;
  if Qr_Itens.RecordCount > 17 then
    Begin
    For Lc_I := 1 to 60 do
      Bd_DetalheStr.Items.Add(IntToStr(lc_I));
    end
  else
    Begin
    For Lc_I := 1 to 17 do
      Bd_DetalheStr.Items.Add(IntToStr(lc_I));
    end;
  Qr_Itens.First;

  Screen.Cursor:=crDefault;

end;

procedure TRL_Orcamento_4.Pc_Detalhe;
begin
  if ((I_Item+1)>Qr_Itens.RecordCount) then
    Begin
    Lb_Item.Font.Color:=clWhite;
    Lb_DescricaoProduto.Font.Color:=clWhite;
    Lb_Qtde.Font.Color:=clWhite;
    Lb_VlUnit.Font.Color:=clWhite;
    Lb_SubTotal.Font.Color:=clWhite;
    end
  else
    Begin
    Lb_Item.Font.Color:=clBlack;
    Lb_DescricaoProduto.Font.Color:=clBlack;
    Lb_Qtde.Font.Color:=clBlack;
    Lb_VlUnit.Font.Color:=clBlack;
    Lb_SubTotal.Font.Color:=clBlack;
    end;
  if not Qr_Itens.Eof then
    Begin
    Lb_Item.Caption:=Bd_DetalheStr.Items.Strings[I_ITem];
    Lb_DescricaoProduto.Caption:=Qr_Itens.FieldByname('ICT_CODVCL').AsString+' - '+ Qr_Itens.FieldByname('PRO_DESCRICAO').AsString;
    Lb_Qtde.Caption:=Qr_Itens.FieldByname('ICT_QTDE').AsString;
    Lb_VlUnit.Caption:=FloatToStrF(Qr_Itens.FieldByname('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
    Lb_SubTotal.Caption:=FloatToStrF(Qr_Itens.FieldByname('ICT_VL_TOTAL').AsCurrency,ffFixed,10,2);
    I_Qtde:=I_Qtde+Qr_Itens.FieldByname('ICT_QTDE').AsInteger;
    I_Total:=I_Total+Qr_Itens.FieldByname('ICT_VL_TOTAL').AsCurrency;
    Qr_Itens.Next;
    end;
    I_Item:=I_Item+1;
end;

procedure TRL_Orcamento_4.Pc_Rodape;
begin
  if Assigned(Fr_Pedido_Vda) then
    if Fr_Pedido_Vda.ChBx_Pecas.Checked then
      Lb_MSG_Pecas.Caption := 'Pe�as de reposição já inclusos no orçamento'
    else
      Lb_MSG_Pecas.Caption := 'Pe�as de Reposição e reempate de uni�o serão cobrados � parte';


  I_Desconto:=Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency;
  if I_Desconto>0 then
    LB_desconto.Caption:='Desconto Concedido de R$ '+ FloatToStrF(I_Desconto,ffFixed,10,2)
  else
    LB_desconto.Caption:='';
  Lb_QtdeTotal.Caption:=IntToStr(I_Qtde);
  Lb_UnitTotal.Caption:=FloatToStrF(((I_Total-I_Desconto)/I_Qtde),ffFixed,10,2);
  Lb_Total.Caption:=FloatToStrF((I_Total-I_Desconto),ffFixed,10,2);
  Lb_PrazoPagto.Caption:= Qr_Cotacao.FieldByname('FPT_DESCRICAO').AsString+ ' / '+ Qr_Cotacao.FieldByName('CTC_PRAZO').AsString;
  Lb_PrazoEntrega.Caption:=Qr_Cotacao.FieldByName('CTC_PRZ_ENTREGA').AsString;
  IF Length(Trim(Qr_Cotacao.FieldByName('CTC_GARANTIA').AsString))>0 then
     Lb_Garantia.Caption := Qr_Cotacao.FieldByName('CTC_GARANTIA').AsString;
  IF Length(Trim(Qr_Cotacao.FieldByName('CTC_VALIDADE').AsString))>0 then
    Lb_Validade.Caption:=Qr_Cotacao.FieldByName('CTC_VALIDADE').AsString;


  Lb_Emp_Resp.Caption:=DM.Qr_Estabelecimento.FieldByname('EMP_RESP_TEC').AsString;
  Lb_End_Estabelecimento.Caption := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString+', '+DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString  + ' - ' +
                                    DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString  + ' - ' +
                                    fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString);
  Lb_www_Estabelecimento.Caption:=DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString  + ' - ' + DM.Qr_Estabelecimento.FieldByName('EMP_EMAIL').AsString;
  DM.Qr_Colaborador.Active:=TRUE;

end;


procedure TRL_Orcamento_4.Pc_cliente;
Var
  CPF_CNPJ:String;
begin
  if (Qr_Cotacao.FieldByName('CTC_CODEMP').AsInteger >0) then
  Begin
    Qr_Cliente.Active := False;
    Qr_Cliente.ParamByName('EMP_CODIGO').AsString := Qr_Cotacao.FieldByName('CTC_CODEMP').AsString;
    Qr_Cliente.Active := True;
    Qr_Cliente.First;
    Lb_Cli_Nome.Caption   := Qr_Cliente.FieldByname('EMP_NOME').AsString;
    Lb_Cli_Ac.Caption:= Qr_Cliente.FieldByname('END_CONTATO').AsString;
  end
  else
  Begin
    Lb_Cli_Nome.Caption := Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString;
    Lb_Cli_Ac.Caption:= Qr_Cotacao.FieldByname('END_CONTATO').AsString;
  end;
end;

procedure TRL_Orcamento_4.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  Pc_Orcamento;
  Pc_Cliente;
end;

procedure TRL_Orcamento_4.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Detalhe;
end;

procedure TRL_Orcamento_4.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

end.




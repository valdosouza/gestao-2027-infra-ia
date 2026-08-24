unit Un_RL_PedidoVenda_2;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Qrctrls, QuickRpt, ExtCtrls, STQuery, System.Math;

type
  TRL_PedidoVenda_2 = class(TForm)
    Qrpt: TQuickRep;
    Rodape: TQRBand;
    Cabecalho: TQRBand;
    S_Empresa: TQRMemo;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    Lb_Emp_Endereco: TQRLabel;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Bairro: TQRLabel;
    Lb_Emp_CNPJ: TQRLabel;
    Lb_Emp_Codigo: TQRLabel;
    Lb_Emp_cep: TQRLabel;
    Lb_Emp_Cidade: TQRLabel;
    Lb_Emp_IncEst: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel45: TQRLabel;
    Lb_Emp_email: TQRLabel;
    QRLabel46: TQRLabel;
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
    QRLabel21: TQRLabel;
    Lb_Data: TQRLabel;
    QRLabel42: TQRLabel;
    Lb_Emp_Fone: TQRLabel;
    QRLabel43: TQRLabel;
    Lb_Emp_Fax: TQRLabel;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Qr_Pedido: TSTQuery;
    Lb_QtdeTotal: TQRLabel;
    Lb_UnitTotal: TQRLabel;
    Lb_Total: TQRLabel;
    QRSysData1: TQRSysData;
    LB_desconto: TQRLabel;
    QRMemo1: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_Cnpj: TQRLabel;
    Lb_Cli_Codigo: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Cli_FoneR: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel35: TQRLabel;
    Lb_Cli_Portaria: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Cli_Email: TQRLabel;
    QRLabel38: TQRLabel;
    Lb_Cli_AtAdm: TQRLabel;
    QRLabel48: TQRLabel;
    Lb_Cli_Vendedor: TQRLabel;
    Lb_Cli_Ac: TQRLabel;
    QRLabel59: TQRLabel;
    QRMemo4: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo2: TQRMemo;
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
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    QRLabel14: TQRLabel;
    QRLabel22: TQRLabel;
    Qr_Itens: TSTQuery;
    QRBand1: TQRBand;
    Ex_Logo: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Tipo: TQRLabel;
    Lb_Orcamento: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Otr_Despesas: TQRLabel;
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
    It_Nr_Pedido : String;
    It_Cd_Pedido : Integer;
    I_Item:Integer;
    I_Qtde:Real;
    I_Desconto:Real;
    I_Otr_depesas:Real;
    I_Total:real;
    I_VLUnit:real;
    procedure Pc_Orcamento;
    procedure Pc_Empresa;
    procedure Pc_Cliente;
    procedure Pc_Detalhe;
    procedure Pc_Rodape;

end;

var
RL_PedidoVenda_2:TRL_PedidoVenda_2;
implementation

uses     Un_Msg, Un_DM, UN_Pedido_Vda, Un_Nota_Fiscal, UN_Sistema, Un_Regra_Negocio, Un_Principal, env;
{$R *.DFM}


procedure TRL_PedidoVenda_2.Pc_Orcamento;
VaR
  Lc_I:Integer;
begin
  Bd_DetalheStr.Items.Clear;
  For Lc_I:=1 to 17 do
    Bd_DetalheStr.Items.Add(IntToStr(Lc_I));
  I_Item:=0;
  I_Qtde:=0;
  I_Total:=0;
  Screen.Cursor:=crHourGlass;
  Qr_Pedido.Active:=False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger:= It_Cd_Pedido;
  Qr_Pedido.Active:=True;
  Qr_Pedido.First;
  Lb_Orcamento.Caption:= It_Nr_Pedido;
  Qr_Itens.Active:=False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger:= It_Cd_Pedido;
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
  Lb_Data.Caption := Qr_Pedido.FieldByName('PED_DATA').AsString;

  Screen.Cursor:=crDefault;

end;

procedure TRL_PedidoVenda_2.Pc_Detalhe;
Var
  LcValor : Real;
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
    Lb_DescricaoProduto.Caption:=Qr_Itens.FieldByName('ITF_CODPRO').AsString+' - '+ Qr_Itens.FieldByName('PRO_DESCRICAO').AsString;
    Lb_Qtde.Caption:= formatFloat('#,##0.###',Qr_Itens.FieldByName('ITF_QTDE').AsFloat);
    Lb_VlUnit.Caption:=FloatToStrF(Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency,ffFixed,10,2);
    I_Qtde:=I_Qtde+Qr_Itens.FieldByName('ITF_QTDE').AsFloat;
    LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
    LcValor := RoundTo(LcValor,-2);
    Lb_SubTotal.Caption:=FloatToStrF(LcValor,ffFixed,10,2);
    I_Total := I_Total+ LcValor;
    Qr_Itens.Next;
  end;
    I_Item:=I_Item+1;
end;

procedure TRL_PedidoVenda_2.Pc_Rodape;
begin

  if Assigned(Fr_Pedido_Vda) then
    if Fr_Pedido_Vda.ChBx_Pecas.Checked then
      Lb_MSG_Pecas.Caption := 'Peças de reposição já inclusos no orçamento';

  I_Otr_depesas := Qr_Pedido.FieldByName('PED_VL_ODESPESA').AsCurrency;
  if I_Otr_depesas>0 then
    Lb_Otr_Despesas.Caption:='Outras Despesas R$ '+ FloatToStrF(I_Otr_depesas,ffFixed,10,2)
  else
    Lb_Otr_Despesas.Caption:='';



  I_Desconto:=Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency;
  if I_Desconto>0 then
    LB_desconto.Caption:='Desconto R$ '+ FloatToStrF(I_Desconto,ffFixed,10,2)
  else
    LB_desconto.Caption:='';
  Lb_QtdeTotal.Caption:= FloatToStr(I_Qtde);
  Lb_UnitTotal.Caption:=FloatToStrF(((I_Total-I_Desconto+I_Otr_depesas)/I_Qtde),ffFixed,10,2);
  Lb_Total.Caption:=FloatToStrF((I_Total-I_Desconto+I_Otr_depesas),ffFixed,10,2);
  Lb_PrazoPagto.Caption:= Qr_Pedido.FieldByName('FPT_DESCRICAO').AsString+ ' / '+ Qr_Pedido.FieldByName('PED_PRAZO').AsString;
  Lb_PrazoEntrega.Caption:=Qr_Pedido.FieldByName('PED_DT_ENTREGA').AsString;
//  Lb_Validade.Caption:='ORÇAMENTO VÁLIDDO ATÉ '+Qr_PedidoPED_VALIDADE.AsString;
  Lb_Emp_Resp.Caption:= DM.Qr_Estabelecimento.FieldByName('EMP_RESP_TEC').AsString;
  DM.Qr_Colaborador.Active:=TRUE;

end;

procedure TRL_PedidoVenda_2.Pc_Empresa;
begin
  with DM.Qr_Estabelecimento do
    Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    Lb_Emp_Nome.Caption     := FieldByName('EMP_CODIGO').AsString + ' - ' + FieldByName('EMP_NOME').AsString;
    Lb_Emp_Codigo.Caption   := FieldByName('EMP_CODIGO').AsString;
    Lb_Emp_Endereco.Caption := FieldByName('END_ENDER').AsString +', '+FieldByName('END_NUMERO').AsString;
    Lb_Emp_cep.Caption      := FieldByName('END_CEP').AsString;
    Lb_Emp_Fone.Caption     := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Emp_Bairro.Caption   := FieldByName('END_BAIRRO').AsString;
    Lb_Emp_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
    Lb_Emp_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
    Lb_Emp_CNPJ.Caption     := FieldByName('EMP_CNPJ').AsString;
    Lb_Emp_IncEst.Caption   := FieldByName('EMP_INSC_EST').AsString;
    Lb_Emp_email.Caption    := FieldByName('EMP_EMAIL').AsString;
    if Length(FieldByName('EMP_CNPJ').AsString)=11 then
      Lb_Emp_CNPJ.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString)
    else
      Lb_Emp_CNPJ.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    end;
end;

procedure TRL_PedidoVenda_2.Pc_cliente;
begin
  with Qr_Pedido do
    Begin
    Lb_Cli_Nome.Caption     := FieldByName('EMP_NOME').AsString;
    Lb_Cli_Codigo.Caption   := FieldByName('EMP_CODIGO').AsString;
    Lb_Cli_FoneR.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString +', '+FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption      := FieldByName('END_CEP').AsString;
    Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_COMERCIAL').AsString);
    Lb_Cli_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
    Lb_Cli_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
    Lb_Cli_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
    if Length(FieldByName('EMP_CNPJ').AsString)=11 then
      Lb_Cli_Cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString)
    else
      Lb_Cli_Cnpj.Caption:= fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);

    Lb_Cli_IncEst.Caption   := FieldByName('EMP_INSC_EST').AsString;
    Lb_Cli_Celular.Caption  := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
    Lb_Cli_Email.Caption    := FieldByName('EMP_EMAIL').AsString;
    Lb_Cli_Vendedor.Caption := FieldByName('CLB_NOME').AsString;
    Lb_Cli_Portaria.Caption := fc_MascaraFone(FieldByName('END_PORTARIA').AsString);
    Lb_Cli_AtAdm.Caption    := FieldByName('EMP_CONTATO_ADM').AsString;
    Lb_Cli_Ac.Caption       := FieldByName('END_CONTATO').AsString;
    end;

end;

procedure TRL_PedidoVenda_2.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Fc_BuscaImagemEmpresa(Ex_Logo.Picture,'LOGO');
  Pc_Orcamento;
  Pc_Empresa;
  Pc_Cliente;
end;

procedure TRL_PedidoVenda_2.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Detalhe;
end;

procedure TRL_PedidoVenda_2.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

end.




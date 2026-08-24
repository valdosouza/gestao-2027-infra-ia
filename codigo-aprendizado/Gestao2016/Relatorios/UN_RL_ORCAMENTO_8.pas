unit UN_RL_ORCAMENTO_8;

interface

uses
      Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, StdCtrls, Qrctrls, QuickRpt, ExtCtrls, STQuery, jpeg;

type
  TRL_Orcamento_8 = class(TForm)
    Qr_Cotacao: TSTQuery;
    Qr_Cliente: TSTQuery;
    Qr_Itens: TSTQuery;
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    E_Obs_Saudacao: TQRMemo;
    Cliente: TQRBand;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo12: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    Lb_Orcamento: TQRLabel;
    Lb_Data: TQRLabel;
    Bd_DetalheStr: TQRStringsBand;
    QRMemo15: TQRMemo;
    QRMemo16: TQRMemo;
    QRMemo14: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo13: TQRMemo;
    Lb_Item: TQRLabel;
    Lb_DescricaoProduto: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_VlUnit: TQRLabel;
    Lb_SubTotal: TQRLabel;
    Rodape: TQRBand;
    QRMemo11: TQRMemo;
    QRLabel17: TQRLabel;
    Lb_Emp_Vendedo: TQRLabel;
    E_VL_SubTotal: TQRLabel;
    E_Obs_Orientacao: TQRMemo;
    QRMemo1: TQRMemo;
    E_Vl_Desconto: TQRLabel;
    QRMemo2: TQRMemo;
    E_VL_total: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_TipoCob: TQRLabel;
    QRLabel8: TQRLabel;
    E_Obs: TQRMemo;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape20: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CNPJ: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_Cnpj: TQRLabel;
    Lb_Cli_Codigo: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    Lb_Ie: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Cli_Complemento: TQRLabel;
    QRLabel18: TQRLabel;
    Lb_Cli_Contato: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
RL_Orcamento_8:TRL_Orcamento_8;
implementation

uses     Un_Msg, Un_DM, UN_Pedido_Vda, Un_Nota_Fiscal, UN_Sistema, Un_Funcoes, Un_Regra_Negocio, Un_Principal, env;
{$R *.DFM}


procedure TRL_Orcamento_8.Pc_Orcamento;
VaR
  SqlTxt:String;
  PCliente,PData,PPlaca,PFrota:Boolean;
  Lc_I:Integer;
  Lc_Ano,Lc_mes,Lc_dia:String;
begin
  E_Obs_Saudacao.Lines.Assign(Fc_Tb_Geral_Detalhe('L','OSR_EXT_SAUDACAO',''));
  DM.Qr_Estabelecimento.Active := False;
  DM.Qr_Estabelecimento.ParamByName('EMP_CODIGO').AsInteger :=Gb_CodMha;
  DM.Qr_Estabelecimento.Active := true;

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

procedure TRL_Orcamento_8.Pc_Detalhe;
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
    Lb_DescricaoProduto.Caption:=Qr_Itens.FieldByName('ICT_CODVCL').AsString+' - '+ Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
    Lb_Qtde.Caption:=Qr_Itens.FieldByName('ICT_QTDE').AsString;
    Lb_VlUnit.Caption:=FloatToStrF(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
    Lb_SubTotal.Caption:=FloatToStrF(Qr_Itens.FieldByName('ICT_VL_TOTAL').AsCurrency,ffFixed,10,2);
    I_Qtde:=I_Qtde+Qr_Itens.FieldByName('ICT_QTDE').AsInteger;
    I_Total:=I_Total+Qr_Itens.FieldByName('ICT_VL_TOTAL').AsCurrency;
    Qr_Itens.Next;
    end;
    I_Item:=I_Item+1;
end;


procedure TRL_Orcamento_8.Pc_Rodape;
Var
  Lc_Texto: TMemoryStream;
  Lc_Linhas : Integer;
  Lc_Top : Integer;
begin
  //Forma de Pagameno
  Lb_TipoCob.Caption := Qr_Cotacao.FieldByName('FPT_DESCRICAO').AsString + ' - ' + Qr_Cotacao.FieldByName('CTC_PRAZO').AsString;
  //Observação
  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Cotacao.CreateBlobStream(Qr_Cotacao.FieldByName('CTC_OBS'), bmRead));
  E_Obs.Lines.LoadFromStream(lC_Texto);
  E_Obs.AutoStretch := True;
  Lc_Linhas := (E_Obs.Lines.Count - 1);
  Lc_Top := (Lc_Linhas * 22);
  Lc_Texto.Free;
  //Totalizadores
  I_Desconto:=Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency;
  E_VL_SubTotal.Caption := FloatToStrF(I_Total,ffFixed,10,2);
  E_Vl_Desconto.Caption := FloatToStrF(I_Desconto,ffFixed,10,2);
  E_VL_total.Caption := FloatToStrF(I_Total-I_Desconto,ffFixed,10,2);
  //Orientação TÉccnica
  Lc_Top := Lc_Top + E_Obs.Top + 2;
  if Lc_Top < 128 then Lc_Top := 128;
  E_Obs_Orientacao.Top :=  Lc_Top;
  E_Obs_Orientacao.Lines.Assign(Fc_Tb_Geral_Detalhe('L','OSR_EXT_ORIENTACAO',''));
  E_Obs_Orientacao.AutoStretch := True;

end;


procedure TRL_Orcamento_8.Pc_cliente;
Var
  CPF_CNPJ:String;
begin
  with Qr_Cliente do
    Begin
    if (Qr_Cotacao.FieldByName('CTC_CODEMP').AsInteger >0) then
      Begin
      Active := False;
      ParamByName('EMP_CODIGO').AsString := Qr_Cotacao.FieldByName('CTC_CODEMP').AsString;
      Active := True;
      Qr_Cliente.First;
      Lb_Cli_Nome.Caption     := FieldByName('EMP_NOME').AsString;
      Lb_Cli_Codigo.Caption   := FieldByName('EMP_CODIGO').AsString;
      Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
      Lb_Cli_cep.Caption      := fc_MascaraCep(FieldByName('END_CEP').AsString);
      Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
      Lb_Cli_Complemento.Caption := FieldByName('END_COMPLEM').AsString;
      Lb_Cli_Contato.Caption     := FieldByName('END_CONTATO').AsString;
      Lb_Cli_bairro.Caption   := FieldByName('END_BAIRRO').AsString;
      Lb_Cli_Cidade.Caption   := FieldByName('CDD_DESCRICAO').AsString;
      Lb_Cli_Fax.Caption      := fc_MascaraFone(FieldByName('END_FAX').AsString);
      if Length(FieldByName('EMP_CNPJ').AsString)=11 then
        Begin
        Lb_CNPJ.Caption := 'C.P.F: ';
        Lb_Ie.Caption   := 'Identidade: ';
        Lb_Cli_Cnpj.Caption   := fc_MascaraCPF(FieldByName('EMP_CNPJ').AsString);
        end
      else
        Begin
        Lb_CNPJ.Caption := 'C.N.P.J: ';
        Lb_Ie.Caption   := 'Insc. Estadual :';
        Lb_Cli_Cnpj.Caption   := fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
        end;
      Lb_Cli_IncEst.Caption := FieldByName('EMP_INSC_EST').AsString;
      Lb_Cli_Celular.Caption := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
      end
    else
      Begin
      Lb_Cli_Nome.Caption     := Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString;
      Lb_Cli_Codigo.Caption   := '00000';
      Lb_Cli_Endereco.Caption := '';
      Lb_Cli_cep.Caption      := '00000-000';
      Lb_Cli_FoneC.Caption    := '';
      Lb_Cli_Complemento.Caption := '';
      Lb_Cli_Contato.Caption     := Qr_Cotacao.FieldByName('CTC_CONTATO').AsString;
      Lb_Cli_bairro.Caption   := '';
      Lb_Cli_Cidade.Caption   := '';
      Lb_Cli_Fax.Caption      := '';
      Lb_CNPJ.Caption := 'Doc1: ';
      Lb_Ie.Caption   := 'Doc2: ';
      Lb_Cli_Cnpj.Caption   := '';
      Lb_Cli_IncEst.Caption := '';
      end;
    end;

end;

procedure TRL_Orcamento_8.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Pc_Orcamento;
  Pc_Cliente;
end;

procedure TRL_Orcamento_8.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Detalhe;
end;

procedure TRL_Orcamento_8.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_Orcamento_8 := Nil;
end;

procedure TRL_Orcamento_8.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Pc_Rodape;
end;

end.




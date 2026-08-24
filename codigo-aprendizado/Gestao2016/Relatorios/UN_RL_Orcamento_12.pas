unit UN_RL_Orcamento_12;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, StdCtrls, QRPDFFilt;

type
  TRL_Orcamento_13 = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    Bd_DetalheStr: TQRStringsBand;
    QRBand4: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Orcamento: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    QRPDFFilter1: TQRPDFFilter;
    QRMemo11: TQRMemo;
    QRLabel3: TQRLabel;
    Lb_Obs: TQRMemo;
    LB_TextoDesconto: TQRLabel;
    LB_VL_Desconto: TQRLabel;
    QRPDFShape5: TQRMemo;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Fone: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_cidade: TQRLabel;
    Lb_Cli_fax: TQRLabel;
    Lb_Cli_cnpj: TQRLabel;
    Lb_Cli_ie: TQRLabel;
    Lb_Cli_celular: TQRLabel;
    Lb_Cli_Codigo: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Cli_email: TQRLabel;
    QRBand3: TQRBand;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    QRMemo2: TQRMemo;
    QRLabel2: TQRLabel;
    Qr_Cotacao: TSTQuery;
    Qr_Itens: TSTQuery;
    Qr_Produto: TSTQuery;
    E_Descricao: TQRMemo;
    E_Qtde: TQRMemo;
    E_VL_Unitario: TQRMemo;
    E_Vl_Unit_Total: TQRMemo;
    QRMemo1: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    ChildBand1: TQRChildBand;
    Lb_Usuario: TQRLabel;
    Lb_Assinatura: TQRLabel;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Vendedor:String;
    It_Cd_Pedido : Integer;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
    Procedure Pc_PreenheCli;
    procedure Pc_Cabecalho;
  end;

var
  RL_Orcamento_13: TRL_Orcamento_13;

implementation

uses      Un_Funcoes, UN_Sistema, Un_DM, Mask, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

Procedure TRL_Orcamento_13.Pc_PreenheCli;
BEgin
  if trim(Qr_Cotacao.FieldByName('EMP_NOME').AsString)<>'' then
    Lb_Cli_Nome.Caption := Qr_Cotacao.FieldByName('EMP_NOME').AsString + ' - ' + Qr_Cotacao.FieldByName('EMP_FANTASIA').AsString
  else
    Lb_Cli_Nome.Caption := Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString;

  Lb_Cli_endereco.Caption := Qr_Cotacao.FieldByName('END_ENDER').AsString +', '+ Qr_Cotacao.FieldByName('END_NUMERO').AsString ;
  Lb_Cli_cep.Caption := Qr_Cotacao.FieldByName('END_CEP').AsString;
  Lb_Cli_fone.Caption := fc_MascaraFone(Qr_Cotacao.FieldByName('END_FONE').AsString);
  Lb_Cli_bairro.Caption := Qr_Cotacao.FieldByName('END_BAIRRO').AsString;
  Lb_Cli_cidade.Caption := Qr_Cotacao.FieldByName('CDD_DESCRICAO').AsString;
  Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Cotacao.FieldByName('END_CELULAR').AsString);
  Lb_Cli_fax.Caption := fc_MascaraFone(Qr_Cotacao.FieldByName('END_FAX').AsString);
  if Length(Qr_Cotacao.FieldByName('EMP_CNPJ').AsString)=11 then
    Lb_Cli_cnpj.Caption := fc_MascaraCPF(Qr_Cotacao.FieldByName('EMP_CNPJ').AsString)
  else
    Lb_Cli_cnpj.Caption := fc_MascaraCNPJ(Qr_Cotacao.FieldByName('EMP_CNPJ').AsString);
  Lb_Cli_ie.Caption := Qr_Cotacao.FieldByName('EMP_INSC_EST').AsString;
  Lb_Cli_Codigo.Caption := Qr_Cotacao.FieldByName('EMP_CODIGO').AsString;
  Lb_Cli_email.Caption := Qr_Cotacao.FieldByName('EMP_EMAIL').AsString;
end;

Procedure TRL_Orcamento_13.PC_VAlidaCampos(Pc_Print : Boolean);
Var
  Lc_Altura:Integer;
Begin
  E_Descricao.Lines.Clear;
  E_Qtde.Lines.Clear;
  E_VL_Unitario.Lines.Clear;
  E_Vl_Unit_Total.Lines.Clear;
  //Ajusta Altura dos Campos
  Lc_Altura := 20;
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Descricao.Height := Lc_Altura;
  E_Qtde.Height := Lc_Altura;
  E_VL_Unitario.Height := Lc_Altura;
  E_Vl_Unit_Total.Height := Lc_Altura;
  Bd_DetalheStr.Repaint;
  Bd_DetalheStr.Refresh;
end;

Procedure TRL_Orcamento_13.PC_PreencheCampos;
Var
  Lc_Altura : Integer;
  Lc_Obs : TMemo;
  Lc_Produto : String;
Begin
  Qr_Produto.Active := False;
  Qr_Produto.ParamByName('PRO_CODIGO').AsInteger := Qr_Itens.FieldByName('ICT_CODVCL').AsInteger;
  Qr_Produto.Active := True;
  Qr_Produto.FetchAll;
  Qr_Produto.First;
  if Qr_Produto.RecordCount > 0 then
  begin
    Lc_Produto := Qr_Produto.FieldByName('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByName('ICT_DESCRICAO').AsString + ' / ' + Qr_Produto.FieldByName('MRC_DESCRICAO').AsString
  end
  else
  begin
    Lc_Produto := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  end;
  
  lc_obs := TMemo.Create(Self);
  lc_obs.Visible := false;
  lc_obs.Parent := Self;
  Lc_Obs.Width := E_Descricao.Width;
  Lc_Obs.Lines.Clear;
  Lc_Obs.Font.Size := 8;
  Lc_Obs.Lines.Add(Lc_Produto);
  Lc_Altura := Lc_Obs.Lines.Count;
  FreeAndNil(Lc_Obs);
  IF (Lc_Altura > 1) then
    Lc_Altura := Lc_Altura * 15
  else
    Lc_Altura := Lc_Altura * 20;
  //Ajusta Altura dos Campos
  Bd_DetalheStr.Height := Lc_Altura + 1;
  E_Descricao.Height := Lc_Altura;
  //Impressão dos campos
  E_Descricao.Lines.Add(' ' + Lc_Produto);
  E_Descricao.Refresh;
  E_Descricao.Repaint;
  E_Qtde.Height := Lc_Altura;
  E_Qtde.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0) + ' ');
  E_Qtde.Refresh;
  E_Qtde.Repaint;
  E_VL_Unitario.Height := Lc_Altura;
  E_VL_Unitario.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2) + ' ');
  E_VL_Unitario.Refresh;
  E_VL_Unitario.Repaint;
  E_Vl_Unit_Total.Height := Lc_Altura;
  E_Vl_Unit_Total.Lines.Add(FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2) + ' ');
  E_Vl_Unit_Total.Refresh;
  E_Vl_Unit_Total.Repaint;

end;

procedure TRL_Orcamento_13.Pc_Cabecalho;
begin
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Fc_BuscaImagemEmpresa(img_logo.Picture, 'LOGO');
    Lb_Emp_Nome.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString) + ' -  I.E.: '+ FieldByName('EMP_INSC_EST').AsString;
    Lb_Emp_End.Caption := FieldByName('END_ENDER').AsString + ', '+ FieldByName('END_NUMERO').AsString + ' - ' + FieldByName('END_BAIRRO').AsString + ' - ' + Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' + FieldByName('CDD_DESCRICAO').AsString + ' - ' + FieldByName('UFE_SIGLA').AsString + ' - Fone: ' +fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Emp_www.Caption := FieldByName('EMP_SITE').AsString;
    Lb_Emp_email.Caption := FieldByName('EMP_EMAIL').AsString;
  END;
end;

procedure TRL_Orcamento_13.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_AtivaEstabelecimento;
  Pc_Cabecalho;
  Qr_Cotacao.Active := False;
  Qr_Cotacao.ParamByName('CTC_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Cotacao.Active := True;


  Lb_Orcamento.Caption := 'Orçamento Nº '+ Qr_Cotacao.FieldByName('CTC_NUMERO').AsString;
  Lc_dia := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Cotacao.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,7,4);

  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;
  Pc_PreenheCli;
  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Qr_Cotacao.FieldByName('CTC_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  Bd_DetalheStr.Items.Clear;
  For Lc_I:=1 to Qr_Itens.RecordCount do
    Bd_DetalheStr.Items.Add(IntTOStr(lc_I));
  Qr_Itens.First;



end;

procedure TRL_Orcamento_13.Bd_DetalheStrBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Not Qr_Itens.Eof then
    Begin
    pc_ValidaCampos(True);
    Pc_PreencheCAmpos;
    Qr_Itens.Next;
    end
  else
    pc_ValidaCampos(False);
end;

procedure TRL_Orcamento_13.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
  Lc_obs : TMemo;
begin

  if (Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency > 0) then
    Begin
    LB_TextoDesconto.Font.Color := clBlack;
    LB_VL_Desconto.Font.Color := clBlack;
    LB_VL_Desconto.Caption := FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency,ffFixed,10,2);
    end
  else
    Begin
    LB_TextoDesconto.Font.Color := clWhite;
    LB_VL_Desconto.Font.Color := clWhite;
    LB_VL_Desconto.Caption := '0,00';
    end;
  Lb_Vl_Geral.Caption := 'R$ ' + FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_COTACAO').AsCurrency,ffFixed,10,2);
  Lc_obs := TMemo.Create(RL_Orcamento_7);
  Lc_obs.Parent := RL_Orcamento_7;
  Lc_obs.Visible := False;
  Lc_obs.Width := 725;
  Lc_obs.Text := Qr_Cotacao.FieldByName('CTC_OBS').AsString;
  Lb_obs.Lines.Clear;
  Lb_obs.Lines.Add('Prazo e Forma de Pagamento : ' + Qr_Cotacao.FieldByName('CTC_PRAZO').AsString);
  For Lc_I := 0 to Lc_obs.Lines.Count - 1 do
    Lb_Obs.Lines.Add(Lc_obs.Lines[lc_I]);
  Lb_Usuario.Caption := UpperCase('Vendedor: '+GB_Nm_Usuario);
end;

procedure TRL_Orcamento_13.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qrpt);
  Action := caFree;
  RL_Orcamento_7 := nil;
end;

end.

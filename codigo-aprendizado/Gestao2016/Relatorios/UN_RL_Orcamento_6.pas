unit UN_RL_Orcamento_6;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, QRPDFFilt, StdCtrls;

type
  TRL_Orcamento_6 = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRStringsBand;
    QRBand4: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Orcamento: TQRLabel;
    Lb_Produto: TQRLabel;
    Lb_Quantidade: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    Lb_Vl_Subtotal: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    Qr_Itens: TSTQuery;
    Lb_Usuario: TQRLabel;
    QRBand1: TQRBand;
    Lb_Validade: TQRLabel;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRLabel19: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    Lb_Assinatura: TQRLabel;
    QRMemo11: TQRMemo;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    Lb_Obs: TQRMemo;
    LB_TextoDesconto: TQRLabel;
    LB_VL_Desconto: TQRLabel;
    QRMemo2: TQRMemo;
    QRMemo4: TQRMemo;
    Lb_Tecido: TQRLabel;
    Lb_Cor: TQRLabel;
    Label1: TLabel;
    QRMemo15: TQRMemo;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    Lb_CPFCNPJ: TQRLabel;
    Lb_Cli_Endereco: TQRLabel;
    Lb_Cli_Nome: TQRLabel;
    Lb_Cli_bairro: TQRLabel;
    Lb_Cli_Cnpj: TQRLabel;
    Lb_Cli_cep: TQRLabel;
    Lb_Cli_Cidade: TQRLabel;
    Lb_Cli_IncEst: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel36: TQRLabel;
    Lb_Cli_Email: TQRLabel;
    QRLabel48: TQRLabel;
    Lb_Emp_Contato: TQRLabel;
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Cli_UF: TQRLabel;
    Qr_Ordem: TSTQuery;
    QRMemo12: TQRMemo;
    QRMemo13: TQRMemo;
    QRMemo14: TQRMemo;
    QRMemo16: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    QRMemo22: TQRMemo;
    QRMemo23: TQRMemo;
    QRMemo24: TQRMemo;
    QRMemo25: TQRMemo;
    QRMemo26: TQRMemo;
    Lb_T01: TQRLabel;
    Lb_T02: TQRLabel;
    Lb_T03: TQRLabel;
    Lb_T04: TQRLabel;
    Lb_T05: TQRLabel;
    Lb_T06: TQRLabel;
    Lb_T07: TQRLabel;
    Lb_QT07: TQRLabel;
    Lb_QT06: TQRLabel;
    Lb_QT05: TQRLabel;
    Lb_QT04: TQRLabel;
    Lb_QT03: TQRLabel;
    Lb_QT02: TQRLabel;
    Lb_QT01: TQRLabel;
    Qr_Tamanho: TSTQuery;
    Qr_Cliente: TSTQuery;
    E_obsOrcamento: TMemo;
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Pedido : Integer;

    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
    Procedure Pc_PreencheGrade;
    procedure Pc_Orcamento;
end;

var
  RL_Orcamento_6: TRL_Orcamento_6;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}
Procedure TRL_Orcamento_6.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
    BEgin
    Lb_Produto.Font.Color := clBlack;
    Lb_Tecido.Font.Color := clBlack;
    Lb_Cor.Font.Color := clBlack;
    Lb_Quantidade.Font.Color := clBlack;
    Lb_Vl_Unitario.Font.Color := clBlack;
    Lb_Vl_Subtotal.Font.Color := clBlack;
    end
  else
    BEgin
    Lb_Produto.Font.Color := clWhite;
    Lb_Tecido.Font.Color := clWhite;
    Lb_Cor.Font.Color := clWhite;
    Lb_Quantidade.Font.Color := clWhite;
    Lb_Vl_Unitario.Font.Color := clWhite;
    Lb_Vl_Subtotal.Font.Color := clWhite;
    end;

end;

Procedure TRL_Orcamento_6.Pc_PreencheGrade;
Var
  Lc_I : integer;
  Lc_Name : String;
Begin
  Qr_Tamanho.Active := False;
  Qr_Tamanho.ParamByName('GRT_CODICT').AsInteger := Qr_Itens.FieldByName('ICT_CODIGO').AsInteger;
  Qr_Tamanho.Active := True;
  Qr_Tamanho.FetchAll;
  Qr_Tamanho.First;
  For Lc_I := 1 to 7 do
    Begin
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clWhite;
    Lc_Name := 'Lb_QT0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clWhite;
    end;
  Lc_I := 1;
  while not Qr_Tamanho.Eof do
    Begin
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_TAMANHO').AsString;
    Lc_Name := 'Lb_T0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_TAMANHO').AsString;
    Lc_Name := 'Lb_QT0' + IntToStr(Lc_I);
    TQRLabel(FindComponent(Lc_Name)).Font.Color := clBlack;
    TQRLabel(FindComponent(Lc_Name)).Caption := Qr_Tamanho.FieldByName('GRT_QTDE').AsString;
    Qr_Tamanho.Next;
    Inc(Lc_I);
    end;

end;

Procedure TRL_Orcamento_6.PC_PreencheCampos;
Begin
  Lb_Produto.Caption := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  Lb_Tecido.Caption := Qr_Itens.FieldByName('ICT_TECIDO').AsString;
  Lb_Cor.Caption := Qr_Itens.FieldByName('ICT_COR').AsString;
  Pc_PreencheGrade;
  Lb_Quantidade.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0);
  Lb_Vl_Unitario.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
  Lb_Vl_Subtotal.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
end;

procedure TRL_Orcamento_6.Pc_Orcamento;
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Pc_Cab_Relatorio(Qrpt);
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('CTC_CODPED').AsInteger := It_cd_Pedido;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  E_obsOrcamento.Text := Qr_Ordem.FieldByName('CTC_OBS').AsString;
  Lb_Orcamento.Caption := 'Orçamento Nº '+ Qr_Ordem.FieldByName('CTC_NUMERO').AsString;
  Lc_dia := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Ordem.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,7,4);

  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ', '+ Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;

  Qr_Cliente.Active := False;
  Qr_Cliente.ParamByName('EMP_CODIGO').AsInteger := Qr_Ordem.FieldByName('CTC_CODEMP').AsInteger;
  Qr_Cliente.Active := True;
  Qr_Cliente.FetchAll;

  DM.Qr_Endereco.Active := False;
  DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Ordem.FieldByName('CTC_CODEMP').AsInteger;
  DM.Qr_Endereco.Active := True;


  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Qr_Ordem.FieldByName('CTC_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.FetchAll;
  DetalheVenda.Items.Clear;
  For Lc_I:=1 to Qr_Itens.RecordCount do
    DetalheVenda.Items.Add(IntTOStr(lc_I));
  Qr_Itens.First;
end;


procedure TRL_Orcamento_6.DetalheVendaBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_Orcamento_6.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
begin
  Lb_Validade.Caption := Qr_Ordem.FieldByName('CTC_PRZ_ENTREGA').AsString;
  if (Qr_Ordem.FieldByName('CTC_VL_DESCONTO').AsCurrency > 0 ) then
    Begin
    LB_TextoDesconto.Font.Color := clBlack;
    LB_VL_Desconto.Font.Color := clBlack;
    LB_VL_Desconto.Caption := FloatToStrF(Qr_Ordem.FieldByName('CTC_VL_DESCONTO').AsCurrency,ffFixed,10,2);
    end
  else
    Begin
    LB_TextoDesconto.Font.Color := clWhite;
    LB_VL_Desconto.Font.Color := clWhite;
    LB_VL_Desconto.Caption := '0,00';
    end;
  Lb_Vl_Geral.Caption := FloatToStrF(Qr_Ordem.FieldByName('CTC_VL_COTACAO').AsCurrency,ffFixed,10,2);
  Lb_Obs.Lines.Clear;
  For Lc_I := 0 to E_obsOrcamento.Lines.Count - 1 do
    Lb_Obs.Lines.Add(E_obsOrcamento.Lines[lc_I]);
  Lb_Usuario.Caption := UpperCase('Vendedor: '+Gb_Nm_Usuario);
end;

procedure TRL_Orcamento_6.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Qrpt.Destroy;
  Qrpt := Nil;
  RL_Orcamento_6 := nil;
end;

procedure TRL_Orcamento_6.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  If Qr_Cliente.RecordCount > 0 then
    Begin
    Lb_Cli_Nome.Caption := Qr_Cliente.FieldByName('EMP_NOME').AsString;
    Lb_Cli_Fantasia.Caption := Qr_Cliente.FieldByName('EMP_FANTASIA').AsString;
    Lb_Cli_Endereco.Caption := Qr_Cliente.FieldByName('END_ENDER').AsString + ' , ' + Qr_Cliente.FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption := fc_MascaraCep(Qr_Cliente.FieldByName('END_CEP').AsString);
    Lb_Cli_FoneC.Caption := fc_MascaraFone(Qr_Cliente.FieldByName('END_FONE').AsString);
    Lb_Cli_bairro.Caption := Qr_Cliente.FieldByName('END_BAIRRO').AsString;
    Lb_Cli_Cidade.Caption := Qr_Cliente.FieldByName('CDD_DESCRICAO').AsString;
    Lb_Cli_UF.Caption := Qr_Cliente.FieldByName('UFE_SIGLA').AsString;
    Lb_Cli_Fax.Caption :=fc_MascaraFone(Qr_Cliente.FieldByName('END_FAX').AsString);
    Lb_Cli_Cnpj.Caption := fc_MascaraCNPJ(Qr_Cliente.FieldByName('EMP_CNPJ').AsString);
    Lb_Cli_IncEst.Caption := Qr_Cliente.FieldByName('EMP_INSC_EST').AsString;
    Lb_Cli_Celular.Caption := fc_MascaraFone(Qr_Cliente.FieldByName('END_CELULAR').AsString);
    Lb_Cli_Email.Caption := Qr_Cliente.FieldByName('EMP_EMAIL').AsString;
    Lb_Emp_Contato.Caption := Qr_Ordem.FieldByName('CTC_CONTATOEMPRESA').AsString;
    end
  else
    Begin
    Lb_Cli_Nome.Caption := Qr_Ordem.FieldByName('CTC_FANTASIA').AsString;
    Lb_Cli_Fantasia.Caption := Qr_Ordem.FieldByName('CTC_FANTASIA').AsString;
    Lb_Cli_Endereco.Caption := '';
    Lb_Cli_cep.Caption := '';
    Lb_Cli_FoneC.Caption := '';
    Lb_Cli_bairro.Caption := '';
    Lb_Cli_Cidade.Caption := '';
    Lb_Cli_UF.Caption := '';
    Lb_Cli_Fax.Caption := '';
    Lb_Cli_Cnpj.Caption := '';
    Lb_Cli_IncEst.Caption := '';
    Lb_Cli_Celular.Caption := '';
    Lb_Cli_Email.Caption := Qr_Ordem.FieldByName('CTC_EMAIL_E').AsString;
    Lb_Emp_Contato.Caption := Qr_Ordem.FieldByName('CTC_CONTATOEMPRESA').AsString;
    end;
end;

procedure TRL_Orcamento_6.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_Orcamento
end;

end.

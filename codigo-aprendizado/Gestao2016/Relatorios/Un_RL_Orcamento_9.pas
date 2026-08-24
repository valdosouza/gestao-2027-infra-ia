unit Un_RL_Orcamento_9;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery, QRPDFFilt, StdCtrls;

type
  TRL_Orcamento_9 = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRStringsBand;
    Rodape: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Orcamento: TQRLabel;
    Lb_Produto: TQRLabel;
    Lb_Quantidade: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    Lb_Vl_Subtotal: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    Qr_Itens: TSTQuery;
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
    QRMemo11: TQRMemo;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    E_OBS: TQRMemo;
    LB_TextoDesconto: TQRLabel;
    LB_VL_Desconto: TQRLabel;
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
    Lb_Cli_Fantasia: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel23: TQRLabel;
    Lb_Cli_UF: TQRLabel;
    Qr_Ordem: TSTQuery;
    Qr_Cliente: TSTQuery;
    Img_Logo: TQRImage;
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Lb_Emp_email: TQRLabel;
    bnd_Assinatura: TQRBand;
    Lb_Usuario: TQRLabel;
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bnd_AssinaturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    It_cd_Pedido : Integer;
    procedure Pc_Cabecalho;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;

    procedure Pc_Orcamento;
end;

var
  RL_Orcamento_9: TRL_Orcamento_9;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_DM, UN_Pedido_Vda, Un_Regra_Negocio, Un_Principal, env;
{$R *.dfm}

procedure TRL_Orcamento_9.Pc_Cabecalho;
Var
  Lc_Aux: String;
begin
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Fc_BuscaImagemEmpresa(Img_Logo.Picture,'LOGO');
    Lb_Emp_Nome.Caption := FieldByName('EMP_FANTASIA').AsString;
    Lb_Emp_Doc.Caption := 'C.N.P.J: '+fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString) + ' -  I.E.: '+ FieldByName('EMP_INSC_EST').AsString;
    IF (trim(FieldByName('END_COMPLEM').asString) = '') then
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end
    else
    Begin
      Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                FieldByName('END_NUMERO').asString + ' - ' +
                FieldByName('END_COMPLEM').asString + ' - ' +
                FieldByName('END_BAIRRO').AsString + ' - ' +
                Fc_MascaraCep(FieldByName('END_CEP').AsString) + ' - ' +
                FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                FieldByName('UFE_SIGLA').AsString ;
    end;
    Lb_Emp_End.Caption := Lc_Aux;
    Lc_Aux :='';
    if (trim(FieldByName('END_FONE').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_FONE').AsString);
    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_CELULAR').AsString)
    else
    if (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_CELULAR').AsString);

    Lb_Emp_Fones.Caption :=  Lc_Aux;
    Lb_Emp_www.Caption := 'Site: ' + FieldByName('EMP_SITE').AsString;
    Lb_Emp_email.Caption := 'e-mail: ' + FieldByName('EMP_EMAIL').AsString;
  END;
end;

Procedure TRL_Orcamento_9.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
  BEgin
    Lb_Produto.Font.Color := clBlack;
    Lb_Quantidade.Font.Color := clBlack;
    Lb_Vl_Unitario.Font.Color := clBlack;
    Lb_Vl_Subtotal.Font.Color := clBlack;
  end
  else
  BEgin
    Lb_Produto.Font.Color := clWhite;
    Lb_Quantidade.Font.Color := clWhite;
    Lb_Vl_Unitario.Font.Color := clWhite;
    Lb_Vl_Subtotal.Font.Color := clWhite;
  end;
end;


Procedure TRL_Orcamento_9.PC_PreencheCampos;
Begin
  Lb_Produto.Caption := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  Lb_Quantidade.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0);
  Lb_Vl_Unitario.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
  Lb_Vl_Subtotal.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
end;

procedure TRL_Orcamento_9.Pc_Orcamento;
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Qr_Ordem.Active := False;
  Qr_Ordem.ParamByName('CTC_CODPED').AsInteger := It_cd_Pedido;
  Qr_Ordem.Active := True;
  Qr_Ordem.FetchAll;
  Lb_Orcamento.Caption := 'Orçamento Nº '+ Qr_Ordem.FieldByName('CTC_NUMERO').AsString;
  Lc_dia := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Ordem.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Ordem.FieldByName('CTC_DATA').AsString,7,4);
  Pc_AtivaEstabelecimento;
  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString + ', '+ Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;

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


procedure TRL_Orcamento_9.DetalheVendaBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_Orcamento_9.RodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
  Lc_Texto: TMemoryStream;
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

  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Ordem.CreateBlobStream(Qr_Ordem.FieldByName('CTC_OBS'), bmRead));
  E_OBS.Lines.LoadFromStream(lC_Texto);
  E_OBS.AutoStretch := True;
  Lc_Texto.Free;
  Rodape.Height := E_OBS.Height + 120;
end;

procedure TRL_Orcamento_9.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Qrpt.Destroy;
  Qrpt := Nil;
  RL_Orcamento_9 := nil;
end;

procedure TRL_Orcamento_9.QRBand2BeforePrint(Sender: TQRCustomBand;
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
    end;
end;

procedure TRL_Orcamento_9.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Pc_AtivaEstabelecimento;
  Pc_Cabecalho;
  Pc_Orcamento
end;

procedure TRL_Orcamento_9.bnd_AssinaturaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Lb_Usuario.Caption := 'Usuário - ' + GB_Nm_Usuario;
end;

end.

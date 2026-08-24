unit Un_RL_ReportBudget;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportOrder, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportBudget = class(TRL_ReportOrder)
    Lb_Emp_Nome: TQRLabel;
    Lb_Emp_Doc: TQRLabel;
    Lb_Emp_End: TQRLabel;
    Lb_Emp_email: TQRLabel;
    Qr_Cliente: TSTQuery;
    Lb_Orcamento: TQRLabel;
    Lb_Data: TQRLabel;
    Lb_Emp_Fones: TQRLabel;
    Lb_Emp_www: TQRLabel;
    Img_Logo: TQRImage;
    procedure cabecalho;Override;
    procedure CustomerGroup; Virtual;

    procedure Rodape;Virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportBudget: TRL_ReportBudget;

implementation

{$R *.dfm}

uses     Un_DM, Un_Regra_Negocio, UN_Sistema, Un_Funcoes;
procedure TRL_ReportBudget.cabecalho;
Var
  Lc_Aux: String;
  Lc_Dia,Lc_Mes,Lc_Ano : String;
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

    Lb_Emp_Fones.Caption :=  'Fones: ' + Lc_Aux;
    Lb_Emp_www.Caption := 'Site: ' + FieldByName('EMP_SITE').AsString;
    Lb_Emp_email.Caption := 'e-mail: ' + FieldByName('EMP_EMAIL').AsString;
  end;

  with Qr_Pedido do
  BEgin
    Lb_Orcamento.Caption := 'Orçamento Nº '+ FieldByName('CTC_NUMERO').AsString;
    Lc_dia := Copy(FieldByName('CTC_DATA').AsString,1,2);
    Lc_mes := Fc_DesMes(Fc_Month(FieldByName('CTC_DATA').AsDateTime),True);
    Lc_Ano := Copy(FieldByName('CTC_DATA').AsString,7,4);
    Pc_AtivaEstabelecimento;
    Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString + ', '+ Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;
  END;
end;

procedure TRL_ReportBudget.CustomerGroup;
begin
  with Qr_Pedido do
  Begin
    Lb_Cli_Nome.Caption     := FieldByName('CTC_FANTASIA').AsString;
    Lb_Cli_Codigo.Caption   := FieldByName('CTC_CODEMP').AsString;
    Lb_Cli_Endereco.Caption := FieldByName('END_ENDER').AsString + ', ' + FieldByName('END_NUMERO').AsString;
    Lb_Cli_cep.Caption      := fc_MascaraCep(FieldByName('END_CEP').AsString);
    Lb_Cli_FoneC.Caption    := fc_MascaraFone(FieldByName('END_FONE').AsString);
    Lb_Cli_Complemento.Caption := FieldByName('END_COMPLEM').AsString;
    Lb_Cli_Contato.Caption     := FieldByName('CTC_CONTATO').AsString;
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
  end;
end;

procedure TRL_ReportBudget.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Qrpt.Destroy;
  Qrpt := Nil;
end;

procedure TRL_ReportBudget.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  cabecalho;
end;

procedure TRL_ReportBudget.Rodape;
Var
  Lc_I : Integer;
  Lc_Texto: TMemoryStream;
begin
  with Qr_Pedido do
  Begin
    Lb_TipoCob.Caption      := FieldByname('FPT_DESCRICAO').AsString + ' - ' + FieldByname('PED_PRAZO').AsString;
    Lb_Vl_Servico.Caption   := FloattoStrf(ValorServico,ffFixed,10,2);
    Lb_Vl_Pecas.Caption     := FloattoStrf(ValorProduto,ffFixed,10,2);
    Lb_Vl_SubTotal.Caption  := FloattoStrf(ValorServico +  ValorProduto,ffFixed,10,2);
    Lb_Vl_Desconto.Caption  := FloattoStrf(ValorDesconto ,ffFixed,10,2);
    Lb_Vl_Total.Caption     := FloattoStrf(ValorServico + ValorProduto - ValorDesconto,ffFixed,10,2);
    E_Obs.Lines.Text        := FieldByname('PED_OBS').AsString;


    Lb_NomeVendedor.Caption := FieldByname('CLB_NOME').AsString;
    Lb_LocalData.Caption    := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '   ______/______/___________ ';
    Lb_Assinatura.Caption   := FieldByname('EMP_NOME').AsString;
  end;

  Lc_Texto := TMemoryStream.Create;
  Lc_Texto.LoadFromStream(Qr_Pedido.CreateBlobStream(Qr_Pedido.FieldByName('CTC_OBS'), bmRead));


  E_OBS.Lines.LoadFromStream(lC_Texto);
  E_OBS.AutoStretch := True;
  Lc_Texto.Free;
  QrbRodape.Height := E_OBS.Height + 120;

end;

end.

unit Un_RL_ReportBudget_10;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportOrder, Data.DB, Un_DM, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportBudget_10 = class(TRL_ReportOrder)
    QRImage1: TQRImage;
    Img_Logo: TQRImage;
    QRImage2: TQRImage;
    Numero: TQRLabel;
    QRLabel48: TQRLabel;
    cnpj: TQRLabel;
    Fone: TQRLabel;
    email: TQRLabel;
    site: TQRLabel;
    Endereco: TQRLabel;
    QRShape4: TQRShape;
    ent_Contato: TQRLabel;
    Lb_Telefone: TQRLabel;
    ent_Telefone: TQRLabel;
    QRLabel2: TQRLabel;
    E_Data: TQRLabel;
    QRLabel6: TQRLabel;
    ent_email: TQRLabel;
    QRLabel11: TQRLabel;
    ent_Endereco: TQRLabel;
    Qr_Contato: TSTQuery;
    QRLabel15: TQRLabel;
    QRLabel19: TQRLabel;
    procedure Rodape;Override;
    procedure Cabecalho;Override;
    procedure QrbRodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportBudget_10: TRL_ReportBudget_10;

implementation

{$R *.dfm}

uses     Un_Regra_Negocio, UN_Sistema;
procedure TRL_ReportBudget_10.Cabecalho;
Var
  Lc_Aux: String;
begin
  WITH DM.Qr_Estabelecimento DO
  bEGIN
    Fc_BuscaImagemEmpresa(Img_logo.Picture, 'LOGO');
    //CNPJ
    cnpj.Caption := 'C.N.P.J: '+ fc_MascaraCNPJ(FieldByName('EMP_CNPJ').AsString);
    //FONES
    if (trim(FieldByName('END_FONE').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_FONE').AsString);
    if (Trim(Lc_Aux) <> '') and (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := Lc_Aux + ' / ' + fc_MascaraFone(FieldByName('END_CELULAR').AsString)
    else
    if (trim(FieldByName('END_CELULAR').AsString) <> '') then
      Lc_Aux := fc_MascaraFone(FieldByName('END_CELULAR').AsString);
    Fone.Caption := 'FONES: '+ Lc_Aux;
    //EMAIL
    email.Caption := 'e-MAIL: ' + FieldByName('EMP_EMAIL').AsString;
    //SITE
    site.Caption :=  'site : ' + FieldByName('EMP_SITE').AsString;

    //ENDERECO
    Lc_Aux := 'Endereco: ' + FieldByName('END_ENDER').AsString + ', '+
                             FieldByName('END_NUMERO').asString + ' - ' ;
    if (trim(FieldByName('END_COMPLEM').asString) = '') then
      Lc_Aux := Lc_Aux + FieldByName('END_COMPLEM').asString + ' - ' ;
    Lc_Aux := Lc_Aux + FieldByName('END_BAIRRO').AsString + ' - ' +
                       FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                       FieldByName('UFE_SIGLA').AsString + ' - ' +
                       'CEP: ' + Fc_MascaraCep(FieldByName('END_CEP').AsString);
    endereco.caption := Lc_Aux;
    //Numero do Orçamento
    Numero.Caption := 'OR�AMENTO : ' + Copy(Qr_Pedido.FieldByName('CTC_NUMERO').AsString,7,8);
    E_Data.Caption := Qr_Pedido.FieldByName('CTC_DATA').AsString;
    with Qr_Contato do
    Begin
      ent_Contato.Caption   := '';
      ent_email.Caption     := '';
      ent_Telefone.Caption  := '';
      ent_Endereco.Caption  := '';
      Active := False;
      ParamByName('EMP_CODIGO').AsInteger := Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger;
      Active := True;
      FetchAll;
      if recordCount > 0 then
      Begin
        ent_Contato.Caption := FieldByname('END_CONTATO').AsString;
        ent_email.Caption := FieldByname('EMP_EMAIL').AsString;
        ent_Telefone.Caption := fc_MascaraFone(FieldByname('END_FONE').AsString);
        //ENDERECO
        Lc_Aux := FieldByName('END_ENDER').AsString + ', '+
                  FieldByName('END_NUMERO').asString + ' - ' ;
        if (trim(FieldByName('END_COMPLEM').asString) = '') then
          Lc_Aux := Lc_Aux + FieldByName('END_COMPLEM').asString + ' - ' ;
        Lc_Aux := Lc_Aux + FieldByName('END_BAIRRO').AsString + ' - ' +
                           FieldByName('CDD_DESCRICAO').AsString + ' - ' +
                           'CEP: ' + Fc_MascaraCep(FieldByName('END_CEP').AsString);
        ent_Endereco.Caption := Lc_Aux;
      End;
    End;
  END;
end;

procedure TRL_ReportBudget_10.QrbRodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  Rodape;
end;

procedure TRL_ReportBudget_10.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  with Qr_Pedido do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
  End;
end;

procedure TRL_ReportBudget_10.Rodape;
begin
  with Qr_Pedido do
  Begin
    Lb_TipoCob.Caption      := FieldByname('FPT_DESCRICAO').AsString + ' - ' + FieldByname('CTC_PRAZO').AsString;
    Lb_Vl_Servico.Caption   := FloattoStrf(ValorServico,ffFixed,10,2);
    Lb_Vl_Pecas.Caption     := FloattoStrf(ValorProduto,ffFixed,10,2);
    Lb_Vl_SubTotal.Caption  := FloattoStrf(ValorServico +  ValorProduto,ffFixed,10,2);
    ValorDesconto           := FieldByname('CTC_VL_DESCONTO').AsCurrency;
    Lb_Vl_Desconto.Caption  := FloattoStrf(ValorDesconto ,ffFixed,10,2);
    Lb_Vl_Total.Caption     := FloattoStrf(ValorServico + ValorProduto - ValorDesconto,ffFixed,10,2);
    E_Obs.Lines.Text        := FieldByname('CTC_OBS').AsString;


    Lb_NomeVendedor.Caption := FieldByname('CLB_NOME').AsString;
    Lb_LocalData.Caption    := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '   ______/______/___________ ';
    Lb_Assinatura.Caption   := FieldByname('EMP_NOME').AsString;
    end;
end;

end.

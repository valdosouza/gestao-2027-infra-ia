unit Un_RL_PedidoCompra_2;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, STQuery, jpeg, System.Math;

type
  TRL_PedidoCompra_2 = class(TForm)
    Qrpt: TQuickRep;
    QRBand1: TQRBand;
    Qr_Logo: TQRImage;
    Lb_Emp_Razao: TQRLabel;
    Lb_Emp_Endereco: TQRLabel;
    Lb_Emp_CepBairroCidadeUf: TQRLabel;
    Lb_Emp_FoneFax: TQRLabel;
    Lb_Emp_Cnpj: TQRLabel;
    Lb_Emp_InscEst: TQRLabel;
    Lb_Emp_Email: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    Lb_Frd_Fantasia: TQRLabel;
    Lb_Frd_Razao: TQRLabel;
    Lb_Frd_endereco: TQRLabel;
    Lb_Frd_cepcidadeUf: TQRLabel;
    Lb_Frd_CNPJ: TQRLabel;
    QRLabel25: TQRLabel;
    Lb_Frd_InscEst: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    Lb_Num_Ped: TQRLabel;
    Lb_Dt_Pedido: TQRLabel;
    Lb_Condicoes: TQRLabel;
    Lb_Transporte: TQRLabel;
    Qr_Fornecedor: TSTQuery;
    QRLabel55: TQRLabel;
    Lb_TipoPI: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel63: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo7: TQRMemo;
    QRMemo8: TQRMemo;
    QRMemo9: TQRMemo;
    QRMemo10: TQRMemo;
    QRMemo11: TQRMemo;
    QRMemo12: TQRMemo;
    Bnd_Detalhe: TQRStringsBand;
    QRBand2: TQRBand;
    MM_Obs: TQRMemo;
    QRMemo49: TQRMemo;
    QRLabel128: TQRLabel;
    QRLabel129: TQRLabel;
    QRLabel131: TQRLabel;
    Lb_VL_Pedido: TQRLabel;
    Lb_VL_Impostos: TQRLabel;
    Lb_VL_Total: TQRLabel;
    MM_Responsavel: TQRMemo;
    QRLabel7: TQRLabel;
    Lb_Responsavel: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Frd_Fone: TQRLabel;
    Lb_Frd_Contato: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel1: TQRLabel;
    QRMemo2: TQRMemo;
    QRMemo17: TQRMemo;
    QRMemo18: TQRMemo;
    QRMemo19: TQRMemo;
    QRMemo20: TQRMemo;
    QRMemo21: TQRMemo;
    Lb_VL_SubTotal: TQRLabel;
    Lb_Vl_Unit: TQRLabel;
    Lb_Unidade: TQRLabel;
    Lb_Descricao: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_Vl_SubImposto: TQRLabel;
    QRMemo22: TQRMemo;
    QRMemo23: TQRMemo;
    QRMemo24: TQRMemo;
    Qr_Pedido: TSTQuery;
    Qr_Itens: TSTQuery;
    QRLabel2: TQRLabel;
    Lb_TipoFrete: TQRLabel;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    It_Vl_Pedido: Currency;
    It_Vl_Imposto: Currency;
  public
    { Public declarations }
    it_cd_Pedido: Integer;
  end;

var
  RL_PedidoCompra_2: TRL_PedidoCompra_2;

implementation

uses     Un_DM, UN_MSG, Un_Sistema, Un_Regra_Negocio;
{$R *.dfm}

procedure TRL_PedidoCompra_2.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  I, J: Integer;
begin
  Pc_AtivaEstabelecimento;
  Fc_BuscaImagemEmpresa(Qr_Logo.Picture,'LOGO');

  // Dados da Empresa
  Lb_Emp_Razao.Caption := DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString;
  Lb_Emp_Endereco.Caption := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' +
    DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString;
  Lb_Emp_CepBairroCidadeUf.Caption := Fc_MascaraCep
    (DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString)
    + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString +
    ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' +
    DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString;
  Lb_Emp_FoneFax.Caption := 'Fone: ' + fc_MascaraFone
    (DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + '/' + fc_MascaraFone
    (DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString);
  Lb_Emp_Cnpj.Caption := 'CNPJ: ' + Copy(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString,
    1, 2) + '.' + Copy(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString, 3, 3) + '.' + Copy
    (DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString, 6, 3) + '/' + Copy
    (DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString, 9, 4) + '-' + Copy
    (DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString, 13, 2);
  Lb_Emp_InscEst.Caption :=
    'Inscr. Estadual: ' + DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString;
  Lb_Emp_Email.Caption := 'E-mail: ' + DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL')
    .AsString;

  // Dados dO Fornecedor
  Lb_Frd_Fantasia.Caption := Qr_Fornecedor.FieldByName('EMP_FANTASIA').AsString;
  Lb_Frd_Razao.Caption := Qr_Fornecedor.FieldByName('EMP_NOME').AsString;
  Lb_Frd_endereco.Caption := Qr_Fornecedor.FieldByName('END_ENDER').AsString + ', ' +
    Qr_Fornecedor.FieldByName('END_NUMERO').AsString;
  if Qr_Fornecedor.FieldByName('END_COMPLEM').AsString <> '' then
    Lb_Frd_endereco.Caption := Qr_Fornecedor.FieldByName('END_ENDER').AsString + ', ' +
      Qr_Fornecedor.FieldByName('END_NUMERO').AsString + ' - ' +
      Qr_Fornecedor.FieldByName('END_COMPLEM').AsString;
  Lb_Frd_cepcidadeUf.Caption := Fc_MascaraCep
    (Qr_Fornecedor.FieldByName('END_CEP').AsString) + ' - ' +
    Qr_Fornecedor.FieldByName('CDD_DESCRICAO').AsString + ' - ' +
    Qr_Fornecedor.FieldByName('UFE_SIGLA').AsString;
  Lb_Frd_CNPJ.Caption := Fc_MascaraCNPJ(Qr_Fornecedor.FieldByName('EMP_CNPJ').AsString);
  Lb_Frd_InscEst.Caption := Qr_Fornecedor.FieldByName('EMP_INSC_EST').AsString;
  Lb_Frd_Fone.Caption := fc_MascaraFone(Qr_Fornecedor.FieldByName('END_FONE').AsString)
    + ' / ' + fc_MascaraFone(Qr_Fornecedor.FieldByName('END_FAX').AsString);
  Lb_Frd_Contato.Caption := Qr_Fornecedor.FieldByName('END_CONTATO').AsString;
  // Dados do Pedido
  Lb_Num_Ped.Caption := Qr_Pedido.FieldByName('PED_NUMERO').AsString;
  Lb_Dt_Pedido.Caption := Qr_Pedido.FieldByName('PED_DATA').AsString;
  Lb_Condicoes.Caption := Qr_Pedido.FieldByName('PED_PRAZO').AsString;
  Lb_Transporte.Caption := Qr_Pedido.FieldByName('EMP_FANTASIA').AsString;
  if Qr_Pedido.FieldByName('PED_CTA_FRETE').AsInteger = 0 then
    Lb_TipoFrete.Caption := 'REMENTENTE - CIF'
  ELSE
    Lb_TipoFrete.Caption := 'DESTINAT�RIO - FOB';

end;

procedure TRL_PedidoCompra_2.Bnd_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_Vl_Sub: Real;
  Lc_Aliq_Icms: Real;
  Lc_Aliq_IPI: Real;
  Lc_Imposto: Real;
  LcValor : Real;
begin
  if Qr_Itens.Eof then
  Begin
    Lb_Descricao.Font.Color := clWhite;
    Lb_Unidade.Font.Color := clWhite;
    Lb_Qtde.Font.Color := clWhite;
    Lb_Vl_Unit.Font.Color := clWhite;
    Lb_VL_SubTotal.Font.Color := clWhite;
    Lb_Vl_SubImposto.Font.Color := clWhite;
  end
  else
  Begin
    // Cor da Fonte
    Lb_Descricao.Font.Color := clBlack;
    Lb_Unidade.Font.Color := clBlack;
    Lb_Qtde.Font.Color := clBlack;
    Lb_Vl_Unit.Font.Color := clBlack;
    Lb_VL_SubTotal.Font.Color := clBlack;
    Lb_Vl_SubImposto.Font.Color := clBlack;
    // Dados dos itens
    Lb_Descricao.Caption := Qr_Itens.FieldByName('PRO_DESCRICAO').AsString;
    Lb_Unidade.Caption := Qr_Itens.FieldByName('MED_DESCRICAO').AsString;
    Lb_Qtde.Caption := FloatToStrF(Qr_Itens.FieldByName('ITF_QTDE').AsFloat, ffFixed, 10, 2);
    Lb_Vl_Unit.Caption := FloatToStrF(Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency, ffFixed, 10,
      2);
    LcValor := Qr_Itens.FieldByName('ITF_QTDE').AsFloat * Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency;
    LcValor := RoundTo(LcValor,-2);

    Lb_VL_SubTotal.Caption := FloatToStrF(LcValor,ffFixed, 10, 2);
    Lc_Vl_Sub := Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
    Lc_Aliq_Icms := Qr_Itens.FieldByName('ITF_AQ_ICMS').AsCurrency;
    Lc_Aliq_IPI := Qr_Itens.FieldByName('ITF_AQ_IPI').AsCurrency;
    Lc_Imposto := Lc_Vl_Sub * (Lc_Aliq_Icms / 100);
    Lc_Imposto := Lc_Imposto + (Lc_Vl_Sub * (Lc_Aliq_IPI / 100));
    Lb_Vl_SubImposto.Caption := FloatToStrF(Lc_Imposto, ffFixed, 10, 2);
    It_Vl_Pedido := It_Vl_Pedido + Lc_Vl_Sub;
    It_Vl_Imposto := It_Vl_Imposto + Lc_Imposto;
  end;
  Qr_Itens.Next;
end;

procedure TRL_PedidoCompra_2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := Cafree;
  RL_PedidoCompra_2 := nil;

end;

procedure TRL_PedidoCompra_2.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  I: Integer;
begin
  MM_Obs.Lines.Clear;
  MM_Obs.Lines.Add(
    ' OBS : � Obrig�rio Mencionar o nr. do Pedido na Sua Nota Fiscal');
  MM_Obs.Lines.Add(Qr_Pedido.FieldByName('PED_OBS').AsString);

  Lb_Responsavel.Caption := DM.Qr_Estabelecimento.FieldByname('END_CONTATO').AsString;
  Lb_VL_Pedido.Caption := FloatToStrF(It_Vl_Pedido, ffCurrency, 10, 2);
  Lb_VL_Impostos.Caption := FloatToStrF(It_Vl_Imposto, ffCurrency, 10, 2);
  Lb_VL_Total.Caption := FloatToStrF(It_Vl_Pedido + It_Vl_Imposto, ffCurrency,
    10, 2);
end;

procedure TRL_PedidoCompra_2.FormCreate(Sender: TObject);
begin
  Pc_AtivaEstabelecimento;
end;

procedure TRL_PedidoCompra_2.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_I: Integer;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  It_Vl_Pedido := 0;
  It_Vl_Imposto := 0;

  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := it_cd_Pedido;
  Qr_Pedido.Active := True;
  Qr_Pedido.First;

  Qr_Fornecedor.Active := False;
  Qr_Fornecedor.ParamByName('EMP_CODIGO').AsInteger :=
    Qr_Pedido.FieldByName('PED_CODEMP').AsInteger;
  Qr_Fornecedor.Active := True;
  Qr_Fornecedor.First;

  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('ITF_CODPED').AsInteger := it_cd_Pedido;
  Qr_Itens.Active := True;
  Qr_Itens.Last;

  if Qr_Itens.RecordCount > 16 then
  Begin
    Bnd_Detalhe.Items.Clear;
    For Lc_I := 1 to Qr_Itens.RecordCount do
      Bnd_Detalhe.Items.Add(IntToStr(Lc_I));
  end;
  Qr_Itens.First;
end;

end.

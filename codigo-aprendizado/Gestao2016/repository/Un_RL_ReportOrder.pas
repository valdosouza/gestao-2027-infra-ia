unit Un_RL_ReportOrder;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_Report, Data.DB, Un_DM, STQuery, Vcl.ExtCtrls, QuickRpt, QRCtrls;

type
  TRL_ReportOrder = class(TRL_Report)
    Qr_Pedido: TSTQuery;
    Qr_ItensPro: TSTQuery;
    QrbRodape: TQRBand;
    QRLabel21: TQRLabel;
    QRShape11: TQRShape;
    Lb_Vl_Pecas: TQRLabel;
    Lb_Vl_Desconto: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Vl_Total: TQRLabel;
    QRLabel31: TQRLabel;
    Lb_TipoCob: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Vl_SubTotal: TQRLabel;
    Lb_Assinatura: TQRLabel;
    Lb_LocalData: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_NomeVendedor: TQRLabel;
    QRLabel18: TQRLabel;
    E_Obs: TQRMemo;
    Titulo: TQRBand;
    Grp_Cliente: TQRGroup;
    QRShape20: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
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
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Ie: TQRLabel;
    QRLabel12: TQRLabel;
    Lb_Cli_FoneC: TQRLabel;
    QRLabel13: TQRLabel;
    Lb_Cli_Fax: TQRLabel;
    QRLabel34: TQRLabel;
    Lb_Cli_Celular: TQRLabel;
    QRLabel10: TQRLabel;
    Lb_Cli_Complemento: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Cli_Contato: TQRLabel;
    StrB_Produto: TQRStringsBand;
    QRShape15: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    Lb_SubVl_Pro: TQRLabel;
    Lb_VlUnit_Pro: TQRLabel;
    Lb_Qtde_Pro: TQRLabel;
    Lb_Codigo_Pro: TQRLabel;
    Lb_Descricao_Pro: TQRLabel;
    Lb_Vl_Servico: TQRLabel;
    QRLabel1: TQRLabel;
    procedure StrB_ProdutoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrbRodapeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  protected
    procedure IniciaVariaveis;Override;
    procedure Cabecalho;Override;
    procedure CustomerGroup; Virtual;
    procedure Rodape;Virtual;
    Procedure ValidaProdutos(Pc_Print : Boolean);Virtual;
    Procedure PreencheProdutos;Virtual;
    procedure PreecheDetalhe;Virtual;
  public
    { Public declarations }
    CodigoPedido : Integer;
    CabProduto : boolean;
    CabServico : boolean;
    ValorServico, ValorProduto, ValorFrete, ValorDesconto : real;
  end;

var
  RL_ReportOrder: TRL_ReportOrder;

implementation

{$R *.dfm}

uses     UN_Sistema;
procedure TRL_ReportOrder.Cabecalho;
begin
  inherited;
  //Escrever aqui o codigo especifico

end;

procedure TRL_ReportOrder.CustomerGroup;
begin
  with Qr_Pedido do
  Begin

    Lb_Cli_Nome.Caption     := FieldByName('EMP_FANTASIA').AsString;
    Lb_Cli_Codigo.Caption   := FieldByName('EMP_CODEMP').AsString;
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
  end;
end;

procedure TRL_ReportOrder.IniciaVariaveis;
Var
  Lc_I : Integer;
begin
  inherited;
  ValorServico := 0;
  ValorProduto := 0;
  ValorDesconto := 0;
  CabProduto := True;
  CabServico := True;

  //Pedido
  with Qr_Pedido do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
    FetchAll;
    RecordCount;
    First;
  End;

  //Itens de Produto
  with Qr_ItensPro do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := CodigoPedido;
    Active := True;
    FetchAll;
    First;
    StrB_Produto.Height := -1;
    StrB_Produto.Items.Clear;
    if RecordCount > 0 then
    Begin
      For Lc_I:= 0 to RecordCount do
        StrB_Produto.Items.Add(IntTostr(Lc_I));
      StrB_Produto.Height := 22;
    end;
  End;
end;

procedure TRL_ReportOrder.QrbRodapeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Rodape;
end;

procedure TRL_ReportOrder.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  Pc_Cab_Relatorio(Qrpt);
  CustomerGroup;
end;

procedure TRL_ReportOrder.Rodape;
begin
  with Qr_Pedido do
  Begin
    Lb_TipoCob.Caption      := FieldByname('FPT_DESCRICAO').AsString + ' - ' + FieldByname('PRAZO').AsString;
    Lb_Vl_Servico.Caption   := FloattoStrf(ValorServico,ffFixed,10,2);
    Lb_Vl_Pecas.Caption     := FloattoStrf(ValorProduto,ffFixed,10,2);
    Lb_Vl_SubTotal.Caption  := FloattoStrf(ValorServico +  ValorProduto,ffFixed,10,2);
    Lb_Vl_Desconto.Caption  := FloattoStrf(ValorDesconto ,ffFixed,10,2);
    Lb_Vl_Total.Caption     := FloattoStrf(ValorServico + ValorProduto + ValorFrete - ValorDesconto,ffFixed,10,2);
    E_Obs.Lines.Text        := FieldByname('OBS').AsString;
    Lb_NomeVendedor.Caption := FieldByname('CLB_NOME').AsString;
    Lb_LocalData.Caption    := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '   ______/______/___________ ';
    Lb_Assinatura.Caption   := FieldByname('EMP_NOME').AsString;
  end;
end;

Procedure TRL_ReportOrder.ValidaProdutos(Pc_Print : Boolean);
Begin
  if Pc_Print then
  BEgin
    Lb_Codigo_Pro.Font.Style := [];
    Lb_Descricao_Pro.Font.Style := [];
    Lb_Qtde_Pro.Font.Style := [];
    Lb_VlUnit_Pro.Font.Style := [];
    Lb_SubVl_Pro.Font.Style := [];

    Lb_Codigo_Pro.Alignment := taLeftJustify;
    Lb_Descricao_Pro.Alignment := taLeftJustify;
    Lb_Qtde_Pro.Alignment := taRightJustify;
    Lb_VlUnit_Pro.Alignment := taRightJustify;
    Lb_SubVl_Pro.Alignment := taRightJustify;

    Lb_Codigo_Pro.Font.Color := clBlack;
    Lb_Descricao_Pro.Font.Color := clBlack;
    Lb_Qtde_Pro.Font.Color := clBlack;
    Lb_VlUnit_Pro.Font.Color := clBlack;
    Lb_SubVl_Pro.Font.Color := clBlack;
  end
  else
  BEgin
    Lb_Codigo_Pro.Font.Color := clWhite;
    Lb_Descricao_Pro.Font.Color := clWhite;
    Lb_Qtde_Pro.Font.Color := clWhite;
    Lb_VlUnit_Pro.Font.Color := clWhite;
    Lb_SubVl_Pro.Font.Color := clWhite;
  end;
end;

procedure TRL_ReportOrder.PreecheDetalhe;
begin

end;

Procedure TRL_ReportOrder.PreencheProdutos;
Begin
  with Qr_ItensPro do
  Begin
    Lb_Codigo_Pro.Caption := FieldByname('PRO_CODIGOFAB').AsString;
    Lb_Descricao_Pro.Caption := FieldByname('DESC_PRODUTO').AsString;
    Lb_Qtde_Pro.Caption := FloatToStrf(FieldByname('QTDE').AsFloat,ffFixed,10,3);
    Lb_VlUnit_Pro.Caption := FloatToStrf(FieldByname('VL_UNIT').AsCurrency,ffFixed,10,2);
    Lb_SubVl_Pro.Caption := FloatToStrf(FieldByname('SUBTOTAL').AsCurrency,ffFixed,10,2);
    if ( FieldByname('TIPO').AsString = 'P' ) then
      ValorProduto := ValorProduto + FieldByname('SUBTOTAL').AsCurrency
    else
      ValorServico := ValorServico + FieldByname('SUBTOTAL').AsCurrency;
    ValorDesconto := ValorDesconto + FieldByname('VL_DESC').AsCurrency;
  End;
end;

procedure TRL_ReportOrder.StrB_ProdutoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if CabProduto then
  Begin
    Lb_Codigo_Pro.Font.Color := clBlack;
    Lb_Descricao_Pro.Font.Color := clBlack;
    Lb_Qtde_Pro.Font.Color := clBlack;
    Lb_VlUnit_Pro.Font.Color := clBlack;
    Lb_SubVl_Pro.Font.Color := clBlack;

    Lb_Codigo_Pro.Font.Style := [fsBold];
    Lb_Descricao_Pro.Font.Style := [fsBold];
    Lb_Qtde_Pro.Font.Style := [fsBold];
    Lb_VlUnit_Pro.Font.Style := [fsBold];
    Lb_SubVl_Pro.Font.Style := [fsBold];

    Lb_Codigo_Pro.Caption := 'Código';
    Lb_Descricao_Pro.Caption := 'Descrição dos Produtos';
    Lb_Qtde_Pro.Caption := 'Qtde';
    Lb_VlUnit_Pro.Caption := 'V. Unit�rio';
    Lb_SubVl_Pro.Caption := 'Sub Total';
    CabProduto := False;
  end
  else
  Begin
    if Not Qr_ItensPro.Eof then
    Begin
      ValidaProdutos(True);
      PreencheProdutos;
      PreecheDetalhe;
      Qr_ItensPro.Next;
    end
    else
      ValidaProdutos(False);
  end;
end;

end.

unit UN_RL_Orcamento_1;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery;

type
  TRL_Orcamento_1 = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRStringsBand;
    QRBand4: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Orcamento: TQRLabel;
    Lb_Cliente: TQRLabel;
    Lb_Codigo: TQRLabel;
    Lb_Descricao: TQRLabel;
    Lb_Quantidade: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    Lb_Vl_Subtotal: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    Qr_Itens: TSTQuery;
    Lb_Usuario: TQRLabel;
    QRBand1: TQRBand;
    Lb_Validade: TQRLabel;
    Lb_Frota: TQRLabel;
    Lb_Equipamento: TQRLabel;
    Lb_Contato: TQRLabel;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    QRMemo6: TQRMemo;
    QRMemo7: TQRMemo;
    QRLabel16: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
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
    Qr_Cotacao: TSTQuery;
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Cd_Pedido : Integer;
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
  end;

var
  RL_Orcamento_1: TRL_Orcamento_1;

implementation

uses      Un_Funcoes, UN_Sistema, Un_DM, StdCtrls, Un_Regra_Negocio, UN_Principal, env;
{$R *.dfm}
Procedure TRL_Orcamento_1.PC_VAlidaCampos(Pc_Print : Boolean);
Begin
  if Pc_Print then
  BEgin
    Lb_Codigo.Font.Color := clBlack;
    Lb_Descricao.Font.Color := clBlack;
    Lb_Quantidade.Font.Color := clBlack;
    Lb_Vl_Unitario.Font.Color := clBlack;
    Lb_Vl_Subtotal.Font.Color := clBlack;
  end
  else
  BEgin
    Lb_Codigo.Font.Color := clWhite;
    Lb_Descricao.Font.Color := clWhite;
    Lb_Quantidade.Font.Color := clWhite;
    Lb_Vl_Unitario.Font.Color := clWhite;
    Lb_Vl_Subtotal.Font.Color := clWhite;
  end;
end;

procedure TRL_Orcamento_1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := caFree;
  RL_Orcamento_1:= nil;
end;

Procedure TRL_Orcamento_1.PC_PreencheCampos;
Begin
  if not Qr_Itens.FieldByName('PRO_CODIGOFAB').IsNull then
    Lb_Codigo.Caption := Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString
  else
    Lb_Codigo.Caption := Qr_Itens.FieldByName('ICT_CODVCL').AsString;
  Lb_Descricao.Caption := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  Lb_Quantidade.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,2);
  Lb_Vl_Unitario.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
  Lb_Vl_Subtotal.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
end;

procedure TRL_Orcamento_1.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
  Lc_I:Integer;
begin
  Qr_Cotacao.Active := False;
  Qr_Cotacao.ParamByName('CTC_CODPED').AsInteger := It_cd_Pedido;
  Qr_Cotacao.Active := True;
  Qr_Cotacao.FetchAll;
  Qr_Cotacao.First;

  Pc_Define_Impressora_Qrpt(Qrpt);
  Pc_Cab_Relatorio(Qrpt);
  Lb_Orcamento.Caption := 'Orçamento Nº '+ Qr_Cotacao.FieldByName('CTC_NUMERO').AsString;
  Lc_dia := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Qr_Cotacao.FieldByName('CTC_DATA').AsDateTime),True);
  Lc_Ano := Copy(Qr_Cotacao.FieldByName('CTC_DATA').AsString,7,4);

  Pc_AtivaEstabelecimento;

  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;
  Lb_Cliente.Caption := Qr_Cotacao.FieldByName('EMP_NOME').AsString;
  Lb_Contato.Caption := Qr_Cotacao.FieldByName('CTC_CONTATO').AsString;

   DM.Qr_Endereco.Active := False;
  DM.Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Qr_Cotacao.FieldByName('EMP_CODIGO').AsInteger;
  DM.Qr_Endereco.Active := True;

  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Qr_Cotacao.FieldByName('CTC_CODIGO').AsInteger;
  Qr_Itens.Active := True;
  Qr_Itens.Last;
  DetalheVenda.Items.Clear;
  For Lc_I:=1 to Qr_Itens.RecordCount do
    DetalheVenda.Items.Add(IntTOStr(lc_I));
  Qr_Itens.First;



end;

procedure TRL_Orcamento_1.DetalheVendaBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_Orcamento_1.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
begin

  Lb_Validade.Caption := Fc_Tb_Geral('L','ORC_VALIDADE','');
  if Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency >0 then
    Begin
    LB_TextoDesconto.Font.Color := clBlack;
    LB_VL_Desconto.Font.Color := clBlack;
    LB_VL_Desconto.Caption := FormatFloat('#,##0.00', Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency);
    end
  else
    Begin
    LB_TextoDesconto.Font.Color := clWhite;
    LB_VL_Desconto.Font.Color := clWhite;
    LB_VL_Desconto.Caption := '0,00';
    end;
  Lb_Vl_Geral.Caption := FormatFloat('#,##0.00', Qr_Cotacao.FieldByName('CTC_VL_COTACAO').AsCurrency);
  Lb_Obs.Lines.Clear;
  Lb_Obs.Lines.Add(Qr_Cotacao.FieldByName('CTC_PRAZO').AsString);
  Lb_Obs.Lines.Add(Qr_Cotacao.FieldByName('CTC_OBS').AsString);
  Lb_Usuario.Caption := UpperCase('Vendedor: '+Gb_Nm_Usuario);
end;

end.

unit UN_RL_Cotacao;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, QuickRpt, QRCtrls, ExtCtrls, jpeg, DB, STQuery;

type
  TRL_Cotacao = class(TForm)
    Qrpt: TQuickRep;
    QRBand2: TQRBand;
    DetalheVenda: TQRStringsBand;
    QRBand4: TQRBand;
    QRBand3: TQRBand;
    Lb_Data: TQRLabel;
    Lb_Empresa: TQRLabel;
    Lb_Contato: TQRLabel;
    Lb_Referencia: TQRLabel;
    QRLabel16: TQRLabel;
    Lb_Apresentacao: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    Lb_Codigo: TQRLabel;
    Lb_Descricao: TQRLabel;
    Lb_Quantidade: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    Lb_Vl_Subtotal: TQRLabel;
    QRLabel8: TQRLabel;
    Lb_Vl_Geral: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    Lb_Frete: TQRLabel;
    Lb_Entrega: TQRLabel;
    QRLabel18: TQRLabel;
    Lb_Condicoes: TQRLabel;
    QRLabel28: TQRLabel;
    Lb_Obs: TQRExprMemo;
    Qr_Itens: TSTQuery;
    Lb_Agadece: TQRLabel;
    QRLabel15: TQRLabel;
    Lb_Usuario: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRImage2: TQRImage;
    QRLabel2: TQRLabel;
    Lb_Validade: TQRLabel;
    QRLabel17: TQRLabel;
    Lb_Garantia: TQRLabel;
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
    Procedure PC_VAlidaCampos(Pc_Print : Boolean);
    Procedure PC_PreencheCampos;
  end;

var
  RL_Cotacao: TRL_Cotacao;

implementation

uses     Un_Cotacao, Un_Funcoes, UN_Sistema, Un_Regra_Negocio, Un_DM, UN_Principal, env;
{$R *.dfm}
Procedure TRL_Cotacao.PC_VAlidaCampos(Pc_Print : Boolean);
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

Procedure TRL_Cotacao.PC_PreencheCampos;
Begin
  Lb_Codigo.Caption := Qr_Itens.FieldByName('ICT_CODVCL').AsString;
  Lb_Descricao.Caption := Qr_Itens.FieldByName('ICT_DESCRICAO').AsString;
  Lb_Quantidade.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_QTDE').AsFloat,ffFixed,10,0);
  Lb_Vl_Unitario.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency,ffFixed,10,2);
  Lb_Vl_Subtotal.Caption := FloatToStrf(Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency,ffFixed,10,2);
end;

procedure TRL_Cotacao.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
Var
  Lc_Ano,Lc_mes,Lc_dia:String ;
begin
  Pc_Define_Impressora_Qrpt(Qrpt);
  Lc_dia := Copy( DateToStr(Fr_Cotacao.cotacao.REgistro.Data) ,1,2);
  Lc_mes := Fc_DesMes(Fc_Month(Fr_Cotacao.cotacao.REgistro.Data),True);
  Lc_Ano := Copy(DateToStr(Fr_Cotacao.cotacao.REgistro.Data),7,4);

  Lb_Data.Caption := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de '+ Lc_Ano;
  Lb_Empresa.Caption := UpperCase(fr_Cotacao.cotacao.REgistro.Fantasia);
  Lb_Contato.Caption := UpperCase('A/C Sr(a) : '+fr_Cotacao.cotacao.REgistro.Contato);
  Lb_Referencia.Caption := UpperCase('REF: COTAÇÃO DE PREÇO - Nº: ' + Fr_Cotacao.cotacao.REgistro.Numero);
  Lb_Apresentacao.Caption := UpperCase('AGRADECEMOS A OPORTUNIDADE E SUBMETEMOS VOSSA APRECIAÇÃO NOSSA PROPOSTA DE FORNECIMENTO DO MATERIAL ABAIXO ESPECIFICADO.');

  Qr_Itens.Active := False;
  Qr_Itens.ParamByName('CTC_CODIGO').AsInteger := Fr_Cotacao.cotacao.REgistro.Codigo;
  Qr_Itens.Active := True;
  Qr_Itens.First;
end;

procedure TRL_Cotacao.DetalheVendaBeforePrint(Sender: TQRCustomBand;
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

procedure TRL_Cotacao.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_I : Integer;
begin
  Lb_Vl_Geral.Caption := Fr_Cotacao.E_VL_Cotacao.Caption;

  Lb_Frete.Caption := Fr_Cotacao.cotacao.REgistro.Tpfrete;
  Lb_Entrega.Caption := Fr_Cotacao.cotacao.REgistro.PrzEntrega;
  Lb_Condicoes.Caption := Fr_Cotacao.cotacao.REgistro.PRazo;
  Lb_Validade.Caption := Fr_Cotacao.cotacao.REgistro.Validade;
  Lb_Garantia.Caption := Fr_Cotacao.cotacao.REgistro.Garantia;
  Lb_Obs.Lines.Clear;
{  For Lc_I:= 0 to Fr_Cotacao.E_Observ.Lines.Count - 1 do
    Lb_Obs.Lines.Add(UpperCase(Fr_Cotacao.E_Observ.Lines[lc_I]));
}  Lb_Agadece.Caption := 'AGUARDAMOS O SEU PRONUNCIAMENTO E PERMANECEMOS A SUA INTEIRA DISPOSIÇÃO PARA ESCLARECIMENTOS ADICIONAIS';
  Lb_Usuario.Caption := UpperCase(Gb_Nm_Usuario);
end;

procedure TRL_Cotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Qrpt);
  Action := caFree;
  RL_Cotacao := nil;
end;

end.

unit Un_RL_ReportVendasGeral;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportVendas, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportVendasGeral = class(TRL_ReportVendas)
    Grp_Pedido: TQRGroup;
    DetalheVenda: TQRBand;
    Ftr_Pedido: TQRBand;
    DataSource1: TDataSource;
    Lb_Cliente: TQRLabel;
    Lb_Nota: TQRLabel;
    Lb_Pedido: TQRLabel;
    Lb_Data: TQRLabel;
    Lb_VL_Venda: TQRLabel;
    Lb_Vl_Custo: TQRLabel;
    E_VL_Custo: TQRLabel;
    E_Vl_Venda: TQRLabel;
    E_Data: TQRLabel;
    E_Pedido: TQRLabel;
    E_Nota: TQRLabel;
    E_Cliente: TQRLabel;
    E_cnpj: TQRLabel;
    QRLabel22: TQRLabel;
    Grp_Dia: TQRGroup;
    Ftr_Dia: TQRBand;
    Sumario: TQRBand;
    Lb_Vl_Frete: TQRLabel;
    E_VL_TL_Frete: TQRLabel;
    QRLabel19: TQRLabel;
    E_VL_TL_Total: TQRLabel;
    Lb_Sbt_Vendas: TQRLabel;
    E_VL_TL_Vendas: TQRLabel;
    Lb_Vl_Desconto: TQRLabel;
    E_VL_TL_Desconto: TQRLabel;
    Lb_Vl_Outras: TQRLabel;
    E_VL_TL_Outras: TQRLabel;
    Lb_VL_IPI: TQRLabel;
    E_VL_TL_IPI: TQRLabel;
    Lb_VL_TL_Custo_Bruto: TQRLabel;
    E_VL_TL_Custo_Bruto: TQRLabel;
    QRLabel10: TQRLabel;
    E_Vl_TL_ST: TQRLabel;
    QRLabel1: TQRLabel;
    E_VL_SubTotal: TQRLabel;
    Lb_VL_TL_Rec_Bruta: TQRLabel;
    E_VL_TL_Rec_Bruta: TQRLabel;
    procedure IniciaVariaveis;Override;
    procedure PreencherGrupo;Override;
    procedure DetalheVendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Ftr_PedidoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Ftr_DiaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    ValorItens : real;
    ValorDesconto : real;
    ValorICMSST : Real;
    ValorIPI : Real;
    ValorCusto : Real;
    ValorCustoTotal : Real;
    ValorTotalVenda : Real;
    ValorSubTotalDia : Real;
  public
    { Public declarations }
  end;

var
  RL_ReportVendasGeral: TRL_ReportVendasGeral;

implementation

{$R *.dfm}

{ TRL_ReportVendasGeral }

procedure TRL_ReportVendasGeral.DetalheVendaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with Qr_Consulta do
  Begin
    ValorItens      := ValorItens       + ( FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency );
    ValorDesconto   := ValorDesconto    +   FieldByName('ITF_VL_DESC').AsCurrency;
    ValorICMSST     := ValorICMSST      +   FieldByName('icm_vl_st').AsCurrency;
    ValorIPI        := ValorIPI         + ( ( FieldByName('ipi_vl_bc').AsCurrency * FieldByName('ipi_aq_nr').AsCurrency )/100);
    ValorCusto      := ValorCusto       +   FieldByName('NFL_VL_CUSTO').AsCurrency;
    ValorCustoTotal := ValorCustototal  +   FieldByName('NFL_VL_CUSTO').AsCurrency;
    ValorTotalVenda := ValorTotalVenda  + ( FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency );
  End;
end;

procedure TRL_ReportVendasGeral.Ftr_DiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VL_Subtotal.Caption := FloatToStrF(ValorSubTotalDia ,ffNumber,18,2);
  ValorSubTotalDia := 0;
end;

procedure TRL_ReportVendasGeral.Ftr_PedidoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherGrupo;
end;

procedure TRL_ReportVendasGeral.IniciaVariaveis;
begin
  inherited;
  ValorItens := 0;
  ValorDesconto := 0;
  ValorICMSST := 0;
  ValorIPI := 0;
  ValorCusto := 0;
  ValorCustoTotal := 0;
  ValorSubTotalDia := 0;
  ValorTotalVenda := 0;
  if MostraCusto then
  Begin
    Lb_Vl_Custo.Font.Color := clBlack;
    Lb_Vl_Custo.Font.Style := [fsBold];
    E_Vl_Custo.Font.Color := clBlack;

    Lb_VL_TL_Rec_Bruta.Font.Color := clBlack;
    Lb_VL_TL_Rec_Bruta.Font.Style := [fsBold];
    E_VL_TL_Rec_Bruta.Font.Color := clBlack;

    Lb_VL_TL_Custo_Bruto.Font.Color := clBlack;
    Lb_VL_TL_Custo_Bruto.Font.Style := [fsBold];
    E_VL_TL_Custo_Bruto.Font.Color := clBlack;

  End
  else
  Begin
    Lb_Vl_Custo.Font.Color := clWhite;
    E_Vl_Custo.Font.Color := clWhite;

    Lb_VL_TL_Rec_Bruta.Font.Color := clWhite;
    Lb_VL_TL_Rec_Bruta.Font.Style := [fsBold];
    E_VL_TL_Rec_Bruta.Font.Color := clWhite;

    Lb_VL_TL_Custo_Bruto.Font.Color := clWhite;
    Lb_VL_TL_Custo_Bruto.Font.Style := [fsBold];
    E_VL_TL_Custo_Bruto.Font.Color := clWhite;

  End;

end;

procedure TRL_ReportVendasGeral.PreencherGrupo;
begin
  with Qr_Consulta do
  Begin
    E_Data.Caption := FieldByName('NFL_DT_EMISSAO').AsString;
    E_Pedido.Caption := FieldByName('PED_NUMERO').AsString;
    E_Nota.Caption := FieldByName('NFL_NUMERO').AsString;
    E_Cliente.Caption := FieldByName('EMP_NOME').AsString;
    E_CNPJ.Caption := FieldByName('EMP_CNPJ').AsString;
    E_VL_Custo.Caption :=FloatToStrF(  ValorCusto, ffNumber, 10,2);
    ValorCusto := 0;
    E_Vl_Venda.Caption := formatfloat('0.00##', ValorTotalVenda);
    ValorSubTotalDia := ValorSubTotalDia + ValorTotalVenda;
    ValorTotalVenda := 0;
  End;
end;

procedure TRL_ReportVendasGeral.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
  Lc_VL_Frete : Real;
  Lc_VL_Outras : Real;
begin
  E_VL_TL_Vendas.Caption    := formatfloat('#,##0.00##', ValorItens );
  E_Vl_TL_Desconto.Caption  := formatfloat('#,##0.00##', ValorDesconto );
  E_Vl_TL_ST.Caption        := formatfloat('#,##0.00##', ValorICMSST );
  Lc_VL_Frete               := GetValorFrete;
  E_Vl_TL_Frete.Caption     := formatfloat('#,##0.00##', Lc_VL_Frete );
  Lc_VL_Outras              := getValorOutrasDespesas;
  E_Vl_TL_Outras.Caption    := formatfloat('#,##0.00##', Lc_VL_Outras  );
  E_VL_TL_IPI.Caption       := formatfloat('#,##0.00##', ValorIPI );
  ValorTotalVenda           := ( ValorItens + ValorICMSST +  Lc_VL_Frete + Lc_VL_Outras + ValorIPI ) - ValorDesconto;
  E_Vl_TL_Total.Caption     := formatfloat('#,##0.00##', ValorTotalVenda );
  E_VL_TL_Custo_Bruto.Caption := formatfloat('#,##0.00##', ValorCustoTotal );
  E_VL_TL_Rec_Bruta.Caption := formatfloat('#,##0.00##', ValorTotalVenda - ValorCustoTotal );
end;

end.

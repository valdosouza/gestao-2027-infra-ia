unit Un_RL_ReportVendasCustoUnico;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportVendas, QuickRpt, Data.DB, STQuery, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportVendasCustoUnico = class(TRL_ReportVendas)
    Lb_Cliente: TQRLabel;
    Lb_Nota: TQRLabel;
    Lb_Pedido: TQRLabel;
    Lb_Data: TQRLabel;
    Lb_VL_Venda: TQRLabel;
    QRLabel1: TQRLabel;
    Sumario: TQRBand;
    Lb_Sbt_Vendas: TQRLabel;
    E_VL_TL_Vendas: TQRLabel;
    Lb_Vl_Desconto: TQRLabel;
    E_VL_TL_Custo: TQRLabel;
    QRLabel2: TQRLabel;
    E_VL_TL_Saldo: TQRLabel;
    Grp_Pedido: TQRGroup;
    Grp_Dia: TQRGroup;
    DetalheVenda: TQRBand;
    Ftr_Pedido: TQRBand;
    E_VL_Custo: TQRLabel;
    E_Vl_Venda: TQRLabel;
    E_Data: TQRLabel;
    E_Pedido: TQRLabel;
    E_Nota: TQRLabel;
    E_Cliente: TQRLabel;
    Ftr_Dia: TQRBand;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure PreencherGrupo;Virtual;
    procedure DetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure SumarioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure Ftr_PedidoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    { Private declarations }
    ValorCustoTotal : Real;
    ValorTotal : Real;
  public
    { Public declarations }
  end;

var
  RL_ReportVendasCustoUnico: TRL_ReportVendasCustoUnico;

implementation

{$R *.dfm}

{ TRL_ReportVendas1 }

procedure TRL_ReportVendasCustoUnico.DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PreencherDetalhe;
end;

procedure TRL_ReportVendasCustoUnico.Ftr_PedidoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PreencherGrupo;
end;

procedure TRL_ReportVendasCustoUnico.IniciaVariaveis;
begin
  inherited;
  ValorCustoTotal := 0;
  ValorTotal := 0;
end;

procedure TRL_ReportVendasCustoUnico.PreencherGrupo;
begin
 if not Qr_Consulta.active then Qr_Consulta.active := True;
  with Qr_Consulta do
  Begin
    E_Data.Caption := FieldByName('NFL_DT_EMISSAO').AsString;
    E_Pedido.Caption := FieldByName('PED_NUMERO').AsString;
    E_Nota.Caption := FieldByName('NFL_NUMERO').AsString;
    E_Cliente.Caption := FieldByName('EMP_NOME').AsString;
    E_VL_Custo.Caption := FloatToStrF( FieldByName('ctp_vl_real').AsCurrency, ffNumber, 10,2);
    ValorCustoTotal := ValorCustoTotal + FieldByName('ctp_vl_real').AsCurrency;
    E_Vl_Venda.Caption := FloatToStrF( FieldByName('NFL_VL_TL_NOTA').AsCurrency, ffNumber, 10,2);
    ValorTotal := ValorTotal + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  End;
end;

procedure TRL_ReportVendasCustoUnico.SelectSql;
begin
  SelectTxt := 'SELECT distinct '+
               ' PED_NUMERO, nfl_numero,nfl_dt_emissao, EMP_NOME, nfl_vl_tl_nota, ctp_vl_real,  (nfl_vl_tl_nota - ctp_vl_real) Lucro '+
               ' FROM TB_NOTA_FISCAL ';

end;

procedure TRL_ReportVendasCustoUnico.SumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_VL_TL_Vendas.Caption  := FloatToStrF(ValorTotal,ffNumber,18,2);
  E_VL_TL_Custo.Caption   := FloatToStrF(ValorCustoTotal,ffNumber,18,2);
  E_VL_TL_Saldo.Caption   := FloatToStrF(ValorTotal - ValorCustoTotal ,ffNumber,18,2);
end;

procedure TRL_ReportVendasCustoUnico.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := InnerJoinTxt +
                  '  left outer join tb_custo_pedido '+
                  '  on (ctp_codped = ped_codigo)';

end;



end.

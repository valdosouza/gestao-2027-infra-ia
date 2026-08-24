unit Un_RL_ReportVendasItens;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportVendas, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TRL_ReportVendasItens = class(TRL_ReportVendas)
    GrupoVendas: TQRGroup;
    Lb_Cd_Produto: TQRLabel;
    Lb_Produto: TQRLabel;
    Lb_Vl_Subtotal: TQRLabel;
    Lb_Qtde: TQRLabel;
    Lb_Vl_Unit: TQRLabel;
    Lb_Data: TQRLabel;
    Lb_Pedido: TQRLabel;
    Lb_Nota: TQRLabel;
    Lb_NomeCliente: TQRLabel;
    QRBand5: TQRBand;
    Ft_Vendas: TQRBand;
    Lb_VL_Total: TQRLabel;
    E_Total: TQRLabel;
    QRBand6: TQRBand;
    QRLabel19: TQRLabel;
    E_TotalGeral: TQRLabel;
    E_NomeCliente: TQRLabel;
    E_Data: TQRLabel;
    E_NotaFiscal: TQRLabel;
    E_Pedido: TQRLabel;
    E_Cd_Produto: TQRLabel;
    E_Produto: TQRLabel;
    E_Subtotal: TQRLabel;
    E_Qtde: TQRLabel;
    E_VL_Unit: TQRLabel;
    StrB_obs: TQRChildBand;
    Lb_obs: TQRLabel;
    E_Obs: TQRMemo;

    procedure Ft_VendasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure GrupoVendasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    ValorTotal : Real;
    ValorTotalGeral : Real;
    procedure PreencherObservacaoPedido;
  protected
    procedure IniciaVariaveis;Override;
    procedure Buscar;Override;
    procedure PreencherDetalhe;Override;
    procedure PreencheGrupo;
  public
    { Public declarations }
  end;

var
  RL_ReportVendasItens: TRL_ReportVendasItens;

implementation

{$R *.dfm}

{ TRL_ReportVendasTrocas }

procedure TRL_ReportVendasItens.Buscar;
begin
  inherited;
  //Monta o Cabecalho
  GrupoVendas.Expression := 'qr_consulta.NFL_CODIGO';
end;

procedure TRL_ReportVendasItens.Ft_VendasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_Total.caption := FloatToStrF( ValorTotal, ffNumber, 10,2);
  PreencherObservacaoPedido;
end;

procedure TRL_ReportVendasItens.IniciaVariaveis;
begin
  inherited;
  ValorTotal := 0;
  ValorTotalGeral := 0;
end;



procedure TRL_ReportVendasItens.PreencheGrupo;
begin
  with Qr_Consulta do
  Begin
    E_Data.Caption := FieldByName('NFL_DT_EMISSAO').AsString;
    E_Pedido.Caption := FieldByName('PED_NUMERO').AsString;
    E_NotaFiscal.Caption := FieldByName('NFL_NUMERO').AsString;
    E_NomeCliente.Caption := FieldByName('EMP_NOME').AsString;
  End;
  ValorTotal := 0;
end;

procedure TRL_ReportVendasItens.PreencherDetalhe;
begin
  with Qr_Consulta do
  Begin
    E_Cd_Produto.Caption := FieldByName('PRO_CODIGOFAB').AsString;
    E_Produto.Caption := FieldByName('PRO_DESCRICAO').AsString;
    E_Qtde.Caption := FloatToStrF( FieldByName('ITF_QTDE').AsFloat, ffNumber, 10,2);
    E_Vl_Unit.Caption := FloatToStrF( FieldByName('ITF_VL_UNIT').AsCurrency, ffNumber, 10,2);
    E_Subtotal.Caption := FloatToStrF( FieldByName('ITF_Subtotal').AsCurrency, ffNumber, 10,2);
    ValorTotal := ValorTotal + FieldByName('ITF_Subtotal').AsCurrency;
    ValorTotalGeral := ValorTotalGeral + FieldByName('ITF_Subtotal').AsCurrency;
  End;
end;

procedure TRL_ReportVendasItens.PreencherObservacaoPedido;
Var
  lc_obs : TMemo;
  Lc_Altura : Integer;
begin
  try
    lc_obs := TMemo.Create(Self);
    lc_obs.Visible := false;
    lc_obs.Parent := Self;
    Lc_Obs.Lines.Clear;
    Lc_Obs.Font.Size := 8;
    Lc_Obs.Lines.Clear;
    Lc_Obs.Lines.Add(Qr_Consulta.FieldByName('PED_OBS').AsString);
    Lc_Altura := Lc_Obs.Lines.Count;
    IF (Lc_Altura >= 1) then
    Begin
      Lc_Altura := Lc_Altura * 20;
      Lb_obs.Height := Lc_Altura;
      StrB_obs.Height := Lc_Altura + 1;
      E_Obs.Height := Lc_Altura;
      E_Obs.Lines.Clear;
      E_Obs.Lines.Add(Qr_Consulta.FieldByName('PED_OBS').AsString);
    End;
  finally
    FreeandNil(lc_obs);
    StrB_obs.Repaint;
    StrB_obs.Refresh;
  end;
end;

procedure TRL_ReportVendasItens.QRBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencherDetalhe;
end;

procedure TRL_ReportVendasItens.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  E_TotalGeral.caption := FloatToStrF( ValorTotalGeral, ffNumber, 10,2);
end;


procedure TRL_ReportVendasItens.QrptBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  if Parametros.ShowObsField then
    Lb_obs.Height := 20
  else
    Lb_obs.Height := 0;
  Qrpt.Repaint;
end;

procedure TRL_ReportVendasItens.GrupoVendasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PreencheGrupo
end;

end.

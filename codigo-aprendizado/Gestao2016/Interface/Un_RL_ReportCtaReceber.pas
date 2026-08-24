unit Un_RL_ReportCtaReceber;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportList, Data.DB, prmCtaReceber, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportCtaReceber = class(TRL_ReportList)
    Qr_Clientes: TSTQuery;
    Qr_Nota: TSTQuery;
    procedure IniciaVariaveis;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;
  private
    { Private declarations }
  public
    { Public declarations }
    DiasCarencia : Integer;
    PercentualMulta : Real;
    PercentualJuros : Real;
    Valor : Real;
    ValorTotal : Real;  
    ValorDescontada : Real;
    ValorDescontadaTotal : Real;
    ValorCredito : Real;
    ValorCreditoTotal : Real;    
    Parametros : TParamCtaReceber;
  end;

var
  RL_ReportCtaReceber: TRL_ReportCtaReceber;

implementation

{$R *.dfm}

uses     UN_Sistema;
procedure TRL_ReportCtaReceber.IniciaVariaveis;
begin
  DiasCarencia    := StrToIntDef(Fc_Tb_Geral('L','FIN_G_CARENCIA',''),0);
  PercentualMulta := StrToIntDef(Fc_Tb_Geral('L','FIN_G_MULTA',''),0);
  if (PercentualMulta > 0 ) then
    PercentualMulta := PercentualMulta / 100;   
  PercentualJuros := StrToFloatDef(Fc_Tb_Geral('L','FIN_G_JUROS',''),0);
  if ( PercentualJuros > 0 ) then
    PercentualJuros := (PercentualJuros / 30 ) / 100;
  ValorDescontada := 0;
  ValorDescontadaTotal := 0;
  ValorCredito := 0;
  ValorCreditoTotal := 0;
  Valor := 0;
  ValorTotal := 0;
end;

procedure TRL_ReportCtaReceber.OrderBy;
begin
  OrderByTxt := 'ORDER BY ' + Parametros.Ordenacao;
end;

procedure TRL_ReportCtaReceber.PassarParametros;
begin
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate := DataInicial;
      ParamByName('DATAFIM').AsDate := DataFinal;
    End;
    if CodigoCliente > 0 then
      ParamByName('FIN_CODEMP').AsInteger := CodigoCliente;

     if CodigoFormaPagamento > 0 then
      ParamByName('FIN_CODFPG').AsInteger := CodigoFormaPagamento;

    if CodigoVendedorCliente > 0 then
      ParamByName('EMP_CODVDOR').AsInteger := CodigoVendedorCliente;

    if CodigoVendedorPedido > 0 then
      ParamByName('PED_CODVDO').AsInteger := CodigoVendedorPedido;

    if CodigoEstabelecimento > 0 then
      ParamByName('FIN_CODMHA').AsInteger := CodigoEstabelecimento;

  end;
end;

procedure TRL_ReportCtaReceber.PreencherDetalhe;
begin
  //
end;

procedure TRL_ReportCtaReceber.PreencherGrupo;
begin
  //
end;



end.

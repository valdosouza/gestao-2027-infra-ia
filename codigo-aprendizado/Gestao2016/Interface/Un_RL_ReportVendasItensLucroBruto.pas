unit Un_RL_ReportVendasItensLucroBruto;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportVendas, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportVendasItensLucroBruto = class(TRL_ReportVendas)
    QRBand2: TQRBand;
    footerGroup: TQRBand;
    Detail: TQRBand;
    e_quantidade: TQRLabel;
    E_Descricao: TQRLabel;
    e_TotalVenda: TQRLabel;
    E_PrecoMedio: TQRLabel;
    E_LucroBruto: TQRLabel;
    E_TotalCusto: TQRLabel;
    e_CustoMedio: TQRLabel;
    E_Total_Qtde: TQRLabel;
    E_Total_Venda: TQRLabel;
    E_Total_LucroBruto: TQRLabel;
    E_Total_Custo: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    Lb_Vl_Unitario: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    procedure DetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure footerGroupBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    Quantidade : Real;
    PrecoMedio : Real;
    CustoMedio : Real;
    TotalVenda : Real;
    TotalCusto : Real;
    procedure ZeraVariaveis;
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure Buscar;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure GroupBy;Override;
    procedure PassarParametros;Override;
    procedure PreencherDetalhe;Override;
    procedure PreencheSumary;

  public
    { Public declarations }
  end;

var
  RL_ReportVendasItensLucroBruto: TRL_ReportVendasItensLucroBruto;

implementation

{$R *.dfm}

{ TRL_ReportVendasItensLucroBruto }

procedure TRL_ReportVendasItensLucroBruto.Buscar;
begin
  inherited;

end;

procedure TRL_ReportVendasItensLucroBruto.DetailBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if TQRCustomBand(Sender).Color = clWhite then
    TQRCustomBand(Sender).Color := clSilver
  else
    TQRCustomBand(Sender).Color := clWhite;

  PreencherDetalhe;
  With Qr_Consulta do
  Begin
    Quantidade := Quantidade + FieldByName('QTDE').AsFloat;
    TotalVenda := TotalVenda + FieldByName('TOTALVENDA').AsCurrency;
    TotalCusto := TotalCusto + FieldByName('TOTALCUSTO').AsCurrency;

  End;
end;

procedure TRL_ReportVendasItensLucroBruto.footerGroupBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PreencheSumary;

end;

procedure TRL_ReportVendasItensLucroBruto.GroupBy;
begin
  inherited;
  GroupByTxt := ' GROUP BY 1,2 ';
end;

procedure TRL_ReportVendasItensLucroBruto.IniciaVariaveis;
begin
  inherited;
  Self.KeyPreview := False;
  ZeraVariaveis;

end;

procedure TRL_ReportVendasItensLucroBruto.OrderBy;
begin
  inherited;
  OrderByTxt := ' ORDER BY  PRO_DESCRICAO,ITF_CODPRO ';
end;

procedure TRL_ReportVendasItensLucroBruto.PassarParametros;
begin
  with Qr_Consulta, Parametros do
  Begin
    if Periodo then
    Begin
      ParamByName('DATAINI').AsDatetime := DataInicial;
      ParamByName('DATAFIM').AsDatetime := DataFinal;
    End;
    if CodigoCliente > 0 then
      ParamByName('NFL_CODEMP').AsInteger := CodigoCliente;

    if (Trim(NomeCliente) <> '') then
      ParamByName('EMP_NOME').AsString := NomeCliente + '%';

    if CodigoTransportadora > 0 then
      ParamByName('NFL_CODTRP').AsInteger := CodigoTransportadora;

    if CodigoVendedorCliente > 0 then
      ParamByName('EMP_CODVDOR').AsInteger := CodigoVendedorCliente;

    if CodigoVendedorPedido > 0 then
      ParamByName('PED_CODVDO').AsInteger := CodigoVendedorPedido;

    if (Trim(NomeDaRegiao) <> '') then
      ParamByName('END_REGIAO').AsString := NomeDaRegiao;

    if CodigoEstabelecimento > 0 then
      ParamByName('NFL_CODMHA').AsInteger := CodigoEstabelecimento;

    if ( Trim(TipoItem) <> '' ) then
      ParamByName('ITF_OPER').AsString := TipoItem;

    //Produto

    if ( CodigoGrupo > 0 ) then
      ParamByName('PRO_CODGRP').AsInteger := CodigoGrupo;

    if ( CodigoSubGrupo > 0 ) then
      ParamByName('PRO_CODSBG').AsInteger:= CodigoSubGrupo;

    if ( CodigoMarca > 0 ) then
      ParamByName('PRO_CODMRC').AsInteger := CodigoMarca;

    if DescricaoProduto <> '' then
      ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(DescricaoProduto,1,98) + '%';

  end;

end;

procedure TRL_ReportVendasItensLucroBruto.PreencheSumary;
begin
  E_Total_Qtde.Caption        := FloatToStrF(Quantidade,ffNumber,10,2);
  E_Total_Venda.Caption       := FloatToStrF(TotalVenda,ffNumber,10,2);
  E_Total_Custo.Caption       := FloatToStrF(TotalCusto,ffNumber,10,2);
  E_Total_LucroBruto.Caption  := FloatToStrF(TotalVenda - TotalCusto,ffNumber,10,2);
end;

procedure TRL_ReportVendasItensLucroBruto.PreencherDetalhe;
begin
  With Qr_Consulta do
  Begin
    E_Descricao.Caption := FieldByName('PRO_DESCRICAO').AsString;
    e_quantidade.Caption := FloatToStrF(FieldByName('QTDE').AsFloat,ffNumber,10,2);
    E_PrecoMedio.Caption := FloatToStrF(FieldByName('PRECOMEDIO').AsCurrency,ffNumber,10,2);
    e_CustoMedio.Caption := FloatToStrF(FieldByName('CUSTOMEDIO').AsCurrency,ffNumber,10,2);
    e_TotalVenda.Caption := FloatToStrF(FieldByName('TOTALVENDA').AsCurrency,ffNumber,10,2);
    E_TotalCusto.Caption := FloatToStrF(FieldByName('TOTALCUSTO').AsCurrency,ffNumber,10,2);
    E_LucroBruto.Caption := FloatToStrF(FieldByName('TOTALVENDA').AsCurrency - FieldByName('TOTALCUSTO').AsCurrency,ffNumber,10,2);
  End;
end;

procedure TRL_ReportVendasItensLucroBruto.SelectSql;
begin
  SelectTxt :=
  Concat('SELECT PRO_DESCRICAO,ITF_CODPRO, ',
         '  SUM(ITF_QTDE) QTDE, ',
         '   (SUM(ITF_VL_CUSTO * ITF_QTDE ) / SUM(ITF_QTDE) ) CUSTOMEDIO, ',
         '   (SUM ( ((ITF_VL_UNIT - ITF_VL_DESC) * ITF_QTDE)) / SUM(ITF_QTDE) ) PRECOMEDIO, ',
         '  SUM(ITF_VL_CUSTO *ITF_QTDE) TOTALCUSTO, ',
         '  SUM( (ITF_VL_UNIT * ITF_QTDE )-ITF_VL_DESC) TOTALVENDA ',
         ' FROM TB_NOTA_FISCAL tb_nota_fiscal '
  );


end;

procedure TRL_ReportVendasItensLucroBruto.WhereSql;
begin
  with Parametros do
  Begin
    WhereTxt := 'WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') '+
                ' AND (PED_TIPO = 1) AND (NFL_STATUS = ''F'')    ';

    case TipoDocumento of
      0:WhereTxt := WhereTxt + ' AND ( ( NFL_NUMERO =  '''') or  (NFL_NUMERO is null    ) ) ';
      1:WhereTxt := WhereTxt + ' AND ( ( NFL_NUMERO <> '''') and (NFL_NUMERO is not null) ) ';
    end;

    if Periodo then
      WhereTxt := WhereTxt + ' AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ';

    if CodigoCliente > 0 then
      WhereTxt := WhereTxt + ' AND (NFL_CODEMP = :NFL_CODEMP) ';

    if (Trim(NomeCliente) <> '') then
      WhereTxt := WhereTxt + ' AND ( (tb_cliente.EMP_NOME LIKE :EMP_NOME) OR (tb_cliente.EMP_FANTASIA LIKE :EMP_NOME) ) ';

    if CodigoTransportadora > 0 then
      WhereTxt := WhereTxt + ' AND ( NFL_CODTRP = :NFL_CODTRP ) ';

    if CodigoVendedorCliente > 0 then
      WhereTxt := WhereTxt + ' AND ( tb_cliente.EMP_CODVDOR = :EMP_CODVDOR ) ';

    if CodigoVendedorPedido > 0 then
      WhereTxt := WhereTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';

    if (Trim(NomeDaRegiao) <> '') then
      WhereTxt := WhereTxt + ' AND ( END_REGIAO LIKE :END_REGIAO ) ';

    if CodigoEstabelecimento > 0 then
      WhereTxt := WhereTxt + ' AND ( NFL_CODMHA = :NFL_CODMHA ) ';

    if ( Trim(TipoItem) <> '' ) then
      WhereTxt := WhereTxt + ' AND ( ITF_OPER = :ITF_OPER ) ';


    WhereTxt := WhereTxt + ' and   ( (PRO_TIPO = ''P'') OR (PRO_TIPO = ''M'') OR (PRO_TIPO = ''C'') ) ';


    if (CodigoGrupo > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODGRP =:PRO_CODGRP) ';

    if (CodigosubGrupo > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODSBG =:PRO_CODSBG) ';

    if (CodigoMarca > 0 ) then
      WhereTxt := WhereTxt + ' AND (PRO_CODMRC =:PRO_CODMRC) ';

    if (CodigoCliente > 0) and (TipoEmpresa = '2' ) then
      WhereTxt := WhereTxt + ' AND (PFR_CODFOR =:PFR_CODFOR) ';

    if (DescricaoProduto <> '' ) then
      WhereTxt := WhereTxt + ' AND (PRO_DESCRICAO LIKE :PRO_DESCRICAO) ';

  End;
end;

procedure TRL_ReportVendasItensLucroBruto.ZeraVariaveis;
begin
  Quantidade := 0;
  PrecoMedio := 0;
  CustoMedio := 0;
  TotalVenda := 0;
  TotalCusto := 0;
end;

end.

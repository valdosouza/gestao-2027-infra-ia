unit un_frx_ReportCtaReceber;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, Data.DB, STQuery, frxExportCSV, frxClass, frxExportPDF, frxDBSet, prmCtaReceber, Un_sistema, frxExportXLS;

type
  Tfrx_ReportCtaReceber = class(TFrxBaseReport)
    Qr_Nota: TSTQuery;
    Qr_Clientes: TSTQuery;
  private
    { Private declarations }
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;
    procedure PassarParametros; Override;
    procedure ValoresAtualizados;Virtual;
    procedure PreencherGrupo;Virtual;
    procedure PreencherDetalhe;Virtual;
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
  frx_ReportCtaReceber: Tfrx_ReportCtaReceber;

implementation

{$R *.dfm}

{ Tfrx_ReportCtaReceber }

procedure Tfrx_ReportCtaReceber.IniciaVariaveis;
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

procedure Tfrx_ReportCtaReceber.InnerJoinSql;
begin
  InnerJoinTxt := '   INNER JOIN TB_EMPRESA Tb_empresa '+
                  '   ON  (Tb_empresa.EMP_CODIGO = Tb_financeiro.FIN_CODEMP) '+
                  '   INNER JOIN TB_ENDERECO tb_endereco '+
                  '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
                  '   LEFT OUTER JOIN TB_PEDIDO '+
                  '   ON (PED_CODIGO = FIN_CODPED) ';
end;

procedure Tfrx_ReportCtaReceber.OrderBy;
begin
  inherited;
  OrderByTxt := 'ORDER BY ' + Parametros.Ordenacao;
end;

procedure Tfrx_ReportCtaReceber.PassarParametros;
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

procedure Tfrx_ReportCtaReceber.PreencherDetalhe;
begin
  //
end;

procedure Tfrx_ReportCtaReceber.PreencherGrupo;
begin
  //
end;

procedure Tfrx_ReportCtaReceber.SelectSql;
begin
  SelectTxt := ' SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EMP_NOME, EMP_FANTASIA, '+
               ' END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FIN_CODFPG,FIN_BAIXA, '+
               ' FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_TIPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA '+
               ' FROM TB_FINANCEIRO Tb_financeiro ';
end;

procedure Tfrx_ReportCtaReceber.ValoresAtualizados;
Var
  Lc_valor : Real;
  Lc_dias : Real;
  Lc_Vl_Multa : Real;
  Lc_Vl_Juros : Real;
Begin
  with Qr_Consulta do
  Begin
    Lc_dias := 0;
    Lc_Vl_Multa := 0;
    Lc_Vl_Juros := 0;
    Lc_valor := FieldByname('FIN_VL_PARCELA').AsCurrency;

    if ( FieldByname('FIN_DT_VENCIMENTO').AsDateTime + DiasCarencia) < Date then
    Begin
      Lc_dias := Date - FieldByname('FIN_DT_VENCIMENTO').AsDateTime;
      Lc_Vl_Multa := Lc_valor * PercentualMulta;
      Lc_Vl_Juros := Lc_valor * ( PercentualJuros * Lc_dias ) ;
    end;
    frxBase.Variables['ValorParcela'] := FloatToStrF(Lc_valor + Lc_Vl_Multa + Lc_Vl_Juros , ffNumber, 10, 2);
    Valor := Valor + Lc_valor + Lc_Vl_Multa + Lc_Vl_Juros;
    ValorTotal := ValorTotal + Lc_valor + Lc_Vl_Multa + Lc_Vl_Juros;
  End;
end;

procedure Tfrx_ReportCtaReceber.WhereSql;
Var
  Dia,Mes,Ano:String;
begin
  with Parametros do
  Begin
    WhereTxt := ' WHERE  ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) AND (END_PRINCIPAL = ''S'')  ';

    Dia:=Copy(DateToStr(Now),1,2);
    Mes:=Copy(DateToStr(Now),4,2);
    Ano:=Copy(DateToStr(Now),7,4);

    if TipoData = 'VENCER' then
      WhereTxt := WhereTxt +  'AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''')' ;
    if TipoData = 'VENCIDA' then
      WhereTxt := WhereTxt +  'AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''')' ;

    WhereTxt := WhereTxt + ' AND (FIN_BAIXA = ''N'') ';
    if ( TipoConta = 'NORMAL' ) then
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''N'') ';

    if ( TipoConta = 'DESTINADA' ) then
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''D'') ';

    if ( TipoConta = 'DESCONTADA' ) then
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''T'') ';

    if Periodo then
      WhereTxt := WhereTxt + ' AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM ';

    if CodigoCliente > 0 then
      WhereTxt := WhereTxt + ' AND ( FIN_CODEMP =:FIN_CODEMP ) ';

    if CodigoFormaPagamento > 0 then
      WhereTxt := WhereTxt + 'AND ( FIN_CODFPG = :FIN_CODFPG ) ';

    if CodigoVendedorCliente > 0 then
      WhereTxt := WhereTxt + ' AND ( EMP_CODVDOR = :EMP_CODVDOR ) ';

    if CodigoVendedorPedido > 0 then
      WhereTxt := WhereTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';

    if CodigoEstabelecimento > 0 then
      WhereTxt := WhereTxt + ' AND ( FIN_CODMHA = :FIN_CODMHA ) ';
  End;
end;

end.

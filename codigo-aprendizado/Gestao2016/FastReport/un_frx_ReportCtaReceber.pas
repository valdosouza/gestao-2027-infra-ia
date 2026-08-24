unit un_frx_ReportCtaReceber;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_frx_base_report, Data.DB, STQuery, frxExportCSV, frxClass, frxExportPDF, frxDBSet, prmCtaReceber, Un_sistema, frxIBXComponents, frxExportXLS;

  type
  Tfrx_ReportCtaReceber = class(TFrxBaseReport)
  private

  protected
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
  inherited;
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
  InnerJoinTxt := concat(
                    '  INNER JOIN tb_nota_fiscal nf ',
                    '  on (nf.nfl_codigo = fn.fin_codnfl) ',
                    '  INNER JOIN TB_EMPRESA ep ',
                    '  ON  (ep.EMP_CODIGO = fn.FIN_CODEMP) ',
                    '  INNER JOIN TB_PEDIDO  pd ',
                    '  ON (pd.PED_CODIGO = fn.FIN_CODPED) ',
                    '  INNER JOIN TB_ENDERECO ed ',
                    '  ON (eD.END_CODIGO = PD.ped_codend) '
    );
  UnionInnerJoinTxt := concat(
                    '  INNER JOIN tb_nota_fiscal nf ',
                    '  on (nf.nfl_codigo = fn.fin_codnfl) ',
                    '  INNER JOIN TB_EMPRESA ep ',
                    '  ON  (ep.EMP_CODIGO = fn.FIN_CODEMP) ',
                    '  INNER JOIN TB_ENDERECO ed ',
                    '  ON (eD.end_codemp = fn.fin_codemp) '
    );
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
  SelectTxt := concat(
                ' SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EMP_NOME, EMP_FANTASIA, ',
                ' END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FIN_CODFPG,FIN_BAIXA,nf.nfl_dt_emissao, ',
                ' FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_TIPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA ',
                ' FROM TB_FINANCEIRO fn '
               );

  UnionSelectTxt := concat(
                ' SELECT FIN_CODQTC, FIN_DT_VENCIMENTO,FIN_DT_PAGTO,FIN_CODEMP, EMP_NOME, EMP_FANTASIA, ',
                ' END_FONE, END_REGIAO, FIN_NUMERO,FIN_VL_PARCELA, FIN_VL_PAGO,FIN_CODFPG,FIN_BAIXA,nf.nfl_dt_emissao, ',
                ' FIN_OPERACAO,FIN_CODMHA,FIN_CODPED, FIN_CODCHQ,FIN_CODNFL, FIN_TIPO, FIN_SITUACAO,FIN_DT_REPROGRAMADA ',
                ' FROM TB_FINANCEIRO fn '
    );
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
    WhereTxt      := ' WHERE  ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) ';
    UnionWhereTxt := ' WHERE  ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) AND (END_PRINCIPAL = ''S'') AND (FN.fin_codped = 0 )  ';

    Dia:=Copy(DateToStr(Now),1,2);
    Mes:=Copy(DateToStr(Now),4,2);
    Ano:=Copy(DateToStr(Now),7,4);

    if TipoData = 'VENCER' then
    Begin
      WhereTxt      := WhereTxt +  ' AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''')' ;
      UnionWhereTxt := UnionWhereTxt +  ' AND (FIN_DT_VENCIMENTO >= '''+Mes+'/'+Dia+'/'+Ano+''')' ;
    End;
    if TipoData = 'VENCIDA' then
    Begin
      WhereTxt := WhereTxt +  ' AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''')' ;
      UnionWhereTxt := UnionWhereTxt +  ' AND (FIN_DT_VENCIMENTO < '''+Mes+'/'+Dia+'/'+Ano+''')' ;
    End;

    WhereTxt := WhereTxt + ' AND (FIN_BAIXA = ''N'') ';
    UnionWhereTxt := UnionWhereTxt + ' AND (FIN_BAIXA = ''N'') ';

    if ( TipoConta = 'NORMAL' ) then
    Begin
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''N'') ';
      UnionWhereTxt := UnionWhereTxt + ' AND (FIN_SITUACAO = ''N'') ';
    End;

    if ( TipoConta = 'DESTINADA' ) then
    Begin
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''D'') ';
      UnionWhereTxt := UnionWhereTxt + ' AND (FIN_SITUACAO = ''D'') ';
    End;

    if ( TipoConta = 'DESCONTADA' ) then
    Begin
      WhereTxt := WhereTxt + ' AND (FIN_SITUACAO = ''T'') ';
      UnionWhereTxt := UnionWhereTxt + ' AND (FIN_SITUACAO = ''T'') ';
    End;

    if Periodo then
    Begin
      WhereTxt := WhereTxt + ' AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM ';
      UnionWhereTxt := UnionWhereTxt + ' AND FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM ';
    End;

    if CodigoCliente > 0 then
    Begin
      WhereTxt := WhereTxt + ' AND ( FIN_CODEMP =:FIN_CODEMP ) ';
      UnionWhereTxt := UnionWhereTxt + ' AND ( FIN_CODEMP =:FIN_CODEMP ) ';
    End;

    if CodigoFormaPagamento > 0 then
    Begin
      WhereTxt := WhereTxt + 'AND ( FIN_CODFPG = :FIN_CODFPG ) ';
      UnionWhereTxt := UnionWhereTxt + 'AND ( FIN_CODFPG = :FIN_CODFPG ) ';
    End;

    if CodigoVendedorCliente > 0 then
    Begin
      WhereTxt := WhereTxt + ' AND ( EMP_CODVDOR = :EMP_CODVDOR ) ';
      UnionWhereTxt := UnionWhereTxt + ' AND ( EMP_CODVDOR = :EMP_CODVDOR ) ';
    End;

    if CodigoVendedorPedido > 0 then
    Begin
      WhereTxt := WhereTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';
      UnionWhereTxt := UnionWhereTxt + ' AND ( PED_CODVDO = :PED_CODVDO ) ';
    End;

    if CodigoEstabelecimento > 0 then
    Begin
      WhereTxt := WhereTxt + ' AND ( FIN_CODMHA = :FIN_CODMHA ) ';
      UnionWhereTxt := UnionWhereTxt + ' AND ( FIN_CODMHA = :FIN_CODMHA ) ';
    End;
  End;
end;
end.

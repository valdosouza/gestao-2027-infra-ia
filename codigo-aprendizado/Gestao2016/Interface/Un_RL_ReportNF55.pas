unit Un_RL_ReportNF55;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportNF, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportNF55 = class(TRL_ReportNF)
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportNF55: TRL_ReportNF55;

implementation

{$R *.dfm}

procedure TRL_ReportNF55.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT NFL_DT_EMISSAO, NFL_NUMERO NF_NUMERO, EMP_FANTASIA, NFL_CODIGO,PED_NUMERO,PED_VL_DESCONTO,NFL_MODELO, '+
               'NFL_VL_TL_NOTA,EMP_NOME, PED_TIPO, NAT_DESCRICAO,NFL_STATUS '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal ';
end;

procedure TRL_ReportNF55.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt +
              '  AND ( NFL_NUMERO <> '''' ) '+
              '  AND ( NFL_NUMERO <> ''0'' ) '+
              '  AND ( ( NAT_REGISTRO = 0 ) OR ( NAT_REGISTRO IS NULL ) )  ';

  WhereTxt := WhereTxt +  '  AND (NFL_MODELO = ''55'')';
end;

procedure TRL_ReportNF55.InnerJoinSql;
begin
  InnerJoinTxt := '   INNER JOIN TB_RETORNO_NFE '+
                  '   ON (NFE_CODNFL = NFL_CODIGO) '+
                  '   INNER JOIN TB_EMPRESA tb_empresa '+
                  '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                  '   INNER JOIN TB_PEDIDO tb_pedido '+
                  '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '   INNER JOIN TB_NATUREZA tb_natureza '+
                  '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ';
end;

end.

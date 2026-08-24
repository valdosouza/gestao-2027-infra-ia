unit Un_RL_ReportNF65;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportNF, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportNF65 = class(TRL_ReportNF)
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportNF65: TRL_ReportNF65;

implementation

{$R *.dfm}

procedure TRL_ReportNF65.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT NFL_DT_EMISSAO, NFC_CODIGO NF_NUMERO, EMP_FANTASIA, NFL_CODIGO,PED_NUMERO,PED_VL_DESCONTO,NFL_MODELO, '+
               'NFL_VL_TL_NOTA,EMP_NOME, PED_TIPO, NAT_DESCRICAO,NFL_STATUS '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal ';

end;

procedure TRL_ReportNF65.InnerJoinSql;
begin
  InnerJoinTxt := '   INNER JOIN TB_RETORNO_NFC '+
                  '   ON (NFC_CODNFL = NFL_CODIGO) '+
                  '   INNER JOIN TB_EMPRESA tb_empresa '+
                  '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                  '   INNER JOIN TB_PEDIDO tb_pedido '+
                  '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '   INNER JOIN TB_NATUREZA tb_natureza '+
                  '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) ';

end;

procedure TRL_ReportNF65.WhereSql;
begin
  Inherited;
  WhereTxt := WhereTxt +  ' AND (NFL_MODELO = ''65'') ';
end;

end.

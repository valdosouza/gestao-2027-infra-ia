unit Un_RL_ReportNFe;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportNF, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TRL_ReportNFe = class(TRL_ReportNF)
  procedure InnerJoinSql;Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RL_ReportNFe: TRL_ReportNFe;

implementation

{$R *.dfm}

procedure TRL_ReportNFE.InnerJoinSql;
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

unit Un_RL_ReportChequeRastrearOrigem;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_RL_ReportChequeRastrear, Data.DB, STQuery, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TRL_ReportChequeRastrearOrigem = class(TRL_ReportChequeRastrear)
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;

    procedure QrptBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure BuscarFinanceiro;
    procedure BuscarCheques;
  public
    { Public declarations }
  end;

var
  RL_ReportChequeRastrearOrigem: TRL_ReportChequeRastrearOrigem;

implementation

{$R *.dfm}

{ TRL_ReportChequeRastrearOrigem }

procedure TRL_ReportChequeRastrearOrigem.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT FIN_CODQTC '+
               'FROM TB_FINANCEIRO tb_financeiro ';
end;

procedure TRL_ReportChequeRastrearOrigem.InnerJoinSql;
begin
  InnerJoinTxt := '   INNER JOIN TB_CHEQUES Tb_cheques '+
                  '   ON  (Tb_cheques.CHQ_QT_REC = tb_financeiro.FIN_CODQTC) '+
                  '   INNER JOIN TB_EMPRESA '+
                  '   ON (EMP_CODIGO = FIN_CODEMP) ';
end;

procedure TRL_ReportChequeRastrearOrigem.WhereSql;
begin
  inherited;
  WhereTxt := WhereTxt  + ' AND  ((FIN_CODQTC IS NOT NULL) AND (FIN_CODQTC > 0)) ';
end;



procedure TRL_ReportChequeRastrearOrigem.BuscarCheques;
begin
  With Qr_Cheque do
  Begin
    Close;
    SQL.Clear;
    sql.Add('SELECT CHQ_NR_BANCO, CHQ_AGENCIA,  CHQ_NUMERO, CHQ_EMITENTE, '+
            'CHQ_VALOR, CHQ_DATA, CHQ_DEVOLVIDO '+
            'FROM TB_CHEQUES Tb_cheques '+
            'WHERE (CHQ_QT_REC=:CODQUITACAO) ');
    active := True;
  End;
end;

procedure TRL_ReportChequeRastrearOrigem.BuscarFinanceiro;
begin
  With Qr_Financeiro do
  Begin
    Close;
    SQL.Clear;
    sql.Add('SELECT DISTINCT '+
            '  EMP_NOME, '+
            ' EMP_FANTASIA, '+
            '  PED_NUMERO, '+
            '  NFL_NUMERO, '+
            '  FIN_NR_PARCELA, '+
            '  FIN_VL_PARCELA, '+
            '  FIN_DT_PAGTO '+
            'FROM TB_FINANCEIRO tb_financeiro '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
            '   LEFT OUTER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
            '   ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
            '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
            '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
            'WHERE (FIN_CODQTC =:CODQUITACAO)' +
            'ORDER BY EMP_NOME ');
    active := True;
  End;
end;



procedure TRL_ReportChequeRastrearOrigem.QrptBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  inherited;
  BuscarFinanceiro;
  BuscarCheques;
end;



end.

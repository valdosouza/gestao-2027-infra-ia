unit Un_RL_ReportChequeEnvioFornecedor;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, QRCtrls, QuickRpt, Vcl.ExtCtrls, Un_RL_ReportCheque;

type
  TRL_ReportChequeEnvioFornecedor = class(TRL_ReportCheque)
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand1: TQRBand;
    QRLabel11: TQRLabel;
    E_ValorTotal: TQRLabel;
    QRLabel9: TQRLabel;
    E_Data_Extenso: TQRLabel;
    E_Fornecedor: TQRLabel;
    E_PedidoDeAte: TQRLabel;
    Detalhe: TQRBand;
    e_Nr_Banco: TQRLabel;
    E_Agencia: TQRLabel;
    E_Nr_Cheque: TQRLabel;
    E_Emitente: TQRLabel;
    E_Valor: TQRLabel;
    E_Data: TQRLabel;
    E_Sequencia: TQRLabel;
    procedure IniciaVariaveis;Override;
    procedure Cabecalho;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBy;Override;

    procedure PreencherDetalhe;Override;
    procedure DetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    ValorTotal : Real;
    Sequencia : Integer;
  public
    { Public declarations }
    NomeFornecedor : String;
  end;

var
  RL_ReportChequeEnvioFornecedor: TRL_ReportChequeEnvioFornecedor;

implementation

{$R *.dfm}

uses     Un_Regra_Negocio, Un_Funcoes, Un_DM;

{ TRL_ReportChequeEnvioFornecedor }

procedure TRL_ReportChequeEnvioFornecedor.Cabecalho;
begin
  inherited;
  Pc_AtivaEstabelecimento;
  with DM.Qr_Estabelecimento do
  Begin
    E_Data_Extenso.Caption := FieldByname('CDD_DESCRICAO').AsString +  ', ' +
                              Copy(DateToStr(DAte),1,2)+ ' de '+
                              Fc_DesMes((StrToInt(Copy(DateToStr(date),4,2))),True)+
                              ' de ' + Copy(DateToStr(DAte),7,4);
    E_Fornecedor.Caption  :=  NomeFornecedor;
   E_PedidoDeAte.Caption:= '1) Abaixo Cheques para pagamentos dos Pedidos de '+
                            DateToStr(Parametros.DataInicial) +' até '+ DateToStr(Parametros.DataFinal);
  End;
end;

procedure TRL_ReportChequeEnvioFornecedor.PreencherDetalhe;
begin
  with Qr_Consulta do
  Begin
    inc(Sequencia);
    E_Sequencia.Caption := StrZero(Sequencia,4,0);
    E_Nr_Banco.Caption := FieldByName('CHQ_NR_BANCO').AsString;
    E_Agencia.Caption := FieldByName('CHQ_AGENCIA').AsString;
    E_Nr_Cheque.Caption := FieldByName('CHQ_NUMERO').AsString;
    E_Emitente.Caption := FieldByName('CHQ_EMITENTE').AsString;
    E_Valor.Caption := FloatToStrF( FieldByName('CHQ_VALOR').AsCurrency, ffNumber, 10,2);
    ValorTotal := ValorTotal + FieldByName('CHQ_VALOR').AsCurrency;
    E_Data.Caption := FieldByName('CHQ_DATA').AsString;
  End;
end;

procedure TRL_ReportChequeEnvioFornecedor.DetalheBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PreencherDetalhe;
end;

procedure TRL_ReportChequeEnvioFornecedor.IniciaVariaveis;
begin
  ValorTotal := 0;
  Sequencia := 0;
end;


procedure TRL_ReportChequeEnvioFornecedor.SelectSql;
begin
  SelectTxt := 'SELECT DISTINCT CHQ_EMITENTE, CHQ_DATA, CHQ_NR_BANCO, CHQ_AGENCIA, CHQ_NUMERO, CHQ_VALOR ' +
               'FROM TB_CHEQUES tb_cheques ';
end;

procedure TRL_ReportChequeEnvioFornecedor.InnerJoinSql;
begin
  InnerJoinTxt := '  INNER JOIN TB_FINANCEIRO Tb_financeiro '+
                  '  ON  (Tb_financeiro.FIN_CODQTC = tb_cheques.CHQ_QT_PAG) '+
                  '  INNER JOIN TB_EMPRESA '+
                  '  ON (EMP_CODIGO = CHQ_CODFOR) ';

end;

procedure TRL_ReportChequeEnvioFornecedor.WhereSql;
begin
  WhereTxt := 'WHERE ( CHQ_CODIGO IS NOT NULL ) ';
  with Parametros do
  Begin
    if Periodo then WhereTxt := WhereTxt + ' AND CHQ_DATA BETWEEN :DATAINI AND :DATAFIM ';
    if CodigoEmpresa > 0 then WhereTxt := WhereTxt + ' AND (CHQ_CODFOR =:CODEMPRESA) ';
    if CodigoEstabelecimento > 0 then WhereTxt := WhereTxt + ' AND ( FIN_CODMHA=:CODESTABELECIMENTO ) ';
  End;
end;

procedure TRL_ReportChequeEnvioFornecedor.OrderBy;
begin
  OrderByTxt := ' ORDER BY CHQ_DATA,CHQ_EMITENTE ';
end;

end.

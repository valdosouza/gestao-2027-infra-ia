unit ControllerCheque;

interface
uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, prm_ctrl_cheque, Un_sistema, Un_Regra_Negocio, tblArquivo, Un_RL_ReportChequeEnvioFornecedor, Un_RL_ReportChequeSimples, Un_RL_ReportCheque, Un_RL_ReportChequeRastrearOrigem, Un_RL_ReportChequeRastrearDestino, UN_RL_ReportChequeEnvioBanco, Un_RL_ReportChequeDisponivelCaixa, UN_RL_ReportChequeDevolvidos, Excel2000, ComObj, prmCheques, tblCheque, System.StrUtils, System.Generics.Collections;


type
  TListCheque = TObjectList<TCheque>;

  TControllerCheque = Class(TControllerBase)
  private
    FParametros: TPrmCtrlCheque;
    procedure setFParametros(const Value: TPrmCtrlCheque);

  public
    Registro : TCheque;
    Lista : TListCheque;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure getById;
    function salva:boolean;
    procedure update;
    Function delete:boolean;
    procedure UpdateEstado;
    procedure Resgate;
    procedure UpdateDevolvido;
    procedure Deposito;
    procedure Descontar;
    procedure Destinar;
    procedure DesvincularTerceiro;
    function getLastCodigoQuitacao(CodigoEmpresa:Integer) : Integer;
    procedure ExportChequeOrigem(P : TParamCheques);
    procedure ExportChequeDestino(P : TParamCheques);

    procedure ReportRelacaoSimples(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportRastrearOrigem(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportRastrearDestino(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportEnvioFornecedor(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportEnvioBanco(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportDisponivelCaixa(Operacao,Caminho: String;P : TParamCheques);
    procedure ReportDevolvido(Operacao, Caminho: String;P : TParamCheques);
    procedure Search;
    property Parametros : TPrmCtrlCheque read FParametros write setFParametros;


  End;

implementation

{ TControllerCheque }

uses     Un_DM, Un_Excel;
procedure TControllerCheque.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerCheque.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCheque.Create;
  FParametros := TPrmCtrlCheque.create;
  Lista := TListCheque.create;
end;

function TControllerCheque.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCheque.Destinar;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry, Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO =:CHQ_ESTADO, '+
              'CHQ_QT_PAG =:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


destructor TControllerCheque.Destroy;
begin
  FreeandNil(Registro);
  FreeandNil(Lista);
  FreeandNil(FParametros);
  inherited;

end;

procedure TControllerCheque.DesvincularTerceiro;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry, Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO =:CHQ_ESTADO, '+
              'CHQ_QT_PAG =:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.UpdateDevolvido;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_DEVOLVIDO=:CHQ_DEVOLVIDO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_DEVOLVIDO').AsString := Devolvido;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.updateEstado;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO=:CHQ_ESTADO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Resgate;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_DEVOLVIDO=:CHQ_DEVOLVIDO, '+
              'CHQ_VL_AMORT=:CHQ_VL_AMORT, '+
              'CHQ_DT_QUITACAO=:CHQ_DT_QUITACAO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_DEVOLVIDO').AsString := Devolvido;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_VL_AMORT').AsCurrency := ValorAmortizado;
      ParamByName('CHQ_DT_QUITACAO').AsDateTime := DataQuitacao;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Deposito;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO=:CHQ_ESTADO, '+
              'CHQ_QT_PAG=:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Descontar;
begin
  //Utiliza a mesa função do Deposito - Aguardar para implementar algo especifico quando for necessario
  Deposito;
end;


procedure TControllerCheque.ExportChequeDestino(P : TParamCheques);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  lC_Form: TRL_ReportChequeRastrearDestino;
begin
  //cria a aplicção
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;

  //planilha recebendo vari�vel nome
  Lc_Excel.WorkSheets[1].Name := 'Cheque Origem';

  // Cabe�alho 1º Linha
  Lc_Linha := 1;
  lC_Form := TRL_ReportChequeRastrearDestino.Create(Self);
  with Lc_Form do
  Begin
    Parametros := P;
    Buscar;
    Qr_Consulta.First;
    while not Qr_Consulta.Eof do
    begin
      Qr_Financeiro.Active := False;
      Qr_Financeiro.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Financeiro.Active := True;
      Qr_Financeiro.First;
      //Nome do Cliente
      Lc_StrCell := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nome do Cliente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Nome do Cliente
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := Qr_Financeiro.FieldByName('EMP_NOME').AsString;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      Lc_Linha := Lc_Linha + 1;

      //'N� Pedido';
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Pedido';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Nota Fiscal';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nota Fiscal';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //N� Parcela';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Parcela';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Data Pagto';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data Pagto';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Valor';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Financeiro.Eof do
      Begin
        //'N� Pedido';
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('PED_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Nota Fiscal';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('NFL_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //N� Parcela';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('FIN_NR_PARCELA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Data Pagto';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Financeiro.FieldByName('FIN_DT_PAGTO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //Valor';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Financeiro.Next;
      END;
      // Cheques relacionados
      Qr_Cheque.Active := False;
      Qr_Cheque.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Cheque.Active := True;
      Qr_Cheque.First;
      Lc_Linha := Lc_Linha + 1;
      //Data
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Emitente';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Emitente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Banco';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'Banco';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Agência';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Agência';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'N� Cheque';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Cheque';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Valor';
      Lc_StrCell := 'G' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Cheque.Eof do
      Begin
        //Data
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Cheque.FieldByName('CHQ_DATA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Emitente';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_EMITENTE').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Banco';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NR_BANCO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Agência';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_AGENCIA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'N� Cheque';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Valor';
        Lc_StrCell := 'G' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Cheque.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Cheque.Next;
      end;
      Qr_Consulta.Next;
      Lc_Linha := Lc_Linha + 2;
    end;
    Lc_Excel.Visible := true;
  end;
end;

procedure TControllerCheque.ExportChequeOrigem( P : TParamCheques);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  Lc_Form: TRL_ReportChequeRastrearOrigem;
begin
  //cria a aplicção
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;

  //planilha recebendo vari�vel nome
  Lc_Excel.WorkSheets[1].Name := 'Cheque Origem';

  //Repassando vari�vel
  Lc_Sheet := Lc_Excel.WorkSheets['Cheque Origem'];
  // Cabe�alho 1º Linha
  Lc_Linha := 1;
  Lc_Form := TRL_ReportChequeRastrearOrigem.Create(self);
  with Lc_Form do
  Begin
    Parametros := P;
    Buscar;
    Qr_Consulta.First;
    while not Qr_Consulta.Eof do
    begin
      Qr_Financeiro.Active := False;
      Qr_Financeiro.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Financeiro.Active := True;
      Qr_Financeiro.First;
      //Nome do Cliente
      Lc_StrCell := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nome do Cliente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Nome do Cliente
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := Qr_Financeiro.FieldByName('EMP_NOME').AsString;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      Lc_Linha := Lc_Linha + 1;

      //'N� Pedido';
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Pedido';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Nota Fiscal';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nota Fiscal';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //N� Parcela';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Parcela';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Data Pagto';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data Pagto';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Valor';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Financeiro.Eof do
      Begin
        //'N� Pedido';
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('PED_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Nota Fiscal';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('NFL_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //N� Parcela';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('FIN_NR_PARCELA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Data Pagto';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Financeiro.FieldByName('FIN_DT_PAGTO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //Valor';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Financeiro.Next;
      END;
      // Cheques relacionados
      Qr_Cheque.Active := False;
      Qr_Cheque.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Cheque.Active := True;
      Qr_Cheque.First;
      Lc_Linha := Lc_Linha + 1;
      //Data
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Emitente';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Emitente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Banco';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'Banco';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Agência';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Agência';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'N� Cheque';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'N� Cheque';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Valor';
      Lc_StrCell := 'G' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Cheque.Eof do
      Begin
        //Data
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Cheque.FieldByName('CHQ_DATA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Emitente';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_EMITENTE').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Banco';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NR_BANCO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Agência';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_AGENCIA').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'N� Cheque';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NUMERO').AsString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Valor';
        Lc_StrCell := 'G' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Cheque.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Cheque.Next;
      end;
      Qr_Consulta.Next;
      Lc_Linha := Lc_Linha + 2;
    end;
    Lc_Excel.Visible := true;
  end;


end;


procedure TControllerCheque.getById;
begin
  _getByKey(Registro);
end;

function TControllerCheque.getLastCodigoQuitacao(CodigoEmpresa:Integer): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry,Registro do
    Begin
      sql.Add(concat(
              'SELECT MAX(FIN_CODQTC) AS FIN_CODQTC ',
              'FROM TB_FINANCEIRO ',
              'WHERE (FIN_BAIXA = ''S'') AND (FIN_CODEMP=:FIN_CODEMP) '
      ));
      ParamByName('FIN_CODEMP').AsInteger := CodigoEmpresa;
      Active := True;
      FetchAll;
      Result := FieldByName('FIN_CODQTC').AsInteger;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.ReportDevolvido(Operacao, Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeDevolvidos;
begin
  Try
    Lc_Form  := TRL_ReportChequeDevolvidos.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - DEVOLVIDOS';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;


procedure TControllerCheque.ReportDisponivelCaixa(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeDisponivelCaixa;
begin
  Try
    Lc_Form  := TRL_ReportChequeDisponivelCaixa.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - DISPON�VEL NO CAIXA';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TControllerCheque.ReportEnvioBanco(Operacao, Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeEnvioBanco;
begin
  Try
    Lc_Form  := TRL_ReportChequeEnvioBanco.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - ENVIO AO BANCO DEPOSITO/CUST�DIA';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;


end;

procedure TControllerCheque.ReportEnvioFornecedor(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeEnvioFornecedor;
begin
  Try
    Lc_Form  := TRL_ReportChequeEnvioFornecedor.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - ENVIO FORNECEDOR';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;


end;

procedure TControllerCheque.ReportRastrearDestino(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeRastrearDestino;
begin
  Try
    Lc_Form  := TRL_ReportChequeRastrearDestino.Create(Self);
    Lc_Form.Parametros := P;
    if Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - RASTREAR DESTINO';
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      ExportChequeDestino(P);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TControllerCheque.ReportRastrearOrigem(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeRastrearOrigem;
begin
  Try
    Lc_Form  := TRL_ReportChequeRastrearOrigem.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - RASTREAR ORIGEM';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        ExportChequeOrigem(P);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;



procedure TControllerCheque.ReportRelacaoSimples(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeSimples;
begin
  Try
    Lc_Form  := TRL_ReportChequeSimples.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELÇÃO DE CHEQUES - SIMPLES';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta, Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;



function TControllerCheque.salva: boolean;
begin
  if ( Registro.Codigo = 0 ) then
    Registro.Codigo := Generator('GN_CHEQUES');
  SaveObj(Registro);

end;

procedure TControllerCheque.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCheque;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add(concat(
                'SELECT DISTINCT ',
                'CHQ_CODIGO, ',
                'CHQ_EMITENTE, ',
                'CHQ_NR_BANCO, ',
                'CHQ_AGENCIA, ',
                'CHQ_NUMERO, ',
                'CHQ_VALOR, ',
                'CHQ_DATA, ',
                'CHQ_DEVOLVIDO, ',
                'CHQ_DT_QUITACAO, ',
                'CHQ_TIPO, ',
                'CHQ_ESTADO, ',
                'CHQ_RETORNO, ',
                'CHQ_VL_AMORT, ',
                'CHQ_QT_REC, ',
                'CHQ_QT_PAG, ',
                'CHQ_CODFOR, ',
                'CHQ_CONTA, ',
                'CHQ_CODMHA, ',
                '(CHQ_VALOR - CHQ_VL_AMORT) CHQ_VL_SALDO ',
               ' FROM TB_CHEQUES '
      ));

      if FParametros.FieldName.NomeCliente <> '' then
      Begin
        SQL.add(concat(
                    '  INNER JOIN TB_FINANCEIRO ',
                    '  ON (FIN_CODQTC = CHQ_QT_REC) ',
                    '  INNER JOIN TB_EMPRESA tb_empresa ',
                    '  ON (EMP_CODIGO = FIN_CODEMP) '
        ));
      End;
      SQL.add('WHERE ( CHQ_CODIGO IS NOT NULL ) ');

      case AnsiIndexStr(UpperCase(FParametros.FieldName.Destino), ['N', 'S','T']) of
        0: SQL.add(' AND ( (CHQ_QT_PAG IS NULL) OR (CHQ_QT_PAG = 0) )  ');
        1: SQL.add(' AND ( (CHQ_QT_PAG IS NOT NULL) AND (CHQ_QT_PAG > 0) )');
      end;

      case AnsiIndexStr(UpperCase(FParametros.FieldName.Devolvido), ['N', 'S','T']) of
        0: SQL.add(' AND (CHQ_DEVOLVIDO =''N'') ');
        1: SQL.add(' AND (CHQ_DEVOLVIDO =''S'') ');
      end;

      if  FParametros.Periodo then
      Begin
        SQL.add(' AND (CHQ_DATA BETWEEN :CHQ_DATAINI AND :CHQ_DATAFIM) ');
        ParamByName('CHQ_DATAINI').AsDate := FParametros.DataInicial;
        ParamByName('CHQ_DATAFIM').AsDate := FParametros.DataFinal;
      End;

      if FParametros.FieldName.NumeroBanco > 0 then
      Begin
        SQL.add(' AND (CHQ_NR_BANCO =:CHQ_NR_BANCO) ');
        ParamByName('CHQ_NR_BANCO').AsInteger := FParametros.FieldName.NumeroBanco;
      End;

      if FParametros.FieldName.Emitente <> '' then
      Begin
        SQL.add(' AND (CHQ_EMITENTE LIKE :CHQ_EMITENTE) ');
        ParamByName('CHQ_EMITENTE').AsString:='%'+FParametros.FieldName.Emitente+'%';
      End;

      if FParametros.FieldName.Numero <> '' then
      Begin
        SQL.add(' AND (CHQ_NUMERO=:CHQ_NUMERO) ');
        ParamByName('CHQ_NUMERO').AsString:= FParametros.FieldName.Numero;
      End;

      if FParametros.FieldName.Valor > 0 then
      Begin
        SQL.add(' AND (CHQ_VALOR=:CHQ_VALOR) ');
        ParamByName('CHQ_VALOR').AsCurrency := FParametros.FieldName.Valor;
      End;

      if FParametros.FieldName.NomeCliente <> '' then
      Begin
         SQL.add(' AND (EMP_NOME LIKE :EMP_NOME) ');
         ParamByName('EMP_NOME').AsString:='%'+ FParametros.FieldName.NomeCliente+'%';
      End;

      SQL.Add(' ORDER BY CHQ_EMITENTE ');

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCheque.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        LITem.Saldo := FieldByName('CHQ_VL_SALDO').AsCurrency;
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerCheque.setFParametros(const Value: TPrmCtrlCheque);
begin
  FParametros := Value;
end;

procedure TControllerCheque.update;
begin
  updateObj(Registro);
end;

end.

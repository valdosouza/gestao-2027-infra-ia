unit ControllerPayBack;

interface

uses     STDatabase, Classes, Vcl.Grids, STQuery, SysUtils, ControllerBase, tblPayBack, Un_MSg, Generics.Collections, prm_pay_back, ControllerPayBackExpired;

Type
  TListaPayBack = TObjectList<TPayBack>;


  TControllerPayBack = Class(TControllerBase)
  private
    FCodigoCliente : Integer;
    FValorSaldo : Real;
    ListaCreditoCliente : TListaPayBack;
    ListaCreditoExpirado : TListaPayBack;

    function getNextNumero:Integer;
    procedure RegistraCreditoExpiradoCliente;
    procedure RegistraCreditoExpiradoGeral;
  public
    Registro : TPayBack;
    Lista : TListaPayBack;
    ListaCreditoEstornado : TListaPayBack;
    Parametros : TPrmPayBack;
    Expired : TControllerPayBackExpired;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure clear;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteByOrder:boolean;
    function getList:Boolean;
    function getListCreditoUtilizado:Boolean;
    function getListCreditCustomer:Boolean;
    function getListCreditExpirado:Boolean;
    function getListCreditEstornado:Boolean;
    function getCredito:Real;
    function GetCreditByOrder:Real;
    function getDebito:Real;
    function getSaldo:Real;
    function getbyCustomer:Boolean;
    function getbyOrderToUseCredit:Boolean;
    function getLasData:TDate;
    procedure RegistraCreditoExpirado;
    procedure DeletaRegistrosCreditoExpirados;
    procedure UtilizaCredito;

  End;

implementation

uses     Un_sistema, Un_Regra_Negocio;
procedure TControllerPayBack.clear;
begin
  clearObj(Registro);
end;

constructor TControllerPayBack.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPayBack.Create;
  Lista := TListaPayBack.Create;
  ListaCreditoExpirado := TListaPayBack.Create;
  ListaCreditoCliente := TListaPayBack.Create;
  ListaCreditoEstornado := TListaPayBack.Create;
  Parametros := TPrmPAyBack.create;
  Expired := TControllerPayBackExpired.Create(Self);
end;

procedure TControllerPayBack.DeletaRegistrosCreditoExpirados;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
            'DELETE ',
            'FROM TB_PAY_BACK pb ',
            'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ',
            '  and pb.history like :history '

      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('history').AsString := concat(Parametros.PayBack.Historico,'%');
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerPayBack.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPayBack.deleteByOrder: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'DELETE  ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerPayBack.Destroy;
begin
  Expired.Destroy;
  Parametros.Destroy;
  FreeAndNil(ListaCreditoExpirado);
  FreeAndNil(ListaCreditoCliente);
  FreeAndNil(ListaCreditoEstornado);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerPayBack.insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PAY_BACK');

    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPayBack.RegistraCreditoExpirado;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'UPDATE TB_PAY_BACK pb SET ' ,
              'PB.STATUS =:STATUS ',
              'where pb.tb_institution_id =:tb_institution_id ',
              ' and (pb.credit_value > 0) ',
              ' and pb.DT_EXPIRE < :DATAATUAL ',
              ' and  ( (PB.status = '''') or (PB.status is null) )',
              'order by DT_RECORD '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('STATUS').AsString              :=  'Expirado';
      ParamByName('DATAATUAL').AsDateTime         :=  Date;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

//var
//  I : Integer;
//begin
//  getListCreditExpirado;
//  for I := 0 to ListaCreditoExpirado.Count -1 do
//  Begin
//    ClonarObj(ListaCreditoExpirado[i],Registro);
//    Registro.Situacao := 'Expirado';
//    updateObj(Registro);
//  End;
//end;
end;

procedure TControllerPayBack.RegistraCreditoExpiradoCliente;
var
  Lc_Qry : TSTQuery;
  Lc_VL_Credito : Real;
  Lc_vl_debito : Real;
  Lc_vl_saldo : Real;
begin
  Try
    Parametros.Periodo := True;
    Expired.Registro.CodigoCliente := FCodigoCliente;
    Parametros.DataInicial  := Expired.getLast;
    Parametros.DataFinal    := Date - self.Parametros.Dias;
    Parametros.PayBack.Cliente := FCodigoCliente;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
          'SELECT pb.tb_institution_id, pb.tb_customer_id, max(pb.dt_record) data, CAST((COALESCE(SUM(credit_value), 0) - COALESCE(SUM(debit_value), 0)) AS NUMERIC(18, 2)) SALDO ',
          'FROM TB_PAY_BACK pb ',
          'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ',
          'and ( pb.dt_record between :DATAINI AND :DATAFIM ) ',
          ' and ( pb.tb_customer_id =:tb_customer_id )',
          'GROUP BY 1,2 ',
          'HAVING (COALESCE(SUM(credit_value), 0) - COALESCE(SUM(debit_value), 0)) <> 0 '
      ));

      ParamByName('TB_INSTITUTION_ID').AsInteger  := self.Parametros.Estabelecimento;
      ParamByName('TB_CUSTOMER_ID').AsInteger     := FCodigoCliente;
      Expired.Registro.CodigoCliente := FCodigoCliente;
      ParamByName('DATAINI').AsDateTime           := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDateTime           := Parametros.DataFinal;
      Active := True;
      FetchAll;
      First;
      Lc_vl_saldo := 0;
      Lc_vl_saldo := FieldByName('saldo').AsCurrency;
      if Lc_vl_saldo <> 0 then
      Begin
        Registro.Codigo          := 0;
        Registro.Estabelecimento := Parametros.Estabelecimento;
        Registro.Terminal        := Parametros.Terminal;
        Registro.Data            := FieldByName('DATA').AsDateTime;
        Registro.Cliente         := FieldByName('TB_CUSTOMER_ID').AsInteger;
        Registro.ValorCredito    := 0;
        Registro.ValorDebito     := Lc_vl_saldo;
        Registro.Historico       := Concat('Crédito expirado periodo: ',DateToSTr(Parametros.DataInicial),' : ',DateToSTr(Parametros.DataFinal));
        Registro.Ordem           := 0;
        self.Insert;

        Expired.clear;
        Expired.Registro.Codigo           := Registro.Codigo;
        Expired.Registro.Estabelecimento  := Registro.Estabelecimento;
        Expired.Registro.Terminal         := Registro.Terminal;
        Expired.Registro.CodigoCliente    := FieldByName('TB_CUSTOMER_ID').AsInteger;
        Expired.Registro.Data             := FieldByName('DATA').AsDateTime;
        Expired.Registro.ValorExpirado    := Registro.ValorDebito;
        Expired.insert;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPayBack.RegistraCreditoExpiradoGeral;
var
  Lc_Qry : TSTQuery;
  Lc_VL_Credito : Real;
  Lc_vl_debito : Real;
  Lc_vl_saldo : Real;
begin
  Registro.Codigo          := 0;
  Registro.Estabelecimento := Parametros.Estabelecimento;
  Registro.Terminal        := Parametros.Terminal;
  Registro.Data            := Parametros.DataFinal;
  Registro.Cliente         := FCodigoCliente;
  Registro.ValorCredito    := 0;
  Registro.ValorDebito     := FValorSaldo;
  Registro.Historico       := Concat('Crédito expirado periodo: ',DateToSTr(Parametros.DataInicial),' : ',DateToSTr(Parametros.DataFinal));
  Registro.Ordem           := 0;
  self.Insert;

  Expired.clear;
  Expired.Registro.Codigo           := Registro.Codigo;
  Expired.Registro.Estabelecimento  := Registro.Estabelecimento;
  Expired.Registro.Terminal         := Registro.Terminal;
  Expired.Registro.CodigoCliente    := FCodigoCliente;
  Expired.Registro.Data             := Parametros.DataFinal;
  Expired.Registro.ValorExpirado    := Registro.ValorDebito;
  Expired.insert;
end;

function TControllerPayBack.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PAY_BACK');

    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerPayBack.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPayBack.UtilizaCredito;
var
  Lc_Saldo : Real;
  I : Integer;
begin
  Lc_Saldo := Parametros.PayBack.ValorDebito;
  getListCreditCustomer;
  for I := 0 to ListaCreditoCliente.Count -1 do
  Begin
    ClonarObj(ListaCreditoCliente[i],Registro);
    Registro.Situacao := 'Utilizado';
    if ( Lc_Saldo >= Registro.ValorCredito) then
    Begin
      updateObj(Registro);
      Lc_Saldo := Lc_Saldo - Registro.ValorCredito;
    End
    else
    Begin
      if (Lc_Saldo > 0 ) then
      Begin
        //Aqui registra como utilizado valor total;
        updateObj(Registro);
        //Cria um novo registro com saldo restante se houver
        Registro.Codigo := 0;
        Registro.ValorCredito := Registro.ValorCredito - Lc_Saldo;
        Registro.Historico := concat(Registro.Historico,' - Saldo Crédito Utilizado');
        insert;
      End;
    End;
  End;
end;

procedure TControllerPayBack.getById;
begin
  _getByKey(Registro);
end;

function TControllerPayBack.getbyOrderToUseCredit: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) ',
                  ' and history like ''Utilização Crédito%'' '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger        :=  Parametros.PayBack.Ordem;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.GetCreditByOrder: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Result := 0;
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT CAST(COALESCE(SUM(credit_value), 0) AS NUMERIC(18, 2)) CREDITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('CREDITO').AsCurrency;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getbyCustomer: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('TB_CUSTOMER_ID').AsInteger     :=  Parametros.PayBack.Cliente;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getCredito: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Result := 0;
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT CAST(COALESCE(SUM(credit_value), 0) AS NUMERIC(18, 2)) CREDITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('CREDITO').AsCurrency;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getDebito: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Result := 0;
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT CAST(COALESCE(SUM(debit_value), 0) AS NUMERIC(18, 2)) DEBITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('DEBITO').AsCurrency;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getLasData: TDate;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT MAX(DT_RECORD) DATA ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('DATA').AsDateTime;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PAY_BACK '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getListCreditCustomer: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT * ',
              'FROM TB_PAY_BACK pb ' ,
              'where pb.tb_institution_id =:tb_institution_id ',
              ' and pb.tb_customer_id =:tb_customer_id ',
//              ' and (pb.credit_value > 0) ',
              ' and pb.dt_record < :DATAATUAL ',
              ' and  ( (PB.status = '''') or (PB.status is null) or (PB.status = ''Estornado'') )',
              ' order by DT_RECORD '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('TB_CUSTOMER_ID').AsInteger     :=  Parametros.PayBack.Cliente;
      ParamByName('DATAATUAL').AsDateTime         :=  Parametros.PayBack.Data;
      Active := True;
      FetchAll;
      First;
      ListaCreditoCliente.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        ListaCreditoCliente.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerPayBack.getListCreditEstornado: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT * ',
              'FROM TB_PAY_BACK pb ' ,
              'where pb.tb_institution_id =:tb_institution_id ',
              ' and pb.history like :history '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('history').AsString         :=  'Extorno%';
      Active := True;
      FetchAll;
      First;
      ListaCreditoEstornado.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        ListaCreditoEstornado.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerPayBack.getListCreditExpirado: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT * ',
              'FROM TB_PAY_BACK pb ' ,
              'where pb.tb_institution_id =:tb_institution_id ',
              ' and (pb.credit_value > 0) ',
              ' and pb.DT_EXPIRE < :DATAATUAL ',
              ' and  ( (PB.status = '''') or (PB.status is null) )',
              'order by DT_RECORD '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('DATAATUAL').AsDateTime         :=  Parametros.PayBack.Data;
      Active := True;
      FetchAll;
      First;
      ListaCreditoExpirado.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        ListaCreditoExpirado.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getListCreditoUtilizado: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_PAY_BACK ',
                     'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ',
                    '  and history like :history ',
                    'ORDER BY DT_RECORD '
      ));
       ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('history').AsString := concat(Parametros.PayBack.Historico,'%');

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerPayBack.getNextNumero: Integer;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT CAST(COALESCE(SUM(NUMBER), 0) AS INTEGER) NUMERO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;

      Active := True;
      FetchAll;
      First;
      Result := 0;//StrToIntDef(FieldByName('NUMERO').AsString,0) + 1;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getSaldo: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Result := 0;
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT CAST(COALESCE(SUM(credit_value), 0) AS NUMERIC(18, 2)) SALDO ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  'and ((status is null) or (status = '''') or (status = ''Estornado'')) ',
                  ' and (DT_RECORD >= :DT_RECORD ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      ParamByName('DT_RECORD').AsDateTime := StrtoDate('18/01/2024');//verficar isso por que houve alteraões durant o desenvolviemnto

      if Parametros.PayBack.Ordem > 0 then
        sql.add(concat(' AND (TB_ORDER_ID =:TB_ORDER_ID )'));

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      //com este parametro preenchidp não somar ao saldo atual, pois trata-se do pedido atual
      if Parametros.PayBack.Ordem > 0 then
        ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;


      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('SALDO').AsCurrency;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.

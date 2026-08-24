unit ControllerDespacho;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, STQuery, Controls, Db, tblDespacho;

Type
  TControllerdespacho = Class(TControllerBase)
  private

  public
    Registro : TDespacho;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function replace:Boolean;
    function Insert:boolean;
    function update:boolean;
    Function delete:boolean;
    procedure deleteByPedido;
    procedure Clear;
    procedure getById;
    procedure DeletaDespacho(Pc_Cd_Item,Pc_Cd_Despacho: Integer);
    procedure AlteraQtdeDespacho(Pc_cd_Despacho:Integer;Pc_Qtde : Real);
    procedure AtualizaDespacho;
    function DespachoLancado:Boolean;
    function ItensDespachados:Boolean;
  End;

implementation

uses     Un_DM;

{ TControllerdespacho }

procedure TControllerdespacho.AtualizaDespacho;
Var
  Lc_Cd_Despacho_Ant : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DSP_CODIGO FROM TB_DESPACHO '+
              'WHERE (DSP_CODITF =:ITF_CODIGO) '+
              '  AND (DSP_DT_REALIZADA =:DSP_DT_REALIZADA) '+
              '  AND (DSP_CODPED =:PED_CODIGO) '+
              '  AND (DSP_CODPRO=:PRO_CODIGO) '+
              '  AND (DSP_SITUACAO = ''S'') ');
      ParamByName('PED_CODIGO').AsInteger := Registro.Pedido;
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemPedido;
      ParamByName('PRO_CODIGO').AsInteger := Registro.Produto;
      ParamByName('DSP_DT_REALIZADA').AsDate := Registro.DataRealizada;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
      Begin
        //Guarda o codigo que vai ser atualizado
        Lc_Cd_Despacho_Ant := FieldbyName('DSP_CODIGO').AsInteger;
        //Deleta o Despacho atual
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM TB_DESPACHO WHERE DSP_CODIGO=:DSP_CODIGO ');
        ParamByName('DSP_CODIGO').AsInteger := Registro.Codigo;
        ExecSQL;
        //Atualiza o Despacho anterior
        Active := False;
        SQL.Clear;
        SQL.Add(' update tb_despacho set '+
                ' dsp_qtde = dsp_qtde + :dsp_qtde '+
                ' where  dsp_codigo= :dsp_codigo ');
        ParamByName('dsp_codigo').AsInteger := Lc_Cd_Despacho_Ant;
        ParamByName('dsp_qtde').AsFloat     := Registro.Qtde;
      end
      else
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(' update tb_despacho set '+
                ' dsp_qtde =:dsp_qtde, '+
                ' dsp_dt_realizada = :dsp_dt_realizada, '+
                ' DSP_SITUACAO = ''S'' '+
                ' where  dsp_codigo= :dsp_codigo ');
        ParamByName('dsp_codigo').AsInteger     := Registro.Codigo;
        ParamByName('dsp_qtde').AsFloat         := Registro.Qtde;
        ParamByName('dsp_dt_realizada').AsDate  := Registro.DataRealizada;
      end;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TControllerdespacho.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerdespacho.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDespacho.create;
end;

procedure TControllerdespacho.DeletaDespacho(Pc_Cd_Item, Pc_Cd_Despacho: Integer);
//------------------------------------------------------------------------------
// Cancela (retorna) um registro de despacho:
//   1. Obtem a quantidade do despacho que esta sendo cancelado;
//   2. Procura outro despacho PENDENTE do mesmo item (diferente do cancelado);
//      - Se encontrar: soma a quantidade no pendente e DELETA o cancelado;
//      - Se nao encontrar: converte o proprio cancelado em PENDENTE,
//        limpando data realizada, impressao e conferencia.
//------------------------------------------------------------------------------
var
  Lc_Sql             : String;
  Lc_Qtde            : Real;
  Lc_Cd_Pendente     : Integer;
  Lc_Qry             : TSTQuery;
  Lc_Iniciou_Transac : Boolean;
begin
  Lc_Iniciou_Transac := False;
  Lc_Qry := nil;
  //1) Busca a quantidade do despacho que esta sendo cancelado
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    Active := False;
    SQL.Clear;
    Lc_Sql := 'SELECT DSP_QTDE FROM TB_DESPACHO '+
              'WHERE DSP_CODIGO =:DSP_CODIGO ';
    SQL.Add(Lc_Sql);
    ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
    Active := True;
    if IsEmpty then
      Begin
      //Nao existe o despacho informado - nada a fazer
      if Lc_Iniciou_Transac and DM.IBT_Atualiza.InTransaction then
        DM.IBT_Atualiza.Commit;
      Exit;
      end;
    Lc_Qtde := FieldByName('DSP_QTDE').AsFloat;
  end;
  FinalizaQuery(Lc_Qry);

  //2) Procura um despacho PENDENTE do mesmo item (diferente do cancelado)
  Lc_Cd_Pendente := 0;
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    Active := False;
    SQL.Clear;
    Lc_Sql := 'SELECT FIRST 1 DSP_CODIGO FROM TB_DESPACHO '+
              'WHERE DSP_CODITF     =:ITF_CODIGO '+
              '  AND DSP_CODIGO    <>:DSP_CODIGO '+
              '  AND DSP_SITUACAO   = ''P'' '+
              '  AND DSP_DT_REALIZADA IS NULL '+
              'ORDER BY DSP_DT_PREVISTA DESC ';
    SQL.Add(Lc_Sql);
    ParamByName('ITF_CODIGO').AsInteger := Pc_Cd_Item;
    ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
    Active := True;
    if not IsEmpty then
      Lc_Cd_Pendente := FieldByName('DSP_CODIGO').AsInteger;
  end;
  FinalizaQuery(Lc_Qry);

  //3) Se achou um pendente, adiciona a quantidade nele e deleta o cancelado
  if (Lc_Cd_Pendente > 0) then
  Begin
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_QTDE = DSP_QTDE + :DSP_QTDE '+
                'WHERE DSP_CODIGO =:DSP_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Lc_Cd_Pendente;
      ParamByName('DSP_QTDE').AsFloat     := Lc_Qtde;
      ExecSQL;

      Active := False;
      SQL.Clear;
      Lc_Sql := 'DELETE FROM TB_DESPACHO '+
                'WHERE DSP_CODIGO =:DSP_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
      ExecSQL;
    end;
    FinalizaQuery(Lc_Qry);
  end
  else
  Begin
    //4) Nao achou pendente: converte o proprio despacho em PENDENTE
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_SITUACAO     = ''P'', '+
                '  DSP_IMPRESSO     = NULL, '+
                '  DSP_DT_REALIZADA = NULL, '+
                '  DSP_CONFERIDO    = NULL '+
                'WHERE DSP_CODIGO  =:DSP_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
      ExecSQL;
    end;
    FinalizaQuery(Lc_Qry);
  end;
end;


function TControllerdespacho.DespachoLancado: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT FIRST 1 DSP_CODIGO ',
              'FROM TB_DESPACHO DSP ',
              'WHERE (DSP_CODPED =:PED_CODIGO) '
      ));
      ParamByName('PED_CODIGO').AsInteger := Registro.Pedido;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

destructor TControllerdespacho.Destroy;
begin
  FreeAndNil( Registro );
  inherited;
end;


procedure TControllerdespacho.getById;
begin
  _getByKey(Registro);
end;

function TControllerdespacho.replace: Boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRECO');
    replaceObj(Registro);
  Except
    Result := False;
  End;

end;

function TControllerdespacho.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
    Begin
      Registro.Codigo := Generator('GN_DESPACHO');
      insertObj(Registro);
    End
    else
    Begin
      updateObj(Registro);
    End;
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerdespacho.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  end;

end;

function TControllerdespacho.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;

end;


function TControllerdespacho.Insert: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_DESPACHO');
    iNSERTObj(Registro);
  Except
    Result := False;
  End;

end;

function TControllerdespacho.ItensDespachados: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT FIRST 1 DSP_CODIGO ',
              'FROM TB_DESPACHO DSP ',
              'WHERE (DSP_CODPED =:PED_CODIGO) ',
              ' AND DSP_SITUACAO = ''S'' '
      ));
      ParamByName('PED_CODIGO').AsInteger := Registro.Pedido;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerdespacho.AlteraQtdeDespacho(Pc_cd_Despacho:Integer; Pc_Qtde : Real);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_QTDE =:DSP_QTDE '+
                'WHERE DSP_CODIGO =:DSP_CODIGO ';

      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Pc_cd_Despacho;
      ParamByName('DSP_QTDE').AsFloat := Pc_Qtde;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerdespacho.deleteByPedido;
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_Sql := 'DELETE '+
                'FROM TB_DESPACHO '+
                'WHERE DSP_CODPED =:DSP_CODPED ';
      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODPED').AsInteger := Registro.Pedido;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

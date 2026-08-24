unit ControllerAdicaoImportacao;

interface
uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, Generics.Collections, Un_sistema, Un_Regra_Negocio, tblAdicaoImportacao, Un_MSg;

Type
  TListAdicaoImportacao = TObjectList<TAdicaoImportacao>;

  TControllerAdicaoImportacao = Class(TControllerBase)
  private
  public
    Registro : TAdicaoImportacao;
    Lista : TListAdicaoImportacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    procedure deleteAll;
    procedure getbyDIM;
    procedure clear;
    procedure getList;
  End;

implementation

procedure TControllerAdicaoImportacao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerAdicaoImportacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TAdicaoImportacao.Create;
  Lista     := TListAdicaoImportacao.create;
end;

function TControllerAdicaoImportacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerAdicaoImportacao.deleteAll;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('DELETE '+
              'FROM TB_ADIC_IMP '+
              'WHERE (ADC_CODDIM =:ADC_CODDIM)');
      ParamByName('ADC_CODDIM').asInteger := Registro.CodigoImportacao;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerAdicaoImportacao.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;


function TControllerAdicaoImportacao.insere: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ADIC_IMP');
  InsertObj(Registro);
end;

function TControllerAdicaoImportacao.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ADIC_IMP');
  SaveObj(Registro);
end;

procedure TControllerAdicaoImportacao.getbyDIM;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_ADIC_IMP '+
              'WHERE (ADC_CODDIM =:ADC_CODDIM)');
      ParamByName('ADC_CODDIM').asInteger := Registro.CodigoImportacao;
      Active := True;
      FetchAll;
      if ( RecordCount > 0 ) then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerAdicaoImportacao.getById;
begin
  _getByKey(Registro);
end;


procedure TControllerAdicaoImportacao.getList;
Var
  Lc_Qry : TSTQuery;
  Lc_item : TAdicaoImportacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_ADIC_IMP '+
              'WHERE (ADC_CODDIM =:ADC_CODDIM)');
      ParamByName('ADC_CODDIM').asInteger := Registro.CodigoImportacao;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        Lc_item := TAdicaoImportacao.Create;
        get(Lc_Qry, Lc_item);
        Lista.add(Lc_item);
        Next;
      end;
    End;
  Finally
    FinalizaQuery(lc_Qry);
  End;

end;

end.

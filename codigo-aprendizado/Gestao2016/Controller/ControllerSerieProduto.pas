unit ControllerSerieProduto;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblSerieProduto, prm_serie_produto;

Type
  TListaSerieProduto  = TObjectList<TSerieProduto>;
  TControllerSerieProduto = Class(TControllerBase)

  private
    FParametros: TPrmSerieProduto;
    procedure setFParametros(const Value: TPrmSerieProduto);
  public
    Registro : TSerieProduto;
    Lista : TListaSerieProduto;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    function salva:boolean;
    Function delete:boolean;
    procedure clear;
    procedure Search;
    function existeNumero:Boolean;
    property Parametros : TPrmSerieProduto read FParametros write setFParametros;
  End;

implementation

{ TControllerSerieProduto }

procedure TControllerSerieProduto.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerSerieProduto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSerieProduto.create;
  Lista := TListaSerieProduto.create;
  FParametros := TPrmSerieProduto.create;
end;

function TControllerSerieProduto.delete: boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerSerieProduto.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  FreeAndNil( FParametros );
  inherited;
end;

function TControllerSerieProduto.existeNumero: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Result := False;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := concat(
             'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI      ',
             'FROM TB_SERIE_PRODUTO                           ',
             'WHERE (SRP_NUMERO=:SRP_NUMERO)                  ',
             ' AND ((SRP_CODSAI = 0) OR (SRP_CODSAI IS NULL) )',
             ' AND SRP_CODIGO <> :SRP_CODIGO                  ',
             'ORDER BY SRP_NUMERO '
             );
      ParamByName('SRP_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      ParamByName('SRP_NUMERO').AsString := Parametros.FieldName.Numero;
      Active := True;
      FetchAll;
      First;
      Result := recordCount > 0;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerSerieProduto.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerSerieProduto.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SERIE_PRODUTO');
  insertObj(Registro);
end;

function TControllerSerieProduto.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerSerieProduto.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SERIE_PRODUTO');
  saveObj(Registro);
end;

procedure TControllerSerieProduto.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TSerieProduto;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_SERIE_PRODUTO WHERE 1=1';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND EMB_CODIGO = :EMB_CODIGO';
        ParamByName('EMB_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND EMB_DESCRICAO LIKE :EMB_DESCRICAO';
        ParamByName('EMB_DESCRICAO').AsString := Concat('%',Parametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TSerieProduto.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerSerieProduto.setFParametros(const Value: TPrmSerieProduto);
begin
  FParametros := Value;
end;

function TControllerSerieProduto.update: boolean;
begin
  updateObj(Registro);
end;

end.

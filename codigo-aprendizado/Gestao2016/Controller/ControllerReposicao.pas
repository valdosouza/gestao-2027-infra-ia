unit ControllerReposicao;

interface

uses     STDatabase, System.Classes, STQuery, System.SysUtils, ControllerBase, tblCtrlEstoque, Un_MSg, tblprodprod, prm_reposicao, System.Generics.Collections, ControllerDskSyncTable, GenericEntity, CAtribEntity;
Type

  TListaReposicao = TObjectList<TProdProd>;

  TControllerReposicao = Class(TControllerBase)
  private
    FParametros: TPrmReposicao;
    procedure setFParametros(const Value: TPrmReposicao);

  public
    Registro : TProdProd;
    Lista : TListaReposicao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure insert;
    procedure update;
    procedure delete;
    procedure replace;
    procedure search;
    property Parametros : TPrmReposicao read FParametros write setFParametros;
  End;



implementation

{ TControllerReposicao }

uses     UN_Sistema, Un_Regra_Negocio;
constructor TControllerReposicao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProdProd.Create;
  Lista := TListaReposicao.Create;
  FParametros := TPrmReposicao.create;
end;

procedure TControllerReposicao.delete;
begin
  DeleteObj(Registro);
end;

destructor TControllerReposicao.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;


procedure TControllerReposicao.insert;
begin
  InsertObj(Registro);
end;

procedure TControllerReposicao.replace;
begin
  replaceObj(Registro);
end;

procedure TControllerReposicao.search;
Var
  Lc_Qry : TSTQuery;
  Lcreg : TProdProd;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                   'SELECT ppd.*, prd.PRO_CODIGO, prd.PRO_CODIGOFAB, prd.PRO_DESCRICAO ',
                   'FROM TB_PRODUTO prd ',
                   '   INNER JOIN TB_PROD_PROD ppd ',
                   '   ON (ppd.PPD_CODPRO_D = prd.PRO_CODIGO) ',
                   'WHERE ppd.PPD_CODPRO_M =:PRO_CODIGO ',
                   ' AND ppd.PPD_TIPO =:PPD_TIPO '
      ));

      ParamByName('PRO_CODIGO').AsInteger := FParametros.FieldName.produtoMaster;
      ParamByName('PPD_TIPO').AsString := 'REPOSICAO';
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      BEgin
        Lcreg := TProdProd.Create;
        get(Lc_Qry,Lcreg);
        Lcreg.Produto        := FieldByName('PRO_DESCRICAO').asString;
        Lcreg.CodigoFabrica  := FieldByName('PRO_CODIGOFAB').asString;
        Lista.Add(Lcreg);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerReposicao.setFParametros(const Value: TPrmReposicao);
begin
  FParametros := Value;
end;

procedure TControllerReposicao.update;
begin
  UpdateObj(Registro);
end;

end.

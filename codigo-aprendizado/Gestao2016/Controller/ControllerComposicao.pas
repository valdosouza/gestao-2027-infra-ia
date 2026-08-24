unit ControllerComposicao;

interface

uses     STDatabase, System.Classes, STQuery, System.SysUtils, ControllerBase, tblCtrlEstoque, Un_MSg, tblprodprod, System.Generics.Collections, ControllerDskSyncTable, GenericEntity, CAtribEntity;
Type
  TListaComposicao = TObjectList<TProdProd>;

  TControllerComposicao = Class(TControllerBase)
  private
  public
    Registro : TProdProd;
    Lista : TListaComposicao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getList;
  End;



implementation

{ TControllerComposicao }

uses     UN_Sistema, Un_Regra_Negocio;
constructor TControllerComposicao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProdProd.Create;
  Lista := TListaComposicao.Create;
end;

destructor TControllerComposicao.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;


procedure TControllerComposicao.getList;
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
                   'SELECT ',
                   '  PPD_CODPRO_M, ',
                   '  PRO_COMPOSICAO, ',
                   '  PPD_QTDE , ',
                   '  PPD_CODPRO_D ',
                   'FROM TB_PRODUTO tb_produto ',
                   '   LEFT OUTER JOIN TB_PROD_PROD tb_prod_prod ',
                   '   ON (tb_prod_prod.PPD_CODPRO_M = tb_produto.PRO_CODIGO) ',
                   'WHERE PRO_CODIGO =:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.produtoMaster;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      BEgin
        Lcreg := TProdProd.Create;
        Lcreg.produtoMaster  := FieldByName('PPD_CODPRO_M').AsInteger;
        Lcreg.Composicao     := FieldByName('PRO_COMPOSICAO').AsString;
        Lcreg.Qtde           := StrToFloatDef(FieldByName('PPD_QTDE').AsString,0);
        Lcreg.produtodetalhe := StrToIntDef(FieldByName('PPD_CODPRO_D').AsString,0);
        Lista.Add(Lcreg);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

end.

unit ControllerItensInd;

interface

uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, Generics.Collections,
         tblItensInd;

Type
  TListaItensInd = TObjectList<TItensInd>;

  TControllerItensInd = Class(TControllerBase)
  public
    Registro : TItensInd;
    Lista : TListaItensInd;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure save;
    procedure insert;
    procedure migra;
    procedure update;
    procedure delete;
    procedure getByKey;
    procedure clear;
    procedure getList;
  End;

implementation

constructor TControllerItensInd.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensInd.Create;
  Lista := TListaItensInd.Create;
end;

destructor TControllerItensInd.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

procedure TControllerItensInd.clear;
begin
  ClearObj(Registro);
  Lista.Clear;
end;

procedure TControllerItensInd.delete;
begin
  DeleteObj(Registro);
end;

procedure TControllerItensInd.getByKey;
begin
  _getByKey(Registro);
end;

procedure TControllerItensInd.getList;
var
  Lc_Qry: TSTQuery;
  LcItem: TItensInd;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    begin
      SQL.Add('SELECT * FROM TB_ITENS_IND WHERE IIN_CODIGO IS NOT NULL ');
      if Registro.CodigoIndustrializa > 0 then
      begin
        SQL.Add(' AND IIN_CODIND = :IIN_CODIND ');
        ParamByName('IIN_CODIND').AsInteger := Registro.CodigoIndustrializa;
      end;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not Eof do
      begin
        LcItem := TItensInd.Create;
        get(Lc_Qry, LcItem);
        Lista.Add(LcItem);
        Next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerItensInd.insert;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ITENS_IND');
  InsertObj(Registro);
end;

procedure TControllerItensInd.migra;
begin
  InsertObj(Registro);
end;

procedure TControllerItensInd.save;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ITENS_IND');
  SaveObj(Registro);
end;

procedure TControllerItensInd.update;
begin
  UpdateObj(Registro);
end;

end.

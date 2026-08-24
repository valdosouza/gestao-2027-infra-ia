unit ControllerFichaTecnica;

interface

uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, Generics.Collections,
         tblFichaTecnica;

Type
  TListaFichaTecnica = TObjectList<TFichaTecnica>;

  TControllerFichaTecnica = Class(TControllerBase)
  public
    Registro : TFichaTecnica;
    Lista : TListaFichaTecnica;
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

constructor TControllerFichaTecnica.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFichaTecnica.Create;
  Lista := TListaFichaTecnica.Create;
end;

destructor TControllerFichaTecnica.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

procedure TControllerFichaTecnica.clear;
begin
  ClearObj(Registro);
  Lista.Clear;
end;

procedure TControllerFichaTecnica.delete;
begin
  DeleteObj(Registro);
end;

procedure TControllerFichaTecnica.getByKey;
begin
  _getByKey(Registro);
end;

procedure TControllerFichaTecnica.getList;
var
  Lc_Qry: TSTQuery;
  LcItem: TFichaTecnica;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    begin
      SQL.Add('SELECT * FROM TB_FICHA_TECNICA WHERE FTC_CODIGO IS NOT NULL ');
      if Registro.CodigoProduto > 0 then
      begin
        SQL.Add(' AND FTC_CODPRO = :FTC_CODPRO ');
        ParamByName('FTC_CODPRO').AsInteger := Registro.CodigoProduto;
      end;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not Eof do
      begin
        LcItem := TFichaTecnica.Create;
        get(Lc_Qry, LcItem);
        Lista.Add(LcItem);
        Next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerFichaTecnica.insert;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_FICHA_TECNICA');
  InsertObj(Registro);
end;

procedure TControllerFichaTecnica.migra;
begin
  InsertObj(Registro);
end;

procedure TControllerFichaTecnica.save;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_FICHA_TECNICA');
  SaveObj(Registro);
end;

procedure TControllerFichaTecnica.update;
begin
  UpdateObj(Registro);
end;

end.

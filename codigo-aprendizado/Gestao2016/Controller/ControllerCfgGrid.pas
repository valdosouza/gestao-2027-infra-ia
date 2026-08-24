unit ControllerCfgGrid;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery,
         ControllerBase, tblCfgGrid;

Type
  TListCfgGrid = TObjectList<TCfgGrid>;

  TControllerCfgGrid = Class(TControllerBase)
  private
  public
    Registro : TCfgGrid;
    Lista : TListCfgGrid;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure save;
    procedure insert;
    procedure update;
    procedure delete;
    procedure getByKey;
    procedure getByUsuarioLabel;
    procedure clear;
    procedure getList;
    procedure loadByUsuario(AUsuario, AIdGrid: Integer);
    procedure deleteByUsuario(AUsuario: Integer);
  End;

implementation

{ TControllerCfgGrid }

procedure TControllerCfgGrid.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerCfgGrid.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCfgGrid.Create;
  Lista := TListCfgGrid.Create;
end;

procedure TControllerCfgGrid.delete;
begin
  DeleteObj(Registro);
end;

procedure TControllerCfgGrid.deleteByUsuario(AUsuario: Integer);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
        'DELETE FROM TB_CFG_GRID ',
        'WHERE CFG_CODUSU = :CFG_CODUSU '
      ));
      ParamByName('CFG_CODUSU').AsInteger := AUsuario;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerCfgGrid.loadByUsuario(AUsuario, AIdGrid: Integer);
begin
  Registro.Usuario := AUsuario;
  Registro.IdGrid := AIdGrid;
  getList;
end;

destructor TControllerCfgGrid.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  inherited;
end;

procedure TControllerCfgGrid.getByKey;
begin
  _getByKey(Registro);
end;

procedure TControllerCfgGrid.getByUsuarioLabel;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
        'SELECT * ',
        'FROM TB_CFG_GRID ',
        'WHERE CFG_CODIGO IS NOT NULL ',
        ' AND CFG_CODUSU = :CFG_CODUSU ',
        ' AND CFG_LABEL=:CFG_LABEL '));

      ParamByName('CFG_CODUSU').AsInteger  := Registro.Usuario;
      ParamByName('CFG_LABEL').AsString    := Registro.Legenda;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry, registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerCfgGrid.getList;
var
  Lc_Qry : TSTQuery;
  LcItem : TCfgGrid;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
        'SELECT * ',
        'FROM TB_CFG_GRID ',
        'WHERE CFG_CODIGO IS NOT NULL '
      ));
      if Registro.Usuario > 0 then
        SQL.Add(' AND CFG_CODUSU = :CFG_CODUSU ');
      if Registro.IdGrid > 0 then
        SQL.Add(' AND CFG_IDGRID = :CFG_IDGRID ');
      SQL.Add(' ORDER BY CFG_POSICAO ');

      if Registro.Usuario > 0 then
        ParamByName('CFG_CODUSU').AsInteger := Registro.Usuario;
      if Registro.IdGrid > 0 then
        ParamByName('CFG_IDGRID').AsInteger := Registro.IdGrid;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not Eof do
      Begin
        LcItem := TCfgGrid.Create;
        get(Lc_Qry, LcItem);
        Lista.Add(LcItem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCfgGrid.insert;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CFG_GRID');
  InsertObj(Registro);
end;

procedure TControllerCfgGrid.save;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CFG_GRID');
  SaveObj(Registro);
end;


procedure TControllerCfgGrid.update;
begin
  UpdateObj(Registro);
end;

end.

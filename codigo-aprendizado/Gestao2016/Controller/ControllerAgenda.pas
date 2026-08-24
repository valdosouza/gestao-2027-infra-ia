unit ControllerAgenda;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblAgenda, Md5, STQuery, prm_commitment, ControllerUsuario;
Type
  TControllerAgenda = Class(TControllerBase)
  private
    FParametros: TPrmCommitMent;
    procedure setFParametros(const Value: TPrmCommitMent);
  public
    Registro : TAgenda;
    Usuario : TControllerUsuario;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    function salva:boolean;
    procedure getbyId;
    procedure getByUser;
    function Clear:Boolean;
    property Parametros : TPrmCommitMent read FParametros write setFParametros;
  End;

  implementation
{ ControllerAgenda }

function TControllerAgenda.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerAgenda.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAgenda.Create;
  FParametros := TPrmCommitMent.Create;
  Usuario := TControllerUsuario.Create(self);
end;

function TControllerAgenda.delete: boolean;
begin
  Result := True;
  Try
    deleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerAgenda.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(FParametros);
  FreeAndNil(Usuario);
  inherited;
end;

function TControllerAgenda.insert: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerAgenda.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'agd_codigo',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerAgenda.save: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerAgenda.setFParametros(const Value: TPrmCommitMent);
begin
  FParametros := Value;
end;

function TControllerAgenda.getAllByKey: boolean;
begin
  getByKey;
end;

procedure TControllerAgenda.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerAgenda.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
procedure TControllerAgenda.getByUser;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(Concat(
                'SELECT AGD_CODIGO ',
                'FROM TB_AGENDA ',
                'WHERE AGD_DIA=:AGD_DIA ',
                '      AND AGD_HORA=:AGD_HORA ',
                '      AND AGD_PARACODUSU=:AGD_PARACODUSU ',
                '      AND AGD_AVISAR = ''SIM'' '
      ));
     ParamByName('AGD_DIA').AsDateTime := Date;
      ParamByName('AGD_HORA').AsString := Copy(TimeToStr(time), 1, 5);
      ParamByName('AGD_PARACODUSU').AsInteger := Parametros.FieldName.ToUsuario;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


end.


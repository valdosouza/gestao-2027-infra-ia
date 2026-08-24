unit ControllerCategory;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblCategory, prm_category;

Type
  TListaCategory = TObjectList<TCategory>;
  TControllerCategory = Class(TControllerBase)
  private
    FParametros: TPrmCategory;
    procedure setFParametros(const Value: TPrmCategory);

  public
    Registro : TCategory;
    Lista : TListaCategory;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    procedure deleteCascate;
    function getByKey:Boolean;
    function salva:boolean;
    function existDependece:Boolean;
    procedure getbyId;
    function getGroup:Boolean;
    function ProximoCodigo: integer;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmCategory read FParametros write setFParametros;
  End;

implementation

{ ControllerCategory}

function TControllerCategory.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCategory.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCategory.Create;
  FParametros := TPrmCategory.Create;
  Lista := TListaCategory.Create;
end;

function TControllerCategory.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCategory.deleteCascate;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'DELETE ',
              'from tb_category ',
              'where POSIT_LEVEL like :POSIT_LEVEL ',
              ' AND (TB_INSTITUTE_ID =:TB_INSTITUTE_ID) '
      ));
      ParamByName('TB_INSTITUTE_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('POSIT_LEVEL').AsString := concat( Registro.NivelPosicao, '%');
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

destructor TControllerCategory.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerCategory.existDependece: Boolean;
begin
  result := false;
end;

function TControllerCategory.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCategory.ProximoCodigo: integer;
begin
  Result := getNextByField(Registro,'ID',0);
end;

function TControllerCategory.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'ID',0);
  SaveObj(Registro);
end;

function TControllerCategory.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCategory.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCategory;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_CATEGORY WHERE 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Estabelecimento > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TB_INSTITUTE_ID = :TB_INSTITUTE_ID';
        ParamByName('TB_INSTITUTE_ID').AsInteger := FParametros.FieldName.Estabelecimento;
      end;

      SQL.Text := SQL.Text + ' ORDER BY POSIT_LEVEL';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCategory.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCategory.setFParametros(const Value: TPrmCategory);
begin
  FParametros := Value;
end;

procedure TControllerCategory.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCategory.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

function TControllerCategory.getGroup: Boolean;
var
  Qry : TSTQuery;
  LITem : TCategory;
begin
  getByKey;
  if exist then
  Begin
    Try
      Qry := GeraQuery;
      with Qry do
      Begin
        sql.add(concat('SELECT *                                     ',
                        'FROM tb_category                            ',
                       'where ( tb_institution_id =:institution_id ) '
        ));
        //Passagem de parametros
        parambyname('institution_id').AsInteger := Parametros.FieldName.Estabelecimento;

        if (Parametros.FieldName.Codigo > 0 ) then
          sql.add(' AND ( id=:id )');

        if (Parametros.FieldName.NivelPosicao <> '' ) then
          sql.add(' AND ( ( posit_level =:one_level ) or (posit_level =:posit_level ) )');

        if (Parametros.FieldName.Codigo >0 ) then
        Begin
          parambyname('id').AsInteger := Parametros.FieldName.Codigo;
        End;

        if (Parametros.FieldName.NivelPosicao <> '' ) then
        Begin
          parambyname('one_level').AsString := Copy(Parametros.FieldName.NivelPosicao,1,3);
          parambyname('posit_level').AsString := Parametros.FieldName.NivelPosicao;
        End;

        Active := True;
        FetchAll;
        exist := RecordCount > 0;
        First;
        Lista.Clear;
        while not eof do
        Begin
          LITem := TCategory.Create;
          get(Qry,LITem);
          Lista.add(LITem);
          next;
        end;
      end;
    Finally
      Qry.Close;
      FreeAndNil(Qry);
    End;
  End;

end;

end.


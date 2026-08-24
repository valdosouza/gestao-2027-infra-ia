unit ControllerTaxes;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblTaxes, prm_taxes, Md5, Generics.Collections, STQuery, ControllerTaxesCbs, ControllerTaxesIncidency, ControllerEClass, ControllerTaxesIbsUF, ControllerTaxesIbsMun;

type

  TListTaxes = TObjectList<TTaxes>;
  TControllerTaxes = class(TControllerBase)
  private
    FParametros: TPrmTaxes;
    procedure setFParametros(const Value: TPrmTaxes);
    // nenhum campo privado necessário
  public
    Registro: TTaxes;
    Lista : TListTaxes;
    CBS : TControllerTaxesCbs;
    IBS_UF : TControllerTaxesIbsUF;
    IBS_Mun : TControllerTaxesIbsMun;

    Incidencia: TControllerTaxesIncidency;
    EClass : TControllerEClass;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure Clear;
    procedure Search;
    property Parametros : TPrmTaxes read FParametros write setFParametros;
  end;

implementation

{ TControllerTaxes }

procedure TControllerTaxes.Clear;
begin
  clearObj(Registro);
  CBS.Clear;
  IBS_UF.Clear;
  IBS_Mun.Clear;
end;

constructor TControllerTaxes.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListTaxes.Create;
  Registro := TTaxes.Create;
  FParametros := TPrmTaxes.Create;
  CBS := TControllerTaxesCbs.Create(Self);

  Incidencia:= TControllerTaxesIncidency.Create(Self);
  EClass := TControllerEClass.Create(Self);
  IBS_UF := TControllerTaxesIbsUF.Create(Self);
  IBS_Mun := TControllerTaxesIbsMun.Create(Self);
end;

destructor TControllerTaxes.Destroy;
begin
  FreeAndNil( Incidencia );
  FreeAndNil( Lista );
  FreeAndNil( FParametros);
  FreeAndNil( Registro);
  FreeAndNil( CBS );
  FreeAndNil( IBS_UF );
  FreeAndNil( IBS_Mun );
  FreeAndNil( EClass );
  inherited;
end;

function TControllerTaxes.save: Boolean;
begin
  Result := True;
  try
    if Registro.ID = 0 then
      Registro.ID := getNextByField(Registro,'ID',Registro.Institution);
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerTaxes.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxes;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT ',
                'ID, ',
                'TB_INSTITUTION_ID, ',
                'Description, ',
                'CST, ',
                'CLASSTRIB ',
                'FROM TB_TAXES T ',
                'WHERE TB_INSTITUTION_ID =:TB_INSTITUTION_ID '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := FParametros.FieldName.Institution;

      if not (FParametros.FieldName.Description = EmptyStr) then
      Begin
        SQL.Add(' AND (DESCRIPTION like :DESCRIPTION)');
        ParamByName('DESCRIPTION').AsString := concat('%', FParametros.FieldName.Description,'%');
      End;

      if not (FParametros.FieldName.CST = EmptyStr) then
      Begin
        SQL.Add(' AND (cst =:CST )');
        ParamByName('CST').AsString := FParametros.FieldName.CST;
      End;

      if not (FParametros.FieldName.classtrib = EmptyStr) then
      Begin
        SQL.Add(' AND (CLASSTRIB =:CLASSTRIB )');
        ParamByName('CLASSTRIB').AsString := fParametros.FieldName.classtrib;
      End;



      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTaxes.Create;
        LITem.ID            := FieldByName('ID').AsInteger;
        LITem.Institution   := FieldByName('TB_INSTITUTION_ID').asInteger;
        LITem.Description   := FieldByName('Description').AsString;
        LITem.CST           := FieldByName('CST').AsString;
        LITem.classtrib     := FieldByName('CLASSTRIB').AsString;
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxes.setFParametros(const Value: TPrmTaxes);
begin
  FParametros := Value;
end;

function TControllerTaxes.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxes.delete: Boolean;
begin
  Result := True;
  try
    //IBS - UF
    IBS_UF.Registro.tb_taxes_id := Registro.ID;
    IBS_UF.delete;
    //IBS - MUN
    IBS_Mun.Registro.tb_taxes_id := Registro.ID;
    IBS_Mun.delete;
    //CBS
    CBS.Registro.tb_taxes_id := Registro.ID;
    CBS.delete;
    //Taxes
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxes.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);

  CBS.Registro.tb_taxes_id := Registro.ID;
  CBS.getByKey;

  IBS_UF.Registro.tb_taxes_id := Registro.ID;
  IBS_UF.getByKey;

  IBS_Mun.Registro.tb_taxes_id := Registro.ID;
  IBS_Mun.getByKey;
end;

end.


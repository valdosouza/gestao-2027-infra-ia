unit ControllerAssistenciaItens;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, Generics.Collections, tblAssistenciaItens, Md5, STQuery, prm_assistance_itens;

Type
  TListAssistanceItens = TObjectList<TAssistenciaItens>;
  TControllerAssistenciaItens = Class(TControllerBase)
  private
    FParametros: TPrmAssistanceItens;
    procedure setFParametros(const Value: TPrmAssistanceItens);
  public
    Registro : TAssistenciaItens;
    Lista : TListAssistanceItens;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure save;
    procedure insert;
    procedure update;
    procedure delete;
    procedure getByKey;
    procedure clear;
    procedure Search;
    property Parametros : TPrmAssistanceItens read FParametros write setFParametros;
  End;

implementation

{ TControllerAssistenciaItens }

procedure TControllerAssistenciaItens.clear;
begin
  ClearObj(Registro)
end;

constructor TControllerAssistenciaItens.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAssistenciaItens.create;
  Lista := TListAssistanceItens.create;
  FParametros := TPrmAssistanceItens.create;
end;

procedure TControllerAssistenciaItens.delete;
begin
  deleteObj(Registro);
end;

destructor TControllerAssistenciaItens.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  inherited;
end;

procedure TControllerAssistenciaItens.getByKey;
begin
  _getByKey(Registro);
end;

procedure TControllerAssistenciaItens.insert;
begin
  if (Registro.Codigo = 0) then
    Registro.Codigo := Generator('GN_ITENS_ASS');
  insertObj(Registro);
end;

procedure TControllerAssistenciaItens.save;
begin
  if (Registro.Codigo = 0) then
    Registro.Codigo := Generator('GN_ITENS_ASS');
  saveObj(Registro);
end;

procedure TControllerAssistenciaItens.Search;
Var
  Lc_Qry : TSTQuery;
  Lc_item : TAssistenciaItens;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT ',
              '  IAS_CODIGO, ',
              '  IAS_CODASS, ',
              '  IAS_ETAPA, ',
              '  IAS_DATA, ',
              '  IAS_HOUR, ',
              '  IAS_DESCRITIVO, ',
              '  IAS_DT_PREVISTA, ',
              '  IAS_VL_CLIENTE, ',
              '  IAS_VL_CUSTO, ',
              '  IAS_DT_REALIZADA, ',
              '  IAS_CODSIT, ',
              '  SIT_DESCRICAO ',
              'FROM TB_ITENS_ASS i ',
              '   LEFT OUTER JOIN TB_SITUACAO s ',
              '   ON (s.SIT_CODIGO = i.IAS_CODSIT) ',
              'WHERE IAS_CODASS=:ASS_CODIGO  ',
              'ORDER BY IAS_ETAPA '
      ));

      ParamByName('ASS_CODIGO').AsInteger := Parametros.FieldName.Assistencia;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        Lc_item := TAssistenciaItens.Create;
        get(Lc_Qry, Lc_item);
        Lc_item.SituacaoDesc := FieldByName('SIT_DESCRICAO').AsString;
        Lista.add(Lc_item);
        Next;
      end;
    End;
  Finally
    FinalizaQuery(lc_Qry);
  End;
end;

procedure TControllerAssistenciaItens.setFParametros(
  const Value: TPrmAssistanceItens);
begin
  FParametros := Value;
end;

procedure TControllerAssistenciaItens.update;
begin
  updateObj(Registro);
end;

end.

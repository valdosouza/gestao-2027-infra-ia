unit ControllerAssistencia;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, Generics.Collections, tblAssistencia, Md5, STQuery, prm_assistance, ControllerAssistenciaItens;

Type
  TListAssistance = TObjectList<TAssistencia>;
  TControllerAssistencia = Class(TControllerBase)

  private
    FParametros: TPrmAssistance;
    procedure setFParametros(const Value: TPrmAssistance);

  public
    Registro : TAssistencia;
    Lista : TListAssistance;
    Itens : TControllerAssistenciaItens;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
    procedure Search;
    property Parametros : TPrmAssistance read FParametros write setFParametros;
  End;

  implementation
{ ControllerAssistencia }


procedure TControllerAssistencia.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerAssistencia.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAssistencia.Create;
  Lista := TListAssistance.Create;
  Itens := TControllerAssistenciaItens.Create(self);
  FParametros := TPrmAssistance.create;
end;

function TControllerAssistencia.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAssistencia.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil( Lista );
  FreeAndNil( Registro );
  FreeAndNil( Itens );
  inherited;
end;

function TControllerAssistencia.insert: boolean;
begin
  try
    if (Registro.Codigo = 0) then
      Registro.Codigo := Generator('GN_ASSISTENCIA');
    if (Registro.Numero = 0) then
      Registro.Numero := Generator('GN_ASSISTENCIA_NR');
    InsertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAssistencia.save: boolean;
begin
  try
    if (Registro.Codigo = 0) then
      Registro.Codigo := Generator('GN_ASSISTENCIA');
    if (Registro.Numero = 0) then
      Registro.Numero := Generator('GN_ASSISTENCIA_NR');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerAssistencia.Search;
Var
  Lc_Qry : TSTQuery;
  Lc_item : TAssistencia;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT a.*, e.EMP_FANTASIA, e.EMP_NOME, s.SIT_CODIGO, s.SIT_DESCRICAO ' ,
                'FROM TB_ASSISTENCIA a ' ,
                '  INNER JOIN TB_EMPRESA e ',
                '  ON (e.EMP_CODIGO = a.ASS_CODEMP ) ',
                '  INNER JOIN TB_ITENS_ASS i ',
                '  ON (i.IAS_CODASS = a.ASS_CODIGO ) ',
                '  LEFT OUTER JOIN TB_SITUACAO s ',
                '  ON (s.SIT_CODIGO = i.IAS_CODSIT ) ',
                'WHERE (ASS_CODIGO IS NOT NULL) '
      ));

      if (FParametros.Periodo) then
      Begin
        SQL.Add(' AND (ASS_PRAZO BETWEEN :DATAINICIAL AND :DATAFINAL ) ');
        ParamByName('DATAINICIAL').AsDate := FParametros.DataInicial;
        ParamByName('DATAFINAL').AsDate := FParametros.DataFinal;
      End;

      if ( FParametros.FieldName.Numero > 0 ) then
      Begin
        SQL.Add(' AND (ASS_NUMERO =:ASS_NUMERO) ');
        ParamByName('ASS_NUMERO').AsInteger := FParametros.FieldName.Numero;
      End;

      if ( FParametros.FieldName.NomeRazao <> '') then
      Begin
        SQL.Add(' AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ');
        ParamByName('EMP_FANTASIA').AsString := '%'+FParametros.FieldName.NomeRazao+'%';
      End;

      if ( FParametros.FieldName.SituacaoId > 0 ) then
      Begin
        SQL.Add(' AND (IAS_CODSIT =:IAS_CODSIT) ');
        ParamByName('IAS_CODSIT').AsInteger := FParametros.FieldName.SituacaoId;
      End;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        Lc_item := TAssistencia.Create;
        get(Lc_Qry, Lc_item);

        Lc_item.NomeRazao := FieldByName('EMP_NOME').AsString;
        Lc_item.ApelidoFantasia := FieldByName('EMP_FANTASIA').AsString;
        Lc_item.SituacaoId := FieldByName('SIT_CODIGO').AsInteger;
        Lc_item.SituacaoDesc := FieldByName('SIT_DESCRICAO').AsString;
        Lista.add(Lc_item);

        Next;
      end;
    End;
  Finally
    FinalizaQuery(lc_Qry);
  End;
end;

procedure TControllerAssistencia.setFParametros(const Value: TPrmAssistance);
begin
  FParametros := Value;
end;

function TControllerAssistencia.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerAssistencia.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
end.



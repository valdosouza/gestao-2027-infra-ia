unit ControllerNotification;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, prm_notification, tblNotification, System.StrUtils;

Type
  TListNotification  = TObjectList<TNotification>;

  TControllerNotification = Class(TControllerBase)
  private
    FParametros: TPrmNotification;
    procedure setFParametros(const Value: TPrmNotification);

  public
    Registro : TNotification;
    Lista : TListNotification;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure insert;
    procedure update;
    procedure clear;
    procedure changeStatus;
    procedure Search;
    property Parametros : TPrmNotification read FParametros write setFParametros;
  End;

implementation

{ TControllerNotification }

procedure TControllerNotification.changeStatus;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := concat(
                    'UPDATE TB_NOTIFICATION SET ',
                    '"ACTIVE" =:ACTIVE ',
                    'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                    ' AND ( ID =:ID ) '
      );
      ParamByName('ACTIVE').AsString := Registro.Ativo;
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('ID').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerNotification.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerNotification.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNotification.Create;
  FParametros := TPrmNotification.Create;
  Lista := TListNotification.Create;
end;

destructor TControllerNotification.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil( FParametros );
  FreeAndNil( Registro );
  inherited;
end;

procedure TControllerNotification.insert;
begin
  Registro.Codigo := Generator('GN_NOTIFICATION');
  Registro.createdAt := Now;
  Registro.updatedAt := Now;
  insertObj(Registro);
end;

procedure TControllerNotification.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TNotification;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_NOTIFICATION WHERE id is not null';

      if Parametros.Estabelecimento > 0 then
      Begin
        SQL.Text := SQL.Text + ' AND (TB_INSTITUTION_ID =:TB_INSTITUTION_ID )';
        ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      End;

      Case AnsiIndexStr(Parametros.FieldName.Ativo, ['S', 'N']) of
        0:Begin
            SQL.Text := SQL.Text + ' AND (ACTIVE =:ACTIVE )';
            ParamByName('ACTIVE').AsString := 'S';
        End;
        1:Begin
            SQL.Text := SQL.Text + ' AND (ACTIVE =:ACTIVE )';
            ParamByName('ACTIVE').AsString := 'N';
        End;
      End;

      if Parametros.FieldName.createdAt > 0 then
      begin
        SQL.Text := SQL.Text + ' AND (CREATED_AT >=:CREATED_AT )';
        ParamByName('CREATED_AT').AsDateTime := Parametros.FieldName.createdAt;
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TNotification.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerNotification.setFParametros(const Value: TPrmNotification);
begin
  FParametros := Value;
end;

procedure TControllerNotification.update;
begin
  Registro.updatedAt := Now;
  updateObj(Registro);
end;

end.

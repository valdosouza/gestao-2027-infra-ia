unit ControllerDocumentoImportacao;

interface

uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, ControllerAdicaoImportacao, Un_sistema, Un_Regra_Negocio, tblDocumentoImportacao, Un_MSg;

Type
  TControllerDocumentoImportacao = Class(TControllerBase)
  private

  public
    Registro : TDocumentoImportacao;
    Adicao : TControllerAdicaoImportacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure getByITF;
    function insere:boolean;
    Function delete:boolean;
    procedure clear;
  End;

implementation

procedure TControllerDocumentoImportacao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerDocumentoImportacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDocumentoImportacao.Create;
  Adicao := TControllerAdicaoImportacao.Create(self);
end;

function TControllerDocumentoImportacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDocumentoImportacao.Destroy;
begin
  FreeAndNil( Adicao );
  FreeAndNil( Registro );
  inherited;
end;

function TControllerDocumentoImportacao.insere: boolean;
begin
  if Registro.Codigo = 0 then Registro.Codigo := Generator('GN_DEC_IMP');
  insertObj(Registro);
end;

function TControllerDocumentoImportacao.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_DEC_IMP');
  SaveObj(Registro);
end;

procedure TControllerDocumentoImportacao.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerDocumentoImportacao.getByITF;
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
              'SELECT * ',
              'from TB_DEC_IMP ',
              'where DIM_CODITF = :DIM_CODITF '
      ));
      ParamByName('DIM_CODITF').AsInteger := Registro.CodigoItem;
      Active := True;
      FetchAll;
      exist := recordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

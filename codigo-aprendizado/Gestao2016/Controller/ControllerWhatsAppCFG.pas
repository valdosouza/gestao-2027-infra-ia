unit ControllerWhatsAppCFG;

interface

uses     STDatabase, Classes, STQuery, SysUtils, ControllerBase, tblWhatsAppCFG, Generics.Collections;


Type
  TListaWhatsAppCFG = TObjectList<TWhatsAppCFG>;

  TControllerWhatsAppCFG = Class(TControllerBase)

  private

  public
    Registro : TWhatsAppCFG;
    Lista : TListaWhatsAppCFG;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function salva:boolean;
    procedure getbyId;
    procedure getByDescription;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure CorrigeDuplicados;
  End;

implementation

procedure TControllerWhatsAppCFG.Clear;
begin
  clearObj(Registro);
end;

procedure TControllerWhatsAppCFG.CorrigeDuplicados;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add('DELETE FROM TB_SEND_WHATSAPP ');
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

constructor TControllerWhatsAppCFG.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TWhatsAppCFG.Create;
  Lista := TListaWhatsAppCFG.Create;
end;

function TControllerWhatsAppCFG.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerWhatsAppCFG.Destroy;
begin
  FreeAndNil( Lista );
  FreeAndNil( Registro );
  inherited;
end;

function TControllerWhatsAppCFG.insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getMaxTable('ID','TB_WHATSAPP_CFG');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerWhatsAppCFG.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID',Registro.Estabelecimento);
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerWhatsAppCFG.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerWhatsAppCFG.getByDescription;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_WHATSAPP_CFG ',
                     'WHERE UPPER(DESCRIPTION) =:DESCRIPTION '
      ));
      ParamByName('DESCRIPTION').AsString :=  Registro.Descricao;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerWhatsAppCFG.getById;
begin
  _getByKey(Registro);
end;

function TControllerWhatsAppCFG.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TWhatsAppCFG;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_WHATSAPP_CFG '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TWhatsAppCFG.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

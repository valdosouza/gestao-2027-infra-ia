unit ControllerSendWhatsApp;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblSendWhatsApp;

Type
  TListSendWhatsApp  = TObjectList<TSendWhatsApp>;

  TControllerSendWhatsApp = Class(TControllerBase)
  private
  public
    Registro : TSendWhatsApp;
    Lista : TListSendWhatsApp;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure insert;
    procedure update;
    procedure delete;
    procedure Search;
  End;

implementation

{ TControllerSendWhatsApp }

constructor TControllerSendWhatsApp.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSendWhatsApp.create;
  Lista := TListSendWhatsApp.create;
end;

procedure TControllerSendWhatsApp.delete;
begin
  DeleteObj(Registro);
end;

destructor TControllerSendWhatsApp.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  inherited;
end;


procedure TControllerSendWhatsApp.insert;
begin
  Registro.Codigo := Generator('GN_SEND_WHATSAPP');
  InsertObj(Registro);
end;

procedure TControllerSendWhatsApp.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TSendWhatsApp;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := concat(
                    ' SELECT * ',
                    'FROM TB_SEND_WHATSAPP ',
                    'WHERE HR_SENT is null '
      );
      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TSendWhatsApp.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerSendWhatsApp.update;
begin
  UpdateObj(Registro);
end;

end.

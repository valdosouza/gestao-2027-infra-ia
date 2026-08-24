unit STDatabase;

interface

uses
  System.SysUtils, System.Classes, Data.DB,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
   FireDAC.Comp.Client;

type
  TSTDatabase = class(TFDConnection)
  private
    FDatabaseName: String;
    FServerType: String;
    procedure setFDatabaseName(const Value: String);
    procedure SetServerType(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    // Compatibilidade com DFMs antigos do IBX
    property DatabaseName : String read FDatabaseName write setFDatabaseName;
    property ServerType : String read FServerType write SetServerType;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTDatabase]);
end;

{ TSTDatabase }

procedure TSTDatabase.setFDatabaseName(const Value: String);
begin
  FDatabaseName := Value;

  if Params.Values['DriverID'] = '' then
    Params.Values['DriverID'] := 'FB';
  Params.Values['Database'] := Value;
end;

procedure TSTDatabase.SetServerType(const Value: String);
begin
  FServerType := Value;
end;

end.

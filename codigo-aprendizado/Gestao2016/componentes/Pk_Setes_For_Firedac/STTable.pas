unit STTable;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, STTransaction, STDatabase;

type
  TSTTable = class(TFDTable)
  private
    FTSTTransaction: TSTTransaction;
    FDatabase: TSTDatabase;
    procedure setFTSTTransaction(const Value: TSTTransaction);
    procedure setFDatabase(const Value: TSTDatabase);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Database: TSTDatabase read FDatabase write setFDatabase;
    property Transaction: TSTTransaction read FTSTTransaction write setFTSTTransaction;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTTable]);
end;

{ TSTTable }

procedure TSTTable.setFDatabase(const Value: TSTDatabase);
begin
  FDatabase := Value;
  Connection := Value;
end;

procedure TSTTable.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
  inherited Transaction := Value;
  UpdateTransaction := Value;

  if (not Assigned(Connection)) and Assigned(Value) and Assigned(Value.DefaultDatabase) then
    Connection := Value.DefaultDatabase;
end;

end.

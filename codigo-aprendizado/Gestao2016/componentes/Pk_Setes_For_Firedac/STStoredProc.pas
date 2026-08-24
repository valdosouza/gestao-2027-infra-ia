unit STStoredProc;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STDatabase, STTransaction;

type
  TSTStoredProc = class(TFDStoredProc)
  private
    FDatabase: TSTDatabase;
    FTSTTransaction: TSTTransaction;
    FForcedRefresh: Boolean;
    procedure setFDatabase(const Value: TSTDatabase);
    procedure setFTSTTransaction(const Value: TSTTransaction);
    procedure setFForcedRefresh(const Value: Boolean);
    procedure EnsureTransactionActive;
    { Private declarations }
  protected
    procedure DoBeforeOpen; override;
  public
    procedure ExecProc;
    { Public declarations }
  published
    property ForcedRefresh :Boolean read FForcedRefresh write setFForcedRefresh;
    property Database : TSTDatabase read FDatabase write setFDatabase;
    property Transaction : TSTTransaction read FTSTTransaction write setFTSTTransaction;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTStoredProc]);
end;

{ TSTStoredProc }

procedure TSTStoredProc.EnsureTransactionActive;
begin
  if Assigned(FTSTTransaction) and not FTSTTransaction.InTransaction then
    FTSTTransaction.StartTransaction;
end;

procedure TSTStoredProc.DoBeforeOpen;
begin
  EnsureTransactionActive;
  inherited DoBeforeOpen;
end;

procedure TSTStoredProc.ExecProc;
begin
  EnsureTransactionActive;
  inherited ExecProc;
end;

procedure TSTStoredProc.setFDatabase(const Value: TSTDatabase);
begin
  FDatabase := Value;
  Connection := Value;
end;

procedure TSTStoredProc.setFForcedRefresh(const Value: Boolean);
begin
  FForcedRefresh := Value;
end;

procedure TSTStoredProc.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
  inherited Transaction := Value;
  UpdateTransaction := Value;

  if (not Assigned(Connection)) and Assigned(Value) and Assigned(Value.DefaultDatabase) then
    Connection := Value.DefaultDatabase;
end;

end.

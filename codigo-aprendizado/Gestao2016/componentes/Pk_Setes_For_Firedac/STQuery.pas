unit STQuery;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STTransaction,STDatabase;

type
  TSTQuery = class(TFDQuery)
  private
    FTSTTransaction: TSTTransaction;
    FForcedRefresh: Boolean;
    FDatabase: TSTDatabase;
    FBufferChunks: Integer;
    FParamCheck: Boolean;
    procedure setFTSTTransaction(const Value: TSTTransaction);
    procedure setFForcedRefresh(const Value: Boolean);
    procedure setFDatabase(const Value: TSTDatabase);
    procedure SetBufferChunks(const Value: Integer);
    procedure EnsureTransactionActive;
    { Private declarations }
  protected
    procedure DoBeforeOpen; override;
  public
    procedure ExecSQL; reintroduce; overload;
    { Public declarations }
  published
    property ForcedRefresh :Boolean read FForcedRefresh write setFForcedRefresh;
    property Database : TSTDatabase read FDatabase write setFDatabase;
    property Transaction : TSTTransaction read FTSTTransaction write setFTSTTransaction;
    {$REGION 'Propriedades de compatibilidade com o componente IB'}
    //[default (1000)]
    property BufferChunks: Integer read FBufferChunks write SetBufferChunks;
    //[default (true)]
    property ParamCheck: Boolean read FParamCheck write FParamCheck;
    //property Database: TSTDatabase read GetDatabase write SetDatabase;
    {$ENDREGION}
 end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTQuery]);
end;

{ TSTQuery }

procedure TSTQuery.EnsureTransactionActive;
begin
  if Assigned(FTSTTransaction) and not FTSTTransaction.InTransaction then
    FTSTTransaction.StartTransaction;
end;

procedure TSTQuery.DoBeforeOpen;
begin
  EnsureTransactionActive;
  inherited DoBeforeOpen;
end;

procedure TSTQuery.ExecSQL;
begin
  EnsureTransactionActive;
  inherited ExecSQL;
end;

procedure TSTQuery.SetBufferChunks(const Value: Integer);
begin
  FBufferChunks := Value;
end;

procedure TSTQuery.setFDatabase(const Value: TSTDatabase);
begin
  FDatabase := Value;
  Connection := Value;
end;

procedure TSTQuery.setFForcedRefresh(const Value: Boolean);
begin
  FForcedRefresh := Value;
end;

procedure TSTQuery.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
  inherited Transaction := Value;
  UpdateTransaction := Value;

  if (not Assigned(Connection)) and Assigned(Value) and Assigned(Value.DefaultDatabase) then
    Connection := Value.DefaultDatabase;
end;

end.

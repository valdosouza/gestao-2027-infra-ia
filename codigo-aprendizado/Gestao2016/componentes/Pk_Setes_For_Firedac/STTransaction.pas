unit STTransaction;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Client,
  STDatabase;

type
  TSTTransaction = class(TFDTransaction)
  private

    FDefaultDatabase: TSTDatabase;
    FParams: TStringList;
    function GetActive: Boolean;
    procedure setFDefaultDatabase(const Value: TSTDatabase);
    procedure setFParams(const Value: TStringList);
    procedure SetActive(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    function inTransaction: boolean;
    procedure StartTransaction;
    property Params : TStringList read FParams write setFParams;
    property DefaultDatabase : TSTDatabase read FDefaultDatabase write setFDefaultDatabase;
    property Active: Boolean read GetActive write SetActive;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTTransaction]);
end;

{ TSTTransaction }

constructor TSTTransaction.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TStringList.Create;
end;

destructor TSTTransaction.Destroy;
begin
  FreeAndNil( FParams);
  inherited;
end;

function TSTTransaction.inTransaction: boolean;
begin
  Result := GetActive;
end;

function TSTTransaction.GetActive: Boolean;
begin
  Result := inherited Active;
end;

procedure TSTTransaction.setFDefaultDatabase(const Value: TSTDatabase);
begin
  FDefaultDatabase := Value;
  Connection := Value;
end;


procedure TSTTransaction.setFParams(const Value: TStringList);
begin
  FParams.Assign(Value);
end;

procedure TSTTransaction.StartTransaction;
begin
  if (not Assigned(Connection)) and Assigned(FDefaultDatabase) then
    Connection := FDefaultDatabase;

  if not GetActive then
    inherited StartTransaction;
end;

procedure TSTTransaction.SetActive(const Value: Boolean);
begin
  if Value then
    StartTransaction
  else if GetActive then
    Rollback;
end;

end.

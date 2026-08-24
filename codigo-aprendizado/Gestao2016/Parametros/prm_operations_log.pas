unit prm_operations_log;

interface

uses
      prm_dsk_base, tblOperationsLog, System.SysUtils;

Type
  TPrmOperationsLog = class(TPrmDskBase)
  private
    FFieldName: TOperationsLog;
    procedure setFFieldName(const Value: TOperationsLog);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TOperationsLog read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmOperationsLog.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmOperationsLog.Create;
begin
  inherited;
  FFieldName := TOperationsLog.Create;
end;

destructor TPrmOperationsLog.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmOperationsLog.setFFieldName(const Value: TOperationsLog);
begin
  FFieldName := Value;
end;

end.


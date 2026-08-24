unit STSQL;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.Client, STDatabase, STTransaction;

type
  TSTSQL = class(TFDCommand)
  private
    FDatabase: TSTDatabase;
    FTSTTransaction: TSTTransaction;
    function GetSQL: TStrings;
    procedure setFDatabase(const Value: TSTDatabase);
    procedure setFTSTTransaction(const Value: TSTTransaction);
  public
    procedure ExecQuery;
    procedure Unprepare;
    procedure Close;
  published
    property Database: TSTDatabase read FDatabase write setFDatabase;
    property Transaction: TSTTransaction read FTSTTransaction write setFTSTTransaction;
    property SQL: TStrings read GetSQL;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTSQL]);
end;

{ TSTSQL }

procedure TSTSQL.Close;
begin
  Unprepare;
end;

procedure TSTSQL.ExecQuery;
begin
  Execute;
end;

function TSTSQL.GetSQL: TStrings;
begin
  Result := CommandText;
end;

procedure TSTSQL.setFDatabase(const Value: TSTDatabase);
begin
  FDatabase := Value;
  Connection := Value;
end;

procedure TSTSQL.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
  inherited Transaction := Value;

  if (not Assigned(Connection)) and Assigned(Value) and Assigned(Value.DefaultDatabase) then
    Connection := Value.DefaultDatabase;
end;

procedure TSTSQL.Unprepare;
begin
  if Prepared then
    inherited Unprepare;
end;

end.

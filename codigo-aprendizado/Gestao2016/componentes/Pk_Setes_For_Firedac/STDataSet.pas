unit STDataSet;

interface

uses
  System.Classes,STTable;

type
  TSTDataSet = class(TSTTable)
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTDataSet]);
end;

end.

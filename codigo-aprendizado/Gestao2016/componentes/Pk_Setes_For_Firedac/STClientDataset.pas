unit STClientDataset;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STDatabase;

type
  TSTClientDataset = class(TFDMemTable)
  private
    FDatabase: TSTDatabase;
    procedure setFDatabase(const Value: TSTDatabase);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Database: TSTDatabase read FDatabase write setFDatabase;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTClientDataset]);
end;

{ TSTClientDataset }

procedure TSTClientDataset.setFDatabase(const Value: TSTDatabase);
begin
  FDatabase := Value;
end;

end.

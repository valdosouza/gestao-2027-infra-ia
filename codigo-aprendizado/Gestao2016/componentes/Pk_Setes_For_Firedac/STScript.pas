unit STScript;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf,
  FireDAC.Comp.Script, STTransaction, STDatabase;

type
  TSTScript = class(TFDScript)
  private
    FTransaction: TSTTransaction;
    FParams: TStrings;
    procedure setFTransaction(const Value: TSTTransaction);
    function GetScript: TStrings;
    procedure SetScript(const Value: TStrings);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Transaction : TSTTransaction read FTransaction write setFTransaction;
    property Script: TStrings read GetScript write SetScript;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTScript]);
end;

{ TSTScript }


function TSTScript.GetScript: TStrings;
begin
  Result := FParams;
end;

procedure TSTScript.setFTransaction(const Value: TSTTransaction);
begin
  FTransaction := Value;
end;

procedure TSTScript.SetScript(const Value: TStrings);
begin

end;

end.

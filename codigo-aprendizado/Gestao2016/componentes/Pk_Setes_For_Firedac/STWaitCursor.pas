unit STWaitCursor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.UI;

type
  TSTWaitCursor = class(TFDGUIxWaitCursor)
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure Register;

implementation

uses
  FireDAC.VCLUI.Wait;

procedure Register;
begin
  RegisterComponents('Setes', [TSTWaitCursor]);
end;

{ TSTWaitCursor }

constructor TSTWaitCursor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Provider := 'Forms';
end;

end.

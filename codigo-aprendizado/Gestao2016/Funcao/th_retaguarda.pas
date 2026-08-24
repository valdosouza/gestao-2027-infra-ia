unit th_retaguarda;

interface

uses
      Classes, SysUtils, System.Threading, Controllerretaguarda;

type
  TRetaguarda = class(TThread)
  private
    Retaguarda : TControllerretaguarda;
  public
    constructor Create();
    destructor Destroy; override;
    procedure execute;override;

  end;

implementation

{ TRetaguarda }

constructor TRetaguarda.Create;
begin
  inherited Create (True);
//  Retaguarda := TControllerretaguarda.Create(self);
end;

destructor TRetaguarda.Destroy;
begin
  FreeAndNil(Retaguarda);
  inherited;
end;

procedure TRetaguarda.execute;
begin
  Retaguarda.getFirst;
  if Retaguarda.exist then
  Begin
    //Retaguarda.BancoPDV := DM.IBD_Gestao;
    Retaguarda.IniciaSincronia;
  end;
  Terminate;
end;

end.

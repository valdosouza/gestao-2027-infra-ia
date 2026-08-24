unit tas_item_obs;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls;

type
  TTasItemObs = class(TBaseRegistry)
    E_Detalhe: TMemo;
  private


  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    Confirma : Boolean;
  end;

var
  TasItemObs: TTasItemObs;

implementation

{$R *.dfm}

uses     Un_Msg, env;

{ TTasItenmObs }

procedure TTasItemObs.Cancel;
begin
  Close;
end;


procedure TTasItemObs.CriarVariaveis;
begin
  inherited;
  Confirma := False;
end;

procedure TTasItemObs.IniciaVariaveis;
begin
  inherited;
  EditionState := 'E';
  EditionControl;
end;

procedure TTasItemObs.Save;
begin
  Confirma := True;
  Close;
end;

function TTasItemObs.ValidateCancel: boolean;
begin
  Result := True;
end;

function TTasItemObs.ValidateSave: boolean;
begin
  Result := True;
  IF  (Trim(E_Detalhe.Text) = '')  then
  Begin
    MensagemPadrao(ATENCAO,
                   'Detalhamento é obrigatório.' + EOLN+
                   'Preencha antes de continuar.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

end.

unit Un_Command;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, ControllerCommand;

type
  TFr_Command = class(TBaseRegistry)
    E_Dt_REcord: TEdit;
    Label1: TLabel;
    e_Numero_Comanda: TEdit;
    Label2: TLabel;
    E_Nome_Cliente: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    E_Numero_Telefone: TEdit;
  private
    { Private declarations }
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;
    function ValidateSave:Boolean;Override;
    procedure SAve;Override;
    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;
    procedure EditionControl;Override;
    procedure execShorCutKeyF5;Override;
    procedure execShorCutKeyF6;Override;

  public
    { Public declarations }
    Command : TControllerCommand;
  end;

var
  Fr_Command: TFr_Command;

implementation

{$R *.dfm}

uses     UN_Principal, env, Un_Msg;

{ TFr_Command }

procedure TFr_Command.Cancel;
begin
  inherited;
  Self.close;
end;

procedure TFr_Command.CriarVariaveis;
begin
  inherited;
  Command := TControllerCommand.Create(self);
end;

procedure TFr_Command.EditionControl;
begin
  inherited;
  E_Dt_REcord.ReadOnly := True;
end;

procedure TFr_Command.execShorCutKeyF5;
begin
  Save;
end;

procedure TFr_Command.execShorCutKeyF6;
begin
  cancel;
end;

procedure TFr_Command.SAve;
begin
  with Command.Registro do
  Begin
    Numero      := e_Numero_Comanda.Text;
    NomeCliente := E_Nome_Cliente.Text;
    Telefone    := E_Numero_Telefone.Text;
  End;
  Command.insere;
  Self.Close;
end;

procedure TFr_Command.IniciaVariaveis;
begin
  ShowData;
  EditionState := 'I';
  EditionControl;
end;

procedure TFr_Command.ShowData;
begin
  CodigoRegistro := Command.Registro.Pedido;
  E_Dt_REcord.Text := DateTimeToStr(Command.Registro.DataRegistro);
  e_Numero_Comanda.Text := IntToStr(Command.Registro.Pedido);
end;

function TFr_Command.ValidateCancel: Boolean;
begin
  Result := True;
end;

function TFr_Command.ValidateSave: Boolean;
begin
  Result := True;
  if (e_Numero_Comanda.Text = '') then
  begin
    MensagemPadrao(' Mensagem de erro',ATENCAO+EOLN+EOLN+
                   ' O campo número da Comanda deve ser preenchido.'+EOLN+
                   ' Preencha o cmapo antes de continuar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    Exit;
  end;

  Command.Registro.Numero := e_Numero_Comanda.Text;

  if Command.veriryDuplicity then
  begin
    MensagemPadrao(' Mensagem de alerta',ATENCAO+EOLN+EOLN+
                   ' Este número de comanda ainda está sendo utilizado.'+EOLN+
                   ' Verifique ou escolha outro número.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Exit;
  end;

end;

end.

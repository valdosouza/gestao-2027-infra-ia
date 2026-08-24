unit cad_cargo;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, ControllerCargo;

type
  TcadCargo = class(TBaseRegistry)
    Label1: TLabel;
    Label2: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
  private
    { Private declarations }
 protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

    procedure ShowData;Virtual;
    procedure ShowNoData;Virtual;
    procedure ClearAllFields;Virtual;
    //inserir
    function ValidaInsert():boolean;Virtual;
    procedure Insert;Virtual;
    //Editar
    function ValidateChange():boolean;Virtual;
    procedure Change;Virtual;
    //Deletar
    function ValidateDelete():boolean;Virtual;
    procedure Delete;Virtual;
    //Salvar
    function ValidateSave():boolean;Virtual;
    procedure Save;Virtual;
    //Cancelar
    function ValidateCancel():boolean;Virtual;
    procedure Cancel;Virtual;

    procedure EditionControl;Virtual;
  public
    { Public declarations }
    Cargo : TControllerCargo;
  end;

var
  cadCargo: TcadCargo;

implementation

{$R *.dfm}

uses     Un_Msg;
{ TcadCargo }

procedure TcadCargo.Cancel;
begin
  if (EditionState = 'I') then
  Begin
    ClearFields(self);
    Self.Close;
  End
  else
  Begin
    ShowData;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TcadCargo.Change;
begin
  E_Descricao.SetFocus;
end;

procedure TcadCargo.ClearAllFields;
begin

end;

procedure TcadCargo.CriarVariaveis;
begin
  inherited;
  Cargo := TControllerCargo.create(self);
end;

procedure TcadCargo.Delete;
begin
  Cargo.delete;
end;

procedure TcadCargo.EditionControl;
begin
  Inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;




procedure TcadCargo.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    Cargo.Registro.Codigo := Self.CodigoRegistro;
    Cargo.getbyId;
  End;
  inherited;
end;

procedure TcadCargo.Insert;
begin
  inherited;
  E_Descricao.SetFocus;

end;

procedure TcadCargo.Save;
begin
  Cargo.Registro.Codigo := 0;
  Cargo.Registro.Descricao := 'analista';
  Cargo.salva;
end;


procedure TcadCargo.ShowData;
begin
  with Cargo.Registro do
  Begin
    E_Codigo.Text := Codigo.ToString();
    E_Descricao.Text := Descricao;
  End;
end;

procedure TcadCargo.ShowNoData;
begin
  E_Codigo.Clear;
  E_Descricao.Clear
end;

function TcadCargo.ValidaInsert: boolean;
begin
  REsult := True;
end;

function TcadCargo.ValidateCancel: boolean;
begin
  REsult := True;
end;

function TcadCargo.ValidateChange: boolean;
begin
  REsult := True;
end;

function TcadCargo.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja relamente excluir esta Cargo?.' + EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TcadCargo.ValidateSave: boolean;
begin
  Result:=true;
  if (trim(E_Descricao.Text) = '') then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Descrição do Cargo não informado.'+EOLN+
                   'Preencha a Descrição deste Cargo.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.

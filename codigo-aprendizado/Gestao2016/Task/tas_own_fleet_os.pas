unit tas_own_fleet_os;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, ControllerOwnFleetOs;

type
  TTasOwnFleetOs = class(TBaseRegistry)
    Label4: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    E_Placa: TMaskEdit;
    E_Km: TEdit;
    E_Data: TDateTimePicker;
    Label1: TLabel;
    Label9: TLabel;
    E_Obs: TMemo;
    E_Marca_Modelo: TEdit;
    Label2: TLabel;
    procedure E_PlacaExit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure LimpaCampos;
    procedure SearchVehicle;
    procedure GetVehicle;
  protected
    procedure CriarVariaveis;Override;

    procedure setPerfil;Override;

    procedure ShowData;Override;
    procedure IniciaVariaveis;Override;

    procedure Insert;Override;

    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;
    procedure EditionControl;Override;
  public
    OnwFleetOS : TControllerOwnFleetOs;
  end;

var
  TasOwnFleetOs: TTasOwnFleetOs;

implementation

{$R *.dfm}

uses     UN_Sistema, UN_Principal, env, Un_Msg, Un_Veiculo;

{ TTasOwnFleetOs }

procedure TTasOwnFleetOs.SearchVehicle;
Var
  Lc_Form : TFr_Veiculo;
begin
  Try
    Lc_Form := TFr_Veiculo.Create(Self);
    Lc_Form.ShowModal;
    E_Placa.Text := Lc_Form.vehicle.Registro.Placa;
    GetVehicle;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TTasOwnFleetOs.Cancel;
begin
  inherited;
end;

procedure TTasOwnFleetOs.Change;
begin
  inherited;
  E_Placa.SetFocus;
  EditionState := 'E';
  EditionControl;
end;

procedure TTasOwnFleetOs.CriarVariaveis;
begin
  inherited;
  OnwFleetOS := TControllerOwnFleetOs.create(Self);
end;

procedure TTasOwnFleetOs.Delete;
begin
  inherited;
  OnwFleetOS.delete;
  Close;

end;

procedure TTasOwnFleetOs.EditionControl;
begin
  inherited;

end;

procedure TTasOwnFleetOs.E_PlacaExit(Sender: TObject);
begin
  inherited;
  if EditionState = 'I' then
    GetVehicle;
end;

procedure TTasOwnFleetOs.GetVehicle;
begin
  OnwFleetOS.Vehicle.Registro.Placa := E_Placa.Text;
  OnwFleetOS.Vehicle.getAll;
  E_placa.text := OnwFleetOS.Vehicle.registro.placa;
  E_Marca_Modelo.Text := concat(OnwFleetOS.Vehicle.Marca.Registro.Descricao,'/',OnwFleetOS.Vehicle.Modelo.Registro.Descricao);
  E_Data.SetFocus;
end;

procedure TTasOwnFleetOs.IniciaVariaveis;
begin
  if CodigoRegistro > 0 then
  Begin
    OnwFleetOS.Registro.Codigo := Self.CodigoRegistro;
    OnwFleetOS.Registro.Estabelecimento := Gb_CodMha;
    OnwFleetOS.getById;
  End;
  inherited;
end;

procedure TTasOwnFleetOs.Insert;
begin
  LimpaCampos;
  E_Placa.SetFocus;
  EditionState := 'I';
  EditionControl;
end;

procedure TTasOwnFleetOs.LimpaCampos;
begin
  E_Placa.Clear;
  E_Data.Date := Date;
  E_Marca_Modelo.Clear;
  E_Km.Clear;
end;

procedure TTasOwnFleetOs.Save;
begin
  with OnwFleetOS do
  Begin
    Registro.Estabelecimento := Gb_CodMha;
    Registro.Placa      := E_Placa.Text;
    Registro.Data       := E_Data.Date;
    Registro.KM         := E_Km.Text;
    Registro.Observacao := E_Obs.Text;
  End;
  OnwFleetOS.salva;
  CodigoRegistro := OnwFleetOS.Registro.Codigo;
end;

procedure TTasOwnFleetOs.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaOwnFleetOs';
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir    := True;
    Pf_Alterar    := True;
    Pf_Excluir    := True;
    Pf_Visualizar := True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(Lc_Menu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(Lc_Menu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(Lc_Menu,'EXCLUIR','S');
    Pf_Visualizar := Fc_HabilitaPermissao(Lc_Menu,'VISUALIZAR','S');
  end;
end;

procedure TTasOwnFleetOs.ShowData;
begin
  inherited;
  with OnwFleetOS do
  Begin
    E_placa.text  := Registro.placa;
    E_Data.Date   := Registro.Data;
    E_Marca_Modelo.Text := concat(Vehicle.Marca.Registro.Descricao,'/',Vehicle.Modelo.Registro.Descricao);
    E_Km.Text     :=  Registro.KM;
    E_obs.Text    :=  Registro.Observacao;
  End;
end;


procedure TTasOwnFleetOs.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  SearchVehicle;
end;

function TTasOwnFleetOs.ValidateCancel: Boolean;
begin
  Result := True;
end;

function TTasOwnFleetOs.ValidateChange: Boolean;
begin
  Result := True;
end;

function TTasOwnFleetOs.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TTasOwnFleetOs.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim(E_Placa.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Placa não  informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Placa.CanFocus then E_Placa.SetFocus;
    Exit;
  end;

  if Trim(E_KM.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'KM não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_KM.CanFocus then E_KM.SetFocus;
   Exit;
  end;

  if Trim(E_OBS.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Observação não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if E_OBS.CanFocus then E_OBS.SetFocus;
   Exit;
  end;

end;

end.

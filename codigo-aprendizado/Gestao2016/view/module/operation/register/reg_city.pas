unit reg_city;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, base_registry, ControllerCidade, Un_Fm_ListaEstados, base_frame_list;

type
  TRegCity = class(TBaseRegistry)
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    E_IBGE: TEdit;
    L_IBGE: TLabel;
    E_AliquotaISS: TEdit;
    L_AliquotaISS: TLabel;
    Fm_ListaEditaEstado: TFm_ListaEstados;
  protected
    procedure ClearAllFields;Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    cidade : TControllerCidade;
  end;

var
  RegCity: TRegCity;

implementation

uses     UN_MSG;

{$R *.dfm}

{ TRegCity }

procedure TRegCity.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCity.ClearAllFields;
begin
  inherited;
  Cidade.Clear;
end;

procedure TRegCity.CriarVariaveis;
begin
  inherited;
  cidade := TControllerCidade.create(self);
end;

procedure TRegCity.Delete;
begin
  cidade.delete;
  inherited;
end;

procedure TRegCity.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cidade);
end;

procedure TRegCity.IniciaVariaveis;
begin
  Fm_ListaEditaEstado.Pc_Listar;
  if Self.CodigoRegistro > 0 then
  Begin
    cidade.Registro.Codigo := Self.CodigoRegistro;
    cidade.getbyId;
  End;
  inherited;
end;

procedure TRegCity.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCity.Save;
begin
  with cidade do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Estado := Fm_ListaEditaEstado.Dblcb_Lista.Text;
    Registro.IBGE := StrToIntDef(E_IBGE.Text, 0);
    Registro.AliqISS := StrToFloatDef(E_AliquotaISS.Text, 0);
    salva;
  End;
  CodigoRegistro := cidade.Registro.Codigo;
  inherited;
end;

procedure TRegCity.ShowData;
begin
  with cidade do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    Fm_ListaEditaEstado.Dblcb_Lista.KeyValue := Fm_ListaEditaEstado.findBySigla(Registro.Estado);
    E_IBGE.Text := Registro.IBGE.ToString;
    E_AliquotaISS.Text := FloatToStrF(Registro.AliqISS, ffFixed, 10, 2);
  End;
  inherited;
end;

procedure TRegCity.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegCity.ValidateDelete: boolean;
begin
  Result := True;
  if ( not TMsgSetes.Excluir ) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegCity.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    MensagemValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Fm_ListaEditaEstado.Dblcb_Lista.Text = EmptyStr then
  begin
    MensagemValidaPreenchimentoCampo('Estado');
    Result := False;
    Fm_ListaEditaEstado.Dblcb_Lista.SetFocus;
    Exit;
  end;

  if (Trim(E_IBGE.Text) = EmptyStr) then
  begin
    MensagemValidaPreenchimentoCampo(L_IBGE.Caption);
    Result := False;
    E_IBGE.SetFocus;
    Exit;
  end;
end;

end.

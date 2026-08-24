unit reg_subgroup_menu;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, System.StrUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, reg_subgroup, ControllerSubGrupos;

type
  TRegSubgroupMenu = class(TRegSubgroup)
    L_Abas: TLabel;
    E_Abas: TEdit;
    Dblcb_Impressora: TDBLookupComboBox;
    Label3: TLabel;
    Sb_Impressora: TSpeedButton;
    procedure Sb_ImpressoraClick(Sender: TObject);
  private

  protected
    procedure ClearAllFields; Override;
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
    subGrupos : TControllerSubGrupos;
    CodigoGrupo : Integer;
  end;

var
  RegSubgroupMenu: TRegSubgroupMenu;

implementation

uses     UN_MSG, env, sea_printers, Un_DM;

{$R *.dfm}

procedure TRegSubgroupMenu.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSubgroupMenu.ClearAllFields;
begin
  inherited;
  subgrupos.Clear;
end;

procedure TRegSubgroupMenu.CriarVariaveis;
begin
  inherited;
  subGrupos := TControllerSubGrupos.create(self);
  DM.Qr_Impressora.Active := True;
end;

procedure TRegSubgroupMenu.Delete;
begin
  subGrupos.delete;
  inherited;
end;

procedure TRegSubgroupMenu.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(subGrupos);
end;

procedure TRegSubgroupMenu.IniciaVariaveis;
begin

  if Self.CodigoRegistro > 0 then
  Begin
    subGrupos.Registro.Codigo := Self.CodigoRegistro;
    subGrupos.getbyId;
  End;
  inherited;
end;

procedure TRegSubgroupMenu.Insert;
begin
  inherited;
  ChBx_Ativo.Checked := true;
  E_Descricao.SetFocus;
end;

procedure TRegSubgroupMenu.Save;
begin
  with subGrupos do
  Begin
    Registro.Grupo := CodigoGrupo;
    Registro.Descricao := E_Descricao.Text;
    Registro.Abas := E_Abas.Text;
    Registro.Impressora := Dblcb_Impressora.KeyValue;
    Registro.Ativos := IfThen(ChBx_Ativo.Checked, SIGLA_S, SIGLA_N);

    salva;
  End;
  CodigoRegistro := subGrupos.Registro.Codigo;
end;

procedure TRegSubgroupMenu.Sb_ImpressoraClick(Sender: TObject);
Var
  Lc_Form : TSeaPrinters;
begin
  Lc_Form := TSeaPrinters.Create(self);
  try
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Dblcb_Impressora.SetFocus;
  end;

end;

procedure TRegSubgroupMenu.ShowData;
var Lc_Aux: string;
begin
  with subGrupos do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Abas.Text  := Registro.Abas;
    Dblcb_Impressora.KeyValue := Registro.Impressora;

    if Registro.Ativos = SIGLA_S then
      ChBx_Ativo.Checked := True
    else
      ChBx_Ativo.Checked := False;
  End;
  inherited;
end;

procedure TRegSubgroupMenu.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegSubgroupMenu.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegSubgroupMenu.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(E_Abas.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Abas.Caption);
    Result := False;
    E_Abas.SetFocus;
    Exit;
  end;
end;

end.

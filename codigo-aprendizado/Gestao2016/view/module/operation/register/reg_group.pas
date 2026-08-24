unit reg_group;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, System.StrUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, base_registry, ControllerGrupos, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TRegGroup = class(TBaseRegistry)
    pnlGrid: TPanel;
    Sb_SubGrupos: TSpeedButton;
    DBGrid1: TDBGrid;
    cds_subgrupo: TClientDataSet;
    cds_subgrupocodigo: TIntegerField;
    cds_subgrupodescricao: TStringField;
    cds_subgrupodescricao_subgrupo: TStringField;
    ds_subgrupo: TDataSource;
    ChBx_Ativo: TCheckBox;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    cds_subgrupoAtivo: TStringField;
    procedure Sb_SubGruposClick(Sender: TObject);
  private
  protected
    FCodigoGrupo: Integer;
    procedure MontarGrid(pCodigo: integer);
    procedure setFCodigoGrupo(const Value: Integer);
    procedure setPerfil;Override;
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
    procedure EditionControl;Override;
  public
    grupos : TControllerGrupos;
    property CodigoGrupo : Integer read FCodigoGrupo write setFCodigoGrupo;
  end;

var
  RegGroup: TRegGroup;

implementation

uses     UN_MSG, reg_subgroup, env;

{$R *.dfm}

procedure TRegGroup.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegGroup.ClearAllFields;
begin
  inherited;
  grupos.clear;
end;

procedure TRegGroup.CriarVariaveis;
begin
  inherited;
  grupos := TControllerGrupos.create(self);
end;

procedure TRegGroup.Delete;
begin
  grupos.delete;
  inherited;
end;

procedure TRegGroup.EditionControl;
begin
  inherited;
  Sb_SubGrupos.Enabled := (EditionState = 'B') and (grupos.Registro.Codigo > 0);
end;

procedure TRegGroup.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(grupos);
end;

procedure TRegGroup.IniciaVariaveis;
begin
  MontarGrid(Self.CodigoRegistro);
  if Self.CodigoRegistro > 0 then
  Begin
    grupos.Registro.Codigo := Self.CodigoRegistro;
    grupos.getbyId;
  End;
  inherited;
end;

procedure TRegGroup.Insert;
begin
  inherited;
  if cds_subgrupo.Active then cds_subgrupo.EmptyDataSet;
  grupos.clear;
  E_Descricao.SetFocus;
end;

procedure TRegGroup.Save;
begin
  with grupos do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Ativo := IfThen(ChBx_Ativo.Checked, SIGLA_S, SIGLA_N);
    salva;
  End;
  CodigoRegistro := grupos.Registro.Codigo;
  inherited;
end;

procedure TRegGroup.Sb_SubGruposClick(Sender: TObject);
var
  Lc_form : TRegSubgroup;
begin
  Lc_form := TRegSubgroup.Create(self);
  Try
    Lc_form.CodigoGrupo     := Grupos.Registro.Codigo;
    Lc_form.CodigoRegistro  := cds_subgrupocodigo.AsInteger;
    Lc_form.ShowModal;
  Finally
    MontarGrid(self.CodigoRegistro);
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegGroup.setFCodigoGrupo(const Value: Integer);
begin
  FCodigoGrupo := Value;
end;

procedure TRegGroup.setPerfil;
begin
   pfMenu := 'Grupos e SubGrupos';
  inherited;
end;

procedure TRegGroup.ShowData;
begin
  with grupos do
  Begin
    E_Descricao.Text  := Registro.Descricao;
    if Registro.Ativo = SIGLA_S then
      ChBx_Ativo.Checked := True
    else
      ChBx_Ativo.Checked := False;
  End;
  inherited;
end;

procedure TRegGroup.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegGroup.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegGroup.ValidateSave: boolean;
Var
  Lc_Cd_Grupo : Integer;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  //Verifica se um grupo com a mesma descrição existe
  Lc_Cd_Grupo := grupos.Fc_GrupoExiste(grupos.Registro.Codigo, E_Descricao.Text,false);

  if (Lc_Cd_Grupo > 0) then
  Begin
    if (MensagemPadrao('Mensagem de Confirmção',
                       'J� existe um grupo com esta descrição.' + EOLN + EOLN +
                       'Deseja visualizar este registro ?',
                       ['Sim', 'N�o'], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
    Begin
      grupos.Registro.Codigo := Lc_Cd_Grupo;
      grupos.getbyId;
      ShowData;
      Result:=false;
      exit;
    end
    else
    Begin
      MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Altere a descrição para continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result:=false;
      exit;
    end;
  end;
end;


procedure TRegGroup.MontarGrid(pCodigo: integer);
var
  i : Integer;
begin
  if pCodigo > 0 then
  begin
    with Grupos do
    begin
      SubGrupo.Clear;

      SubGrupo.Parametros.FieldName.Grupo := pCodigo;

      SubGrupo.Search;

      if not cds_subgrupo.Active then
        cds_subgrupo.CreateDataSet;

      cds_subgrupo.EmptyDataSet;

      cds_subgrupo.DisableControls;

      for i := 0 to Pred(SubGrupo.Lista.Count) do
        cds_subgrupo.AppendRecord([SubGrupo.Lista[i].Codigo, SubGrupo.Lista[i].Grupo, SubGrupo.Lista[i].Descricao,SubGrupo.Lista[i].Ativos]);

      cds_subgrupo.EnableControls;
    end;
  end;
end;

end.

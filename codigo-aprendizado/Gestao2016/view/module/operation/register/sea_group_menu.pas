unit sea_group_menu;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerGrupos, base_search, Datasnap.Provider;

type
  TSeaGroupMenu = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_grupo: TLabel;
    Lb_subgrupo: TLabel;
    E_BuscaGrupo: TEdit;
    E_BuscaSubGrupo: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    cds_searchdescricao_subgrupo: TStringField;
    ChBx_GrupoVazio: TCheckBox;
    ChBx_GrupoInativo: TCheckBox;
    cds_searchcodigo_subgrupo: TIntegerField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    grupos : TControllerGrupos;
  end;

var
  SeaGroupMenu: TSeaGroupMenu;

implementation

uses     reg_group_menu, env;

{$R *.dfm}

procedure TSeaGroupMenu.CriarVariaveis;
begin
  inherited;
  grupos := TControllerGrupos.create(self);
end;

procedure TSeaGroupMenu.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(grupos);
end;

procedure TSeaGroupMenu.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaGroupMenu.openRegister(pCodigo: Integer);
var
  Lc_form : TRegGroupMenu;
begin
  Lc_form := TRegGroupMenu.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaGroupMenu.Search;
var
  i: Integer;
begin
  grupos.Clear;

  grupos.Parametros.FieldName.Descricao := E_BuscaGrupo.Text;
  grupos.Parametros.FieldName.DescricaoSubGrupo := E_BuscaSubGrupo.Text;
  grupos.Parametros.Vazio := ChBx_GrupoVazio.Checked;
  grupos.Parametros.isRestaurant := True;
  if ChBx_GrupoInativo.Checked then
    grupos.Parametros.FieldName.Ativo := SIGLA_N
  else
    grupos.Parametros.FieldName.Ativo := SIGLA_S;
  grupos.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(grupos.Lista.Count) do
    cds_search.AppendRecord([
                      grupos.Lista[i].Codigo,
                      grupos.Lista[i].Descricao,
                      grupos.Lista[i].DescricaoSubGrupo,
                      grupos.Lista[i].CodigoSubGrupo]);

  cds_search.EnableControls;


end;

procedure TSeaGroupMenu.SetRegister;
begin
  openRegister(0);
end;

end.

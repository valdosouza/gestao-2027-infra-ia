unit sea_group;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerGrupos, base_search, Datasnap.Provider;

type
  TSeaGroup = class(TBaseSearch)
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    cds_searchdescricao_subgrupo: TStringField;
    GroupBox2: TGroupBox;
    Lb_grupo: TLabel;
    Lb_subgrupo: TLabel;
    E_BuscaGrupo: TEdit;
    E_BuscaSubGrupo: TEdit;
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
  SeaGroup: TSeaGroup;

implementation

uses     reg_group, env;

{$R *.dfm}

procedure TSeaGroup.CriarVariaveis;
begin
  inherited;
  grupos := TControllerGrupos.create(self);
end;

procedure TSeaGroup.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(grupos);
end;

procedure TSeaGroup.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaGroup.openRegister(pCodigo: Integer);
var
  Lc_form : TRegGroup;
begin
  Lc_form := TRegGroup.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaGroup.Search;
var
  i: Integer;
begin
  grupos.Clear;

  grupos.Parametros.FieldName.Descricao := E_BuscaGrupo.Text;
  grupos.Parametros.FieldName.DescricaoSubGrupo := E_BuscaSubGrupo.Text;
  grupos.Parametros.isRestaurant := False;
  grupos.Parametros.Vazio := ChBx_GrupoVazio.Checked;
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
                        grupos.Lista[i].CodigoSubGrupo ]);

  cds_search.EnableControls;


end;

procedure TSeaGroup.SetRegister;
begin
  openRegister(0);
end;

end.

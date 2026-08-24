unit sea_assistance;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerAssistencia, Un_Fm_ListaSituacao, Vcl.ComCtrls;

type
  TSeaAssistance = class(TBaseSearch)
    GroupBox3: TGroupBox;
    Label11: TLabel;
    ChBx_Busca_Nome: TCheckBox;
    E_Cliente: TMaskEdit;
    ChBx_Busca_Fantasia: TCheckBox;
    E_Numero: TMaskEdit;
    Fm_ListaSituacao: TFm_ListaSituacao;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    cds_searchASS_CODIGO: TIntegerField;
    cds_searchASS_NUMERO: TIntegerField;
    cds_searchEMP_FANTASIA: TStringField;
    cds_searchEMP_NOME: TStringField;
    cds_searchSIT_DESCRICAO: TStringField;
    Configurao1: TMenuItem;
    procedure Configurao1Click(Sender: TObject);
  private
  protected
    procedure setPerfil;Override;
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    Assistencia : TControllerAssistencia;
  end;

var
  SeaAssistance: TSeaAssistance;

implementation

{$R *.dfm}

uses     reg_assistance, cfg_assistance;

{ TSeaAssistance }

procedure TSeaAssistance.Configurao1Click(Sender: TObject);
Var
  Lc_form : TCfgAssistance;
begin
  Lc_form := TCfgAssistance.create(Self);
  Try
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaAssistance.CriarVariaveis;
begin
  inherited;
  Assistencia := TControllerAssistencia.create(self);
  E_Data_Ini.Date := Date-30;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked := (ExecConfig('L','GRL_G_DT_PESQUISA','S') = 'S');
end;

procedure TSeaAssistance.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Assistencia);
end;

procedure TSeaAssistance.GetView;
begin
  openRegister(cds_searchASS_CODIGO.AsInteger);
end;

procedure TSeaAssistance.IniciaVariaveis;
begin
  inherited;
  Fm_ListaSituacao.Listar;
end;

procedure TSeaAssistance.openRegister(pCodigo: Integer);
var
  Lc_form : TRegAssistance;
begin
  Lc_form := TRegAssistance.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaAssistance.Search;
var
  i: Integer;
begin
  Assistencia.Clear;
  Assistencia.Parametros.Periodo := ChBx_Periodo.Checked;
  Assistencia.Parametros.DataInicial := E_Data_Ini.Date;
  Assistencia.Parametros.DataFinal := E_Data_Fim.Date;
  Assistencia.Parametros.FieldName.Numero := StrToIntDef(E_Numero.Text,0);
  Assistencia.Parametros.FieldName.NomeRazao := E_Cliente.Text;
  if ( Fm_ListaSituacao.DBLCB_Situacao.Text <> '') then
    Assistencia.Parametros.FieldName.SituacaoId := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;

  Assistencia.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(Assistencia.Lista.Count) do
  Begin
    cds_search.Append;
    cds_searchASS_CODIGO.AsInteger := Assistencia.Lista[I].Codigo;
    cds_searchASS_NUMERO.AsInteger := Assistencia.Lista[I].Numero;
    cds_searchEMP_FANTASIA.AsString := Assistencia.Lista[I].ApelidoFantasia;
    cds_searchEMP_NOME.AsString := Assistencia.Lista[I].NomeRazao;
    cds_searchSIT_DESCRICAO.AsString := Assistencia.Lista[I].SituacaoDesc;
    cds_search.post;
  End;

end;

procedure TSeaAssistance.setPerfil;
begin
  pfMenu := 'Assistência Técnica';
  inherited;

end;

procedure TSeaAssistance.SetRegister;
begin
  openRegister(0);
end;

end.

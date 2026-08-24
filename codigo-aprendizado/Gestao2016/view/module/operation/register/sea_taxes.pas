unit sea_taxes;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerTaxes, Vcl.Mask;

type

  TSeaTaxes = class(TBaseSearch)
    cds_searchID: TIntegerField;
    cds_searchDESCRIPTION: TStringField;
    L_BuscaDescricao: TLabel;
    E_Descricao: TMaskEdit;
    Lb_CST: TLabel;
    E_CST: TMaskEdit;
    Lb_Classe: TLabel;
    E_Classe: TMaskEdit;
    cds_searchCST: TStringField;
    cds_searchCLASSTRIB: TStringField;
  private
    { Private declarations }
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    Taxes : TControllerTaxes;
  end;

var
  SeaTaxes: TSeaTaxes;

implementation

{$R *.dfm}

uses     reg_taxes, env;

{ TBaseSearch1 }

procedure TSeaTaxes.CriarVariaveis;
begin
  inherited;
  Taxes := TControllerTaxes.Create(self);

end;

procedure TSeaTaxes.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Taxes);
end;

procedure TSeaTaxes.GetView;
begin
  openRegister(cds_searchID.AsInteger);
end;

procedure TSeaTaxes.IniciaVariaveis;
begin
  inherited;

end;

procedure TSeaTaxes.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxes;
begin
  Lc_form := TRegTaxes.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxes.Search;
var
  i: Integer;
begin
  Taxes.Clear;

  Taxes.Parametros.FieldName.Institution := Gb_CodMha;
  Taxes.Parametros.FieldName.Description := E_Descricao.Text;
  Taxes.Parametros.FieldName.CST        := E_CST.Text;
  Taxes.Parametros.FieldName.classtrib  := E_Classe.Text;

  Taxes.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(Taxes.Lista.Count) do
  Begin
    cds_search.Append;
    cds_searchID.AsInteger          :=  Taxes.Lista[I].ID;
    cds_searchDESCRIPTION.AsString  :=  Taxes.Lista[I].Description;
    cds_searchCST.AsString          :=  Taxes.Lista[I].cst;
    cds_searchCLASSTRIB.AsString    :=  Taxes.Lista[I].classtrib;
    cds_search.Post;

  End;

end;

procedure TSeaTaxes.SetRegister;
begin
  openRegister(0);
end;

end.

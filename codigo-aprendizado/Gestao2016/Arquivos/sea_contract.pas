unit sea_contract;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, STQuery, ControllerContract;

type
  TSeaContract = class(TBaseSearch)
    Label1: TLabel;
    E_Tittle: TEdit;
    Label26: TLabel;
    CB_Kind: TComboBox;
  private

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;

  public
    { Public declarations }
    Contrato : TControllerContract;
  end;

var
  SeaContract: TSeaContract;

implementation

{$R *.dfm}

uses     cad_contract, UN_Principal, env;
procedure TSeaContract.CriarVariaveis;
begin
  inherited;
  Contrato := TControllerContract.Create(Self);
end;

procedure TSeaContract.GetView;
Var
  LcForm : TCadContract;
begin
  try
    LcForm := TCadContract.Create(nil);
    LcForm.CodigoRegistro := cds_search.FieldByName('ID').AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaContract.GroupBySql;
begin
  inherited;

end;

procedure TSeaContract.IniciaVariaveis;
begin
  inherited;
  Contrato.ComboKind(CB_Kind);
end;

procedure TSeaContract.InnerJoinSql;
begin
  inherited;

end;

procedure TSeaContract.OrderBySql;
begin
  inherited;

end;

procedure TSeaContract.returnRegister;
begin
  if FSelecionado then
  Begin
    contrato.Registro.Codigo := cds_search.FieldByName('ID').AsInteger;
    contrato.Registro.Estabelecimento := Gb_CodMha;
    contrato.getbyId;
  End;
end;


procedure TSeaContract.SelectSql;
begin
  inherited;
  SelectTxt := concat(
              'select co.* ',
              'from TB_CONTRACT co '
            );

end;

procedure TSeaContract.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if E_Tittle.Text <> '' then
      ParamByName('TITTLE').AsString := concat('%',E_Tittle.Text,'%');

    if Cb_Kind.Text <> '' then
      ParamByName('KIND').AsString := concat('%',CB_Kind.Text,'%');
  End;

end;

procedure TSeaContract.SetRegister;
Var
  LcForm : TCadContract;
begin
  try
    LcForm := TCadContract.Create(nil);
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaContract.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'WHERE (ID IS NOT NULL)   '
              );
    //incrementa SQL
  if E_Tittle.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (co.tittle LIKE :tittle) '
                );

  if CB_Kind.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  'and (co.KINDe  LIKE :KIND)'
                );


end;

end.

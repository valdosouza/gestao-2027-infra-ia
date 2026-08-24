unit sea_elect_equip;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Un_Fm_ListaEmpresas, QEdit_Setes, Vcl.Mask, Un_DM, STQuery;

type
  TSeaElectEquip = class(TBaseSearch)
    Label28: TLabel;
    Label29: TLabel;
    Label26: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    E_Device: TEdit;
    E_Modelo: TEdit;
    E_Marca: TEdit;
    E_Serie: TEdit;
    E_IMei: TEdit;
    Fm_ListaEmpresas: TFm_ListaEmpresas;
    cds_searchID: TIntegerField;
    cds_searchTB_CUSTOMER_ID: TIntegerField;
    cds_searchDEVICE: TWideStringField;
    cds_searchBRAND: TWideStringField;
    cds_searchMODEL: TWideStringField;
    cds_searchSERIE: TWideStringField;
    cds_searchIMEI: TWideStringField;
    cds_searchACCESSORIES: TWideStringField;
    cds_searchEMP_FANTASIA: TWideStringField;
  private
    procedure setPerfil;Override;
  protected
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure SetRegister;Override;

  public
    { Public declarations }
  end;

var
  SeaElectEquip: TSeaElectEquip;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, cad_elect_equip;
procedure TSeaElectEquip.GetView;
Var
  Form:TCadElectEquip;
begin
  Try
    Form := TCadElectEquip.create(nil);
    Form.CodigoRegistro := cds_search.FieldByName('ID').AsInteger;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TSeaElectEquip.GroupBySql;
begin
  inherited;

end;

procedure TSeaElectEquip.IniciaVariaveis;
begin
  inherited;
  Fm_ListaEmpresas.Pc_AtivaEmpresa(1);
end;

procedure TSeaElectEquip.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                  '  inner join TB_EMPRESA ep ',
                  '  on (ep.EMP_CODIGO = ee.TB_CUSTOMER_ID ) '
                );

end;

procedure TSeaElectEquip.OrderBySql;
begin
  inherited;

end;



procedure TSeaElectEquip.SelectSql;
begin
  inherited;
  SelectTxt := concat(
              'select ee.*, ep.emp_fantasia ',
              'from TB_ELECT_EQUIP ee '
            );

end;

procedure TSeaElectEquip.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if E_Device.Text <> '' then
      ParamByName('DEVICE').AsString := concat('%',E_Device.Text,'%');

    if E_Marca.Text <> '' then
      ParamByName('BRAND').AsString := concat('%',E_Marca.Text,'%');

    if E_Modelo.Text <> '' then
      ParamByName('MODEL').AsString := concat('%',E_Modelo.Text,'%');

    if E_Serie.Text <> '' then
      ParamByName('SERIE').AsString := concat('%',E_Serie.Text,'%');

    if E_IMei.Text <> '' then
      ParamByName('IMEI').AsString := concat('%',E_IMei.Text,'%');

    if Fm_ListaEmpresas.DBLCB_Empresa.Text <> '' then
      ParamByName('TB_CUSTOMER_ID').Value := Fm_ListaEmpresas.DBLCB_Empresa.KeyValue;

  End;
end;

procedure TSeaElectEquip.setPerfil;
Var
  Lc_Menu : String;
begin
  Lc_Menu := 'SeaElectEquip';
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
  SB_Cadastrar.Enabled   :=  Pf_Inserir;

end;

procedure TSeaElectEquip.SetRegister;
Var
  Form:TCadElectEquip;
begin
  Try
    Form := TCadElectEquip.create(nil);
    Form.CodigoRegistro := 0;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TSeaElectEquip.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'where ee.id is not null '
              );
    //incrementa SQL
  if E_Device.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (DEVICE LIKE :DEVICE) '
                );
  if E_Marca.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  'and (BRAND  LIKE :BRAND)'
                );


  if E_Modelo.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (MODEL LIKE :MODEL)'
                );

  if E_Serie.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (SERIE like :SERIE) '
                );

  if E_IMei.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (IMEI like :IMEI) '
                );
  if Fm_ListaEmpresas.DBLCB_Empresa.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (TB_CUSTOMER_ID =:TB_CUSTOMER_ID) '
                );

end;

end.

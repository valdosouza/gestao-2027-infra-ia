unit sea_order_pet_shop;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, Un_Fm_ListaSituacao, QEdit_Setes, Vcl.Mask, Un_Fm_ListaEmpresas, Vcl.ComCtrls, ControllerPetOrder, Un_Fm_ListaClientes, STQuery;

type
  TSeaOrderPetShop = class(TBaseSearch)
    Label28: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_pet_name: TMaskEdit;
    E_Age: TMaskEdit;
    Fm_ListaVendedores: TFm_ListaColaboradores;
    cds_searchPED_CODIGO: TIntegerField;
    cds_searchPED_NUMERO: TIntegerField;
    cds_searchPED_DATA: TDateField;
    cds_searchEMP_FANTASIA: TWideStringField;
    cds_searchNAME: TWideStringField;
    cds_searchRACE: TWideStringField;
    cds_searchHAIR: TWideStringField;
    cds_searchCOLOR: TWideStringField;
    cds_searchAGE: TIntegerField;
    Sb_PEdido: TSpeedButton;
    cds_searchPED_FATURADO: TWideStringField;
    Label26: TLabel;
    CB_Race: TComboBox;
    Label29: TLabel;
    CB_Hair: TComboBox;
    Cb_Color: TComboBox;
    Fm_ListaClientes: TFm_ListaClientes;
    cds_searchPED_CODEMP: TIntegerField;
    procedure Sb_PEdidoClick(Sender: TObject);
  private

    procedure OpenOrder;
    Procedure OpenInvoice;

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
    procedure ImagemBotao;Override;
    procedure execShorCutKeyF9;Override;
  public
    { Public declarations }
    Atendimento : TControllerPetOrder;

  end;

var
  SeaOrderPetShop: TSeaOrderPetShop;

implementation

{$R *.dfm}

uses     Un_DM, RN_Permissao, UN_Principal, env, RN_NotaFiscal, UN_Pedido_Vda, tas_order_pet_shop;
procedure TSeaOrderPetShop.CriarVariaveis;
begin
  inherited;
  Atendimento := TControllerPetOrder.create(self);
end;

procedure TSeaOrderPetShop.execShorCutKeyF9;
begin
  if cds_searchPED_FATURADO.AsString = 'N' then
    OpenOrder
  else
    OpenInvoice;

end;

procedure TSeaOrderPetShop.GetView;
Var
  LcForm : TTasOrderPetShop;
begin
  try
    LcForm := TTasOrderPetShop.Create(nil);
    LcForm.CodigoRegistro := cds_searchPED_CODIGO.AsInteger;
    LcForm.Cliente        := cds_searchPED_CODEMP.AsInteger;
    LcForm.Atendimento.Registro.Pedido := cds_searchPED_CODIGO.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;

end;

procedure TSeaOrderPetShop.GroupBySql;
begin
  inherited;

end;

procedure TSeaOrderPetShop.ImagemBotao;
begin
  CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  //SB_Visualizar.Glyph.Assign(Fc_CarregaImagemBotao('VISUALIZAR'));Fixo
  SB_Visualizar.Caption:= 'Visualizar - F8';
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
  CarregaImagemBotao(Sb_PEdido,'PEDIDO');

end;

procedure TSeaOrderPetShop.IniciaVariaveis;
begin
  inherited;
  Fm_ListaClientes.Pc_AtivaEmpresa(1);
  Fm_ListaVendedores.ListaVendedor;
end;

procedure TSeaOrderPetShop.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                   'inner join tb_pet pe ',
                   'on (pe.id = po.tb_pet_id) ',
                   'inner join tb_pedido pd ',
                   'on (pd.ped_codigo = po.tb_pedido_id) ',
                   'inner join tb_empresa em ',
                   'on (em.emp_codigo = pd.ped_codemp) '
  );
end;

procedure TSeaOrderPetShop.OpenInvoice;
Begin
  if Fc_VerificaPermissao('Fr_Nota_Fiscal','Opera��es NFe','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Atendimento.NotaFiscal.Registro.CodigoPedido := cds_searchPED_CODIGO.AsInteger;

    Pc_AbreTelaNotaFiscal(Atendimento.NotaFiscal.getCodigoNotaByPedido,Self);
  End;


end;

procedure TSeaOrderPetShop.OpenOrder;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.Create(nil);
    LcForm.Pedido.Registro.Codigo := cds_searchPED_CODIGO.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;


end;

procedure TSeaOrderPetShop.OrderBySql;
begin
  inherited;

end;


procedure TSeaOrderPetShop.Sb_PEdidoClick(Sender: TObject);
begin
  if validateGetView then
  Begin
    if cds_searchPED_FATURADO.AsString = 'N' then
      OpenOrder
    else
      OpenInvoice;
  End;
end;


procedure TSeaOrderPetShop.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                  'Select pd.ped_codigo, pd.ped_numero, pd.ped_data, ',
                  'em.emp_fantasia, pe.name, pe.race, pe.hair, pe.color,pe.age, ',
                  'PED_FATURADO, PED_CODEMP ',
                  'from tb_pet_order po '
  );

end;


procedure TSeaOrderPetShop.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if E_pet_name.Text <> '' then
      ParamByName('PET_NANME').AsString := concat('%',E_pet_name.Text,'%');

    if Cb_race.Text <> '' then
      ParamByName('PET_RACE').AsString := concat('%',Cb_race.Text,'%');

    if Cb_Hair.Text <> '' then
      ParamByName('PET_HAIR').AsString := concat('%',Cb_Hair.Text,'%');

    if E_Age.Text <> '' then
      ParamByName('PET_AGE').AsString := E_Age.Text;

    if Cb_color.Text <> '' then
      ParamByName('PET_COLOR').AsString := concat('%',Cb_color.Text,'%');

    if Fm_ListaClientes.DBLCB_Empresa.Text <> '' then
      ParamByName('PED_CODEMP').Value := Fm_ListaClientes.DBLCB_Empresa.KeyValue;

    if Fm_ListaVendedores.Dblcb_Vendedor.Text <> '' then
      ParamByName('PED_CODVDO').Value := Fm_ListaVendedores.Dblcb_Vendedor.KeyValue;
  End;

end;

procedure TSeaOrderPetShop.SetRegister;
Var
  LcForm : TFr_Pedido_Vda;
begin
  try
    LcForm := TFr_Pedido_Vda.Create(nil);
    LcForm.AbrirNovo := True;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaOrderPetShop.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'WHERE (PED_CODIGO IS NOT NULL)   '
              );
    //incrementa SQL
  if E_pet_name.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.name LIKE :pet_name) '
                );
  if Cb_race.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  'and (pe.race  LIKE :pet_race)'
                );


  if Cb_Hair.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.hair LIKE :pet_hair)'
                );

  if E_Age.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.age =:pet_age) '
                );

  if Cb_color.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.color =:pet_color) '
                );
  if Fm_ListaClientes.DBLCB_Empresa.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (PED_CODEMP =:PED_CODEMP) '
                );

  if Fm_ListaVendedores.Dblcb_Vendedor.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (PED_CODVDO =:PED_CODVDO) '
                );


end;

end.

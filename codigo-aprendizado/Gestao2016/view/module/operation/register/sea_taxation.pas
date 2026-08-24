unit sea_taxation;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerTributacao, System.StrUtils, Datasnap.Provider, Un_Fm_ListaEstados, base_frame_list, Un_Fm_ListaCFOP_UF;

type
  TSeaTaxation = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Busca_NCM: TLabel;
    chbx_consumidor: TCheckBox;
    E_NCM: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchNAT_CFOP: TStringField;
    cds_searchUFE_SIGLA: TStringField;
    cds_searchTRB_CONSUMIDOR: TStringField;
    cds_searchTRB_MICRO: TStringField;
    cds_searchTRB_CST: TStringField;
    cds_searchTRB_ST_CIMS: TStringField;
    cds_searchOBS_DESCRICAO: TStringField;
    cds_searchTRB_CODIGONCM: TStringField;
    cds_searchTRB_RD_AQ_ICMS: TFloatField;
    cds_searchTRB_RD_BS_ICMS: TFloatField;
    cds_searchTRB_AQ_ICMS: TFloatField;
    Fm_ListaCFOP_UF: TFm_ListaCFOP_UF;
    cds_searchReforma: TStringField;
  protected
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure IniciaVariaveis;override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    taxation : TControllerTributacao;
    FProduto: Integer;
    FEmpresa: Integer;
    procedure setFEmpresa(const Value: Integer);
    procedure setFProduto(const Value: Integer);
  public
    property Produto : Integer read FProduto write setFProduto;
    property Empresa :Integer read FEmpresa write setFEmpresa;
  end;

var
  SeaTaxation: TSeaTaxation;

implementation

uses     reg_taxation, env, un_dm, un_regra_negocio;

{$R *.dfm}

procedure TSeaTaxation.CriarVariaveis;
begin
  inherited;
  taxation := TControllerTributacao.create(self);
  FEmpresa := 0;
  FProduto := 0;
end;

procedure TSeaTaxation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxation);
end;

procedure TSeaTaxation.FormataTela;
Var
 It_Cd_CRT : Integer;
begin
  Pc_AtivaEstabelecimento;
  It_Cd_CRT := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);

  if (It_Cd_CRT = 3) or (It_Cd_CRT = 2) then
  Begin
    DBG_Pesquisa.Columns[4].Title.Caption := 'C.S.T.';
    DBG_Pesquisa.Columns[4].FieldName := 'TRB_CST';
  end
  else
  Begin
    DBG_Pesquisa.Columns[4].Title.Caption := 'C.S.O.S.N.';
    DBG_Pesquisa.Columns[4].FieldName := 'TRB_CSOSN';
  end;
end;

procedure TSeaTaxation.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxation.IniciaVariaveis;
begin
  inherited;
  Fm_ListaCFOP_UF.Estabelecimento := Gb_CodMha;
  Fm_ListaCFOP_UF.Listar;
end;

procedure TSeaTaxation.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxation;
begin
  Lc_form := TRegTaxation.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.Produto := FProduto;
    Lc_form.Empresa := FEmpresa;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;


procedure TSeaTaxation.Search;
var
  i: Integer;
begin
  taxation.Clear;

  taxation.Parametros.FieldName.Estabelecimento := Gb_CodMha;

  if (Fm_ListaCFOP_UF.RG_Tipo_S_E.ItemIndex = 0) then
    taxation.Parametros.FieldName.SentidoCFOP := 'S'
  else
    taxation.Parametros.FieldName.SentidoCFOP := 'E';

  if (FProduto > 0) then
    taxation.Parametros.FieldName.Produto := FProduto
  ELSE
    taxation.Parametros.FieldName.Produto := 0;

  if (FEmpresa > 0) then
    taxation.Parametros.FieldName.Empresa := FEmpresa
  ELSE
    taxation.Parametros.FieldName.Empresa := 0;

  IF Fm_ListaCFOP_UF.Fm_ListaBuscaEstado.Dblcb_Lista.Text <> EmptyStr THEN
    taxation.Parametros.FieldName.Estado := Fm_ListaCFOP_UF.Fm_ListaBuscaEstado.Dblcb_Lista.KeyValue
  else
    taxation.Parametros.FieldName.Estado := 0;

  IF Fm_ListaCFOP_UF.Dblcb_Lista.Text <> EmptyStr THEN
    taxation.Parametros.FieldName.CFOP := Fm_ListaCFOP_UF.Dblcb_Lista.KeyValue
  else
    taxation.Parametros.FieldName.CFOP := 0;


  if chbx_consumidor.checked then
    taxation.Parametros.FieldName.Consumidor := 'S'
  else
    taxation.Parametros.FieldName.Consumidor := '';

  if E_NCM.text <> EmptyStr then
    taxation.Parametros.FieldName.NCM := E_NCM.text
  else
    taxation.Parametros.FieldName.NCM := '';

  taxation.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(taxation.Lista.Count) do
  Begin
    cds_search.Append;

    cds_searchcodigo.AsInteger        := taxation.Lista[i].Codigo;
    cds_searchNAT_CFOP.AsString       := taxation.Lista[i].NAT_CFOP;
    cds_searchUFE_SIGLA.AsString      := taxation.Lista[i].UFE_SIGLA;
    cds_searchTRB_CONSUMIDOR.AsString := taxation.Lista[i].Consumidor;
    cds_searchTRB_MICRO.AsString      := taxation.Lista[i].MicroEmpresa;
    cds_searchTRB_CST.AsString        := taxation.Lista[i].TRB_CST;
    cds_searchTRB_ST_CIMS.AsString    := taxation.Lista[i].TemST;
    cds_searchOBS_DESCRICAO.AsString  := taxation.Lista[i].OBS_DESCRICAO;
    cds_searchTRB_CODIGONCM.AsString  := taxation.Lista[i].NCM;
    cds_searchTRB_RD_AQ_ICMS.AsCurrency  := taxation.Lista[i].RedAliqICMS;
    cds_searchTRB_RD_BS_ICMS.AsCurrency  := taxation.Lista[i].RedBCICMS;
    cds_searchTRB_AQ_ICMS.AsCurrency     := taxation.Lista[i].AliqICMS;
    if taxation.Lista[i].CodigoTaxas > 0 then
      cds_searchReforma.AsString  := 'Sim'
    else
      cds_searchReforma.AsString  := 'Não';

    cds_search.Post;
  End;
  cds_search.EnableControls;
end;

procedure TSeaTaxation.setFEmpresa(const Value: Integer);
begin
  FEmpresa := Value;
end;

procedure TSeaTaxation.setFProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TSeaTaxation.setPerfil;
begin
  pfMenu := 'Tributação';
  inherited;
end;

procedure TSeaTaxation.SetRegister;
begin
  openRegister(0);
end;

end.


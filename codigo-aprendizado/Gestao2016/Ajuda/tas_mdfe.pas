unit tas_mdfe;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Mask, Un_Fm_ListaEstados, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, ControllerMdfe, Actions, Vcl.ActnList, STQuery, Un_fm_listaCidade, Un_Msg, Datasnap.DBClient, Datasnap.Provider, tblMdfeLoadLocal, tblMdfeStateRoute, TblMdfeUnloadLocal, TblMdfeRoad, tblMdfeConductor, ControllerMdfeConductor, tblMdfe, tblMdfeNfe, ControllerRetornoNFe, ControllerMdfeConfig, tblMdfeConfig, QEdit_Setes, base_frame_list;

type
  TTasMdfe = class(TBaseRegistry)
    pg_geral: TPageControl;
    tbs_mdfe: TTabSheet;
    pnl_mdfe: TPanel;
    modelo: TLabel;
    serie: TLabel;
    numero: TLabel;
    dt_emissao: TLabel;
    dt_viagem: TLabel;
    modalidade: TLabel;
    tipo_transp: TLabel;
    tipo_EMIT: TLabel;
    E_modelo: TEdit;
    E_serie: TEdit;
    E_numero: TEdit;
    Cb_modalidade: TComboBox;
    Cb_tipo_de_transportador: TComboBox;
    Cb_tipo_de_Emitente: TComboBox;
    tbs_mdfe_road: TTabSheet;
    pnl_mdfe_road: TPanel;
    RNTRC: TLabel;
    CodigoPorto: TLabel;
    PlacaVeiculo: TLabel;
    Sb_Placa: TSpeedButton;
    E_codigo_agendamento_porto: TEdit;
    E_rntrc: TEdit;
    E_Placa: TMaskEdit;
    tbs_mdfe_cte_nfe: TTabSheet;
    STQuery1: TSTQuery;
    Fm_Listauf_mdfe: TFm_ListaEstados;
    cds_load_local: TClientDataSet;
    ds_load_local: TDataSource;
    DataSetProvider1: TDataSetProvider;
    cds_load_localUFE_CODIGO: TIntegerField;
    cds_load_localUFE_SIGLA: TWideStringField;
    cds_load_localCDD_CODIGO: TIntegerField;
    cds_load_localCDD_DESCRICAO: TWideStringField;
    Dtp_Emissao: TDateTimePicker;
    Dtp_Viagem: TDateTimePicker;
    cds_state_route: TClientDataSet;
    ds_state_route: TDataSource;
    cds_state_routeTB_STATE_ID: TIntegerField;
    cds_state_routeUFE_SIGLA: TWideStringField;
    ds_unload_local: TDataSource;
    cds_unload_local: TClientDataSet;
    cds_unload_localUFE_CODIGO: TIntegerField;
    cds_unload_localUFE_SIGLA: TWideStringField;
    cds_unload_localCDD_CODIGO: TIntegerField;
    cds_unload_localCDD_DESCRICAO: TWideStringField;
    DescricaoVeiculo: TLabel;
    E_MarcaModelo: TEdit;
    Bt_inc_Condutor: TButton;
    Bt_exc_Condutor: TButton;
    Grp_Conductor: TGroupBox;
    cds_conductor: TClientDataSet;
    ds_Conductor: TDataSource;
    pnl_mdfe_nfe: TPanel;
    Grp_Nfe: TGroupBox;
    GroupBox6: TGroupBox;
    Dbg_nfe: TDBGrid;
    Bt_inc_Nfe: TButton;
    Bt_exc_Nfe: TButton;
    cds_nfe: TClientDataSet;
    ds_nfe: TDataSource;
    cds_conductorCLB_CODIGO: TIntegerField;
    cds_conductorCLB_NOME: TWideStringField;
    cds_conductorCLB_CPF: TWideStringField;
    Dbg_conductor: TDBGrid;
    cds_nfeNFE_CODNFL: TIntegerField;
    cds_nfeNFE_NOTA_INI: TWideStringField;
    cds_nfeNFE_ARQUIVO: TWideStringField;
    Grp_local_load: TGroupBox;
    Grp_city_load: TGroupBox;
    Dbg_city_load: TDBGrid;
    Bt_ins_loadlocal: TButton;
    Bt_exc_loadlocal: TButton;
    Fm_Listauf_load_local: TFm_ListaEstados;
    Fm_lista_cidades_load_local: TFmListaCidades;
    Grp_route: TGroupBox;
    Grp_uf_route: TGroupBox;
    Dbg_uf_route: TDBGrid;
    Bt_ins_uf_route: TButton;
    Bt_exc_uf_route: TButton;
    Fm_Listauf_Route: TFm_ListaEstados;
    Grp_local_unload: TGroupBox;
    Grp_city_unload: TGroupBox;
    Dbg_city_unload: TDBGrid;
    Bt_ins_unloadlocal: TButton;
    Bt_exc_unloadlocal: TButton;
    Fm_Listauf_Unload_local: TFm_ListaEstados;
    Fm_lista_cidades_unload_local: TFmListaCidades;
    Grp_Totalizadores: TGroupBox;
    Valor_total_mercadoria: TLabel;
    Quantidade_total_NFE: TLabel;
    E_Qtde_Nfe: TEdit;
    Unidade_Medida_Carga: TLabel;
    E_Peso_Total: TEdit;
    Peso_Bruto_Total: TLabel;
    Cb_Medida_Peso: TComboBox;
    Grp_Observacoes: TGroupBox;
    M_info_fisco: TMemo;
    M_info_contribuinte: TMemo;
    info_fisco: TLabel;
    info_contribuinte: TLabel;
    Configuraes1: TMenuItem;
    OperaesMDFe1: TMenuItem;
    E_Valor_Total_Mercadoria: TEdit_Setes;
    cds_nfeNFL_VL_TL_NOTA: TBCDField;
    procedure Bt_ins_loadlocalClick(Sender: TObject);
    procedure Bt_exc_loadlocalClick(Sender: TObject);
    procedure Bt_ins_uf_routeClick(Sender: TObject);
    procedure Bt_exc_uf_routeClick(Sender: TObject);
    procedure Bt_ins_unloadlocalClick(Sender: TObject);
    procedure Fm_Listauf_Unload_localDblcb_ListaExit(Sender: TObject);
    procedure Bt_exc_unloadlocalClick(Sender: TObject);
    procedure Sb_PlacaClick(Sender: TObject);
    procedure Bt_inc_CondutorClick(Sender: TObject);
    procedure Bt_exc_CondutorClick(Sender: TObject);
    procedure Bt_inc_NfeClick(Sender: TObject);
    procedure Bt_exc_NfeClick(Sender: TObject);
    procedure Configuraes1Click(Sender: TObject);
    procedure OperaesMDFe1Click(Sender: TObject);
    procedure E_Valor_Total_MercadoriaExit(Sender: TObject);
    procedure E_PlacaExit(Sender: TObject);
    procedure Fm_Listauf_load_localDblcb_ListaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    function getnumberNfes:Boolean;
    procedure SomaNotaFiscal;
    function validainsereLoadlocal:Boolean;
    procedure insereLoadLocal;
    function validainsereStateroute:Boolean;
    procedure insereStateroute;
    function validainsereUnloadlocal:Boolean;
    procedure insereUnloadLocal;
    function validainsereConductor:Boolean;
    procedure insereConductor;
    function validainsereNfe:Boolean;
    procedure insereNfe;
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure EditionControl;Override;
    //
    procedure ShowData;Override;
    procedure ShowDataMDFE;
    procedure ShowDataLoadLocal;
    procedure ShowDataStateRoute;
    procedure ShowDataUnloadLocal;
    procedure ShowDataRoad;
    procedure ShowDataTrailler;
    procedure ShowDataConductor;
    procedure ShowDataNfe;
    procedure ShowDataTotalizer;
    procedure ShowNoData;Override;
    //
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;

    function ValidateSaveMDFE():boolean;
    procedure SaveMDFE;

    function ValidateSaveLoadLocal():boolean;
    procedure DeleteLoadLocal;
    procedure SaveLoadLocal;

    function ValidateSaveStateRoute():boolean;
    procedure DeleteStateRoute;
    procedure SaveStateRoute;

    function ValidateSaveUnloadLocal():boolean;
    procedure DeleteUnloadLocal;
    procedure SaveUnloadLocal;

    function ValidateSaveRoad():boolean;
    procedure SaveRoad;

    function ValidateSaveTrailler():boolean;
    procedure SaveTrailler;

    function ValidateSaveConductor():boolean;
    procedure DeleteConductor;
    procedure SaveConductor;

    function ValidateSaveNfe():boolean;
    procedure DeleteNfe;
    procedure SaveNfe;

    function ValidateSaveTotalizer():boolean;
    procedure SaveTotalizer;

    function ValidateSalvaRetorno():boolean;
    procedure SalvaRetorno;


    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

   protected

    It_Casa_Decimal : String;

  public
    MDFe : TControllerMdfe;

  end;

var
  TasMdfe: TTasMdfe;

implementation

{$R *.dfm}

uses     Un_DM, UN_Principal, env, UN_Sistema, Un_Regra_Negocio, Un_Veiculo, sea_collaborator, Un_Funcoes, Un_Pesq_NF_Pro, tas_mdfe_config, tas_mdfe_operacoes;
procedure TTasMdfe.Bt_exc_CondutorClick(Sender: TObject);
begin
  inherited;
    cds_conductor.Delete
end;

procedure TTasMdfe.Bt_exc_loadlocalClick(Sender: TObject);
begin
  inherited;
    cds_load_local.Delete;
end;

procedure TTasMdfe.Bt_exc_NfeClick(Sender: TObject);
begin
  inherited;
  cds_nfe.Delete;
  getnumberNfes;
  SomaNotaFiscal;
end;

procedure TTasMdfe.Bt_exc_uf_routeClick(Sender: TObject);
begin
  inherited;
  cds_state_route.Delete;
end;

procedure TTasMdfe.Bt_exc_unloadlocalClick(Sender: TObject);
begin
  inherited;
    cds_unload_local.Delete;
end;

procedure TTasMdfe.Bt_inc_CondutorClick(Sender: TObject);
var
  LcForm : TSeaCollaborator;
begin
  LcForm := TSeaCollaborator.Create(nil);
  Try
    LcForm.ShowModal;
    MDFe.Conductor.Colaborador.Registro.Codigo := LcForm.cds_searchcodigo.AsInteger;
    MDFe.Conductor.Colaborador.getbyId;
    if validainsereConductor then
      insereConductor;
  Finally
    FreeAndNil(LcForm);
  End;
end;


procedure TTasMdfe.Bt_inc_NfeClick(Sender: TObject);
var
  LcForm : TFr_Pesq_NF_Pro;
begin
  LcForm := TFr_Pesq_NF_Pro.Create(nil);
  Try
    LcForm.ShowModal;
    MDFe.Nfe.Retorno.Registro.NotaFiscal := LcForm.Qr_Pesquisa.FieldByName('NFL_CODIGO').AsInteger;
    MDFe.Nfe.Retorno.getByNotaFiscal;
    if validainsereNfe then
       insereNfe;
    getnumberNfes;
    SomaNotaFiscal;
  Finally
    FreeAndNil(LcForm);
  End;
end;

procedure TTasMdfe.Bt_ins_loadlocalClick(Sender: TObject);
begin
  if validainsereloadlocal then
  BEgin
    insereloadLocal;
  end;
end;

procedure TTasMdfe.Bt_ins_uf_routeClick(Sender: TObject);
begin
  inherited;
 if validainserestateroute then
  BEgin
    inserestateroute;
  end;
end;

procedure TTasMdfe.Bt_ins_unloadlocalClick(Sender: TObject);
begin
  if validainsereunloadlocal then
  BEgin
    insereunloadLocal;
  end;
end;

procedure TTasMdfe.Cancel;
begin
  inherited;
end;

procedure TTasMdfe.Change;
begin
  inherited;

end;

procedure TTasMdfe.Configuraes1Click(Sender: TObject);
var
  LcForm : TTasMdfeConfig;
Begin
  LcForm := TTasMdfeConfig.Create(nil);
  Try
    LcForm.CodigoRegistro := Gb_CodMha;
    LcForm.MDFe := self.MDFe;
    LcForm.ShowModal;
  Finally
    FreeAndNil(LcForm);
  End;
End;

procedure TTasMdfe.CriarVariaveis;
begin
  inherited;
  MDFe := TControllerMdfe.create(nil);
end;

procedure TTasMdfe.Delete;
begin
  inherited;
end;

procedure TTasMdfe.DeleteConductor;
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if cds_conductor.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_conductor.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          MDFe.conductor.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
          MDFe.conductor.Registro.MDFE            := MDFe.Registro.Codigo;
          MDFe.Conductor.Registro.Colaborador     := cds_temp.FieldByName('CLB_CODIGO').AsInteger;
          MDFe.conductor.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TTasMdfe.DeleteLoadLocal;
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if cds_load_local.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_load_local.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          MDFe.LoadLocal.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
          MDFe.LoadLocal.Registro.MDFE            := MDFe.Registro.Codigo;
          MDFe.LoadLocal.Registro.Estado          := cds_temp.FieldByName('UFE_CODIGO').AsInteger;
          MDFe.LoadLocal.Registro.Cidade          := cds_temp.FieldByName('CDD_CODIGO').AsInteger;
          MDFe.LoadLocal.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TTasMdfe.DeleteNfe;
Var
LcOperacao : String;
cds_temp : TClientDataSet;
begin
  if cds_nfe.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_nfe.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          MDFe.Nfe.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
          MDFe.Nfe.Registro.MDFE            := MDFe.Registro.Codigo;
          MDFe.Nfe.Registro.Nota            := cds_temp.FieldByName('NFE_CODNFL').AsInteger;
          MDFe.Nfe.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TTasMdfe.DeleteStateRoute;
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if cds_state_route.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_state_route.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          MDFe.StateRoute.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
          MDFe.StateRoute.Registro.MDFE            := MDFe.Registro.Codigo;
          MDFe.StateRoute.Registro.Estado          := cds_temp.FieldByName('TB_STATE_ID').AsInteger;
          MDFe.StateRoute.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TTasMdfe.DeleteUnloadLocal;
Var
  LcOperacao : String;
  cds_temp : TClientDataSet;
begin
  if cds_Unload_local.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_Unload_local.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        if cds_temp.UpdateStatus = usDeleted then
        Begin
          MDFe.UnLoadLocal.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
          MDFe.UnLoadLocal.Registro.MDFE            := MDFe.Registro.Codigo;
          MDFe.UnLoadLocal.Registro.Estado          := cds_temp.FieldByName('UFE_CODIGO').AsInteger;
          MDFe.UnLoadLocal.Registro.Cidade          := cds_temp.FieldByName('CDD_CODIGO').AsInteger;
          MDFe.UnLoadLocal.delete;
        End;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TTasMdfe.EditionControl;
begin
  inherited;
  pnl_mdfe.Enabled      := ( EditionState = 'I' ) or ( EditionState = 'E' );
  pnl_mdfe_road.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  pnl_mdfe_nfe.Enabled  := ( EditionState = 'I' ) or ( EditionState = 'E' );
  E_modelo.ReadOnly := True;
  E_Valor_Total_Mercadoria.ReadOnly := True;
  E_Qtde_Nfe.ReadOnly := True;
  E_MarcaModelo.ReadOnly := True;
end;

procedure TTasMdfe.E_PlacaExit(Sender: TObject);
begin
  if Trim(E_Placa.Text) <> '' then
  Begin
    MDFe.Road.Veiculo.Registro.Placa := E_Placa.Text;
    MDFe.Road.Veiculo.getbyId;
    E_Placa.Text := MDFe.Road.Veiculo.Registro.Placa;
    E_MarcaModelo.Text := MDFe.Road.Veiculo.getMarcaModelo;
  End;
end;

procedure TTasMdfe.E_Valor_Total_MercadoriaExit(Sender: TObject);
begin
  E_Valor_Total_Mercadoria.Text := FormatFloat(It_Casa_Decimal, StrToFloatDef(E_Valor_Total_Mercadoria.Text, 0));
end;

procedure TTasMdfe.Fm_Listauf_load_localDblcb_ListaExit(Sender: TObject);
begin
  inherited;
  Fm_lista_cidades_load_local.Estado := Fm_Listauf_load_local.Dblcb_Lista.Text;
  Fm_lista_cidades_load_local.Pc_Listar;
end;

procedure TTasMdfe.Fm_Listauf_Unload_localDblcb_ListaExit(Sender: TObject);
begin
  inherited;
  Fm_lista_cidades_unload_local.Estado := Fm_Listauf_unload_local.Dblcb_Lista.Text;
  Fm_lista_cidades_unload_local.Pc_Listar;
end;

procedure TTasMdfe.FormataTela;
begin
  inherited;
  pg_Geral.ActivePage := tbs_mdfe;

end;

procedure TTasMdfe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(MDFe);
end;

function TTasMdfe.getnumberNfes: Boolean;
begin
  E_Qtde_Nfe.Text := InttoStr(cds_nfe.RecordCount);
end;

procedure TTasMdfe.IniciaVariaveis;
begin
  Pc_AtivaEstabelecimento();
  Fm_Listauf_mdfe.Pc_Listar;
  Fm_Listauf_load_local.Pc_Listar;
  Fm_lista_cidades_load_local.Estado := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
  Fm_lista_cidades_load_local.Pc_Listar;

  Fm_Listauf_Route.Pc_Listar;

  Fm_Listauf_Unload_local.Pc_Listar;
  Fm_lista_cidades_unload_local.Estado := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
  Fm_lista_cidades_unload_local.Pc_Listar;

  if CodigoRegistro > 0 then
  Begin
    MDFe.Registro.Codigo := CodigoRegistro;
    MDFe.Registro.Estabelecimento := Gb_CodMha;
    MDFe.getAllbyId;
  End;

  inherited;

end;

procedure TTasMdfe.insereConductor;
begin
  IF NOT cds_conductor.Active THEN cds_conductor.CreateDataSet;
  cds_conductor.Append;
  cds_conductorCLB_CODIGO.AsInteger := MDFe.Conductor.Colaborador.Registro.Codigo;
  cds_conductorCLB_NOME.AsString    := MDFe.Conductor.Colaborador.Registro.Nome;
  cds_conductorCLB_CPF.AsString     := fc_MascaraCPF( MDFe.Conductor.Colaborador.Registro.CPFCNPJ);
  cds_conductor.Post;
end;

procedure TTasMdfe.insereloadLocal;
begin
  IF NOT cds_load_local.Active THEN cds_load_local.CreateDataSet;
  cds_load_local.Append;
  cds_load_localUFE_CODIGO.AsInteger    := Fm_Listauf_load_local.Dblcb_Lista.KeyValue;
  cds_load_localUFE_SIGLA.AsString      := Fm_Listauf_load_local.Dblcb_Lista.Text;
  cds_load_localCDD_CODIGO.AsInteger    := Fm_lista_cidades_load_local.DBLCB_CIDADE.KeyValue;
  cds_load_localCDD_DESCRICAO.AsString  := Fm_lista_cidades_load_local.DBLCB_CIDADE.Text;
  cds_load_local.Post;
end;

procedure TTasMdfe.insereNfe;
begin
  IF NOT cds_nfe.Active THEN cds_nfe.CreateDataSet;
  cds_Nfe.Append;
  cds_nfeNFE_CODNFL.AsInteger      := MDFe.Nfe.Retorno.Registro.NotaFiscal;
  cds_nfeNFE_NOTA_INI.AsString     := mdfe.Nfe.Retorno.Registro.NumeroInicial;
  cds_nfeNFE_ARQUIVO.AsString      := mdfe.Nfe.Retorno.Registro.NomeArquivo;
  
  mdfe.Nfe.NotaFiscal.Registro.Codigo := MDFe.Nfe.Retorno.Registro.NotaFiscal;
  cds_nfeNFL_VL_TL_NOTA.AsCurrency    := mdfe.Nfe.NotaFiscal.getTotalValue;
  cds_Nfe.Post;
end;

procedure TTasMdfe.inserestateroute;
begin
  IF NOT cds_state_route.Active THEN cds_state_route.CreateDataSet;
  cds_state_route.Append;
  cds_state_routeTB_STATE_ID.AsInteger := Fm_Listauf_route.Dblcb_Lista.KeyValue;
  cds_state_routeUFE_SIGLA.AsString    := Fm_Listauf_route.Dblcb_Lista.Text;
  cds_state_route.Post;
end;

procedure TTasMdfe.insereUnloadLocal;
begin
  IF NOT cds_Unload_local.Active THEN cds_Unload_local.CreateDataSet;
  cds_Unload_local.Append;
  cds_Unload_localUFE_CODIGO.AsInteger    := Fm_Listauf_Unload_local.Dblcb_Lista.KeyValue;
  cds_Unload_localUFE_SIGLA.AsString      := Fm_Listauf_Unload_local.Dblcb_Lista.Text;
  cds_Unload_localCDD_CODIGO.AsInteger    := Fm_lista_cidades_unload_local.DBLCB_CIDADE.KeyValue;
  cds_Unload_localCDD_DESCRICAO.AsString  := Fm_lista_cidades_unload_local.DBLCB_CIDADE.Text;
  cds_Unload_local.Post;
end;

procedure TTasMdfe.Insert;
begin
  ClearAllFields;
  MDFe.clear;
  ShowNoData;
end;

procedure TTasMdfe.OperaesMDFe1Click(Sender: TObject);
var
  LcForm : TTasMdfeOperacoes;
Begin
  LcForm := TTasMdfeOperacoes.Create(nil);
  Try
    LcForm.MDFe := Self.MDFe;
    LcForm.ShowModal;
  Finally
    FreeAndNil(LcForm);
  End;
End;

procedure TTasMdfe.SalvaRetorno;
begin
  With MDFe.Retorno.Registro do
  begin
    Codigo            := mdfe.Registro.Codigo;
    Estabelecimento   := mdfe.Registro.Estabelecimento;
    Situacao          := 0;
    Arquivo           := '';
    Motivo            := '';
    Serie             := 0;
    Protocolo         := '';
  end;
  MDFe.Retorno.salva;
end;

procedure TTasMdfe.Save;
begin
  inherited;
  SaveMDFE;
  DeleteLoadLocal;
  SaveLoadLocal;
  DeleteStateRoute;
  SaveStateRoute;
  DeleteUnloadLocal;
  SaveUnloadLocal;
  SaveRoad;
  {SaveDataTrailler;}
  DeleteConductor;
  SaveConductor;
  DeleteNfe;
  SaveNfe;
  SaveTotalizer;
  SalvaRetorno;

end;

procedure TTasMdfe.SaveConductor;
Var
  LcOperacao : String;
begin
  if not cds_conductor.Active then  cds_conductor.CreateDataSet;
  if cds_conductor.ChangeCount > 0 then
  Begin
    cds_conductor.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_conductor.eof do
    Begin
      MDFe.conductor.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
      MDFe.conductor.Registro.MDFE            := MDFe.Registro.Codigo;
      MDFe.conductor.Registro.Colaborador     := cds_conductorCLB_CODIGO.AsInteger;

      case cds_conductor.UpdateStatus of
        usModified: MDFe.conductor.update;
        usInserted: MDFe.conductor.insere;
      end;
      cds_conductor.next;
    End;
    cds_conductor.MergeChangeLog;
  End;
end;

procedure TTasMdfe.SaveLoadLocal;
Var
  LcOperacao : String;
begin
  if not cds_load_local.Active then  cds_load_local.CreateDataSet;
  if cds_load_local.ChangeCount > 0 then
  Begin
    cds_load_local.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_load_local.eof do
    Begin
      MDFe.LoadLocal.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
      MDFe.LoadLocal.Registro.MDFE            := MDFe.Registro.Codigo;
      MDFe.LoadLocal.Registro.Estado          := cds_load_localUFE_CODIGO.AsInteger;
      MDFe.LoadLocal.Registro.Cidade          := cds_load_localCDD_CODIGO.AsInteger;
      case cds_load_local.UpdateStatus of
        usModified: MDFe.LoadLocal.update;
        usInserted: MDFe.LoadLocal.insere;
      end;
      cds_load_local.next;
    End;
    cds_load_local.MergeChangeLog;
  End;
end;

procedure TTasMdfe.SaveMDFE;
begin
  With MDFe do
  begin
    Registro.Estabelecimento :=  Gb_CodMha;
    Registro.modelo          :=  E_modelo.Text;
    Registro.serie           :=  E_serie.Text;
    Registro.numero          :=  E_numero.Text;
    Registro.DataEmissao     :=  Dtp_Emissao.DateTime;
    Registro.DataViagem      :=  Dtp_Viagem.DateTime;
    Registro.Estado          :=Fm_Listauf_mdfe.Dblcb_Lista.keyvalue ;
    if Cb_tipo_de_Emitente.ItemIndex =0 then
      Registro.TipoEmissor   := 'T'
    else
      Registro.TipoEmissor   := 'P';
    Registro.TipoDoTransportador := Cb_tipo_de_transportador.Text;
    if Cb_modalidade.ItemIndex = 0 then
      Registro.Modalidade    := 'R'
    else
      Registro.Modalidade    := 'Q' ;
    Registro.Observacao      :=  M_info_contribuinte.Text;
    Registro.ObservacaoFisco :=  M_info_fisco.Text;
  end;
  MDFe.salva;
end;

procedure TTasMdfe.SaveNfe;
Var
  LcOperacao : String;
begin
  if not cds_nfe.Active then  cds_nfe.CreateDataSet;
  if cds_nfe.ChangeCount > 0 then
  Begin
    cds_nfe.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_nfe.eof do
    Begin
      MDFe.Nfe.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
      MDFe.Nfe.Registro.MDFE            := MDFe.Registro.Codigo;
      MDFe.Nfe.Registro.Nota            := cds_nfeNFE_CODNFL.AsInteger;
      case cds_nfe.UpdateStatus of
        usModified: MDFe.Nfe.update;
        usInserted: MDFe.Nfe.insere;
      end;
      cds_nfe.next;
    End;
    cds_nfe.MergeChangeLog;
  End;
  getnumberNfes;
  SomaNotaFiscal;
end;


procedure TTasMdfe.SaveRoad;
begin
  With MDFe.Road do
  begin
    Registro.Estabelecimento   :=  Gb_CodMha;
    Registro.mdfe              :=  mdfe.Registro.Codigo;
    Registro.veiculo           :=  E_Placa.Text;
    Registro.rntrc             :=  E_rntrc.Text;
    Registro.AgendamentoPorto  :=  E_codigo_agendamento_porto.text;

  end;
  MDFe.road.save;
end;

procedure TTasMdfe.SaveStateRoute;
Var
  LcOperacao : String;
begin
  if not cds_state_route.Active then  cds_state_route.CreateDataSet;
  if cds_state_route.ChangeCount > 0 then
  Begin
    cds_state_route.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_state_route.eof do
    Begin
      MDFe.StateRoute.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
      MDFe.StateRoute.Registro.MDFE            := MDFe.Registro.Codigo;
      MDFe.StateRoute.Registro.Estado          := cds_state_routeTB_STATE_ID.AsInteger;
      case cds_state_route.UpdateStatus of
        usModified: MDFe.StateRoute.update;
        usInserted: MDFe.StateRoute.insere;
      end;
      cds_state_route.next;
    End;
    cds_state_route.MergeChangeLog;
  End;
end;


procedure TTasMdfe.SaveTotalizer;
begin
  With MDFe.Totalizer do
  begin
    Registro.Estabelecimento :=  Gb_CodMha;
    Registro.QuantidadeNfe   :=  StrToIntDef(E_Qtde_Nfe.Text,0);
    Registro.ValorTotalCarga :=  StrToFloatDef(E_Valor_Total_Mercadoria.Text,0);
    Registro.PesoBruto       :=  StrToFloatDef(E_Peso_Total.Text,0);
    //Define codigo da Medida
    if Cb_Medida_Peso.ItemIndex =0 then
    Begin
      Medida.Registro.Descricao := 'KILO';
      Medida.Registro.Abreviatura := 'KG';
    End
    else
    Begin
      Medida.Registro.Descricao := 'TONELADA';
      Medida.Registro.Abreviatura := 'TON';
    End;
    Medida.getIdAutoByDesc;
    Registro.MedidaId := Medida.Registro.Codigo;
  end;
  MDFe.Totalizer.salva;
end;

procedure TTasMdfe.SaveTrailler;
begin

end;

procedure TTasMdfe.SaveUnloadLocal;
Var
  LcOperacao : String;
begin
  if not cds_Unload_local.Active then  cds_Unload_local.CreateDataSet;
  if cds_Unload_local.ChangeCount > 0 then
  Begin
    cds_Unload_local.First;
    //Trata somente os dados Inseridos ou Alterados
    while not cds_Unload_local.eof do
    Begin
      MDFe.UnloadLocal.Registro.Estabelecimento := MDFe.Registro.Estabelecimento;
      MDFe.UnloadLocal.Registro.MDFE            := MDFe.Registro.Codigo;
      MDFe.UnloadLocal.Registro.Estado          := cds_Unload_localUFE_CODIGO.AsInteger;
      MDFe.UnloadLocal.Registro.Cidade          := cds_Unload_localCDD_CODIGO.AsInteger;
      case cds_Unload_local.UpdateStatus of
        usModified: MDFe.UnloadLocal.update;
        usInserted: MDFe.UnloadLocal.insere;
      end;
      cds_Unload_local.next;
    End;
    cds_Unload_local.MergeChangeLog;
  End;
end;

procedure TTasMdfe.Sb_PlacaClick(Sender: TObject);
Var
  LcForm : TFr_Veiculo;
begin
  LcForm := TFr_Veiculo.Create(nil);
  Try
    LcForm.ShowModal;
    MDFe.Road.Veiculo.Registro.Placa := LcForm.vehicle.Registro.Placa;
    MDFe.Road.Veiculo.getbyId;
    E_Placa.Text := MDFe.Road.Veiculo.Registro.Placa;
    E_MarcaModelo.Text := MDFe.Road.Veiculo.getMarcaModelo;
  Finally
    FreeAndNil(LcForm);
  End;

end;

procedure TTasMdfe.setPerfil;
begin
  inherited;

end;

procedure TTasMdfe.ShowData;
begin
  inherited;
  ShowDataMDFE;
  ShowDataLoadLocal;
  ShowDataStateRoute;
  ShowDataUnloadLocal;
  ShowDataRoad;
  {ShowDataTrailler;}
  ShowDataConductor;
  ShowDataNfe;
  ShowDataTotalizer;
end;

procedure TTasMdfe.ShowDataConductor;

Var
  I: Integer;
  LITem : TMdfeconductor;
 begin
 IF NOT cds_conductor.Active THEN cds_conductor.CreateDataSet;
 cds_conductor.LogChanges := False;
 cds_conductor.EmptyDataSet;
 for I := 0 to mdfe.conductor.Lista.Count -1 do
      Begin
        LITem := TMdfeconductor.Create;
        LITem := mdfe.conductor.Lista[I];

        mdfe.conductor.Colaborador.Registro.Codigo := LITem.Colaborador;
        mdfe.conductor.Colaborador.getbyId;

        cds_conductor.Append;

        cds_conductorCLB_CODIGO.AsInteger  := LITem.Colaborador;
        cds_conductorCLB_NOME.AsString     := mdfe.Conductor.Colaborador.Registro.Nome;
        cds_conductorCLB_CPF.AsString      := mdfe.Conductor.Colaborador.Registro.CPFCNPJ;
        cds_conductor.Post;
      end;
 cds_conductor.LogChanges := True;
 end;

procedure TTasMdfe.ShowDataLoadLocal;
Var
  I: Integer;
  LITem : TMdfeLoadLocal;
begin
  IF NOT cds_load_local.Active THEN cds_load_local.CreateDataSet;
  cds_load_local.LogChanges := False;
  cds_load_local.EmptyDataSet;
  for I := 0 to mdfe.loadlocal.Lista.Count -1 do
  Begin
    LITem := TMdfeLoadLocal.Create;
    LITem := mdfe.loadlocal.Lista[I];

    mdfe.loadlocal.Cidade.Registro.Codigo := LITem.Cidade;
    mdfe.loadlocal.Cidade.getbyId;

    cds_load_local.Append;
    cds_load_localUFE_CODIGO.AsInteger    := LITem.Estado;
    cds_load_localUFE_SIGLA.AsString      := mdfe.loadlocal.Cidade.Registro.Estado;
    cds_load_localCDD_CODIGO.AsInteger    := LITem.Cidade;
    cds_load_localCDD_DESCRICAO.AsString  := mdfe.loadlocal.Cidade.Registro.Descricao;
    cds_load_local.Post;
  end;
  cds_load_local.LogChanges := True;
end;

procedure TTasMdfe.ShowDataMDFE;
begin
  With MDFe do
  begin
    E_modelo.Text                     :=  Registro.modelo;
    E_serie.Text                      :=  Registro.serie;
    E_numero.Text                     :=  Registro.numero;
    Dtp_Emissao.DateTime              :=  Registro.DataEmissao;
    Dtp_Viagem.DateTime               :=  Registro.DataViagem;
    Fm_Listauf_mdfe.Dblcb_Lista.keyvalue :=  Registro.Estado;
    if Registro.TipoEmissor = 'T' then
      Cb_tipo_de_Emitente.ITEMINDEX   :=  0
    else
      Cb_tipo_de_Emitente.ITEMINDEX   :=  1;
    Cb_tipo_de_transportador.Text     := Registro.TipoDoTransportador;
    if Registro.Modalidade = 'R' then
      Cb_modalidade.ItemIndex         := 0
    else
      Cb_modalidade.ItemIndex         := 1;

    M_info_contribuinte.Text          := Registro.Observacao;
    M_info_fisco.Text                 := Registro.ObservacaoFisco;
  end;

end;

procedure TTasMdfe.ShowDataNfe;
Var
  I: Integer;
  LITem : TMdfeNfe;
begin
  IF NOT cds_Nfe.Active THEN cds_Nfe.CreateDataSet;
  cds_Nfe.LogChanges := False;
  cds_Nfe.EmptyDataSet;
  for I := 0 to mdfe.Nfe.Lista.Count -1 do
  Begin
    LITem := TMdfeNfe.Create;
    LITem := mdfe.Nfe.Lista[I];
    mdfe.Nfe.Retorno.Registro.NotaFiscal := LITem.Nota;
    mdfe.Nfe.Retorno.getByNotaFiscal;
    insereNfe;
  end;
  cds_Nfe.LogChanges := True;
  getnumberNfes;
  SomaNotaFiscal;
end;
procedure TTasMdfe.ShowDataRoad;
begin
  With MDFe.Road do
  begin
    E_rntrc.Text                    := Registro.RNTRC;
    E_codigo_agendamento_porto.Text := Registro.AgendamentoPorto;
    E_Placa.Text                    := Registro.Veiculo;
    Veiculo.Registro.Placa          := Registro.Veiculo;
    E_MarcaModelo.Text              := Veiculo.getMarcaModelo;
  end;

end;


procedure TTasMdfe.ShowDataTotalizer;
begin
  With MDFe.Totalizer do
  begin
    E_Qtde_Nfe.text                   :=  IntToStr(Registro.QuantidadeNfe);
    E_Valor_Total_Mercadoria.Text     :=  FloatToStrF(Registro.ValorTotalCarga,ffFixed,10,2);
    E_Peso_Total.Text                 :=  FloatToStrF(Registro.PesoBruto,ffFixed,10,2);
    Medida.Registro.Codigo            := Registro.MedidaId;
    Medida.getbyId;
    if Medida.Registro.Abreviatura = 'KG' then
      Cb_Medida_Peso.ItemIndex        := 0
    else
      Cb_Medida_Peso.ItemIndex        := 1;
  end;

end;
procedure TTasMdfe.ShowDataTrailler;
begin

end;

procedure TTasMdfe.ShowDataUnloadLocal;
Var
  I: Integer;
  LITem : TMdfeUnloadLocal;
begin
  IF NOT cds_Unload_local.Active THEN cds_Unload_local.CreateDataSet;
  cds_Unload_local.LogChanges := False;
  cds_Unload_local.EmptyDataSet;
  for I := 0 to mdfe.UnloadLocal.Lista.Count -1 do
  Begin
    LITem := TMdfeUnloadLocal.Create;
    LITem := mdfe.UnloadLocal.Lista[I];

    mdfe.UnloadLocal.Cidade.Registro.Codigo := LITem.Cidade;
    mdfe.UnloadLocal.Cidade.getbyId;

    cds_Unload_local.Append;

    cds_Unload_localUFE_CODIGO.AsInteger    := LITem.Estado;
    cds_Unload_localUFE_SIGLA.AsString      := mdfe.UnloadLocal.Cidade.Registro.Estado;
    cds_Unload_localCDD_CODIGO.AsInteger    := LITem.Cidade;
    cds_Unload_localCDD_DESCRICAO.AsString  :=  mdfe.UnloadLocal.Cidade.Registro.Descricao;
    cds_Unload_local.Post;
  end;
  cds_Unload_local.LogChanges := True;
end;

procedure TTasMdfe.ShowNoData;
begin
  inherited;
  E_modelo.Text         :=  '58';
  E_serie.Text          :=  '1';
  E_numero.Text         :=  '';
  Dtp_Emissao.DateTime  :=  now;
  Dtp_Viagem.DateTime   :=  now;
  Cb_tipo_de_Emitente.ItemIndex       := 1;
  Cb_tipo_de_transportador.ItemIndex  := 0;
  Cb_modalidade.ItemIndex             := 0;
  Fm_Listauf_mdfe.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('ufe_codigo').AsInteger;

  Fm_Listauf_load_local.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('ufe_codigo').AsInteger;
  Fm_lista_cidades_load_local.DBLCB_CIDADE.KeyValue := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;

  Fm_Listauf_Route.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('ufe_codigo').AsInteger;

  Fm_Listauf_Unload_local.Dblcb_Lista.KeyValue := DM.Qr_Estabelecimento.FieldByName('ufe_codigo').AsInteger;
  Fm_lista_cidades_unload_local.DBLCB_CIDADE.KeyValue := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;

  cds_conductor.Active    := False;
  cds_load_local.Active   := False;
  cds_state_route.Active  := False;
  cds_unload_local.Active := False;
  cds_nfe.Active          := False;

end;

procedure TTasMdfe.SomaNotaFiscal;
VAr
  lcVAlor : Real;
begin
  cds_nfe.Active := True;
  cds_nfe.First;
  lcVAlor := 0;
  while not cds_nfe.eof do
  Begin
    lcVAlor := lcVAlor + cds_nfeNFL_VL_TL_NOTA.AsCurrency;
    cds_nfe.Next;    
  End;  
  E_Valor_Total_Mercadoria.Text := FloattoStrF(lcVAlor,ffFixed,10,2);
end;

procedure TTasMdfe.ShowDataStateRoute;
Var
  I: Integer;
  LITem : TMdfeStateRoute;
begin
  IF NOT cds_state_route.Active THEN cds_state_route.CreateDataSet;
  cds_state_route.LogChanges := False;
  cds_state_route.EmptyDataSet;
  for I := 0 to mdfe.StateRoute.Lista.Count -1 do
  Begin
    LITem := TMdfeStateRoute.Create;
    LITem := mdfe.StateRoute.Lista[I];

    mdfe.StateRoute.Uf.Registro.Codigo := LITem.Estado;
    mdfe.StateRoute.Uf.getbyId;

    cds_state_route.Append;
    cds_state_routeTB_STATE_ID.AsInteger    := LITem.Estado;
    cds_state_routeUFE_SIGLA.AsString      := mdfe.StateRoute.Uf.Registro.Sigla;

    cds_state_route.Post;
  end;
  cds_state_route.LogChanges := True;
end;

function TTasMdfe.validainsereConductor: Boolean;
begin
  REsult := True;
  if not MDFe.Conductor.Colaborador.exist  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'Condutor não foi encontrado.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;
end;

function TTasMdfe.validainsereloadlocal: Boolean;
begin
  result := True;
  if (Fm_Listauf_load_local.Dblcb_Lista.Text='')  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'UF não foi informada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;

  if (Fm_lista_cidades_load_local.DBLCB_CIDADE.Text='')  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'Cidade não foi informada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;

end;

function TTasMdfe.validainsereNfe: Boolean;

begin
  REsult := True;
  if not MDFe.Nfe.Retorno.exist  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'NFE não foi encontrada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;
end;


function TTasMdfe.validainserestateroute: Boolean;
begin
   result := True;
  if (Fm_Listauf_Route.Dblcb_Lista.Text='')  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'UF não foi informada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;
end;

function TTasMdfe.validainsereUnloadlocal: Boolean;
begin
  result := True;
  if (Fm_Listauf_Unload_local.Dblcb_Lista.Text='')  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'UF não foi informada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;

  if (Fm_lista_cidades_unload_local.DBLCB_CIDADE.Text='')  then
  Begin
    MensagemPadrao( TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'Cidade não foi informada.'+EOLN+
                    'Verifique e tente novamente'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    REsult := False;
    exit;
  End;

end;


function TTasMdfe.ValidaInsert: boolean;
begin
  Result := True;
end;

function TTasMdfe.ValidateCancel: boolean;
begin
    Result := True;
end;

function TTasMdfe.ValidateChange: boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;

  if (MDFe.Retorno.Registro.Situacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe enviada mas ainda não possue autorização.' + EOLN +
                   'Não é possivel editar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if (MDFe.Retorno.Registro.Situacao = 2) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Autorizada.' + EOLN +
                   'Não é possivel editar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if (MDFe.Retorno.Registro.Situacao = 3) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Cancelada.' + EOLN +
                   'Não é possivel editar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

    if (MDFe.Retorno.Registro.Situacao = 4) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Encerrada.' + EOLN +
                   'Não é possivel editar.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfe.ValidateDelete: boolean;
begin
  Result := True;
  // Limpa as consultas do webservice;

  if (MDFe.Retorno.Registro.Situacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe enviada mas ainda não possue autorização.' + EOLN +
                   'Não é possivel Excluir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if (MDFe.Retorno.Registro.Situacao = 2) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Autorizada.' + EOLN +
                   'Não é possivel Excluir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if (MDFe.Retorno.Registro.Situacao = 3) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Cancelada.' + EOLN +
                   'Não é possivel Excluir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

    if (MDFe.Retorno.Registro.Situacao = 4) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'MDfe Encerrada.' + EOLN +
                   'Não é possivel Excluir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfe.ValidateSalvaRetorno: boolean;
begin

end;

function TTasMdfe.ValidateSave: boolean;
begin
  Result := True;
  if not ValidateSaveMDFE then
  Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveLoadLocal then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveStateRoute then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveUnloadLocal then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveRoad then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveTrailler then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveConductor then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveTotalizer then
    Begin
    Result := False;
    exit;
  End;

  if not ValidateSaveNfe then
    Begin
    Result := False;
    exit;
  End;

end;

function TTasMdfe.ValidateSaveConductor: boolean;
begin
  Result := True;
  if cds_conductor.RecordCount = 0  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Condutor não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveLoadLocal: boolean;
begin
  Result := True;
  if cds_load_local.RecordCount = 0  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Local de Carregamento não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveMDFE: boolean;
begin
  Result := True;
  if trim(E_serie.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Série não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if trim(E_numero.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Número não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasMdfe.ValidateSaveNfe: boolean;
begin
  Result := True;
  if cds_nfe.RecordCount = 0  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Nfe não informada.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveRoad: boolean;
begin
  Result := True;
  if trim(Fm_Listauf_mdfe.Dblcb_Lista.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Estado não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveStateRoute: boolean;
begin
  Result := True;
  if cds_state_route.RecordCount = 0  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Percurso não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveTotalizer: boolean;
begin
  Result := True;
  if trim(E_Peso_Total.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Campo Peso Bruto não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveTrailler: boolean;
begin
  Result := True;
  if trim(E_Placa.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Placa não informada.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
  if trim(E_MarcaModelo.Text) = ''  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Veiculo não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

function TTasMdfe.ValidateSaveUnloadLocal: boolean;
begin
  Result := True;
  if cds_unload_local.RecordCount = 0  then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Local de Descarregamento não informado.' + EOLN +
                   'Informar para prosseguir.' + EOLN, ['OK'], [bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;

end.


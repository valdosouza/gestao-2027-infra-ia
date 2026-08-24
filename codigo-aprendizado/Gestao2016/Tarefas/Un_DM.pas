unit Un_DM;

interface

uses
  TypInfo,Forms, STStoredProc, Datasnap.DBClient, STQuery, STDatabase, Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase, STFBDriverLink, FireDAC.Comp.UI, STWaitCursor,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, STTransaction, IBX.IBCustomDataSet,
  IBX.IBQuery, IBX.IBDatabase;


type
   TDM = class(TDataModule)
    IBD_Gestao: TSTDatabase;
    IB_Transacao: TSTTransaction;
    Qr_Cargo: TSTQuery;
    Qr_Grupo: TSTQuery;
    Qr_SubGrupo: TSTQuery;
    Ds_Grupo: TDataSource;
    Ds_SubGrupo: TDataSource;
    Qr_Observacao: TSTQuery;
    Qr_Empresas: TSTQuery;
    Qr_Prazo: TSTQuery;
    Qr_Endereco: TSTQuery;
    Qr_Impostos: TSTQuery;
    Qr_Colaborador: TSTQuery;
    Qr_MarcaVeiculo: TSTQuery;
    Qr_Modelo: TSTQuery;
    Ds_MarcaVeiculo: TDataSource;
    Ds_Modelo: TDataSource;
    Qr_Tp_Veiculo: TSTQuery;
    Qr_MarcaProduto: TSTQuery;
    Qr_ListaUsuario: TSTQuery;
    Qr_Cartao: TSTQuery;
    Qr_Situacao: TSTQuery;
    Qr_UF: TSTQuery;
    IBT_Estoque: TSTTransaction;
    Qr_Pais: TSTQuery;
    Qr_Cidades: TSTQuery;
    Ds_UF: TDataSource;
    Ds_Cidades: TDataSource;
    ds_Pais: TDataSource;
    Qr_Estoques: TSTQuery;
    Ds_Estoques: TDataSource;
    Ds_Tabelas: TDataSource;
    Qr_Impressora: TSTQuery;
    IBT_Financeiro: TSTTransaction;
    Qr_Embalagem: TSTQuery;
    Ds_Embalagem: TDataSource;
    Ds_marcaProduto: TDataSource;
    Qr_Nvl_Manut: TSTQuery;
    Qr_Filtra_CFOP: TSTQuery;
    Qr_Modal_Frete: TSTQuery;
    IBT_Atualiza: TSTTransaction;
    IBT_Consulta: TSTTransaction;
    Qr_Color: TSTQuery;
    Ds_Color: TDataSource;
    Qr_ImagenBotao: TSTQuery;
    IBT_Generator: TSTTransaction;
    qr_trib_pis: TSTQuery;
    ds_trib_pis: TDataSource;
    Qr_Uf_Mva_NCM: TSTQuery;
    Qr_Especie_Doc_Cobranca: TSTQuery;
    Qr_Carteira_Cobranca: TSTQuery;
    Qr_Negocio: TSTQuery;
    Ds_Negocio: TDataSource;
    Qr_Revestimento: TSTQuery;
    Ds_Revestimento: TDataSource;
    qr_category: TSTQuery;
    ds_category: TDataSource;
    Qr_Carteiras: TSTQuery;
    Ds_Carteiras: TDataSource;
    Ds_Endereco: TDataSource;
    Qr_Estabelecimento: TSTQuery;
    Qr_Nf_Eletronica: TSTQuery;
    Ds_Colaborador: TDataSource;
    IBT_GeneratorBcoDestino: TSTTransaction;
    Qr_GeneratorBcoDestino: TSTQuery;
    IBT_ConsultaBcoDestino: TSTTransaction;
    Qr_Acao_EstoqueBcoDestino: TSTQuery;
    Qr_Insere_EstoqueBcoDestino: TSTQuery;
    IBT_EstoqueBcoDestino: TSTTransaction;
    Qr_Transportadora: TSTQuery;
    Ds_Natureza: TDataSource;
    Qr_Tabelas: TSTQuery;
    Qr_Crud: TSTQuery;
    IBT_Faturamento: TSTTransaction;
    IBT_Crud: TSTTransaction;
    Ds_TPV_Veiculo: TDataSource;
    IBT_Listas: TSTTransaction;
    IBD_Servidor: TSTDatabase;
    IBT_Servidor: TSTTransaction;
    IBT_Report: TSTTransaction;
    Ds_Impressora: TDataSource;
   procedure Qr_CargoAfterOpen(DataSet: TDataSet);
   procedure Qr_EmpresasAfterOpen(DataSet: TDataSet);
   procedure Qr_GrupoAfterOpen(DataSet: TDataSet);
   procedure Qr_SubGrupoAfterOpen(DataSet: TDataSet);
   procedure Qr_ObservacaoAfterOpen(DataSet: TDataSet);
   procedure Qr_PrazoAfterOpen(DataSet: TDataSet);
   procedure Qr_EnderecoAfterOpen(DataSet: TDataSet);
   procedure Qr_MarcaAfterOpen(DataSet: TDataSet);
   procedure Qr_ModeloAfterOpen(DataSet: TDataSet);
   procedure Qr_Tp_VeiculoAfterOpen(DataSet: TDataSet);
   procedure Qr_MarcaProdutoAfterOpen(DataSet: TDataSet);
   procedure Qr_ListaUsuarioAfterOpen(DataSet: TDataSet);
   procedure Qr_ColaboradorAfterOpen(DataSet: TDataSet);
   procedure Qr_CartaoAfterOpen(DataSet: TDataSet);
   procedure Qr_SituacaoAfterOpen(DataSet: TDataSet);
   procedure Qr_PaisAfterOpen(DataSet: TDataSet);
   procedure Qr_EstoquesAfterOpen(DataSet: TDataSet);
   procedure Qr_MarcaVeiculoAfterOpen(DataSet: TDataSet);
   procedure Qr_Modal_FreteAfterOpen(DataSet: TDataSet);
   procedure Qr_Filtra_CFOPAfterOpen(DataSet: TDataSet);
    procedure Qr_ColorAfterOpen(DataSet: TDataSet);
    procedure Qr_CidadesAfterOpen(DataSet: TDataSet);
    procedure Qr_UFAfterOpen(DataSet: TDataSet);
    procedure Qr_Uf_Mva_NCMAfterOpen(DataSet: TDataSet);
    procedure Qr_Carteira_CobrancaAfterOpen(DataSet: TDataSet);
    procedure Qr_NegocioAfterOpen(DataSet: TDataSet);
    procedure Qr_RevestimentoAfterOpen(DataSet: TDataSet);
    procedure Qr_EmbalagemAfterOpen(DataSet: TDataSet);
    procedure Qr_Especie_Doc_CobrancaAfterOpen(DataSet: TDataSet);
    procedure Qr_CarteirasAfterOpen(DataSet: TDataSet);
    procedure Qr_TabelasAfterOpen(DataSet: TDataSet);
    procedure Qr_ImpressoraAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure IBD_GestaoBeforeDisconnect(Sender: TObject);
  private
   { Private declarations }
  public
   { Public declarations }
    PathExe: string;
    PathTabelas: string;
    PathPrivate: string;
    PathNetFileDir: string;
    PathTemp: string;
    procedure ExecComando(SqlTxt: String);

  end;

var
   DM: TDM;

implementation

uses     Un_Script_Sql, UN_Principal, env, rn_empresa;
{$R *.dfm}


procedure TDM.DataModuleCreate(Sender: TObject);
begin
  DM.IBD_Gestao.Connected := False;
  Qr_Crud.Active := False;
end;

procedure TDM.ExecComando(SqlTxt: String);
begin
  with Qr_Crud do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    active := False;
    sql.Clear;
    SQL.Add(SqlTxt);
    ExecSQL;
    if Transaction.InTransaction then Transaction.Commit;
    Close;
  End;
end;

procedure TDM.IBD_GestaoBeforeDisconnect(Sender: TObject);
  function ComponentDB(C: TComponent): TObject;
  begin
    Result := nil;

    if GetPropInfo(C.ClassInfo, 'Database') <> nil then
      Result := TObject(GetObjectProp(C, 'Database'))
    else if GetPropInfo(C.ClassInfo, 'Connection') <> nil then
      Result := TObject(GetObjectProp(C, 'Connection'));
  end;

  procedure SafeCloseDataSet(DS: TDataSet);
  begin
    try
      if DS.Active then
      begin
        if DS.State in [dsEdit, dsInsert] then
          try DS.Post except DS.Cancel; end;
        DS.Close;
      end;
    except
      // silencioso: estamos desligando
    end;
  end;

  function TransactionDB(T: TSTTransaction): TObject;
  begin
    Result := nil;

    if GetPropInfo(T.ClassInfo, 'DefaultDatabase') <> nil then
      Result := TObject(GetObjectProp(T, 'DefaultDatabase'))
    else if GetPropInfo(T.ClassInfo, 'Database') <> nil then
      Result := TObject(GetObjectProp(T, 'Database'))
    else if GetPropInfo(T.ClassInfo, 'Connection') <> nil then
      Result := TObject(GetObjectProp(T, 'Connection'));
  end;

  function TransactionActive(T: TSTTransaction): Boolean;
  begin
    Result := False;

    if GetPropInfo(T.ClassInfo, 'InTransaction') <> nil then
      Result := GetOrdProp(T, 'InTransaction') <> 0
    else if GetPropInfo(T.ClassInfo, 'Active') <> nil then
      Result := GetOrdProp(T, 'Active') <> 0;
  end;

  procedure SafeFinishTransaction(T: TSTTransaction);
  begin
    if (not Assigned(T)) or (TransactionDB(T) <> IBD_Gestao) then
      Exit;

    try
      if TransactionActive(T) then
        T.Commit;
    except
      try
        if TransactionActive(T) then
          T.Rollback;
      except
        // nao propagar erro no shutdown
      end;
    end;
  end;

  procedure CloseOwnerResources(AOwner: TComponent);
  var
    I: Integer;
    C: TComponent;
  begin
    if not Assigned(AOwner) then
      Exit;

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      C := AOwner.Components[I];

      if (C is TDataSet) and (ComponentDB(C) = IBD_Gestao) then
        SafeCloseDataSet(TDataSet(C));

      if C is TSTTransaction then
        SafeFinishTransaction(TSTTransaction(C));
    end;
  end;

var
  I: Integer;
begin
  if not Assigned(IBD_Gestao) then Exit;

  CloseOwnerResources(IBD_Gestao.Owner);
  CloseOwnerResources(Application);

  for I := 0 to Screen.FormCount - 1 do
    CloseOwnerResources(Screen.Forms[I]);

  for I := 0 to Screen.DataModuleCount - 1 do
    CloseOwnerResources(Screen.DataModules[I]);
end;

procedure TDM.Qr_CargoAfterOpen(DataSet: TDataSet);
begin
  Qr_Cargo.FetchAll;
end;

procedure TDM.Qr_EmpresasAfterOpen(DataSet: TDataSet);
begin
  Qr_Empresas.FetchAll;
end;

procedure TDM.Qr_GrupoAfterOpen(DataSet: TDataSet);
begin
  Qr_Grupo.FetchAll;
end;

procedure TDM.Qr_ImpressoraAfterOpen(DataSet: TDataSet);
begin
  Qr_Impressora.FetchAll;
end;

procedure TDM.Qr_SubGrupoAfterOpen(DataSet: TDataSet);
begin
  Qr_SubGrupo.FetchAll;
end;

procedure TDM.Qr_ObservacaoAfterOpen(DataSet: TDataSet);
begin
  Qr_Observacao.FetchAll;
end;

procedure TDM.Qr_PrazoAfterOpen(DataSet: TDataSet);
begin
  Qr_Prazo.FetchAll;
end;

procedure TDM.Qr_EnderecoAfterOpen(DataSet: TDataSet);
begin
  Qr_Endereco.FetchAll;
end;

procedure TDM.Qr_MarcaAfterOpen(DataSet: TDataSet);
begin
   Qr_MarcaVeiculo.FetchAll;
end;

procedure TDM.Qr_ModeloAfterOpen(DataSet: TDataSet);
begin
   Qr_Modelo.FetchAll;
end;

procedure TDM.Qr_TabelasAfterOpen(DataSet: TDataSet);
begin
  Qr_Tabelas.FetchAll;
end;

procedure TDM.Qr_Tp_VeiculoAfterOpen(DataSet: TDataSet);
begin
   Qr_Tp_Veiculo.FetchAll;
end;

procedure TDM.Qr_MarcaProdutoAfterOpen(DataSet: TDataSet);
begin
   Qr_MarcaProduto.FetchAll;
end;

procedure TDM.Qr_ListaUsuarioAfterOpen(DataSet: TDataSet);
begin
   Qr_ListaUsuario.FetchAll;
end;

procedure TDM.Qr_ColaboradorAfterOpen(DataSet: TDataSet);
begin
   Qr_Colaborador.FetchAll;
end;

procedure TDM.Qr_CartaoAfterOpen(DataSet: TDataSet);
begin
   Qr_Cartao.FetchAll;
end;

procedure TDM.Qr_SituacaoAfterOpen(DataSet: TDataSet);
begin
   Qr_Situacao.FetchAll;
end;

procedure TDM.Qr_PaisAfterOpen(DataSet: TDataSet);
begin
   Qr_Pais.FetchAll;
end;

procedure TDM.Qr_EstoquesAfterOpen(DataSet: TDataSet);
begin
   Qr_Estoques.FetchAll;
end;

procedure TDM.Qr_MarcaVeiculoAfterOpen(DataSet: TDataSet);
begin
  Qr_MarcaVeiculo.FetchAll;
end;

procedure TDM.Qr_Modal_FreteAfterOpen(DataSet: TDataSet);
begin
  Qr_Modal_Frete.FetchAll;
end;

procedure TDM.Qr_Filtra_CFOPAfterOpen(DataSet: TDataSet);
begin
  Qr_Filtra_CFOP.FetchAll;
end;

procedure TDM.Qr_ColorAfterOpen(DataSet: TDataSet);
begin
  Qr_Color.FetchAll;
end;

procedure TDM.Qr_CidadesAfterOpen(DataSet: TDataSet);
begin
  Qr_Cidades.FetchAll;
end;

procedure TDM.Qr_UFAfterOpen(DataSet: TDataSet);
begin
  QR_UF.FetchAll;
end;
                                                    
procedure TDM.Qr_Uf_Mva_NCMAfterOpen(DataSet: TDataSet);
begin
  Qr_Uf_Mva_NCM.FetchAll;
end;


procedure TDM.Qr_Carteira_CobrancaAfterOpen(DataSet: TDataSet);
begin
  Qr_Carteira_Cobranca.FetchAll;
end;

procedure TDM.Qr_NegocioAfterOpen(DataSet: TDataSet);
begin
  Qr_Negocio.FetchAll;
end;

procedure TDM.Qr_RevestimentoAfterOpen(DataSet: TDataSet);
begin
  Qr_Revestimento.FetchAll;
end;

procedure TDM.Qr_EmbalagemAfterOpen(DataSet: TDataSet);
begin
  Qr_Embalagem.FetchAll;
end;

procedure TDM.Qr_Especie_Doc_CobrancaAfterOpen(DataSet: TDataSet);
begin
  Qr_Especie_Doc_Cobranca.FetchAll;
end;

procedure TDM.Qr_CarteirasAfterOpen(DataSet: TDataSet);
begin
  Qr_Carteiras.FetchAll;
end;

end.

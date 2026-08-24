unit ControllerRetaguardaSync;

interface

uses     STDatabase, Classes, SysUtils, ControllerBase, tblRetaguardaSync, Generics.Collections, STQuery, ControllerSincronia, ControllerRetaguardareceive, ControllerRetaguardaSendToLocal;

Type
  TListaRetaguardaSync = TObjectList<TRetaguardaSync>;

  TControllerRetaguardaSync = Class(TControllerBase)
  private
    FSincronia : TControllerSincronia;
    FRetaguardareceive : TControllerRetaguardareceive;
    FBancoRetaguarda: TSTDatabase;
    FBancoPDV: TSTDatabase;

    procedure ReceiveUsuario;
    procedure ReceiveCargo;
    procedure ReceiveColaborador;
    procedure ReceiveEmpresa;
    procedure ReceiveFormapagto;
    procedure ReceiveGrupo;
    procedure ReceiveSubgrupo;
    procedure ReceiveMarcaproduto;
    procedure ReceiveMedida;
    procedure ReceiveEmbalagem;
    procedure ReceiveProduto;
    procedure ReceiveEstoques;
    procedure ReceiveEstoque;
    procedure ReceiveTabelaPreco;
    procedure ReceivePreco;

    function getTime: TDateTime;
    Function delete: boolean;

    procedure setFBancoRetaguarda(const Value: TSTDatabase);
    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure Inicializa;

    // Executa o loop de receive para uma tabela generica
    procedure DoReceive(const ATabela: String; AReceiveProc: TProc);

    // Grava o timestamp de sincronia de forma atomica e tolerante a
    // conflito de atualizacao concorrente
    procedure SalvaTempoSync;
  public
    Registro: TRetaguardaSync;
    Lista: TListaRetaguardaSync;
    SendtoLocal : TControllerRetaguardaSendToLocal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save: boolean;
    function insert: boolean;
    function update: boolean;
    procedure getById;
    procedure Receive;
    procedure Send;
    function getList: boolean;
    property BancoRetaguarda : TSTDatabase read FBancoRetaguarda write setFBancoRetaguarda;
    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;

implementation

{ TControllerEmpresa }

uses     un_sistema, Un_Regra_Negocio, ControllerRetaguarda;
constructor TControllerRetaguardaSync.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguardaSync.Create;
  FSincronia := TControllerSincronia.create(self);
  FRetaguardareceive := TControllerRetaguardareceive.create(self);
  SendtoLocal := TControllerRetaguardaSendToLocal.create(self);
  Lista := TListaRetaguardaSync.Create;
end;

function TControllerRetaguardaSync.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerRetaguardaSync.Destroy;
begin
  FBancoRetaguarda := nil;
  FBancoPDV := nil;
  FreeAndNil(FSincronia);
  FreeAndNil(FRetaguardareceive);
  FreeAndNil(Registro);
  FreeAndNil(SendtoLocal);
  FreeAndNil(Lista);
  inherited;
end;

function TControllerRetaguardaSync.save: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerRetaguardaSync.Send;
begin

end;

procedure TControllerRetaguardaSync.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

procedure TControllerRetaguardaSync.setFBancoRetaguarda(
  const Value: TSTDatabase);
begin
  FBancoRetaguarda := Value;
end;

function TControllerRetaguardaSync.update: boolean;
begin
  updateObj(Registro);
end;

procedure TControllerRetaguardaSync.getById;
begin
  _getByKey(Registro);
  if not exist then
  Begin
    Registro.Tempo := StrToDateTimeDef('01/01/2022 00:00:00',Now);
  End;
end;

function TControllerRetaguardaSync.getList: boolean;
begin
  // stub
end;

function TControllerRetaguardaSync.getTime: TDateTime;
Var
  Lc_Qry: TSTQuery;
begin
  Result := Now;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat('SELECT DT_UPDATE, TM_UPDATE ', 'FROM TB_RETAGUARDA_SYNC ',
        'WHERE ( ID=:ID ) ', 'AND ( WAY=:WAY )'));
      ParamByName('ID').AsString := Registro.Codigo;
      ParamByName('WAY').AsString := Registro.Sentido;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('DT_UPDATE').AsDateTime + FieldByName('TM_UPDATE').AsDateTime
      else
        Result := StrToDateTime('01/01/2016 00:00:01');
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetaguardaSync.Inicializa;
begin
  FRetaguardareceive.BancoRetaguarda  := Self.FBancoRetaguarda;
  FRetaguardareceive.BancoPDV         := Self.FBancoPDV;
end;

function TControllerRetaguardaSync.insert: boolean;
begin
  insertObj(Registro);
end;

// Grava a linha de controle (ID, WAY, SYN_TIME) em um unico comando
// UPDATE OR INSERT, dentro de uma transacao curta e exclusiva.
// Evita a janela SELECT->UPDATE do SaveObj e, em caso de
// "update conflicts with concurrent update" (outro processo/terminal
// gravando a mesma linha), tenta novamente em vez de abortar a sincronia.
procedure TControllerRetaguardaSync.SalvaTempoSync;
Const
  MAX_TENTATIVAS = 3;
Var
  Lc_Qry: TSTQuery;
  LcTentativa: Integer;
begin
  for LcTentativa := 1 to MAX_TENTATIVAS do
  begin
    Lc_Qry := GeraQuery;
    Try
      try
        with Lc_Qry do
        Begin
          sql.Add(concat('UPDATE OR INSERT INTO TB_RETAGUARDA_SYNC (ID, SYN_TIME, WAY) ',
                         'VALUES (:ID, :SYN_TIME, :WAY) ',
                         'MATCHING (ID, WAY)'));
          ParamByName('ID').AsString := Registro.Codigo;
          ParamByName('SYN_TIME').AsDateTime := Registro.Tempo;
          ParamByName('WAY').AsString := Registro.Sentido;
          ExecSQL;
        End;
        Exit;
      except
        on E: Exception do
          if LcTentativa = MAX_TENTATIVAS then
            geralog('RetaguardaSync - SalvaTempoSync - ', E.Message);
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
    TThread.Sleep(200 * LcTentativa);
  end;
end;

// Centraliza a logica repetida nos 15 metodos ReceiveXxx.
// Busca registros novos da tabela ATabela no servidor, aplica via AReceiveProc
// e grava o timestamp uma unica vez ao final (em vez de por registro).
procedure TControllerRetaguardaSync.DoReceive(const ATabela: String; AReceiveProc: TProc);
var
  I: Integer;
  LUltimoTempo: TDateTime;
begin
  self.Registro.Codigo := ATabela;
  self.Registro.Sentido := 'R';
  self.getById;

  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela := self.Registro.Codigo;
  FSincronia.Registro.Tempo := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;

  if FSincronia.Lista.Count = 0 then
    Exit;

  LUltimoTempo := self.Registro.Tempo;
  for I := 0 to FSincronia.Lista.Count - 1 do
  begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    AReceiveProc();
    if FSincronia.Lista[I].Tempo > LUltimoTempo then
      LUltimoTempo := FSincronia.Lista[I].Tempo;
  end;

  // Salva o timestamp uma unica vez, com o valor mais recente
  self.Registro.Tempo := LUltimoTempo;
  SalvaTempoSync;
end;

procedure TControllerRetaguardaSync.Receive;
begin
  Inicializa;
  ReceiveUsuario;
  ReceiveCargo;
  ReceiveColaborador;
  ReceiveEmpresa;
  ReceiveFormapagto;
  ReceiveGrupo;
  ReceiveSubgrupo;
  ReceiveMarcaproduto;
  ReceiveMedida;
  ReceiveEmbalagem;
  ReceiveProduto;
  ReceiveEstoques;
  ReceiveEstoque;
  ReceiveTabelaPreco;
  ReceivePreco;
end;

procedure TControllerRetaguardaSync.ReceiveCargo;
begin
  DoReceive('TB_CARGO', procedure begin FRetaguardareceive.cargo; end);
end;

procedure TControllerRetaguardaSync.ReceiveColaborador;
begin
  DoReceive('TB_COLABORADOR', procedure begin FRetaguardareceive.Colaborador; end);
end;

procedure TControllerRetaguardaSync.ReceiveEmbalagem;
begin
  DoReceive('TB_EMBALAGEM', procedure begin FRetaguardareceive.embalagem; end);
end;

procedure TControllerRetaguardaSync.ReceiveEmpresa;
begin
  DoReceive('TB_EMPRESA', procedure begin FRetaguardareceive.empresa; end);
end;

procedure TControllerRetaguardaSync.ReceiveEstoque;
begin
  DoReceive('TB_ESTOQUE', procedure begin FRetaguardareceive.estoque; end);
end;

procedure TControllerRetaguardaSync.ReceiveEstoques;
begin
  DoReceive('TB_ESTOQUES', procedure begin FRetaguardareceive.estoques; end);
end;

procedure TControllerRetaguardaSync.ReceiveFormapagto;
begin
  DoReceive('TB_FORMAPAGTO', procedure begin FRetaguardareceive.formapagto; end);
end;

procedure TControllerRetaguardaSync.ReceiveGrupo;
begin
  DoReceive('TB_GRUPOS', procedure begin FRetaguardareceive.grupo; end);
end;

procedure TControllerRetaguardaSync.ReceiveMarcaproduto;
begin
  DoReceive('TB_MARCA_PRODUTO', procedure begin FRetaguardareceive.marcaproduto; end);
end;

procedure TControllerRetaguardaSync.ReceiveMedida;
begin
  DoReceive('TB_MEDIDA', procedure begin FRetaguardareceive.Medida; end);
end;

procedure TControllerRetaguardaSync.ReceivePreco;
begin
  DoReceive('TB_PRECO', procedure begin FRetaguardareceive.preco; end);
end;

procedure TControllerRetaguardaSync.ReceiveProduto;
var
  LUltimoTempo : TDateTime;
  I: Integer;
begin
  // TB_PRODUTO: getById usa FBancoPDV (nao FBancoRetaguarda) para a ultima sincronia
  FSincronia.DataBase := FBancoPDV;
  self.Registro.Codigo := 'TB_PRODUTO';
  self.Registro.Sentido := 'R';
  self.getById;

  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela := self.Registro.Codigo;
  FSincronia.Registro.Tempo := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;

  if FSincronia.Lista.Count = 0 then
    Exit;

  LUltimoTempo := self.Registro.Tempo;
  for I := 0 to FSincronia.Lista.Count - 1 do
  begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.produto;
    if FSincronia.Lista[I].Tempo > LUltimoTempo then
      LUltimoTempo := FSincronia.Lista[I].Tempo;
  end;
  self.Registro.Tempo := LUltimoTempo;
  SalvaTempoSync;
end;

procedure TControllerRetaguardaSync.ReceiveSubgrupo;
begin
  DoReceive('TB_SUBGRUPOS', procedure begin FRetaguardareceive.subgrupo; end);
end;

procedure TControllerRetaguardaSync.ReceiveTabelaPreco;
begin
  DoReceive('TB_TABELA_PRECO', procedure begin FRetaguardareceive.tabela_preco; end);
end;

procedure TControllerRetaguardaSync.ReceiveUsuario;
begin
  DoReceive('TB_USUARIO', procedure begin FRetaguardareceive.usuario; end);
end;

end.
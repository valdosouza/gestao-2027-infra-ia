unit ControllerTributacao;

interface
uses     STDatabase, System.Classes, Vcl.Grids, STQuery, System.SysUtils, ControllerBase, tblTributacao, System.Generics.Collections, prm_taxation, System.StrUtils;

Type
  TListaTributacao = TObjectList<TTributacao>;

  TControllerTributacao = Class(TControllerBase)

  private
    FParametros: TPrmTaxation;
    procedure setFParametros(const Value: TPrmTaxation);
    procedure AplicaReformaTributariaUnica;
    procedure AplicaReformaTributariaParcial;
    procedure AplicaReformaTributariaTotal;
  public
    Registro : TTributacao;
    Lista : TListaTributacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function insert:boolean;
    function salva:boolean;
    function migra:Boolean;
    procedure AplicaReformaTributaria(RegraId, ReformaId:Integer;Abrangencia:String);
    procedure getList;
    procedure Clear;
    Function delete:boolean;
    Function VerificaRegraExistente:Boolean;
    property Parametros : TPrmTaxation read FParametros write setFParametros;
    procedure search;

  End;


implementation

{ TControllerTributacao }

uses     Un_Regra_Negocio, ENV;
procedure TControllerTributacao.AplicaReformaTributaria(RegraId, ReformaId: Integer;
  Abrangencia: String);
Begin
  Registro.Codigo      := RegraId;
  Registro.CodigoTaxas := ReformaId;

  case AnsiIndexText(Abrangencia, ['UNICA', 'PARCIAL', 'TOTAL']) of
    0: AplicaReformaTributariaUnica;
    1: AplicaReformaTributariaParcial;
    2: AplicaReformaTributariaTotal;
  end;
end;

procedure TControllerTributacao.AplicaReformaTributariaParcial;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'UPDATE TB_TRIBUTACAO SET ',
              'TB_TAXES_ID =:TB_TAXES_ID ',
              'WHERE (TB_TAXES_ID is null) or (TB_TAXES_ID = 0)  '
      ));
      ParamByName('TB_TAXES_ID').AsInteger := Registro.CodigoTaxas;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerTributacao.AplicaReformaTributariaTotal;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'UPDATE TB_TRIBUTACAO SET ',
              'TB_TAXES_ID =:TB_TAXES_ID '
      ));
      ParamByName('TB_TAXES_ID').AsInteger := Registro.CodigoTaxas;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTributacao.AplicaReformaTributariaUnica;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'UPDATE TB_TRIBUTACAO SET ',
              'TB_TAXES_ID =:TB_TAXES_ID ',
              'WHERE TRB_CODIGO =:TRB_CODIGO '
      ));
      ParamByName('TB_TAXES_ID').AsInteger := Registro.CodigoTaxas;
      ParamByName('TRB_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerTributacao.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerTributacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTributacao.Create;
  Lista := TListaTributacao.Create;
  FParametros := TPrmTaxation.Create;
end;

function TControllerTributacao.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTributacao.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;

procedure TControllerTributacao.getById;
begin
  _getbykey(Registro);
end;

procedure TControllerTributacao.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TTributacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TRIBUTACAO ',
                      'WHERE TRB_CODIGO IS NOT NULL '
                    ));
      //Incremento SQL
      if Registro.Produto >0 then
        sql.add(' AND TRB_CODPRO =:TRB_CODPRO');
      //Passsagem de Parametros
      if Registro.Produto >0 then
        ParamByName('TRB_CODPRO').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TTributacao.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerTributacao.insert: boolean;
begin
  TRy
    Registro.Codigo := Generator('GN_TRIBUTACAO');
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

function TControllerTributacao.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerTributacao.salva: boolean;
begin
  TRy
    if Registro.codigo = 0 then
      Registro.Codigo := Generator('GN_TRIBUTACAO');
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

procedure TControllerTributacao.setFParametros(const Value: TPrmTaxation);
begin
  FParametros := Value;
end;

function TControllerTributacao.VerificaRegraExistente: Boolean;
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select TRB_CODIGO ' +
              'from tb_tributacao '+
              'where (TRB_CODIGO <>:TRB_CODIGO) AND '+
              'TRB_CODPRO =:TRB_CODPRO AND '+
              'TRB_ORIGEM =:TRB_ORIGEM AND '+
              'TRB_CODTBI_ICMS_NR =:TRB_CODTBI_ICMS_NR AND '+
              'TRB_CODTBI_ICMS_SN =:TRB_CODTBI_ICMS_SN AND '+
              'TRB_CODMDB_ICMS_NR =:TRB_CODMDB_ICMS_NR AND '+
              'TRB_CODMDB_ICMS_ST =:TRB_CODMDB_ICMS_ST AND '+
              'TRB_CODDSI_ICMS =:TRB_CODDSI_ICMS AND '+
              'TRB_AQ_ICMS =:TRB_AQ_ICMS AND '+
              'TRB_RD_AQ_ICMS =:TRB_RD_AQ_ICMS AND '+
              'TRB_RD_BS_ICMS =:TRB_RD_BS_ICMS AND '+
              'TRB_CODTBI_IPI =:TRB_CODTBI_IPI AND '+
              'TRB_AQ_IPI =:TRB_AQ_IPI AND '+
              'TRB_CODTBI_PIS =:TRB_CODTBI_PIS AND '+
              'TRB_AQ_PIS =:TRB_AQ_PIS AND '+
              'TRB_CODTBI_CFS =:TRB_CODTBI_CFS AND '+
              'TRB_AQ_COFINS =:TRB_AQ_COFINS AND '+
              'TRB_AQ_IRPJ =:TRB_AQ_IRPJ AND '+
              'TRB_AQ_CSLL =:TRB_AQ_CSLL AND '+
              'TRB_AQ_SISCOMEX =:TRB_AQ_SISCOMEX AND '+
              'TRB_AQ_II =:TRB_AQ_II AND '+
              'TRB_ST_ICMS =:TRB_ST_ICMS AND '+
              'TRB_CONSUMIDOR =:TRB_CONSUMIDOR AND '+
              'TRB_MICRO =:TRB_MICRO AND '+
              'TRB_DIFERIDO =:TRB_DIFERIDO AND '+
              'TRB_DESTAQUE =:TRB_DESTAQUE AND '+
              'TRB_CODOBS =:TRB_CODOBS AND '+
              'TRB_CODNAT =:TRB_CODNAT AND '+
              'TRB_ESTADO =:TRB_ESTADO AND '+
              'TRB_CODMHA =:TRB_CODMHA AND '+
              'TRB_SUB_TRI =:TRB_SUB_TRI AND '+
              'TRB_CODIGONCM =:TRB_CODIGONCM AND '+
              'TRB_PRODUTO =:TRB_PRODUTO and '+
              'TRB_CODEMP =:TRB_CODEMP ');
      //Passagem de Parametros
      ParamByName('TRB_CODIGO').AsInteger := FParametros.FieldName.Codigo;

      ParamByName('TRB_CODPRO').AsInteger := FParametros.FieldName.Produto;
      //ParamByName('TRB_CODEMP').AsInteger := taxation.Registro.Empresa; //nao utilizado

      ParamByName('TRB_ORIGEM').AsString := FParametros.FieldName.Origem;

      if FParametros.FieldName.TribICMS_NR > 0 then
        ParamByName('TRB_CODTBI_ICMS_NR').AsInteger := FParametros.FieldName.TribICMS_NR;

      if FParametros.FieldName.TribICMS_SN > 0 then
        ParamByName('TRB_CODTBI_ICMS_SN').AsInteger := FParametros.FieldName.TribICMS_SN;

      if FParametros.FieldName.DeterBC_ICMS_NR > 0 then
        ParamByName('TRB_CODMDB_ICMS_NR').AsInteger := FParametros.FieldName.DeterBC_ICMS_NR;

      if FParametros.FieldName.DeterBC_ICMS_ST > 0 then
        ParamByName('TRB_CODMDB_ICMS_ST').AsInteger := FParametros.FieldName.DeterBC_ICMS_ST;

      if FParametros.FieldName.Desoneracao > 0 then
        ParamByName('TRB_CODDSI_ICMS').AsInteger := FParametros.FieldName.Desoneracao;

      ParamByName('TRB_AQ_ICMS').AsCurrency := FParametros.FieldName.AliqICMS;
      ParamByName('TRB_RD_AQ_ICMS').AsCurrency := FParametros.FieldName.RedAliqICMS;
      ParamByName('TRB_RD_BS_ICMS').AsCurrency := FParametros.FieldName.RedBCICMS;

      if FParametros.FieldName.TribIPI > 0 then
        ParamByName('TRB_CODTBI_IPI').AsInteger := FParametros.FieldName.TribIPI;

      ParamByName('TRB_AQ_IPI').AsCurrency := FParametros.FieldName.AliqIPI;

      if FParametros.FieldName.TribPIS > 0 then
        ParamByName('TRB_CODTBI_PIS').AsInteger := FParametros.FieldName.TribPIS;

      ParamByName('TRB_AQ_PIS').AsCurrency := FParametros.FieldName.AliqPIS;

      if FParametros.FieldName.TribCofins > 0 then
        ParamByName('TRB_CODTBI_CFS').AsInteger := FParametros.FieldName.TribCofins;

      ParamByName('TRB_AQ_COFINS').AsCurrency := FParametros.FieldName.AliqCofins;

      ParamByName('TRB_AQ_IRPJ').AsFloat := FParametros.FieldName.AliqIRPJ;
      ParamByName('TRB_AQ_CSLL').AsFloat := FParametros.FieldName.AliqCSLL;
      ParamByName('TRB_AQ_SISCOMEX').AsFloat := FParametros.FieldName.AliqSisComex;
      ParamByName('TRB_AQ_II').AsFloat := FParametros.FieldName.AliqII;
      ParamByName('TRB_ST_ICMS').AsString := FParametros.FieldName.TemST;

      ParamByName('TRB_CONSUMIDOR').AsString := FParametros.FieldName.Consumidor;
      ParamByName('TRB_MICRO').AsString := FParametros.FieldName.MicroEmpresa;
      ParamByName('TRB_DIFERIDO').AsString := FParametros.FieldName.Diferido;
      ParamByName('TRB_DESTAQUE').AsString := FParametros.FieldName.Destacar;
      ParamByName('TRB_SUB_TRI').AsString := FParametros.FieldName.SubstitutoTributario;
      ParamByName('TRB_PRODUTO').AsString := FParametros.FieldName.TipoTransacaoProduto;
      ParamByName('TRB_CODOBS').AsInteger := FParametros.FieldName.Observacao;
      ParamByName('TRB_CODNAT').AsInteger := FParametros.FieldName.CFOP;
      ParamByName('TRB_ESTADO').AsInteger := FParametros.FieldName.Estado;
      ParamByName('TRB_CODIGONCM').AsString := FParametros.FieldName.NCM;
      ParamByName('TRB_CODMHA').AsInteger := FParametros.FieldName.Estabelecimento;
      Active := True;
      FetchAll;
      Result := (RecordCount>0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerTributacao.search;
var
  Lc_Qry : TSTQuery;
  LITem : TTributacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        ' SELECT TRI.*, NAT_CFOP, UFE_SIGLA, ICMS_NR.TBI_GRUPO TRB_CST, ICMS_SN.TBI_GRUPO TRB_CSOSN, OBS.OBS_DESCRICAO, TRI.TB_TAXES_ID  '+
        '   FROM TB_TRIBUTACAO TRI '+
        '   JOIN TB_NATUREZA ON (NAT_CODIGO = TRB_CODNAT) '+
        '   LEFT OUTER JOIN TB_OBSERVACAO OBS ON (OBS.OBS_CODIGO = TRI.TRB_CODOBS) '+
        '   LEFT OUTER JOIN TB_UF UF ON (UF.UFE_CODIGO = TRI.TRB_ESTADO) '+
        '   LEFT OUTER JOIN TB_TRIB_ICMS_NR ICMS_NR ON (ICMS_NR.TBI_CODIGO =TRB_CODTBI_ICMS_NR) '+
        '   LEFT OUTER JOIN TB_TRIB_ICMS_SN ICMS_SN ON (ICMS_SN.TBI_CODIGO =TRB_CODTBI_ICMS_SN) '+
        '  WHERE TRB_CODIGO IS NOT NULL ';

      if FParametros.FieldName.Empresa > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODEMP = :TRB_CODEMP ';
        ParamByName('TRB_CODEMP').AsInteger := FParametros.FieldName.Empresa;
      end;

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODIGO = :TRB_CODIGO';
        ParamByName('TRB_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Estabelecimento > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODMHA = :TRB_CODMHA';
        ParamByName('TRB_CODMHA').AsInteger := FParametros.FieldName.Estabelecimento;
      end;

      if FParametros.FieldName.NCM <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODIGONCM LIKE :TRB_CODIGONCM';
        ParamByName('TRB_CODIGONCM').AsString := Concat('%',FParametros.FieldName.NCM,'%');
      end;

      if FParametros.FieldName.SentidoCFOP = 'S' then
        SQL.Text := SQL.Text + 'AND (NAT_SENTIDO = ''S'') '
      else
        SQL.Text := SQL.Text + 'AND (NAT_SENTIDO = ''E'') ';

      SQL.Text := SQL.Text + ' AND (TRB_CODPRO = :TRB_CODPRO) ';
      ParamByName('TRB_CODPRO').AsInteger := FParametros.FieldName.Produto;

      if FParametros.FieldName.Estado > 0 then
      begin
        SQL.Text := SQL.Text + 'AND (TRB_ESTADO = :TRB_ESTADO) ';
        ParamByName('TRB_ESTADO').AsInteger := FParametros.FieldName.Estado
      end;

      if FParametros.FieldName.CFOP > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODNAT = :TRB_CODNAT ';
        ParamByName('TRB_CODNAT').AsInteger := FParametros.FieldName.CFOP
      end;

      if FParametros.FieldName.Consumidor = SIGLA_S then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CONSUMIDOR = :TRB_CONSUMIDOR';
        ParamByName('TRB_CONSUMIDOR').AsString := FParametros.FieldName.Consumidor;
      end;

      SQL.Text := SQL.Text + ' ORDER BY TRB_ESTADO, TRB_CONSUMIDOR, TRB_CODNAT ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTributacao.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        LITem.NAT_CFOP := Lc_Qry.FieldByName('NAT_CFOP').AsString;
        LITem.UFE_SIGLA := Lc_Qry.FieldByName('UFE_SIGLA').AsString;
        LITem.TRB_CST := Lc_Qry.FieldByName('TRB_CST').AsString;
        LITem.TRB_CSOSN := Lc_Qry.FieldByName('TRB_CSOSN').AsString;
        LITem.OBS_DESCRICAO := Lc_Qry.FieldByName('OBS_DESCRICAO').AsString;

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

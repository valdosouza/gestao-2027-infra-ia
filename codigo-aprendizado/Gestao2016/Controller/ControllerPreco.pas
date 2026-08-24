unit ControllerPreco;

interface

uses     STDatabase, Classes, Vcl.Grids, STQuery, SysUtils, ControllerBase, tblPreco, Un_MSg, Generics.Collections, prm_price, un_funcoes;

Type
  TListaPreco = TObjectList<TPreco>;

  TControllerPreco = Class(TControllerBase)

  private
    TipoCalculoPreco : String;
    FParametros: TPrmPrice;
    procedure setFParametros(const Value: TPrmPrice);

  public
    Registro : TPreco;
    Lista : TListaPreco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure DefineTipoCalculoPreco;
    function salva:boolean;
    function replace:Boolean;
    function migra:Boolean;
    function Insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteByID:boolean;
    Function deleteByTabela:boolean;
    procedure getbyId;
    Function getIdByTabelaProduto:Integer;
    procedure getByTabelaProduto;
    procedure getByCodigo;
    procedure getList;
    function CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,Fc_Aq_Margem:real):Real;
    procedure clear;
    procedure CopiaTabela(Cod_Prod_novo,Cod_Prod_Ant:Integer);
    procedure Search;
    property Parametros : TPrmPrice read FParametros write setFParametros;
  End;

implementation

uses     UN_Sistema, Un_Regra_Negocio;
function TControllerPreco.CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,  Fc_Aq_Margem: real): Real;
begin
  Result := 0;
  If (Fc_Vl_Custo > 0) then
  Begin
    if (TipoCalculoPreco = '1') then
    Begin
      //Preço de Custo / [( 100 - Taxa de Lucro ) / 100 ]
      Result := Fc_Vl_Custo / (( 100 - Fc_Aq_Margem) /100);
    end
    else
    Begin
      //Preço de Custo + (Preço de Custo * Taxa de Lucro)
      Result := Fc_Vl_Custo + (Fc_Vl_Custo * (Fc_Aq_Margem/100));
    end;
  end;
end;

procedure TControllerPreco.clear;
begin
  ClearObj(Registro);
end;

procedure TControllerPreco.CopiaTabela(Cod_Prod_novo, Cod_Prod_Ant: Integer);
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT PRC_CODTPR ,PRC_VL_VDA , PRC_AQ_COM,PRC_QT_MIN, PRC_MAR_LRC ');
    Lc_Qry.SQL.Add('FROM TB_PRECO ');
    Lc_Qry.SQL.Add('WHERE PRC_CODPRO =:PRC_CODPRO ');
    Lc_Qry.ParamByName('PRC_CODPRO').AsInteger:= Cod_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      registro.Codigo         := Fc_Generator('GN_PRECO','TB_PRECO','PRC_CODIGO');
      registro.CodigoTabela   := Lc_Qry.fieldbyname('PRC_CODTPR').AsInteger;
      registro.CodigoProduto  := Cod_Prod_novo;
      registro.Valor          := Lc_Qry.fieldbyname('prc_vl_vda').AsCurrency;
      registro.Alicomissao    := Lc_Qry.fieldbyname('prc_aq_com').AsFloat;
      registro.QtdeMinima     := Lc_Qry.fieldbyname('prc_qt_min').AsFloat;
      registro.MargemLucro    := Lc_Qry.fieldbyname('prc_mar_lrc').AsFloat;
      insertObj(Registro);
      Lc_Qry.Next;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

constructor TControllerPreco.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPreco.Create;
  Lista := TListaPreco.Create;
  FParametros := TPrmPrice.Create;
end;


procedure TControllerPreco.DefineTipoCalculoPreco;
begin
  TipoCalculoPreco := Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','1');
end;

destructor TControllerPreco.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;


function TControllerPreco.salva: boolean;
begin
  Result := True;
  Try
    Registro.Codigo := getIdByTabelaProduto;
    if Registro.Codigo = 0 then
    Begin
      Registro.Codigo := Generator('GN_PRECO');
      insertObj(Registro);
    End
    else
    Begin
      updateObj(Registro);
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPreco.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  end;
end;


function TControllerPreco.Insert: boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    try
      with Lc_Qry do
      Begin
        SQL.Clear;
        SQL.Add (concat(
                  'SELECT PRC_CODIGO ',
                  'FROM TB_PRECO ',
                  'WHERE PRC_CODTPR =:PRC_CODTPR ',
                  ' AND PRC_CODPRO=:PRC_CODPRO'
        ));
        ParamByName('PRC_CODTPR').AsInteger := Registro.CodigoTabela;
        ParamByName('PRC_CODPRO').AsInteger := Registro.CodigoProduto;
        Active := True;
        FetchAll;
        If ( RecordCount > 0 ) then
        Begin
          Registro.Codigo := fieldByName('PRC_CODIGO').AsInteger;
          UpdateObj(Registro);
        End
        else
        Begin
          if Registro.Codigo = 0 then
            Registro.Codigo := Generator('GN_PRECO');
          InsertObj(Registro);
        End;
      End;
    Except on E: Exception do
      geralog('Base - existObj - ',E.Message);
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


function TControllerPreco.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerPreco.replace: Boolean;
begin
  Result := True;
  Try
    Registro.Codigo := getIdByTabelaProduto;
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRECO');
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerPreco.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerPreco.deleteByID: boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('DELETE  '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODIGO=:PRC_CODIGO )');
      ParamByName('PRC_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerPreco.deleteByTabela: boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('DELETE  '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODTPR=:PRC_CODTPR )');
      ParamByName('PRC_CODTPR').AsInteger := Registro.CodigoTabela;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerPreco.getById;
begin
  _getByKey(Registro);
end;

Function TControllerPreco.getIdByTabelaProduto:Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT PRC_CODIGO '+
              'FROM TB_Preco '+
              '  inner join tb_tabela_preco '+
              '  on (prc_codtpr = tpr_codigo) '+
              '  inner join tb_produto '+
              '  on (pro_codigo = prc_codpro) '+
              'WHERE ( PRC_CODTPR=:TPR_CODIGO ) AND ( PRC_CODPRO =:PRO_CODIGO )');
      ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
        Result := FieldByName('PRC_CODIGO').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerPreco.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TPreco;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_PRECO where (PRC_CODIGO > 0 ) ');
      if Registro.CodigoProduto > 0 then
        sql.add(' AND (PRC_CODPRO=:PRO_CODIGO) ');
      if Registro.CodigoTabela > 0 then
        sql.add(' AND (PRC_CODTPR=:TPR_CODIGO) ');

      sql.add(' ORDER BY PRC_CODTPR, prc_codpro ');
      //Passagem de Parametro
      if Registro.CodigoProduto > 0 then
        ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      if Registro.CodigoTabela > 0 then
        ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TPreco.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPreco.getByTabelaProduto;
VAr
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODTPR=:TPR_CODIGO ) AND ( PRC_CODPRO =:PRO_CODIGO )');
      ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


procedure TControllerPreco.getByCodigo;
VAr
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODIGO=:PRC_CODIGO )');
      ParamByName('PRC_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerPreco.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TPreco;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        ' SELECT * FROM TB_PRECO WHERE 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PRC_CODIGO = :PRC_CODIGO';
        ParamByName('PRC_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.CodigoTabela > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PRC_CODTPR = :PRC_CODTPR';
        ParamByName('PRC_CODTPR').AsInteger := FParametros.FieldName.CodigoTabela;
      end;

      if FParametros.FieldName.CodigoProduto > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PRC_CODPRO = :PRC_CODPRO';
        ParamByName('PRC_CODPRO').AsInteger := FParametros.FieldName.CodigoProduto;
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TPreco.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPreco.setFParametros(const Value: TPrmPrice);
begin
  FParametros := Value;
end;

end.

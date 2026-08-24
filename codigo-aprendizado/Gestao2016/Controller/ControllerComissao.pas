unit ControllerComissao;

interface

uses     STDatabase, STQuery, Classes, SysUtils, ControllerBase, tblComissao, Md5, prm_comissao;

Type
  TControllerComissao = Class(TControllerBase)
  private
    FParametros: TPrmComissao;
    procedure setFParametros(const Value: TPrmComissao);
  public
    Registro : TComissao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    procedure atualizaVendedorPedido;
    function insert:boolean;
    Function delete:boolean;
    procedure deleteByFinanceiro;
    function getById:Boolean;
    procedure pagar;
    procedure CorrigeDuplicados;
    property Parametros : TPrmComissao read FParametros write setFParametros;
  End;

  implementation
{ ControllerComissao}

procedure TControllerComissao.atualizaVendedorPedido;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add('UPDATE TB_PEDIDO SET '+
              'PED_CODVDO =:PED_CODVDO '+
              'WHERE PED_CODIGO =:PED_CODIGO');
      ParamByName('PED_CODVDO').AsInteger := Registro.Vendedor;
      ParamByName('PED_CODIGO').AsInteger := Registro.Pedido;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerComissao.CorrigeDuplicados;
Var
  Lc_Qry : TSTQuery;
  Lc_pedido,Lc_Empresa,Lc_Vendedor : Integer;
  Lc_Data : TDateTime;
  Lc_Valor: Real;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.add(concat('SELECT * ' ,
                     'FROM TB_COMISSAO c ' ,
                     'WHERE (COM_CODMHA =:COM_CODMHA) ',
                     ' AND (COM_DT_PAGTO IS NULL) '
      ));


      if FParametros.Periodo then
      Begin
        SQL.add(' AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM ');
        ParamByName('DATAINICIO').AsDate  := FParametros.DataInicial;
        ParamByName('DATAFIM').AsDate     := FParametros.DataFinal
      End;

      if FParametros.FieldName.Vendedor > 0 then
      Begin
        SQL.add(' AND (COM_CODVDO =:COM_CODVDO) ');
        ParamByName('COM_CODVDO').AsInteger := FParametros.FieldName.Vendedor;
      End;

      SQL.Add(' ORDER BY COM_CODPED, COM_DT_VENDA, COM_CODEMP, COM_CODVDO, COM_VL_DOC ');
      ParamByName('COM_CODMHA').AsInteger := FParametros.Estabelecimento;
      Active := True;
      if RecordCount > 0 then
      Begin


        repeat
          Lc_pedido   := fieldByName('COM_CODPED').asInteger;
          Lc_Empresa  := fieldByName('COM_CODEMP').asInteger;
          Lc_Vendedor := fieldByName('COM_CODVDO').asInteger;
          Lc_Data     := fieldByName('COM_DT_VENDA').AsDateTime;
          Lc_Valor    := fieldByName('COM_VL_DOC').AsCurrency;

          Next;

          repeat
            if  ( Lc_pedido   = fieldByName('COM_CODPED').asInteger) and
                ( Lc_Empresa = fieldByName('COM_CODEMP').asInteger) and
                ( Lc_Vendedor = fieldByName('COM_CODVDO').asInteger) and
                ( Lc_Data     = fieldByName('COM_DT_VENDA').AsDateTime) and
                ( Lc_Valor    = fieldByName('COM_VL_DOC').AsCurrency) then
            Begin
              Registro.Codigo := fieldByName('COM_CODIGO').asInteger;
              deleteObj(Registro);
            End;

            Next;
          until (Lc_pedido <> fieldByName('COM_CODPED').asInteger) or eof;

        until eof;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

constructor TControllerComissao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TComissao.Create;
  FParametros := TPrmComissao.create;
end;

function TControllerComissao.delete: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                ' delete from tb_comissao',
                ' where  com_codigo is not null '
              ));

      if (Registro.Codigo > 0) then
        SQL.Add(' AND ( COM_CODIGO =:COM_CODIGO ) ');

      if (Registro.Estabelecimento > 0) then
        SQL.Add(' AND ( COM_CODMHA =:COM_CODMHA ) ');

      if (Registro.Pedido > 0) then
        SQL.Add(' AND ( COM_CODPED =:COM_CODPED ) ');

      if (Registro.Financeiro > 0) then
        SQL.Add(' AND ( COM_CODFIN =:COM_CODFIN ) ');

      if (Registro.Codigo > 0) then
        ParamByName('COM_CODIGO').AsInteger:= Registro.Codigo;

      if (Registro.Estabelecimento > 0) then
        ParamByName('COM_CODMHA').AsInteger:= Registro.Estabelecimento;

      if (Registro.Pedido > 0) then
        ParamByName('COM_CODPED').AsInteger:= Registro.Pedido;

      if (Registro.Financeiro > 0) then
        ParamByName('COM_CODFIN').AsInteger:= Registro.Financeiro;

      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerComissao.deleteByFinanceiro;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'DELETE FROM TB_COMISSAO  ',
                'WHERE ( COM_CODPED =:COM_CODPED) ',
                ' AND ( COM_CODFIN =:COM_CODFIN) '

      ));
      ParamByName('COM_CODPED').AsInteger := FParametros.FieldName.Pedido;
      ParamByName('COM_CODFIN').AsInteger := FParametros.FieldName.Financeiro;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

destructor TControllerComissao.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerComissao.insert: boolean;
begin
  Result := True;
  try
    if Registro.Codigo = 0 then
       Registro.Codigo := Generator('GN_COMISSAO');
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerComissao.pagar;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_COMISSAO SET ',
                ' COM_DT_PAGTO = :COM_DT_PAGTO ',
                'WHERE ( COM_DT_PAGTO IS NULL) ',
                ' AND (COM_CODVDO=:COM_CODVDO) ',
                ' AND COM_DT_VENDA BETWEEN :DATAINICIO AND :DATAFIM '
      ));
      ParamByName('COM_CODVDO').AsInteger := FParametros.FieldName.Vendedor;
      ParamByName('COM_DT_PAGTO').AsDate := Date;
      ParamByName('DATAINICIO').AsDate :=  FParametros.DataInicial;
      ParamByName('DATAFIM').Asdate := FParametros.DataFinal;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerComissao.save: boolean;
begin
  Result := True;
  try
    if Registro.Codigo = 0 then
       Registro.Codigo := Generator('GN_COMISSAO');
    SaveObj(Registro);
  except
    Result := False;
  end;
end;


procedure TControllerComissao.setFParametros(const Value: TPrmComissao);
begin
  FParametros := Value;
end;

function TControllerComissao.getById: Boolean;
begin
  Result := True;
  _getByKey(Registro);
end;

end.

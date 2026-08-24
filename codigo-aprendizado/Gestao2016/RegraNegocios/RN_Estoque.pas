unit RN_Estoque;

interface

uses
      STDatabase, STQuery, SysUtils, ControllerCtrlEstoque, Vcl.Forms;
//------------------------- Controle de Estoque Especifico---------------------------------------
  procedure Pc_Grava_EstoqueDiaAnterior(Pc_Cd_Estoque:Integer;
                                        Pc_Cd_Produto:Integer;
                                        Pc_Data:TDate;
                                        Pc_Qtde:Real);

  procedure Pc_CriaRegistroEstoque(Pc_Cd_Produto: Integer);


  function  Fc_SaldoEstoque(Fc_Cd_Produto,Fc_Cd_Estoque:Integer ):Real;
  function  Fc_SaldoAnteriorEstoque(Fc_Cd_Produto,Fc_Cd_Estoque:Integer; Fc_Data:TDate):Real;

  {
  procedure Pc_Registra_Estoque(Pc_Vinculo : String;
                                Pc_Cd_Controle:Integer;
                                Pc_Cd_Item_Ctrl:Integer;
                                Pc_Cd_Estoques:Integer;
                                Pc_OPERACAO:String;
                                Pc_Cd_Produto:Integer;
                                Pc_QTDE : Real;
                                Pc_DATA: Tdate);
  }
  procedure Pc_Registra_EstoqueBcoDestino(FcDataBase : TSTDatabase;
                                        Pc_Vinculo : String;
                                        Pc_Cd_Controle:Integer;
                                        Pc_Cd_Item_Ctrl:Integer;
                                        Pc_Cd_Estoques:Integer;
                                        Pc_OPERACAO:String;
                                        Pc_Cd_Produto:Integer;
                                        Pc_QTDE : Real;
                                        Pc_DATA: Tdate);
                                        
  procedure Pc_Delete_Estoque(Pc_Vinculo : String;
                              Pc_Cd_Controle :Integer;
                              Pc_Cd_Item_Ctrl:Integer);
  Function Fc_Contagem_Estoque(Pc_Cd_Produto:Integer;
                               Pc_Cd_Estoque:Integer;
                               Pc_Dt_Ini:Tdate;
                               Pc_Dt_Fim:Tdate):Real;
  Function Fc_BuscaCodigoEstoqueProduto(Fc_cd_Estoque,Fc_Cd_Produto:Integer):String;

  Function Fc_AuditoriaEstoquePedido(Fc_Cd_Pedido:Integer;Fc_Faturado:String):Boolean;
//------------------------- Controle de Estoque Especifico---------------------------------------

implementation

uses
  Un_DM, UN_Sistema, UN_MSG, un_Padrao, ControllerBase, Un_WebService, RN_Inventario, UN_Principal, env, ControllerEstoque;

procedure Pc_Grava_EstoqueDiaAnterior(Pc_Cd_Estoque:Integer;Pc_Cd_Produto:Integer;Pc_Data:TDate;Pc_Qtde:Real);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin

      SQL.Add('Update tb_estoque set '+
              'EST_SLD_DATA =:EST_SLD_DATA, '+
              'EST_DATA =:EST_DATA '+
              'WHERE (EST_CODPRO =:PRO_CODIGO) AND EST_CODETS=:ETS_CODIGO ');
      ParamByName('EST_SLD_DATA').AsFloat := Pc_Qtde;
      ParamByName('EST_DATA').AsDate := Pc_Data;
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      ParamByName('ETS_CODIGO').AsInteger := Pc_Cd_Estoque;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_CriaRegistroEstoque(Pc_Cd_Produto: Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Upt : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Lc_Qry_Upt := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT ETS_CODIGO '+
                   ' FROM tb_estoques '+
                   ' WHERE ETS_CODIGO NOT IN( '+
                   ' SELECT DISTINCT ETS_CODIGO '+
                   ' FROM tb_produto '+
                   '    INNER JOIN tb_estoque '+
                   '    ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
                   '    INNER JOIN tb_estoques '+
                   '    ON (tb_estoques.ETS_CODIGO = tb_estoque.EST_CODETS) '+
                   ' WHERE PRO_CODIGO = :PRO_CODIGO)';

      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      Active := True;
      FetchAll;
      First;
      IF (RecordCount > 0) then
      Begin
        //Inclui o Sql que vai inserir a tabela para cada produto
        Lc_Qry_Upt.SQL.Clear;
        Lc_Qry_Upt.SQL.add(concat(
                     'UPDATE OR INSERT INTO TB_ESTOQUE( ' ,
                     '  EST_CODIGO, ' ,
                     '  EST_CODETS, ' ,
                     '  EST_CODPRO, ' ,
                     '  EST_QTDE, ' ,
                     '  EST_QTDE_MIN) ' ,
                     'VALUES( ' ,
                     '  :EST_CODIGO, ' ,
                     '  :EST_CODETS, ' ,
                     '  :EST_CODPRO, ' ,
                     '  :EST_QTDE, ' ,
                     '  :EST_QTDE_MIN) ',
                     ' MATCHING (EST_CODETS,EST_CODPRO) '
                     ));
        while not Eof do
        begin
          Lc_Qry_Upt.Active := False;
          Lc_Qry_Upt.ParamByName('EST_CODIGO').AsInteger := Fc_Generator('GN_ESTOQUE','','EST_CODIGO');
          Lc_Qry_Upt.ParamByName('EST_CODETS').AsInteger := FieldByName('ETS_CODIGO').AsInteger;
          Lc_Qry_Upt.ParamByName('EST_CODPRO').AsInteger := Pc_Cd_Produto;
          Lc_Qry_Upt.ParamByName('EST_QTDE').AsFloat := 0;
          Lc_Qry_Upt.ParamByName('EST_QTDE_MIN').AsInteger := 0;
          Lc_Qry_Upt.ExecSQL;
          Next;
        end;
      end
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_Qry_Upt);
    FreeAndNil(LcBase);
  End;
end;

function Fc_SaldoEstoque(Fc_Cd_Produto,Fc_Cd_Estoque:Integer ):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      if (Fc_Cd_Estoque > 0) then
      Begin
        SQL.Add('SELECT CAST(COALESCE(SUM(EST_QTDE), 0) AS DOUBLE PRECISION) EST_QTDE ' +
                'FROM TB_ESTOQUE '+
                'WHERE (EST_CODPRO =:EST_CODPRO) '+
                '      AND (EST_CODETS=:EST_CODETS) ');
        ParamByName('EST_CODPRO').AsInteger := Fc_Cd_Produto;
        ParamByName('EST_CODETS').AsInteger := Fc_Cd_Estoque;
      end
      else
      Begin
        SQL.Add('SELECT CAST(COALESCE(SUM(EST_QTDE), 0) AS DOUBLE PRECISION) EST_QTDE '+
                'FROM TB_ESTOQUE '+
                'WHERE (EST_CODPRO =:EST_CODPRO) ');
        ParamByName('EST_CODPRO').AsInteger := Fc_Cd_Produto;
      end;
      Active := True;
      FetchAll;
      First;
      Result := FieldbyName('EST_QTDE').AsFloat;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function  Fc_SaldoAnteriorEstoque(Fc_Cd_Produto,Fc_Cd_Estoque:Integer; Fc_Data:TDate):Real;
Var
  Lc_SqlTxt : String;
  Lc_negativo : Real;
  Lc_Positivo : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := 0;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT CET_OPERACAO, CAST(COALESCE(SUM(CET_QTDE), 0) AS DOUBLE PRECISION) SALDO '+
                   'FROM TB_CTRL_ESTOQUE '+
                   'WHERE (CET_CODPRO =:PRO_CODIGO) AND '+
                   '      (CET_DATA < :DATAINI) ';
      if (Fc_Cd_Estoque > 0) then
        Lc_SqlTxt := Lc_SqlTxt + '  AND    (CET_CODETS =:ETS_CODIGO)  ';

      Lc_SqlTxt := Lc_SqlTxt + ' GROUP BY CET_OPERACAO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Fc_Cd_Produto;
      if (Fc_Cd_Estoque > 0) then
        ParamByName('ETS_CODIGO').AsInteger := Fc_Cd_Estoque;
      ParamByName('DATAINI').AsDate := Fc_Data;
      Active := True;
      FetchAll;
      First;
      Lc_negativo := 0;
      Lc_Positivo := 0;
      while not eof do
      Begin
        if (FieldByName('CET_OPERACAO').AsString = 'S') then
          Lc_negativo := Lc_negativo + FieldByName('SALDO').AsCurrency
        else
          Lc_Positivo := Lc_Positivo + FieldByName('SALDO').AsCurrency;
        next;
      end;
      Result := Lc_Positivo - Lc_negativo;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_Registra_EstoqueBcoDestino(FcDataBase : TSTDatabase;
                                        Pc_Vinculo : String;
                                        Pc_Cd_Controle:Integer;
                                        Pc_Cd_Item_Ctrl:Integer;
                                        Pc_Cd_Estoques:Integer;
                                        Pc_OPERACAO:String;
                                        Pc_Cd_Produto:Integer;
                                        Pc_QTDE : Real;
                                        Pc_DATA: Tdate);
Var
  Lc_SqlTxt : String;
  Lc_Qtde : String;
Begin
  with DM do
    Begin
    //Insere os novos registros referente a este item
    Qr_Acao_EstoqueBcoDestino.Active := false;
    Qr_Acao_EstoqueBcoDestino.Database := FcDataBase;
    Qr_Acao_EstoqueBcoDestino.Transaction := DM.IBT_ConsultaBcoDestino;
    Qr_Acao_EstoqueBcoDestino.SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 '  PRO_CODIGO, '+
                 '  PRO_COMPOSICAO, '+
                 '  PPD_QTDE , '+
                 '  PPD_CODPRO_D '+
                 'FROM TB_PRODUTO tb_produto '+
                 '   LEFT OUTER JOIN TB_PROD_PROD tb_prod_prod '+
                 '   ON (tb_prod_prod.PPD_CODPRO_M = tb_produto.PRO_CODIGO) '+
                 'WHERE PRO_CODIGO =:PRO_CODIGO ';
    Qr_Acao_EstoqueBcoDestino.SQL.Add(Lc_SqlTxt);
    Qr_Acao_EstoqueBcoDestino.ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
    Qr_Acao_EstoqueBcoDestino.Active := True;
    Qr_Acao_EstoqueBcoDestino.FetchAll;
    Qr_Acao_EstoqueBcoDestino.First;
    if Qr_Acao_EstoqueBcoDestino.RecordCount = 0 then
      Exit;

    if ((Qr_Acao_EstoqueBcoDestino.FieldByname('PRO_COMPOSICAO').AsString = '1') or (Qr_Acao_EstoqueBcoDestino.FieldByname('PRO_COMPOSICAO').AsString = '3')) then
      Begin
      //Registra o produto Principal
      with DM.Qr_Insere_EstoqueBcoDestino do
        Begin
        IF not DM.IBT_EstoqueBcoDestino.InTransaction then DM.IBT_EstoqueBcoDestino.StartTransaction;
        Active := False;
        DM.Qr_Insere_EstoqueBcoDestino.Database :=  FcDataBase;
        DM.Qr_Insere_EstoqueBcoDestino.Transaction :=  DM.Qr_Acao_EstoqueBcoDestino.Transaction;
        ParamByName('CET_VINCULO').AsString := Pc_Vinculo;
        ParamByName('CET_CONTROLE').AsInteger := Pc_Cd_Controle;
        ParamByName('CET_ITEM_CTRL').AsInteger := Pc_Cd_Item_Ctrl;
        ParamByName('CET_CODETS').AsInteger := Pc_Cd_Estoques;
        ParamByName('CET_OPERACAO').AsString := Pc_OPERACAO;
        ParamByName('CET_CODPRO').AsInteger := Pc_Cd_Produto;
        ParamByName('CET_QTDE').AsFloat := Pc_QTDE;
        ParamByName('CET_DATA').AsDate := Pc_DATA;
        ExecSQL;
        IF DM.IBT_EstoqueBcoDestino.InTransaction then DM.IBT_EstoqueBcoDestino.CommitRetaining;
        end;
      end;
    if ((Qr_Acao_EstoqueBcoDestino.FieldByname('PRO_COMPOSICAO').AsString = '2') or (Qr_Acao_EstoqueBcoDestino.FieldByname('PRO_COMPOSICAO').AsString = '3')) then
    //AND (Pc_OPERACAO = 'S' ) then
      Begin
      //Registra o produto da composicao
      while not Qr_Acao_EstoqueBcoDestino.Eof do
        Begin
        if (trim(Qr_Acao_EstoqueBcoDestino.FieldByname('PPD_CODPRO_D').AsString)<> '') then
          Begin
          with DM.Qr_Insere_EstoqueBcoDestino do
            Begin
            IF not DM.IBT_EstoqueBcoDestino.InTransaction then DM.IBT_EstoqueBcoDestino.StartTransaction;
            Active := False;
            ParamByName('CET_VINCULO').AsString := Pc_Vinculo;
            ParamByName('CET_CONTROLE').AsInteger := Pc_Cd_Controle;
            ParamByName('CET_ITEM_CTRL').AsInteger := Pc_Cd_Item_Ctrl;
            ParamByName('CET_CODETS').AsInteger := Pc_Cd_Estoques;
            ParamByName('CET_OPERACAO').AsString := Pc_OPERACAO;
            ParamByName('CET_CODPRO').AsInteger := DM.Qr_Acao_EstoqueBcoDestino.FieldByname('PPD_CODPRO_D').AsInteger;
            Lc_Qtde := FloatToStrF(DM.Qr_Acao_EstoqueBcoDestino.FieldByname('PPD_QTDE').AsFloat,ffFixed,10,6);
            ParamByName('CET_QTDE').AsFloat := StrToFloatDef(Lc_Qtde,0) * Pc_QTDE;
            ParamByName('CET_DATA').AsDate := Pc_DATA;
            ExecSQL;
            IF DM.IBT_EstoqueBcoDestino.InTransaction then DM.IBT_EstoqueBcoDestino.CommitRetaining;
            end;
          end;
        Qr_Acao_EstoqueBcoDestino.Next;
        end;
      end;
    end;
end;


procedure Pc_Delete_Estoque(Pc_Vinculo : String;
                            Pc_Cd_Controle :Integer;
                            Pc_Cd_Item_Ctrl:Integer);
Var
  Lc_SqlTxt : String;
  LcCtrlEstoque : TControllerCtrlEstoque;
Begin
  LcCtrlEstoque := TControllerCtrlEstoque.Create(nil);
  try
    LcCtrlEstoque.Desregistra(Pc_Vinculo,
                              Pc_Cd_Controle,
                              Pc_Cd_Item_Ctrl);
  finally
    FreeAndNil(LcCtrlEstoque);
  end;
end;

Function Fc_Contagem_Estoque(Pc_Cd_Produto:Integer;
                             Pc_Cd_Estoque:Integer;
                             Pc_Dt_Ini:Tdate;
                             Pc_Dt_Fim:Tdate):Real;
Var
  Lc_SqlTxt : String;
  Lc_negativo : Real;
  Lc_Positivo : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := 0;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT CET_OPERACAO, CAST(COALESCE(SUM(CET_QTDE), 0) AS DOUBLE PRECISION) SALDO '+
                   'FROM TB_CTRL_ESTOQUE '+
                   'WHERE (CET_CODPRO =:PRO_CODIGO) AND '+
                   '      (CET_CODETS =:ETS_CODIGO) AND '+
                   '      (CET_DATA BETWEEN :DATAINI AND :DATAFIM) '+
                   'GROUP BY CET_OPERACAO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      ParamByName('ETS_CODIGO').AsInteger := Pc_Cd_Estoque;
      ParamByName('DATAINI').AsDate := Pc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Pc_Dt_Fim;
      Active := True;
      FetchAll;
      First;
      Lc_negativo := 0;
      Lc_Positivo := 0;
      while not eof do
      Begin
        if (FieldByName('CET_OPERACAO').AsString = 'S') then
          Lc_negativo := Lc_negativo + FieldByName('SALDO').AsCurrency
        else
          Lc_Positivo := Lc_Positivo + FieldByName('SALDO').AsCurrency;
        next;
      end;
      Result := Lc_Positivo - Lc_negativo;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_SelecionaEstoques(Pc_Codmha:Integer);
Var
  Lc_SqlTxt : String;
Begin
  with DM.Qr_Estoques do
    Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL   '+
                 ' FROM TB_ESTOQUES  '+
                 ' WHERE ETS_CODIGO IS NOT NULL ';
    if Pc_Codmha > 0 then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (ETS_CODMHA = :ETS_CODMHA) ';

    Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC ';
    SQL.Add(Lc_SqlTxt);

    if Pc_Codmha > 0 then
      ParamByName('ETS_CODMHA').AsInteger := Pc_Codmha;
    Active := True;
    end;
end;

Function Fc_BuscaCodigoEstoqueProduto(Fc_cd_Estoque,Fc_Cd_Produto:Integer):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Lc_SqlTxt:sTRING;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT EST_CODIGO   '+
                   ' FROM TB_ESTOQUE '+
                   ' WHERE EST_CODETS=:EST_CODETS AND EST_CODPRO=:EST_CODPRO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('EST_CODETS').AsInteger := Fc_cd_Estoque;
      ParamByName('EST_CODPRO').AsInteger := Fc_Cd_Produto;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('EST_CODIGO').AsString
      else
       Result := '0';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

Function Fc_AuditoriaEstoquePedido(Fc_Cd_Pedido:Integer;Fc_Faturado:String):Boolean;
Var
  LcCtrlEstoque : TControllerCtrlEstoque;
  I : Integer;
Begin
  LcCtrlEstoque := TControllerCtrlEstoque.create(nil);
  Try
    Result := False;
    LcCtrlEstoque.getlistByPedido(Fc_Cd_Pedido,Fc_Faturado);
    //Deletar itens
    for I := 0 to LcCtrlEstoque.Lista.Count - 1 do
    BEgin
      with LcCtrlEstoque.Registro do
      Begin
        Vinculo     := LcCtrlEstoque.Lista[I].Vinculo;
        Ordem       := LcCtrlEstoque.Lista[I].Ordem;
        Item        := 0;
      End;
      LcCtrlEstoque.delete;
    End;

    for I := 0 to LcCtrlEstoque.Lista.Count - 1 do
    BEgin
      with LcCtrlEstoque.Registro do
      Begin
        Codigo      := 0;
        Vinculo     := LcCtrlEstoque.Lista[I].Vinculo;
        Ordem       := LcCtrlEstoque.Lista[I].Ordem;
        Item        := LcCtrlEstoque.Lista[I].Item;
        Estoque     := LcCtrlEstoque.Lista[I].Estoque;
        operacao    := LcCtrlEstoque.Lista[I].operacao;
        Produto     := LcCtrlEstoque.Lista[I].Produto;
        Quantidade  := LcCtrlEstoque.Lista[I].Quantidade;
        Data        := LcCtrlEstoque.Lista[I].Data;
        Tipo        := LcCtrlEstoque.Lista[I].Tipo;
        UpdateAt    := Now;
      End;
      LcCtrlEstoque.Registra;
    end;
    Result := true;
  Finally
    FreeAndNil(LcCtrlEstoque);
  End;
end;



end.

{------------------------------------------------------------
 Funcao : Esta unidade contém uma biblioteca de funções
 para controlar as comissões
 -----------------------------------------------------------}

unit Un_Fc_Comissao;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, ControllerComissao, ControllerBase, System.Math, STTransaction;

  type TComissao = Record
      It_Mtz_Vendedores : Array of Array of String;
    //  It_Mtz_Vendedores :  array[0..2] of array[0..1] of String;
      It_Qt_Vendedores: Integer;
  end;

{C}
procedure Pc_Construtor_Comissao(Pc_Transacao: TSTTransaction);
{D}
procedure Pc_Deleta_Vdo_Pedido(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido,Pc_Cd_Itens: Integer;Pc_Edicao:String);
procedure Pc_DeletaComissao(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido,Pc_Cd_Financeiro: Integer);
Function  Fc_DefineVendedor(Fc_Cd_Pedido: Integer): TComissao;
procedure Pc_Destrutor_Comissao;
{G}
procedure Pc_Gerar_Comissao_Srv_Fat(Pc_Transacao: TSTTransaction; Pc_Cd_Pedido:Integer);
procedure Pc_Gerar_Comissao_Vda_Fat(Pc_Transacao: TSTTransaction;Pc_Cd_Pedido:Integer);
procedure Pc_Gerar_Comissao_Srv_Vdo_Fat(Pc_Transacao: TSTTransaction;Pc_cd_Pedido:Integer);

procedure Pc_Gerar_Comissao_Srv_Rec(Pc_Transacao: TSTTransaction; Pc_Cd_Financeiro: Integer);
procedure Pc_Gerar_Comissao_Vda_Rec(Pc_Transacao: TSTTransaction; Pc_Cd_Financeiro: Integer);
procedure Pc_Gerar_Comissao_Srv_Vdo_Rec(Pc_Transacao : TSTTransaction;Pc_cd_Financeiro:Integer);

{I}
procedure Pc_Ins_Vdo_Itf_Vda(Pc_Transacao : TSTTransaction;
                             Pc_Cd_Item: Integer;
                             Pc_Cd_Pedido: Integer;
                             Pc_Cd_Vendedor: Integer;
                             Pc_tp_Edicao : String;
                             Pc_Aq_Com: Real);

procedure Pc_Ins_Tec_Itf_Srv(Pc_Transacao : TSTTransaction;
                             Pc_Cd_Item: Integer;
                             Pc_Cd_Pedido: Integer;
                             Pc_Cd_Tecnico: Integer;
                             Pc_Proporcao: Real;
                             Pc_Tp_Vinculo:String);
procedure PreecheAliquotaZero(Pc_Transacao : TSTTransaction;
                              Pc_Cd_Pedido: Integer);

{R}
procedure Pc_Registra_Vdo_Pedido(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido: Integer);

VAR
  Base : TControllerBase;
  It_Qry : TSTQuery;
  It_Registra_Vdo_Pedido : TSTQuery;
  It_Define_Vendedor : TSTQuery;
  It_Gera_Com_Vda_Rec : TSTQuery;
  It_Qtde_Vendedor : TSTQuery;
  It_Reg_Comissao : TComissao;
implementation

uses     Un_DM, UN_Sistema, DB, Classes, TypInfo, Un_Fc_Sored_Procedures, env, un_principal;
procedure Pc_Construtor_Comissao(Pc_Transacao: TSTTransaction);
Var
  Lc_Txt : String;
Begin
  Base := TControllerBase.create(nil);
  //Cria Query de Consulta
  It_Qry := Base.GeraQuery;

  //Cria Query de Acao

  //Cria a Query que registra o Vendedor
  It_Registra_Vdo_Pedido := Base.GeraQuery;

  Lc_Txt := 'SELECT ITF_CODIGO, ITF_CODPED, PED_CODVDO, ITF_AQ_COM  '+
            ' FROM TB_ITENS_NFL tb_itens_nfl                        '+
            '  INNER JOIN TB_PEDIDO tb_pedido                       '+
            '  ON (tb_pedido.PED_CODIGO = tb_itens_nfl.ITF_CODPED)  '+
            '  INNER JOIN TB_EMPRESA tb_empresa                     '+
            '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP)    '+
            '  INNER JOIN TB_PRODUTO tb_produto                     '+
            '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
            'WHERE (ITF_CODPED=:ITF_CODPED) AND PRO_TIPO <> ''S''   '+
            'ORDER BY 1                                             ';
  It_Registra_Vdo_Pedido.SQL.Add(Lc_Txt);
  
  //Cria Consulta para Verificar os vendedor(es) do Pedido
  It_Define_Vendedor := Base.GeraQuery;

  Lc_Txt := 'SELECT DISTINCT  tb_Pedido.PED_CODVDO, '+
            '   tb_vendedor_Pedido.CLB_AQ_COM_VDA AS PED_AQ_COM, '+
            '   tb_vendedor_Pedido.CLB_COM_VDA AS PED_COM_VDA, '+
            '   tb_vendedor_Pedido.CLB_CALC_COM_VDA AS PED_CALC_COM_VDA,     '+
            '   tb_empresa.EMP_CODVDOR,  '+
            '   tb_vendedor_Cliente.CLB_AQ_COM_VDA AS EMP_AQ_COM,'+
            '   tb_vendedor_Cliente.CLB_COM_VDA AS EMP_COM_VDA,'+
            '   tb_vendedor_Cliente.CLB_CALC_COM_VDA AS EMP_CALC_COM_VDA     '+
            'FROM TB_PEDIDO tb_pedido '+
            '   INNER JOIN TB_EMPRESA tb_empresa '+
            '   ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
            '   INNER JOIN TB_COLABORADOR tb_vendedor_Pedido'+
            '   ON (tb_vendedor_Pedido.CLB_CODIGO = tb_pedido.PED_CODVDO)    '+
            '   LEFT JOIN TB_COLABORADOR tb_vendedor_Cliente'+
            '   ON (tb_vendedor_Cliente.CLB_CODIGO = tb_empresa.EMP_CODVDOR) '+
            'WHERE (PED_CODIGO=:PED_CODIGO) '+
            'ORDER BY tb_empresa.EMP_CODVDOR, tb_Pedido.PED_CODVDO ';

  It_Define_Vendedor.SQL.Add(Lc_Txt);

  //Cria a query que vai gerar a Comissão de Venda no Recebimento
  It_Gera_Com_Vda_Rec := Base.GeraQuery;
  Lc_Txt := 'SELECT DISTINCT '+
            '  FIN_CODIGO, '+
            '  ITF_CODIGO,' +
            '  FIN_DATA, '+
            '  FIN_DT_PAGTO, '+
            '  FIN_CODEMP, '+
            '  FIN_OPERACAO, '+
            '  VEN_CODPED, '+
            '  VEN_CODCLB, '+
            '  VEN_PROPORCAO, '+
            '  FIN_VL_PAGO, '+
            ' FIN_VL_PARCELA, '+
            '  (ITF_VL_UNIT * ITF_QTDE) ITF_VL_SUBTOTAL, '+
            '  NFL_VL_TL_NOTA '+
            'FROM TB_VENDEDOR tb_vendedor '+
            '  INNER JOIN TB_FINANCEIRO tb_financeiro '+
            '  ON (tb_financeiro.FIN_CODPED = tb_vendedor.VEN_CODPED) '+
            '  INNER JOIN TB_NOTA_FISCAL '+
            '  ON (FIN_CODNFL = NFL_CODIGO) '+
            '  INNER JOIN TB_ITENS_NFL '+
            '  ON (ITF_CODPED = FIN_CODPED) '+
            '  INNER JOIN TB_PRODUTO '+
            '  ON (PRO_CODIGO = ITF_CODPRO) '+
            'WHERE (FIN_CODIGO = :FIN_CODIGO)AND (FIN_BAIXA = ''S'') AND (PRO_TIPO <> ''S'') '+
            'ORDER BY VEN_CODCLB';

  It_Gera_Com_Vda_Rec.SQL.Add(Lc_Txt);
  //Descobrir quantos vendedores temos no pedido
  It_Qtde_Vendedor := Base.GeraQuery;
  Lc_Txt := 'SELECT DISTINCT  '+
               '  VEN_CODPED, '+
               '  VEN_CODCLB  '+
               'FROM TB_VENDEDOR tb_vendedor '+
               'WHERE (VEN_CODPED = :VEN_CODPED) ';
  It_Qtde_Vendedor.SQL.Add(Lc_Txt);

end;

{D}

procedure Pc_Destrutor_Comissao;
Begin
  //Cria a Query que registra o Vendedor
  Base.FinalizaQuery(It_Qry);
  Base.FinalizaQuery(It_Registra_Vdo_Pedido);
  Base.FinalizaQuery(It_Define_Vendedor);
  Base.FinalizaQuery(It_Gera_Com_Vda_Rec);
  Base.FinalizaQuery(It_Qtde_Vendedor);
  FreeAndNil(Base);
end;

procedure Pc_Deleta_Vdo_Pedido(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido,Pc_Cd_Itens: Integer;Pc_Edicao:String);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Sqltxt : sTRING;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('DELETE '+
              'FROM TB_VENDEDOR ');
      if (Pc_Cd_Pedido >0) then
        SQL.Add('WHERE (VEN_CODPED =:VEN_CODPED) ');

      if (Pc_Cd_Itens >0) then
        SQL.Add('WHERE (VEN_CODITF =:VEN_CODITF) ');

      if trim(Pc_Edicao) = 'M' then
        SQL.Add('AND (VEN_EDICAO =:VEN_EDICAO) ')
      else
        SQL.Add('AND (VEN_EDICAO is null) OR (VEN_EDICAO = ''A'') ');

      if (Pc_Cd_Pedido >0) then
        ParamByName('VEN_CODPED').AsInteger := Pc_Cd_Pedido;

      if (Pc_Cd_Itens >0) then
        ParamByName('VEN_CODITF').AsInteger := Pc_Cd_Itens;

      if trim(Pc_Edicao) = 'M' then
        ParamByName('VEN_EDICAO').AsString := Pc_Edicao;

      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;


end;

procedure Pc_DeletaComissao(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido,Pc_cd_Financeiro: Integer);
Var
  Lc_SqlTxt : String;
Var
  LcComissao : TControllerComissao;
begin
  TRy
    LcComissao := TControllerComissao.create(nil);
    with LcComissao.registro do
    BEgin
      Codigo          := 0;
      Pedido          := Pc_Cd_Pedido;
      Financeiro      := Pc_Cd_Financeiro;
      Estabelecimento := Gb_CodMha;
    End;
    LcComissao.delete;
  Finally
    FreeAndNil( LcComissao );
  End;
end;

Function Fc_DefineVendedor(Fc_Cd_Pedido: Integer): TComissao;
var
  Lc_Dist_Com : Boolean;
  Lc_Aq_Compartilhada : Real;
begin

  //Verifica se (Distribuir comissão entre o vendedor do Cadasro do cliente e o Vendedor do Pedido)
  Lc_Dist_Com := (Fc_Tb_Geral('L','COM_G_DIST_EMPVDO_PEDVDO','S') = 'S');

  //Se Lc_Dist_Com for verdadeiro traz a aliquota padrão
  if Lc_Dist_Com then Lc_Aq_Compartilhada := StrToFloatDef(Fc_Tb_Geral('L','COM_G_AQ_DIST','0'),0);


  It_Define_Vendedor.CLOSE;

  It_Define_Vendedor.ParamByName('PED_CODIGO').AsInteger := Fc_Cd_Pedido;
  It_Define_Vendedor.Active := True;
  It_Define_Vendedor.FetchAll;
  {$R-}
  if (It_Define_Vendedor.FieldByName('PED_CODVDO').AsInteger = It_Define_Vendedor.FieldByName('EMP_CODVDOR').AsInteger) then
  Begin
    //Quantidade de Vendedor(es)
    Result.It_Qt_Vendedores := 1;
    //Vendedor do Cliente / aliquota Propria / Recebe por Produto / [Calculo pela Aliquota do Cadastro ou Calculo pela soma da Aliquota ao item de venda]

    SetLength(Result.It_Mtz_Vendedores,4,1);
    Result.It_Mtz_Vendedores[0,0] := IntToStr(It_Define_Vendedor.FieldByName('EMP_CODVDOR').AsInteger);
    if Lc_Dist_Com then
      Result.It_Mtz_Vendedores[1,0] := FloatToStrF((It_Define_Vendedor.FieldByName('EMP_AQ_COM').AsFloat + Lc_Aq_Compartilhada),ffFixed,10,2)
    else
      Result.It_Mtz_Vendedores[1,0] := FloatToStrF(It_Define_Vendedor.FieldByName('EMP_AQ_COM').AsFloat,ffFixed,10,2) ;
    Result.It_Mtz_Vendedores[2,0] := It_Define_Vendedor.FieldByName('EMP_COM_VDA').AsString;
    Result.It_Mtz_Vendedores[3,0] := It_Define_Vendedor.FieldByName('EMP_CALC_COM_VDA').AsString;
  end
  else
  Begin
    if Lc_Dist_Com then
    Begin
      //Quantidade de Vendedor(es)
      Result.It_Qt_Vendedores := 2;
      //1º Vendedor do cliente / aliquota Propria / Recebe por Produto / [Calculo pela Aliquota do Cadastro ou Calculo pela soma da Aliquota ao item de venda]
      SetLength(Result.It_Mtz_Vendedores,4,2);
      Result.It_Mtz_Vendedores[0,0] := IntToStr(It_Define_Vendedor.FieldByName('EMP_CODVDOR').AsInteger);
      Result.It_Mtz_Vendedores[1,0] := FloatToStrF(It_Define_Vendedor.FieldByName('EMP_AQ_COM').AsFloat,ffFixed,10,2) ;
      Result.It_Mtz_Vendedores[2,0] := It_Define_Vendedor.FieldByName('EMP_COM_VDA').AsString;
      Result.It_Mtz_Vendedores[3,0] := It_Define_Vendedor.FieldByName('EMP_CALC_COM_VDA').AsString;

      //º Vendedor do Pedido / aliquota padrão / Recebe por Produto
      Result.It_Mtz_Vendedores[0,1] := IntToStr(It_Define_Vendedor.FieldByName('PED_CODVDO').AsInteger);
      Result.It_Mtz_Vendedores[1,1] := FloatToStrF(Lc_Aq_Compartilhada,ffFixed,10,2);
      Result.It_Mtz_Vendedores[2,1] := It_Define_Vendedor.FieldByName('PED_COM_VDA').AsString;
      Result.It_Mtz_Vendedores[3,1] := It_Define_Vendedor.FieldByName('PED_CALC_COM_VDA').AsString;
    end
    else
    Begin
      //Quantidade de Vendedor(es)
      Result.It_Qt_Vendedores := 1;
      //1º Vendedor do Pedido / aliquota Propria / Recebe por Produto / [Calculo pela Aliquota do Cadastro ou Calculo pela soma da Aliquota ao item de venda]
      SetLength(Result.It_Mtz_Vendedores,4,1);
      Result.It_Mtz_Vendedores[0,0] := IntToStr(It_Define_Vendedor.FieldByName('PED_CODVDO').AsInteger);
      Result.It_Mtz_Vendedores[1,0] := FloatToStrF(It_Define_Vendedor.FieldByName('PED_AQ_COM').AsFloat,ffFixed,10,2) ;
      Result.It_Mtz_Vendedores[2,0] := It_Define_Vendedor.FieldByName('PED_COM_VDA').AsString;
      Result.It_Mtz_Vendedores[3,0] := It_Define_Vendedor.FieldByName('PED_CALC_COM_VDA').AsString;
    end;
  end;
  {$R+}
end;

{G}
procedure Pc_Gerar_Comissao_Srv_Fat(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido:Integer);
var
  Lc_Cd_Colab: Integer;
  Lc_Vl_Comissao: Real;
  Lc_VL_Doc: Real;
  Lc_Calculo: Real;
  Lc_Com_Venda: Boolean;
  Lc_SqlTxt : String;
  Lc_Aq_com : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;

label
   lb_Sai;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT  '+
                   '  PED_DATA, '+
                   '  PED_CODEMP,'+
                   '  TEC_CODIGO,'+
                   '  TEC_CODITF,'+
                   '  TEC_CODPED,'+
                   '  TEC_CODCLB,'+
                   '  TEC_PROPORCAO,'+
                   '  ((ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC) AS  ITF_SUBTOTAL,'+
                   '  ITF_AQ_COM,'+
                   '  CLB_AQ_COM_SRV,'+
                   '  CLB_COM_SRV,  '+
                   '  CLB_CALC_COM_SRV '+
                   'FROM TB_TECNICO tb_tecnico '+
                   '  INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                   '  ON (tb_itens_nfl.ITF_CODIGO = tb_tecnico.TEC_CODITF)     '+
                   '  INNER JOIN TB_PEDIDO tb_pedido '+
                   '  ON (tb_pedido.PED_CODIGO = tb_itens_nfl.ITF_CODPED) '+
                   '  INNER JOIN TB_COLABORADOR tb_colaborador                 '+
                   '  ON (tb_colaborador.CLB_CODIGO = tb_tecnico.TEC_CODCLB) '+
                   'WHERE (ITF_CODPED = :ITF_CODPED)  '+
                   'ORDER BY TEC_CODCLB  ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODPED').AsInteger := Pc_cd_Pedido;
      Active := True;
      FetchAll;
      First;
      lb_sai:
      Lc_Calculo := 0;
      Lc_Vl_Comissao := 0;
      Lc_VL_Doc := 0;
      Lc_Cd_Colab := FieldByName('TEC_CODCLB').AsInteger;

      while not Eof do
      begin
        if (Lc_Cd_Colab = FieldByName('TEC_CODCLB').AsInteger) then
        begin
          Lc_VL_Doc := Lc_VL_Doc + FieldByName('ITF_SUBTOTAL').AsCurrency;
          //Caso receba um valor fixo pelo Cadastro do Colaborador e consequentemente a proporcação da qual participou na execução
          if FieldByName('CLB_CALC_COM_SRV').AsString = 'C' then
          Begin
            Lc_Calculo := FieldByName('ITF_SUBTOTAL').AsCurrency * (FieldByName('CLB_AQ_COM_SRV').AsFloat / 100);
            Lc_Calculo := Lc_Calculo * (FieldByName('TEC_PROPORCAO').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
          end;
          //Caso receba comissão por item e consequentemente a proporcação da qual participou na execução
          if  FieldByName('CLB_COM_SRV').AsString = 'S' then
          Begin
            if FieldByName('CLB_CALC_COM_SRV').AsString = 'S' then
            Begin
              //'S' - Calculo pela soma da Aliquota ao item de serviço
              Lc_Aq_com := FieldByName('CLB_AQ_COM_SRV').AsFloat;
              Lc_Calculo := FieldByName('ITF_SUBTOTAL').AsCurrency * (Lc_Aq_com / 100);
              Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
            end;
            Lc_Calculo := FieldByName('ITF_SUBTOTAL').AsCurrency * (FieldByName('ITF_AQ_COM').AsFloat / 100);
            Lc_Calculo := Lc_Calculo * (FieldByName('TEC_PROPORCAO').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
            end;
        end
        else
        begin
          //Calcular as comissões
          if (Lc_Vl_Comissao > 0) then
          Begin
            Pc_Comissao(Pc_Transacao,
                        FieldByName('PED_DATA').AsDateTime,
                        Pc_Cd_Pedido,
                        0,
                        FieldByName('PED_CODEMP').AsInteger,
                        Lc_Cd_Colab,
                        Lc_VL_Doc,
                        Lc_Vl_Comissao,
                        'S');
          end;
          goto lb_sai;
        end;
        Next;
      end;
      if (Lc_Vl_Comissao > 0) then
      Begin
        Pc_Comissao(Pc_Transacao,
                    FieldByName('PED_DATA').AsDateTime,
                    Pc_Cd_Pedido,
                    0,
                    FieldByName('PED_CODEMP').AsInteger,
                    Lc_Cd_Colab,
                    Lc_VL_Doc,
                    Lc_Vl_Comissao,
                    'S');
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_Gerar_Comissao_Vda_Fat(Pc_Transacao : TSTTransaction;Pc_Cd_Pedido:Integer);
var
   Lc_Cd_Colab: Integer;
   Lc_Vl_Comissao: Real;
   Lc_VL_Doc: Real;
   Lc_Calculo: Real;
   Lc_Com_Venda: Boolean;
   Lc_SqlTxt : String;
   Lc_Qry : TSTQuery;
   LcBase : TControllerBase;
label
   lb_Sai;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
    Lc_SqlTxt := 'SELECT  '+
                 '  NFL_DT_EMISSAO, '+
                 '  NFL_CODEMP, '+
                 '  VEN_CODITF, '+
                 '  VEN_CODPED, '+
                 '  VEN_CODCLB, '+
                 '  VEN_PROPORCAO, '+
                 '  ((ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC) AS  ITF_SUBTOTAL,'+
                 '  ITF_AQ_COM  '+
                 'FROM TB_VENDEDOR tb_vendedor '+
                 '  INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                 '  ON (tb_itens_nfl.ITF_CODIGO = tb_vendedor.VEN_CODITF)    '+
                 '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
                 '  ON (tb_nota_fiscal.NFL_CODIGO = tb_itens_nfl.ITF_CODNFL) '+
                 'WHERE (ITF_CODPED = :ITF_CODPED) '+
                 'ORDER BY VEN_CODCLB ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODPED').AsInteger := Pc_cd_Pedido;
      Active := True;
      FetchAll;
      First;
      lb_sai:
      Lc_Calculo := 0;
      Lc_Vl_Comissao := 0;
      Lc_VL_Doc := 0;
      Lc_Cd_Colab := Lc_Qry.FieldByName('VEN_CODCLB').AsInteger;

      while not Lc_Qry.Eof do
      begin
        if (Lc_Cd_Colab = Lc_Qry.FieldByName('VEN_CODCLB').AsInteger) then
        begin
          Lc_VL_Doc := Lc_VL_Doc + Lc_Qry.FieldByName('ITF_SUBTOTAL').AsCurrency;
          Lc_Calculo := Lc_Qry.FieldByName('ITF_SUBTOTAL').AsCurrency * (Lc_Qry.FieldByName('VEN_PROPORCAO').AsFloat / 100);
          Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
        end
        else
        begin
          //Calcular as comissões
          if (Lc_Vl_Comissao > 0) then
            Pc_Comissao(Pc_Transacao,
                        Lc_Qry.FieldByName('NFL_DT_EMISSAO').AsDateTime,
                        Pc_Cd_Pedido,
                        0,
                        Lc_Qry.FieldByName('NFL_CODEMP').AsInteger,
                        Lc_Cd_Colab,
                        Lc_VL_Doc,
                        Lc_Vl_Comissao,
                        'P');
          goto lb_sai;
        end;
        Lc_Qry.Next;
      end;
      if (Lc_Vl_Comissao > 0) then
      Begin
          Pc_Comissao(Pc_Transacao,
                    Lc_Qry.FieldByName('NFL_DT_EMISSAO').AsDateTime,
                    Pc_Cd_Pedido,
                    0,
                    Lc_Qry.FieldByName('NFL_CODEMP').AsInteger,
                    Lc_Cd_Colab,
                    Lc_VL_Doc,
                    Lc_Vl_Comissao,
                    'P');
      End;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;
end;

procedure Pc_Gerar_Comissao_Srv_Vdo_Fat(Pc_Transacao: TSTTransaction; Pc_cd_Pedido: Integer);
var
  Lc_Cd_Colab: Integer;
  Lc_Vl_Comissao: Real;
  Lc_VL_Doc: Real;
  Lc_Calculo: Real;
  Lc_Com_Venda: Boolean;
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT                                                     '+
                   '  NFL_DT_EMISSAO,                                          '+
                   '  NFL_CODEMP,                                              '+
                   '  PED_CODVDO,                                              '+
                   '  ((ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC) AS  ITF_SUBTOTAL,'+
                   '  ITF_AQ_COM,                                              '+
                   '  tb_vendedor.CLB_CODIGO,                                  '+
                   '  tb_vendedor.CLB_AQ_COM_SRV,                              '+
                   '  tb_vendedor.CLB_COM_SRV                                  '+
                   'FROM TB_PEDIDO tb_pedido                                   '+
                   '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal                 '+
                   '  ON (tb_nota_fiscal.NFL_CODPED = tb_pedido.PED_CODIGO)    '+
                   '  INNER JOIN TB_COLABORADOR tb_vendedor                    '+
                   '  ON (tb_vendedor.CLB_CODIGO = tb_pedido.PED_CODVDO)       '+
                   '  INNER JOIN TB_CARGO tb_cargo                             '+
                   '  ON (tb_cargo.CRG_CODIGO = tb_vendedor.CLB_CODCRG)        '+
                   '  INNER JOIN TB_ITENS_NFL tb_itens_nfl                     '+
                   '  ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)      '+
                   '  INNER JOIN TB_PRODUTO tb_produto                         '+
                   '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)     '+
                   'WHERE (PED_CODIGO = :PED_CODIGO) AND (PRO_TIPO = ''S'')    '+
                   'AND (CRG_DESCRICAO LIKE :CRG_DESCRICAO)                     ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('CRG_DESCRICAO').AsString := 'VENDEDOR%';
      ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
      Active := True;
      FetchAll;
      First;
      Lc_Vl_Comissao := 0;
      Lc_Cd_Colab := FieldByName('CLB_CODIGO').AsInteger;
      if (FieldByName('CLB_AQ_COM_SRV').AsFloat > 0) or (FieldByName('CLB_COM_SRV').AsString = 'S') then
      Begin
        Lc_VL_Doc := 0;
        while not Eof do
        begin
          Lc_VL_Doc := Lc_VL_Doc + FieldByName('ITF_SUBTOTAL').AsCurrency;
          if (FieldByName('CLB_COM_SRV').AsString = 'S') then
          Begin
            Lc_Calculo := FieldByName('ITF_SUBTOTAL').AsCurrency * (FieldByName('ITF_AQ_COM').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
          end;
          Lc_Qry.Next;
        end;
      end;

      if (Lc_Qry.FieldByName('CLB_AQ_COM_SRV').AsFloat > 0)  then
      Begin
        Lc_Vl_Comissao := Lc_Vl_Comissao + (Lc_VL_Doc * (FieldByName('CLB_AQ_COM_SRV').AsFloat / 100));
      end;

      //Calcular as comissões
      If (Lc_Vl_Comissao > 0) then
      Begin
        Pc_Comissao(Pc_Transacao,
                    FieldByName('NFL_DT_EMISSAO').AsDateTime,
                    Pc_Cd_Pedido,
                    0,
                    FieldByName('NFL_CODEMP').AsInteger,
                    Lc_Cd_Colab,
                    Lc_VL_Doc,
                    Lc_Vl_Comissao,
                    'S');
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_Gerar_Comissao_Srv_Rec(Pc_Transacao: TSTTransaction; Pc_Cd_Financeiro: Integer);
var
   Lc_Cd_Colab: Integer;
   Lc_Vl_Comissao: Real;
   Lc_VL_Doc: Real;
   Lc_Calculo: Real;
   Lc_Com_Venda: Boolean;
   Lc_SqlTxt : String;
   Lc_Aq_com : Real;
   Lc_Tx_Baixa_Pagto : real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
label
   lb_Sai;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT  '+
                   '  FIN_DT_PAGTO, '+
                   '  PED_CODIGO,'+
                   '  FIN_CODIGO,'+
                   '  PED_CODEMP,'+
                   '  TEC_CODIGO,'+
                   '  TEC_CODITF,'+
                   '  TEC_CODPED,'+
                   '  TEC_CODCLB,'+
                   '  TEC_PROPORCAO,'+
                   '  ((ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC) AS  ITF_SUBTOTAL,'+
                   '  ITF_AQ_COM,'+
                   '  CLB_AQ_COM_SRV,'+
                   '  CLB_COM_SRV,  '+
                   '  CLB_CALC_COM_SRV, '+
                   '  NFL_VL_TL_NOTA '+
                   'FROM TB_TECNICO tb_tecnico '+
                   '  INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                   '  ON (tb_itens_nfl.ITF_CODIGO = tb_tecnico.TEC_CODITF)     '+
                   '  INNER JOIN TB_PEDIDO tb_pedido '+
                   '  ON (tb_pedido.PED_CODIGO = tb_itens_nfl.ITF_CODPED) '+
                   '  INNER JOIN TB_NOTA_FISCAL '+
                   '  ON (NFL_CODPED = PED_CODIGO) '+
                   '  INNER JOIN TB_FINANCEIRO tb_financeiro '+
                   '  ON (tb_financeiro.FIN_CODPED = tb_pedido.PED_CODIGO) '+
                   '  INNER JOIN TB_COLABORADOR tb_colaborador                 '+
                   '  ON (tb_colaborador.CLB_CODIGO = tb_tecnico.TEC_CODCLB) '+
                   'WHERE (FIN_CODIGO= :FIN_CODIGO)  '+
                   'ORDER BY TEC_CODCLB  ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODIGO').AsInteger := Pc_Cd_Financeiro;
      Active := True;
      FetchAll;
      First;
      lb_sai:
      Lc_Calculo := 0;
      Lc_Vl_Comissao := 0;
      Lc_VL_Doc := 0;
      Lc_Cd_Colab := FieldByName('TEC_CODCLB').AsInteger;

      while not Eof do
      begin
        if (Lc_Cd_Colab = FieldByName('TEC_CODCLB').AsInteger) then
        begin
          Lc_Tx_Baixa_Pagto := (FieldByName('FIN_VL_PAGO').AsCurrency / FieldByName('NFL_VL_TL_NOTA').AsCurrency);
          Lc_VL_Doc := Lc_VL_Doc + (FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto);
          //Caso receba um valor fixo pelo Cadastro do Colaborador e consequentemente a proporcação da qual participou na execução
          if FieldByName('CLB_CALC_COM_SRV').AsString = 'C' then
          Begin
            Lc_Calculo := (FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) * (FieldByName('CLB_AQ_COM_SRV').AsFloat / 100);
            Lc_Calculo := Lc_Calculo * (FieldByName('TEC_PROPORCAO').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
          end;
          //Caso receba comissão por item e consequentemente a proporcação da qual participou na execução
          if  FieldByName('CLB_COM_SRV').AsString = 'S' then
          Begin
            if FieldByName('CLB_CALC_COM_SRV').AsString = 'S' then
            Begin
              //'S' - Calculo pela soma da Aliquota ao item de serviço
              Lc_Aq_com := FieldByName('CLB_AQ_COM_SRV').AsFloat;
              Lc_Calculo := (FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) * (Lc_Aq_com / 100);
              Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
            end;
            Lc_Calculo := (FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) * (FieldByName('ITF_AQ_COM').AsFloat / 100);
            Lc_Calculo := Lc_Calculo * (FieldByName('TEC_PROPORCAO').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
          end;
        end
        else
        begin
          //Calcular as comissões
          if (Lc_Vl_Comissao > 0) then
          Begin
            Pc_Comissao(Pc_Transacao,
                        FieldByName('FIN_DT_PAGTO').AsDateTime,
                        FieldByName('PED_CODIGO').AsInteger,
                        FieldByName('FIN_CODIGO').AsInteger,
                        FieldByName('PED_CODEMP').AsInteger,
                        Lc_Cd_Colab,
                        Lc_VL_Doc,
                        Lc_Vl_Comissao,
                        'S');
          end;
          goto lb_sai;
        end;
        Next;
      end;
      if (Lc_Vl_Comissao > 0) then
      Begin
        Pc_Comissao(Pc_Transacao,
                    FieldByName('FIN_DT_PAGTO').AsDateTime,
                    FieldByName('PED_CODIGO').AsInteger,
                    0,
                    FieldByName('PED_CODEMP').AsInteger,
                    Lc_Cd_Colab,
                    Lc_VL_Doc,
                    Lc_Vl_Comissao,
                    'S');
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_Gerar_Comissao_Vda_Rec(Pc_Transacao: TSTTransaction; Pc_Cd_Financeiro: Integer);
var
   Lc_Cd_Colab: Integer;
   Lc_Vl_Comissao: Real;
   Lc_VL_Doc: Real;
   Lc_Calculo: Real;
   Lc_Com_Venda: Boolean;
   Lc_SqlTxt : String;
   Lc_Nr_Vendedores : Integer;
   Lc_Tx_Baixa_Pagto : real;
label
   lb_Sai;
begin
  with It_Gera_Com_Vda_Rec do
  Begin
    Close;
    ParamByName('FIN_CODIGO').AsInteger := Pc_Cd_Financeiro;
    Active := True;
    FetchAll;
    RecordCount;

    It_Qtde_Vendedor.Close;
    It_Qtde_Vendedor.ParamByName('VEN_CODPED').AsInteger := FieldByName('VEN_CODPED').AsInteger;
    It_Qtde_Vendedor.Active := True;
    It_Qtde_Vendedor.FetchAll;
    Lc_Nr_Vendedores := It_Qtde_Vendedor.RecordCount;

    It_Gera_Com_Vda_Rec.First;
    lb_sai:
    Lc_Calculo := 0;
    Lc_Vl_Comissao := 0;
    Lc_VL_Doc := 0;
    Lc_Cd_Colab := FieldByName('VEN_CODCLB').AsInteger;

    while not Eof do
    begin
      if (Lc_Cd_Colab = FieldByName('VEN_CODCLB').AsInteger) then
      begin
        Lc_Tx_Baixa_Pagto := (FieldByName('FIN_VL_PAGO').AsCurrency / FieldByName('NFL_VL_TL_NOTA').AsCurrency);
        Lc_VL_Doc := Lc_VL_Doc + ((FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) / Lc_Nr_Vendedores);
        Lc_Calculo := ((FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) / Lc_Nr_Vendedores) * (FieldByName('VEN_PROPORCAO').AsFloat / 100);
        Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
      end
      else
      begin
        if (FieldByName('FIN_OPERACAO').AsString = 'D') then
        Begin
          Lc_VL_Doc := Lc_VL_Doc * -1;
          Lc_Vl_Comissao := Lc_Vl_Comissao * -1;
        end;
        //Calcular as comissões
        if (Lc_Vl_Comissao <> 0) then
          Pc_Comissao(Pc_Transacao,
                      FieldByName('FIN_DT_PAGTO').AsDateTime,
                      FieldByName('VEN_CODPED').AsInteger,
                      FieldByName('FIN_CODIGO').AsInteger,
                      FieldByName('FIN_CODEMP').AsInteger,
                      Lc_Cd_Colab,
                      Lc_VL_Doc,
                      Lc_Vl_Comissao,
                      'P');
        goto lb_sai;
      end;
      Next;
    end;
    if (FieldByName('FIN_OPERACAO').AsString = 'D') then
    Begin
      Lc_VL_Doc := Lc_VL_Doc * -1;
      Lc_Vl_Comissao := Lc_Vl_Comissao * -1;
    end;
    if (Lc_Vl_Comissao <> 0) then
      Pc_Comissao(Pc_Transacao,
                  FieldByName('FIN_DT_PAGTO').AsDateTime,
                  FieldByName('VEN_CODPED').AsInteger,
                  FieldByName('FIN_CODIGO').AsInteger,
                  FieldByName('FIN_CODEMP').AsInteger,
                  Lc_Cd_Colab,
                  Lc_VL_Doc,
                  Lc_Vl_Comissao,
                  'P');
  end;
end;

procedure Pc_Gerar_Comissao_Srv_Vdo_Rec(Pc_Transacao: TSTTransaction; Pc_cd_Financeiro: Integer);
var
   Lc_Cd_Colab: Integer;
   Lc_Vl_Comissao: Real;
   Lc_VL_Doc: Real;
   Lc_Calculo: Real;
   Lc_Com_Venda: Boolean;
   Lc_SqlTxt : String;
   Lc_Qry : TSTQuery;
   Lc_Tx_Baixa_Pagto : Real;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT '+
                   '  FIN_DT_PAGTO, '+
                   '  NFL_CODEMP,  '+
                   '  PED_CODIGO, '+
                   '  FIN_CODIGO, '+
                   '  PED_CODVDO,  '+
                   '  FIN_VL_PAGO,  '+
                   '  FIN_VL_PARCELA,  '+
                   '  ((ITF_QTDE * ITF_VL_UNIT)- ITF_VL_DESC) AS  ITF_VL_SUBTOTAL,'+
                   '  ITF_AQ_COM,  '+
                   '  tb_vendedor.CLB_CODIGO,  '+
                   '  tb_vendedor.CLB_AQ_COM_SRV, '+
                   '  tb_vendedor.CLB_COM_SRV,  '+
                   '  NFL_VL_TL_NOTA '+
                   'FROM TB_FINANCEIRO tb_financeiro '+
                   '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal '+
                   '  ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
                   '  INNER JOIN TB_PEDIDO tb_pedido '+
                   '  ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
                   '  INNER JOIN TB_COLABORADOR tb_vendedor                    '+
                   '  ON (tb_vendedor.CLB_CODIGO = tb_pedido.PED_CODVDO)       '+
                   '  INNER JOIN TB_CARGO tb_cargo                             '+
                   '  ON (tb_cargo.CRG_CODIGO = tb_vendedor.CLB_CODCRG)        '+
                   '  INNER JOIN TB_ITENS_NFL tb_itens_nfl                     '+
                   '  ON (tb_itens_nfl.ITF_CODPED = tb_pedido.PED_CODIGO)      '+
                   '  INNER JOIN TB_PRODUTO tb_produto                         '+
                   '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO)     '+
                   'WHERE (FIN_CODIGO = :FIN_CODIGO) AND (PRO_TIPO = ''S'')    '+
                   'AND (CRG_DESCRICAO LIKE :CRG_DESCRICAO)                     ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CRG_DESCRICAO').AsString := 'VENDEDOR%';
      ParamByName('FIN_CODIGO').AsInteger := Pc_cd_Financeiro;
      Active := True;
      FetchAll;
      First;
      Lc_Vl_Comissao := 0;
      Lc_Cd_Colab := FieldByName('CLB_CODIGO').AsInteger;
      if (FieldByName('CLB_AQ_COM_SRV').AsFloat > 0) or (FieldByName('CLB_COM_SRV').AsString = 'S') then
      Begin
        Lc_VL_Doc := 0;
        while not Eof do
        begin
          Lc_Tx_Baixa_Pagto := (FieldByName('FIN_VL_PAGO').AsCurrency / FieldByName('NFL_VL_TL_NOTA').AsCurrency);
          Lc_VL_Doc := Lc_VL_Doc + ((FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto));
          if (Lc_Qry.FieldByName('CLB_COM_SRV').AsString = 'S') then
          Begin
            Lc_Calculo := (FieldByName('ITF_VL_SUBTOTAL').AsCurrency * Lc_Tx_Baixa_Pagto) * (FieldByName('ITF_AQ_COM').AsFloat / 100);
            Lc_Vl_Comissao := Lc_Vl_Comissao + Lc_Calculo;
          end;
          Next;
        end;
      end;

      if (FieldByName('CLB_AQ_COM_SRV').AsFloat > 0)  then
      Begin
        Lc_Vl_Comissao := Lc_Vl_Comissao + (Lc_VL_Doc * (FieldByName('CLB_AQ_COM_SRV').AsFloat / 100));
      end;

      //Calcular as comissões
      If (Lc_Vl_Comissao > 0) then
      Begin
        Pc_Comissao(Pc_Transacao,
                    Lc_Qry.FieldByName('FIN_DT_PAGTO').AsDateTime,
                    Lc_Qry.FieldByName('PED_CODIGO').AsInteger,
                    Lc_Qry.FieldByName('FIN_CODIGO').AsInteger,
                    Lc_Qry.FieldByName('NFL_CODEMP').AsInteger,
                    Lc_Cd_Colab,
                    Lc_VL_Doc,
                    Lc_Vl_Comissao,
                    'S');
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

{I}
procedure Pc_Ins_Vdo_Itf_Vda(Pc_Transacao : TSTTransaction;
                             Pc_Cd_Item: Integer;
                             Pc_Cd_Pedido: Integer;
                             Pc_Cd_Vendedor: Integer;
                             Pc_tp_Edicao : String;
                             Pc_Aq_Com: Real);
Var
  Lc_Txt: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Sqltxt : sTRING;
begin
  if (Pc_Aq_Com > 0) then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        Lc_Txt := 'UPDATE OR INSERT INTO TB_VENDEDOR(   '+
                  '  VEN_CODITF,'+
                  '  VEN_CODPED,'+
                  '  VEN_CODCLB,'+
                  '  VEN_EDICAO,'+
                  '  VEN_PROPORCAO)'+
                  'VALUES('+
                  '  :VEN_CODITF,'+
                  '  :VEN_CODPED,'+
                  '  :VEN_CODCLB,'+
                  '  :VEN_EDICAO,'+
                  '  :VEN_PROPORCAO)'+
                  'MATCHING (VEN_CODITF,VEN_CODCLB) ';
        SQL.Add(Lc_Txt);
        // Preenche Parametros.
        ParamByName('VEN_CODITF').AsInteger := Pc_Cd_Item;
        ParamByName('VEN_CODPED').AsInteger := Pc_Cd_Pedido;
        ParamByName('VEN_CODCLB').AsInteger := Pc_Cd_Vendedor;
        ParamByName('VEN_EDICAO').AsString := Pc_tp_Edicao;
        ParamByName('VEN_PROPORCAO').AsFloat := Pc_Aq_Com;
        ExecSQL;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  End;
end;

procedure Pc_Ins_Tec_Itf_Srv(Pc_Transacao : TSTTransaction;
                             Pc_Cd_Item: Integer;
                             Pc_Cd_Pedido: Integer;
                             Pc_Cd_Tecnico: Integer;
                             Pc_Proporcao: Real;
                             Pc_Tp_Vinculo:String);
Var
  Lc_Ins: TSTQuery;
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Ins := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Txt := 'SELECT TEC_CODIGO FROM TB_TECNICO '+
                'WHERE (TEC_CODITF=:TEC_CODITF) AND (TEC_CODCLB=:TEC_CODCLB) ';

      Lc_Qry.SQL.Add(Lc_Txt);
      Lc_Qry.ParamByName('TEC_CODITF').AsInteger := Pc_Cd_Item;
      Lc_Qry.ParamByName('TEC_CODCLB').AsInteger := Pc_Cd_Tecnico;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;
      Lc_Qry.First;

      if (Pc_Proporcao = 0) then
      Begin
        Lc_Ins.close;
        Lc_Ins.SQL.Clear;
        Lc_Txt := 'DELETE FROM TB_TECNICO         '+
                  ' WHERE (TEC_CODITF=:TEC_CODITF) '+
                  ' AND (TEC_CODCLB=:TEC_CODCLB)   ';

        Lc_Ins.SQL.Add(Lc_Txt);
        // Preenche Parametros.
        Lc_Ins.ParamByName('TEC_CODITF').AsInteger := Pc_Cd_Item;
        Lc_Ins.ParamByName('TEC_CODCLB').AsInteger := Pc_Cd_Tecnico;
        Lc_Ins.Active := True;
        if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
        exit;
      end;

      if (Lc_Qry.RecordCount > 0) then
      Begin
        Lc_Ins.close;
        Lc_Ins.SQL.Clear;
        Lc_Txt := 'UPDATE TB_TECNICO SET           '+
                  '  TEC_PROPORCAO =:TEC_PROPORCAO '+
                  ' WHERE (TEC_CODITF=:TEC_CODITF) '+
                  ' AND (TEC_CODCLB=:TEC_CODCLB)   ';

        Lc_Ins.SQL.Add(Lc_Txt);
        // Preenche Parametros.
        Lc_Ins.ParamByName('TEC_CODITF').AsInteger := Pc_Cd_Item;
        Lc_Ins.ParamByName('TEC_CODCLB').AsInteger := Pc_Cd_Tecnico;
        Lc_Ins.ParamByName('TEC_PROPORCAO').AsFloat := Pc_Proporcao;
        Lc_Ins.Active := True;
        if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
      end ;

      if (Lc_Qry.RecordCount = 0) then
      Begin
        Lc_Ins.close;
        Lc_Ins.SQL.Clear;

        Lc_Txt := 'INSERT INTO TB_TECNICO( '+
                  '  TEC_CODIGO,'+
                  '  TEC_CODITF,'+
                  '  TEC_CODPED,'+
                  '  TEC_CODCLB,'+
                  '  TEC_PROPORCAO, '+
                  '  TEC_TP_VCL) '+
                  'VALUES( '+
                  '  :TEC_CODIGO,'+
                  '  :TEC_CODITF,'+
                  '  :TEC_CODPED,'+
                  '  :TEC_CODCLB,'+
                  '  :TEC_PROPORCAO,'+
                  '  :TEC_TP_VCL)';
        Lc_Ins.SQL.Add(Lc_Txt);
        // Preenche Parametros.
        Lc_Ins.ParamByName('TEC_CODIGO').AsInteger := Fc_Generator('GN_TECNICO','TB_TECNICO','TEC_CODIGO');
        Lc_Ins.ParamByName('TEC_CODITF').AsInteger := Pc_Cd_Item;
        Lc_Ins.ParamByName('TEC_CODPED').AsInteger := Pc_Cd_Pedido;
        Lc_Ins.ParamByName('TEC_CODCLB').AsInteger := Pc_Cd_Tecnico;
        Lc_Ins.ParamByName('TEC_PROPORCAO').AsFloat := Pc_Proporcao;
        Lc_Ins.ParamByName('TEC_TP_VCL').AsString := Pc_Tp_Vinculo;
        Lc_Ins.Active := True;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Ins);
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure PreecheAliquotaZero(Pc_Transacao : TSTTransaction;Pc_Cd_Pedido: Integer);
var
   Lc_Cd_Colab: Integer;
   Lc_Vl_Comissao: Real;
   Lc_VL_Doc: Real;
   Lc_Calculo: Real;
   Lc_Com_Venda: Boolean;
   Lc_SqlTxt : String;
   Lc_Qry : TSTQuery;
   Lc_QrAcao : TSTQuery;
   Lc_Tx_Baixa_Pagto : Real;
   LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.Create(nil);
    Lc_QrAcao := LcBase.GeraQuery;
    with Lc_QrAcao do
    Begin
      SQL.Add(concat(
                  'UPDATE TB_ITENS_NFL SET ',
                  'ITF_AQ_COM=:ITF_AQ_COM ',
                  'WHERE ITF_CODIGO=:ITF_CODIGO'
      ));

    End;

    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'select i.itf_codigo, pr.prc_aq_com ',
              'from tb_itens_nfl i ',
              '  inner join tb_pedido p ',
              '  on (p.ped_codigo = i.itf_codped) ',
              '  inner join tb_colaborador c ',
              '  on (c.clb_codigo = p.ped_codvdo) ',
              '  inner join tb_preco pr ',
              '  on (pr.prc_codpro = i.itf_codpro) and (i.itf_codtpr = pr.prc_codtpr) ',
              'where PED_CODIGO=:PED_CODIGO '

      ));
      ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      while not Eof do
      begin
        if NOT Pc_Transacao.InTransaction then Pc_Transacao.StartTransaction;
        Lc_QrAcao.Active := false;
        Lc_QrAcao.ParamByName('ITF_AQ_COM').AsFloat := FieldByNAme('prc_aq_com').AsFloat;
        Lc_QrAcao.ParamByName('ITF_CODIGO').AsInteger := FieldByNAme('ITF_CODIGO').AsInteger;
        Lc_QrAcao.ExecSQL;
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_QrAcao);
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;
{R}
procedure Pc_Registra_Vdo_Pedido(Pc_Transacao : TSTTransaction; Pc_Cd_Pedido: Integer);
Var
  Lc_Aq_Com : Real;
  Lc_I : Integer;
begin
  It_Reg_Comissao := Fc_DefineVendedor(Pc_Cd_Pedido);
  with It_Registra_Vdo_Pedido do
  Begin
    close;
    ParamByName('ITF_CODPED').AsInteger := Pc_Cd_Pedido;
    Active := True;
    FetchAll;
	  For Lc_I := 0 to It_Reg_Comissao.It_Qt_Vendedores -1 do
		begin
    {$R-}
      First;
      while not Eof do
      begin
        if (It_Reg_Comissao.It_Mtz_Vendedores[2,Lc_I] = 'S') then
        begin
          if It_Reg_Comissao.It_Mtz_Vendedores[3,Lc_I] = 'C' then
            Lc_Aq_Com := StrToFloatDef(It_Reg_Comissao.It_Mtz_Vendedores[1,Lc_I],0) + FieldByName('ITF_AQ_COM').AsFloat
          else
            Lc_Aq_Com := FieldByName('ITF_AQ_COM').AsFloat;

          Pc_Ins_Vdo_Itf_Vda(Pc_Transacao,
                             FieldByName('ITF_CODIGO').AsInteger,
                             FieldByName('ITF_CODPED').AsInteger,
                             StrToIntDef(It_Reg_Comissao.It_Mtz_Vendedores[0,Lc_I],0),
                             'A',
                             Lc_Aq_Com);
        end
        else
        begin
          if It_Reg_Comissao.It_Mtz_Vendedores[3,Lc_I] = 'C' then
            Lc_Aq_Com := StrToFloatDef(It_Reg_Comissao.It_Mtz_Vendedores[1,Lc_I],0)
          else
            Lc_Aq_Com := FieldByName('ITF_AQ_COM').AsFloat;

          Pc_Ins_Vdo_Itf_Vda(Pc_Transacao,
                             FieldByName('ITF_CODIGO').AsInteger,
                             FieldByName('ITF_CODPED').AsInteger,
                             StrToIntDef(It_Reg_Comissao.It_Mtz_Vendedores[0,Lc_I],0),
                             'A',
                             Lc_Aq_Com);
        end;
		    Next;
	  	end;
    {$R+}
    end;
  End;
end;



end.

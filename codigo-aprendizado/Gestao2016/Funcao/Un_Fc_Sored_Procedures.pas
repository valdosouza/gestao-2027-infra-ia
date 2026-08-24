{------------------------------------------------------------
 Funcao : Esta unidade contém uma biblioteca de funções
 para controlar as Stored procedures
 -----------------------------------------------------------}
unit Un_Fc_Sored_Procedures;

interface

uses
      ControllerComissao, STDatabase, SysUtils, STTransaction, STQuery, Datasnap.DBClient, Vcl.Dialogs, ControllerItensICMS, ControllerBase, ControllerItensNFL, ControllerOperationsLog, ControllerFinanceiro, ControllerMovimentoFinanceiro, ControllerNotaFiscal, ControllerFichaTecnica;


{A}

Function GeraStored():TSTTransaction;

function Fc_AtualizaItensNfl( Pc_Transacao : TSTTransaction;
                              Pc_Operacao: string;
                              Pc_Cd_Item: Integer;
                              Pc_Cd_Pedido: Integer;
                              Pc_Cd_Nota: Integer;
                              Pc_Cd_Produto: Integer;
                              Pc_Qtde: Real;
                              Pc_VL_Custo: Real;
                              Pc_VL_Unitario: Real;
                              Pc_AQ_Desconto: Real;
                              Pc_VL_Desconto: Real;
                              Pc_Aliq_COM: Real;
                              Pc_OPER: string;
                              Pc_Estoque: string;
                              Pc_Despacho: string;
                              Pc_Aliq_IPI: Real;
                              Pc_Aliq_ICMS: Real;
                              Pc_Cd_Estoque: Integer;
                              Pc_Cd_Tabela: Integer;
                              Pc_sentido:String;
                              Pc_Imp_Aprox:Real;
                              Pc_Largura:Real;
                              Pc_Altura:Real):Integer;

Function Fc_AtualizaItensNflBcoDestino( Pc_DataBase : TSTDatabase;
                                        Pc_Transacao : TSTTransaction;
                                        Pc_Operacao: string;
                                        Pc_Cd_Item: Integer;
                                        Pc_Cd_Pedido: Integer;
                                        Pc_Cd_Nota: Integer;
                                        Pc_Cd_Produto: Integer;
                                        Pc_Qtde: Real;
                                        Pc_VL_Custo: Real;
                                        Pc_VL_Unitario: Real;
                                        Pc_AQ_Desconto: Real;
                                        Pc_VL_Desconto: Real;
                                        Pc_Aliq_COM: Real;
                                        Pc_OPER: string;
                                        Pc_Estoque: string;
                                        Pc_Despacho: string;
                                        Pc_Aliq_IPI: Real;
                                        Pc_Aliq_ICMS: Real;
                                        Pc_Cd_Estoque: Integer;
                                        Pc_Cd_Tabela: Integer;
                                        pc_sentido:String;
                                        Pc_Imp_Aprox:Real):Integer;                              



{B}

procedure Pc_Comissao(Pc_Transacao : TSTTransaction;
                      Pc_Data: TDate;
                      Pc_Cd_Pedido: Integer;
                      Pc_Cd_Financeiro: Integer;
                      Pc_Cd_Empresa: Integer;
                      Pc_Cd_Vendedor: Integer;
                      Pc_Vl_Documento: Real;
                      Pc_Vl_Comissao: Real;
                      Pc_Tipo:String);                     

{E}


{F}
procedure Pc_Fr_FichaTecnica(Pc_Operacao : String;
                             Pc_Cd_ficha : Integer;
                             Pc_tipo : String;
                             Pc_Cd_Ict:Integer;
                             Pc_Cd_Itf:Integer;
                             Pc_Codvcl : Integer;
                             Pc_Produto : String;
                             Pc_Unidade : String;
                             Pc_Vl_Unit : real;
                             Pc_Cs_Unit : real;
                             Pc_Tx_Partic : real;
                             Pc_CodPro :integer);

procedure Pc_Financeiro(Pc_Transacao : TSTTransaction;
                         Pc_Oper_reg: string;
                         Pc_CODIGO: Integer;
                         Pc_CODEMP: Integer;
                         Pc_DATA: TDate;
                         Pc_CODPED: Integer;
                         Pc_CODNFL: Integer;
                         Pc_CODFPG: Integer;
                         Pc_PRAZO: string;
                         Pc_DT_VENCIMENTO: TDate;
                         Pc_NUMERO: string;
                         Pc_VL_PARCELA: Real;
                         Pc_VL_JUROS: Real;
                         Pc_VL_MORA: Real;
                         Pc_VL_DESCONTO: Real;
                         Pc_VL_PAGO: Real;
                         Pc_DT_PAGTO: TDate;
                         Pc_DT_BAIXA: TDate;
                         Pc_BAIXA: string;
                         Pc_NR_PARCELA: Integer;
                         Pc_TIPO: string;
                         Pc_SITUACAO: string;
                         Pc_CODQTC: Integer;
                         PC_Operacao: string;
                         Pc_Etapa: string;
                         Pc_cd_Cheque : Integer);

{L}
procedure Pc_Log_Sistema( pc_log_codmha    : Integer;
                          pc_log_codusu    : Integer;
                          pc_log_timeStamp : TDateTime;
                          pc_log_interface : String;
                          pc_log_registro  : Integer;
                          pc_log_operacao  : String;
                          pc_log_descricao : String );
{M}
procedure Pc_Movim_Financeiro(Pc_Transacao : TSTTransaction;
                              PC_OPERACAO : String;
                              PC_CODIGO : Integer;
                              PC_CODCTB : Integer;
                              PC_DATA : TDate;
                              PC_CODHTB : Integer;
                              PC_CODPLC_C : Integer;
                              PC_CODPLC_D : Integer;
                              PC_VL_CREDITO :Real;
                              PC_VL_DEBITO :Real;
                              PC_HISTORISCO : String;
                              PC_TIPO : String;
                              PC_CODQTC : Integer;
                              PC_CODUSU : Integer;
                              PC_VL_FUTURO :Real;
                              PC_DT_ORIG : TDate;
                              PC_NR_DOC : String;
                              PC_CONFERIDO : String;
                              PC_ESPECIE : String;
                              PC_CODMHA : Integer;
                              PC_CODFPT : Integer);

{N}
procedure Pc_NotaFiscal(Pc_Transacao : TSTTransaction;
                        Pc_Cd_Nota : Integer;
                        Pc_Tp_Operacao : String;
                        Pc_Finalidade:Integer;
                        Pc_Nr_Nota : String;
                        Pc_Serie : Integer;
//                        /Pc_Modelo : String;
                        Pc_Cd_CFOP : Integer;
                        Pc_Cd_Pedido : Integer;
                        Pc_Cd_Empresa : Integer;
                        Pc_Dt_Emissao : TDate;
                        Pc_Dt_Saida : String;
                        Pc_Time :TTime;
                        Pc_VL_Bs_ICMS : Real;
                        Pc_VL_ICMS : Real;
                        Pc_Vl_Bs_Icms_St : Real;
                        Pc_Vl_Icms_St : Real;
                        Pc_VL_Produto : Real;
                        Pc_VL_Frete : Real;
                        Pc_Vl_Seguro : Real;
                        PC_Vl_Outras : Real;
                        Pc_VL_IPI : Real;
                        PC_VL_Nota : Real;
                        Pc_Cd_Transporte : Integer;
                        Pc_Cta_Frete : Integer;
                        Pc_Qt_Produto : Real;
                        Pc_Especie : String;
                        Pc_Marca : String;
                        PC_PesoBruto : String;
                        PC_PesoLiq : String;
                        Pc_Ctrl_Retorno : String;
                        Pc_Nfl_Vinculo : String;
                        Pc_Status : String;
                        Pc_VL_TL_Servicos : Real;
                        Pc_VL_ISS : Real;
                        Pc_Nr_Volume : String;
                        PC_PlacaVeiculo : String;
                        Pc_Uf_Veiculo : String;
                        Pc_RNTC : String;
                        Pc_CodMha : Integer);
{O}
procedure Pc_Observacao(Pc_Transacao : TSTTransaction;
                        Pc_Operacao : String;
                        Pc_CODIGO : Integer;
                        Pc_CODITF : Integer;
                        Pc_CODNFL : Integer;
                        Pc_TIPO : String;
                        Pc_DETALHE : String);


{V}


implementation

uses     Un_DM, UN_Sistema, UN_MSG, Un_Regra_Negocio, UN_Principal, env, RI_MovimentoFinanceiro;
Function GeraStored():TSTTransaction;
begin
  Result := TSTTransaction.Create(nil);
  Result.DefaultDatabase := DM.IBD_Gestao;
  Result.Params.Clear;
  Result.Params.Add('read_committed');
  Result.Params.Add('rec_version');
  Result.Params.Add('wait');
end;


Function Fc_AtualizaItensNfl(Pc_Transacao : TSTTransaction;
                              Pc_Operacao: string;
                              Pc_Cd_Item: Integer;
                              Pc_Cd_Pedido: Integer;
                              Pc_Cd_Nota: Integer;
                              Pc_Cd_Produto: Integer;
                              Pc_Qtde: Real;
                              Pc_VL_Custo: Real;
                              Pc_VL_Unitario: Real;
                              Pc_AQ_Desconto: Real;
                              Pc_VL_Desconto: Real;
                              Pc_Aliq_COM: Real;
                              Pc_OPER: string;
                              Pc_Estoque: string;
                              Pc_Despacho: string;
                              Pc_Aliq_IPI: Real;
                              Pc_Aliq_ICMS: Real;
                              Pc_Cd_Estoque: Integer;
                              Pc_Cd_Tabela: Integer;
                              pc_sentido:String;
                              Pc_Imp_Aprox:Real;
                              Pc_Largura:Real;
                              Pc_Altura:Real):Integer;
Var
  Lc_Item : TControllerItensNFL;
begin
  Try
    Try
      Lc_Item := TControllerItensNFL.Create(nil);
      with Lc_Item.Registro do
      Begin
        Codigo            := Pc_Cd_Item;
        Sequencia         := 0;
        CodigoPedido      := Pc_Cd_Pedido;
        CodigoNota        := Pc_Cd_Nota;
        CodigoProduto     := Pc_Cd_Produto;
        Quantidade        := Pc_Qtde;
        ValorCusto        := Pc_Vl_custo;
        ValorUnitario     := Pc_Vl_Unitario;
        Despachar         := 'N';
        Estoque           := Pc_Estoque;
        AliqComissao      := Pc_Aliq_COM;
        ValorDesconto     := Pc_VL_Desconto;
        AliqDesconto      := Pc_AQ_Desconto;
        AliqIPI           := Pc_Aliq_IPI;
        Operacao          := Pc_OPER;
        AliqICMS          := Pc_Aliq_ICMS;
        CodigoEstoque     := Pc_Cd_Estoque;
        CodigoTabela      := Pc_Cd_Tabela;
        Altura            := Pc_ALtura;
        Largura           := Pc_Largura;
        Sentido           := Pc_Sentido;
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := Pc_Imp_Aprox;
        NumeroPecas       := 0;
      End;
      if Pc_Cd_Item = 0 then
      Begin
        lc_Item.insere;
      end
      else
      Begin
        lc_Item.atualiza;
      end;
      Result := lc_Item.Registro.Codigo;
    except
      on E : Exception do
      Begin
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'Por favor Informe este erro ao Desenvolvedor.' + EOLN +
                       'V2: ' + E.Message + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := 0;
    End;
  end;
  Finally
    FreeAndNil(Lc_Item);
  End;
end;

Function Fc_AtualizaItensNflBcoDestino( Pc_DataBase : TSTDatabase;
                                        Pc_Transacao : TSTTransaction;
                                        Pc_Operacao: string;
                                        Pc_Cd_Item: Integer;
                                        Pc_Cd_Pedido: Integer;
                                        Pc_Cd_Nota: Integer;
                                        Pc_Cd_Produto: Integer;
                                        Pc_Qtde: Real;
                                        Pc_VL_Custo: Real;
                                        Pc_VL_Unitario: Real;
                                        Pc_AQ_Desconto: Real;
                                        Pc_VL_Desconto: Real;
                                        Pc_Aliq_COM: Real;
                                        Pc_OPER: string;
                                        Pc_Estoque: string;
                                        Pc_Despacho: string;
                                        Pc_Aliq_IPI: Real;
                                        Pc_Aliq_ICMS: Real;
                                        Pc_Cd_Estoque: Integer;
                                        Pc_Cd_Tabela: Integer;
                                        pc_sentido:String;
                                        Pc_Imp_Aprox:Real):Integer;
Var
  Lc_Item : TControllerItensNFL;
begin
  Result := 0;
  Lc_Item := TControllerItensNFL.Create(nil);
  try
    Lc_Item.DataBase := Pc_DataBase;
    with Lc_Item.Registro do
    Begin
      Codigo            := Pc_Cd_Item;
      Sequencia         := 0;
      CodigoPedido      := Pc_Cd_Pedido;
      CodigoNota        := Pc_Cd_Nota;
      CodigoProduto     := Pc_Cd_Produto;
      Quantidade        := Pc_Qtde;
      ValorCusto        := Pc_VL_Custo;
      ValorUnitario     := Pc_VL_Unitario;
      Despachar         := Pc_Despacho;
      Estoque           := Pc_Estoque;
      AliqComissao      := Pc_Aliq_COM;
      ValorDesconto     := Pc_VL_Desconto;
      AliqDesconto      := Pc_AQ_Desconto;
      AliqIPI           := Pc_Aliq_IPI;
      Operacao          := Pc_OPER;
      AliqICMS          := Pc_Aliq_ICMS;
      CodigoEstoque     := Pc_Cd_Estoque;
      CodigoTabela      := Pc_Cd_Tabela;
      Altura            := 0;
      Largura           := 0;
      Sentido           := Pc_sentido;
      PedidoCompra      := '';
      ItemCompra        := '';
      ImpostoAproximado := Pc_Imp_Aprox;
      NumeroPecas       := 0;
    End;
    if Pc_Cd_Item = 0 then
    Begin
      Lc_Item.Registro.Codigo := Fc_GeneratorBcoDestino(Pc_DataBase, Pc_Transacao, 'GN_ITENS_NFL','','ITF_CODIGO');
      Lc_Item.migra;
    end
    else
      Lc_Item.atualiza;
    if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
    Result := Lc_Item.Registro.Codigo;
  finally
    FreeAndNil(Lc_Item);
  end;
end;

{B}

{C}

procedure Pc_Comissao(Pc_Transacao : TSTTransaction;
                      Pc_Data: TDate;
                      Pc_Cd_Pedido: Integer;
                      Pc_Cd_Financeiro: Integer;
                      Pc_Cd_Empresa: Integer;
                      Pc_Cd_Vendedor: Integer;
                      Pc_Vl_Documento: Real;
                      Pc_Vl_Comissao: Real;
                      Pc_Tipo:String);
Var
  LcComissao : TControllerComissao;
begin
  TRy
    LcComissao := TControllerComissao.create(nil);
    with LcComissao.registro do
    BEgin
      Codigo          := 0;
      DataVenda       := Pc_Data;
      Pedido          := Pc_Cd_Pedido;
      Cliente         := Pc_Cd_Empresa;
      Vendedor        := Pc_Cd_Vendedor;
      valorDocumento  := Pc_Vl_Documento;
      if (Pc_Vl_Documento <> 0) then
        Aliquota := (Pc_Vl_Comissao / Pc_Vl_Documento) * 100
      else
        Aliquota := (Pc_Vl_Comissao / 1) * 100;
      valorComissao   := Pc_Vl_Comissao;
      Estabelecimento := Gb_CodMha;
      DataPagto       := 0;
      Financeiro      := Pc_Cd_Financeiro;
      Tipo            := Pc_Tipo;
    End;
    LcComissao.Insert;
  Finally
    FreeAndNil( LcComissao );
  End;
end;

{E}

{F}
procedure Pc_Fr_FichaTecnica(Pc_Operacao : String;
                             Pc_Cd_ficha : Integer;
                             Pc_tipo : String;
                             Pc_Cd_Ict:Integer;
                             Pc_Cd_Itf:Integer;
                             Pc_Codvcl : Integer;
                             Pc_Produto : String;
                             Pc_Unidade : String;
                             Pc_Vl_Unit : real;
                             Pc_Cs_Unit : real;
                             Pc_Tx_Partic : real;
                             Pc_CodPro :integer);
Var
  LcFicha : TControllerFichaTecnica;
begin
  LcFicha := TControllerFichaTecnica.Create(nil);
  try
    with LcFicha.Registro do
    Begin
      if Pc_Operacao = 'I' then
      begin
        if Pc_Cd_ficha = 0 then
          Pc_Cd_ficha := Fc_Generator('GN_FICHA_TECNICA','','FTC_CODIGO');
      end;
      Codigo := Pc_Cd_ficha;
      CodigoCotacaoItem := Pc_Cd_Ict;
      CodigoItemNfl := Pc_Cd_Itf;
      Tipo := Pc_Tipo;
      CodigoVcl := Pc_CodVcl;
      DescricaoInsumo := Pc_Produto;
      Unidade := Pc_Unidade;
      ValorUnitario := Pc_Vl_Unit;
      CustoUnitario := Pc_Cs_Unit;
      TaxaParticipacao := Pc_Tx_Partic;
      CodigoProduto := Pc_CodPro;
    end;
    if Pc_Operacao = 'I' then
      LcFicha.migra
    else if Pc_Operacao = 'E' then
      LcFicha.update
    else if Pc_Operacao = 'A' then
      LcFicha.delete;
  finally
    FreeAndNil(LcFicha);
  end;
end;

procedure Pc_Financeiro(Pc_Transacao : TSTTransaction;
                         Pc_Oper_reg: string;
                         Pc_CODIGO: Integer;
                         Pc_CODEMP: Integer;
                         Pc_DATA: TDate;
                         Pc_CODPED: Integer;
                         Pc_CODNFL: Integer;
                         Pc_CODFPG: Integer;
                         Pc_PRAZO: string;
                         Pc_DT_VENCIMENTO: TDate;
                         Pc_NUMERO: string;
                         Pc_VL_PARCELA: Real;
                         Pc_VL_JUROS: Real;
                         Pc_VL_MORA: Real;
                         Pc_VL_DESCONTO: Real;
                         Pc_VL_PAGO: Real;
                         Pc_DT_PAGTO: TDate;
                         Pc_DT_BAIXA: TDate;
                         Pc_BAIXA: string;
                         Pc_NR_PARCELA: Integer;
                         Pc_TIPO: string;
                         Pc_SITUACAO: string;
                         Pc_CODQTC: Integer;
                         PC_Operacao: string;
                         Pc_Etapa: string;
                         Pc_cd_Cheque : Integer);
Var
  LcFin : TControllerFinanceiro;
  Lc_Qry : TSTQuery;
begin
  LcFin := TControllerFinanceiro.Create(nil);
  try
    try
      with LcFin.Registro do
      Begin
        Codigo := Pc_CODIGO;
        CodigoEmpresa := Pc_CODEMP;
        DataFinanceiro := Pc_DATA;
        CodigoPedido := Pc_CODPED;
        CodigoNota := Pc_CODNFL;
        FormaPagamento := Pc_CODFPG;
        PrazoPagamento := Pc_PRAZO;
        DataVencimento := Pc_DT_VENCIMENTO;
        NumeroDuplicata := Pc_NUMERO;
        ValorParcela := Pc_VL_PARCELA;
        ValorJuros := Pc_VL_JUROS;
        ValorMora := Pc_VL_MORA;
        ValorDesconto := Pc_VL_DESCONTO;
        ValorPago := Pc_VL_PAGO;
        if (Pc_Oper_reg = 'I') and (Pc_BAIXA = 'N') then
        begin
          DataPagamento := 0;
          DataBaixa := 0;
        end
        else
        begin
          DataPagamento := Pc_DT_PAGTO;
          DataBaixa := Pc_DT_BAIXA;
        end;
        DocumentoBaixado := Pc_BAIXA;
        NumeroParcela := Pc_NR_PARCELA;
        TipoFinanceiro := Pc_TIPO;
        SituacaoFinanceiro := Pc_SITUACAO;
        CodigoQuitacao := Pc_CODQTC;
        OperacaoFinanceiro := PC_Operacao;
        EtapaFinaceiro := Pc_Etapa;
        Estabelecimento := Gb_CodMha;
        CodigoCheque := Pc_cd_Cheque;
      End;

      if Pc_Oper_reg = 'I' then
      begin
        if LcFin.Registro.Codigo = 0 then
          LcFin.insere
        else
          LcFin.migra;
      end
      else if Pc_Oper_reg = 'E' then
      begin
        Lc_Qry := LcFin.GeraQuery;
        try
          with Lc_Qry do
          begin
            SQL.Add('UPDATE TB_FINANCEIRO SET '+
                    'FIN_CODFPG=:FIN_CODFPG,'+
                    'FIN_DT_VENCIMENTO=:FIN_DT_VENCIMENTO,'+
                    'FIN_VL_JUROS=:FIN_VL_JUROS,'+
                    'FIN_VL_MORA=:FIN_VL_MORA,'+
                    'FIN_VL_DESCONTO=:FIN_VL_DESCONTO,'+
                    'FIN_VL_PAGO=:FIN_VL_PAGO,'+
                    'FIN_DT_PAGTO=:FIN_DT_PAGTO '+
                    'WHERE FIN_CODIGO=:FIN_CODIGO');
            ParamByName('FIN_CODFPG').AsInteger := Pc_CODFPG;
            ParamByName('FIN_DT_VENCIMENTO').AsDateTime := Pc_DT_VENCIMENTO;
            ParamByName('FIN_VL_JUROS').AsCurrency := Pc_VL_JUROS;
            ParamByName('FIN_VL_MORA').AsCurrency := Pc_VL_MORA;
            ParamByName('FIN_VL_DESCONTO').AsCurrency := Pc_VL_DESCONTO;
            ParamByName('FIN_VL_PAGO').AsCurrency := Pc_VL_PAGO;
            ParamByName('FIN_DT_PAGTO').AsDateTime := Pc_DT_PAGTO;
            ParamByName('FIN_CODIGO').AsInteger := Pc_CODIGO;
            ExecSQL;
          end;
        finally
          LcFin.FinalizaQuery(Lc_Qry);
        end;
      end
      else if Pc_Oper_reg = 'D' then
      begin
        Lc_Qry := LcFin.GeraQuery;
        try
          with Lc_Qry do
          begin
            SQL.Add('UPDATE TB_FINANCEIRO SET '+
                    'FIN_CODFPG=:FIN_CODFPG,'+
                    'FIN_VL_JUROS=:FIN_VL_JUROS,'+
                    'FIN_VL_MORA=:FIN_VL_MORA,'+
                    'FIN_VL_DESCONTO=:FIN_VL_DESCONTO,'+
                    'FIN_SITUACAO=:FIN_SITUACAO,'+
                    'FIN_CODQTC=:FIN_CODQTC '+
                    'WHERE FIN_CODIGO=:FIN_CODIGO');
            ParamByName('FIN_CODFPG').AsInteger := Pc_CODFPG;
            ParamByName('FIN_VL_JUROS').AsCurrency := Pc_VL_JUROS;
            ParamByName('FIN_VL_MORA').AsCurrency := Pc_VL_MORA;
            ParamByName('FIN_VL_DESCONTO').AsCurrency := Pc_VL_DESCONTO;
            ParamByName('FIN_SITUACAO').AsString := Pc_SITUACAO;
            ParamByName('FIN_CODQTC').AsInteger := Pc_CODQTC;
            ParamByName('FIN_CODIGO').AsInteger := Pc_CODIGO;
            ExecSQL;
          end;
        finally
          LcFin.FinalizaQuery(Lc_Qry);
        end;
      end
      else if Pc_Oper_reg = 'B' then
      begin
        Lc_Qry := LcFin.GeraQuery;
        try
          with Lc_Qry do
          begin
            SQL.Add('UPDATE TB_FINANCEIRO SET '+
                    'FIN_CODFPG=:FIN_CODFPG,'+
                    'FIN_VL_PARCELA=:FIN_VL_PARCELA,'+
                    'FIN_DT_VENCIMENTO=:FIN_DT_VENCIMENTO,'+
                    'FIN_VL_JUROS=:FIN_VL_JUROS,'+
                    'FIN_VL_MORA=:FIN_VL_MORA,'+
                    'FIN_VL_DESCONTO=:FIN_VL_DESCONTO,'+
                    'FIN_VL_PAGO=:FIN_VL_PAGO,'+
                    'FIN_DT_PAGTO=:FIN_DT_PAGTO,'+
                    'FIN_DT_BAIXA=:FIN_DT_BAIXA,'+
                    'FIN_BAIXA=:FIN_BAIXA,'+
                    'FIN_SITUACAO=:FIN_SITUACAO,'+
                    'FIN_CODQTC=:FIN_CODQTC '+
                    'WHERE FIN_CODIGO=:FIN_CODIGO');
            ParamByName('FIN_CODFPG').AsInteger := Pc_CODFPG;
            ParamByName('FIN_VL_PARCELA').AsCurrency := Pc_VL_PARCELA;
            ParamByName('FIN_DT_VENCIMENTO').AsDateTime := Pc_DT_VENCIMENTO;
            ParamByName('FIN_VL_JUROS').AsCurrency := Pc_VL_JUROS;
            ParamByName('FIN_VL_MORA').AsCurrency := Pc_VL_MORA;
            ParamByName('FIN_VL_DESCONTO').AsCurrency := Pc_VL_DESCONTO;
            ParamByName('FIN_VL_PAGO').AsCurrency := Pc_VL_PAGO;
            ParamByName('FIN_DT_PAGTO').AsDateTime := Pc_DT_PAGTO;
            ParamByName('FIN_DT_BAIXA').AsDateTime := Pc_DT_BAIXA;
            ParamByName('FIN_BAIXA').AsString := Pc_BAIXA;
            ParamByName('FIN_SITUACAO').AsString := Pc_SITUACAO;
            ParamByName('FIN_CODQTC').AsInteger := Pc_CODQTC;
            ParamByName('FIN_CODIGO').AsInteger := Pc_CODIGO;
            ExecSQL;
          end;
        finally
          LcFin.FinalizaQuery(Lc_Qry);
        end;
      end
      else if Pc_Oper_reg = 'A' then
        LcFin.delete
      else if Pc_Oper_reg = 'C' then
      begin
        LcFin.Registro.CodigoNota := Pc_CODNFL;
        LcFin.deleteByNota;
      end;

      if Pc_Transacao.InTransaction then
        Pc_Transacao.CommitRetaining;
    except
      on E : Exception do
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                       'Um erro impossibilitou a execução da tarefa.' + EOLN +
                        E.ClassName + EOLN+
                        E.Message + EOLN,
                       ['OK'], [bEscape], mpErro);
    end;
  finally
    FreeAndNil(LcFin);
  end;
end;

{L}
procedure Pc_Log_Sistema( pc_log_codmha    : Integer;
                          pc_log_codusu    : Integer;
                          pc_log_timeStamp : TDateTime;
                          pc_log_interface : String;
                          pc_log_registro  : Integer;
                          pc_log_operacao  : String;
                          pc_log_descricao : String );
Var
  LcTran: TSTTransaction;
  OperationsLog : TControllerOperationsLog;
begin
  OperationsLog := TControllerOperationsLog.Create(nil);

  try
    try
      with OperationsLog.Registro do
      begin
        Descricao := Copy(pc_log_descricao,1,100); //--> Descrição operação realizada
        CodMha := pc_log_codmha; //--> Código da Empresa
        CodUsu := pc_log_codusu; //--> Código do Usuário
        Hora := pc_log_timeStamp; //--> A hora e data Atual
        InterfaceLog := copy(pc_log_interface,1,30); //--> Nome da tela
        Registro := pc_log_registro; //--> Chave prmimara da Tabela Relacionada
        Operacao := copy(pc_log_operacao,1,30); //--> Tipo de Modificação
      end;
      OperationsLog.insert;
    except
      on E : Exception do
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
        'Um erro impossibilitou a gravação dos Log(s).' + EOLN +
        E.ClassName + EOLN+
        E.Message + EOLN,
        ['OK'], [bEscape], mpErro);
    end;
  finally
    FreeAndNil(OperationsLog);
  end;
end;

{M}
procedure Pc_Movim_Financeiro(Pc_Transacao : TSTTransaction;
                              PC_OPERACAO : String;
                              PC_CODIGO : Integer;
                              PC_CODCTB : Integer;
                              PC_DATA : TDate;
                              PC_CODHTB : Integer;
                              PC_CODPLC_C : Integer;
                              PC_CODPLC_D : Integer;
                              PC_VL_CREDITO :Real;
                              PC_VL_DEBITO :Real;
                              PC_HISTORISCO : String;
                              PC_TIPO : String;
                              PC_CODQTC : Integer;
                              PC_CODUSU : Integer;
                              PC_VL_FUTURO :Real;
                              PC_DT_ORIG : TDate;
                              PC_NR_DOC : String;
                              PC_CONFERIDO : String;
                              PC_ESPECIE : String;
                              PC_CODMHA : Integer;
                              PC_CODFPT : Integer);
Var
  LcMvf : TControllerMovimentoFinanceiro;
begin
  Try
    IF Gb_DataCaixa = 0 then
    Begin
      Fc_VerificaCaixaAberto(False);
    End;
    If NOT Pc_Transacao.InTransaction then Pc_Transacao.StartTransaction;
    LcMvf := TControllerMovimentoFinanceiro.Create(nil);
    try
      with LcMvf.Registro do
      begin
        if PC_OPERACAO = 'I' then
          Codigo := Fc_Generator('GN_MOVIM_FINANCEIRO','','MVF_CODIGO')
        else
          Codigo := PC_CODIGO;
        ContaCorrente := PC_CODCTB;
        Data := PC_DATA;
        HistoricoBancario := PC_CODHTB;
        PL_Credito := PC_CODPLC_C;
        PL_Debito := PC_CODPLC_D;
        ValorCredito := PC_VL_CREDITO;
        ValorDebito := PC_VL_DEBITO;
        Historico := Copy(PC_HISTORISCO,1,100);
        Tipo := PC_TIPO;
        Quitacao := PC_CODQTC;
        Usuario := PC_CODUSU;
        ValorFuturo := PC_VL_FUTURO;
        DataOriginal := PC_DT_ORIG;
        NrDocumento := PC_NR_DOC;
        Conferido := PC_CONFERIDO;
        Especie := PC_ESPECIE;
        Estabelecimento := PC_CODMHA;
        FormaPagto := PC_CODFPT;
      end;
      if PC_OPERACAO = 'I' then
        LcMvf.migra
      else if PC_OPERACAO = 'E' then
        LcMvf.atualiza
      else if PC_OPERACAO = 'A' then
        LcMvf.delete;
      if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
    finally
      FreeAndNil(LcMvf);
    end;
  Finally
  End;
end;


{N}
procedure Pc_NotaFiscal(Pc_Transacao : TSTTransaction;
                        Pc_Cd_Nota : Integer;
                        Pc_Tp_Operacao : String;
                        Pc_Finalidade:Integer;
                        Pc_Nr_Nota : String;
                        Pc_Serie : Integer;
                        //Pc_Modelo : String;
                        Pc_Cd_CFOP : Integer;
                        Pc_Cd_Pedido : Integer;
                        Pc_Cd_Empresa : Integer;
                        Pc_Dt_Emissao : TDate;
                        Pc_Dt_Saida : String;
                        Pc_Time :TTime;
                        Pc_VL_Bs_ICMS : Real;
                        Pc_VL_ICMS : Real;
                        Pc_Vl_Bs_Icms_St : Real;
                        Pc_Vl_Icms_St : Real;
                        Pc_VL_Produto : Real;
                        Pc_VL_Frete : Real;
                        Pc_Vl_Seguro : Real;
                        PC_Vl_Outras : Real;
                        Pc_VL_IPI : Real;
                        PC_VL_Nota : Real;
                        Pc_Cd_Transporte : Integer;
                        Pc_Cta_Frete : Integer;
                        Pc_Qt_Produto : Real;
                        Pc_Especie : String;
                        Pc_Marca : String;
                        PC_PesoBruto : String;
                        PC_PesoLiq : String;
                        Pc_Ctrl_Retorno : String;
                        Pc_Nfl_Vinculo : String;
                        Pc_Status : String;
                        Pc_VL_TL_Servicos : Real;
                        Pc_VL_ISS : Real;
                        Pc_Nr_Volume : String;
                        PC_PlacaVeiculo : String;
                        Pc_Uf_Veiculo : String;
                        Pc_RNTC : String;  
                        Pc_CodMha : Integer);
Var
  LcNfl : TControllerNotaFiscal;
  LcNrNota : String;
begin
  LcNfl := TControllerNotaFiscal.Create(nil);
  try
    if Pc_Tp_Operacao = 'EM' then
      LcNrNota := Pc_Nr_Nota
    else if StrToIntDef(Pc_Nr_Nota,0) > 0 then
      LcNrNota := Pc_Nr_Nota
    else
      LcNrNota := '';

    with LcNfl.Registro do
    begin
      Codigo := pc_Cd_Nota;
      Tipo := Pc_Tp_Operacao;
      Finalidade := IntToStr(Pc_Finalidade);
      Numero := LcNrNota;
      Serie := IntToStr(Pc_Serie);
      CodigoCFOP := Pc_Cd_CFOP;
      CodigoPedido := Pc_Cd_Pedido;
      CodigoEmpresa := Pc_Cd_Empresa;
      DataEmissao := Pc_Dt_Emissao;
      if Length(Pc_Dt_Saida) > 0 then
      begin
        HoraSaida := Pc_Time;
        DataSaida := StrToDate(Pc_Dt_Saida);
      end
      else
      begin
        HoraSaida := 0;
        DataSaida := 0;
      end;
      ValorBaseICMS := Pc_VL_Bs_ICMS;
      ValorICMS := Pc_VL_ICMS;
      ValorBaseICMSST := Pc_Vl_Bs_Icms_St;
      ValorICMSST := Pc_Vl_Icms_St;
      ValorProdutos := Pc_VL_Produto;
      ValorFrete := Pc_VL_Frete;
      ValorSeguro := Pc_Vl_Seguro;
      ValorOutrasDespesas := PC_Vl_Outras;
      ValorIPI := Pc_VL_IPI;
      ValorNota := PC_VL_Nota;
      CodigoTransportadora := Pc_Cd_Transporte;
      ContaFrete := Pc_Cta_Frete;
      QtdeProdutos := Pc_Qt_Produto;
      Especie := Copy(Pc_Especie,1,10);
      Marca := Copy(Pc_Marca,1,10);
      PesoBruto := Copy(PC_PesoBruto,1,10);
      PesoLiquido := Copy(PC_PesoLiq,1,10);
      ControlaRetorno := Pc_Ctrl_Retorno;
      NotaVinculada := Pc_Nfl_Vinculo;
      Situacao := Pc_Status;
      ValorServico := Pc_VL_TL_Servicos;
      ValorISS := Pc_VL_ISS;
      Pc_Nr_Volume := IntToStr(StrToIntDef(Pc_Nr_Volume,0));
      NumeroVolume := Copy(Pc_Nr_Volume,1,8);
      PlacaVeiculo := PC_PlacaVeiculo;
      EstadoVeiculo := Pc_Uf_Veiculo;
      RNTC := Copy(Pc_RNTC,1,20);
      CodigoEstabelecimento := Pc_CodMha;
    end;
    LcNfl.migra;
    if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
  finally
    FreeAndNil(LcNfl);
  end;
end;

{O}
procedure Pc_Observacao(Pc_Transacao : TSTTransaction;
                        Pc_Operacao : String;
                        Pc_CODIGO : Integer;
                        Pc_CODITF : Integer;
                        Pc_CODNFL : Integer;
                        Pc_TIPO : String;
                        Pc_DETALHE : String);
Var
  LcTran: TSTTransaction;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Sqltxt : sTRING;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if Pc_Operacao = 'I' then
      Begin
        Lc_Sqltxt := 'insert into "TB_OBS_NFE"( '+
                     '   "OBN_CODIGO"           '+
                     ' , "OBN_CODITF"           '+
                     ' , "OBN_CODNFL"           '+
                     ' , "OBN_TIPO"             '+
                     ' , "OBN_DETALHE")         '+
                     ' values(                  '+
                     '   :"OBN_CODIGO"          '+
                     ' , :"OBN_CODITF"          '+
                     ' , :"OBN_CODNFL"          '+
                     ' , :"OBN_TIPO"            '+
                     ' , :"OBN_DETALHE")        ';
        Lc_qry.SQL.Add(Lc_Sqltxt);
        Pc_Codigo := Fc_Generator('GN_OBS_NFE','','OBN_CODIGO');
        ParamByName('OBN_CODIGO').Value := Pc_codigo;
        ParamByName('OBN_CODITF').Value := Pc_coditf;
        ParamByName('OBN_CODNFL').Value := Pc_codnfl;
        //[M] MANUAL / [F] FISCAL / [A] AUTOMATICA
        ParamByName('OBN_TIPO').Value := Pc_tipo;
        ParamByName('OBN_DETALHE').Value := Pc_DETALHE;
      end
      else
      if Pc_Operacao = 'E' then
        Begin
          Lc_Sqltxt := 'update "TB_OBS_NFE" set       '+
                       ' OBN_DETALHE =:OBN_DETALHE    '+
                       'WHERE OBN_CODIGO =:OBN_CODIGO ';
          SQL.Add(Lc_Sqltxt);
          ParamByName('OBN_CODIGO').Value := Pc_codigo;
          ParamByName('OBN_DETALHE').Value := Pc_DETALHE;
        end
        else
        if Pc_Operacao = 'A' then
          Begin
            Lc_Sqltxt := 'DELETE FROM "TB_OBS_NFE"      '+
                         'WHERE OBN_CODIGO =:OBN_CODIGO ';
            SQL.Add(Lc_Sqltxt);
            ParamByName('OBN_CODIGO').Value := Pc_codigo;
          end;
      ExecSQL;
      if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


{R}

end.

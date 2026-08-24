unit ajustapedidocompra;

interface

uses
      SysUtils, StdCtrls, Classes, STQuery, STDatabase, Variants, Graphics, STTransaction;

type
  tajustaPedidoCompra = class(TComponent)

  private
    { Private declarations }

    Qr_DadosNota : TSTQuery;
    Qr_DadosPedido : TSTQuery;
    Qr_Acao : TSTQuery;

    //Informa o banco de dados
    It_BD_Gestao : TSTDatabase;
    It_Bd_transacao : TSTTransaction;
    It_CodMha : Integer;

    //Dados para encontrar a Nota
    FNumeroDaNota     : String;
    FCodigodoPedido   : Integer;
    FCodigodaEmpresa  : Integer;
    FValorTotalNota   : Real;
    FValorTotalPedido : Real;
    procedure Pc_CriaConsultas;
    Procedure Pc_IniciaVariaveis;
    Function Fc_VerificaSeExisteNota():boolean;
    procedure Pc_VerificaQuantidade;
    procedure Pc_AtualizaQuantidade;
    procedure Pc_VerificaValorUnitario;
    procedure Pc_AtualizaValorUnitario(pc_Cd_Item:Integer;Pc_Vl_Unit:Real);

  protected
    { Protected declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Function Fc_ExecutaAjuste:String;
  published
    { Published declarations }
    //Informa o banco de dados
    property BancodeDados: TSTDatabase read It_BD_Gestao write It_BD_Gestao;
    property Transacao: TSTTransaction read It_Bd_transacao write It_Bd_transacao;
    //Identificção do Estabelecimento Emissor da nota
    property Estabelecimento : Integer read It_CodMha write It_CodMha;
    //Dados da Nota
    property NumeroDaNota    : String read FNumeroDaNota write FNumeroDaNota;
    property CodigoDoPedido  : Integer read FCodigodoPedido write FCodigodoPedido;
    property CodigoDaEmpresa : Integer read FCodigodaEmpresa write FCodigodaEmpresa;

  end;

implementation

uses     DB, un_msg;
procedure tajustaPedidoCompra.Pc_CriaConsultas;
Begin
  Qr_DadosNota := TSTQuery.Create(nil);
  Qr_DadosPedido := TSTQuery.Create(nil);
  Qr_Acao := TSTQuery.Create(nil);
end;

constructor tajustaPedidoCompra.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Pc_CriaConsultas;

end;

Procedure tajustaPedidoCompra.Pc_IniciaVariaveis;
Begin
  Qr_DadosNota.Database := It_BD_Gestao;
  Qr_DadosNota.Transaction := It_Bd_transacao;
  Qr_DadosNota.ForcedRefresh := true;

  Qr_DadosNota.close;

  Qr_DadosPedido.Database := It_BD_Gestao;
  Qr_DadosPedido.Transaction := It_Bd_transacao;
  Qr_DadosPedido.ForcedRefresh := true;

  Qr_DadosPedido.close;

  Qr_Acao.Database := It_BD_Gestao;
  Qr_Acao.Transaction := It_Bd_transacao;
  Qr_Acao.ForcedRefresh := true;

  Qr_Acao.close;
end;

destructor tajustaPedidoCompra.Destroy;
begin
  if Assigned(Qr_DadosNota) then
    Begin
    Qr_DadosNota.Close;
    FreeAndNil(Qr_DadosNota);
    end;

  if Assigned(Qr_DadosPedido) then
    Begin
    Qr_DadosPedido.Close;
    FreeAndNil(Qr_DadosPedido);
    end;

  if Assigned(Qr_Acao) then
    Begin
    Qr_Acao.Close;
    FreeAndNil(Qr_Acao);
    end;
  inherited destroy
end;

Function tajustaPedidoCompra.Fc_ExecutaAjuste:String;
Begin
  Try
    Pc_IniciaVariaveis;
    if Fc_VerificaSeExisteNota then
    Begin
      //Cria consulta dos Itens da Nota para Comparção
      with Qr_DadosNota do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT ITF_CODIGO, ITF_CODPRO, ITF_QTDE, ITF_VL_UNIT '+
                'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                '  INNER JOIN  TB_ITENS_NFL tb_itens_nfl '+
                '  ON (tb_nota_fiscal.NFL_CODIGO = tb_itens_nfl.ITF_CODNFL) '+
                'WHERE (NFL_NUMERO=:NFL_NUMERO) AND (NFL_CODEMP=:NFL_CODEMP) and (ITF_CODPRO=:ITF_CODPRO)');
      end;
      //Cria consulta dos Itens do Pedido para Comparção
      with Qr_DadosPedido do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT ITF_CODIGO,ITF_CODPRO, ITF_QTDE, ITF_VL_UNIT,PED_VL_PEDIDO  '+
                'FROM TB_PEDIDO tb_pedido '+
                '  INNER JOIN  TB_ITENS_NFL tb_itens_nfl '+
                '  ON (tb_pedido.PED_CODIGO = tb_itens_nfl.ITF_CODPED) '+
                'WHERE (PED_CODIGO=:PED_CODIGO) ');
        ParamByName('PED_CODIGO').AsInteger := CodigoDoPedido;
        Active := True;
        FetchAll;
        FValorTotalPedido := FieldByName('PED_VL_PEDIDO').AsCurrency;
      end;
      //Verifica se precisa ajustar as quantidades
      Pc_VerificaQuantidade;
      //Verifica se precisa ajustar os valores Unitarios
      Pc_VerificaValorUnitario;
      Result := 'Sucesso';
    end
    else
    Begin
      Result := 'Nota Fiscal não encontrada';
    end;
  except
    Result := 'Occoreu um erro Desconhecido'+EOLN+
              'Contate o suporte técnico';
  end;
end;

Function tajustaPedidoCompra.Fc_VerificaSeExisteNota():boolean;
Begin
  FValorTotalNota := 0;
  with Qr_DadosNota do
    Begin
    SQL.Add('SELECT NFL_VL_TL_NOTA FROM TB_NOTA_FISCAL '+
            'WHERE (NFL_CODEMP=:NFL_CODEMP) AND (NFL_NUMERO=:NFL_NUMERO) ');
    ParamByName('NFL_CODEMP').AsInteger := FCodigodaEmpresa;
    ParamByName('NFL_NUMERO').AsString := FNumeroDaNota;
    Active := True;
    FetchAll;
    FValorTotalNota := FieldByName('NFL_VL_TL_NOTA').AsCurrency;
    Result := (RecordCount > 0);
    end;
end;

procedure tajustaPedidoCompra.Pc_VerificaQuantidade;
Begin
  with Qr_DadosPedido do
    Begin
    Active := True;
    First;
    while not eof do
      Begin
      Qr_DadosNota.Active := False;
      Qr_DadosNota.ParamByName('ITF_CODPRO').AsInteger := FieldByName('ITF_CODPRO').AsInteger;
      Qr_DadosNota.ParamByName('NFL_NUMERO').AsString := NumeroDaNota;
      Qr_DadosNota.ParamByName('NFL_CODEMP').AsInteger := CodigoDaEmpresa;
      Qr_DadosNota.Active := True;
      //Executa a procudure que vai atualizar as quantidades
      Pc_AtualizaQuantidade;
      Next;
      end;
    end;
end;


procedure tajustaPedidoCompra.Pc_AtualizaQuantidade;
Begin
  if Qr_DadosPedido.FieldByName('ITF_QTDE').AsFloat > Qr_DadosNota.FieldByName('ITF_QTDE').AsFloat then
    Begin
    with Qr_Acao do
      Begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_ITENS_NFL set '+
              '  ITF_QTDE =:ITF_QTDE '+
              'WHERE (ITF_CODIGO=:ITF_CODIGO)');
      ParamByName('ITF_QTDE').AsFloat := (Qr_DadosPedido.FieldByName('ITF_QTDE').AsFloat - Qr_DadosNota.FieldByName('ITF_QTDE').AsFloat);
      ParamByName('ITF_CODIGO').AsFloat := Qr_DadosPedido.FieldByName('ITF_CODIGO').AsInteger;
      ExecSQL;
      Transaction.CommitRetaining;
      end;
    end
  else
    Begin
    with Qr_Acao do
      Begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_ITENS_NFL set '+
              '  ITF_ESTOQUE =:ITF_ESTOQUE '+
              'WHERE (ITF_CODIGO=:ITF_CODIGO)');
      ParamByName('ITF_ESTOQUE').AsString := 'N'; 
      ParamByName('ITF_CODIGO').AsFloat := Qr_DadosPedido.FieldByName('ITF_CODIGO').AsInteger;
      ExecSQL;
      Transaction.CommitRetaining;
      end;
    end;
end;

procedure tajustaPedidoCompra.Pc_VerificaValorUnitario;
Var
  Lc_Tx_Proporcao : Real;
  Lc_SaldoAjuste : Real;
  Lc_Vl_Unit : Real;
  Lc_Valores :array of real;
  Lc_I:Integer;
Begin
  with Qr_DadosPedido do
    Begin
    Transaction.CommitRetaining;
    Active := True;
    FetchAll;
    SetLength(Lc_Valores,RecordCount);
    First;
    Lc_I := 0;
    //Guarda os valores atuais para fazer a proporção com as notas quantidades
    while not eof do
      Begin
      Lc_Valores[Lc_I] := (FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat);
      Next;
      Inc(Lc_I);
      end;

    Lc_SaldoAjuste := FValorTotalPedido - FValorTotalNota;
    //Atualiza a Dataset para pegar as novas quantidades
    Active := False;
    Active := True;
    Lc_I := 0;
    First;
    while not eof do
      Begin
      Lc_Tx_Proporcao := Lc_Valores[Lc_I] / FValorTotalPedido;
      Lc_Vl_Unit := (Lc_SaldoAjuste * Lc_Tx_Proporcao) / FieldByName('ITF_QTDE').AsFloat;
      Pc_AtualizaValorUnitario(FieldByName('ITF_CODIGO').AsInteger,Lc_Vl_Unit);
      Next;
      Inc(Lc_I);
      end;
    end;
end;

procedure tajustaPedidoCompra.Pc_AtualizaValorUnitario(Pc_Cd_Item:Integer;Pc_Vl_Unit:Real);
Begin
  with Qr_Acao do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_ITENS_NFL set '+
            '  ITF_VL_UNIT =:ITF_VL_UNIT '+
            'WHERE (ITF_CODIGO=:ITF_CODIGO)');
    ParamByName('ITF_VL_UNIT').AsCurrency := Pc_Vl_Unit;
    ParamByName('ITF_CODIGO').AsInteger := pc_Cd_Item;
    ExecSQL;
    Transaction.CommitRetaining;
    end;
end;


end.

unit prmVendas;

interface

Type
  TParamVendas = class
    public
      TipoDocumento : Integer;
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      CodigoCliente : Integer;
      NomeCliente : String;
      CodigoTransportadora : Integer;
      CodigoVendedorCliente : Integer;
      CodigoVendedorPedido : Integer;
      NomeDaRegiao : String;
      CodigoEstabelecimento : Integer;
      TipoItem : String;
      //Venda por produto
      CodigoEstoque : Integer;
      CodigoTabelaPreco : Integer;
      CodigoGrupo : Integer;
      CodigoSubGrupo : Integer;
      CodigoMarca : Integer;
      DescricaoProduto : String;
      Localizacao : String;
      TipoEmpresa : String;
      FiltroVendedor : String;
      CodigoVendedor : Integer;
      EstoqueMinimo : Boolean;
      EstoquePositivo : Boolean;
      EstoqueNegativo : Boolean;
      EstoqueZerado : Boolean;
      ComMovimentacao : Boolean;
      InternetPublished : Boolean;
      Inativos : Boolean;
      Ordenacao : String;
      ShowObsField : Boolean;
  end;

implementation

end.

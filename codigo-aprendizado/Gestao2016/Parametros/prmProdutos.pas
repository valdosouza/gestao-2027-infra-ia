unit prmProdutos;

interface

Type
  TParamProdutos = class
    public
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      CodigoEstoque : Integer;
      CodigoTabelaPreco : Integer;
      CodigoGrupo : Integer;
      CodigoSubGrupo : Integer;
      CodigoMarca : Integer;
      DescricaoProduto : String;
      Localizacao : String;
      TipoEmpresa : String;
      CodigoEmpresa : Integer;
      FiltroVendedor : String;
      CodigoVendedor : Integer;
      EstoqueMinimo : Boolean;
      EstoquePositivo : Boolean;
      EstoqueNegativo : Boolean;
      EstoqueZerado : Boolean;
      ComMovimentacao : Boolean;
      InternetPublished : Boolean;
      Inativos : Boolean;
      CodigoEstabelecimento : Integer;
      Ordenacao : String;
      CampoCusto : String;
  end;

implementation

end.

unit prmLucratividade;

interface

Type
  TParamLucratividade = class
    public
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      CodigoCliente : Integer;
      NomeCliente : String;
      CodigoTransportadora : Integer;
      CodigoEstabelecimento : Integer;
      VendedorCliente : Integer;
      VendedorPedido : Integer;
      NegociosEspecificos : String;
      NumeroDocumento : String;
      //Parametros para Produtos
      CodigoGrupo : Integer;
      CodigoSubGrupo : Integer;
      CodigoMarca : Integer;
      CodigoProduto : Integer;
      DescricaoProduto : String;


  end;

implementation

end.

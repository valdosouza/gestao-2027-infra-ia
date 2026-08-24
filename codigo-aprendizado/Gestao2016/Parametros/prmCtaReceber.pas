unit prmCtaReceber;

interface

Type
  TParamCtaReceber = class
    public
      TipoData : String;
      TipoConta : String;
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      CodigoCliente : Integer;
      CodigoFormaPagamento : Integer;
      CodigoVendedorCliente : Integer;
      CodigoVendedorPedido : Integer;
      CodigoEstabelecimento : Integer;
      Ordenacao : String;
      CampoNomeCliente : String;
  end;

implementation

end.

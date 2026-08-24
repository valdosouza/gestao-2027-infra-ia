unit prmComissao;

interface

Type
  TParamComissao = class
    public
      CodigoVendedor : Integer;
      NomeVendedor : String;
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      SituacaoComissao : String;
      Ordenacao : String;
      CodigoEstabelecimento : Integer;
  end;

implementation

end.

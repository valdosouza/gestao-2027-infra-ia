unit prmNotas;

interface

Type
  TParamNotas = class
    public
      TipoDocumento : Integer;
      Periodo : Boolean;
      DataInicial : TDate;
      DataFinal : TDate;
      CodigoEmpresa : Integer;
      CodigoCFOP : Integer;
      CodigoEstabelecimento : Integer;
      Ordenacao : String;
  end;

implementation

end.

unit prmCheques;

interface

Type
  TParamCheques = class
    public
    SituacaoDocumento : String;
    Periodo : Boolean;
    DataInicial : TDate;
    DataFinal : TDate;
    CodigoEmpresa : Integer;
    CampoOrdenacao : String;
    CodigoEstabelecimento : Integer;
  end;

implementation

end.

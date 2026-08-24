unit PagamentoEscolhido;

interface

uses     System.Generics.Collections;

type
  TPagamentoEscolhido = Class
    private
    FValor: Real;
    FForma: String;
    procedure setFForma(const Value: String);
    procedure setFValor(const Value: Real);
    public
      property Forma : String read FForma write setFForma;
      property Valor : Real read FValor write setFValor;

  End;

  TListaPagamentoEscolhido = TObjectList<TPagamentoEscolhido>;
implementation

{ TPagamentoEscolhido }

procedure TPagamentoEscolhido.setFForma(const Value: String);
begin
  FForma := Value;
end;

procedure TPagamentoEscolhido.setFValor(const Value: Real);
begin
  FValor := Value;
end;

end.

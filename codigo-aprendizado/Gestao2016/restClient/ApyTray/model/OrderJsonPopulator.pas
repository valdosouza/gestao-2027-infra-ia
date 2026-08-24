unit OrderJsonPopulator; // Exemplo de nome para a unit que conteria esta função

interface

uses
      System.SysUtils, System.Classes, System.JSON, TrayOrderWrapper, TrayOrder;

  function PopulateOrderFromTrayJson(AJsonString: string): TTrayOrderWrapper;

implementation

function PopulateOrderFromTrayJson(AJsonString: string): TTrayOrderWrapper;
var
  LOrderWrapper: TTrayOrderWrapper;
begin
  LOrderWrapper := TTrayOrderWrapper.Create;
  try
    // O método FromJSON da TTrayOrderWrapper (com a modificção sugerida)
    // ir� analisar a string JSON e popular o objeto FOrder interno
    // e todas as suas sub-partes (ProductsSold, Customer, etc.).
    LOrderWrapper.FromJSON(AJsonString);
    Result := LOrderWrapper; // Retorna o objeto wrapper populado
  except
    on E: Exception do
    begin
      LOrderWrapper.Free; // Libera o objeto em caso de erro
      // Voc� pode querer registrar o erro ou relan��-lo.
      // Por exemplo: raise Exception.Create('Falha ao popular o pedido a partir do JSON: ' + E.Message);
      Result := nil; // Ou indicar falha retornando nil
      // Relan�ar para que o chamador saiba do erro:
      raise;
    end;
  end;
end;

end.

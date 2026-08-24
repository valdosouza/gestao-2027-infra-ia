unit api_route_image;

interface

uses
      un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto, REST.Json, System.Json, Vcl.Dialogs, System.SysUtils, tblImage, System.Contnrs, Generics.Collections, REST.Types;

type

  TApiRouteImage = class(TBaseApiAdmDesktop)
    private
      function getJsonString:String;
    protected

    public
      ObjImage : TTableImage;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function post(): Boolean;
  end;
implementation

{ TApiRouteImage }

uses     UN_MSG, env;

constructor TApiRouteImage.Create(AOwner: TComponent);
begin
  inherited;
  ObjImage := TTableImage.create;
end;

destructor TApiRouteImage.Destroy;
begin
  FreeAndNil(ObjImage);
  inherited;
end;

function TApiRouteImage.getJsonString: String;
begin
  Try
    Result := ObjToJson(ObjImage);
  Except
    on E : Exception do
    Begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Algum problema com a imagem que não pode ser enviada para Loja Virtual.' + EOLN +
                     'Verique se o tamanho está dentros os limites deinidos.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Result := '{}';
    End;
  end;
end;

function TApiRouteImage.post: Boolean;
Var
  LcStrJSon : WideString;
begin
  configComponents('post','image','post','');
  LcStrJSon := getJsonString;
  Result := sendData(LcStrJSon);
end;


end.

unit un_base_api_adm_desktop;

interface

uses
      Classes, SysUtils, StrUtils, REST.Client, REST.Types, Registry, System.JSON, System.RTTI, System.TypInfo, Winapi.Windows, GenericORM;

type

  TBaseApiAdmDesktop = Class(TComponent)

    private
      FURL: String;
      procedure ResetToDefaults;
      procedure ConfigureHttpClient;
      procedure ConfigureTlsForLegacyWindows;
      procedure ApplyWinInetSecureProtocols(AProtocols: Integer);
      procedure EnableSchannelClientProtocol(const AVersion: string);
      function ExecuteWithRetry(const AOrigin: string): Boolean;

    protected
      RESTClient:   TRESTClient;
      RESTRequest:  TRESTRequest;
      RESTResponse: TRESTResponse;

      function ConverteDataHora(Tempo: String): TDateTime;
      function verificaretorno: Boolean;
      procedure LogRoute(const AOrigin, AMsg: string);
      function LoadJsonArrayFromGet(const AOrigin: string; out AArray: TJSONArray): Boolean;

      procedure configComponents(Metodo, Route, Resource, Param: String);
      function sendData(Data: WideString): Boolean; Virtual;
      function getData: Boolean;
      function ObjToJson(Obj: TObject): String;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure ClonarObj<T: class>(ObjOri: T;ObjClone: T);

  End;

implementation

{ TBaseApiAdmDesktop }

uses     UnGeraLog;

const
  C_API_MAX_TENTATIVAS     = 2;
  C_API_INTERVALO_RETRY_MS = 1000;
  {WinInet SecureProtocols (HKCU Internet Settings\SecureProtocols)}
  {SSL2=8, SSL3=32, TLS1.0=128, TLS1.1=512, TLS1.2=1024}
  C_SECURE_PROTOCOLS_XP     = 160;  {SSL 3.0 (32) + TLS 1.0 (128) - maximo suportado no XP}
  C_SECURE_PROTOCOLS_MODERN = 1664; {TLS 1.0 (128) + TLS 1.1 (512) + TLS 1.2 (1024) - necessario para Node.js 21+}

procedure TBaseApiAdmDesktop.ApplyWinInetSecureProtocols(AProtocols: Integer);
var
  LcRegistro: TRegistry;
begin
  LcRegistro := TRegistry.Create(KEY_WRITE);
  try
    LcRegistro.RootKey := HKEY_CURRENT_USER;
    if LcRegistro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      LcRegistro.WriteInteger('SecureProtocols', AProtocols);
      LcRegistro.WriteInteger('GlobalUserOffline', 0);
      {Nao desabilitar CertificateRevocation: desligar permite certs revogados serem aceitos}
    end;
  finally
    LcRegistro.Free;
  end;
end;

procedure TBaseApiAdmDesktop.EnableSchannelClientProtocol(const AVersion: string);
var
  LcRegistro: TRegistry;
  LcKey: string;
begin
  LcRegistro := TRegistry.Create(KEY_WRITE);
  try
    try
      LcRegistro.RootKey := HKEY_LOCAL_MACHINE;
      LcKey := 'SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\' +
               AVersion + '\Client';
      if LcRegistro.OpenKey(LcKey, True) then
      begin
        LcRegistro.WriteInteger('Enabled', 1);
        LcRegistro.WriteInteger('DisabledByDefault', 0);
      end;
    except
      on E: Exception do
        GeralogFile('ConfigureTls.Schannel', AVersion + ' - ' + E.Message);
    end;
  finally
    LcRegistro.Free;
  end;
end;

procedure TBaseApiAdmDesktop.ConfigureTlsForLegacyWindows;
var
  LcProtocols: Integer;
  LcPerfil: string;
begin
  if TOSVersion.Major < 6 then
  begin
    {XP/2003: suporta apenas SSL 3.0 e TLS 1.0 - nao consegue conectar a Node.js 21+}
    LcProtocols := C_SECURE_PROTOCOLS_XP;
    LcPerfil := 'XP/2003';
    {SSL 3.0 nao habilitado via Schannel: vulneravel ao ataque POODLE (CVE-2014-3566)}
    EnableSchannelClientProtocol('TLS 1.0');
  end
  else
  begin
    {Vista/7/8/10: habilita TLS 1.2 via WinInet (requer KB3140245 no Windows 7)}
    LcProtocols := C_SECURE_PROTOCOLS_MODERN;
    LcPerfil := 'Vista+';
    EnableSchannelClientProtocol('TLS 1.0');
    EnableSchannelClientProtocol('TLS 1.1');
    EnableSchannelClientProtocol('TLS 1.2');
  end;

  try
    ApplyWinInetSecureProtocols(LcProtocols);
  except
    on E: Exception do
      GeralogFile(concat('ConfigureTls - ', LcPerfil), E.Message);
  end;
end;

procedure TBaseApiAdmDesktop.ConfigureHttpClient;
begin
  ConfigureTlsForLegacyWindows;
end;

function TBaseApiAdmDesktop.ExecuteWithRetry(const AOrigin: string): Boolean;
var
  Tentativa: Integer;
begin
  Result := False;
  for Tentativa := 1 to C_API_MAX_TENTATIVAS do
  begin
    try
      RESTRequest.Execute;
      Result := True;
      Exit;
    except
      on E: Exception do
      begin
        GeralogFile(AOrigin, Format('Tentativa %d/%d - %s',
          [Tentativa, C_API_MAX_TENTATIVAS, E.Message]));
        if Tentativa < C_API_MAX_TENTATIVAS then
          Sleep(C_API_INTERVALO_RETRY_MS);
      end;
    end;
  end;
end;

function TBaseApiAdmDesktop.ObjToJson(Obj: TObject): String;
var
  ContextoRTTI: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  JSONObject: TJSONObject;
begin
  JSONObject := TJSONObject.Create;
  try
    Tipo := ContextoRTTI.GetType(Obj.ClassType);
    for Propriedade in Tipo.GetProperties do
    begin
      if Propriedade.Visibility = mvPublic then
      begin
        case Propriedade.PropertyType.TypeKind of
          tkString, tkLString, tkWString, tkUString:
            JSONObject.AddPair(Propriedade.Name, Propriedade.GetValue(Obj).AsString);
          tkInteger:
            JSONObject.AddPair(Propriedade.Name, TJSONNumber.Create(Propriedade.GetValue(Obj).AsInteger));
          tkFloat:
            JSONObject.AddPair(Propriedade.Name, TJSONNumber.Create(Propriedade.GetValue(Obj).AsExtended));
          tkEnumeration:
            JSONObject.AddPair(Propriedade.Name, Propriedade.GetValue(Obj).ToString);
        end;
      end;
    end;
    Result := JSONObject.ToString;
  finally
    JSONObject.Free;
  end;
end;

procedure TBaseApiAdmDesktop.ClonarObj<T>(ObjOri, ObjClone: T);
begin
    TGenericORM._assign(ObjOri,ObjClone);
end;

procedure TBaseApiAdmDesktop.configComponents(Metodo, Route, Resource, Param: String);
var
  LcUrl: String;
begin
  ResetToDefaults;
  RESTClient.ContentType  := 'application/json';
  RESTClient.Accept       := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient.AcceptCharset := 'UTF-8, *;q=0.8';

  case AnsiIndexStr(UpperCase(Metodo), ['POST', 'PUT', 'DELETE', 'GET']) of
    0: begin
        LcUrl := FURL + Route;
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmPOST;
        with RESTRequest.Params.AddItem do
        begin
          Kind  := pkREQUESTBODY;
          Name  := 'body';
          Value := '';
        end;
        RESTRequest.Params.ParameterByName('body').Options := [poDoNotEncode];
       end;
    1: begin
        LcUrl := FURL + Route;
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmPUT;
       end;
    2: begin
        LcUrl := FURL + Route;
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmDELETE;
       end;
    3: begin
        LcUrl := FURL + Route + '/' + Resource;
        if Param <> '' then
          LcUrl := LcUrl + '/' + Param;
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmGET;
       end;
  end;
end;

function TBaseApiAdmDesktop.ConverteDataHora(Tempo: String): TDateTime;
begin
  {Formato esperado: 'YYYY-MM-DD HH:MM:SS'}
  Result := StrToDateTimeDef(
    Copy(Tempo, 9, 2) + '/' + Copy(Tempo, 6, 2) + '/' + Copy(Tempo, 1, 4) +
    ' ' + Copy(Tempo, 12, 8),
    Now);
end;

constructor TBaseApiAdmDesktop.Create(AOwner: TComponent);
begin
  inherited;
  FURL := 'https://admdesktop.setesgestao.com.br/';
  //FURL := 'http://localhost:3000/';

  RESTClient   := TRESTClient.Create(FURL);
  RESTRequest  := TRESTRequest.Create(Self);
  RESTResponse := TRESTResponse.Create(Self);

  RESTRequest.Client   := RESTClient;
  RESTRequest.Response := RESTResponse;

  ConfigureHttpClient;
end;

destructor TBaseApiAdmDesktop.Destroy;
begin
  FreeAndNil(RESTClient);
  FreeAndNil(RESTRequest);
  inherited;
end;

function TBaseApiAdmDesktop.getData: Boolean;
begin
  Result := ExecuteWithRetry('APIADMDESKTOP.getData');
  if not Result then
    GeralogFile('APIADMDESKTOP.Recebido', RESTResponse.Content);
end;

procedure TBaseApiAdmDesktop.ResetToDefaults;
begin
  RESTResponse.RootElement := '';
  RESTRequest.Params.Clear;
  RESTRequest.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  {TLS ja configurado no construtor - nao regravar registry a cada requisicao}
end;

function TBaseApiAdmDesktop.sendData(Data: WideString): Boolean;
var
  i: Integer;
  LcParam: TRESTRequestParameter;
begin
  RESTResponse.RootElement := '';
  LcParam := nil;
  for i := 0 to RESTRequest.Params.Count - 1 do
    if SameText(RESTRequest.Params[i].Name, 'body') then
    begin
      LcParam := RESTRequest.Params[i];
      Break;
    end;
  if LcParam = nil then
  begin
    LcParam := RESTRequest.Params.AddItem;
    LcParam.Kind    := pkREQUESTBODY;
    LcParam.Name    := 'body';
    LcParam.Options := [poDoNotEncode];
  end;
  LcParam.Value := Data;
  Result := ExecuteWithRetry('APIADMDESKTOP.sendData');
  if not Result then
    GeralogFile('APIADMDESKTOP.Enviado', RESTResponse.Content);
end;

function TBaseApiAdmDesktop.verificaretorno: Boolean;
begin
  Result := Trim(RESTResponse.Content) <> '';
end;

procedure TBaseApiAdmDesktop.LogRoute(const AOrigin, AMsg: string);
begin
  GeralogFile(AOrigin, AMsg);
end;

function TBaseApiAdmDesktop.LoadJsonArrayFromGet(const AOrigin: string;
  out AArray: TJSONArray): Boolean;
var
  LcValue: TJSONValue;
begin
  Result := False;
  AArray := nil;
  if not getData then
    Exit;
  if not verificaretorno then
    Exit;
  try
    LcValue := TJSONObject.ParseJSONValue(
      TEncoding.UTF8.GetBytes(RESTResponse.Content), 0);
    if not (LcValue is TJSONArray) then
    begin
      LogRoute(AOrigin, 'Resposta invalida - esperado array JSON');
      LcValue.Free;
      Exit;
    end;
    AArray := TJSONArray(LcValue);
    Result := True;
  except
    on E: Exception do
    begin
      LogRoute(AOrigin, E.Message);
      FreeAndNil(AArray);
    end;
  end;
end;

end.

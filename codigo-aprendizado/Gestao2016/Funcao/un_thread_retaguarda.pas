unit un_thread_retaguarda;

interface

uses
      Classes, SysUtils, Vcl.Forms, UnFunctions, System.Threading, Winapi.Windows, StackTrace, ControllerEstabelecimento, STQuery, ControllerBase, Controllerretaguarda, System.SyncObjs, STDatabase;

type
  TThreadRetaguarda = class(TThread)
  private
    FStopEvent: TEvent;
    //Conexao exclusiva da thread com o banco local do PDV
    FBancoLocal: TSTDatabase;
  protected

  public
    FRetaguarda: TControllerretaguarda;
    constructor Create();
    destructor Destroy; override;

    procedure Stop;
    procedure Execute; override;
  end;

implementation

{ TThreadLoadGeneral }

uses     Un_DM;

constructor TThreadRetaguarda.Create;
begin
  inherited Create(True);
  FreeOnTerminate := False;
  FStopEvent := TEvent.Create(nil, True, False, '');

  //A thread nao pode compartilhar a conexao DM.IBD_Gestao com a thread
  //principal (conexao FireDAC nao e thread-safe e as transacoes se
  //misturam, causando "update conflicts with concurrent update").
  //Cria uma conexao propria; os parametros sao copiados no Execute,
  //quando o banco local ja esta configurado.
  FBancoLocal := TSTDatabase.Create(nil);
  FBancoLocal.LoginPrompt := False;

  FRetaguarda := TControllerretaguarda.create(nil);
  FRetaguarda.DataBase := FBancoLocal;
  FRetaguarda.BancoPDV := FBancoLocal;
  FRetaguarda.RetaguardaSync.DataBase := FBancoLocal;
end;

destructor TThreadRetaguarda.Destroy;
begin
  FreeAndNil(FRetaguarda);
  if Assigned(FBancoLocal) then
    FBancoLocal.Connected := False;
  FreeAndNil(FBancoLocal);
  FreeAndNil(FStopEvent);
  inherited;
end;

procedure TThreadRetaguarda.Execute;
begin
  //Copia os parametros da conexao principal (ja configurada neste ponto)
  //para a conexao exclusiva da thread
  FBancoLocal.Params.Assign(DM.IBD_Gestao.Params);

  try
    FRetaguarda.getFirst;
    if not FRetaguarda.exist or (FRetaguarda.Registro.Ativo <> 'S') then
      Exit;

    while not Terminated do
    begin
      FRetaguarda.IniciaSincronia;
      // Aguarda 30s mas responde ao Stop imediatamente
      FStopEvent.WaitFor(30000);
    end;
  finally
    //Desconecta a conexao exclusiva ainda dentro do contexto da thread
    FBancoLocal.Connected := False;
  end;
end;

procedure TThreadRetaguarda.Stop;
begin
  Terminate;
  FStopEvent.SetEvent;
end;

end.
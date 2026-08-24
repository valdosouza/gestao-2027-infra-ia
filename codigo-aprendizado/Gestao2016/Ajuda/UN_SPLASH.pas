unit Un_Splash;

interface


uses
      STQuery, Data.DB, Vcl.DBCtrls, System.Threading, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Imaging.pngimage, Winapi.ShellAPI, ControllerMovimentoLote, System.IniFiles, un_thread_generator, ControllerBase, api_route_oper_interface, ControllerOperInterface, EncdDecd, synacode, api_route_interface, ControllerInterface, api_route_itens_ifc, ControllerItensIfc, tblAdmCliente;


type
  TSplashForm = class(TForm)
    IM_Logo: TImage;
    Lb_Progresso: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FONLINE : Boolean;
    Base : TControllerBase;
    procedure InformacaoProjeto;
    procedure ConsultaScript;

    function  getCliente:TAdmCliente;
    function  TryGetCliente(out ACliente: TAdmCliente): Boolean;
    procedure LogApiSplash(const AEtapa, AMsg: string);
    procedure AtualizacaoOperInterface;
    procedure AtualizacaoInterface;
    procedure AtualizacaoItensInterface;
    procedure ConfirmaAtualizacao(Cliente:TAdmCliente);
    function VerificaAtulizacaoVersao:Boolean;
    procedure ExecCheckGestaoOnline;
    procedure IniciaProcesso;
    procedure ExecDataBaseConnection;
    procedure ExecCheckApplicationVersion;
    procedure ExecCheckCustomer;
    procedure ExecSetesWebService;
    procedure ExecNED;
    procedure ExecThreadGenerator;
    procedure ExecThreadBatchTransition;
    procedure ExecCheckApplicationName;
    procedure ExecApplication;
    function ExecValidadeSistema:Boolean;
    function VerificaClienteAtivo:boolean;
  public
    BatchTransition : TThread;
    Generators : TThreadGenerator;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.DFM}

uses     Un_Conexao, UN_Sistema, UN_Principal, env, Un_Msg, Un_Serial_HD, Un_Script_Sql, Un_Funcoes, Un_Regra_Negocio, RN_NovaEstruturaDados, api_route_projeto, api_route_cliente, api_route_script,
  Un_DM, api_route_script_exec, ControllerEstabelecimento, UnGeraLog;
procedure TSplashForm.LogApiSplash(const AEtapa, AMsg: string);
begin
  GeralogFile('Splash.' + AEtapa, AMsg);
end;

procedure TSplashForm.AtualizacaoInterface;
Var
  I: Integer;
  Lc_route : TApiRouteInterface;
  Lc_interface : TControllerInterface;
begin
  Lc_interface := TControllerInterface.create(self);
  Lc_route := TApiRouteInterface.create(self);
  Try
    try
      if not Lc_route.getList(Gb_Cd_Cliente_Setes,Gb_Cd_Projeto_setes ) then
        LogApiSplash('AtualizacaoInterface', 'Falha ao obter lista da API');
      if Lc_route.Lista.count > 0 then
      Begin
        for I := 0 to Lc_route.Lista.count -1 do
        Begin
          Lc_interface.Registro.Codigo      := Lc_route.Lista[I].Codigo;
          Lc_interface.Registro.projeto     := Lc_route.Lista[I].Projeto;
          Lc_interface.Registro.Descricao   := Lc_route.Lista[I].Descricao;
          Lc_interface.Registro.Formulario  := Lc_route.Lista[I].Formulario;
          Lc_interface.Registro.CodigoMenu  := Lc_route.Lista[I].CodigoMenu;
          Lc_interface.Registro.Sistema     := Lc_route.Lista[I].Sistema;
          Lc_interface.Registro.Menu        := Lc_route.Lista[I].Menu;
          Lc_interface.replace;
        End;
      End;
    except
      on E: Exception do
        LogApiSplash('AtualizacaoInterface', E.Message);
    end;
  Finally
    FreeAndNil(Lc_route);
    FreeAndNil(Lc_interface);
  End;
end;

procedure TSplashForm.AtualizacaoItensInterface;
Var
  I: Integer;
  Lc_route : TApiRouteItensIfc;
  Lc_itens : TControllerItensIfc;
begin
  Lc_itens := TControllerItensIfc.create(self);
  Lc_route := TApiRouteItensIfc.create(self);
  Try
    try
      if not Lc_route.getList(Gb_Cd_Projeto_setes) then
        LogApiSplash('AtualizacaoItensInterface', 'Falha ao obter lista da API');
      if Lc_route.Lista.count > 0 then
      Begin
        for I := 0 to Lc_route.Lista.count -1 do
        Begin
          Lc_itens.Registro.Codigo          := Lc_route.Lista[I].Codigo;
          Lc_itens.Registro.CodigoInterface := Lc_route.Lista[I].CodigoInterface;
          Lc_itens.Registro.CodigoOperacao        := Lc_route.Lista[I].CodigoOperacao;
          Lc_itens.insert;
        End;
      End;
    except
      on E: Exception do
        LogApiSplash('AtualizacaoItensInterface', E.Message);
    end;
  Finally
    FreeAndNil(Lc_route);
    FreeAndNil(Lc_itens);
  End;
end;

procedure TSplashForm.AtualizacaoOperInterface;
Var
  I: Integer;
  Lc_route : TApiRouteOperInterface;
  Lc_oper : TControllerOperInterface;
begin
  Lc_oper := TControllerOperInterface.create(self);
  Lc_route := TApiRouteOperInterface.create(self);
  Try
    try
      if not Lc_route.getList() then
        LogApiSplash('AtualizacaoOperInterface', 'Falha ao obter lista da API');
      if Lc_route.Lista.count > 0 then
      Begin
        for I := 0 to Lc_route.Lista.count -1 do
        Begin
          Lc_oper.Registro.Codigo := Lc_route.Lista[I].Codigo;
          Lc_oper.Registro.Descricao := Lc_route.Lista[I].Descricao;
          Lc_oper.Registro.Imagem := Lc_route.Lista[I].Imagem;
          Lc_oper.replaceByInternet;
        End;
      End;
    except
      on E: Exception do
        LogApiSplash('AtualizacaoOperInterface', E.Message);
    end;
  Finally
    FreeAndNil(Lc_route);
    FreeAndNil(Lc_oper);
  End;
end;

procedure TSplashForm.ConfirmaAtualizacao(Cliente:TAdmCliente);
Var
  Lc_route : TApiRouteCliente;
begin
  Lc_route := TApiRouteCliente.create(self);
  Lc_route.ClonarObj(Cliente,Lc_route.ObjCliente);
  try
    try
      Lc_route.ObjCliente.Atualizar := 'N';
      if not Lc_route.put then
        LogApiSplash('Confirma Atualização', 'Falha ao confirmar atualização na API');
    except
      on E: Exception do
        LogApiSplash('Confirma Atualização', E.Message);
    end;
  finally
    FreeAndNil(Lc_route);
  end;
end;

procedure TSplashForm.ConsultaScript;
Var
  Lc_route_script : TApiRouteScript;
  Lc_route_script_exec : TApiRouteScriptExec;
  Lc_Qry : TSTQuery;
  I : Integer;
  Lc_resultado : String;
begin
  if (Gb_Cd_Cliente_Setes > 0) then
  Begin
    Lc_Qry := Base.GeraQuery;
    Lc_route_script_exec := TApiRouteScriptExec.create(self);
    Lc_route_script := TApiRouteScript.create(self);
    try
      try
        if not Lc_route_script.getList(Gb_Cd_Cliente_Setes) then
        begin
          LogApiSplash('ConsultaScript', 'Falha ao obter scripts da API');
          Exit;
        end;
        if Lc_route_script.Lista.count > 0 then
        Begin
          for I := 0 to Lc_route_script.Lista.count -1 do
          Begin
            with Lc_Qry do
            Begin
              Try
                try
                  SQL.Clear;
                  sql.Add(Lc_route_script.Lista[I].Comando);
                  Prepare;
                  ExecSQL;
                  if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
                  Lc_resultado := 'OK';
                Except
                  on E: Exception do
                  Begin
                    if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Rollback;
                    Lc_resultado := E.Message;
                  End;
                END;
              Finally
                try
                  Lc_route_script_exec.ObjScriptExec.Codigo := Lc_route_script.Lista[I].Codigo;
                  Lc_route_script_exec.ObjScriptExec.Cliente := Gb_Cd_Cliente_Setes;
                  Lc_route_script_exec.ObjScriptExec.Resultado := Lc_resultado;
                  if not Lc_route_script_exec.post then
                    LogApiSplash('ConsultaScript.post', 'Falha ao registrar execucao na API');
                except
                  on E: Exception do
                    LogApiSplash('ConsultaScript.post', E.Message);
                end;
              End;
            end;
          End;
        end;
      except
        on E: Exception do
          LogApiSplash('ConsultaScript', E.Message);
      end;
    finally
      FreeAndNil(Lc_route_script);
      FreeAndNil(Lc_route_script_exec);
      Base.FinalizaQuery(Lc_Qry);
    end;
  End;
end;

procedure TSplashForm.ExecApplication;
begin
  if Gb_exec_Aplication then
   Begin
    //Verifica se háo primeiro Usuario
    Gb_exec_Aplication := Fc_CriaPrimeiroUsuario;
    Lb_Progresso.Caption := 'Progresso: Abrindo o Sistema                        ';
    Lb_Progresso.Update;
    Pc_Define_FormatoRegional;
  end
  else
  Begin
    Application.Terminate
  end;
end;

procedure TSplashForm.ExecCheckApplicationName;
begin
  if (Upper( ExtractFileName(ParamStr(0)) ) <> 'GESTAO.EXE') then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Este programa não é a versão atualizada.' + EOLN +
                    'Favor execute o atualizador do Gestão.' + EOLN + EOLN +
                    'Antes de clicar em atualizar marque a seguinte opções.' + EOLN +EOLN +
                    '[X] Criar atalho na Àrea de trabalho.' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Gb_exec_Aplication := False;
  End;
end;

procedure TSplashForm.ExecCheckApplicationVersion;
begin
  //Verifica a Data da Versão local
  Lb_Progresso.Caption :=   'Progresso: Verificando data da Versão Local         ';
  Lb_Progresso.Update;
  Gb_data_Criacao := Fc_Aq_Geral('L','SISTEMA','Versao','');
  if Gb_data_Criacao = '' then
    Gb_data_Criacao := '01/01/2016';
end;

procedure TSplashForm.ExecCheckCustomer;
begin
  if not FONLINE then
  Begin
    Lb_Progresso.Caption :=   'Progresso: Identificando o cliente                  ';
    Lb_Progresso.Update;
   //Identifica o Serial do HF
    Gb_Serial_HD := Fc_GetIdeSN;
    if trim(Gb_Serial_HD) = '' then
      Gb_Serial_HD := FC_GetVolumeSerialHd('C:');
  End;
end;

procedure TSplashForm.ExecCheckGestaoOnline;
Var
  Lc_Arq_Ini: TIniFile;
begin
 Lc_Arq_Ini := TIniFile.Create(GbPathExe + 'Config.INI');
  Try
    FONLINE := Lc_Arq_Ini.SectionExists('PATH_ONLINE');
  Finally
    FreeAndNil(Lc_Arq_Ini);
  End;
end;

procedure TSplashForm.ExecDataBaseConnection;
begin
  DM.IBD_Gestao.Close;
  Gb_exec_Aplication := true;
  GbPathExe := ExtractFilePath(Application.ExeName);

  SplashForm.Refresh;
  Lb_Progresso.Caption :=   'Progresso: Conectando ao Banco de Dados             ';
  Lb_Progresso.Update;

  Gb_Nivel := 0;
  Gb_Cd_Usuario := 0;
  Gb_CodMha := 0;

  try
    Pc_Conecta(GbPathExe + 'Config.INI');
  except
      on E : Exception do
        Begin
          MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                        'Não foi possível Conectar o Banco de Dados.' + EOLN +
                        'Erro: ' + E.Message + EOLN +
                        'Entre em contato com o suporte técnico.' + EOLN,
                        ['OK'], [bEscape], mpErro);
          if not Assigned(Fr_ConectaBanco) then
            (Application.CreateForm(TFr_ConectaBanco, Fr_ConectaBanco));
          Fr_ConectaBanco.ShowModal;
          Gb_exec_Aplication := False;
        End;
  end;
end;

procedure TSplashForm.ExecNED;
Var
  LcOp : TNED;
  Lc_Arq_Ini: TIniFile;
begin
  Lc_Arq_Ini := TIniFile.Create(GbPathExe + 'Config.INI');
  try
    if not Lc_Arq_Ini.SectionExists('PATH_ONLINE') then
    Begin
      try
        Lb_Progresso.Caption := 'Progresso: Executando Tarefas para nova Estrutura   ';
        Lb_Progresso.Update;
        LcOp := TNED.Create(Application);
        LcOp.execAlteracao;
      finally
        // TODO : Rod - Erro na conexao
        //DM.IBD_Gestao.Close;
        //DM.IBD_Gestao.Open;
        FreeAndNil(LcOp);
      end;
    End;
  finally
    FreeAndNil(Lc_Arq_Ini);
  end;
end;

procedure TSplashForm.ExecSetesWebService;
Var
  Lc_Cliente : TAdmCliente;
begin
  Lb_Progresso.Caption :=   'Verificando conectividade com a Internet            ';
  Lb_Progresso.Update;

  if not Fc_PingConectadoSetes then
  begin
    LogApiSplash('ExecSetesWebService', 'Sem conectividade com a API - modo local');
    Exit;
  end;

  try
    Lb_Progresso.Caption := 'Progresso: Identificando o Projeto                  ';
    Lb_Progresso.Update;
    try
      InformacaoProjeto;
    except
      on E: Exception do
        LogApiSplash('InformacaoProjeto', E.Message);
    end;

    if not FONLINE then
    Begin
      Lb_Progresso.Caption := 'Progresso: executando Script''s de Atualização      ';
      Lb_Progresso.Update;
      ConsultaScript;
    End;

    if not FONLINE then
    Begin
      Lb_Progresso.Caption := 'Progresso: Atualizando funcionalidades do sistema   ';
      Lb_Progresso.Update;
      if TryGetCliente(Lc_Cliente) then
      Begin
        try
          if (Lc_Cliente.Atualizar = 'S') then
          Begin
            AtualizacaoOperInterface;
            AtualizacaoInterface;
            AtualizacaoItensInterface;
            ConfirmaAtualizacao(Lc_Cliente);
          End;
        finally
          Lc_Cliente.Free;
        end;
      end
      else
        LogApiSplash('ExecSetesWebService', 'Cliente nao obtido da API - atualizacao de interface ignorada');
    End;

    Lb_Progresso.Caption := 'Progresso: Verificando se há atualização na Web     ';
    Lb_Progresso.Update;

    if VerificaAtulizacaoVersao then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Há uma nova atualização disponível.' + EOLN +
                         'É altamente recomendável manter o sistema atualizado' +EOLN + EOLN +
                         'Confirmar a atualização ?',
                         [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
      begin
        ShellExecute(Gb_Handle,'open',pchar(GbPathExe + 'GestaoUpdate.exe'),nil,nil,sw_show);
        Gb_exec_Aplication := False;
      end;
    end;
  except
    on E: Exception do
    begin
      LogApiSplash('ExecSetesWebService', E.Message);
      {modo degradado: falha na API nao impede abertura do sistema}
    end;
  end;
end;

procedure TSplashForm.ExecThreadBatchTransition;
begin
  Lb_Progresso.Caption := 'Progresso: Corrigindo Movimentações de Lote   ';
  Lb_Progresso.Update;
  exit;
  BatchTransition := TThread.CreateAnonymousThread(
  procedure()
    Var
      Lote : TControllerMovimentoLote;
    begin
      try
        Lote := TControllerMovimentoLote.Create(Self);
        Lote.CorrigeItemExcluido;
      finally
        FreeAndNil(Lote);
        BatchTransition.Terminate;
      end;
    end);
  BatchTransition.FreeOnTerminate := true;
  BatchTransition.Start;
end;

procedure TSplashForm.ExecThreadGenerator;
begin
  Lb_Progresso.Caption := 'Progresso: Ajustando sequencias dos Geradores       ';
  Lb_Progresso.Update;
  Generators := TThreadGenerator.Create();
  Generators.FreeOnTerminate := False;
  try
    Generators.Start;
    Generators.WaitFor;
  finally
    FreeAndNil(Generators);
  end;
end;

function TSplashForm.ExecValidadeSistema: Boolean;
Var
  Lc_Dt_Validade : TDate;
  Lc_Dt_Ult_Acesso : TDate;
  Lc_Hoje : TDate;
begin

  Lc_Hoje := Date;
  Lc_Dt_Validade := StrToDateDEf(Fc_Tb_Geral('L','VALIDADE_SISTEMA',''),Lc_Hoje);
  Lc_Dt_Ult_Acesso := StrToDateDEf(Fc_Tb_Geral('L','ULTIMO_ACESSO',''),Lc_Hoje);
  if (Lc_Hoje < Lc_Dt_Validade) then
  Begin
    if (Lc_Hoje >= Lc_Dt_Ult_Acesso) then
    Begin
      Result := True;
      Fc_Tb_Geral('G','ULTIMO_ACESSO',DateToStr(Lc_Hoje));
    End
    else
    Begin
      Result := False;
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                      'A data de hoje parece estar incorreta' + EOLN +
                      'O último acesso foi em ' + DateToSTr(Lc_Dt_Ult_Acesso)+'.' + EOLN +
                      'E a data atual está como ' + DateToSTr(Lc_Hoje)+'.' + EOLN +
                      'Verifique para continuar.' + EOLN,
                      ['OK'], [bEscape], mpAlerta);
    End;
  End
  else
  Begin
    if VerificaClienteAtivo then
    BEgin
      Result := True;
      Fc_Tb_Geral('G','VALIDADE_SISTEMA',DateToStr(Lc_Hoje + 10));
    End
    else
    Begin
      Result := False;
      MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                      'A data de validade do sistema expirou em ' + DateToSTr(Lc_Dt_Validade)+'.' + EOLN +
                      'Para atualizar a nova data conecte-se à internet.'+ EOLN +
                      'E abra o sistema novamente.' + EOLN ,
                      ['OK'], [bEscape], mpAlerta);
    End;
  End;
end;

procedure TSplashForm.FormActivate(Sender: TObject);
begin
  Brush.Style := bsClear;
  IniciaProcesso;
end;

procedure TSplashForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LcBatchTransition: TThread;
begin
  if Assigned(SplashForm.BatchTransition) then
  begin
    LcBatchTransition := SplashForm.BatchTransition;
    SplashForm.BatchTransition := nil;
    FreeAndNil(LcBatchTransition);
  end;
// if Assigned(SplashForm.Generators) then
//  begin
//    SplashForm.Generators.Stop;
//    SplashForm.Generators.DisposeOf;
//  end;
end;

procedure TSplashForm.InformacaoProjeto;
Var
  Lc_route : TApiRouteCliente;
  Lc_Est : TControllerEstabelecimento;
begin
  if (Gb_Cd_Cliente_Setes = 0) then
  Begin
    try
      Lc_Est := TControllerEstabelecimento.create(Self);
      Lc_route := TApiRouteCliente.create(self);
      try
        if Lc_route.getProject(Lc_Est.GetCNPJByTipoZero) and
           (Lc_route.ObjProjCliente.Projeto > 0) then
        Begin
          Gb_Cd_Projeto_setes := Lc_route.ObjProjCliente.Projeto;
          Gb_Cd_Cliente_Setes := Lc_route.ObjProjCliente.Cliente;
          Fc_Tb_Geral('G','CD_CLIENTE_SETES',InttoStr(Gb_Cd_Cliente_Setes));
          Fc_Tb_Geral('G','CD_PROJETO_SETES',InttoStr(Gb_Cd_Projeto_setes));
        end
        else
        Begin
          LogApiSplash('InformacaoProjeto', 'Projeto nao identificado na API - mantendo dados locais');
        end;
      finally
        FreeAndNil(Lc_route);
        FreeAndNil(Lc_Est);
      end;
    except
      on E: Exception do
        LogApiSplash('InformacaoProjeto', E.Message);
    end;
  End;
end;

procedure TSplashForm.IniciaProcesso;
begin
  Base := TControllerBase.create(Self);
  Try
    ExecCheckGestaoOnline;

    ExecDataBaseConnection;

    ExecCheckApplicationVersion;
    //Depois ler os dados do banco conectado
    Gb_Cd_Cliente_Setes := StrToIntDef(Fc_Tb_Geral('L','CD_CLIENTE_SETES',''),0);
    Gb_Cd_Projeto_setes := StrToIntDef(Fc_Tb_Geral('L','CD_PROJETO_SETES',''),0);
    // TODO: Rod - Para não validar a ativação, True - ExecValidadeSistema
    Gb_exec_Aplication := ExecValidadeSistema;
    if Gb_exec_Aplication then
    Begin
      ExecCheckCustomer;

      ExecNED;

      // TODO: Rod - Não usar o web service - ExecSetesWebService
      ExecSetesWebService;

      ExecThreadBatchTransition;

      ExecThreadGenerator;

      ExecCheckApplicationName;
    end;

    ExecApplication;
  Finally
    FreeAndNil( base );
  End;
end;


function TSplashForm.TryGetCliente(out ACliente: TAdmCliente): Boolean;
Var
  Lc_route : TApiRouteCliente;
begin
  Result := False;
  ACliente := nil;
  if Gb_Cd_Cliente_Setes <= 0 then
    Exit;

  Lc_route := TApiRouteCliente.create(Self);
  try
    try
      if not Lc_route.get(Gb_Cd_Cliente_Setes) then
        Exit;
      if Trim(Lc_route.ObjCliente.Ativo) = '' then
      begin
        LogApiSplash('TryGetCliente', 'Resposta vazia ou invalida da API');
        Exit;
      end;
      ACliente := TAdmCliente.create;
      Lc_route.ClonarObj(Lc_route.ObjCliente, ACliente);
      Result := True;
    except
      on E: Exception do
        LogApiSplash('TryGetCliente', E.Message);
    end;
  finally
    FreeAndNil(Lc_route);
  end;
end;

function TSplashForm.getCliente: TAdmCliente;
begin
  if not TryGetCliente(Result) then
  begin
    Result := TAdmCliente.create;
    LogApiSplash('getCliente', 'Retornando cliente vazio - API indisponivel');
  end;
end;

function TSplashForm.VerificaAtulizacaoVersao: Boolean;
Var
  Lc_route : TApiRouteProjeto;
begin
  Result := False;
  if Gb_Cd_Projeto_setes <= 0 then
    Exit;

  Lc_route := TApiRouteProjeto.create(Self);
  try
    try
      Lc_route.ObjProjeto.Atualizacao := Gb_data_Criacao;
      if not Lc_route.get(Gb_Cd_Projeto_setes) then
      begin
        LogApiSplash('VerificaAtulizacaoVersao', 'Falha ao consultar versao na API');
        Exit;
      end;
      if Trim(Lc_route.ObjProjeto.Atualizacao) = '' then
      begin
        LogApiSplash('VerificaAtulizacaoVersao', 'Resposta vazia da API');
        Exit;
      end;
      Result := (StrToDateTimeDef(Gb_data_Criacao,Now) <
                 StrToDateTimeDef(Lc_route.ObjProjeto.Atualizacao,Now));
    except
      on E: Exception do
        LogApiSplash('VerificaAtulizacaoVersao', E.Message);
    end;
  finally
    Lc_route.Free;
  end;
end;

function TSplashForm.VerificaClienteAtivo: boolean;
Var
  Lc_Cliente : TAdmCliente;
begin
  Result := True;
  if Gb_Cd_Cliente_Setes <= 0 then
    Exit;

  Lb_Progresso.Caption := 'Progresso: Verifica cliente ativo.   ';
  Lb_Progresso.Update;

  if not TryGetCliente(Lc_Cliente) then
  begin
    LogApiSplash('VerificaClienteAtivo', 'API indisponivel - continuando com dados locais');
    Exit(True);
  end;

  try
    Result := (Lc_Cliente.Ativo = 'S');
  finally
    Lc_Cliente.Free;
  end;
end;

end.

unit Un_Trata_Excecao;

interface

uses
      Classes, SysUtils, Vcl.Forms, UnFunctions, System.Threading, Winapi.Windows, StackTrace, ControllerEstabelecimento, UN_SPLASH;

type
  TTrata_Excecao = class(TThread)
  private
    { Private declarations }
    FOB: TObject;
    FEX: Exception;
    FExceptionClass: TClass;
    FStackTraceText: string;
    FEstabelecimento: TControllerEstabelecimento;
    FPrinterSemDispositivoAposCorrecao: Boolean;
    procedure ThreadTerminated(Sender: TObject);
    function  Fc_GeraEmailErro: String;
    function  Fc_NomeImpressoraPadraoWin: string;
    function  Fc_IndiceNomeImpressora(const ANome: string): Integer;
    function  Fc_ImpressoraIndiceValido: Boolean;

    procedure Pc_TrataSequenciaTabela(Pc_Msg_erro:String);

    procedure Pc_Erro(Pc_MsgErro: String);
    procedure Pc_CorrigeImpressoraVcl;
    procedure HandleExcept;
    procedure setFFOB(const Value: TObject);
    procedure setFFEX(const Value: Exception);
    procedure setFEstabelecimento(const Value: Integer);
  protected
    email : Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure execute;override;
    procedure stop;
    procedure DefineExcecao(const AException: Exception);
    property Objeto :TObject read FOB write setFFOB;
    property Excecao :Exception read FEX write setFFEX;
    property StackTraceText : string read FStackTraceText write FStackTraceText;
    property Estabelecimento : Integer  write setFEstabelecimento;
  end;

function IniciarTrataExcecao: Boolean;
procedure FinalizarTrataExcecao;

Var
  It_cd_Script : Integer;
  It_TxtSql    : String;
  It_TrataExcecaoEmAndamento: Boolean;

implementation

uses     UN_Sistema, UN_Principal, env, un_envia_email, UN_MSG, Un_Funcoes, Vcl.Printers, Winapi.WinSpool, System.HelpIntfs;


function IniciarTrataExcecao: Boolean;
begin
  if It_TrataExcecaoEmAndamento then
    Result := False
  else
  begin
    It_TrataExcecaoEmAndamento := True;
    Result := True;
  end;
end;

procedure FinalizarTrataExcecao;
begin
  It_TrataExcecaoEmAndamento := False;
end;


constructor TTrata_Excecao.Create();
begin
  inherited Create (True);
  FPrinterSemDispositivoAposCorrecao := False;
  FExceptionClass := nil;
  FEstabelecimento := TControllerEstabelecimento.create(nil);
  FreeOnTerminate := True;
  OnTerminate := ThreadTerminated;
end;

destructor TTrata_Excecao.Destroy;
begin
  FreeAndNil(FEX);
  FEstabelecimento.Destroy;
  inherited;
end;

procedure TTrata_Excecao.ThreadTerminated(Sender: TObject);
begin
  FinalizarTrataExcecao;
end;

procedure TTrata_Excecao.DefineExcecao(const AException: Exception);
begin
  FreeAndNil(FEX);
  FExceptionClass := nil;
  if AException = nil then
    Exit;
  FExceptionClass := AException.ClassType;
  FEX := Exception.Create(AException.Message);
end;

procedure TTrata_Excecao.Pc_Erro(Pc_MsgErro: String);
begin
  MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
               Pc_MsgErro + EOLN,
               ['OK'], [bEscape], mpErro);
end;

function TTrata_Excecao.Fc_NomeImpressoraPadraoWin: string;
var
  n: DWORD;
  p: PChar;
  ok: BOOL;
begin
  Result := '';
  n := 0;
  ok := GetDefaultPrinter(nil, @n);
  if (not ok) and (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
    Exit;
  if n = 0 then
    Exit;
  GetMem(p, n * SizeOf(Char));
  try
    if GetDefaultPrinter(p, @n) then
      Result := Trim(string(p));
  finally
    FreeMem(p);
  end;
end;

function TTrata_Excecao.Fc_IndiceNomeImpressora(const ANome: string): Integer;
var
  I: Integer;
  LNome: string;
begin
  Result := -1;
  LNome := Trim(ANome);
  if LNome = '' then
    Exit;
  for I := 0 to Printer.Printers.Count - 1 do
    if SameText(Trim(Printer.Printers[I]), LNome) then
      Exit(I);
end;

function TTrata_Excecao.Fc_ImpressoraIndiceValido: Boolean;
begin
  Result := (Printer.PrinterIndex >= 0) and (Printer.PrinterIndex < Printer.Printers.Count);
end;

procedure TTrata_Excecao.Pc_CorrigeImpressoraVcl;
var
  NomePadrao: string;
  Idx, I: Integer;
  Ok: Boolean;
begin
  FPrinterSemDispositivoAposCorrecao := False;
  try
    if Printer.Printing then
    begin
      try
        Printer.Abort;
      except
      end;
    end;
    if Printer.Printers.Count <= 0 then
    begin
      FPrinterSemDispositivoAposCorrecao := True;
      Exit;
    end;

    Ok := False;
    { 1) Alinhar com a impressora padrao do Windows, se ela existir na lista atual do VCL }
    NomePadrao := Fc_NomeImpressoraPadraoWin;
    Idx := Fc_IndiceNomeImpressora(NomePadrao);
    if Idx >= 0 then
    begin
      try
        Printer.PrinterIndex := Idx;
        Ok := Fc_ImpressoraIndiceValido;
      except
        Ok := False;
      end;
    end;

    { 2) Fallback classico: primeira da lista enumerada }
    if not Ok then
    begin
      try
        Printer.PrinterIndex := 0;
        Ok := Fc_ImpressoraIndiceValido;
      except
        Ok := False;
      end;
    end;

    { 3) Ultimo recurso: Windows / VCL descasados - procurar o primeiro indice que aceite }
    if not Ok then
    begin
      for I := 0 to Printer.Printers.Count - 1 do
      begin
        try
          Printer.PrinterIndex := I;
          if Fc_ImpressoraIndiceValido then
          begin
            Ok := True;
            Break;
          end;
        except
        end;
      end;
    end;
  except
  end;
end;

procedure TTrata_Excecao.execute;
begin
  try
    Synchronize(HandleExcept);
  finally
    Terminate;
  end;
end;


function TTrata_Excecao.Fc_GeraEmailErro: String;
var
  lc_Data: string;
  Lc_nome : String;
  Lc_Ano, Lc_mes, Lc_dia: string;
  LcExe : String;
  LcDataExe : TDateTime;
  I,F:Integer;
  EBP, RetAddr: Pointer;
Begin
   Try
     Lc_Nome := FEstabelecimento.Registro.NomeRazaoSocial;
     Lc_dia := Copy(DatetoStr(Date), 1, 2);
     Lc_mes := Fc_DesMes(Fc_Month(date), True);
     Lc_Ano := Copy(DatetoStr(Date), 7, 4);

    //Data nome do executvel
    LcExe := ExtractFileName(ParamStr(0));
    FileAge(ParamStr(0),LcDataExe);
    LcExe := concat(UpperCase(Copy(LcExe,1,1)),
                    LowerCase(Copy(LcExe,2,Length(LcExe)-1)),' - ',
                    DateTimeToStr(LcDataExe));

     Lc_Data := FEstabelecimento.Endereco.Cidade.registro.Descricao +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de ' + Lc_Ano +' / ' + TimeToStr(Now);
     Result := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> '+
               '<html> '+
               '<head> '+
               '  <meta content="text/html; charset=ISO-8859-1" '+
               ' http-equiv="content-type"> '+
               '  <title>Erros do Sistema Gestão</title> '+
               '</head> '+
               '<body> '+
               '<table style="text-align: left; width: 605px; height: 116px;"  '+
               ' border="1" cellpadding="0" cellspacing="0"> '+
               '  <tbody> '+
               '    <tr> '+
               '      <td style="width: 159px;">Data&nbsp;</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">' + Lc_Data +'</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Cd Cli Setes</td> '+
               '      <td style="width: 10px;">:</td>  '+
               '      <td style="width: 790px;">'+Fc_Tb_Geral('L','CD_CLIENTE_SETES','')+'</td> '+
               '    </tr>  '+

               '    <tr> '+
               '      <td style="width: 159px;">Nome do Cliente</td> '+
               '      <td style="width: 10px;">:</td>  '+
               '      <td style="width: 790px;">'+Lc_Nome+'</td> '+
               '    </tr>  '+

               '    <tr> '+
               '      <td style="width: 159px;">Nome do Computador</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">' + Fc_NomeComputador+'</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Nome do Usuário</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">' + GB_Nm_Usuario + '</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Data da Versão</td> '+
               '      <td style="width: 10px;">:</td>  '+

               '      <td style="width: 790px;">2.002 - '+ Fc_Aq_Geral('L','SISTEMA','Versao',Gb_data_Criacao) +'</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Data Executavel</td> '+
               '      <td style="width: 10px;">:</td>  '+

               '      <td style="width: 790px;">'+ LcExe +'</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Interface</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;"> ';

          F := Screen.FormCount -1;
          for I :=0 to F do
          Begin
            if  ( Screen.Forms[I] <> Fr_Principal) and
                ( Screen.Forms[I].Name <> '') and
                ( Screen.Forms[I].ClassType <> TFr_envia_email) then
                Result := Result + Screen.Forms[I].Name + '<br>';
          End;

          Result := Result +
               '</td> '+
               '    </tr> '+
               '    <tr> '+
               '      <td style="width: 159px;">Descrição do Erro</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FEX.ClassName+' error raised, with message : '+FEX.Message + '</td> '+
               '    </tr> '+
               '    <tr> '+
               '      <td style="width: 159px;">Unit Name</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FEX.UnitName + '</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Base Excetion Message</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FEX.BaseException.Message + '</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">Base Excetion Class Name</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FEX.BaseException.ClassName + '</td> '+
               '    </tr> '+
               '    <tr> '+
               '      <td style="width: 159px;">Stack Trace</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ StringReplace(FStackTraceText, #13#10, '<br>', [rfReplaceAll]) + '</td> '+
               '    </tr> '+
               '    <tr> '+
               '      <td style="width: 159px;">ClassName</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FOB.ClassName + '</td> '+
               '    </tr> '+

               '    <tr> '+
               '      <td style="width: 159px;">ClassParent</td> '+
               '      <td style="width: 10px;">:</td> '+
               '      <td style="width: 790px;">'+ FOB.ClassParent.ClassName + '</td> '+
               '    </tr> ';

          Result := Result +
               '  </tbody> '+
               '</table> '+
               '</body> '+
               '</html> ';

   Except

      on E:Exception do
        Result := E.message;
   End;

end;


procedure TTrata_Excecao.HandleExcept;
var
  Lc_I, Lc_F:integer;
  Lc_NomeTabela:String;
  Lc_Msg_erro : String;
  Lc_Erro : String;
  LcEnviaemail : TFr_envia_email;
  LcPAthFilePrint:String;
Begin
  if FEX = nil then
    Exit;
  Lc_Msg_erro := FEX.Message;

  if (FExceptionClass = EHelpSystemException) or
     (Pos('No context-sensitive help installed', Lc_Msg_erro) > 0) then
    exit;

  //Mensagem da Nota Fiscal Eletronica dizendo que o numero da nota já foi usada e não pode ser inutilizada
  if (Pos('Um numero da faixa', Lc_Msg_erro) > 0)  then
  Begin
    exit;
  end;

  if (Pos('printer index out of range', LowerCase(Lc_Msg_erro)) > 0) or
     ((FExceptionClass = EPrinter) and
      (Pos('printer', LowerCase(Lc_Msg_erro)) > 0) and
      (Pos('out of range', LowerCase(Lc_Msg_erro)) > 0)) then
  begin
    Pc_CorrigeImpressoraVcl;
    if FPrinterSemDispositivoAposCorrecao then
      Pc_Erro(concat('Não há impressoras instaladas ou disponíveis neste Windows.',#13,#13,
                     'Instale ou ative uma impressora e tente novamente.'))
    else
      Pc_Erro(concat('A impressora que o sistema usava deixou de existir ou a lista de impressoras do Windows mudou ',#13,
                     '(índice fora da faixa).',#13,#13,
                     'O sistema tentou: (1) a impressora padrão do Windows, se constar na lista; ',
                     '(2) a primeira impressora da lista; (3) o primeiro índice que o Windows aceitar.',#13,#13,
                     'Tente imprimir novamente.'));
    exit;
  end;


  //Trata os erros de tabelas que precisam ser reajustadas
  if (Pos('must have a value', Lc_Msg_erro) > 0)  then
  Begin
    Pc_Erro(concat('Este campo precisa ter algum valor.',#13,#13,
                   'Verifique para continuar.'
            ));
    exit;
  end;

  //Trata os erros de tabelas que precisam ser reajustadas
  if (Pos('violation of PRIMARY', Lc_Msg_erro) > 0)  then
  Begin
    Pc_TrataSequenciaTabela(Lc_Msg_erro);
    exit;
  end;


  if (Pos('Servico Paralisado Momentaneamente', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('O serviço da NF-e está paralisado momentaneamente.',#13,#13,
                   'Aguarde o serviço retornar para autorização on-line.'
            ));
    exit;
  end;

  if (Pos('Unable to complete network', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('A tua conexão de rede está muito instável.',#13,#13,
                   'Por favor entre em contato com o suporte técnico',#13,#13,
                   ' para fazer a devida avaliação.'
            ));
    exit;
  end;


  if (Pos('Erro Interno: 12002', Lc_Msg_erro) > 0) or
     (Pos('Connection timed out', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('O tempo da operação demorou muito e o servidor interrompeu a operação.',#13,#13,
                   'Possíveis causas:.',#13,
                   '1º - A internet interna',#13,
                   '2º - A operadora de Internet,',#13,
                   '3º - Servidor Externo demorou para processar'
            ));
    exit;
  end;

  if (Pos('is not a valid BCD value', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Não foi digitado um valor válido',#13,#13,
                   'Verifique se não tem 2 virgulas ou caracter inválido.'
            ));
    exit;
  end;

  if (Pos('is not a valid date', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Não foi digitado uma data válida',#13,#13,
                   'Verifique para continuar.'
            ));
    exit;
  end;

  if (Pos('is not a valid integer', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Não foi digitado um número inteiro válido',#13,#13,
                   'Verifique para continuar.'
            ));
    exit;
  end;

  if (Pos('Integer overflow', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Não foi digitado um número inteiro válido',#13,#13,
                   'Verifique para continuar.'
            ));
    exit;
  end;


  if (Pos('Invalid file name - %', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Aparentemente o sistema não conseguiu enviar a impressão',#13,
                   'Verifique a impressora e suas conexões',#13,#13,
                   'Verifique para continuar.'
            ));
    exit;
  end;

  if (Pos('is not a valid BCD value', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('Não foi digitado um valor válido',#13,#13,
                   'Verifique se não tem 2 virgulas ou caracter inválido.'
            ));
    exit;
  end;


  if (Pos('O tempo limite da operação foi atingido', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('O tempo para execução da tarefa expirou.',#13,#13,
                   'Tente novamente.'
            ));
    exit;
  end;

  if (Pos('não pôde ser resolvido', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro(concat('O Sistema não conseguiu encontrar o servidor da receita',#13,#13,
                   'Verifique as conexões com a internet ou tente novamente.'
            ));
    exit;
  end;

  if (Pos('violation of FOREIGN KEY constraint', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Existe algum problema de relacionamento entre Tabelas'+#13+#13+
            'Este registro foi ou não consegue ser referenciado com outras tabelas.');
    exit;
  end;

  if (Pos('Uma conexão com o servidor não pôde ser', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Conexão com o servidor não pode ser estabelecida.'+#13+#13+
            'Erro de conexão com a internet ou apenas falha de conexão momentânea.');
    exit;
  end;

  if (Pos('is not a valid floating point value', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Verifique o valor digitado');
    exit;
  end;



  if (Pos('File access denied', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Acesso ao arquivo negado.'+#13+#13+
            'Verifique problemas de Compatilhamento(Arquvo/Impressora).');
    exit;
  end;



  if (Pos('multiple sources or destinations specified', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Tem algo errado com o destino do Backup'+#13+
            'Verifique antes de continuar');
    exit;
  end;

  if (Pos('error code = -303', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Verifique se o que foi digitado está correto para o campo atual.'+#13+
            'Verifique antes de continuar');
    exit;
  end;

  if (Pos('CPF do destinatario invalido', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('CPF do destinatário inválido'+#13+
            'Verifique antes de continuar');
    exit;
  end;

  if (Pos('Not in edit mode', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Esta tela não está em modo de edição'+#13+
            'Verifique antes de continuar');
    exit;
  end;


  if (Pos('HTTP: 500', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Erro: HTTP: 500'+#13+
            'Houve um erro interno do Servidor com '+#13+
            'o qual está tentando se comunicar.'+#13+
            'Aguarde um pouco de tente novamente');
    exit;
  end;

  if (Pos('Ja existe pedido de Inutilizacao com a mesma faixa de inutilizacao', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Já existe pedido de Inutilização com a mesma faixa de inutilização'+#13+
            'Verifique antes de continuar');
    exit;
  end;

  if (Pos('CNPJ deve ter 14 dígitos', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('CNPJ deve ter 14 dígitos'+#13+
            'Verifique antes de continuar');
    exit;
  end;


  if (Pos('Data de Validade do Certificado já expirou', Lc_Msg_erro) > 0) then
  begin
    Pc_Erro('Data de Validade do Certificado já expirou.'+#13+
            'Verifique antes de continuar');
    exit;
  end;


  //quando a operação e cancelada pelo usuario
  Lc_Erro := Copy( Lc_Msg_erro,1,37);
  IF (Lc_Erro = 'A operação foi cancelada pelo usuário') then
  Begin
    exit;
  end;
  //trata os erros que não precisam de mensagem na tela
  if (Copy( Lc_Msg_erro,1,40) = 'The connection with the server was reset') then exit;
  if (Copy( Lc_Msg_erro,1,42) = 'A conexão com o servidor foi reconfigurada') then exit;

  //trata os Erros que não precisam de envio de email

  //erro interno gerado pela Receita
  Lc_Erro := Copy( Lc_Msg_erro,1,12);
  IF (Lc_Erro = 'Erro interno') then
    Begin
    Pc_Erro('A servidor da Receita gerou um erro interno.' + EOLN +
            'Aguarde alguns instantes e tente novamente.');
    exit;
    end;


  //Quando a impressora selecionada não é valida
  Lc_Erro := Copy( Lc_Msg_erro,1,29);
  IF (Lc_Erro = 'Printer selected is not valid') then
    Begin
    Pc_Erro('Impressora selecionda não é válida.' + EOLN +
            'Verifique se a impressora está ligada e acessível.');
    exit;
    end;

  //Quando a impressora não está imprimindo
  Lc_Erro := Copy( Lc_Msg_erro,1,20);
  IF (Lc_Erro = 'Printing in progress') then
  Begin
    Pc_Erro('                   Impressão em andamento.' + EOLN +
            'Solicitar múltiplas impressões antes da resposta da impressora' + EOLN +
            'pode gerar instabilidade no sistema, aguarde um instante.');
    exit;
  end;

  //Quando a impressora não está imprimindo
  Lc_Erro := Copy( Lc_Msg_erro,1,33);
  IF (Lc_Erro = 'Printer is not currently printing') then
  Begin
    Pc_Erro('Impressora não está imprimindo.' + EOLN +
            'Verifique se a impressora está ligada e acessível.');
    exit;
  end;

  //Quando a impressora não está imprimindo
  Lc_Erro := Copy( Lc_Msg_erro,1,46);
  IF (Lc_Erro = 'There is no default printer currently selected') then
  Begin
    Pc_Erro('Não há impressora padrão selecionada.' + EOLN +
            'Verifique antes de continuar.');
    exit;
  end;

  //Consulta WebService receita
  Lc_Erro := Copy( Lc_Msg_erro,1,34);
  IF (Lc_Erro = 'WebService Consulta Status serviço') then
  Begin
    exit;
  end;

  //Backup
  Lc_Erro := Copy( Lc_Msg_erro,1,23);
  IF (Lc_Erro = 'cannot open backup file') then
  Begin
    Pc_Erro('Verifique se as mídias (pendrive/hd externo) estão conectadas.' + EOLN +
            'Observe também a letra da unidade de disco.');
    exit;
  end;

  //criar arquivo
  Lc_Erro := Copy( Lc_Msg_erro,1,18);
  IF (Lc_Erro = 'Cannot create file') then
  Begin
    Pc_Erro('O arquivo não pode ser criado.' + EOLN +
            'Verique problemas de permissão, ou ele está sendo usado por outro processo.');
    exit;
  end;

  //criar arquivo
  Lc_Erro := Copy( Lc_Msg_erro,1,18);
  IF (Lc_Erro = 'Cannot open file') then
  Begin
    Pc_Erro('O arquivo não pode ser aberto.' + EOLN +
            'O sistema não achou o arquivo.');
    exit;
  end;


  //Lote em processamento
  Lc_Erro := Copy( Lc_Msg_erro,1,21);
  IF (Lc_Erro = 'Lote em processamento') then
  Begin
    Pc_Erro('O lote de Notas enviadas estão em processamento.' + EOLN +
            'Aguarde alguns instantes e solicite o retorno.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,35);
  IF (Lc_Erro = 'Socket Error # 11001 Host not found') then
  Begin
    Pc_Erro('Libere o sistema no seu anti vírus / firewall ' + EOLN +
            'ou tente executar o sistema como administrador.');
    exit;
  end;

  //Erro Sem certficado
  IF (Copy( Lc_Msg_erro,1,59) = 'A certificate is required to complete client authentication') or
     (Copy( Lc_Msg_erro,1,59) = 'É necessário ter um certificado para concluir a autenticaçã') or
     (Copy( Lc_Msg_erro,1,34) = 'Certificado Digital não encontrado') or
     ( (Copy( Lc_Msg_erro,1,11) = 'Certificado') and (pos('não encontrado',Lc_Msg_erro)>0 )  ) then
  Begin
    Pc_Erro('Por favor verifique se o certificado está presente.' + EOLN +
            'O sistema precisa fazer a autenticação para continuar.');
    exit;
  end;


  Lc_Erro := Copy( Lc_Msg_erro,1,34);
  IF (Lc_Erro = 'Serviço Paralisado Momentaneamente') then
  Begin
    Pc_Erro('A Receita informa que o serviço está paralisado momentâneamente.' + EOLN +
            'Aguarde alguns instantes e tente novamente.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,18);
  IF (Copy( Lc_Msg_erro,1,19) = 'Certificado Digital') or
     (Copy( Lc_Msg_erro,1,19) = 'O conjunto de chave') or
     (Copy( Lc_Msg_erro,1,18) = 'A chave não existe') or
     (Copy( Lc_Msg_erro,1,47) = 'An error occurred in the secure channel support') then
  Begin
    Pc_Erro('Por favor verifique se o certificado está presente.' + EOLN +
            'O sistema precisa fazer a autenticação para continuar.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,21);
  IF (Lc_Erro = 'Classe não registrada') then
  Begin
    Pc_Erro('Classe não registrada ' + EOLN +
            'Instale as DLL''s necessárias para operar o Certificado.' + EOLN +
            'Execute esta operação antes de continuar.');
    exit;
  end;


  IF (Copy( Lc_Msg_erro,1,53) = 'A connection with the server could not be established') or
     (Copy( Lc_Msg_erro,1,19) = 'Service Unavailable') then
  Begin
    Pc_Erro('A conexão com o servidor não pôde ser estabelecida.' + EOLN +
            'Se está operando NF-e. aguarde uns instantes antes de continuar.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,24);
  IF (Lc_Erro = 'Nota(s) não confirmadas:') then
  Begin
    Pc_Erro(Lc_Msg_erro);
    exit;
  end;

  if (Pos('The operation timed out - URL:https://nfe', Lc_Msg_erro) > 0) or
     (Pos('O tempo limite da oper', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O Servidor não respondeu no tempo esperado.' + EOLN +
            'Sua solicitação está na fila, aguardando avaliação.' + EOLN+
            'Aguarde uns instantes e solicite o retorno.');
    exit;
  end;

  if (Pos('O tempo limite da operação foi atingido', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O Servidor não respondeu no tempo esperado.' + EOLN +
            'Isso acontece por questões de segurança.' + EOLN+
            'Tente novamente.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,20);
  IF (Lc_Erro = 'Invalid input value.') then
  Begin
    Pc_Erro('Por favor preencha o campo adequadamente.' + EOLN +
            'Observe o formato do dado que o campo necessita.');
    exit;
  end;

  //Comeca o Tratamento conforme a identificaçao de cada mensagem
  {O tratamento a seguir é para perda de conexão com o banco de dados
   O sistema vai fechar todas as telas e reconectar com o banco.  }
  Lc_Erro := Copy( Lc_Msg_erro,1,42);
  IF (Lc_Erro = 'Unable to complete network request to host') then
  Begin
    Lc_I := 0;
    Repeat
      if ( ( Screen.Forms[Lc_I] <> Fr_Principal) and
           ( Screen.Forms[Lc_I] <> Fr_envia_email) and
           ( Screen.Forms[Lc_I].ClassType <> TFr_envia_email) and
           ( Screen.Forms[Lc_I] <> SplashForm ) ) then
      Begin
        Screen.Forms[Lc_I].Close;
        Screen.Forms[Lc_I].DisposeOf;
      End;
      inc(Lc_I);
    Until (Screen.FormCount - 3) <=0  ;

//    ( ( Screen.Forms[Lc_I] <> Fr_Principal) and ( Screen.Forms[Lc_I].ClassType <> TFr_envia_email) and  ( Screen.Forms[Lc_I] <> SplashForm ) )

    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Perda momentânea de conexão com o Banco de dados.' + EOLN +
                    'O sistema tentará restabelecê-la' + EOLN,
                    ['OK'], [bEscape], mpErro);
    Pc_Conecta(GbPathExe + 'Config.INI');
    exit;
  end;


  Lc_Erro := Copy( Lc_Msg_erro,1,34);
  IF (Lc_Erro = '5.1.3 Bad recipient address syntax') then
  Begin
    Pc_Erro('O endereço de email está errado ou ' + EOLN +
            'foi rejeitado pelo servidor. Verifique!');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,48);
  IF (Lc_Erro = 'Serviço Paralisado Momentaneamente (curto prazo)') then
  Begin
    Pc_Erro(Lc_Msg_erro);
    exit;
  end;


  Lc_Erro := Copy( Lc_Msg_erro,1,45);
  IF (Lc_Erro = 'NF-e autorizada há mais de 7 dias (168 horas)') then
    Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   Lc_Msg_erro + EOLN,
                    ['OK'], [bEscape], mpErro);
    exit;
    end;

  Lc_Erro := Copy( Lc_Msg_erro,1,31);
  IF (Lc_Erro = 'A call to an OS function failed') then
  Begin
    Pc_Erro('Sem resposta a uma chamada do Sistema Operacional.' + EOLN +
            'Tente novamente.');
    exit;
  end;

  Lc_Erro := Copy( Lc_Msg_erro,1,60);
  IF (Lc_Erro = 'System Error. Code: 1722. O servidor RPC não está disponível') then
  Begin
    Pc_Erro('Sem resposta a uma chamada do Sistema Operacional.' + EOLN +
            'O servidor RPC não está disponível.');
    exit;
  end;
  //The requested operation has been cancelled by the user
  Lc_Erro := Copy( Lc_Msg_erro,1,54);
  IF (Lc_Erro = 'The requested operation has been cancelled by the user') then
  Begin
    //É apenas informação e escapamos aqui
    exit;
   end;

  //Erro I/O error 64 - Erro de Rede
  Lc_Erro := Copy( Lc_Msg_erro,1,12);
  IF (Lc_Erro = 'I/O error 64') then
  Begin
    Pc_Erro('Por favor verifique as conexões de rede.' + EOLN +
            'O sistema identificou instabilidade em sua rede.');
    exit;
  end;

  //Erro I/O error 21 - Mídia não encontrada
  Lc_Erro := Copy( Lc_Msg_erro,1,12);
  IF (Lc_Erro = 'I/O error 21') then
  Begin
    Pc_Erro('O sistema está tentando acessar uma mídia que não está disponível.' + EOLN +
            'Verifique, reconecte a mídia se for o caso e tente novamente.');
    exit;
  end;

  //Erro I/O error 103 - File not open
  Lc_Erro := Copy( Lc_Msg_erro,1,13);
  IF (Lc_Erro = 'I/O error 103') then
  Begin
    Pc_Erro('Por favor verifique as conexões da Impressora.' + EOLN +
            'O sistema não consegue enviar a impressão.');
    exit;
  end;

  //Erro I/O error 103 - não consegue abrir um arquivo que está na rede
  Lc_Erro := Copy( Lc_Msg_erro,1,12);
  IF (Lc_Erro = 'I/O error 53') then
  Begin
    Pc_Erro('Por favor verifique as conexões de rede.' + EOLN +
            'O sistema não consegue abrir um arquivo que está na rede.');
    exit;
  end;


  //Erro I/O error 105 - File not open for output
  Lc_Erro := Copy( Lc_Msg_erro,1,13);
  IF (Lc_Erro = 'I/O error 105') then
  Begin
    Pc_Erro('Por favor verifique as configurações da Impressora.' + EOLN +
            'O sistema não consegue enviar a impressão.');
    exit;
  end;

  //The operation timed out - O servidor não respondeu no tempo esperado
  Lc_Erro := Copy( Lc_Msg_erro,1,23);
  if (Pos('The operation timed out', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O Servidor Web não respondeu no tempo esperado.' + EOLN +
            'A operação pode não ter sido realizada, tente novamente.');
    exit;
  end;

  //Invalid floating ponint operation - Valor não real não é valido
  Lc_Erro := Copy( Lc_Msg_erro,1,33);
  IF (Lc_Erro = 'Invalid floating ponint operation') then
  Begin
    Pc_Erro('O valor que foi digitado, não obedece o formato de valores' + EOLN +
            'configurados no painel de controle do windows.');
    exit;
  end;

  //deadlock update conflicts with
  Lc_Erro := Copy( Lc_Msg_erro,1,30);
  IF (Lc_Erro = 'deadlock update conflicts with') then
  Begin
    Pc_Erro('Existe outra tela utilizando alguma tabela ao mesmo tempo.' + EOLN+
            'Não é possivel atualizar duas tabelas ao mesmo tempo.'+ EOLN+
            'Encerre esta operação e tente novamente.');
    exit;
  end;

  //Erro na consulta do CNPJ na receita
  Lc_Erro := Copy( Lc_Msg_erro,1,16);
  IF (Lc_Erro = 'Erro na Consulta') then
  Begin
    Pc_Erro('Erro na consulta.' + EOLN+
            'Verifique os dados na imagem ou sua conexão com a internet.');
    exit;
  end;

  //Erro na consulta do CNPJ na receita
  Lc_Erro := Copy( Lc_Msg_erro,1,53);
  IF (Lc_Erro = 'Erro na hora de fazer o download da imagem do captcha') then
  Begin
    Pc_Erro('Erro ao buscar a imagem do capctha.' + EOLN+
            'Verifique sua conexão com a internet.');
    exit;
  end;

  //Erro na consulta do CNPJ na receita
  Lc_Erro := Copy( Lc_Msg_erro,1,29);
  IF (Lc_Erro = 'Erro: Requisição não enviada.') then
  Begin
    Pc_Erro('Por favor veirifique configurações do Certificado Digital.' + EOLN+
            'Eles devem estar com SSL 2.0 e TLS 1.0.');
    exit;
  end;

  if (Pos('Informado NCM inexistente', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O NCM informado é inválido ou não é mais utilizado' + EOLN +
            'Veja na tela de acompamento qual é o item que precisa se reviado');
    exit;
  end;
  //Motrar mensagem amigavel mas ainda assim enviar email (não tem Exit)
  if (Pos('Cannot perform this operation on a closed dataset', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O sistema não conseguiu abrir uma tabela para continuar a operação.' + EOLN +
            'Por favor feche a tela e tente novamente.' + EOLN +
            'Caso o erro persista informe ao desenvolvedor do sistema.');
    exit;
  end;

  //Motrar mensagem amigavel mas ainda assim enviar email (não tem Exit)
  if (Pos('Cannot focus', Lc_Msg_erro) > 0) then
  Begin
    Pc_Erro('O sistema não consegue dar foco no campo desejado.' + EOLN +
            'Verifique o preenchimento do campo atual ou ' + EOLN +
            'Se o próximo campo está acessível.');
    exit;
  end;

//------------------------------------------------------------------------------------
  {erros que serão enviados via email}
  //Chama o Formulario e comeca o envio
  //Synchronize(
  if Terminated then
  Begin
    exit;
  End;


  try
    //ApagaArquivosTemp;
    //LcPathFilePrint := CriaArquivoJpg;
    //Relaciona os forms abertos
    //Pc_LimpaFormSemNome;

    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
      Terminado := False;
      It_Tipo_Envio := 'A';
      It_Assunto  := 'Envio automático de erro ou exceção no Gestão';
      It_Destino.Add(' suporte@setes.com.br');
      It_Corpo    := Fc_GeraEmailErro;
      if FileExists(LcPathFilePrint) then
        It_Anexo.Add(LcPathFilePrint)
      else
        It_Anexo.Add('Sem anexo');
      Pc_Define_Rementente;
      Fc_EnviaEmail;
    end;
  finally
    //Destroy as StringList
    LcEnviaemail.Close;
    FreeAndNil( LcEnviaemail );
  end;


  {O tratamento a seguir trata quando o componente de visualização fica travado na memoria
  impedindo que outros relatorios sejam abertos}
  if trim(Lc_Erro) = '' then exit;

  Lc_Erro := Copy(Lc_Msg_erro,1,35);
  IF (Lc_Erro = 'A component named QRStandardPreview') then
  Begin
    Lc_F := Screen.FormCount -1;
    for Lc_I :=0 to Lc_F do
    Begin
      if Screen.Forms[Lc_I].Name = 'QRStandardPreview' then
      Begin
        Screen.Forms[Lc_I].Close;
        Screen.Forms[Lc_I].disposeOf;
      End;
    end;
    exit;
  end;

  {O tratamento a seguir trata a violação de acesso a memoria.
   O sistema vai fechar todos os formualários abertos}

  if (Pos('Access violation at address', Lc_Msg_erro) > 0) then
  Begin
    Lc_I := 0;
    Repeat
      if ( ( Screen.Forms[Lc_I] <> Fr_Principal) and
           ( Screen.Forms[Lc_I].ClassType <> TFr_envia_email) and
           ( Screen.Forms[Lc_I] <> SplashForm ) ) then
      Begin
        Screen.Forms[Lc_I].Close;
        Screen.Forms[Lc_I].disposeof;
      End;
      inc(Lc_I);
    Until (Screen.FormCount - 3) <=0  ;
    Pc_Erro('Instabilidade do Sistema na Memória.' + EOLN +
          'O Sistema está reorganizando as informações' + EOLN +
          'Esta operação será encerrada.');

    exit;
  end;

  {O tratamento a seguir é para casos em que uma operação for executada sem o
  o banco de dados estar aberto. O sistema vai conectar em seguida}
  Lc_Erro := Copy(Lc_Msg_erro,1,42);
  IF (Lc_Erro = 'Cannot perform operation -- DB is not open') then
  Begin
    Pc_Conecta(GbPathExe + 'Config.INI');
    exit;
  end;

  IF (Lc_Erro = 'Cannot perform operation -- DB is currently open') then
  Begin
    Pc_Conecta(GbPathExe + 'Config.INI');
    exit;
  end;

  {O Tratamento a seguir é para erros com o envio de email.
   O caso especifico é para a conexão com SMTP for fechada por erro ou por solicitação}
  Lc_Erro := Copy(Lc_Msg_erro,1,17);
  IF (Lc_Erro = 'connection closed') Then
  begin
    Pc_Erro('Envio de e-mail cancelado.');
    for Lc_I :=0 to Screen.FormCount -1 do
    Begin
      if Screen.Forms[Lc_I].ClassType = TFr_envia_email then
      Begin
        Screen.Forms[Lc_I].Close;
        Screen.Forms[Lc_I].disposeof;
      End;
    end;
    exit;
  End;

  {O Tratamento a seguir é para erros com o envio de email.
   O caso especifico é para a conexão com SMTP não estiver conectada}
  Lc_Erro := Copy(Lc_Msg_erro,1,13);
  IF (Lc_Erro = 'Not Connected') Then
  begin
    Lc_I := 0;
    Repeat
      if ( ( Screen.Forms[Lc_I] <> Fr_Principal) and
           ( Screen.Forms[Lc_I].ClassType <> TFr_envia_email) and
           ( Screen.Forms[Lc_I] <> SplashForm ) ) then
      Begin
        Screen.Forms[Lc_I].Close;
        Screen.Forms[Lc_I].disposeof;
      End;
      inc(Lc_I);
    Until (Screen.FormCount - 3) <=0  ;

    Pc_Erro('Envio de e-mail cancelado.');
    exit;
  End;

  {O Tratamento a seguir é para erros desconhecidos que gerem exceções com a memoria
   O sistema vai matar o processo gestão finalizando a aplicação}
  Lc_Erro := Copy(Lc_Msg_erro,1,36);
  IF (Lc_Erro = 'Exception EAccessViolation in module') then
  Begin
    Pc_Erro('Instabilidade do Sistema na Memória.' + EOLN +
            'O sistema será Encerrado');
    winexec('taskkill /f /im Gestao.exe',sw_hide);
    exit;
  end;
  ///Mostra a mensagem caso não tenha sido tratada acima
  Pc_Erro(Lc_Msg_erro);
end;

procedure TTrata_Excecao.Pc_TrataSequenciaTabela(Pc_Msg_erro:String);
Var
  Lc_Tabela : String;
  Lc_Tamanho : Integer;
  Lc_Posicao : Integer;
  Lc_Campo:String;
  Lc_Generator : String;
  Lc_Sequencia : Integer;

begin
  //tABELA
  Lc_Tamanho := length(Pc_Msg_erro);
  Lc_Posicao := Pos('TB_', Pc_Msg_erro);
  Lc_Tabela := Copy(Pc_Msg_erro,Lc_Posicao,(Lc_Tamanho - Lc_Posicao));
  Lc_Posicao := Pos('"', Lc_Tabela) - 1;
  if Lc_Posicao > 0 then
    Lc_Tabela := copy(Lc_Tabela,1,Lc_Posicao);
  if Lc_Tabela  = 'TB_ITENS_NFL' then
  Begin
    Lc_Campo := 'ITF_CODIGO';
    Lc_Generator := 'GN_ITENS_NFL';
  end;
  if Lc_Tabela  = 'TB_PRODUTO' then
  Begin
    Lc_Campo := 'PRO_CODIGO';
    Lc_Generator := 'GN_PRODUTO';
  end;
  if Lc_Tabela  = 'TB_PEDIDO' then
  Begin
    Lc_Campo := 'PED_CODIGO';
    Lc_Generator := 'GN_PEDIDO';
  end;

  if Lc_Tabela  = 'TB_RETORNO_NFC' then
  Begin
    Lc_Campo := 'NFC_CODIGO';
    Lc_Generator := 'GN_RETORNO_NFC';
  end;
  if (Trim(Lc_Tabela)<> '') and (Trim(Lc_Campo)<> '') and (Trim(Lc_Generator)<> '') then
  Begin
    Lc_Sequencia := FEstabelecimento.getMaxTable(Lc_Campo,Lc_Tabela);
    FEstabelecimento.setGenerator(Lc_Generator, Lc_Sequencia.ToString());
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'O sistema precisou ajustar a sequencia de registro do cadastro.' + EOLN +
                   'Execute novamente a operação.' + EOLN,
                    ['OK'], [bEscape], mpInformacao);
  end;
end;

procedure TTrata_Excecao.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento.Registro.Codigo := Value;
  FEstabelecimento.getbyID;
  FEstabelecimento.Endereco.Registro.CodigoEmpresa := FEstabelecimento.Registro.Codigo;
  FEstabelecimento.Endereco.getByEmpresa;
  FEstabelecimento.Endereco.Cidade.Registro.Codigo := FEstabelecimento.Endereco.Registro.CodigoCidade;
  FEstabelecimento.Endereco.Cidade.getbyId;
end;

procedure TTrata_Excecao.setFFEX(const Value: Exception);
begin
  DefineExcecao(Value);
end;

procedure TTrata_Excecao.setFFOB(const Value: TObject);
begin
  FOB := Value;
end;

procedure TTrata_Excecao.stop;
begin
  terminate;
  WaitFor;
end;

end.




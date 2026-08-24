unit tas_gera_nfe_autorizacao;

interface

uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IniFiles, DB, STQuery, Grids, DBGrids, Menus, Mask, Printers, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnLeitor, ACBrNFeNotasFiscais, ACBrNFeWebServices, ACBrNFeDANFeRLClass, QuickRpt, System.StrUtils, FavoritoButtons, Gauges, XMLDoc, XMLIntf, System.Math, filectrl, Registry, WinINEt, ExtActns, ACBrNFeDANFeESCPOS, TypInfo, IdTCPConnection, IdTCPClient, IdHTTP, XSBuiltIns, blcksock, DBCtrls, Spin, QEdit_Setes, pcnConversaoNfe, ACBrPosPrinter, ACBrBase, ACBrDFe, ShellAPI, zlib, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, Vcl.AppEvnts, STDataSet, un_geranfe3X, ACBrNFe.Classes, ControllerRetornoNFe, ACBrDFe.Conversao, Xml.Win.msxmldom, // TXMLDocument + vendor MSXML
    Winapi.ActiveX, Winapi.msxml, System.Win.ComObj;              // CoInitialize + IXMLDOM*

type
  TTasGeraNfeAutorizacao = class(TFr_GeraNfe3x)
    tbs_NF_e: TTabSheet;
    Panel4: TPanel;
    Sb_NF_Autorizar: TSpeedButton;
    Sb_NF_Conferir: TSpeedButton;
    Sb_NF_sair: TSpeedButton;
    Sb_NF_Envia: TSpeedButton;
    Sb_NF_Imprimir: TSpeedButton;
    Sb_NF_Consultar: TSpeedButton;
    Sb_NF_Cancelar: TSpeedButton;
    pnl_NF_e: TPanel;
    Lb_titulo: TLabel;
    MM_Acompanhamento: TMemo;
    E_Obs: TMemo;
    CkBx_Nota_Manual: TCheckBox;
    ChBx_NF_Referenciada: TCheckBox;
    ChBx_NF_PreExistente: TCheckBox;
    ChBx_Otimiza_obs: TCheckBox;
    procedure Sb_NF_CancelarClick(Sender: TObject);
    procedure Sb_NF_ConferirClick(Sender: TObject);
    procedure Sb_NF_sairClick(Sender: TObject);
    procedure Sb_NF_AutorizarClick(Sender: TObject);
    procedure Sb_NF_ImprimirClick(Sender: TObject);
    procedure Sb_NF_EnviaClick(Sender: TObject);
    procedure Sb_NF_ConsultarClick(Sender: TObject);
    procedure ChBx_NF_PreExistenteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure PreencheDanfeIde(dfide:TIde;Oper_Consulta:Boolean);Override;
    procedure PreencheDanfeInfAdic;Override;
  protected
    RetornoNFE : TControllerRetornoNFe;

    procedure FormataTela;Override;
    procedure CriarVariaveis;Override;
    procedure FinalizarVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure IniciaVariaveis;Override;


    procedure Pc_CancelaNFe_Pendente; Virtual;
    procedure TrataRetorno(Var Pc_Cd_Retorno: Integer; pc_Memo: TMemo; OnLine:Boolean);Override;
    Function Autoriza(Fc_Cd_Pedido, Fc_Cd_Nota, Fc_Nr_Nota: Integer;
      Fc_Path, FC_FileXML: String): Integer;
    procedure AutorizaNFe;
    procedure ImprimeNFe;Virtual;

    procedure Pc_CancelaNFe;
    procedure Pc_CancelamentoNotasNFe;

    function Fc_UpdateRetornoNFe(chave:String): Boolean;

    function Fc_ValidaAutorizacaoNFe(Fc_Cd_Nota: Integer): Boolean;

    function ValidaCancelamentoNotasNFe: Boolean;
    function Fc_CancelaNFe(Fc_Path, FC_FileXML: String): Boolean;
    procedure Pc_ImprimeConferencia;
    function Fc_DefineNumeroNotaNFe(): Boolean;
    function Pc_DocFiscalReferenciada(Pc_Ide: Tide):Boolean;
    procedure Pc_ConsultaNFe;
    procedure Pc_FinalizaCancelamentoNFe;
    procedure ImprimeNFeTerceiro;Virtual;
    procedure Pc_EnviaNFe;
    Function Fc_ConsultaNFe(Fc_Cd_Pedido, Fc_Cd_Nota, Fc_Nr_Nota: Integer;
      Fc_Path, FC_FileXML: String): Integer;
    Function Fc_AtualizaRetornoNFe(Fc_Cd_Retorno, Fc_Cd_Nota,
      Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;

    function CarregaComponenteNFE(Pc_Path,Pc_FileXMl:String):Boolean; Override;
  public
    { Public declarations }
  end;

var
  TasGeraNfeAutorizacao: TTasGeraNfeAutorizacao;

implementation

uses     un_sistema, RN_Permissao, env, UN_Principal, ControllerBase, Un_DM, un_msg, Un_Funcoes, RN_NotaFiscalEletronica3X, Un_MultiEmpresa, Un_Regra_Negocio, Un_Doc_Fiscal_Referenciado, TrataXMLNFe, Un_Fc_Sored_Procedures;
{$R *.dfm}

{ TTasGeraNfeAutorizacao }

function TTasGeraNfeAutorizacao.Autoriza(Fc_Cd_Pedido, Fc_Cd_Nota,
  Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;
var
  Lc_Cd_Retorno: Integer;
  Lc_Cd_Vinculo: Integer;
begin
  With Fr_Principal.Nfe, MM_Acompanhamento do
  Begin
    WebServices.Consulta.Clear;
    WebServices.Retorno.Clear;
    WebServices.Enviar.Clear;
    Lines.Add('ENVIANDO OS DADOS DA NOTA...');
    MM_Acompanhamento.Update;
    try
      DANFE.MostraPreview := True;
      TRY
        Enviar(0,True,true,false);
      except
        on E: Exception do
          Lines.Add(E.ClassName + ' error raised, with message : ' + E.Message);
      end;
    finally
      Lc_Cd_Retorno := WebServices.Retorno.cStat;
      NotasFiscais.Items[0].GravarXML(FC_FileXML, Fc_Path);
      // Faz o Tratamento do Retorno convertendo o codigo da Receita em Codigo interno
      TrataRetorno(Lc_Cd_Retorno, MM_Acompanhamento,True);
      // Salva Retorno
      Lines.Add('ATUALIZANDO A SITUAÇÃO DO RETORNO...');
      MM_Acompanhamento.Update;
      if (Lc_Cd_Retorno > 0) AND (Lc_Cd_Retorno < 5)  then
      Begin
        with RetornoNFE do
        Begin
          Registro.NotaFiscal :=It_Cd_Nota;
          getByNotaFiscal;
          Registro.NotaFiscal      := It_Cd_Nota;
          Registro.Serie           := StrToIntDef(NotaFiscal.Registro.Serie,1);
          Registro.Situacao        := Lc_Cd_Retorno;
          Registro.NomeArquivo     := FC_FileXML;
          Registro.NumeroInicial   := StrZero(Fc_Nr_Nota, 6, 0);
          Registro.NumeroFinal     := StrZero(Fc_Nr_Nota, 6, 0);
          Registro.Estabelecimento := Gb_CodMha;
          salva;
        End;

        // Salva o Arquivo em Banco de dados
        Lines.Add('SALVANDO O ARQUIVO NO BANCO DE DADOS...');
        MM_Acompanhamento.Update;
        Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(It_Cd_Nota);
        Pc_Insere_Arq_Banco(Fc_Path, FC_FileXML, 1, 'XML', Lc_Cd_Vinculo);
      End;
      if (Lc_Cd_Retorno = 5) then
      Begin
        // processo de cancelamento para nota denegada
        Pc_FinalizaCancelamentoNFe;
      end;
      Result := Lc_Cd_Retorno;
      Lines.Add('FINALIZÇÃO DO PROCESSO DE AUTORIZÇÃO...');
      MM_Acompanhamento.Update;

    end;
  End;
end;

procedure TTasGeraNfeAutorizacao.AutorizaNFe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_FilePDF: String;
  Lc_Cd_Retorno: Integer;
Begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Atualizar dados da nota fiscal/Financeiro e Comissao
  Pc_atualiza_dadosnotafiscal(It_Cd_Codmha);
  financeiro.Registro.CodigoNota := It_Cd_Nota;
  financeiro.AtualizaFIN_Numero;
  Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, False);
  if Trim(Lc_FileXML) <> '' then
  Begin
    // Faz a consulta no site antes de Autorizar
    MM_Acompanhamento.Lines.Add('FAZ A CONSULTA DA NOTA...');
    MM_Acompanhamento.Update;
    // Consulta e faz o Tratamento do Retorno convertendo o codigo da Receita em Codigo interno
    Lc_Cd_Retorno := Fc_ConsultaNFe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
    if (Lc_Cd_Retorno = 0) and (Lc_Cd_Retorno <> -1) then
    Begin
      // Autorizção propriamente dita
      Lc_Cd_Retorno := Autoriza(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota,Lc_Path, Lc_FileXML);

      if (Lc_Cd_Retorno = 2) then
      Begin
        ConfirmaImprimeBoleto;
        if ( Fc_Tb_Geral('L', 'GRL_G_EMAIL_AUTOMATICO', 'S') = 'S') OR
           ( Qr_Nota.FieldByName('CLI_EMAIL_NF_AUTO').AsString = 'S') then
        Begin
          if Fc_ValidaEnvioNfePDF(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger)
          then
          Begin
            Lc_FilePDF := Copy(Lc_FileXML, 1, (Length(Lc_FileXML) - 4))+ '.PDF';
            Pc_SalvaNfeArquivoPDF(Lc_Path);
          end;
          // Envia Email
          ConfirmaEnviaNFe(Lc_Path,
                            Lc_FileXML,
                            Lc_FilePDF,
                            False);
          ConfirmaEnviaBoleto;
        end;
      end;
    end;

    Fc_AtualizaRetornoNFe(Lc_Cd_Retorno, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
  end;
end;

function TTasGeraNfeAutorizacao.CarregaComponenteNFE(Pc_Path,
  Pc_FileXMl: String): Boolean;
begin
  Result := true;
  //file Adjustment to print e query invoices cancelad
  if (StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0) = 3) then
    SaveAsNfeProcExact(Pc_Path + '\' + Pc_FileXML,Pc_Path + '\' + Pc_FileXML);

  inherited;
end;

procedure TTasGeraNfeAutorizacao.ChBx_NF_PreExistenteClick(Sender: TObject);
begin
  //  Não fazer o inverso por que o cliente pode querer informar manualmente.
  //   Se ele desmarcar o caso da chave vai desmarcar o caso da nota manual....
  //   O que pode ser um problema caso ele marque sem querer e desmarque, mesmo querendo o informar
  //   manualmente somente o numero da nota
  if TCheckBox(Sender).Checked then
    CkBx_Nota_Manual.Checked := True;
end;

procedure TTasGeraNfeAutorizacao.CriarVariaveis;
begin
  inherited;
  RetornoNFE    := TControllerRetornoNFe.Create(self);
end;

function TTasGeraNfeAutorizacao.Fc_AtualizaRetornoNFe(Fc_Cd_Retorno, Fc_Cd_Nota,
  Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;
var
  Lc_Cd_Vinculo: Integer;
Begin
  with MM_Acompanhamento do
  Begin
    if (Fc_Cd_Retorno >= 0) then
    Begin
      Lines.Add('ATUALIZANDO A SITUÇÃO DO RETORNO...');
      MM_Acompanhamento.Update;
      // Verifica se retorno cancelada ou denegada
      if (Fc_Cd_Retorno = 3) or (Fc_Cd_Retorno = 5) then
      Begin
        Pc_FinalizaCancelamentoNFe;
        if (Fc_Cd_Retorno = 3) then
        Begin
          Lines.Add('TRATANDO VINCULOS DE NOTA CANCELADA...')
        End
        else
        Begin
          Lines.Add('PARA NOTA DENEGADA NÃO EXISTE XML...');
          Fc_Cd_Retorno := 0;
        End;
      end;

      if (Fc_Cd_Retorno > 0) or (Fc_Cd_Retorno < 5) then
      Begin
        // Salva o Arquivo em Banco de dados
        Lines.Add('SALVANDO O ARQUIVO NO BANCO DE DADOS...');
        MM_Acompanhamento.Update;
        Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(Fc_Cd_Nota);
        Pc_Insere_Arq_Banco(Fc_Path, FC_FileXML, 1, 'XML', Lc_Cd_Vinculo);
      End;

      with RetornoNFE do
      Begin
        Registro.NotaFiscal :=It_Cd_Nota;
        getByNotaFiscal;
        Registro.NotaFiscal      := Fc_Cd_Nota;
        Registro.Serie           := StrToIntDef(NotaFiscal.Registro.Serie,1);
        Registro.Situacao        := Fc_Cd_Retorno;
        Registro.NomeArquivo     := FC_FileXML;
        Registro.NumeroInicial   := StrZero(Fc_Nr_Nota, 6, 0);
        Registro.NumeroFinal     := StrZero(Fc_Nr_Nota, 6, 0);
        Registro.Estabelecimento := Gb_CodMha;
        salva;
      End;

      Result := Fc_Cd_Retorno;
      Lines.Add('RETORNO FINALIZADO COM SUCESSO...');
      MM_Acompanhamento.Update;
    End
    else
    Begin
      Lines.Add('NÃO FOI POSSIVEL TRATAR O RETORNO...');
      Lines.Add('ENTRE EM CONTATO COM O SUPORTE TÉCNICO...');
      MM_Acompanhamento.Update;
    End;
  end;
end;

function TTasGeraNfeAutorizacao.Fc_CancelaNFe(Fc_Path,
  FC_FileXML: String): Boolean;
Var
  Lc_NumeroLote: Int64;
  Lc_Aux:String;
begin
  with MM_Acompanhamento, Fr_Principal.Nfe do
  Begin
    Clear;
    Lines.Add('INICIANDO A OPERAÇÃO DE CANCELAMENTO...');
    MM_Acompanhamento.Update;
    Lines.Add('GERANDO NÚMERO DO LOTE...');
    MM_Acompanhamento.Update;
    Lc_Aux := FormatDateTime('yymmddhhmmss', NOW);
    Lc_Aux := copy(Lc_Aux,2,10);
    Lc_NumeroLote := StrToInt64(Lc_Aux);
    Lines.Add('CARREGANDO OS DADOS DO EVENTO...');
    MM_Acompanhamento.Update;
    EventoNFe.Evento.Clear;
    EventoNFe.idLote := Lc_NumeroLote;
    with EventoNFe.Evento.Add do
    begin
      // infEvento.chNFe      := Copy(Fc_FileXML,1,44);
      // infEvento.CNPJ       := NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
      infEvento.dhEvento := NOW;
      infEvento.tpEvento := teCancelamento;
      // infEvento.detEvento.nProt := NotasFiscais.Items[0].Nfe.procNFe.nProt;
      infEvento.detEvento.xJust := FMotivoCancelamento;
    end;
    Lines.Add('ENVIANDO INFORMÇÕES PARA O CANCELAMENTO...');
    MM_Acompanhamento.Update;

//      EnviarEvento(Lc_NumeroLote);
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.RetWS);
//      MM_Acompanhamento.Lines.Add('========================');
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.RetornoWS);
//      MM_Acompanhamento.Lines.Add('========================');
//      MM_Acompanhamento.Lines.Add(IntToStr(WebServices.EnvEvento.cStat));
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);

    try
      EnviarEvento(Lc_NumeroLote);
      if (WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat = 135) then
      Begin
        Result := True;
        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        (Now),
                        'Operções NF-e',
                        Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                        'Cancelamento NF-e',
                        concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));

        MensagemPadrao(MENSAGEM, 'S U C E S S O!' + EOLN + EOLN +
                       'Nota Cancelada com Sucesso!' + EOLN + EOLN +
                       'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                       'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                       ['OK'], [bEscape], mpInformacao);
      end
      else
      Begin
        Result := False;
        MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!' + EOLN + EOLN +
                       'Esta Nota não pode ser Cancelada!' + EOLN + EOLN +
                       'Código: ' + IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                       'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Lines.Add('PROCESSAMENTO FINALIZADO...');
      end;
    except
      Result := False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Houve um erro ao tentar cancelar a nota' + EOLN +
                     'Código: ' +IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat) + EOLN +
                     'Motivo: ' + WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo + EOLN, ['OK'], [bEscape], mpErro);
      Lines.Add('PROCESSAMENTO FINALIZADO...');
    end;
  end;
end;

function TTasGeraNfeAutorizacao.Fc_ConsultaNFe(Fc_Cd_Pedido, Fc_Cd_Nota,
  Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;
Var
  LcFileTemp : String;
  LcTExt : String;
  NomeArq : String;

begin
  with MM_Acompanhamento do
  Begin
    LimpaWebService;
    Clear;
    Lines.Add('INICIANDO A OPERAÇÃO DE CONSULTA...');
    MM_Acompanhamento.Update;
    Fr_Principal.Nfe.NotasFiscais.Clear;
    Fr_Principal.Nfe.NotasFiscais.LoadFromFile( concat(Fc_Path,'\',FC_FileXML ) );

    Fr_Principal.Nfe.Consultar;
    Result := Fr_Principal.Nfe.WebServices.Consulta.cStat;
    Lines.Add(concat('PROTOCOLO: ', Fr_Principal.Nfe.WebServices.Consulta.Protocolo));

    LcFileTemp := concat(Copy(FC_FileXML,1,44),'-NFeDFe.xml');

    //Esse trecho foi colocado para resolver o problema do protocolo de cancelamento
    if FileExists(concat(Fc_Path,'\',LcFileTemp)) then
    Begin
      DeleteFile(concat(Fc_Path,'\',FC_FileXML ));
      RenameFile(concat(Fc_Path,'\',LcFileTemp ),concat(Fc_Path,'\',FC_FileXML ));
    End;

    MM_Acompanhamento.Update;
    // Faz o Tratamento do Retorno convertendo o codigo da Receita em Codigo interno
    TrataRetorno(Result, MM_Acompanhamento,true);

  End;
end;

function TTasGeraNfeAutorizacao.Fc_DefineNumeroNotaNFe: Boolean;
Var
  Lc_Crt: Integer;
  Lc_Nr_Nota: String;
  Lc_Form: TFr_MultiEmpresa;
Begin
  Result := True;
  if (It_Nr_Nota = 0) then
  Begin
    if Fc_MultiEmpresa then
    Begin
      IF (Fc_Tb_Geral('L', 'GRL_G_MULTIEMP_ESCOLHENFE', 'N') = 'S') then
      Begin
        // pega os dados da empresa atual
        Pc_AtivaEstabelecimento;
        // poderia usar (It_Cd_Codmha := gb_codmha) mas manti o padrao de marcção para os dois campos abaixo
        It_Cd_Codmha := DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsInteger;
        Lc_Crt := StrToIntDef(DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsString,1);
        Lc_Form := TFr_MultiEmpresa.Create(self);
        Lc_Form.ShowModal;
        if (Lc_Form.It_Codmha > 0) then
        Begin
          if (Gb_CodMha <> Lc_Form.It_Codmha) then
          Begin
            // Muda a Variavel Global
            Gb_CodMha := Lc_Form.It_Codmha;
            Pc_DefineEmpresaAtiva(Gb_CodMha);
            // Compara se os estabelecimentos tem o mesmo regime tributario
            if (Lc_Crt <> DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsInteger)
            then
            Begin
              MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                'Os Regimes Tributários são diferentes!' + EOLN +
                'Não é possivel alterar o emissor da Nota!' + EOLN +
                'Operação será cancelada' + EOLN, ['OK'], [bEscape], mpAlerta);
              Gb_CodMha := It_Cd_Codmha;
              Pc_DefineEmpresaAtiva(Gb_CodMha);
              Result := False;
              Exit;
            end;
          End;
        End;
      end;
    end;
    // Gerar o numero da nota
    if not CkBx_Nota_Manual.Checked then
    begin
      It_Nr_Nota := Fc_GeraNumeroNota;
      MM_Acompanhamento.Lines.Add('Número da Nota Fiscal ' +
        StrZero(It_Nr_Nota, 6, 0));
    end
    else
    Begin
      if not(InputQuery('Autorizção da NF-e ', 'Número da Nota', Lc_Nr_Nota))
      then
      Begin
        Result := False;
        Exit;
      end;
      It_Nr_Nota := StrToIntdef(Lc_Nr_Nota, 0);
      if It_Nr_Nota = 0 then
      Begin
        Result := False;
        Exit;
      end;
      if Fc_VerificaNumeroNota('P', 0, Lc_Nr_Nota) then
      Begin
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
          'O número de nota Informada já existe !' + EOLN +
          'Verifique e tente novamente' + EOLN, ['OK'], [bEscape], mpErro);
        Result := False;
        Exit;
      end;
    end;
    with RetornoNFE do
    Begin
      Registro.NotaFiscal :=It_Cd_Nota;
      getByNotaFiscal;
      Registro.NotaFiscal      := It_Cd_Nota;
      Registro.Serie           := StrToIntDef(NotaFiscal.Registro.Serie,1);
      Registro.Situacao        := 0;
      Registro.NomeArquivo     := '';
      Registro.NumeroInicial   := StrZero(It_Nr_Nota, 6, 0);
      Registro.NumeroFinal     := StrZero(It_Nr_Nota, 6, 0);
      Registro.Estabelecimento := Gb_CodMha;
      salva;
    End;
  end;

end;

function TTasGeraNfeAutorizacao.Fc_UpdateRetornoNFe(chave: String): Boolean;
Var
  LCNfe : TControllerRetornoNFe;
begin
 LCNfe := TControllerRetornoNFe.Create(self);
  try
    LCNfe.Registro.NotaFiscal := It_Cd_Nota;
    LCNfe.Registro.NomeArquivo := concat(chave,'-NFe.xml');
    LCNfe.UpdateFileXMl;
  finally
    FreeAndNil(LCNfe);
  end;
end;

function TTasGeraNfeAutorizacao.Fc_ValidaAutorizacaoNFe(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
//  if not Fc_VerificaStatusServicoNfe(False) then
//  Begin
//    Result := False;
//    Exit;
//  end;


  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Autorizar a Nota Fiscal',
    'AUTORIZAR', GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Não foi possivel carregar a Nota.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if (Qr_itens.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Este pedido não tem Produtos.' + EOLN +
                    'Não é possível emitir nota de Mercadorias.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;


  Lc_Verificacao := StrToIntDef(Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsString,0);
  if (Lc_Verificacao = 3) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Esta nota já esta cancelada.' + EOLN +
      'Não é possível autorizar. Verifique.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 4) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Número de Nota Inutilizada.' + EOLN + 'Verifique antes de continuar.' +
      EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if not Fc_DefineNumeroNotaNFe then
  Begin
    Result := False;
    Exit;
  end;
end;

procedure TTasGeraNfeAutorizacao.FinalizarVariaveis;
begin
  inherited;
  FreeAndNil( RetornoNFE );
end;

procedure TTasGeraNfeAutorizacao.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_NF_e;
end;

procedure TTasGeraNfeAutorizacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2:
      if Sb_NF_Conferir.Enabled then
        Sb_NF_ConferirClick(self);
    VK_F3:
      if Sb_NF_Autorizar.Enabled then
        Sb_NF_AutorizarClick(self);
    VK_F4:
      if Sb_NF_Consultar.Enabled then
        Sb_NF_ConsultarClick(self);
    VK_F5:
      if Sb_NF_Cancelar.Enabled then
        Sb_NF_CancelarClick(self);
    VK_F6:
      if Sb_NF_Imprimir.Enabled then
        Sb_NF_ImprimirClick(self);
    VK_F7:
      if Sb_NF_Envia.Enabled then
        Sb_NF_EnviaClick(self);
    VK_Escape:
      if Sb_NF_sair.Enabled then
        Sb_NF_sairClick(self);
  end;
end;

procedure TTasGeraNfeAutorizacao.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    // NF-e
    CarregaImagemBotao(Sb_NF_Conferir,'CONFERIR');
    CarregaImagemBotao(Sb_NF_Autorizar,'AUTORIZAR');
    CarregaImagemBotao(Sb_NF_Consultar,'CONSULTAR');
    CarregaImagemBotao(Sb_NF_Cancelar,'CANCELAR NFE');
    CarregaImagemBotao(Sb_NF_Imprimir,'IMPRIMIR');
    CarregaImagemBotao(Sb_NF_Envia,'ENVIA EMAIL');
    CarregaImagemBotao(Sb_NF_sair,'SAIR');
  END;
end;


procedure TTasGeraNfeAutorizacao.ImprimeNFe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  bExisteFile : Boolean;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Fc_ChaveDanfe_XMl(It_Cd_Nota);
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Salva o Arquivo XML da NOta no diretorio
  bExisteFile :=  Fc_VerificaExistenciaArquivoNFEXML(1, It_Cd_Nota, Lc_Path, Lc_FileXML);
  If not bExisteFile  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    // Prepara a danfe para o envio
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    MM_Acompanhamento.Lines.Add('Imprimindo...');
    MM_Acompanhamento.Update;
    with Fr_Principal do
    Begin
      Nfe.DANFE.MostraPreview := True;
      Nfe.NotasFiscais.Imprimir;
    end;
  end;
end;

procedure TTasGeraNfeAutorizacao.ImprimeNFeTerceiro;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  bExisteFile : Boolean;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := 'compra' + IntToStr(It_Cd_Nota) + 'NFe.xml';
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Salva o Arquivo XML da NOta no diretorio
  bExisteFile := Fc_VerificaExistenciaArquivoNFEXML(3, It_Cd_Nota, Lc_Path,Lc_FileXML);

  if bExisteFile then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    MM_Acompanhamento.Lines.Add('Imprimindo...');
    MM_Acompanhamento.Update;
    with Fr_Principal do
    Begin
      if FileExists(Lc_Path + '\' + Lc_FileXML) then
        DeleteFile(Lc_Path + '\' + Lc_FileXML);
      Lc_FileXML := Copy(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID,(Length(Fr_Principal.Nfe.NotasFiscais.Items[0].Nfe.infNFe.ID) - 44) + 1,44) + '-NFe.xml';
      Nfe.NotasFiscais.Items[0].GravarXML(Lc_FileXML, Lc_Path);
      Nfe.DANFE.MostraPreview := True;
      Nfe.NotasFiscais.Imprimir;
    end;
  end
  else
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
  end;


end;

procedure TTasGeraNfeAutorizacao.IniciaVariaveis;
begin
  inherited;
  pg_Principal.ActivePage := tbs_NF_e;
  Qr_Nota.Close;
  Qr_RetornoNFe.Close;
  try
    MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);
  finally
    FNfConjugada := (Fc_Tb_Geral('L', 'OSR_G_NFSE_CONJ', 'N') = 'S');
    Pc_FormataModeloNFE;
  end;
end;


procedure TTasGeraNfeAutorizacao.Pc_CancelamentoNotasNFe;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja realmente Cancelar este Documento?.' + EOLN + EOLN +
                      'Confirmar a operação ?', [SIM, NAO], [bEscape, bNormal], mpConfirmacao,
                      clred) = mrBotao1) then
  Begin
    If (Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsInteger > 0) and
       (Qr_RetornoNFe.FieldByName('NFE_CODSIT').AsInteger <> 4) then //se for inutilizada pode cancelar
    Begin
      if Fc_ValidaCancelamentoNFe(It_Cd_Nota) then
      Begin
        CancelaCtrlIcmsST;
        Pc_CancelaNFe;
      End;
    end
    else
    Begin
      if validaCancelaNotaServico then
      Begin
        CancelaCtrlIcmsST;
        Pc_CancelaNFe_Pendente;
      End;
    end;
  end;

end;

procedure TTasGeraNfeAutorizacao.Pc_CancelaNFe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Vinculo: Integer;
  Lc_Cd_Retorno: Integer;
  Lc_Lst_Lote : TStringList;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Fc_ChaveDanfe_XMl(It_Cd_Nota);
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Salva o Arquivo XML da NOta no diretorio
  if not Fc_VerificaExistenciaArquivoNFEXML(1, It_Cd_Nota, Lc_Path, Lc_FileXML)
  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    // Cancelamento da Nota Propriamente dito
    if Fc_CancelaNFe(Lc_Path, Lc_FileXML) then
    Begin
      Lc_Cd_Retorno := Fc_ConsultaNFe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
      Fc_AtualizaRetornoNFe(Lc_Cd_Retorno, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
    End;
  end;
end;

procedure TTasGeraNfeAutorizacao.Pc_CancelaNFe_Pendente;
begin

end;

procedure TTasGeraNfeAutorizacao.Pc_ConsultaNFe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Retorno: Integer;
  LcRetorno : TControllerRetornoNFe;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Fc_ChaveDanfe_XMl(It_Cd_Nota);
  if Lc_FileXML = '' then
  Begin
    try
      Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
      LcRetorno := TControllerRetornoNFe.create(nil);
      LcRetorno.Registro.NotaFiscal    := Qr_RetornoNfe.FieldByName('NFE_CODNFL').AsInteger;
      LcRetorno.getByNotaFiscal;
      LcRetorno.Registro.NomeArquivo  := Lc_FileXML;
      LcRetorno.atualiza;
    finally
      FreeAndNil(LcRetorno);
    end;
  End;

  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Salva o Arquivo XML da NOta no diretorio
  if not Fc_VerificaExistenciaArquivoNFEXML(1, It_Cd_Nota, Lc_Path, Lc_FileXML)
  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    MM_Acompanhamento.Update;
    // Prepara a danfe para o envio
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    Lc_Cd_Retorno := Fc_ConsultaNFe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
    Fc_AtualizaRetornoNFe(Lc_Cd_Retorno, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
  end;
end;

function TTasGeraNfeAutorizacao.Pc_DocFiscalReferenciada(Pc_Ide: Tide): Boolean;
Var
  Lc_Form: TFr_Doc_Fiscal_Referenciado;
Begin
  Result := False;
  Lc_Form := TFr_Doc_Fiscal_Referenciado.Create(self);
  Lc_Form.DocReferenciado := True;
  with Lc_Form do
  Begin
    It_Confirma := Result;
    ShowModal;
    Result := It_Confirma;
    if Result then
    Begin
      Pc_Ide.NFref.Add;
      if Trim(E_Chave_Nfe.Text) <> '' then
      Begin
        Pc_Ide.NFref.Items[0].refNFe := E_Chave_Nfe.Text;
      end
      else
      Begin
        if ChBx_NFProd.Checked then
        Begin
          // Informção da NF Produtor
          // Código da UF do emitente
          Pc_Ide.NFref.Items[0].RefNFP.cUF := DBLCB_UF.KeyValue;
          // Ano e Mês de emissão da NF-e
          Pc_Ide.NFref.Items[0].RefNFP.AAMM := E_Ano_Mes.Text;
          // CNPJ do emitente
          Pc_Ide.NFref.Items[0].RefNFP.CNPJCPF := E_CNPJ.Text;
          // IE do emitente
          Pc_Ide.NFref.Items[0].RefNFP.IE := e_InscriEstadual.Text;
          // Modelo do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNFP.modelo := E_Modelo.Text;
          // Série do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNFP.serie := StrToIntdef(E_Serie.Text, 1);
          // Número do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNFP.nNF := StrToIntdef(E_Numero.Text, 1);
        end
        else
        Begin
          // Código da UF do emitente
          Pc_Ide.NFref.Items[0].RefNF.cUF := DBLCB_UF.KeyValue;
          // Ano e Mês de emisão da NF-e
          Pc_Ide.NFref.Items[0].RefNF.AAMM := E_Ano_Mes.Text;
          // CNPJ do emitente
          Pc_Ide.NFref.Items[0].RefNF.CNPJ := E_CNPJ.Text;
          // Modelo do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNF.modelo := StrToIntdef(E_Modelo.Text, 1);
          // Série do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNF.serie := StrToIntdef(E_Serie.Text, 1);
          // Número do Documento Fiscal
          Pc_Ide.NFref.Items[0].RefNF.nNF := StrToIntdef(E_Numero.Text, 1);
        end;
        if (E_Chave_CT.Text <> '') then
          Pc_Ide.NFref.Items[0].refCTe := E_Chave_CT.Text;
      End;
    End
    else
    Begin
      MM_Acompanhamento.Lines.Add('Nota Referenciada não informada...');
      MM_Acompanhamento.Lines.Add('Operação abortada pelo usuário');
    End;
  end;

    // Modelo do Documento Fiscal
    // Número de ordem sequencial do ECF
    // Número do Contador de Ordem de Operação - COO
end;

procedure TTasGeraNfeAutorizacao.Pc_EnviaNFe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_FilePDF: String;
  Lc_Escolha : Integer;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Fc_ChaveDanfe_XMl(It_Cd_Nota);
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Salva o Arquivo XML da NOta no diretorio
  If not Fc_VerificaExistenciaArquivoNFEXML(1, It_Cd_Nota, Lc_Path, Lc_FileXML)
  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    // Prepara a danfe para o envio
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    if Fc_ValidaEnvioNfePDF(Qr_Nota.FieldByName('EMP_CODIGO').AsInteger) then
    Begin
      Lc_FilePDF := Copy(Lc_FileXML, 1, (Length(Lc_FileXML) - 4)) + '.PDF';
      Pc_SalvaNfeArquivoPDF(Lc_Path);
    end;

    // Envia Email
    if ValidaEnvioEmailNFe then
      Fc_EnviaEmailNfe(Qr_Nota.FieldByName('EMP_CODIGO').AsString,
                  Qr_Nota.FieldByName('NFL_CODTRP').AsString,
                  Qr_Nota.FieldByName('NFL_NUMERO').AsString, Lc_Path, Lc_FileXML,
                    Lc_FilePDF,'');
  end;
end;

procedure TTasGeraNfeAutorizacao.Pc_FinalizaCancelamentoNFe;
Var
  Lc_Verificacao: Integer;
  Lc_nfl_tipo: String;
Begin
  Pc_SelecionaItensNota(It_Cd_Nota);
  IF (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'SC') or
    (Qr_Nota.FieldByName('NFL_TIPO').AsString = 'EC') THEN
  // diferente de  COMPLEMENTAR
    Lc_nfl_tipo := 'C' // complementar
  else
    Lc_nfl_tipo := 'N';
  if Lc_nfl_tipo = 'N' then
  Begin
    MM_Acompanhamento.Lines.Add('APAGANDO MOVIMENTO FINANCEIRO...');
    //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
    Pc_ApagaMovimFinanceiro(It_Cd_Nota);
    Financeiro.Clear;
    Financeiro.Registro.CodigoNota := It_Cd_Nota;
    Financeiro.deleteByNota;
    MM_Acompanhamento.Lines.Add('APAGANDO COMISSÃO...');
    Pc_ApagaComissaoFaturamento( It_Cd_Pedido);

    MM_Acompanhamento.Lines.Add('ATUALIZANDO SITUÇÃO DA NOTA...');
    NotaFiscal.Registro.Codigo := iT_CD_NOTA;
    NotaFiscal.Registro.Situacao := 'C';
    NotaFiscal.AlteraStatus;

    Pc_CancelaVendaComercioEletronico(It_Cd_Pedido);
    Pc_Apaga_conserto(It_Cd_Pedido);
    Pc_ApagaVendedor( It_Cd_Pedido);
    Pc_Retornodevolucao(Qr_Itens); // Devolução modelo Genio

    NotaFiscal.AtualizaSeries(Qr_Nota.FieldByName('NFL_TIPO').AsString,Qr_Itens);
    MM_Acompanhamento.Lines.Add('ATUALIZANDO OS ITENS DA NOTA...');
    Pc_AtualizarItensNota(Qr_Nota.FieldByName('NFL_TIPO').AsString,
                          'AUTORIZADA',
                          It_Cd_Nota,
                          It_Cd_Pedido,
                          Qr_Itens);
    NotaFiscal.Pedido.Itens.BaseTroca.Registro.Ordem := It_Cd_Pedido;
    NotaFiscal.Pedido.Itens.BaseTroca.deleteByOrdem;

    MM_Acompanhamento.Lines.Add('APAGANDO ESTOQUE...');
    Pc_AtualizacaoEstoqueNota('AUTORIZADA', Qr_Nota.FieldByName('PED_TIPO').AsInteger, Qr_Nota.FieldByName('PED_CODIGO').AsInteger);
    // Pc_AtualizarItensDevolucao(Qr_Nota.FieldByName('NFL_TIPO').AsString,Qr_Itens);//Devolução modelo Winkert - comentei pois na nfe não tem devolução assim


    MM_Acompanhamento.Lines.Add('ATUALIZANDO SITUÇÃO DO PEDIDO...');
    NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
    NotaFiscal.Pedido.Registro.Faturado := 'C';
    NotaFiscal.Pedido.alteraStatus;
  END
  ELSE
  BEGIN
    MM_Acompanhamento.Lines.Add('ATUALIZANDO SITUÇÃO DO PEDIDO...');
    Pc_ApagaRetornoNFE(It_Cd_Nota);
    //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
    //MM_Acompanhamento.Lines.Add('APAGANDO MOVIMENTO FINANCEIRO...');
    Pc_ApagaMovimFinanceiro( It_Cd_Nota);
    MM_Acompanhamento.Lines.Add('APAGANDO FINANCEIRO...');
    Financeiro.Clear;
    Financeiro.Registro.CodigoNota := It_Cd_Nota;
    Financeiro.deleteByNota;
    MM_Acompanhamento.Lines.Add('ATUALIZANDO SITUÇÃO DA NOTA...');
    NotaFiscal.Registro.Codigo := It_Cd_Nota;
    NotaFiscal.Registro.Situacao := 'C';
    NotaFiscal.alteraStatus;
  end;
  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Operções NF-e',
                  Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                  'Cancelamento NF-e',
                  concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));

  MensagemPadrao(MENSAGEM, 'S U C E S S O !.' + EOLN + EOLN +
                 'Nota Fiscal Cancelada com Sucesso.' + EOLN +
                 '  Clique em OK para continuar.' + EOLN,
                 ['OK'], [bEscape], mpInformacao);
end;

procedure TTasGeraNfeAutorizacao.Pc_ImprimeConferencia;
Var
  Lc_Path: String;
  Lc_FileXML: String;
Begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
  // Define numero da Nota como 000001 apenas para conferencia
  It_Nr_Nota := 1;
  Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, False);
  It_Nr_Nota := 0;
  if Trim(Lc_FileXML) <> '' then
  Begin
    if Trim(Lc_FileXML) <> '' then
    Begin
      MM_Acompanhamento.Lines.Add('IMPRIMINDO O NOTA PARA CONFEFÊNCIA...');
      MM_Acompanhamento.Update;
      with Fr_Principal do
      Begin
        Nfe.DANFE.MostraPreview := True;
        Nfe.NotasFiscais.Imprimir;
      end;
    end;
  end;


end;

procedure TTasGeraNfeAutorizacao.PreencheDanfeIde(dfide: TIde;
  Oper_Consulta: Boolean);
Var
  Lc_Time_Str: String;
  Lc_Ok : Boolean;
Begin
  inherited;
  with dfide,Qr_Nota do
  Begin
    modelo := 55;


    if (ChBx_NF_PreExistente.Checked) then
    Begin
      ChaveDuplicada := '';
      Arquivo.DeleteByNotaViaVinculo(1,FieldByName('NFL_CODIGO').AsInteger);
      cNF := InformarChaveAcesso;
    end;

    if Trim(ChaveDuplicada) <> '' then
    Begin
      Arquivo.DeleteByNotaViaVinculo(4,FieldByName('NFL_CODIGO').AsInteger);
      cNF := StrToIntDef(Copy(ChaveDuplicada,36,8),0);
    End;

    dEmi := FieldByName('NFL_DT_EMISSAO').AsDateTime + FieldByName('NFL_HR_SAIDA').AsDateTime;
    if Trim( FieldByName('NFL_DT_SAIDA').AsString) <> '' then
    Begin
      dSaiEnt := FieldByName('NFL_DT_SAIDA').AsDateTime + FieldByName('NFL_HR_SAIDA').AsDateTime;
      hSaiEnt := FieldByName('NFL_HR_SAIDA').AsDateTime;
    end;

    tpImp  := StrToTpImp(FNFEletronica.Registro.Orientacao);
    if (tpEmis <> teNormal) then
    BEgin
      dhCont := NOW;
      xJust := 'Serviço paralisado - Longo Prazo';
    end;

    case StrToIntDef( FieldByName('PED_INDPRES').AsString,1) of
      1:indPres := pcPresencial;
      2:indPres := pcInternet;
      3:indPres := pcTeleatendimento;
      4:indPres := pcEntregaDomicilio;
      5:indPres := pcPresencialForaEstabelecimento;
      6:indPres := pcOutros;
    else
      indPres := pcPresencial;
    end;

    // 1=NF-e normal; 2=NF-e complementar; 3=NF-e de ajuste; 4=Devolução/Retorno.
    if not Oper_Consulta then
    Begin
      if (ChBx_NF_Referenciada.Checked) then
      Begin
        if not Pc_DocFiscalReferenciada(dfide) then
          abort;
      End
      else
      Begin
        case StrToIntdef( FieldByName('NFL_FINALIDADE').AsString, 1) of
          1:Begin
              finNFe := fnNormal;
              if ( FieldByName('NAT_CFOP').AsString = '5929' ) or
                 ( FieldByName('NAT_CFOP').AsString = '6929' ) then
              Begin
                if not Pc_DocFiscalReferenciada(dfide) then
                  abort;
              End;
            End;
          2:
            Begin
              finNFe := fnComplementar;
              dfide.NFref.Add;
              notaFiscal.REgistro.NotaVinculada := Qr_Nota.FieldByName('NFL_NFL_VINCULO').AsString;
              notaFiscal.REgistro.CodigoEstabelecimento := Gb_CodMha;
              dfide.NFref.Items[0].refNFe := notaFiscal.DocFiscalRefComplementar;
            end;
          3:Begin
              finNFe := fnAjuste;
              if not Pc_DocFiscalReferenciada(dfide) then
                abort;

            End;
          4:
            Begin
              finNFe := fnDevolucao;
              if not Pc_DocFiscalReferenciada(dfide) then
                abort;
            end;
          5:
            Begin
              finNFe := fnCredito;
              {RFT - 01=Transferncia de créditos para Cooperativas;
                      02=Anulção de Crédito por Saídas Imunes/Isentas;
                      03=Débitos de notas fiscais não processadas na apurção;
                      04=Multa e juros;
                      05=Transferncia de crédito de sucesso;
                      06 = Pagamento antecipado
                      07 = Perda em estoque}
              //tpNFCredito := ver tabela a ser criada
            end;
          6:
            Begin
              finNFe := fnDebito;
              {RFT - tpNFCredito
                      01 = Multa e juros
                      02 = Aproprição de crédito presumido de IBS sobre o saldo devedor na ZFM (art. 450,  1, LC 214/25)}
              //tpNFDebito := ver tabela a ser criada
            end;
        end;
      End;
    End;

  End;
end;

procedure TTasGeraNfeAutorizacao.PreencheDanfeInfAdic;
Var
  Lc_Obs: TMemo;
  Lc_I : Integer;
  Lc_Bc_Difal:Real;
  Lc_Aq_Difal:Real;
Begin
  //Não aplicar o disposeof quando o create for SElf
  Lc_Obs :=  TMemo.Create(Self);
  Lc_Obs.Visible := False;
  Lc_Obs.Parent := self;
  Lc_Obs.Width := 600;
  with Fr_Principal.Nfe.NotasFiscais[0].Nfe do
  Begin
    // Informações de Interesse do Financeiro
    Qr_Observacao.Active := False;
    Qr_Observacao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Qr_Observacao.ParamByName('OBN_TIPO').AsString := 'A';
    Qr_Observacao.Active := True;
    Qr_Observacao.FetchAll;
    Qr_Observacao.First;
    InfAdic.infCpl := '';
    Lc_Obs.Clear;
    Lc_Obs.text := Qr_Observacao.FieldByName('OBN_DETALHE').AsString;

    if (ChBx_Otimiza_obs.Checked ) then
    Begin
      for Lc_I := 0 to Lc_Obs.Lines.Count - 1 do
      Begin
        if (Lc_I = 0) then
          InfAdic.infCpl := Lc_Obs.Lines[Lc_I]
        else
          InfAdic.infCpl := concat(InfAdic.infCpl,' | ',Lc_Obs.Lines[Lc_I]);
      End;
      //Retira os ; do texto
      InfAdic.infCpl := Fc_RemoveCaracterInformado(InfAdic.infCpl, [';']);
    end
    else
    Begin
      InfAdic.infCpl := Lc_Obs.text;
    End;

    // Informações de Interesse do Contribuinte

    Qr_Observacao.Active := False;
    Qr_Observacao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Qr_Observacao.ParamByName('OBN_TIPO').AsString := 'M';
    Qr_Observacao.Active := True;
    Qr_Observacao.FetchAll;
    Qr_Observacao.First;
    Lc_Obs.Clear;
    Lc_Obs.text := Qr_Observacao.FieldByName('OBN_DETALHE').AsString;

    if (ChBx_Otimiza_obs.Checked ) then
    Begin
      for Lc_I := 0 to Lc_Obs.Lines.Count - 1 do
      Begin
        if InfAdic.infCpl = '' then
          InfAdic.infCpl := Lc_Obs.Lines[Lc_I]
        else
          InfAdic.infCpl := concat(InfAdic.infCpl, ' | ', Lc_Obs.Lines[Lc_I])
      End;
      //Retira os ; do texto
      InfAdic.infCpl := Fc_RemoveCaracterInformado(InfAdic.infCpl, [';']);
    end
    else
    Begin
      InfAdic.infCpl := Lc_Obs.text;
    End;

    // Informações de Interesse do Fisco

    Qr_Observacao.Active := False;
    Qr_Observacao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Qr_Observacao.ParamByName('OBN_TIPO').AsString := 'F';
    Qr_Observacao.Active := True;
    Qr_Observacao.FetchAll;
    Qr_Observacao.First;
    InfAdic.infAdFisco := '';
    //Caso seja uma nota de ajuste será encarada como um cancelamento feito apos 24 horas - 999 - Estorno de NF-e não cancelada no prazo legal;
    if Ide.finNFe = fnAjuste then
    BEgin
      InfAdic.infAdFisco := 'Atraso na rotina, impediu o cancelamento no tempo previsto.';
    End;


    while not Qr_Observacao.Eof do
    Begin
      InfAdic.infAdFisco := concat(
                                InfAdic.infAdFisco ,
                                Qr_Observacao.FieldByName('OBN_DETALHE').AsString
                            );
      Qr_Observacao.Next;
    end;
    //Totais do fundo de combate a pobreza
    if Total.ICMSTot.vFCP > 0 then
    BEgin
      InfAdic.infAdFisco := concat(
                                InfAdic.infAdFisco ,
                                'Total de FCP : ', FloatToStrF(Total.ICMSTot.vFCP,ffFixed,10,2)
                            );
    End;

    //Retira os ; do texto
    if (not ChBx_Otimiza_obs.Checked ) then
      InfAdic.infAdFisco := Fc_RemoveCaracterInformado(InfAdic.infAdFisco, [';']);
  End;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_AutorizarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Pc_SelecionaItensNota(It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    if Fc_ValidaAutorizacaoNFe(It_Cd_Nota) then
      AutorizaNFe;
  finally
    Pc_RetornaEstabelecimentoInicial;
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    self.Update;
    Self.BringToFront;
  end;

end;

procedure TTasGeraNfeAutorizacao.Sb_NF_CancelarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    if ValidaCancelamentoNotas then
      Pc_CancelamentoNotasNFe;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    self.BringToFront;
  end;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_ConferirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Pc_SelecionaItensNota(It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    if Fc_ValidaConferencia(It_Cd_Nota) then
      Pc_ImprimeConferencia;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_ConsultarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    Pc_PosicionaEstabelecimentoEmissor;
    if Fc_ValidaConsultaNFe(It_Cd_Nota) then
      Pc_ConsultaNFe;
  finally
    Pc_RetornaEstabelecimentoInicial;
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_EnviaClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    Pc_EnviaNFe;
    ConfirmaEnviaBoleto;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Fc_AtivaRetornoNFe(It_Cd_Nota);
    if not It_Nf_Terceiro then
    Begin
      if Fc_ValidaImpressaoNFe(It_Cd_Nota) then
      Begin
        ImprimeNFe;
        ConfirmaImprimeBoleto;
      End;
      ImprimeDuplicata;
    end
    else
    Begin
      ImprimeNFeTerceiro;
    end;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfeAutorizacao.Sb_NF_sairClick(Sender: TObject);
begin
  Close;
end;

procedure TTasGeraNfeAutorizacao.TrataRetorno(Var Pc_Cd_Retorno: Integer;pc_Memo: TMemo; OnLine: Boolean);
Var
  Lc_SqlTxt: String;
  Lc_Qry: TSTQuery;
  Lc_Mensagem: String;
  LcPosicao : Integer;
  LcDhRecbto : TDateTime;
  LcTIpoNF : String;
  LcBase : TControllerBase;
Begin
  LcDhRecbto := 0;
  if (Fr_Principal.Nfe.WebServices.Retorno.cStat > 0) then
  Begin
    Pc_Cd_Retorno := Fr_Principal.Nfe.WebServices.Retorno.cStat;
    Lc_Mensagem := UpperCase(Fr_Principal.Nfe.WebServices.Retorno.XMotivo);
  End
  else
  Begin
    if (Fr_Principal.Nfe.WebServices.Enviar.cStat > 0) then
    Begin
      LcDhRecbto := Fr_Principal.Nfe.WebServices.Enviar.dhRecbto;
      Pc_Cd_Retorno := Fr_Principal.Nfe.WebServices.Enviar.cStat;
      Lc_Mensagem := UpperCase(Fr_Principal.Nfe.WebServices.Enviar.XMotivo);
    End
    else
    Begin
      LcDhRecbto := Fr_Principal.Nfe.WebServices.Consulta.DhRecbto;
      Pc_Cd_Retorno := Fr_Principal.Nfe.WebServices.Consulta.cStat;
      Lc_Mensagem := UpperCase(Fr_Principal.Nfe.WebServices.Consulta.XMotivo);
    End;
  End;
  if ( (Pc_Cd_Retorno = 100 ) or (Pc_Cd_Retorno = 150 ) or (Pc_Cd_Retorno = 110 ) ) and OnLine then
    Pc_Atualiza_DataHora_NF(It_Cd_Nota,LcDhRecbto);
  ChaveDuplicada := '';
  if  (Pos(UpperCase('Duplicidade de NF-e'), UpperCase(Lc_Mensagem)) > 0) then
  begin
    //123456789X123456789X123456789X123456789X123456789X12345678
    //Duplicidade de NF-e, com diferenca na Chave de Acesso. [41191017906757000141650020000215831000436399] [nRec:919001164446027]'
    LcPosicao := Pos(concat('[',DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsString), Lc_Mensagem);
    ChaveDuplicada := Copy(Lc_Mensagem,LcPosicao +1,44);
    LcTIpoNF := Copy(ChaveDuplicada,21,2);
    Fc_UpdateRetornoNFe(ChaveDuplicada);
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Foi atualizado a nova chave de Acesso.' + EOLN +
                   'Efetue uma nova Consulta.' + EOLN, ['OK'], [bEscape], mpAlerta);

    Pc_Cd_Retorno := -1;
    exit;
  end;

  if  (Pos(UpperCase('muito antiga'), UpperCase(Lc_Mensagem)) > 0) then
  begin
    MM_Acompanhamento.Lines.Add('----------------------------------');
    MM_Acompanhamento.Lines.Add('Data do XML muito antiga, não é permitida a consulta pelo Webservice');
    MM_Acompanhamento.Lines.Add('Acesse o portal nacional da nota fiscal ');
    MM_Acompanhamento.Lines.Add('----------------------------------');
    Pc_Cd_Retorno := -1;
    exit;
  end;

  // faz a cnsulta na tabela de retono

  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry, pc_Memo do
    Begin
      Lc_SqlTxt := 'SELECT MSG_RETORNO, MSG_CODSIT, MSG_DESCRICAO ' +
                   'FROM TB_MSG_RETORNO_NFE        ' +
                   'WHERE MSG_RETORNO=:MSG_RETORNO ';
      sql.Add(Lc_SqlTxt);
      ParamByName('MSG_RETORNO').AsInteger := Pc_Cd_Retorno;
      Active := True;
      FetchAll;
      First;
      if recordcount > 0 then
      Begin
        Pc_Cd_Retorno := StrToIntDef(FieldByName('MSG_CODSIT').AsString,0);
      End
      else
      Begin
        if (Fr_Principal.Nfe.WebServices.Consulta.cStat = 217) OR
          (Fr_Principal.Nfe.WebServices.Retorno.cStat = 217) then
        Begin
          Pc_Cd_Retorno := 0;
        End
        else
        Begin
          if (MensagemPadrao(MENSAGEM,
                              IntToStr(Pc_Cd_Retorno) + ' - ' + Upper(Lc_Mensagem) + EOLN + EOLN +
                              'Caso já tenha visualizado esta mensagem anteriormente e ' + EOLN +
                              'tenha resolvido o problema clique em continuar' + EOLN,
                              ['Vou Resolver', 'Continuar'], [bNormal, bEscape], mpConfirmacao,
                              clBtnFace) = mrBotao2) then
          begin
            Pc_Cd_Retorno := 0;
          end
          else
          Begin
            Lines.Add('SISTEMA NÃO ENCONTROU RETORNO ADEQUADO PARA PROSSEGUIR...');
            Lines.Add('OBSERVE A MENSAGEM CORRIJA A NOTA E TENTE NOVAMENTE...');
            Pc_Cd_Retorno := -1;
          End;
        End;
      End;
      // 0 NÃO ENVIADA / 1 ENVIADA / 2 AUTORIZADA / 3 CANCELADA / 4 INUTILIZADA / 5 DENEGADA
      Lines.Add('TRATANDO OS CODIGOS DE RETORNO...');
      Lines.Add('================================================');
      Lines.Add('CODIGO: ' + IntToStr(Pc_Cd_Retorno));
      Lines.Add('MENSAGEM : ' + UpperCase(Lc_Mensagem));
      Lines.Add('================================================');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;


function TTasGeraNfeAutorizacao.ValidaCancelamentoNotasNFe: Boolean;
begin
  Result := True;
  MM_Acompanhamento.Lines.Clear;
  MM_Acompanhamento.Lines.Add('Validando o cancelamento NFe...');
  if not ValidaCancelamentoNotas then
  Begin
    Result := False;
    Exit;
  End;
end;

end.

unit tas_gera_nfce_autorizacao;

interface

uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IniFiles, DB, STQuery, Grids, DBGrids, Menus, Mask, Printers, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnLeitor, ACBrNFeNotasFiscais, ACBrNFeWebServices, ACBrNFeDANFeRLClass, QuickRpt, System.StrUtils, FavoritoButtons, Gauges, XMLDoc, XMLIntf, System.Math, filectrl, Registry, WinINEt, ExtActns, ACBrNFeDANFeESCPOS, TypInfo, IdTCPConnection, IdTCPClient, IdHTTP, XSBuiltIns, blcksock, DBCtrls, Spin, QEdit_Setes, pcnConversaoNfe, ACBrPosPrinter, ACBrBase, ACBrDFe, ShellAPI, zlib, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, Vcl.AppEvnts, STDataSet, un_geranfe3X, ACBrNFe.Classes, ControllerInventario, ControllerBase, ControllerRetornoNFCe, ACBrDFe.Conversao;

type
  TTasGeraNfceAutorizacao = class(TFr_GeraNfe3x)
    tbs_NFC_e: TTabSheet;
    Pnl_NFC_e: TPanel;
    Label3: TLabel;
    MM_Acompanhamento: TMemo;
    Memo2: TMemo;
    Panel3: TPanel;
    Sb_NFC_Autorizar: TSpeedButton;
    Sb_NFC_Sair: TSpeedButton;
    Sb_NFC_Consultar: TSpeedButton;
    Sb_NFC_Imprimir: TSpeedButton;
    Sb_NFC_Cancelar: TSpeedButton;
    Sb_NFC_Envia: TSpeedButton;
    Sb_NFC_Conferir: TSpeedButton;
    Pnl_NFCE_Opcao: TPanel;
    Label21: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    ChBx_InformarCPFnaNota: TCheckBox;
    pnl_emission_option: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    Cb_TipoEmissao: TComboBox;
    Cb_IndPresenca: TComboBox;
    Cb_ForDanfe: TComboBox;
    edt_Justificativa_Offline: TEdit;
    procedure Sb_NFC_ConferirClick(Sender: TObject);
    procedure Sb_NFC_AutorizarClick(Sender: TObject);
    procedure Sb_NFC_ConsultarClick(Sender: TObject);
    procedure Sb_NFC_CancelarClick(Sender: TObject);
    procedure Sb_NFC_ImprimirClick(Sender: TObject);
    procedure Sb_NFC_EnviaClick(Sender: TObject);
    procedure Sb_NFC_SairClick(Sender: TObject);
    procedure Cb_TipoEmissaoChange(Sender: TObject);
    procedure Cb_ForDanfeChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure PreencheDanfeIde(dfide:TIde;Oper_Consulta:Boolean);Override;
    procedure PreencheDanfeInfAdic;Override;
    procedure InformarCPFnaNotaClick(Sender: TObject);

  protected
    FImp_Auto_NFCe: Boolean;
    RetornoNFCE    : TControllerRetornoNFCe;
    procedure TrataRetorno(var Pc_Cd_Retorno: Integer; pc_Memo: TMemo; OnLine:Boolean);Override;
    function ValidaFinanceiro:Boolean;
    function Fc_ValidaAutorizacaoNFCe(Fc_Cd_Nota: Integer): Boolean;
    function VerificaItemsVinculadoNF:Boolean;
    function Fc_CancelaNFCe(Fc_Path, FC_FileXML: String): Boolean;
    procedure PrePreenchimento;
    function Fc_UpdateRetornoNFCe(chave:String): Boolean;
    procedure Pc_AutorizaNFCe;
    procedure Pc_AutorizacaoOn_Line;
    procedure Pc_AutorizacaoOff_Line;
   procedure Pc_AutorizaNFCe_Off_Line;
   procedure Pc_GeraNFCe(Pc_cd_Nota: Integer);
    Function Fc_ConsultaNFCe(Fc_Cd_Pedido, Fc_Cd_Nota, Fc_Nr_Nota: Integer;
      Fc_Path, FC_FileXML: String): Integer;
    procedure Pc_ConsultaNFCe;
    Function Fc_AtualizaRetornoNFCe(Fc_Cd_Retorno: Integer;
      Fc_Path, FC_FileXML: String; Fc_Memo: TMemo): Integer;
    procedure Pc_CancelamentoNotasNFCe;
    function Fc_ValidaConsultaNFCe(Fc_Cd_Nota: Integer): Boolean;
    Function Fc_ValidaCancelamentoNFCe(Fc_Cd_Nota: Integer): Boolean;
    Function Fc_ValidaCancelamentoNFCe_Pendente(Fc_Cd_Nota: Integer): Boolean;
    procedure Pc_CancelaNFCe;
    procedure Pc_FinalizaCancelamentoNFCe;
    function Fc_ValidaImpressaoNFCE(Fc_Cd_Nota: Integer): Boolean;
    procedure Pc_ImprimeNFCe;
    function  ValidaEmiteCupomNotaPromissoria:Boolean;
    procedure Pc_EmiteCupomNaoFiscal;
    procedure Pc_EmiteCupomNotaPromissoria;
    function ValidaEnvioEmailNFCe(Fc_Cd_Nota: Integer): Boolean;
    procedure Pc_EnviaEmailNFCE;
    function AtivaRetorno(Pc_cd_Nota: Integer): Boolean;
    procedure Pc_CancelaNFC_Pendente;

    function ValidaCancelamentoNotasNFCE: Boolean;

    procedure IniciaVariaveis;Override;
    procedure CriarVariaveis;Override;
    procedure FinalizarVariaveis;Override;
    procedure FormataTela;Override;
    procedure ImagemBotao;Override;
    function CarregaComponenteNFE(Pc_Path,Pc_FileXMl:String):Boolean; Override;
  public
    { Public declarations }
  end;

var
  TasGeraNfceAutorizacao: TTasGeraNfceAutorizacao;

implementation

{$R *.dfm}

{ TTasGeraNfceAutorizacao }

uses UN_Principal, Un_DM, env, un_msg,RN_NotaFiscalEletronica3X, un_sistema,
    Un_Regra_Negocio,Un_Funcoes, Un_Consumidor, RN_PERMISSAO,RN_Estoque,
    Un_Imp_Mod_Impressao, TrataXMLNFe, Un_Fc_Sored_Procedures;

function TTasGeraNfceAutorizacao.CarregaComponenteNFE(Pc_Path,
  Pc_FileXMl: String): Boolean;
begin
  REsult := True;
  //file Adjustment to print e query invoices cancelad
  if (StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsString,0) = 3) then
    SaveAsNfeProcExact(Pc_Path + '\' + Pc_FileXML,Pc_Path + '\' + Pc_FileXML);

  inherited;
end;

procedure TTasGeraNfceAutorizacao.Cb_ForDanfeChange(Sender: TObject);
begin
  if ChBx_InformarCPFnaNota.Enabled then
    ChBx_InformarCPFnaNota.Checked := (Cb_ForDanfe.ItemIndex = 1);
end;

procedure TTasGeraNfceAutorizacao.Cb_TipoEmissaoChange(Sender: TObject);
begin
  if Cb_TipoEmissao.ItemIndex = 1 then
    edt_Justificativa_Offline.Text := 'Sem conectividade receita'
  else
    edt_Justificativa_Offline.Clear;
end;

procedure TTasGeraNfceAutorizacao.CriarVariaveis;
begin
  inherited;
  RetornoNFCE   := TControllerRetornoNFCe.Create(self);

end;

function TTasGeraNfceAutorizacao.AtivaRetorno(
  Pc_cd_Nota: Integer): Boolean;
begin
  with Qr_RetornoNFCe do
  Begin
    Close;
    ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
    Active := True;
    FetchAll;
    It_Nr_Nota := FieldByName('NFC_CODIGO').AsInteger;
    Result := (recordcount > 0);
  end;

end;

function TTasGeraNfceAutorizacao.Fc_AtualizaRetornoNFCe(Fc_Cd_Retorno: Integer;
  Fc_Path, FC_FileXML: String; Fc_Memo: TMemo): Integer;
var
  Lc_Cd_Vinculo: Integer;
Begin
  // Salva Retorno
  if (Fc_Cd_Retorno > 0) then
  Begin
    // Verifica se retorno cancelada ou denegada(nao há notas para gravar
    if (Fc_Cd_Retorno = 3) or (Fc_Cd_Retorno = 5) then
    Begin
      Pc_FinalizaCancelamentoNFCe;

      if (Fc_Cd_Retorno = 3) then
      Begin
        Fc_Memo.Lines.Add('TRATANDO VINCULOS DE NOTA CANCELADA...');
        Fc_Memo.Update;
      End
      else
      Begin
        Fc_Memo.Lines.Add('PARA NOTA DENEGADA NÃO EXISTE XML...');
        Fc_Memo.Update;
        Fc_Cd_Retorno := 0; //Nao controlar mais por que nao ha nota na receita
      End;
    end;
    //Salva arquivo
    if (Fc_Cd_Retorno > 0) AND (Fc_Cd_Retorno < 5) then
    Begin
      Fc_Memo.Lines.Add('SALVANDO O ARQUIVO NO BANCO DE DADOS...');
      Fc_Memo.Update;
      Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNFCeArquivo(It_Cd_Nota);
      Pc_Insere_Arq_Banco(Fc_Path, FC_FileXML, 4, 'XML', Lc_Cd_Vinculo);
      //Precisa atualizar antes de ir para o cancelamento
    End;
    RetornoNFCE.clear;
    RetornoNFCE.Registro.NotaFiscal   := It_Cd_Nota;
    RetornoNFCE.Registro.Situacao     := Fc_Cd_Retorno;
    RetornoNFCE.Registro.NomeArquivo  := FC_FileXML;
    RetornoNFCE.SalvaRetorno;
    Fc_Memo.Lines.Add('ATUALIZANDO A SITUÇÃO DO RETORNO...');
    Fc_Memo.Update;
    Result := Fc_Cd_Retorno;
    Fc_Memo.Lines.Add('RETORNO FINALIZADO COM SUCESSO...');
  End
  else
  Begin
    Fc_Memo.Lines.Add('SEM RETORNO DEFINIDO - VERIFIQUE ANTES DE CONTINUAR..');
  End;
  Fc_Memo.Update;
end;

function TTasGeraNfceAutorizacao.Fc_CancelaNFCe(Fc_Path,
  FC_FileXML: String): Boolean;
Var
  Lc_NumeroLote: Integer;
  Lc_Aux:String;
begin
  with MM_Acompanhamento, Fr_Principal.Nfe do
  Begin
    Clear;
    Lines.Add('INICIANDO A OPERÇÃO DE CANCELAMENTO...');
    MM_Acompanhamento.update;
    Lines.Add('GERANDO NÚMERO DO LOTE...');
    MM_Acompanhamento.update;
    Lc_Aux := FormatDateTime('yymmddhhmmss', NOW);
    Lc_Aux := copy(Lc_Aux,2,10);
    Lc_NumeroLote := StrToInt64(Lc_Aux);
    if Lc_NumeroLote < 0 then
      Lc_NumeroLote := Lc_NumeroLote * -1;


    Lines.Add('CARREGANDO OS DADOS DO EVENTO...');
    MM_Acompanhamento.update;
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
    MM_Acompanhamento.update;

//      EnviarEvento(Lc_NumeroLote);
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.RetWS);
//      MM_Acompanhamento.Lines.Add('========================');
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.RetornoWS);
//      MM_Acompanhamento.Lines.Add('========================');
//      MM_Acompanhamento.Lines.Add(IntToStr(WebServices.EnvEvento.cStat));
//      MM_Acompanhamento.Lines.Add(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
    try
      EnviarEvento(Lc_NumeroLote);
      if (WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
        .RetInfEvento.cStat = 135) then
      Begin
        Result := True;

        Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        (Now),
                        'Operções NFC-e',
                        Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                        'Cancelamento NFC-e',
                        concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));

        MensagemPadrao(MENSAGEM, 'S U C E S S O!' + EOLN + EOLN +
          'Nota Cancelada com Sucesso!' + EOLN + EOLN + 'Código: ' +
          IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
          .RetInfEvento.cStat) + EOLN + 'Motivo: ' +
          WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
          .RetInfEvento.XMotivo + EOLN, ['OK'], [bEscape], mpInformacao);
      end
      else
      Begin
        Result := False;
        MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!' + EOLN + EOLN +
          'Esta Nota não pode ser Cancelada!' + EOLN + EOLN + 'Código: ' +
          IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
          .RetInfEvento.cStat) + EOLN + 'Motivo: ' +
          WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
          .RetInfEvento.XMotivo + EOLN, ['OK'], [bEscape], mpAlerta);
        Lines.Add('PROCESSAMENTO FINALIZADO...');
      end;
    except
      Result := False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
        'Houve um erro ao tentar cancelar a nota' + EOLN + 'Código: ' +
        IntToStr(WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
        .RetInfEvento.cStat) + EOLN + 'Motivo: ' +
        WebServices.EnvEvento.EventoRetorno.retEvento.Items[0]
        .RetInfEvento.XMotivo + EOLN, ['OK'], [bEscape], mpErro);
      Lines.Add('PROCESSAMENTO FINALIZADO...');
    end;
  end;

end;

function TTasGeraNfceAutorizacao.Fc_ConsultaNFCe(Fc_Cd_Pedido, Fc_Cd_Nota,
  Fc_Nr_Nota: Integer; Fc_Path, FC_FileXML: String): Integer;
begin
  with MM_Acompanhamento do
  Begin
    LimpaWebService;
    Clear;
    Lines.Add('INICIANDO A OPERÇÃO DE CONSULTA...');
    MM_Acompanhamento.Update;
    Fr_Principal.Nfe.Consultar;
    Result := Fr_Principal.Nfe.WebServices.Consulta.cStat;
    Lines.Add('RETORNO DA CONSULTA RECEBIDO...');
    MM_Acompanhamento.Update;
    // Faz o Tratamento do Retorno convertendo o codigo da Receita em Codigo interno
    TrataRetorno(Result, MM_Acompanhamento,True);
    MM_Acompanhamento.Update;
  end;

end;

procedure TTasGeraNfceAutorizacao.TrataRetorno(var Pc_Cd_Retorno:Integer; pc_Memo: TMemo; OnLine: Boolean);
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
  if ( (Pc_Cd_Retorno = 100) or (Pc_Cd_Retorno = 150) or (Pc_Cd_Retorno = 110) ) and OnLine then
    Pc_Atualiza_DataHora_NF(It_Cd_Nota,LcDhRecbto);
  ChaveDuplicada := '';
  if  (Pos(UpperCase('Duplicidade de NF-e'), UpperCase(Lc_Mensagem)) > 0) then
  begin
    //123456789X123456789X123456789X123456789X123456789X12345678
    //Duplicidade de NF-e, com diferenca na Chave de Acesso. [41191017906757000141650020000215831000436399] [nRec:919001164446027]'
    LcPosicao := Pos(concat('[',DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsString), Lc_Mensagem);
    ChaveDuplicada := Copy(Lc_Mensagem,LcPosicao +1,44);
    LcTIpoNF := Copy(ChaveDuplicada,21,2);
    Fc_UpdateRetornoNFCe(ChaveDuplicada);
    if FTentativasChaveDuplicada <= 3 then
    Begin
      inc(FTentativasChaveDuplicada);
      MM_Acompanhamento.Lines.Add('----------------------------------');
      MM_Acompanhamento.Lines.Add('O Sistema está fazendo uma nova consulta com chave de nota encontrada');
      MM_Acompanhamento.Lines.Add(concat('Tentativa : ', intToStr(FTentativasChaveDuplicada)));
      MM_Acompanhamento.Lines.Add(ChaveDuplicada);
      MM_Acompanhamento.Lines.Add('Esta sequência aparece como autorizada');
      Pc_ConsultaNFCe;
    End
    else
    Begin
      MM_Acompanhamento.Lines.Add('----------------------------------');
      MM_Acompanhamento.Lines.Add('O sistema fez três tentativas de consultas para esta chave.');
      MM_Acompanhamento.Lines.Add(ChaveDuplicada);
      MM_Acompanhamento.Lines.Add('Informe a equipe de suporte.');
    end;
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
                              Pc_Cd_Retorno.ToString + ' - ' + Upper(Lc_Mensagem) + EOLN + EOLN +
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
      Lines.Add('CODIGO: ' + Pc_Cd_Retorno.ToString());
      Lines.Add('MENSAGEM : ' + UpperCase(Lc_Mensagem));
      Lines.Add('================================================');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

function TTasGeraNfceAutorizacao.Fc_UpdateRetornoNFCe(chave: String): Boolean;
begin
  RetornoNFCE.clear;
  RetornoNFCE.Registro.NotaFiscal := It_Cd_Nota;
  RetornoNFCE.Registro.NomeArquivo := concat(chave,'-NFe.xml');
  RetornoNFCE.UpdateFileXMl;

end;

function TTasGeraNfceAutorizacao.Fc_ValidaAutorizacaoNFCe(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Form: TFr_Consumidor;
  Lc_Consumidor: Integer;
  Lc_DocFiscal : String;
Begin
  Result := True;
  // limpa mensagem do Web Service
  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possivel carregar a Nota.' + EOLN +
                   '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if not VerificaItemsVinculadoNF then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não foi possivel vincular os itens da venda na Nota Fiscal.' + EOLN +
                    'Cancele o pedido e recarregue a venda utilizando o pedido:.'+ Qr_Nota.FieldByName('PED_NUMERO').AsString + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;

  if not ValidaFinanceiro then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor da Nota e Valor do Financeiro não estão iguais.' + EOLN +
                    '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;


  if (Cb_TipoEmissao.ItemIndex = 1) then
  Begin
    Fr_Principal.Nfe.DANFE.TipoDANFE := tiMsgEletronica;
    if (Length(Trim(edt_Justificativa_Offline.Text)) < 15) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'Para tipo de OFF-Line uma justificativa deve ser informada.' + EOLN +
        '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
      edt_Justificativa_Offline.setfocus;
      Result := False;
      Exit;
    end;
  end;

  Lc_DocFiscal := ValidDocFiscal(Qr_Nota.FieldByName('EMP_CNPJ').AsString);
  if (ChBx_InformarCPFnaNota.Checked) and
     (NOT (Lc_DocFiscal = OK)) then
  Begin
    Try
      MM_Acompanhamento.Lines.Add('Aguardando o registro do cliente...');
      MM_Acompanhamento.Update;
      Lc_Form := TFr_Consumidor.Create(nil);
      if Cb_IndPresenca.ItemIndex = 1 then
        Lc_Form.It_Valida_Endereco := True
      else
        Lc_Form.It_Valida_Endereco := False;
      Lc_Form.It_Confirma := False;

      Lc_Consumidor := StrToIntdef(Fc_Tb_Geral('L', 'VDA_G_CODCONS', '0'), 0);

      if (Lc_Consumidor = Qr_Nota.FieldByName('EMP_CODIGO').AsInteger) then
        Lc_Form.Cliente.Empresa.Registro.Codigo := 0
      else
        Lc_Form.Cliente.Empresa.Registro.Codigo := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.ShowModal;
      if Lc_Form.It_Confirma then
      Begin
        It_cd_Cliente := Lc_Form.Cliente.Empresa.Registro.Codigo;
        MM_Acompanhamento.Lines.Add('Cliente registrado com sucesso.');
        MM_Acompanhamento.Update;
        MM_Acompanhamento.Lines.Add('Atualizando dados da venda.');
        MM_Acompanhamento.Update;

        NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
        NotaFiscal.Pedido.Registro.Empresa  := Lc_Form.Cliente.Empresa.Registro.codigo;
        NotaFiscal.Pedido.Registro.Endereco := Lc_Form.Cliente.Empresa.Endereco.Registro.Codigo;
        NotaFiscal.Pedido.AtualizaPedidoConsumidor;

        NotaFiscal.Registro.Codigo := It_Cd_Nota;
        NotaFiscal.Registro.CodigoEmpresa := Lc_Form.Cliente.Empresa.Registro.Codigo;
        NotaFiscal.AtualizaEmpresaNF;

        Financeiro.Registro.CodigoEmpresa := Lc_Form.Cliente.Empresa.Registro.Codigo;
        Financeiro.Registro.CodigoNota    := It_Cd_Nota;
        Financeiro.AtualizaEmpresaFinanceiro;

        MM_Acompanhamento.Lines.Add('Dados da venda atualizado com sucesso.');
        MM_Acompanhamento.Update;
      end
      else
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'O cliente precisa ser identificado corretamente.' + EOLN +
                       'Verifique as opções escolhidas e tente novamente.' + EOLN, ['OK'],
                       [bEscape], mpAlerta);
        Result := False;
      end;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;


end;

function TTasGeraNfceAutorizacao.Fc_ValidaCancelamentoNFCe(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  if Qr_RetornoNFCe.recordcount = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Dados de retorno da Nota não encontrada.' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  Lc_Verificacao := StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Não é possivel cancelar um Cumpom não enviado.' + EOLN +
      '       Verifique e tente novamente.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 1) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Este Cupom foi envida, mas não foi autorizado ainda.' + EOLN +
      'Faça consulta para pegar o retorno e tente novamente.' + EOLN, ['OK'],
      [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 3) then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Este Cupom já está cancelado.' + EOLN + 'Verifique e tente novamente.' +
      EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  FMotivoCancelamento := '';
  if not(InputQuery('WebServices Cancelamento', 'Justificativa',
    FMotivoCancelamento)) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Justificativa de cancelamento deve ser informada' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if Length(FMotivoCancelamento) < 15 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Justificativa de cancelamento não' + EOLN +
      'pode ser inferior a 15 caracteres.' + EOLN +
      'Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasGeraNfceAutorizacao.Fc_ValidaCancelamentoNFCe_Pendente(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Dt_Inventario: TDate;
  Lc_Dt_Prx_Inventario: TDate;
  Lc_Inventario : TControllerInventario;
Begin
  Try
    Result := True;
    Lc_Inventario := TControllerInventario.create(Nil);
    // Verifica Inventario
    Lc_Dt_Inventario := 0;
    Lc_Dt_Prx_Inventario := 0;
    Qr_Itens.Active := True;
    Qr_Itens.First;
    while not Qr_Itens.Eof do
    Begin
      Lc_Inventario.CodigoProduto := Qr_Itens.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Inventario.CodigoEstoque := Gb_Estoque;
      Lc_Inventario.Estabelecimento := Gb_CodMha;
      Lc_Dt_Prx_Inventario := Lc_Inventario.UltimaDataInventarioProduto();

      if Lc_Dt_Inventario < Lc_Dt_Prx_Inventario then
        Lc_Dt_Inventario := Lc_Dt_Prx_Inventario;
      Qr_Itens.Next;
    end;
  Finally
    FreeAndNil(Lc_Inventario);
  End;
  if Qr_Nota.FieldByName('NFL_DT_EMISSAO').AsDateTime < Lc_Dt_Inventario then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Este documento não pode ser cancelado.' + EOLN +
      'A data de emissão é menor do que o último inventário criado' + EOLN,
      ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;


end;

function TTasGeraNfceAutorizacao.Fc_ValidaConsultaNFCe(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  // Limpa as consultas do webservice;
  if not Fc_VerificaPermissao('Fr_GeraNFe', 'Consultar Nota Fiscal',
    'CONSULTAR', GB_Cd_Usuario, 'S') then
  Begin
    Result := False;
    Exit;
  end;

  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Não foi possivel Carregar a Nota.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

//    Lc_Verificacao := Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsInteger;
//    if (Lc_Verificacao = 0) then
//    Begin
//    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
//    'Nota não enviada para autorizção.'+EOLN+
//    'Envie antes de tentar Consultar.'+EOLN,
//    ['OK'],[bEscape],mpAlerta);
//    Result := False;
//    Exit;
//    end;


end;

function TTasGeraNfceAutorizacao.Fc_ValidaImpressaoNFCE(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  MM_Acompanhamento.Lines.Clear;
  MM_Acompanhamento.Lines.Add('Validando a impressão...');
  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Não foi possivel Carregar a Nota.' + EOLN +
      '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  Lc_Verificacao := StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Cupom não enviado para autorizção.' + EOLN +
      'Autorize a Nota antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 1) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
      'Cupom enviado mas ainda não possue autorizção.' + EOLN +
      'Consulte a Nota antes de tentar imprimir.' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
    Exit;
  end;

end;

procedure TTasGeraNfceAutorizacao.FinalizarVariaveis;
begin
  inherited;
  FreeAndNil(RetornoNFCE);
end;

procedure TTasGeraNfceAutorizacao.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_NFC_e;
end;

procedure TTasGeraNfceAutorizacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2:
      if Sb_NFC_Conferir.Enabled then
        Sb_NFC_ConferirClick(self);
    VK_F3:
      if Sb_NFC_Autorizar.Enabled then
        Sb_NFC_AutorizarClick(self);
    VK_F4:
      if Sb_NFC_Consultar.Enabled then
        Sb_NFC_ConsultarClick(self);
    VK_F5:
      if Sb_NFC_Cancelar.Enabled then
        Sb_NFC_CancelarClick(self);
    VK_F6:
      if Sb_NFC_Imprimir.Enabled then
        Sb_NFC_ImprimirClick(self);
    VK_F7:
      if Sb_NFC_Envia.Enabled then
        Sb_NFC_EnviaClick(self);
    VK_F8:
      ChBx_InformarCPFnaNota.Checked := not ChBx_InformarCPFnaNota.Checked;
    VK_Escape:
      if Sb_NFC_Sair.Enabled then
        Sb_NFC_SairClick(self);
  end;
end;

procedure TTasGeraNfceAutorizacao.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    CarregaImagemBotao(Sb_NFC_Conferir,'CONFERIR');
    CarregaImagemBotao(Sb_NFC_Autorizar,'AUTORIZAR');
    CarregaImagemBotao(Sb_NFC_Consultar,'CONSULTAR');
    CarregaImagemBotao(Sb_NFC_Cancelar,'CANCELAR NFE');
    CarregaImagemBotao(Sb_NFC_Imprimir,'IMPRIMIR');
    CarregaImagemBotao(Sb_NFC_Envia,'ENVIA EMAIL');
    CarregaImagemBotao(Sb_NFC_Sair,'SAIR');
  END;
end;

procedure TTasGeraNfceAutorizacao.InformarCPFnaNotaClick(Sender: TObject);
Var
  Lc_Verificacao : Integer;
begin
  if Qr_RetornoNFCe.Active then
  Begin
    Lc_Verificacao := StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsString,0);
    if (Lc_Verificacao > 0) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                      'Não é possível informar CNF/CNPJ neste cupom.' + EOLN +
                      'O processo de autorizção já efetuado ou está em operção.' + EOLN, ['OK'], [bEscape],
                      mpAlerta);

    end;
  End;
end;

procedure TTasGeraNfceAutorizacao.IniciaVariaveis;
begin
  inherited;

  FTentativasChaveDuplicada := 0;
  Qr_Nota.Close;
  Qr_RetornoNFCe.Close;
  MostraValidade(PnL_Validade, PnL_Cert_Validade,PnL_Cert_Expira);

  FVisualizaImpressao := (Fc_Aq_Geral('L', 'CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL', 'S') = 'S');
  FImp_Auto_NFCe := ( Fc_Aq_Geral('L', 'NFCE', 'NFCE_IMP_AUTO', 'S') = 'S');
  if FVisualizaImpressao then
    fr_principal.Danfe_NFCe_F.Impressora := ''
  else
    fr_principal.Danfe_NFCe_F.Impressora := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA','' );
  Pc_FormataModeloNFCe;
  AtivaRetorno(It_Cd_Nota);
  Fc_AtivaDadosDaNota('C', It_Cd_Nota);
  DM.Qr_Modal_Frete.Active := True;
  Cb_TipoEmissao.ItemIndex := 0;
  Cb_ForDanfe.ItemIndex := 0;

  PrePreenchimento;
end;

procedure TTasGeraNfceAutorizacao.Pc_AutorizacaoOff_Line;
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    if Fc_ValidaAutorizacaoNFCe(It_Cd_Nota) then
    Begin
      // Gera a nota do consumidor com os dados complementares
      Pc_GeraNFCe(It_Cd_Nota);
      Pc_AtivaEstabelecimento();
      Pc_AtivaConfiguracaoNFe;
      Fc_AtivaDadosDaNota('C', It_Cd_Nota);
      AtivaRetorno(It_Cd_Nota);
      // Envio para autoriazção
      Pc_AutorizaNFCe_Off_Line;
    end;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    self.BringToFront;
  end;

end;

procedure TTasGeraNfceAutorizacao.Pc_AutorizacaoOn_Line;
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    if Fc_ValidaAutorizacaoNFCe(It_Cd_Nota) then
    Begin
      // Gera a nota do consumidor com os dados complementares
      Pc_GeraNFCe(It_Cd_Nota);
      Pc_AtivaEstabelecimento();
      Pc_AtivaConfiguracaoNFe;
      Fc_AtivaDadosDaNota('C', It_Cd_Nota);
      AtivaRetorno(It_Cd_Nota);
      // Envio para autoriazção
      Pc_AutorizaNFCe;
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

procedure TTasGeraNfceAutorizacao.Pc_AutorizaNFCe;
Var
  Lc_Nr_Lote: String;
  Lc_Sincrono: Boolean;
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Vinculo: Integer;
  Lc_Cd_Retorno: Integer;
Begin
  // Define o caminho e o arquivo da Nota Fiscal
  Fr_Principal.Nfe.DANFE.MostraPreview := FVisualizaImpressao;
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE').AsString;
  // Prepara a danfe para o envio
  Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, False);
  if Trim(Lc_FileXML) <> '' then
  Begin
    // Consulta e faz o Tratamento do Retorno convertendo o codigo da Receita em Codigo interno
    Lc_Cd_Retorno := Fc_ConsultaNFCe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota,
      Lc_Path, Lc_FileXML);
    if (Lc_Cd_Retorno = 0) then
    Begin
      try
        LimpaWebService;
        MM_Acompanhamento.Clear;
        MM_Acompanhamento.Lines.Add('ENVIANDO OS DADOS DA NOTA...');
        MM_Acompanhamento.Update;
        Lc_Nr_Lote := Qr_RetornoNFCe.FieldByName('NFC_LOTE').AsString;
        Lc_Sincrono := (Qr_RetornoNFCe.FieldByName('NFC_SINCRONO').AsString = 'S');
        MM_Acompanhamento.Lines.Add('AGUARDANDO RETORNO DA NOTA...');
        MM_Acompanhamento.Update;
          try
            Fr_Principal.Nfe.Enviar(Lc_Nr_Lote, FImp_Auto_NFCe, Lc_Sincrono);
          Except
            on E : Exception do
            Begin
              MM_Acompanhamento.Lines.Add('========================');
              MM_Acompanhamento.Lines.Add( E.ClassName );
              MM_Acompanhamento.Lines.Add( E.Message );
              MM_Acompanhamento.Lines.Add('========================');
              Exit;
            End;
          end;
      finally
        // Consulta
        // comentado no dia 10/10/2016- dados já tratado no tratamento do retorno
        // MM_Acompanhamento.Lines.Add('RETORNO DA AUTORIZÇÃO RECEBIDO...');
        // MM_Acompanhamento.Lines.Add('========================');
        // MM_Acompanhamento.Lines.Add(UpperCase(Fr_Principal.Nfe.WebServices.Enviar.xMotivo));
        // MM_Acompanhamento.Lines.Add('========================');

        Lc_Cd_Retorno := Fr_Principal.Nfe.WebServices.Enviar.cStat;
        TrataRetorno(Lc_Cd_Retorno, MM_Acompanhamento,True);
        Fr_Principal.Nfe.NotasFiscais.Items[0].GravarXML(Lc_FileXML, Lc_Path);
      end;
    end;
    Fc_AtualizaRetornoNFCe(Lc_Cd_Retorno, Lc_Path, Lc_FileXML, MM_Acompanhamento);
  end;

end;

procedure TTasGeraNfceAutorizacao.Pc_AutorizaNFCe_Off_Line;
Var
  Lc_Nr_Lote: String;
  Lc_Sincrono: Boolean;
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Vinculo: Integer;
  Lc_Cd_Retorno: Integer;
Begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE').AsString;
  // Prepara a danfe para o envio
  Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, False);
  if Trim(Lc_FileXML) <> '' then
  Begin
    MM_Acompanhamento.Lines.Add('ENVIANDO OS DADOS DA NOTA...');
    MM_Acompanhamento.Update;
    // Coloca o "0" Zero para ficar pendente.
    Lc_Cd_Retorno := 0;
    Fc_AtualizaRetornoNFCe(Lc_Cd_Retorno, Lc_Path, Lc_FileXML, MM_Acompanhamento);
    //if FImp_Auto_NFCe then foi retirada por que a reeimpressão não é permitida pelo botão
    Fr_Principal.Nfe.NotasFiscais.Imprimir;
    // Fr_Principal.Nfe.NotasFiscais.ImprimirResumido;
  end;

end;

procedure TTasGeraNfceAutorizacao.Pc_CancelamentoNotasNFCe;
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Deseja realmente Cancelar este Documento?.' + EOLN + EOLN +
                      'Confirmar a operção ?', [SIM, NAO], [bEscape, bNormal], mpConfirmacao,
                      clred) = mrBotao1) then
  Begin
    If (Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsInteger > 0) then
    Begin
      if Fc_ValidaCancelamentoNFCe(It_Cd_Nota) then
        Pc_CancelaNFCe;
    end
    else
    Begin
      if Fc_ValidaCancelamentoNFCe_Pendente(It_Cd_Nota) then
        Pc_CancelaNFC_Pendente;
    end;
  end;

end;

procedure TTasGeraNfceAutorizacao.Pc_CancelaNFCe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Vinculo: Integer;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Qr_RetornoNFCe.FieldByName('NFC_ARQUIVO').AsString;
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE')
    .AsString;
  // Salva o Arquivo XML da NOta no diretorio
  if not Fc_VerificaExistenciaArquivoNFCEXML(4, It_Cd_Nota, Lc_Path, Lc_FileXML)
  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    // Cancelamento da Nota Propriamente dito
    if Fc_CancelaNFCe(Lc_Path, Lc_FileXML) then
    Begin
      Fc_ConsultaNFCe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota, Lc_Path, Lc_FileXML);
    End;
  end;


end;

procedure TTasGeraNfceAutorizacao.Pc_CancelaNFC_Pendente;
begin
  //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
  //MM_Acompanhamento.Lines.Add('Apagando Movimento Financeiro...');
  MM_Acompanhamento.Lines.Add('Apagando Financeiro...');
  MM_Acompanhamento.Update;
  Financeiro.Clear;
  Financeiro.Registro.CodigoNota := It_Cd_Nota;
  Financeiro.deleteByNota;

  MM_Acompanhamento.Lines.Add('Apagando Comissão...');
  MM_Acompanhamento.Update;
  Pc_ApagaComissaoFaturamento( It_Cd_Pedido);
  MM_Acompanhamento.Lines.Add('Apagando Impostos...');
  MM_Acompanhamento.Update;

  NotaFiscal.Registro.Codigo := It_Cd_Nota;
  NotaFiscal.ApagarImpostos;


  MM_Acompanhamento.Lines.Add('Apagando Observções...');
  MM_Acompanhamento.Update;
  Pc_ApagaObservacao( It_Cd_Nota);
  MM_Acompanhamento.Lines.Add('Apagando Nota Fiscal...');
  MM_Acompanhamento.Update;

  Notafiscal.Registro.Codigo := It_Cd_Nota;
  Notafiscal.delete;

  MM_Acompanhamento.Lines.Add('Apagando Informações Vendedor...');
  MM_Acompanhamento.Update;
  Pc_ApagaVendedor( It_Cd_Nota);
  MM_Acompanhamento.Lines.Add('Apagando outras informações...');
  MM_Acompanhamento.Update;

  MM_Acompanhamento.Lines.Add('Atualizando itens da nota...');
  MM_Acompanhamento.Update;
  Pc_AtualizarItensNota(Qr_RetornoNFCe.FieldByName('NFL_TIPO').AsString,
    'PENDENTE', It_Cd_Nota, It_Cd_Pedido, Qr_Itens);
  MM_Acompanhamento.Lines.Add('Atualizando Estoque...');
  MM_Acompanhamento.Update;
  Pc_Delete_Estoque('P', It_Cd_Pedido, 0);

  NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
  NotaFiscal.Pedido.getbyId;
  if (NotaFiscal.Pedido.Registro.Tipo = 2) or (NotaFiscal.Pedido.Registro.Tipo = 3) then
  Begin
    if (Copy(NotaFiscal.Registro.Tipo,1,1) = 'S') then
      NotaFiscal.AtualizaSeries('S',Qr_Itens)//Se for cancelamento de saida e não for venda volta a ficar disponivel
    else
      NotaFiscal.AtualizaSeries('N',Qr_Itens)//Se for cancelamento de Entrada volta a ficar não disponivel
  End;
  //Altera a Status;
  NotaFiscal.Pedido.Registro.Faturado := 'N';
  NotaFiscal.Pedido.alteraStatus;

  ApagarPrePaid;
  ApagarPayBAck;
  MM_Acompanhamento.Lines.Add('Cancelamento efetuado com sucesso..');
  MM_Acompanhamento.Update;

  Pc_Log_Sistema( Gb_CodMha,
                  GB_Cd_Usuario,
                  (Now),
                  'Operções NFC-e',
                  Qr_Nota.FieldByName('PED_CODIGO').AsInteger,
                  'Cancelamento NFC-e',
                  concat('PEDIDO: ',Qr_Nota.FieldByName('PED_NUMERO').AsString ));

  MensagemPadrao(MENSAGEM, 'S U C E S S O !.' + EOLN + EOLN +
                  'Nota Fiscal Cancelada com Sucesso.' + EOLN +
                  '  Clique em OK para continuar.' + EOLN, ['OK'], [bEscape], mpInformacao);

end;

procedure TTasGeraNfceAutorizacao.Pc_ConsultaNFCe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Retorno: Integer;
Begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Qr_RetornoNFCe.FieldByName('NFC_ARQUIVO').AsString;
  if Lc_FileXML = '' then
  Begin
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
    RetornoNFCE.Registro.Codigo       := Qr_RetornoNFCe.FieldByName('NFC_CODIGO').AsInteger;
    RetornoNFCE.getById;
    RetornoNFCE.Registro.NomeArquivo  := Lc_FileXML;
    RetornoNFCE.atualiza;
  End;
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE').AsString;
  // Salva o Arquivo XML da NOta no diretorio
  MM_Acompanhamento.Lines.Add('VERIFICA A EXISTENCIA DO ARQUIVO NO DIRETORIO...');
  MM_Acompanhamento.Update;
  if not Fc_VerificaExistenciaArquivoNFCEXML(4, It_Cd_Nota, Lc_Path, Lc_FileXML)  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    MM_Acompanhamento.Update;
    // Prepara a danfe para o envio
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    MM_Acompanhamento.Lines.Add('CARREGANDO OS COMPONENTES DA NOTA FISCAL...');
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    // Consulta
    Lc_Cd_Retorno := Fc_ConsultaNFCe(It_Cd_Pedido, It_Cd_Nota, It_Nr_Nota,Lc_Path, Lc_FileXML);
    if Lc_Cd_Retorno >= 0 then
      Fc_AtualizaRetornoNFCe(Lc_Cd_Retorno, Lc_Path, Lc_FileXML, MM_Acompanhamento);
    MM_Acompanhamento.Update;
  end;
end;

procedure TTasGeraNfceAutorizacao.Pc_EmiteCupomNaoFiscal;
Var
  Lc_Vl_Pagar, Lc_Vl_Recebido, Lc_Vl_Troco: Real;
  Lc_Tp_Impressao: Integer;
  Lc_Imp: TimpModImpressao;
Begin
  Try
    Lc_Imp := TimpModImpressao.Create(Nil);
    Lc_Vl_Pagar := 0;
    Lc_Vl_Recebido := 0;
    Lc_Vl_Troco := 0;
    Lc_Tp_Impressao := StrToIntdef(Fc_Aq_Geral('L', 'CONTROLE DE FRENTE','FRT_P_IMPRESSORA', '1'), 1);
    case Lc_Tp_Impressao of
      0:Lc_Imp.Pc_Imp_Frt_Matricial(It_Cd_Pedido, Lc_Vl_Pagar, Lc_Vl_Recebido,Lc_Vl_Troco);
      1:Lc_Imp.Pc_Imp_Frt_Termica(It_Cd_Pedido, Lc_Vl_Pagar, Lc_Vl_Recebido,Lc_Vl_Troco);
    end;
  Finally
    FreeandNil(Lc_Imp);
  end;


end;

procedure TTasGeraNfceAutorizacao.Pc_EmiteCupomNotaPromissoria;
Var
  Lc_Imp: TimpModImpressao;
begin
  Lc_Imp := TimpModImpressao.Create(Nil);
  Try
    Lc_Imp.CodigoPedido := It_Cd_Pedido;
    Lc_Imp.pc_ImprimeCupomNotaPromissoria
  Finally
    FreeandNil(Lc_Imp);
  end;
end;

procedure TTasGeraNfceAutorizacao.Pc_EnviaEmailNFCE;
Var
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_FilePDF: String;
  Lc_Escolha : Integer;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  Lc_FileXML := Qr_RetornoNFCe.FieldByName('NFC_ARQUIVO').AsString;
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE').AsString;
  // Salva o Arquivo XML da NOta no diretorio
  if not Fc_VerificaExistenciaArquivoNFCEXML(4, It_Cd_Nota, Lc_Path, Lc_FileXML)
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
    //Gera o PDF para envio
    Lc_FilePDF := Copy(Lc_FileXML, 1, (Length(Lc_FileXML) - 4)) + '.PDF';
    //Se usa o ESCPOS PRECISA MUDAR PARA O MODO GRAFICO
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_ESCPOS', 'N') = 'S') then
    Begin
      //Configura o componente para gerar o pdf
      with Fr_Principal,DM.Qr_Nf_Eletronica do
      Begin
        Danfe_NFCe_F.ACBrNFe := Nfe;
        Nfe.DANFE := Danfe_NFCe_F;
        Nfe.DANFE.TipoDANFE  := tiNFCe;
        Nfe.DANFE.MostraPreview := True;
      End;
      Pc_SalvaNFCEArquivoPDF(Lc_Path);
      //voltamos a configurção
      AtivaESCPOS;
    end
    else
    Begin
      Pc_SalvaNFCEArquivoPDF(Lc_Path);
    End;

    // Envia Email
    Fc_EnviaEmailNFCE(Qr_RetornoNFCe.FieldByName('EMP_NOME').AsString,
                      Qr_RetornoNFCe.FieldByName('EMP_EMAIL').AsString,
                      Qr_RetornoNFCe.FieldByName('NFC_CODIGO').AsString, Lc_Path,
                      Lc_FileXML,
                      Lc_FilePDF);
  End;
end;

procedure TTasGeraNfceAutorizacao.Pc_FinalizaCancelamentoNFCe;
Begin
  Fc_AtivaDadosDaNota('C', It_Cd_Nota);
  Pc_SelecionaItensNota(It_Cd_Nota);
  //Foi retirado por que para cancelar deve cancelar a baixa no caixa/banco e o o novo metodo de cancelamento do caixa não apaga o movimento
  Pc_ApagaMovimFinanceiro( It_Cd_Nota);
  Financeiro.Clear;
  Financeiro.Registro.CodigoNota := It_Cd_Nota;
  Financeiro.deleteByNota;

  Pc_ApagaComissaoFaturamento( It_Cd_Pedido);
  NotaFiscal.Registro.Codigo := It_Cd_Nota;
  NotaFiscal.Registro.Situacao := 'C';
  NotaFiscal.alteraStatus;
  Pc_CancelaVendaComercioEletronico(It_Cd_Pedido);
  Pc_Apaga_conserto( It_Cd_Pedido);
  Pc_ApagaVendedor( It_Cd_Pedido);
  Pc_Retornodevolucao(Qr_Itens); // Devolução modelo Genio
  NotaFiscal.AtualizaSeries(Qr_Nota.FieldByName('NFL_TIPO').AsString, Qr_Itens);
  Pc_AtualizarItensNota(Qr_Nota.FieldByName('NFL_TIPO').AsString,
                        'AUTORIZADA',
                        It_Cd_Nota,
                        It_Cd_Pedido,
                        Qr_Itens);
  Pc_AtualizacaoEstoqueNota('AUTORIZADA',
                            Qr_Nota.FieldByName('PED_TIPO').AsInteger,
                            Qr_Nota.FieldByName('PED_CODIGO').AsInteger);
  // Pc_AtualizarItensDevolucao(Qr_Nota.FieldByName('NFL_TIPO').AsString,Qr_Itens);//Devolução modelo Winkert - comentei pois na nfe não tem devolução assim

  NotaFiscal.Pedido.Registro.Codigo   := It_Cd_Pedido;
  NotaFiscal.Pedido.Registro.Faturado := 'C';
  NotaFiscal.Pedido.alteraStatus;
end;

procedure TTasGeraNfceAutorizacao.Pc_GeraNFCe(Pc_cd_Nota: Integer);
Var
  Lc_Sincrono: String;
  Lc_Tp_Emissao: String;
  Lc_Formato: String;
  Lc_Ind_Pres: String;
BEgin
  if (It_Nr_Nota = 0) then
  Begin
    RetornoNFCE.Registro.Codigo := 0;
    RetornoNFCE.Registro.NotaFiscal := It_Cd_Nota;
    RetornoNFCE.Registro.Numero     := 0;
    RetornoNFCE.Registro.Serie      := StrToIntDeF(Fc_Tb_Geral('L','NFE_SERIE','1'),1);
    RetornoNFCE.Registro.Lote       := 0;
    RetornoNFCE.Registro.DataHora   := Now;
    RetornoNFCE.Registro.Sincrono := 'S';
    if Cb_TipoEmissao.ItemIndex = 0 then
      RetornoNFCE.Registro.TipoEmissao := '4'
    else
      RetornoNFCE.Registro.TipoEmissao := '9';

    if Cb_ForDanfe.ItemIndex = 0 then
      RetornoNFCE.Registro.Formato := '1'
    else
      RetornoNFCE.Registro.Formato := '9';

    if Cb_IndPresenca.ItemIndex = 0 then
      RetornoNFCE.Registro.IndicacaoPresenca := '1'
    else
      RetornoNFCE.Registro.IndicacaoPresenca := '4';

    RetornoNFCE.Registro.NomeArquivo := '';
    RetornoNFCE.Registro.Motivo      := '';
    RetornoNFCE.Registro.Estabelecimento := Gb_CodMha;
    RetornoNFCE.insere;
  end;
end;

procedure TTasGeraNfceAutorizacao.Pc_ImprimeNFCe;
Var
  Lc_Path: String;
  Lc_FileXML: String;
begin
  // Define o caminho e o arquivo da Nota Fiscal
  MM_Acompanhamento.Lines.Add('Definindo o caminho do Arquivo XML...');
  MM_Acompanhamento.Update;
  Lc_FileXML := Qr_RetornoNFCe.FieldByName('NFC_ARQUIVO').AsString;
  Lc_Path := DM.Qr_Nf_Eletronica.FieldByName('NFE_REPOSITORIO_NFCE').AsString;
  // Salva o Arquivo XML da NOta no diretorio
  MM_Acompanhamento.Lines.Add('Salvando o Arquivo XML no Diretório...');
  MM_Acompanhamento.Update;
  if not Fc_VerificaExistenciaArquivoNFCEXML(4, It_Cd_Nota, Lc_Path, Lc_FileXML)
  then
  Begin
    MM_Acompanhamento.Lines.Add('Arquivo XML não encontrado...');
    MM_Acompanhamento.Lines.Add('Gerando Arquivo XML novamente...');
    // Prepara a danfe para o envio
    Lc_FileXML := Fc_Conferencia_Danfe(Lc_Path, MM_Acompanhamento, True);
  end;
  if Trim(Lc_FileXML) <> '' then
  Begin
    MM_Acompanhamento.Lines.Add('Carregando dados da Nota...');
    CarregaComponenteNFE(Lc_Path, Lc_FileXML);
    MM_Acompanhamento.Lines.Add('IMPRIMINDO...');
    MM_Acompanhamento.Update;
    with Fr_Principal do
    Begin
      Nfe.DANFE.MostraPreview := FVisualizaImpressao;
      Nfe.NotasFiscais.Imprimir;
      MM_Acompanhamento.Lines.Add('PROCESSO FINALIZADO COM SUCESSO...');
    end;
  end;


end;

procedure TTasGeraNfceAutorizacao.PreencheDanfeIde(dfide: TIde;
  Oper_Consulta: Boolean);
Var
  Lc_Time_Str: String;
  Lc_Ok : Boolean;
Begin
  inherited;
  with dfide,Qr_Nota do
  Begin
    modelo := 65;


    if Oper_Consulta then
    Begin
      if (Length(FieldByName('NFL_HR_SAIDA').AsString) > 0) then
      Begin
        dEmi    := FieldByName('NFL_DT_EMISSAO').AsDateTime + FieldByName('NFL_HR_SAIDA').AsDateTime;
        dSaiEnt := FieldByName('NFL_DT_SAIDA').AsDateTime   + FieldByName('NFL_HR_SAIDA').AsDateTime;
        // Ide.hSaiEnt   := Qr_Nota.FieldByName('NFL_HR_SAIDA').AsDateTime;
      end
      else
      Begin
        Lc_Time_Str := TimeToStr(NOW);
        dEmi    := FieldByName('NFL_DT_EMISSAO').AsDateTime + StrToTime(Lc_Time_Str);
        dSaiEnt := FieldByName('NFL_DT_SAIDA').AsDateTime   + StrToTime(Lc_Time_Str);
        hSaiEnt := StrToTime(Lc_Time_Str);
      end;
    end
    else
    Begin
      dEmi := NOW;
      dSaiEnt := NOW;
      hSaiEnt := NOW;
    end;

    tpImp  := tiNFCe;
    if (StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_TP_EMISSAO').AsString,9) = 9) then
    Begin
      Fr_Principal.Nfe.Configuracoes.Geral.FormaEmissao := teOffLine;
      tpEmis := teOffLine;
      dhCont := FieldByName('NFL_DT_EMISSAO').AsDateTime + FieldByName('NFL_HR_SAIDA').AsDateTime;
      if ( Qr_RetornoNFCe.FieldByName('NFC_MOTIVO').AsString <> '') then
        xJust := Qr_RetornoNFCe.FieldByName('NFC_MOTIVO').AsString
      else
        xJust := 'Sem conectividade com a Receita';
    end
    else
    BEgin
      tpEmis := teNormal;
    End;



    if (Qr_RetornoNFCe.FieldByName('NFC_IND_PRES').AsString = '1') then
      indPres := pcPresencial
    else
      indPres := pcEntregaDomicilio;

    indIntermed := iiOperacaoSemIntermediador;

    // 1=NF-e normal; 2=NF-e complementar; 3=NF-e de ajuste; 4=Devolução/Retorno.
    if not Oper_Consulta then
    Begin
      case StrToIntdef( FieldByName('NFL_FINALIDADE').AsString, 1) of
        1:Begin
            finNFe := fnNormal;
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
          End;
        4:
          Begin
            finNFe := fnDevolucao;
          end;
      end;
    End;
  End;
end;

procedure TTasGeraNfceAutorizacao.PreencheDanfeInfAdic;
Var
  Lc_Obs: TMemo;
  Lc_I : Integer;
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

    InfAdic.infCpl := Lc_Obs.text;

    // Informações de Interesse do Contribuinte

    Qr_Observacao.Active := False;
    Qr_Observacao.ParamByName('NFL_CODIGO').AsInteger := It_Cd_Nota;
    Qr_Observacao.ParamByName('OBN_TIPO').AsString := 'M';
    Qr_Observacao.Active := True;
    Qr_Observacao.FetchAll;
    Qr_Observacao.First;
    Lc_Obs.Clear;
    Lc_Obs.text := Qr_Observacao.FieldByName('OBN_DETALHE').AsString;

    InfAdic.infCpl := Lc_Obs.text;

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
  End;
end;

procedure TTasGeraNfceAutorizacao.PrePreenchimento;
Var
  Lc_DocFiscal : String;
begin
  if FNFEletronica.Registro.Ambiente <> '0' then
    Caption := concat(Caption,' - HOMOLOGÇÃO');

  pnl_emission_option.Enabled := True;
  Cb_TipoEmissao.ItemIndex := 0;
  Cb_IndPresenca.ItemIndex := 0;

  if (It_Nr_Nota > 0) then
  Begin
    if StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_TP_EMISSAO').AsString,1) = 4 then
      Cb_TipoEmissao.ItemIndex := 0
    else
    Begin
      Cb_TipoEmissao.ItemIndex := 1;
      edt_Justificativa_Offline.Text := 'Sem conectividade com a Receita'
    End;


    if StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_IND_PRES').AsString,1) = 1 then
      Cb_IndPresenca.ItemIndex := 0
    else
      Cb_IndPresenca.ItemIndex := 1;

    Cb_ForDanfe.ItemIndex := StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_FORMATO').AsString,1) - 1;


    pnl_emission_option.Enabled := False;
  End;
  ChBx_InformarCPFnaNota.OnClick := nil;

  if (Fc_Tb_Geral('L','GRL_G_VALIDA_CPF_CNPJ','') = 'S') then
  Begin
    ChBx_InformarCPFnaNota.Font.Color := clBlack;
    ChBx_InformarCPFnaNota.Caption := 'F8 - Informar C.P.F na Nota Fiscal';
    Lc_DocFiscal := ValidDocFiscal(Qr_Nota.FieldByName('EMP_CNPJ').AsString);
    if ( Lc_DocFiscal = OK ) and
        (Qr_Nota.FieldByName('EMP_CODIGO').AsInteger <> It_cd_Consumidor) then
    Begin
      ChBx_InformarCPFnaNota.Checked := True;
      ChBx_InformarCPFnaNota.Enabled := False;
    end
    else
    Begin
      ChBx_InformarCPFnaNota.Checked := False;
      ChBx_InformarCPFnaNota.Enabled := True;
    end;
    ChBx_InformarCPFnaNota.OnClick := InformarCPFnaNotaClick;
    //Se a validção não estiver aivva vamos desativar o campo de CPF na NOta
  End
  else
  Begin
    ChBx_InformarCPFnaNota.Checked := False;
    ChBx_InformarCPFnaNota.enabled := False;
    ChBx_InformarCPFnaNota.Font.Color := clRed;
    ChBx_InformarCPFnaNota.Caption := 'F8 - Informar C.P.F na Nota Fiscal (Validção CPF/CNPJ Desativado)';
  End;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_AutorizarClick(Sender: TObject);
begin
  if Cb_TipoEmissao.ItemIndex = 0 then
  Begin
    Pc_AutorizacaoOn_Line;
  end
  else
  Begin
    Pc_AutorizacaoOff_Line;
  end;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_CancelarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    AtivaRetorno(It_Cd_Nota);
    if ValidaCancelamentoNotas then
      Pc_CancelamentoNotasNFCe;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    self.BringToFront;
  end;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_ConferirClick(Sender: TObject);
begin
  inherited;
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    Pc_EmiteCupomNaoFiscal;
    if ValidaEmiteCupomNotaPromissoria then
      Pc_EmiteCupomNotaPromissoria;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;

end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_ConsultarClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    AtivaRetorno(It_Cd_Nota);
    if Fc_ValidaConsultaNFCe(It_Cd_Nota) then
      Pc_ConsultaNFCe;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_EnviaClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    AtivaRetorno(It_Cd_Nota);
    if ValidaEnvioEmailNFCe(It_Cd_Nota) then
      Pc_EnviaEmailNFCE;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(self, 'I');
    self.Enabled := False;
    Self.FormStyle := fsNormal;
    Self.Update;
    Pc_AtivaEstabelecimento();
    Pc_AtivaConfiguracaoNFe;
    Fc_AtivaDadosDaNota('C', It_Cd_Nota);
    AtivaRetorno(It_Cd_Nota);
    if Fc_ValidaImpressaoNFCE(It_Cd_Nota) then
      Pc_ImprimeNFCe;
  finally
    Pc_ProcesoAguarde(self, 'F');
    self.Enabled := True;
    self.Activate;
    Self.FormStyle := fsStayOnTop;
    Self.Update;
    Self.BringToFront;
  end;
end;

procedure TTasGeraNfceAutorizacao.Sb_NFC_SairClick(Sender: TObject);
begin
  Close;
end;


function TTasGeraNfceAutorizacao.ValidaCancelamentoNotasNFCE: Boolean;
begin
  Result := True;
  MM_Acompanhamento.Lines.Clear;
  MM_Acompanhamento.Lines.Add('Validando o cancelamento NFCe...');
  if not ValidaCancelamentoNotas then
  Begin
    Result := False;
    Exit;
  End;
end;

function TTasGeraNfceAutorizacao.ValidaEmiteCupomNotaPromissoria: Boolean;
Var
  Lc_Imp: TimpModImpressao;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := True;
  if ( Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOTA_PROMISSORIA', 'S') <> 'S') then
  Begin
    Result := False;
    exit;
  end;
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(CONCAT(
                'SELECT PED_CODEMP, FPT_DESCRICAO     ',
                'FROM TB_PEDIDO P                     ',
                '  INNER JOIN tb_financeiro FN        ',
                '  ON (FN.fin_codped = P.ped_codigo)  ',
                '  INNER JOIN tb_formapagto F         ',
                '  ON (F.fpt_codigo = FN.fin_codfpg)  ',
                '  INNER JOIN tb_empresa E            ',
                '  ON (E.emp_codigo = P.ped_codemp)   ',
                'WHERE PED_CODIGO=:PED_CODIGO         ',
                'AND EMP_NOME NOT LIKE :EMP_NOME      ',
                ' AND FPT_DESCRICAO=:FPT_DESCRICAO   '
      ));
      ParamByName('PED_CODIGO').AsiNTEGER := It_Cd_Pedido;
      ParamByName('EMP_NOME').AsString := '%CONSUMIDOR%';
      ParamByName('FPT_DESCRICAO').AsString := 'CARTEIRA';
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);

    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;

end;

function TTasGeraNfceAutorizacao.ValidaEnvioEmailNFCe(
  Fc_Cd_Nota: Integer): Boolean;
Var
  Lc_Verificacao: Integer;
Begin
  Result := True;
  if (Qr_Nota.recordcount = 0) then
  Begin
    MensagemPadrao( TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Não foi possivel Carregar a Nota.' + EOLN +
                    '   Verifique e tente novamente.' + EOLN, ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  Lc_Verificacao := StrToIntDef(Qr_RetornoNFCe.FieldByName('NFC_CODSIT').AsString,0);
  if (Lc_Verificacao = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota não enviada para autorizção.' + EOLN +
      'Autorize a Nota antes de tentar enviar e-mail.' + EOLN, ['OK'],
      [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

  if (Lc_Verificacao = 1) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Nota enviada mas ainda não possue autorizção.' + EOLN +
      'Consulte a Nota antes de tentar de tentar enviar e-mail.' + EOLN, ['OK'],
      [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;

end;

function TTasGeraNfceAutorizacao.ValidaFinanceiro: Boolean;
Var
  Lc_Valor : Real;
Begin
  REsult := True;
  Financeiro.Clear;
  Financeiro.Registro.CodigoNota := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
  Lc_Valor := Financeiro.ValorTotalNota;
  Result :=  Lc_Valor = Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency;
  if not Result then
  Begin
    MM_Acompanhamento.Lines.Add('============== FINANCEIRO =========================');
    MM_Acompanhamento.Lines.Add('VALOR DA VENDA      : '+ FloatToStrF(Qr_Nota.FieldByName('NFL_VL_TL_NOTA').AsCurrency,ffNumber,10,2));
    MM_Acompanhamento.Lines.Add('VALOR NO FINANCEIRO : '+ FloatToStrF( Lc_Valor ,ffNumber,10,2));
    MM_Acompanhamento.Lines.Add('CANCELE A VENDA E REFAÇA UTILIZANDO O NUMERO DO PEDIDO Nº ' + Qr_Nota.FieldByName('PED_NUMERO').AsString);
    MM_Acompanhamento.Lines.Add('===================================================');
  End;

end;

function TTasGeraNfceAutorizacao.VerificaItemsVinculadoNF: Boolean;
begin
  REsult := True;
  Pc_SelecionaItensNota(It_Cd_Nota);
  if Qr_Itens.RecordCount = 0 then
  Begin
    MM_Acompanhamento.Lines.Add('===================================================');
    MM_Acompanhamento.Lines.Add('HOUVE UM PROBLEMA DE VINCULO DOS ITENS NA NOTA..');
    MM_Acompanhamento.Lines.Add('ESTA OPERÇÃO SERÁ ABORTADA..');
    MM_Acompanhamento.Lines.Add('CANCELE A VENDA E REFAÇA UTILIZANDO O NUMERO DO PEDIDO Nº '+Qr_Nota.FieldByName('PED_NUMERO').AsString);
    MM_Acompanhamento.Lines.Add('===================================================');
    REsult := False;
    Exit;
  End;

end;

end.

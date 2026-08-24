unit tas_gera_nfce_autorizacao_lote;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_geranfe3X, STDataSet, Data.DB, STQuery, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, tas_gera_nfce_autorizacao;

type
  TTasGeraNfceAutorizacaoLote = class(TTasGeraNfceAutorizacao)
    tbs_Auto_Lote_Nfce: TTabSheet;
    Panel12: TPanel;
    Lb_7_Inicio: TLabel;
    Lb_7_Fim: TLabel;
    Label36: TLabel;
    RG_7_Tipo_Pesquisa: TRadioGroup;
    Ed_7_Inicio: TMaskEdit;
    Ed_7_Fim: TMaskEdit;
    Panel16: TPanel;
    Sb_Off_NFCe_Voltar: TSpeedButton;
    Sb_Off_NFCe_Confirmar: TSpeedButton;
    Panel14: TPanel;
    Label31: TLabel;
    MM_Auto_Lote_NFce: TMemo;
    procedure Sb_Off_NFCe_VoltarClick(Sender: TObject);
    procedure RG_7_Tipo_PesquisaClick(Sender: TObject);
    procedure Sb_Off_NFCe_ConfirmarClick(Sender: TObject);
  private
    function Fc_Valida_EnvioLoteNFCeOffLine: Boolean;
    procedure Pc_EnviarLoteNFCeOffLine;
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;

  public
    { Public declarations }
  end;

var
  TasGeraNfceAutorizacaoLote: TTasGeraNfceAutorizacaoLote;

implementation

{$R *.dfm}

uses     UN_Principal, Un_DM, env, un_msg, RN_NotaFiscalEletronica3X, un_sistema, Un_Regra_Negocio;

{ TTasGeraNfceAutorizacaoLote }

procedure TTasGeraNfceAutorizacaoLote.CriarVariaveis;
begin
  inherited;

end;

function TTasGeraNfceAutorizacaoLote.Fc_Valida_EnvioLoteNFCeOffLine: Boolean;
Begin
  Result := True;
  with Qr_LoteNFC_e_OffLine do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'select nc.* ',
              'from tb_retorno_nfc nc ',
              '  inner join tb_nota_fiscal nf ',
              '  on (nf.nfl_codigo = nc.nfc_codnfl) ',
              'where ( nc.nfc_tp_emissao = 9 ) ',
              ' and ( nc.nfc_codsit = 0 ) ',
              ' and (nf.NFL_CODMHA =:NFL_CODMHA) '
              )
            );
    if RG_7_Tipo_Pesquisa.ItemIndex = 0 then
      sql.Add(' AND nc.NFC_CODIGO between :INICIO and :FIM ')
    else
      sql.Add(' AND nf.NFL_DT_EMISSAO between :INICIO and :FIM ');

    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    ParamByName('INICIO').AsString := Ed_7_Inicio.Text;
    ParamByName('FIM').AsString := Ed_7_Fim.Text;
    Active := True;
    FetchAll;
    if recordcount = 0 then
    BEgin
      Result := False;
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Não h� registros para serem processados.' + EOLN +
                     'Verifique e tente novamente' + EOLN, ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure TTasGeraNfceAutorizacaoLote.FormataTela;
begin
  inherited;

end;

procedure TTasGeraNfceAutorizacaoLote.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    // Operções NFCe - Lote OffLine
    CarregaImagemBotao(Sb_Off_NFCe_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(Sb_Off_NFCe_Voltar,'SAIR');
  End;
end;

procedure TTasGeraNfceAutorizacaoLote.IniciaVariaveis;
begin
  inherited;
  Pc_FormataModeloNFCe;
  pg_Principal.ActivePage := tbs_Auto_Lote_Nfce;
end;

procedure TTasGeraNfceAutorizacaoLote.Pc_EnviarLoteNFCeOffLine;
Var
  Lc_Nr_Lote: String;
  Lc_Sincrono: Boolean;
  Lc_Path: String;
  Lc_FileXML: String;
  Lc_Cd_Vinculo: Integer;
  Lc_Cd_Retorno: Integer;
Begin
  // Configura para sair impresso em arquivo
  FTipoOperacao := 'NFC-e';
  It_Cd_Consumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  FVisualizaImpressao := False;
  FImp_Auto_NFCe := False;
  Pc_FormataModeloNFCe;
  MM_Auto_Lote_NFce.Lines.Clear;
  with Qr_LoteNFC_e_OffLine do
  Begin
    while not Eof do
    Begin
      MM_Auto_Lote_NFce.Lines.Add('PROCESSANDO NFC-e N� ' + FieldByName('NFC_CODIGO').AsString);
      // Gera a nota do consumidor com os dados complementares
      It_Cd_Nota := FieldByName('NFC_CODNFL').AsInteger;
      AtivaRetorno(It_Cd_Nota);
      Fc_AtivaDadosDaNota('C', It_Cd_Nota);
      DM.Qr_Modal_Frete.Active := True;

      PrePreenchimento;
      Pc_AtivaEstabelecimento();
      Pc_AtivaConfiguracaoNFe;

      It_cd_Cliente := Qr_Nota.FieldByName('EMP_CODIGO').AsInteger;

      // Envio para autoriazção
      // Define o caminho e o arquivo da Nota Fiscal
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
            Fr_Principal.Nfe.Enviar(Lc_Nr_Lote, FImp_Auto_NFCe, Lc_Sincrono);
          finally
            // Consulta
            // comentado no dia 10/10/2016- dados já tratado no tratamento do retorno
            // MM_Acompanhamento.Lines.Add('RETORNO DA AUTORIZÇÃO RECEBIDO...');
            // MM_Acompanhamento.Lines.Add('========================');
            // MM_Acompanhamento.Lines.Add(UpperCase(Fr_Principal.Nfe.WebServices.Enviar.xMotivo));
            // MM_Acompanhamento.Lines.Add('========================');
            Lc_Cd_Retorno := Fr_Principal.Nfe.WebServices.Enviar.cStat;
            TrataRetorno(Lc_Cd_Retorno, MM_Acompanhamento,False);
            Fr_Principal.Nfe.NotasFiscais.Items[0].GravarXML(Lc_FileXML, Lc_Path);
          end;
        end;
        Fc_AtualizaRetornoNFCe(Lc_Cd_Retorno, Lc_Path, Lc_FileXML, MM_Acompanhamento);
      end;
      Next;
    end;
  end;
end;

procedure TTasGeraNfceAutorizacaoLote.RG_7_Tipo_PesquisaClick(Sender: TObject);
begin
  if RG_7_Tipo_Pesquisa.ItemIndex = 0 then
  BEgin
    Lb_7_Inicio.Caption := 'Número Inicial';
    Lb_7_Fim.Caption := 'Número Final';
  end
  else
  Begin
    Lb_7_Inicio.Caption := 'Data Inicial';
    Lb_7_Fim.Caption := 'Data Final';
  end;
end;

procedure TTasGeraNfceAutorizacaoLote.Sb_Off_NFCe_ConfirmarClick(
  Sender: TObject);
begin
  if Fc_Valida_EnvioLoteNFCeOffLine then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Deseja processar este lote de NFC-e emitidas off-line?' + EOLN + EOLN +
      'Confirmar a opereção ?', [SIM, NAO], [bNormal, bEscape],
      mpConfirmacao, clred) = mrBotao1) then
    begin
      Pc_EnviarLoteNFCeOffLine;
    end;
  end;
end;

procedure TTasGeraNfceAutorizacaoLote.Sb_Off_NFCe_VoltarClick(Sender: TObject);
begin
  Close;
end;

end.

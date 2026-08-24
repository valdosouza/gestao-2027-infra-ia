unit UN_Imp_Notas;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, IniFiles, Mask, DB, STQuery, ComCtrls, QEdit_Setes, Gauges, ACBrNFe, ACBrNFeDANFEClass, pcnLeitor, pcnConversao, ACBrBase, ACBrDFe, Un_RL_ReportNF, un_Rl_ReportNf55, un_Rl_ReportNf65, UN_Rl_ReportNfe, prmNotas, IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient, ControllerBase, IdExplicitTLSClientServerBase, IdFTP, un_frx_report_gerencial_nfe_sebrae, ACBrGIF, un_setes_zip, base_frame_list, un_fm_lista_cfop, ACBrNFSeXNotasFiscais, ACBrNFSeXInterface, ACBrUtil, ACBrDFeReport, ACBrMail, ACBrNFSeX, ACBrNFSeXConversao, ACBrNFSeXWebservicesResponse, ACBrNFSeXClass, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass;



type
  TFr_Imp_Notas = class(TForm)
    Panel1: TPanel;
    Sb_Sair_0: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Exportar: TSpeedButton;
    Panel2: TPanel;
    Gg_Progresso: TGauge;
    Label2: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    ChBx_Nome: TCheckBox;
    E_BuscaCodigo: TMaskEdit;
    ChBx_Fantasia: TCheckBox;
    Qr_Exporta: TSTQuery;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Panel3: TPanel;
    Label11: TLabel;
    LBx_TipoRelatorio: TListBox;
    Ftp_Cliente: TIdFTP;
    Lb_Processamento: TLabel;
    Fm_lista_cfop: TFm_lista_cfop;
    ChBx_Lote_cancelada: TCheckBox;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_ExportarClick(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure FormShow(Sender: TObject);
    procedure E_BuscaCodigoExit(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure Ftp_ClienteWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure Ftp_ClienteWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure Ftp_ClienteWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure FormCreate(Sender: TObject);
    procedure LBx_TipoRelatorioClick(Sender: TObject);
  private
    ZipSetes : TSetesZip;
    FErro : Boolean;
    procedure AtualizaAguarde;
    { Private declarations }
    procedure Pc_NotasCompras(Pc_Operacao,Pc_Caminho:String);
      //Notas de Ajustes
    procedure Pc_NotasAjustes(Pc_Operacao,Pc_Caminho:String);
      //Notas de Vendas Geral
    procedure Pc_NotasVendasGeral(Pc_Operacao,Pc_Caminho:String);
      //Notas de Vendas NF-e
    procedure Pc_NotasVendasNFe(Pc_Operacao,Pc_Caminho:String);
      //Notas de Vendas NFC-e
    procedure Pc_NotasVendasNFCe(Pc_Operacao,Pc_Caminho:String);
      //Notas Geral
    procedure Pc_NotasGeral(Pc_Operacao,Pc_Caminho:String);
    //Nota GEral NFE
    procedure Pc_NotasGeralNFe(Pc_Operacao, Pc_Caminho: String);
      //RESUMO CFOP
    procedure Pc_Resumo_CFOP(Pc_Operacao,Pc_Caminho:String);
      //FORMATO CORDILHEIRA
    procedure Pc_FormaCodilheira(Pc_Operacao,Pc_Caminho:String);
      //LOTE NF-E
    procedure Pc_LoteNFe(Pc_Operacao,Pc_Caminho:String);
      //LOTE NFC-E
    procedure Pc_LoteNFCe(Pc_Operacao,Pc_Caminho:String);
      //LOTE NFC-E - TERCEIROS
    procedure Pc_LoteNFeTerceiros(Pc_Operacao,Pc_Caminho:String);
    procedure Pc_GerencialNFeSebrae(Pc_Operacao,Pc_Caminho:String);
    //LOTE NFS-E
    procedure Pc_LoteNFSe(Pc_Operacao,Pc_Caminho:String);

    procedure DefineNomeArquivos(Tipo:String);
    procedure Pc_Compactar(Tipo : String);
    procedure EnviaArquivoFtp;
    function Fc_Gera_Email():String;
    procedure Pc_EnviaLinkDownloadLote(Tipo:String);
    procedure GoToSubDir(SubDir: string);
  public
    { Public declarations }
    IT_Tp_Pedido:Integer;
    It_Visualizar :Boolean;
    It_Imprimir :Boolean;
    It_Exportar :Boolean;
    It_Arquivo  : TextFile;   // handle do arquivo texto
    It_Dados_Arquivo : String;
    It_Linhas : Integer;
    it_Cd_Crt : Integer;
    It_NameFolder : String;
    It_NameFileZip : String;
    It_PastaCNPJ : String;
    Function Fc_TrataValorArquivoCordilheira(Fc_Valor:Real;Fc_tamanho,Fc_Virgula:Integer):String;
    procedure Pc_Cord_Nota_Sai;
    //LAYOUT DO REGISTRO HEADER
    procedure Pc_HeaderNota;
    //LAYOUT DO REGISTRO DO EMITENTE/DESTINATÁRIO
    procedure Pc_EmitenteDestinatarioNota(Pc_Tipo:String);
    //LAYOUT DO REGISTRO DE NOTAS FISCAIS
    procedure Pc_NotaFiscaisNotaSai;
    //LAYOUT DO REGISTRO DE PRODUTOS
    procedure Pc_ProdutosNota(Pc_Cd_Nota:Integer);
    //LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE SADA
    procedure Pc_DadosComplemetaresNotaSai;

    procedure Pc_Cord_Nota_Ent;
    //LAYOUT DO REGISTRO DE NOTAS FISCAIS
    procedure Pc_NotaFiscaisNotaEnt;
    //LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE SADA
    procedure Pc_DadosComplemetaresNotaEnt;

    procedure Pc_Cord_Item;

    Function Fc_Mercaforia_St(Fc_cd_Nota:Integer):Real;
    Function Fc_Cfop_St(Fc_cd_Nota:Integer):String;
    procedure Pc_GeraLoteArquivoNFe;
    procedure Pc_GeraLoteArquivoNFCe;
    procedure Pc_GeraLoteArquivoNFeTerceiros;
    procedure Pc_GeraLoteArquivoNFSe;
   function RemoveCaracterInformado(Fc_Variavel: string; Fc_CaracterNaoDesejado : string):string;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    function getParametros: TParamNotas;
    function gerarNomeArquivoNFSe(FileName, Extension:String):String;
  end;

var
  Fr_Imp_Notas: TFr_Imp_Notas;

implementation

uses     UN_MSG, Un_Excel, UN_Sistema, Un_RL_Notas, Un_RL_Nota_Resum, UN_FUNCOES, un_padrao, UN_Principal, env, Un_Regra_Negocio, RN_Empresa, UN_TabelasEmListas, UN_DM, RN_NotaFiscalEletronica3X, Un_envia_email, ControllerContador, RN_Mailing, TrataXMLNFe, RN_NotaFiscalServico, ControllerRetornoNFS;
{$R *.dfm}

function TFr_Imp_Notas.gerarNomeArquivoNFSe(FileName, Extension: String): String;
var
  I : Integer;
begin
  Result := '';
  for I := 1 to Length(FileName) do
    if FileName[I] in ['0'..'9'] then
      Result := Result + FileName[I];

  // Se tiver mais de 40 caracteres, pega os últimos 40
  if Length(Result) > 40 then
    Result := Copy(Result, Length(Result) - 39, 40);

  // Retorna no padrão de arquivo
  Result := Result + Extension;

end;

function TFr_Imp_Notas.getParametros: TParamNotas;
begin
  Result := TParamNotas.Create;
  with Result do
  Begin
    TipoDocumento := LBx_TipoRelatorio.ItemIndex;
    Periodo := ChBx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    if Trim(DBLCB_Empresa.Text) <> '' then
      CodigoEmpresa := DBLCB_Empresa.KeyValue;
    if Trim(Fm_lista_cfop.Dblcb_Lista.Text) <> '' then
      CodigoCFOP := Fm_lista_cfop.Dblcb_Lista.KeyValue;
    CodigoEstabelecimento := Gb_Codmha;
  end;
end;

procedure TFr_Imp_Notas.Pc_GeraLoteArquivoNFe;
Var
  Lc_Qr_NF : TSTQuery;
  Lc_Tamanho : Integer;
  Lc_PathXMl,Lc_FileXML : String;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux : String;
  Lc_Cd_Vinculo : Integer;
  Lc_Base : TControllerBase;
  procedure ErroArquivo;
  Begin
    if not FErro then
    Begin
      Lc_Aux := 'Ação a ser tomada: Solicite retorno destas Nota';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFL_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);   
      FErro := True;         
    End
    else
    Begin
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFL_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);     
    End;
  
  End;
Begin
  Try
    Lc_Base := TControllerBase.create(nil);
    //Inicia VAriavel
    FErro := False;
    //Deleta Pasta
    if Trim(It_NameFolder) <> '' then
    Begin
      if DirectoryExists(GbPathExe + It_NameFolder) then
        Fc_deleteFolder(GbPathExe + It_NameFolder,false);

      //Criar Pasta
      if not DirectoryExists(GbPathExe + it_NameFolder) then
        ForceDirectories(GbPathExe + It_NameFolder);
    End;

    //Cria a Queri para a consulta de notas
    Lc_Qr_NF := Lc_Base.GeraQuery;
    with Lc_Qr_NF do
    Begin
      SQL.Add('SELECT DISTINCT   '+
               '   NFL_NUMERO, '+
               '   NFE_ARQUIVO, '+
               '   NFE_CODNFL, ' +
               '   NFE_CODSIT '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
               '  inner join TB_RETORNO_NFE tb_retorno_nfl '+
               '  ON (tb_retorno_nfl.NFE_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
               ' WHERE (NFL_CODMHA =:NFL_CODMHA) '+
               ' AND   (NFL_NUMERO <> '''' ) '+
               ' AND (NFL_MODELO = ''55'')' );
      if ChBx_Lote_cancelada.Visible and ChBx_Lote_cancelada.Checked then
      Begin
        SQL.Add(' AND NFE_CODSIT IN (3,5) ');
      End;

      if ChBx_Periodo.Checked then
        SQL.Add(' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      SQL.Add(' ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');
      //Passagem de Paramentros
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
      end;
      Active := true;
      FetchAll;
      First;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.Update;
      Lb_Processamento.Caption := 'Exportando Notas Fiscais - Modelo 55';
      Lb_Processamento.Update;
      Lc_PathXMl := GbPathExe + It_NameFolder;
      Fr_Principal.Nfe.DANFE.PathPDF := GbPathExe + It_NameFolder;
      //Arquivo do Log de Erros
      Lc_caminhoErro := GbPathExe + 'xml_nfe_nao_encontrado.txt';
      IF FileExists(Lc_caminhoErro)then
        DeleteFile(Lc_caminhoErro);
      AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
      Rewrite ( Lc_Arquivoerro);

      //Cabeçalho do Arquivo
      Lc_Aux := 'Verificar  as Notas Fiscais que estão com problemas';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      //Inicia a Exportao
      while not Lc_Qr_NF.Eof do
      Begin
        Lc_Tamanho := length(FieldByName('NFE_ARQUIVO').AsString)-51;
        Lc_FileXML     := copy(FieldByName('NFE_ARQUIVO').AsString,Lc_Tamanho,length(FieldByName('NFE_ARQUIVO').AsString));
        if (trim(Lc_FileXML) <> '') then
        Begin
          Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(FieldByname('NFE_CODNFL').AsInteger);
          try
            Pc_Salva_Arq_Disco( 1,
                               'XML',
                               Lc_Cd_Vinculo,
                               Lc_PathXMl + '\' +  Lc_FileXML);
            //Carrrega a arquivo xml no Componenente
            if FileExists(Lc_PathXMl + '\' +  Lc_FileXML) then
            Begin
              Fr_Principal.Nfe.NotasFiscais.Clear;
              if (FieldByName('NFE_CODSIT').AsInteger = 3) or (FieldByName('NFE_CODSIT').AsInteger = 5) then
              Begin
                if (FieldByName('NFE_CODSIT').AsInteger = 3) then //Notas denegadas nao tem retorno como as canceladas
                  SaveAsNfeProcExact(Lc_PathXMl + '\' +  Lc_FileXML,Lc_PathXMl + '\' +  Lc_FileXML);
                Fr_Principal.Dfe_Fortes.Cancelada := True
              End
              else
              Begin
                Fr_Principal.Dfe_Fortes.Cancelada := False;
              End;
              Fr_Principal.Nfe.NotasFiscais.LoadFromFile(Lc_PathXMl + '\' +  Lc_FileXML);

              Fr_Principal.Nfe.DANFE.MostraPreview := False;
              Fr_Principal.Nfe.DANFE.MostraStatus := False;
              Fr_Principal.Nfe.DANFE.ImprimirDANFEPDF();
            end;
          except
            ErroArquivo;
          end;
        End
        else
        Begin
          ErroArquivo;
        End;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
        Next;
      end;
      CloseFile(Lc_Arquivoerro);
      if FErro then
      Begin
        //Finaliza instruo no ARquivo de Erro e FEcha o Arquivo
        Pc_Executar_Arquivo(Lc_caminhoErro);
      end;
      Gg_Progresso.Update;
    end;
  finally  
    Lc_Base.FinalizaQuery(Lc_Qr_NF);
    FreeAndNil(Lc_Base);
  end;
end;

procedure TFr_Imp_Notas.Pc_GeraLoteArquivoNFeTerceiros;
Var
  Lc_Qr_NF : TSTQuery;
  Lc_Tamanho : Integer;
  Lc_FilePDF : String;
  Lc_PathXMl,Lc_FileXML : String;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux : String;
  wnProt: TLeitor;
  Lc_Cd_Vinculo : Integer;
  Lc_Base : TControllerBase;
  procedure ErroARquivo;
  Begin
    if not FErro then
    Begin
      Lc_Aux := 'Ação a ser tomada: Solicite retorno destas Nota';
      Writeln (Lc_Arquivoerro,Lc_Aux);          
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFL_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);
      FErro := True;
    End
    else
    Begin
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFL_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);   
    End;
  
  End;
Begin
  Try
    Lc_Base := TControllerBase.create(nil);
    //Inicia VAriavel
    FErro := False;
    //Deleta Pasta
    if Trim(It_NameFolder) <> '' then
    Begin
      if DirectoryExists(GbPathExe + It_NameFolder) then
        Fc_deleteFolder(GbPathExe + It_NameFolder,false);

      //Criar Pasta
      if not DirectoryExists(GbPathExe + it_NameFolder) then
        ForceDirectories(GbPathExe + It_NameFolder);
    End;

    //Cria a Queri para a consulta de notas
    Lc_Qr_NF := Lc_Base.GeraQuery;
    with Lc_Qr_NF do
    Begin
      SQL.Add('SELECT DISTINCT   '+
               '   NFL_CODIGO, '+
               '   NFL_NUMERO '+
               'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
               ' WHERE (NFL_CODMHA =:NFL_CODMHA) '+
               ' AND (NFL_TIPO = ''EE'' ) '+
               ' AND   (NFL_NUMERO <> '''' ) '+
               ' AND (NFL_MODELO = ''55'')' );
      if ChBx_Periodo.Checked then
        SQL.Add(' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      SQL.Add(' ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');
      //Passagem de Paramentros
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
      end;
      Active := true;
      FetchAll;
      First;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.Update;
      Lb_Processamento.Caption := 'Exportando Notas Fiscais de Terceiro - Modelo 55';
      Lb_Processamento.Update;
      Lc_PathXMl := GbPathExe + It_NameFolder;
      Fr_Principal.Nfe.DANFE.PathPDF := GbPathExe + It_NameFolder;
      //Arquivo do Log de Erros
      Lc_caminhoErro := GbPathExe + 'xml_nfe_terceiro_nao_encontrado.txt';
      IF FileExists(Lc_caminhoErro)then
        DeleteFile(Lc_caminhoErro);
      AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
      Rewrite ( Lc_Arquivoerro);

      //Cabeçalho do Arquivo
      Lc_Aux := 'Verificar  as Notas Fiscais de Terceirs que estão com problemas';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      wnProt:=TLeitor.Create;
      //Inicia a Exportao
      while not Lc_Qr_NF.Eof do
      Begin
        Lc_FileXML := 'compra' + FieldByName('NFL_CODIGO').AsString + 'NFe.xml';
        if (trim(Lc_FileXML) <> '') then
        Begin
          //No caso de notas de entrada fica o NfL_codigo direto
          Lc_Cd_Vinculo := FieldByname('NFL_CODIGO').AsInteger;
          try
            Pc_Salva_Arq_Disco( 3,
                               'XML',
                               Lc_Cd_Vinculo,
                               Lc_PathXMl + '\' +  Lc_FileXML);
            //Carrrega a arquivo xml no Componenente
            if FileExists(Lc_PathXMl + '\' +  Lc_FileXML) then
            Begin
              Fr_Principal.Nfe.NotasFiscais.Clear;
              Fr_Principal.Nfe.NotasFiscais.LoadFromFile(Lc_PathXMl + '\' +  Lc_FileXML);
              wnProt.Grupo:=wnProt.Arquivo;
              Fr_Principal.Nfe.DANFE.Protocolo:=wnProt.rCampo(tcStr,'nProt');
              Fr_Principal.Nfe.DANFE.MostraPreview := False;
              Fr_Principal.Nfe.DANFE.MostraStatus := False;
              Fr_Principal.Nfe.DANFE.ImprimirDANFEPDF();

              Lc_FilePDF := concat(Copy(Fr_Principal.Nfe.DANFE.ArquivoPDF,1,(Length(Fr_Principal.Nfe.DANFE.ArquivoPDF)-4)),'.xml');
              RenameFile(Lc_PathXMl + '\' +  Lc_FileXML,Lc_FilePDF);

            end;
          except
            ErroARquivo;
          end;
        End
        else
        Begin
          ErroARquivo;
        End;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
        Next;
      end;
      CloseFile(Lc_Arquivoerro);
      if FErro then
      Begin
        //Finaliza instr no ARquivo de Erro e FEcha o Arquivo
        Pc_Executar_Arquivo(Lc_caminhoErro);
      end;
      Gg_Progresso.Update;
    end;
  finally
    Lc_base.FinalizaQuery(Lc_Qr_NF);
    FreeAndNil(Lc_base);
    FreeAndNil(wnProt);
  end;


end;

procedure TFr_Imp_Notas.Pc_GeraLoteArquivoNFSe;
Var
  Lc_Qr_NF : TSTQuery;
  Lc_Tamanho : Integer;
  Lc_PathXMl,Lc_FileXML,Lc_FilePDF : String;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux : String;
  Lc_Cd_Vinculo : Integer;
  Lc_Base : TControllerBase;
  Lc_RetNFse : TControllerRetornoNFS;
  Lc_NFS_e: TACBrNFSeX;
  Lc_Dfe_NFSe: TACBrNFSeXDANFSeRL;
  procedure ErroArquivo;
  Begin
    if not FErro then
    Begin
      Lc_Aux := 'Ação a ser tomada: Solicite retorno destas Nota';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFS_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);
      FErro := True;
    End
    else
    Begin
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFS_NUMERO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);
    End;

  End;
Begin

  Try
    Lc_Base     := TControllerBase.create(nil);
    Lc_RetNFse  := TControllerRetornoNFS.create(Self);
    Lc_NFS_e    := TACBrNFSeX.create(Self);
    Lc_Dfe_NFSe := TACBrNFSeXDANFSeRL.create(Self);
    Lc_Dfe_NFSe.ACBrNFSe := LC_NFS_e;

    Lc_RetNFse.inicializa;
    Lc_RetNFse.Config.ConfiguraComponente(Lc_NFS_e,dm.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString);

    //Inicia VAriavel
    FErro := False;
    //Deleta Pasta
    if Trim(It_NameFolder) <> '' then
    Begin
      if DirectoryExists(GbPathExe + It_NameFolder) then
        Fc_deleteFolder(GbPathExe + It_NameFolder,false);

      //Criar Pasta
      if not DirectoryExists(GbPathExe + it_NameFolder) then
        ForceDirectories(GbPathExe + It_NameFolder);
    End;

    //Cria a Queri para a consulta de notas
    Lc_Qr_NF := Lc_Base.GeraQuery;
    with Lc_Qr_NF do
    Begin

      SQL.Add('SELECT NFL_CODIGO, NFL_DT_EMISSAO,  '+
              ' NFS_DATETIME,NFS_NUMERO, NFL_STATUS, NFS_ARQUIVO '+
              'FROM TB_NOTA_FISCAL Tb_nota_fiscal '+
              '  INNER JOIN TB_RETORNO_NFS '+
              '  ON (NFS_CODNFL = NFL_CODIGO) '+
              ' WHERE ( NFL_CODMHA =:NFL_CODMHA)'+
              '  AND  ( NFS_CODSIT = 4 ) '+
              '  AND  ( NFS_NUMERO <> '''') ');

      if ChBx_Periodo.Checked then
        SQL.Add(' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      SQL.Add(' ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');
      //Passagem de Paramentros
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      if ChBx_Periodo.Checked then
      Begin
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
      end;
      Active := true;
      FetchAll;
      First;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.Update;
      Lb_Processamento.Caption := 'Exportando Notas Fiscais de Serviço';
      Lb_Processamento.Update;
      Lc_PathXMl := GbPathExe + It_NameFolder;
      Fr_Principal.Nfe.DANFE.PathPDF := GbPathExe + It_NameFolder;
      //Arquivo do Log de Erros
      Lc_caminhoErro := GbPathExe + 'xml_nfse_nao_encontrado.txt';
      IF FileExists(Lc_caminhoErro)then
        DeleteFile(Lc_caminhoErro);
      AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
      Rewrite ( Lc_Arquivoerro);

      //Cabeçalho do Arquivo
      Lc_Aux := 'Verificar  as Notas Fiscais que estão com problemas';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      //Inicia a Exportao
      while not Lc_Qr_NF.Eof do
      Begin
        Lc_FileXML     := FieldByName('NFS_ARQUIVO').AsString;
        if (trim(Lc_FileXML) <> '') then
        Begin
          Lc_FileXML := gerarNomeArquivoNFSe(Lc_FileXML,'.xml');

          Lc_Cd_Vinculo := FieldByname('NFL_CODIGO').AsInteger;
          try
            Pc_Salva_Arq_Disco( 5,
                               'XML',
                               Lc_Cd_Vinculo,
                               Lc_PathXMl + '\' +  Lc_FileXML);
            //Carrrega a arquivo xml no Componenente
            if FileExists(Lc_PathXMl + '\' +  Lc_FileXML) then
            Begin
              Lc_NFS_e.NotasFiscais.Clear;
              Lc_NFS_e.NotasFiscais.LoadFromFile(Lc_PathXMl + '\' +  Lc_FileXML);
              Lc_NFS_e.Configuracoes.Arquivos.NomeLongoNFSe := True;
              Lc_NFS_e.DANFSe.MostraPreview := False;

              Lc_FilePDF := gerarNomeArquivoNFSe(Lc_FileXML,'.PDF');

              Lc_NFS_e.DANFSe.PathPDF := Concat(Lc_PathXMl ,'\' , Lc_FilePDF);
              Lc_NFS_e.NotasFiscais.ImprimirPDF;

            end;
          except
            ErroArquivo;
          end;
        End
        else
        Begin
          ErroArquivo;
        End;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
        Next;
      end;
      CloseFile(Lc_Arquivoerro);
      if FErro then
      Begin
        //Finaliza instruo no ARquivo de Erro e FEcha o Arquivo
        Pc_Executar_Arquivo(Lc_caminhoErro);
      end;
      Gg_Progresso.Update;
    end;
  finally
    Lc_Base.FinalizaQuery(Lc_Qr_NF);
    FreeAndNil(Lc_Base);
  end;

end;

procedure TFr_Imp_Notas.Pc_GerencialNFeSebrae(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TFrxReportGerencialNfeSebrae;
begin
  TRY
    Lc_Form := TFrxReportGerencialNfeSebrae.create(Self);
    Lc_Form.Parametros := getParametros;
    Lc_Form.Caption := 'RELATÓRIO NFE GERENCIAL - SEBRAE';
    Lc_Form.buscar;
    Lc_Form.Totalizadores;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Notas.Pc_GeraLoteArquivoNFCe;
Var
  Lc_Qr_NF : TSTQuery;
  Lc_Tamanho : Integer;
  Lc_PathXMl,Lc_FileXML : String;
  Lc_Arquivoerro:TextFile;
  Lc_caminhoErro:String;
  Lc_Aux : String;
  Lc_Base: TcontrollerBase;
  procedure ErroArquivo;
  Begin
    if not FErro then
    Begin
      Lc_Aux := 'Ação a ser tomada: Solicite retorno destas Nota';
      Writeln (Lc_Arquivoerro,Lc_Aux);        
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFC_CODIGO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);
      FErro := True;
    End
    else
    Begin
      Lc_Aux := Lc_Qr_NF.fieldbyname('NFC_CODIGO').AsString;
      Writeln (Lc_Arquivoerro,Lc_Aux);        
    End;  
  End;
Begin
  Try
    Lc_Base := TcontrollerBase.create(nil);
    Pc_CarregaDadosEmitente(False);
    Pc_FormataModeloNFCe;
    //Inicia VAriavel
    FErro := False;

    if Trim(It_NameFolder) <> '' then
    Begin
      //Deleta Pasta
      Fc_deleteFolder(GbPathExe + '\LoteNFC-e',false);
      Fc_deleteFolder(GbPathExe + It_NameFolder,false);

      //Criar Pasta
      if not DirectoryExists(GbPathExe + it_NameFolder) then
        ForceDirectories(GbPathExe + It_NameFolder);
    End;

    //Cria a Queri para a consulta de notas
    Lc_Qr_NF := Lc_Base.GeraQuery;
    with Lc_Qr_NF do
    Begin
      SQL.Add('SELECT DISTINCT   '+
              '   NFC_CODIGO,  '+
              '   NFC_ARQUIVO '+
              'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
              '  inner join TB_RETORNO_NFC tb_retorno_nfc '+
              '  ON (tb_retorno_nfc.NFC_CODNFL = tb_nota_fiscal.NFL_CODIGO) '+
              'WHERE (NFL_CODMHA =:NFL_CODMHA) AND NFC_CODSIT > 1 AND (NFL_MODELO = ''65'') ');

      IF ChBx_Periodo.Checked then
        SQL.Add(' and (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ');
      SQL.Add(' ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ');
      //Passagem de parametros
      ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
      IF ChBx_Periodo.Checked then
      Begin
        ParamByName('DATAINI').AsDate := E_Data_INI.Date;
        ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
      end;
      Active := true;
      FetchAll;
      First;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := Lc_Qr_NF.RecordCount;
      Gg_Progresso.Progress := 0;
      Gg_Progresso.Update;
      Lb_Processamento.Caption := 'Exportando Notas Fiscais - Modelo 65';
      Lb_Processamento.Update;
      Lc_PathXMl := GbPathExe + It_NameFolder;
      Fr_Principal.Nfe.DANFE.PathPDF := GbPathExe + It_NameFolder;
      //Arquivo do Log de Erros
      Lc_caminhoErro := GbPathExe + 'xml_nfce_nao_encontrado.txt';
      IF FileExists(Lc_caminhoErro)then
        DeleteFile(Lc_caminhoErro);
      AssignFile (Lc_Arquivoerro, Lc_caminhoErro );
      Rewrite ( Lc_Arquivoerro);
      //Cabeçalho do Arquivo
      Lc_Aux := 'Número da Nota Fiscal';
      Writeln (Lc_Arquivoerro,Lc_Aux);
      //Inicia a Exportação
      while not Eof do
      Begin
        Lc_Tamanho := length(FieldByName('NFC_ARQUIVO').AsString)-51;
        Lc_FileXML     := copy(FieldByName('NFC_ARQUIVO').AsString,Lc_Tamanho,length(FieldByName('NFC_ARQUIVO').AsString));
        if (trim(Lc_FileXML) <> '') then
        Begin
          Try
            Pc_Salva_Arq_Disco( 4,
                             'XML',
                             FieldByname('NFC_CODIGO').AsInteger ,
                             Lc_PathXMl + '\' +  Lc_FileXML
                             );
          except
            ErroArquivo;
          End;
        end
        else
        Begin
          ErroArquivo;
        end;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
        Next;
      end;
      CloseFile(Lc_Arquivoerro);
      if FErro then
      Begin
        //Finaliza instruo no ARquivo de Erro e FEcha o Arquivo
        Pc_Executar_Arquivo(Lc_caminhoErro);
      end;
    end;
  finally
    Lc_Base.FinalizaQuery(Lc_Qr_NF);
    FreeAndNil(Lc_Base);
  end;  
end;

procedure TFr_Imp_Notas.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;




procedure TFr_Imp_Notas.Pc_NotasAjustes(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf;
begin
  Try
    Lc_Form  := TRl_ReportNf.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 3;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'Notas Fiscais de Ajuste/Outras Operações';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Buscar;
        Fr_Excel.Pc_Excel(Qr_Consulta,Pc_CAminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Imp_Notas.Pc_NotasCompras(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf;
begin
  Try
    Lc_Form  := TRl_ReportNf.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 2;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'Notas Fiscais de Compra';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;



procedure TFr_Imp_Notas.Pc_NotasGeral(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf;
begin
  Try
    Lc_Form  := TRl_ReportNf.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 0;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'Notas Fiscais em Geral';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Notas.Pc_NotasGeralNFe(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNfe;
begin
  Try
    Lc_Form  := TRl_ReportNfe.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 0;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'Notas Fiscais em Geral - NF-e';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Notas.Pc_NotasVendasGeral(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf;
begin
  Try
    Lc_Form  := TRl_ReportNf.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 1;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'Notas Fiscais de Venda em Geral';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Notas.Pc_NotasVendasNFCe(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf65;
begin
  Try
    Lc_Form  := TRl_ReportNf65.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 1;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Imp_Notas.Pc_NotasVendasNFe(Pc_Operacao, Pc_Caminho: String);
Var
  Lc_Form : TRl_ReportNf55;
begin
  Try
    Lc_Form  := TRl_ReportNf55.Create(Self);
    with Lc_Form do
    Begin
      Lc_Form.Parametros := getParametros;
      Lc_Form.Parametros.TipoDocumento := 1;
      if Pc_Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Qr_Consulta,Pc_Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Imp_Notas.Pc_Resumo_CFOP(Pc_Operacao,Pc_Caminho:String);
Begin
  try
    If not Assigned(RL_Nota_Resum) then (Application.CreateForm(TRL_Nota_Resum, RL_Nota_Resum));
      RL_Nota_Resum.Qrpt.Preview;
  finally
      RL_Nota_Resum.Close;
  end;
end;


procedure TFr_Imp_Notas.SB_ImprimirClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_LimpaQrPreviweMemoria;
    case LBx_TipoRelatorio.ItemIndex of
      //Nota de Compras
      0:Pc_NotasCompras('I','');
      //Notas de Ajustes
      1:Pc_NotasAjustes('I','');
      //Notas de Vendas Geral
      2:Pc_NotasVendasGeral('I','');
      //Notas de Vendas NF-e
      3:Pc_NotasVendasNFe('I','');
      //Notas de Vendas NFC-e
      4:Pc_NotasVendasNFCe('I','');
      //Notas Geral
      5:Pc_NotasGeral('I','');
      //Nota Geral NFe
      6:Pc_NotasGeralNFe('I','');
      //RESUMO CFOP
      7:Pc_Resumo_CFOP('I','');
      //FORMATO CORDILHEIRA
      8:Pc_FormaCodilheira('I','');
      //LOTE NF-E
      9:Pc_LoteNFe('I','');
      //LOTE NFC-E
      10:Pc_LoteNFCe('I','');
      //LOTE NFE - TERCEIROS
      11:Pc_LoteNFeTerceiros('I','');
      12:Pc_GerencialNFeSebrae('I','');
    end;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;    
end;

procedure TFr_Imp_Notas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F2  : if Sb_Exportar.Enabled then Sb_ExportarClick(Sender);
      VK_F3  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Imp_Notas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(ZipSetes);
  Action:=caFree;
  Fr_Imp_Notas:=nil;
end;
   
procedure TFr_Imp_Notas.FormCreate(Sender: TObject);
begin
  ZipSetes := TSetesZip.create;
  ZipSetes.Progresso := GG_progresso;
  ZipSetes.FileProcessando := Lb_Processamento;
end;

procedure TFr_Imp_Notas.Sb_ExportarClick(Sender: TObject);
Var
  Lc_CAminho : String;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    if (LBx_TipoRelatorio.ItemIndex < 7 ) then
    Begin
      IF (Fr_Principal.SaveDialogo.Execute) then
      Begin
        if not Assigned(Fr_Excel) THEN Application.CreateForm(TFr_Excel, Fr_Excel);
        Fr_Excel.E_NomeArquivo.Text := Fr_Principal.SaveDialogo.FileName;
        Lc_CAminho := Fr_Principal.SaveDialogo.FileName;
        case LBx_TipoRelatorio.ItemIndex of
          //Nota de Compras
          0:Pc_NotasCompras('E',Lc_CAminho);
          //Notas de Ajustes
          1:Pc_NotasAjustes('E',LC_Caminho);
          //Notas de Vendas Geral
          2:Pc_NotasVendasGeral('E',Lc_CAminho);
          //Notas de Vendas NF-e
          3:Pc_NotasVendasNFe('E',Lc_CAminho);
          //Notas de Vendas NFC-e
          4:Pc_NotasVendasNFCe('E',Lc_CAminho);
          //Notas Geral
          5:Pc_NotasGeral('E',Lc_CAminho);
          //Nota Geral NFe
          6:Pc_NotasGeralNFe('E',Lc_CAminho);
          //RESUMO CFOP
          7:Pc_Resumo_CFOP('E',Lc_CAminho);
        end;

      End;
    End
    else
    Begin
      case LBx_TipoRelatorio.ItemIndex of
        //FORMATO CORDILHEIRA
        8:Pc_FormaCodilheira('E',Lc_CAminho);
        //LOTE NF-E
        9:Pc_LoteNFe('E',Lc_CAminho);
        //LOTE NFC-E
        10:Pc_LoteNFCe('E',Lc_CAminho);
        //LOTE NFC-E
        11:Pc_LoteNFeTerceiros('E',Lc_CAminho);
        //LOTE NFS-E
        13:Pc_LoteNFSe('E',Lc_CAminho);

      end;
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;

end;

procedure TFr_Imp_Notas.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
        DBLCB_Empresa.KeyValue := Null;
        E_BuscaCodigo.Clear;
        end;
      end;
end;


//LAYOUT DO REGISTRO HEADER
procedure TFr_Imp_Notas.Pc_HeaderNota;
Var
  Lc_Data:String;
Begin
  It_Linhas := 1;
  It_Dados_Arquivo := '0';                                                                  //TIPO DE REGISTRO 	9(001) 	001 a 001 	Tipo de Registro: 0 - Header 	0	Este campo deve conter apenas o número 0, que  o tipo de registro Header, que informa os dados iniciais para a importação do arquivo.
  Lc_data := DateToStr(Date);
  Lc_Data := StringReplace(Lc_Data,'/','',[rfReplaceAll, rfIgnoreCase]);
  It_Dados_Arquivo := It_Dados_Arquivo + Lc_Data;                                           //DATA DE GERAçõO 	9(008) 	002 a 009 	Data de geração do arquivo: DDMMAAAA 	30112007	Data da geração do arquivo, formato DDMMAAAA, não deve informar barras.  a data em que o arquivo foi gerado, não a data dos lanamentos.
  Pc_AtivaEstabelecimento;
  //Codigo do regime Tributario
  it_Cd_Crt := StrToIntdef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);
  
  It_Dados_Arquivo := It_Dados_Arquivo + fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString); // CNPJ EMPRESA 	    X(018) 	010 a 027 	CNPJ do estabelecimento (editado) 	12.345.678/0001-99	 o CNPJ da empresa para qual os dados serão importados.
  It_Dados_Arquivo := It_Dados_Arquivo + '0';                                               // OPCAO BASES 	    9(001) 	028 a 028 	Opção p/ cálc. bases imp/contribuições 	1	Este campo possibilita o cálculo automático das bases de cálculo de PIS, COFINS, CSLL e IRPJ, pode assumir os seguintes valores:
                                                                                            // 0 - O cálculo não  feito automaticamente pelo sistema, sendo os valores lidos das posições respectivas nos registros de lanamentos de notas fiscais, ou seja, deverá preencher os campos de bases de cálculo para os tributos PIS, COFINS, CSLL e IRPJ quando este for devido.
                                                                                            // 1 - O cálculo das bases  feito automaticamente pelo sistema, com base nos percentuais informados nos parmetros do mesmo, bem como nas incidncias constantes nos cadastros de natureza de operação. Se informar a opção 1, não será necessário o preenchimento de valores nos campos de bases de cálculo para PIS, COFINS, CSLL e IRPJ.
  It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                               // ORIGEM	          X(003)	029 a 031	  Campo reservado. Gravar brancos.	 	Preencher com brancos.
  It_Dados_Arquivo := It_Dados_Arquivo + '0';                                               // OPçõO RETENçõO	  X(001)	032 a 032	Opção para o cálculos das retenções
  It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',442);                             // BRANCOS 	        X(442) 	033 a 474	  Campo vazio. Gravar brancos. 	 	Preencher com brancos.
  It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',20);                              // USO DA EBS 	    X(020)	475 a 494 	Campo reservado. Gravar brancos. 	 	Preencher com brancos.
  It_Dados_Arquivo := It_Dados_Arquivo + StrZero(It_Linhas,6,0);                             // SEQUNCIA 	    9(006) 	495 a 500 	Número sequencial, igual a 000001 	000001	Dever iniciar com 000001, obrigatoriamente.
  Writeln(It_Arquivo,It_Dados_Arquivo);
end;

//LAYOUT DO REGISTRO DO EMITENTE/DESTINATRIO
procedure TFr_Imp_Notas.Pc_EmitenteDestinatarioNota(Pc_Tipo:String);
Var
  Lc_Qr_Emitente : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
Begin
  Lc_Qr_Emitente := TSTQuery.Create(Self);
  with Lc_Qr_Emitente do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    // Busca os dados do Remetente
    Close;
    SQL.Clear;
    Lc_SqlTxt := ' SELECT DISTINCT EMP_PESSOA, EMP_CNPJ, EMP_NOME, EMP_FANTASIA, END_ENDER, END_COMPLEM, '+
                  ' END_BAIRRO, END_CEP, CDD_DESCRICAO, UFE_SIGLA, EMP_INSC_EST, END_FONE,EMP_CONSUMIDOR, '+
                  ' END_PAIS,CDD_IBGE '+
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                  '  INNER JOIN TB_EMPRESA tb_empresa '+
                  '  ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                  '  INNER JOIN TB_PEDIDO tb_pedido  '+
                  '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '  INNER JOIN TB_ENDERECO tb_endereco  '+
                  '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
                  '  INNER JOIN TB_CIDADE tb_cidade '+
                  '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
                  '  INNER JOIN TB_UF tb_uf '+
                  '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                  ' WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
                  ' AND   (NFL_NUMERO <> '''' ) '+
                  ' AND   (NFL_NUMERO <> ''0'' ) '+
                  ' AND   (NFL_CODMHA =:NFL_CODMHA) ';
    if Pc_Tipo = 'S' then
      Lc_SqlTxt := Lc_SqlTxt +  ' AND   (NFL_TIPO LIKE ''S%'') '
    else
      Lc_SqlTxt := Lc_SqlTxt +  ' AND   (NFL_TIPO LIKE ''E%'') ';


    SQL.Add(Lc_SqlTxt);
    ParamByName('DATAINI').AsDate := E_Data_INI.Date;
    ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Open;
    FetchAll;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := RecordCount;
    Gg_Progresso.Update;
    First;
    RecordCount;
    while not Eof do
      begin
      It_Dados_Arquivo := '4';                                                  //  TIPO DE REGISTRO 	9(001) 	001 a 001 	Tipo de Registro: 4 - Emitente/Destinatário
      Lc_Cnpj := FieldByName('EMP_CNPJ').AsString;
      IF (FieldByName('END_PAIS').AsInteger = 1058 ) then                       //  CNPJ/CPF 	  X(018) 	002 a 019 	Número do CNPJ ou CPF (editado).
        Begin
        if Length(Lc_Cnpj) = 11 then
          Lc_Cnpj := fc_MascaraCPF(Lc_Cnpj)
        else
          Lc_Cnpj := fc_MascaraCNPJ(Lc_Cnpj);
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(Lc_Cnpj,18);
        end
      else
        Begin
        if (FieldByName('EMP_CONSUMIDOR').AsString = 'S') then
          It_Dados_Arquivo := It_Dados_Arquivo + '999.999.999-99    '
        else
          It_Dados_Arquivo := It_Dados_Arquivo + 'AA.AAA.AAA-AAAAA-00';
        end;

      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('EMP_NOME').AsString,40);                //  RAZÃO 	    X(040) 	020 a 059 	Razão social
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('EMP_FANTASIA').AsString,20);            //  FANTASIA 	  X(020) 	060 a 079 	Fantasia
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('UFE_SIGLA').AsString,2);                //  ESTADO 	    X(002) 	080 a 081 	Estado
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('EMP_INSC_EST').AsString,20);            //  INSCRIçõO 	X(020) 	082 a 101 	Número da inscrição estadual
      if trim(FieldByName('END_COMPLEM').AsString) <> '' then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('END_ENDER').AsString + ' - '+
                                                             FieldByName('END_COMPLEM').AsString, 40)             //  ENDEREÇO 	  X(040) 	102 a 141 	Descrição do endereão
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('END_ENDER').AsString, 40);              //  ENDEREÇO 	  X(040) 	102 a 141 	Descrição do endereão
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('END_BAIRRO').AsString,20);                //  BAIRRO 	    X(020) 	142 a 161 	Bairro do endereão
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('CDD_DESCRICAO').AsString,20);             //  CIDADE 	    X(020) 	162 a 181 	Cidade do endereão
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByName('END_CEP').AsString,8);                      //  CEP 	      9(008) 	182 a 189 	Número do CEP
      It_Dados_Arquivo := It_Dados_Arquivo + '0000';                                                              //  MUNICPIO 	9(004) 	190 a 193 	Cdigo do municpio 	7459	Informar o Cdigo do Municpio apenas com números.
      if Length(FieldByName('END_FONE').AsString) > 10 then
        begin
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(COPY(FieldByName('END_FONE').AsString,1,2),3);         // DDD telefone        194 a 196
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(COPY(FieldByName('END_FONE').AsString,3,8),10);        // Número Telefone     197 a 206
        end
      else
        begin
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',3);                                               // DDD Telefone       194 a 196
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',10);                                              // FONE               197 a 206
        end;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',6);                                                 // CONTA CLIENTE 	        9(006) 	207 a 212 	Conta para int. contbil/cliente
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                                               // HISTRICO CLIENTE 	    9(003) 	213 a 215 	Histrico para int. contbil se cliente
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',6);                                               // CONTA FORNEC. 	        9(006) 	216 a 221 	Conta para int. contbil/fornecedor
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                                               // HISTRICO FORNEC. 	    9(003) 	222 a 224 	Histrico para int. contbil/fornecedor
      It_Dados_Arquivo := It_Dados_Arquivo + 'N';                                                               // PRODUTOR	              X(001)	225 a 225	  Produtor rural (S/N).
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',18);                                              // IDENTIFICAçõO EXTERIOR 	X(018)	226 a 243 	Identificação para destinatários do exterior. Estado = 'EX'.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                               // NUMERO 	                X(05) 	244 a 248 	Campo vazio. Gravar brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(FieldByName('END_COMPLEM').AsString, 20 );               // COMPLEMENTO           	X(020)  249 a 268	Número do Bloco, Apartamento, Sala, etc.
                                                                                                                // Informar o cdigo do Suframa completando com zeros ou brancos os espaos restantes. http://www.suframa.gov.br/
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',9);                                               // SUFRAMA 	      X(009)	269 a 277
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('1058',5);                                           // CDIGO DO PAIS 	X(005)	278 a 282
      It_Dados_Arquivo := It_Dados_Arquivo + '1';                                                               // Natureza Juridica 283
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByName('CDD_IBGE').AsString,7);                   // MUNICPIO IBGE	X(007)	284 a 290 	Gravar o cdigo de 7 dgitos do IBGE	4106902	Cdigo de 7 dgitos do IBGE (Concla).
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',199);                                             //  BRANCOS	      X(199)	291 a 489	Campo vazio gravar brancos	 	Gravar Brancos
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                               //  USO DA EBS 	  X(005)	490 a 494 	Campo reservado. Gravar brancos.
      Inc(It_Linhas);
      It_Dados_Arquivo := It_Dados_Arquivo + StrZero(It_Linhas,6,0);                                            //  NR REGISTRO 	9(006) 	495 a 500 	Número sequencial do registro
      Writeln(It_Arquivo,It_Dados_Arquivo);
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Gg_Progresso.Update;
      Next;
      end;
    end;
  Lc_Qr_Emitente.Close;
  FreeAndNil(Lc_Qr_Emitente);
end;

procedure TFr_Imp_Notas.Pc_FormaCodilheira(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Este formato somente pra exportação! '+EOLN,
                  ['OK'],[bEscape,bNormal],mpConfirmacao)
  End
  else
  Begin
    PC_Cord_ITem;
    Pc_Cord_Nota_Ent;
    Pc_Cord_Nota_Sai;
  End;
end;

//LAYOUT DO REGISTRO DE NOTAS FISCAIS
procedure TFr_Imp_Notas.Pc_NotaFiscaisNotaSai;
Var
  Lc_Qr_Notas : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
  lcc_TotalNF : Real;
  Lc_Valor : Real;
Begin
  Lc_Qr_Notas := TSTQuery.Create(Self);
  with Lc_Qr_Notas do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;


    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT '+
                  '   NFL_NUMERO, '+
                  '   NFL_CODIGO, '+
                  '   NFL_SERIE, '+
                  '   NFL_DT_EMISSAO, '+
                  '   NFL_VL_TL_NOTA,  '+
                  '   NFL_BS_ICMS, '+
                  '   NFL_VL_ICMS,  '+
                  '   NFL_BS_ICMS_SUBST,'+
                  '   NFL_VL_ICMS_SUBST,'+
                  '   NFL_VL_IPI, '+
                  '   NFL_CTA_FRETE, '+
                  '   PED_PRAZO,  '+
                  '   NAT_CFOP,  '+
                  '   PED_VL_DESCONTO, '+
                  '   NFL_VL_SEGURO,  '+
                  '   NFL_PESO_BRUTO, '+
                  '   NFL_PESO_LIQ,  '+
                  '   NFL_QT_PRODUTO,  '+
                  '   NFL_VL_FRETE,  '+
                  '   NFL_VL_DESP_ACESS,  '+
                  '   tb_transportadora.EMP_CNPJ AS TRP_CNPJ, '+
                  '   NFL_ESPECIE,  '+
                  '   tb_empresa2.emp_cnpj as cnpj2  '+
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal  '+
                  '  INNER JOIN TB_PEDIDO tb_pedido  '+
                  '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '  INNER JOIN TB_NATUREZA tb_natureza  '+
                  '  ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)  '+
                  '  LEFT OUTER JOIN TB_EMPRESA tb_transportadora   '+
                  '  ON (tb_transportadora.EMP_CODIGO = tb_nota_fiscal.NFL_CODTRP)'+
                  '  INNER JOIN TB_EMPRESA tb_empresa2   '+
                  '  ON (tb_empresa2.EMP_CODIGO = tb_nota_fiscal.nfl_codemp)  '+
                  'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)  '+
                  ' AND   (NFL_NUMERO <> '''' ) '+
                  ' AND   (NFL_TIPO  LIKE ''S%'' ) '+
                  ' AND   (NFL_CODMHA =:NFL_CODMHA)  '+
                  'ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('DATAINI').AsDate := E_Data_INI.Date;
    ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := RecordCount;
    Gg_Progresso.Update;
    First;
    while not Eof do
      Begin
      It_Dados_Arquivo := '1';                                                                              //  TIPO DE REGISTRO 	9(001) 	001 a 001 	Tipo de Registro: 1 - Notas Fiscais
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,'/','',[rfReplaceAll, rfIgnoreCase]);  //  DATA LCTO 	        9(008) 	002 a 009 	Data do lanamento formato DDMMAAAA
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NFL_NUMERO').AsString,6);             //  NMERO INICIAL 	    9(006) 	010 a 015 	Número do documento inicial
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NFL_NUMERO').AsString,6);             //  NMERO FINAL 	      9(006) 	016 a 021 	Número do documento final
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,'/','',[rfReplaceAll, rfIgnoreCase]);  //  DATA DCTO 	        9(008) 	022 a 029 	Data de emissão no formato DDMMAAAA.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                                           //  BRANCOS	            X(003) 	030 a 032 	Campo vazio. Gravar brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + '55';                                                          //  MODELO 	            9(002) 	033 a 034 	Cdigo de modelos de notas definidos para o SINTEGRA.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NFL_SERIE').AsString,3);              //  SRIE 	            X(003) 	035 a 037 	Srie da nota fiscal
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                                           //  SUB-SRIE 	        X(003) 	038 a 040 	Sub-sórie da nota fiscal
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NAT_CFOP').AsString,4);               //  NATUREZA 	          9(004) 	041 a 044	  Natureza da operação (CFOP)
      It_Dados_Arquivo := It_Dados_Arquivo + '01';                                                          //  VARIAçõO	          9(002)	045 a 046	  Variação de incidncia da natureza. (Padrão 01)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',2);                                             //  CLASSIFICAçõO 1     9(002) 	047 a 048	  classificação 1 para integração contbil
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',2);                                             //  CLASSIFICAçõO 2     9(002) 	049 a 050	  classificação 2 para integração contbil
      Lc_Cnpj := FieldByname('CNPJ2').AsString;
      if Length(Lc_Cnpj) > 11 then
        Lc_Cnpj := fc_MascaraCNPJ(Lc_Cnpj)
      else
        Lc_Cnpj := fc_MascaraCPF(Lc_Cnpj);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(Lc_Cnpj,18);                                     //  CNPJ/CPF DESTINAT. 	X(018) 	051 a 068	CNPJ ou CPF do destinatário (editado)

      // VALOR CONTBIL
      // Deve informar apenas números, sendo q os 2 ltimos registros se referem as casas decimais. Ex.: 205540 refere-se ao vlr de 2.055,40. Não informar pontos ou vrgulas
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(FieldByname('NFL_VL_TL_NOTA').AsCurrency,10,2);       //  VALOR CONTBIL 	    9(010)V99 	069 a 080	Valor contbil da nota
      lcc_TotalNF := lcc_TotalNF + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      Lc_Valor := 0;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE PIS 	        9(010)V99 	081 a 092	Base de cálculo do PIS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE COFINS 	      9(010)V99 	093 a 104	Base de cálculo do COFINS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE CSLL 	        9(010)V99 	105 a 116	Base de cálculo de CONTRIBUIçõO SOCIAL
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE IRPJ	        9(010)V99 	117 a 128	Base de cálculo de IRPJ (Merc/Servios)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',8);                              //  BRANCOS 	          X(008) 	    129 a 136	Campo reservado (gravar brancos)
      Lc_Valor := FieldByName('NFL_BS_ICMS').AsCurrency;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ICMS A 	      9(010)V99 	137 a 148	Base de cálculo do ICMS (base A)
      Lc_Valor := (FieldByName('NFL_VL_ICMS').AsCurrency / FieldByName('NFL_BS_ICMS').AsCurrency) *100;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);    //  ALQUOTA ICMS A 	  9(002)V99 	149 a 152	Alquota de tributação do ICMS (base A)
      //Lc_Valor := FieldByName('NFL_VL_ICMS').AsFloat;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR ICMS A	      9(010)V99   153 a 164	Valor do crdito do ICMS (base A)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ICMS B 	      9(010)V99 	165 a 176	Base de cálculo do ICMS (base B)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);    //  ALQUOTA ICMS B 	  9(002)V99 	177 a 180	Alquota de tributação do ICMS (base B)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR ICMS B 	    9(010)V99 	181 a 192	Valor do crdito do ICMS (base B)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ICMS C 	      9(010)V99 	193 a 204	Base de cálculo do ICMS (base C)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);    //  ALIQUOTA ICMS C 	  9(002)V99 	205 a 208	Alquota de tributação do ICMS (base C)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR ICMS C 	    9(010)V99 	209 a 220	Valor do crdito do ICMS (base C)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ICMS D 	      9(010)V99 	221 a 232	Base de cálculo do ICMS (base D)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);    //  ALIQUOTA ICMS D 	  9(002)V99 	233 a 236	Alquota de tributação do ICMS (base D)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR ICMS D 	    9(010)V99 	237 a 248	Valor do crdito do ICMS (base D)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  ISENTAS ICMS 	    9(010)V99 	249 a 260	Valor de isentas de ICMS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  OUTRAS ICMS 	      9(010)V99 	261 a 272	Valor de outras de ICMS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE IPI 	        9(010)V99 	273 a 284	Base de cálculo do IPI
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR IPI 	        9(010)V99 	285 a 296	Valor do crdito do IPI
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  ISENTAS IPI 	      9(010)V99 	297 a 308	Valor de isentas de IPI
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  OUTRAS IPI 	      9(010)V99 	309 a 320	Valor de outras de IPI
      //Lc_Valor := FieldByName('NFL_VL_ICMS').AsFloat;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  MERCADORIAS ST 	  9(010)V99 	321 a 332	Valor de mercadorias com sub. tributria
      //Lc_Valor := FieldByName('NFL_BS_ICMS_SUBST').AsFloat;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ST 	          9(010)V99 	333 a 344	Base de cálculo da sub. tributria
      //Lc_Valor := FieldByName('NFL_VL_ICMS_SUBST').AsFloat;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  ICMS ST 	          9(010)V99 	345 a 356	ICMS retido por sub. tributria
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  DIFERIDAS 	        9(010)V99 	357 a 368	Valor de mercadorias diferidas
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  BASE ISS 	        9(010)V99 	369 a 380	Base de cálculo de ISS (valor dos servios)
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);    //  ALQUOTA ISS 	    9(002)V99 	381 a 384	Alquota de tributação de ISS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  VALOR ISS 	        9(010)V99 	385 a 396	Valor de ISS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  ISENTAS ISS 	      9(010)V99 	397 a 408	Valores da nota isentos de ISS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);   //  IRRF RETIDO	      9(010)V99 	409 a 420	Valor do IRRF retido
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',50);                             //  OBSERVAçõES 	      X(050) 	    421 a 470	Observaçõoervações a gerar no livro fiscal
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('NFE',5);                           //  ESPCIE 	          X(005) 	    471 a 475	Espcie do documento
      It_Dados_Arquivo := It_Dados_Arquivo + 'N';                                              //  VENDA A VISTA 	    X(001) 	    476 a 476	S = venda a vista e "N" = venda a prazo
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',4);                                //  NAT. OPERAçõO ST	   9(004)	    477 a 480	Natureza de operação para Sub. Tributria.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,6,2);    //  BASE PIS/COFINS ST  9(006)V99 	481 a 488	Base de PIS/COFINS por Sub. Tributria
      It_Dados_Arquivo := It_Dados_Arquivo + IntToStr(FieldByName('NFL_CTA_FRETE').AsInteger);              // MODALIDADE DO FRETE	 9(001)	    489 a 489	0 - sem frete 1 - CIF 2 - FOB
      // Informar alor do PIS Retido nas entradas de servios. Caso não exista informação, preencher com zeros
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);                //  PIS RETIDO	        9(010)V99	490 a 501	Valor do PIS retido
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);                //  COFINS RETIDO	      9(010)V99	502 a 513	Valor do COFINS retido
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);                //  CSLL RETIDO	        9(010)V99	514 a 525	Valor do CSLL retido
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,'/','',[rfReplaceAll, rfIgnoreCase]);  //  DATA DE RECEBIMENTO 9(008)	    526 a 533	Data de recebimento da nota fiscal, no formato DDMMAAAA
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,4,0);                        //  OPERAçõO CONTBIL 	9(004)	    534 a 537	Cdigo da operação contbil (opcional).
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);                       //  MATERIAIS	          9(010)V99	  538 a 549 	Valor de Materiais na prestação de servios
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);                       //  SUBEMPREITADA	      9(010)V99	  550 a 561 	Valor de Subempreitada na prestação de servios
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,4,0);                        //  CDIGO SERVIO 	    9(004)	    562 a 565 	Cdigo do item de servião
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,6,0);                        //  CLIFOR	            9(006)	    566 a 571 	Campo reservado para clientes FOX.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',18);                                          //  IDENT. EXTERIOR 	  X(018)      572 a 589	Identificação para destinatários do exterior. Estado = 'EX'.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                           //  USO DA EBS 	        X(005) 	    590 a 594	Campo reservado Gravar brancos.
      Inc(It_Linhas);
      It_Dados_Arquivo := It_Dados_Arquivo + StrZero(It_Linhas,6,0);                                        //  SEQUNCIA 	        9(006) 	  595 a 600	Número sequencial, iniciando em 000002
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('0',9);                                              //NMERO DA NOTA INICIAL 2 	9(009) 	601 a 609	Número da Nota Inicial	317584574	Quando informado valor neste campo, será desconsiderado o valor informado no campo Número da nota inicial (posição 10).
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('0',9);                                              //NMERO DA NOTA FINAL   2 	9(009) 	610 a 618	Número da Nota Final	317584574	Quando informado valor neste campo, será desconsiderado o valor informado no campo Número da nota final (posição 16).
      Writeln(It_Arquivo,It_Dados_Arquivo);
      //LAYOUT DO REGISTRO DE PRODUTOS
      Pc_ProdutosNota(FieldByName('NFL_CODIGO').AsInteger);
      Next;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Gg_Progresso.Update;
      end;
    end;
  Lc_Qr_Notas.Close;
  FreeAndNil(Lc_Qr_Notas);
end;

//LAYOUT DO REGISTRO DE PRODUTOS
procedure TFr_Imp_Notas.Pc_ProdutosNota(Pc_Cd_Nota:Integer);
Var
  Lc_Qr_Itens : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
  lcc_TotalNF : Real;
  Lc_Valor : Real;
Begin
  Lc_Qr_Itens := TSTQuery.Create(Self);
  with Lc_Qr_Itens do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Close;
    SQL.Clear;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt :='SELECT DISTINCT EMP_PESSOA, EMP_CNPJ, NAT_CFOP, ''01'' NFL_MODELO, NFL_SERIE,ICM_VL_BC_NR, '+
                'NFL_NUMERO,PRO_DESCRICAO, MED_ABREVIATURA, NAT_CFOP,ITF_CODIGO, ITF_CODPRO, ITF_QTDE, '+
                '(ITF_QTDE * ITF_VL_UNIT) ITF_VL_PRODUTO, ITF_VL_DESC,PRO_CODIGOFAB,pRO_CODIGO, '+
                '(IPI_VL_BC * (IPI_AQ_NR/100)) IPI_VL_IPI,IPI_VL_BC,IPI_AQ_NR, ICM_VL_BC_ST, IPI_AQ_NR, '+
                '  ICM_AQ_RD_NR,PIS_VL_BC,PIS_AQ_NR,PIS_VL_NR,CFS_VL_BC,CFS_AQ_NR,CFS_VL_NR, '+
                '  ICM_VL_ST,ICM_AQ_ST,ICM_VL_NR,ICM_AQ_NR '+
                'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                '   INNER JOIN TB_NATUREZA tb_natureza '+
                '   ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT) '+
                '   INNER JOIN TB_PEDIDO tb_pedido '+
                '   ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                '   INNER JOIN TB_EMPRESA tb_empresa '+
                '   ON (tb_empresa.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) '+
                '   INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                '   ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO ) '+
                '   LEFT OUTER JOIN TB_ITENS_ICMS tb_itens_icms '+
                '   ON (tb_itens_icms.ICM_CODITF = tb_itens_nfl.ITF_CODIGO )  '+
                '   LEFT OUTER JOIN TB_ITENS_IPI tb_itens_ipi '+
                '   ON (tb_itens_ipi.IPI_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
                '   LEFT OUTER JOIN TB_ITENS_PIS tb_itens_pis '+
                '   ON (tb_itens_pis.PIS_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
                '   LEFT OUTER JOIN TB_ITENS_CFS tb_itens_cfs '+
                '   ON (tb_itens_cfs.CFS_CODITF = tb_itens_nfl.ITF_CODIGO ) '+
                '   INNER JOIN TB_PRODUTO tb_produto '+
                '   ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                '   INNER JOIN TB_MEDIDA tb_medida '+
                '   ON (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
                'WHERE (NFL_CODMHA =:NFL_CODMHA) '+
                '  AND (ITF_CODNFL =:NFL_CODIGO) '+
                'ORDER BY NFL_CODIGO, ITF_CODIGO ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    ParamByName('NFL_CODIGO').AsInteger := Pc_Cd_Nota;
    Active := true;
    FetchAll;
    First;
    while not Eof do
      Begin
      It_Dados_Arquivo := '2';                                                                                              // TIPO DE REGISTRO  9(001)	    001 a 001	Tipo de Registro: 2 - Itens
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FIELDBYNAME('ITF_CODPRO').AsString,10);                            // CODIGO 	         9(010)	    002 a 011	Cdigo do item
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(FIELDBYNAME('ITF_QTDE').AsFloat,6,3);          // QUANTIDADE-1 	   9(006)V999	012 a 020	Quantidade a importar (vide Observações);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ITF_VL_PRODUTO').AsCurrency,10,2);   // VALOR	           9(010)V99	021 a 032	Valor total deste item	205540
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,3);                                       // QUANTIDADE-2	     9(010)V999	033 a 045
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ITF_VL_DESC').AsCurrency,10,2);      // DESCONTO	         9(010)V99	046 a 057	Valor total desconto
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_VL_BC_NR').Value,10,2);       // BASE ICMS         9(010)V99  058 a 069
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_AQ_NR').Value,3,2);           // ALIQUOTA ICMS	   9(003)V99	070 a 074	Alquota de tributação do icms	01800	Informar neste campo a alquota de ICMS para o item informado no lanamento. Este campo  obrigatário quando houver informação nos campos 058 a 069. Quando não houver informação, preencher com zeros.
      if not (Fieldbyname('IPI_VL_IPI').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('IPI_VL_IPI').Value ,10,2)       // VALOR IPI	9(010)V99	075 a 086	Valor do IPI deste item
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0 ,10,2);
      If not (Fieldbyname('ICM_VL_BC_ST').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_VL_BC_ST').Value,10,2)      // BASE ICMS ST	9(010)V99	087 a 098	Base de cálculo do icms de sub.tributria
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);
      If not (Fieldbyname('IPI_AQ_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('IPI_AQ_NR').Value,3,2)          // ALQUOTA DE IPI	9(003)V99	099 a 103	Alquota de IPI do item
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,3,2);

      If not (Fieldbyname('ICM_AQ_RD_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_AQ_RD_NR').Value,3,2)       // PPERC.RED.ICMS	9(003)V99	104 a 108	Percentual de redução da base de ICMS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,3,2);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('000' ,3);                                                       // SITUAçõO TRIBUTRIA	9(003)	109 a 111	Situação tributria do item
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(Fieldbyname('PRO_CODIGOFAB').AsString,15);                       // IDENTIFICAçõO	X(015)	112 a 126 	Cdigo alfanumrico do item
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('000' ,3);                                                       // SITUAçõO TRIBUTRIA IPI	9(003)	127 a 129	Situação Tributria do IPI
      If not (Fieldbyname('IPI_VL_BC').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('IPI_VL_BC').Value,10,2)         // BASE DE IPI	9(010)V99	130 a 141	Base de cálculo do IPI
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('00', 2);                                                          // SITUAçõO TRIBUTRIA PIS	9(002)	142 a 143	Situação Tributria do PIS

      If not (Fieldbyname('PIS_VL_BC').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('PIS_VL_BC').Value,10,2)         // BASE DE PIS	9(010)V99	144 a 155	Base de cálculo de PIS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);

      If not (Fieldbyname('PIS_AQ_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('PIS_AQ_NR').Value,3,4)          // ALQUOTA DE PIS (%)	9(003)V9999	156 a 162	Alquota de PIS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,3,4);

      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,3);                                       // QUANTIDADE DE BASE DE PIS	9(010)V999	163 a 175	Quantidade de base de PIS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,4);                                       // ALQUOTA DE PIS (R$)	9(010)V9999	176 a 189	Valor de PIS pr-determinado
      If not (Fieldbyname('PIS_VL_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('PIS_VL_NR').Value,10,2)         // VALOR DE PIS	9(010)V99	190 a 201	Valor de PIS deste item
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('00', 2);                                                          // SITUAçõO TRIBUTRIA COFINS	9(002)	202 a 203	Situação Tributria de COFINS
      If not (Fieldbyname('CFS_VL_BC').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('CFS_VL_BC').Value,10,2)         // BASE DE COFINS	9(010)V99	204 a 215	Base de cálculo de COFINS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);

      If not (Fieldbyname('CFS_AQ_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('CFS_AQ_NR').Value,3,4)          // ALQUOTA DE COFINS (%)	9(003)V9999	216 a 222	Alquota de COFINS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,3,4);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,3);                                       // QUANTIDADE DE BASE DE COFINS	9(010)V999	223 a 235	Quantidade de base de COFINS
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,4);                                       // ALQUOTA DE COFINS (R$)	    9(010)V9999	236 a 249	Valor de COFINS pr-determinado
      If not (Fieldbyname('CFS_VL_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('CFS_VL_NR').Value,10,2)         // VALOR DE COFINS	9(010)V99	250 a 261	Valor de COFINS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);
      If not (Fieldbyname('ICM_VL_ST').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_VL_ST').Value,10,2)        // VALOR ICMS ST	    9(010)V99	262 a 273	Valor de ICMS por Situação Tributria
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);

      If not (Fieldbyname('ICM_AQ_ST').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_AQ_ST').Value,3,2)         // ALQUOTA DE ICMS ST	9(003)V99	274 a 278	Alquota de ICMS ST
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,3,2);
      If not (Fieldbyname('ICM_VL_NR').Value = null) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Fieldbyname('ICM_VL_NR').Value,10,2)        // VALOR ICMS	9(10) V99	279 a 290	Valor do ICMS
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,10,2);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(Fieldbyname('NAT_CFOP').AsString, 4);                             // NATUREZA DO ITEM	9(004)	291 a 294	CFOP do Item
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(Fieldbyname('MED_ABREVIATURA').AsString,6);                     // UNIDADE	X(006)	295 a 300	Unidade de medida
      It_Dados_Arquivo := It_Dados_Arquivo + '0000';                                                                       // CDIGO DE SERVIO TELECOM	9(004)	301 a 304	Classificação do servião de comunicação/telecomunicação
      It_Dados_Arquivo := It_Dados_Arquivo + '0';                                                                          // TIPO DE RECEITA TELECOM	9(001)	305 a 305	Classificação do servião de comunicação/telecomunicação
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',184);                                                        // BRANCOS 	X(184) 	306 a 489	Campo vazio. Gravar brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                                          // USO DA EBS 	X(005)	490 a 494	Campo reservado. Gravar brancos.
      Inc(It_Linhas);
      It_Dados_Arquivo := It_Dados_Arquivo + StrZero(It_Linhas,6,0);                                                       // SEQUNCIA 	9(006)	495 a 500	Número sequencial do registro
      Writeln(It_Arquivo,It_Dados_Arquivo);
      Next;
      end;
    end;
  Lc_Qr_Itens.Close;
  FreeAndNil(Lc_Qr_Itens);
end;

//LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE SADA
procedure TFr_Imp_Notas.Pc_DadosComplemetaresNotaSai;
Begin
//TIPO DE REGISTRO 	            9(001) 	    001 a 001 - Tipo de Registro: 5 - Dados complementares	5
//VALOR MERCADORIAS	            9(010)V99 	002 a 013 - Valor total das mercadorias	000000205540	Valor total das mercadorias. Em geral, corresponde ao valor total da nota fiscal. Se não houver informação, preencher com zeros.
//DESCONTO	                    9(010)V99 	014 a 025 - Valor total desconto	000000000000	Informar o valor do desconto se houver informação na nota fiscal. Caso não exista informação, preencher com zeros.
//FRETE	                        9(010)V99 	026 a 037 - Valor do Frete	000000000000	Informar o valor do frete se houver informação na nota fiscal. Caso não exista informação, preencher com zeros.
//DESPESAS	                    9(010)V99 	038 a 049 - Valor das despesas acessrias 	000000000000	Informar o valor das despesas acessrias, se houver informação na nota fiscal. Caso não exista, preencher com zeros.
//SEGURO	                      9(010)V99 	050 a 061	- Valor do seguro	000000000000	Informar o valor do seguro se houver informação na nota fiscal. Caso não exista, preencher com zeros.
//PESO BRUTO	                  9(006)V99 	062 a 069	- Peso Bruto	00000000	Informar o Peso Bruto da Mercadoria se houver informação na nota fiscal. Caso não exista, preencher com zeros.
//PESO LQUIDO	                9(006)V99 	070 a 077	- Peso Lquido	00000000	Informar o Peso Lquido da Mercadoria se houver informação na nota fiscal. Caso não exista, preencher com zeros.
//CNPJ/CPF TRANSPORTADOR	      X(018)	    078 a 095	- CNPJ ou CPF do transportador (editado) 	45.678.901/0001-23	Informar o CNPJ ou CPF do transportador informado na nota fiscal. Caso não exista, preencher com zeros.
//MEIO DE TRANSPORTE	          9(001)	    096 a 096	- Meio de transporte conforme observações abaixo	5	Informar o meio de transporte da mercadoria da Nota Fiscal (verificar observações abaixo). Se não houver informação, preencher com zeros.
//PLACA	                        X(015)	    097 a 111 - Placa do veculo transportador 	ABC1234	Informar a placa do veculo transportador informado na Nota Fiscal. Preencher sem traos e completar com espaos em branco a direita. Caso não exista informação, preencher com brancos. Esta informação  utilizada na geração de arquivo para o SINCO (Sistema Integrado de Coleta).
//VOLUMES	                      9(006)	    112 a 117	- Quantidade de volumes	000000	Informar a quantidade de volumes conforme Nota Fiscal. Caso não exista informação, preencher com zeros.
//ESPCIE	                      X(010)	    118 a 127	- Espcie dos volumes	 	Informar a espcie dos volumes informados na Nota Fiscal (caixa, pacote, etc.). Caso não exista informação, preencher com brancos.
//CHAVE NFe	                    X(044)	    128 a 171	- Chave da nota fiscal eletrnica	 	Informar a chave da nota fiscal eletrnica ou do conhecimento de transporte eletrnico.
//ICMS-ST RETIDO ANTEC.         X(001)	    172 a 172	- ICMS-ST já recolhido antecipadamento	S	Informar S (sim) ou N (não). Utilizado para indicar quando o ICMS ST foi recolhido antecipadamente, em GNRE, quando da sada da mercadoria.
//INSCRIçõO ESTADUAL REMETENTE	X(020)	    173 a 192	- Inscrição Estadual do Remetente	9014205990	Pode ser utilizado em conjunto com o CNPJ, para identificar o remetente da nota fiscal, quando h cadastro de emitente/destinatário com o mesmo CNPJ porm com Inscrição Estadual diferente.
//VALOR DO ICMS ANTEC. PARCIAL	9(012)	    193 a 204	- Valor do ICMS de Antecipação Parcial	 	Informar o valor do ICMS de Antecipação Parcial, correspondente aos CFOP 2.102, 2.113, 2.117, 2.118, 2.121, 2152, 2.403, 2409. Campo especfico para os estabelecimentos situados na Bahia, São Paulo e Maranhão.
//VALOR DO DIF. DE ALQ	        9(012)	    205 a 216	- Valor do Diferencial de Alquota	 	Para os estabelecimentos situados no na Bahia, São Paulo e Maranhão, informar o valor do Diferencial de Alquota correspondente aos CFOP 2.406, 2.407, 2.551, 2.552, 2.556 e 2.557.
//VALOR DO DIF. DE ALQ CRDITO	9(012)	    217 a 228	- Valor  de crdito correspondente ao Diferencial de Alquota 	 	Campo especfico para estabelecimentos situados no Estado de São Paulo. Informar o valor de crdito do diferencial de alquota correspondente aos CFOP 2101, 2102, 2111, 2113, 2116, 2117, 2118, 2120, 2121, 2122, 2126, 2251, 2252, 2253, 2254, 2255, 2256, 2257, 2301, 2302, 2303, 2304, 2305, 2306, 2351, 2352, 2353, 2354, 2355, 2356, 2401, 2403, 2406, 2407, 2551, 2552, 2556, 2557, 2651, 2652 e 2653.
//VALOR DO DIF. DE ALQ DBITO	9(012)	    229 a 240	- Valor  de dbito correspondente ao Diferencial de Alquota 	 	Campo especfico para estabelecimentos situados no Estado de São Paulo. Informar o valor de dbito do diferencial de alquota correspondente aos CFOP 2101, 2102, 2111, 2113, 2116, 2117, 2118, 2120, 2121, 2122, 2126, 2251, 2252, 2253, 2254, 2255, 2256, 2257, 2301, 2302, 2303, 2304, 2305, 2306, 2351, 2352, 2353, 2354, 2355, 2356, 2401, 2403, 2406, 2407, 2551, 2552, 2556, 2557, 2651, 2652 e 2653.
//Base de ICMS Antec. Parcial	  9(12)	      241 a 252	- Valor da base de cálculo do ICMS Antecipação Parcial	 	Campo especfico para estabelecimentos situados nos Estados Bahia e Maranhão.
//Base de ICMS Dif. de Alq   	9(12)	      253 a 264	- Valor da base de cálculo do ICMS Diferencial de Alquota	 	Campo especfico para estabelecimentos situados nos Estados Bahia e Maranhão.
//Valor da antec. parc. dbito	9(12)	      265 a 276	- Valor do ICMS interno, ou seja, valor que seria praticado na movimentação interna, referente aos itens com diferencial	 	Campo especfico para estabelecimentos situados nos Estados Bahia e Maranhão.
//Valor da antec. parc. crdito	9(12)	      277 a 288	- Valor do ICMS origem, ou seja, valor do ICMS destacado na nota, correspondente aos itens com diferencial	 	Campo especfico para estabelecimentos situados nos Estados Bahia e Maranhão.
//BRANCOS	                      X(297)	    289 a 489	- Campo vazio. Gravar brancos.	 	Gravar Brancos.
//USO DA EBS	                  9(005)	    490 a 494	- Campo reservado. Gravar brancos.	 	Gravar Brancos.
//SEQUNCIA	                    9(006)	    495 a 500	- Número sequencial do registro	000005	Cada linha deve ter um número seqencial, linha 2 - 000002, linha 3 -   000003. Deve-se observar a linha do arquivo de modo geral, e não informar a sequncia apenas do registro.



end;


procedure TFr_Imp_Notas.Pc_Cord_Nota_Ent;
Var
  Lc_Nome : String;
begin
  // Layout do Arquivo de Importação de Notas Fiscais de Sada
  Lc_Nome := 'C:\NOTAENT.TXT';
  if FileExists(Lc_Nome) then DeleteFile(Lc_Nome);
  AssignFile(It_Arquivo,Lc_Nome); // Associa o arquivo a uma varivel do tipo TextFile
  Rewrite (It_Arquivo);
  //LAYOUT DO REGISTRO HEADER
  Pc_HeaderNota;
  //LAYOUT DO REGISTRO DO EMITENTE/DESTINATRIO
  Pc_EmitenteDestinatarioNota('E');
  //LAYOUT DO REGISTRO DE NOTAS FISCAIS
  Pc_NotaFiscaisNotaEnt;
  //LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE SADA
  Pc_DadosComplemetaresNotaEnt;
  //Fechamento do Arquivo
  CloseFile(It_Arquivo);
  Gg_Progresso.Update;
  MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                 'O arquivo NOTAENT.TXT foi exportado com Sucesso.'+EOLN+EOLN+Lc_Nome+EOLN,
                  ['OK'],[bEscape],mpInformacao);
end;


procedure TFr_Imp_Notas.Pc_NotaFiscaisNotaEnt;
Var
  Lc_Qr_Notas : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
  lcc_TotalNF : Real;
  Lc_Valor : Real;
Begin
  Lc_Qr_Notas := TSTQuery.Create(Self);
  with Lc_Qr_Notas do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT '+
                  '   NFL_NUMERO, '+
                  '   NFL_CODIGO, '+
                  '   NFL_SERIE, '+
                  '   NFL_DT_EMISSAO, '+
                  '   NFL_VL_TL_NOTA,  '+
                  '   NFL_BS_ICMS, '+
                  '   NFL_VL_ICMS,  '+
                  '   NFL_BS_ICMS_SUBST,'+
                  '   NFL_VL_ICMS_SUBST,'+
                  '   NFL_VL_IPI, '+
                  '   NFL_CTA_FRETE, '+
                  '   MDF_CODIGO, '+
                  '   PED_PRAZO,  '+
                  '   NAT_CFOP,  '+
                  '   PED_VL_DESCONTO, '+
                  '   NFL_VL_SEGURO,  '+
                  '   NFL_PESO_BRUTO, '+
                  '   NFL_PESO_LIQ,  '+
                  '   NFL_QT_PRODUTO,  '+
                  '   NFL_VL_FRETE,  '+
                  '   NFL_VL_DESP_ACESS,  '+
                  '   tb_transportadora.EMP_CNPJ AS TRP_CNPJ, '+
                  '   NFL_ESPECIE,  '+
                  '   tb_empresa2.emp_cnpj as cnpj2,  '+
                  '   NFE_CODNFL '+
                  'FROM TB_NOTA_FISCAL tb_nota_fiscal  '+
                  '  INNER JOIN TB_PEDIDO tb_pedido  '+
                  '  ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                  '  INNER JOIN TB_MODAL_FRETE '+
                  '  ON (MDF_CODIGO = NFL_CTA_FRETE) '+
                  '  INNER JOIN TB_NATUREZA tb_natureza  '+
                  '  ON (tb_natureza.NAT_CODIGO = tb_nota_fiscal.NFL_CODNAT)  '+
                  '  LEFT OUTER JOIN TB_EMPRESA tb_transportadora   '+
                  '  ON (tb_transportadora.EMP_CODIGO = tb_nota_fiscal.NFL_CODTRP)'+
                  '  INNER JOIN TB_EMPRESA tb_empresa2   '+
                  '  ON (tb_empresa2.EMP_CODIGO = tb_nota_fiscal.nfl_codemp)  '+
                  '  LEFT OUTER JOIN TB_RETORNO_NFE '+
                  '  ON (NFE_CODNFL = NFL_CODIGO) '+
                  'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)  '+
                  ' AND   (NFL_NUMERO <> '''' ) '+
                  ' AND   (NFL_TIPO  LIKE  ''E%'' ) '+
                  ' AND   (NFL_CODMHA =:NFL_CODMHA)  '+
                  'ORDER BY NFL_DT_EMISSAO, NFL_NUMERO ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('DATAINI').AsDate := E_Data_INI.Date;
    ParamByName('DATAFIM').AsDate := E_Data_FIM.Date;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
    Gg_Progresso.Progress := 0;
    Gg_Progresso.MinValue := 0;
    Gg_Progresso.MaxValue := RecordCount;
    Gg_Progresso.Update;
    First;
    while not Eof do
      Begin
      It_Dados_Arquivo := '1';                                                                      //TIPO DE REGISTRO	      9(001)	001 a 001	      Tipo de Registro: 1 - Notas Fiscais	1	Este campo deve conter apenas o número 1, que  o tipo do registro de lanamento de notas fiscais.
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,  //DATA LCTO	              9(008)	002 a 009	      Data do lanamento formato DDMMAAAA	30112007	Informar a data do lanamento no formato DDMMAAAA, este campo não deve conter caracteres como barras ou traos, deve conter apenas números. Os lanamentos do arquivo de importação devem estar todos dentro do mesmo ms. A data de lanamento se refere a data de entrada da mercadoria no estabelecimento, diferente da data de emissão da nota fiscal. é possível acontecer que a data do lanamento e a data de emissão sejam iguais, porm, sóo fatos diferentes. Este campo  de preenchimento obrigatário
                                             '/','',[rfReplaceAll, rfIgnoreCase]);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NFL_NUMERO').AsString,6);     //NMERO NOTA	            9(006)	010 a 015	      Número da nota fiscal	413517	Informar o número da nota fiscal com at 6 dgitos, caso o número tenha menos campos, completar com zeros  esquerda. Este campo  de preenchimento obrigatário.
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,  //DATA DCTO	              9(008)	016 a 023	      Data de emissão no formato DDMMAAAA.	29112007	Informar a data de emissão da Nota Fiscal no formato DDMMAAAA, este campo não deve conter caracteres como barras ou traos, deve conter apenas números. Os lanamentos do arquivo de importação devem estar todos dentro do mesmo ms. A data de emissão da nota fiscal  a data informada na nota fiscal como Data de Emissão, diferente da data de lanamento da nota fiscal que se refere a entrada da mercadoria no estabelecimento. é possível acontecer que a data do lanamento e a data de emissão sejam iguais, porm, sóo fatos diferentes. Este campo  de preenchimento obrigatário.
                                             '/','',[rfReplaceAll, rfIgnoreCase]);
      It_Dados_Arquivo := It_Dados_Arquivo + '01';                                                  //MODELO	                9(002)	024 a 025	      Modelo da nota fiscal	01	Deve ser informado o modelo da nota fiscal. Quando se tratar de nota de servios ou nota que não possuir modelo definido, deverá informar modelo 01. Notas fiscais emitidas para consumidor final deverão ser preenchidas com modelo 02. Dever atentar para os modelos 07 e 08, onde 07 se refere a Nota Fiscal de servião de transporte e o modelo 08  o CTRC - Conhecimento de Transporte Rodoviário de Cargas. O preenchimento correto deste campo  essencial para evitar rejeições no Sintegra. Este campo  de preenchimento obrigatário. Veja abaixo tabela de modelos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NFL_SERIE').AsString,3);      //SRIE	                  X(003)	026 a 028	      Srie da nota fiscal	U	Neste campo deverá informar apenas a sórie da nota fiscal. Por exemplo, se a sórie da nota for D-1, informar apenas o D, pois o 1 se refere a sub-sórie. Este campo aceita tanto números quanto letras, informar brancos  direita se o registro for menor do que o espaão. Se não houver informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',3);                                   //SUBSRIE	              X(003)	029 a 031	      Subsrie da nota fiscal	001	Neste campo deverá informar apenas a subsrie da nota fiscal. Por exemplo, se a sórie da nota for D-1, informar apenas o 1, pois o D se refere a sórie. Este campo aceita tanto números quanto letras, informar brancos  direita caso o registro seja menor que o espaão. Se não houver informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero(FieldByname('NAT_CFOP').AsString,4);       //NATUREZA	              9(004)	032 a 035	      Natureza da operação (CFOP) 	1102	Informar a Natureza de Operação de Entrada. Não informar pontos, deve informar apenas números. Este campo  de preenchimento obrigatário, exceto para notas somente de servião.
      It_Dados_Arquivo := It_Dados_Arquivo + '01';                                                  //VARIAçõO	              9(002)	036 a 037	      Variação de incidncia da natureza. (Padrão 01)	01	Este campo se refere a opção de tributação dos lanamentos no Cordilheira. Como padrão deverá informar 01, ou outro número a pedido do usuário do sistema. A falta deste registro impede que a nota seja considerada no cálculo dos impostos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',2);                                     //CLASSIFICAçõO 1	        9(002)	38 a 39	        classificação 1 para integração contbil	01	Este campo está relacionado com a integração contbil. Dever ser preenchido de acordo com informações passadas pelo usuário do sistema. Não  um campo de preenchimento obrigatário. Se preenchido incorretamente, poder causar erro na importação do arquivo, pela falta do cadastro da informação no Cordilheira. Se não houver informação preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',2);                                      //CLASSIFICAçõO 2	        9(002)	40 a 41	        classificação 2 para integração contbil	00	Este campo está relacionado com a integração contbil. Dever ser preenchido de acordo com informações passadas pelo usuário do sistema. Não  um campo de preenchimento obrigatário. Se preenchido incorretamente, poder causar erro na importação do arquivo, pela falta do cadastro da informação no Cordilheira. Se não houver informação preencher com zeros.
      Lc_Cnpj := FieldByname('CNPJ2').AsString;
      if Length(Lc_Cnpj) > 11 then
        Lc_Cnpj := fc_MascaraCNPJ(Lc_Cnpj)
      else
        Lc_Cnpj := fc_MascaraCPF(Lc_Cnpj);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco(Lc_Cnpj,18);                             //CNPJ/CPF EMITENTE	      X(018)	42 a 59	        CNPJ ou CPF do emitente (editado)	45.678.901/0001-23	Informar o CNPJ ou CPF do emitente da nota fiscal. Para CPF deve-se completar com brancos  direita. Para emitentes do exterior, preencher com zeros ou um, conforme registro tipo 4 ou cadastro no Cordilheira. Essa informação deve coincidir com a do registro 4, posição 002 a 019.  de preenchimento obrigatário.
      It_Dados_Arquivo := It_Dados_Arquivo +                                                        //VALOR CONTBIL	        9(010)V99	60 a 71	      Valor contbil da nota	000000205540	Informar o valor contbil da nota fiscal. O valor contbil se refere ao valor total da nota fiscal, agrupando todas as operações da mesma. Deve informar apenas números, sendo que os dois ltimos registros se referem as casas decimais. O exemplo: 205540 refere-se ao valor de 2.055,40. Não informar pontos ou vrgulas. Informar zeros  esquerda no restante do registro.
                          Fc_TrataValorArquivoCordilheira(FieldByname('NFL_VL_TL_NOTA').AsCurrency,10,2);
      lcc_TotalNF := lcc_TotalNF + FieldByName('NFL_VL_TL_NOTA').AsCurrency;
      Lc_Valor := 0;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE PIS	              9(010)V99	72 a 83	      Base de cálculo do PIS	000000205540	Informar a base de cálculo para o PIS, caso a empresa seja contribuinte deste imposto e tenha crdito do mesmo. Não será necessário informar se no registro 0 - Header, posição 028, foi informado 1, pois desta forma o prprio Cordilheira preencher os dados automaticamente.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE COFINS	            9(010)V99	84 a 95	      Base de cálculo do COFINS	000000205540	Informar a base de cálculo para o COFINS, caso a empresa seja contribuinte deste imposto e tenha crdito do mesmo. Não será necessário informar se no registro 0 - Header, posição 028, foi informado 1, pois desta forma o prprio Cordilheira preencher os dados automaticamente.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE CSLL	              9(010)V99	96 a 107	    Base de cálculo de CONTRIBUIçõO SOCIAL	000000065773	Informar a base de cálculo para a CSLL - Contribuição Social Sobre o Lucro Lquido, caso a empresa seja contribuinte deste imposto e tenha crdito do mesmo. Não será necessário informar se no registro 0 - Header, posição 028, foi informado 1, pois desta forma o prprio Cordilheira preencher os dados automaticamente.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE IRPJ	              9(010)V99	108 a 119	    Base de cálculo de IMPOSTO DE RENDA	000000065773	Informar a base de cálculo para o IRPJ - Imposto de Renda Pessoa Jurdica, caso a empresa seja contribuinte deste imposto e tenha crdito do mesmo. Não será necessário informar se no registro 0 - Header, posição 028, foi informado 1, pois desta forma o prprio Cordilheira preencher os dados automaticamente.
      Lc_Valor := FieldByName('NFL_BS_ICMS').AsCurrency;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ICMS A	            9(010)V99	120 a 131	    Base de cálculo do ICMS (base A)	000000125540	Neste campo deverá informar a base de cálculo do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Se houver apenas uma alquota de ICMS na nota fiscal deverá informar a base de cálculo apenas neste campo. Se houver mais de uma alquota deverá informar nos campos de BASE ICMS B, C, etc.
      if (FieldByName('NFL_BS_ICMS').AsCurrency >0) then
        Lc_Valor := (FieldByName('NFL_VL_ICMS').AsCurrency / FieldByName('NFL_BS_ICMS').AsCurrency) * 100
      else
        Lc_Valor := 0;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);         //ALIQUOTA ICMS A	        9(002)V99	132 a 135	    Alquota de tributação do ICMS (base A)	1800	Neste campo deverá informar a alquota do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Esta alquota será aplicada sobre a base de cálculo informada em BASE ICMS A, campos 120 a 131. Preencher com zeros a esquerda se o registro for menor do que o campo. No exemplo 18% = 1800
      Lc_Valor := FieldByName('NFL_VL_ICMS').AsCurrency;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR ICMS A	          9(010)V99	136 a 147	    Valor do crdito do ICMS (base A)	000000022597	Informar o valor do ICMS correspondente a BASE ICMS A e ALIQUOTA ICMS A. Se houver informação de Base de Clculo e Alquota, obrigatoriamente deverá ter valor de ICMS, do contrário, haver rejeição no Sintegra.
      Lc_Valor := 0;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ICMS B 	          9(010)V99	148 a 159	    Base de cálculo do ICMS (base B)	000000050000	Neste campo deverá informar a base de cálculo do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Ser utilizado somente se houver mais de uma alquota de ICMS.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);         //ALIQUOTA ICMS B	        9(002)V99	160 a 163	    Alquota de tributação do ICMS (base B)	0700	Neste campo deverá informar a alquota do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Esta alquota será aplicada sobre a base de cálculo informada em BASE ICMS B, campos 148 a 159. Informar zeros  esquerda se o registro for menor do que o campo. No exemplo 7% = 0700
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR ICMS B	          9(010)V99	164 a 175	    Valor do crdito do ICMS (base B)	000000003500	Informar o valor do ICMS correspondente a BASE ICMS B e ALIQUOTA ICMS B. Se houver informação de Base de Clculo e Alquota, obrigatoriamente deverá ter valor de ICMS, do contrário, haver rejeição no Sintegra.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ICMS C 	          9(010)V99	176 a 187	    Base de cálculo do ICMS (base C)	000000000000	Neste campo deverá informar a base de cálculo do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Ser utilizado somente se houver mais de duas alquotas de ICMS. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);         //ALIQUOTA ICMS C	        9(002)V99	188 a 191	    Alquota de tributação do ICMS (base C)	0000	Neste campo deverá informar a alquota do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Esta alquota será aplicada sobre a base de cálculo informada em BASE ICMS C, campos 176 a 187. Informar zeros  esquerda se o registro for menor do que o campo. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR ICMS C          	9(010)V99	192 a 203	    Valor do crdito do ICMS (base C)	000000000000	Informar o valor do ICMS correspondente a BASE ICMS C e ALIQUOTA ICMS C. Se houver informação de Base de Clculo e Alquota, obrigatoriamente deverá ter valor de ICMS, do contrário, haver rejeição no Sintegra. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ICMS D	            9(010)V99	204 a 215	    Base de cálculo do ICMS (base D)	000000000000	Neste campo deverá informar a base de cálculo do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Ser utilizado somente se houver mais de trs alquotas de ICMS. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);         //ALIQUOTA ICMS D	        9(002)V99	216 a 219	    Alquota de tributação do ICMS (base D)	0000	Neste campo deverá informar a alquota do ICMS, caso a empresa seja contribuinte e tenha crdito deste imposto. Esta alquota será aplicada sobre a base de cálculo informada em BASE ICMS D, campos 204 a 215. Informar zeros  esquerda se o registro for menor do que o campo. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR ICMS D	          9(010)V99	220 a 231	    Valor do crdito do ICMS (base D)	000000000000	Informar o valor do ICMS correspondente a BASE ICMS D e ALIQUOTA ICMS D. Se houver informação de Base de Clculo e Alquota, obrigatoriamente deverá ter valor de ICMS, do contrário, haver rejeição no Sintegra. Preencher com zeros se não houver informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //ISENTAS ICMS	          9(010)V99	232 a 243	    Valor de isentas de ICMS	000000010000	Informar o valor correspondente as mercadorias Isentas de ICMS na nota fiscal. Preencher com zeros se não houver a informação.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //OUTRAS ICMS	            9(010)V99	244 a 255	    Valor de outras de ICMS	000000020000	Informar o valor correspondente a Outras de ICMS na nota fiscal. Preencher com zeros se não houver a informação. Para empresas contribuintes do ICMS, o valor contbil da nota deve ser o mesmo da soma dos campos: Base de Clculo + Isentas + Outras.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE IPI	              9(010)V99	256 a 267	    Base de cálculo do IPI	000000090000	Informar a base de cálculo para o IPI caso a empresa seja contribuinte deste imposto. Dever informar valor neste registro apenas se houver valor do IPI. Caso não tenha informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR IPI	              9(010)V99	268 a 279	    Valor do crdito de IPI	000000010000	Informar o valor do IPI caso a empresa seja contribuinte deste imposto. Dever informar valor neste registro apenas se houver Base de Clculo do IPI. Caso não tenha informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //ISENTAS IPI	            9(010)V99	280 a 291	    Valor de isentas de IPI	000000000000	Informar o valor de Isentas do IPI. Este registro será preenchido apenas se a empresa for contribuinte do IPI e se no lanamento houver informação de Isentas para o IPI. Caso não tenha informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //OUTRAS IPI	            9(010)V99	292 a 303	    Valor de outras de IPI	000000105540	Informar o valor de Outras do IPI. Este registro será preenchido apenas se a empresa for contribuinte do IPI e se no lanamento houver informação de Outras para o IPI. Caso não tenha informação, preencher com zeros.
      Lc_Valor := Fc_Mercaforia_St(FieldByName('NFL_CODIGO').AsInteger);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //MERCADORIAS ST	        9(010)V99	304 a 315	    Valor de mercadorias com sub. tributria	000000010000	Informe o valor total das mercadorias com substituição tributria de ICMS. Como regra geral este valor deve ser menor ou igual ao valor contbil da nota fiscal. IMPORTANTE: Neste campo devem ser somados os valores referentes as mercadorias somente com substituição tributria de ICMS + mercadorias com sub. trib. de ICMS/PIS/COFINS. Informar este valor apenas se o campo Natureza de Operação (032 a 035) corresponder a Substituição Tributria ou se existir informação nos campos 408 a 411 (Natureza de operação para Sub. Tributria). Caso não tenha informação, preencher com zeros.
      Lc_Valor := FieldByName('NFL_BS_ICMS_SUBST').AsCurrency;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ST	                9(010)V99	316 a 327	    Base de cálculo da sub. tributria	000000000000	Informe a base de cálculo utilizada para retenção do imposto por substituição tributria. Este valor pode, eventualmente, ser maior que o valor contbil. Este campo será preenchido caso exista imposto retido por substituição tributria. Se não for o caso do lanamento, deverá preencher somente o campo Mercadorias St (304 a 315) quando a natureza de operação for de substituição tributria. Caso não tenha informação, preencher com zeros.
      Lc_Valor := FieldByName('NFL_VL_ICMS_SUBST').AsCurrency;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //ICMS ST	                9(010)V99	328 a 339	    ICMS retido por sub. tributria	000000000000	Informe o imposto retido por substituição tributria. Este campo será preenchido caso exista Base de Clculo da Substituição Tributria, nos campos 316 a 327. Caso não tenha informação, preencher com zeros.
      Lc_Valor := 0;
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //DIFERIDAS	              9(010)V99	340 a 351	    Valor de mercadorias diferidas	000000000000	Informe o valor das mercadorias com diferimento do imposto. Caso não tenha informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',50);                                  //OBSERVAçõES	            X(050)	352 a 401	      Observaçõoervações a gerar no livro fiscal	DECRETO 1.234/2007	Informar observações existentes na nota fiscal e necessitem serem impressas no Livro Fiscal. Caso não tenha informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('NFE',5);                                //ESPCIE	                X(005)	402 a 406	      Espcie do documento	NF	Informar a espcie do documento que está sendo lanado. Pode ser NF (Nota Fiscal), CTRC (Conhecimento de Transporte Rodoviário de Cargas), etc. Este campo  de preenchimento obrigatário. Os espaos restantes devem ser completados com brancos  direita.
      It_Dados_Arquivo := It_Dados_Arquivo + 'N';                                                   //VENDA A VISTA	          X(001)	407 a 407	      "S" = venda a vista e "N" = venda a prazo
                                                                                                    //"X"= Sem Pagamento	N	Informar S para venda a vista, N para venda a prazo e X para Sem Pagamento. Este campo  de preenchimento obrigatário.
      if (FieldByName('NFL_BS_ICMS').AsCurrency >0) then
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_Cfop_St(FieldByName('NFL_CODIGO').AsInteger)     //NAT. OPERAçõO ST	      9(004)	408 a 411	      Natureza de operação para Sub. Tributria.	1403	Este campo deverá ser informado caso a nota fiscal apresente dois CFOPs (duas Naturezas de Operação), sendo uma delas obrigatoriamente de Substituição Tributria. Caso exista apenas a Natureza de Operação de Substituição Tributria, deverá informar apenas no campo 032 a 035. Caso a empresa tenha duas naturezas de operação e estas não forem de substituição tributria, deverá efetuar dois lanamentos diferenciados. Caso não exista informação, preencher com zeros.
      else
        It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('',4);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,6,2);         //BASE PIS/COFINS ST	    9(006)V99	412 a 419	    Base de PIS/COFINS por Sub. Tributria	00000000	Dever informar neste campo o valor referente a substituição tributria de PIS e COFINS. Não deverá confundir com a Substituição Tributria de ICMS. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //BASE ISS	              9(010)V99	420 a 431 	  Base de cálculo de ISS (valor dos servios)	000000000000	Informar o valor para a Base de Clculo do ISS quando houver valor de entrada de servios na nota fiscal. Se não houver informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,2,2);         //ALQUOTA ISS	          9(002)V99	432 a 435	    Alquota de tributação de ISS 	0500	Informar o valor da alquota de ISS na entrada de servios. Este valor deve ser informado caso exista informação nos campos 420 a 431 que correspondem a base do ISS. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //VALOR ISS	              9(010)V99	436 a 447	    Valor de ISS	000000000000	Informar o valor de ISS na entrada de servios. Este valor deve ser informado caso exista informação nos campos Base de Clculo do ISS (420 a 431) e alquota do ISS (campos 432 a 435). Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //ISENTAS ISS	            9(010)V99	448 a 459	    Valores da nota isentos de ISS	000000000000	Informar o valor de entrada de servios Isentos de ISS. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //IRRF RETIDO	            9(010)V99	460 a 471	    Valor do IRRF retido	000000000000	Informar o valor do IRRF Retido nas entradas de servios. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //PIS RETIDO	            9(010)V99	472 a 483	    Valor do PIS retido	000000000000	Informar o valor do PIS Retido nas entradas de servios. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //COFINS RETIDO	          9(010)V99	484 a 495	    Valor do COFINS retido	000000000000	Informar o valor do COFINS Retido nas entradas de servios. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);        //CSLL RETIDO	            9(010)V99	496 a 507	    Valor do CSLL retida	000000000000	Informar o valor da CSLL Retida nas entradas de servios. Caso não exista informação, preencher com zeros.
      It_Dados_Arquivo := It_Dados_Arquivo + StringReplace(FieldByname('NFL_DT_EMISSAO').AsString,  //DATA PAGAMENTO	        9(008)	508 a 515	      Data de pagamento da nota fiscal, no formado DDMMAAAA	30112007	Informar a data de pagamento da Nota Fiscal de entrada de Servios no formato DDMMAAAA. Esta data será referenciada no cálculo dos tributos na questão das retenções. Caso não exista informação, preencher com zeros.
                                             '/','',[rfReplaceAll, rfIgnoreCase]);
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,4,0);               //OPERAçõO CONTBIL 	    9(004)	516 a 519 	    Cdigo da operação contbil (opcional).	0001	Neste campo poder informar a operação contbil do lanamento. Este campo  de preenchimento opcional, se refere a estrutura dos lanamentos para integração com o Cordilheira Sistema Contbil. A não informação deste campo não ir acarretar erros ou advertncias na importação. Se não existir a informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,6,0);               //CLIFOR 	                9(006)	520 a 525 	    Campo reservado. 	000000	Gravar brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',18);                                 //IDENTIFICAçõO EXTERIOR	X(018)	526 a 543 	    Identificação para emitentes do exterior. Estado = 'EX'.	PORTUGAL	Informar uma identificação se o emitente/destinatário for do exterior (EX: Nome do pas ou nome da empresa). Essa informação  importante para poder distinguir um emitente/destinatário do exterior de outro, já que o CNPJ sempre será o mesmo (zeros ou um). Essa identificação deverá constar tambm no cadastro do emitente/destinatário.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);       //INSS RETIDO 	          9(010)V99 	544 a 555 	Valor do INSS retido nas notas de entrada de servios. 	000000000000	Informar o Valor do INSS retido nas notas de entrada de servios. Se não existir a informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(Lc_Valor,10,2);       //FUNRURAL RETIDO 	      9(010)V99 	556 a 567 	Valor do FUNRURAL retido nas notas de entrada de servios. 	000000000000	Informar o Valor do FUNRURAL retido nas notas de entrada de servios. Se não existir a informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_TrataValorArquivoCordilheira(0,4,0);               //CDIGO SERVIO      	  9(004)	568 a 571 	    Cdigo do item de servião	0001	Informar o item de servião para o lanamento de entradas de servios. Este campo deverá ser informado somente se houver valor de servios no lanamento. Este item  cadastrado no Cordilheira, se não houver informação, não causar erros na validação do arquivo, pois existe uma opção para ser informado este campo no momento da importação. Caso não exista informação, preencher com brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + 'N';                                                  //ISS RETIDO S/N	        X(001)	572 a 572	      ISS já retido anteriormente	S	Informar S para Sim e N para Não.
      It_Dados_Arquivo := It_Dados_Arquivo + 'N';                                                  //ISS DEVIDO PRESTAçõO	  X(001)	573 a 573	      ISS devido no local da prestação do servião	S	Informar S (sim) ou N (não).
      It_Dados_Arquivo := It_Dados_Arquivo + '  ';                                                 //UF PRESTAçõO	          X(002)	574 a 575	      Estado do local da prestação do servião	SP	Este campo se torna obrigatário quando o campo ISS Devido Prestação for igual a S. Devendo ser preenchido com sigla vlida.
      It_Dados_Arquivo := It_Dados_Arquivo + '0000000';                                            //MUNICPIO PRESTAçõO	  9(007)	576 a 582	      Municpio do local da prestação do servião	0000001	Este campo se torna obrigatário quando o campo ISS Devido Prestação for igual a S. Devendo ser preenchido com municpio vlido, previamente cadastrado no sistema para a UF Prestação informada.
      if (FieldByname('NFE_CODNFL').AsInteger > 0) then                                        //TIPO EMISSO	          X(001)	583 a 583	      Tipo de emissão da nota fiscal	T	Informar P para emissão prpria e T para emissão de terceiros.
        It_Dados_Arquivo := It_Dados_Arquivo + 'P'                                                 //Brancos ou informação diferente de P ou T       será considerado como Terceiros.
      else
        It_Dados_Arquivo := It_Dados_Arquivo + 'T';
      It_Dados_Arquivo := It_Dados_Arquivo + FieldByname('MDF_CODIGO').AsString;                   //MODALIDADE DO FRETE	    9(001)	584 a 584	0 - Sem cobrança de frete
                                                                                                   //0 - Sem cobrança de frete
                                                                                                   //1 - Por conta do Remetente (CIF)
                                                                                                   //2 - Por conta do Destinatário (FOB)
                                                                                                   //3 - Por conta do Emitente
                                                                                                   //4 - Por conta de Terceiros
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                  //BRANCOS 	              X(005) 	585 a 589	      Campo vazio. Gravar brancos.	 	Gravar Brancos.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaEspaco('',5);                                  //USO DA EBS	            X(005)	590 a 594	      Campo reservado. Gravar brancos.		Gravar Brancos.
      Inc(It_Linhas);
      It_Dados_Arquivo := It_Dados_Arquivo + StrZero(It_Linhas,6,0);                               //SEQUNCIA	            9(006)	595 a 600	      Número sequencial	000003	Cada linha do arquivo deve ter um número sequencial. Exemplo: linha 2 - 000002, linha 3 - 000003. Deve-se observar a linha do arquivo de modo geral, e não apenas a do registro.
      It_Dados_Arquivo := It_Dados_Arquivo + Fc_CriaZero('0',9);                                   //NMERO DA NOTA 2	      9(009)	601 a 609	      Número da nota fiscal	413557001	Quando informado valor neste campo, será desconsiderado o valor informado no campo Número da nota (posição 10)
      Writeln(It_Arquivo,It_Dados_Arquivo);
      //LAYOUT DO REGISTRO DE PRODUTOS
      Pc_ProdutosNota(FieldByName('NFL_CODIGO').AsInteger);
      Next;
      Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
      Gg_Progresso.Update;
      end;
    end;
  Lc_Qr_Notas.Close;
  FreeAndNil(Lc_Qr_Notas);
end;

//LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE ENTRADA
procedure TFr_Imp_Notas.Pc_DadosComplemetaresNotaEnt;
Begin


end;

Function TFr_Imp_Notas.Fc_TrataValorArquivoCordilheira(Fc_Valor:Real;Fc_tamanho,Fc_Virgula:Integer):String;
Begin
  Result := FloatToStrF(ABS(Fc_Valor),ffFixed,Fc_tamanho,Fc_Virgula);
  Result := Fc_RemoveCaracterInformado(Result, ['.']);
  Result := Fc_RemoveCaracterInformado(Result, [',']);
  Result := Fc_CriaZero(Result,(Fc_tamanho + Fc_Virgula));
end;

procedure TFr_Imp_Notas.Pc_Cord_Nota_Sai;
Var
  Lc_Nome : String;
begin
  // Layout do Arquivo de Importação de Notas Fiscais de Sada
  Lc_Nome := 'C:\NOTASAI.TXT';
  if FileExists(Lc_Nome) then DeleteFile(Lc_Nome);
  AssignFile(It_Arquivo,Lc_Nome); // Associa o arquivo a uma varivel do tipo TextFile
  Rewrite (It_Arquivo);
  //LAYOUT DO REGISTRO HEADER
  Pc_HeaderNota;
  //LAYOUT DO REGISTRO DO EMITENTE/DESTINATRIO
  Pc_EmitenteDestinatarioNota('S');
  //LAYOUT DO REGISTRO DE NOTAS FISCAIS
  Pc_NotaFiscaisNotaSai;
  //LAYOUT DE DADOS COMPLEMENTARES DA NOTA FISCAL DE SADA
  Pc_DadosComplemetaresNotaSai;
  //Fechamento do Arquivo
  CloseFile(It_Arquivo);
  Gg_Progresso.Update;
  MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                 'O arquivo NOTASAI.TXT foi exportado com Sucesso.'+EOLN+EOLN+Lc_Nome+EOLN,
                  ['OK'],[bEscape],mpInformacao);
end;

Function TFr_Imp_Notas.Fc_Mercaforia_St(Fc_cd_Nota:Integer):Real;
Var
  Lc_Qr_Notas : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
  lcc_TotalNF : Real;
  Lc_Valor : Real;
Begin
  Lc_Qr_Notas := TSTQuery.Create(Self);
  with Lc_Qr_Notas do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;


  // Abre Tabela de Notas Fiscais

    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT Sum((ITF_QTDE * ITF_VL_UNIT)-ITF_VL_DESC) ITF_VL_PRODUTO '+
                 ' FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                 '    INNER JOIN TB_ITENS_NFL tb_itens_nfl '+
                 '    ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO ) '+
                 '    INNER JOIN TB_PRODUTO tb_produto '+
                 '    ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) '+
                 ' where tb_produto.pro_sub_trib = ''S'' '+
                 '   AND (NFL_CODIGO=:NFL_CODIGO) '+
                 '   AND (NFL_CODMHA =:NFL_CODMHA) '+
                 '   AND NFL_BS_ICMS_SUBST >0';

    SQL.Add(Lc_SqlTxt);
    ParamByName('NFL_CODIGO').AsInteger := Fc_cd_Nota;
    ParamByName('NFL_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
    Result := FieldbyName('ITF_VL_PRODUTO').AsCurrency;

    end;
  Lc_Qr_Notas.Close;
  FreeAndNil(Lc_Qr_Notas);
end;

Function TFr_Imp_Notas.Fc_Cfop_St(Fc_cd_Nota:Integer):String;
Var
  Lc_Qr_Notas : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Cnpj : String;
  lcc_TotalNF : Real;
  Lc_Valor : Real;
Begin
  Lc_Qr_Notas := TSTQuery.Create(Self);
  with Lc_Qr_Notas do
    Begin
    Database := DM.IBD_Gestao;
    Lc_Qr_Notas.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;

    Close;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT NAT_CFOP '+
                 ' FROM TB_ITENS_ICMS tb_itens_icms '+
                 '    INNER JOIN TB_NATUREZA tb_natureza '+
                 '    ON (tb_natureza.NAT_CODIGO = tb_itens_icms.icm_codnat) '+
                 ' where ICM_CODNFL =:NFL_CODIGO '+
                 '   AND (ICM_VL_BC_ST >0) ';

    SQL.Add(Lc_SqlTxt);
    ParamByName('NFL_CODIGO').AsInteger := Fc_cd_Nota;
    Active := true;
    FetchAll;
    if (recordcount >0) then
      Result := FieldbyName('NAT_CFOP').AsString
    else
      Result := '0000';

    end;
  Lc_Qr_Notas.Close;
  FreeAndNil(Lc_Qr_Notas);
end;

procedure TFr_Imp_Notas.PC_Cord_ITem;
var
  Lc_Qr_sql :TSTQuery;
  lc_caminho,lc_txt:String;
  lc_sequencia:Integer;
  lc_arquivo:TextFile;
  Lc_Aux : String;
begin
  Lc_Qr_sql := TSTQuery.Create(Fr_Imp_Notas);
  Lc_caminho:= 'C:\ITEM.txt';
  AssignFile (lc_arquivo, lc_caminho );
  Rewrite ( lc_arquivo );
  lc_sequencia:=1;

  with Lc_Qr_sql do
    Begin
    Database:= DM.IBD_Gestao;
    Transaction:= DM.IB_Transacao;
    //Registro - Unidade de Medida
    Active:=false;
    SQL.Clear;
    lc_txt := ' select distinct MED_ABREVIATURA, MED_DESCRICAO '+
              ' from tb_itens_nfl a '+
              ' inner join tb_nota_fiscal tb_nota_fiscal on tb_nota_fiscal.nfl_codigo = a.itf_codnfl '+
              ' inner join tb_pedido tb_pedido on tb_pedido.ped_codigo =tb_nota_fiscal.nfl_codped '+
              ' left outer join tb_itens_icms  tb_itens_icms  on tb_itens_icms.ICM_CODITF = a.itf_codnfl '+
              ' left outer join tb_itens_ipi  tb_itens_ipi  on tb_itens_ipi.IPI_CODITF = a.itf_codnfl '+
              ' inner join tb_produto tb_produto on tb_produto.pro_codigo = a.itf_codpro '+
              ' inner join tb_medida  tb_medida  on tb_produto.pro_codmed = tb_medida.MED_CODIGO '+
              '  where tb_nota_fiscal.NFL_CODMHA  =:NFL_CODMHA '+
              ' AND tb_nota_fiscal.nfl_dt_emissao between :dat_ini and :dat_fim ';

    SQL.Add(lc_txt);
    ParamByName('dat_ini').AsDate  := E_Data_Ini.Date;
    ParamByName('dat_fim').AsDate  := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;

    Active:=true;
    FetchAll;
    First;
    if RecordCount >0 then
      begin
      Gg_Progresso.Progress := 0;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Gg_Progresso.Update;
      while not Eof do
        begin
        //Unidade de Medida
        Lc_Aux := Copy(fieldbyname('MED_ABREVIATURA').AsString,1,2);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,6);
        Write (lc_arquivo,Lc_Aux);
        //Descrição da Medida
        Lc_Aux := Copy(fieldbyname('MED_DESCRICAO').AsString,1,30);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,30);
        Write (lc_arquivo,Lc_Aux);
        //brancos
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,457);
        Write (lc_arquivo,Lc_Aux);
        //Tipo de REgistros
        Lc_Aux := '1';
        Write (lc_arquivo,Lc_Aux);
        //Número sequencial do registro.
        Lc_Aux := StrZero(Lc_sequencia,6,0);
        Writeln (lc_arquivo,Lc_Aux);
        next;
        lc_sequencia:=lc_sequencia+1;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
        end;//FIM WHILE MEDIDA
      END;//Fim REgistro Medida

    //Registro - Cadastro de ITem
    Active:=false;
    SQL.Clear;
    lc_txt := ' select distinct pro_codigo,PRO_DESCRICAO,MED_ABREVIATURA,pro_peso, '+
              ' PRO_CODIGOFAB,pro_tipo,PRO_CODIGONCM,ICM_AQ_NR,IPI_AQ_NR '+
              ' from tb_itens_nfl a '+
              ' inner join tb_nota_fiscal tb_nota_fiscal on tb_nota_fiscal.nfl_codigo = a.itf_codnfl '+
              ' inner join tb_pedido tb_pedido on tb_pedido.ped_codigo =tb_nota_fiscal.nfl_codped '+
              ' left outer join tb_itens_icms  tb_itens_icms  on tb_itens_icms.ICM_CODITF = a.itf_codnfl ';
{
    if (it_Cd_Crt = 2) or (it_Cd_Crt = 3) then
      Begin
      lc_txt := lc_txt +
              ' LEFT OUTER JOIN TB_TRIB_ICMS_NR ON (tb_trib_icms_nr.TBI_CODIGO = tb_itens_icms.ICM_CODTBI_NR) ';
      end
    else
      Begin
      lc_txt := lc_txt +
              ' LEFT OUTER JOIN TB_TRIB_ICMS_SN ON (tb_trib_icms_nr.TBI_CODIGO = tb_itens_icms.ICM_CODTBI_SN) ';
      end;
}      
    lc_txt := lc_txt +
              ' left outer join tb_itens_ipi  tb_itens_ipi  on tb_itens_ipi.IPI_CODITF = a.itf_codnfl '+

              ' inner join tb_produto tb_produto on tb_produto.pro_codigo = a.itf_codpro '+
              ' inner join tb_medida  tb_medida  on tb_produto.pro_codmed = tb_medida.MED_CODIGO '+
              '  where tb_nota_fiscal.NFL_CODMHA  =:NFL_CODMHA '+
              ' AND tb_nota_fiscal.nfl_dt_emissao between :dat_ini and :dat_fim ';

    SQL.Add(lc_txt);
    ParamByName('dat_ini').AsDate  := E_Data_Ini.Date;
    ParamByName('dat_fim').AsDate  := E_Data_Fim.Date;
    ParamByName('NFL_CODMHA').AsInteger:=Gb_CodMha;

    Active:=true;
    FetchAll;
    First;
    if RecordCount >0 then
      begin
      Gg_Progresso.Progress := 0;
      Gg_Progresso.MinValue := 0;
      Gg_Progresso.MaxValue := RecordCount;
      Gg_Progresso.Update;
      while not Eof do
        begin
        //Cdigo do item
        Lc_Aux := StrZero(fieldbyname('PRO_CODIGO').AsFloat,10,0);
        Write (lc_arquivo,Lc_Aux);
        //Descrição do item
        Lc_Aux := Copy(fieldbyname('PRO_DESCRICAO').AsString,1,40);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,40);
        Write (lc_arquivo,Lc_Aux);
        //Cdigo da Nomenclatura Comum do Mercosul do item
        Lc_Aux := fieldbyname('PRO_CODIGONCM').AsString;
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,8);
        Write (lc_arquivo,Lc_Aux);
        //Unidade de medida
        Lc_Aux := Copy(fieldbyname('MED_ABREVIATURA').AsString,1,4);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,4);
        Write (lc_arquivo,Lc_Aux);
        //Peso do item
        Lc_Aux := StrZero(fieldbyname('PRO_PESO').AsFloat,10,3);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
        Write (lc_arquivo,Lc_Aux);
        //Identificação do produto
        Lc_Aux := Copy(fieldbyname('PRO_CODIGOFAB').AsString,1,15);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,15);
        Write (lc_arquivo,Lc_Aux);
        //Identificação do tipo do produto, conforme tabela abaixo.
        IF fieldbyname('PRO_TIPO').AsString = 'P' then
          Begin
          Lc_Aux := StrZero(5,2,0);
          Write (lc_arquivo,Lc_Aux);
          end
        else
          Begin
          Lc_Aux := StrZero(2,2,0);
          Write (lc_arquivo,Lc_Aux);
          end;
        //Campo reservado.
        Lc_Aux := Fc_CriaEspaco('',12);
        Write (lc_arquivo,Lc_Aux);
        //Entrada - Situação Tributria ICMS
        Write (lc_arquivo,'090');
        //Entrada - Situação Tributria IPI
        Write (lc_arquivo,'000');
        //Saida - Situação Tributria ICMS
        Write (lc_arquivo,'090');
        //Saida - Situação Tributria IPI
        Write (lc_arquivo,'000');
        //Unidade 2
        Lc_Aux := Copy(fieldbyname('MED_ABREVIATURA').AsString,1,6);
        Lc_Aux := Fc_CriaEspaco(Lc_Aux,6);
        Write (lc_arquivo,Lc_Aux);
        //aLIQUOTA DE ICMS
        Lc_Aux := StrZero(fieldbyname('ICM_AQ_NR').AsFloat,6,2);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
        Write (lc_arquivo,Lc_Aux);
        //aLIQUOTA DE IPI
        Lc_Aux := StrZero(fieldbyname('IPI_AQ_NR').AsCurrency,6,2);
        Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux,[',']);
        Write (lc_arquivo,Lc_Aux);
        //Campo Reservado
        Lc_Aux := Fc_CriaEspaco('',365);
        Write (lc_arquivo,Lc_Aux);
        //Número sequencial do registro.
        Lc_Aux := '2';
        Write (lc_arquivo,Lc_Aux);
        //Número sequencial do registro.
        Lc_Aux := StrZero(Lc_sequencia,6,0);
        Writeln (lc_arquivo,Lc_Aux);
        Next;
        lc_sequencia:=lc_sequencia+1;
        Gg_Progresso.Progress := Gg_Progresso.Progress + 1;
        Gg_Progresso.Update;
      end;
      Gg_Progresso.Update;
      CloseFile(lc_arquivo);
      end;
    end;
  FreeAndNil(Lc_Qr_sql);
end;



function TFr_Imp_Notas.RemoveCaracterInformado(Fc_Variavel,
  Fc_CaracterNaoDesejado: string): string;
var
  lci_Aux     : integer;
  lcs_Retorno : string;
  lcs_Letra   : string[1];
begin
  lcs_Retorno:='';

  for lci_Aux:=1 to length(Fc_Variavel) do
  begin
    lcs_Letra := Copy(Fc_Variavel,lci_Aux,1);
    if lcs_Letra <> Fc_CaracterNaoDesejado then
      lcs_Retorno := lcs_Retorno + Copy(Fc_Variavel,lci_Aux,1);
  end;
  Result := lcs_Retorno;

end;


procedure TFr_Imp_Notas.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Imprimir     := True;
    It_Exportar     := True;
  end
  else
  begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Imprimir      := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Exportar      := Fc_HabilitaPermissao(Pc_Menu,'EXPORTAR','S');
  end;
  SB_Imprimir.Enabled:= It_Imprimir;
  Sb_Exportar.Enabled:= It_Exportar;
end;

procedure TFr_Imp_Notas.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  Pc_AbreListaEmpresa(-1,'EMP_NOME');
  Fm_lista_cfop.Sentido := '';
  Fm_lista_cfop.Alcada := '';
  Fm_lista_cfop.Listar;

  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  ChBx_Periodo.Checked:=Fc_Marca_data_pesquisa;
  Pc_PermissaoBotao('Notas');
end;

procedure TFr_Imp_Notas.Ftp_ClienteWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Gg_Progresso.Progress := AWorkCount;
  Gg_Progresso.Update;
end;

procedure TFr_Imp_Notas.Ftp_ClienteWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  Gg_Progresso.Progress := 0;
  if AWorkCountMax > 0 then
    Gg_Progresso.MaxValue := AWorkCountMax
  else
    Gg_Progresso.MaxValue := 1;
end;

procedure TFr_Imp_Notas.Ftp_ClienteWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  Gg_Progresso.Update;
end;

procedure TFr_Imp_Notas.E_BuscaCodigoExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_BuscaCodigo.Text,0);
end;

procedure TFr_Imp_Notas.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Imp_Notas.AtualizaAguarde;

begin
  
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  Var
    I : Integer; 
    J:Integer; 
  begin
    for I := 0 to Self.ComponentCount - 1 do
      begin
        //Limpa Painel
        if (Self.Components[I].ClassType = TPanel) then
        begin
          if (Copy(TPanel(Self.Components[I]).Name,1,16) = 'Pnl_ProceAguarde') then
          begin            
            for J := 0 to TPanel(Self.Components[I]).ComponentCount - 1 do
            Begin
              if (TPanel(Self.Components[I]).Components[J].ClassType = TACBrGIF) then
              Begin
                TACBrGIF(TPanel(Self.Components[I]).Components[J]).Repaint;
                Break;
              End;
            End;
          end;
        end;
      end;
  end);

end;

procedure TFr_Imp_Notas.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Imp_Notas.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Imp_Notas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Imp_Notas.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    Sb_Exportar.Glyph.Assign(Fc_CarregaImagemBotao('EXPORTAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Imp_Notas.GoToSubDir(SubDir: string);
VAR
  details, nodetails: TStringList;
  k: Integer;
begin
  {
  details   := TStringList.Create;       //get folder contents from ftp. one with details, one without
  nodetails := TStringList.Create;
  TRY
   Ftp_Cliente.List(details, '', True);
   Ftp_Cliente.List(nodetails, '', False);

   //we only want to have directories in the list (without '.' and '..')
   for k := details.Count - 1 downto 0 do
    if details.Strings[k] <> '' then
      if (PosInsensitive('dir', details.Strings[k]) < 1)
      OR (nodetails.Strings[k] = '.')
      OR (nodetails.Strings[k] = '..') then
       begin
        details.Delete(k);
        nodetails.Delete(k);
       end;

   //if our directory does not exists on the server, create it
   if nodetails.IndexOf(SubDir) = -1
   then Ftp_Cliente.MakeDir(SubDir);
  FINALLY
   FreeAndNil(Details);
   FreeAndNil(nodetails);
  END;
  Ftp_Cliente.ChangeDir(SubDir);   //change into next directory on server
  }
end;

procedure TFr_Imp_Notas.LBx_TipoRelatorioClick(Sender: TObject);
begin
  case LBx_TipoRelatorio.ItemIndex of
    9:Begin
        ChBx_Lote_cancelada.Visible := True;
    End
    else
    Begin
      ChBx_Lote_cancelada.Checked := False;
      ChBx_Lote_cancelada.Visible := False;
    End;
  end;
end;

procedure TFr_Imp_Notas.Pc_LoteNFCe(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Este formato somente pra exportação! '+EOLN,
                  ['OK'],[bEscape,bNormal],mpConfirmacao)
  End
  else
  Begin
    Pc_AtivaConfiguracaoNFe;
    Pc_FormataModeloNFCe;
    DefineNomeArquivos('nfce');
    Pc_GeraLoteArquivoNFCe;
    if Not FErro then
    Begin
      Pc_Compactar('nfce');
      EnviaArquivoFtp;
      Pc_EnviaLinkDownloadLote('nfce');
    End;
  End;
end;

procedure TFr_Imp_Notas.Pc_LoteNFe(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Este formato somente pra exportação! '+EOLN,
                  ['OK'],[bEscape,bNormal],mpConfirmacao)
  End
  else
  Begin
    Pc_AtivaConfiguracaoNFe;
    Pc_FormataModeloNFe;
    DefineNomeArquivos('nfe');
    Pc_GeraLoteArquivoNFe;
    if not FErro then
    Begin
      Pc_Compactar('nfe');
      EnviaArquivoFtp;
      Pc_EnviaLinkDownloadLote('nfe');
    End;

  End;
end;


procedure TFr_Imp_Notas.Pc_LoteNFeTerceiros(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Este formato somente pra exportação! '+EOLN,
                  ['OK'],[bEscape,bNormal],mpConfirmacao)
  End
  else
  Begin
    Pc_AtivaConfiguracaoNFe;
    Pc_FormataModeloNFe;
    DefineNomeArquivos('nfeTerceiros');
    Pc_GeraLoteArquivoNFeTerceiros;
    if not FErro then
    Begin
      Pc_Compactar('nfeTerceiros');
      EnviaArquivoFtp;
      Pc_EnviaLinkDownloadLote('nfeterceiros');
    End;
  End;
end;

procedure TFr_Imp_Notas.Pc_LoteNFSe(Pc_Operacao, Pc_Caminho: String);
begin
  if Pc_Operacao = 'I' then
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Este formato somente pra exportação! '+EOLN,
                  ['OK'],[bEscape,bNormal],mpConfirmacao)
  End
  else
  Begin
    Pc_AtivaConfiguracaoNFSe;
    Pc_FormataModeloNFe;
    DefineNomeArquivos('nfse');
    Pc_GeraLoteArquivoNFSe;
    if not FErro then
    Begin
      Pc_Compactar('nfe');
      EnviaArquivoFtp;
      Pc_EnviaLinkDownloadLote('nfe');
    End;

  End;

end;

procedure TFr_Imp_Notas.DefineNomeArquivos(Tipo:String);
Var
  Lc_Mes, Lc_Ano : String;
begin
  //Define o nome da pasta
  Pc_AtivaEstabelecimento;
  It_NameFolder :=  Trim(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString);
  It_NameFolder := Trim(Copy(It_NameFolder,1,5));
  It_NameFolder := StringReplace(It_NameFolder, ' ', '_', []);
  It_NameFolder := StringReplace(It_NameFolder, '.', '_', []);
  It_NameFolder := StringReplace(It_NameFolder, '.', '_', []);
  if Tipo = 'nfe' then
    It_NameFolder := 'LoteNF-e_' + It_NameFolder
  else
    if Tipo = 'nfce' then
      It_NameFolder := 'LoteNFC-e_' + It_NameFolder
    else
      if Tipo = 'nfse' then
        It_NameFolder := 'LoteNFS-e_' + It_NameFolder
      else
        It_NameFolder := 'LoteNF-e_Terceiros_' + It_NameFolder ;

  //Mes e ano do Lote
  Lc_Mes := Copy(DateToStr(E_Data_Ini.DateTime),4,2);
  Lc_Ano := Copy(DateToStr(E_Data_Ini.DateTime),7,4);
  //Serie da Nota
  It_NameFolder := concat( It_NameFolder , '_S' , Fc_Tb_Geral('L','NFE_SERIE','1'), '_' , Lc_Mes , '_' , Lc_Ano);
  //Nome do ARquivo Zipado
  It_NameFileZip := concat(It_NameFolder,'.zip');
End;


procedure TFr_Imp_Notas.Pc_Compactar(Tipo : String);
begin
  if not ValidaDiretorio(GbPathExe + It_NameFolder + '\') then
  Begin
    Lb_Processamento.Caption := 'Compactando Lote de Notas';
    Lb_Processamento.Update;
    if FileExists(GbPathExe + It_NameFileZip) and (It_NameFileZip <> '')then
    begin
      DeleteFile(GbPathExe + It_NameFileZip);
    end;
    //o caminho onde o zip de backup vai ser criado o nome do arquivo
    //vai ficar backup1211.zip se ele for feito no dia 12 de novembro (12)
    ZipSetes.ZipDirectorio(GbPathExe,It_NameFolder ,It_NameFileZip);
  End
  else
  Begin
    MensagemPadrao(' Mensagem de  Atenção',
                   ' Nenhum arquivo encontrado para  para compactação. '+EOLN+
                   ' Todo o processo de envio será abortado.'+EOLN,
                   ['OK'],[bEscape,bNormal],mpConfirmacao)
  End;
end;

procedure TFr_Imp_Notas.EnviaArquivoFtp;
var
   Lc_Date : String;
   Lc_FileNameExe :string;
   Lc_FileNameZip :string;
   Lc_FileName_Dat :String;
   Lc_I : Integer;
begin
  if FileExists(GbPathExe + It_NameFileZip) then
  begin
    Lb_Processamento.Caption := 'Enviado o Lote de Notas para a Internet/Setes';
    Lb_Processamento.Update;
    //Inicia o processo de envio
    Ftp_Cliente.Disconnect;
    Ftp_Cliente.Passive := True;
    Ftp_Cliente.Username := 'setes';
    Ftp_Cliente.Password := 'dN9g23i^';
    Ftp_Cliente.Host := 'ftp.setes.com.br';
    Ftp_Cliente.Connect;
    It_PastaCNPJ := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
    try
      try
        Ftp_Cliente.MakeDir('/httpdocs/Cliente/' + It_PastaCNPJ);
      except
        Lb_Processamento.Caption := 'Enviado o Lote de Notas para a Internet/Setes';
      end;
    finally
      Ftp_Cliente.ChangeDir('/httpdocs/Cliente/' + It_PastaCNPJ);
      Ftp_Cliente.Put(GbPathExe + It_NameFileZip);
      Ftp_Cliente.Disconnect
    end;
  end;
End;

procedure TFr_Imp_Notas.Pc_EnviaLinkDownloadLote(Tipo:String);
var
  Lc_Email: string;
  Lc_Destinatario : TStringList;
  Lc_Anexo : TStringList;
  Lc_AssuntoEmail : string;
  Contador : TControllerContador;
  LcEnviaemail : TFr_envia_email;
begin
  if FileExists(GbPathExe + It_NameFileZip) then
  Begin
    Lb_Processamento.Caption := 'Enviando o email para o contador com o link';
    Lb_Processamento.Update;
    TRy
      Contador := TControllerContador.create(nil);
      LcEnviaemail := TFr_envia_email.create(nil);
      Lc_Email := Contador.getEmail ;
      if (Trim(Lc_Email) <> '') then
      Begin
        Lc_Destinatario := TStringList.Create;
        Lc_Anexo := TStringList.Create;
        Lc_Anexo.Add('Sem anexo');
        Lc_AssuntoEmail :=  'Envio de Lote ' + Tipo + ' - ' + DM.Qr_Estabelecimento.FieldByName('EMP_FANTASIA').AsString;
        with LcEnviaemail do
        Begin
          if (Fc_Tb_Geral('L','GRL_G_EMAIL_SISTEMANFE','S') = 'S') then
            It_Tipo_Envio := 'N'
          else
            It_Tipo_Envio := 'S';
          It_Assunto := Lc_AssuntoEmail;
          Lc_Destinatario.Clear;
          Lc_Destinatario.Add(' ' + Lc_Email );
          It_Destino := Lc_Destinatario;
          It_Anexo := Lc_Anexo;
          It_Corpo   := Fc_Gera_Email();
          ShowModal;
        End;
      End;
    Finally
      FreeAndNil(Lc_Destinatario);
      FreeAndNil(Lc_Anexo);
      FreeAndNil(LcEnviaemail);
      FreeAndNil(Contador);
    End;

  End;
end;

function TFr_Imp_Notas.Fc_Gera_Email():String;
Var
  Lc_Qry : TSTQuery;
  Lc_Referencia : String;
Begin
  //Criar o Html
  Result := '<html> '+
            '<head> '+
            '  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"> '+
            '</head> '+
            '<body> ';
  //Cabeçalho do Email
  Result := Result +
            '<table width="100%" border="0" cellpadding="0" cellspacing="0"> '+
            '   <tr> '+
            '     <td>Ol </td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td>&nbsp;</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> Segue  link para download do Lote de Notas Fiscal Eletronicas. </td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> https://www.setes.com.br/Cliente/' + It_PastaCNPJ + '/' + It_NameFileZip + ' </td> '+
            '   </tr> '+
            '</table> ';
  //Rodape
  Result := Result +
            '<table width="100%" border="0" cellpadding="0" cellspacing="0"> '+
            '   <tr> '+
            '     <td><BR><BR><BR></td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td>e-mail automático - Favor não responder;</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td>Sistema Setes - Gerenciamento Comercial</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td><img  style="width: 192px; height: 56px;" alt=""  src="https://www.setes.com.br/logo_setes_email.jpg"></td> '+
            '   </tr> '+
            '</table> '+
            '</body> '+
            '</html> ';
  Screen.Cursor:=crDefault;
end;


end.

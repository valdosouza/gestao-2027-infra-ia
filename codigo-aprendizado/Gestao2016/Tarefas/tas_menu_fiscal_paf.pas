unit tas_menu_fiscal_paf;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, Un_Fm_ListaProdutos, Vcl.FileCtrl, ControllerPafNfcE, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, ACBrGIF;

type
  TTasMenuFiscalPaf = class(TFr_Base)
    pg_principal: TPageControl;
    Panel1: TPanel;
    tbs_identificacao: TTabSheet;
    pnl_identificacao: TPanel;
    Lb_Identifica_empresa: TLabel;
    Lb_CNPJ: TLabel;
    E_CNPJ: TLabel;
    Lb_nome_razao: TLabel;
    Lb_endereco: TLabel;
    E_nome_razao: TLabel;
    E_Endereco_1: TLabel;
    E_Endereco_2: TLabel;
    Lb_telefone: TLabel;
    E_telefone: TLabel;
    Lb_Contato: TLabel;
    E_nome_contato: TLabel;
    Lb_Identificacao_PAF_NFE_e: TLabel;
    Lb_nome_comercial: TLabel;
    E_nome_comercial: TLabel;
    Lb_Versao_PAF: TLabel;
    E_Versao_PAF: TLabel;
    tbs_PAF_NFC_e: TTabSheet;
    pnl_registro_paf_nfc_e_body: TPanel;
    Fm_ListaProdutos: TFm_ListaProdutos;
    pnl_registro_paf_nfc_e_bottom: TPanel;
    tbs_fechamento: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    Identificao1: TMenuItem;
    Fechamento1: TMenuItem;
    RegistrosdoPAFNFCe1: TMenuItem;
    pnl_local_gracacao: TPanel;
    Sb_local_gravacao: TSpeedButton;
    E_path_diretorio: TEdit;
    Label8: TLabel;
    Sb_Arquivos: TSpeedButton;
    pnl_registro_paf_nfc_e_body_top: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    Rg_tipo_estoque: TRadioGroup;
    pnl_row_2: TPanel;
    Sb_Ins_Produto: TBitBtn;
    Sb_Exc_Produto: TBitBtn;
    DBG_Produtos: TDBGrid;
    cds_Items: TClientDataSet;
    Ds_Items: TDataSource;
    cds_ItemsPRO_CODIGO: TIntegerField;
    cds_ItemsPRO_DESCRICAO: TStringField;
    pnl_estoque_parcial: TPanel;
    Sb_Clear_Produto: TBitBtn;
    cds_paf_aberto: TClientDataSet;
    ds_paf_aberto: TDataSource;
    dbg_fechamento: TDBGrid;
    RG_controle_paf_nfce: TRadioGroup;
    Sb_Encerramento: TSpeedButton;
    cds_paf_abertoTempo: TStringField;
    cds_paf_abertoSituacao: TStringField;
    cds_paf_abertoAberturaUsuario: TStringField;
    cds_paf_abertoHaMovimentacao: TStringField;
    cds_paf_abertoData: TStringField;
    procedure Identificao1Click(Sender: TObject);
    procedure Fechamento1Click(Sender: TObject);
    procedure RegistrosdoPAFNFCe1Click(Sender: TObject);
    procedure Sb_local_gravacaoClick(Sender: TObject);
    procedure Sb_ArquivosClick(Sender: TObject);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure Rg_tipo_estoqueClick(Sender: TObject);
    procedure Sb_Clear_ProdutoClick(Sender: TObject);
    procedure tbs_fechamentoShow(Sender: TObject);
    procedure RG_controle_paf_nfceClick(Sender: TObject);
    procedure Sb_EncerramentoClick(Sender: TObject);
  private
    SaveLastConfig :  TThread;
    PAFNFCE : TControllerPAFNFCE;
    procedure GravaUltimasConfiguracoes;
    procedure PreencherListaEstoqueParcial;
    function ValidaGeraArquivos:Boolean;
    procedure GeraArquivos;
    function ValidateInsertItem:boolean;
    procedure InsertItem;
    function ValidateDeleteItems:boolean;
    procedure DeleteItem;
    procedure getListClosure;
    function ValidaClosure:Boolean;
    procedure setClosure;


  protected
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF4;Override;
    procedure execShorCutKeyF5;Override;
    procedure execShorCutKeyF10;Override;
  public
    { Public declarations }
  end;

var
  TasMenuFiscalPaf: TTasMenuFiscalPaf;
const
  SELDIRHELP = 1000;

implementation


{$R *.dfm}

uses     UN_Sistema, UN_Principal, env, Un_Msg, tas_processamento;

procedure TTasMenuFiscalPaf.Sb_Clear_ProdutoClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Limpar a lista de Itens Selecionados?'+EOLN+EOLN+
                     'Confirmar a operação ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  Begin
    cds_Items.EmptyDataSet;
  End;
end;


procedure TTasMenuFiscalPaf.CriarVariaveis;
begin
  inherited;
  PAFNFCE := TControllerPAFNFCE.create(Self);
end;

procedure TTasMenuFiscalPaf.DeleteItem;
begin
  cds_Items.Delete;
end;

procedure TTasMenuFiscalPaf.execShorCutKeyF10;
begin
  if Sb_Arquivos.Enabled then Sb_ArquivosClick(Self);

end;

procedure TTasMenuFiscalPaf.execShorCutKeyF2;
begin
  if Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Self);

end;

procedure TTasMenuFiscalPaf.execShorCutKeyF4;
begin
  if Sb_Clear_Produto.Enabled then Sb_Clear_ProdutoClick(Self);

end;

procedure TTasMenuFiscalPaf.execShorCutKeyF5;
begin
  inherited;

end;

procedure TTasMenuFiscalPaf.Fechamento1Click(Sender: TObject);
begin
  pg_principal.ActivePage := tbs_fechamento;
end;

procedure TTasMenuFiscalPaf.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(PAFNFCE);
end;

procedure TTasMenuFiscalPaf.FormataTela;
Var
  Lc_X : Integer;
begin
  For Lc_X:=1 to pg_principal.PageCount do pg_principal.Pages[Lc_X-1].TabVisible:=False;
  pg_principal.ActivePage :=tbs_fechamento;
  E_path_diretorio.Text := Fc_Aq_Geral('L','PAF_NFCE','LOCAL_GRAVA','C:\Sistema\PAF_NFC_E\');
  if not SysUtils.DirectoryExists(E_path_diretorio.Text) then
    CreateDir(E_path_diretorio.Text);


  E_Data_Ini.DATE := StrToDate('01/10/2021');
  E_Data_Fim.DATE := StrToDate('31/10/2021');
end;

procedure TTasMenuFiscalPaf.GeraArquivos;
begin
  PAFNFCE.Estabelecimento := Gb_CodMha;
  PAFNFCE.DataInicial     := E_Data_Ini.Date;
  PAFNFCE.DataFinal       := E_Data_Fim.Date;
  PAFNFCE.EstoqueParcial := (Rg_tipo_estoque.ItemIndex = 0);
  PAFNFCE.ListaEstoqueParcial.Clear;
  if PAFNFCE.EstoqueParcial then
  Begin
    PreencherListaEstoqueParcial;
  end;
  PAFNFCE.LocalGravacao   := E_path_diretorio.Text;
  PAFNFCE.GeraArquivoPAFNFCe;
  PAFNFCE.GeraArquivoPAFNFCeZ;
  PAFNFCE.GeraArquivoPAFNFCeW;
end;

procedure TTasMenuFiscalPaf.getListClosure;
Var
  I : Integer;
begin
  PAFNFCE.Controle.clear;
  with PAFNFCE.Controle do
  Begin
    case Rg_controle_paf_nfce.itemIndex of
      0:registro.Situacao := 'A';
      1:registro.Situacao := 'F';
    end;
    getListInterface;
    cds_paf_aberto.Close;
    cds_paf_aberto.CreateDataSet;
    //cds_paf_aberto.EmptyDataSet;
    for I := 0 to ListaInterface.Count - 1 do
    Begin
      cds_paf_aberto.Append;
      cds_paf_abertoData.AsString            := DateToStr(ListaInterface[I].Data);
      cds_paf_abertoTempo.AsString           := TimeToStr(ListaInterface[I].Tempo);
      cds_paf_abertoSituacao.AsString        := ListaInterface[I].Situacao;
      cds_paf_abertoAberturaUsuario.AsString := ListaInterface[I].AberturaUsuario;
      cds_paf_abertoHaMovimentacao.AsString  := ListaInterface[I].HaMovimentacao;
      cds_paf_aberto.post;
    End;
  end;
end;

procedure TTasMenuFiscalPaf.GravaUltimasConfiguracoes;
begin
  SaveLastConfig := TThread.CreateAnonymousThread(
    procedure
    begin
      Fc_Aq_Geral('G','PAF_NFCE','LOCAL_GRAVA',E_path_diretorio.Text);
      SaveLastConfig.Terminate;
    end
  );
  SaveLastConfig.FreeOnTerminate := true;
  SaveLastConfig.Start;
end;

procedure TTasMenuFiscalPaf.Identificao1Click(Sender: TObject);
begin
  pg_principal.ActivePage := tbs_identificacao;
end;

procedure TTasMenuFiscalPaf.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Arquivos,'EXPORTAR');
end;

procedure TTasMenuFiscalPaf.InsertItem;
begin
 with self.cds_Items do
  Begin
    if not Active then createDataset;
    Append;
    FieldByName('PRO_CODIGO').AsInteger   := StrToIntDef(Fm_ListaProdutos.E_Cd_Produto.Text,0);
    FieldByName('PRO_DESCRICAO').AsString := Fm_ListaProdutos.E_Busca_Produto.Text;
    Post;
    Active := False;
    Active := True;
  End;

end;

procedure TTasMenuFiscalPaf.PreencherListaEstoqueParcial;
begin
  if cds_items.RecordCount > 0 then
  Begin
    cds_items.First;
    while not cds_items.Eof do
    Begin
      PAFNFCE.ListaEstoqueParcial.Add(cds_ItemsPRO_CODIGO.AsString);
      cds_items.Next;
    End;
  End;
end;

procedure TTasMenuFiscalPaf.RegistrosdoPAFNFCe1Click(Sender: TObject);
begin
  pg_principal.ActivePage := tbs_PAF_NFC_e;
end;

procedure TTasMenuFiscalPaf.RG_controle_paf_nfceClick(Sender: TObject);
begin
  inherited;
  getListClosure;
end;

procedure TTasMenuFiscalPaf.Rg_tipo_estoqueClick(Sender: TObject);
begin
  inherited;
  if (TRadioGroup(Sender).ItemIndex = 0) then
  Begin
    pnl_estoque_parcial.Enabled := True;
  End
  else
  Begin
    if not cds_items.Active then cds_items.CreateDataSet;
    if cds_items.RecordCount > 0 then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Alternando para o Modo Estoque Total caso exista .'+EOLN+
                         'uma seleção de produtos ela será apagada .'+EOLN+EOLN+
                         'Confirmar a operação ?',
                        [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
      begin
        cds_Items.EmptyDataSet;
        pnl_estoque_parcial.Enabled := False;
      end
      else
      Begin
        TRadioGroup(Sender).ItemIndex := 0;
      End;
    End
    else
    begin
      pnl_estoque_parcial.Enabled := False;
    end
  End;
end;

procedure TTasMenuFiscalPaf.Sb_ArquivosClick(Sender: TObject);
var
  Lc_processo : TTasProcessamento;
begin
  if ValidaGeraArquivos then
  Begin
    try
      Lc_processo := TTasProcessamento.Create(Application);
      Lc_processo.Show;
      Lc_processo.BringToFront;
      Lc_processo.Update;
      GeraArquivos;
      Lc_processo.Finalizar;
    finally
      FreeAndNil(Lc_processo);
      MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                     'Arquivos Gerado com Sucesso.' + EOLN+ EOLN,
                     ['OK'], [bEscape], mpConfirmacao);
    end;
  End;

end;

procedure TTasMenuFiscalPaf.Sb_Exc_ProdutoClick(Sender: TObject);
begin
  inherited;
  if ValidateDeleteItems then
    DeleteItem;
end;

procedure TTasMenuFiscalPaf.Sb_EncerramentoClick(Sender: TObject);
var
  Lc_processo : TTasProcessamento;
begin
  if ValidaClosure then
  Begin
    try
      Lc_processo := TTasProcessamento.Create(Application);
      Lc_processo.Show;
      Lc_processo.BringToFront;
      Lc_processo.Update;
      setClosure;
      getListClosure;
      Lc_processo.Finalizar;
    finally
      FreeAndNil(Lc_processo);
      MensagemPadrao(MENSAGEM, 'S U C E S S O!.' + EOLN + EOLN +
                     'Fechamento executado com Sucesso.' + EOLN+ EOLN,
                     ['OK'], [bEscape], mpConfirmacao);
    end;
  End;
end;

procedure TTasMenuFiscalPaf.Sb_Ins_ProdutoClick(Sender: TObject);
begin
  if ValidateInsertItem then
  Begin
    InsertItem;
    Fm_ListaProdutos.E_Cd_Produto.Clear;
    Fm_ListaProdutos.E_Busca_Produto.Clear;
    Fm_ListaProdutos.E_Cd_Produto.SetFocus;
  End;
end;

procedure TTasMenuFiscalPaf.Sb_local_gravacaoClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(E_path_diretorio.Text) <= 0 then
    Dir := ExtractFileDir(Application.ExeName)
  else
    Dir := E_path_diretorio.Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP)  then
  Begin
    E_path_diretorio.Text := concat(Dir,'\');
    Fc_Aq_Geral('G','PAF_NFCE','LOCAL_GRAVA',E_path_diretorio.Text);
  End;
end;

procedure TTasMenuFiscalPaf.setClosure;
Var
  Lc_Movimento : Boolean;
begin
  PAFNFCE.Controle.DataMovimento  := StrToDate(cds_paf_abertoData.AsString);
  PAFNFCE.Controle.Estoque        := Gb_Estoque;
  Lc_Movimento := PAFNFCE.Controle.ClosuredailySsale;
  if Lc_Movimento then PAFNFCE.Controle.ClosuredailyStock;
  with PAFNFCE.Controle do
  Begin
    Registro.DataMovimento      := StrToDate(cds_paf_abertoData.AsString);
    Registro.Situacao           := 'F';
    if Lc_Movimento then
      Registro.HaMovimentacao     := 'S'
    else
      Registro.HaMovimentacao     := 'N';
    Registro.UsuarioFechamento  := GB_Cd_Usuario;
    Registro.TempoFechamento    := Now;
  End;
  PAFNFCE.Controle.setClosure;
end;

procedure TTasMenuFiscalPaf.tbs_fechamentoShow(Sender: TObject);
begin
  inherited;
  getListClosure;
end;

function TTasMenuFiscalPaf.ValidaClosure: Boolean;
begin
  Result := True;
  if not cds_paf_aberto.Active then cds_paf_aberto.CreateDataSet;
  if cds_paf_aberto.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não há registro de PAF-NFCe em Aberto.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;

  if cds_paf_abertoSituacao.AsString = 'F' then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Registro selecionado já foi encerrado.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;

  PAFNFCE.Controle.Registro.DataMovimento := StrToDate(cds_paf_abertoData.AsString);
  PAFNFCE.Controle.getOpenedPrior;
  if PAFNFCE.Controle.exist then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Existe um movimento anterior em Aberto.'+EOLN+
                   'Data: ' +DateToStr(PAFNFCE.Controle.Registro.DataMovimento)+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;

end;

function TTasMenuFiscalPaf.ValidaGeraArquivos: Boolean;
begin
  REsult := True;
  if (Rg_tipo_estoque.ItemIndex = 0) then
  Begin
    if not cds_items.Active then cds_items.CreateDataSet;
    if cds_items.RecordCount = 0 then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Selecionado Estoque Parcial, deve informar pelo menos um item.'+EOLN+
                         'O que deseja executar ?',
                          [' Estoque Total ',' Informar Item '],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao2) then
      Begin
        Result := False;
        exit;
      End
      else
      Begin
        Rg_tipo_estoque.ItemIndex := 1;
      End;
    End;
  End;

end;

function TTasMenuFiscalPaf.ValidateDeleteItems: boolean;
begin
  Result := True;
  if not cds_items.Active then cds_items.CreateDataSet;

  if cds_items.RecordCount = 0 then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Não há itens para Delete.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO,SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TTasMenuFiscalPaf.ValidateInsertItem: boolean;
begin
  Result:=true;
  if not cds_Items.Active then cds_Items.CreateDataSet;
  if Trim( Fm_ListaProdutos.E_Cd_Produto.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Códcódcódcódigo do produto não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Fm_ListaProdutos.E_Cd_Produto.CanFocus then Fm_ListaProdutos.E_Cd_Produto.SetFocus;
   Exit;
  end;

  if Trim( Fm_ListaProdutos.E_Busca_Produto.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Produto não encontrado.'+EOLN+
                   'Verifique o códcódcódigo do produto.'+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   if Fm_ListaProdutos.E_Busca_Produto.CanFocus then Fm_ListaProdutos.E_Busca_Produto.SetFocus;
   Exit;
  end;

  if cds_Items.Locate('PRO_CODIGO',Fm_ListaProdutos.E_Cd_Produto.Text,[]) then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Este Produto já está na lista desta promoção.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpErro);
   result:=False;
   Exit;
  end;
end;

end.
